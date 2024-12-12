Return-Path: <stable+bounces-102492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851F99EF3EE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB9F18972C1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AED22A7E9;
	Thu, 12 Dec 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gu3hpL+t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E5223C5C;
	Thu, 12 Dec 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021426; cv=none; b=JngPxG5UWTlz2IIV0sMh0YDcYo5oVXfI7P1pNjN4fESSF2qSRhvwHYqd8AIVkbvXNEVqDNOcViCg7xXMRxIEKDyv80v/tkKRfxTbAGVK3mE0FR1U4MpoNu6GG3BXOFrHXZlzKpFpmQM28uHo0+0AabkThz9szqm9uuB06QvJU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021426; c=relaxed/simple;
	bh=ykksMg4IS3UAkRuEQu73JSRmKH2+azxsv8ACXLFV2JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5Cntv7Bl3Nmg/RHjF4T+YIYeKIMEfnefiT+86e9dxq6+UWE2RI8WBYjdp2pjdp/zK6uO/p4+sb7lmli9vL4tfXf2TX+jRgD7efaj99UuZ2FcYmtgNJdPj5LYoFY1wtwRlIOSeT+T0XpWJGjrOPj4wcF2BSNom9c1/g1b7fHfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gu3hpL+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025E1C4CECE;
	Thu, 12 Dec 2024 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021426;
	bh=ykksMg4IS3UAkRuEQu73JSRmKH2+azxsv8ACXLFV2JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gu3hpL+tMrXPi4zo5b132jPZxDQZ+T8DXfQFTUhED8S9Dsh9OHY6TPj+rLq5Jl9YI
	 tb7kFKDM/r545197CIvXdNKMO2XY0tlz8wSM8djzrBuwSQpqaaVDKZP2dYBPpG1QLh
	 efRI4fhWt1hNWtVSWeyooSw3/HiF6JCfvFfGe2Ws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 734/772] btrfs: fix missing snapshot drew unlock when root is dead during swap activation
Date: Thu, 12 Dec 2024 16:01:19 +0100
Message-ID: <20241212144420.248692804@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 9c803c474c6c002d8ade68ebe99026cc39c37f85 ]

When activating a swap file we acquire the root's snapshot drew lock and
then check if the root is dead, failing and returning with -EPERM if it's
dead but without unlocking the root's snapshot lock. Fix this by adding
the missing unlock.

Fixes: 60021bd754c6 ("btrfs: prevent subvol with swapfile from being deleted")
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8fc8a24a1afe8..eb5f03c3336cf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11228,6 +11228,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (btrfs_root_dead(root)) {
 		spin_unlock(&root->root_item_lock);
 
+		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_exclop_finish(fs_info);
 		btrfs_warn(fs_info,
 		"cannot activate swapfile because subvolume %llu is being deleted",
-- 
2.43.0




