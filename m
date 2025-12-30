Return-Path: <stable+bounces-204245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9384CEA28E
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 17:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9488E301D0D2
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE1320A29;
	Tue, 30 Dec 2025 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M51kIw+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739D3191A7
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111777; cv=none; b=VrvDMHMTyTFJmzRSzNgc05Q4lA9bHCD5IXmYoVtA09enDlfPnh+dwXvIGLjtfH/NCDcfF/lifJRX5Woz5hnA9eY55XEPMfrgjowwn2xliV8Pj869Eqm1hguHU0eJp4/vnz4WncvHUDdNC0qNL+b3W3YP810Ws1QKIu8Ks6NmiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111777; c=relaxed/simple;
	bh=u0cEnRraoaUdb2iRXvWocLIhzNICxDhc+X3U6HM9sQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I28YPWzBlAna249R1cHB+v7XIzwE+pQ8I0EQeddg1tGf7HtXQ9rksaGXNGuKlojYFL9ni9s9BOKv3Fsa+lsOKKmbxj0mKlm7D1TaR4+ZQIl8iNSiXNGxIPzZCZVpmJyZrOjRZXOJ4JK8zmxEp6yXlZe2frRLi1MsnarZEIXjwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M51kIw+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AC3C4CEFB;
	Tue, 30 Dec 2025 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767111776;
	bh=u0cEnRraoaUdb2iRXvWocLIhzNICxDhc+X3U6HM9sQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M51kIw+lUpuoA5FYPHAB7Qly1AfichERXUzhDMJDGQzBhK/2dSASxkIiLepFI9GPW
	 IVRNeSeMHqsprkJ9Exo/9nOcxwNn6UD9oXe+mxODJaK5giEQpMsIYsTZIRxbHqAMfd
	 qg/zTtmS9l1CFjjrYNmFNtiwqniIezZm5PxJrDl6MKc8lWRkbWwmCICwIqx4PQX4Gx
	 lG4dwaISTTI7LD0hjFkZJYmzFr3PNDWf2YTmpjdVcGwSmJM3fyBc5eihy//U/mySLp
	 WBrbpXQBplckrEK4AGAWGdwwNZ6awRZa2TdK4X5Avj6n9QdK+cSc7N16hMJLD9xrGF
	 QN/orIhmCK0vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sheng Yong <shengyong@oppo.com>,
	Song Feng <songfeng@oppo.com>,
	Yongpeng Yang <yangyongpeng1@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] f2fs: clear SBI_POR_DOING before initing inmem curseg
Date: Tue, 30 Dec 2025 11:22:51 -0500
Message-ID: <20251230162254.2306864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122946-opponent-boozy-7af8@gregkh>
References: <2025122946-opponent-boozy-7af8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sheng Yong <shengyong@oppo.com>

[ Upstream commit f88c7904b5c7e35ab8037e2a59e10d80adf6fd7e ]

SBI_POR_DOING can be cleared after recovery is completed, so that
changes made before recovery can be persistent, and subsequent
errors can be recorded into cp/sb.

Signed-off-by: Song Feng <songfeng@oppo.com>
Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
Signed-off-by: Sheng Yong <shengyong@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: be112e7449a6 ("f2fs: fix to propagate error from f2fs_enable_checkpoint()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ae7263954404..7d4a0a906614 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4843,13 +4843,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_meta;
 
+	/* f2fs_recover_fsync_data() cleared this already */
+	clear_sbi_flag(sbi, SBI_POR_DOING);
+
 	err = f2fs_init_inmem_curseg(sbi);
 	if (err)
 		goto sync_free_meta;
 
-	/* f2fs_recover_fsync_data() cleared this already */
-	clear_sbi_flag(sbi, SBI_POR_DOING);
-
 	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = f2fs_disable_checkpoint(sbi);
 		if (err)
-- 
2.51.0


