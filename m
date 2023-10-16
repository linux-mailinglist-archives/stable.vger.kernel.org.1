Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55AF7CA22E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjJPIrC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjJPIq5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:46:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BF6EA
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:46:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A711DC433C9;
        Mon, 16 Oct 2023 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446016;
        bh=tpBvzq18nGnPCfqlgPg1nR1iz45Ujn64m4+Yql6siBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6zeAWXAGp44sEC7dzcGY4l824Xrwjj2Ck2HxdZ3ULScFucXUJTbE8iIinJvPTPDw
         GtA/BZMbcPu120FLezm0sN2BB3ttvEepn/95/e1jfBHFqiDQZVozimMxas6L4/D5FO
         dGey3kjB8vtqaepnRxavqaILEzF32f7mTsNwr5S4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Charlene Liu <charlene.liu@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Daniel Miess <daniel.miess@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.15 059/102] drm/amd/display: Dont set dpms_off for seamless boot
Date:   Mon, 16 Oct 2023 10:40:58 +0200
Message-ID: <20231016083955.275113355@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Miess <daniel.miess@amd.com>

commit 23645bca98304a2772f0de96f97370dd567d0ae6 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1023,6 +1023,9 @@ static void disable_vbios_mode_if_requir
 		if (stream == NULL)
 			continue;
 
+		if (stream->apply_seamless_boot_optimization)
+			continue;
+
 		// only looking for first odm pipe
 		if (pipe->prev_odm_pipe)
 			continue;


