Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391B876ADC5
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjHAJdk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjHAJcf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D9944B1
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4000E614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48685C433C7;
        Tue,  1 Aug 2023 09:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882236;
        bh=07eLiQdKwf8weSQ2QC1cOc9LAUcXi11CgR/gAamRBoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2j6Rmi+rCAIIEaHrbfi2+ZrvXPdRuDHEZTUUPWkMeXfdD/RwMGL69AA/UV2nc2/VQ
         uop5yelJJlPJ32czUMRdMJhz5NheDPH/yGYsOHmCORK4IpgX/BOi/8K+rCxl2n2F8d
         ZGCTLaIXv8qHwcdMsh6GcfCSSvj0G/HpxgsxBIrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 034/228] drm/amd/display: Check if link state is valid
Date:   Tue,  1 Aug 2023 11:18:12 +0200
Message-ID: <20230801091924.119614462@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[ Upstream commit 03ce7b387e8b0f4a1dc97a878545bdf7c7f23251 ]

The link state is set to false if there is no link and local sink. Even
though the stream state may not change, it is desirable to commit the
new stream when HPD goes low to high.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 59de751e3845 ("drm/amd/display: add ODM case when looking for first split pipe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cca0143444164..beb2d7f103c58 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1517,6 +1517,8 @@ static bool context_changed(
 	for (i = 0; i < dc->current_state->stream_count; i++) {
 		if (dc->current_state->streams[i] != context->streams[i])
 			return true;
+		if (!context->streams[i]->link->link_state_valid)
+			return true;
 	}
 
 	return false;
-- 
2.39.2



