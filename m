Return-Path: <stable+bounces-256466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EwNIt0EGWrlpggAu9opvQ
	(envelope-from <stable+bounces-256466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:15:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E85FCA0E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57834310339B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183F369D4B;
	Fri, 29 May 2026 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTLTV2iz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963136A369
	for <stable@vger.kernel.org>; Fri, 29 May 2026 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024340; cv=none; b=MMGXu17voWjF/ZJj9Y4G0tJBnqAelu3UQrorrF3P2P9uXd632XmkCi+g4jqmZL9WEv8bhM8pBvWoQGl5DZUvOJawXquasoMwwWHxzb6FEp4N+VPnxVvLJkNiPxfFlDNsj4+8XinUbGfGagdX9Sg/ro1FKR00FIoOPxvzQtNoOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024340; c=relaxed/simple;
	bh=40T2GLBqj4FpYx2f+Q5O8Te1Fo7OcJyPDzJ1RlcCGmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gmv1BGqihcOxMaGux5Bt64IXkeH07i6x0Jxc3izVHrF9LQ/fjL4BDeR0OsS5GSIikym16hzRY/fKxvJdzHyrBjY5oh+0bFHOLVKc4YmFtTobZJIp9sZk9URm8EiPhcK2fE/yvpqblr7uKh5I+00wMOlhh3ve/wfTnWIn8X/Rrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTLTV2iz; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e61f8d3cbfso3105208a34.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 20:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780024337; x=1780629137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9Db9daSum/vcEWTe0jIogWuT23gsSW5PUBP5KH0NAU=;
        b=MTLTV2izSJCm7sFmcnidLgrxTdWt4czGqAxxgb6Elo19V8WnRULnbMiQ/qM/s9/Tuo
         eMVa2vL9ar8egy/jjxqdnDBkmYy9O5IhMPZbP1FhhF7mRXdw1nYbgMFy16SF4osqIqZU
         neD0kidair8iaqPc7ZXJZz4miHkZGhbhVubt2G4dMp+/YtA8xvovFuw2+ZbvEMaaKnGX
         EszZnXelm028tYJRquVQ17T8RmQBsbh9/Ku3oWpBGJIAm6ECxM8vi9DUHInBvKddzmZF
         5v9OZRzjBZldntdK9RtuVaieEkjXEyCu6iUKwJ90bzPqKSiAjM8xGS1WTiTQ+DYomRdx
         ocRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024337; x=1780629137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9Db9daSum/vcEWTe0jIogWuT23gsSW5PUBP5KH0NAU=;
        b=WJqULLR6vqhqKIoX6x/uucmHp34V+2miOnxSjPG5KvKp/WuPZal7XuuUy00Er84puT
         mYrpIHzXyTbvdUW2RukOApaSWjP8DV50cpVRJU9657F0sVnXo8+VPxt0xkqW2JCy2RzU
         wd9MM7dIuy+UWrJjJImoaO+KkYTx7WQ4IyrQBI7tP1uL8Oa/XpUsYJxqt1ADHkqAP9x2
         pUhg19ituuUkoVyPbp0h1vso9iJVNRSigI2P9JMHMJ+H5X6LnZoHP1FDc53EGspHOvtO
         piVnAZ2HIvil2wQ7XlrP8RKL20M/TJC2PBE6owI+Yyvun84W0r2S6mr+E3lNCX+uwebX
         BUkA==
X-Forwarded-Encrypted: i=1; AFNElJ8yWgF0FH/fvGvCdioXW8oT4fGZdYOJGkCgc4XkXaENT9rIjN1zvGPo2yDDW8Su1HcHH969AKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5I0VaKWH/zlWXOKGPVUFGhpToeM2Mkl/joghOgMzpLWC5xb12
	e6lN6aFJFFQFt7AHAwhIkBHuNTvUHqiJEAAqFD3FbVBG8eUH547JvYpg
X-Gm-Gg: Acq92OF7U18quRWsXvO6AkXyEBXtv+yJhBrR7T/ArIsWrTt3GsUWSyBuZNPJ/NqKDNr
	HM0rP5htH/w8jtqO/LZ0QJnSpvISMy62aD2nEjy1WfqYMCQEcj9abJBa7IHsEZ93eh4z4NdIAj2
	Itzww8DhVNov0LaoaHwRnbnaQWskJUbknxRo1rQJjiIZt5n5wH2duJR8kpsRo2WZC9tQW5Igl1r
	qEceiFqYEFwNxYKpRFsFYkj6N6G5C+L3svGKClWzjGmgVa5mXtHY9xzk+Bsh7eYLASNXlo0gKBi
	pwqy/m5p6ElYZX+cmM954KjJlLI5J5TG4ts3lMUK1Y6lCaOyJjgnpIMmkF0/6npqMFPT9xEiQ56
	5qzaABXdMOKDatHaCcpTFjvQhvsYkf6WBhgF6lbkP8PKFJ9cu+u/EkwZIwsu5GLR1CeXPtYXPUF
	GBOGMvJMGzdjiCROKUC58JJDHbu6erQ1AHmQ0x7SCKnCVDTfKzTYU4l/gr06ZfJBSwwEvtFrG5c
	WL43pBWVCfoPtXQwcQHAZWkXOY2rz7BG0mCVa3zbRL90pFpXfH22BoZXqhrdyqGig==
X-Received: by 2002:a05:6830:2a8c:b0:7dc:dd58:50c3 with SMTP id 46e09a7af769-7e694f38d25mr875627a34.13.1780024337504;
        Thu, 28 May 2026 20:12:17 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d65e6esm548861a34.20.2026.05.28.20.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:12:16 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: linux-fuse@vger.kernel.org
Cc: miklos@szeredi.hu,
	linux-kernel@vger.kernel.org,
	Russ Fellows <russ.fellows@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fuse: fix FOPEN_PARALLEL_DIRECT_WRITES being ignored for passthrough writes
Date: Fri, 29 May 2026 03:12:03 +0000
Message-ID: <20260529031210.7021-2-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260529031210.7021-1-russ.fellows@gmail.com>
References: <20260529031210.7021-1-russ.fellows@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256466-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szeredi.hu,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[russfellows@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E11E85FCA0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

