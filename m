Return-Path: <stable+bounces-52820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9C90D00F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F50B277DF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51D1B47C7;
	Tue, 18 Jun 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxZjxZSy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4FE1B47C3;
	Tue, 18 Jun 2024 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714571; cv=none; b=I2ihfB7z3Jn+m2AS+CzJ3BkO4J5PtLMWyGh3uqgQ8fiMsrln1y4rt8Kd5sWWibJkDzs5DxCCSPxPB5qLIRVOU4SxnKu33LEKwzysPlUVtEyqTxCP8+UpqV39Xzobxh7v+Y9agFvb5sfIGz3iAUxcnwyNoDyQPydGYAfnZYJGuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714571; c=relaxed/simple;
	bh=Dd6pY7xPJEu5e/X4E+ynYc0y6ur0lmwjdRCXfrc2LsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/dZubfkwS6AsTlnptT8Fhx+ogaltUNUIDhzUXN2u2TwF8+YsvD07frejGmEjNQBYLagHQtIBZ3bRCcJVaer8yUDLzxBoK1PhL2NrP4/Mm1NnQhA8bhQJVWikeRN/ViM+ce49VWhFgbHjsoudmtk6g85AS0tYTpbo2lvTWWxHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxZjxZSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B559C3277B;
	Tue, 18 Jun 2024 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714570;
	bh=Dd6pY7xPJEu5e/X4E+ynYc0y6ur0lmwjdRCXfrc2LsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxZjxZSyowyDns7M5DPl5T5quF50sV2lD45WpXNPjRJiGETdaeIszS32TxBO0HncJ
	 hv92feMKtHLyWVpq2M6q/DuVL2nNzBElCMOYhZ6fJkVfgp0ZdrQCWj1vg+oXZ2vzei
	 nxQyTkrm22pc+vpfVtoxbKTUbixHMmuRtAVVmcN/J3jpYD07yO6H1lOsGW2dQSg3Ki
	 L/3AUb+29hILHcV60I2mEgxglse1O/P+r76kpwuO3pAFrK6/WjsSOWaGV7GYZ2idjf
	 1LlLxeGEqqR5ZJYxDo1F/kC5W5obZWh0y0GqTpaDuKJXloCTl2US75Qt05Rn2RpbQz
	 G+rGmm8VnN24A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Li <liwei391@huawei.com>,
	Huisong Li <lihuisong@huawei.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	j.granados@samsung.com,
	mcgrof@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 10/13] arm64: armv8_deprecated: Fix warning in isndep cpuhp starting process
Date: Tue, 18 Jun 2024 08:42:21 -0400
Message-ID: <20240618124231.3304308-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124231.3304308-1-sashal@kernel.org>
References: <20240618124231.3304308-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.219
Content-Transfer-Encoding: 8bit

From: Wei Li <liwei391@huawei.com>

[ Upstream commit 14951beaec93696b092a906baa0f29322cf34004 ]

The function run_all_insn_set_hw_mode() is registered as startup callback
of 'CPUHP_AP_ARM64_ISNDEP_STARTING', it invokes set_hw_mode() methods of
all emulated instructions.

As the STARTING callbacks are not expected to fail, if one of the
set_hw_mode() fails, e.g. due to el0 mixed-endian is not supported for
'setend', it will report a warning:

```
CPU[2] cannot support the emulation of setend
CPU 2 UP state arm64/isndep:starting (136) failed (-22)
CPU2: Booted secondary processor 0x0000000002 [0x414fd0c1]
```

To fix it, add a check for INSN_UNAVAILABLE status and skip the process.

Signed-off-by: Wei Li <liwei391@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
Link: https://lore.kernel.org/r/20240423093501.3460764-1-liwei391@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/armv8_deprecated.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index f0ba854f0045e..34370be75acd5 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -471,6 +471,9 @@ static int run_all_insn_set_hw_mode(unsigned int cpu)
 	for (i = 0; i < ARRAY_SIZE(insn_emulations); i++) {
 		struct insn_emulation *insn = insn_emulations[i];
 		bool enable = READ_ONCE(insn->current_mode) == INSN_HW;
+		if (insn->status == INSN_UNAVAILABLE)
+			continue;
+
 		if (insn->set_hw_mode && insn->set_hw_mode(enable)) {
 			pr_warn("CPU[%u] cannot support the emulation of %s",
 				cpu, insn->name);
-- 
2.43.0


