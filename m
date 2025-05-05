Return-Path: <stable+bounces-141323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB99AAB267
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14974638C3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563AB42955E;
	Tue,  6 May 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjdaj52l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D128031D;
	Mon,  5 May 2025 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485760; cv=none; b=Q4FpIPBYAFhF5cClQkjTnClWPfyH352rQEAtblMQSoD6xbQhKoLRxoGEyTgdhK2gKonXnQu2kMzF8/xIcR7Ipg/oZi2fCRsCOvR1O2vfiNLw1p6Iu4SvRfqMylczVyomtE8Lp+aXbVKjmAMtIa45jMtuX9g2ZJfbfVVBmVFcoTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485760; c=relaxed/simple;
	bh=5EK3ujhSzpb7eoLDLCPJ4F+Yy6hZCLVlJzYSvX3MzDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScrCqpLFFSqcc+VPRWVOM6eSY6sdgywRG0fFd54BHEEBWgapHJDhmdrlYt9UU/YYChU2otv22EFvcpeawr0iHiAESWP/clW1P6aRX3qq3cvSTktw9fFJ5X6khCOtHg9PLMHBVPtp6Bhe1gR5ZCG+o7zkUR8T40Sqci3MOqkTzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjdaj52l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6ECC4CEEF;
	Mon,  5 May 2025 22:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485759;
	bh=5EK3ujhSzpb7eoLDLCPJ4F+Yy6hZCLVlJzYSvX3MzDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjdaj52lFXUNnI7YmzHd7MJn+YoXhaAdTqQ9ybJetVTRbd3sDonwF1hS8kXC+wDk7
	 uxGPkKFjDSXgiO8B2DXeFGynCIDdcOsxDyUsFsKDmekXXfCqxoJK9Dk07CwBsGxQkZ
	 1BEg+CkJrfV4cQmlF4q+Obxk0O7u94IEc1dM3lyatv7B1Iy6pjcww4n6y8aQxaWU3e
	 0jZ8dYFha35XkSqYiVlEFAmTcXp/vE8xZzCpO10kR+S/a5qR6gIiZalDHd/6eMslzA
	 cmbVjalizJQQTI6pMwCl/IXwDvqBi2M4jMDIxM+5IZiWK6pp8Xp2W3XHa30IkVFKI3
	 tbqbvYMZ4/qMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 469/486] drm/xe/pf: Reset GuC VF config when unprovisioning critical resource
Date: Mon,  5 May 2025 18:39:05 -0400
Message-Id: <20250505223922.2682012-469-sashal@kernel.org>
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

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 33f17e2cbd930a2a00eb007d9b241b6db010a880 ]

GuC firmware counts received VF configuration KLVs and may start
validation of the complete VF config even if some resources where
unprovisioned in the meantime, leading to unexpected errors like:

 $ echo 1 | sudo tee /sys/kernel/debug/dri/0000:00:02.0/gt0/vf1/contexts_quota
 $ echo 0 | sudo tee /sys/kernel/debug/dri/0000:00:02.0/gt0/vf1/contexts_quota
 $ echo 1 | sudo tee /sys/kernel/debug/dri/0000:00:02.0/gt0/vf1/doorbells_quota
 $ echo 0 | sudo tee /sys/kernel/debug/dri/0000:00:02.0/gt0/vf1/doorbells_quota
 $ echo 1 | sudo tee /sys/kernel/debug/dri/0000:00:02.0/gt0/vf1/ggtt_quota
 tee: '/sys/kernel/debug/dri/0000:00:02.0/gt0/vf1/ggtt_quota': Input/output error

To mitigate this problem trigger explicit VF config reset after
unprovisioning any of the critical resources (GGTT, context or
doorbell IDs) that GuC is monitoring.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250129195947.764-3-michal.wajdeczko@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c | 37 +++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
index c9ed996b9cb0c..786f0dba41437 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
@@ -323,6 +323,26 @@ static int pf_push_full_vf_config(struct xe_gt *gt, unsigned int vfid)
 	return err;
 }
 
+static int pf_push_vf_cfg(struct xe_gt *gt, unsigned int vfid, bool reset)
+{
+	int err = 0;
+
+	xe_gt_assert(gt, vfid);
+	lockdep_assert_held(xe_gt_sriov_pf_master_mutex(gt));
+
+	if (reset)
+		err = pf_send_vf_cfg_reset(gt, vfid);
+	if (!err)
+		err = pf_push_full_vf_config(gt, vfid);
+
+	return err;
+}
+
+static int pf_refresh_vf_cfg(struct xe_gt *gt, unsigned int vfid)
+{
+	return pf_push_vf_cfg(gt, vfid, true);
+}
+
 static u64 pf_get_ggtt_alignment(struct xe_gt *gt)
 {
 	struct xe_device *xe = gt_to_xe(gt);
@@ -419,6 +439,10 @@ static int pf_provision_vf_ggtt(struct xe_gt *gt, unsigned int vfid, u64 size)
 			return err;
 
 		pf_release_vf_config_ggtt(gt, config);
+
+		err = pf_refresh_vf_cfg(gt, vfid);
+		if (unlikely(err))
+			return err;
 	}
 	xe_gt_assert(gt, !xe_ggtt_node_allocated(config->ggtt_region));
 
@@ -744,6 +768,10 @@ static int pf_provision_vf_ctxs(struct xe_gt *gt, unsigned int vfid, u32 num_ctx
 			return ret;
 
 		pf_release_config_ctxs(gt, config);
+
+		ret = pf_refresh_vf_cfg(gt, vfid);
+		if (unlikely(ret))
+			return ret;
 	}
 
 	if (!num_ctxs)
@@ -1041,6 +1069,10 @@ static int pf_provision_vf_dbs(struct xe_gt *gt, unsigned int vfid, u32 num_dbs)
 			return ret;
 
 		pf_release_config_dbs(gt, config);
+
+		ret = pf_refresh_vf_cfg(gt, vfid);
+		if (unlikely(ret))
+			return ret;
 	}
 
 	if (!num_dbs)
@@ -2003,10 +2035,7 @@ int xe_gt_sriov_pf_config_push(struct xe_gt *gt, unsigned int vfid, bool refresh
 	xe_gt_assert(gt, vfid);
 
 	mutex_lock(xe_gt_sriov_pf_master_mutex(gt));
-	if (refresh)
-		err = pf_send_vf_cfg_reset(gt, vfid);
-	if (!err)
-		err = pf_push_full_vf_config(gt, vfid);
+	err = pf_push_vf_cfg(gt, vfid, refresh);
 	mutex_unlock(xe_gt_sriov_pf_master_mutex(gt));
 
 	if (unlikely(err)) {
-- 
2.39.5


