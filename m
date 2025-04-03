Return-Path: <stable+bounces-127930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F47A7AD55
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FE9177032
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2322BF3FB;
	Thu,  3 Apr 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VigYIOTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0122BF3F3;
	Thu,  3 Apr 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707418; cv=none; b=RKNiG2NuLspzyuOrxKbJj5ZnxzjBkxJ6wM7GIlxiyPk9X3lKiNf9DrU46eUm7dSWn4Y0Ky7rVur9LXUj/qkSqwJPd2hCAuEpHw2QFOguUw7YzLgkRqLZiyBH2PnYtgGuxQEB5CSW6x4WOF2z54X4/mtrTr4UN81Q8OJQNMbV1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707418; c=relaxed/simple;
	bh=WyKlAsJ2/2pvwzjjmI56XNt6esscPGIt15CrzTuTmQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uscqVCiQdjpP5x//fPifO5ExGuRra5pnghwRPFI3bquYpRN9QuwxkhBFmXBOxkIyTyA/y1gIkqHEejhZHIujTn1XefDC8zTsOq/t4rVxmXB9nqmr4+j/NNNOALq7M7+qCM3erAdH0ug+zqG/Qvftz5W6dy4nlbYQwlWdWIlfU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VigYIOTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55069C4CEE8;
	Thu,  3 Apr 2025 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707418;
	bh=WyKlAsJ2/2pvwzjjmI56XNt6esscPGIt15CrzTuTmQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VigYIOTvIYoiYV50pfLaqCcrZyXNGxBEooEb+wbq6sKnz0bp51F93jUCGlchzaGDK
	 DbzS6Kp5Yz4ay4wPLGJCC9dPbaaEAjQymDahQQkQPPOhArB8kzsUwzU8HadO6F+0M+
	 2aAhRJ0OqhnDk+Gxx9maEat9TX1RmkEX2F1t0vRRZGsvLtZeogvxGQBeBMI2au7nRH
	 ehuo0ZyRdskCYu8frZOp7CuOakZpY+M06//khruowfRiTW8oYsW2cgVNzthRyBZoLU
	 iX0qedJ0CVFegrSOl+kdsEF18lQNRt8qorAw8EkTxYWq9jkA/4cGHFJgiG/0NNbpdI
	 TuTN3SQxa4KvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+7c808908291a569281a9@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rand.sec96@gmail.com,
	peili.dev@gmail.com,
	ghanshyam1898@gmail.com,
	niharchaithanya@gmail.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 05/15] jfs: add sanity check for agwidth in dbMount
Date: Thu,  3 Apr 2025 15:09:52 -0400
Message-Id: <20250403191002.2678588-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191002.2678588-1-sashal@kernel.org>
References: <20250403191002.2678588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit ddf2846f22e8575d6b4b6a66f2100f168b8cd73d ]

The width in dmapctl of the AG is zero, it trigger a divide error when
calculating the control page level in dbAllocAG.

To avoid this issue, add a check for agwidth in dbAllocAG.

Reported-and-tested-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 3cc10f9bf9f8b..8f4c55c711ba0 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -204,6 +204,10 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
+	if (!bmp->db_agwidth) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
-- 
2.39.5


