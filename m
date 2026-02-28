Return-Path: <stable+bounces-220830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNuUFRtGo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:46:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCEF1C7593
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CDAD30B5B71
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25C2D2483;
	Sat, 28 Feb 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFCLged8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C88415FD1;
	Sat, 28 Feb 2026 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300715; cv=none; b=m7rC4XjRrpy9qtI++evSgxMgDIfAZjo4ymup5zqsn7XqKZebIIAYvjdm6M6xmSSF1WD53ZKyKB9TwS4UKOhemkkUEXDTb3mDqlXOw8LrhwNNwuuY5lFjCmyeh8Q6zjKI178pn+w5Bm7mzxKk0KPYzyQvssnnme1FXQVbB/qx6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300715; c=relaxed/simple;
	bh=7CwA+MeN8tG/l0tVfl+yVvqZ6EPZcnqVLzgKng0siLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thy+nf/3vOnwwBwKHyg3JdMnkOm+qvRBCNGbgKtRy8x4ptNMckbfn9/xxw/vgTW1ei3INvE9Ko6EQROjzWwRKpJ4wylgrXbBn1XAFpgiWUu8ihw/15+0sTERNY3hx6o5C8k6Nz99xrIHFbDs7wiDiT2IZwUNYcV+beTn0Egjzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFCLged8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13444C116D0;
	Sat, 28 Feb 2026 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300715;
	bh=7CwA+MeN8tG/l0tVfl+yVvqZ6EPZcnqVLzgKng0siLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFCLged8al/FVbuzzmvy4polPxNBX3cE3yzoqDqSzmud1NJ1GWn4XeZBl3W4AS6Lu
	 jxABj7Ea5KASpxtBuOMo5AmtbsiJGRHlM1TBsXPvDrojnvCfPeg0d90sgwx631ov4f
	 ItJlbKV4qP+0Xf1CsN7k4VAXBLej+lfJ78cclFqSrllTsYHqcwv4AF3eYUSCgn3zw8
	 YEenaiJLdCcTbD2ocW091JtRs8AdBLNXU9pMT81CeppT0Z8Bc7weB0l4JM27z2zSSg
	 iERMa3dseI4ZIgLT4Gp1FT3Dv0wfRJk7QU3cBlu/yd84i5cM5PsSNDV2QOJKNKEMib
	 ynmxOOlc0gnfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 751/844] drm/amdgpu: GPU vm support 5-level page table
Date: Sat, 28 Feb 2026 12:31:04 -0500
Message-ID: <20260228173244.1509663-752-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220830-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: BCCEF1C7593
X-Rspamd-Action: no action

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit f6b1c1f5fd7237f77fc3880603ea54dcf0371a20 ]

If GPU supports 5-level page table, but CPU disable 5-level page table
by using boot option no5lvl or CPU feature not available, the virtual
address will be 48bit, not needed to enable 5-level page table on GPU
vm.

If adev->vm_manager.num_level, number of pde levels, set to 4, then
gfxhub and mmhub register VM_CONTEXTx_CNTL/PAGE_TABLE_DEPTH will set
to 4 to enable 5-level page table in page table walker.

Set vm_manager.root_level to AMDGPU_VM_PDE3, then update GPU mapping
will allocate and update PDE3/PDE2/PDE1/PDE0/PTB 5-level page tables.

If max_level is not 4, no change for the logic to support features
needed by old ASICs.

v2: squash in CONFIG fix

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 3b948dd0366a ("drm/amdgpu: Use 5-level paging if gmc support 57-bit VA")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a67285118c37b..4d329454456bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2360,9 +2360,26 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 			   unsigned max_bits)
 {
 	unsigned int max_size = 1 << (max_bits - 30);
+	bool sys_5level_pgtable = false;
 	unsigned int vm_size;
 	uint64_t tmp;
 
+#ifdef CONFIG_X86_64
+	/*
+	 * Refer to function configure_5level_paging() for details.
+	 */
+	sys_5level_pgtable = (native_read_cr4() & X86_CR4_LA57);
+#endif
+
+	/*
+	 * If GPU supports 5-level page table, but system uses 4-level page table,
+	 * then use 4-level page table on GPU
+	 */
+	if (max_level == 4 && !sys_5level_pgtable) {
+		min_vm_size = 256 * 1024;
+		max_level = 3;
+	}
+
 	/* adjust vm size first */
 	if (amdgpu_vm_size != -1) {
 		vm_size = amdgpu_vm_size;
@@ -2405,6 +2422,9 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 	tmp = DIV_ROUND_UP(fls64(tmp) - 1, 9) - 1;
 	adev->vm_manager.num_level = min_t(unsigned int, max_level, tmp);
 	switch (adev->vm_manager.num_level) {
+	case 4:
+		adev->vm_manager.root_level = AMDGPU_VM_PDB3;
+		break;
 	case 3:
 		adev->vm_manager.root_level = AMDGPU_VM_PDB2;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 15d757c016cbb..de53176a398dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -185,9 +185,10 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
 
 /* VMPT level enumerate, and the hiberachy is:
- * PDB2->PDB1->PDB0->PTB
+ * PDB3->PDB2->PDB1->PDB0->PTB
  */
 enum amdgpu_vm_level {
+	AMDGPU_VM_PDB3,
 	AMDGPU_VM_PDB2,
 	AMDGPU_VM_PDB1,
 	AMDGPU_VM_PDB0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f794fb1cc06e6..c7a7d51080a87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -51,6 +51,7 @@ static unsigned int amdgpu_vm_pt_level_shift(struct amdgpu_device *adev,
 					     unsigned int level)
 {
 	switch (level) {
+	case AMDGPU_VM_PDB3:
 	case AMDGPU_VM_PDB2:
 	case AMDGPU_VM_PDB1:
 	case AMDGPU_VM_PDB0:
-- 
2.51.0


