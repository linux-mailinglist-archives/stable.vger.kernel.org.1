Return-Path: <stable+bounces-52528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A340890B142
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303DA2841DB
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA171AFD2B;
	Mon, 17 Jun 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPUn4Ie5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF731AFD26;
	Mon, 17 Jun 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630850; cv=none; b=j7PLgIjMOUXi/AeRfhYiDzy844lsv+VhROxy7VbkIVD8JDRyIbBrpoRQglh9dChq0tAASAwlJMkqZ7yBwIyEcoqhkKjs1lhFpd4O1m9mmZAkC075oahTKvCuvD7ItOA7DFqq2x8+6x/H3IXqVKrHya6upIgZ5Pdt6XiiVmRO8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630850; c=relaxed/simple;
	bh=Dd6pY7xPJEu5e/X4E+ynYc0y6ur0lmwjdRCXfrc2LsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtVPYrjc7CRrtDeQuV+oKjlj4uUmduuyr9Ny/6SC5mZ+67cM3vwCo0P9I3iI/c8GiPBj3KIPADmzgf4n2zCbpogJVy7Ujufgn3iDmgjHJ+EzMFvvIIXuoTOglREgPHZzSYw4+6UsqmgZWtzHXnII70BwAGhjods6oGmODj1Ldxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPUn4Ie5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2ACC4AF1C;
	Mon, 17 Jun 2024 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630849;
	bh=Dd6pY7xPJEu5e/X4E+ynYc0y6ur0lmwjdRCXfrc2LsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPUn4Ie54lVKs1watNtzr9G+TAhwNOzbH5Y2LQkP1pPr/s4sf9IPOLAXI1qGNr0VE
	 GYP5do8p/0zd+thU47R25aglt96US7HiDp2Z9PICDxdmSvrwFwJT/dsNdRsj1jUF8l
	 0XdxEdA8s7DNuk6wGOoZZy6BpxijWkm0wMlpyYaOga2/uWyriYu5OyLl+uEyaNYUPH
	 WXJ3Fl6JEPLqEKVyh0Q69ni5CD1T71Dlj+WyPqyh2oLjHChBgnCgngXIR4jJMitf3y
	 Ue2RR/zUm79+me031W8FZh81GfKOH5JsNtPgaVNl9NDDe/7jcAAWGJq8ONaVzwN6Ug
	 lVd4MNxrW1n5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Li <liwei391@huawei.com>,
	Huisong Li <lihuisong@huawei.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	mcgrof@kernel.org,
	j.granados@samsung.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 10/13] arm64: armv8_deprecated: Fix warning in isndep cpuhp starting process
Date: Mon, 17 Jun 2024 09:26:59 -0400
Message-ID: <20240617132710.2590101-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132710.2590101-1-sashal@kernel.org>
References: <20240617132710.2590101-1-sashal@kernel.org>
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


