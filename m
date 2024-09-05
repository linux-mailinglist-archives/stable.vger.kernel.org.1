Return-Path: <stable+bounces-73465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677196D4FB
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCD0B24AE6
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E98818D65E;
	Thu,  5 Sep 2024 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJfXQIeo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEC015574C;
	Thu,  5 Sep 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530320; cv=none; b=DCHmOvZ+Mma4aaIDtMem4fta+95Q6moZ2J19kzAtSKFhQLKxx/GxWQyHPKNUBvGby9lqx+af90v8Ir4JusSE3rJUz7ECpilUB/FwzU2h2ajFbl/ojDcls6av7BdPGdFoHrrPJR/k+ZtDOOwZmhMzGKkzrys7xsWyZpGDFDattXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530320; c=relaxed/simple;
	bh=pDbFYc9hR8HQxAmflwXgM9Yyb11EOQsL7SArKMMPDEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjxeSywU0JR4vf+/Fw4Zd9CgZg2UeYHsfiu+fu6hkg9mWyysxTZcxTD/zOhRd1Zk3+yzC32BeDBUwUZ8TdtHYVaS2Gmz260LUzxi7KcDTrc4L+O0J8cl3kt9CKPRE4dwciEez9JkZi1aWlBvVzZdmaunc6VuAXaQNu+IoSDVAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJfXQIeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6CAC4CEC3;
	Thu,  5 Sep 2024 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530320;
	bh=pDbFYc9hR8HQxAmflwXgM9Yyb11EOQsL7SArKMMPDEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJfXQIeoY5QEE1wOyxoI8dEUI4PWKqlAOc3uyEpouIS5M4UhSYXMDJHj2nUGWJjEj
	 nvaReVvTHi/6Q1IJxYHLxZNwFORLLlOXMXGfUqMnR2dh9Ykdl1VbeomLe9Z+E27zBs
	 WWxjaxkkKXKFzVs68jaFPz/U9UCYI6Q58QZccwGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yunxiang Li <Yunxiang.Li@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 121/132] drm/amdgpu: add lock in amdgpu_gart_invalidate_tlb
Date: Thu,  5 Sep 2024 11:41:48 +0200
Message-ID: <20240905093726.924473352@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunxiang Li <Yunxiang.Li@amd.com>

[ Upstream commit 18f2525d31401e5142db95ff3a6ec0f4147be818 ]

We need to take the reset domain lock before flush hdp. We can't put the
lock inside amdgpu_device_flush_hdp itself because it is used during
reset where we already take the write side lock.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 73b8cca35bab..eace2c9d0c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -34,6 +34,7 @@
 #include <asm/set_memory.h>
 #endif
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 
@@ -400,7 +401,10 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 		return;
 
 	mb();
-	amdgpu_device_flush_hdp(adev, NULL);
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_device_flush_hdp(adev, NULL);
+		up_read(&adev->reset_domain->sem);
+	}
 	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 }
-- 
2.43.0




