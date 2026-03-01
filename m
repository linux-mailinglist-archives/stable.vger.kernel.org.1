Return-Path: <stable+bounces-222004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOlCN9yfo2noIgUAu9opvQ
	(envelope-from <stable+bounces-222004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:09:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB71CD208
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D457731419F1
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD30302CD5;
	Sun,  1 Mar 2026 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNJ3Ml8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2181F2E7164;
	Sun,  1 Mar 2026 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329671; cv=none; b=qbzM5C0sYC73saqMotrkowNno2dha5VJDtK0jgGGRck7A0HRkexyqjLyKkmdq7EKQy0eAd5jmgk0fFJZ3EKHB7i0JIrjxHcNhAgAxOA3se89bd6T6EHn9OKNDp15JUfAKJhgfw27v8Ki2t6a1gqwpEJ/Z90gDu2F3NwxhsKNRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329671; c=relaxed/simple;
	bh=ok2K+Bts9SZqCGPdkS2dmRAvBdP8K339/mPtF55sN0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSapsDxYwxkdUpjCUUJ/c46HoJ76fS7UIdeIva8gL1df/AaKGGVZuq0jIstQiVgLjiDh3QCRvD/5xfRFH4+pZBEQz5Tld1VTm47Ub1bQ4f7XLo+uKDYe6PcNwjkxNCIZhY+ykFz/oiZMmcwk3ctImfgUkVYI8YGwrXZaRciJuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNJ3Ml8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599F3C19421;
	Sun,  1 Mar 2026 01:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329671;
	bh=ok2K+Bts9SZqCGPdkS2dmRAvBdP8K339/mPtF55sN0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=nNJ3Ml8I4KJCxkY6OXk0Dp5T+fAidUPQAhhaMUae9IZPYMFgrVMH3PAjsDGjDtFjf
	 Kjs90T9ueSM6b+QsVd2l5lDa9WZPmPF2opCLrszcu0fIyMqWWLBwqBEa6JqssXcTdu
	 XjxZ7aM5/6EbHZhDjcJ5l18rX6ZS8AdijnPGajYxIZqX99rrh508+BiYRODgdcfGHv
	 l9ufP5QDY7FiF8wkX1TjA/Tai9fVtJCa18OV+StAB7KapmDKKqvwGp4ery89B5VlLj
	 OHMN75xutGyMLnw8FH7QMwj54/YCd1JLLQ37WO0SWWZ9RvR6kqipL+D+i/c6rKE2x+
	 FdxNKDtWyeHvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sprasad@microsoft.com
Cc: Yuchan Nam <entropy1110@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: FAILED: Patch "cifs: some missing initializations on replay" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:48 -0500
Message-ID: <20260301014749.1711799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,vger.kernel.org,lists.samba.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222004-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79FB71CD208
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 14f66f44646333d2bfd7ece36585874fd72f8286 Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Sat, 14 Feb 2026 15:59:13 +0530
Subject: [PATCH] cifs: some missing initializations on replay

In several places in the code, we have a label to signify
the start of the code where a request can be replayed if
necessary. However, some of these places were missing the
necessary reinitializations of certain local variables
before replay.

This change makes sure that these variables get initialized
after the label.

Cc: stable@vger.kernel.org
Reported-by: Yuchan Nam <entropy1110@gmail.com>
Tested-by: Yuchan Nam <entropy1110@gmail.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/smb2ops.c | 2 ++
 fs/smb/client/smb2pdu.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 61c521712f863..7370d7a18cd0c 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1185,6 +1185,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	used_len = 0;
 	flags = CIFS_CP_CREATE_CLOSE_OP;
 	oplock = SMB2_OPLOCK_LEVEL_NONE;
 	server = cifs_pick_channel(ses);
@@ -1588,6 +1589,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 
 replay_again:
 	/* reinitialize for possible replay */
+	buffer = NULL;
 	flags = CIFS_CP_CREATE_CLOSE_OP;
 	oplock = SMB2_OPLOCK_LEVEL_NONE;
 	server = cifs_pick_channel(ses);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4602b4dfe8322..7f3edf42b9c3f 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2908,6 +2908,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 
 replay_again:
 	/* reinitialize for possible replay */
+	pc_buf = NULL;
 	flags = 0;
 	n_iov = 2;
 	server = cifs_pick_channel(ses);
-- 
2.51.0





