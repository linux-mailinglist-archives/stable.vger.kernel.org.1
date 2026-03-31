Return-Path: <stable+bounces-231851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHNIDZn8y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:55:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC836D6FB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6B20329EA49
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2A2425CEF;
	Tue, 31 Mar 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i9FWg/Vi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D776423A7C;
	Tue, 31 Mar 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975234; cv=none; b=Z/SCplsTaKMTfLqoEKUv2YlsZKw2bN+Yc+UNZn466eULSxOL7nnX3aH8oAmEqxCsag4ekmoS1SahaC4OXPkpqdhEZS0Q1CtjO9H9QQ2FV3BsrScf3JLYgzaw1w+lsaTX0z0QOKZFo3tDDNNaR6qSWvMLmb0M5MipfU5eJ8aA6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975234; c=relaxed/simple;
	bh=uW6r8if7xZ29/Qwg3OUdgVHvwlASKBGyaeiJ8sinMxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPsA+T5+O6Wn9FXtlDwvT4Iq50Jt83WrUC8RxFJcfvX9nQf+ECW4D9TyINMZQ2LwdVi3UwIxAZlWgijAtxkdamd2NDTMoiCWuyfzv7OAAo+08dS4SIJ2V/f1yc9XE5xITwDH5sKlLdzRfcEOsI1Kp7wRkQywhv9fOBR9r3xQZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9FWg/Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FEFC19423;
	Tue, 31 Mar 2026 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975234;
	bh=uW6r8if7xZ29/Qwg3OUdgVHvwlASKBGyaeiJ8sinMxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9FWg/Vid3C5uLARfu0onRdw4BcC6ISLYwoOwFGQewkcCkmOfR2uAc2CSe3IJdZqQ
	 7Sbchl6PKvH7czrSkg5dZln1kGK9B2NwAbaivdwuCjHHoyEQrIa2Up5vXeQ/b9g/un
	 /44eJTQKLHpsqgkSQHYIcwqzdmWMvW7zZfnnD/7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.19 215/342] cpufreq: Dont skip cpufreq_frequency_table_cpuinfo()
Date: Tue, 31 Mar 2026 18:20:48 +0200
Message-ID: <20260331161806.889242832@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231851-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linaro.org:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 8DCC836D6FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 8f13c0c6cb75cc4421d5a60fc060e9e6fd9d1097 upstream.

The commit 6db0f533d320 ("cpufreq: preserve freq_table_sorted
across suspend/hibernate") unintentionally made a change where
cpufreq_frequency_table_cpuinfo() isn't getting called anymore
for old policies getting re-initialized.

This leads to potentially invalid values of policy->max and
policy->cpuinfo_max_freq.

Fix the issue by reverting the original commit and adding the condition
for just the sorting function.

Fixes: 6db0f533d320 ("cpufreq: preserve freq_table_sorted across suspend/hibernate")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 6.19+ <stable@vger.kernel.org> # 6.19+
Link: https://patch.msgid.link/65ba5c45749267c82e8a87af3dc788b37a0b3f48.1773998611.git.viresh.kumar@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq.c    |    9 +++------
 drivers/cpufreq/freq_table.c |    4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1421,12 +1421,9 @@ static int cpufreq_policy_online(struct
 		 * If there is a problem with its frequency table, take it
 		 * offline and drop it.
 		 */
-		if (policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_ASCENDING &&
-		    policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_DESCENDING) {
-			ret = cpufreq_table_validate_and_sort(policy);
-			if (ret)
-				goto out_offline_policy;
-		}
+		ret = cpufreq_table_validate_and_sort(policy);
+		if (ret)
+			goto out_offline_policy;
 
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -360,6 +360,10 @@ int cpufreq_table_validate_and_sort(stru
 	if (policy_has_boost_freq(policy))
 		policy->boost_supported = true;
 
+	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING ||
+	    policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_DESCENDING)
+		return 0;
+
 	return set_freq_table_sorted(policy);
 }
 



