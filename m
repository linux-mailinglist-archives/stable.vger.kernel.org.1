Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7E7A38F4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjIQTnB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbjIQTml (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:42:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866DFE7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:42:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C042DC433C7;
        Sun, 17 Sep 2023 19:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979756;
        bh=j9kW4ArCcT0tOVuNVlivpsaaBk8SimTy/ZduEayFrRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1D0z2W0pkZOAR4nrbEJ9kG8j2AKIYHxI93IJb5EXKHU4U4fR5Y8nAjfOgjK0xt00
         AE6ZjB/XE1Q3DvCDOQ8VCz8tdF4qCU7K26F9uPz7R3QynhrcWEKcqnJFFouqPEVNMw
         dwgdbEAyAGSrACeYGlirGhWQ4KVlSHe/E5UZxQYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <jun.lei@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
        Wesley Chalmers <wesley.chalmers@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.10 405/406] drm/amd/display: Fix a bug when searching for insert_above_mpcc
Date:   Sun, 17 Sep 2023 21:14:19 +0200
Message-ID: <20230917191111.950446457@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -206,8 +206,9 @@ struct mpcc *mpc1_insert_plane(
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


