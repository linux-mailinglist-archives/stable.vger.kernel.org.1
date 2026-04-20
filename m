Return-Path: <stable+bounces-239720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMcaAI1n5mnBvwEAu9opvQ
	(envelope-from <stable+bounces-239720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:51:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B36432301
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5F736E948B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689772AE78;
	Mon, 20 Apr 2026 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpqJDxa0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5793382C7;
	Mon, 20 Apr 2026 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701044; cv=none; b=XiiyeGt8UM5T0+bZmJWo/0kKZtXaCI1xDFm7M9STnwvYWeYAk7oA/Sebrs+bZSPAHR/AavkZhUe3l2TQUGO4vbOISs645IcRe47YdySN/dHLuapMqi9qte3dxVZs+1POpo/Tl4HqRmRfH+vxgV1VBqyWCzDu0qDQpbcoJQEzsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701044; c=relaxed/simple;
	bh=K+WoCHO7xgTE3Y5cBn2OI5d+aSqb061TSIdpoi1zTxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BycElH+iyVqc/bh5EMQHeQFCEjrZAdKTt27VxzUeAcFE6jJQaodLoupqpi/qw+Mo2peaCvoq5XCSgpXELS91ipGaZC1zziAdqUqZ9GzT3ppCXrgbUQcHxcOtWm1A68WzN85g6LlG1v0J8287uKJ9++OAPFgeoXAhTW91HIHorrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpqJDxa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7E2C2BCB4;
	Mon, 20 Apr 2026 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701044;
	bh=K+WoCHO7xgTE3Y5cBn2OI5d+aSqb061TSIdpoi1zTxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpqJDxa0DINT+gGkNfe35ZogfW92OhOVywrr258lQ67tCHG2D4Rf+5XIxF9bzEoFK
	 VvdwYg2lMhpxjO9VCHyTeUfvAi8lzcd6bCHurv19B1Htb9Y5tcnUU2DhmVWdHzEWAY
	 kNwyYhq4Tu/DGXHJbZl8L9C6UjQXu7YPmTWwegaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+67b90111784a3eac8c04@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Joseph Qi <jiangqi903@gmail.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 160/198] ocfs2: fix possible deadlock between unlink and dio_end_io_write
Date: Mon, 20 Apr 2026 17:42:19 +0200
Message-ID: <20260420153941.367896116@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-239720-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,linux.alibaba.com,suse.com,fasheh.com,evilplan.org,oracle.com,gmail.com,live.cn,huawei.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,67b90111784a3eac8c04];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,huawei.com:email,fasheh.com:email,live.cn:email,evilplan.org:email,oracle.com:email,syzkaller.appspot.com:url,alibaba.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux-foundation.org:email]
X-Rspamd-Queue-Id: 69B36432301
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joseph Qi <joseph.qi@linux.alibaba.com>

commit b02da26a992db0c0e2559acbda0fc48d4a2fd337 upstream.

ocfs2_unlink takes orphan dir inode_lock first and then ip_alloc_sem,
while in ocfs2_dio_end_io_write, it acquires these locks in reverse order.
This creates an ABBA lock ordering violation on lock classes
ocfs2_sysfile_lock_key[ORPHAN_DIR_SYSTEM_INODE] and
ocfs2_file_ip_alloc_sem_key.

Lock Chain #0 (orphan dir inode_lock -> ip_alloc_sem):
ocfs2_unlink
  ocfs2_prepare_orphan_dir
    ocfs2_lookup_lock_orphan_dir
      inode_lock(orphan_dir_inode) <- lock A
    __ocfs2_prepare_orphan_dir
      ocfs2_prepare_dir_for_insert
        ocfs2_extend_dir
	  ocfs2_expand_inline_dir
	    down_write(&oi->ip_alloc_sem) <- Lock B

Lock Chain #1 (ip_alloc_sem -> orphan dir inode_lock):
ocfs2_dio_end_io_write
  down_write(&oi->ip_alloc_sem) <- Lock B
  ocfs2_del_inode_from_orphan()
    inode_lock(orphan_dir_inode) <- Lock A

Deadlock Scenario:
  CPU0 (unlink)                     CPU1 (dio_end_io_write)
  ------                            ------
  inode_lock(orphan_dir_inode)
                                    down_write(ip_alloc_sem)
  down_write(ip_alloc_sem)
                                    inode_lock(orphan_dir_inode)

Since ip_alloc_sem is to protect allocation changes, which is unrelated
with operations in ocfs2_del_inode_from_orphan.  So move
ocfs2_del_inode_from_orphan out of ip_alloc_sem to fix the deadlock.

Link: https://lkml.kernel.org/r/20260306032211.1016452-1-joseph.qi@linux.alibaba.com
Reported-by: syzbot+67b90111784a3eac8c04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=67b90111784a3eac8c04
Fixes: a86a72a4a4e0 ("ocfs2: take ip_alloc_sem in ocfs2_dio_get_block & ocfs2_dio_end_io_write")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/aops.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2295,8 +2295,6 @@ static int ocfs2_dio_end_io_write(struct
 		goto out;
 	}
 
-	down_write(&oi->ip_alloc_sem);
-
 	/* Delete orphan before acquire i_rwsem. */
 	if (dwc->dw_orphaned) {
 		BUG_ON(dwc->dw_writer_pid != task_pid_nr(current));
@@ -2309,6 +2307,7 @@ static int ocfs2_dio_end_io_write(struct
 			mlog_errno(ret);
 	}
 
+	down_write(&oi->ip_alloc_sem);
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 
 	ocfs2_init_dinode_extent_tree(&et, INODE_CACHE(inode), di_bh);



