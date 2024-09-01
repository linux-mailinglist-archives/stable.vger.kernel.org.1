Return-Path: <stable+bounces-71740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB4D96778A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91B61F2171D
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829BD17E01C;
	Sun,  1 Sep 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="llsSw8D7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29144C97;
	Sun,  1 Sep 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207658; cv=none; b=PXTx1/BbIIpRbIbheCtpT2MZdh5Esv6DWvxYddpaeroRPAHT0OnJ8B7GB016rGWZYWLceOvpKjeIj70PXMQi4JJ4MXmX7HQD85ncvs3d8CgK/NhaRW1OODvjBKUUXX+bixBwofp76kCHHwkRrBIDkNhZs8J6z17fSBjQojvSoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207658; c=relaxed/simple;
	bh=kU+0+RapXi5Oul8uhZGsV3634GPRs5Ka6/nfU03YsoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI9nB6ml/WvyeUllG7ZwQROUHI6IsDKvqKDl7YcAIKfBbPYGbP0whDZf4tC8DY5mZDcADt2CyNlm7Sgm3afhRLi9gUYRg1/B5vG/DPvXeGYU1WtlsTcMKx+heUj7BCts1opbWt3W/1LbU/3xWKRVlIL+4LAaSnPgRESAFv0MjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=llsSw8D7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DECBC4CEC3;
	Sun,  1 Sep 2024 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207658;
	bh=kU+0+RapXi5Oul8uhZGsV3634GPRs5Ka6/nfU03YsoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llsSw8D7HQ/RTpuPq2hPVAFswB+6qDT4Va1xTEYTCXze3iNEsJAq+2yu6NXjv1trR
	 XwnVRdEiiZhlLupknUcT1Gqsx6xAGLP3qeSpTACUJ//3ZHn0oYyWZmhMAljoDoKyAa
	 bQAZNS9TPxDOfRZkbFBhkxuZe95T7wAvUn7RgTgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 39/98] btrfs: delete pointless BUG_ON check on quota root in btrfs_qgroup_account_extent()
Date: Sun,  1 Sep 2024 18:16:09 +0200
Message-ID: <20240901160805.174327721@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
References: <20240901160803.673617007@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index ef95525fa6cdf..770e6f652a1e5 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2095,8 +2095,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	if (nr_old_roots == 0 && nr_new_roots == 0)
 		goto out_free;
 
-	BUG_ON(!fs_info->quota_root);
-
 	trace_btrfs_qgroup_account_extent(fs_info, trans->transid, bytenr,
 					num_bytes, nr_old_roots, nr_new_roots);
 
-- 
2.43.0




