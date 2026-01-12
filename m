Return-Path: <stable+bounces-208129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2559D1366F
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C15D13015A65
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721AF25A642;
	Mon, 12 Jan 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXloL/Gm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660B1E1E16
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228755; cv=none; b=EA3RDbdk0jJRTAot6Syvon4nBsMhJUTjFQmOHr8JhJLaza/bORulbGzFBlbhcrM+ESyibi5nk1VUeWzhAzjBteblFQvufevTgUG1yJj3TcDyIuQPmAP1D0D6S2eb2S9jKEJMThJCYNCQncKK4Ud4otu91nXsm+G8zXEqQXHA+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228755; c=relaxed/simple;
	bh=HzfZgLblIU4eXgtwxuT+pXhWPJOUgHyOIG4cx7BtfKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szdy4mG9hSty4m+xlhOuyfl0q7RYKYc3jOUqhuxOhoyYy5mPBJj+SMRa3RZcyBU1iocZ7BgymfCwEfe8X+Y81TvhFEjM86ZOuDP8kS6Q8fRkrZ24QPEXZS/997vVgpOgNOa3pEXNp8kEmoigyD3oG7wz+u0QMeeOvZBCMVOj/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXloL/Gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F672C19425;
	Mon, 12 Jan 2026 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228754;
	bh=HzfZgLblIU4eXgtwxuT+pXhWPJOUgHyOIG4cx7BtfKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXloL/GmyR3xb71NkuAkO6bxRp+lhPgPO19T8TX94JnNwZPVq2dTxT1+cOhgSWR6o
	 Z6bawZPqAS3j3wKMVptByhWXWwj8b7RMUizn0EtM9RZEbFDsoJm+qWQmEY5nBXiswF
	 2TTWPkFGXttVh5RAzIEgn8vt24F5SsEXw1xBsoF6D5tyEYvPs37GYdvEmkYG6Goyzy
	 uW3a1akQ7IgLuH/Yl+JONkeHW7GpidRjsCCO3hn1YRpORr2BhbTYnKWk0OeBQQyOk8
	 xxHG78jQLijEqZY5yUjb/ZVRyWW8uKE3GY5roOQeE5NBDkpFr+F5S24HVDw6ymh5ZB
	 RS6+fPYENal+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] NFSD: Remove NFSERR_EAGAIN
Date: Mon, 12 Jan 2026 09:39:10 -0500
Message-ID: <20260112143910.714632-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112143910.714632-1-sashal@kernel.org>
References: <2026011223-dash-veal-39c7@gregkh>
 <20260112143910.714632-1-sashal@kernel.org>
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
index f78a01102c673..714e4c471e863 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1321,7 +1321,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 					(schedule_timeout(20*HZ) == 0)) {
 				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
-				return nfserr_eagain;
+				return nfserr_jukebox;
 			}
 			finish_wait(&nn->nfsd_ssc_waitq, &wait);
 			goto try_again;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 996f3f62335b2..1116e5fcddc54 100644
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


