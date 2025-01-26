Return-Path: <stable+bounces-110796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBC0A1CD11
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DB81885B48
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E318E750;
	Sun, 26 Jan 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXIabqnt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC218DF6B;
	Sun, 26 Jan 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909937; cv=none; b=LtVeR7euC0Ty4z+cDfW0FWpC7OZYsorsJY358m6piwYT3UMoNlzOdklNPsqGctc3Wr5EW+MM73yz2AtuSgEDkLiMRyyNUwIJ6L9fYF7S82XfMjTtx+0FzyRKZRLZTRWwKUjJ4KNjOW4htSwvfbgNJSDsXCW6qNYsVvPEqdgHL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909937; c=relaxed/simple;
	bh=RAMXiLffNFxcps5QIXjr79VU4lUEaMVI9sVYxPmUPc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGRRtGLrY45R57VBpB/+zVYDV8MNu7AFrOOSzGFhXFCgoWy3L7TvCG4hA7x5oKMf8vY573gK4gdPYm4rOAQB26y8iIh1HkEhBamx9RLgRZ4OwDKgbaKnTgu6xi31WTm9bQCmwwbT+2Q4pymFCJOAyw5wsWqZpypG3gMdevV6fP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXIabqnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA09AC4CEE2;
	Sun, 26 Jan 2025 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737909937;
	bh=RAMXiLffNFxcps5QIXjr79VU4lUEaMVI9sVYxPmUPc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXIabqntlEP3PsL52PkWmIEyxVGu2ajlMU8oDhl/YNlndSr8toxcm1NT3Q1BgzjiN
	 3FDELS9ECZ/AjjA+lHFhcIAz5iKiER2QnGmUQjsrjMzFcNfft1ajTGLeIpIIBTNMpN
	 LeIvICb2AuaaTyX9k08Z0ucKQmXXpfb/2guJ7pSQyFdxadcVUXXieHOREHeAqj2v6O
	 N0hA0SjhDt+1RnfUBFz1JiPHTW717rw2eMYfeIjqx8lYKM0jqZ+gu+CgOjlImV9T9j
	 MS19PKTSQQgfN42a2bg6MxzZ3UaJVtwKKrSFfvbS0+J5cZPvDv/HOdqy1gP8s2cUwI
	 wP9wDFnct0iLw==
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
Subject: [PATCH AUTOSEL 6.13 6/8] soc/tegra: fuse: Update Tegra234 nvmem keepout list
Date: Sun, 26 Jan 2025 11:45:21 -0500
Message-Id: <20250126164523.963930-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126164523.963930-1-sashal@kernel.org>
References: <20250126164523.963930-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index eb14e5ff5a0aa..e24ab5f7d2bf1 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -647,15 +647,20 @@ static const struct nvmem_cell_lookup tegra234_fuse_lookups[] = {
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


