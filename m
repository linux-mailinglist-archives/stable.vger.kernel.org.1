Return-Path: <stable+bounces-195374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C03C75BD8
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 94BDA2CD2E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437136D4E3;
	Thu, 20 Nov 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9G8BO3r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866336D516
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660195; cv=none; b=HTPpE5LzTkjfT4ZBzrBHdDNDI7NFAF5O2S3wFHmSAWk6D+m617tH5EFZV1iK54sbvZWxjt73nvY3q68lCgdqBcwBgb9K3V0taWPWE3UX+v25sm4Lv747akMdfOMwDK/3OeDPqSpdim8vONzx2DG6gaklKIBtV/aeDsTFVhXj8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660195; c=relaxed/simple;
	bh=JfPiFVHAEhbQfv6rpO5sgD4K1E79ZEaswA9lSxa88YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMP9oXyMt/lJc9mx14dKl0a/byBeSJXuWrg+0i79O7cqd0pngCurPzeH+a4rKiK8I94Hd48nycqNSWDxSFAv31DA4T1Yjh5bayc2LL9pHZGb63+lviP6S5JZWEVWCUsbN7nGCZ/ciR6VySwEyWaBBuKyoHfC9Aq8+EF/U3Pins8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9G8BO3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE62C116D0;
	Thu, 20 Nov 2025 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763660194;
	bh=JfPiFVHAEhbQfv6rpO5sgD4K1E79ZEaswA9lSxa88YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9G8BO3raEfmn5Y0m+IabSQd5+cE/pAz35Bu6M/EGdBRFEu+57HteeP6anvMMb0Kg
	 as54XvzXzAwV9ppSkOUt2jgnm1qhoy3o8izysFP6JuTeIdZ4d82OArfe1qx0hTLri1
	 A+6ZJYr1jidx35p3gqbmQxfPPQFhuvt9WA+4EbULr0YcC4B0brtU6dRyAuCML6+r+7
	 LiT2kv6K0Wsj44dTpsluykTMF9Qm2j4gcTfU7f85t3TqORnAq51ACjiobAuNPZmqI+
	 lf0lXKuXBIg0QPGU3udqIR6fsTAlx+ZUunZhTgUAq+sKdTbeRIS2XiplhblwIMmy70
	 oc8Vf+bNwLuvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yan Zhao <yan.y.zhao@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] KVM: guest_memfd: Remove RCU-protected attribute from slot->gmem.file
Date: Thu, 20 Nov 2025 12:36:30 -0500
Message-ID: <20251120173631.1905381-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120173631.1905381-1-sashal@kernel.org>
References: <2025112009-getaway-overplay-a36a@gregkh>
 <20251120173631.1905381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yan Zhao <yan.y.zhao@intel.com>

[ Upstream commit 67b43038ce14d6b0673bdffb2052d879065c94ae ]

Remove the RCU-protected attribute from slot->gmem.file. No need to use RCU
primitives rcu_assign_pointer()/synchronize_rcu() to update this pointer.

- slot->gmem.file is updated in 3 places:
  kvm_gmem_bind(), kvm_gmem_unbind(), kvm_gmem_release().
  All of them are protected by kvm->slots_lock.

