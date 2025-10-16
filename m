Return-Path: <stable+bounces-186105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A31BE3955
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1944C500712
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590FB19E7F9;
	Thu, 16 Oct 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y7xPa/Fn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A881CD1F
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619736; cv=none; b=DH7RYr56WgpuquP3SrMonVKDGrysFLMpkQdGfnVFOerxzVM54iElffjQ4m5B6eQCV3sRqI96172LJDiAYZarQVe6QwyMTWGkY00lc+t9epbSAdIypHSFJOtWjlYIzcaQfZ4JhYH8FKk0Gj5RGHgtEEq2jFciSc7g7+L+rTXQs90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619736; c=relaxed/simple;
	bh=QwMlYfCbZsCiYOQYQFXllh3uG83C+8Wd30QSOrSLjQs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mF2ZCp0l79Y+0nvm4Wu72i4f5ao1oRw00qahbJWZ1JB8OJD5KzG3lll1/PlayWh5UZpYhIVDuCyxO5NDzc+iHO1Q2gzT/UZxFZioyhuiP2hVcjUCaHGe/11k9zoJTmxg72tXdUr1CznFj1iwNzBw4CCneWOy4ksqvvnMcNAw0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y7xPa/Fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBA3C4CEF1;
	Thu, 16 Oct 2025 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619734;
	bh=QwMlYfCbZsCiYOQYQFXllh3uG83C+8Wd30QSOrSLjQs=;
	h=Subject:To:Cc:From:Date:From;
	b=Y7xPa/Fn0WAL1rbptAs09BwLxpaTdRF2FwKlMnUSmG8usz37inuzpD+Q4LzdJ4S0Z
	 ViqQlvcbT/BRoYxuACc44JyDGn6kKbmMbU4lHIudfqekrq0+buGc9SmjCaZo35msrU
	 fLXnF8oKXxROzj6XHlD1MlNe+OhJWQ7P6qvC7aHg=
Subject: FAILED: patch "[PATCH] xfs: use deferred intent items for reaping crosslinked blocks" failed to apply to 6.6-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:02:03 +0200
Message-ID: <2025101603-baggage-humming-330b@gregkh>
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
git cherry-pick -x cd32a0c0dcdf634f2e0e71f41c272e19dece6264
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101603-baggage-humming-330b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd32a0c0dcdf634f2e0e71f41c272e19dece6264 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 8 Apr 2025 16:14:32 -0700
Subject: [PATCH] xfs: use deferred intent items for reaping crosslinked blocks

When we're removing rmap records for crosslinked blocks, use deferred
intent items so that we can try to free/unmap as many of the old data
structure's blocks as we can in the same transaction as the commit.

Cc: <stable@vger.kernel.org> # v6.6
Fixes: 1c7ce115e52106 ("xfs: reap large AG metadata extents when possible")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 8703897c0a9c..86d3d104b8d9 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -416,8 +416,6 @@ xreap_agextent_iter(
 		trace_xreap_dispose_unmap_extent(pag_group(sc->sa.pag), agbno,
 				*aglenp);
 
-		rs->force_roll = true;
-
 		if (rs->oinfo == &XFS_RMAP_OINFO_COW) {
 			/*
 			 * If we're unmapping CoW staging extents, remove the
@@ -426,11 +424,14 @@ xreap_agextent_iter(
 			 */
 			xfs_refcount_free_cow_extent(sc->tp, false, fsbno,
 					*aglenp);
+			rs->force_roll = true;
 			return 0;
 		}
 
-		return xfs_rmap_free(sc->tp, sc->sa.agf_bp, sc->sa.pag, agbno,
-				*aglenp, rs->oinfo);
+		xfs_rmap_free_extent(sc->tp, false, fsbno, *aglenp,
+				rs->oinfo->oi_owner);
+		rs->deferred++;
+		return 0;
 	}
 
 	trace_xreap_dispose_free_extent(pag_group(sc->sa.pag), agbno, *aglenp);


