Return-Path: <stable+bounces-274360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIV0M6BPVmrd3AAAu9opvQ
	(envelope-from <stable+bounces-274360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:02:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E8756326
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:02:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=H6D6s+h2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274360-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274360-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB59030107DE
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4549253A;
	Tue, 14 Jul 2026 14:58:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133114921B9
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:58:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041111; cv=none; b=ulX68uD2xuL9fUBkGGo0RxD/dUvhrssVKfPMo3zDRq21SArTzjxp6GkihBtyb9Rk/f5ZKP29buIaLVEwBUMKBrSTdtRWY955T89xv8tvYd/64ebXGoEARN+RvkqJz/Y7dXbvVqg4bC73mZ7PaANSAhuhBmJQVC7RQvfBBn8P+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041111; c=relaxed/simple;
	bh=rRUQbV1u7ROsI4oFxi9q9g78GbIJRjhFARsZvYFodWI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aGjSuLFNaarsBJ4ohq6p+BzzbEXB/OxhstdLfUrn7vtowuCe9fudgWPFLzXkK+8Vrrvbv1qeicuRSjARFc65SezzoSWgT5aL1qGdFDn1ehO9V3dS7igfDE6S+XewB28/HKZzHkindrBeqmx2kreD2gcSZYbKvks7Wl4yyZCVZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6D6s+h2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932241F000E9;
	Tue, 14 Jul 2026 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784041107;
	bh=9sQl6kxnJN6x3oRTAjzQ7v29arl6WN7CP5R6WbziKqg=;
	h=Subject:To:Cc:From:Date;
	b=H6D6s+h2SSE4rbwZI50gDuUdNyFiWTe2D97AzgudRnGeFU6hv1VQduYtleL7uMeXD
	 8wZfD0Hp67gR1FPNXz5k+QTT8+cRWMVZ1KFEsOJQc3VPpuhe8GIQ2iXO94SMFfvr7E
	 FdYKjec4cMjwNFArxhAcjA4BB1INL26o3R93H71I=
Subject: FAILED: patch "[PATCH] cpufreq: intel_pstate: Sync policy->cur during CPU offline" failed to apply to 5.10-stable tree
To: wangfushuai@baidu.com,rafael.j.wysocki@intel.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:56:52 +0200
Message-ID: <2026071452-shimmer-reformer-0bc4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274360-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:wangfushuai@baidu.com,m:rafael.j.wysocki@intel.com,m:srinivas.pandruvada@linux.intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B18E8756326


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x bcbdaa1086c25a8a5d48e04e1b82fdfb0682b681
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071452-shimmer-reformer-0bc4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bcbdaa1086c25a8a5d48e04e1b82fdfb0682b681 Mon Sep 17 00:00:00 2001
From: Fushuai Wang <wangfushuai@baidu.com>
Date: Wed, 20 May 2026 11:21:19 +0800
Subject: [PATCH] cpufreq: intel_pstate: Sync policy->cur during CPU offline

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
[ rjw: Subject refinement ]
Link: https://patch.msgid.link/20260520032119.30615-1-fushuai.wang@linux.dev
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1f093e346430..0fbbdbd5765c 100644
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
 


