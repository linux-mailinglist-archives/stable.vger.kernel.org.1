Return-Path: <stable+bounces-110808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61198A1CD34
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AFE7A2ADA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903CE19E7ED;
	Sun, 26 Jan 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQB41mAb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE319DFA2;
	Sun, 26 Jan 2025 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909978; cv=none; b=MH0QaZGdUEruI5L+FK/uEx9iNN75hSgiSMuotjOyP7Ntd+Hywmr5//0ZGg4ncBhNSHaOQBSuAqPLu3mg7q8X5lbBzwUTz8iYSJOtpiRSwSdrZrt9oBUKDOFPNRhiXWwMD1/hc5X6zXyuUh0MSWfqzkULcwj5TNDU3kauUV5/aJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909978; c=relaxed/simple;
	bh=4M1D8Nf9NWNtXlGrr0mI2OGUhUqO7MM2B1GTAzKs45s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drprAIyWv31ahusM6U8EPVggkMftvHCAY8Zi2Md2eWgJOP8UV+rKrGT1eYNV+ZSeh6qMa5PzDJ0dVrUs3PmvR083VjHn0Sf6XuFqNg3wpoF8jbaodnzVni7nRwfUAz0Te+pCPhMm1njl/BMLVDv6YQ9vpTQz4oZ2qh4s266qap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQB41mAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD46C4CEE2;
	Sun, 26 Jan 2025 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737909977;
	bh=4M1D8Nf9NWNtXlGrr0mI2OGUhUqO7MM2B1GTAzKs45s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQB41mAbCkZA2SR+xapyFLZShjyEWsILRWUVABZTC7zCiIl19v8r9CydG/zGqPZq+
	 BdROjzGn0I6u5mB8FLHtKlROfPycr6/2OG3BqepfNiklvoK8ljAODLQbgFvKTAnPBT
	 6/vrpzmBEvI/Lpt1XKEEraxpQ58zAqgpEvgw9kLBOu0xu5AjPy/0OPCStA5P5bQ2aS
	 a8qFtiVKD5njJF7TgE/q7/XWmPNPpADCd3HR5o37fH5wckCGva2vFay2e0hjry/c1o
	 zQ/VYHXa7E+QQu+s/JGj2/lT5BRz4BruKXpsuy+94Qh29E9+DbFntqFGL/+EHAFllu
	 z2bcRWW+rhloA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kartik Rajput <kkartik@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	arnd@arndb.de,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 3/3] soc/tegra: fuse: Update Tegra234 nvmem keepout list
Date: Sun, 26 Jan 2025 11:46:09 -0500
Message-Id: <20250126164609.964170-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126164609.964170-1-sashal@kernel.org>
References: <20250126164609.964170-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Kartik Rajput <kkartik@nvidia.com>

[ Upstream commit 836b341cc8dab680acc06a7883bfeea89680b689 ]

Various Nvidia userspace applications and tests access following fuse
via Fuse nvmem interface:

	* odmid
	* odminfo
	* boot_security_info
	* public_key_hash
	* reserved_odm0
	* reserved_odm1
	* reserved_odm2
	* reserved_odm3
	* reserved_odm4
	* reserved_odm5
	* reserved_odm6
	* reserved_odm7
	* odm_lock
	* pk_h1
	* pk_h2
	* revoke_pk_h0
	* revoke_pk_h1
	* security_mode
	* system_fw_field_ratchet0
	* system_fw_field_ratchet1
	* system_fw_field_ratchet2
	* system_fw_field_ratchet3
	* optin_enable

Update tegra234_fuse_keepouts list to allow reading these fuse from
nvmem sysfs interface.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
Link: https://lore.kernel.org/r/20241127061053.16775-1-kkartik@nvidia.com
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/fuse/fuse-tegra30.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index e94d46372a639..402cf939c0326 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -646,15 +646,20 @@ static const struct nvmem_cell_lookup tegra234_fuse_lookups[] = {
 };
 
 static const struct nvmem_keepout tegra234_fuse_keepouts[] = {
-	{ .start = 0x01c, .end = 0x0c8 },
-	{ .start = 0x12c, .end = 0x184 },
+	{ .start = 0x01c, .end = 0x064 },
+	{ .start = 0x084, .end = 0x0a0 },
+	{ .start = 0x0a4, .end = 0x0c8 },
+	{ .start = 0x12c, .end = 0x164 },
+	{ .start = 0x16c, .end = 0x184 },
 	{ .start = 0x190, .end = 0x198 },
 	{ .start = 0x1a0, .end = 0x204 },
-	{ .start = 0x21c, .end = 0x250 },
-	{ .start = 0x25c, .end = 0x2f0 },
+	{ .start = 0x21c, .end = 0x2f0 },
 	{ .start = 0x310, .end = 0x3d8 },
-	{ .start = 0x400, .end = 0x4f0 },
-	{ .start = 0x4f8, .end = 0x7e8 },
+	{ .start = 0x400, .end = 0x420 },
+	{ .start = 0x444, .end = 0x490 },
+	{ .start = 0x4bc, .end = 0x4f0 },
+	{ .start = 0x4f8, .end = 0x54c },
+	{ .start = 0x57c, .end = 0x7e8 },
 	{ .start = 0x8d0, .end = 0x8d8 },
 	{ .start = 0xacc, .end = 0xf00 }
 };
-- 
2.39.5


