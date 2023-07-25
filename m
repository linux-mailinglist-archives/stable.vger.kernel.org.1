Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE73761395
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjGYLLs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjGYLLa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46B9D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011436166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C67C433C7;
        Tue, 25 Jul 2023 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283450;
        bh=sHtE15PecU2QpaCoVfQN+PYWLcVMakYcm1Moz9PpAqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a02oYUeHd90VHk7weGDY7UPA75vuNLnWX1HuoNyoOuUpBEVyf1ACDcimp6h1304tW
         GAGvyZpY2QNTTcv6k7s+PO3QwmuMgMkukCn3n7vcMg8a04oFTb+6Gd/PsF7+NwPgu9
         y+m1XvABFiFLjR+c1FF6ibkiIp21eoB0EWGyyKRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 59/78] fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe
Date:   Tue, 25 Jul 2023 12:46:50 +0200
Message-ID: <20230725104453.546457371@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 4e88761f5f8c7869f15a2046b1a1116f4fab4ac8 ]

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.

Fix this by stop calling request_irq() with invalid IRQ #s.

Fixes: 1630d85a8312 ("au1200fb: fix hardcoded IRQ")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/au1200fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index a8a0a448cdb5e..80f54111baec1 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1732,6 +1732,9 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 	/* Now hook interrupt too */
 	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = request_irq(irq, au1200fb_handle_irq,
 			  IRQF_SHARED, "lcd", (void *)dev);
 	if (ret) {
-- 
2.39.2



