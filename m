Return-Path: <stable+bounces-241812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C7XFniC8WmChQEAu9opvQ
	(envelope-from <stable+bounces-241812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:00:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 461FF48EED5
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F6330166D3
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A29A1DDC1D;
	Wed, 29 Apr 2026 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJHb1f1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD6169AD2
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435252; cv=none; b=JmXwJBn2DGCLVNxDKa+O16crvCBCksEGGaqdikpzN1mT1PYXiFIsx69U+CJSwxUQVmpAi30Go9fExGwQSlSe6BvhusPHGyooOc/EUMYpH4VrB/Chey0oP3Jt0alEOlffD39BFvweW5QWAY/LMEEfjUgDt2FTP10OPpFdXBgsWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435252; c=relaxed/simple;
	bh=Vx3l/84KLSUgSfB2eYUqxnMOVRqQuwJZr9bqN1Eazy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ea48IGokXfTmJ1lfLr2EtFfyo1sHUAeIroOiyjdGYn+37QTAmI7Ddw5Xm1kSlYNA798o05MGl9OnNi0wohKCIx4MnswLMW6YqlIZ2d+K+3vqFctMxRBcDOVvvxRdY2rqWqzYYgNjlfSODJ/wBEzEscau1a4Lar7zKZGs5aFBDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJHb1f1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EDEC19425;
	Wed, 29 Apr 2026 04:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777435251;
	bh=Vx3l/84KLSUgSfB2eYUqxnMOVRqQuwJZr9bqN1Eazy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cJHb1f1BdyPSs9UkF83xiwaJzn7aO4nnAQoGZx2G1vGdmV/Vppp61J9dzWgdVZ2/m
	 xIMM1NZYiOJx2/5y/i3JB1z//RstHxQz/YyQaOfVtLSycAif7ZT/V/lYA3WxPmUF7H
	 i+9/x4Uhct8/z501m3vi2Sj6ICsB8cJ+2AH/+zTXD8FWkzMVwrl9IDnAF70BD26opB
	 DP47k4AfkziwtRxjijv5vvhuLRBrEIqhEG88jX6Jj/ywDfhn59RLdyGEetNffow87d
	 C6UKEbdzoXKaFbhxIDOLLpSVjwQY/zQj/9XRNHRnNFWgfQzc7KTW2gp1o+9BUK95aE
	 ewEUkfJwwXweA==
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
Date: Wed, 29 Apr 2026 00:00:48 -0400
Message-ID: <20260429040048.3342222-1-sashal@kernel.org>
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
X-Rspamd-Queue-Id: 461FF48EED5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241812-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
[ applied the mmap completion hunk to __mmap_region() in mm/mmap.c instead of __mmap_complete() in mm/vma.c ]
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


