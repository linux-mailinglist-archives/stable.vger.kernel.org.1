Return-Path: <stable+bounces-59470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC2932911
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE68B2860B7
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60AE19D898;
	Tue, 16 Jul 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UArRWzLG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DB19E7DC;
	Tue, 16 Jul 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140147; cv=none; b=uQ9Fqpu4jZtntlLVnn7wQ4LY8DYtLKtYiSmrtzVpOFoVbJol9hExs/Oa6dg9E8mSnFg7SNu7SdAM1kZge3E3jRLIPSmSay8MaIlwF2nFeAxpTl5CemknEtzoRy4b2jfFSBQAfAiP88pKPPPvamZWJX18S6se45ivL3npgEsh7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140147; c=relaxed/simple;
	bh=8DZ+UvYWXLieNDjcPqQu55JAO03uXEdFSEaxbU1vTcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTMcr871ZAZOGJtgCH8iRUJfAwXmkJBVI2TgPtyITd7hZbsJHZ+D6k2pkOHd8q4wlwvjoYvkGtK2YbY2/PZuvZgtRIiBIAqBuNBn/9cpDDWsr3DZmqyRu6XTwO8AVKSPa3sssLFohDqmSXfZtZsPC/5PUADqYwfaHRbY7F74tQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UArRWzLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEF2C4AF09;
	Tue, 16 Jul 2024 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140147;
	bh=8DZ+UvYWXLieNDjcPqQu55JAO03uXEdFSEaxbU1vTcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UArRWzLGDf3luJrfdVfx52i99DlCUVDZbJ5y9wK7kOgkPoIz2GrKWHCIaJvB4bSjx
	 3X1KO3AcPxxbDmhMjn8vAN9SJ81D6xFDHe4dw5GWNX1UsxwItZ6F7rAL8vIF9c3exI
	 CvJB9dnVWEMbJMR1emqVjA/simawvf8KK8gRkEPVBq7JTweIjckgJy54G5QHrHZ/76
	 Zhm5JdNszh3i7KiX8PipzU45dSwra/KzK6S39tPR18WlGWEn45rL/A9t5qTQlvyYJK
	 Ahy4OhpCLWX5sKkvCmEXRyUDBuY58+IrCxREVv0V7TCyO5BMa8WUKxovDknqiP4Lae
	 0sVYHiOuEhx5w==
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
Subject: [PATCH AUTOSEL 6.1 14/15] drivers/perf: riscv: Reset the counter to hpmevent mapping while starting cpus
Date: Tue, 16 Jul 2024 10:28:11 -0400
Message-ID: <20240716142825.2713416-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
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
index 382fe5ee6100b..5aab43a3ffb92 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -502,7 +502,7 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 	 * which may include counters that are not enabled yet.
 	 */
 	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, pmu->cmask, 0, 0, 0, 0);
+		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
 }
 
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
-- 
2.43.0


