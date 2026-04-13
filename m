Return-Path: <stable+bounces-236029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEEEM5Lf3GnrXgkAu9opvQ
	(envelope-from <stable+bounces-236029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:20:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE13EBD40
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBD61305E374
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8107A3BE17F;
	Mon, 13 Apr 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AEFfMH44"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A7346AD6
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082451; cv=none; b=QDNmyd7di9nD5YdhAsJP9WRJwei1S0PIMUau3l44XWcYNsAvYNwenBpD2XrdZv0TmO+1MQQpknkraDmU8s+mRDYmigmQ4SUoJGfc42OHZLzObqtKuzIaSrBFFPKK4I7Nk5x2F1kXAd8pfCIWGpjeCbZYzteYk55sQJjgKMiT5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082451; c=relaxed/simple;
	bh=qg86gjNIUFqsm+wKhbWoYmqU8JAzSRyvSrmIPOTOfcI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PYPjyaGlYTcXNtvQA/4U8u4nGDhW2qloJCu53O34MS3tk6pKZLZPegXrdSeNzNcc698HaaJHfi/Vfems8t75A26gAbFf79zUzTdbFvKIJJDGMk0BHQtOhriLNp9Q9mP/1rQZ/2Y8+102GMufCXGJcgxfy5nxKNRBkyQYCmhCWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AEFfMH44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDCEC116C6;
	Mon, 13 Apr 2026 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776082451;
	bh=qg86gjNIUFqsm+wKhbWoYmqU8JAzSRyvSrmIPOTOfcI=;
	h=Subject:To:Cc:From:Date:From;
	b=AEFfMH443WXN7cBB65xy9TT/tWMkjurCecNEQM1YcM81W4SKoUAZ9LAI3rR10dCPl
	 38LZdmThXkO002qyZ2HjvNa+xZKJxcC7Kf7us+RipZWBKAkv8pzN6DMawkV+IvlUW7
	 74xwyCXWZlse+Pbbeuk26U5mFRwgrF33G6lQAhRQ=
Subject: FAILED: patch "[PATCH] ocfs2: fix out-of-bounds write in ocfs2_write_end_inline" failed to apply to 5.10-stable tree
To: joseph.qi@linux.alibaba.com,akpm@linux-foundation.org,gechangwei@live.cn,heming.zhao@suse.com,jlbec@evilplan.org,junxiao.bi@oracle.com,mark@fasheh.com,piaojun@huawei.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:13:54 +0200
Message-ID: <2026041354-dork-imperial-5aba@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236029-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.alibaba.com,linux-foundation.org,live.cn,suse.com,evilplan.org,oracle.com,fasheh.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40CE13EBD40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7bc5da4842bed3252d26e742213741a4d0ac1b14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041354-dork-imperial-5aba@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7bc5da4842bed3252d26e742213741a4d0ac1b14 Mon Sep 17 00:00:00 2001
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Date: Fri, 3 Apr 2026 14:38:30 +0800
Subject: [PATCH] ocfs2: fix out-of-bounds write in ocfs2_write_end_inline

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

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 03a51662ea8e..a2ccd8011706 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1505,6 +1505,16 @@ int ocfs2_validate_inode_block(struct super_block *sb,
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


