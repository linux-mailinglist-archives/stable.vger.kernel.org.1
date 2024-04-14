Return-Path: <stable+bounces-37017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6289C2CF
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417791F25515
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477737D08F;
	Mon,  8 Apr 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XqrXmBsr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A637D07E;
	Mon,  8 Apr 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583012; cv=none; b=cVTS4eZCYH1rTFRXnD8tGO3JniByh178FNZBCl+E86ANgv/4KtihI8jlJ+Q976M/a69fWmfEzzJCA37BB5uJCki38quHGmVNtCoEKFlKTj3XYGGlYr6GdFDUJozbrBadzo4vKFvuDvWMzapPa5BoL7RkIX/VRMIq+5E2TSSDgMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583012; c=relaxed/simple;
	bh=ESyLPgJy4tCnMuyulDjM+saKBS0DqivERDnvBXhD30k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ3D5w08aBVWExCtD/nMPUXXur9/D7kvzZsALn/2p3clI2qh5dTY6V0F12lu43RRQRi6mMffyS5LSRy0ooszKfN4RTpb+5AsCo/bTjFd9/mRXM5aiLh9LykMlerscRUgZXDAmNM1ca78qgjm8ed1acQVZgXqPG6KWoChvmUEBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XqrXmBsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A946C433C7;
	Mon,  8 Apr 2024 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583011;
	bh=ESyLPgJy4tCnMuyulDjM+saKBS0DqivERDnvBXhD30k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XqrXmBsruCIEnh1zcEBWcg1i+0VtXHGna1qOAQ4hzSHRdiBAnE3Igm7Y4tUMVgLiy
	 b03F5GCm/23AuZEJwsK37pVTF3YefjoEwgK7zr2ZitRtwD9i5KihdsqHYJ54/2fuqU
	 +F2yBBzFhXOVrdqF43iTe1FflFiXRqXqf4lj7cx0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.15 198/690] NFS: Move NFS protocol display macros to global header
Date: Mon,  8 Apr 2024 14:51:04 +0200
Message-ID: <20240408125406.721798604@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 8791545eda52e8f3bc48e3cd902e38bf4ba4c9de ]

Refactor: surface useful show_ macros so they can be shared between
the client and server trace code.

Additional clean up:
- Housekeeping: ensure the correct #include files are pulled in
  and add proper TRACE_DEFINE_ENUM where they are missing
- Use a consistent naming scheme for the helpers
- Store values to be displayed symbolically as unsigned long, as
  that is the type that the __print_yada() functions take

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h         | 403 ++++---------------------------------
 fs/nfs/nfstrace.h          | 117 ++---------
 fs/nfs/pnfs.h              |   4 -
 fs/nfsd/trace.h            |   1 +
 include/linux/nfs4.h       |   4 +
 include/trace/events/nfs.h | 375 ++++++++++++++++++++++++++++++++++
 6 files changed, 433 insertions(+), 471 deletions(-)
 create mode 100644 include/trace/events/nfs.h

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index afbecdb8fa21b..635f13a8d44aa 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -12,309 +12,7 @@
 #include <trace/events/sunrpc_base.h>
 
 #include <trace/events/fs.h>
