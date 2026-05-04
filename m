Return-Path: <stable+bounces-243584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE4rEsus+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:27:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DDA4BF77B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E173067C44
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430593D8129;
	Mon,  4 May 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MR3+9yo+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738A315785;
	Mon,  4 May 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904260; cv=none; b=lc+y8uqOUqZz2F/cQiNxKyH//GSX2IftUd+ZKjU9sIude6ouV8urB35U4N6KpRJ62o38PgtrDenDFwid3pulfZ/Jq+leoR/EN0HkAin5qlhCrN6HQoTZBdmk8nVkfxjOsTkb3fUryBJFQnA6fFD1Wz2NjsUxlu0vifAq8ByTzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904260; c=relaxed/simple;
	bh=QIzdfI78uI3uDVWxzoWPalW8CosCrAF5i8R9HOaMVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5VnM2iSS2MNG4ZNvuu8+in2nv1GcaeIFW3cZWSb102antHivZ9kI5xjuZQFxF5OCm8Hj3Yq6KV4XeC9EhR1pVM4P2BpXoqlto+KaaABGb3SiCBdvLTH+Zpvai5dwyV0YeiA10c76jkbZ4m+WPauaryMoI/AxGYX1aE2bdzTyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MR3+9yo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC26C2BCB8;
	Mon,  4 May 2026 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904259;
	bh=QIzdfI78uI3uDVWxzoWPalW8CosCrAF5i8R9HOaMVg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MR3+9yo++EmjTqw8IZWz4QzPGiYARiydphs7yCuT4YW2PIUT27cdakTykyefAZeTk
	 dWYIUM22+hRvl7ZUy+ALIzuZM7rObl7jZMNKQcUWWifpzvrl+9w2edoLIMN51dgZ4a
	 G+fn3kYAgUM77DnjALTObt5GG7jzj9NZkG8qIXx0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
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
Subject: [PATCH 6.18 246/275] mm: prevent droppable mappings from being locked
Date: Mon,  4 May 2026 15:53:06 +0200
Message-ID: <20260504135152.177634736@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B2DDA4BF77B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243584-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
[ added const to is_vm_hugetlb_page and stubbed vma_supports_mlock in vma_internal.h instead of the split-out stubs.h ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hugetlb_inline.h   |    4 ++--
 mm/internal.h                    |   10 ++++++++++
 mm/mlock.c                       |   10 ++++++----
 mm/vma.c                         |    4 +---
 tools/testing/vma/vma_internal.h |    7 ++++++-
 5 files changed, 25 insertions(+), 10 deletions(-)

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
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1129,6 +1129,16 @@ static inline struct file *maybe_unlock_
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
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -472,10 +472,12 @@ static int mlock_fixup(struct vma_iterat
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
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2571,9 +2571,7 @@ static void __mmap_complete(struct mmap_
 
 	vm_stat_account(mm, vma->vm_flags, map->pglen);
 	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(mm))
+		if (!vma_supports_mlock(vma))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
 			mm->locked_vm += map->pglen;
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -989,7 +989,12 @@ static inline bool mapping_can_writeback
 	return true;
 }
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+static inline bool is_vm_hugetlb_page(const struct vm_area_struct *vma)
+{
+	return false;
+}
+
+static inline bool vma_supports_mlock(const struct vm_area_struct *vma)
 {
 	return false;
 }



