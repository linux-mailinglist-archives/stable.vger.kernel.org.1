Return-Path: <stable+bounces-273138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O9BrKmF9UGrMzwIAu9opvQ
	(envelope-from <stable+bounces-273138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:04:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E48FB73735F
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:04:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="q/94u1uU";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273138-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273138-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4800300BCB3
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7313749E1;
	Fri, 10 Jul 2026 05:04:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE682673B0;
	Fri, 10 Jul 2026 05:04:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783659866; cv=none; b=s/4o/JfE8F9SCwYFylKy3xIObdFKnHCr7N0oY1GKn2SPrGett6I6HDUTFCMhE8DpcYUL4yNXHtjn01Yk7ryP3CercGM+eu4KDz5ozG7S3smPjjRDc/IGUA2yt/9xAxSdZoD9R+fZR0Dbe4vf7JcKyCtDfAS8n3fviPb0pMwQ5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783659866; c=relaxed/simple;
	bh=4GCZTsjsHYacD5mHqMa7Rj3px0ezGyg3rrTqHoUWDv8=;
	h=Date:To:From:Subject:Message-Id; b=LlS8clza1koBr+2Jl7TFK6IImdS8JrxMJjDX0SZkWKcPv7XzDYPa+cEhgaR3CEEjrxMTTvzfoYhY1Y94n2eMUIi4BYgn/egtdxvoeN/imn6CD1Ryniio8OKpEXaa04CX1xpJoCtRYOrSouHew5dnCerM84EQikch6qsL9DyxErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=q/94u1uU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9641F000E9;
	Fri, 10 Jul 2026 05:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783659865;
	bh=1Pk/1QQfoSsadFi9xLmIrV+XNF/Vnm3t2DspH1CXKiA=;
	h=Date:To:From:Subject;
	b=q/94u1uUpPVOyWy/s+wEbu7sJyTQK4Dsqz3l+R9q2NLrx+NMBJu1uIHbn0mwdk58c
	 XEe/KUWJHOAtaQKTsDcU5wIvrWcuH5Ht/ikz6b5wM8+S4IpIUbm7iqUUzL9w8vYdmB
	 UcuL3N1RyGEDPlAxeZXx6BKmaryK/Knf51vwXfLI=
Date: Thu, 09 Jul 2026 22:04:24 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,jlbec@evilplan.org,heming.zhao@suse.com,gechangwei@live.cn,joseph.qi@linux.alibaba.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + ocfs2-fix-boundary-check-in-ocfs2_check_dir_entry-to-use-buffer-offset.patch added to mm-hotfixes-unstable branch
Message-Id: <20260710050424.DB9641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273138-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:piaojun@huawei.com,m:mark@fasheh.com,m:junxiao.bi@oracle.com,m:jlbec@evilplan.org,m:heming.zhao@suse.com,m:gechangwei@live.cn,m:joseph.qi@linux.alibaba.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,evilplan.org,suse.com,live.cn,linux.alibaba.com,linux-foundation.org];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E48FB73735F


The patch titled
     Subject: ocfs2: fix boundary check in ocfs2_check_dir_entry() to use buffer offset
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     ocfs2-fix-boundary-check-in-ocfs2_check_dir_entry-to-use-buffer-offset.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/ocfs2-fix-boundary-check-in-ocfs2_check_dir_entry-to-use-buffer-offset.patch

This patch will later appear in the mm-hotfixes-unstable branch at
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
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: ocfs2: fix boundary check in ocfs2_check_dir_entry() to use buffer offset
Date: Fri, 10 Jul 2026 12:05:12 +0800

Commit 390ac56cf0f6 ("ocfs2: add boundary check to
ocfs2_check_dir_entry()") added an out-of-bounds guard using the
caller-supplied 'offset' argument:

	if (offset > size - OCFS2_DIR_REC_LEN(1))
		return 0;

However, 'offset' and 'size' are not measured against the same base for
all callers.  In the block-based lookup path, ocfs2_find_entry_el() passes
'offset' as an absolute offset into the whole directory:

	i = ocfs2_search_dirblock(bh, dir, name, namelen,
				  block << sb->s_blocksize_bits,
				  bh->b_data, sb->s_blocksize, res_dir);

while 'size' is a single block size (sb->s_blocksize).  For any directory
entry located in the second or later block, 'offset' is >=
sb->s_blocksize, so the guard rejects every such entry even though it is
perfectly valid and lies entirely within its block buffer.

This makes mounting fail for filesystems whose system directory spans more
than one block, e.g.  a volume formatted with a small block size:

  mkfs.ocfs2 -b 512 -C 4096 -N 2 -T datafiles --fs-features=usrquota,grpquota

  ocfs2_check_dir_entry:314 ERROR: directory entry (#18: offset=512) too close to end or out-of-bounds
  ocfs2_init_local_system_inodes:496 ERROR: status=-22, sysfile=12, slot=0
  ocfs2_mount_volume:1757 ERROR: status = -22

The dirent's position within the buffer being validated is ((char *)de -
buf), which is what the rest of the function already uses (via
next_offset) and what must be bounds-checked against 'size'.  Compute that
buffer-relative offset and use it for the guard.  The subtraction is
reordered to size - buf_offset < OCFS2_DIR_REC_LEN(1) to avoid an unsigned
underflow when size is smaller than the minimal record length.

Link: https://lore.kernel.org/20260710040512.3310736-1-joseph.qi@linux.alibaba.com
Fixes: 390ac56cf0f6 ("ocfs2: add boundary check to ocfs2_check_dir_entry()")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/dir.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/ocfs2/dir.c~ocfs2-fix-boundary-check-in-ocfs2_check_dir_entry-to-use-buffer-offset
+++ a/fs/ocfs2/dir.c
@@ -302,10 +302,11 @@ static int ocfs2_check_dir_entry(struct
 				 unsigned long offset)
 {
 	const char *error_msg = NULL;
+	unsigned long buf_offset = (char *)de - buf;
 	unsigned long next_offset;
 	int rlen;
 
-	if (offset > size - OCFS2_DIR_REC_LEN(1)) {
+	if (buf_offset > size || size - buf_offset < OCFS2_DIR_REC_LEN(1)) {
 		/* Dirent is (maybe partially) beyond the buffer
 		 * boundaries so touching 'de' members is unsafe.
 		 */
@@ -316,7 +317,7 @@ static int ocfs2_check_dir_entry(struct
 	}
 
 	rlen = le16_to_cpu(de->rec_len);
-	next_offset = ((char *) de - buf) + rlen;
+	next_offset = buf_offset + rlen;
 
 	if (unlikely(rlen < OCFS2_DIR_REC_LEN(1)))
 		error_msg = "rec_len is smaller than minimal";
_

Patches currently in -mm which might be from joseph.qi@linux.alibaba.com are

ocfs2-fix-boundary-check-in-ocfs2_check_dir_entry-to-use-buffer-offset.patch


