Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E75C7A3A2D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjIQT7e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbjIQT7Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:59:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EB3F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:59:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FFEC433C8;
        Sun, 17 Sep 2023 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980760;
        bh=/krOP+GGNsEKjKDGbzC+iqCYnrhrjQGqXpyKCIDDEhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9HQ66k3j4q/NSEYQIQnyikvCN49Se0PDZGpkZDl3Uatt0iwXmFeUp1v2TaHMkRg9
         K7htJnItowq0ndYYfq/ZZ+feGia87OUJOSYcPt+NbUR45yDT8Qswx2kiF5Fpau1J1A
         fGurX0KsqmtSGK3UqI9gJPeDi64UtALMCG7835Vk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <jun.lei@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
        Wesley Chalmers <wesley.chalmers@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.5 285/285] drm/amd/display: Fix a bug when searching for insert_above_mpcc
Date:   Sun, 17 Sep 2023 21:14:45 +0200
Message-ID: <20230917191100.996862643@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

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
@@ -212,8 +212,9 @@ struct mpcc *mpc1_insert_plane(
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


