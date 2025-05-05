Return-Path: <stable+bounces-140560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522CAAAE27
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCFA1BA566D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B42C1E38;
	Mon,  5 May 2025 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUk+nL2S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2E361287;
	Mon,  5 May 2025 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485148; cv=none; b=ukYVTADb2vXjecuTyqYC/RCxOAHHb5hCyHDdoqhCkji0p9WNdQ7mLSyPSqB1++SHry9pMGfKZMV7RbNnAFuNcdqDxHtY0ZaxKI4aspG26xs9kHrfd7h6y/HpYtpCxji6od+Nw25fTLb5VuQ1nEl/C2Dwqpn4upwiE+DQ+SJG07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485148; c=relaxed/simple;
	bh=CUZYiWZohMGUCG0wpS3AGsr94wXLMvRnxjIi6vlYFUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XWuvylSL6PKd4D5kiRa3vTV0NGdBo/osV1VxTQ3fkLj/6E86laY13kEmH2Omne9uwR6pqC8SdQuPT20RuGwWm/gnclfVjlwDEPQoKBuvm/IfttwTIKpsyS4USeqx272BoMx5nF4gjHKqEC+m4aACnbLUXQ+p8Q/uIAU3tJsXFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUk+nL2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFB7C4CEED;
	Mon,  5 May 2025 22:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485147;
	bh=CUZYiWZohMGUCG0wpS3AGsr94wXLMvRnxjIi6vlYFUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUk+nL2SjhvVKY+1Dj6JUCmDTrFqsF7stU/5IaX6eXC6zBO6XLAV2x+skM9h7CiCd
	 HHoqr3QTpvQVN+XrT200TFh4d3c4hW9rrfBjbFQEjMwWU0YoYOFm+uvZv7GUkGD6rC
	 tIoFdilrJ4LeE5PitMNvp5zYxvehf8efvWhzs8ZFja0YC0XfsyP0IWBfwm9S7UtOER
	 vTQR08AgVqMH52dfGPQIyj6znjFpgh74I1lmcSB8l9OugrmH9i3RQo0m7RmGtHlEFn
	 RyAofLzhX4NwUM6kRBajs8KkHFUbcSa6b8vcRTN7TBg0BCMlUYdn0te9B69RqZJTFh
	 M3thCh9oBUvvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Stuart Summers <stuart.summers@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 184/486] drm/xe: Retry BO allocation
Date: Mon,  5 May 2025 18:34:20 -0400
Message-Id: <20250505223922.2682012-184-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 1d724a2f1b2c3f0cba4975784a808482e0631adf ]

TTM doesn't support fair eviction via WW locking, this mitigated in by
using retry loops in exec and preempt rebind worker. Extend this retry
loop to BO allocation. Once TTM supports fair eviction this patch can be
reverted.

v4:
 - Keep line break (Stuart)

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250306012657.3505757-2-matthew.brost@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_bo.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 84e327b569252..35a8242a9f541 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1975,6 +1975,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 	struct xe_file *xef = to_xe_file(file);
 	struct drm_xe_gem_create *args = data;
 	struct xe_vm *vm = NULL;
+	ktime_t end = 0;
 	struct xe_bo *bo;
 	unsigned int bo_flags;
 	u32 handle;
@@ -2047,6 +2048,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 		vm = xe_vm_lookup(xef, args->vm_id);
 		if (XE_IOCTL_DBG(xe, !vm))
 			return -ENOENT;
+	}
+
+retry:
+	if (vm) {
 		err = xe_vm_lock(vm, true);
 		if (err)
 			goto out_vm;
@@ -2060,6 +2065,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 
 	if (IS_ERR(bo)) {
 		err = PTR_ERR(bo);
+		if (xe_vm_validate_should_retry(NULL, err, &end))
+			goto retry;
 		goto out_vm;
 	}
 
-- 
2.39.5


