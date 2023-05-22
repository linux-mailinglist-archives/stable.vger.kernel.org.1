Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E9870C7A2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjEVTb7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjEVTb4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDCD9C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52DF662929
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A86C433D2;
        Mon, 22 May 2023 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783914;
        bh=eCTwl5Q1pEoTUsB7q3IJ2NISdFBW52+rtrWJOG/VU5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btzbHQMmvhZL989q+H9Fx36oWXiaansQMLPmhRTbOb1Nz5Dq888urxT4RBDgq8A/6
         Jf6jOomv2Aslp4A94hNhVFCTs8hUPXv2oml7JDgFL43vagwttwZmhO3pTslagJFIMz
         X94b9q7ZJCNwXbdDQOmhK00rwUiEWnem4rWS7J/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, XuDong Liu <m202071377@hust.edu.cn>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 176/292] serial: 8250_bcm7271: fix leak in `brcmuart_probe`
Date:   Mon, 22 May 2023 20:08:53 +0100
Message-Id: <20230522190410.363327167@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit f264f2f6f4788dc031cef60a0cf2881902736709 ]

Smatch reports:
drivers/tty/serial/8250/8250_bcm7271.c:1120 brcmuart_probe() warn:
'baud_mux_clk' from clk_prepare_enable() not released on lines: 1032.

The issue is fixed by using a managed clock.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Reported-by: XuDong Liu <m202071377@hust.edu.cn>
Link: https://lore.kernel.org/lkml/20230424125100.4783-1-m202071377@hust.edu.cn/
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20230427181916.2983697-3-opendmb@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 1f0095cf57a7e..ffc7f67e27e35 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1014,7 +1014,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	of_property_read_u32(np, "clock-frequency", &clk_rate);
 
 	/* See if a Baud clock has been specified */
-	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
+	baud_mux_clk = devm_clk_get(dev, "sw_baud");
 	if (IS_ERR(baud_mux_clk)) {
 		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-- 
2.39.2



