Return-Path: <stable+bounces-189893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E3C0B67D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 00:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C88D3B7CC9
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC65913B797;
	Sun, 26 Oct 2025 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWxhXsx7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC71EEAB
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519708; cv=none; b=mLYgzP0brOLdCArvVoCzvZFexxm/B+WW2tG4R2NoZ0ps90hX4TDnoBz9AZtCmzp7fXcK79uXjK440pb+kMW/ENC43coICJkCqnTjDuy0Z7pnSngkGNvmSHta10k4byZWdzGFmck/Tsxgrzgi6G/azG1GH/poPjUSReWhKUe8oKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519708; c=relaxed/simple;
	bh=qzfI+kjBvm5Jv04/ZAGxxWGNPWMbD/KYh4wJC/fpKFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoojcsLAHNjWm6IsHw2i07ROipS1MEka+Sq+X33VQOjFcQAtcmcVJKnufURWKTh3b8oznujaBl3K8Kv0aIR2xqGgdutODta4+VAS6GZQBODcDtYRDw8+X442yN1/4vUvGVjWAO+HF0I34zn1irmSUYkoTe+G1PkT7Jm1L3oS1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWxhXsx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE99C4CEE7;
	Sun, 26 Oct 2025 23:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761519706;
	bh=qzfI+kjBvm5Jv04/ZAGxxWGNPWMbD/KYh4wJC/fpKFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWxhXsx7TcA86GLAfhv6zvo5/a+Fo9Y7O3pTtsvUXvoepZx+2YfqHNL2i44pLP56M
	 fQB+zdXUyKHiKxd0uA1D2yWdNaqh6L1BKy7QJBvzpQwiYmSZWvEQGCPtp+l9ffhvO7
	 QQaFHT389AjGKs1onR1R5t0kg4bVaRvJYZvwKG2nexlBr2roANYJvaXldcPfh44KgH
	 BjshV+Qc9idcOMNkY5yztUyfclE7SENqL79wp7YfS2gFabpsYdQgfIHfJktYMOzoM1
	 CVSK2u0wMeFj3MphAuMh413ncY0aypArUU6UqpRiaD6cH3eCtKNIO62JFy+YxBGJ4D
	 FUIRR1fTj/p0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: always warn about deprecated mount options
Date: Sun, 26 Oct 2025 19:01:43 -0400
Message-ID: <20251026230143.275411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102645-gesture-rebuttal-ebca@gregkh>
References: <2025102645-gesture-rebuttal-ebca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 630785bfbe12c3ee3ebccd8b530a98d632b7e39d ]

The deprecation of the 'attr2' mount option in 6.18 wasn't entirely
successful because nobody noticed that the kernel never printed a
warning about attr2 being set in fstab if the only xfs filesystem is the
root fs; the initramfs mounts the root fs with no mount options; and the
init scripts only conveyed the fstab options by remounting the root fs.

Fix this by making it complain all the time.

Cc: stable@vger.kernel.org # v5.13
Fixes: 92cf7d36384b99 ("xfs: Skip repetitive warnings about mount options")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ Update existing xfs_fs_warn_deprecated() callers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_super.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2ef331132fca7..8752eb58d0363 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1201,16 +1201,25 @@ suffix_kstrtoint(
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
-	struct fs_parameter	*param,
-	uint64_t		flag,
-	bool			value)
+	struct fs_parameter	*param)
 {
-	/* Don't print the warning if reconfiguring and current mount point
-	 * already had the flag set
+	/*
+	 * Always warn about someone passing in a deprecated mount option.
+	 * Previously we wouldn't print the warning if we were reconfiguring
+	 * and current mount point already had the flag set, but that was not
+	 * the right thing to do.
+	 *
+	 * Many distributions mount the root filesystem with no options in the
+	 * initramfs and rely on mount -a to remount the root fs with the
+	 * options in fstab.  However, the old behavior meant that there would
+	 * never be a warning about deprecated mount options for the root fs in
+	 * /etc/fstab.  On a single-fs system, that means no warning at all.
+	 *
+	 * Compounding this problem are distribution scripts that copy
+	 * /proc/mounts to fstab, which means that we can't remove mount
+	 * options unless we're 100% sure they have only ever been advertised
+	 * in /proc/mounts in response to explicitly provided mount options.
 	 */
-	if ((fc->purpose & FS_CONTEXT_FOR_RECONFIGURE) &&
-            !!(XFS_M(fc->root->d_sb)->m_features & flag) == value)
-		return;
 	xfs_warn(fc->s_fs_info, "%s mount option is deprecated.", param->key);
 }
 
@@ -1349,19 +1358,19 @@ xfs_fs_parse_param(
 #endif
 	/* Following mount options will be removed in September 2025 */
 	case Opt_ikeep:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_IKEEP;
 		return 0;
 	case Opt_noikeep:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, false);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features &= ~XFS_FEAT_IKEEP;
 		return 0;
 	case Opt_attr2:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_ATTR2, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_ATTR2;
 		return 0;
 	case Opt_noattr2:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_NOATTR2, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_NOATTR2;
 		return 0;
 	default:
-- 
2.51.0


