Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B6F7D357B
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjJWLsv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbjJWLsv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:48:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED02DF5
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:48:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BABC433C7;
        Mon, 23 Oct 2023 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061728;
        bh=/8V55VeURH9G7Rp0rSrJ1RsUA9hOVCcbLkhtETPi6II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5yp23PMTFbIsA9AWXpYYsD3CZz3Zpz3I1g678mj7KiFnjXJ6WGtG1xhAnvA0ii+Q
         N9xVTi2GnFE3ZzECvXD0Q9rjvXTCdRqniJKTR/M4Wlau1cxmdI7sGqLR2pUSLkcO1X
         8VLjhRzvTIAq/AyBwphjFz29BEXB5Y/YDPqZ394o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Charlene Liu <charlene.liu@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Daniel Miess <daniel.miess@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 144/202] drm/amd/display: Dont set dpms_off for seamless boot
Date:   Mon, 23 Oct 2023 12:57:31 +0200
Message-ID: <20231023104830.744985663@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Miess <daniel.miess@amd.com>

[ Upstream commit 23645bca98304a2772f0de96f97370dd567d0ae6 ]

[Why]
eDPs fail to light up with seamless boot enabled

[How]
When seamless boot is enabled don't configure dpms_off
in disable_vbios_mode_if_required.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9cf287124fe4c..36a9e9c84ed44 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -862,6 +862,9 @@ static void disable_vbios_mode_if_required(
 		if (stream == NULL)
 			continue;
 
+		if (stream->apply_seamless_boot_optimization)
+			continue;
+
 		// only looking for first odm pipe
 		if (pipe->prev_odm_pipe)
 			continue;
-- 
2.40.1



