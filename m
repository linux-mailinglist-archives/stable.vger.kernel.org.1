Return-Path: <stable+bounces-104246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2892A9F22A8
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F97A1007
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922AF13CA95;
	Sun, 15 Dec 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKqmE/bQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9111C83
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734252462; cv=none; b=DSDcb3TKMI/X+tao/QXXlGpOJs+tm0HOqOEGjMb8as498EheBt5N48D03DQtUxHZzdeibKrYSFPK15qaJGo1d7EAtelffEcCBvNdwHlCbNH7pEdmvSwFELORXkLrSFuJpDXhQzhhxM3FMsI+U9sVwgNWKn9oGLmCbL3zJ4+o5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734252462; c=relaxed/simple;
	bh=Y8V9Lq7JNQyywOnT6nhbaLuy6WzgWXCSJg+nPvf/HYA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NzQ3k4jBFz/OD5K73pg5sZuB41chuyiYaWT7PbLVpGqs9bkx5GXKijdLWMqxHDtBvklWV3trEiGckFHlfFJbOa0Mh9MlXNL9K7rTaVEvWhRVkT6YM4LZ8spfxwrE6MqIhmofwS/Q92Ijv1NyzDLnfD2sOX3a8uyelpw5lIJ4Dpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZKqmE/bQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A66DC4CECE;
	Sun, 15 Dec 2024 08:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734252461;
	bh=Y8V9Lq7JNQyywOnT6nhbaLuy6WzgWXCSJg+nPvf/HYA=;
	h=Subject:To:Cc:From:Date:From;
	b=ZKqmE/bQE5VPbM1qA00UGxxT/u/tIJI4s90zaqg4vNMPL9lSAn6yUoXQh65Wa2zLk
	 Z3KeuBhd3b9M3wUPa51+ON/K2fS9UyCnMebmGKjTrEOFAZU/iIhNA+abysHeiKCZzM
	 4qjwMN2RwmLtqbF8KIY/pHK3lHNg2EgoPnhh0/xA=
Subject: FAILED: patch "[PATCH] xfs: return from xfs_symlink_verify early on V4 filesystems" failed to apply to 5.4-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:47:30 +0100
Message-ID: <2024121530-postwar-percent-fbe9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7f8b718c58783f3ff0810b39e2f62f50ba2549f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121530-postwar-percent-fbe9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f8b718c58783f3ff0810b39e2f62f50ba2549f6 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 2 Dec 2024 10:57:43 -0800
Subject: [PATCH] xfs: return from xfs_symlink_verify early on V4 filesystems

V4 symlink blocks didn't have headers, so return early if this is a V4
filesystem.

Cc: <stable@vger.kernel.org> # v5.1
Fixes: 39708c20ab5133 ("xfs: miscellaneous verifier magic value fixups")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/libxfs/xfs_symlink_remote.c b/fs/xfs/libxfs/xfs_symlink_remote.c
index f228127a88ff..fb47a76ead18 100644
--- a/fs/xfs/libxfs/xfs_symlink_remote.c
+++ b/fs/xfs/libxfs/xfs_symlink_remote.c
@@ -92,8 +92,10 @@ xfs_symlink_verify(
 	struct xfs_mount	*mp = bp->b_mount;
 	struct xfs_dsymlink_hdr	*dsl = bp->b_addr;
 
+	/* no verification of non-crc buffers */
 	if (!xfs_has_crc(mp))
-		return __this_address;
+		return NULL;
+
 	if (!xfs_verify_magic(bp, dsl->sl_magic))
 		return __this_address;
 	if (!uuid_equal(&dsl->sl_uuid, &mp->m_sb.sb_meta_uuid))


