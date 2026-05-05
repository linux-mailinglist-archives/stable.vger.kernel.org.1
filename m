Return-Path: <stable+bounces-244131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPBiNzfl+Wn2EwMAu9opvQ
	(envelope-from <stable+bounces-244131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:40:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE264CDB89
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11B42303F096
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1EE42EEB7;
	Tue,  5 May 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzuRKsd5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295242B743
	for <stable@vger.kernel.org>; Tue,  5 May 2026 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984416; cv=none; b=GDBXjOtuRGo0FUMNGeta4i5SVO0jNGQ4BR1/cl7SipvgAu43UzAKoRMoiJDEmEOCKI22qzInuOM2t26YjvM63ygcQGmxsUGSj/R6KCDtO6yaAPB/JlBZmRr96wcMMMwPwrYC0vCeyE2zoQ6IxSDBQzVx+K9Mmct2ZgZzIQiZZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984416; c=relaxed/simple;
	bh=Z3ON3mFU82KZ4ejixTSR3VCbT6rBl8vXb8mMuYvWmVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aawpk7ZGZ4hkt833nJ9s4RQ8YJ+uzDje1pgaUGXlt1NRfhSzm+H7Blg2vD2lW4Deknwd29bEbMCA+NQqZfxghYl6eZb3FFtoPdPoTctO06QCv/Dgfhd+zqXD45IulkZ/6McPLuITph2cH8SR0kh5ZFo96L1ClAjF+S1ZUxHb36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzuRKsd5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso37106675e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777984413; x=1778589213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef0p1N+2QsEru7968/qc5yXSbaXMb/XOXU32VPi/MUM=;
        b=CzuRKsd55tn1cTm3V398v5mT3hLHBp8ptcsZMnj5ogoy0reBqTWmZnckuEIwIxo/OO
         S7aJQqNo7pyOvohxUGbLz/QwJBUcby6RbsGGXKEcEaiyvNMZZMrwaIJT/JLzrFaWFrIi
         iS+SMV1iDNyd9ynsZ++UTuF76Obh7ByaNdFoKnx/GK4Kd+PYqzMpYAMB6He+VwZkxhla
         kkKVIi/BqJWM06WONpMrloSMkO6SD9seSMznew4aJWNFs/Nhdwme9wafm2/yb61aaH2/
         7JhNlS1Sr5eJVMgGQm9RZmgC+WNJx/83PMp/hyrxbG7aFFMT3en0Hcjnz9pVK5uzTIrL
         G4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777984413; x=1778589213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ef0p1N+2QsEru7968/qc5yXSbaXMb/XOXU32VPi/MUM=;
        b=g5jfSbasajbHiVXbjWgrT7C32de19SBKIvSDu3dq9rlBiUXkVdfWAAsBFXRMaiobVa
         3A0zweuXst5xyzegjNa0o7eC+tZS0+SJrNxM4BDdHmPOALsQ19goZhMajpqM6EjrHmjm
         0H3VcpLnWiejGSGOS+2dLNMibfyqTpE7Eaa/C7HlZNNiS2ge1Krn+8M/RX3jrY24Jywu
         E4FngQrGobklzJ7u8p9dyAu5QtOaT54v8poh8f4VhxFwKSNIQyRREqJsyaq5z6+N+dg8
         BA0EgIvOJiMkeZ8KZktuIR40XU6a7LO6te7lBbdI6GlP01ubELUgNzIhvdrsNap/NKy7
         q3lA==
X-Forwarded-Encrypted: i=1; AFNElJ/9vUuW5P0CkMpK3vPR/WY8iunVGNemP2m7b3Pjs8f92CUUR46fyp8zzhlZ8Do5PkZqCVIiJXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1yOC6V3RdmsTLNWpjxjRqZxQr46BDebWkuGhExDe46puyKPl
	/cOL48l9j+ngZhumBcauMaayUXNFY7rafQyW2XcLRBV63Cf9yhQMUvc=
X-Gm-Gg: AeBDieseYsBW3eotqv88XgNhEbT7xyV/bkeNcD+gpmUGL/Yf/QV+UPLMiLsLKOZ6vD0
	AnraZs7w/BKbfWha+xkONn0DX7qqVjhQcm6vUMCXG9+p3DwcMZP2ZG8Md0l+XZeHOPSwwvCjOhM
	JVbnrxEtRLnxrkNX9d3hjyR5C2Oxg/x0dB3K4D0xAg8hSVcri9P3PHEmtjPEPe+zqdccPOSTmm6
	0TcNYeJjazDveL6U+tQvxBnnk69oBkUZbZwpyiFb3uUfUCobdE000CU5ffCOD2PiFQveFpQxw9F
	ATn7u7iEDafq0+gCFQbFGXh2ztFsRjGUydBhsUWd69Xj6X9nO2wgg1Quoz8jA7HeduR4wF0CgUc
	WAZ+mNzlZ8L05NzjsEhuFPmJlBy10Dhu5m3n0IlbVdS+10cfocuwv9YbediN78LU1miP3K8Q1Ui
	WDVDM=
X-Received: by 2002:a05:600c:a590:b0:48d:5e7:a5b4 with SMTP id 5b1f17b1804b1-48d05e7afb7mr92025535e9.23.1777984413307;
        Tue, 05 May 2026 05:33:33 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822bf3ffsm431044285e9.7.2026.05.05.05.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:33:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com,
	syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 2/2] jfs: wait for in-flight log I/O before freeing lbufs in lbmLogShutdown
