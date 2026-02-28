Return-Path: <stable+bounces-220270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDkMF4szo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B60921C5CF8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC8E231A3E03
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B09381CC9;
	Sat, 28 Feb 2026 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3pPVPRT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9905381CBF;
	Sat, 28 Feb 2026 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300173; cv=none; b=VGFYyT1S/WD0R6dlcicXNdDozq1UUS1wUjeCc0nD4NX3ZJwSZ3T6LfIKuWYlhxp+9yKhgikh27Got94cClGPS4vy7d0phRncEqMHZzC/ym+XjLDDosOnsA22RRpiML6dWM3K1nTkPRReyfzXKkOqeTCVrQYy5GtOqLDyCOcy3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300173; c=relaxed/simple;
	bh=eJtyVck8aATmjY54Z7ZJUhHhk9S7xobDAX5bxsj0qi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GszRTIbAsEXH5yCFlUlkZHa9N95OlxoUGdo9Zd7bFLTxlGLoreI0HiSAPKB7couX5pVetKv5B5/5+9AJvmKdHCpmv4mBsQAWqyJml1xCMvPhr80Pgza6hRTUOWq5hcBvxsGvEN3rMGWoLuc/RfBaCiJHwdKUAE0/nhO5ma4LB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3pPVPRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D2AC19424;
	Sat, 28 Feb 2026 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300173;
	bh=eJtyVck8aATmjY54Z7ZJUhHhk9S7xobDAX5bxsj0qi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3pPVPRTpQgda92c8qsQXnuPEhyA88PhIv59HNQ7WIjCqI7ZOimN4VPdPchq3kxS/
	 I21CSDjfB681YLbB6cF6GQJ+PA/SKlJ8AW19dEZfjNem8p3SmhKcAw87kOx9wYOOID
	 Df7oMIgPWFeHTnq0LDUTEvix3/UoLpA6AeHyuiy8qXV+oJ3jCwxPKtyDsey7kHC06u
	 wGA1LN+wIOCe4lQGu89389rf+0vzuAlb5aj+N0VUonOVQm5VWlqrqLa34iEe3M+TrQ
	 NXp0ZmUSCw0ufPo785Peax2fXLGH43k251Rj/QES6uWU1D2xcbErLEYwh8xjq67QZp
	 KFr1ckidEQlFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Donet Tom <donettom@linux.ibm.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philip Yang <Philip.Yang@amd.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 192/844] drm/amdkfd: Fix GART PTE for non-4K pagesize in svm_migrate_gart_map()
Date: Sat, 28 Feb 2026 12:21:45 -0500
Message-ID: <20260228173244.1509663-193-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,amd.com,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-220270-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B60921C5CF8
X-Rspamd-Action: no action

From: Donet Tom <donettom@linux.ibm.com>

[ Upstream commit 6c160001661b6c4e20f5c31909c722741e14c2d8 ]

In svm_migrate_gart_map(), while migrating GART mapping, the number of
bytes copied for the GART table only accounts for CPU pages. On non-4K
systems, each CPU page can contain multiple GPU pages, and the GART
requires one 8-byte PTE per GPU page. As a result, an incorrect size was
passed to the DMA, causing only a partial update of the GART table.

Fix this function to work correctly on non-4K page-size systems by
accounting for the number of GPU pages per CPU page when calculating the
number of bytes to be copied.

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6ada7b4af7c68..5086caac3fd06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -61,7 +61,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, u64 npages,
 	*gart_addr = adev->gmc.gart_start;
 
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
-	num_bytes = npages * 8;
+	num_bytes = npages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 
 	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
-- 
2.51.0


