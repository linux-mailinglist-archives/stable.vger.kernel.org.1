Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6633E7832B9
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHUT7x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjHUT7x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A418C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB0F464728
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69A1C433C7;
        Mon, 21 Aug 2023 19:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647987;
        bh=OYlNHeqgaZ8ZKIneDOaNIS064bRseQPY0XLl3sbQXCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4bW6CDN7usCHEay72X8IMM/ztPgkwk/TT/2pCys4w0Vo8/cvmrN1rY1gyqrUEc2B
         e8DV1T/AM+oZNrAO+vQNpV2dC5w8kGwriUXwXc9DrMzxyklGLbE7667lXO+NwFQmvc
         sz0GvisWmhmbQzIvZrY+71hsdVJ46AQc6a+7eIjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 015/234] drm/stm: ltdc: fix late dereference check
Date:   Mon, 21 Aug 2023 21:39:38 +0200
Message-ID: <20230821194129.420654437@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

[ Upstream commit 898a9e3f56db9860ab091d4bf41b6caa99aafc3d ]

In ltdc_crtc_set_crc_source(), struct drm_crtc was dereferenced in a
container_of() before the pointer check. This could cause a kernel panic.

Fix this smatch warning:
drivers/gpu/drm/stm/ltdc.c:1124 ltdc_crtc_set_crc_source() warn: variable dereferenced before check 'crtc' (see line 1119)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202212241802.zeLFZCXB-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/lkml/202212241802.zeLFZCXB-lkp@intel.com/
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
Signed-off-by: Philippe Cornu <philippe.cornu@foss.st.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230515123818.93971-1-raphael.gallais-pou@foss.st.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/stm/ltdc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 03c6becda795c..b8be4c1db4235 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1145,7 +1145,7 @@ static void ltdc_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static int ltdc_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
 {
-	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
+	struct ltdc_device *ldev;
 	int ret;
 
 	DRM_DEBUG_DRIVER("\n");
@@ -1153,6 +1153,8 @@ static int ltdc_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
 	if (!crtc)
 		return -ENODEV;
 
+	ldev = crtc_to_ltdc(crtc);
+
 	if (source && strcmp(source, "auto") == 0) {
 		ldev->crc_active = true;
 		ret = regmap_set_bits(ldev->regmap, LTDC_GCR, GCR_CRCEN);
-- 
2.40.1



