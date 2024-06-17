Return-Path: <stable+bounces-52461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308B90B03B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E210F285F57
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C51200132;
	Mon, 17 Jun 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwnD4caL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C8E20012C;
	Mon, 17 Jun 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630661; cv=none; b=jlcntM/z8n9SBN2J0ZR6EizvuhXmUByX2PrZ4z746w95iprVT3/Osv0CgjOYLSMn847m+IZaSChr90aSkZ7axvMElmXVWZbVltkjZ300cchF+E8mSrXsLW7aE/ILaMzKzRPCSHAPR/Yyl9tQybMd4PrzceWFtrpkZ9Qw5e61jNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630661; c=relaxed/simple;
	bh=gXFY6kVP7Vswt9ZX8PM6HfCz4hCwGp9J3qwlDlyRPdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMZoTqRA9PN4ROwq6CGUzUV5edznx5CHs1J+aFQpREHlyMr892v6blu83BbcrDGk+mhsiAWGBzj7qFtP1NpEh1q78lSruxi2cblAwoh/SFZlFxqi3AnW3uMM1bd9DOXOqK5qsBf2a+oJExd5vuKHbSLa1lVAE21dAgg3cwrwOs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwnD4caL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E04C4AF1D;
	Mon, 17 Jun 2024 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630660;
	bh=gXFY6kVP7Vswt9ZX8PM6HfCz4hCwGp9J3qwlDlyRPdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwnD4caLmXWnHLu6wyB3D9YN6mTC/blUMGYGhBTw9RUsbJp8sv7okOPMzS/Lev3x6
	 geiW31ZidiD8iEB37pnZoOS3faSITQ+7gASAkmnSVgY/Hk/nEkRauA6shAiAfOPL7e
	 pCPEBF6VxX0FkUliaKDWYsV4ydBjEgN1ps1D+oRNUvYigG9ET3jID8dPto3XJ+4zEt
	 nsPm+ozzC+vqQz4Od5ved9Zz29/hj1Zacjk8GWbmEGwke2I6YfsQb1sm6jupFmVWFn
	 VHXLBpP1a1YvppzvULx9+UWI7dZCYNAtacilOxxT6fF44w3kUip3k1KYN5LamQzTM6
	 nxIlVGtu50J2w==
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
Date: Mon, 17 Jun 2024 09:22:27 -0400
Message-ID: <20240617132309.2588101-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
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


