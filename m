Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFCD7ECE39
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjKOTll (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjKOTlk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A6B189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999BFC433C7;
        Wed, 15 Nov 2023 19:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077296;
        bh=oK6dwfZH8huCR/W+q4SFSuLSxNxHHEY3xID+NyfeiX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3mtdAnnlxKYs+t9b4hpqAM5pQkDmDA7vN+IbsE+SeTKYh4bRo+KU//UceIHkyVfe
         mpVhMWX/Ws3NZErVyPSp4lCZykTEn58XotCc5D3lHJ/F1tzePVD27cRBrRHa29LEHc
         SyZadHlZVZH0yyqLKtgKuqYqsqE7E0RjvUDqTopM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 217/603] drm/loongson: Fix error handling in lsdc_pixel_pll_setup()
Date:   Wed, 15 Nov 2023 14:12:42 -0500
Message-ID: <20231115191628.302507012@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit 5976a28b344ecb6810882a01b76a320cac21d307 ]

There are two problems in lsdc_pixel_pll_setup()
1. If kzalloc() fails then call iounmap() to release the resources.
2. Both kzalloc and ioremap does not return error pointers on failure, so
   using IS_ERR_OR_NULL() checks is a bit confusing and not very right,
   fix this by changing those to NULL checks instead.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
Link: https://patchwork.freedesktop.org/patch/msgid/20230720123950.543082-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/loongson/lsdc_pixpll.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_pixpll.c b/drivers/gpu/drm/loongson/lsdc_pixpll.c
index 04c15b4697e21..2609a2256da4b 100644
--- a/drivers/gpu/drm/loongson/lsdc_pixpll.c
+++ b/drivers/gpu/drm/loongson/lsdc_pixpll.c
@@ -120,12 +120,14 @@ static int lsdc_pixel_pll_setup(struct lsdc_pixpll * const this)
 	struct lsdc_pixpll_parms *pparms;
 
 	this->mmio = ioremap(this->reg_base, this->reg_size);
-	if (IS_ERR_OR_NULL(this->mmio))
+	if (!this->mmio)
 		return -ENOMEM;
 
 	pparms = kzalloc(sizeof(*pparms), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(pparms))
+	if (!pparms) {
+		iounmap(this->mmio);
 		return -ENOMEM;
+	}
 
 	pparms->ref_clock = LSDC_PLL_REF_CLK_KHZ;
 
-- 
2.42.0



