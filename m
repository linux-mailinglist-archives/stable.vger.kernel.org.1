Return-Path: <stable+bounces-221268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPe4E7WTo2khHQUAu9opvQ
	(envelope-from <stable+bounces-221268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:17:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213331CA161
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A67530107A4
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44064244665;
	Sun,  1 Mar 2026 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzW2OgGw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07207243968
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327847; cv=none; b=DhoqmtRcMPbTO5bBj3zItdiy1C5ngngBZolxY5Uq521bRgXFLWAkTmn0ME+FDlavn5ZmZTTSara/3EgGuU5vPxBYLVP9wVi8YssDL4DvxpeRTEQaVWFNQAecACyY6BNKCWlSTAbrjibmAijmefk5b+gxNL4bEb18SZuIcq4Ca24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327847; c=relaxed/simple;
	bh=rBl57kMDRLpGUBb7ZPbRn0v73r0r0HgPBzQemyULpBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzdB31IdAyCtH8jM6YzcFY0MdaWwUMNoASQBstAGSTsP/Y3k595s8aJZ9eQayUHoqDT3MmyYEJwV0K81OZArM6s/jH5fYCMhWCfAoXmhwcwMd3WytjBtMzG8f9Kpn3oojLE2scSPY7EraXmV4xDOMZ6FWUa0aIKl8/tEXiFaO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzW2OgGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E596FC19421;
	Sun,  1 Mar 2026 01:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327846;
	bh=rBl57kMDRLpGUBb7ZPbRn0v73r0r0HgPBzQemyULpBo=;
	h=From:To:Cc:Subject:Date:From;
	b=VzW2OgGwa3ZxrzCV/XVym07ehAgN7Qve8VFYAR9ikGDgEJOBgkaAWqdzc5Ccs3MtP
	 smd4uZfFf1ClSRrwjF3JW1Cr9J4WI/9azFklUGJzB095J5gdW5bCfuuur4IxtizMHR
	 KLwWStiGJT1bPvgCPbX03eaKpDtXbNfTJptIYoqNa/cSpiQesHtHLK7fyzVUc9yo5x
	 JYGRynyZl4+WeW4IA9J2zHhU0JIjnog8iKQsVn18Mph8GcfjJHtM6wkSUbxxlEYg/b
	 0UykmTsFQwA4WOuf+OwJSnD78AC1iX2sPjOZVzEbL+fmKgHTotbKsHE/oXU6aPTZxj
	 C89ccJ72bOsxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Philip.Yang@amd.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdgpu: Use 5-level paging if gmc support 57-bit VA" failed to apply to 6.18-stable tree
Date: Sat, 28 Feb 2026 20:17:24 -0500
Message-ID: <20260301011724.1671349-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221268-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 213331CA161
X-Rspamd-Action: no action

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3b948dd0366a0b64c02e4ed1aefdf7825942e803 Mon Sep 17 00:00:00 2001
From: Philip Yang <Philip.Yang@amd.com>
Date: Tue, 27 Jan 2026 13:52:33 -0500
Subject: [PATCH] drm/amdgpu: Use 5-level paging if gmc support 57-bit VA
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Regardless if CPU enable 5-level paging, GPU vm use 5-level paging if
gmc init with 57-bit address space support, because

ARM64 4-level paging support 48-bit VA, x86 and GPU 4-level paging
support 47-bit VA, require 5-level paging on GPU to support ARM64.

NPA address space 52-bit mapping on NPA GPU VM require 5-level paging.

Debugger trap get device snapshot expect LDS and Scratch base, limit
above 57-bit, which is set only for 5-level paging.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.19.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a2ea200d90c8..31383583fc682 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2360,26 +2360,9 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 			   unsigned max_bits)
 {
 	unsigned int max_size = 1 << (max_bits - 30);
-	bool sys_5level_pgtable = false;
 	unsigned int vm_size;
 	uint64_t tmp;
 
-#ifdef CONFIG_X86_64
-	/*
-	 * Refer to function configure_5level_paging() for details.
-	 */
-	sys_5level_pgtable = (native_read_cr4() & X86_CR4_LA57);
-#endif
-
-	/*
-	 * If GPU supports 5-level page table, but system uses 4-level page table,
-	 * then use 4-level page table on GPU
-	 */
-	if (max_level == 4 && !sys_5level_pgtable) {
-		min_vm_size = 256 * 1024;
-		max_level = 3;
-	}
-
 	/* adjust vm size first */
 	if (amdgpu_vm_size != -1) {
 		vm_size = amdgpu_vm_size;
-- 
2.51.0