Date: Tue,  5 May 2026 12:33:30 +0000
Message-ID: <20260505123330.2822833-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505123330.2822833-1-tristmd@gmail.com>
References: <20260501110236.43226-1-tristmd@gmail.com>
 <20260505123330.2822833-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECE264CDB89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244131-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,c244f4a09ca85dd2ebc1,885a4f3281b8d99c48d8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,talencesecurity.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Tristan Madani <tristan@talencesecurity.com>

lbmLogShutdown() frees log buffer (lbuf) pages and structures from
log->lbuf_free.  However, BIO completions (lbmIODone) may still be
executing in softirq context when lbmLogShutdown() runs, because
lbmIODone accesses lbuf fields (l_flag, l_log, l_freelist) before
returning the buffer to the freelist.

If lbmLogShutdown() runs concurrently with lbmIODone in-flight,
it can free an lbuf that lbmIODone is still accessing -- resulting
in a use-after-free.

Fix this by adding an atomic io_count to struct jfs_log that tracks
in-flight BIO operations.  lbmStartIO increments it before submit_bio
(or before calling lbmIODone directly for no_integrity mode), and
lbmIODone decrements it after all lbuf accesses are complete.
lbmLogShutdown waits for io_count to reach zero before freeing any
lbufs.

Reported-by: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c244f4a09ca85dd2ebc1
Reported-by: syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=885a4f3281b8d99c48d8
Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/jfs/jfs_logmgr.c | 12 ++++++++++++
 fs/jfs/jfs_logmgr.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 306165e61438c..95e95f71ec0fa 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1804,6 +1804,8 @@ static int lbmLogInit(struct jfs_log * log)
 	 * avoid deadlock here.
 	 */
 	init_waitqueue_head(&log->free_wait);
+	atomic_set(&log->io_count, 0);
+	init_waitqueue_head(&log->io_done_wait);
 
 	log->lbuf_free = NULL;
 
@@ -1855,6 +1857,9 @@ static void lbmLogShutdown(struct jfs_log * log)
 
 	jfs_info("lbmLogShutdown: log:0x%p", log);
 
+	/* Wait for all in-flight log I/O to complete */
+	wait_event(log->io_done_wait, !atomic_read(&log->io_count));
+
 	lbuf = log->lbuf_free;
 	while (lbuf) {
 		struct lbuf *next = lbuf->l_freelist;
@@ -1976,6 +1981,8 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
+
+	atomic_inc(&log->io_count);
 	/*check if journaling to disk has been disabled*/
 	if (log->no_integrity) {
 		bio->bi_iter.bi_size = 0;
@@ -2123,6 +2130,8 @@ static void lbmStartIO(struct lbuf * bp)
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
 
+	atomic_inc(&log->io_count);
+
 	/* check if journaling to disk has been disabled */
 	if (log->no_integrity) {
 		bio->bi_iter.bi_size = 0;
@@ -2299,6 +2308,9 @@ static void lbmIODone(struct bio *bio)
 out:
 	bp->l_flag |= lbmDONE;
 	LCACHE_UNLOCK(flags);
+
+	if (atomic_dec_and_test(&bp->l_log->io_count))
+		wake_up(&bp->l_log->io_done_wait);
 }
 
 int jfsIOWait(void *arg)
diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
index 09e0ef6aeccef..cbf38ed27c950 100644
--- a/fs/jfs/jfs_logmgr.h
+++ b/fs/jfs/jfs_logmgr.h
@@ -367,6 +367,8 @@ struct jfs_log {
 
 	struct lbuf *lbuf_free;	/* 4: free lbufs */
 	wait_queue_head_t free_wait;	/* 4: */
+	atomic_t io_count;		/* in-flight log I/O count */
+	wait_queue_head_t io_done_wait;	/* wait for io_count == 0 */
 
 	/* log write */
 	int logtid;		/* 4: log tid */
-- 
2.47.3


