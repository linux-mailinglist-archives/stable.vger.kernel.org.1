Return-Path: <stable+bounces-208125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D54D134B2
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 15:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A306F309F8DA
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443AC2E62D9;
	Mon, 12 Jan 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4Ib++9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A92E5D17
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228026; cv=none; b=YGDYzmzgwo91nfdlIbmL/d9mHihq4dUdUoJ0ZRJBQCHKndL3s75kOY52OJGlb25YcgPdUK+xmKa5CQzIIXfhgUnqgW+AgWCAoXPjZbWnZrZdkcSvRiwYpcRMRo5/yBQszp5MEVHi1tPAfYM8p33MmiqliQLVJCydLCWqVcxhEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228026; c=relaxed/simple;
	bh=TrmtWPw7GJViBixH8wj95EdL83oRb8RQByFnqkLL5WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu3x5hPtkeUyTHQG5II1oPivYzP99IQhQvrfM+uOXBsiy/MxorAqaztnuVeRTRhsqKhugxiwgYHB48kA6F8N8ZoI8qyxVeJgVEPdPF40T1iMxuXjYCK0Hp6ALC3hFqlTCXdQq7S4gR9mFUyUZydqoNHtZIySK6Bez/c1YR5/yGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4Ib++9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B970C16AAE;
	Mon, 12 Jan 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228025;
	bh=TrmtWPw7GJViBixH8wj95EdL83oRb8RQByFnqkLL5WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4Ib++9rRmr2InD94PFL+HWqMzURN/djSOek/VXf3Kx4t0yE+2izWNg1ZD5X8xrWf
	 z9jsHetv2RSKp5YU/KvsdUNKJe4NoMnrYVtjXL9ceaBhujyNs2iTPIIDeUoeWtH8Y1
	 4sl0MR8H0MACxKXqUly3mjxNfVR7S+G+bLPrr1KRw+zpOAZAWNBkzIYlu985ZbsajT
	 2xgJVCXP5VBuzulj0rVfr8h8H9WE/v0EYqbEdj4TC9MwrP82/H+M6WMPka0Uy699ZT
	 UkERRH9QewpNVd+FVe03xZoBheFt0bBOMP8IJU3KLBaShzCpagHsFyAjwvlwdyXlsP
	 wKT393LxuZNBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] NFSD: Remove NFSERR_EAGAIN
Date: Mon, 12 Jan 2026 09:27:01 -0500
Message-ID: <20260112142701.711948-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112142701.711948-1-sashal@kernel.org>
References: <2026011222-giggle-goofiness-bbd1@gregkh>
 <20260112142701.711948-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit c6c209ceb87f64a6ceebe61761951dcbbf4a0baa ]

I haven't found an NFSERR_EAGAIN in RFCs 1094, 1813, 7530, or 8881.
None of these RFCs have an NFS status code that match the numeric
value "11".

Based on the meaning of the EAGAIN errno, I presume the use of this
status in NFSD means NFS4ERR_DELAY. So replace the one usage of
nfserr_eagain, and remove it from NFSD's NFS status conversion
tables.

As far as I can tell, NFSERR_EAGAIN has existed since the pre-git
era, but was not actually used by any code until commit f4e44b393389
("NFSD: delay unmount source's export after inter-server copy
completed."), at which time it become possible for NFSD to return
a status code of 11 (which is not valid NFS protocol).

Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-server copy completed.")
Cc: stable@vger.kernel.org
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs_common/common.c   | 1 -
 fs/nfsd/nfs4proc.c       | 2 +-
 fs/nfsd/nfsd.h           | 1 -
 include/trace/misc/nfs.h | 2 --
 include/uapi/linux/nfs.h | 1 -
 5 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
index a4ee95da2174e..5cb0781e918f7 100644
--- a/fs/nfs_common/common.c
+++ b/fs/nfs_common/common.c
@@ -16,7 +16,6 @@ static const struct {
 	{ NFSERR_NOENT,		-ENOENT		},
 	{ NFSERR_IO,		-errno_NFSERR_IO},
 	{ NFSERR_NXIO,		-ENXIO		},
-/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
 	{ NFSERR_ACCES,		-EACCES		},
 	{ NFSERR_EXIST,		-EEXIST		},
 	{ NFSERR_XDEV,		-EXDEV		},
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 886c092675442..3436b07dbefd3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1355,7 +1355,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 					(schedule_timeout(20*HZ) == 0)) {
 				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
-				return nfserr_eagain;
+				return nfserr_jukebox;
 			}
 			finish_wait(&nn->nfsd_ssc_waitq, &wait);
 			goto try_again;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index d05bd2b811f37..bb24ecbf2109f 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -201,7 +201,6 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_noent		cpu_to_be32(NFSERR_NOENT)
 #define	nfserr_io		cpu_to_be32(NFSERR_IO)
 #define	nfserr_nxio		cpu_to_be32(NFSERR_NXIO)
-#define	nfserr_eagain		cpu_to_be32(NFSERR_EAGAIN)
 #define	nfserr_acces		cpu_to_be32(NFSERR_ACCES)
 #define	nfserr_exist		cpu_to_be32(NFSERR_EXIST)
 #define	nfserr_xdev		cpu_to_be32(NFSERR_XDEV)
diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index 5b6c36fe9cdfe..7d336ba1c34f7 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -16,7 +16,6 @@ TRACE_DEFINE_ENUM(NFSERR_PERM);
 TRACE_DEFINE_ENUM(NFSERR_NOENT);
 TRACE_DEFINE_ENUM(NFSERR_IO);
 TRACE_DEFINE_ENUM(NFSERR_NXIO);
-TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
 TRACE_DEFINE_ENUM(NFSERR_ACCES);
 TRACE_DEFINE_ENUM(NFSERR_EXIST);
 TRACE_DEFINE_ENUM(NFSERR_XDEV);
@@ -53,7 +52,6 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
 		{ NFSERR_NXIO,			"NXIO" }, \
 		{ ECHILD,			"CHILD" }, \
 		{ ETIMEDOUT,			"TIMEDOUT" }, \
-		{ NFSERR_EAGAIN,		"AGAIN" }, \
 		{ NFSERR_ACCES,			"ACCES" }, \
 		{ NFSERR_EXIST,			"EXIST" }, \
 		{ NFSERR_XDEV,			"XDEV" }, \
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index 946cb62d64b0b..5dc726070b511 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -49,7 +49,6 @@
 	NFSERR_NOENT = 2,		/* v2 v3 v4 */
 	NFSERR_IO = 5,			/* v2 v3 v4 */
 	NFSERR_NXIO = 6,		/* v2 v3 v4 */
-	NFSERR_EAGAIN = 11,		/* v2 v3 */
 	NFSERR_ACCES = 13,		/* v2 v3 v4 */
 	NFSERR_EXIST = 17,		/* v2 v3 v4 */
 	NFSERR_XDEV = 18,		/*    v3 v4 */
-- 
2.51.0


