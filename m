Return-Path: <stable+bounces-95185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9619D73FE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9252A2839C8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184B236934;
	Sun, 24 Nov 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ7ZufwT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B160D23690D;
	Sun, 24 Nov 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456267; cv=none; b=Mpw63pIH2pG8Xjkk2p5gYy8/8F9N9KyImaqrhSfJoHs+saGd6hWzfA/H5wpaAKc3nPmmCGEJ1Ldkw0nKJE3BD0B6GWEPpnoAE0fE5UJPjaEzRv305wIn0szvH42OUKpS8zjKIOIhggl/oW/xrhfk8bQwV8ltJsR8Fi/KEj9UKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456267; c=relaxed/simple;
	bh=l5PdqaJLHwhARy2XCSDw06mVLgAJQeZSV6wtGkpYRgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfjsxIiO/kBLbVXdK5veCwq/nAcqOIBE1ZUr1udc9VVqltVQIU5dKGDF8YD1PAtHj6XJOULJ6EIq021zJxs6bvws3m3+jyJ+GHjCfYeSTF7apHNOygtvJQLjglVquSa/I8naSdW3lMiKW0NmMCMv/Ayw6v406pkErEdKJRrBpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ7ZufwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AC4C4CED1;
	Sun, 24 Nov 2024 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456267;
	bh=l5PdqaJLHwhARy2XCSDw06mVLgAJQeZSV6wtGkpYRgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQ7ZufwT0YrzmLtQDRjke4eJ05VwRvnkzZRGcE+kN7VY/2ADQ/5PzHUihkefKcvu0
	 RY6pv4nta8ZfunS3TNSPL4JMlSvLRHXJpRp2nvZN4OMR8XeoKkgKffdYObX3NuW8N+
	 ViwrINUVIij12DgpFbVdW11avDaSZuTnjrsggUxbwOi2vNzjNz5jFQaLigyPTvhHON
	 aTnOWHIq4tbj355QbZd1mAswDN7c+Y5ytA2Vf1ovgtM15rBQVWNsx34MUIumP5Zid8
	 R0mANMsPBomx+XjlZUAMZMT6CnxyCo6uYnkAK0vttfWrVXMDagDSewFRrV49Um8/f5
	 u60wQeZ2ofdQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>,
	syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	peili.dev@gmail.com,
	eadavis@qq.com,
	rbrasga@uci.edu,
	ghanshyam1898@gmail.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 34/48] jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
Date: Sun, 24 Nov 2024 08:48:57 -0500
Message-ID: <20241124134950.3348099-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 30a56c37d9ecf..6509102e581a1 100644
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


