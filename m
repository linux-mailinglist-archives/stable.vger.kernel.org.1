Return-Path: <stable+bounces-241408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGOoI4mS72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:44:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0969E476A14
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0F2F301C90F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621A3D75B7;
	Mon, 27 Apr 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D9JCegrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431673D6CDD
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308261; cv=none; b=q+5dQ3cZ39K8/E9AiqO0laC5TnMC6OCXFXqgVZksT5y6oyNKH9dMq2cw4Hq1UtL8FpxKywgY4g3Oaz/+A92Tugmz7l6PcyKZ8rSp3QH4q8dtc/W030l+u2lM8jIWduvjv0CEzCs7FJD09ONuBg3gPe1q4KDqJOP35Eqtjvt8Uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308261; c=relaxed/simple;
	bh=U4Ty+ysFvMKtaOvwOGQMEbbL6RR276776/1qznXA9p4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MADQ81l5xqP7PUl4dO4WWOSTXXQHaAsDlvsMn2Cx9xJX/GKGv2Vh+bjEzKaXl+KYRdrNfMs+g+8pu4Tgd834LjmVoY8JZESgqI4yMeB+2WbWbG+fLO8eUm3W2PbOj2ezXByglcTyQK4f7GAfPL8U1OHoFawdg0w1ovtgxyIR9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D9JCegrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3D6C19425;
	Mon, 27 Apr 2026 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777308260;
	bh=U4Ty+ysFvMKtaOvwOGQMEbbL6RR276776/1qznXA9p4=;
	h=Subject:To:Cc:From:Date:From;
	b=D9JCegrAhnIRnaOyzqYhcSILs6cUnu92kQvKtLmh45mDahe1GArflxfBppX0nY6aB
	 AUV0hVRcIuMHTjtdzdme295h/C0hj3birpsIGEY7a/UlUKDPqUZRCrA/3hH9C57o+4
	 Yohesa9aJoxvigg3v6SAh6IgYdg38aGTqHzZBCWY=
Subject: FAILED: patch "[PATCH] mm: prevent droppable mappings from being locked" failed to apply to 6.12-stable tree
To: anthony.yznaga@oracle.com,akpm@linux-foundation.org,david@kernel.org,jannh@google.com,jason@zx2c4.com,liam.howlett@oracle.com,ljs@kernel.org,mhocko@suse.com,pfalcato@suse.de,rppt@kernel.org,shuah@kernel.org,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 10:43:36 -0600
Message-ID: <2026042736-vascular-rubbed-001c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0969E476A14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241408-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d239462787b072c78eb19fc1f155c3d411256282
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042736-vascular-rubbed-001c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d239462787b072c78eb19fc1f155c3d411256282 Mon Sep 17 00:00:00 2001
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Tue, 10 Mar 2026 08:58:20 -0700
Subject: [PATCH] mm: prevent droppable mappings from being locked

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

diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index 84afc3c3e2e4..565b473fd135 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -30,7 +30,7 @@ static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
 
 #endif
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+static inline bool is_vm_hugetlb_page(const struct vm_area_struct *vma)
 {
 	return is_vm_hugetlb_flags(vma->vm_flags);
 }
diff --git a/mm/internal.h b/mm/internal.h
index 4ab833b8bcdf..ebb68ad10d5c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1243,6 +1243,16 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
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
index 1a92d16f3684..fd648138bc72 100644
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
 
 	vma = vma_modify_flags(vmi, *prev, vma, start, end, &newflags);
diff --git a/mm/vma.c b/mm/vma.c
index e95fd5a5fe5c..b7055c264b5d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2589,9 +2589,7 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 
 	vm_stat_account(mm, vma->vm_flags, map->pglen);
 	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(mm))
+		if (!vma_supports_mlock(vma))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
 			mm->locked_vm += map->pglen;
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index 947a3a0c2566..416bb93f5005 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -426,3 +426,8 @@ static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 }
 
 static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
+
+static inline bool vma_supports_mlock(const struct vm_area_struct *vma)
+{
+	return false;
+}


