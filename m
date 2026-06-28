Return-Path: <stable+bounces-269438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yDiuBLt6QGpqfwkAu9opvQ
	(envelope-from <stable+bounces-269438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:36:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB706D2EDA
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:36:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=ubSpsty6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269438-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269438-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A69B301700E
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 01:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426431A08A3;
	Sun, 28 Jun 2026 01:36:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DFEEC0;
	Sun, 28 Jun 2026 01:36:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782610614; cv=none; b=HoI3ApRRe6HScxckgQmNbNRdSH1w5i/D8PX+U5HimLC2jrAdmEJs6UJxd/dOp/ibfqL9QxZ6GjEoH65hVXoMQD5nhQ2kw5GnFCsBpwWoZX+SjfFrK6JZavpENK+2pLEFA08thNdXqKKGxQqmEQbOiS+jx47GPSiCPqDsChtOmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782610614; c=relaxed/simple;
	bh=qcyT18ycfgs67qeBeGLSw680gcNmqxnv+2QGvTVVH64=;
	h=Date:To:From:Subject:Message-Id; b=iDWIeIecvhRpNHr6pAuNPqPjWNtqt/2eJSlBOYGTXOjMiyM6ggXDfeB8krHGItSWQtWAidsmUZpMIEc9dQtY3revyParJr+u0hUjxudHaTRNQVAWkPT4AMci3dxCykBI/A5fw77z6cHHs0mukXMumq5b6hLahMX2gP5qzDOmmiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ubSpsty6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBDE1F000E9;
	Sun, 28 Jun 2026 01:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782610612;
	bh=4ayx45IuqpUBVfUPNG6TijbKmA66iUihHOUZXkkdfuE=;
	h=Date:To:From:Subject;
	b=ubSpsty6vaTEh9LRYanM1L+PH9qAIcXBto8YuabribI0/FkkqGCmZLKCTO4Ga5vc1
	 yut3JUzuBDd0b9CdpghlmQnKtILhkq7qh9NQl/1obqOPvOafWqdpSEA1wcZXxgaZ1Z
	 QDHeUTz4yDNOr8GhDYT2Aixg9xzYQ9EYSjlmPxB0=
Date: Sat, 27 Jun 2026 18:36:51 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,hughd@google.com,baolin.wang@linux.alibaba.com,alhouseenyousef@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + tmpfs-zero-unused-folio-tail-for-long-symlinks.patch added to mm-new branch
Message-Id: <20260628013652.3EBDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:alhouseenyousef@gmail.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,google.com,linux.alibaba.com,gmail.com,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-269438-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CB706D2EDA


The patch titled
     Subject: tmpfs: zero unused folio tail for long symlinks
has been added to the -mm mm-new branch.  Its filename is
     tmpfs-zero-unused-folio-tail-for-long-symlinks.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/tmpfs-zero-unused-folio-tail-for-long-symlinks.patch

This patch will later appear in the mm-new branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Note, mm-new is a provisional staging ground for work-in-progress
patches, and acceptance into mm-new is a notification for others take
notice and to finish up reviews.  Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.

The mm-new branch of mm.git is not included in linux-next

If a few days of testing in mm-new is successful, the patch will me moved
into mm.git's mm-unstable branch, which is included in linux-next

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
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: tmpfs: zero unused folio tail for long symlinks
Date: Sun, 28 Jun 2026 02:43:14 +0200

shmem_symlink() marks the entire folio uptodate after copying only the
NUL-terminated link target.  The remainder of the freshly allocated folio
is left uninitialized.

Reclaim may pass the whole folio to a swap compressor.  KMSAN observed
sw842_compress() computing a checksum over the uninitialized tail.  If the
folio is written to a swap device, those bytes can also leave the kernel.

Zero the remainder of the folio before marking it uptodate and dirty.

Link: https://lore.kernel.org/20260628004314.27370-1-alhouseenyousef@gmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bf5586280a66e9ccdfa9
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/shmem.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/shmem.c~tmpfs-zero-unused-folio-tail-for-long-symlinks
+++ a/mm/shmem.c
@@ -4057,6 +4057,7 @@ static int shmem_symlink(struct mnt_idma
 			goto out_remove_offset;
 		inode->i_op = &shmem_symlink_inode_operations;
 		memcpy(folio_address(folio), symname, len);
+		folio_zero_range(folio, len, folio_size(folio) - len);
 		folio_mark_uptodate(folio);
 		folio_mark_dirty(folio);
 		folio_unlock(folio);
_

Patches currently in -mm which might be from alhouseenyousef@gmail.com are

tmpfs-zero-unused-folio-tail-for-long-symlinks.patch


