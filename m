Return-Path: <stable+bounces-52745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26B390CCBF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37C6285482
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7D19D079;
	Tue, 18 Jun 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/4hyYSb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465519D062;
	Tue, 18 Jun 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714384; cv=none; b=ZnRZLgUR2ORRB6oItP3CA/mDeR1wVS6upFWq0f7ytLO6MrM8PQ5RBjqHncBpmPPwl7uf6WYUBuxb6lLIdSQvcxApErry35fTRZZfDQ893CrRM3uepAUXhyKcEpJG0FiDh1Mrg7LFjIfaUMJ9i3+eyJTBKru6Q4/tDI4tpmjpMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714384; c=relaxed/simple;
	bh=gXFY6kVP7Vswt9ZX8PM6HfCz4hCwGp9J3qwlDlyRPdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4b2OaGWyFgwMDnSz+mBdkYkKfiM39vU8SO7VyZGIJzSGK6lql36B4/hcp4G+IRs3Xc89nokCU6ajaFDBiUK9tsJU/vr/t/M0tbqIawsj9NsxMq+8S7pISkl8QpSHM070JPxabhPdL2/dQcnFact9olxaG+HXspIxA4BLjQbyjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/4hyYSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BEBC4AF1D;
	Tue, 18 Jun 2024 12:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714383;
	bh=gXFY6kVP7Vswt9ZX8PM6HfCz4hCwGp9J3qwlDlyRPdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/4hyYSberJIT0QFFwge2zsQaNKmpQTfG8QHHJKVJlnWMckjU1LvPEX/DYMZkmgVn
	 ARODoR6iKo3m/9HBMnc7HnsoFKMzb6Pm29fFYCaRrQlx+LAceqItP3OPp3Acxxhj1x
	 pzhIIRuVQY3zDN97TNS8RJAogoX9Ej5a0sCx9+1YcSUyzhm4HfPwuP7mHIRhDgcYgg
	 o6f3L2gCJZFO+knoqyeY53bW9UD9QN2SJqhgeGfKDgMk0NIoVVaVApk4wW2/v9GGz6
	 6PAWScOaCzeHVGiN3/powN8ZTfQTsS2FZvjIej1e47zv7zXfRj9/a5EK5GUKghIQos
	 fkDTnvE6kLasw==
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
Subject: [PATCH AUTOSEL 6.6 29/35] arm64: armv8_deprecated: Fix warning in isndep cpuhp starting process
Date: Tue, 18 Jun 2024 08:37:49 -0400
Message-ID: <20240618123831.3302346-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
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
index e459cfd337117..d6b711e56df97 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -464,6 +464,9 @@ static int run_all_insn_set_hw_mode(unsigned int cpu)
 	for (int i = 0; i < ARRAY_SIZE(insn_emulations); i++) {
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


