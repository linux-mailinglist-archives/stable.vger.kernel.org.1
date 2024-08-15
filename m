Return-Path: <stable+bounces-67769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776B1952E8C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7591F212C0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E56F143888;
	Thu, 15 Aug 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBblkNeJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E11AC8A0
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726219; cv=none; b=j4egO4xDdnoZTNaj+l03LEGKmeuOsHRAGrzDGG7yEEnAs8fK9DD7Q9CuxmOPjTB75SaXvg7UJ/zfGOt49CKIHJWben63DDz5LMb8UNTnm0L60PLVOWDyoNloM/UTT6jjcevP5lLuNSptmAnJpAWqBr9VizD5t3HbYP9xDzTaUME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726219; c=relaxed/simple;
	bh=lBDYtvfznvt+zkpValfj20JiwDcXb2UAETOoILm4Q1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MEaWm24FG4WIc9CwQHmLVcCIAAuM0goKrl0ka/eCKm927bwv0hePRx2nmKLorUEUVngqY+ojWmT8c0bYXQdH5HwToDPXhucxnzl3QGo2GBexPUsbBGKJLZo/K2R2VArdky0vPAw9a/vXBfNsoh8mWzdQoEuj09OWJ4QzBuG7iiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBblkNeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84BBC4AF0A;
	Thu, 15 Aug 2024 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723726218;
	bh=lBDYtvfznvt+zkpValfj20JiwDcXb2UAETOoILm4Q1c=;
	h=From:To:Cc:Subject:Date:From;
	b=fBblkNeJMa/VHaAAN/hGkJfX0vsHy2boTjklC1lvrJ32Dv9G3bAlJ+Wy2S5jkEl69
	 7jOYe4r667WGTHj+NqTHNLK4J5TwnT+uzj5hLaU/edpIy3veOApNcXRgFJJ/y0iK5F
	 XVHRdeY65wu6qN6gGsLNCZglixCjoIh8QB9BRIocsLHSvuga3uK9gfPO7j5RNs7dG6
	 gMCxPwdIoZyAKZjYpKX4IseCeIJKKRrJd6CBe4R8M97gGV7hhAUDs+XpJ/Vg/uL7bR
	 3YDPjNTNUCm5lUjKhfneqIdDeaiX3YuZh75g/yiezkDAx2FK1ZlFBpHe1hCDNzy429
	 hu4dNo/8OizIg==
From: Will Deacon <will@kernel.org>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 6.1.y] KVM: arm64: Don't pass a TLBI level hint when zapping table entries
Date: Thu, 15 Aug 2024 13:50:03 +0100
Message-Id: <20240815125003.21813-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 36e008323926036650299cfbb2dca704c7aba849 upstream.

The TLBI level hints are for leaf entries only, so take care not to pass
them incorrectly after clearing a table entry.

Cc: Gavin Shan <gshan@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Fixes: 82bb02445de5 ("KVM: arm64: Implement kvm_pgtable_hyp_unmap() at EL2")
Fixes: 6d9d2115c480 ("KVM: arm64: Add support for stage-2 map()/unmap() in generic page-table")
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240327124853.11206-3-will@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Cc: <stable@vger.kernel.org> # 6.1.y only
[will@: Use '0' instead of TLBI_TTL_UNKNOWN_to indicate "no level". Force
        level to 0 in stage2_put_pte() if we're clearing a table entry.]
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/pgtable.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index ae5f6b5ac80f..f0167dc7438f 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -475,7 +475,7 @@ static int hyp_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 
 		kvm_clear_pte(ptep);
 		dsb(ishst);
-		__tlbi_level(vae2is, __TLBI_VADDR(addr, 0), level);
+		__tlbi_level(vae2is, __TLBI_VADDR(addr, 0), 0);
 	} else {
 		if (end - addr < granule)
 			return -EINVAL;
@@ -699,8 +699,14 @@ static void stage2_put_pte(kvm_pte_t *ptep, struct kvm_s2_mmu *mmu, u64 addr,
 	 * Clear the existing PTE, and perform break-before-make with
 	 * TLB maintenance if it was valid.
 	 */
-	if (kvm_pte_valid(*ptep)) {
+	kvm_pte_t pte = *ptep;
+
+	if (kvm_pte_valid(pte)) {
 		kvm_clear_pte(ptep);
+
+		if (kvm_pte_table(pte, level))
+			level = 0;
+
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, addr, level);
 	}
 
-- 
2.46.0.184.g6999bdac58-goog


