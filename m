Return-Path: <stable+bounces-118759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0406BA41B0E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0267917444D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFC5253F03;
	Mon, 24 Feb 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cc8CdZnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70E253359
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392939; cv=none; b=BpyTBnIOETYUmITGQF8cSCRGArUZPj5QSkaxb9W1ru2NI5r7AiiETY6r9HAQS0JIfw5MkQxLUaadxkz8BWYuoWjwOpAZw8RfNvthoMhDPiZujeZ9/ZgAN/ZxvNQnC410IhG+HS6Uz45Wb7Efp8TUlHhwtPfi/3bd4/mgsClepBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392939; c=relaxed/simple;
	bh=k5ibL3yHS1ra7zWcauzqaVxMJ/WoYI+byBYlkPU2UaY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cyg2wPwl429vKEYs28PYRywy4USCN18HQpSOoAnDPfbr6XPj1+ATsQoIgeinyl6p60uIRLGORrelPwBCdkxs3ms8QPSjtvGV2+lnErMrpcuZEAzFrgYNLwLASHQXtp39sb0S+AwmRyA8OfBkmb5sppinXdPLzbAW6bEag26zQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cc8CdZnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31998C2BCB2;
	Mon, 24 Feb 2025 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392939;
	bh=k5ibL3yHS1ra7zWcauzqaVxMJ/WoYI+byBYlkPU2UaY=;
	h=Subject:To:Cc:From:Date:From;
	b=cc8CdZnvznaQapcBfaxI4Z3OqDH+tXNKP8GvxlBKpJv9QN1eVR8pOIumu4FKaTy2y
	 xhU0s6AyZeuCxANwGr2DEMuy6PdHVH+2pZ0goyIxxDBGQsq2tSX6CsBZAyM1ITFzEO
	 mbpsAyd0tw9s6h9h/QNFnEHnlMGI5nOwM/kjZmWs=
Subject: FAILED: patch "[PATCH] xfs: fix online repair probing when" failed to apply to 6.6-stable tree
To: djwong@kernel.org,cem@kernel.org,david.flynn@oracle.com,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:28:46 +0100
Message-ID: <2025022446-gratify-muster-5e00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 66314e9a57a050f95cb0ebac904f5ab047a8926e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022446-gratify-muster-5e00@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66314e9a57a050f95cb0ebac904f5ab047a8926e Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Sun, 2 Feb 2025 16:50:14 -0800
Subject: [PATCH] xfs: fix online repair probing when
 CONFIG_XFS_ONLINE_REPAIR=n

I received a report from the release engineering side of the house that
xfs_scrub without the -n flag (aka fix it mode) would try to fix a
broken filesystem even on a kernel that doesn't have online repair built
into it:

 # xfs_scrub -dTvn /mnt/test
 EXPERIMENTAL xfs_scrub program in use! Use at your own risk!
 Phase 1: Find filesystem geometry.
 /mnt/test: using 1 threads to scrub.
 Phase 1: Memory used: 132k/0k (108k/25k), time:  0.00/ 0.00/ 0.00s
 <snip>
 Phase 4: Repair filesystem.
 <snip>
 Info: /mnt/test/some/victimdir directory entries: Attempting repair. (repair.c line 351)
 Corruption: /mnt/test/some/victimdir directory entries: Repair unsuccessful; offline repair required. (repair.c line 204)

Source: https://blogs.oracle.com/linux/post/xfs-online-filesystem-repair

It is strange that xfs_scrub doesn't refuse to run, because the kernel
is supposed to return EOPNOTSUPP if we actually needed to run a repair,
and xfs_io's repair subcommand will perror that.  And yet:

 # xfs_io -x -c 'repair probe' /mnt/test
 #

The first problem is commit dcb660f9222fd9 (4.15) which should have had
xchk_probe set the CORRUPT OFLAG so that any of the repair machinery
will get called at all.

It turns out that some refactoring that happened in the 6.6-6.8 era
broke the operation of this corner case.  What we *really* want to
happen is that all the predicates that would steer xfs_scrub_metadata()
towards calling xrep_attempt() should function the same way that they do
when repair is compiled in; and then xrep_attempt gets to return the
fatal EOPNOTSUPP error code that causes the probe to fail.

