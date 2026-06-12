Return-Path: <stable+bounces-262833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bgGzCn9fK2pg8QMAu9opvQ
	(envelope-from <stable+bounces-262833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 03:23:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB36761BD
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 03:23:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="tXIR/rVS";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262833-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262833-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2FE311B027
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E92FC898;
	Fri, 12 Jun 2026 01:23:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3A13B58A;
	Fri, 12 Jun 2026 01:23:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227386; cv=none; b=HF4b7meT6Nov6WIrzIfb9YayOiJp3Rh9IGumkUZDeaimeuX5PCTSvoSXwV+T0rSLSXewtu0drXV3x0hDFj7grl2dlPTaQpdbuItYdl9wa1mEimCeO0xyjGBw2iebgMbtoe3tFI23jG6drM/TkHI+2lGCv/a/2G9jP1kHfzAFguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227386; c=relaxed/simple;
	bh=YySmRN2InHe0zbzE26gk6WYa22vR2Y/cLM5ZStbxsHg=;
	h=Date:To:From:Subject:Message-Id; b=j4TT8iERSoct44POWLTYO3eCXbglSPKvjcQx7Bf1aWa+FcbIv2HMEeKh73Rf0beb/Kz9H0mQUMuey6+uzaTAfASB5e+gyKz4+hfFMTai0GFntcoMT6lbtKQY5jiFJ/gaahcOaQw9q9wxxaW6ho2EUY69GE2cOb3du9bIaSsGggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tXIR/rVS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911CB1F000E9;
	Fri, 12 Jun 2026 01:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1781227381;
	bh=KlkYP8VAdnveSJkJ3+ASbCy7DrQBC0Wwd1FAHB51ztU=;
	h=Date:To:From:Subject;
	b=tXIR/rVS79NH/97n8iBv7Qp4hyJ1S+6buAjLw3qcwqZxBupPGZpZAugMcGNrVWVrQ
	 Xg6I+2+2XGDlxR1lf/v8pPnO8L8hDLHIi4fHq07aa05JH2BCRdVRd7y9SelqrJlI4E
	 hlMU0UIHTSaCy1F0FmPjRvOXcI+ndmgzZ/FeFfys=
Date: Thu, 11 Jun 2026 18:23:01 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,joseph.qi@linux.alibaba.com,jlbec@evilplan.org,heming.zhao@suse.com,gechangwei@live.cn,icb@fastmail.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + ocfs2-fix-ubsan-array-index-out-of-bounds-in-ocfs2_sum_rightmost_rec.patch added to mm-nonmm-unstable branch
Message-Id: <20260612012301.911CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:piaojun@huawei.com,m:mark@fasheh.com,m:junxiao.bi@oracle.com,m:joseph.qi@linux.alibaba.com,m:jlbec@evilplan.org,m:heming.zhao@suse.com,m:gechangwei@live.cn,m:icb@fastmail.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262833-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,linux.alibaba.com,evilplan.org,suse.com,live.cn,fastmail.org,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78BB36761BD


The patch titled
     Subject: ocfs2: fix UBSAN array-index-out-of-bounds in ocfs2_sum_rightmost_rec
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     ocfs2-fix-ubsan-array-index-out-of-bounds-in-ocfs2_sum_rightmost_rec.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/ocfs2-fix-ubsan-array-index-out-of-bounds-in-ocfs2_sum_rightmost_rec.patch

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
From: Ian Bridges <icb@fastmail.org>
Subject: ocfs2: fix UBSAN array-index-out-of-bounds in ocfs2_sum_rightmost_rec
Date: Wed, 10 Jun 2026 19:23:11 -0500

[BUG]
On-disk corruption setting l_next_free_rec to 0 in an inode's embedded
extent list triggers a UBSAN panic on the next write to that file.

[CAUSE]
ocfs2_sum_rightmost_rec() computes
i = le16_to_cpu(el->l_next_free_rec) - 1
and accesses el->l_recs[i] without validating i. When l_next_free_rec
is 0, i becomes -1; when l_next_free_rec exceeds l_count, i falls
past the end of the array. Either case violates the
__counted_by_le(l_count) annotation on l_recs[] and triggers UBSAN.

[FIX]
Validate the inode's embedded extent list when the inode is read, in
ocfs2_validate_inode_block(): l_count must be non-zero and no larger
than the inode block can hold, and l_next_free_rec must not exceed
l_count. A corrupt list is rejected at read time, before the b-tree
code can index l_recs[] out of bounds.

Link: https://lore.kernel.org/ain_780qc0P4ypNd@dev
Signed-off-by: Ian Bridges <icb@fastmail.org>
Reported-by: syzbot+be16e33db01e6644db7a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be16e33db01e6644db7a
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

 fs/ocfs2/inode.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/fs/ocfs2/inode.c~ocfs2-fix-ubsan-array-index-out-of-bounds-in-ocfs2_sum_rightmost_rec
+++ a/fs/ocfs2/inode.c
@@ -1696,6 +1696,38 @@ int ocfs2_validate_inode_block(struct su
 		goto bail;
 	}
 
+	if (ocfs2_dinode_has_extents(di)) {
+		struct ocfs2_extent_list *el = &di->id2.i_list;
+		u16 count = le16_to_cpu(el->l_count);
+		u16 next_free = le16_to_cpu(el->l_next_free_rec);
+
+		if (count == 0) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode %llu: extent list l_count is zero\n",
+					 (unsigned long long)bh->b_blocknr);
+			goto bail;
+		}
+		/*
+		 * The exact capacity depends on i_xattr_inline_size, another
+		 * unvalidated on-disk field. Inline xattrs only shrink the
+		 * list, so the no-xattr maximum is a safe upper bound that a
+		 * valid l_count never exceeds.
+		 */
+		if (count > ocfs2_extent_recs_per_inode(sb)) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode %llu: extent list l_count %u exceeds max %u\n",
+					 (unsigned long long)bh->b_blocknr, count,
+					 ocfs2_extent_recs_per_inode(sb));
+			goto bail;
+		}
+		if (next_free > count) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode %llu: extent list l_next_free_rec %u exceeds l_count %u\n",
+					 (unsigned long long)bh->b_blocknr, next_free, count);
+			goto bail;
+		}
+	}
+
 	rc = 0;
 
 bail:
_

Patches currently in -mm which might be from icb@fastmail.org are

ocfs2-fix-ubsan-array-index-out-of-bounds-in-ocfs2_sum_rightmost_rec.patch


