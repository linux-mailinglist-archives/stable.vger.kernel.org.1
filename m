Return-Path: <stable+bounces-52801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D0290CD6A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F13285B87
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606771AED4D;
	Tue, 18 Jun 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/7BLxPE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD231AED4A;
	Tue, 18 Jun 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714539; cv=none; b=GgcWuKELWDnVK0Hr1mKjsN57DeyWMpoONSOvZH6LmvafmWFWol9aClhPe03QOqZB/EQtyqfRyHDvegaXmNx8tRUf/Em3UjKFbOSLNkXQvalVhMN3oI+9Rl6f1WSfMw/buUgPgMc/DwFx5szyTtQyHjJhEDjrZ2JypWYYXlvm5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714539; c=relaxed/simple;
	bh=cx592+iKFqXiOnvXyX+31L13tpfxsiMcgxmxVGX9NpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XflQX26vcHzwRPC05QxhIGNKH+t1rWuDJPpE/vFO/KZKI+/pGlxJX9oxeJgJhWYpX2p2ofA1UQ8Pk2qZ+UoUunXN+/jZWB7hB3P2bLMxpvrt/xeMp0nwSSbiR7cBM/WLfrGle0mjQUJYBJxHx316LiVGmXcUPo8MlwP7a6os/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/7BLxPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A91C32786;
	Tue, 18 Jun 2024 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714537;
	bh=cx592+iKFqXiOnvXyX+31L13tpfxsiMcgxmxVGX9NpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/7BLxPEK+6RVl3IS3bSge4dMSQ64cSQmKhegcwOfI7A3lQ1+uH00urQhvvY0vjoO
	 L2/0NFEHm6bG+yyHCZX5NMWGLeWgfJm12MW78XZM1HQV/YkqwpH1Av9OxgzFQ3morM
	 m3N3Ty4tj8GTGG0tXDeDrl169NndBr/df0OaqN15xF7G/CcejQIAbqCjzkuCCpCZtD
	 Ga3TvNIqnF1JJUORrIUPaq71zxqPjcQ0DXQOe/InRUTxQk3QFuF0RtVXqukMXoQ+F2
	 WW+nFUwd66SoWoS4eaJBpv5JItE3Ht6Eq5Ik8mOpZ5MDNjE1SiZfTx/wU5MkrOiCtf
	 B8U9uHIsKG9Yw==
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
Subject: [PATCH AUTOSEL 5.15 18/21] arm64: armv8_deprecated: Fix warning in isndep cpuhp starting process
Date: Tue, 18 Jun 2024 08:41:17 -0400
Message-ID: <20240618124139.3303801-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124139.3303801-1-sashal@kernel.org>
References: <20240618124139.3303801-1-sashal@kernel.org>
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


