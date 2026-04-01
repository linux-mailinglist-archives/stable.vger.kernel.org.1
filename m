Return-Path: <stable+bounces-232866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBIMN0ePzWn4ewYAu9opvQ
	(envelope-from <stable+bounces-232866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:33:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D821380A09
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F7CC303B2D0
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 21:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7F032A3E1;
	Wed,  1 Apr 2026 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U2TZJRKE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEECF2673B0;
	Wed,  1 Apr 2026 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775079232; cv=none; b=a2Mr0IZYxSXtCq/Cxd0BwscLmtv1sJoE0RrtdrsnsSG8+F7jeeYwbdbZMv9mCZMtQ9ZG+vqyUF+FsgFgCMz2qcZNNiIj4gCn7ElZHz4oLA4tWdR6fJJofitbb9FBL0ddfi8tQivR8ulv+CBcXKdgqlzAd+bariy9Lis+6mEw/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775079232; c=relaxed/simple;
	bh=mWMxSmnlBADZ27xepfqTEImAm/Tn25hFSaGEnX3CeL4=;
	h=Date:To:From:Subject:Message-Id; b=Md3mA2BsMlAosWkNFjmRhoReIxqUoTmqPQE6SMzwXHjnECcFliXu6BjZETmo22cmZJhwBI4wx+gcMLFfX+kn/Xgvg0Cfp/OeD7gzMEph9TJDYzQchRJ3j8ctSCyH/zOp4xFZ3BkcMThG37aU4fG5kS4/9TEnEi+gNH8ObF/zFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U2TZJRKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41316C4CEF7;
	Wed,  1 Apr 2026 21:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775079232;
	bh=mWMxSmnlBADZ27xepfqTEImAm/Tn25hFSaGEnX3CeL4=;
	h=Date:To:From:Subject:From;
	b=U2TZJRKEKkFbcQmiql+98Z/q19iySqjlJ5q6zIT3B3dX5U7eRZNAjlaAIZA+ycDjs
	 X4MiYQu2p951N3GLl/pXYDumXz+64AsNLfo8G1X7InmpFX/7B/XyjDcoULxFDubZJq
	 NjRRUp+6y1v24SHz3hdg0bcCVXtHDcjVePeQ0yps=
Date: Wed, 01 Apr 2026 14:33:51 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,joseph.qi@linux.alibaba.com,jlbec@evilplan.org,heming.zhao@suse.com,gechangwei@live.cn,gality369@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + ocfs2-handle-invalid-dinode-in-ocfs2_group_extend.patch added to mm-nonmm-unstable branch
Message-Id: <20260401213352.41316C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232866-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,linux.alibaba.com,evilplan.org,suse.com,live.cn,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,live.cn:email,suse.com:email]
X-Rspamd-Queue-Id: 2D821380A09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: ocfs2: handle invalid dinode in ocfs2_group_extend
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     ocfs2-handle-invalid-dinode-in-ocfs2_group_extend.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/ocfs2-handle-invalid-dinode-in-ocfs2_group_extend.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: ZhengYuan Huang <gality369@gmail.com>
Subject: ocfs2: handle invalid dinode in ocfs2_group_extend
Date: Wed, 1 Apr 2026 17:23:03 +0800

[BUG]
kernel BUG at fs/ocfs2/resize.c:308!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
RIP: 0010:ocfs2_group_extend+0x10aa/0x1ae0 fs/ocfs2/resize.c:308
Code: 8b8520ff ffff83f8 860f8580 030000e8 5cc3c1fe
Call Trace:
 ...
 ocfs2_ioctl+0x175/0x6e0 fs/ocfs2/ioctl.c:869
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x197/0x1e0 fs/ioctl.c:583
 x64_sys_call+0x1144/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ...

[CAUSE]
ocfs2_group_extend() assumes that the global bitmap inode block
returned from ocfs2_inode_lock() has already been validated and
BUG_ONs when the signature is not a dinode. That assumption is too
strong for crafted filesystems because the JBD2-managed buffer path
can bypass structural validation and return an invalid dinode to the
resize ioctl.

[FIX]
Validate the dinode explicitly in ocfs2_group_extend(). If the global
bitmap buffer does not contain a valid dinode, report filesystem
corruption with ocfs2_error() and fail the resize operation instead of
crashing the kernel.

Link: https://lkml.kernel.org/r/20260401092303.3709187-1-gality369@gmail.com
Fixes: 10995aa2451a ("ocfs2: Morph the haphazard OCFS2_IS_VALID_DINODE() checks.")
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/resize.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/ocfs2/resize.c~ocfs2-handle-invalid-dinode-in-ocfs2_group_extend
+++ a/fs/ocfs2/resize.c
@@ -303,9 +303,13 @@ int ocfs2_group_extend(struct inode * in
 
 	fe = (struct ocfs2_dinode *)main_bm_bh->b_data;
 
-	/* main_bm_bh is validated by inode read inside ocfs2_inode_lock(),
-	 * so any corruption is a code bug. */
-	BUG_ON(!OCFS2_IS_VALID_DINODE(fe));
+	/* JBD-managed buffers can bypass validation, so treat this as corruption. */
+	if (!OCFS2_IS_VALID_DINODE(fe)) {
+		ret = ocfs2_error(main_bm_inode->i_sb,
+				  "Invalid dinode #%llu\n",
+				  (unsigned long long)OCFS2_I(main_bm_inode)->ip_blkno);
+		goto out_unlock;
+	}
 
 	if (le16_to_cpu(fe->id2.i_chain.cl_cpg) !=
 		ocfs2_group_bitmap_size(osb->sb, 0,
_

Patches currently in -mm which might be from gality369@gmail.com are

ocfs2-validate-bg_list-extent-bounds-in-discontig-groups.patch
ocfs2-handle-invalid-dinode-in-ocfs2_group_extend.patch


