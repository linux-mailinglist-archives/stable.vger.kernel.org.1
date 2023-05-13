Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7664C7014FF
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEMHjE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMHjC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335F935B5
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C430E618DB
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518B8C433D2;
        Sat, 13 May 2023 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963540;
        bh=raGPCTcsGdvSMERU4vUtTugkDia0MvnFKw4h3bMyX7g=;
        h=Subject:To:Cc:From:Date:From;
        b=dTgdINbU28axNKzg1mEeXfEPZiITB67NpC1NipHGIGeyXw8Ad4qj00PQqqAeKT5fA
         KXEGhpBV90uzSscRgmw6x1vdAPFYJG2GJekGbBDogPEHnVSa4BXpwcaoJWuLEXeJWN
         CmoB3F0juEBqSDIESLLk9sd27qycTSNiJhTe0kJs=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix double memory allocation" failed to apply to 6.2-stable tree
To:     Martin.Leung@amd.com, Hanghong.Ma@amd.com,
        alexander.deucher@amd.com, daniel.wheeler@amd.com,
        mario.limonciello@amd.com, qingqing.zhuo@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:20:10 +0900
Message-ID: <2023051310-tipping-creation-c33f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x f5442b35e69e42015ef3082008c0d85cdcc0ca05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051310-tipping-creation-c33f@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

f5442b35e69e ("drm/amd/display: fix double memory allocation")
b5006f873b99 ("drm/amd/display: initialize link_srv in virtual env")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5442b35e69e42015ef3082008c0d85cdcc0ca05 Mon Sep 17 00:00:00 2001
From: Martin Leung <Martin.Leung@amd.com>
Date: Tue, 14 Mar 2023 09:27:20 -0400
Subject: [PATCH] drm/amd/display: fix double memory allocation

[Why & How]
when trying to fix a nullptr dereference on VMs,
accidentally doubly allocated memory for the non VM
case. removed the extra link_srv creation since
dc_construct_ctx is called in both VM and non VM cases
Also added a proper fail check for if kzalloc fails

Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Leo Ma <Hanghong.Ma@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 40f2e174c524..52564b93f7eb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -887,7 +887,10 @@ static bool dc_construct_ctx(struct dc *dc,
 	}
 
 	dc->ctx = dc_ctx;
+
 	dc->link_srv = link_create_link_service();
+	if (!dc->link_srv)
+		return false;
 
 	return true;
 }
@@ -986,8 +989,6 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
-	dc->link_srv = link_create_link_service();
-
 	dc->res_pool = dc_create_resource_pool(dc, init_params, dc_ctx->dce_version);
 	if (!dc->res_pool)
 		goto fail;

