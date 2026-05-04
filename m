Return-Path: <stable+bounces-242940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBZFNA5f+GlJtgIAu9opvQ
	(envelope-from <stable+bounces-242940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:55:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9234BAA0A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55ECE30914B8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A403451D9;
	Mon,  4 May 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BIvPTwBI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934C34A79E
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884616; cv=none; b=CgKHYbyPoSMTAO5RAnqLRCeYtC0tCjuaTtx52jDCfwvqDmdoI9tgFOZbsYzNMERsSH/tp76EOQ1xzVYT2L4th9qWNJ79E84tkTBLRzCWMjp3cHIDduIzOrtmTpyLsoXc6HYktyHZlZmv7HD5InmcO6QEMf+skZpTa+j9OwDFEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884616; c=relaxed/simple;
	bh=P0iDYlYYyvUP5qHZjV5PXxXu/mP1YKdaA5xfEwQnZuk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XIjXvF19Ewk6IDsAcTcaGnj4CMW1TUE9B/I2gWnbi1PqZYR+lzYvR//Xo57xmCNSN4OLtbL1VfevrsDPq6tOLWpAWJ769OexV8+AiUEb7hYm/psurrrOxPsd9HU8+MM7PgSB3c7/yz0cM0jBTd7iSLl2cNDCFNCKQrKBTsm07jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BIvPTwBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2041C2BCB8;
	Mon,  4 May 2026 08:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884616;
	bh=P0iDYlYYyvUP5qHZjV5PXxXu/mP1YKdaA5xfEwQnZuk=;
	h=Subject:To:Cc:From:Date:From;
	b=BIvPTwBI+Avwy/pZ2FVjZiLgla/Fm2/ptcI22j/9+oZTIwFDzn3Q2MTbGYsbPnny4
	 uJJ/ysnYvnwmuOAO6OM7JmXJ5IS7X5Kr2zQVMs2WA5UjG9Pnx5iFuiQZ1jXU8hgSQk
	 H1CbvWEwttbpQFxZWTGytq8Ptd+NOSRHhk6WY9oE=
Subject: FAILED: patch "[PATCH] ceph: only d_add() negative dentries when they are unhashed" failed to apply to 5.15-stable tree
To: max.kellermann@ionos.com,Slava.Dubeyko@ibm.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:50:11 +0200
Message-ID: <2026050410-undated-taking-85de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D9234BAA0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242940-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[ionos.com,ibm.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ionos.com:email,linuxfoundation.org:dkim]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 803447f93d75ab6e40c85e6d12b5630d281d70d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050410-undated-taking-85de@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 803447f93d75ab6e40c85e6d12b5630d281d70d6 Mon Sep 17 00:00:00 2001
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 27 Mar 2026 17:23:08 +0100
Subject: [PATCH] ceph: only d_add() negative dentries when they are unhashed

Ceph can call d_add(dentry, NULL) on a negative dentry that is already
present in the primary dcache hash.

In the current VFS that is not safe.  d_add() goes through __d_add()
to __d_rehash(), which unconditionally reinserts dentry->d_hash into
the hlist_bl bucket.  If the dentry is already hashed, reinserting the
same node can corrupt the bucket, including creating a self-loop.
Once that happens, __d_lookup() can spin forever in the hlist_bl walk,
typically looping only on the d_name.hash mismatch check and
eventually triggering RCU stall reports like this one:

 rcu: INFO: rcu_sched self-detected stall on CPU
 rcu:         87-....: (2100 ticks this GP) idle=3a4c/1/0x4000000000000000 softirq=25003319/25003319 fqs=829
 rcu:         (t=2101 jiffies g=79058445 q=698988 ncpus=192)
 CPU: 87 UID: 2952868916 PID: 3933303 Comm: php-cgi8.3 Not tainted 6.18.17-i1-amd #950 NONE
 Hardware name: Dell Inc. PowerEdge R7615/0G9DHV, BIOS 1.6.6 09/22/2023
 RIP: 0010:__d_lookup+0x46/0xb0
 Code: c1 e8 07 48 8d 04 c2 48 8b 00 49 89 fc 49 89 f5 48 89 c3 48 83 e3 fe 48 83 f8 01 77 0f eb 2d 0f 1f 44 00 00 48 8b 1b 48 85 db <74> 20 39 6b 18 75 f3 48 8d 7b 78 e8 ba 85 d0 00 4c 39 63 10 74 1f
 RSP: 0018:ff745a70c8253898 EFLAGS: 00000282
 RAX: ff26e470054cb208 RBX: ff26e470054cb208 RCX: 000000006e958966
 RDX: ff26e48267340000 RSI: ff745a70c82539b0 RDI: ff26e458f74655c0
 RBP: 000000006e958966 R08: 0000000000000180 R09: 9cd08d909b919a89
 R10: ff26e458f74655c0 R11: 0000000000000000 R12: ff26e458f74655c0
 R13: ff745a70c82539b0 R14: d0d0d0d0d0d0d0d0 R15: 2f2f2f2f2f2f2f2f
 FS:  00007f5770896980(0000) GS:ff26e482c5d88000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f5764de50c0 CR3: 000000a72abb5001 CR4: 0000000000771ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  lookup_fast+0x9f/0x100
  walk_component+0x1f/0x150
  link_path_walk+0x20e/0x3d0
  path_lookupat+0x68/0x180
  filename_lookup+0xdc/0x1e0
  vfs_statx+0x6c/0x140
  vfs_fstatat+0x67/0xa0
  __do_sys_newfstatat+0x24/0x60
  do_syscall_64+0x6a/0x230
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

This is reachable with reused cached negative dentries.  A Ceph lookup
or atomic_open can be handed a negative dentry that is already hashed,
and fs/ceph/dir.c then hits one of two paths that incorrectly assume
"negative" also means "unhashed":

  - ceph_finish_lookup():
      MDS reply is -ENOENT with no trace
      -> d_add(dentry, NULL)

  - ceph_lookup():
      local ENOENT fast path for a complete directory with shared caps
      -> d_add(dentry, NULL)

Both paths can therefore re-add an already-hashed negative dentry.

Ceph already uses the correct pattern elsewhere: ceph_fill_trace() only
calls d_add(dn, NULL) for a negative null-dentry reply when d_unhashed(dn)
is true.

Fix both fs/ceph/dir.c sites the same way: only call d_add() for a
negative dentry when it is actually unhashed.  If the negative dentry
is already hashed, leave it in place and reuse it as-is.

This preserves the existing behavior for unhashed dentries while
avoiding d_hash list corruption for reused hashed negatives.

Cc: stable@vger.kernel.org
Fixes: 2817b000b02c ("ceph: directory operations")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index bac9cfb6b982..27ce9e55e947 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -769,7 +769,8 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 				d_drop(dentry);
 				err = -ENOENT;
 			} else {
-				d_add(dentry, NULL);
+				if (d_unhashed(dentry))
+					d_add(dentry, NULL);
 			}
 		}
 	}
@@ -840,7 +841,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 			spin_unlock(&ci->i_ceph_lock);
 			doutc(cl, " dir %llx.%llx complete, -ENOENT\n",
 			      ceph_vinop(dir));
-			d_add(dentry, NULL);
+			if (d_unhashed(dentry))
+				d_add(dentry, NULL);
 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
 			return NULL;
 		}


