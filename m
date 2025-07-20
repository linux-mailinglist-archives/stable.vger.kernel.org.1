Return-Path: <stable+bounces-163482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D84B0B964
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 01:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1B63ACA9C
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 23:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FAF22F765;
	Sun, 20 Jul 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBFA1y6I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0C622CBE6
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055242; cv=none; b=KZIQO1m0ynGIXXCkt8adIQEeuK0mwERtA5Q+ebvcuIVdDqJlQii8HSQ9OVvr96JIsJDOG2fme7JPTkT/W4bWTwmr5jVk+hehgWdjFJX9JF0s607Tp+7V8jV3JGH0e/8cHdIIKeK2KTrgEHBd45NJ94LoqSLaajDfFApe+u9cnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055242; c=relaxed/simple;
	bh=0Jrp0zHKM5Ct+JH7lj5tm373gvs7YsDs70FZpHOXrXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=llPP+lwYcxNBUieRlXh5yrIP2BcflnglP5QPLmqR3lIPoIzc7VmYqhimDYfrvS1BrdaYBfZ1k3fGmL3Yd7afV7x4tKH4JUlZ1dvA+/sTKmB3OncJJ9ejq35INNXy5PdLXjJFC9I56Z3JR7ziAJcAXfl7BPd871IiiOPO2EMIlGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBFA1y6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10842C4CEF1;
	Sun, 20 Jul 2025 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753055242;
	bh=0Jrp0zHKM5Ct+JH7lj5tm373gvs7YsDs70FZpHOXrXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBFA1y6I1e7f2aN7TDEcuBsjrhFtrl7DgVKqPiYuwn18ZtUtBLZFMODI1QOQ3vc+p
	 piaUr1vvry5IRIMa505NZIJfEdB2po+vgYOkUymImGJaEM5LfT+HIubcb31h5YhgKl
	 GL1aOTzCDAv9Tio1dnWTtIWag+0c/ZnCk/FK3S5xhqv55agpX4LoKZiEe+CHygcJWD
	 WWSMNcEWBItjNJCVTpXDrUYOjKxEg7KBfMHRwE9kllGWA8wOk2YNBWlTE03GpIDVnA
	 idVG7chYcb8C55vUifUWAlSKlfkUdxv3QgVDbxx+p8OCJANBzFz5siVNdF2WVSnHgE
	 uesgrwSbjQ04w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Wang Wendy <wendy.wang@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/7] powercap: intel_rapl: Change primitive order
Date: Sun, 20 Jul 2025 19:47:02 -0400
Message-Id: <20250720234705.764310-4-sashal@kernel.org>
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

[ Upstream commit 045610c383bd6b740bb7e7c780d6f7729249e60d ]

The same set of operations are shared by different Powert Limits,
including Power Limit get/set, Power Limit enable/disable, clamping
enable/disable, time window get/set, and max power get/set, etc.

But the same operation for different Power Limit has different
primitives because they use different registers/register bits.

A lot of dirty/duplicate code was introduced to handle this difference.

Instead of using hardcoded primitive name directly, using Power Limit id
+ operation type is much cleaner.

For this sense, move POWER_LIMIT1/POWER_LIMIT2/POWER_LIMIT4 to the
beginning of enum rapl_primitives so that they can be reused as
Power Limit ids.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 964209202ebe ("powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c | 4 ++--
 include/linux/intel_rapl.h           | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 169a08e691e8f..87023d6aebf9c 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -655,14 +655,14 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 
 static struct rapl_primitive_info rpi_default[NR_RAPL_PRIMITIVES] = {
 	/* name, mask, shift, msr index, unit divisor */
-	[ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
-			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
 	[POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
 	[POWER_LIMIT2] = PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
 	[POWER_LIMIT4] = PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
 				RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
+	[ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
+			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
 	[FW_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	[PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index b2456d97995ba..50098e641181a 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -36,10 +36,10 @@ enum rapl_domain_reg_id {
 struct rapl_domain;
 
 enum rapl_primitives {
-	ENERGY_COUNTER,
 	POWER_LIMIT1,
 	POWER_LIMIT2,
 	POWER_LIMIT4,
+	ENERGY_COUNTER,
 	FW_LOCK,
 
 	PL1_ENABLE,		/* power limit 1, aka long term */
@@ -74,7 +74,8 @@ struct rapl_domain_data {
 	unsigned long timestamp;
 };
 
-#define NR_POWER_LIMITS (3)
+#define NR_POWER_LIMITS	(POWER_LIMIT4 + 1)
+
 struct rapl_power_limit {
 	struct powercap_zone_constraint *constraint;
 	int prim_id;		/* primitive ID used to enable */
-- 
2.39.5


