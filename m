Return-Path: <stable+bounces-141328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B726AAB281
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112F74E2045
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349F42D04C;
	Tue,  6 May 2025 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBb25xl1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8636AAF2;
	Mon,  5 May 2025 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485781; cv=none; b=NSwPTvdU7teNcsg0ThyeXPfa7wy5cbEfWe36o49J4Sw/s5WuVtqAJy4cGca+Rqgn+0ghUhlNgJAYQC9hrk/LJ7Mly3l/Ju02DgmtCa68GA6m7mU4NnG8Yxk+YDSr86V1LD0PQHob83twMjK3xaKv9KS64giuwUIUiYY1fpagYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485781; c=relaxed/simple;
	bh=ixfi30/lcflrPfhhbOcBX3S3YAtPFBIpsD7l18WacgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkUHSnC2PosqoogPdytLYGt1bOTA3D6TdgTJEAdpgzq3RDx2R+2I8PPPmmXaY8VkMlKC8gvQ5WT8ild/ZLLb7DTLCeUwDg1M97QT1nX2tjBQeLGqJvUs+WOqDvQMfg6FomYGni2zuQz57TvZAje3kta5YK1Pp5TeTzYVMywoHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBb25xl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2BAC4CEED;
	Mon,  5 May 2025 22:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485780;
	bh=ixfi30/lcflrPfhhbOcBX3S3YAtPFBIpsD7l18WacgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBb25xl1PwhPlkZYFdUAtgZPCNQXgE5pmJEwtoYag+55+p8wcexJRHUokA+wme9Nf
	 6fZkIG9G38sJoj7vLERVfQuMZmU6LGLDLn/uvkjbw7h1JmVfFQaUwHQr18Npupb6Tu
	 mQ9wOp4bl/vhJqzr/FPJx2G07uxHuIccnzQSLFw8NycavTVq2ZBTeek62hpUex1Ssr
	 bfcX5brCzS9k7D1733RAFClND0DMMYGXNH+HHrP13eNshpLQTGUIBft+oeEu5f+EQr
	 mJwFSxOYe1FSxR7RdW1OSNxfhP54lxrCax1x9m757KIGlv1BiAjn/lqEUVEdQWmIK6
	 1//XXNKC/FMyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oak Zeng <oak.zeng@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 481/486] drm/xe: Reject BO eviction if BO is bound to current VM
Date: Mon,  5 May 2025 18:39:17 -0400
Message-Id: <20250505223922.2682012-481-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Oak Zeng <oak.zeng@intel.com>

[ Upstream commit 0af944f0e3082ff517958b1cea76fb9b8cb379dd ]

This is a follow up fix for
https://patchwork.freedesktop.org/patch/msgid/20241203021929.1919730-1-oak.zeng@intel.com
The overall goal is to fail vm_bind when there is memory pressure. See more
details in the commit message of above patch. Abbove patch fixes the issue
when user pass in a vm_id parameter during gem_create. If user doesn't pass
in a vm_id during gem_create, above patch doesn't help.

This patch further reject BO eviction (which could be triggered by bo validation)
if BO is bound to the current VM. vm_bind could fail due to the eviction failure.
The BO to VM reverse mapping structure is used to determine whether BO is bound
to VM.

v2:
Move vm_bo definition from function scope to if(evict) clause (Thomas)
Further constraint the condition by adding ctx->resv (Thomas)
Add a short comment describe the change.

Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Oak Zeng <oak.zeng@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250110210137.3181576-1-oak.zeng@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_bo.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 35a8242a9f541..8acc4640f0a28 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -702,6 +702,21 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 		goto out;
 	}
 
+	/* Reject BO eviction if BO is bound to current VM. */
+	if (evict && ctx->resv) {
+		struct drm_gpuvm_bo *vm_bo;
+
+		drm_gem_for_each_gpuvm_bo(vm_bo, &bo->ttm.base) {
+			struct xe_vm *vm = gpuvm_to_vm(vm_bo->vm);
+
+			if (xe_vm_resv(vm) == ctx->resv &&
+			    xe_vm_in_preempt_fence_mode(vm)) {
+				ret = -EBUSY;
+				goto out;
+			}
+		}
+	}
+
 	/*
 	 * Failed multi-hop where the old_mem is still marked as
 	 * TTM_PL_FLAG_TEMPORARY, should just be a dummy move.
-- 
2.39.5


