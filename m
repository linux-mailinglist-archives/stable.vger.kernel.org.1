Return-Path: <stable+bounces-236146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLiNIUQP3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:44:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E73EE1FD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70014301BC0A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D623C65FE;
	Mon, 13 Apr 2026 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teQATJKt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDD1A680E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094536; cv=none; b=JCl87seSkOxmcdAygufpWWZthl9dWfooZzkKd7EcxLKPqm4VzB+NHu9jSxR3Iu/2yPZVm0iEMiqS5w6zAtHcq/NK1EL0BpV15cpIHLt+FzE2AAUgvPp60fd8zyMUBnd9gFCvHN2rtbmMYIeh2cvFDx8VhHDTYPAQaM5lUYSgS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094536; c=relaxed/simple;
	bh=cdVk/TnfRyeFBipr09GBNE1IUiZFHn/zsmtWbkWkQto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeoyxKIpZAVshNFY/j5yC7kRdRRFYuJ84fu2ojwla5TYRK36LGb5S/aZ4Zo0Wo8Rq4rziKpmW8QUKnh1ROuXLZIhpVVfLM/A30ownUkaHKKGijCxHargC+hVbXiH17Re1lxJCqT/pBns5uIlRoebl7/zdmUpSWRuZ2mDT+dfvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teQATJKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C71C2BCAF;
	Mon, 13 Apr 2026 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776094536;
	bh=cdVk/TnfRyeFBipr09GBNE1IUiZFHn/zsmtWbkWkQto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teQATJKtRRBzXUBQ8g2zX0x4ARTfR9LlfjfLek7U3vXnJDa62WZPxO4kMy5csknKg
	 klr+5Q0iteY827MCPmmso/LtxG/PNrGohSV7/qXNreoHF1QZ5U1cbSmtJq8osE7w6f
	 soHut9Q1sJ0WTrQ4vOJ65H5lL4HYoUntGQMBJYhHfvwotrZboa72dkaBlpgEnYsG9n
	 vNCb7GVIS++UaHcgvWfNiZ+eQvi2BhAIdIvi58FxkxSv/UZhUfVfytKpG9Dq/HWDcb
	 N2GOUsc1v31HYzyiGwMTb3D/6Bku1x1RX5nz+bSZBfCEN9fQ2bsidSgpPSUYUD4Xb7
	 qWIjFLOGOP5CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	syzbot+62c1793956716ea8b28a@syzkaller.appspotmail.com,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] ocfs2: fix out-of-bounds write in ocfs2_write_end_inline
Date: Mon, 13 Apr 2026 11:35:30 -0400
Message-ID: <20260413153531.3097531-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413153531.3097531-1-sashal@kernel.org>
References: <2026041351-barbecue-conductor-c8e7@gregkh>
 <20260413153531.3097531-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,syzkaller.appspotmail.com,fasheh.com,evilplan.org,oracle.com,live.cn,huawei.com,suse.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236146-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,62c1793956716ea8b28a];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B1E73EE1FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit 7bc5da4842bed3252d26e742213741a4d0ac1b14 ]

KASAN reports a use-after-free write of 4086 bytes in
ocfs2_write_end_inline, called from ocfs2_write_end_nolock during a
copy_file_range splice fallback on a corrupted ocfs2 filesystem mounted on
a loop device.  The actual bug is an out-of-bounds write past the inode
block buffer, not a true use-after-free.  The write overflows into an
adjacent freed page, which KASAN reports as UAF.

The root cause is that ocfs2_try_to_write_inline_data trusts the on-disk
id_count field to determine whether a write fits in inline data.  On a
corrupted filesystem, id_count can exceed the physical maximum inline data
capacity, causing writes to overflow the inode block buffer.

Call trace (crash path):

   vfs_copy_file_range (fs/read_write.c:1634)
     do_splice_direct
       splice_direct_to_actor
         iter_file_splice_write
           ocfs2_file_write_iter
             generic_perform_write
               ocfs2_write_end
                 ocfs2_write_end_nolock (fs/ocfs2/aops.c:1949)
                   ocfs2_write_end_inline (fs/ocfs2/aops.c:1915)
                     memcpy_from_folio     <-- KASAN: write OOB

So add id_count upper bound check in ocfs2_validate_inode_block() to
alongside the existing i_size check to fix it.

Link: https://lkml.kernel.org/r/20260403063830.3662739-1-joseph.qi@linux.alibaba.com
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reported-by: syzbot+62c1793956716ea8b28a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=62c1793956716ea8b28a
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index e614b5981ae2c..26a0d4ef8829d 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1430,6 +1430,16 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 			goto bail;
 		}
 
+		if (le16_to_cpu(data->id_count) >
+		    ocfs2_max_inline_data_with_xattr(sb, di)) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode #%llu: inline data id_count %u exceeds max %d\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(data->id_count),
+					 ocfs2_max_inline_data_with_xattr(sb, di));
+			goto bail;
+		}
+
 		if (le64_to_cpu(di->i_size) > le16_to_cpu(data->id_count)) {
 			rc = ocfs2_error(sb,
 					 "Invalid dinode #%llu: inline data i_size %llu exceeds id_count %u\n",
-- 
2.53.0


