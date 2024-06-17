Return-Path: <stable+bounces-52515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDB90B13E
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC880B36B14
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C61A8C33;
	Mon, 17 Jun 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCbsCxGp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BC1A8C2D;
	Mon, 17 Jun 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630816; cv=none; b=r9XO805+6+H5b5G0xg8rxkUD0iROGWy291fnIqHSt15ygP/7QLiTQcGeE+gu0GecIA9fN/FLpDSK1wIgz0abWBjgQFyviV+x/GY+tXU2IJH2x5LP2NnNg+cxX+A8HtrbJF8Z2kGWOWr64Cw2T/HCCrsdBGNiSXlWgP6+ZK4tnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630816; c=relaxed/simple;
	bh=cx592+iKFqXiOnvXyX+31L13tpfxsiMcgxmxVGX9NpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/Gq0soDeaMALhxaiVdlfxrzJ/BZ3KIX/I6jrF8jB445gnu87hMj6rDs37QiQ8nO3UzcHaxUIg0qyFMwITAVKp2T9u6CcyRSLdItP0KuNQeXzZ07Xq9UvMxT8LLEhDpD/fWjsdAI7Z40sHfKBmHCgBpNeygcxJk2fsvV3hvnxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCbsCxGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FA1C4AF1C;
	Mon, 17 Jun 2024 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630816;
	bh=cx592+iKFqXiOnvXyX+31L13tpfxsiMcgxmxVGX9NpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCbsCxGpvE/ixzf83CgPLiBEDI0OhHU0AVGl5WWPd6+w2t1uv1P1562B0pTRkQq5c
	 8+FbtoWFiIHGox7785b4jGZD1293h9gjKjwIBGtYC3Sr6W6vWN/+JLmGmOMAhkEfXy
	 /G94uOsp6BYhOrFBYdpTcwIvxw+i2y+fczM5zZ6Y9XKS4nGz8oabH6CRbzwsTFWxvz
	 ygC3SKdfucXPiD/uCazMyMUo7Q6brLKQI7L/+m56W1o0WYU3O4UiPI2c0h28Ir0rtG
	 nHQLntmr57Oaddp7gdB1LG2r650KpO/N8GR4/QfousF0soij/Zzt+tpGiRD6dcN1+S
	 LAPxAm8acjA1w==
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
Subject: [PATCH AUTOSEL 5.15 18/21] arm64: armv8_deprecated: Fix warning in isndep cpuhp starting process
Date: Mon, 17 Jun 2024 09:25:55 -0400
Message-ID: <20240617132617.2589631-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 91eabe56093d6..91c29979aea79 100644
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


