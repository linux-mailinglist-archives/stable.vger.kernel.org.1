Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450CA75CD8C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjGUQMo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjGUQMa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95964217
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89BF461D3A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96215C433C8;
        Fri, 21 Jul 2023 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955915;
        bh=vXPDJvcLKnoGF4uR2COdZjXKsH/WrlKNtGKTEPrF/MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8nP0NoMxSb0n/ctenLyGkx6Ty1+TK/d2kHQxJ/Qq6vjq2ZAeQkpjpoQxOhqgXM6e
         pvrBYf33A7APID/z1ri3dxrl8g8hY2YxseSsZk14D5v5zpt2lopYgd39XlsluniR7E
         skchFYD/MMFoAF52nYrYTF/ODf4BQjFrFm7XB4Qs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 047/292] drm/fbdev-dma: Fix documented default preferred_bpp value
Date:   Fri, 21 Jul 2023 18:02:36 +0200
Message-ID: <20230721160530.825171337@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 15008052b34efaa86c1d56190ac73c4bf8c462f9 ]

As of commit 6c80a93be62d398e ("drm/fb-helper: Initialize fb-helper's
preferred BPP in prepare function"), the preferred_bpp parameter of
drm_fb_helper_prepare() defaults to 32 instead of
drm_mode_config.preferred_depth.  Hence this also applies to
drm_fbdev_dma_setup(), which just passes its own preferred_bpp
parameter.

Fixes: b79fe9abd58bab73 ("drm/fbdev-dma: Implement fbdev emulation for GEM DMA helpers")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/91f093ffe436a9f94d58fb2bfbc1407f1ebe8bb0.1688656591.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fbdev_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index 728deffcc0d92..e85cdf69cd6c4 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -218,7 +218,7 @@ static const struct drm_client_funcs drm_fbdev_dma_client_funcs = {
  * drm_fbdev_dma_setup() - Setup fbdev emulation for GEM DMA helpers
  * @dev: DRM device
  * @preferred_bpp: Preferred bits per pixel for the device.
- *                 @dev->mode_config.preferred_depth is used if this is zero.
+ *                 32 is used if this is zero.
  *
  * This function sets up fbdev emulation for GEM DMA drivers that support
  * dumb buffers with a virtual address and that can be mmap'ed.
-- 
2.39.2



