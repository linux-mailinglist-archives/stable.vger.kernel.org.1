Return-Path: <stable+bounces-241409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IrgC4+S72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:45:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B7476A1B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D3C2301D32D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7418C3D6CC1;
	Mon, 27 Apr 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aK/5Ta9W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD253D6683
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308264; cv=none; b=PiKwa8hKirRjuvIBr4X1mjGWNI53x32W7aHoRPzj7ztKnsCbX6ywbeh0gUKlu0vjynLXMHPUYV+LEanGBBgihtD6dQ+Kt96pCpEcJKc8+GtXLor7FLegOeGRkVrTB0qzcvSamjr2xRwLL3xeMRyz8u+ZCYOGL6kHXXcmeJninV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308264; c=relaxed/simple;
	bh=tTU4DVnY+/hb2cBXGp7hZOAA5UG2QN8OjU2xVuCgLIA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WWqDEvWC9zxXxgZLkYJYLf7IlLpp90rxtm8Cw/DUOdgxeokp/RwNbIXvMwqkfN/5AXf/vgtY8k/fBJTTaBoCMZjxuyOaOOVFuTdFEkudMg91nrxeQVfw6r959WdfaFVgmrnlc3Kk3NbXVyOlYmQhMhyuf6xp+KI2yuxGuGzriYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aK/5Ta9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DDFC2BCB4;
	Mon, 27 Apr 2026 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777308263;
	bh=tTU4DVnY+/hb2cBXGp7hZOAA5UG2QN8OjU2xVuCgLIA=;
	h=Subject:To:Cc:From:Date:From;
	b=aK/5Ta9Wb043GJ5t1RaAxlC8H3w52xgP2HHY1SmAzoWuIrOh4WxUPOKMvBBjhdQ+d
	 zCofhOdYiN4M7D2g5n1XOyzOJ+TTISZxfoMdv6PWmxTBu/wwuBwBbuOo+EkpeyucNu
	 ZLbR9YowjXIa2Er3zCfmQsZmqshSVLkF2lbpOHYU=
Subject: FAILED: patch "[PATCH] mm: avoid deadlock when holding rmap on mmap_prepare error" failed to apply to 7.0-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,alexander.shishkin@linux.intel.com,alexandre.torgue@foss.st.com,arnd@arndb.de,bostroesser@gmail.com,brauner@kernel.org,clemens@ladisch.de,corbet@lwn.net,david@kernel.org,decui@microsoft.com,dhowells@redhat.com,gregkh@linuxfoundation.org,haiyangz@microsoft.com,jack@suse.cz,jannh@google.com,kys@microsoft.com,liam.howlett@oracle.com,longli@microsoft.com,marc.dionne@auristor.com,martin.petersen@oracle.com,mcoquelin.stm32@gmail.com,mhocko@suse.com,miquel.raynal@bootlin.com,pfalcato@suse.de,richard@nod.at,rppt@kernel.org,ryan.roberts@arm.com,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org,vigneshr@ti.com,viro@zeniv.linux.org.uk,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 10:43:47 -0600
Message-ID: <2026042747-cardinal-pellet-094f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C03B7476A1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241409-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux-foundation.org,linux.intel.com,foss.st.com,arndb.de,gmail.com,ladisch.de,lwn.net,microsoft.com,redhat.com,linuxfoundation.org,suse.cz,google.com,oracle.com,auristor.com,suse.com,bootlin.com,suse.de,nod.at,arm.com,vger.kernel.org,ti.com,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x f96e1d5f15b7c854a6a9ec1225d68a12fe7dcda6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042747-cardinal-pellet-094f@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f96e1d5f15b7c854a6a9ec1225d68a12fe7dcda6 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Date: Fri, 20 Mar 2026 22:39:30 +0000
Subject: [PATCH] mm: avoid deadlock when holding rmap on mmap_prepare error

Commit ac0a3fc9c07d ("mm: add ability to take further action in
vm_area_desc") added the ability for drivers to instruct mm to take actions
after the .mmap_prepare callback is complete.

To make life simpler and safer, this is done before the VMA/mmap write lock
is dropped but when the VMA is completely established.

So on error, we simply munmap() the VMA.

As part of this implementation, unfortunately a horrible hack had to be
implemented to support some questionable behaviour hugetlb relies upon -
that is that the file rmap lock is held until the operation is complete.

The implementation, for convenience, did this in mmap_action_finish() so
both the VMA and mmap_prepare compatibility layer paths would have this
correctly handled.

However, it turns out there is a mistake here - the rmap lock cannot be
held on munmap, as free_pgtables() -> unlink_file_vma_batch_add() ->
unlink_file_vma_batch_process() takes the file rmap lock.

We therefore currently have a deadlock issue that might arise.

Resolve this by leaving it to callers to handle the unmap.

The compatibility layer does not support this rmap behaviour, so we simply
have it unmap on error after calling mmap_action_complete().

In the VMA implementation, we only perform the unmap after the rmap lock is
dropped.

This resolves the issue by ensuring the rmap lock is always dropped when
the unmap occurs.

Link: https://lkml.kernel.org/r/d44248be9da68258b07c2c59d4e73485ee0ca943.1774045440.git.ljs@kernel.org
Fixes: ac0a3fc9c07d ("mm: add ability to take further action in vm_area_desc")
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: David Hildenbrand <david@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Long Li <longli@microsoft.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Richard Weinberger <richard@nod.at>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/util.c b/mm/util.c
index 73c97a748d8e..a2cfa0d77c35 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1215,7 +1215,13 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 		return err;
 
 	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(vma, &desc.action);
+	err = mmap_action_complete(vma, &desc.action);
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
+
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+	}
+	return err;
 }
 EXPORT_SYMBOL(compat_vma_mmap);
 
@@ -1316,10 +1322,6 @@ static int mmap_action_finish(struct vm_area_struct *vma,
 	 * invoked if we do NOT merge, so we only clean up the VMA we created.
 	 */
 	if (err) {
-		const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-		do_munmap(current->mm, vma->vm_start, len, NULL);
-
 		if (action->error_hook) {
 			/* We may want to filter the error. */
 			err = action->error_hook(err);
diff --git a/mm/vma.c b/mm/vma.c
index 1e2996a12d7f..4095834dce09 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2735,9 +2735,9 @@ static int call_action_complete(struct mmap_state *map,
 				struct mmap_action *action,
 				struct vm_area_struct *vma)
 {
-	int ret;
+	int err;
 
-	ret = mmap_action_complete(vma, action);
+	err = mmap_action_complete(vma, action);
 
 	/* If we held the file rmap we need to release it. */
 	if (map->hold_file_rmap_lock) {
@@ -2745,7 +2745,14 @@ static int call_action_complete(struct mmap_state *map,
 
 		i_mmap_unlock_write(file->f_mapping);
 	}
-	return ret;
+
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
+
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+	}
+
+	return err;
 }
 
 static unsigned long __mmap_region(struct file *file, unsigned long addr,


