Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFB7A80D6
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbjITMkl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbjITMkg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:40:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1335983
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:40:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A511C433CA;
        Wed, 20 Sep 2023 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213630;
        bh=9jEenxPkkzj5tp0TyuCi6uaThl17m80uTSMNERr9hKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j54XbyLPpWc6bvGoVw6isp2ta7s7GqYrTzT71dxs40AGr7jnmzk8Ofeq36E6nQv1f
         zb/kuQwQnkARJEW4Mf4XO1eJ276TymLwG6YHahxFWFX4rJIx2Sj6AWE3q0TYAFzojH
         6R/aaHpTvE2GEgg5fIiNiUul+/PEw1Jm2ssm7efE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <jun.lei@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
        Wesley Chalmers <wesley.chalmers@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.4 308/367] drm/amd/display: Fix a bug when searching for insert_above_mpcc
Date:   Wed, 20 Sep 2023 13:31:25 +0200
Message-ID: <20230920112906.527048472@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wesley Chalmers <wesley.chalmers@amd.com>

commit 3d028d5d60d516c536de1ddd3ebf3d55f3f8983b upstream.

[WHY]
Currently, when insert_plane is called with insert_above_mpcc
parameter that is equal to tree->opp_list, the function returns NULL.

[HOW]
Instead, the function should insert the plane at the top of the tree.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wesley Chalmers <wesley.chalmers@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -199,8 +199,9 @@ struct mpcc *mpc1_insert_plane(
 		/* check insert_above_mpcc exist in tree->opp_list */
 		struct mpcc *temp_mpcc = tree->opp_list;
 
-		while (temp_mpcc && temp_mpcc->mpcc_bot != insert_above_mpcc)
-			temp_mpcc = temp_mpcc->mpcc_bot;
+		if (temp_mpcc != insert_above_mpcc)
+			while (temp_mpcc && temp_mpcc->mpcc_bot != insert_above_mpcc)
+				temp_mpcc = temp_mpcc->mpcc_bot;
 		if (temp_mpcc == NULL)
 			return NULL;
 	}


