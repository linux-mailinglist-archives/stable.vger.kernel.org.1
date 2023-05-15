Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0C703573
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243304AbjEOQ7N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243298AbjEOQ7L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:59:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3EB7A98
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB50062A49
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1BCC433D2;
        Mon, 15 May 2023 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169949;
        bh=NID4KUmXriX4ekkz0vYmBRkVlbhxHL5dCiwxSe+d5tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1GMnzpLVZNRlf2goFEIKWjLai7kf7xpvoibay721DABYWXsN6Y0nPl5GK1atOR1I4
         1+zmvdKGaaunPXLSb2hoNOgYp3UHk7ALEpzBrbf07GJ75AR+xKBdoyCt1XjhrDnFZy
         Xtq+jGLQ68GLyP7a6zeWggULmFgFr8I348ff6r2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Wheeler <daniel.wheeler@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Leo Chen <sancchen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 223/246] drm/amd/display: Lowering min Z8 residency time
Date:   Mon, 15 May 2023 18:27:15 +0200
Message-Id: <20230515161729.279806841@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Leo Chen <sancchen@amd.com>

[ Upstream commit d893f39320e1248d1c97fde0d6e51e5ea008a76b ]

[Why & How]
Per HW team request, we're lowering the minimum Z8
residency time to 2000us. This enables Z8 support for additional
modes we were previously blocking like 2k>60hz

Cc: stable@vger.kernel.org
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 33d8188d076ab..30129fb9c27a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -887,7 +887,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
-	.minimum_z8_residency_time = 3080,
+	.minimum_z8_residency_time = 2000,
 	.psr_skip_crtc_disable = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
-- 
2.39.2



