Return-Path: <stable+bounces-208076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6434BD11E7B
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43E7E303834B
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0B25A34F;
	Mon, 12 Jan 2026 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KKMV9lHr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBF30F815
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214020; cv=none; b=DU5SQV1zGwg7TKGRmW4t3zmU/HPk55GLBpd7FnTPk6qqVcDHVsz/GSRaHp+FnxmQx4f9sg8RwQ7qLw89n7Srr6O+Y2u6pDswe+8NXcNLOMqjxrvF2dB0jIZOjSZzMLw1TU3XDGzCeOEGtTeKte1igBR5lqqugyz4gkXCZT3Oxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214020; c=relaxed/simple;
	bh=yhYQ0p+ReZgknmLQzKSRzvIDFPdpEXIMxuacUIg8wRI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cYtY8QV9RoKz5oMDm/wG7MZSOvmUdEQNgNsa4ikZEGavO0POdu1pzdMG/U5rohF0jgHhhiwSpK1B/ALkhWeIVX5WtVVBMlPO67X3b0PcbY0zGybUifVWT3oyCroO+OKT/2ZM7RhxugHIMT5rUpe5T68O95LguBCcv2EBYSsPPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KKMV9lHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D22C19421;
	Mon, 12 Jan 2026 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214020;
	bh=yhYQ0p+ReZgknmLQzKSRzvIDFPdpEXIMxuacUIg8wRI=;
	h=Subject:To:Cc:From:Date:From;
	b=KKMV9lHrilMpZIpcu2ahPCr3CiyR/2LLmt2pLB+pVgZQU2r4Fv72VPaA8pn4lXzdp
	 QcE8S42aGLOTvSY4Ma9aqOdSf81l9Y0FGWTCqHi01quT8q4X37U/nlgzHwbcJ6KCH9
	 unkThm4Dq+bAmo3/i7880RjJ8GhKOo1noDzA5Q58=
Subject: FAILED: patch "[PATCH] NFSD: Remove NFSERR_EAGAIN" failed to apply to 5.10-stable tree
To: chuck.lever@oracle.com,jlayton@kernel.org,neil@brown.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:33:24 +0100
Message-ID: <2026011224-freezing-captive-52e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c6c209ceb87f64a6ceebe61761951dcbbf4a0baa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011224-freezing-captive-52e7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6c209ceb87f64a6ceebe61761951dcbbf4a0baa Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 9 Dec 2025 19:28:49 -0500
Subject: [PATCH] NFSD: Remove NFSERR_EAGAIN

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

diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
index af09aed09fd2..0778743ae2c2 100644
--- a/fs/nfs_common/common.c
+++ b/fs/nfs_common/common.c
@@ -17,7 +17,6 @@ static const struct {
 	{ NFSERR_NOENT,		-ENOENT		},
 	{ NFSERR_IO,		-EIO		},
 	{ NFSERR_NXIO,		-ENXIO		},
-/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
 	{ NFSERR_ACCES,		-EACCES		},
 	{ NFSERR_EXIST,		-EEXIST		},
 	{ NFSERR_XDEV,		-EXDEV		},
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7f7e6bb23a90..42a6b914c0fe 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1506,7 +1506,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 					(schedule_timeout(20*HZ) == 0)) {
 				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
-				return nfserr_eagain;
+				return nfserr_jukebox;
 			}
 			finish_wait(&nn->nfsd_ssc_waitq, &wait);
 			goto try_again;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 50be785f1d2c..b0283213a8f5 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -233,7 +233,6 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_noent		cpu_to_be32(NFSERR_NOENT)
 #define	nfserr_io		cpu_to_be32(NFSERR_IO)
 #define	nfserr_nxio		cpu_to_be32(NFSERR_NXIO)
-#define	nfserr_eagain		cpu_to_be32(NFSERR_EAGAIN)
 #define	nfserr_acces		cpu_to_be32(NFSERR_ACCES)
 #define	nfserr_exist		cpu_to_be32(NFSERR_EXIST)
 #define	nfserr_xdev		cpu_to_be32(NFSERR_XDEV)
diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index c82233e950ac..a394b4d38e18 100644
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
@@ -52,7 +51,6 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
 		{ NFSERR_NXIO,			"NXIO" }, \
 		{ ECHILD,			"CHILD" }, \
 		{ ETIMEDOUT,			"TIMEDOUT" }, \
-		{ NFSERR_EAGAIN,		"AGAIN" }, \
 		{ NFSERR_ACCES,			"ACCES" }, \
 		{ NFSERR_EXIST,			"EXIST" }, \
 		{ NFSERR_XDEV,			"XDEV" }, \
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index f356f2ba3814..71c7196d3281 100644
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


