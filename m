Return-Path: <stable+bounces-70171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D3E95F049
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D2CB20BD2
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEE714B95F;
	Mon, 26 Aug 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QuKQSoXb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191A156241
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673583; cv=none; b=H89CBInn+ZuJr+2/58hXLdAeXwZ57v4J5rrPn7Mu4XrASxwLYOKmp1dh21Gdz6Q/tJklUBEqwexXeJ2iFrz33AHGsdFmw+EJ/x0+u2tzT2xpPCnsfZpJRy4GierFN41vj1HGLawpoKOugAlLoPljLMKBOf1a0OjLY8JtC8gygwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673583; c=relaxed/simple;
	bh=i4L1DIRJ9Qb7YCw9hc92EtPt2p/SfhJpfJKtu5gDbHU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bUS7JDY1iuH3EW7gAba3RrBJMzPW19yNcuZboNZ7qsi408Y0CmwULTgVa5rY5jb3snfkGyFINN736B4Njbk/Try7UVEtMEWQebb66jXxUKMapt4vXLjo0Xfzl1qLEazYkmwAcgoYmwjnBjN7CDj4MuXmLX6BsGkQE0UkUikwxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QuKQSoXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0DCC51406;
	Mon, 26 Aug 2024 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724673582;
	bh=i4L1DIRJ9Qb7YCw9hc92EtPt2p/SfhJpfJKtu5gDbHU=;
	h=Subject:To:Cc:From:Date:From;
	b=QuKQSoXboajfmcnVZLDH/JbTG2P1YhFn2zBIgEBesjLCgA+geY8XsrtDT/scHYlT0
	 SgVQKeDVVxoU5DtbnPsPViJnybEnEbvplJF3aiRHT80v9DeRP0xNFXSgb4pZgu4eyA
	 zc/Zj67uYATmjydhv9piIOk9mje3elxqaHpEOE9w=
Subject: FAILED: patch "[PATCH] smb3: fix broken cached reads when posix locks" failed to apply to 6.1-stable tree
To: stfrench@microsoft.com,dhowells@redhat.com,kevin.ottens@enioka.com,piastryyy@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 13:59:36 +0200
Message-ID: <2024082636-freehand-sliding-9738@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e4be320eeca842a3d7648258ee3673f1755a5a59
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082636-freehand-sliding-9738@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e4be320eeca8 ("smb3: fix broken cached reads when posix locks")
3ee1a1fc3981 ("cifs: Cut over to using netfslib")
69c3c023af25 ("cifs: Implement netfslib hooks")
edea94a69730 ("cifs: Add mempools for cifs_io_request and cifs_io_subrequest structs")
1a5b4edd97ce ("cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c")
ab58fbdeebc7 ("cifs: Use more fields from netfs_io_subrequest")
a975a2f22cdc ("cifs: Replace cifs_writedata with a wrapper around netfs_io_subrequest")
753b67eb630d ("cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest")
0f7c0f3f5150 ("cifs: Use alternative invalidation to using launder_folio")
2e9d7e4b984a ("mm: Remove the PG_fscache alias for PG_private_2")
2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private and marking dirty")
f3dc1bdb6b0b ("cifs: Fix writeback data corruption")
d1bba17e20d5 ("Merge tag '6.8-rc1-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e4be320eeca842a3d7648258ee3673f1755a5a59 Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Thu, 15 Aug 2024 18:31:36 -0500
Subject: [PATCH] smb3: fix broken cached reads when posix locks

Mandatory locking is enforced for cached reads, which violates
default posix semantics, and also it is enforced inconsistently.
This affected recent versions of libreoffice, and can be
demonstrated by opening a file twice from the same client,
locking it from handle one and trying to read from it from
handle two (which fails, returning EACCES).

There is already a mount option "forcemandatorylock"
(which defaults to off), so with this change only when the user
intentionally specifies "forcemandatorylock" on mount will we
break posix semantics on read to a locked range (ie we will
only fail in this case, if the user mounts with
"forcemandatorylock").

An earlier patch fixed the write path.

Fixes: 85160e03a79e ("CIFS: Implement caching mechanism for mandatory brlocks")
Cc: stable@vger.kernel.org
Cc: Pavel Shilovsky <piastryyy@gmail.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Reported-by: abartlet@samba.org
Reported-by: Kevin Ottens <kevin.ottens@enioka.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 1fc66bcf49eb..f9b302cb8233 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2912,9 +2912,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (!CIFS_CACHE_READ(cinode))
 		return netfs_unbuffered_read_iter(iocb, to);
 
-	if (cap_unix(tcon->ses) &&
-	    (CIFS_UNIX_FCNTL_CAP & le64_to_cpu(tcon->fsUnixInfo.Capability)) &&
-	    ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0)) {
+	if ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0) {
 		if (iocb->ki_flags & IOCB_DIRECT)
 			return netfs_unbuffered_read_iter(iocb, to);
 		return netfs_buffered_read_iter(iocb, to);


