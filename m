Return-Path: <stable+bounces-218659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGVbNGBYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F11906ED
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4A031B4184
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7126463A;
	Wed, 25 Feb 2026 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6KZ3sZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F31D5141;
	Wed, 25 Feb 2026 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983511; cv=none; b=q3ysXCeWxdDQpAXrEkE8kdVb6tZd8Hz54uAVX7wJulrrvmPxJAkKreMDDkry/XbaN5kJlg5qSEMTuPzYiFy9moiUJ5G3fo21tYwriukdML80n7Xl8Mw0dFDyunOzvwk7tzakda8cROSGacyHNJUose11YeptgdKOvihVm1uaiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983511; c=relaxed/simple;
	bh=43BW4/VSSTkseD9Udb2yNQJzK1R58HENvmUa8nOb8lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y67ycS6r+DEzOzPLRtRcY342FDJU98KWTRN0i8aDwwsJnoI/ZUmNHx5zlKmm67Zelnt/ZKMi2iPjkYOFuya3xDUUY+fyI/xv3hMJpPgZ/SHsIFI/lMg3AK7amww3gS8obwVoxIuMHpOfbwqRoFHjcB0KJNuSLtVgXdZShpdWxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6KZ3sZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92285C19424;
	Wed, 25 Feb 2026 01:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983511;
	bh=43BW4/VSSTkseD9Udb2yNQJzK1R58HENvmUa8nOb8lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6KZ3sZ7MliX1GKSwVZkni7PGMmiFg7mavbLJSqUSgOU/2Y+W6IWXRZT0TZUeWP3R
	 xfCs3nZbWRLlL4U3P6lwMjzaeTVt9BdJdo/GG6b0ujvH1VMXgxcP3vFThKsZcuZvbW
	 GBLACe0nS8ynvZ5l9usI/eLkvGUudI2TbxE7U/MI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+5af33dd272b913b65880@syzkaller.appspotmail.com,
	Szymon Wilczek <swilczek.lx@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 618/781] fs/ntfs3: fix deadlock in ni_read_folio_cmpr
Date: Tue, 24 Feb 2026 17:22:07 -0800
Message-ID: <20260225012414.963371941@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218659-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,paragon-software.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,5af33dd272b913b65880];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,paragon-software.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 588F11906ED
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Szymon Wilczek <swilczek.lx@gmail.com>

[ Upstream commit e37a75bb866c29da954b51d0dd7670406246d9ee ]

Syzbot reported a task hung in ni_readpage_cmpr (now ni_read_folio_cmpr).
This is caused by a lock inversion deadlock involving the inode mutex
(ni_lock) and page locks.

Scenario:
1. Task A enters ntfs_read_folio() for page X. It acquires ni_lock.
2. Task A calls ni_read_folio_cmpr(), which attempts to lock all pages in
   the compressed frame (including page Y).
3. Concurrently, Task B (e.g., via readahead) has locked page Y and
   calls ntfs_read_folio().
4. Task B waits for ni_lock (held by A).
5. Task A waits for page Y lock (held by B).
   -> DEADLOCK.

The fix is to restructure locking: do not take ni_lock in ntfs_read_folio().
Instead, acquire ni_lock inside ni_read_folio_cmpr() ONLY AFTER all required
page locks for the frame have been successfully acquired. This restores the
correct lock ordering (Page Lock -> ni_lock) consistent with VFS.

Reported-by: syzbot+5af33dd272b913b65880@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5af33dd272b913b65880
Fixes: f35590ee26f5 ("fs/ntfs3: remove ntfs_bio_pages and use page cache for compressed I/O")
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
[almaz.alexandrovich@paragon-software.com: ni_readpage_cmpr was renamed to ni_read_folio_cmpr]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 2 ++
 fs/ntfs3/inode.c   | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 7e3d61de2f8fa..d5bbd47e1ee9d 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2107,7 +2107,9 @@ int ni_read_folio_cmpr(struct ntfs_inode *ni, struct folio *folio)
 		pages[i] = pg;
 	}
 
+	ni_lock(ni);
 	err = ni_read_frame(ni, frame_vbo, pages, pages_per_frame, 0);
+	ni_unlock(ni);
 
 out1:
 	for (i = 0; i < pages_per_frame; i++) {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 1319b99dfeb41..ec8e954f4426c 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -735,9 +735,8 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
 	}
 
 	if (is_compressed(ni)) {
-		ni_lock(ni);
+		/* ni_lock is taken inside ni_read_folio_cmpr after page locks */
 		err = ni_read_folio_cmpr(ni, folio);
-		ni_unlock(ni);
 		return err;
 	}
 
-- 
2.51.0




