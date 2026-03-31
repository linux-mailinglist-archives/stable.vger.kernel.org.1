Return-Path: <stable+bounces-231852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKVjOm4BzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-231852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:16:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD9F36E5D0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E85293187F81
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B135423A7C;
	Tue, 31 Mar 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mlWc6gqd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2453425CE5;
	Tue, 31 Mar 2026 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975236; cv=none; b=tBmYWIjXqrRCfsw6eav3fZrJD4LYHgNBqfEg1uBRfmRDlqwR0ssN8B3FbVk1nuvUBxIkZbDpjZ7wo2KS7e639r73r8L/pKdihgJjZVT9wd/SzyJutyBPS7HgxdM5yURxLNH6ZAV2qv+NK6c2WuUMspYrHOOkGBKuE7V+/Y+vECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975236; c=relaxed/simple;
	bh=Reu0GdrV4O2AKWAIeez+CsX+rR93IywioFp/nXnZvhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpDzsWXuV3nRRtSQ5Pn4HQO3Ykuun7LwJz23SxyOuG2ogRYgiXaU6u9lFYzvMO3q/Kt7cPjf+GL63apE7u92q05Z/pmQsICfSkoxxYUNefu0+onbMMeHS4xArzZZqulAdCVw+qNxYVa+bLEn2PlZBz1SeARqIihNePcCeC3zmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mlWc6gqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59569C19423;
	Tue, 31 Mar 2026 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975236;
	bh=Reu0GdrV4O2AKWAIeez+CsX+rR93IywioFp/nXnZvhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlWc6gqdeJMwaV9V1FIKQwHjhrdOMkF72G9c3QZGisyuWnsdMukUoF5ndm6xGpgir
	 9I9q4JD3oUfG/vIBDcWMHS2JzAFKVyOJ2Aita24vZs0SlIVqzVrsCXH9NMvAlar3ix
	 k5dcClCu09E8lusXqQUhmDmZYSDgVs9SeaMJnKEQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.19 216/342] cpufreq: conservative: Reset requested_freq on limits change
Date: Tue, 31 Mar 2026 18:20:49 +0200
Message-ID: <20260331161806.926076185@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231852-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linaro.org:email,huawei.com:email,cs_governor.gov:url]
X-Rspamd-Queue-Id: 4DD9F36E5D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 6a28fb8cb28b9eb39a392e531d938a889eacafc5 upstream.

A recently reported issue highlighted that the cached requested_freq
is not guaranteed to stay in sync with policy->cur. If the platform
changes the actual CPU frequency after the governor sets one (e.g.
due to platform-specific frequency scaling) and a re-sync occurs
later, policy->cur may diverge from requested_freq.

This can lead to incorrect behavior in the conservative governor.
For example, the governor may assume the CPU is already running at
the maximum frequency and skip further increases even though there
is still headroom.

Avoid this by resetting the cached requested_freq to policy->cur on
detecting a change in policy limits.

Reported-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Tested-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Link: https://lore.kernel.org/all/20260210115458.3493646-1-zhenglifeng1@huawei.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/d846a141a98ac0482f20560fcd7525c0f0ec2f30.1773999467.git.viresh.kumar@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq_conservative.c |   12 ++++++++++++
 drivers/cpufreq/cpufreq_governor.c     |    3 +++
 drivers/cpufreq/cpufreq_governor.h     |    1 +
 3 files changed, 16 insertions(+)

--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -313,6 +313,17 @@ static void cs_start(struct cpufreq_poli
 	dbs_info->requested_freq = policy->cur;
 }
 
+static void cs_limits(struct cpufreq_policy *policy)
+{
+	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
+
+	/*
+	 * The limits have changed, so may have the current frequency. Reset
+	 * requested_freq to avoid any unintended outcomes due to the mismatch.
+	 */
+	dbs_info->requested_freq = policy->cur;
+}
+
 static struct dbs_governor cs_governor = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
 	.kobj_type = { .default_groups = cs_groups },
@@ -322,6 +333,7 @@ static struct dbs_governor cs_governor =
 	.init = cs_init,
 	.exit = cs_exit,
 	.start = cs_start,
+	.limits = cs_limits,
 };
 
 #define CPU_FREQ_GOV_CONSERVATIVE	(cs_governor.gov)
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -563,6 +563,7 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_s
 
 void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 {
+	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs;
 
 	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
@@ -574,6 +575,8 @@ void cpufreq_dbs_governor_limits(struct
 	mutex_lock(&policy_dbs->update_mutex);
 	cpufreq_policy_apply_limits(policy);
 	gov_update_sample_delay(policy_dbs, 0);
+	if (gov->limits)
+		gov->limits(policy);
 	mutex_unlock(&policy_dbs->update_mutex);
 
 out:
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -138,6 +138,7 @@ struct dbs_governor {
 	int (*init)(struct dbs_data *dbs_data);
 	void (*exit)(struct dbs_data *dbs_data);
 	void (*start)(struct cpufreq_policy *policy);
+	void (*limits)(struct cpufreq_policy *policy);
 };
 
 static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)



