Return-Path: <stable+bounces-225438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOlFNJmstWla3QAAu9opvQ
	(envelope-from <stable+bounces-225438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 19:44:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7452628E846
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 19:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97000300F10E
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA2D33A03A;
	Sat, 14 Mar 2026 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="GrYEwdei"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB5202997;
	Sat, 14 Mar 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773513877; cv=none; b=oXDST+dVUxlFqZFqQ/7sNyLYsUvPExozcrjyFvnQK6eBtGCqX8dTpF8S3kgCbkK6NUV12FqlTmkxTn1eMZsSnqpoIyMzAYw+brY4d3m9hnls3BylbaUR/zTj3qGP86d8TVKN/cwSe7EOn4/yOfTaKR/HeP3u3Q03U9kNimRwb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773513877; c=relaxed/simple;
	bh=b/m0C98Ar1qk6GqkYHn0uxkv8LlQkvvWGQ54JoPFdFI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9HNJFfY8viws8tCdOs+xBAp6+d8bSjQQ/KU95FHEwMNJOn8F87/V2Jxl1AAotYMW5adSmRWyAWDVyP/fL5DV1EdJD2NCTo5dMQ/bbUWjYxYc8Lue5nXLheV5dpDKnic385ihCGwTITU0neMKmLIrIoFFL0HchXVpiUKkmMjsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GrYEwdei; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773513876; x=1805049876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nucdgIT4ue9aPFJmvyBHRTxOW28+Q8aHVHM5lAkRMG4=;
  b=GrYEwdei0+zzpY/IToHk3LuTlpM0t68bTp3e28la3Kcbqxh2T6Y9MEun
   HR7FkMF69JFppyCOsbDYFwUMR6UD8nE1pCocMnUVHgGio/LMH+4qQijMj
   SxRnpWwGwmECsG1XPSGpyznxHNJpcHGW25HG5oSZWnApT9vULUOlu5evx
   rf+UCemsEluiUXVDJG77FARi5iYorriyIQwkG7n7G3yainDxUXhha4IwF
   wpd/xvbXZTcFOVBUFFuu1mjD75/bkZE5UJmHJ+HfvzCQe8IPvl7L1pv4m
   e2wiczEPlipBYgT5LkFVafSY20QFCDt+a1JYkEpqmaOPyd/yBzUI7A7pu
   Q==;
X-CSE-ConnectionGUID: f+QIM8NoSb2xa235nSjVPg==
X-CSE-MsgGUID: QJi5NFfwQq2+zfmGpC8TMw==
X-IronPort-AV: E=Sophos;i="6.23,119,1770595200"; 
   d="scan'208";a="14848842"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 18:44:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:27108]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.193:2525] with esmtp (Farcaster)
 id 0a86d918-46fb-435b-8db8-3fbeaf6c9c13; Sat, 14 Mar 2026 18:44:31 +0000 (UTC)
X-Farcaster-Flow-ID: 0a86d918-46fb-435b-8db8-3fbeaf6c9c13
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sat, 14 Mar 2026 18:44:31 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.29) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sat, 14 Mar 2026 18:44:30 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yuto Ohnuki <ytohnuki@amazon.com>,
	<syzbot+c0fd9ea308d049c4e0b9@syzkaller.appspotmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] fs: fix use-after-free in peer group traversal during mount release
Date: Sat, 14 Mar 2026 18:44:22 +0000
Message-ID: <20260314184421.47303-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225438-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,c0fd9ea308d049c4e0b9];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7452628E846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mntput_no_expire_slowpath() does not remove a mount from its peer group
(mnt_share list) or slave list before sending it to the free path. If a
mount that was added to a peer group by clone_mnt() is freed through
mntput() without going through umount_tree()/bulk_make_private(), it
remains linked in the peer group's circular list after the slab object
is freed.

When another mount namespace is later torn down, umount_tree() calls
bulk_make_private() -> trace_transfers(), which walks the peer group via
next_peer(). This dereferences the freed mount's mnt_share field,
causing use-after-free:

  BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report
  Read of size 8 at addr ffff88807d533af8

  Call Trace:
   __list_del_entry_valid_or_report
   bulk_make_private
   umount_tree
   put_mnt_ns
   do_exit

  Allocated by:
   alloc_vfsmnt
   clone_mnt
   vfs_open_tree

  Freed by:
   kmem_cache_free
   rcu_core

Fix this by calling change_mnt_propagation(mnt, MS_PRIVATE) in
mntput_no_expire_slowpath() after mnt_del_instance(), while holding
lock_mount_hash(). This removes the mount from both the peer group and
any slave list before it enters the cleanup path.

This is safe without namespace_sem: the mount has MNT_DOOMED set and has
been removed from the instance list by mnt_del_instance(), making it
unreachable through normal lookup paths. lock_mount_hash() prevents
concurrent peer group traversal. This call is also idempotent: mounts
already made private by bulk_make_private() have IS_MNT_SHARED() and
IS_MNT_SLAVE() both false, so the condition is skipped.

Reported-by: syzbot+c0fd9ea308d049c4e0b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0fd9ea308d049c4e0b9
Fixes: 75db7fd99075b ("umount_tree(): take all victims out of propagation graph at once")
Cc: stable@vger.kernel.org
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/namespace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 854f4fc66469..d25abf051ad6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1359,6 +1359,11 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
 	rcu_read_unlock();
 
 	mnt_del_instance(mnt);
+
+	/* Remove from peer group / slave list before freeing */
+	if (unlikely(IS_MNT_SHARED(mnt) || IS_MNT_SLAVE(mnt)))
+		change_mnt_propagation(mnt, MS_PRIVATE);
+
 	if (unlikely(!list_empty(&mnt->mnt_expire)))
 		list_del(&mnt->mnt_expire);
 
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