Instead, commit 8336a64eb75cba (6.6) started the failwhale swimming by
hoisting OFLAG checking logic into a helper whose non-repair stub always
returns false, causing scrub to return "repair not needed" when in fact
the repair is not supported.  Prior to that commit, the oflag checking
that was open-coded in scrub.c worked correctly.

Similarly, in commit 4bdfd7d15747b1 (6.8) we hoisted the IFLAG_REPAIR
and ALREADY_FIXED logic into a helper whose non-repair stub always
returns false, so we never enter the if test body that would have called
xrep_attempt, let alone fail to decode the OFLAGs correctly.

The final insult (yes, we're doing The Naked Gun now) is commit
48a72f60861f79 (6.8) in which we hoisted the "are we going to try a
repair?" predicate into yet another function with a non-repair stub
always returns false.

Fix xchk_probe to trigger xrep_probe if repair is enabled, or return
EOPNOTSUPP directly if it is not.  For all the other scrub types, we
need to fix the header predicates so that the ->repair functions (which
are all xrep_notsupported) get called to return EOPNOTSUPP.  Commit
48a72 is tagged here because the scrub code prior to LTS 6.12 are
incomplete and not worth patching.

Reported-by: David Flynn <david.flynn@oracle.com>
Cc: <stable@vger.kernel.org> # v6.8
Fixes: 8336a64eb75c ("xfs: don't complain about unfixed metadata when repairs were injected")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index bdcd40f0ec74..19877d99f255 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -224,7 +224,6 @@ static inline bool xchk_skip_xref(struct xfs_scrub_metadata *sm)
 bool xchk_dir_looks_zapped(struct xfs_inode *dp);
 bool xchk_pptr_looks_zapped(struct xfs_inode *ip);
 
-#ifdef CONFIG_XFS_ONLINE_REPAIR
 /* Decide if a repair is required. */
 static inline bool xchk_needs_repair(const struct xfs_scrub_metadata *sm)
 {
@@ -244,10 +243,6 @@ static inline bool xchk_could_repair(const struct xfs_scrub *sc)
 	return (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR) &&
 		!(sc->flags & XREP_ALREADY_FIXED);
 }
-#else
-# define xchk_needs_repair(sc)		(false)
-# define xchk_could_repair(sc)		(false)
-#endif /* CONFIG_XFS_ONLINE_REPAIR */
 
 int xchk_metadata_inode_forks(struct xfs_scrub *sc);
 
diff --git a/fs/xfs/scrub/repair.h b/fs/xfs/scrub/repair.h
index 823c00d1a502..af0a3a9e5ed9 100644
--- a/fs/xfs/scrub/repair.h
+++ b/fs/xfs/scrub/repair.h
@@ -191,7 +191,16 @@ int xrep_reset_metafile_resv(struct xfs_scrub *sc);
 #else
 
 #define xrep_ino_dqattach(sc)	(0)
-#define xrep_will_attempt(sc)	(false)
+
+/*
+ * When online repair is not built into the kernel, we still want to attempt
+ * the repair so that the stub xrep_attempt below will return EOPNOTSUPP.
+ */
+static inline bool xrep_will_attempt(const struct xfs_scrub *sc)
+{
+	return (sc->sm->sm_flags & XFS_SCRUB_IFLAG_FORCE_REBUILD) ||
+		xchk_needs_repair(sc->sm);
+}
 
 static inline int
 xrep_attempt(
diff --git a/fs/xfs/scrub/scrub.c b/fs/xfs/scrub/scrub.c
index 7567dd5cad14..6fa9e3e5bab7 100644
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@ -149,6 +149,18 @@ xchk_probe(
 	if (xchk_should_terminate(sc, &error))
 		return error;
 
+	/*
+	 * If the caller is probing to see if repair works but repair isn't
+	 * built into the kernel, return EOPNOTSUPP because that's the signal
+	 * that userspace expects.  If online repair is built in, set the
+	 * CORRUPT flag (without any of the usual tracing/logging) to force us
+	 * into xrep_probe.
+	 */
+	if (xchk_could_repair(sc)) {
+		if (!IS_ENABLED(CONFIG_XFS_ONLINE_REPAIR))
+			return -EOPNOTSUPP;
+		sc->sm->sm_flags |= XFS_SCRUB_OFLAG_CORRUPT;
+	}
 	return 0;
 }
 