-
-TRACE_DEFINE_ENUM(EPERM);
-TRACE_DEFINE_ENUM(ENOENT);
-TRACE_DEFINE_ENUM(EIO);
-TRACE_DEFINE_ENUM(ENXIO);
-TRACE_DEFINE_ENUM(EACCES);
-TRACE_DEFINE_ENUM(EEXIST);
-TRACE_DEFINE_ENUM(EXDEV);
-TRACE_DEFINE_ENUM(ENOTDIR);
-TRACE_DEFINE_ENUM(EISDIR);
-TRACE_DEFINE_ENUM(EFBIG);
-TRACE_DEFINE_ENUM(ENOSPC);
-TRACE_DEFINE_ENUM(EROFS);
-TRACE_DEFINE_ENUM(EMLINK);
-TRACE_DEFINE_ENUM(ENAMETOOLONG);
-TRACE_DEFINE_ENUM(ENOTEMPTY);
-TRACE_DEFINE_ENUM(EDQUOT);
-TRACE_DEFINE_ENUM(ESTALE);
-TRACE_DEFINE_ENUM(EBADHANDLE);
-TRACE_DEFINE_ENUM(EBADCOOKIE);
-TRACE_DEFINE_ENUM(ENOTSUPP);
-TRACE_DEFINE_ENUM(ETOOSMALL);
-TRACE_DEFINE_ENUM(EREMOTEIO);
-TRACE_DEFINE_ENUM(EBADTYPE);
-TRACE_DEFINE_ENUM(EAGAIN);
-TRACE_DEFINE_ENUM(ELOOP);
-TRACE_DEFINE_ENUM(EOPNOTSUPP);
-TRACE_DEFINE_ENUM(EDEADLK);
-TRACE_DEFINE_ENUM(ENOMEM);
-TRACE_DEFINE_ENUM(EKEYEXPIRED);
-TRACE_DEFINE_ENUM(ETIMEDOUT);
-TRACE_DEFINE_ENUM(ERESTARTSYS);
-TRACE_DEFINE_ENUM(ECONNREFUSED);
-TRACE_DEFINE_ENUM(ECONNRESET);
-TRACE_DEFINE_ENUM(ENETUNREACH);
-TRACE_DEFINE_ENUM(EHOSTUNREACH);
-TRACE_DEFINE_ENUM(EHOSTDOWN);
-TRACE_DEFINE_ENUM(EPIPE);
-TRACE_DEFINE_ENUM(EPFNOSUPPORT);
-TRACE_DEFINE_ENUM(EPROTONOSUPPORT);
-
-TRACE_DEFINE_ENUM(NFS4_OK);
-TRACE_DEFINE_ENUM(NFS4ERR_ACCESS);
-TRACE_DEFINE_ENUM(NFS4ERR_ATTRNOTSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_ADMIN_REVOKED);
-TRACE_DEFINE_ENUM(NFS4ERR_BACK_CHAN_BUSY);
-TRACE_DEFINE_ENUM(NFS4ERR_BADCHAR);
-TRACE_DEFINE_ENUM(NFS4ERR_BADHANDLE);
-TRACE_DEFINE_ENUM(NFS4ERR_BADIOMODE);
-TRACE_DEFINE_ENUM(NFS4ERR_BADLAYOUT);
-TRACE_DEFINE_ENUM(NFS4ERR_BADLABEL);
-TRACE_DEFINE_ENUM(NFS4ERR_BADNAME);
-TRACE_DEFINE_ENUM(NFS4ERR_BADOWNER);
-TRACE_DEFINE_ENUM(NFS4ERR_BADSESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_BADSLOT);
-TRACE_DEFINE_ENUM(NFS4ERR_BADTYPE);
-TRACE_DEFINE_ENUM(NFS4ERR_BADXDR);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_COOKIE);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_HIGH_SLOT);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_RANGE);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_SEQID);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_SESSION_DIGEST);
-TRACE_DEFINE_ENUM(NFS4ERR_BAD_STATEID);
-TRACE_DEFINE_ENUM(NFS4ERR_CB_PATH_DOWN);
-TRACE_DEFINE_ENUM(NFS4ERR_CLID_INUSE);
-TRACE_DEFINE_ENUM(NFS4ERR_CLIENTID_BUSY);
-TRACE_DEFINE_ENUM(NFS4ERR_COMPLETE_ALREADY);
-TRACE_DEFINE_ENUM(NFS4ERR_CONN_NOT_BOUND_TO_SESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_DEADLOCK);
-TRACE_DEFINE_ENUM(NFS4ERR_DEADSESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_DELAY);
-TRACE_DEFINE_ENUM(NFS4ERR_DELEG_ALREADY_WANTED);
-TRACE_DEFINE_ENUM(NFS4ERR_DELEG_REVOKED);
-TRACE_DEFINE_ENUM(NFS4ERR_DENIED);
-TRACE_DEFINE_ENUM(NFS4ERR_DIRDELEG_UNAVAIL);
-TRACE_DEFINE_ENUM(NFS4ERR_DQUOT);
-TRACE_DEFINE_ENUM(NFS4ERR_ENCR_ALG_UNSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_EXIST);
-TRACE_DEFINE_ENUM(NFS4ERR_EXPIRED);
-TRACE_DEFINE_ENUM(NFS4ERR_FBIG);
-TRACE_DEFINE_ENUM(NFS4ERR_FHEXPIRED);
-TRACE_DEFINE_ENUM(NFS4ERR_FILE_OPEN);
-TRACE_DEFINE_ENUM(NFS4ERR_GRACE);
-TRACE_DEFINE_ENUM(NFS4ERR_HASH_ALG_UNSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_INVAL);
-TRACE_DEFINE_ENUM(NFS4ERR_IO);
-TRACE_DEFINE_ENUM(NFS4ERR_ISDIR);
-TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTTRYLATER);
-TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTUNAVAILABLE);
-TRACE_DEFINE_ENUM(NFS4ERR_LEASE_MOVED);
-TRACE_DEFINE_ENUM(NFS4ERR_LOCKED);
-TRACE_DEFINE_ENUM(NFS4ERR_LOCKS_HELD);
-TRACE_DEFINE_ENUM(NFS4ERR_LOCK_RANGE);
-TRACE_DEFINE_ENUM(NFS4ERR_MINOR_VERS_MISMATCH);
-TRACE_DEFINE_ENUM(NFS4ERR_MLINK);
-TRACE_DEFINE_ENUM(NFS4ERR_MOVED);
-TRACE_DEFINE_ENUM(NFS4ERR_NAMETOOLONG);
-TRACE_DEFINE_ENUM(NFS4ERR_NOENT);
-TRACE_DEFINE_ENUM(NFS4ERR_NOFILEHANDLE);
-TRACE_DEFINE_ENUM(NFS4ERR_NOMATCHING_LAYOUT);
-TRACE_DEFINE_ENUM(NFS4ERR_NOSPC);
-TRACE_DEFINE_ENUM(NFS4ERR_NOTDIR);
-TRACE_DEFINE_ENUM(NFS4ERR_NOTEMPTY);
-TRACE_DEFINE_ENUM(NFS4ERR_NOTSUPP);
-TRACE_DEFINE_ENUM(NFS4ERR_NOT_ONLY_OP);
-TRACE_DEFINE_ENUM(NFS4ERR_NOT_SAME);
-TRACE_DEFINE_ENUM(NFS4ERR_NO_GRACE);
-TRACE_DEFINE_ENUM(NFS4ERR_NXIO);
-TRACE_DEFINE_ENUM(NFS4ERR_OLD_STATEID);
-TRACE_DEFINE_ENUM(NFS4ERR_OPENMODE);
-TRACE_DEFINE_ENUM(NFS4ERR_OP_ILLEGAL);
-TRACE_DEFINE_ENUM(NFS4ERR_OP_NOT_IN_SESSION);
-TRACE_DEFINE_ENUM(NFS4ERR_PERM);
-TRACE_DEFINE_ENUM(NFS4ERR_PNFS_IO_HOLE);
-TRACE_DEFINE_ENUM(NFS4ERR_PNFS_NO_LAYOUT);
-TRACE_DEFINE_ENUM(NFS4ERR_RECALLCONFLICT);
-TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_BAD);
-TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_CONFLICT);
-TRACE_DEFINE_ENUM(NFS4ERR_REJECT_DELEG);
-TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG);
-TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG_TO_CACHE);
-TRACE_DEFINE_ENUM(NFS4ERR_REQ_TOO_BIG);
-TRACE_DEFINE_ENUM(NFS4ERR_RESOURCE);
-TRACE_DEFINE_ENUM(NFS4ERR_RESTOREFH);
-TRACE_DEFINE_ENUM(NFS4ERR_RETRY_UNCACHED_REP);
-TRACE_DEFINE_ENUM(NFS4ERR_RETURNCONFLICT);
-TRACE_DEFINE_ENUM(NFS4ERR_ROFS);
-TRACE_DEFINE_ENUM(NFS4ERR_SAME);
-TRACE_DEFINE_ENUM(NFS4ERR_SHARE_DENIED);
-TRACE_DEFINE_ENUM(NFS4ERR_SEQUENCE_POS);
-TRACE_DEFINE_ENUM(NFS4ERR_SEQ_FALSE_RETRY);
-TRACE_DEFINE_ENUM(NFS4ERR_SEQ_MISORDERED);
-TRACE_DEFINE_ENUM(NFS4ERR_SERVERFAULT);
-TRACE_DEFINE_ENUM(NFS4ERR_STALE);
-TRACE_DEFINE_ENUM(NFS4ERR_STALE_CLIENTID);
-TRACE_DEFINE_ENUM(NFS4ERR_STALE_STATEID);
-TRACE_DEFINE_ENUM(NFS4ERR_SYMLINK);
-TRACE_DEFINE_ENUM(NFS4ERR_TOOSMALL);
-TRACE_DEFINE_ENUM(NFS4ERR_TOO_MANY_OPS);
-TRACE_DEFINE_ENUM(NFS4ERR_UNKNOWN_LAYOUTTYPE);
-TRACE_DEFINE_ENUM(NFS4ERR_UNSAFE_COMPOUND);
-TRACE_DEFINE_ENUM(NFS4ERR_WRONGSEC);
-TRACE_DEFINE_ENUM(NFS4ERR_WRONG_CRED);
-TRACE_DEFINE_ENUM(NFS4ERR_WRONG_TYPE);
-TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
-
-TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_MDS);
-TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
-
-#define show_nfsv4_errors(error) \
-	__print_symbolic(error, \
-		{ NFS4_OK, "OK" }, \
-		/* Mapped by nfs4_stat_to_errno() */ \
-		{ EPERM, "EPERM" }, \
-		{ ENOENT, "ENOENT" }, \
-		{ EIO, "EIO" }, \
-		{ ENXIO, "ENXIO" }, \
-		{ EACCES, "EACCES" }, \
-		{ EEXIST, "EEXIST" }, \
-		{ EXDEV, "EXDEV" }, \
-		{ ENOTDIR, "ENOTDIR" }, \
-		{ EISDIR, "EISDIR" }, \
-		{ EFBIG, "EFBIG" }, \
-		{ ENOSPC, "ENOSPC" }, \
-		{ EROFS, "EROFS" }, \
-		{ EMLINK, "EMLINK" }, \
-		{ ENAMETOOLONG, "ENAMETOOLONG" }, \
-		{ ENOTEMPTY, "ENOTEMPTY" }, \
-		{ EDQUOT, "EDQUOT" }, \
-		{ ESTALE, "ESTALE" }, \
-		{ EBADHANDLE, "EBADHANDLE" }, \
-		{ EBADCOOKIE, "EBADCOOKIE" }, \
-		{ ENOTSUPP, "ENOTSUPP" }, \
-		{ ETOOSMALL, "ETOOSMALL" }, \
-		{ EREMOTEIO, "EREMOTEIO" }, \
-		{ EBADTYPE, "EBADTYPE" }, \
-		{ EAGAIN, "EAGAIN" }, \
-		{ ELOOP, "ELOOP" }, \
-		{ EOPNOTSUPP, "EOPNOTSUPP" }, \
-		{ EDEADLK, "EDEADLK" }, \
-		/* RPC errors */ \
-		{ ENOMEM, "ENOMEM" }, \
-		{ EKEYEXPIRED, "EKEYEXPIRED" }, \
-		{ ETIMEDOUT, "ETIMEDOUT" }, \
-		{ ERESTARTSYS, "ERESTARTSYS" }, \
-		{ ECONNREFUSED, "ECONNREFUSED" }, \
-		{ ECONNRESET, "ECONNRESET" }, \
-		{ ENETUNREACH, "ENETUNREACH" }, \
-		{ EHOSTUNREACH, "EHOSTUNREACH" }, \
-		{ EHOSTDOWN, "EHOSTDOWN" }, \
-		{ EPIPE, "EPIPE" }, \
-		{ EPFNOSUPPORT, "EPFNOSUPPORT" }, \
-		{ EPROTONOSUPPORT, "EPROTONOSUPPORT" }, \
-		/* NFSv4 native errors */ \
-		{ NFS4ERR_ACCESS, "ACCESS" }, \
-		{ NFS4ERR_ATTRNOTSUPP, "ATTRNOTSUPP" }, \
-		{ NFS4ERR_ADMIN_REVOKED, "ADMIN_REVOKED" }, \
-		{ NFS4ERR_BACK_CHAN_BUSY, "BACK_CHAN_BUSY" }, \
-		{ NFS4ERR_BADCHAR, "BADCHAR" }, \
-		{ NFS4ERR_BADHANDLE, "BADHANDLE" }, \
-		{ NFS4ERR_BADIOMODE, "BADIOMODE" }, \
-		{ NFS4ERR_BADLAYOUT, "BADLAYOUT" }, \
-		{ NFS4ERR_BADLABEL, "BADLABEL" }, \
-		{ NFS4ERR_BADNAME, "BADNAME" }, \
-		{ NFS4ERR_BADOWNER, "BADOWNER" }, \
-		{ NFS4ERR_BADSESSION, "BADSESSION" }, \
-		{ NFS4ERR_BADSLOT, "BADSLOT" }, \
-		{ NFS4ERR_BADTYPE, "BADTYPE" }, \
-		{ NFS4ERR_BADXDR, "BADXDR" }, \
-		{ NFS4ERR_BAD_COOKIE, "BAD_COOKIE" }, \
-		{ NFS4ERR_BAD_HIGH_SLOT, "BAD_HIGH_SLOT" }, \
-		{ NFS4ERR_BAD_RANGE, "BAD_RANGE" }, \
-		{ NFS4ERR_BAD_SEQID, "BAD_SEQID" }, \
-		{ NFS4ERR_BAD_SESSION_DIGEST, "BAD_SESSION_DIGEST" }, \
-		{ NFS4ERR_BAD_STATEID, "BAD_STATEID" }, \
-		{ NFS4ERR_CB_PATH_DOWN, "CB_PATH_DOWN" }, \
-		{ NFS4ERR_CLID_INUSE, "CLID_INUSE" }, \
-		{ NFS4ERR_CLIENTID_BUSY, "CLIENTID_BUSY" }, \
-		{ NFS4ERR_COMPLETE_ALREADY, "COMPLETE_ALREADY" }, \
-		{ NFS4ERR_CONN_NOT_BOUND_TO_SESSION, \
-			"CONN_NOT_BOUND_TO_SESSION" }, \
-		{ NFS4ERR_DEADLOCK, "DEADLOCK" }, \
-		{ NFS4ERR_DEADSESSION, "DEAD_SESSION" }, \
-		{ NFS4ERR_DELAY, "DELAY" }, \
-		{ NFS4ERR_DELEG_ALREADY_WANTED, \
-			"DELEG_ALREADY_WANTED" }, \
-		{ NFS4ERR_DELEG_REVOKED, "DELEG_REVOKED" }, \
-		{ NFS4ERR_DENIED, "DENIED" }, \
-		{ NFS4ERR_DIRDELEG_UNAVAIL, "DIRDELEG_UNAVAIL" }, \
-		{ NFS4ERR_DQUOT, "DQUOT" }, \
-		{ NFS4ERR_ENCR_ALG_UNSUPP, "ENCR_ALG_UNSUPP" }, \
-		{ NFS4ERR_EXIST, "EXIST" }, \
-		{ NFS4ERR_EXPIRED, "EXPIRED" }, \
-		{ NFS4ERR_FBIG, "FBIG" }, \
-		{ NFS4ERR_FHEXPIRED, "FHEXPIRED" }, \
-		{ NFS4ERR_FILE_OPEN, "FILE_OPEN" }, \
-		{ NFS4ERR_GRACE, "GRACE" }, \
-		{ NFS4ERR_HASH_ALG_UNSUPP, "HASH_ALG_UNSUPP" }, \
-		{ NFS4ERR_INVAL, "INVAL" }, \
-		{ NFS4ERR_IO, "IO" }, \
-		{ NFS4ERR_ISDIR, "ISDIR" }, \
-		{ NFS4ERR_LAYOUTTRYLATER, "LAYOUTTRYLATER" }, \
-		{ NFS4ERR_LAYOUTUNAVAILABLE, "LAYOUTUNAVAILABLE" }, \
-		{ NFS4ERR_LEASE_MOVED, "LEASE_MOVED" }, \
-		{ NFS4ERR_LOCKED, "LOCKED" }, \
-		{ NFS4ERR_LOCKS_HELD, "LOCKS_HELD" }, \
-		{ NFS4ERR_LOCK_RANGE, "LOCK_RANGE" }, \
-		{ NFS4ERR_MINOR_VERS_MISMATCH, "MINOR_VERS_MISMATCH" }, \
-		{ NFS4ERR_MLINK, "MLINK" }, \
-		{ NFS4ERR_MOVED, "MOVED" }, \
-		{ NFS4ERR_NAMETOOLONG, "NAMETOOLONG" }, \
-		{ NFS4ERR_NOENT, "NOENT" }, \
-		{ NFS4ERR_NOFILEHANDLE, "NOFILEHANDLE" }, \
-		{ NFS4ERR_NOMATCHING_LAYOUT, "NOMATCHING_LAYOUT" }, \
-		{ NFS4ERR_NOSPC, "NOSPC" }, \
-		{ NFS4ERR_NOTDIR, "NOTDIR" }, \
-		{ NFS4ERR_NOTEMPTY, "NOTEMPTY" }, \
-		{ NFS4ERR_NOTSUPP, "NOTSUPP" }, \
-		{ NFS4ERR_NOT_ONLY_OP, "NOT_ONLY_OP" }, \
-		{ NFS4ERR_NOT_SAME, "NOT_SAME" }, \
-		{ NFS4ERR_NO_GRACE, "NO_GRACE" }, \
-		{ NFS4ERR_NXIO, "NXIO" }, \
-		{ NFS4ERR_OLD_STATEID, "OLD_STATEID" }, \
-		{ NFS4ERR_OPENMODE, "OPENMODE" }, \
-		{ NFS4ERR_OP_ILLEGAL, "OP_ILLEGAL" }, \
-		{ NFS4ERR_OP_NOT_IN_SESSION, "OP_NOT_IN_SESSION" }, \
-		{ NFS4ERR_PERM, "PERM" }, \
-		{ NFS4ERR_PNFS_IO_HOLE, "PNFS_IO_HOLE" }, \
-		{ NFS4ERR_PNFS_NO_LAYOUT, "PNFS_NO_LAYOUT" }, \
-		{ NFS4ERR_RECALLCONFLICT, "RECALLCONFLICT" }, \
-		{ NFS4ERR_RECLAIM_BAD, "RECLAIM_BAD" }, \
-		{ NFS4ERR_RECLAIM_CONFLICT, "RECLAIM_CONFLICT" }, \
-		{ NFS4ERR_REJECT_DELEG, "REJECT_DELEG" }, \
-		{ NFS4ERR_REP_TOO_BIG, "REP_TOO_BIG" }, \
-		{ NFS4ERR_REP_TOO_BIG_TO_CACHE, \
-			"REP_TOO_BIG_TO_CACHE" }, \
-		{ NFS4ERR_REQ_TOO_BIG, "REQ_TOO_BIG" }, \
-		{ NFS4ERR_RESOURCE, "RESOURCE" }, \
-		{ NFS4ERR_RESTOREFH, "RESTOREFH" }, \
-		{ NFS4ERR_RETRY_UNCACHED_REP, "RETRY_UNCACHED_REP" }, \
-		{ NFS4ERR_RETURNCONFLICT, "RETURNCONFLICT" }, \
-		{ NFS4ERR_ROFS, "ROFS" }, \
-		{ NFS4ERR_SAME, "SAME" }, \
-		{ NFS4ERR_SHARE_DENIED, "SHARE_DENIED" }, \
-		{ NFS4ERR_SEQUENCE_POS, "SEQUENCE_POS" }, \
-		{ NFS4ERR_SEQ_FALSE_RETRY, "SEQ_FALSE_RETRY" }, \
-		{ NFS4ERR_SEQ_MISORDERED, "SEQ_MISORDERED" }, \
-		{ NFS4ERR_SERVERFAULT, "SERVERFAULT" }, \
-		{ NFS4ERR_STALE, "STALE" }, \
-		{ NFS4ERR_STALE_CLIENTID, "STALE_CLIENTID" }, \
-		{ NFS4ERR_STALE_STATEID, "STALE_STATEID" }, \
-		{ NFS4ERR_SYMLINK, "SYMLINK" }, \
-		{ NFS4ERR_TOOSMALL, "TOOSMALL" }, \
-		{ NFS4ERR_TOO_MANY_OPS, "TOO_MANY_OPS" }, \
-		{ NFS4ERR_UNKNOWN_LAYOUTTYPE, "UNKNOWN_LAYOUTTYPE" }, \
-		{ NFS4ERR_UNSAFE_COMPOUND, "UNSAFE_COMPOUND" }, \
-		{ NFS4ERR_WRONGSEC, "WRONGSEC" }, \
-		{ NFS4ERR_WRONG_CRED, "WRONG_CRED" }, \
-		{ NFS4ERR_WRONG_TYPE, "WRONG_TYPE" }, \
-		{ NFS4ERR_XDEV, "XDEV" }, \
-		/* ***** Internal to Linux NFS client ***** */ \
-		{ NFS4ERR_RESET_TO_MDS, "RESET_TO_MDS" }, \
-		{ NFS4ERR_RESET_TO_PNFS, "RESET_TO_PNFS" })
+#include <trace/events/nfs.h>
 
 #define show_nfs_fattr_flags(valid) \
 	__print_flags((unsigned long)valid, "|", \
@@ -355,7 +53,7 @@ DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_printk(
 			"error=%ld (%s) dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__get_str(dstaddr)
 		)
 );
