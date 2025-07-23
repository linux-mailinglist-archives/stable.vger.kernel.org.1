Return-Path: <stable+bounces-164358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F5FB0E8A7
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102AD1C8536A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0990C18DB1C;
	Wed, 23 Jul 2025 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQgPwx/I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C687E0E8
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237821; cv=none; b=N+fsdfdmtY9npyTYpkZ4ig3uL/SZK58fL+s9WjVKmCrm4ifQ9eaTCf4k+OG9jdq73TxILQg9GjS7OUGcF0pwvw0tSvcdalvNQykGoTwI/RaA2NZVF/EVe2ZMi/lYBZlsNuQhMKW9tqXeS4lI7BWnSAeaqPy5IjKPmP51R+jScc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237821; c=relaxed/simple;
	bh=4rkD5+oaBe4AhLBmtX2zYDlz6fZnsaGo/3ooYP16TJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nol6dCZXnooqK1kYiNG2Uw6u0Cwy8XOhL9j7CO5rDVZeSSfpJkXKOYP1PzZc9jA9LH98U7okW9weQDmT2IjYVF+imDA1aSNHcN56ILTMRi+gdYP1hV/Rd3svsrWh6Lb9eO/ZNa74bgqq+FYxbajC9kid6ke4wipZExVqKZ5x87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQgPwx/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B848C4CEEB;
	Wed, 23 Jul 2025 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753237821;
	bh=4rkD5+oaBe4AhLBmtX2zYDlz6fZnsaGo/3ooYP16TJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQgPwx/IBVmK+Uvs4OkG1qAQCE4j3D5NEUmt1IBAULOQI0Qf0AyaP9HkUCoBUV8Bp
	 XDrSQzmgsJ+GoYsdlX2Pkvix6tixbs0N3lcbw1oXB5qAVR1ExnPH0exjMzsFViS/q4
	 HUInU/ZpR6x9yD4t41h2fBTGHQHjHfQ4VUApzP2HW1vPqzsIIuLKYi9G2Bs44ky5tN
	 SM4tSJc5/kOYkohBg9iEboPWcohR06aFCP9e3OUIQhI42S87n1LR2k7V4EDj1RKZ3P
	 jFl+/hI63Uv3Xiyd0W1icS3NgCxZyZujfQzZbq03mv8IZCOJNgi64DoUJ7SEpRJRcs
	 L2bV5DkT4gDpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] x86/mce/amd: Add default names for MCA banks and blocks
Date: Tue, 22 Jul 2025 22:30:16 -0400
Message-Id: <20250723023016.1031080-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071200-bath-copartner-6a91@gregkh>
References: <2025071200-bath-copartner-6a91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit d66e1e90b16055d2f0ee76e5384e3f119c3c2773 ]

Ensure that sysfs init doesn't fail for new/unrecognized bank types or if
a bank has additional blocks available.

Most MCA banks have a single thresholding block, so the block takes the same
name as the bank.

Unified Memory Controllers (UMCs) are a special case where there are two
blocks and each has a unique name.

However, the microarchitecture allows for five blocks. Any new MCA bank types
with more than one block will be missing names for the extra blocks. The MCE
sysfs will fail to initialize in this case.

Fixes: 87a6d4091bd7 ("x86/mce/AMD: Update sysfs bank names for SMCA systems")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250624-wip-mca-updates-v4-3-236dd74f645f@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/amd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5535749620afd..9939b984bceb7 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1052,13 +1052,20 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
 	}
 
 	bank_type = smca_get_bank_type(cpu, bank);
-	if (bank_type >= N_SMCA_BANK_TYPES)
-		return NULL;
 
 	if (b && bank_type == SMCA_UMC) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
-		return NULL;
+	}
+
+	if (b && b->block) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_block_%u", b->block);
+		return buf_mcatype;
+	}
+
+	if (bank_type >= N_SMCA_BANK_TYPES) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_bank_%u", bank);
+		return buf_mcatype;
 	}
 
 	if (per_cpu(smca_bank_counts, cpu)[bank_type] == 1)
-- 
2.39.5


