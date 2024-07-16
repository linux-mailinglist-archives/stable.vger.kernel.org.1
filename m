Return-Path: <stable+bounces-59437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7D29328AF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF756B20B6D
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBA1A2C11;
	Tue, 16 Jul 2024 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCnIEk7I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1E1A2C0C;
	Tue, 16 Jul 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140008; cv=none; b=VYlkEnJUMgICBEaMAPqZYXkp0qQF+v++XkLoVlKSkyDON7VWDkjj9vPGE2oebl5E8vbFv4w61yDijQuBPwO/EYzQWQfFVmCP8ZO4lkdHtT83hlX0h+mrXWEAof1fB3N8s1QLdyzhCOsSs8MyLgs30aboRe4NEyFiJei0r2z5PEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140008; c=relaxed/simple;
	bh=EXYSkTpfZdRsAURefw+wp/oHxR/nZJWgDFo0FkryX7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1S/L2grW7mG7tTzkica2UIsqzelKoCuNU9sgulCCSVmpqEHxW9FYbIOmd5T2dNd03MVId3PHGS/ZtBaOq2roADxEbPwjGKJiucOtu81iaIVwTGglj/jqweuJIWCplxzh9Dijc54yAHFZjutClzhft8SYac2Nxj/WbUSIuDQ6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCnIEk7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E501C116B1;
	Tue, 16 Jul 2024 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140007;
	bh=EXYSkTpfZdRsAURefw+wp/oHxR/nZJWgDFo0FkryX7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCnIEk7ITVMenMm3d9yP9wF6PZbszYZTlDOkexVGkuO/qzwmhEtLzjxTWO5fpXZvh
	 laqjeYg6V03HEi+bJWds9jrLw9TinBUQZxR6H4pHT/5YWujcRKnnA6nEOt6CxRFfXq
	 K+L2TJloJCZgiIv7akZgN9FS/F8aDsks9Yni2pAUfgR+wFfSXN7vJD9zfXI5r+wqlx
	 m9UEimLEv8xSjZaAK+8gFGetzLVsNgSGC7COxVk53LrJIS67cyRoyMvO284GlNtJRV
	 G3p7sSSWE0tX1mn8mcwyTDBNkwqboi33VIWpKHJhvXYb7IDqwxSFWx268NqL8thXO2
	 dtEzNPiqwzAVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Atish Patra <atishp@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	atishp@atishpatra.org,
	will@kernel.org,
	mark.rutland@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 21/22] drivers/perf: riscv: Reset the counter to hpmevent mapping while starting cpus
Date: Tue, 16 Jul 2024 10:24:28 -0400
Message-ID: <20240716142519.2712487-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Samuel Holland <samuel.holland@sifive.com>

[ Upstream commit 7dd646cf745c34d31e7ed2a52265e9ca8308f58f ]

Currently, we stop all the counters while a new cpu is brought online.
However, the hpmevent to counter mappings are not reset. The firmware may
have some stale encoding in their mapping structure which may lead to
undesirable results. We have not encountered such scenario though.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Link: https://lore.kernel.org/r/20240628-misc_perf_fixes-v4-2-e01cfddcf035@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 3e44d2fb8bf81..6d3fdf3a688dd 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -634,7 +634,7 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 	 * which may include counters that are not enabled yet.
 	 */
 	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, pmu->cmask, 0, 0, 0, 0);
+		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
 }
 
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
-- 
2.43.0


