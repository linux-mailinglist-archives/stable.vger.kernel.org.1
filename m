Return-Path: <stable+bounces-204314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222CCEB2DE
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 04:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D70C9300B6A0
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 03:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C032816EB42;
	Wed, 31 Dec 2025 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmShELjO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA03C0C
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767150989; cv=none; b=Df4mmmcqDU9+5H6oXBGpA2I3M7pXbMiz+Rwoz+9oKh6eZKa248C0+g6+zSjnf8cpa8ORf25Hpgd4A1nBXynisRxNPTsDpWJtnBpEOZAA3t2Qeze4iAvzAMHAjRqZXPdpMH9FVGSfmcJOfxNmvxABXuiOInM00qWjns/xQ3/blP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767150989; c=relaxed/simple;
	bh=7kDNKQPUNZQk5kzyd20Wh5NBbUzK12UE/BY9Lur5iPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBXRmHE1Tt6bPy1UAgP4JSeJ/P/xghWuzMX/EzA0ZLH4rarR+PRV60uGP0Jk7DGYAStq5fqv60Gp/8vfnpjzB0jP+IHCksCQjFedsbbpxsvPjvmwnYQAZ+VKKIK8CS6iVf23sjW/bUztmA2P4fB6G78wtt1mG2qZnfxB94W9M08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmShELjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EF8C116B1;
	Wed, 31 Dec 2025 03:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767150989;
	bh=7kDNKQPUNZQk5kzyd20Wh5NBbUzK12UE/BY9Lur5iPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmShELjOVdfvNvBBEFEcvz9IDGkl0s4AqM3FiO0OCbxrLY+egXN94TTVc9yGHE45F
	 YGCGpNGfwnulCU262e1aNO7/9K/ZparJbKK9EIAOTeUIpRdofpHCTJRSNeJP+oppLP
	 wZ+1qO9783oi02L/ClexSoNO2Utlslrv/wBFJB5KTxrsW6k3SAEceKxiPuBVSM6QX4
	 VJ7X/Z5Z5qDw1X//F1zlFsnlK0J5rz2rfl0Zh8nXqRiPc6nGI23BxU5/GJf4dQtbWD
	 USXBZ+69AbupQx6uy/IJ7QNklrd3FgTVCgRcShFmW3pCsS7elclmfzOmJAwCc5Qbrs
	 TZSuwC1i65j8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: s390: Fix gmap_helper_zap_one_page() again
Date: Tue, 30 Dec 2025 22:16:26 -0500
Message-ID: <20251231031626.2684565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122907-grant-reformist-a323@gregkh>
References: <2025122907-grant-reformist-a323@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

[ Upstream commit 2f393c228cc519ddf19b8c6c05bf15723241aa96 ]

A few checks were missing in gmap_helper_zap_one_page(), which can lead
to memory corruption in the guest under specific circumstances.

Add the missing checks.

Fixes: 5deafa27d9ae ("KVM: s390: Fix to clear PTE when discarding a swapped page")
Cc: stable@vger.kernel.org
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
[ adapted ptep_zap_softleaf_entry() and softleaf_from_pte() calls to ptep_zap_swap_entry() and pte_to_swp_entry() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/gmap_helpers.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index d4c3c36855e2..38a2d82cd88a 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -47,6 +47,7 @@ static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
 void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 {
 	struct vm_area_struct *vma;
+	unsigned long pgstev;
 	spinlock_t *ptl;
 	pgste_t pgste;
 	pte_t *ptep;
@@ -65,9 +66,13 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 	if (pte_swap(*ptep)) {
 		preempt_disable();
 		pgste = pgste_get_lock(ptep);
+		pgstev = pgste_val(pgste);
 
-		ptep_zap_swap_entry(mm, pte_to_swp_entry(*ptep));
-		pte_clear(mm, vmaddr, ptep);
+		if ((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED ||
+		    (pgstev & _PGSTE_GPS_ZERO)) {
+			ptep_zap_swap_entry(mm, pte_to_swp_entry(*ptep));
+			pte_clear(mm, vmaddr, ptep);
+		}
 
 		pgste_set_unlock(ptep, pgste);
 		preempt_enable();
-- 
2.51.0


