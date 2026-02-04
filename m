Return-Path: <stable+bounces-213326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHvOJUCVgmkRWgMAu9opvQ
	(envelope-from <stable+bounces-213326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:39:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDF3E0108
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 868C0305193A
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 00:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13020A5F3;
	Wed,  4 Feb 2026 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh4vdi+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7320468E
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165564; cv=none; b=r6KjM4rx5Ol4AOCJUZS8YD+HWF3TJGHgmsOIsB4+e8JnAPXRR2CUFr1bIZd1o8NOd+7UwYOWBknRKOpXX/FDIq8Os83OER5utT1yZqqTRjT8W91Lh03a0isv9QguDWPJEYYgotGgCcPi96Zh8w4T7Z1cwuBJPqF3+gpc58b9B78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165564; c=relaxed/simple;
	bh=XiDnzz7a21RlTighvkAstkAwuFqgncb3YkhJ5barOeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9RsByj9WfqdP51BriBNOLD0B8FBx7XMEYspL9zSWj8rRtiVpmGljh225SQkUYmdoH2p8q1Jf/qMzf5NHb8Qx+sv/nNGaz6vKvDVzJadpJqCMVL4TMijN7bAfJu5AgIdTbA0aF/0aRQGp7d9X/dZX/JNFK6dkKTq3L+lfseZrGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh4vdi+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86486C116D0;
	Wed,  4 Feb 2026 00:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770165564;
	bh=XiDnzz7a21RlTighvkAstkAwuFqgncb3YkhJ5barOeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kh4vdi+uwYGoOUc4eYS/e3Nuja83pt1LarJO6Fu6Zvw3DH7LYcKEXN7qNQN3BYl4y
	 4JotcmFU9IGewjmxohPqd/b0KYptrjPMXph/G+WNH6vHrmdHg/UoYgL9VdsGFUaFBq
	 El7MhIuEYFDGMNl0N/MB+ipeOczisQXfW9MmGshVTDsrCNQrQ5i1f1v2tAyoNMAypH
	 Pm4OP5E1skKaoloerKlrMsgDalMIh3RhuNlNX3VGdofJB37B7VYCgAHWt5S40IRrSC
	 3VHnOc/dtIvLmfd1qETg4C/iGJxwIdGsRdvNV17QO0+Hc0sdrN4ZLWBWVX2TMES7Rd
	 vQ2KxsiUQtzew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu/gfx11: adjust KGQ reset sequence
Date: Tue,  3 Feb 2026 19:39:21 -0500
Message-ID: <20260204003922.1467007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020327-overbid-collar-0ba9@gregkh>
References: <2026020327-overbid-collar-0ba9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213326-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 3BDF3E0108
X-Rspamd-Action: no action

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 3eb46fbb601f9a0b4df8eba79252a0a85e983044 ]

Kernel gfx queues do not need to be reinitialized or
remapped after a reset.  This fixes queue reset failures
on APUs.

v2: preserve init and remap for MMIO case.

Fixes: b3e9bfd86658 ("drm/amdgpu/gfx11: add ring reset callbacks")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4789
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b340ff216fdabfe71ba0cdd47e9835a141d08e10)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 45 ++++++++++++++------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f218df42f5c8a..ce8b4e732e582 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6568,36 +6568,39 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool use_mmio = false;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio);
 	if (r)
 		return r;
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)) {
-		dev_err(adev->dev, "fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v11_0_kgq_init_queue(ring, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
-	if (r) {
-		dev_err(adev->dev, "fail to unresv mqd_obj\n");
-		return r;
-	}
+	if (use_mmio) {
+		r = amdgpu_bo_reserve(ring->mqd_obj, false);
+		if (unlikely(r != 0)) {
+			dev_err(adev->dev, "fail to resv mqd_obj\n");
+			return r;
+		}
+		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+		if (!r) {
+			r = gfx_v11_0_kgq_init_queue(ring, true);
+			amdgpu_bo_kunmap(ring->mqd_obj);
+			ring->mqd_ptr = NULL;
+		}
+		amdgpu_bo_unreserve(ring->mqd_obj);
+		if (r) {
+			dev_err(adev->dev, "fail to unresv mqd_obj\n");
+			return r;
+		}
 
-	r = amdgpu_mes_map_legacy_queue(adev, ring);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kgq\n");
-		return r;
+		r = amdgpu_mes_map_legacy_queue(adev, ring);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kgq\n");
+			return r;
+		}
 	}
 
 	return amdgpu_ring_test_ring(ring);
-- 
2.51.0


