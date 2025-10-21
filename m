Return-Path: <stable+bounces-188420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 639AFBF83BB
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2991D18A6517
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B3B351FB3;
	Tue, 21 Oct 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5y+fXHn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E04338903
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074551; cv=none; b=KFSrysP9r0KwWJfkNypCcgTIiIC2C1A4apLi3Xj4xrjq4jihXusKGxE93Fd3RZO5teKKX9IonM1YNaPCyou7/OWzF2ofdKKcf2c3vghoUidO7AsRmEhF0Jh+vHBnDY1Tzlhs/voDs5TnjzYHZ4Dag+NWUb8vZiIx7DHTzjiOQIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074551; c=relaxed/simple;
	bh=Lg4UCJWv39cA3Iap3fZzNj98FsYxBCjsjJq8ljg0foU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHGZ2nHXRez9kMZuKaG2JDboBsaL/QIPw3EcHAg+UjXgdw1EYommL/i8MentKHoJyZV7uoEJSluavMIYRZ4tBFpcpyvQ7ANQKO7bcMPzO8eJC7MoHq9K2Tq6VWletNvvvIVZ/I/Rb1a4XbJaf/elIZQRwHHid1OAVJb0YJfzWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5y+fXHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B51C116B1;
	Tue, 21 Oct 2025 19:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761074550;
	bh=Lg4UCJWv39cA3Iap3fZzNj98FsYxBCjsjJq8ljg0foU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5y+fXHnOyQGZirbUaoteCsTP1S46MtvPhtFPM/JA9BJLrA1XS+zEp4xFjHoZfZhI
	 8FnVbKw3GKlCKA3yMf7LZ+wMKqdHGUAGEM2cSSDygzROi8O4wi16c5YKopw3bOHcSz
	 LeCa4hnMfYljtMedUJ0IuVWjHsiMDzIO5wuvPooBFRweMaUENhjw4OcczYhlp2gI8O
	 lSAzMd9x6jblW0enTWqgJlHh2SOuPDmWfuEdopjMmJlydlDlyDFoA3pjiMYo+4OfDo
	 l3Zq1tcRJs2KnO/hDddakjGISWR9p08P7nwwehaOuOvu5gefTCPL4xoaPFfhGXOvWO
	 n0mMKqCxa9Mgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	Kenneth Crudup <kenneth.crudup@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] PM: EM: Fix late boot with holes in CPU topology
Date: Tue, 21 Oct 2025 15:22:25 -0400
Message-ID: <20251021192225.2899605-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021192225.2899605-1-sashal@kernel.org>
References: <2025101616-gigahertz-profane-b22c@gregkh>
 <20251021192225.2899605-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Loehle <christian.loehle@arm.com>

[ Upstream commit 1ebe8f7e782523e62cd1fa8237f7afba5d1dae83 ]

Commit e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity
adjustment") added a mechanism to handle CPUs that come up late by
retrying when any of the `cpufreq_cpu_get()` call fails.

However, if there are holes in the CPU topology (offline CPUs, e.g.
nosmt), the first missing CPU causes the loop to break, preventing
subsequent online CPUs from being updated.

Instead of aborting on the first missing CPU policy, loop through all
and retry if any were missing.

Fixes: e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity adjustment")
Suggested-by: Kenneth Crudup <kenneth.crudup@gmail.com>
Reported-by: Kenneth Crudup <kenneth.crudup@gmail.com>
Link: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854f72b8144d@panix.com/
Cc: 6.9+ <stable@vger.kernel.org> # 6.9+
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20250831214357.2020076-1-christian.loehle@arm.com
[ rjw: Drop the new pr_debug() message which is not very useful ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/energy_model.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 2ef0a7d9d8405..d839b564522f6 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -755,7 +755,7 @@ static void em_adjust_new_capacity(unsigned int cpu, struct device *dev,
 static void em_check_capacity_update(void)
 {
 	cpumask_var_t cpu_done_mask;
-	int cpu;
+	int cpu, failed_cpus = 0;
 
 	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
 		pr_warn("no free memory\n");
@@ -773,10 +773,8 @@ static void em_check_capacity_update(void)
 
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy) {
-			pr_debug("Accessing cpu%d policy failed\n", cpu);
-			schedule_delayed_work(&em_update_work,
-					      msecs_to_jiffies(1000));
-			break;
+			failed_cpus++;
+			continue;
 		}
 		cpufreq_cpu_put(policy);
 
@@ -791,6 +789,9 @@ static void em_check_capacity_update(void)
 		em_adjust_new_capacity(cpu, dev, pd);
 	}
 
+	if (failed_cpus)
+		schedule_delayed_work(&em_update_work, msecs_to_jiffies(1000));
+
 	free_cpumask_var(cpu_done_mask);
 }
 
-- 
2.51.0


