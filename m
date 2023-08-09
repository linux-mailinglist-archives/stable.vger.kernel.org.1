Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E353477598E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjHILBe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjHILBd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:01:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ECE2103
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD97763118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F15C433C8;
        Wed,  9 Aug 2023 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578891;
        bh=Ncum7HX9sEOSyf191U/G17l2K95yupaM6V6J5ktW78E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztFNQFGISJZpNqGy0mltfphuu+HO6FuGjbQubRdPefNeER6XvWePLHglxHCEs7DzC
         8jMTVDqzWMVgRn/Rs1X+ti6AqyjkOWoLc6UGPDCWwM0hFfFwqRt9hwMApYv1wuheB7
         xXQZgdl4/zQ0YZJJ8fo9BKD36O4mNAlpmL9Sbr14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 85/92] drm/fsl-dcu: Use drm_plane_helper_destroy()
Date:   Wed,  9 Aug 2023 12:42:01 +0200
Message-ID: <20230809103636.476164417@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit a4d847df8b440cc667c18f99abe84ccaa83afac4 ]

Replace the driver's own function with drm_plane_helper_destroy(). No
functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20220720083058.15371-8-tzimmermann@suse.de
Stable-dep-of: ee31742bf176 ("drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 8fe953d6e0a94..8a9e6db71e46b 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -170,16 +170,10 @@ static const struct drm_plane_helper_funcs fsl_dcu_drm_plane_helper_funcs = {
 	.atomic_update = fsl_dcu_drm_plane_atomic_update,
 };
 
-static void fsl_dcu_drm_plane_destroy(struct drm_plane *plane)
-{
-	drm_plane_cleanup(plane);
-	kfree(plane);
-}
-
 static const struct drm_plane_funcs fsl_dcu_drm_plane_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
-	.destroy = fsl_dcu_drm_plane_destroy,
+	.destroy = drm_plane_helper_destroy,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.reset = drm_atomic_helper_plane_reset,
 	.update_plane = drm_atomic_helper_update_plane,
-- 
2.40.1



