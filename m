Return-Path: <stable+bounces-127898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5981A7AD10
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C38E1618BB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D0325A2A3;
	Thu,  3 Apr 2025 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbROkayl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3314290BAD;
	Thu,  3 Apr 2025 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707345; cv=none; b=opcqtDZqlHfn7480EKhbbstcEmn0ef/Z4tzFbpLnb8ZQZ8dqqlDbXZkVLvtK6gSZRMXr9Vjib/PbKuwWabZM5PunAhXgaTp52d16G6QPFKcDONQkK624ChtLsgDyFmimWFWd8iR57BOlIiF86mNKPLuxXlbM7+DwdcGpdIhJyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707345; c=relaxed/simple;
	bh=VQQiRatY8EIEAIaWfZVXAqvF+w2crUxrchqhiCQJ6Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dslyM6nqKZQ8ZqLG9EHzXeoSRjzdlW+W9qdt7lAo7T2uFn7xgMpLjN/Nt3zdjGxqGXp/tm5AtuSvUdeitRwRa3dQVDQ3/Mpb8NkzeVm9xUVN/cFzOUu65aXRVTRsk+OZf4V2cCz/SoF1wOZ7SPK570W3boSYj8iP1yUjNo9ODFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbROkayl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E2BC4CEE3;
	Thu,  3 Apr 2025 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707345;
	bh=VQQiRatY8EIEAIaWfZVXAqvF+w2crUxrchqhiCQJ6Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbROkaylruy/yEHHiyVHIoMlQQJgUqVXB4FnS7FaE+Y/XQhuihw6trgrj4wFlqdk1
	 kCzmbMrvZN7LTRWlqNGScs4U7Lnnr5BRW9VnOPAuVLO0WTH9gew/pGUA7Tf3IjVSEA
	 F0fec/KLzTXRZKOfYjsrf/R/J6sCJp5Vl4qa0l9iA4Sr1s3erifOEB+Fq9OBWaXcJt
	 Cbze20TrKy52EZIRb3bWMCH486ZqyBgg07IoMvSeRYCMWWVmTySf9LKzxZnWLvMdQD
	 +a+ewXHZr0lXQbUooIatiTv3MeGJExgkqtT12hS6PGxHznVN4KxcnsQ8dYctVy1ULt
	 uk1gYo5DI17LQ==
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
	niharchaithanya@gmail.com,
	ghanshyam1898@gmail.com,
	rbrasga@uci.edu,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 07/18] jfs: add sanity check for agwidth in dbMount
Date: Thu,  3 Apr 2025 15:08:33 -0400
Message-Id: <20250403190845.2678025-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 11b6be462575c..5e32526174e88 100644
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


