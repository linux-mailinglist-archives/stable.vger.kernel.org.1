Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D918C7E239C
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjKFNNL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjKFNNH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:13:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD60D7A
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:13:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C006C433C8;
        Mon,  6 Nov 2023 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276383;
        bh=NTcA/PVcbRYVKnQRa0pAZDWfwpl0DtchYkQ9rJyCMAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSVsUp+HXHkJ7aZGYTJJfyGTGJQXb7b7FnRVGsl4H1NkyfGv1OADcmGDIrDCIbkKd
         nvKTnpv3SuZGTvQIz63VXQZeqf98yGNRdTtwK4UH9/f85MkgCj99RGRN6wslSu74tG
         pU3PiOV8pQSuMALerNbzfJ0j6w7GWGxr5QSRvtN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 24/62] fbdev: omapfb: fix some error codes
Date:   Mon,  6 Nov 2023 14:03:30 +0100
Message-ID: <20231106130302.682667207@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit dc608db793731426938baa2f0e75a4a3cce5f5cf ]

Return negative -ENXIO instead of positive ENXIO.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/omap/omapfb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 17cda57656838..5ea7c52baa5a8 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1643,13 +1643,13 @@ static int omapfb_do_probe(struct platform_device *pdev,
 	}
 	fbdev->int_irq = platform_get_irq(pdev, 0);
 	if (fbdev->int_irq < 0) {
-		r = ENXIO;
+		r = -ENXIO;
 		goto cleanup;
 	}
 
 	fbdev->ext_irq = platform_get_irq(pdev, 1);
 	if (fbdev->ext_irq < 0) {
-		r = ENXIO;
+		r = -ENXIO;
 		goto cleanup;
 	}
 
-- 
2.42.0



