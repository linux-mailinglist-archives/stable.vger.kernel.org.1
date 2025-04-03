Return-Path: <stable+bounces-127841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9E1A7AC57
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B0F176719
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF7026F470;
	Thu,  3 Apr 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTc7Vm+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB226F469;
	Thu,  3 Apr 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707215; cv=none; b=tBWDS58xbmWh+xDe3/L7G1JHpp+ANTlmnQk7fae3mKq00nPdJKMh7fjOYs2ZfRD/ZIEtyVNM9hBEW7Uao4HunA35jk6KeActC6ihHwigEofmIB3tjg5PIqVtbTDhEiN5AXdcFpRZd5kmSQMA7JJJd8kayyXDLNaywgIzIKVDEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707215; c=relaxed/simple;
	bh=DKtMNqkGSl3Jk+kOCm2sYF+Agp8jjR0lL5uamaFFRtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OqBSjU2rcSL8QkP3gm0+FhJIgzRr1t3vq61HbtEh3ofug7zK11DwrrfO9VJKe53fTRQxFF2KDtlH7pIRPjcruGmh8hISXYo47xT38nHq9IhelUsqWJaeMS2ma/SpJsxF10WMipee2XKhpuN31dZJzu/uismojLvS5dRDRqODEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTc7Vm+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AABC4CEE3;
	Thu,  3 Apr 2025 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707213;
	bh=DKtMNqkGSl3Jk+kOCm2sYF+Agp8jjR0lL5uamaFFRtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTc7Vm+LmyI2KEa1wx6htyzjJhlSw/rNscU4izdzVPkQWjigTWeIeKnr4Qton/3my
	 8ko+7Lxclfivp6Zv9/ldraKeUET+DBrgLomO7OSY8dVdAbx8TI6vJbixdRzb9X0XaF
	 t4CUUo5n8U4R4b0tB8AzMgPc9PfrW/CmwKU4+Xhy5UzYdEQ5bgKDcb5+7SPnd9KZAD
	 OU5lK/2yKyS1XeZMf5Nl73qmWZJGk8TaJSSwgEZSenz/JhSn6CGCaWp8s/iBHKzy8t
	 NjmOEiLyLHKChNzzWslhcXLskUwUiLAP0ra/iG3fERhFrzd5ZJoDXMuxCJvWKdZC/Z
	 x4dBAaFdR5hgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+7c808908291a569281a9@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rand.sec96@gmail.com,
	ghanshyam1898@gmail.com,
	aha310510@gmail.com,
	rbrasga@uci.edu,
	niharchaithanya@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.12 22/47] jfs: add sanity check for agwidth in dbMount
Date: Thu,  3 Apr 2025 15:05:30 -0400
Message-Id: <20250403190555.2677001-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 9ac1fc2ed05bc..0e1019382cf51 100644
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


