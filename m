Return-Path: <stable+bounces-233139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH82LNs5z2lcuAYAu9opvQ
	(envelope-from <stable+bounces-233139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 05:54:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F302390BD7
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 05:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9B8302927A
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 03:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3E3093D3;
	Fri,  3 Apr 2026 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5KSiwFO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D932FA2C
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775188428; cv=none; b=Y/qasmXhyunvcVcri8QdSrCo5+88wQyEo9BIDH548AqSYS6SSyFirsJJOE4nfwfPGqevl57xo2EioR8VV2Xheglp7iiOYzqvLgl4szBY6XblCMTGMs4dVLtE7Yqjrz1uyxwjL8LybCdqzw3EwxBMAij0Fv2WU/n7ll3VHIZjiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775188428; c=relaxed/simple;
	bh=Kq6u8Iu3bu0n+bBK07KN2oI6tH3HoOhAkahw7ULZs0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8XAHGUgayc4l1u/2JZQAZpa1eMmB+mVqL5LT0dUMTww0m3ditbLiSQwrbbC+Hh9Q78zmnnnTdCQpUlhDvkO9UkC8yTD9f+hLV43pCy2wvurNN1oXBC6TeYQFXtYm6IS6fqKO4LD6MYq9EgrSTRg+34GP93f7Tm0kClRt8dYQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5KSiwFO; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bda3b4318dso120286eec.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775188426; x=1775793226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LnRELhx4WGvfyiMv9TNoo2v4m61WEl0oLbVEZ8jYJI=;
        b=q5KSiwFOQIgeei+XBj6qONsYIl072CgTjb5+uqsvBxBvPP9TGo1L9T23I3pR7WqEHR
         WbR1bqREUJTxXlKXIOqX3RnNSth8tAnZDvRAXJKNUY/b7Ahq7RRom4uSmym9l5qi9ztV
         q2aA3ZEes9aYCKbpT8jIuUFP32ly6anM3tvcOhWrLMONZcwlcur/mQNY9oyDSlKPr8PO
         NH5pMEVQDBXXKyRY3DsT959UlvFlZWqS/0WaUwPbws/aWEihhVGyn6hdk4L+wGzwYlxM
         pjbLiG2U6rUxBp7xQ1j+kL4L8feYXMpnhPkcYSxlI7CC2QKabjrg/o03/z7bbcRrKD5+
         QGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775188426; x=1775793226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LnRELhx4WGvfyiMv9TNoo2v4m61WEl0oLbVEZ8jYJI=;
        b=V81f5DJ/cmIgeuKGxnkU32PNOLNjjLe6TnkpL7onzJBLOK1eDi9s+difjaAqB1tLFT
         bHXBnKk66WkZdO4+rsjdEjTtCJ5CXV2pMBDjbdGOrEfp/psWtyTclm7W041TBzcRS5eN
         43GHVZoRTnUhiPfhHAxxi3EkvkOLjCEZxYLAGJVvsP8gBdzB+KrvhdR+4lx27avfsEr8
         VMmMhamj3LPy2GQoyogiQdg7IFpI6KrVXvT/RtXoSYghW3N1lekJnSYODy7GIJcksn6x
         A8cIY3VS7sY0bim7njBz35UzKitI1hJ8sFueR7FZJdMca9ETYzD0Vpv6wySUcexQFTHv
         6u8g==
X-Forwarded-Encrypted: i=1; AJvYcCVFD/ecg31a8QOUwhtJ3BaHqMg/Rpg8WffjuIiLz1R0MXrFRz8Uc9AXs1T6ZFcm/s9s7HpYxDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwv5FVeSNp/RhvGl0/7bbv616/ju2xs7n2bwdDuk4vEgNP1DV
	BZesKFtBtSjay0hH3j2Q1Og2GBvHY+2sgsep0fDkwi3I4DW4VZZIzE+7
X-Gm-Gg: AeBDieu6xXW94X0fUvc8noUqkgt2GmzYB5fxDpufjoKk8jtLznO9AoR3lkCDwgtPWoX
	0XqelFKeqRIAcILAaTxAVb1TrJuEBLYoNOVLG8utO5cKl/AE4XeS62R0kCIVjrk9Xcz0Rp7t+3A
	pLO+dcHcILigFIrlDpTQ0sYWokyt1kDn/+fDqO1cdg+uUURMPBLhSqzjr1U+FJyYXzbuPqvYG8u
	P8nw5/fSmOnpSMlUXr/CnS/ibckgshspFjPK9TtkFHxbUAMmUxhOQ0AGJ5g9MqyfHOLJbxrqXb4
	OagMTUjIoUMcke0xmk+terdvhjMhtz+B6FVPbr0MgDrnSPNUf4A2uLur7jAordLG3Z2Pq+15yet
	FLx19soKEs4jMOeI135vLXyNEVCKkOVC8FQsgtCVGIYFaF1PXDQpfVGXGmt1j2KsotAnbCDlyNn
	ucFZvv/8RRHk6aC+nX3A==
X-Received: by 2002:a05:7300:4347:b0:2c0:c961:4b98 with SMTP id 5a478bee46e88-2cbfc85e0eemr354507eec.7.1775188425702;
        Thu, 02 Apr 2026 20:53:45 -0700 (PDT)
Received: from macbookair ([2600:8802:2a09:a700::c877])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7caeb83dsm6587414eec.22.2026.04.02.20.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:53:45 -0700 (PDT)
From: Tejas Bharambe <thbharam@gmail.com>
X-Google-Original-From: Tejas Bharambe <tejas.bharambe@outlook.com>
To: ocfs2-devel@lists.linux.dev
Cc: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com,
	akpm@linux-foundation.org,
	Tejas Bharambe <tejas.bharambe@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
Date: Thu,  2 Apr 2026 20:53:33 -0700
Message-ID: <20260403035333.136824-1-tejas.bharambe@outlook.com>
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
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233139-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fasheh.com,evilplan.org,linux.alibaba.com,vger.kernel.org,syzkaller.appspotmail.com,linux-foundation.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thbharam@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,a49010a0e8fcdeea075f];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,appspotmail.com:email,outlook.com:email,outlook.com:mid,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 1F302390BD7
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

Fix this by saving the inode reference before calling filemap_fault(),
and removing vma from the trace event. The inode remains valid across
the lock drop since the file is still open, so the trace can fire in
all cases without dereferencing the potentially freed vma.

Reported-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
Cc: stable@vger.kernel.org
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Tejas Bharambe <tejas.bharambe@outlook.com>
---
 fs/ocfs2/mmap.c        |  6 +++---
 fs/ocfs2/ocfs2_trace.h | 10 ++++------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 50e2faf64c..41c08c5a3d 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -30,7 +30,7 @@
 
 static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
 	sigset_t oldset;
 	vm_fault_t ret;
 
@@ -38,8 +38,8 @@ static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 	ret = filemap_fault(vmf);
 	ocfs2_unblock_signals(&oldset);
 
-	trace_ocfs2_fault(OCFS2_I(vma->vm_file->f_mapping->host)->ip_blkno,
-			  vma, vmf->page, vmf->pgoff);
+	trace_ocfs2_fault(OCFS2_I(inode)->ip_blkno,
+			  vmf->page, vmf->pgoff);
 	return ret;
 }
 
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


