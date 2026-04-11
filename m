Return-Path: <stable+bounces-235769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMifLGSk2mmn4ggAu9opvQ
	(envelope-from <stable+bounces-235769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 21:43:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC043E1892
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 21:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AD61300F11A
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA23A9D96;
	Sat, 11 Apr 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IrtRUtDS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6353074A1;
	Sat, 11 Apr 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775936609; cv=none; b=I76ujGB8qYlRrS2UGSv/C6xuTBRtxsjC8MTprKzXvzFUoQeua8ts8FqQ0QMtDOEWTCijGnQ4NdUrejp3WEDtQ186a3EfkQ4kQ2PPSJC+cUKj5f1seKHkg7tI3b7n8+Llee54OGZL9N5/yPIIW+WQK8Dxt3nL0Y33UR2VZxovosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775936609; c=relaxed/simple;
	bh=eMixD/AEEMlB3xgt8qmv2OlLJOHVTXBiIgJvWAOO4o8=;
	h=Date:To:From:Subject:Message-Id; b=pj/0Ra3hfu+tm8+eSE5vHFFBApYQyHsA+GAZS1yX/FfFf47tfN8xxQRq7oOnp6GamD5k/EYz9d8rDHHeoxp8Zuobw6As/u3LhWZ54ROpp4GR80er1ulDoNH16AGVSWY0qZLE9pYqmNLr8i5PGVkmm7tO9awBuAAoegFudf7RblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IrtRUtDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEB1C2BCAF;
	Sat, 11 Apr 2026 19:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775936608;
	bh=eMixD/AEEMlB3xgt8qmv2OlLJOHVTXBiIgJvWAOO4o8=;
	h=Date:To:From:Subject:From;
	b=IrtRUtDSm18btsJdxSIjI94tmU4U8nenqZkBIEeUHghIc1yTv2i4huBhZA4dMN1AA
	 xktwYUQ63PnVmrvjKk87lswMsIp31IC4W9pE3yhtXV30J6s4OiSVqR96m5QGgAmqP+
	 zE9GJLx8oqVWnc4QXsih8eOoszSnFkzr7izBiFpQ=
Date: Sat, 11 Apr 2026 12:43:25 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,joseph.qi@linux.alibaba.com,jlbec@evilplan.org,heming.zhao@suse.com,gechangwei@live.cn,tejas.bharambe@outlook.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] ocfs2-fix-use-after-free-in-ocfs2_fault-when-vm_fault_retry.patch removed from -mm tree
Message-Id: <20260411194328.0CEB1C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235769-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,linux.alibaba.com,evilplan.org,suse.com,live.cn,outlook.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BC043E1892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
has been removed from the -mm tree.  Its filename was
     ocfs2-fix-use-after-free-in-ocfs2_fault-when-vm_fault_retry.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: Tejas Bharambe <tejas.bharambe@outlook.com>
Subject: ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
Date: Wed, 1 Apr 2026 21:02:34 -0700

filemap_fault() may drop the mmap_lock before returning VM_FAULT_RETRY,
as documented in mm/filemap.c:

  "If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
  may be dropped before doing I/O or by lock_folio_maybe_drop_mmap()."

When this happens, a concurrent munmap() can call remove_vma() and free
the vm_area_struct via RCU. The saved 'vma' pointer in ocfs2_fault() then
becomes a dangling pointer, and the subsequent trace_ocfs2_fault() call
dereferences it -- a use-after-free.

Fix this by saving the inode reference before calling filemap_fault(),
and removing vma from the trace event. The inode remains valid across
the lock drop since the file is still open, so the trace can fire in
all cases without dereferencing the potentially freed vma.

Link: https://lkml.kernel.org/r/20260403035333.136824-1-tejas.bharambe@outlook.com
Link: https://lkml.kernel.org/r/20260402040234.92432-1-tejas.bharambe@outlook.com
Signed-off-by: Tejas Bharambe <tejas.bharambe@outlook.com>
Reported-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/mmap.c        |    6 +++---
 fs/ocfs2/ocfs2_trace.h |   10 ++++------
 2 files changed, 7 insertions(+), 9 deletions(-)

--- a/fs/ocfs2/mmap.c~ocfs2-fix-use-after-free-in-ocfs2_fault-when-vm_fault_retry
+++ a/fs/ocfs2/mmap.c
@@ -30,7 +30,7 @@
 
 static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
 	sigset_t oldset;
 	vm_fault_t ret;
 
@@ -38,8 +38,8 @@ static vm_fault_t ocfs2_fault(struct vm_
 	ret = filemap_fault(vmf);
 	ocfs2_unblock_signals(&oldset);
 
-	trace_ocfs2_fault(OCFS2_I(vma->vm_file->f_mapping->host)->ip_blkno,
-			  vma, vmf->page, vmf->pgoff);
+	trace_ocfs2_fault(OCFS2_I(inode)->ip_blkno,
+			  vmf->page, vmf->pgoff);
 	return ret;
 }
 
--- a/fs/ocfs2/ocfs2_trace.h~ocfs2-fix-use-after-free-in-ocfs2_fault-when-vm_fault_retry
+++ a/fs/ocfs2/ocfs2_trace.h
@@ -1246,22 +1246,20 @@ TRACE_EVENT(ocfs2_write_end_inline,
 
 TRACE_EVENT(ocfs2_fault,
 	TP_PROTO(unsigned long long ino,
-		 void *area, void *page, unsigned long pgoff),
-	TP_ARGS(ino, area, page, pgoff),
+		 void *page, unsigned long pgoff),
+	TP_ARGS(ino, page, pgoff),
 	TP_STRUCT__entry(
 		__field(unsigned long long, ino)
-		__field(void *, area)
 		__field(void *, page)
 		__field(unsigned long, pgoff)
 	),
 	TP_fast_assign(
 		__entry->ino = ino;
-		__entry->area = area;
 		__entry->page = page;
 		__entry->pgoff = pgoff;
 	),
-	TP_printk("%llu %p %p %lu",
-		  __entry->ino, __entry->area, __entry->page, __entry->pgoff)
+	TP_printk("%llu %p %lu",
+		  __entry->ino, __entry->page, __entry->pgoff)
 );
 
 /* End of trace events for fs/ocfs2/mmap.c. */
_

Patches currently in -mm which might be from tejas.bharambe@outlook.com are



