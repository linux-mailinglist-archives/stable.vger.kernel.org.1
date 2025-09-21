Return-Path: <stable+bounces-180849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89783B8E974
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890B8189C865
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 23:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8AC72625;
	Sun, 21 Sep 2025 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnjag/Ba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D252AF03
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496682; cv=none; b=IPQbqQKBHX1Olnu2cJrpkiuYqD1wdY17RqNGnLkyevkqvOW8U6IsbKSi6IpMvhL7m9Y5BKuQo0z+DJCw1pgN32h54JihzOIeVBC7NDc+N9m3DZ9DXnDID+Tir6p6yiQyt/INrMj0P39P3oUsgCggRu4zs3EVFm7TzQYZ3xaSU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496682; c=relaxed/simple;
	bh=hbVtUmL1lchhYpPWFbVYwo+Sh+d3JJb/Ka4xxOrdLJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYtuyAbTBj3bWBl3oQitf01AHhZuDbLj4EoS4J4JndxkUmBKnhYa3BbOqLVKdGfZNUlGPFRfPrmmYJdyaBIMgBtFCb4Q21R/rgZOGhJHwfGaIECdT/ifhqPrMQk97NU101yo05T0onzMF5/kKtfXo91QNQnGldaiJzZOBBmcWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnjag/Ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14A2C4CEE7;
	Sun, 21 Sep 2025 23:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758496681;
	bh=hbVtUmL1lchhYpPWFbVYwo+Sh+d3JJb/Ka4xxOrdLJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnjag/Ba/ZLtTLrpGfp8Lbfp6ZPCbUiC+M1/uf/mXAv/1EiV6a3b++pnYcZSszC2F
	 SIbBRIAc3wkHFCri8jkqDsl7BDWR9r6cRkT5qBSDEDoqSIEOgRa8oZRbKVpmJ8zTeB
	 Ws5X4yqi5C4mSr7ZuevAzxVrTB6wAcZjCL/8BTl8jL69sVdq9hTW2OdEsdWNzwkuYz
	 n536XOtBfYalMIaTDSsu5vx5OFsy0F30Yooi4On7qViN8hsdKeL8yoKGTOZZOH4Mkn
	 p8G4wE0YFIz4xFkMp/8ZKRWBZPhr4TkOSswJZo2saHZSeh0rSyl2PYGn8HEd39rwUS
	 VruFqDxjejOoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT
Date: Sun, 21 Sep 2025 19:17:59 -0400
Message-ID: <20250921231759.3033314-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092125-resurface-hypertext-5ca5@gregkh>
References: <2025092125-resurface-hypertext-5ca5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tom Lendacky <thomas.lendacky@amd.com>

[ Upstream commit 7f830e126dc357fc086905ce9730140fd4528d66 ]

The sev_evict_cache() is guest-related code and should be guarded by
CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV.

CONFIG_AMD_MEM_ENCRYPT=y is required for a guest to run properly as an SEV-SNP
guest, but a guest kernel built with CONFIG_KVM_AMD_SEV=n would get the stub
function of sev_evict_cache() instead of the version that performs the actual
eviction. Move the function declarations under the appropriate #ifdef.

Fixes: 7b306dfa326f ("x86/sev: Evict cache lines during SNP memory validation")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@kernel.org # 6.16.x
Link: https://lore.kernel.org/r/70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com
[ Move sev_evict_cache() out of shared.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/coco/sev/shared.c | 18 ------------------
 arch/x86/include/asm/sev.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 16b799f37d6cb..75653edcc5f06 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -1243,24 +1243,6 @@ static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svs
 	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
 }
 
-static inline void sev_evict_cache(void *va, int npages)
-{
-	volatile u8 val __always_unused;
-	u8 *bytes = va;
-	int page_idx;
-
-	/*
-	 * For SEV guests, a read from the first/last cache-lines of a 4K page
-	 * using the guest key is sufficient to cause a flush of all cache-lines
-	 * associated with that 4K page without incurring all the overhead of a
-	 * full CLFLUSH sequence.
-	 */
-	for (page_idx = 0; page_idx < npages; page_idx++) {
-		val = bytes[page_idx * PAGE_SIZE];
-		val = bytes[page_idx * PAGE_SIZE + PAGE_SIZE - 1];
-	}
-}
-
 static void svsm_pval_4k_page(unsigned long paddr, bool validate)
 {
 	struct svsm_pvalidate_call *pc;
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ee34ab00a8d6d..a4dae8054fc4b 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -400,6 +400,24 @@ u64 sev_get_status(void);
 void sev_show_status(void);
 void snp_update_svsm_ca(void);
 
+static inline void sev_evict_cache(void *va, int npages)
+{
+	volatile u8 val __always_unused;
+	u8 *bytes = va;
+	int page_idx;
+
+	/*
+	 * For SEV guests, a read from the first/last cache-lines of a 4K page
+	 * using the guest key is sufficient to cause a flush of all cache-lines
+	 * associated with that 4K page without incurring all the overhead of a
+	 * full CLFLUSH sequence.
+	 */
+	for (page_idx = 0; page_idx < npages; page_idx++) {
+		val = bytes[page_idx * PAGE_SIZE];
+		val = bytes[page_idx * PAGE_SIZE + PAGE_SIZE - 1];
+	}
+}
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define snp_vmpl 0
@@ -435,6 +453,7 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
 static inline void snp_update_svsm_ca(void) { }
+static inline void sev_evict_cache(void *va, int npages) {}
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
-- 
2.51.0


