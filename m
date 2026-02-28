Return-Path: <stable+bounces-220125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGsUHxUqo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E581C5189
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89F61316278C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63C481229;
	Sat, 28 Feb 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj/cTzTS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE51481221;
	Sat, 28 Feb 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300035; cv=none; b=aUpQqKJqxs5DQOkLmDZ09oeC1rALh/whZ31R4q4226xTmqyPsGoMz+Jloa7LJWeAIXQST2Nxic+pBhu9wB34/jJnUDjtXJJjB+cbYTFuRM68LOAu/VHHxXBBzropo3qd9YgUE4YYXpRrN7Tgs4kXn5l7/Sv5QAlQkrOZ0+3fdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300035; c=relaxed/simple;
	bh=3hym72ytkvsMcl0STiUx/epQk0w3xXD3m4DrcNFZKlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su2Eq0Hkc3f1Y0UkYBqDK4swyhSo+nr26AgnmcIYLvUja+cPjGQp72iT6pcWpnFSBoFf58gy1ZrFYrYeveFw1voGyvcy8skh2Irn8+WJKDZ6DozGNd0lQ6YQWZhA6f6L7Hj85iGvqNv/UgLwoUYOIVzXRakC8Vh/JulLK6RWpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj/cTzTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ADFC19424;
	Sat, 28 Feb 2026 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300035;
	bh=3hym72ytkvsMcl0STiUx/epQk0w3xXD3m4DrcNFZKlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kj/cTzTSWtCJYCllYau+iVdvMKoFl2u4o0Zveaycq0UcGtuU70QdIW7F3Esz5B8xO
	 Wss1QORwG2cq3YVa0UHPuCOGlSMtWrbEf8Dz7rsS+HwtEvQhibgu9MRxVzwBZVnLVh
	 VJuGQERwqlehx0VtsKb1Nv7libq+hD4beBVlbdogFgldkJzYvqx9ZKcn/uNgaUFivt
	 E+bkXWMWKSo4sq9wnJ82pCfInNc6Upnl6/bCFlLRxerBJTYuMOPKegqw81Ch0bhf3v
	 tdIR3IhJxQU92+dnLmU3yWAe3559eLuQKCBAbxWQkHTMd0EhLJKyHiQOqzE9k5kwWn
	 bilEWXkabCrPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Jan Kara <jack@suse.cz>,
	syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 047/844] minix: Add required sanity checking to minix_check_superblock()
Date: Sat, 28 Feb 2026 12:19:20 -0500
Message-ID: <20260228173244.1509663-48-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[xs4all.nl,suse.cz,syzkaller.appspotmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220125-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,5ad0824204c7bf9b67f2];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:email,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: F2E581C5189
X-Rspamd-Action: no action

From: Jori Koolstra <jkoolstra@xs4all.nl>

[ Upstream commit 8c97a6ddc95690a938ded44b4e3202f03f15078c ]

The fs/minix implementation of the minix filesystem does not currently
support any other value for s_log_zone_size than 0. This is also the
only value supported in util-linux; see mkfs.minix.c line 511. In
addition, this patch adds some sanity checking for the other minix
superblock fields, and moves the minix_blocks_needed() checks for the
zmap and imap also to minix_check_super_block().

This also closes a related syzbot bug report.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Link: https://patch.msgid.link/20251208153947.108343-1-jkoolstra@xs4all.nl
Reviewed-by: Jan Kara <jack@suse.cz>
Reported-by: syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5ad0824204c7bf9b67f2
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/minix/inode.c | 50 ++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 51ea9bdc813f7..c8c6b2135abe7 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -170,10 +170,38 @@ static int minix_reconfigure(struct fs_context *fc)
 static bool minix_check_superblock(struct super_block *sb)
 {
 	struct minix_sb_info *sbi = minix_sb(sb);
+	unsigned long block;
 
-	if (sbi->s_imap_blocks == 0 || sbi->s_zmap_blocks == 0)
+	if (sbi->s_log_zone_size != 0) {
+		printk("minix-fs error: zone size must equal block size. "
+		       "s_log_zone_size > 0 is not supported.\n");
+		return false;
+	}
+
+	if (sbi->s_ninodes < 1 || sbi->s_firstdatazone <= 4 ||
+	    sbi->s_firstdatazone >= sbi->s_nzones)
 		return false;
 
+	/* Apparently minix can create filesystems that allocate more blocks for
+	 * the bitmaps than needed.  We simply ignore that, but verify it didn't
+	 * create one with not enough blocks and bail out if so.
+	 */
+	block = minix_blocks_needed(sbi->s_ninodes, sb->s_blocksize);
+	if (sbi->s_imap_blocks < block) {
+		printk("MINIX-fs: file system does not have enough "
+		       "imap blocks allocated. Refusing to mount.\n");
+		return false;
+	}
+
+	block = minix_blocks_needed(
+			(sbi->s_nzones - sbi->s_firstdatazone + 1),
+			sb->s_blocksize);
+	if (sbi->s_zmap_blocks < block) {
+		printk("MINIX-fs: file system does not have enough "
+		       "zmap blocks allocated. Refusing to mount.\n");
+		return false;
+	}
+
 	/*
 	 * s_max_size must not exceed the block mapping limitation.  This check
 	 * is only needed for V1 filesystems, since V2/V3 support an extra level
@@ -293,26 +321,6 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
 	minix_set_bit(0,sbi->s_imap[0]->b_data);
 	minix_set_bit(0,sbi->s_zmap[0]->b_data);
 
-	/* Apparently minix can create filesystems that allocate more blocks for
-	 * the bitmaps than needed.  We simply ignore that, but verify it didn't
-	 * create one with not enough blocks and bail out if so.
-	 */
-	block = minix_blocks_needed(sbi->s_ninodes, s->s_blocksize);
-	if (sbi->s_imap_blocks < block) {
-		printk("MINIX-fs: file system does not have enough "
-				"imap blocks allocated.  Refusing to mount.\n");
-		goto out_no_bitmap;
-	}
-
-	block = minix_blocks_needed(
-			(sbi->s_nzones - sbi->s_firstdatazone + 1),
-			s->s_blocksize);
-	if (sbi->s_zmap_blocks < block) {
-		printk("MINIX-fs: file system does not have enough "
-				"zmap blocks allocated.  Refusing to mount.\n");
-		goto out_no_bitmap;
-	}
-
 	/* set up enough so that it can read an inode */
 	s->s_op = &minix_sops;
 	s->s_time_min = 0;
-- 
2.51.0


