Return-Path: <stable+bounces-919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD167F7D26
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBD21C211B3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858839FF7;
	Fri, 24 Nov 2023 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h5bAMKsu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E2E381D6;
	Fri, 24 Nov 2023 18:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DD9C433C9;
	Fri, 24 Nov 2023 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850107;
	bh=KuBSiNbIox6jFS1QfiWuGjs5JXTS2x1rMZCoDAVrHBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5bAMKsuy7n1Cl+oaBkqmtf+L27F03hkjct354H8LKOZuXLDRms9j1PBoiqLZWNDy
	 YVVY0j1xYwgFb7x+ce7Hj+RscWPts8uov8I6yuaOEHEQYuryWUNBu4DTUSVxZ4dtG4
	 xmKCBDmBUCqT3MZF/lQVGM9A+OoO0gj2MWHXms2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	stable@kernel.org
Subject: [PATCH 6.6 430/530] xfs: recovery should not clear di_flushiter unconditionally
Date: Fri, 24 Nov 2023 17:49:56 +0000
Message-ID: <20231124172041.168091053@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Chinner <dchinner@redhat.com>

commit 7930d9e103700cde15833638855b750715c12091 upstream.

Because on v3 inodes, di_flushiter doesn't exist. It overlaps with
zero padding in the inode, except when NREXT64=1 configurations are
in use and the zero padding is no longer padding but holds the 64
bit extent counter.

This manifests obviously on big endian platforms (e.g. s390) because
the log dinode is in host order and the overlap is the LSBs of the
extent count field. It is not noticed on little endian machines
because the overlap is at the MSB end of the extent count field and
we need to get more than 2^^48 extents in the inode before it
manifests. i.e. the heat death of the universe will occur before we
see the problem in little endian machines.

This is a zero-day issue for NREXT64=1 configuraitons on big endian
machines. Fix it by only clearing di_flushiter on v2 inodes during
recovery.

Fixes: 9b7d16e34bbe ("xfs: Introduce XFS_DIFLAG2_NREXT64 and associated helpers")
cc: stable@kernel.org # 5.19+
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_inode_item_recover.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

--- a/fs/xfs/xfs_inode_item_recover.c
+++ b/fs/xfs/xfs_inode_item_recover.c
@@ -369,24 +369,26 @@ xlog_recover_inode_commit_pass2(
 	 * superblock flag to determine whether we need to look at di_flushiter
 	 * to skip replay when the on disk inode is newer than the log one
 	 */
-	if (!xfs_has_v3inodes(mp) &&
-	    ldip->di_flushiter < be16_to_cpu(dip->di_flushiter)) {
-		/*
-		 * Deal with the wrap case, DI_MAX_FLUSH is less
-		 * than smaller numbers
-		 */
-		if (be16_to_cpu(dip->di_flushiter) == DI_MAX_FLUSH &&
-		    ldip->di_flushiter < (DI_MAX_FLUSH >> 1)) {
-			/* do nothing */
-		} else {
-			trace_xfs_log_recover_inode_skip(log, in_f);
-			error = 0;
-			goto out_release;
+	if (!xfs_has_v3inodes(mp)) {
+		if (ldip->di_flushiter < be16_to_cpu(dip->di_flushiter)) {
+			/*
+			 * Deal with the wrap case, DI_MAX_FLUSH is less
+			 * than smaller numbers
+			 */
+			if (be16_to_cpu(dip->di_flushiter) == DI_MAX_FLUSH &&
+			    ldip->di_flushiter < (DI_MAX_FLUSH >> 1)) {
+				/* do nothing */
+			} else {
+				trace_xfs_log_recover_inode_skip(log, in_f);
+				error = 0;
+				goto out_release;
+			}
 		}
+
+		/* Take the opportunity to reset the flush iteration count */
+		ldip->di_flushiter = 0;
 	}
 
-	/* Take the opportunity to reset the flush iteration count */
-	ldip->di_flushiter = 0;
 
 	if (unlikely(S_ISREG(ldip->di_mode))) {
 		if ((ldip->di_format != XFS_DINODE_FMT_EXTENTS) &&



