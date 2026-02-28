Return-Path: <stable+bounces-220216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGGvD2Eto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E4F1C5538
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C80373187AA7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7C4DC521;
	Sat, 28 Feb 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAkvOYW9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E44DBD98;
	Sat, 28 Feb 2026 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300121; cv=none; b=MbdSCY9g5NOAzqSMugkgK9bRx032WaK/sjmhZXdAFMmgjf0CZ5uI8WZ+PYHlcT2QPiD1KaocKu6NmBteEVU9zTEY274AB1XwCR+BgLquYHQAoIeNGktgmFOfe6rhKHLysWJ/SYj6uuhowtpNH//WTi5Jt2QoSksQqlJNT6qih2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300121; c=relaxed/simple;
	bh=UEHRO0JjcXGWwUefm/KvjqDR+eXCgmSQLiASBuhYmis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzP7yZVnGlMc7/9e/mogcHWsxvT3rXOyMBTK63rwl5QJG92aT5Og15XYBoekxCUWr+H6Gal7eLbgAJ1b5MoPzrNOBewwy0b5wNtuBTnxuDbt0syceDrwvI3Net7BysaFtzlRnj7IpZDrmAkbZF/+oXz0SoBTZSNMehElLgVqGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAkvOYW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F268C116D0;
	Sat, 28 Feb 2026 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300121;
	bh=UEHRO0JjcXGWwUefm/KvjqDR+eXCgmSQLiASBuhYmis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAkvOYW9BVpxJsNy5dOKl471bZ52bsPYyQ9pw90Q9aZREepR653IVJKlNF1s8SWP1
	 T6cL0z5A9DpXIya8GrmZPIBpZjl0cBW5Yb2bnYnOZSKCsM+k0H5K9lP6otu/NnFX7U
	 RUGa1hYiCQRIWwKV+0H7sOZS/n3aGtQs+mqDtelBeiR2OHnhAL4WxgDieAtFacuvFc
	 MnkeB2royKo3ajKCbo78Qdu4YT8xGBavlpbx1v+xJv9beyemzFVFybN7UCO5tOE6Pz
	 hvBgq+WJas76xY0b37uHToBvga8P/ZpQIupsEC2jl3eHbo0YifLAOYXNpcetVxCHj4
	 Frp71ilY68clw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 138/844] drm/amdkfd: Handle GPU reset and drain retry fault race
Date: Sat, 28 Feb 2026 12:20:51 -0500
Message-ID: <20260228173244.1509663-139-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220216-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81E4F1C5538
X-Rspamd-Action: no action

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 5b57c3c3f22336e8fd5edb7f0fef3c7823f8eac1 ]

Only check and drain IH1 ring if CAM is not enabled.

If GPU is under reset, don't access IH to drain retry fault.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 79ea138897fcf..a10cf8650c92b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -33,6 +33,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_reset.h"
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
@@ -2349,6 +2350,9 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
 
+		if (!down_read_trylock(&pdd->dev->adev->reset_domain->sem))
+			continue;
+
 		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
 				pdd->dev->adev->irq.retry_cam_enabled ?
 				&pdd->dev->adev->irq.ih :
@@ -2358,6 +2362,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 			amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
 				&pdd->dev->adev->irq.ih_soft);
 
+		up_read(&pdd->dev->adev->reset_domain->sem);
 
 		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
 	}
@@ -2541,7 +2546,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		adev = pdd->dev->adev;
 
 		/* Check and drain ih1 ring if cam not available */
-		if (adev->irq.ih1.ring_size) {
+		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
 			ih = &adev->irq.ih1;
 			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
 			if (ih->rptr != checkpoint_wptr) {
-- 
2.51.0


