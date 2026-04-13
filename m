Return-Path: <stable+bounces-236139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP1wE2gM3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:31:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF97A3EDFC9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B396730A8158
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B23CB2E7;
	Mon, 13 Apr 2026 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgXN17IX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFDD3C9EFB
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093947; cv=none; b=BWGXhz3y+gIPtktjlw+bOxLUQz04plT22zLDml5l3rUdEFldJMPTpr0inYnt4Qc1EpL1TCeWjWgEepvU+VMVB+y4L9O4nvf0LuXeElKrIaHR8DkfZFZ71EN1o/oi/Esks/VnLK0CeNYxsU07xnrdwwh0kWkWQaYUMz6wCczEHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093947; c=relaxed/simple;
	bh=PYpstxGvXP1Xl24ChjQGshyazsxTdUDEiwVWw4ao1lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXM2nMHjRQIsEp3zWtMK/fTLm17nfUeHAArxFwLkdFIowaNHe82SWrZX1GKxTom9nxulFJ4XOjuI+5bKPsQKRpOixT2uHAHl4DHgYKz0tcRWWmrLi7ccGTnR3HiyKb4YoGfwD+doNGdGdkMMB3OP5hNZUa63rgmjUEUXD8UL/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgXN17IX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E1CC2BCB0;
	Mon, 13 Apr 2026 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776093946;
	bh=PYpstxGvXP1Xl24ChjQGshyazsxTdUDEiwVWw4ao1lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgXN17IXqx4u7meXFGKIc0PhN/1YNaZXH3bBmS5E/y2nkNp4F1pZnO4MFqmD3R1go
	 LiDHEpVisfPem7loUG7rudErOqY2+m51efD4dCE4+O03uAUxlgkdFELsigVsaSuvW1
	 EjmtCLy5wX+OlUjDaBATawFu9JwYwEfdr5n7Ls4GtbWPkI7pUU1UbNpSQFjoFFG6mH
	 2PlUd4oBA+B9U+OoazHa07kFH4UZHIyi5kRmUdZItohOd2lYXtIW+2qx2NXHxYEpRf
	 1KOT3K/J7huhY3cnvl8avI5Zv6B6bTGtqepyFuEN2q6KZQNqV4+dOBy6gXylMs5SMZ
	 kBe5QG5LDLIUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c897823f699449cc3eb4@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] ocfs2: validate inline data i_size during inode read
Date: Mon, 13 Apr 2026 11:25:41 -0400
Message-ID: <20260413152542.3042780-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413152542.3042780-1-sashal@kernel.org>
References: <2026041351-smashup-claim-a6fa@gregkh>
 <20260413152542.3042780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236139-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,linux.alibaba.com,fasheh.com,evilplan.org,oracle.com,live.cn,huawei.com,suse.com,linux-foundation.org,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c897823f699449cc3eb4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DF97A3EDFC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit 1524af3685b35feac76662cc551cbc37bd14775f ]

When reading an inode from disk, ocfs2_validate_inode_block() performs
various sanity checks but does not validate the size of inline data.  If
the filesystem is corrupted, an inode's i_size can exceed the actual
inline data capacity (id_count).

This causes ocfs2_dir_foreach_blk_id() to iterate beyond the inline data
buffer, triggering a use-after-free when accessing directory entries from
freed memory.

In the syzbot report:
  - i_size was 1099511627576 bytes (~1TB)
  - Actual inline data capacity (id_count) is typically <256 bytes
  - A garbage rec_len (54648) caused ctx->pos to jump out of bounds
  - This triggered a UAF in ocfs2_check_dir_entry()

Fix by adding a validation check in ocfs2_validate_inode_block() to ensure
inodes with inline data have i_size <= id_count.  This catches the
corruption early during inode read and prevents all downstream code from
operating on invalid data.

Link: https://lkml.kernel.org/r/20251212052132.16750-1-kartikey406@gmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Reported-by: syzbot+c897823f699449cc3eb4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c897823f699449cc3eb4
Tested-by: syzbot+c897823f699449cc3eb4@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/20251211115231.3560028-1-kartikey406@gmail.com/T/ [v1]
Link: https://lore.kernel.org/all/20251212040400.6377-1-kartikey406@gmail.com/T/ [v2]
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 7bc5da4842be ("ocfs2: fix out-of-bounds write in ocfs2_write_end_inline")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/inode.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 41310d2b937c4..ab41ec1ff9244 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1419,12 +1419,25 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
-	if ((le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) &&
-	    le32_to_cpu(di->i_clusters)) {
-		rc = ocfs2_error(sb, "Invalid dinode %llu: %u clusters\n",
-				 (unsigned long long)bh->b_blocknr,
-				 le32_to_cpu(di->i_clusters));
-		goto bail;
+	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) {
+		struct ocfs2_inline_data *data = &di->id2.i_data;
+
+		if (le32_to_cpu(di->i_clusters)) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode %llu: %u clusters\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le32_to_cpu(di->i_clusters));
+			goto bail;
+		}
+
+		if (le64_to_cpu(di->i_size) > le16_to_cpu(data->id_count)) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode #%llu: inline data i_size %llu exceeds id_count %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 (unsigned long long)le64_to_cpu(di->i_size),
+					 le16_to_cpu(data->id_count));
+			goto bail;
+		}
 	}
 
 	rc = 0;
-- 
2.53.0


