Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C546F77ACA2
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjHMVfT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjHMVfS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:35:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A710E5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6495A61366
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C911C433C8;
        Sun, 13 Aug 2023 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962518;
        bh=+ecs3ODtgA28oTupRvKUtRFGI+0huETpzyjh51D7gME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrMIySH+FeEfmckgm5yEx7gfj7vOCldg/WQ/hoeZ/7E4I8WbACWM/fzQpw1I0ehNx
         EvIHM1jVHTSaI//zuVisQuwUX+Ubry6CINDH8Pr5PRr5N7m1kyq/qbGU6myh8Ks6Fd
         YsfACEq2AO31Ptk0QqVl/bHJcSNFRfSAkCZKAQ3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Melissa Wen <mwen@igalia.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 029/149] drm/amd/display: check attr flag before set cursor degamma on DCN3+
Date:   Sun, 13 Aug 2023 23:17:54 +0200
Message-ID: <20230813211719.679674863@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Melissa Wen <mwen@igalia.com>

commit 96b020e2163fb2197266b2f71b1007495206e6bb upstream.

Don't set predefined degamma curve to cursor plane if the cursor
attribute flag is not set. Applying a degamma curve to the cursor by
default breaks userspace expectation. Checking the flag before
performing any color transformation prevents too dark cursor gamma in
DCN3+ on many Linux desktop environment (KDE Plasma, GNOME,
wlroots-based, etc.) as reported at:
- https://gitlab.freedesktop.org/drm/amd/-/issues/1513

This is the same approach followed by DCN2 drivers where the issue is
not present.

Fixes: 03f54d7d3448 ("drm/amd/display: Add DCN3 DPP")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1513
Signed-off-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Tested-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -357,8 +357,11 @@ void dpp3_set_cursor_attributes(
 	int cur_rom_en = 0;
 
 	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
-		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA)
-		cur_rom_en = 1;
+		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
+		if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
+			cur_rom_en = 1;
+		}
+	}
 
 	REG_UPDATE_3(CURSOR0_CONTROL,
 			CUR0_MODE, color_format,


