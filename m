Return-Path: <stable+bounces-241811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ERLL2eC8WmChQEAu9opvQ
	(envelope-from <stable+bounces-241811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:00:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E46B48EECE
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60D3C3004430
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701D2472AF;
	Wed, 29 Apr 2026 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ7EH/tB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5C1A682C
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435231; cv=none; b=BE758KdN3S/6YUZ3HUGZCL9foeWpU5odSvWEi+Gsycr8l7tQR+6C2grPjaSAMlLOOOubA04OScpN9V7YqJGzvA8ooF3UMhruAAVvaZH81+Dbt3yfrUZxbzfaPWTkaFsAR1+Yd21gfG/n6jPn0Cx7jvkxrKnKifhz5nUHJJN0X74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435231; c=relaxed/simple;
	bh=Vuxb4Z+qd6r7e+UhEv2ZRsLXmdLEkl5/lprIyIu1Szk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRHuX0GCaTIV1cPRoIOtGsXzdmpBbxL1pZfYfwC6EH2OvNrQhTi8bTIyYRZqEFeAZmdTkHRdV3sif35fqnWx/1GVSIvLRXVwuA8cm12IKovTcMCpMsBHrYKIJoAfMYyuWMDwrBcW6np5v28EFtQSisSwfahKb3EhPRdBQZ/WCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ7EH/tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26996C19425;
	Wed, 29 Apr 2026 04:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777435230;
	bh=Vuxb4Z+qd6r7e+UhEv2ZRsLXmdLEkl5/lprIyIu1Szk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZ7EH/tB6/+N6LjRKn+ykSN4ihp+JaUwTsUwuNb9Lq2mR6Dx4A3BU6tGUyW6bL/px
	 yvgLAocUQfql9RBfG/WMg8yPW3BS2p+qgqrzmwHTwT1FZCFF47QQmiYcu71EeYuxZ5
	 +RHFYRbOV5qnKJD7hSc2ltm+dK8cgvue42133NLRFAOjOdMPb+zzip4O/uDUERfM8m
	 YESjk07KhPlvoidwVAJzC5cjMZBl8KZsJ1uhJuL1GK4Wq1WJK8szRTmcMhapgd8txe
	 bZ7IUmpPgLfRvRod0Tvtsniz3pTVn5pRmT45oYTp9dxV6mBXsUZJ6sg4LDqkcahs+j
	 8+zGXDKde8Uvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Jann Horn <jannh@google.com>,
	"Jason A. Donenfeld" <jason@zx2c4.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm: prevent droppable mappings from being locked
Date: Wed, 29 Apr 2026 00:00:27 -0400
Message-ID: <20260429040027.3341979-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042736-vascular-rubbed-001c@gregkh>
References: <2026042736-vascular-rubbed-001c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E46B48EECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241811-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Anthony Yznaga <anthony.yznaga@oracle.com>

[ Upstream commit d239462787b072c78eb19fc1f155c3d411256282 ]

Droppable mappings must not be lockable.  There is a check for VMAs with
VM_DROPPABLE set in mlock_fixup() along with checks for other types of
unlockable VMAs which ensures this when calling mlock()/mlock2().

For mlockall(MCL_FUTURE), the check for unlockable VMAs is different.  In
apply_mlockall_flags(), if the flags parameter has MCL_FUTURE set, the
current task's mm's default VMA flag field mm->def_flags has VM_LOCKED
applied to it.  VM_LOCKONFAULT is also applied if MCL_ONFAULT is also set.
When these flags are set as default in this manner they are cleared in
__mmap_complete() for new mappings that do not support mlock.  A check for
VM_DROPPABLE in __mmap_complete() is missing resulting in droppable
mappings created with VM_LOCKED set.  To fix this and reduce that chance
of similar bugs in the future, introduce and use vma_supports_mlock().

Link: https://lkml.kernel.org/r/20260310155821.17869-1-anthony.yznaga@oracle.com
Fixes: 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always lazily freeable mappings")
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Tested-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted change to `mm/mmap.c::__mmap_region()` instead of `mm/vma.c::__mmap_complete()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb_inline.h |  4 ++--
 mm/internal.h                  | 10 ++++++++++
 mm/mlock.c                     | 10 ++++++----
 mm/mmap.c                      |  4 +---
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index 0660a03d37d98..846185ea626c7 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -6,14 +6,14 @@
 
 #include <linux/mm.h>
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+static inline bool is_vm_hugetlb_page(const struct vm_area_struct *vma)
 {
 	return !!(vma->vm_flags & VM_HUGETLB);
 }
 
 #else
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+static inline bool is_vm_hugetlb_page(const struct vm_area_struct *vma)
 {
 	return false;
 }
diff --git a/mm/internal.h b/mm/internal.h
index b7b942767c702..3bfc1dc2d7eaf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1015,6 +1015,16 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 	}
 	return fpin;
 }
+
+static inline bool vma_supports_mlock(const struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & (VM_SPECIAL | VM_DROPPABLE))
+		return false;
+	if (vma_is_dax(vma) || is_vm_hugetlb_page(vma))
+		return false;
+	return vma != get_gate_vma(current->mm);
+}
+
 #else /* !CONFIG_MMU */
 static inline void unmap_mapping_folio(struct folio *folio) { }
 static inline void mlock_new_folio(struct folio *folio) { }
diff --git a/mm/mlock.c b/mm/mlock.c
index 8c8d522efdd59..d16bf4dbd06dd 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -472,10 +472,12 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	int ret = 0;
 	vm_flags_t oldflags = vma->vm_flags;
 
-	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
-	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
-	    vma_is_dax(vma) || vma_is_secretmem(vma) || (oldflags & VM_DROPPABLE))
-		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
+	if (newflags == oldflags || vma_is_secretmem(vma) ||
+	    !vma_supports_mlock(vma))
+		/*
+		 * Don't set VM_LOCKED or VM_LOCKONFAULT and don't count.
+		 * For secretmem, don't allow the memory to be unlocked.
+		 */
 		goto out;
 
 	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
diff --git a/mm/mmap.c b/mm/mmap.c
index 6183805f6f9e6..d361b1058da10 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1547,9 +1547,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	vm_stat_account(mm, vm_flags, pglen);
 	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(current->mm))
+		if (!vma_supports_mlock(vma))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
 			mm->locked_vm += pglen;
-- 
2.53.0


