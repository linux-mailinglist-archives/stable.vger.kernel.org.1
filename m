Return-Path: <stable+bounces-72495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A6967ADB
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 19:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C26281DF1
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2F326AE8;
	Sun,  1 Sep 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zSQl+YZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63017C;
	Sun,  1 Sep 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210110; cv=none; b=sbfJNZ7USkb/UWwJ8a9t+ZcFzjffLVDc/PLvFtziZ+OYNJ9lmYFgMEnMrqCL6/qKKCWi4e8zRoCxTAvRW78952F83uj4OuOAY2Vrhqz58jjEYvLzHKoIBYYkrcf+sD/BeoLC2jU6VvlCOyMgaWRV939Rc0jT1Rub0qUaKT2QqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210110; c=relaxed/simple;
	bh=UGD5+0TaMzp+DaT0AHc3FkUmaIeOIBo1DhZTn3PWW0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nM2hqaweB5FIoMVPq5PIRfn2zPQC5s82Cg3EvA9RR4M/oZU8RbBZEZ/Qvqo7k+wb2DjW5w7RBJD5fdCT4Vo1nK6JvnLDUYrnazAnHLly/x5Yetx/A926Dz8UpwlzTDtpGBwnxoy2p9++I6U1jTmImws8+LWu0i2HXBZXPRGaTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zSQl+YZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EC3C4CEC3;
	Sun,  1 Sep 2024 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725210110;
	bh=UGD5+0TaMzp+DaT0AHc3FkUmaIeOIBo1DhZTn3PWW0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zSQl+YZ9xvIOnenRehpApNDX0WBROrBeEcgbgLOqMAVdTqw/sUD4UvmTAzSv6Poee
	 AWVBHMtZsuxesmfExxkZsypdWn9V6Dm8GvIpKEeY1cWLp7YLdZrG3q+JqF0tLqDKkv
	 ayd6eLvRwVWdierx4f4SxFfOP71nFu8jykNYHMUI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 091/215] btrfs: delete pointless BUG_ON check on quota root in btrfs_qgroup_account_extent()
Date: Sun,  1 Sep 2024 18:16:43 +0200
Message-ID: <20240901160826.792081878@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
References: <20240901160823.230213148@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Sterba <dsterba@suse.com>

[ Upstream commit f40a3ea94881f668084f68f6b9931486b1606db0 ]

The BUG_ON is deep in the qgroup code where we can expect that it
exists. A NULL pointer would cause a crash.

It was added long ago in 550d7a2ed5db35 ("btrfs: qgroup: Add new qgroup
calculation function btrfs_qgroup_account_extents()."). It maybe made
sense back then as the quota enable/disable state machine was not that
robust as it is nowadays, so we can just delete it.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1f5ab51e18dc4..a4908fd31ccc3 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2648,8 +2648,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (nr_old_roots == 0 && nr_new_roots == 0)
 		goto out_free;
 
-	BUG_ON(!fs_info->quota_root);
-
 	trace_btrfs_qgroup_account_extent(fs_info, trans->transid, bytenr,
 					num_bytes, nr_old_roots, nr_new_roots);
 
-- 
2.43.0




