Return-Path: <stable+bounces-256465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGYQGAAEGWrGpggAu9opvQ
	(envelope-from <stable+bounces-256465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:12:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E805FC9C9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B01B30432FE
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3735F60B;
	Fri, 29 May 2026 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7rxVK8Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C33369D4B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024257; cv=none; b=UxFoNtNuFAn7TV7N+tCSej3Sch0WaKt52mAcgBFD6KXzqFb52wbvgt4hGCmBPBbe2y33TupYVD1UvumOVKEuUtIvtKyCKuRfRIFTMdpVHIkBwRbG3Cw4upv+M4wjZ7YIZLtsU2dbDqdNwxQHqRDDuDTmvFzbGSypxxeJOA3134Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024257; c=relaxed/simple;
	bh=rf1EcstU4/jv4SU6YfAT83160zMwoLcxQfhRzCUu/aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5RpPKEe10/Tn61qnL/El/rDZV6hoRmM9rf7BwuigyniGCRqT4mfh0eTRp5sP8m2TFS7cmP3liYXQwxOQnsOvTzEy2zDb8zoFpjm6LvWdF1tQYeUtzceu83Lqh7BhcYI5vI9W8b5iiZdFKg5MxuwRzP163q6TeyCPywdqGlUBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7rxVK8Y; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69de16f5f79so1266638eaf.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780024254; x=1780629054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBnEs79NiKULep7z/FAzFX0XaT8uCCEHPAexPCrbBaw=;
        b=r7rxVK8YmnoLVmk7cWxhE242xzn8OcU2yw/NKjKtsdkE9yo+1rOd2rOnYLmIcJTd25
         bp9YuHUV2qyR8Cjh5Ed+Og8gwV7paoaaXtHgvrJK3f3B9Rmjcl7BJAxX3GLb9jcR9FLy
         6hyA6lGaM0gh+tUYg5eSBI6Y0rMhNFmUrMaukELtsXXGPjElCh8Z4YOPnOEvPv4qNchL
         a8URumR5g01sk/f14b4mfaanrVTafh7JmgLnLfbbrCTD8HZ3fGo67gNWVTUXu1mnGOiP
         qR+c61w9Jwc1WCPV9bwZNaUp6Fn5D7A0Dn2OzCgyYdK9o5e2he24mNFH1RTiOBIuvCyo
         oLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024254; x=1780629054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBnEs79NiKULep7z/FAzFX0XaT8uCCEHPAexPCrbBaw=;
        b=q9zzRL+8hg/3cmtvFyNju6TI5y07PKjSAIZhZ/b7Sok+Xi7FAwnQZhYQE0HGGgkMw2
         OD6Jc3q9ZcnhnIU0BLjnkzts4pmlYYnHuZV5KL0KthaA4+f2iwK75aq3lmcKkELff2jL
         AV71x9NtZZChEV0sYjMfgEk6/xXzNauuXQ93SCw9lrSY/O5EjOpvkwh7pi/VIS5A7hC4
         PfTIzzf9Z/5lGbqk0PauoHPRGLZXOjzeNj6z77lLsGgq+UeViOvH2tCXAY6n/lcNBadm
         iPOM1X6+ikJTJRp7I3eHoPaDFfEI4DXQYtLxrW5dvXdAFlMQlNmbdPrC1ZgzKEwHih1P
         wSYQ==
X-Gm-Message-State: AOJu0Yx2v7pa3tbPL/vv1a9JMsLyp3ajqmnpWC3dxVlD6of7DflOd00Y
	ZFN/ctdH3Jp3sahLB22YZrrne2eO1/2M4s2fW3dRHNlNhEVG6sXD3qUPL1xQrw==
X-Gm-Gg: Acq92OGsuxZLmDbrZT4F7voPlpvpxcS1V7twqFKGxSwPPYDxcDb5cWETJcn736qPSF1
	Rxzv1OGn/Hslfp4ZyHK5TA4CanPpNkL/pHAPMn/INNdByG8w/jhL//mRVRdJ/vm+zlwY29GSNny
	dkBQd6MZNdYDWBNvzmmGnkeNrNNjl1aI5zESTMtiLFhuSMGYVx7OcXOWnuIEt4u0ESfY7ZlDFLz
	Lyt3MTxeRSzwCVaGF3Lh3JHEUBiWagG3IL60Qhdfkl+3/+GX9eVhH/4LvGkPqobzrbNRmpSq7IB
	v5dg9DHqxgYFVEWumkRjg/yhSuDSCRrG7V2kRKV/aKsRXMaOFJ9cS/rdvq0lERKVh1EGTpnR8yw
	AFZEUuiyxRn2FBoOA+/uvfXvyVMZk1YCjKgHSdskcHkk8NDFA9dpcL+j6houv+w0PecU15oZ/Hq
	LOiKhv+/uvRFoCae0vA0e0FBBV3BB0YKnyt/EwCjnzmBbomAuptTZj1cWO3+UEQGIvNjuUaMavh
	wGbe0lXpU71ihcS6ckHlzFWd61dBlViL8nZRguLahrJoKFSt3L13vlx7wnxGtnybp6fn1C1
X-Received: by 2002:a05:6820:a04:b0:69d:d78f:e3d0 with SMTP id 006d021491bc7-69e0403b8a9mr685164eaf.44.1780024254484;
        Thu, 28 May 2026 20:10:54 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e069b55ddsm195563eaf.13.2026.05.28.20.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:10:53 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
X-Google-Original-From: Russ Fellows <rfellows@xlrait.dev>
To: russ.fellows@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] fuse: fix FOPEN_PARALLEL_DIRECT_WRITES being ignored for passthrough writes
Date: Fri, 29 May 2026 03:10:46 +0000
Message-ID: <20260529031046.6861-1-rfellows@xlrait.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256465-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[russfellows@gmail.com,stable@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B9E805FC9C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Russ Fellows <russ.fellows@gmail.com>

FOPEN_PARALLEL_DIRECT_WRITES has no effect on passthrough-backed FUSE
files due to two independent bugs that each prevent it from working.
Both must be fixed to restore parallel write concurrency.

Bug 1: fuse_passthrough_write_iter() acquires the exclusive inode lock
directly:

    inode_lock(inode);
    ret = backing_file_write_iter(...);
    inode_unlock(inode);

This serializes all concurrent writers regardless of whether the server
set FOPEN_PARALLEL_DIRECT_WRITES.  The flag is checked by
fuse_dio_wr_exclusive_lock(), called from fuse_dio_lock(), called from
fuse_direct_write_iter() -- the non-passthrough O_DIRECT path.
fuse_file_write_iter() routes passthrough opens to
fuse_passthrough_write_iter() instead, bypassing the flag check entirely.

Bug 2: fuse_file_io_open() in iomode.c strips FOPEN_PARALLEL_DIRECT_WRITES
from any open that lacks FOPEN_DIRECT_IO:

    if (!(ff->open_flags & FOPEN_DIRECT_IO))
        ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;

This is correct for regular direct-IO opens where FOPEN_DIRECT_IO ensures
O_DIRECT is actually in effect.  It is wrong for passthrough opens: a
passthrough file already bypasses the FUSE page cache by definition, so
FOPEN_DIRECT_IO is redundant and should not be required to preserve the
parallel-writes flag.

Note: adding FOPEN_DIRECT_IO to the daemon's open flags is not a valid
workaround.  fuse_file_write_iter() checks FOPEN_DIRECT_IO before
FOPEN_PASSTHROUGH, so setting both causes writes to be routed through
fuse_direct_write_iter() (requiring a userspace round-trip) instead of
fuse_passthrough_write_iter() (zero-copy kernel path).

Combined effect: a daemon that opens with FOPEN_PASSTHROUGH |
FOPEN_PARALLEL_DIRECT_WRITES (without FOPEN_DIRECT_IO) has the parallel
flag stripped by Bug 2 before Bug 1 is even reached.  Both bugs must be
fixed together.

Fix Bug 1: make fuse_dio_lock() and fuse_dio_unlock() non-static and call
them from fuse_passthrough_write_iter(), replacing the open-coded
inode_lock/inode_unlock.  This reuses the existing logic that handles
FOPEN_PARALLEL_DIRECT_WRITES, append writes, writes past EOF, and
page-cache IO mode transitions.

Fix Bug 2: skip the FOPEN_PARALLEL_DIRECT_WRITES strip when
FOPEN_PASSTHROUGH is set.  The flag remains stripped for non-passthrough
opens without FOPEN_DIRECT_IO, preserving existing behaviour.

Safety: backing_file_write_iter() calls into the backing filesystem's
write_iter (e.g. xfs_file_write_iter), which acquires the backing inode's
own lock independently.  The FUSE inode lock and the backing inode lock are
entirely separate; using inode_lock_shared on the FUSE inode does not
affect the backing filesystem's concurrency control.

Fixes: 4d99ff8f6b85 ("fuse: implement open/create with FOPEN_PASSTHROUGH")
Cc: stable@vger.kernel.org
Signed-off-by: Russ Fellows <russ.fellows@gmail.com>
---
 fs/fuse/file.c        |  6 +++---
 fs/fuse/fuse_i.h      |  2 ++
 fs/fuse/iomode.c      |  8 ++++++--
 fs/fuse/passthrough.c |  6 +++---
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f94f3dc082c6..602c3f18676e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1428,8 +1428,8 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	return false;
 }
 
