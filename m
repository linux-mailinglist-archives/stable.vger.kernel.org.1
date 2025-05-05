Return-Path: <stable+bounces-140725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B9AAAAED
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07635188B98B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9162F10BA;
	Mon,  5 May 2025 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW8ATfXb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85938AC6B;
	Mon,  5 May 2025 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486067; cv=none; b=CvYx3yoB8zqdg8cSY13djxCxdjQemRpiBAiYIijF3nJ6YF0qRG1bVrbJ02lh78I9eD098is6yyrlhaa1x7nIN3odLYo+42FlH7n/k+lPAyvxyXPuG9/H8u7J7rXQJDr+ORXGBkv6WPf2IAyO+sJNabDryUmmMTmA7uCElttfqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486067; c=relaxed/simple;
	bh=hPkjsLeqWZe4ntLeAR3nTRoxsVbfSj08SPdFKyCJqvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKDzRdX5ULeuox5YaV4r7HmoTQke4u5xYhuVxZ5Lds6r+FzRnnjDQ0ManXzhxGZZwoJqlIB5tHfkcRfGvVUxBndpRo6OcbzwORAlGfUO420qp/Tt5/wi8AKlXyMlMXT4vTS9NePpNr26tDboZ/R8L04ZaANfS7UN278Bq4O4XNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW8ATfXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C7AC4CEEE;
	Mon,  5 May 2025 23:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486066;
	bh=hPkjsLeqWZe4ntLeAR3nTRoxsVbfSj08SPdFKyCJqvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZW8ATfXbthDj/wsZeu/I6+vh+5maXpFAA2/7gN91Ch0wqtGxg+tfnLc3ExpMwHPSt
	 h1OFEJUFphajON1PBch9A3RlnA7Ou+XWNA5lGgo+Lid8MqnF7bsKqtyB75m4qrWUS7
	 griPEVhLxiW6AbrT5Y2QZ5Q8nt9PsQcLsqLmv+1BNaW8cUyhtc5VjiNVrN3uPmFoso
	 F7ubkzawlIbvekJ5Grhfs68Nl9r2HDtkmnANqbhglp+UXSVhVEPoccdlYG+Pr8ZW86
	 HYIP69pNX5lHqU+jyyNHNPA7HsXKVtC6WkEuZl1kURd02bG/zbkROgjfVDtuH3N24H
	 bwneLplt66NkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 136/294] perf: arm_pmuv3: Call kvm_vcpu_pmu_resync_el0() before enabling counters
Date: Mon,  5 May 2025 18:53:56 -0400
Message-Id: <20250505225634.2688578-136-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: "Rob Herring (Arm)" <robh@kernel.org>

[ Upstream commit 04bd15c4cbc3f7bd2399d1baab958c5e738dbfc9 ]

Counting events related to setup of the PMU is not desired, but
kvm_vcpu_pmu_resync_el0() is called just after the PMU counters have
been enabled. Move the call to before enabling the counters.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Link: https://lore.kernel.org/r/20250218-arm-brbe-v19-v20-1-4e9922fc2e8e@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_pmuv3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 0e8f54168cb64..0858e6096453e 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -751,10 +751,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 	else
 		armv8pmu_disable_user_access();
 
+	kvm_vcpu_pmu_resync_el0();
+
 	/* Enable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
-
-	kvm_vcpu_pmu_resync_el0();
 }
 
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
-- 
2.39.5


