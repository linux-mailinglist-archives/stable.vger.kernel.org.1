Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24F0703552
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbjEOQ5u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243291AbjEOQ5r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5673C1BC0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D115962A1B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03C1C4339B;
        Mon, 15 May 2023 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169862;
        bh=PtXfU9XZ99giHsN57o7gksXNtphka7orWQzhN12a0jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USCt2DE5kDDO09bSpUyr5sVOKgEQo72juJisjygIjfaEAEzR9Lk76vgM7tKBto8rv
         BjybqO5QPB5nTjCRc0kDH7/hv3XU4er8xJkQppD3tBdYLEBfXlI0PouhD2GI7U/SJG
         xMQmlnRVeyv3YmHWlR/HDuMsPvvmkmRPSxmFlGUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guchun Chen <guchun.chen@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 195/246] drm/amdgpu: drop redundant sched job cleanup when cs is aborted
Date:   Mon, 15 May 2023 18:26:47 +0200
Message-Id: <20230515161728.465097267@linuxfoundation.org>
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

From: Guchun Chen <guchun.chen@amd.com>

commit 1253685f0d3eb3eab0bfc4bf15ab341a5f3da0c8 upstream.

Once command submission failed due to userptr invalidation in
amdgpu_cs_submit, legacy code will perform cleanup of scheduler
job. However, it's not needed at all, as former commit has integrated
job cleanup stuff into amdgpu_job_free. Otherwise, because of double
free, a NULL pointer dereference will occur in such scenario.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2457
Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1276,7 +1276,7 @@ static int amdgpu_cs_submit(struct amdgp
 		r = drm_sched_job_add_dependency(&leader->base, fence);
 		if (r) {
 			dma_fence_put(fence);
-			goto error_cleanup;
+			return r;
 		}
 	}
 
@@ -1303,7 +1303,8 @@ static int amdgpu_cs_submit(struct amdgp
 	}
 	if (r) {
 		r = -EAGAIN;
-		goto error_unlock;
+		mutex_unlock(&p->adev->notifier_lock);
+		return r;
 	}
 
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
@@ -1350,14 +1351,6 @@ static int amdgpu_cs_submit(struct amdgp
 	mutex_unlock(&p->adev->notifier_lock);
 	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return 0;
-
-error_unlock:
-	mutex_unlock(&p->adev->notifier_lock);
-
-error_cleanup:
-	for (i = 0; i < p->gang_size; ++i)
-		drm_sched_job_cleanup(&p->jobs[i]->base);
-	return r;
 }
 
 /* Cleanup the parser structure */


