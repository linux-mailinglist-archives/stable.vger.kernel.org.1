Return-Path: <stable+bounces-236150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CYQEDkP3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:43:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3173EE1E8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32A05300DCEB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C53BAD9F;
	Mon, 13 Apr 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfXwV7Ly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6B7262F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095031; cv=none; b=YRN6erplrWViWtJEbjrKIh724QPqowzaSUcNGlr9KKOLR+Dsl1PUrmYfw3FlbBAK/T+dZKjikOJNs07x7ZW/EErj1kOZ6KZ7IhG3P0rdCxYxlfakcqFPhXxwSXaWzF94uQyHhOWSzpYID9MYsSUdVJHo4/JeNsRUstnfrqbagpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095031; c=relaxed/simple;
	bh=Y9Vc77yDHBPJ4X8pnsSuv1KyvRrIFHmKy1tRMHMf49s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFb8mAyGZxkZyg1fpkr4W0NhSbpyqnXfEeZh5sLp/MEQc6U18ZLMa3s4IFgtBNdbta4ioIMZ5mFolNZ+OcfRzIfAD5/vU+7CkfK851xCGEUOX1K5IayXXjufwoIAmj7As0FvWSUwXDwrBdtHw1gHTQaV4LSVRt3DKhrgmU1kKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfXwV7Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4C5C2BCB6;
	Mon, 13 Apr 2026 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776095031;
	bh=Y9Vc77yDHBPJ4X8pnsSuv1KyvRrIFHmKy1tRMHMf49s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfXwV7LyMbKGk9j4qQKEotkdRKtFn7wT/BpUO87HZ7m9IvJFOHpp43TZRrvBfwic+
	 Se0snDJ7lQYeRDJCq5rCNPbS3nqSk2F4kwapq1zT11jLKuQXlxdybHzsvSLbiYPoND
	 sE3i2BbxzI1irz49+nAQJO33DPy68teNEbK6We683U95zuv3O5RkoIOFJOq/RcttT/
	 SQjyvnrOqN6vXv7REQR1SvEvmIaVEajdmoE77KKnQM+9hyX/EPILUbeNN+t1qSI91b
	 j9VR7LQuoZ2SN8xzCVPBWkB5ATsADD0zcGXcVkHvUpxD2Sw7YWBhP+K0ReCgq1HL1C
	 yaFsJlV2RgcXA==
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
Subject: [PATCH 6.1.y 3/3] ocfs2: fix out-of-bounds write in ocfs2_write_end_inline
Date: Mon, 13 Apr 2026 11:43:45 -0400
Message-ID: <20260413154345.3124558-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413154345.3124558-1-sashal@kernel.org>
References: <2026041352-oppressor-guidable-7094@gregkh>
 <20260413154345.3124558-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,syzkaller.appspotmail.com,fasheh.com,evilplan.org,oracle.com,live.cn,huawei.com,suse.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236150-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD3173EE1E8
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
index bd882bf384b3f..04c8eecc66c92 100644
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


