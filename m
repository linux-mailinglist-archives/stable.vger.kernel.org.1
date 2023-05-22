Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58570C78A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjEVTaw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjEVTav (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB29E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2936B628F9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35686C433EF;
        Mon, 22 May 2023 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783849;
        bh=0zSPkExD5i64hWqhJ1mDo0A7b/q3SlPWRGGmGx+MXdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HyaWpgLuyHV1Gnrj+96b2Es0BGSRKQAdDkPc69IGjEujyqeDVakgZA3t+CPOy/i6t
         IzmityuzP1FaO81GY8EIP2L1Oh0MtFS+wbHNeFCJl++NMWtl3TW1D+wLj4ij2FIgwU
         IAFJPkIRWluNdY6mb2UOqvndtrzl2unPqnCIUky4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ke Zhang <m202171830@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 174/292] serial: arc_uart: fix of_iomap leak in `arc_serial_probe`
Date:   Mon, 22 May 2023 20:08:51 +0100
Message-Id: <20230522190410.312062267@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ke Zhang <m202171830@hust.edu.cn>

[ Upstream commit 8ab5fc55d7f65d58a3c3aeadf11bdf60267cd2bd ]

Smatch reports:

drivers/tty/serial/arc_uart.c:631 arc_serial_probe() warn:
'port->membase' from of_iomap() not released on lines: 631.

In arc_serial_probe(), if uart_add_one_port() fails,
port->membase is not released, which would cause a resource leak.

To fix this, I replace of_iomap with devm_platform_ioremap_resource.

Fixes: 8dbe1d5e09a7 ("serial/arc: inline the probe helper")
Signed-off-by: Ke Zhang <m202171830@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Link: https://lore.kernel.org/r/20230428031636.44642-1-m202171830@hust.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/arc_uart.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 2a65ea2660e10..f3ccc59d8c1f3 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -607,10 +607,11 @@ static int arc_serial_probe(struct platform_device *pdev)
 	}
 	uart->baud = val;
 
-	port->membase = of_iomap(np, 0);
-	if (!port->membase)
+	port->membase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(port->membase)) {
 		/* No point of dev_err since UART itself is hosed here */
-		return -ENXIO;
+		return PTR_ERR(port->membase);
+	}
 
 	port->irq = irq_of_parse_and_map(np, 0);
 
-- 
2.39.2



