Return-Path: <stable+bounces-208134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FABD13530
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 15:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90072300EE67
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3F2BE62B;
	Mon, 12 Jan 2026 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8rg28lr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC92BDC34
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229383; cv=none; b=rUkxYQW3PRTya1ON0eb4gBH0lzuGH2bz8begTIBKsWLwz9I+qNW+bUfNdsN19XlWzstpa51wQJvromhYHo1WtsZy4kqXJbHGfRRnp0qw15plMffG1ikf9jJ7hmFi1FDQ53Q7RYS5gEVq9cIcdvh6bcm6bkCQHt6s0gXoZ6MbImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229383; c=relaxed/simple;
	bh=Wp1fezml3dk9v0OplIA7R4Bdg01Wpa6d0nsfFjqyTus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkaBrBheF9YtM3Bjb0+gS5KiY0oi5yaN9HDtAMhcOlCW88FQYkm/8g2cI/IJwg2iT1EVxZT49OLWnthP7KMalNyCrwqAEDeYcE+0DL86G6AcrIVqtqNAvYIohVMsDt03BpAJ0aOgvySUu8hGUmzq8Q69NO6DLz6BytLfjvPh0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8rg28lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8F9C16AAE;
	Mon, 12 Jan 2026 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229383;
	bh=Wp1fezml3dk9v0OplIA7R4Bdg01Wpa6d0nsfFjqyTus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8rg28lrCw64iI9Q9DD+6rl/rc4QyfC7wn7hg/+9yn3zStX/y9TQPpyVP/r2OZoMa
	 56PlgZkPIxXOkZeotAz0PlPnBtyBiRqwoZwUulgc+j2Dqq40m2FjeWvNgQ747+uj1P
	 7aMytB0wVcxJir8VU3r+EM0HU8yaTna9mAjBSXhONv0H9Se6Qg6BPSvSqeENIprICb
	 xtenLPZtNOJCrKw2r3bRLpZ8Mzzh3+XygI2Q4EhUbthGn5DtFIEi1zSu+DyL+aeEfK
	 vEZRLgTXxtYF0VqMgV2ib0SS65fz6oy437oQQ6wrVoFiCMDcUsTXBTFWbd7IQPpRhJ
	 G6Y+Ml6uvBr3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] NFSD: Remove NFSERR_EAGAIN
Date: Mon, 12 Jan 2026 09:49:39 -0500
Message-ID: <20260112144939.718289-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112144939.718289-1-sashal@kernel.org>
References: <2026011223-capitol-diploma-75b9@gregkh>
 <20260112144939.718289-1-sashal@kernel.org>
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
index 58099c9621373..2d6e88f3370bf 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1322,7 +1322,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 					(freezable_schedule_timeout(20*HZ) == 0)) {
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