-static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
-			  bool *exclusive)
+void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
+		   bool *exclusive)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -1455,7 +1455,7 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
 	}
 }
 
-static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
+void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -1469,7 +1469,7 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 	}
 }
 
-static const struct iomap_write_ops fuse_iomap_write_ops = {
+static const struct iomap_write_ops fuse_iomap_write_ops = {	/* unchanged */
 	.read_folio_range = fuse_iomap_read_folio_range,
 };
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 17423d4e3cfa..120de517cea0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1541,6 +1541,8 @@ int fuse_file_io_open(struct file *file, struct inode *inode);
 void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
 
 /* file.c */
+void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from, bool *exclusive);
+void fuse_dio_unlock(struct kiocb *iocb, bool exclusive);
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 				 unsigned int open_flags, bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index c99e285f3..b3f51e3d1 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -214,10 +214,14 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	if (fuse_inode_backing(fi) && !(ff->open_flags & FOPEN_PASSTHROUGH))
 		goto fail;
 
-	/*
-	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
-	 */
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	/*
+	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO, except for
+	 * passthrough opens which bypass the page cache regardless and do not
+	 * need FOPEN_DIRECT_IO to guarantee direct I/O semantics.
+	 */
+	if (!(ff->open_flags & FOPEN_DIRECT_IO) &&
+	    !(ff->open_flags & FOPEN_PASSTHROUGH))
 		ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;
 
 	/*
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index f2d08ac2459b..f83d0a27cfb9 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -54,11 +54,11 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
 				    struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-	struct inode *inode = file_inode(file);
 	struct fuse_file *ff = file->private_data;
 	struct file *backing_file = fuse_file_passthrough(ff);
 	size_t count = iov_iter_count(iter);
 	ssize_t ret;
+	bool exclusive;
 	struct backing_file_ctx ctx = {
 		.cred = ff->cred,
 		.end_write = fuse_passthrough_end_write,
@@ -70,10 +70,10 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
 	if (!count)
 		return 0;
 
-	inode_lock(inode);
+	fuse_dio_lock(iocb, iter, &exclusive);
 	ret = backing_file_write_iter(backing_file, iter, iocb, iocb->ki_flags,
 				      &ctx);
-	inode_unlock(inode);
+	fuse_dio_unlock(iocb, exclusive);
 
 	return ret;
 }
-- 
2.51.0

