Return-Path: <stable+bounces-77524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8AF985E4D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8CBB29C0E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F820B1EF;
	Wed, 25 Sep 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnlmuNmm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0220B1E8;
	Wed, 25 Sep 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266112; cv=none; b=mGeLYdMJ0ayX38T8Pz3wTjkmiRton7HdyZJIVmfXT6zTOBMGWGQBVN8Ev6C5Oi7V3PUPwy18lqyseVrviUIlcIHTfGnfftswuDyqmO+jonbgTlYuYNKN7B1IGOlp4n8ygYWwimoXB/3/yq4nuNk013FBfbUkVwoFTku2OPXhPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266112; c=relaxed/simple;
	bh=B5QuL0qqSIR5MOesCll76x9q2bnI8oUj3OEh00t2cqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ik3EMMevdnpSOzAnhAQhsWSxzkLKnmHe9inN1g1Ia3iwc+/94znFmCQD1bLvV9ozI41EhcyGTbtqDNe2whiKdikOzzMAcE4HWiwgCc/7GdvBZPSLpdmFbRmxKA2r1m2TX+lEWEzSRHLloBwGFErQcxJWe2XzMU6FJPLHrpV44aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnlmuNmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ED2C4CECD;
	Wed, 25 Sep 2024 12:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266112;
	bh=B5QuL0qqSIR5MOesCll76x9q2bnI8oUj3OEh00t2cqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnlmuNmm6UjJjf5wihXRTT1XVjwmWEgqBJgiINoG1MisfoxJJjdxsDEpuYyla7BKW
	 JLdZbfAeA+5jE5pU7Rhz8OAfKIAqkIJOfk74YhaoPt/QOi+8BJFQt4wUClKKxWLdH0
	 4sYDXBha+eNQr2GEwbQjomdmdomZ0+LaZb6C98nSoAzJ3DnzSVM7N7IRblU9EaZ4VZ
	 lFHN9bKjiB8Zgw0jZhBUkmE4lR4tzk5X6sSCGUUidiJj4OStGnsBYTNfQ35gEudoME
	 8Bn2E5vecHCtDhK7LlvKSto86W8VPDP4SIXtJyumjWHRDLQJIJeTToK5ucC2BBrJSf
	 mNiLcgeT1Cfrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Jagmeet Randhawa <jagmeet.randhawa@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 176/197] drm/xe: Drop warn on xe_guc_pc_gucrc_disable in guc pc fini
Date: Wed, 25 Sep 2024 07:53:15 -0400
Message-ID: <20240925115823.1303019-176-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit a323782567812ee925e9b7926445532c7afe331b ]

Not a big deal if CT is down as driver is unloading, no need to warn.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Jagmeet Randhawa <jagmeet.randhawa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240820172958.1095143-4-matthew.brost@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index 23382ced4ea74..69f8b6fdaeaea 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -897,7 +897,7 @@ static void xe_guc_pc_fini(struct drm_device *drm, void *arg)
 	struct xe_guc_pc *pc = arg;
 
 	XE_WARN_ON(xe_force_wake_get(gt_to_fw(pc_to_gt(pc)), XE_FORCEWAKE_ALL));
-	XE_WARN_ON(xe_guc_pc_gucrc_disable(pc));
+	xe_guc_pc_gucrc_disable(pc);
 	XE_WARN_ON(xe_guc_pc_stop(pc));
 	xe_force_wake_put(gt_to_fw(pc_to_gt(pc)), XE_FORCEWAKE_ALL);
 }
-- 
2.43.0


