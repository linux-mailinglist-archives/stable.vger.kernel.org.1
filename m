Return-Path: <stable+bounces-236158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLM6BcwQ3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:50:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D53EE2E9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 350863008C98
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DE9318EF4;
	Mon, 13 Apr 2026 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh6GsFZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C08286D5E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095431; cv=none; b=AZv6VnPv1jkR2Mso6KvQtIMxLxNy0OS8hb6aii06LA8DSiknHRCa2QB7xNL5L7ZuJB6Edzl7RQHQj6PROScLsQOwaxEBr6koIguDOb1G1i9EFbZGNg7eObvihSMdMqoZ9ygND9lS6t8ehluFeTrIC87KKThHzafyc1CeEB5cQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095431; c=relaxed/simple;
	bh=X0hdRl494d49qU1E6wKPd7lLI0sbEvaZJC3jrT71Kok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxURvIPFutdn20mW3wjqbztlPKvCi38jt4rtVUG74xT1Wo47aFH5HdlJ5W0q01y2RW92zRFGyZ1P9S17xCXIvz0ubCRo9MYd8NjFwSv5foPFs4irvSY2vZfLVNkT1v/+3eEtsaVMfiwPfoRSs+7ta6nmWHdabJVMwr9KHBZVuNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh6GsFZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AEFC2BCB4;
	Mon, 13 Apr 2026 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776095430;
	bh=X0hdRl494d49qU1E6wKPd7lLI0sbEvaZJC3jrT71Kok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uh6GsFZ9fBILsefargGXzxjJFslllfGNwGKK9lyiyytRIfZTOB413gjZEdh6OD04+
	 Tyr7ahm4Wa+ASdrMGW7iValcQ9vF8QocvmKLQIP6M2B4nP4YBL+UgksGN2mViQRKeZ
	 /kL/MUsq7V0bRxIlURuWwBQbZlPwaBsL1GHUgKJQpuCe4GCMRYYmsU94EvmAMdPtvB
	 YveUGmXXwkPFDO3xw84TcAcVCdGXkY1DsBV+f6ieW1OzusTeBY2lfNKDSJzYa4idIQ
	 obhX3YVMGF4pAtXvU2GzRwX3KhpQ2dIaO6H2vfN8R/rbBaIiYGMWToLz3qL5NsSoVI
	 akUoFL1twUcVg==
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
Subject: [PATCH 5.15.y 3/3] ocfs2: fix out-of-bounds write in ocfs2_write_end_inline
Date: Mon, 13 Apr 2026 11:50:25 -0400
Message-ID: <20260413155025.3145781-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155025.3145781-1-sashal@kernel.org>
References: <2026041353-swimmer-skied-a346@gregkh>
 <20260413155025.3145781-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,syzkaller.appspotmail.com,fasheh.com,evilplan.org,oracle.com,live.cn,huawei.com,suse.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236158-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable,62c1793956716ea8b28a];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 341D53EE2E9
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
index 0c11e298ec282..ead61176b0f28 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1427,6 +1427,16 @@ int ocfs2_validate_inode_block(struct super_block *sb,
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


