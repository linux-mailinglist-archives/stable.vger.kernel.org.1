Return-Path: <stable+bounces-244130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNPUNC3l+Wn2EwMAu9opvQ
	(envelope-from <stable+bounces-244130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:40:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D401F4CDB78
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7812E303E15B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029D542E011;
	Tue,  5 May 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8WQEN6y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB3429814
	for <stable@vger.kernel.org>; Tue,  5 May 2026 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984415; cv=none; b=CM88PkTrlKGZaa/xt1FimRYzQx6DgZeiCycHJMuvsxzjD44KtpTZ+7/GAQVT2fdBvg1sY+pGH4FUO75kxxz2vd7H9X1N1dLKSKtbfBBB2ChdVZ4/Jb7dmPSHq7de9alc6+eIRuBIczPr34atRVp2C0G6xA+xbmMOc4Ub57Qnr0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984415; c=relaxed/simple;
	bh=TLIH/Tgx3dg9i1TNN4EsgmGal4HuOLfx7/7fIa8ct+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3I+HG+hjt32zk6RdgCu/Xr3Cz6IUyz+oNDMcIwnIcJGaosWgiGJ3XNUT0FMIhxCUy4zqt5K7qOBcA9VOXCYr6MhEgQN6AhU+jPT4oKmUsniSadhOZOndSLG5RvxEDE5DXZHj5nparVGrj66v1n0sxtsQGGq1qR5lX6Hw5c3VgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8WQEN6y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so32898485e9.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777984413; x=1778589213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2WNU8nICgt72CKBqTTHtMF4K06yXBKs3UcZ/HI1eik=;
        b=U8WQEN6ytTntXP/0KyTyQf+3O17R5hg8UnF3SS1MqIM9k05SBLctBUA92sy9gLOgDX
         xDUFvr1sLsXWjWkOhRCsEXYn00KA0XdF4P/iqfFVCLv4i9KgyZi8lIS6zNRJgJMbjXcS
         zsPmACh+8CGgcfPGVm8oMzMuA28AWI44s437b/rFX/0OJhkytrmUBaEXbNGvWyzqaSWk
         CuWHcctI6DF4rdZpcwRpSzzHexL0Hq5RQbTjWHwKpxBlOvkzycGXXjcSJ8oU1Fb2I2h+
         UtyJNpwoj7tr9xCZPCA7WzLJ+IaNLCMOC+ms1H1OcJIhVXFv17eN3/vnoir5962zlbUE
         RsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777984413; x=1778589213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2WNU8nICgt72CKBqTTHtMF4K06yXBKs3UcZ/HI1eik=;
        b=kte/1X/ZxEApOC7DpEDHILSRmmdnMIUUWzMbp8m9l27WnHFyaJ7QlflKyYE+3SKaJn
         knFp9zMZBgFJcZbXNsGkF6sxh7Jvft/I4j1Svb396up0bBVPJjkQAu+Mbmj+nyR57i4c
         1Lo1v/dZPVAUsvY1YtZBfeSRUv9RwfpHVE2XRVi87oRr03kX5Pq3E0tzpb11beLhs+kt
         ZQyZhDzv+x+hyD2JR2s757B1M3XYSeD0hRU7Ynfn23by6NPPgBz1Jk8P//9aCX7+QsA5
         dqRARgOjuJouZzbwguD2U3ogy2EC8qyXyRzyd7fxiSOxUJS4Iflgi2KykbddGzSbXQKe
         MfEg==
X-Forwarded-Encrypted: i=1; AFNElJ838imYPpn3aZlnuYxrwpNeR25UZoRLB5mkS7TUAUpZgbbeymjMtPwpnMLcGOLQU06ag3LIDIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkd7ttURFu2Fap/WKA8lvZRvz00K1hmM2MSSJWXCJLWozFJ4li
	dW2Fh9/h1V1v2hLtLvgDYY4Z162gYhyBUbx1vFG0jCo3CQxfQ9zd5Og=
X-Gm-Gg: AeBDieuz1Hd4hSVI95c5AVqR2/kZLomplYalYD7FSjfy2hAyklfkOcrf5wNFIycbgya
	d75DJ0EUQjupfYSnfdFnLvFxKFzHM0n+F1Jhp42dpm8INd/ykDEuzV2gPKnqNzBJAe2kUqaRMzS
	bz98rEfvlOL9rbUZ1UVH2IcTnBKmznIxFm9PvXP0KMhlLDbHt6knOPXrx7r3lSpyXwZKQnuO4oJ
	IesQg/Ui+Xn2tbo1OjDeceVCHJvETcXfXIxLanzHB9u6dD+TOGug5DEMP1NSPEJabcO57lSpKos
	t/pBWt/JCaw1C16dyBtST/rpGHSnHTzmIODElmW2xrfK5UeFSXXv2xjXWwSZS/iD18/YERkwEk2
	czDKP6B/WH2F/SrQhRqtKqATRithOuyd+Yp+CVAAEwmC4b6DqG3CnsWGC4M5kAvDgI2pcPoMeDv
	sASOA8kCiLO//UdQ==
X-Received: by 2002:a05:600c:a11:b0:487:12c:e7e1 with SMTP id 5b1f17b1804b1-48d187d95d2mr49896755e9.11.1777984412421;
        Tue, 05 May 2026 05:33:32 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822bf3ffsm431044285e9.7.2026.05.05.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:33:31 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com,
	syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 1/2] jfs: drain lazy commit queue during unmount to prevent use-after-free
Date: Tue,  5 May 2026 12:33:29 +0000
Message-ID: <20260505123330.2822833-2-tristmd@gmail.com>
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
X-Rspamd-Queue-Id: D401F4CDB78
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
	TAGGED_FROM(0.00)[bounces-244130-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,talencesecurity.com:email,syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
index ba71eb5ced567..80ce468eadde0 100644
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


