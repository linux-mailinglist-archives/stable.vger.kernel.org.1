Return-Path: <stable+bounces-239240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kInhGAxa5mnGvAEAu9opvQ
	(envelope-from <stable+bounces-239240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:53:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CD64302E1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37DD437FB605
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CD33A3E69;
	Mon, 20 Apr 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDzqhjXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B93A0B26
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696122; cv=none; b=us7NpSmW3DyCMXqFNy1dsmSZbtVpQlJUMEPzZMj9qQBV4fUG2BNBt+fzg9l29Rp9iDxtaZDzBQJCP59nJqnEbZaCwKuB6LLdeUNHYheU6F4f1aGLai9kJnMoMpyeJFa+XGy0tdsZo8FWHsEWcJcsg3B/X8d/Si+4JZ48SrMAH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696122; c=relaxed/simple;
	bh=TuNPWLDCc5mt8DSUujK8W2IU0p4PIznU/xADdOMwCT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjo1NXGCqQTLGM5rDKEJexgZq/E2exh6kMozsMMbWa5glcPcYK2ieb12G3LhlDYv3q4YVG/Fa7EC2/wPen6bXwX1Hwp03yCR0rFuWftYvMUNtfQDOgSBztARi0tfX7+Hg8/Kjj/Wee7pl6o6h8WPSs3kYWwWknFUE/Xkl86bgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDzqhjXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42521C2BCB4;
	Mon, 20 Apr 2026 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776696122;
	bh=TuNPWLDCc5mt8DSUujK8W2IU0p4PIznU/xADdOMwCT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDzqhjXmSH7VRGMVdAgYj7EdQxEgB4n5U8yt6dLu9twtWC0e8y+aiYyI9HBjaZ/OT
	 NfEvf14M8avKG99haM0/h0xBQMBPpkr/MW015X0W8kQwfLdUlQOTmyYZOSqe6XWXXr
	 J8z6XQvJOTkWzQZf17BDfiP/as2fRcAV/lb7msvfcTLsyOlaw0v4Jd7ZgMN7TcbpOG
	 XgQi1ICRCNAxChEOiY/sPSgpFm+apxxgnEpgum7cBD6QFiw/i3G6nJAMCpmrrLbtXR
	 eQn1CtL/Z4fBz+mFvbW00165jZIDelBpl1XqL/sXRuPrI1S/pZ+kKSslpwca0a0ET0
	 1CGmsLK4GBllQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	syzbot+67b90111784a3eac8c04@syzkaller.appspotmail.com,
	Heming Zhao <heming.zhao@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Joseph Qi <jiangqi903@gmail.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ocfs2: fix possible deadlock between unlink and dio_end_io_write
Date: Mon, 20 Apr 2026 10:41:58 -0400
Message-ID: <20260420144158.1143438-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420144158.1143438-1-sashal@kernel.org>
References: <2026042002-rumbling-plunder-40f1@gregkh>
 <20260420144158.1143438-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,syzkaller.appspotmail.com,suse.com,fasheh.com,evilplan.org,oracle.com,gmail.com,live.cn,huawei.com,linux-foundation.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-239240-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,67b90111784a3eac8c04];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,appspotmail.com:email,suse.com:email,huawei.com:email,syzkaller.appspot.com:url,oracle.com:email,live.cn:email,alibaba.com:email,evilplan.org:email]
X-Rspamd-Queue-Id: D1CD64302E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit b02da26a992db0c0e2559acbda0fc48d4a2fd337 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/aops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 22bc41d2bdcc6..bf288da6ff11e 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2322,8 +2322,6 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 		goto out;
 	}
 
-	down_write(&oi->ip_alloc_sem);
-
 	/* Delete orphan before acquire i_rwsem. */
 	if (dwc->dw_orphaned) {
 		BUG_ON(dwc->dw_writer_pid != task_pid_nr(current));
@@ -2336,6 +2334,7 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 			mlog_errno(ret);
 	}
 
+	down_write(&oi->ip_alloc_sem);
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 
 	ocfs2_init_dinode_extent_tree(&et, INODE_CACHE(inode), di_bh);
-- 
2.53.0


