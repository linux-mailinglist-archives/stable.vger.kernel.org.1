Return-Path: <stable+bounces-95061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27E99D741F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FCB2BC252C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA832203710;
	Sun, 24 Nov 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D76KeyGK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863920370A;
	Sun, 24 Nov 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455855; cv=none; b=ZraP1O6ExR/K88QfijE+UX5jHSkD+vp4MrUqAPSh/YVbkwjjtHSLdxIfAyPPpAv1R2vyXf5u4BDLxN/tTzfqjeNXTaG62QQLr7IuYtotWTmM/mlC/ZnTqc+mrCEaNfcE3zYQEAtmdIL6ZtWHNshuwiO1hqEZmqArj+BiVKCS9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455855; c=relaxed/simple;
	bh=BO6XiJPNfT8ipKf07nKW33xa4VrXBD/jl7rU5wBBQJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6IuT3tkw1W7ohViE81f3Zd8je5Jb+CF5/xKgQ4M9r7R3f4rat5q0iuMMLE6J0REp57jqwpi+ShCDwclmJ8YD4iuyQSTyvch6H54iAmLkUNSPqw8AAfS3j/MeUj8CQCL+9lzBtUCIECkLetkCHv+hMbfSXAwLtvsXVSuSXiSRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D76KeyGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E31C4CECC;
	Sun, 24 Nov 2024 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455855;
	bh=BO6XiJPNfT8ipKf07nKW33xa4VrXBD/jl7rU5wBBQJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D76KeyGKY3UIxa25X/vwxrbu/VSrIT0X7BzRoa1rbjIEFD79FV7lNOoGlK5yXjY5k
	 0UyJFoThkb8LOXWgQRj+n6QP15hRkspADZChjsRud/wOCgsZkslrL5sGtffKrMQes9
	 +4EER8/SWUAMEL6wzELsnLtIOP5EVTmD3PkA6BJG6WT8dtgizwhM82kOuZknOZ08Q0
	 w9/KRr84IC+RiXoFKYH0o2jYXkv/mmqZJw6SlrenwntK7aRpaiO3+lB3OX+qjKFv0j
	 wF9ANPFbBMXfW+EXfTWguJOO4yGZr3VfTZACarNWkcLBsoMcHDuJrmq6ZuDtgqjXdv
	 pnyh0slIBUWwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>,
	syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghanshyam1898@gmail.com,
	peili.dev@gmail.com,
	eadavis@qq.com,
	rbrasga@uci.edu,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.11 58/87] jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
Date: Sun, 24 Nov 2024 08:38:36 -0500
Message-ID: <20241124134102.3344326-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 39957361a7eed..f9009e4f9ffd8 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2891,6 +2891,9 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
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


