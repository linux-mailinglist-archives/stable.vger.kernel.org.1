Return-Path: <stable+bounces-217937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHh8Dar4nWmeSwQAu9opvQ
	(envelope-from <stable+bounces-217937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:14:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8554D18BBE2
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF17930EC563
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5411333E35B;
	Tue, 24 Feb 2026 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vwEGnqR/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816C301468;
	Tue, 24 Feb 2026 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960445; cv=none; b=dGnDTEX2tiVu5LfjOotc9rg+8OCoCTW+WFyiCPXUpur/iZEsqlyujXdjAr98u8aR7T7he4gLYo2BV7b74ZVge337wdbiRhFcCQxElOLUijWDseBxfVtr8ogRF9JtlYFNkubPTcO6/YebqJXvMrSIuHufxQZSgpuaCvfvnrDOtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960445; c=relaxed/simple;
	bh=84igjuhslbg4jYuWAt+VyxcMngsVajbxXFgxJMrHfao=;
	h=Date:To:From:Subject:Message-Id; b=utEdwjDCoqcg6QgmX8IYonZ5DCsfYJNpP2qcsldj5c62QEBq7ZZPXNqMkiPE83Ez01oyub4RGtCLIG/NYggTGqD7KU+386759H4YFptMYQE8bf39JswKgsbEWPVV967Z6xd269It5bnvEcsn3GVmyOjmcAzO6XdJYNMOyr8E2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vwEGnqR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B8EC116D0;
	Tue, 24 Feb 2026 19:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771960444;
	bh=84igjuhslbg4jYuWAt+VyxcMngsVajbxXFgxJMrHfao=;
	h=Date:To:From:Subject:From;
	b=vwEGnqR/KX27XQ51wcWyRkNGH4HaJMlPCpSKguPYfrLNywH3Jt6uCkXGeTYps1mL3
	 YcKNFwMkZwcOtbZyB4Pc41cZ1Wi3ezzTYtNavp/SvVBsuVLekY5GO0FRMRrpdgNGls
	 Y0OcMriqI7fKlBiZQej16lGeDN663ZekdCBGc1r0=
Date: Tue, 24 Feb 2026 11:14:04 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,brauner@kernel.org,phillip@squashfs.org.uk,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] squashfs-check-metadata-block-offset-is-within-range.patch removed from -mm tree
Message-Id: <20260224191404.D2B8EC116D0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217937-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,smtp.kernel.org:mid,squashfs.org.uk:email,linux-foundation.org:email,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 8554D18BBE2
X-Rspamd-Action: no action


The quilt patch titled
     Subject: Squashfs: check metadata block offset is within range
has been removed from the -mm tree.  Its filename was
     squashfs-check-metadata-block-offset-is-within-range.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

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

squashfs-check-xz-dictionary-size-isnt-zero.patch


