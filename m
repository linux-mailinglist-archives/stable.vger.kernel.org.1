Return-Path: <stable+bounces-242297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKLyMrGI9GnFCAIAu9opvQ
	(envelope-from <stable+bounces-242297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:04:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE64ABDC2
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBEC43051D8F
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142D2396B76;
	Fri,  1 May 2026 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFmFksQA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198839C65C
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633361; cv=none; b=eQBX8kW4KiCbloAhdKp2++EGigZsm/Oud5JjU2w4IySNTa0uDYT4t8VyK1fOWMc4dd9L3DNk116Jh5+lpI3ZKvWSKbheW31eWlfM/Gr9ooSn48CkyGqsAOijIrQpCJqg1iEVZnkYOTgodi5dZ7pTqVcoj8qHuiqc3kXjiMqnL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633361; c=relaxed/simple;
	bh=F8u6jKI7D27MbEeW5xGCVvTgUbqVVT1yLqWITRrJmYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRoRtiOen0+AxvS9iZ9zAHeQx1Tqmq2g0acnhs/7Y7LuevGZ4Rechx0ONdKO5oGWGjk/Ziidg6DWzNnfvA091m3Xkzj4vZ5EIzuzRywPXFdOsmeLyVbaMfXF5G/YSGC/dIYb9H1SGoSneLHUTRTKwWJSiiyWjTsEpH+GBzbsLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFmFksQA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso9768905e9.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633358; x=1778238158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6/GzFE2IPmBpClk7dJcDRUbOhvrcqXJNzoTjRHtmKk=;
        b=iFmFksQAA32GWUi/6O2vlYiSIxzB9ORFvSCaTeB242v23WdnNpS54Xc6lKHnqtOxG/
         7I6gev/qCo33lZowOx9wgR3SfOt+CTJOgg/XDKiwx/2mR26aMfHg4zHZos05Csen4aHj
         qy87hrIUMDPd8bvJtWSVY9Rnv9tyISE6isq3oG8jyq7Z7zyiisF+ccAWPUIDjQK2gVt5
         g0tFrvTTDsh2wFy3YxzIAvjk4BX9i3zwesiv1G7K4gqdsZSXav8uJhpL2hJ5yWoywx4K
         aEPRFZ+0SphH/IRSrLnLztp0kZoQ9rYIQx3Zw9gyNvkJRHzJUbvC2tpaSesPM305PlJR
         sPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633358; x=1778238158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6/GzFE2IPmBpClk7dJcDRUbOhvrcqXJNzoTjRHtmKk=;
        b=Yq1QWGairU5L7dYQJ5w6OkO9nPtVTshLHZhPTEmH4k7x8dFMYiXvUxaNSYeS68cHVA
         IU9K4FdrCleXp0tTYsS32fN+cItEBa5J9DqXoz8Yi6fE4y1edmhUxjlAT8fMOm9a3E7K
         tss3yTJY8n3mMOWFP+tK+YuTIzctt6DZeY6q5AYfVzh8qYMygMoccWqb54atuXQS55Ep
         HBptU6IxpjjzczjkztkbJuODM3FDnqtIbKySE7kWhdECinH0TG7FnO1hf+2FflRzgLBd
         jl2Gr3/iSZ2L3J60dnw4omw734utztIX9pwgM8aX4uLMlnOETCEGyCxEmuXiE6PiuGLN
         qOFA==
X-Forwarded-Encrypted: i=1; AFNElJ9nNQRVkgRS13Ll/r76tgeQGqpauuxs/V9WAfpNEFBTCkJRDMffwIwr4e9tbQyfsq1vkxpiloI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywna0NlV34MlFGQavkI7+KQ1sZmX63522nb6dElafJaoLC2moCq
	nC2lY5UHuUTX55DWj6Lof68kbhBOVitHOZb+uthuyD5s89KDcpSx2vM=
X-Gm-Gg: AeBDiev3NxkjE/T0Rfdl8Pr+Mku+sXtu8zwpzwKsot438FQXnb9PmG83v9USwGxM2sO
	FYXbFusNfSDqhNeey7QPQxtBXO6rtvfhtPAOPHzaRiYSad0WdPlI9ZAiD4VV+mniJemVUQMWurB
	sAbx9Mxy9mUct+B69qBBAeyUDPixtz970MfqsLMrv5HTbE6EzDSyZwl34fabk1FCCqRWsTK1qMw
	pKkbbQUjlpfhW5ZlkQUlBS+NswaMtrsMndj0yZv3T5c1LI8wt77yu+NgSU3bBEGNnFeK2t4XnQ6
	L4T0EvDK5D056jDtEz8SVB0JVyPfPWGdkm1X6nYNpMpCjOWw6QSWp4AgDbkhH6g4WmYo+C8CprO
	aKdOWclonyGDhKI92+tmyTiNFipgHPaVXwPr4WBH80FcNfljAMeHxV4oLt+TKkUW7fVaICEv+g+
	of6Hg=
X-Received: by 2002:a05:600c:c0c2:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48a83d09d5dmr77193445e9.0.1777633358043;
        Fri, 01 May 2026 04:02:38 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef1db8sm10780005e9.29.2026.05.01.04.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:37 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com,
	syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com
Subject: [PATCH] jfs: drain lazy commit queue during unmount to prevent use-after-free
Date: Fri,  1 May 2026 11:02:36 +0000
Message-ID: <20260501110236.43226-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78EE64ABDC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242297-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,c244f4a09ca85dd2ebc1,885a4f3281b8d99c48d8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]

