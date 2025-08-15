Return-Path: <stable+bounces-169810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C826DB285C2
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3F31CE1B8B
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD9F20E31B;
	Fri, 15 Aug 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jBkECSIV"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1F317714
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282043; cv=none; b=ovfabOhzt/ptmoYXfyI1M5IrKD/X38KzmQJqrG5Pg3CfC0tRBqyTuduvz0E7ldVHY6ocVHzC5OMjKnLcBr3p7m0neZWZ39zUMqEkNLp08pVoCIw58eGqrQ1cwgxotyw8WKXkhGmLiMbwC8NSVE+rGqrrEwZvUgJkIBcHUxwc/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282043; c=relaxed/simple;
	bh=nDO8zXqErEmH+WSyUBD3fvey1CQrgFkBuqBQ2pzJOxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DtVrcopYiN6BbZSEVuc5J1S0RoVPiI6ou3piMNumfz0FXKIz5jsC6ue/zKt+sKfdq/5y8RxV9G988X7C99jP08D8r2Y34v9YsGAb0SoXSjPGV03hJncYpWSBKVVlhm7yyIIlXh93xUweh7diZ8vJUEE90vnNivgvx6waXoGgeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jBkECSIV; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755281983;
	bh=Nnx10Pc1Y5EMtdb/1rifNttU8FJJuSoF00TQXbSlXMw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=jBkECSIVCFhf0jVp0+KOi+Pknr++cYSoT56VAMp4PQjsSgkyCu/DKjCw2oyFJUCKo
	 go4mEj1P1bb/gzgjbYiPtucXgQgJLQCb0lW2AQhkOncCzQ9D3h7N2I5dZ98AytTh5n
	 vFmScq4Sky+UcRE+Mok9h8aNcuhfBp1uT2W+ftUQ=
X-QQ-mid: esmtpgz10t1755281977t4639d1eb
X-QQ-Originating-IP: 7M6B3ERDfHKfzXnV4T0TJHk2yFznXovGUJ1wmq66N+4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 02:19:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13253942423024133549
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 7/8] topology: Set capacity_freq_ref in all cases
Date: Sat, 16 Aug 2025 02:16:17 +0800
Message-Id: <20250815181618.3199442-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250815181618.3199442-1-guanwentao@uniontech.com>
References: <20250815181618.3199442-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NMjxIHxwvoj+6wx0qfdtbuGvCvZSTWjcZuKTo9jz9Vb7JkDO5X7Nsk+2
	CRHUyPR0VUeEqkJOyfbgfC6jdfnhiny2wZMg0fACcqN9TZucTHhgkhVchmPtPHOIKVqJNyD
	O4mkxsr0x7ZfTIYIO0R8zxA6+eK0R7W0Ii3Iq090SWc4HFIUQb1jhuLixj3kBWIQ5gDCPZt
	xj7ZUUrtBsJwQn71hDHxZxN11sdlt6mhmgtwyex8efcwxrHs5p6YCGTt5jZGACV9hrnf5Tn
	fDLIs1Z7J6KLOR6Kr0XKtJYhWQILrwmpq1Zi6DQlJ8CfDkHn5lbItk3fhyvdVfEOPVhn94i
	k4kg3lIrLx3MvcnnQq7OIkPVjUm+N9TRbSMG7vOdWEu9XIYSlYlMTGKZ+k6oLDWr7p6FPKG
	AX6pWzyE7xQIcm65kcokWz4VbIlx8qdtV7XtcNMzfxPOuE0NtIzCdq+mxtGzOSdwE9/3YlJ
	sQ3tO8S2A+Ru0+wtRsZygh0kj5hJa0HIyWNRw7pKGHRoOeGOZTzH0unDXYZBu+NIIZfPGVH
	4AoMzUkqPCX5VCvgOURR3hmWvdo7qoG6yNCEGCCidvYimjJh2ne5K1Rt4CkS11XJWp1DPlX
	TxQ8ogOlRsQ8Ng/1OkFx7SvYDgr5RQug/3OKVRKd/DGjOz3EkC2sEYsvjOvslJIWajuuphj
	wpGm0qoh/8yOc5RbMoR33/sO94O1XFBF4Yc0VMM7u1u0IBn4jiVV+Yaj8LUmtokY928UVoo
	b81v/1gnuJvtKQoyHN9eCrCjYFnQUk7oyV4AKGMfRzmcwHXKhgabd+E79a00E09WKbNtXou
	coLSpJlQ+lHDThhRrcBPBE+LQoSX9mnbguk6v2wr1DgEbtnbQvhtF2q/5d4UAZwjOHIG7Mr
	f7FHgZGkct1RXYZvr2Qj3LRN5dwQapKgQri/afHvgbtOEIVRWT5ZhXmchMkRMETkWcpoe5D
	jL3D2iazEeiePPYnZFLKvfftzoeZMKjNTQkx2Duy0rG9QcLrT+rjS4pIwBTj5GePNZRLN6F
	2bZUzFwSDipHn3Sq3wdtrJdCkhma1dsd6NcIBtiHJ2LMopJMJ87dK2OkodbA/u7iM67IRnU
	P/SENwXTUGut+dt4Xaq+kWOWnADOUjglyUxzubVeZ+EzPIhTgrnpSvHwuKpP1+SPA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

From: Vincent Guittot <vincent.guittot@linaro.org>

If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip the
normalization step which includes setting per_cpu capacity_freq_ref.
Always register the notifier but skip the capacity normalization if
raw_capacity is null.

Fixes: 9942cb22ea45 ("sched/topology: Add a new arch_scale_freq_ref() method")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20240117190545.596057-1-vincent.guittot@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 98323e9d70172f1b46d1cadb20d6c54abf62870d)
Stable-dep-of: e37617c8e53a ("sched/fair: Fix frequency selection for non-invariant case")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/base/arch_topology.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 5aaa0865625d..2aa0c6425290 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -417,9 +417,6 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (!raw_capacity)
-		return 0;
-
 	if (val != CPUFREQ_CREATE_POLICY)
 		return 0;
 
@@ -436,9 +433,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	}
 
 	if (cpumask_empty(cpus_to_visit)) {
-		topology_normalize_cpu_scale();
-		schedule_work(&update_topology_flags_work);
-		free_raw_capacity();
+		if (raw_capacity) {
+			topology_normalize_cpu_scale();
+			schedule_work(&update_topology_flags_work);
+			free_raw_capacity();
+		}
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
 	}
@@ -458,7 +457,7 @@ static int __init register_cpufreq_notifier(void)
 	 * On ACPI-based systems skip registering cpufreq notifier as cpufreq
 	 * information is not needed for cpu capacity initialization.
 	 */
-	if (!acpi_disabled || !raw_capacity)
+	if (!acpi_disabled)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))
-- 
2.20.1


