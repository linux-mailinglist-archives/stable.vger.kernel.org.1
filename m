Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11A7354D4
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjFSK7R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjFSK64 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C0110EA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA9060B5F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D68C433C8;
        Mon, 19 Jun 2023 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172252;
        bh=GyNGN1Tmloe2/Z/X5RDIorGVBlpXRFeo0S5OspDgYaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r5E7oEPBqB58IEsch5d5qfWgVr/YFNW61h7DsrckMRNGVWIvWvtWa/cEYHNO3zp3s
         kuumXXSA0FIdjvLakcwyhz4TNDXByOacNwwDy7x5mLW0WQjnYoHjznAK/QfWTdegYX
         1n4IfmQWDj5p4xDZ7HUve0npMpuYSL1xDU9o665c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Natalia Petrova <n.petrova@fintech.ru>,
        Lyude Paul <lyude@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 66/89] drm/nouveau/dp: check for NULL nv_connector->native_mode
Date:   Mon, 19 Jun 2023 12:30:54 +0200
Message-ID: <20230619102141.269461752@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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

From: Natalia Petrova <n.petrova@fintech.ru>

[ Upstream commit 20a2ce87fbaf81e4c3dcb631d738e423959eb320 ]

Add checking for NULL before calling nouveau_connector_detect_depth() in
nouveau_connector_get_modes() function because nv_connector->native_mode
could be dereferenced there since connector pointer passed to
nouveau_connector_detect_depth() and the same value of
nv_connector->native_mode is used there.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d4c2c99bdc83 ("drm/nouveau/dp: remove broken display depth function, use the improved one")

Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230512111526.82408-1-n.petrova@fintech.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 9542fc63e7968..7478f2a1411e6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -946,7 +946,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	/* Determine display colour depth for everything except LVDS now,
 	 * DP requires this before mode_valid() is called.
 	 */
-	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
+	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
 		nouveau_connector_detect_depth(connector);
 
 	/* Find the native mode if this is a digital panel, if we didn't
@@ -967,7 +967,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	 * "native" mode as some VBIOS tables require us to use the
 	 * pixel clock as part of the lookup...
 	 */
-	if (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)
+	if (connector->connector_type == DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
 		nouveau_connector_detect_depth(connector);
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_TV)
-- 
2.39.2



