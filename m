Return-Path: <stable+bounces-220120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OuwHVopo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:43:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A01C5112
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C88A7315772D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1C9480948;
	Sat, 28 Feb 2026 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCo3MB8l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF433A9D1;
	Sat, 28 Feb 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300031; cv=none; b=kOKUpRGapR+sPnzWLkr62zIi9xhAdNSYIGR+JsUIXyZqPrg5RyuNC5/qUPzgGDSInQYTWMnXUA3onkW1PLVRGmxPdy7Ct4G91xu2VhAUOL7aPP2kejysYdymlf1XEZ1MDfCQhrMka7bDDj+GymqRrIjUZjiq7+9iB8ZW3HxgGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300031; c=relaxed/simple;
	bh=MgRoRHKMN2hql43Baj4t2TCddrzhBbDDOZni91WrMe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQSRuMBIq8vTYTckNyODh51C8RaG0itKvdVS9GeOB3Q+0fvNcFKVEpXBkWP7JtLrPcOglx1btJfANv4lsZWPqIxrMCUd7w5fD+rgiZfp6KO4sSwgB+K1y2tRqV5EZgIQS6lyQIsk8Iwdhz8OkqrW/8VRxF7HnT7vJDlMfoLGtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCo3MB8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3F8C2BC87;
	Sat, 28 Feb 2026 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300030;
	bh=MgRoRHKMN2hql43Baj4t2TCddrzhBbDDOZni91WrMe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCo3MB8lqBtr+ToySNE6sUy8W4xYd4ptCytwL5Hyvv8gnJ/oQjWENki91HQR/nZIw
	 2gUctkpg7YK/gIDc6mREBU2YnaGNaD8pTnX4NQ+GDE7uVZfVYSmHfwa3XzuqsGciGL
	 qheVWHCKig8V24qJYwpf6oUbkgJK+XbVTSxXEyy5n6SAEz+/ZV8Bwn9ZctcXDI+6cA
	 Pe07lXTtiZBTzB+zWOtybBwq84UAkxajIIXqB4MoMFoMeFihgYLJhtjDqi2X716X4T
	 ArOgEuFgvuZgFa1Nt9iLCO848R1hd7EMHMcQ8nlPna2QR/SVEQaTsrsGQ3LuVCcNld
	 MgXXopSTuSkpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 042/844] hfsplus: pretend special inodes as regular files
Date: Sat, 28 Feb 2026 12:19:15 -0500
Message-ID: <20260228173244.1509663-43-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220120-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,895c23f6917da440ed0d];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dubeyko.com:email]
X-Rspamd-Queue-Id: E75A01C5112
X-Rspamd-Action: no action

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit ed8889ca21b6ab37bc1435c4009ce37a79acb9e6 ]

Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/d0a07b1b-8b73-4002-8e29-e2bd56871262@I-love.SAKURA.ne.jp
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index aaffa9e060a0a..7f327b777ece8 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -53,6 +53,12 @@ static int hfsplus_system_read_inode(struct inode *inode)
 		return -EIO;
 	}
 
+	/*
+	 * Assign a dummy file type, for may_open() requires that
+	 * an inode has a valid file type.
+	 */
+	inode->i_mode = S_IFREG;
+
 	return 0;
 }
 
-- 
2.51.0


