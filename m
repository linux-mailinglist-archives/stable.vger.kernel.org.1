Return-Path: <stable+bounces-163481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBD2B0B963
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 01:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C163AC511
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 23:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCCE22DFB6;
	Sun, 20 Jul 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1gdOzKL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27E1F4289
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055242; cv=none; b=Nbb2qmf6F6YdrtYstd30sJo1FU2cxDFd2ZWyBXTtSvK1LHHM/34WrnG46JcdI0paFILT9YPi+ns2n1DFyJ4jIEyY5bohA0Y56EtI7ZCGgDW267708pBOpBJZDZGg+eKNMsM5WyC8SyAgRHFSDW36RkQi1LhGXNcS2/bTGqyk57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055242; c=relaxed/simple;
	bh=Su9/iTrXOISWFC1ULeqQqO+KtLQmpJzcXoW5/BRqCEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRrRkSMbNdaSIgD7uXlXucEpF2fQLDFYzYqXy3o+PKIMjTqoAMIy7hECzvYBcx2Z4nd8cn8wbLZ59CgZuU9BAzDQw311zOZ7KkJz71jUVJGIpwP9BKBqWtWPTQtjB1/grKmji/bYeCyrgsn9tVaK+a+qhao9PAL5LWWLVJcZVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1gdOzKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC491C4CEE7;
	Sun, 20 Jul 2025 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753055240;
	bh=Su9/iTrXOISWFC1ULeqQqO+KtLQmpJzcXoW5/BRqCEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1gdOzKLr+gCKti9PygxvtqygcIwqO7dwtKXqmaDeaENrnmi4EMN91mZCnK3jfZUZ
	 aPw9qEOoaWsT6kbpRGkwAeMME1S99zbpyBqu4xsbHIz4h6RVhMOCahHVHPgc1DIel2
	 jPbNijT8Rzpergi+jlKcSJTkmCJGPIZtQjozEjB/SlnEcw7Ja7qhxljJt5oVbHS+Gf
	 E8OxxCLVJZZbI0hvEBL5li6lsviXAr6s7CvHbphpZbBqjYFRbD6CWqsMrT9bKMUqXC
	 ComX/5QS1iXHN2CGbViJMFXBOjLJJZnmPhtvQOVfwVUJU5qGi9Q3lPwLMWXLRkkK9k
	 2ABDdvxCtI9XA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Wang Wendy <wendy.wang@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/7] powercap: intel_rapl: Use index to initialize primitive information
Date: Sun, 20 Jul 2025 19:47:01 -0400
Message-Id: <20250720234705.764310-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720234705.764310-1-sashal@kernel.org>
References: <2025070817-quaintly-lend-80a3@gregkh>
 <20250720234705.764310-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 11edbe5c66d624e2e1eec8929d3668d76a574c3b ]

Currently, the RAPL primitive information array is required to be
initialized in the order of enum rapl_primitives.
This can break easily, especially when different RAPL Interfaces may
support different sets of primitives.

Convert the code to initialize the primitive information using array
index explicitly.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 964209202ebe ("powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c | 54 ++++++++++++++--------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index e99905ca271da..169a08e691e8f 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -653,61 +653,59 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 	return div64_u64(value, scale);
 }
 
-/* in the order of enum rapl_primitives */
-static struct rapl_primitive_info rpi_default[] = {
+static struct rapl_primitive_info rpi_default[NR_RAPL_PRIMITIVES] = {
 	/* name, mask, shift, msr index, unit divisor */
-	PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
+	[ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
 			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
+	[POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
+	[POWER_LIMIT2] = PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
+	[POWER_LIMIT4] = PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
 				RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
+	[FW_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
+	[PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
+	[PL1_CLAMP] = PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL2_ENABLE, POWER_LIMIT2_ENABLE, 47,
+	[PL2_ENABLE] = PRIMITIVE_INFO_INIT(PL2_ENABLE, POWER_LIMIT2_ENABLE, 47,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
+	[PL2_CLAMP] = PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
+	[PL4_ENABLE] = PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
 				RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
+	[TIME_WINDOW1] = PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
+	[TIME_WINDOW2] = PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, POWER_INFO_THERMAL_SPEC_MASK,
+	[THERMAL_SPEC_POWER] = PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, POWER_INFO_THERMAL_SPEC_MASK,
 			    0, RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(MAX_POWER, POWER_INFO_MAX_MASK, 32,
+	[MAX_POWER] = PRIMITIVE_INFO_INIT(MAX_POWER, POWER_INFO_MAX_MASK, 32,
 			    RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(MIN_POWER, POWER_INFO_MIN_MASK, 16,
+	[MIN_POWER] = PRIMITIVE_INFO_INIT(MIN_POWER, POWER_INFO_MIN_MASK, 16,
 			    RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, POWER_INFO_MAX_TIME_WIN_MASK, 48,
+	[MAX_TIME_WINDOW] = PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, POWER_INFO_MAX_TIME_WIN_MASK, 48,
 			    RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK, 0,
+	[THROTTLED_TIME] = PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK, 0,
 			    RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
+	[PRIORITY_LEVEL] = PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
 			    RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
+	[PSYS_POWER_LIMIT1] = PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK, 32,
+	[PSYS_POWER_LIMIT2] = PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK, 32,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE, 17,
+	[PSYS_PL1_ENABLE] = PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE, 17,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE, 49,
+	[PSYS_PL2_ENABLE] = PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE, 49,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK, 19,
+	[PSYS_TIME_WINDOW1] = PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK, 19,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK, 51,
+	[PSYS_TIME_WINDOW2] = PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK, 51,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	/* non-hardware */
-	PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
+	[AVERAGE_POWER] = PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
 			    RAPL_PRIMITIVE_DERIVED),
-	{NULL, 0, 0, 0},
 };
 
 static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
-- 
2.39.5


