Return-Path: <stable+bounces-238760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMx6D/4l5mmgsgEAu9opvQ
	(envelope-from <stable+bounces-238760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:11:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B942B4D9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 001293126710
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23739E6FF;
	Mon, 20 Apr 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UjKQcyWE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8524034405B
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690314; cv=none; b=rfO9lVrzuGbjbDE5LcbrW8OrqJnQTcm7qA0/xT/DED8MRmeXgCnyJQvx6jQ6iUjpYEHFRoGQBZqcGkSATQsnOTwkyz2v2Y4fyVq9cJH1QtJJyXLn0D6XZvfcCQQmZpWy99+P9cjGcyiYL5p02dcohwmIJozvsRJdoiqoi/TeUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690314; c=relaxed/simple;
	bh=5Cem+yaowv39X0j0UAZ8xNhjCHVKG5Shnq93QiV9SuE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eh/QAnDwZHYQX1DxGPmrm79Xph5ye03iV6DVmAhMO65winLaDafGrdCeBoenrmfxnUoBt7nDW/u7gz7XSnmiYeUy7q3B8eAOWEbN5W2teTAtE8JZzXDNqqkorJifb9YCUXLO0Ejggbiz/MdF9vUfT9makQUD2nP3qekgtCylvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UjKQcyWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0562C19425;
	Mon, 20 Apr 2026 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776690314;
	bh=5Cem+yaowv39X0j0UAZ8xNhjCHVKG5Shnq93QiV9SuE=;
	h=Subject:To:Cc:From:Date:From;
	b=UjKQcyWEShJa/9+FKRYmv+cZQiNwRAhpgK9I02A5ikLxU3G46BHEf5Q20jexihZCD
	 nWb0BHVNrR0HPjbWfaF63OoHLnNwnKwFlo5muhYsjdoDwKB20HlwPe9RjCEYNRhDwh
	 BEXvxlMxGuDR+cce93EkDNXH2p8iAWktq8zMZEaw=
Subject: FAILED: patch "[PATCH] ocfs2: fix possible deadlock between unlink and" failed to apply to 5.10-stable tree
To: joseph.qi@linux.alibaba.com,akpm@linux-foundation.org,gechangwei@live.cn,heming.zhao@suse.com,jiangqi903@gmail.com,jlbec@evilplan.org,junxiao.bi@oracle.com,mark@fasheh.com,piaojun@huawei.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 15:05:03 +0200
Message-ID: <2026042003-rocking-engine-1cb6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238760-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.alibaba.com,linux-foundation.org,live.cn,suse.com,gmail.com,evilplan.org,oracle.com,fasheh.com,huawei.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 9A4B942B4D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b02da26a992db0c0e2559acbda0fc48d4a2fd337
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042003-rocking-engine-1cb6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b02da26a992db0c0e2559acbda0fc48d4a2fd337 Mon Sep 17 00:00:00 2001
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Date: Fri, 6 Mar 2026 11:22:11 +0800
Subject: [PATCH] ocfs2: fix possible deadlock between unlink and
 dio_end_io_write

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

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 17ba79f443ee..09146b43d1f0 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2294,8 +2294,6 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 		goto out;
 	}
 
-	down_write(&oi->ip_alloc_sem);
-
 	/* Delete orphan before acquire i_rwsem. */
 	if (dwc->dw_orphaned) {
 		BUG_ON(dwc->dw_writer_pid != task_pid_nr(current));
@@ -2308,6 +2306,7 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 			mlog_errno(ret);
 	}
 
+	down_write(&oi->ip_alloc_sem);
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 
 	ocfs2_init_dinode_extent_tree(&et, INODE_CACHE(inode), di_bh);


