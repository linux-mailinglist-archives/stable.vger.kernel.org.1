Return-Path: <stable+bounces-72109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A6D967938
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB00C1F21963
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746017F389;
	Sun,  1 Sep 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GYkAkppl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A46183092;
	Sun,  1 Sep 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208870; cv=none; b=bcJy/+k14gdOOhfmAqLAyPpKpt3djo8MRSZ7kE4tjh+wV4xIweVtoonGtHllvPtrpc9Ck04MRROYpXddC0rD0hbTkP/3SRrgxk04FOZIvsztNfIue6Ki4pbGKYfnuhPzt3X+zzRZeqyN+EMtoHOgzM0FKN59+mB7TBzqRuOHUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208870; c=relaxed/simple;
	bh=00pLTnilcHer5GnIvxI0NNw5lJ343tDWf8altqzhawM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpo4NPOqmkxAf7bJ8pVJvl/mSH2Wx82nK8BgOWvfGiwEJIn3/g3CfXXnqIDOFFyDi35Ky61CrlZY3tkjd7WjmPICuasMJzCm9SnDpwMGQ9Y8A+jYpw3sZ44EY9Zm/et+CXkKSRptmq65yspWhj49AF/BeqzcKQp1XDeMyp7noV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GYkAkppl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABEAC4CEC3;
	Sun,  1 Sep 2024 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208870;
	bh=00pLTnilcHer5GnIvxI0NNw5lJ343tDWf8altqzhawM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYkAkppl/Zd5m6tq/RQU9+zHszyyBTiXWXP3RzwtcdvydrAXnhGFU3e0AXz6NIG1a
	 T3srpLTlev1jnHmRQeZLG8RlXe5xZ01Ehqr352M7QeEkPpS1DcPiVY3tKEh2G+8FFQ
	 bIqykvzgaoeDfsZBiC4c6PdTkwwc7gQ/D/PUlhlk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/134] NFS: avoid infinite loop in pnfs_update_layout.
Date: Sun,  1 Sep 2024 18:16:51 +0200
Message-ID: <20240901160812.547085166@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
References: <20240901160809.752718937@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

[ Upstream commit 2fdbc20036acda9e5694db74a032d3c605323005 ]

If pnfsd_update_layout() is called on a file for which recovery has
failed it will enter a tight infinite loop.

NFS_LAYOUT_INVALID_STID will be set, nfs4_select_rw_stateid() will
return -EIO, and nfs4_schedule_stateid_recovery() will do nothing, so
nfs4_client_recover_expired_lease() will not wait.  So the code will
loop indefinitely.

Break the loop by testing the validity of the open stateid at the top of
the loop.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pnfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 3b19fa74b0620..3f7d905d7528d 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1953,6 +1953,14 @@ pnfs_update_layout(struct inode *ino,
 	}
 
 lookup_again:
+	if (!nfs4_valid_open_stateid(ctx->state)) {
+		trace_pnfs_update_layout(ino, pos, count,
+					 iomode, lo, lseg,
+					 PNFS_UPDATE_LAYOUT_INVALID_OPEN);
+		lseg = ERR_PTR(-EIO);
+		goto out;
+	}
+
 	lseg = ERR_PTR(nfs4_client_recover_expired_lease(clp));
 	if (IS_ERR(lseg))
 		goto out;
-- 
2.43.0




