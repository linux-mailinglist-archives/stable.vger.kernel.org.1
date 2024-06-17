Return-Path: <stable+bounces-52424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B090AF8A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2F1292204
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BBC1B150D;
	Mon, 17 Jun 2024 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNLVxgQe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA81B1507;
	Mon, 17 Jun 2024 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630536; cv=none; b=AvIODQGQlqSJ0CMuGuxwcyvQh0K30VNpeTinCEbV0zqdtrPVytRmk/Ld4QNzE279kDYT5Bdug5C0+qBVBDFLXseWFCbe2vfg+L64e8doplWomQD/atjmCjefjFrXvyd1TRlEJ92w+yF6j+WK8UbsozVq3xTJLj5zBoIog05hJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630536; c=relaxed/simple;
	bh=CUkpH5ziarLDNTdBZg+j4bgG3JKK8GRBVo8WUHYR+2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZ5JQcmzpseP2QSnVHtYOmLpijEIQ5bvjVo+oIi1NOXTIDdJ7ap8wtg2YIrmyClvlYJ/MdUT63ZmB7BnD4Pha8TYsSMAlMQ6Pa7R6Jz+1rrcebKL9iyU/p7S/V4k1pLw9R3FbpKPRfEgYeakVrT6jmGcp+PiRSSupT1bvWA4rJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNLVxgQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02068C4AF1D;
	Mon, 17 Jun 2024 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630536;
	bh=CUkpH5ziarLDNTdBZg+j4bgG3JKK8GRBVo8WUHYR+2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNLVxgQeVrVn+xCHGoArEpXMdNwkxWTmZZZlsFhFontEarc58luO3bZmwXKbTbF1A
	 ffj+OMJcFoU15yKhSGpK4lowomyGfOjbj5L0fo9c6c5x+LviytbLsRJiaGDlLg8YBr
	 VOLUT732jR2Rz+1zgmx5EuXKSQs5w+1aR+TeqfimYCqaGm2clOWAVgki1bjAVpE/V1
	 MZt1uHVmbbJYFVfQzbsUtxgwRA8npwMorSo+YfmnxklNM6alyTsN4xNPBl75LgTDoU
	 ZsWvz+TNQ1e8cv0TLUo3zvfkWdFKo3fRMlB/TB2Jtzv/Mj1NT/YomyTnrPz89/ZGWa
	 bl7XVfD8CQDrQ==
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
Subject: [PATCH AUTOSEL 6.9 37/44] arm64: armv8_deprecated: Fix warning in isndep cpuhp starting process
Date: Mon, 17 Jun 2024 09:19:50 -0400
Message-ID: <20240617132046.2587008-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index dd6ce86d4332b..b776e7424fe91 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -462,6 +462,9 @@ static int run_all_insn_set_hw_mode(unsigned int cpu)
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


