Return-Path: <stable+bounces-139979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB46DAAA371
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277D47AF296
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DCA2F0BA1;
	Mon,  5 May 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4o9Y3Ci"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E12F0B9B;
	Mon,  5 May 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483817; cv=none; b=pEeCcfbu7Ld8wFGyxPjHq5tOOeDsnjghTYFeuJK4tnN23sTqchY9rTyDo9zlsZ4cf049vYURNW2SNPVne8St9tnpcPPKZh7IlvxcFscBIsVfqboaryd2bKRIL48LN6HGbILKLyIpkjYDSya5syt0KtVWaTlWkZABPmC2MuLwYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483817; c=relaxed/simple;
	bh=cYgAGWyxk03GJQKmaNwFChbrqq9o9Ns3i/Fj53+ylZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VeyjXm04UuXqu/djzKFcoiEz4iKlyZo9C8KxNexjThI1LwcFcw4ptg75m/NgVhQLH5XkJmbE2yoKp2YALV+KntzabsLoZsoLu/PuRV07a9sEGZhSzzfFgOJsWEmzJcOdi/OIXsDsIML5WKSGnT3vZIf39ZugPiqFex72g2+J+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4o9Y3Ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F094C4CEE4;
	Mon,  5 May 2025 22:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483817;
	bh=cYgAGWyxk03GJQKmaNwFChbrqq9o9Ns3i/Fj53+ylZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4o9Y3Ci3CdmaWLKRFmugQs5E0aqx0SBK/tJUn0NtRZPzTCSH04stlpYqOAMKR0iF
	 jT1wraMAJOBTtXnBesCCq3tb3/Oh4pGRYYOTDmU0o1KlpiH37raMXALsgsZxDthzt7
	 4Di49mN43Eb2tuRHzox78IGV9/nTCxin06IijR13vKsiZ+ZtaxGdzeRFkpW2zdhRvx
	 66WhaX8PS4wjTHFgNk1mOQ9UK9s7n5VRQ43qC7Zf5/mgmIUhquzSYBqkZbyofMdbow
	 tQXbwfIqOKPPE8trsy4klpzPfcQMSrCpDpEkz4K00prL0PWojZBjtsPEMtyUWHcbFS
	 8va9m0jU6jIKA==
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
Subject: [PATCH AUTOSEL 6.14 232/642] drm/xe: Retry BO allocation
Date: Mon,  5 May 2025 18:07:28 -0400
Message-Id: <20250505221419.2672473-232-sashal@kernel.org>
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
index 3f5391d416d46..d1eb87cb178bd 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2142,6 +2142,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 	struct xe_file *xef = to_xe_file(file);
 	struct drm_xe_gem_create *args = data;
 	struct xe_vm *vm = NULL;
+	ktime_t end = 0;
 	struct xe_bo *bo;
 	unsigned int bo_flags;
 	u32 handle;
@@ -2214,6 +2215,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
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
@@ -2227,6 +2232,8 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 
 	if (IS_ERR(bo)) {
 		err = PTR_ERR(bo);
+		if (xe_vm_validate_should_retry(NULL, err, &end))
+			goto retry;
 		goto out_vm;
 	}
 
-- 
2.39.5


