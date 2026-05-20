Return-Path: <stable+bounces-249738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEGVIngqDWo2uAUAu9opvQ
	(envelope-from <stable+bounces-249738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:28:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 030EF587398
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB2683040D9B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF4352027;
	Wed, 20 May 2026 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KV6qtBh2"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5483491C9
	for <stable@vger.kernel.org>; Wed, 20 May 2026 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247368; cv=none; b=ez2wiRIGoWDU3O6z/Bf6TbhzDC3J24VbCE1cTq0UUfSza6ZRr2JETA6HaVPevlmpySn5REkrSpsMQeC++pfaVlKc5ZIGGn2csK5dqp97AGbnjwLuV/GO60GZtMwKr0NI1gKTtpA3SsDIJ0mUKXWfhEMQGO540Ypbh00+YQlHOVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247368; c=relaxed/simple;
	bh=Cpu72zIKlP/5shzkvgl5+ibZqDu3fBT7lzprYTL58rM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lYkNyZw9wZZGb3bekL3AdJ2rCZ3seLfFZNggQA2jxaE/8SVpKIuOOQhCp2BWOHBs8TsKbMA0AEWO7ebTU5jmBT8AYJbm8yMEZBekI5oRArsxsuobZn2h0qXdDftAYNUpBQnQJocewI/vFH5s3Nlu8yfBSX54C73QMWefOO2kOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KV6qtBh2; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779247363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZqZmu0OqZXtv/PtHiYRsiCkX8ld0/Ake0qTSoL86xa8=;
	b=KV6qtBh2zR13CBHHP4AaZRqqlnwcpLwTrs/mQpoSeDlAyDV9dX3SRyl8G8gp/HKwy/1v3/
	B+09PLGFyRDmMdQNDUUUyj+fOiHTRAxhzviDuVinT1Hgc18kpKbxqyrUfyh+Hz+cAGUpP1
	ExS8+ykyX70hxwuRZdMqISANBtnbk44=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	currojerez@riseup.net
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com,
	stable@vger.kernel.org
Subject: [PATCH v2] cpufreq: intel_pstate: Sync policy->cur when setting min pstate during CPU offline
Date: Wed, 20 May 2026 11:21:19 +0800
Message-Id: <20260520032119.30615-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249738-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[fushuai.wang@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 030EF587398
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Fushuai Wang <wangfushuai@baidu.com>

When a CPU goes offline with HWP disabled, intel_pstate_set_min_pstate()
sets the MSR_IA32_PERF_CTL to minimum frequency to prevent SMT siblings
from being restricted. However, the policy->cur value was not updated,
leaving it at the previous value.

When the CPU comes back online, governor->limits() checks if target_freq
equals policy->cur and skips the frequency adjustment if they match. Since
policy->cur still holds the previous value, the governor does not call
cpufreq_driver->target to update MSR_IA32_PERF_CTL.

Fix this by synchronizing policy->cur with the hardware state when setting
minimum pstate during CPU offline.

Fixes: bb18008f8086 ("intel_pstate: Set core to min P state during core offline")
Cc: stable@vger.kernel.org # 3.15+
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/cpufreq/intel_pstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fc..11db1c887c80 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2984,10 +2984,12 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	 * from getting to lower performance levels, so force the minimum
 	 * performance on CPU offline to prevent that from happening.
 	 */
-	if (hwp_active)
+	if (hwp_active) {
 		intel_pstate_hwp_offline(cpu);
-	else
+	} else {
 		intel_pstate_set_min_pstate(cpu);
+		policy->cur = cpu->pstate.min_freq;
+	}
 
 	intel_pstate_exit_perf_limits(policy);
 
-- 
2.36.1


