Return-Path: <stable+bounces-238240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDS0IQlQ4Gm0egAAu9opvQ
	(envelope-from <stable+bounces-238240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 04:57:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7122F409C93
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 04:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03A66310BF31
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 02:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80436274B5F;
	Thu, 16 Apr 2026 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDwdXPvJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC81F16B
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308112; cv=none; b=RAgL3oy3U9W/a7CRwDdZPdI56uqK3XJpPzLgehGFx2OCYgmhmEnsu13lwVvsjg3K/qpPhE6TSbqSINZjzg98tUyKSkfW2FkrZAAj8i6tfJJNx0d1KpktrvRqQ91CkUfVPsvU0MpLD9cpnAWS1lko+gtc3h3C2RJcN8FtwIPZ3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308112; c=relaxed/simple;
	bh=6S7KMazqhoVy+obkuqbNC9p0hOG+SegOff4nzVs5fcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=soqZGv9jaHifwLcP4YRrtB/j+JaYFb98dAmrwcjoEwJ1K8jDKxM/Mt5fyKl/zWDlWJyVzJk7T4RWFgbVi30gWd24z+NYyddIuST+ug0naUTbfufENSi28WSjRkis5ycx9HCLKmYq6gNMktdIkVii7ocjDfTBt4mR9ORCF5Vvp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDwdXPvJ; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bd801b40dbso291664eec.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776308110; x=1776912910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QE/BJl1ZObFBbMpGLrFvgyiHLdE0hg+6Ibwj1dVcmZc=;
        b=kDwdXPvJIT9LoZ29ksYCg1r5N0yil7nW2QQcJTJKeeluX2pxxLqSHZWjChA11brgMu
         PVVc45o/rIpSOXj+ARu6ktKwmC4uXb0gNK59/G+mlR8Uv2Uc01EvgEbCVE6KI1iqKJhM
         LKfl54FcQAVzmYJi7Ndisg4tx+A557rK0Gyiqpu3Ts/NufmOsB9ztbptY9Gk1IEYxkfI
         Khqie0En/wEo0ce5tpKH5lHvTi6D6MMF1LYCp9YWxMcslLKt6A+eV0E/oGtU0akVm/rH
         C/pdrma+jbuOwMoS6m4o8Qg8qmXx0/2x/JQymJw9c3T7jc8PUsbtblh70vkKXMeVHYIJ
         zH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776308110; x=1776912910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE/BJl1ZObFBbMpGLrFvgyiHLdE0hg+6Ibwj1dVcmZc=;
        b=HobRDcXl9Czx0L3Z5ylJ9zsnPiTpPkfDRjJrdeIzTIdBl24ZcZudX+Nkiqv4Cs3ZWr
         pGSBT7uGl1mzO550IAAchM22q7ifSNu9n+GR2JJhwXu8h1DRAuLLxs42arqmvDfk5mq9
         B9rTAe5l+LofFf58jriUDlp0mOyGrkssOZL8/uMyf6bOUHXXNbcYev1nXUXy5En0+LiI
         S4aht72epLS3X2bb1JmGkCgsMwf/M3UxLlIJXQxgMKuDh+bAo/5L0awBJJO0DVv0DEPL
         erDbyPGYOpHRfneY9raEI6wSDlhci5XWXVH0a8ieo88XDL75oM1CNPUW9narEmeT/j6L
         Z4Eg==
X-Forwarded-Encrypted: i=1; AFNElJ/wK0ORzZzlK+WbV4nU5DLdLIUjx4kuxnm7aYn2kR0IG+DBGlohSgmnnvrOsWCV8SuDjLBTzAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwxi723B2H8eAxCbTsc3wl4VzME/BmvS5E0a9gpBimFgbNOdsa
	gnphou+I78siXcpTKuF19sjEsKgntx93fcxKS4czuH1lbA4YbQOo5ORO
X-Gm-Gg: AeBDiesjbEU8u+mWrTJiXMaeCqBEo6l6RyWQ714ZXhIspVji/cQh5MNR6ooKPMHnZLb
	9XIZomxr/TkJAEvMbaZCQloNuK6v9+Q5YAUke5pr842uCiRZi4TetjV+KwhoT60xOh/Jc2KapiW
	VN4XaHFAapZsOgcZEtMFANfAQSCKRoKpn+V3xbojW7VWa04n+TPBxjTydm4ca9eSbvQncFB0EsJ
	+I9TxzTER4jvDle1FnSzkUE1bGgzgdvGnxbdYo1u11neF50oaNwbGJK2PBJW2E8lx5erd38Cdio
	9tTImN9m+S4I7Q6Ttlecmz67ry/8HQzKAzfAwoc4dKYbVYboizppUPhhje2tWHJ/xFls+xsIOPp
	JEOhpCUk158y2MOa+m1Vz14JJH7NPpwsqstt6G12LvFvCTqN+Ff8xK9HOuA6LJc+6pphvB/o+2c
	QLEBtLkKOG0kCNA2WQgM2Nr6tnHPY=
X-Received: by 2002:a05:7300:134a:b0:2d9:94b4:a1bc with SMTP id 5a478bee46e88-2de7d021ec5mr1092602eec.8.1776308109369;
        Wed, 15 Apr 2026 19:55:09 -0700 (PDT)
Received: from macbookair ([2600:8802:2a09:a700::4e5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f65f9bcsm6577527eec.22.2026.04.15.19.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 19:55:08 -0700 (PDT)
From: Tejas Bharambe <thbharam@gmail.com>
X-Google-Original-From: Tejas Bharambe <tejas.bharambe@outlook.com>
To: ocfs2-devel@lists.linux.dev
Cc: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	Tejas Bharambe <tejas.bharambe@outlook.com>
Subject: [PATCH v7] ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
Date: Wed, 15 Apr 2026 19:55:01 -0700
Message-ID: <20260416025501.67593-1-tejas.bharambe@outlook.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238240-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fasheh.com,evilplan.org,linux.alibaba.com,vger.kernel.org,syzkaller.appspotmail.com,linux-foundation.org,outlook.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.994];
	FROM_NEQ_ENVFROM(0.00)[thbharam@gmail.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,a49010a0e8fcdeea075f];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:mid,outlook.com:email,syzkaller.appspot.com:url,alibaba.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 7122F409C93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tejas Bharambe <tejas.bharambe@outlook.com>

filemap_fault() may drop the mmap_lock before returning VM_FAULT_RETRY,
as documented in mm/filemap.c:

  "If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
  may be dropped before doing I/O or by lock_folio_maybe_drop_mmap()."

When this happens, a concurrent munmap() can call remove_vma() and free
the vm_area_struct via RCU. The saved 'vma' pointer in ocfs2_fault() then
becomes a dangling pointer, and the subsequent trace_ocfs2_fault() call
dereferences it -- a use-after-free.

Fix this by saving ip_blkno as a plain integer before calling
filemap_fault(), and removing vma from the trace event. Since
ip_blkno is copied by value before the lock can be dropped, it
remains valid regardless of what happens to the vma or inode
afterward.

Reported-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
Fixes: 614a9e849ca6 ("ocfs2: Remove FILE_IO from masklog.")
Cc: stable@vger.kernel.org
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Tejas Bharambe <tejas.bharambe@outlook.com>
---
 fs/ocfs2/mmap.c        |  7 +++----
 fs/ocfs2/ocfs2_trace.h | 10 ++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 50e2faf64c..6c570157ca 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -30,7 +30,8 @@
 
 static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	unsigned long long ip_blkno =
+		OCFS2_I(file_inode(vmf->vma->vm_file))->ip_blkno;
 	sigset_t oldset;
 	vm_fault_t ret;
 
@@ -38,11 +39,9 @@ static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 	ret = filemap_fault(vmf);
 	ocfs2_unblock_signals(&oldset);
 
-	trace_ocfs2_fault(OCFS2_I(vma->vm_file->f_mapping->host)->ip_blkno,
-			  vma, vmf->page, vmf->pgoff);
+	trace_ocfs2_fault(ip_blkno, vmf->page, vmf->pgoff);
 	return ret;
 }
-
 static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 			struct buffer_head *di_bh, struct folio *folio)
 {
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index 4b32fb5658..6c2c97a980 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
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
-- 
2.53.0


