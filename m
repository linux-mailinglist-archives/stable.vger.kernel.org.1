Return-Path: <stable+bounces-250600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HnJHAUSDmoJ6AUAu9opvQ
	(envelope-from <stable+bounces-250600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:56:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB24598ECE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A7913356530
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CBB318EC7;
	Wed, 20 May 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gnppz/Y5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9023D7D7E;
	Wed, 20 May 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295835; cv=none; b=NuwwBHZGTqUtY6Y2augIihgZuY6Zmc3ihMqpnnuuNfOBnrPTIYSuA/DNcnCk/BoP9pEotMs7AabOiBIRq5H1GlquKrmLSLytkhYQjr7u3mOJoDx/V3Oyt7zkr7T+w3IKfbCVAbJOesWafk3IF2OPZ7hPAlYHCIxOuniHtDY4/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295835; c=relaxed/simple;
	bh=NDzWkV1j+woVq2HW8j3eG0ez+bpn3aIkeWzH+sCROGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtC4eMfhuyfKqPsNdJHz+mVsNsNRn6XB9a1hqpwQ1YyRauD8DvpJPnC1YH/ek0n47lndWnrAutHTvoJ0F+pDCtunGnCLMLF9RY30TXpZJ2sq39hQz/67bbHy9YGr+vyBKyvyripNzxvaHEWRdfJNpeWlsCvtXGZHeoe+hRsafLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gnppz/Y5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC821F000E9;
	Wed, 20 May 2026 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295834;
	bh=0Cb6KpLV1WkLy0v0Lzcuv2+cuM9FFFnKEYTbZmUrGa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnppz/Y5VQFt5bjKAGRjkX69g1J0hMl62Z9Pm5iKGiprlY/olwlBkykdY9PDpY7zW
	 aESsQ2VtQB9f9yrYo+W/oDtfBCSbXZgjM/UeHy6/+GAeMNru2Uljhq4hZitAg3Uuem
	 JpdgFNzbApg50djGUASoWK/qsXYhwspZEw1X4ZXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhengYuan Huang <gality369@gmail.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0571/1146] ocfs2: validate group add input before caching
Date: Wed, 20 May 2026 18:13:41 +0200
Message-ID: <20260520162201.107061101@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-250600-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.alibaba.com,fasheh.com,evilplan.org,oracle.com,live.cn,huawei.com,suse.com,linux-foundation.org,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,live.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: ADB24598ECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ZhengYuan Huang <gality369@gmail.com>

[ Upstream commit 70b672833f4025341c11b22c7f83778a5cd611bc ]

[BUG]
OCFS2_IOC_GROUP_ADD can trigger a BUG_ON in
ocfs2_set_new_buffer_uptodate():

kernel BUG at fs/ocfs2/uptodate.c:509!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
RIP: 0010:ocfs2_set_new_buffer_uptodate+0x194/0x1e0 fs/ocfs2/uptodate.c:509
Code: ffffe88f 42b9fe4c 89e64889 dfe8b4df
Call Trace:
 ocfs2_group_add+0x3f1/0x1510 fs/ocfs2/resize.c:507
 ocfs2_ioctl+0x309/0x6e0 fs/ocfs2/ioctl.c:887
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x197/0x1e0 fs/ioctl.c:583
 x64_sys_call+0x1144/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7bbfb55a966d

[CAUSE]
ocfs2_group_add() calls ocfs2_set_new_buffer_uptodate() on a
user-controlled group block before ocfs2_verify_group_and_input()
validates that block number. That helper is only valid for newly
allocated metadata and asserts that the block is not already present in
the chosen metadata cache. The code also uses INODE_CACHE(inode) even
though the group descriptor belongs to main_bm_inode and later journal
accesses use that cache context instead.

[FIX]
Validate the on-disk group descriptor before caching it, then add it to
the metadata cache tracked by INODE_CACHE(main_bm_inode). Keep the
validation failure path separate from the later cleanup path so we only
remove the buffer from that cache after it has actually been inserted.
This keeps the group buffer lifetime consistent across validation,
journaling, and cleanup.

Link: https://lkml.kernel.org/r/20260410020209.3786348-1-gality369@gmail.com
Fixes: 7909f2bf8353 ("[PATCH 2/2] ocfs2: Implement group add for online resize")
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/resize.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
index 09724e7dc01ba..6375d50359725 100644
--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -508,14 +508,14 @@ int ocfs2_group_add(struct inode *inode, struct ocfs2_new_group_input *input)
 		goto out_unlock;
 	}
 
-	ocfs2_set_new_buffer_uptodate(INODE_CACHE(inode), group_bh);
-
 	ret = ocfs2_verify_group_and_input(main_bm_inode, fe, input, group_bh);
 	if (ret) {
 		mlog_errno(ret);
 		goto out_free_group_bh;
 	}
 
+	ocfs2_set_new_buffer_uptodate(INODE_CACHE(main_bm_inode), group_bh);
+
 	trace_ocfs2_group_add((unsigned long long)input->group,
 			       input->chain, input->clusters, input->frees);
 
@@ -523,7 +523,7 @@ int ocfs2_group_add(struct inode *inode, struct ocfs2_new_group_input *input)
 	if (IS_ERR(handle)) {
 		mlog_errno(PTR_ERR(handle));
 		ret = -EINVAL;
-		goto out_free_group_bh;
+		goto out_remove_cache;
 	}
 
 	cl_bpc = le16_to_cpu(fe->id2.i_chain.cl_bpc);
@@ -577,9 +577,11 @@ int ocfs2_group_add(struct inode *inode, struct ocfs2_new_group_input *input)
 out_commit:
 	ocfs2_commit_trans(osb, handle);
 
-out_free_group_bh:
+out_remove_cache:
 	if (ret < 0)
-		ocfs2_remove_from_cache(INODE_CACHE(inode), group_bh);
+		ocfs2_remove_from_cache(INODE_CACHE(main_bm_inode), group_bh);
+
+out_free_group_bh:
 	brelse(group_bh);
 
 out_unlock:
-- 
2.53.0




