Return-Path: <stable+bounces-215521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNS/K/MHimluFQAAu9opvQ
	(envelope-from <stable+bounces-215521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:14:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC51112651
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 17:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AD44302D106
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9143815C6;
	Mon,  9 Feb 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="hsWqOIqb";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="KxLc+Bwo"
X-Original-To: stable@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEC3806D8;
	Mon,  9 Feb 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653637; cv=none; b=mcpBbZ6tEizvNFRSw+x08qZngL3N+AH/0D8vRMnlOYgIzogTT1aWwQRlkCbo3btdngxhVEpgF2ptquUT2SCsDANRl99WvuibVJ01ZXCvwSo++M316IBMRksUJYcbirgkJ8/ODUzHoxkk4TFVx+uLfhedMIzqbKWyD1Q2ugSiaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653637; c=relaxed/simple;
	bh=BbAHzEmDq6quWXuJVOzwlsWcfxdjzBv1mmQ60zpegig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJtnVarag9hAB2srov0hmAMDMZF5gNRcnSDeGMZR8DJy+8P6vyV1wicYimJBwSGY1lTs0ecnyTQMxfLVhiz94dQePiXiwaBA0hkZqS6cksPHh4aMdLtQTq5a4u3IbbZWW840ctnDrcMDBHXGHDbF+qHx0H+xVQ5FwzQBHynPES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=hsWqOIqb; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=KxLc+Bwo; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770653628; bh=TIzg/21WYc6roqYOqE2C6xR
	chOosyzbnkc8iUinXj6o=; b=hsWqOIqbOtG78PHJyLh4rOYkaq5gKpOInudF0yRmW2F8hF6Tm2
	p/HpAeDLEiiXfoWw5ebsAz4rriI06RK0XdxtrEWfD91CKVKGoErscG4S5Lc7V4tMONCNF5uMZlg
	yXe4nZUZNad5tzswNcsoTB6zWAPWCiDBwu9K9BHRoocxvbooaNaefcIXxA8mVWkQFlMVYLfqzc0
	IPkcgRRdRCkRdJ8mi3wryBQ2TZUjK1/gSEzzW9N1M9g12LCleE8QqnZiw7QsKGmbVvy98ep+H5L
	GQ8hJHSVe0pa4HV1MdRN0mpvSNjfP3cIv0f+LarWX/9YXHwWCnpdFBahNjk98q0F53w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770653628; bh=TIzg/21WYc6roqYOqE2C6xR
	chOosyzbnkc8iUinXj6o=; b=KxLc+BwosL8FCsZiMixI5znDkBJJ+UeI8qWO9S12iC5i+ZfDQ3
	ZocCY/NzffJgSVi510VeKHRtnsGK8Mso1fAw==;
From: Daniel Hodges <git@danielhodges.dev>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>,
	syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: zero-initialize recovery bitmap to prevent uninit-value in find_next_bit
Date: Mon,  9 Feb 2026 11:13:47 -0500
Message-ID: <20260209161347.30400-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215521-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,7ea0b96c4ddb49fd1a70];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,danielhodges.dev:mid,danielhodges.dev:dkim,danielhodges.dev:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 0AC51112651
X-Rspamd-Action: no action

ocfs2_add_recovery_chunk() allocates a bitmap buffer of sb->s_blocksize
bytes using kmalloc() but only copies (ol_chunk_entries(sb) + 7) >> 3
bytes into it from the on-disk quota chunk. When the number of chunk
entries is not aligned to a long boundary (64 bits on 64-bit systems),
find_next_bit() reads uninitialized memory from the trailing bytes of
the last word in the bitmap.

Fix this by using kzalloc() to zero-initialize the entire bitmap
allocation, ensuring that any bits beyond the copied region are
clean zeros.

Reported-by: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Fixes: 2205363dce74 ("ocfs2: Implement quota recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 fs/ocfs2/quota_local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index de7f12858729..bd3eb098097f 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -302,7 +302,7 @@ static int ocfs2_add_recovery_chunk(struct super_block *sb,
 	if (!rc)
 		return -ENOMEM;
 	rc->rc_chunk = chunk;
-	rc->rc_bitmap = kmalloc(sb->s_blocksize, GFP_NOFS);
+	rc->rc_bitmap = kzalloc(sb->s_blocksize, GFP_NOFS);
 	if (!rc->rc_bitmap) {
 		kfree(rc);
 		return -ENOMEM;
-- 
2.52.0


