Return-Path: <stable+bounces-230112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFRlBgttwmnYcwQAu9opvQ
	(envelope-from <stable+bounces-230112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:52:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE93306C67
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BA5304E731
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D63E4C75;
	Tue, 24 Mar 2026 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pjre0K3L"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35050368263
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349191; cv=none; b=hA3nIm314FloKUiuDd1JwynyEVPJT0e4sFHqOOZ2MT6sKk5hueVDz6VHKnQf9D8cJyToqDI5sojhWuuJEWzCgjVddWtcWAAb5K08em7Ijs2H1qzZqcLIFzrX+a3cWn+CvnHPLrDxh7qR4ki3KsyECvF/JVyAbPvW+KhsV/qc8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349191; c=relaxed/simple;
	bh=SJBtwzFKz9LTfTysUSrYLmnlMLb8HFshNQlslEZDK80=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qr85ow8kTCy42Rg5AVP3syCht+sZJa6+VQoegDcI6/058kFOU9u4Q04OZ1ruwqPDfmqEGFy6KZOoQaS0Jn/i5PEBBzOHinCki0xHf6uNHSJwbakh+w3UtnSIZLjUGdi5l2xEjXtxWjsy8Q5aN+18MN+NxbH0ZDpAogMgdBC2NpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pjre0K3L; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Mar 2026 18:45:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774349177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkji2R9FeYSO37ALO1T1nPzc7U9/qqFRpEEZ+KP4TMo=;
	b=Pjre0K3LzK/Qyz21BPAUqLbYtmUOzQtQQANe2NSwiOPDJV8R9z+7Em+65pX06FMMNgAAYJ
	SRpPC5fsnK1piPZpROLaIc6P4/xEAwh6MmDRFzBSuTxTz431WHIakUa6K0e3BlaZLTY3he
	FgPHuJ+M5WoqXfQDjC75W27kGiRv+O8=
Message-ID: <65f731a33b7f0f5e26bf288505694c9a.junjie.cao@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Junjie Cao <junjie.cao@linux.dev>
To: syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_ioctl_prepare_clean_segments
In-Reply-To: <69c08e14.050a0220.3bf4de.008f.GAE@google.com>
References: <69b8c9a9.a00a0220.3b25d1.002a.GAE@google.com> <69c08e14.050a0220.3bf4de.008f.GAE@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230112-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,gmail.com,dubeyko.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junjie.cao@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,466a45fcfb0562f5b9a0];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 6BE93306C67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please test the following patch.

From: Junjie Cao <junjie.cao@linux.dev>
Date: Thu, 19 Mar 2026 00:00:00 +0800
Subject: [PATCH] nilfs2: skip blocks with no bmap entry in
 nilfs_ioctl_mark_blocks_dirty()

In nilfs_ioctl_mark_blocks_dirty(), called during garbage collection,
nilfs_bmap_lookup_at_level() may return -ENOENT when a block no longer
exists in the DAT bmap.  In that case the code sets bd_blocknr to 0 but
falls through to the liveness check that compares bd_blocknr against
bd_oblocknr.  If bd_oblocknr also happens to be 0, the descriptor is
incorrectly treated as live and the code attempts to get or mark the
non-existent block, triggering a WARN_ON.

Fix this by adding a continue statement so that a block descriptor is
immediately skipped when its bmap lookup returns -ENOENT, since there
is no block in the DAT to mark dirty.

Fixes: 7942b919f732 ("nilfs2: ioctl operations")
Reported-by: syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=466a45fcfb0562f5b9a0
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 fs/nilfs2/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 1bfe8a2..d71a0a5 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -744,6 +744,7 @@ static int nilfs_ioctl_mark_blocks_dirty(struct the_nilfs *nilfs,
 		if (ret < 0) {
 			if (ret != -ENOENT)
 				return ret;
 			bdescs[i].bd_blocknr = 0;
+			continue;
 		}
 		if (bdescs[i].bd_blocknr != bdescs[i].bd_oblocknr)
 			/* skip dead block */
--
2.43.0

