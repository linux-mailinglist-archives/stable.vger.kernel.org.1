Return-Path: <stable+bounces-146671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014AAC542A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004601885ECF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50EE280322;
	Tue, 27 May 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgZPRh0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B85280012;
	Tue, 27 May 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364950; cv=none; b=jnQcpji5P7SapMZLEUuN56sfAl6AWxO7hJpBEZXLqFfCN/AAd6odG9ldb88TBCLuRcMNDkXk+eF7oiWyGsAhHQgb2pPv88+6SA0OYXIHdluSTY63ExA86+t3XuU3A4fgpV2A3LkJgzoQj3jpjtA7vXhrovL/c8B64CRiN+1xJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364950; c=relaxed/simple;
	bh=rl65A+2AZs+mzOv0UWSAWS/0UvxX/zl2hjJxDcU/xFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+jgbiuCdcJyTSH5JvkAWwglQ7RDB0TJDaIcBqPjo0cR2+PSZXrZ+rLAqhghDH0wQHLS2HJbgae6FX5w/dOV0CmxVykJ0/qO+hD0GBkixoeNnbuH0wimooAHioLcmob6byaeC6KhbIOWLLvfOGoO/KzhxE8w3V/jjDTJdg2ZcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VgZPRh0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D977DC4CEE9;
	Tue, 27 May 2025 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748364950;
	bh=rl65A+2AZs+mzOv0UWSAWS/0UvxX/zl2hjJxDcU/xFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgZPRh0tuofJJsthBjY7o8hb2QTzlvTZso8fcI9eNY8nHqqn/3iQi7n5tGPotCoLr
	 9LGsM1UGs2rRZWhoYeN1dXORnw64es+UWWxgZZMbU+6IKFFvLZr9qJHkeQva0o1kol
	 RtOIMXcYGkim5KYQvOtlWuT2z8MGjb8LE4oCLaQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emily Deng <Emily.Deng@amd.com>,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 211/626] drm/amdgpu: Fix missing drain retry fault the last entry
Date: Tue, 27 May 2025 18:21:44 +0200
Message-ID: <20250527162453.590972454@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emily Deng <Emily.Deng@amd.com>

[ Upstream commit fe2fa3be3d59ba67d6de54a0064441ec233cb50c ]

While the entry get in svm_range_unmap_from_cpu is the last entry, and
the entry is page fault, it also need to be dropped. So for equal case,
it also need to be dropped.

v2:
Only modify the svm_range_restore_pages.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Reviewed-by: Xiaogang Chen<xiaogang.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 508f02eb0cf8f..7de10208e8dde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -78,6 +78,9 @@ struct amdgpu_ih_ring {
 #define amdgpu_ih_ts_after(t1, t2) \
 		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
 
+#define amdgpu_ih_ts_after_or_equal(t1, t2) \
+		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) >= 0LL)
+
 /* provided by the ih block */
 struct amdgpu_ih_funcs {
 	/* ring read/write ptr handling, called from interrupt context */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b50283864dcd2..f00d41be7fca2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3014,7 +3014,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	/* check if this page fault time stamp is before svms->checkpoint_ts */
 	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
+		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
 			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
 			r = -EAGAIN;
 			goto out_unlock_svms;
-- 
2.39.5




