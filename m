Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9014C75539B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjGPUUz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGPUUz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:20:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C75126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:20:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E391260E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C9CC433C8;
        Sun, 16 Jul 2023 20:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538853;
        bh=7jsq5kicvkJ4PImkuR14h7n1quMms7GQLz7ONQp0CSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVsYZCKsxQXcdLBuzWE27SuJSwelBP+pUL8Ks316rg4yW0tB2sQSOMoeSFDfeFvzJ
         Jn5mSzAWBBnOamrUCWjTaBX1N3J4ntr7I8FqKoCGgtXt458xbdFgecoS4ZrZhIULXv
         YMPh+1OCmynUznzXQw26m2j2WKKjKmfb+L7qp4Q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Yang <lidaxian@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 592/800] usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()
Date:   Sun, 16 Jul 2023 21:47:25 +0200
Message-ID: <20230716195002.851352763@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Yang <lidaxian@hust.edu.cn>

[ Upstream commit 342161c11403ea00e9febc16baab1d883d589d04 ]

Smatch reports:
drivers/usb/phy/phy-tahvo.c: tahvo_usb_probe()
warn: missing unwind goto?

After geting irq, if ret < 0, it will return without error handling to
free memory.
Just add error handling to fix this problem.

Fixes: 0d45a1373e66 ("usb: phy: tahvo: add IRQ check")
Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Link: https://lore.kernel.org/r/20230420140832.9110-1-lidaxian@hust.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/phy/phy-tahvo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index 47562d49dfc1b..5cac31c6029b3 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -391,7 +391,7 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 
 	tu->irq = ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		return ret;
+		goto err_remove_phy;
 	ret = request_threaded_irq(tu->irq, NULL, tahvo_usb_vbus_interrupt,
 				   IRQF_ONESHOT,
 				   "tahvo-vbus", tu);
-- 
2.39.2



