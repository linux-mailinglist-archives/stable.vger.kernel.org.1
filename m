Return-Path: <stable+bounces-227156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGulONEOu2kSegIAu9opvQ
	(envelope-from <stable+bounces-227156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:45:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E432C2965
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 888AE3165070
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53CF33C51D;
	Wed, 18 Mar 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNb7iMnb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900E34107A
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866504; cv=none; b=UQ37zZIaIfZ9KmllbMCTwTIrHPACP6AB/U1MvBgV+jBVk0p4ekWRJr5b8aVzE3O97C/xvlf2wnrTZwnsqENmx+PS4ZUDRcDgPdDTM40eB9w7c00O010ZKQNpE8IEPmecQdY29Gkd6eHkMRXEvyFtAg2Jh35zgXi0NQFQKNINSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866504; c=relaxed/simple;
	bh=yrdIZaku+ltjPzr5+mmCP5tWE1r2lTt1ZmS6vhPlXM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgBdXbVxHhw+z7IcC+7oqkwzDqI9jmBucFP285grQU4oBYJfd1hPlgUWvRQq10+d70JeAcB5YkkF74CWy+3w5RHcyDIw22tNpyP49KLEIWSr+uVAw51gwSoPlxabxZfI2S4Fl2YofOA61FSwVdMOiPa9FU9CSIqHgsKD7ZpIgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNb7iMnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A531C19421;
	Wed, 18 Mar 2026 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773866504;
	bh=yrdIZaku+ltjPzr5+mmCP5tWE1r2lTt1ZmS6vhPlXM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNb7iMnbcAL6xy7gFadC9pR6VIog560K/o1/Llv392R4gxpY+a2uyZVCT/KGXZjJK
	 HOrsZ0exhdcTTBEpAe0TUu50S1V46C2nMgqAI2wiLj6KKILYga/AD4MPQL1esaQK/H
	 s05aed2hRa1ShyT6bBOqEqTECrcjD1JYZ+v7rw7fjI3lcwxVt15JahXkNutLskc8QU
	 Eu8ACv41ig+E3cCB6Orwh8dZNPHMS2V5Cr7Ww283AeGPcLB8XHHCXPaf3USvhMfDSw
	 eIasbvTGC14Ty6SXrYsGTvvo9xAoVXDwldUKmzBK6bTvlTE27UDVXTCzXloBIq1Yyi
	 Lqy0TZ6jd7cjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Varun Gupta <varun.gupta@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] drm/xe: Fix memory leak in xe_vm_madvise_ioctl
Date: Wed, 18 Mar 2026 16:41:41 -0400
Message-ID: <20260318204141.1139130-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031742-pull-husband-3953@gregkh>
References: <2026031742-pull-husband-3953@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227156-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.973];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61E432C2965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Varun Gupta <varun.gupta@intel.com>

[ Upstream commit 0cfe9c4838f1147713f6b5c02094cd4dc0c598fa ]

When check_bo_args_are_sane() validation fails, jump to the new
free_vmas cleanup label to properly free the allocated resources.
This ensures proper cleanup in this error path.

Fixes: 293032eec4ba ("drm/xe/bo: Update atomic_access attribute on madvise")
Cc: stable@vger.kernel.org # v6.18+
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
Signed-off-by: Varun Gupta <varun.gupta@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260223175145.1532801-1-varun.gupta@intel.com
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
(cherry picked from commit 29bd06faf727a4b76663e4be0f7d770e2d2a7965)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[ changed old goto target from `madv_fini` to `unlock_vm` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_vm_madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index fe7e1b45f5c0c..9dc801f657129 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -390,7 +390,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 						    madvise_range.num_vmas,
 						    args->atomic.val)) {
 				err = -EINVAL;
-				goto unlock_vm;
+				goto free_vmas;
 			}
 		}
 
@@ -426,6 +426,7 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 err_fini:
 	if (madvise_range.has_bo_vmas)
 		drm_exec_fini(&exec);
+free_vmas:
 	kfree(madvise_range.vmas);
 	madvise_range.vmas = NULL;
 unlock_vm:
-- 
2.51.0


