Return-Path: <stable+bounces-95312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48049D771F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 19:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9309FB2194A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949C1FF81B;
	Sun, 24 Nov 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkmQyNnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB11FF7F6;
	Sun, 24 Nov 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456665; cv=none; b=S1/iUG/uNeQGDgUC/1zTzJGZGqhASSz59qmIaTzyTrBnpbgvmAczA2oLcdbNQdUPNP9aWtjUP5U5c0NPm6yH7CCf31s8DbCBpJzjs4iXPBWRVcyJHWXg6JCtfQNMxA/jZBob+wqTPMBGCuIjZmi6pogEjzh9Fd9ksILMMzDz4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456665; c=relaxed/simple;
	bh=Q3NTUcQjhKJe8oHlyi1+hjuoKGBKJhWs1Qq1F51MBWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmx52fcCmoB6jl0p8DeGJlmpGV6jv6zcewNYrANT27hc/eB2yIw0kMoZ2FESjts/M648hQLnWbhwmNjKW5VjV1Vfz+LAZ4lfcVHfMN/EJag61VdMmJKsNCWlKd2v04Fe4RGfb/n+5CmER3wKC64Gyo/pxp0zl9TC1r6EnsoavI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkmQyNnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D6DC4CED1;
	Sun, 24 Nov 2024 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456664;
	bh=Q3NTUcQjhKJe8oHlyi1+hjuoKGBKJhWs1Qq1F51MBWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkmQyNnvUk8Jk3MsvfSanegZW9fv2j5rBMlppkN3CKCEPNw7R1D2QduxNXhdoTmVn
	 koMCQ+4wIefZvnaJzTaIb0JWoBGE/zH4dHdIoYsjs5dq28urVwGc8BJBJPI2kYg8o/
	 9qnMJIOnHf+7f2yA4hF4eTAKbJiP5GJJm0IbfLQOwp+oCR4kVAQXjtIAoVNViEGEU8
	 c9KtHVoixXafOEbcYhgsJr563R9xwPVc1Di2NLBq54Ap5JkWb8ntNqUY2jiJuIVIZ4
	 scTGzi4kTRfOmJOD/mJXMK0FIlGUYQMlVKw9RGJt9Eb35eDjw6ju+BBnZGJ0CMVB5a
	 XHqbIgR95RnDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>,
	syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rbrasga@uci.edu,
	ghanshyam1898@gmail.com,
	eadavis@qq.com,
	peili.dev@gmail.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 16/21] jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
Date: Sun, 24 Nov 2024 08:56:49 -0500
Message-ID: <20241124135709.3351371-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Nihar Chaithanya <niharchaithanya@gmail.com>

[ Upstream commit a174706ba4dad895c40b1d2277bade16dfacdcd9 ]

When the value of lp is 0 at the beginning of the for loop, it will
become negative in the next assignment and we should bail out.

Reported-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=412dea214d8baa3f7483
Tested-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 7bb2d0212c90a..7e1cc0e21eff2 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2966,6 +2966,9 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 	/* bubble the new value up the tree as required.
 	 */
 	for (k = 0; k < le32_to_cpu(tp->dmt_height); k++) {
+		if (lp == 0)
+			break;
+
 		/* get the index of the first leaf of the 4 leaf
 		 * group containing the specified leaf (leafno).
 		 */
-- 
2.43.0