@@ -379,29 +77,6 @@ DEFINE_NFS4_CLIENTID_EVENT(nfs4_bind_conn_to_session);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_sequence);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_reclaim_complete);
 
-#define show_nfs4_sequence_status_flags(status) \
-	__print_flags((unsigned long)status, "|", \
-		{ SEQ4_STATUS_CB_PATH_DOWN, "CB_PATH_DOWN" }, \
-		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING, \
-			"CB_GSS_CONTEXTS_EXPIRING" }, \
-		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED, \
-			"CB_GSS_CONTEXTS_EXPIRED" }, \
-		{ SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED, \
-			"EXPIRED_ALL_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED, \
-			"EXPIRED_SOME_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_ADMIN_STATE_REVOKED, \
-			"ADMIN_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_RECALLABLE_STATE_REVOKED,	 \
-			"RECALLABLE_STATE_REVOKED" }, \
-		{ SEQ4_STATUS_LEASE_MOVED, "LEASE_MOVED" }, \
-		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED, \
-			"RESTART_RECLAIM_NEEDED" }, \
-		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION, \
-			"CB_PATH_DOWN_SESSION" }, \
-		{ SEQ4_STATUS_BACKCHANNEL_FAULT, \
-			"BACKCHANNEL_FAULT" })
-
 TRACE_EVENT(nfs4_sequence_done,
 		TP_PROTO(
 			const struct nfs4_session *session,
@@ -415,7 +90,7 @@ TRACE_EVENT(nfs4_sequence_done,
 			__field(unsigned int, seq_nr)
 			__field(unsigned int, highest_slotid)
 			__field(unsigned int, target_highest_slotid)
-			__field(unsigned int, status_flags)
+			__field(unsigned long, status_flags)
 			__field(unsigned long, error)
 		),
 
@@ -434,16 +109,16 @@ TRACE_EVENT(nfs4_sequence_done,
 		TP_printk(
 			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
 			"highest_slotid=%u target_highest_slotid=%u "
-			"status_flags=%u (%s)",
+			"status_flags=0x%lx (%s)",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__entry->session,
 			__entry->slot_nr,
 			__entry->seq_nr,
 			__entry->highest_slotid,
 			__entry->target_highest_slotid,
 			__entry->status_flags,
-			show_nfs4_sequence_status_flags(__entry->status_flags)
+			show_nfs4_seq4_status(__entry->status_flags)
 		)
 );
 
@@ -480,7 +155,7 @@ TRACE_EVENT(nfs4_cb_sequence,
 			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
 			"highest_slotid=%u",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__entry->session,
 			__entry->slot_nr,
 			__entry->seq_nr,
@@ -517,7 +192,7 @@ TRACE_EVENT(nfs4_cb_seqid_err,
 			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
 			"highest_slotid=%u",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__entry->session,
 			__entry->slot_nr,
 			__entry->seq_nr,
@@ -653,7 +328,7 @@ TRACE_EVENT(nfs4_state_mgr_failed,
 			"hostname=%s clp state=%s error=%ld (%s) section=%s",
 			__get_str(hostname),
 			show_nfs4_clp_state(__entry->state), -__entry->error,
-			show_nfsv4_errors(__entry->error), __get_str(section)
+			show_nfs4_status(__entry->error), __get_str(section)
 
 		)
 )
@@ -724,7 +399,7 @@ DECLARE_EVENT_CLASS(nfs4_xdr_event,
 		TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
 			  " xid=0x%08x error=%ld (%s) operation=%u",
 			__entry->task_id, __entry->client_id, __entry->xid,
-			-__entry->error, show_nfsv4_errors(__entry->error),
+			-__entry->error, show_nfs4_status(__entry->error),
 			__entry->op
 		)
 );
@@ -839,7 +514,7 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 			"name=%02x:%02x:%llu/%s stateid=%d:0x%08x "
 			"openstateid=%d:0x%08x",
 			 -__entry->error,
-			 show_nfsv4_errors(__entry->error),
+			 show_nfs4_status(__entry->error),
 			 __entry->flags,
 			 show_fs_fcntl_open_flags(__entry->flags),
 			 show_fs_fmode_flags(__entry->fmode),
@@ -943,7 +618,7 @@ TRACE_EVENT(nfs4_close,
 			"error=%ld (%s) fmode=%s fileid=%02x:%02x:%llu "
 			"fhandle=0x%08x openstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			__entry->fmode ?  show_fs_fmode_flags(__entry->fmode) :
 					  "closed",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -998,7 +673,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			show_fs_fcntl_cmd(__entry->cmd),
 			show_fs_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
@@ -1074,7 +749,7 @@ TRACE_EVENT(nfs4_set_lock,
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x lockstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			show_fs_fcntl_cmd(__entry->cmd),
 			show_fs_fcntl_lock_type(__entry->type),
 			(long long)__entry->start,
@@ -1240,7 +915,7 @@ TRACE_EVENT(nfs4_delegreturn_exit,
 			"error=%ld (%s) dev=%02x:%02x fhandle=0x%08x "
 			"stateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			__entry->fhandle,
 			__entry->stateid_seq, __entry->stateid_hash
@@ -1283,7 +958,7 @@ DECLARE_EVENT_CLASS(nfs4_test_stateid_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1330,7 +1005,7 @@ DECLARE_EVENT_CLASS(nfs4_lookup_event,
 		TP_printk(
 			"error=%ld (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -1377,7 +1052,7 @@ TRACE_EVENT(nfs4_lookupp,
 		TP_printk(
 			"error=%ld (%s) inode=%02x:%02x:%llu",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->ino
 		)
@@ -1416,7 +1091,7 @@ TRACE_EVENT(nfs4_rename,
 			"error=%ld (%s) oldname=%02x:%02x:%llu/%s "
 			"newname=%02x:%02x:%llu/%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->olddir,
 			__get_str(oldname),
@@ -1451,7 +1126,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_event,
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle
@@ -1509,7 +1184,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1562,7 +1237,7 @@ DECLARE_EVENT_CLASS(nfs4_getattr_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"valid=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1618,7 +1293,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_callback_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1679,7 +1354,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1728,7 +1403,7 @@ DECLARE_EVENT_CLASS(nfs4_idmap_event,
 
 		TP_printk(
 			"error=%ld (%s) id=%u name=%s",
-			-__entry->error, show_nfsv4_errors(__entry->error),
+			-__entry->error, show_nfs4_status(__entry->error),
 			__entry->id,
 			__get_str(name)
 		)
@@ -1806,7 +1481,7 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 			"offset=%lld count=%u res=%u stateid=%d:0x%08x "
 			"layoutstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1880,7 +1555,7 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 			"offset=%lld count=%u res=%u stateid=%d:0x%08x "
 			"layoutstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1944,7 +1619,7 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%lld count=%u layoutstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -1964,16 +1639,6 @@ DEFINE_NFS4_COMMIT_EVENT(nfs4_commit);
 #ifdef CONFIG_NFS_V4_1
 DEFINE_NFS4_COMMIT_EVENT(nfs4_pnfs_commit_ds);
 
-TRACE_DEFINE_ENUM(IOMODE_READ);
-TRACE_DEFINE_ENUM(IOMODE_RW);
-TRACE_DEFINE_ENUM(IOMODE_ANY);
-
-#define show_pnfs_iomode(iomode) \
-	__print_symbolic(iomode, \
-		{ IOMODE_READ, "READ" }, \
-		{ IOMODE_RW, "RW" }, \
-		{ IOMODE_ANY, "ANY" })
-
 TRACE_EVENT(nfs4_layoutget,
 		TP_PROTO(
 			const struct nfs_open_context *ctx,
@@ -2029,11 +1694,11 @@ TRACE_EVENT(nfs4_layoutget,
 			"iomode=%s offset=%llu count=%llu stateid=%d:0x%08x "
 			"layoutstateid=%d:0x%08x",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			show_pnfs_iomode(__entry->iomode),
+			show_pnfs_layout_iomode(__entry->iomode),
 			(unsigned long long)__entry->offset,
 			(unsigned long long)__entry->count,
 			__entry->stateid_seq, __entry->stateid_hash,
@@ -2127,7 +1792,7 @@ TRACE_EVENT(pnfs_update_layout,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			show_pnfs_iomode(__entry->iomode),
+			show_pnfs_layout_iomode(__entry->iomode),
 			(unsigned long long)__entry->pos,
 			(unsigned long long)__entry->count,
 			__entry->layoutstateid_seq, __entry->layoutstateid_hash,
@@ -2181,7 +1846,7 @@ DECLARE_EVENT_CLASS(pnfs_layout_event,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			show_pnfs_iomode(__entry->iomode),
+			show_pnfs_layout_iomode(__entry->iomode),
 			(unsigned long long)__entry->pos,
 			(unsigned long long)__entry->count,
 			__entry->layoutstateid_seq, __entry->layoutstateid_hash,
@@ -2326,7 +1991,7 @@ DECLARE_EVENT_CLASS(nfs4_flexfiles_io_event,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%llu count=%u stateid=%d:0x%08x dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -2382,7 +2047,7 @@ TRACE_EVENT(ff_layout_commit_error,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%llu count=%u dstaddr=%s",
 			-__entry->error,
-			show_nfsv4_errors(__entry->error),
+			show_nfs4_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 918237677a383..f6013d3b110b8 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -12,6 +12,7 @@
 #include <linux/iversion.h>
 
 #include <trace/events/fs.h>
+#include <trace/events/nfs.h>
 #include <trace/events/sunrpc_base.h>
 
 #define nfs_show_cache_validity(v) \
@@ -115,7 +116,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"type=%u (%s) version=%llu size=%lld "
 			"cache_validity=0x%lx (%s) nfs_flags=0x%lx (%s)",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -206,7 +207,7 @@ TRACE_EVENT(nfs_access_exit,
 			"type=%u (%s) version=%llu size=%lld "
 			"cache_validity=0x%lx (%s) nfs_flags=0x%lx (%s) "
 			"mask=0x%x permitted=0x%x",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -292,7 +293,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 
 		TP_printk(
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			__entry->flags,
 			show_fs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -383,7 +384,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 		TP_printk(
 			"error=%ld (%s) flags=0x%lx (%s) fmode=%s "
 			"name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			__entry->flags,
 			show_fs_fcntl_open_flags(__entry->flags),
 			show_fs_fmode_flags(__entry->fmode),
@@ -454,7 +455,7 @@ TRACE_EVENT(nfs_create_exit,
 
 		TP_printk(
 			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			__entry->flags,
 			show_fs_fcntl_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -524,7 +525,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event_done,
 
 		TP_printk(
 			"error=%ld (%s) name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -614,7 +615,7 @@ TRACE_EVENT(nfs_link_exit,
 
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			__entry->fileid,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -701,7 +702,7 @@ DECLARE_EVENT_CLASS(nfs_rename_event_done,
 		TP_printk(
 			"error=%ld (%s) old_name=%02x:%02x:%llu/%s "
 			"new_name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->old_dir,
 			__get_str(old_name),
@@ -755,7 +756,7 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 
 		TP_printk(
 			"error=%ld (%s) name=%02x:%02x:%llu/%s",
-			-__entry->error, nfs_show_status(__entry->error),
+			-__entry->error, show_nfs_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -938,16 +939,6 @@ TRACE_EVENT(nfs_pgio_error,
 	)
 );
 
-TRACE_DEFINE_ENUM(NFS_UNSTABLE);
-TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
-TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
-
-#define nfs_show_stable(stable) \
-	__print_symbolic(stable, \
-			{ NFS_UNSTABLE, "UNSTABLE" }, \
-			{ NFS_DATA_SYNC, "DATA_SYNC" }, \
-			{ NFS_FILE_SYNC, "FILE_SYNC" })
-
 TRACE_EVENT(nfs_initiate_write,
 		TP_PROTO(
 			const struct nfs_pgio_header *hdr
@@ -961,7 +952,7 @@ TRACE_EVENT(nfs_initiate_write,
 			__field(u64, fileid)
 			__field(loff_t, offset)
 			__field(u32, count)
-			__field(enum nfs3_stable_how, stable)
+			__field(unsigned long, stable)
 		),
 
 		TP_fast_assign(
@@ -985,7 +976,7 @@ TRACE_EVENT(nfs_initiate_write,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset, __entry->count,
-			nfs_show_stable(__entry->stable)
+			show_nfs_stable_how(__entry->stable)
 		)
 );
 
@@ -1005,7 +996,7 @@ TRACE_EVENT(nfs_writeback_done,
 			__field(u32, arg_count)
 			__field(u32, res_count)
 			__field(int, status)
-			__field(enum nfs3_stable_how, stable)
+			__field(unsigned long, stable)
 			__array(char, verifier, NFS4_VERIFIER_SIZE)
 		),
 
@@ -1038,8 +1029,8 @@ TRACE_EVENT(nfs_writeback_done,
 			__entry->fhandle,
 			(long long)__entry->offset, __entry->arg_count,
 			__entry->res_count, __entry->status,
-			nfs_show_stable(__entry->stable),
-			__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE)
+			show_nfs_stable_how(__entry->stable),
+			show_nfs4_verifier(__entry->verifier)
 		)
 );
 
@@ -1140,7 +1131,7 @@ TRACE_EVENT(nfs_commit_done,
 			__field(u64, fileid)
 			__field(loff_t, offset)
 			__field(int, status)
-			__field(enum nfs3_stable_how, stable)
+			__field(unsigned long, stable)
 			__array(char, verifier, NFS4_VERIFIER_SIZE)
 		),
 
@@ -1169,8 +1160,8 @@ TRACE_EVENT(nfs_commit_done,
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset, __entry->status,
-			nfs_show_stable(__entry->stable),
-			__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE)
+			show_nfs_stable_how(__entry->stable),
+			show_nfs4_verifier(__entry->verifier)
 		)
 );
 
@@ -1207,76 +1198,6 @@ TRACE_EVENT(nfs_fh_to_dentry,
 		)
 );
 
-TRACE_DEFINE_ENUM(NFS_OK);
-TRACE_DEFINE_ENUM(NFSERR_PERM);
-TRACE_DEFINE_ENUM(NFSERR_NOENT);
-TRACE_DEFINE_ENUM(NFSERR_IO);
-TRACE_DEFINE_ENUM(NFSERR_NXIO);
-TRACE_DEFINE_ENUM(ECHILD);
-TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
-TRACE_DEFINE_ENUM(NFSERR_ACCES);
-TRACE_DEFINE_ENUM(NFSERR_EXIST);
-TRACE_DEFINE_ENUM(NFSERR_XDEV);
-TRACE_DEFINE_ENUM(NFSERR_NODEV);
-TRACE_DEFINE_ENUM(NFSERR_NOTDIR);
-TRACE_DEFINE_ENUM(NFSERR_ISDIR);
-TRACE_DEFINE_ENUM(NFSERR_INVAL);
-TRACE_DEFINE_ENUM(NFSERR_FBIG);
-TRACE_DEFINE_ENUM(NFSERR_NOSPC);
-TRACE_DEFINE_ENUM(NFSERR_ROFS);
-TRACE_DEFINE_ENUM(NFSERR_MLINK);
-TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
-TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
-TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
-TRACE_DEFINE_ENUM(NFSERR_DQUOT);
-TRACE_DEFINE_ENUM(NFSERR_STALE);
-TRACE_DEFINE_ENUM(NFSERR_REMOTE);
-TRACE_DEFINE_ENUM(NFSERR_WFLUSH);
-TRACE_DEFINE_ENUM(NFSERR_BADHANDLE);
-TRACE_DEFINE_ENUM(NFSERR_NOT_SYNC);
-TRACE_DEFINE_ENUM(NFSERR_BAD_COOKIE);
-TRACE_DEFINE_ENUM(NFSERR_NOTSUPP);
-TRACE_DEFINE_ENUM(NFSERR_TOOSMALL);
-TRACE_DEFINE_ENUM(NFSERR_SERVERFAULT);
-TRACE_DEFINE_ENUM(NFSERR_BADTYPE);
-TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
-
-#define nfs_show_status(x) \
-	__print_symbolic(x, \
-			{ NFS_OK, "OK" }, \
-			{ NFSERR_PERM, "PERM" }, \
-			{ NFSERR_NOENT, "NOENT" }, \
-			{ NFSERR_IO, "IO" }, \
-			{ NFSERR_NXIO, "NXIO" }, \
-			{ ECHILD, "CHILD" }, \
-			{ NFSERR_EAGAIN, "AGAIN" }, \
-			{ NFSERR_ACCES, "ACCES" }, \
-			{ NFSERR_EXIST, "EXIST" }, \
-			{ NFSERR_XDEV, "XDEV" }, \
-			{ NFSERR_NODEV, "NODEV" }, \
-			{ NFSERR_NOTDIR, "NOTDIR" }, \
-			{ NFSERR_ISDIR, "ISDIR" }, \
-			{ NFSERR_INVAL, "INVAL" }, \
-			{ NFSERR_FBIG, "FBIG" }, \
-			{ NFSERR_NOSPC, "NOSPC" }, \
-			{ NFSERR_ROFS, "ROFS" }, \
-			{ NFSERR_MLINK, "MLINK" }, \
-			{ NFSERR_OPNOTSUPP, "OPNOTSUPP" }, \
-			{ NFSERR_NAMETOOLONG, "NAMETOOLONG" }, \
-			{ NFSERR_NOTEMPTY, "NOTEMPTY" }, \
-			{ NFSERR_DQUOT, "DQUOT" }, \
-			{ NFSERR_STALE, "STALE" }, \
-			{ NFSERR_REMOTE, "REMOTE" }, \
-			{ NFSERR_WFLUSH, "WFLUSH" }, \
-			{ NFSERR_BADHANDLE, "BADHANDLE" }, \
-			{ NFSERR_NOT_SYNC, "NOTSYNC" }, \
-			{ NFSERR_BAD_COOKIE, "BADCOOKIE" }, \
-			{ NFSERR_NOTSUPP, "NOTSUPP" }, \
-			{ NFSERR_TOOSMALL, "TOOSMALL" }, \
-			{ NFSERR_SERVERFAULT, "REMOTEIO" }, \
-			{ NFSERR_BADTYPE, "BADTYPE" }, \
-			{ NFSERR_JUKEBOX, "JUKEBOX" })
-
 DECLARE_EVENT_CLASS(nfs_xdr_event,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
@@ -1316,7 +1237,7 @@ DECLARE_EVENT_CLASS(nfs_xdr_event,
 			__entry->task_id, __entry->client_id, __entry->xid,
 			__get_str(program), __entry->version,
 			__get_str(procedure), -__entry->error,
-			nfs_show_status(__entry->error)
+			show_nfs_status(__entry->error)
 		)
 );
 #define DEFINE_NFS_XDR_EVENT(name) \
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 3307361c79560..f331f067691b0 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -82,10 +82,6 @@ enum pnfs_try_status {
 	PNFS_TRY_AGAIN     = 2,
 };
 
-/* error codes for internal use */
-#define NFS4ERR_RESET_TO_MDS   12001
-#define NFS4ERR_RESET_TO_PNFS  12002
-
 #ifdef CONFIG_NFS_V4_1
 
 #define LAYOUT_NFSV4_1_MODULE_PREFIX "nfs-layouttype4"
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 7e7d0f1705ed3..61943a629cdee 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -9,6 +9,7 @@
 #define _NFSD_TRACE_H
 
 #include <linux/tracepoint.h>
+
 #include "export.h"
 #include "nfsfh.h"
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 15004c469807d..5662d8be04eb0 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -292,6 +292,10 @@ enum nfsstat4 {
 	NFS4ERR_XATTR2BIG      = 10096,
 };
 
+/* error codes for internal client use */
+#define NFS4ERR_RESET_TO_MDS   12001
+#define NFS4ERR_RESET_TO_PNFS  12002
+
 static inline bool seqid_mutating_err(u32 err)
 {
 	/* See RFC 7530, section 9.1.7 */
diff --git a/include/trace/events/nfs.h b/include/trace/events/nfs.h
new file mode 100644
index 0000000000000..09ffdbb04134d
--- /dev/null
+++ b/include/trace/events/nfs.h
@@ -0,0 +1,375 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Display helpers for NFS protocol elements
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <linux/nfs.h>
+#include <linux/nfs4.h>
+#include <uapi/linux/nfs.h>
+
+TRACE_DEFINE_ENUM(NFS_OK);
+TRACE_DEFINE_ENUM(NFSERR_PERM);
+TRACE_DEFINE_ENUM(NFSERR_NOENT);
+TRACE_DEFINE_ENUM(NFSERR_IO);
+TRACE_DEFINE_ENUM(NFSERR_NXIO);
+TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
+TRACE_DEFINE_ENUM(NFSERR_ACCES);
+TRACE_DEFINE_ENUM(NFSERR_EXIST);
+TRACE_DEFINE_ENUM(NFSERR_XDEV);
+TRACE_DEFINE_ENUM(NFSERR_NODEV);
+TRACE_DEFINE_ENUM(NFSERR_NOTDIR);
+TRACE_DEFINE_ENUM(NFSERR_ISDIR);
+TRACE_DEFINE_ENUM(NFSERR_INVAL);
+TRACE_DEFINE_ENUM(NFSERR_FBIG);
+TRACE_DEFINE_ENUM(NFSERR_NOSPC);
+TRACE_DEFINE_ENUM(NFSERR_ROFS);
+TRACE_DEFINE_ENUM(NFSERR_MLINK);
+TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
+TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
+TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
+TRACE_DEFINE_ENUM(NFSERR_DQUOT);
+TRACE_DEFINE_ENUM(NFSERR_STALE);
+TRACE_DEFINE_ENUM(NFSERR_REMOTE);
+TRACE_DEFINE_ENUM(NFSERR_WFLUSH);
+TRACE_DEFINE_ENUM(NFSERR_BADHANDLE);
+TRACE_DEFINE_ENUM(NFSERR_NOT_SYNC);
+TRACE_DEFINE_ENUM(NFSERR_BAD_COOKIE);
+TRACE_DEFINE_ENUM(NFSERR_NOTSUPP);
+TRACE_DEFINE_ENUM(NFSERR_TOOSMALL);
+TRACE_DEFINE_ENUM(NFSERR_SERVERFAULT);
+TRACE_DEFINE_ENUM(NFSERR_BADTYPE);
+TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
+
+#define show_nfs_status(x) \
+	__print_symbolic(x, \
+		{ NFS_OK,			"OK" }, \
+		{ NFSERR_PERM,			"PERM" }, \
+		{ NFSERR_NOENT,			"NOENT" }, \
+		{ NFSERR_IO,			"IO" }, \
+		{ NFSERR_NXIO,			"NXIO" }, \
+		{ ECHILD,			"CHILD" }, \
+		{ NFSERR_EAGAIN,		"AGAIN" }, \
+		{ NFSERR_ACCES,			"ACCES" }, \
+		{ NFSERR_EXIST,			"EXIST" }, \
+		{ NFSERR_XDEV,			"XDEV" }, \
+		{ NFSERR_NODEV,			"NODEV" }, \
+		{ NFSERR_NOTDIR,		"NOTDIR" }, \
+		{ NFSERR_ISDIR,			"ISDIR" }, \
+		{ NFSERR_INVAL,			"INVAL" }, \
+		{ NFSERR_FBIG,			"FBIG" }, \
+		{ NFSERR_NOSPC,			"NOSPC" }, \
+		{ NFSERR_ROFS,			"ROFS" }, \
+		{ NFSERR_MLINK,			"MLINK" }, \
+		{ NFSERR_OPNOTSUPP,		"OPNOTSUPP" }, \
+		{ NFSERR_NAMETOOLONG,		"NAMETOOLONG" }, \
+		{ NFSERR_NOTEMPTY,		"NOTEMPTY" }, \
+		{ NFSERR_DQUOT,			"DQUOT" }, \
+		{ NFSERR_STALE,			"STALE" }, \
+		{ NFSERR_REMOTE,		"REMOTE" }, \
+		{ NFSERR_WFLUSH,		"WFLUSH" }, \
+		{ NFSERR_BADHANDLE,		"BADHANDLE" }, \
+		{ NFSERR_NOT_SYNC,		"NOTSYNC" }, \
+		{ NFSERR_BAD_COOKIE,		"BADCOOKIE" }, \
+		{ NFSERR_NOTSUPP,		"NOTSUPP" }, \
+		{ NFSERR_TOOSMALL,		"TOOSMALL" }, \
+		{ NFSERR_SERVERFAULT,		"REMOTEIO" }, \
+		{ NFSERR_BADTYPE,		"BADTYPE" }, \
+		{ NFSERR_JUKEBOX,		"JUKEBOX" })
+
+TRACE_DEFINE_ENUM(NFS_UNSTABLE);
+TRACE_DEFINE_ENUM(NFS_DATA_SYNC);
+TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
+
+#define show_nfs_stable_how(x) \
+	__print_symbolic(x, \
+		{ NFS_UNSTABLE,			"UNSTABLE" }, \
+		{ NFS_DATA_SYNC,		"DATA_SYNC" }, \
+		{ NFS_FILE_SYNC,		"FILE_SYNC" })
+
+TRACE_DEFINE_ENUM(NFS4_OK);
+TRACE_DEFINE_ENUM(NFS4ERR_ACCESS);
+TRACE_DEFINE_ENUM(NFS4ERR_ATTRNOTSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_ADMIN_REVOKED);
+TRACE_DEFINE_ENUM(NFS4ERR_BACK_CHAN_BUSY);
+TRACE_DEFINE_ENUM(NFS4ERR_BADCHAR);
+TRACE_DEFINE_ENUM(NFS4ERR_BADHANDLE);
+TRACE_DEFINE_ENUM(NFS4ERR_BADIOMODE);
+TRACE_DEFINE_ENUM(NFS4ERR_BADLAYOUT);
+TRACE_DEFINE_ENUM(NFS4ERR_BADLABEL);
+TRACE_DEFINE_ENUM(NFS4ERR_BADNAME);
+TRACE_DEFINE_ENUM(NFS4ERR_BADOWNER);
+TRACE_DEFINE_ENUM(NFS4ERR_BADSESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_BADSLOT);
+TRACE_DEFINE_ENUM(NFS4ERR_BADTYPE);
+TRACE_DEFINE_ENUM(NFS4ERR_BADXDR);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_COOKIE);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_HIGH_SLOT);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_RANGE);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_SEQID);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_SESSION_DIGEST);
+TRACE_DEFINE_ENUM(NFS4ERR_BAD_STATEID);
+TRACE_DEFINE_ENUM(NFS4ERR_CB_PATH_DOWN);
+TRACE_DEFINE_ENUM(NFS4ERR_CLID_INUSE);
+TRACE_DEFINE_ENUM(NFS4ERR_CLIENTID_BUSY);
+TRACE_DEFINE_ENUM(NFS4ERR_COMPLETE_ALREADY);
+TRACE_DEFINE_ENUM(NFS4ERR_CONN_NOT_BOUND_TO_SESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_DEADLOCK);
+TRACE_DEFINE_ENUM(NFS4ERR_DEADSESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_DELAY);
+TRACE_DEFINE_ENUM(NFS4ERR_DELEG_ALREADY_WANTED);
+TRACE_DEFINE_ENUM(NFS4ERR_DELEG_REVOKED);
+TRACE_DEFINE_ENUM(NFS4ERR_DENIED);
+TRACE_DEFINE_ENUM(NFS4ERR_DIRDELEG_UNAVAIL);
+TRACE_DEFINE_ENUM(NFS4ERR_DQUOT);
+TRACE_DEFINE_ENUM(NFS4ERR_ENCR_ALG_UNSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_EXIST);
+TRACE_DEFINE_ENUM(NFS4ERR_EXPIRED);
+TRACE_DEFINE_ENUM(NFS4ERR_FBIG);
+TRACE_DEFINE_ENUM(NFS4ERR_FHEXPIRED);
+TRACE_DEFINE_ENUM(NFS4ERR_FILE_OPEN);
+TRACE_DEFINE_ENUM(NFS4ERR_GRACE);
+TRACE_DEFINE_ENUM(NFS4ERR_HASH_ALG_UNSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_INVAL);
+TRACE_DEFINE_ENUM(NFS4ERR_IO);
+TRACE_DEFINE_ENUM(NFS4ERR_ISDIR);
+TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTTRYLATER);
+TRACE_DEFINE_ENUM(NFS4ERR_LAYOUTUNAVAILABLE);
+TRACE_DEFINE_ENUM(NFS4ERR_LEASE_MOVED);
+TRACE_DEFINE_ENUM(NFS4ERR_LOCKED);
+TRACE_DEFINE_ENUM(NFS4ERR_LOCKS_HELD);
+TRACE_DEFINE_ENUM(NFS4ERR_LOCK_RANGE);
+TRACE_DEFINE_ENUM(NFS4ERR_MINOR_VERS_MISMATCH);
+TRACE_DEFINE_ENUM(NFS4ERR_MLINK);
+TRACE_DEFINE_ENUM(NFS4ERR_MOVED);
+TRACE_DEFINE_ENUM(NFS4ERR_NAMETOOLONG);
+TRACE_DEFINE_ENUM(NFS4ERR_NOENT);
+TRACE_DEFINE_ENUM(NFS4ERR_NOFILEHANDLE);
+TRACE_DEFINE_ENUM(NFS4ERR_NOMATCHING_LAYOUT);
+TRACE_DEFINE_ENUM(NFS4ERR_NOSPC);
+TRACE_DEFINE_ENUM(NFS4ERR_NOTDIR);
+TRACE_DEFINE_ENUM(NFS4ERR_NOTEMPTY);
+TRACE_DEFINE_ENUM(NFS4ERR_NOTSUPP);
+TRACE_DEFINE_ENUM(NFS4ERR_NOT_ONLY_OP);
+TRACE_DEFINE_ENUM(NFS4ERR_NOT_SAME);
+TRACE_DEFINE_ENUM(NFS4ERR_NO_GRACE);
+TRACE_DEFINE_ENUM(NFS4ERR_NXIO);
+TRACE_DEFINE_ENUM(NFS4ERR_OLD_STATEID);
+TRACE_DEFINE_ENUM(NFS4ERR_OPENMODE);
+TRACE_DEFINE_ENUM(NFS4ERR_OP_ILLEGAL);
+TRACE_DEFINE_ENUM(NFS4ERR_OP_NOT_IN_SESSION);
+TRACE_DEFINE_ENUM(NFS4ERR_PERM);
+TRACE_DEFINE_ENUM(NFS4ERR_PNFS_IO_HOLE);
+TRACE_DEFINE_ENUM(NFS4ERR_PNFS_NO_LAYOUT);
+TRACE_DEFINE_ENUM(NFS4ERR_RECALLCONFLICT);
+TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_BAD);
+TRACE_DEFINE_ENUM(NFS4ERR_RECLAIM_CONFLICT);
+TRACE_DEFINE_ENUM(NFS4ERR_REJECT_DELEG);
+TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG);
+TRACE_DEFINE_ENUM(NFS4ERR_REP_TOO_BIG_TO_CACHE);
+TRACE_DEFINE_ENUM(NFS4ERR_REQ_TOO_BIG);
+TRACE_DEFINE_ENUM(NFS4ERR_RESOURCE);
+TRACE_DEFINE_ENUM(NFS4ERR_RESTOREFH);
+TRACE_DEFINE_ENUM(NFS4ERR_RETRY_UNCACHED_REP);
+TRACE_DEFINE_ENUM(NFS4ERR_RETURNCONFLICT);
+TRACE_DEFINE_ENUM(NFS4ERR_ROFS);
+TRACE_DEFINE_ENUM(NFS4ERR_SAME);
+TRACE_DEFINE_ENUM(NFS4ERR_SHARE_DENIED);
+TRACE_DEFINE_ENUM(NFS4ERR_SEQUENCE_POS);
+TRACE_DEFINE_ENUM(NFS4ERR_SEQ_FALSE_RETRY);
+TRACE_DEFINE_ENUM(NFS4ERR_SEQ_MISORDERED);
+TRACE_DEFINE_ENUM(NFS4ERR_SERVERFAULT);
+TRACE_DEFINE_ENUM(NFS4ERR_STALE);
+TRACE_DEFINE_ENUM(NFS4ERR_STALE_CLIENTID);
+TRACE_DEFINE_ENUM(NFS4ERR_STALE_STATEID);
+TRACE_DEFINE_ENUM(NFS4ERR_SYMLINK);
+TRACE_DEFINE_ENUM(NFS4ERR_TOOSMALL);
+TRACE_DEFINE_ENUM(NFS4ERR_TOO_MANY_OPS);
+TRACE_DEFINE_ENUM(NFS4ERR_UNKNOWN_LAYOUTTYPE);
+TRACE_DEFINE_ENUM(NFS4ERR_UNSAFE_COMPOUND);
+TRACE_DEFINE_ENUM(NFS4ERR_WRONGSEC);
+TRACE_DEFINE_ENUM(NFS4ERR_WRONG_CRED);
+TRACE_DEFINE_ENUM(NFS4ERR_WRONG_TYPE);
+TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
+
+TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_MDS);
+TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
+
+#define show_nfs4_status(x) \
+	__print_symbolic(x, \
+		{ NFS4_OK,			"OK" }, \
+		{ EPERM,			"EPERM" }, \
+		{ ENOENT,			"ENOENT" }, \
+		{ EIO,				"EIO" }, \
+		{ ENXIO,			"ENXIO" }, \
+		{ EACCES,			"EACCES" }, \
+		{ EEXIST,			"EEXIST" }, \
+		{ EXDEV,			"EXDEV" }, \
+		{ ENOTDIR,			"ENOTDIR" }, \
+		{ EISDIR,			"EISDIR" }, \
+		{ EFBIG,			"EFBIG" }, \
+		{ ENOSPC,			"ENOSPC" }, \
+		{ EROFS,			"EROFS" }, \
+		{ EMLINK,			"EMLINK" }, \
+		{ ENAMETOOLONG,			"ENAMETOOLONG" }, \
+		{ ENOTEMPTY,			"ENOTEMPTY" }, \
+		{ EDQUOT,			"EDQUOT" }, \
+		{ ESTALE,			"ESTALE" }, \
+		{ EBADHANDLE,			"EBADHANDLE" }, \
+		{ EBADCOOKIE,			"EBADCOOKIE" }, \
+		{ ENOTSUPP,			"ENOTSUPP" }, \
+		{ ETOOSMALL,			"ETOOSMALL" }, \
+		{ EREMOTEIO,			"EREMOTEIO" }, \
+		{ EBADTYPE,			"EBADTYPE" }, \
+		{ EAGAIN,			"EAGAIN" }, \
+		{ ELOOP,			"ELOOP" }, \
+		{ EOPNOTSUPP,			"EOPNOTSUPP" }, \
+		{ EDEADLK,			"EDEADLK" }, \
+		{ ENOMEM,			"ENOMEM" }, \
+		{ EKEYEXPIRED,			"EKEYEXPIRED" }, \
+		{ ETIMEDOUT,			"ETIMEDOUT" }, \
+		{ ERESTARTSYS,			"ERESTARTSYS" }, \
+		{ ECONNREFUSED,			"ECONNREFUSED" }, \
+		{ ECONNRESET,			"ECONNRESET" }, \
+		{ ENETUNREACH,			"ENETUNREACH" }, \
+		{ EHOSTUNREACH,			"EHOSTUNREACH" }, \
+		{ EHOSTDOWN,			"EHOSTDOWN" }, \
+		{ EPIPE,			"EPIPE" }, \
+		{ EPFNOSUPPORT,			"EPFNOSUPPORT" }, \
+		{ EPROTONOSUPPORT,		"EPROTONOSUPPORT" }, \
+		{ NFS4ERR_ACCESS,		"ACCESS" }, \
+		{ NFS4ERR_ATTRNOTSUPP,		"ATTRNOTSUPP" }, \
+		{ NFS4ERR_ADMIN_REVOKED,	"ADMIN_REVOKED" }, \
+		{ NFS4ERR_BACK_CHAN_BUSY,	"BACK_CHAN_BUSY" }, \
+		{ NFS4ERR_BADCHAR,		"BADCHAR" }, \
+		{ NFS4ERR_BADHANDLE,		"BADHANDLE" }, \
+		{ NFS4ERR_BADIOMODE,		"BADIOMODE" }, \
+		{ NFS4ERR_BADLAYOUT,		"BADLAYOUT" }, \
+		{ NFS4ERR_BADLABEL,		"BADLABEL" }, \
+		{ NFS4ERR_BADNAME,		"BADNAME" }, \
+		{ NFS4ERR_BADOWNER,		"BADOWNER" }, \
+		{ NFS4ERR_BADSESSION,		"BADSESSION" }, \
+		{ NFS4ERR_BADSLOT,		"BADSLOT" }, \
+		{ NFS4ERR_BADTYPE,		"BADTYPE" }, \
+		{ NFS4ERR_BADXDR,		"BADXDR" }, \
+		{ NFS4ERR_BAD_COOKIE,		"BAD_COOKIE" }, \
+		{ NFS4ERR_BAD_HIGH_SLOT,	"BAD_HIGH_SLOT" }, \
+		{ NFS4ERR_BAD_RANGE,		"BAD_RANGE" }, \
+		{ NFS4ERR_BAD_SEQID,		"BAD_SEQID" }, \
+		{ NFS4ERR_BAD_SESSION_DIGEST,	"BAD_SESSION_DIGEST" }, \
+		{ NFS4ERR_BAD_STATEID,		"BAD_STATEID" }, \
+		{ NFS4ERR_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
+		{ NFS4ERR_CLID_INUSE,		"CLID_INUSE" }, \
+		{ NFS4ERR_CLIENTID_BUSY,	"CLIENTID_BUSY" }, \
+		{ NFS4ERR_COMPLETE_ALREADY,	"COMPLETE_ALREADY" }, \
+		{ NFS4ERR_CONN_NOT_BOUND_TO_SESSION, "CONN_NOT_BOUND_TO_SESSION" }, \
+		{ NFS4ERR_DEADLOCK,		"DEADLOCK" }, \
+		{ NFS4ERR_DEADSESSION,		"DEAD_SESSION" }, \
+		{ NFS4ERR_DELAY,		"DELAY" }, \
+		{ NFS4ERR_DELEG_ALREADY_WANTED,	"DELEG_ALREADY_WANTED" }, \
+		{ NFS4ERR_DELEG_REVOKED,	"DELEG_REVOKED" }, \
+		{ NFS4ERR_DENIED,		"DENIED" }, \
+		{ NFS4ERR_DIRDELEG_UNAVAIL,	"DIRDELEG_UNAVAIL" }, \
+		{ NFS4ERR_DQUOT,		"DQUOT" }, \
+		{ NFS4ERR_ENCR_ALG_UNSUPP,	"ENCR_ALG_UNSUPP" }, \
+		{ NFS4ERR_EXIST,		"EXIST" }, \
+		{ NFS4ERR_EXPIRED,		"EXPIRED" }, \
+		{ NFS4ERR_FBIG,			"FBIG" }, \
+		{ NFS4ERR_FHEXPIRED,		"FHEXPIRED" }, \
+		{ NFS4ERR_FILE_OPEN,		"FILE_OPEN" }, \
+		{ NFS4ERR_GRACE,		"GRACE" }, \
+		{ NFS4ERR_HASH_ALG_UNSUPP,	"HASH_ALG_UNSUPP" }, \
+		{ NFS4ERR_INVAL,		"INVAL" }, \
+		{ NFS4ERR_IO,			"IO" }, \
+		{ NFS4ERR_ISDIR,		"ISDIR" }, \
+		{ NFS4ERR_LAYOUTTRYLATER,	"LAYOUTTRYLATER" }, \
+		{ NFS4ERR_LAYOUTUNAVAILABLE,	"LAYOUTUNAVAILABLE" }, \
+		{ NFS4ERR_LEASE_MOVED,		"LEASE_MOVED" }, \
+		{ NFS4ERR_LOCKED,		"LOCKED" }, \
+		{ NFS4ERR_LOCKS_HELD,		"LOCKS_HELD" }, \
+		{ NFS4ERR_LOCK_RANGE,		"LOCK_RANGE" }, \
+		{ NFS4ERR_MINOR_VERS_MISMATCH,	"MINOR_VERS_MISMATCH" }, \
+		{ NFS4ERR_MLINK,		"MLINK" }, \
+		{ NFS4ERR_MOVED,		"MOVED" }, \
+		{ NFS4ERR_NAMETOOLONG,		"NAMETOOLONG" }, \
+		{ NFS4ERR_NOENT,		"NOENT" }, \
+		{ NFS4ERR_NOFILEHANDLE,		"NOFILEHANDLE" }, \
+		{ NFS4ERR_NOMATCHING_LAYOUT,	"NOMATCHING_LAYOUT" }, \
+		{ NFS4ERR_NOSPC,		"NOSPC" }, \
+		{ NFS4ERR_NOTDIR,		"NOTDIR" }, \
+		{ NFS4ERR_NOTEMPTY,		"NOTEMPTY" }, \
+		{ NFS4ERR_NOTSUPP,		"NOTSUPP" }, \
+		{ NFS4ERR_NOT_ONLY_OP,		"NOT_ONLY_OP" }, \
+		{ NFS4ERR_NOT_SAME,		"NOT_SAME" }, \
+		{ NFS4ERR_NO_GRACE,		"NO_GRACE" }, \
+		{ NFS4ERR_NXIO,			"NXIO" }, \
+		{ NFS4ERR_OLD_STATEID,		"OLD_STATEID" }, \
+		{ NFS4ERR_OPENMODE,		"OPENMODE" }, \
+		{ NFS4ERR_OP_ILLEGAL,		"OP_ILLEGAL" }, \
+		{ NFS4ERR_OP_NOT_IN_SESSION,	"OP_NOT_IN_SESSION" }, \
+		{ NFS4ERR_PERM,			"PERM" }, \
+		{ NFS4ERR_PNFS_IO_HOLE,		"PNFS_IO_HOLE" }, \
+		{ NFS4ERR_PNFS_NO_LAYOUT,	"PNFS_NO_LAYOUT" }, \
+		{ NFS4ERR_RECALLCONFLICT,	"RECALLCONFLICT" }, \
+		{ NFS4ERR_RECLAIM_BAD,		"RECLAIM_BAD" }, \
+		{ NFS4ERR_RECLAIM_CONFLICT,	"RECLAIM_CONFLICT" }, \
+		{ NFS4ERR_REJECT_DELEG,		"REJECT_DELEG" }, \
+		{ NFS4ERR_REP_TOO_BIG,		"REP_TOO_BIG" }, \
+		{ NFS4ERR_REP_TOO_BIG_TO_CACHE,	"REP_TOO_BIG_TO_CACHE" }, \
+		{ NFS4ERR_REQ_TOO_BIG,		"REQ_TOO_BIG" }, \
+		{ NFS4ERR_RESOURCE,		"RESOURCE" }, \
+		{ NFS4ERR_RESTOREFH,		"RESTOREFH" }, \
+		{ NFS4ERR_RETRY_UNCACHED_REP,	"RETRY_UNCACHED_REP" }, \
+		{ NFS4ERR_RETURNCONFLICT,	"RETURNCONFLICT" }, \
+		{ NFS4ERR_ROFS,			"ROFS" }, \
+		{ NFS4ERR_SAME,			"SAME" }, \
+		{ NFS4ERR_SHARE_DENIED,		"SHARE_DENIED" }, \
+		{ NFS4ERR_SEQUENCE_POS,		"SEQUENCE_POS" }, \
+		{ NFS4ERR_SEQ_FALSE_RETRY,	"SEQ_FALSE_RETRY" }, \
+		{ NFS4ERR_SEQ_MISORDERED,	"SEQ_MISORDERED" }, \
+		{ NFS4ERR_SERVERFAULT,		"SERVERFAULT" }, \
+		{ NFS4ERR_STALE,		"STALE" }, \
+		{ NFS4ERR_STALE_CLIENTID,	"STALE_CLIENTID" }, \
+		{ NFS4ERR_STALE_STATEID,	"STALE_STATEID" }, \
+		{ NFS4ERR_SYMLINK,		"SYMLINK" }, \
+		{ NFS4ERR_TOOSMALL,		"TOOSMALL" }, \
+		{ NFS4ERR_TOO_MANY_OPS,		"TOO_MANY_OPS" }, \
+		{ NFS4ERR_UNKNOWN_LAYOUTTYPE,	"UNKNOWN_LAYOUTTYPE" }, \
+		{ NFS4ERR_UNSAFE_COMPOUND,	"UNSAFE_COMPOUND" }, \
+		{ NFS4ERR_WRONGSEC,		"WRONGSEC" }, \
+		{ NFS4ERR_WRONG_CRED,		"WRONG_CRED" }, \
+		{ NFS4ERR_WRONG_TYPE,		"WRONG_TYPE" }, \
+		{ NFS4ERR_XDEV,			"XDEV" }, \
+		/* ***** Internal to Linux NFS client ***** */ \
+		{ NFS4ERR_RESET_TO_MDS,		"RESET_TO_MDS" }, \
+		{ NFS4ERR_RESET_TO_PNFS,	"RESET_TO_PNFS" })
+
+#define show_nfs4_verifier(x) \
+	__print_hex_str(x, NFS4_VERIFIER_SIZE)
+
+TRACE_DEFINE_ENUM(IOMODE_READ);
+TRACE_DEFINE_ENUM(IOMODE_RW);
+TRACE_DEFINE_ENUM(IOMODE_ANY);
+
+#define show_pnfs_layout_iomode(x) \
+	__print_symbolic(x, \
+		{ IOMODE_READ,			"READ" }, \
+		{ IOMODE_RW,			"RW" }, \
+		{ IOMODE_ANY,			"ANY" })
+
+#define show_nfs4_seq4_status(x) \
+	__print_flags(x, "|", \
+		{ SEQ4_STATUS_CB_PATH_DOWN,		"CB_PATH_DOWN" }, \
+		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING,	"CB_GSS_CONTEXTS_EXPIRING" }, \
+		{ SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED,	"CB_GSS_CONTEXTS_EXPIRED" }, \
+		{ SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED, "EXPIRED_ALL_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED, "EXPIRED_SOME_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_ADMIN_STATE_REVOKED,	"ADMIN_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_RECALLABLE_STATE_REVOKED,	"RECALLABLE_STATE_REVOKED" }, \
+		{ SEQ4_STATUS_LEASE_MOVED,		"LEASE_MOVED" }, \
+		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED,	"RESTART_RECLAIM_NEEDED" }, \
+		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION,	"CB_PATH_DOWN_SESSION" }, \
+		{ SEQ4_STATUS_BACKCHANNEL_FAULT,	"BACKCHANNEL_FAULT" })
-- 
2.43.0




