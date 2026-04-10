Return-Path: <stable+bounces-235582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EYQHU6w2GljgwgAu9opvQ
	(envelope-from <stable+bounces-235582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:09:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D103D3C92
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D78304481D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F170133A9F8;
	Fri, 10 Apr 2026 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l17osc7p"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47A32FA18
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808297; cv=none; b=PdaY2GKCqwCMEvueni4vf/dMdb36ir8SMD7enPtcdk4L0AR+BHVkCYGVKWJGeK6n2Rn9TOMov4mhDGFQ/oL0FU5z3bnTwwo2UzB+a4P5emL0mFYikvxBY8VS0eEdyBA8ggRAYM6xknr2mbfwRB5j+hARse7ChXEb3lMx6wz3lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808297; c=relaxed/simple;
	bh=2vzGcnNhpiIAONLC17Hy6GpLRRZRjPyICSrVDETbAEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DIVux2KC+hocTq8v0JioANlNXLQ99PWIMyTo1tMpD+ZNEvCQ++L05XTmJ8F/CGGmIoPj8SUBvbyhCCNeobGwqpgN29F3qnDu6B9BZlE7pYJ0dhMcP3U7tFQvPzPZ/o7loii/eM5sR+Zyx6YvLJcpRzAH6HpcFxhp2G0Ax+pFRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l17osc7p; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1273c690e5bso693095c88.2
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808296; x=1776413096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGYShwk/FAKXSlmM6Pq7ffufoxw0zBbsv7DQNDGdeZ4=;
        b=l17osc7pt4ADANrfkSTQD8KbZulaVpcBgoj7ExxShOHTSE37wxybdZG89RAB/95RP/
         Oq8tmKObfMElqafGDNcgQM4MrVrhIiARTTW6g1wJUgXvBqU4iMaRt+YaQmTQqQ3UZID+
         Ar2DX1Eqeui2iE52GE95bexqNB49g7MFzd202Tha6NfkqhtectiD5qVgSOphfY8SE2dl
         lQaWRq/4GxhFa8h893tuu8ZiPuKpCRf4lpdqhXMY/LXX9UJ4gHhQPcqSiSO5z5ZrHc5/
         p5/jfF3g/4UyR4OsDif3gBtQqAgeAkPjRYP11dQLIXT0h1wx7DD3VhdS4/oTHKauqF0S
         2+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808296; x=1776413096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGYShwk/FAKXSlmM6Pq7ffufoxw0zBbsv7DQNDGdeZ4=;
        b=XoOlJnbQP+5ghQxi8W9QN2wTujftT3zUhwItindcPilQZ8mva1NdNy8UzgElFBYHzD
         RIqx8f2pV5sgq55Lfmnv84AgaO1uj+RVRMtDjd7dLLtxdxDIb3jqC/iP3yHdht6rhTk9
         X8LO4mDobTj9ftkg6OUeq/ohBmwmC8XT9C1N0Wqwo8NILa88/gq5HEpaDgo/vYY0yIEr
         Uzj3ce+ZIv7sySiWGNJfyvpfSJHePzhnnLx1TPKtdKU7gGtTUSAIb4gKkMfcX7nQ686X
         J2+Iy6k1O0CCnl+ODr8VjNCJFsAqBN9DRI3gYlmfWf+qZtKeSqYsn6Ip8yHRoMi7Ec6o
         lfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMBz2fWbnI/G6tumiitcbd0MwPUqrAtDHE7Yvedc0+OtB7A/qLrON24yxjhAS8toUcDxvJv/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1D0As0GzdeeSO1r4xWf3ufQHTL0MExsIsva2OZhyqvFyw+aRo
	c8rpLpu2YqAeU9PVT9V0Eat5S2lSbFD4hFXd4Stzb1jl1Ubb4F3STzH+
X-Gm-Gg: AeBDieujzwNSt6DU6HSMOW61oVzi2ymgP2gU3gPCLwwisl2c96hqJReBJAnqGqgosAT
	CXvsuU3g62srwBleAtj+PLFGPYTPiEXXJ2gHJsnUUrN+65SL52Xm6nrILMkV5Tw8MzXeyXtNLlo
	qQVTwhI4tkmAUMpoPI5JecvE3FXYRzjcGKMqt0FFW+lanShE8xKwrTg1WWXheUgUoM4Gz0ews4q
	2zcmOjIuaV5om1b1BWPn3/iHJ7+22cSi/8En03OV9aVxmkvaH/gsK4zWASrDy1x8tTMB8312NyO
	jGRcp0wyy5Ylfi4yTRxPReB9B1sIu3N7YdA9U74qgPB1jd6D2h10k4sBxm2YZzd9TX5ausnDTIZ
	zh/gdHeqcqlRhovI84BhImb5EhTw5fwb6UJrJ82PLwgudU5Ccv8qxv+1iUM9YxXyRVRacYmPeH5
	BNKWptIKXGTCKUGZUg
X-Received: by 2002:a05:7300:a984:b0:2c0:c55c:156f with SMTP id 5a478bee46e88-2d5c39f4a6bmr345876eec.4.1775808295434;
        Fri, 10 Apr 2026 01:04:55 -0700 (PDT)
Received: from macbookair ([2600:8802:2a09:a700::2791])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ff826dcsm3103870eec.13.2026.04.10.01.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:04:54 -0700 (PDT)
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
Subject: [PATCH v5] ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
Date: Fri, 10 Apr 2026 01:04:45 -0700
Message-ID: <20260410080445.29422-1-tejas.bharambe@outlook.com>
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
	TAGGED_FROM(0.00)[bounces-235582-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,outlook.com:email,outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,alibaba.com:email]
X-Rspamd-Queue-Id: C6D103D3C92
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


