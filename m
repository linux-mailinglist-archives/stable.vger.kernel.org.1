Return-Path: <stable+bounces-224351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GRXFVUDsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:41:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A5F24B4C5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA21930D5560
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6F410D02;
	Tue, 10 Mar 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvI06+Yn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3997389462;
	Tue, 10 Mar 2026 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142044; cv=none; b=uBQnXcBBjk+gdhWfRxGjL7iXUgrs+onkasZVBU8AlVzL93Y7z5A59Z4albLKzJXfrqsV3Zc8jjO1vDNzD+8xh1ZS4gWO8QwA/Dm5A2viCLBs7PIM+vjyjeaFaGy/sgIORcd8sOqD8Mc9NJkRb6Uh7G15SI7F6NZ+T9pgXYV+L8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142044; c=relaxed/simple;
	bh=ZDWTqD3x1dJWdFMkFKLQhVEm80OZj1Db4opMt6qB8NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6mfjk7GD/jyggLU4fc100ToG+Xgi1x1K/aNV6HyD+yHSlzlHmhAUphA69ED/PW82KiSaU7NhIrmm7WnzairgvJIaLI/ug6zFkkowpK9wufNOwaGTd1B6FhlGWvUZmnUQuj7peMAG58tweyzGjFloojknKn9zNVGYv6DzvhRJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvI06+Yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93ACC19423;
	Tue, 10 Mar 2026 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142044;
	bh=ZDWTqD3x1dJWdFMkFKLQhVEm80OZj1Db4opMt6qB8NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BvI06+YnTAlxncV/cGS7KflYJ6+HOoZvEWQ8w/UncfvSez5WH16mG2KI2hXFQoVUh
	 M2kC727vgjX6Iz9nmDEhs0v5+CwyZi+JOwtMfGNoQ382EF56OcJmD99VPryocl3if7
	 3IIqL+pQ5IKCN1UwbEercTX0B7AHmulc1Urwwx81r1373LM/XKubN2c8flcNzaYB8s
	 0pl16+56gxuyxHmBygkPvvwYzm4NxuSpeBEKW2uGpogNID12shL7ZvEWD7y+2xKInP
	 G75am6mTEUEyfAl5o26d03SIesWyOGyN6OJlU7aZbcnb48PQzhbIyIcOGGFdh0Tf46
	 rGMy2F8kApwvA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 172/314] cpufreq: intel_pstate: Fix crash during turbo disable
Date: Tue, 10 Mar 2026 07:17:11 -0400
Message-ID: <018d7d288fd854010eb63585c8b36041eb081c02.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 61A5F24B4C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224351-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 6b050482ec40569429d963ac52afa878691b04c9 upstream.

When the system is booted with kernel command line argument "nosmt" or
"maxcpus" to limit the number of CPUs, disabling turbo via:

 echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo

results in a crash:

 PF: supervisor read access in kernel mode
 PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP PTI
 ...
 RIP: 0010:store_no_turbo+0x100/0x1f0
 ...

This occurs because for_each_possible_cpu() returns CPUs even if they
are not online. For those CPUs, all_cpu_data[] will be NULL. Since
commit 973207ae3d7c ("cpufreq: intel_pstate: Rearrange max frequency
updates handling code"), all_cpu_data[] is dereferenced even for CPUs
which are not online, causing the NULL pointer dereference.

To fix that, pass CPU number to intel_pstate_update_max_freq() and use
all_cpu_data[] for those CPUs for which there is a valid cpufreq policy.

Fixes: 973207ae3d7c ("cpufreq: intel_pstate: Rearrange max frequency updates handling code")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221068
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
Link: https://patch.msgid.link/20260225001752.890164-1-srinivas.pandruvada@linux.intel.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/intel_pstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 38333f7da40db..00b87f8ee70bc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1467,13 +1467,13 @@ static void __intel_pstate_update_max_freq(struct cpufreq_policy *policy,
 	refresh_frequency_limits(policy);
 }
 
-static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
+static bool intel_pstate_update_max_freq(int cpu)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return false;
 
-	__intel_pstate_update_max_freq(policy, cpudata);
+	__intel_pstate_update_max_freq(policy, all_cpu_data[cpu]);
 
 	return true;
 }
@@ -1492,7 +1492,7 @@ static void intel_pstate_update_limits_for_all(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		intel_pstate_update_max_freq(all_cpu_data[cpu]);
+		intel_pstate_update_max_freq(cpu);
 
 	mutex_lock(&hybrid_capacity_lock);
 
@@ -1932,7 +1932,7 @@ static void intel_pstate_notify_work(struct work_struct *work)
 	struct cpudata *cpudata =
 		container_of(to_delayed_work(work), struct cpudata, hwp_notify_work);
 
-	if (intel_pstate_update_max_freq(cpudata)) {
+	if (intel_pstate_update_max_freq(cpudata->cpu)) {
 		/*
 		 * The driver will not be unregistered while this function is
 		 * running, so update the capacity without acquiring the driver
-- 
2.51.0


