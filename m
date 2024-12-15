Return-Path: <stable+bounces-104245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EF49F22A7
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B501165E8C
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3569C13CA95;
	Sun, 15 Dec 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYdYM3T2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657311C83
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734252453; cv=none; b=M198pxg0tzKNbSIRysOnx+ww1EHfNnMHR7VF/fO8wC7jrTet8R/QgQCHhFOgT2NbCq3fK2whBRPvaISag75UKoA99w+q4DEoC9WAqKFfdm0YTqC5qJfqxssfsKju0KPhbDKPtC6bZqHLVNXucGbD16TLs2jHdf2/LYoreRlVyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734252453; c=relaxed/simple;
	bh=IHBNWf1SIOboclkIjdSZdA1bM62kO+Th693d6G3wnn0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OaOJ5U9QAJDNgO/F6k3TCC4+e3LKqrtyquBDTvtAtMBLRnYLzZJJRN6l5sVwyvSL7v6blW9YNm2ruIkvX9K4kHS+krjM3WTpLvJtHKJ78d+OhYcQjTm7wHIOzh7a4sj06Ww7hOh0z9QXfDxwqyEqqyWdlgVElHnyy3VQva3Q1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYdYM3T2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5638CC4CECE;
	Sun, 15 Dec 2024 08:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734252452;
	bh=IHBNWf1SIOboclkIjdSZdA1bM62kO+Th693d6G3wnn0=;
	h=Subject:To:Cc:From:Date:From;
	b=eYdYM3T2WyG8X5Z70xIcHusi5CYc804hXrWqBxgQZxTDSQ0zpxwYn91mz+w/FVA4A
	 M5Jmg2W/Hw6/MZqJIaqwNGhf+8IqUrAA0sHKQJSBtVsUeN0sQ3WuEkDHEuTkuuN4/R
	 XXkeCIsDFyt6Tg/0ynHaDmc7JZWNHLZb75bpiMRk=
Subject: FAILED: patch "[PATCH] xfs: return from xfs_symlink_verify early on V4 filesystems" failed to apply to 5.10-stable tree
To: djwong@kernel.org,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 09:47:29 +0100
Message-ID: <2024121529-cornbread-brink-915a@gregkh>
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
git cherry-pick -x 7f8b718c58783f3ff0810b39e2f62f50ba2549f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121529-cornbread-brink-915a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


