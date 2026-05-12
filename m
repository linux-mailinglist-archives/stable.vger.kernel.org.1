Return-Path: <stable+bounces-245580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJKOFNwxA2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:57:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC85521CC1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3878B30C4191
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307223A48CB;
	Tue, 12 May 2026 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MKK5Yk2i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3070306774
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591876; cv=none; b=FcTzlrlqDVEk80ZwmX90IR2tEll3OFEIXFsLHrIfhspvwfXE7ao1vF4QRtRycoiC+VH1Sxjk2bBGHLolvmySgvyl0ZKZIFY9Gats9BhRqO0hSIrxuRX1sYGbsrQrocH7j46olRQUhrnxUmvgSp+0XppnHcI3WQjENSwBhzrv+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591876; c=relaxed/simple;
	bh=DC8vFnb+5oTYl7cIHM1JED/9EJ6C9VVGRuK+hQRAu1w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Oif4ivxEknONPwa9gRp8BiZxw/uU23TQ+dUxktbzXH/ZvCdD6vz0+mMfLGsLY87XBBrXAW84Deg+4wjBZdkCv1oZ5IHQmzo9LyxF0UUU5Zq5rz+ewWaY4TMhk124AJK+hjeAulNKdBqhMBcIrKVTK5EUr2xeIoDNIDnHfUcHkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MKK5Yk2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29005C2BCB0;
	Tue, 12 May 2026 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778591875;
	bh=DC8vFnb+5oTYl7cIHM1JED/9EJ6C9VVGRuK+hQRAu1w=;
	h=Subject:To:Cc:From:Date:From;
	b=MKK5Yk2iX7EblUYmiTf++5IAHijx84qk3x4Y6Lye/evC3fOIGl1TD8BM+heJ5YeIZ
	 5PDeUssrGIB0QKTy7mC1DXORmACijboceJTyncqz7XxkVspT8dujENYPOZHrksu738
	 nI18gmWfCIyXeTsWhVhz0ugB/PBIpqgY3XGW5w4I=
Subject: FAILED: patch "[PATCH] mm/vma: do not try to unmap a VMA if mmap_prepare() invoked" failed to apply to 7.0-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,david@kernel.org,jannh@google.com,liam.howlett@oracle.com,mhocko@suse.com,pfalcato@suse.de,rppt@kernel.org,stable@vger.kernel.org,surenb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:17:52 +0200
Message-ID: <2026051252-diabetic-cognition-76a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5CC85521CC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245580-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,suse.com:email,linux-foundation.org:email,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 619eab23e1ce7c97e54bfc5a417306d94b3f6f13
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051252-diabetic-cognition-76a6@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 619eab23e1ce7c97e54bfc5a417306d94b3f6f13 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Tue, 21 Apr 2026 11:21:50 +0100
Subject: [PATCH] mm/vma: do not try to unmap a VMA if mmap_prepare() invoked
 from mmap()

The mmap_prepare hook functionality includes the ability to invoke
mmap_prepare() from the mmap() hook of existing 'stacked' drivers, that is
ones which are capable of calling the mmap hooks of other drivers/file
systems (e.g.  overlayfs, shm).

As part of the mmap_prepare action functionality, we deal with errors by
unmapping the VMA should one arise.  This works in the usual mmap_prepare
case, as we invoke this action at the last moment, when the VMA is
established in the maple tree.

However, the mmap() hook passes a not-fully-established VMA pointer to the
caller (which is the motivation behind the mmap_prepare() work), which is
detached.

So attempting to unmap a VMA in this state will be problematic, with the
most obvious symptom being a warning in vma_mark_detached(), because the
VMA is already detached.

It's also unncessary - the mmap() handler will clean up the VMA on error.

So to fix this issue, this patch propagates whether or not an mmap action
is being completed via the compatibility layer or directly.

If the former, then we do not attempt VMA cleanup, if the latter, then we
do.

This patch also updates the userland VMA tests to reflect the change.

