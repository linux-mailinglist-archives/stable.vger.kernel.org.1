Return-Path: <stable+bounces-112166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FBAA27410
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFED3A97BD
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AEC215163;
	Tue,  4 Feb 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4IDzDa8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC272135D7
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677708; cv=none; b=WCJfbz9GR/krXTKSdhSVIzW4z/h3bvj+WmoIVPexDB44DHitLrytMSCV3o28bkqH9jP/0FWw6m80N4BhaBfaJ/nZVWgNJyBq8kXG1xbtwxwsVvb3pnZI4kMw5h/gvdiRq+C+QB5UzwZ7NzrN0SGQBZ7yF2EQqOPEKSXXNPcm5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677708; c=relaxed/simple;
	bh=DWWnpeoDCIT16FFkGCRkeBAIDHYqgiMElq+vXsq8ph0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jox3FgGJn76TEYAn3n+DkGa849IhRnhU+Ela4vW+dNOUaX4ZtTZkZV3rhzOwmEzOhFoZxTsya+B2Csis5frsVVlhAJP8nYqs6bqEscEBrDMDTXm4YBiOz2D+YHK1qhYtnaUyuLlx/RmCly7JoGlQhtFitGznEKNP7cAN/tNkXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h4IDzDa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FFCC4CEE2;
	Tue,  4 Feb 2025 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738677708;
	bh=DWWnpeoDCIT16FFkGCRkeBAIDHYqgiMElq+vXsq8ph0=;
	h=Subject:To:Cc:From:Date:From;
	b=h4IDzDa8iF10EqtiCN45bKxzQfi4lPhyZ0dwoOk1NPDLlId9uWhKnHFC6lxKSPP9E
	 KyKXy+v5MUDuf5qHqeFJ9GE3/J/oDwM8BoThftrg/sPj2S9h3FrJ3TKrHXKNsSOEPT
	 QmhBDXKGoInbTRd/3OFYDPwOyKxQCqHUw/M5pjmE=
Subject: FAILED: patch "[PATCH] xfs: don't shut down the filesystem for media failures beyond" failed to apply to 6.1-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 15:01:26 +0100
Message-ID: <2025020426-bobtail-police-e100@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f4ed93037966aea07ae6b10ab208976783d24e2e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020426-bobtail-police-e100@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4ed93037966aea07ae6b10ab208976783d24e2e Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 17 Dec 2024 13:43:06 -0800
Subject: [PATCH] xfs: don't shut down the filesystem for media failures beyond
 end of log

If the filesystem has an external log device on pmem and the pmem
reports a media error beyond the end of the log area, don't shut down
the filesystem because we don't use that space.

Cc: <stable@vger.kernel.org> # v6.0
Fixes: 6f643c57d57c56 ("xfs: implement ->notify_failure() for XFS")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index fa50e5308292..0b0b0f31aca2 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -153,6 +153,79 @@ xfs_dax_notify_failure_thaw(
 	thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 }
 
+static int
+xfs_dax_translate_range(
+	struct xfs_buftarg	*btp,
+	u64			offset,
+	u64			len,
+	xfs_daddr_t		*daddr,
+	uint64_t		*bblen)
+{
+	u64			dev_start = btp->bt_dax_part_off;
+	u64			dev_len = bdev_nr_bytes(btp->bt_bdev);
+	u64			dev_end = dev_start + dev_len - 1;
+
+	/* Notify failure on the whole device. */
+	if (offset == 0 && len == U64_MAX) {
+		offset = dev_start;
+		len = dev_len;
+	}
+
+	/* Ignore the range out of filesystem area */
+	if (offset + len - 1 < dev_start)
+		return -ENXIO;
+	if (offset > dev_end)
+		return -ENXIO;
+
+	/* Calculate the real range when it touches the boundary */
+	if (offset > dev_start)
+		offset -= dev_start;
+	else {
+		len -= dev_start - offset;
+		offset = 0;
+	}
+	if (offset + len - 1 > dev_end)
+		len = dev_end - offset + 1;
+
+	*daddr = BTOBB(offset);
+	*bblen = BTOBB(len);
+	return 0;
+}
+
+static int
+xfs_dax_notify_logdev_failure(
+	struct xfs_mount	*mp,
+	u64			offset,
+	u64			len,
+	int			mf_flags)
+{
+	xfs_daddr_t		daddr;
+	uint64_t		bblen;
+	int			error;
+
+	/*
+	 * Return ENXIO instead of shutting down the filesystem if the failed
+	 * region is beyond the end of the log.
+	 */
+	error = xfs_dax_translate_range(mp->m_logdev_targp,
+			offset, len, &daddr, &bblen);
+	if (error)
+		return error;
+
+	/*
+	 * In the pre-remove case the failure notification is attempting to
+	 * trigger a force unmount.  The expectation is that the device is
+	 * still present, but its removal is in progress and can not be
+	 * cancelled, proceed with accessing the log device.
+	 */
+	if (mf_flags & MF_MEM_PRE_REMOVE)
+		return 0;
+
+	xfs_err(mp, "ondisk log corrupt, shutting down fs!");
+	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
+	return -EFSCORRUPTED;
+}
+
 static int
 xfs_dax_notify_ddev_failure(
 	struct xfs_mount	*mp,
@@ -263,8 +336,9 @@ xfs_dax_notify_failure(
 	int			mf_flags)
 {
 	struct xfs_mount	*mp = dax_holder(dax_dev);
-	u64			ddev_start;
-	u64			ddev_end;
+	xfs_daddr_t		daddr;
+	uint64_t		bblen;
+	int			error;
 
 	if (!(mp->m_super->s_flags & SB_BORN)) {
 		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
@@ -279,17 +353,7 @@ xfs_dax_notify_failure(
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
 	    mp->m_logdev_targp != mp->m_ddev_targp) {
-		/*
-		 * In the pre-remove case the failure notification is attempting
-		 * to trigger a force unmount.  The expectation is that the
-		 * device is still present, but its removal is in progress and
-		 * can not be cancelled, proceed with accessing the log device.
-		 */
-		if (mf_flags & MF_MEM_PRE_REMOVE)
-			return 0;
-		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
-		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
-		return -EFSCORRUPTED;
+		return xfs_dax_notify_logdev_failure(mp, offset, len, mf_flags);
 	}
 
 	if (!xfs_has_rmapbt(mp)) {
@@ -297,33 +361,12 @@ xfs_dax_notify_failure(
 		return -EOPNOTSUPP;
 	}
 
-	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
-	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
+	error = xfs_dax_translate_range(mp->m_ddev_targp, offset, len, &daddr,
+			&bblen);
+	if (error)
+		return error;
 
-	/* Notify failure on the whole device. */
-	if (offset == 0 && len == U64_MAX) {
-		offset = ddev_start;
-		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
-	}
-
-	/* Ignore the range out of filesystem area */
-	if (offset + len - 1 < ddev_start)
-		return -ENXIO;
-	if (offset > ddev_end)
-		return -ENXIO;
-
-	/* Calculate the real range when it touches the boundary */
-	if (offset > ddev_start)
-		offset -= ddev_start;
-	else {
-		len -= ddev_start - offset;
-		offset = 0;
-	}
-	if (offset + len - 1 > ddev_end)
-		len = ddev_end - offset + 1;
-
-	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
-			mf_flags);
+	return xfs_dax_notify_ddev_failure(mp, daddr, bblen, mf_flags);
 }
 
 const struct dax_holder_operations xfs_dax_holder_operations = {


