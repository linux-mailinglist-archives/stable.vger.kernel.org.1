Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6E7A301E
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjIPM3k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbjIPM3X (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:29:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631A0194
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:29:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F96AC433C7;
        Sat, 16 Sep 2023 12:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867358;
        bh=e9oKWmZvEMSCev/icou4v11MoGvgWZ7XdaV7dVmMlN8=;
        h=Subject:To:Cc:From:Date:From;
        b=KAnWdzswbYJUD+x7yDtvbdycPBQOyAlJR3OBTSkdvEoM60iifVDWY9ZMtCEAxl7O8
         GhRccfT5TxvpZ+xpU1lbH1NUk3N8nbEWsd1SWqQcPihEF5UmPKyLgMVlbNSVXgn/UU
         nTqQq/Tei6OlZyEWgVzWdZuGokayLBgC3ZQwG/e0=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix amdgpu_cs_p1_user_fence" failed to apply to 6.5-stable tree
To:     christian.koenig@amd.com, alexander.deucher@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:29:15 +0200
Message-ID: <2023091615-wick-punch-6c68@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 35588314e963938dfdcdb792c9170108399377d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091615-wick-punch-6c68@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

35588314e963 ("drm/amdgpu: fix amdgpu_cs_p1_user_fence")
ca6c1e210aa7 ("drm/amdgpu: use the new drm_exec object for CS v3")
8abc1eb2987a ("drm/amdkfd: switch over to using drm_exec v3")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 35588314e963938dfdcdb792c9170108399377d6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Fri, 25 Aug 2023 15:28:00 +0200
Subject: [PATCH] drm/amdgpu: fix amdgpu_cs_p1_user_fence
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The offset is just 32bits here so this can potentially overflow if
somebody specifies a large value. Instead reduce the size to calculate
the last possible offset.

The error handling path incorrectly drops the reference to the user
fence BO resulting in potential reference count underflow.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 49dd9aa8da70..efdb1c48f431 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -127,7 +127,6 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 {
 	struct drm_gem_object *gobj;
 	unsigned long size;
-	int r;
 
 	gobj = drm_gem_object_lookup(p->filp, data->handle);
 	if (gobj == NULL)
@@ -137,23 +136,14 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	drm_gem_object_put(gobj);
 
 	size = amdgpu_bo_size(p->uf_bo);
-	if (size != PAGE_SIZE || (data->offset + 8) > size) {
-		r = -EINVAL;
-		goto error_unref;
-	}
+	if (size != PAGE_SIZE || data->offset > (size - 8))
+		return -EINVAL;
 
-	if (amdgpu_ttm_tt_get_usermm(p->uf_bo->tbo.ttm)) {
-		r = -EINVAL;
-		goto error_unref;
-	}
+	if (amdgpu_ttm_tt_get_usermm(p->uf_bo->tbo.ttm))
+		return -EINVAL;
 
 	*offset = data->offset;
-
 	return 0;
-
-error_unref:
-	amdgpu_bo_unref(&p->uf_bo);
-	return r;
 }
 
 static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,

