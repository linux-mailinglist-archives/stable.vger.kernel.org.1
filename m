Return-Path: <stable+bounces-216891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CND2EpG5lGlmHQIAu9opvQ
	(envelope-from <stable+bounces-216891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:55:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED1314F650
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0C92301BF6A
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D1374190;
	Tue, 17 Feb 2026 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wQTThFC6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8F33CE80;
	Tue, 17 Feb 2026 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354496; cv=none; b=hvQoDmxjqIxrWxi0boYB3uGDhUexstkPa+OzT8a3+4uD6V+q8VOUqI91pL6n7FaSFStt/fff+VYYHF7I/u5foHva9Ihq2CwXuXvz1JFOXFt+n1oIuCVaBQqAi1vmKVSkkDdXdE5qdERSmrSCU/cKLrmZvBFAZnmqLkLEIMJOPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354496; c=relaxed/simple;
	bh=JJE0Hx6jzZgjhwlkZO/l08SngRVGoAnjVveZaJvLr0o=;
	h=Date:To:From:Subject:Message-Id; b=XIFX4WeomU9VadkpSm55yQfSag95BhIkcNsBW2Rci+zjH7CPCLP3QQ97P3otKB3K125wIlxsXOVnNG0CYFxsTKKAHt2lbL5vtITr7OSGQ2D5jyWbctUWlPbmizCLNxNXHNVA3sHbfxdAgMZKtq5CaWU9+pJrrfNDEg7PfU/aJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wQTThFC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A3FC4CEF7;
	Tue, 17 Feb 2026 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771354495;
	bh=JJE0Hx6jzZgjhwlkZO/l08SngRVGoAnjVveZaJvLr0o=;
	h=Date:To:From:Subject:From;
	b=wQTThFC6t5mjbSe5Qz8jgxFEcU47Gh5J4QWQg72jmRKHbT09R7cP+NhSMyyjodqM5
	 ur7qycNBpJxc8ciavijnbS2nc474dhAOrRLLzSg/Ew4vFdgkoV055jaXssCshIEuZD
	 AM3SPiUC1WhY+i4iakqdWxpKkviqJGJuyqjINv3Y=
Date: Tue, 17 Feb 2026 10:54:54 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,brauner@kernel.org,phillip@squashfs.org.uk,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + squashfs-check-metadata-block-offset-is-within-range.patch added to mm-hotfixes-unstable branch
Message-Id: <20260217185455.80A3FC4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216891-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,linux-foundation.org:dkim,squashfs.org.uk:email,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 9ED1314F650
X-Rspamd-Action: no action


The patch titled
     Subject: Squashfs: check metadata block offset is within range
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     squashfs-check-metadata-block-offset-is-within-range.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/squashfs-check-metadata-block-offset-is-within-range.patch

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
From: Phillip Lougher <phillip@squashfs.org.uk>
Subject: Squashfs: check metadata block offset is within range
Date: Tue, 17 Feb 2026 05:09:55 +0000

Syzkaller reports a "general protection fault in squashfs_copy_data"

This is ultimately caused by a corrupted index look-up table, which
produces a negative metadata block offset.

This is subsequently passed to squashfs_copy_data (via
squashfs_read_metadata) where the negative offset causes an out of bounds
access.

The fix is to check that the offset is within range in
squashfs_read_metadata.  This will trap this and other cases.

Link: https://lkml.kernel.org/r/20260217050955.138351-1-phillip@squashfs.org.uk
Fixes: f400e12656ab ("Squashfs: cache operations")
Reported-by: syzbot+a9747fe1c35a5b115d3f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/699234e2.a70a0220.2c38d7.00e2.GAE@google.com/
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/squashfs/cache.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/squashfs/cache.c~squashfs-check-metadata-block-offset-is-within-range
+++ a/fs/squashfs/cache.c
@@ -344,6 +344,9 @@ int squashfs_read_metadata(struct super_
 	if (unlikely(length < 0))
 		return -EIO;
 
+	if (unlikely(*offset < 0 || *offset >= SQUASHFS_METADATA_SIZE))
+		return -EIO;
+
 	while (length) {
 		entry = squashfs_cache_get(sb, msblk->block_cache, *block, 0);
 		if (entry->error) {
_

Patches currently in -mm which might be from phillip@squashfs.org.uk are

squashfs-check-metadata-block-offset-is-within-range.patch


