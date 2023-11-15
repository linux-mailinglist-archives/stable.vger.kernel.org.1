Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7120B7ED0AB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjKOT4y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbjKOT4i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AC2D7A
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A9BC433C9;
        Wed, 15 Nov 2023 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078194;
        bh=rk8i1Rxt/IDOh1cEtKs63Qvs1c+Vp7IcmqaK9EsAOxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXbdorcIm3OU1E7DdEkdLRJuMj0h4VQjp4CvGR0V/H3NIlRcs+lPAqCp5a8bsYztZ
         AZnisloNR2Yx9H0Qxv1auggWKrj2DhHVV7OsK4gTQWO1b3nqpM22CulDCOodyHQF6+
         JciWE8TR4EW2V8dc27FQCiZUuOLjjAXFjSBfOC+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Xiaogang.Chen" <xiaogang.chen@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 135/379] drm/amdkfd: fix some race conditions in vram buffer alloc/free of svm code
Date:   Wed, 15 Nov 2023 14:23:30 -0500
Message-ID: <20231115192653.116675597@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaogang Chen <xiaogang.chen@amd.com>

[ Upstream commit 7bfaa160caed8192f8262c4638f552cad94bcf5a ]

This patch fixes:
1: ref number of prange's svm_bo got decreased by an async call from hmm. When
wait svm_bo of prange got released we shoul also wait prang->svm_bo become NULL,
otherwise prange->svm_bo may be set to null after allocate new vram buffer.

2: During waiting svm_bo of prange got released in a while loop should reschedule
current task to give other tasks oppotunity to run, specially the the workque
task that handles svm_bo ref release, otherwise we may enter to softlock.

Signed-off-by: Xiaogang.Chen <xiaogang.chen@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 63feea08904cb..d7e758c86a0b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -487,11 +487,11 @@ svm_range_validate_svm_bo(struct amdgpu_device *adev, struct svm_range *prange)
 
 	/* We need a new svm_bo. Spin-loop to wait for concurrent
 	 * svm_range_bo_release to finish removing this range from
-	 * its range list. After this, it is safe to reuse the
-	 * svm_bo pointer and svm_bo_list head.
+	 * its range list and set prange->svm_bo to null. After this,
+	 * it is safe to reuse the svm_bo pointer and svm_bo_list head.
 	 */
-	while (!list_empty_careful(&prange->svm_bo_list))
-		;
+	while (!list_empty_careful(&prange->svm_bo_list) || prange->svm_bo)
+		cond_resched();
 
 	return false;
 }
-- 
2.42.0



