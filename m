Return-Path: <stable+bounces-139969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202D0AAA31B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD28117B03B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A282EE492;
	Mon,  5 May 2025 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGByiNTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE452EE48C;
	Mon,  5 May 2025 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483797; cv=none; b=XmpfYgTmK/2wp1ExeTeuLDdv2Pswt+pG2KF16JngtLllCYWnbB7eCZq023fXudDfADoThBgLIKcfFO4dwT4QYOxAJ0h0ss5OmFozKAQ+wygxsUVfvL9WkNBjHIWRBmsnbf1wNMkznSzSr+tNplyHp0Fyzr82hDxprMRNOJL7bBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483797; c=relaxed/simple;
	bh=a1kuSAiEM1EOjK781g5Z7jy7/bRtjex1qwzQ00O5S1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IT/wpDGjlrbyq6icX+Uus/vWl6Oq6CCmQRjyqyvc+5hgjqtGQjjm4ijhA74wu9De3yLWqNLxLZUCR8E77Nh/vjcRruVOgYyIYY8bjOpHXbSpOH5olonfa0Fqw52IChN3rtNi4hdyqh5kl621HVq3qaWpPyV9NDJwPGgzRkm6cXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGByiNTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559D3C4CEEE;
	Mon,  5 May 2025 22:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483797;
	bh=a1kuSAiEM1EOjK781g5Z7jy7/bRtjex1qwzQ00O5S1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGByiNTtepz7dXzappNf1LO9siiOeGjJ/zAD6jdbdyqlA5NTTW2osPB2XQTTn8Ue9
	 fnTMUlAudkrCAO3+tJTiX4mwvh6NAnRqRJB4QvDdfzizYylEqIu5XUxUycPO/uM7FN
	 XdtEwaFuhSUEkxa4IBQhFOkiUPPxwGzHCJ//MMcBpQVgJLGoOHW0i9Yh5tX5JNQs7g
	 1Ca3725to/Sjfd1aSZsUqsPaWq59oT3AL3pfWID8hDGVRqhDHm0YCp9C1z9YaDuz9h
	 hyIol7N4YuzskCr9ITAKrhmigWDMFFyjkmX4liX/F2WabxT5YBPTAa0OXNJUQrUT5/
	 uz6GyXn6aqQPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emily Deng <Emily.Deng@amd.com>,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Felix.Kuehling@amd.com,
	Philip.Yang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 222/642] drm/amdgpu: Fix missing drain retry fault the last entry
Date: Mon,  5 May 2025 18:07:18 -0400
Message-Id: <20250505221419.2672473-222-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

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
index 7d4395a5d8ac9..b0a88f92cd821 100644
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
index d1cf9dd352904..47189453b20c3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3024,7 +3024,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	/* check if this page fault time stamp is before svms->checkpoint_ts */
 	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
+		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
 			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
 			r = -EAGAIN;
 			goto out_unlock_svms;
-- 
2.39.5


