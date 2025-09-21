Return-Path: <stable+bounces-180774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF82B8DAE6
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FEE3AB25A
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA0E1853;
	Sun, 21 Sep 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zf4urH/O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29DA41
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457836; cv=none; b=rPXlexarij/q8z41vu9F/I1msMPNGZxYJAo4Sjs38ABGoggtwR3+oMhDd22e1cSKfCVXz72n9jFLzj0GPNXiE6bAE9hH36vsyZ7OT8EUdIdACNNdRvacgdMyBRq7PX9jQ7zo/CPBSkemyIxfgDS0hxBnIMYmvBMLpZTWcD7u8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457836; c=relaxed/simple;
	bh=fgkjkbApW05ncjbhRoBZuZqCPD0rruJZqlmJOGDOYbI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dhVNkalbKBCh9ky/zlpKc8jhMHtY9pV4CwcSOm6/8yTpOVWjEJdRJdfY04A5FEwYEyUgLoKwLh6W+3hL8/8HzcGDlEfgWKzenpLeHoduT/vryn7EoUSCcFEu8TLj7RGSyZibVmzOl5FBEJd2oy2LtBCdNugSrrTt0ngSyl2Lo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zf4urH/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E3FC4CEE7;
	Sun, 21 Sep 2025 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457836;
	bh=fgkjkbApW05ncjbhRoBZuZqCPD0rruJZqlmJOGDOYbI=;
	h=Subject:To:Cc:From:Date:From;
	b=Zf4urH/OIgQbAOEKcAV9xX0ZfDwaPa6W7hz/4yQ/IDE0rScBH7w2ouSyR+xuXYm6X
	 BNigAS2t7nuKGv1nLk/Uoz2iEa/nDRqWop4f8WAOjPnv/1iirZZUjCnZo8hmpIC315
	 OloG8sQhx/3R6+P0BCl5lAqvyKSLk1vMKIBOBaaA=
Subject: FAILED: patch "[PATCH] x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT" failed to apply to 6.1-stable tree
To: thomas.lendacky@amd.com,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:30:26 +0200
Message-ID: <2025092126-fabulous-despair-ac21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7f830e126dc357fc086905ce9730140fd4528d66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092126-fabulous-despair-ac21@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f830e126dc357fc086905ce9730140fd4528d66 Mon Sep 17 00:00:00 2001
From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Mon, 15 Sep 2025 11:04:12 -0500
Subject: [PATCH] x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT

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

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 02236962fdb1..465b19fd1a2d 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -562,6 +562,24 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 
 extern struct ghcb *boot_ghcb;
 
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
@@ -605,6 +623,7 @@ static inline int snp_send_guest_request(struct snp_msg_desc *mdesc,
 static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
+static inline void sev_evict_cache(void *va, int npages) {}
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
@@ -619,24 +638,6 @@ int rmp_make_shared(u64 pfn, enum pg_level level);
 void snp_leak_pages(u64 pfn, unsigned int npages);
 void kdump_sev_callback(void);
 void snp_fixup_e820_tables(void);
-
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
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_rmptable_init(void) { return -ENOSYS; }
@@ -652,7 +653,6 @@ static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
 static inline void snp_fixup_e820_tables(void) {}
-static inline void sev_evict_cache(void *va, int npages) {}
 #endif
 
 #endif