- slot->gmem.file is read in 2 paths:
  (1) kvm_gmem_populate
        kvm_gmem_get_file
        __kvm_gmem_get_pfn

  (2) kvm_gmem_get_pfn
         kvm_gmem_get_file
         __kvm_gmem_get_pfn

  Path (1) kvm_gmem_populate() requires holding kvm->slots_lock, so
  slot->gmem.file is protected by the kvm->slots_lock in this path.

  Path (2) kvm_gmem_get_pfn() does not require holding kvm->slots_lock.
  However, it's also not guarded by rcu_read_lock() and rcu_read_unlock().
  So synchronize_rcu() in kvm_gmem_unbind()/kvm_gmem_release() actually
  will not wait for the readers in kvm_gmem_get_pfn() due to lack of RCU
  read-side critical section.

  The path (2) kvm_gmem_get_pfn() is safe without RCU protection because:
  a) kvm_gmem_bind() is called on a new memslot, before the memslot is
     visible to kvm_gmem_get_pfn().
  b) kvm->srcu ensures that kvm_gmem_unbind() and freeing of a memslot
     occur after the memslot is no longer visible to kvm_gmem_get_pfn().
  c) get_file_active() ensures that kvm_gmem_get_pfn() will not access the
     stale file if kvm_gmem_release() sets it to NULL.  This is because if
     kvm_gmem_release() occurs before kvm_gmem_get_pfn(), get_file_active()
     will return NULL; if get_file_active() does not return NULL,
     kvm_gmem_release() should not occur until after kvm_gmem_get_pfn()
     releases the file reference.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20241104084303.29909-1-yan.y.zhao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kvm_host.h |  7 ++++++-
 virt/kvm/guest_memfd.c   | 34 +++++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2e836d44f7386..a2ebc37a29ff4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -608,7 +608,12 @@ struct kvm_memory_slot {
 
 #ifdef CONFIG_KVM_PRIVATE_MEM
 	struct {
-		struct file __rcu *file;
+		/*
+		 * Writes protected by kvm->slots_lock.  Acquiring a
+		 * reference via kvm_gmem_get_file() is protected by
+		 * either kvm->slots_lock or kvm->srcu.
+		 */
+		struct file *file;
 		pgoff_t pgoff;
 	} gmem;
 #endif
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 73e5db8ef1611..343ed456b89b0 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -261,15 +261,19 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	 * dereferencing the slot for existing bindings needs to be protected
 	 * against memslot updates, specifically so that unbind doesn't race
 	 * and free the memslot (kvm_gmem_get_file() will return NULL).
+	 *
+	 * Since .release is called only when the reference count is zero,
+	 * after which file_ref_get() and get_file_active() fail,
+	 * kvm_gmem_get_pfn() cannot be using the file concurrently.
+	 * file_ref_put() provides a full barrier, and get_file_active() the
+	 * matching acquire barrier.
 	 */
 	mutex_lock(&kvm->slots_lock);
 
 	filemap_invalidate_lock(inode->i_mapping);
 
 	xa_for_each(&gmem->bindings, index, slot)
-		rcu_assign_pointer(slot->gmem.file, NULL);
-
-	synchronize_rcu();
+		WRITE_ONCE(slot->gmem.file, NULL);
 
 	/*
 	 * All in-flight operations are gone and new bindings can be created.
@@ -298,8 +302,7 @@ static inline struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
 	/*
 	 * Do not return slot->gmem.file if it has already been closed;
 	 * there might be some time between the last fput() and when
-	 * kvm_gmem_release() clears slot->gmem.file, and you do not
-	 * want to spin in the meanwhile.
+	 * kvm_gmem_release() clears slot->gmem.file.
 	 */
 	return get_file_active(&slot->gmem.file);
 }
@@ -510,11 +513,11 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	}
 
 	/*
-	 * No synchronize_rcu() needed, any in-flight readers are guaranteed to
-	 * be see either a NULL file or this new file, no need for them to go
-	 * away.
+	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable to change, so
+	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
+	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
 	 */
-	rcu_assign_pointer(slot->gmem.file, file);
+	WRITE_ONCE(slot->gmem.file, file);
 	slot->gmem.pgoff = start;
 
 	xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL);
@@ -550,8 +553,12 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 
 	filemap_invalidate_lock(file->f_mapping);
 	xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
-	rcu_assign_pointer(slot->gmem.file, NULL);
-	synchronize_rcu();
+
+	/*
+	 * synchronize_srcu(&kvm->srcu) ensured that kvm_gmem_get_pfn()
+	 * cannot see this memslot.
+	 */
+	WRITE_ONCE(slot->gmem.file, NULL);
 	filemap_invalidate_unlock(file->f_mapping);
 
 	fput(file);
@@ -563,11 +570,12 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 					pgoff_t index, kvm_pfn_t *pfn,
 					bool *is_prepared, int *max_order)
 {
+	struct file *gmem_file = READ_ONCE(slot->gmem.file);
 	struct kvm_gmem *gmem = file->private_data;
 	struct folio *folio;
 
-	if (file != slot->gmem.file) {
-		WARN_ON_ONCE(slot->gmem.file);
+	if (file != gmem_file) {
+		WARN_ON_ONCE(gmem_file);
 		return ERR_PTR(-EFAULT);
 	}
 
-- 
2.51.0