Link: https://lore.kernel.org/20260421102150.189982-1-ljs@kernel.org
Fixes: ac0a3fc9c07d ("mm: add ability to take further action in vm_area_desc")
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
Reported-by: syzbot+db390288d141a1dccf96@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e69734.050a0220.24bfd3.0027.GAE@google.com/
Cc: David Hildenbrand <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0b776907152e..af23453e9dbd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4391,7 +4391,7 @@ static inline void mmap_action_map_kernel_pages_full(struct vm_area_desc *desc,
 
 int mmap_action_prepare(struct vm_area_desc *desc);
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action);
+			 struct mmap_action *action, bool is_compat);
 
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
diff --git a/mm/util.c b/mm/util.c
index 232c3930a662..3cc949a0b7ed 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1232,7 +1232,7 @@ int __compat_vma_mmap(struct vm_area_desc *desc,
 	/* Update the VMA from the descriptor. */
 	compat_set_vma_from_desc(vma, desc);
 	/* Complete any specified mmap actions. */
-	return mmap_action_complete(vma, &desc->action);
+	return mmap_action_complete(vma, &desc->action, /*is_compat=*/true);
 }
 EXPORT_SYMBOL(__compat_vma_mmap);
 
@@ -1389,7 +1389,8 @@ static int call_vma_mapped(struct vm_area_struct *vma)
 }
 
 static int mmap_action_finish(struct vm_area_struct *vma,
-			      struct mmap_action *action, int err)
+			      struct mmap_action *action, int err,
+			      bool is_compat)
 {
 	size_t len;
 
@@ -1400,8 +1401,12 @@ static int mmap_action_finish(struct vm_area_struct *vma,
 
 	/* do_munmap() might take rmap lock, so release if held. */
 	maybe_rmap_unlock_action(vma, action);
-	if (!err)
-		return 0;
+	/*
+	 * If this is invoked from the compatibility layer, post-mmap() hook
+	 * logic will handle cleanup for us.
+	 */
+	if (!err || is_compat)
+		return err;
 
 	/*
 	 * If an error occurs, unmap the VMA altogether and return an error. We
@@ -1451,13 +1456,15 @@ EXPORT_SYMBOL(mmap_action_prepare);
  * mmap_action_complete - Execute VMA descriptor action.
  * @vma: The VMA to perform the action upon.
  * @action: The action to perform.
+ * @is_compat: Is this being invoked from the compatibility layer?
  *
  * Similar to mmap_action_prepare().
  *
- * Return: 0 on success, or error, at which point the VMA will be unmapped.
+ * Return: 0 on success, or error, at which point the VMA will be unmapped if
+ * !@is_compat.
  */
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action)
+			 struct mmap_action *action, bool is_compat)
 {
 	int err = 0;
 
@@ -1478,7 +1485,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 		break;
 	}
 
-	return mmap_action_finish(vma, action, err);
+	return mmap_action_finish(vma, action, err, is_compat);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #else
@@ -1500,7 +1507,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
 EXPORT_SYMBOL(mmap_action_prepare);
 
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action)
+			 struct mmap_action *action,
+			 bool is_compat)
 {
 	int err = 0;
 
@@ -1517,7 +1525,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 		break;
 	}
 
-	return mmap_action_finish(vma, action, err);
+	return mmap_action_finish(vma, action, err, is_compat);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #endif
diff --git a/mm/vma.c b/mm/vma.c
index 377321b48734..d90791b00a7b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2780,7 +2780,8 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	__mmap_complete(&map, vma);
 
 	if (have_mmap_prepare && allocated_new) {
-		error = mmap_action_complete(vma, &desc.action);
+		error = mmap_action_complete(vma, &desc.action,
+					     /*is_compat=*/false);
 		if (error)
 			return error;
 	}
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index b4864aad2db0..9e0dfd3a85b0 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1330,7 +1330,7 @@ static inline int __compat_vma_mmap(struct vm_area_desc *desc,
 	/* Update the VMA from the descriptor. */
 	compat_set_vma_from_desc(vma, desc);
 	/* Complete any specified mmap actions. */
-	return mmap_action_complete(vma, &desc->action);
+	return mmap_action_complete(vma, &desc->action, /*is_compat=*/true);
 }
 
 static inline int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index a30b8bc84955..64164e25658f 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -87,7 +87,8 @@ static inline int mmap_action_prepare(struct vm_area_desc *desc)
 }
 
 static inline int mmap_action_complete(struct vm_area_struct *vma,
-				       struct mmap_action *action)
+				       struct mmap_action *action,
+				       bool is_compat)
 {
 	return 0;
 }