From: Tristan Madani <tristan@talencesecurity.com>

The jfsCommit kernel thread processes committed transactions from
TxAnchor.unlock_queue via jfs_lazycommit().  During filesystem
unmount, jfs_umount() calls jfs_flush_journal(log, 2) which waits
for the log commit queue (log->cqueue) to drain.  However, after
log I/O completes, lazy transactions are moved to
TxAnchor.unlock_queue for asynchronous processing by jfsCommit.

If jfs_umount() proceeds to free the jfs_log (via lmLogClose) or
jfs_sb_info (via kfree in jfs_put_super) while entries referencing
this superblock remain on unlock_queue, the jfsCommit thread will
access freed memory when it later processes these entries:

- jfs_lazycommit reads sbi->commit_state (UAF of jfs_sb_info)
- txLazyCommit accesses JFS_SBI(tblk->sb)->log and takes
  log->gclock (UAF of jfs_log)

Add txLazyDrain() which waits for all entries in
TxAnchor.unlock_queue belonging to the unmounting superblock to be
processed, and also waits for any in-flight txLazyCommit
(IN_LAZYCOMMIT) for this superblock to complete.  Call it from both
jfs_umount() and jfs_umount_rw() after jfs_flush_journal().

Reported-by: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c244f4a09ca85dd2ebc1
Tested-by: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com
Reported-by: syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=885a4f3281b8d99c48d8
Tested-by: syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com
Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/jfs/jfs_txnmgr.c | 35 +++++++++++++++++++++++++++++++++++
 fs/jfs/jfs_txnmgr.h |  1 +
 fs/jfs/jfs_umount.c |  8 ++++++++
 3 files changed, 44 insertions(+)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 083dbbb0c3268..67a9908b5a4d9 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2791,6 +2791,41 @@ void txLazyUnlock(struct tblock * tblk)
 	LAZY_UNLOCK(flags);
 }
 
+
+/*
+ * txLazyDrain
+ *
+ * Wait for all pending lazy commit entries for this superblock
+ * to be processed by the jfsCommit thread.  Must be called
+ * before freeing per-filesystem structures during unmount.
+ */
+void txLazyDrain(struct super_block *sb)
+{
+	struct jfs_sb_info *sbi = JFS_SBI(sb);
+	struct tblock *tblk;
+	unsigned long flags;
+	bool found;
+
+	do {
+		found = false;
+		LAZY_LOCK(flags);
+		list_for_each_entry(tblk, &TxAnchor.unlock_queue, cqueue) {
+			if (tblk->sb == sb) {
+				found = true;
+				break;
+			}
+		}
+		if (!found && (sbi->commit_state & IN_LAZYCOMMIT))
+			found = true;
+		LAZY_UNLOCK(flags);
+
+		if (found) {
+			wake_up(&jfs_commit_thread_wait);
+			schedule_timeout_uninterruptible(1);
+		}
+	} while (found);
+}
+
 static void LogSyncRelease(struct metapage * mp)
 {
 	struct jfs_log *log = mp->log;
diff --git a/fs/jfs/jfs_txnmgr.h b/fs/jfs/jfs_txnmgr.h
index ba71eb5ced567..fbbaed26c52bd 100644
--- a/fs/jfs/jfs_txnmgr.h
+++ b/fs/jfs/jfs_txnmgr.h
@@ -291,6 +291,7 @@ extern void txFreelock(struct inode *);
 extern int lmLog(struct jfs_log *, struct tblock *, struct lrd *,
 		 struct tlock *);
 extern void txQuiesce(struct super_block *);
+extern void txLazyDrain(struct super_block *sb);
 extern void txResume(struct super_block *);
 extern void txLazyUnlock(struct tblock *);
 extern int jfs_lazycommit(void *);
diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
index 18569f1eaabdb..657707361be2a 100644
--- a/fs/jfs/jfs_umount.c
+++ b/fs/jfs/jfs_umount.c
@@ -58,6 +58,13 @@ int jfs_umount(struct super_block *sb)
 		 */
 		jfs_flush_journal(log, 2);
 
+	/*
+	 * Drain any pending lazy commit entries for this filesystem so
+	 * the jfsCommit thread does not access freed structures.
+	 */
+	if (log)
+		txLazyDrain(sb);
+
 	/*
 	 * Hold log lock so write_special_inodes (lmLogSync) cannot see
 	 * this sbi with a NULL inode pointer while iterating log->sb_list.
@@ -142,6 +149,7 @@ int jfs_umount_rw(struct super_block *sb)
 	 * remove file system from log active file system list.
 	 */
 	jfs_flush_journal(log, 2);
+	txLazyDrain(sb);
 
 	/*
 	 * Make sure all metadata makes it to disk
-- 
2.47.3


