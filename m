Return-Path: <stable+bounces-127915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50999A7AD2B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC0318991F2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C529B22B;
	Thu,  3 Apr 2025 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQDwaMl1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDD29C328;
	Thu,  3 Apr 2025 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707384; cv=none; b=dt6f2Yz1pKdH196AtTLGwimmhYW+fUZM66oH2sus0PNNiubxdywmKko9LXSH9/rIY9U1xIYnUpSkeImexq3+ga1HrbgZuc4vESlep7/3lcdZrAmRV90lhnW49d0xDEnYiYi+m3PBxbNbZhdyM5bhDlK1lqbfhtq5Q8WhVh0dkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707384; c=relaxed/simple;
	bh=a/lWEcq4MvOXq8Dm2qBzh3SjI227vcmWnqwL602uVt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyc1sr7z8SBJXeuuZOGBdzLG9A36MN7xjIIgEwxAbnoghGommpWImOueXM2mSrxEMsfpt6T+DKOecdivLRdj2EnUvq89f9hRgQfCnUCEiY5ksXoHCUly2aS3uwwW3hD9oKwA9ZTBviIWS57DKzy5IVn1/fqaCR7eI1mppAxLT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQDwaMl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7565C4CEE3;
	Thu,  3 Apr 2025 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707384;
	bh=a/lWEcq4MvOXq8Dm2qBzh3SjI227vcmWnqwL602uVt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQDwaMl1AXnhdQEAeSzpEKk1VgGqISLZ3vurm3GrrsCMOEzKbE9pTqB4aMfe9NiTW
	 CVYtEQwgojUlEGl4DzxhN602k0VJDYiF+mDfGQ8kYhdrWOgA0Im3FhWOs+07maxb+w
	 YMh+c5gE848oOpQxAzR3UWSpZ5WM1XzG95sl8lkov5gP0yarnT/uZmZO2qEpy7x7h6
	 30aue7xJQdf16K9h+NtYTiH+3jDlsc1Gd/8vrz7t+1pyZ/ff+djN8vSYMbB+aOqDvf
	 RTfS2MoSzxVdjOMUiB3DySRrlYDp+Gs3Y5IjG+F+LdKU+5mWk8eeSOm4Wia6sA1X8K
	 EnDxyVoopaZBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+7c808908291a569281a9@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rand.sec96@gmail.com,
	niharchaithanya@gmail.com,
	rbrasga@uci.edu,
	ghanshyam1898@gmail.com,
	aha310510@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 06/16] jfs: add sanity check for agwidth in dbMount
Date: Thu,  3 Apr 2025 15:09:14 -0400
Message-Id: <20250403190924.2678291-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190924.2678291-1-sashal@kernel.org>
References: <20250403190924.2678291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 99e9885cbb444..cd6ba0c96d77b 100644
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


