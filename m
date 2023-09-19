Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B567A694C
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 19:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjISRAD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 13:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISRAC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 13:00:02 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE912C6
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=99fPj2MgU9tusLfYHkaJeeuM630Yqz5EtvySwyGZINc=; b=Om1NuPvj11aP03F3jZnT8ZZd0K
        6sT8D8hpmrAUHhLvtB8e802ghhPOLcBAaAZPgItiDjfQmT0ZfcohUUYjK7IWg5gFGMA1nuwT8DC+i
        npY60kOOxaPt8DlIo5z40kkT5Y0JPGPzcOGvJnUaJsJNzDMoaGbLX+Ra+3aegIaEekP27dwvF2I21
        N+2dxN0dzPAcWWIqQGWvfoMdezZyHCQUyPZ5pDuWQhk9K/OLObI+ju5bKiqfLkXtcrx90+6/6LvMl
        SVWTZj7bckLV7F2kr4LvmIMePR7iPZEaQEnKAqxv2gTxf5GF2/ulkbgOyEIhFRpcL1KYm7xcLQMLM
        1BZbiPRQ==;
Received: from [38.44.68.151] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qie4m-006Bal-3d; Tue, 19 Sep 2023 18:59:52 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.10.y] drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma
Date:   Tue, 19 Sep 2023 15:59:36 -0100
Message-Id: <20230919165936.1256007-1-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023091622-outpost-audio-2222@gregkh>
References: <2023091622-outpost-audio-2222@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

For DRM legacy gamma, AMD display manager applies implicit sRGB degamma
using a pre-defined sRGB transfer function. It works fine for DCN2
family where degamma ROM and custom curves go to the same color block.
But, on DCN3+, degamma is split into two blocks: degamma ROM for
pre-defined TFs and `gamma correction` for user/custom curves and
degamma ROM settings doesn't apply to cursor plane. To get DRM legacy
gamma working as expected, enable cursor degamma ROM for implict sRGB
degamma on HW with this configuration.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2803
Fixes: 96b020e2163f ("drm/amd/display: check attr flag before set cursor degamma on DCN3+")
Signed-off-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 57a943ebfcdb4a97fbb409640234bdb44bfa1953)
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0bdc83d89946..652ddec18838 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6971,6 +6971,13 @@ static void handle_cursor_update(struct drm_plane *plane,
 	attributes.rotation_angle    = 0;
 	attributes.attribute_flags.value = 0;
 
+	/* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma in DRM
+	 * legacy gamma setup.
+	 */
+	if (crtc_state->cm_is_degamma_srgb &&
+	    adev->dm.dc->caps.color.dpp.gamma_corr)
+		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
+
 	attributes.pitch = attributes.width;
 
 	if (crtc_state->stream) {
-- 
2.40.1

