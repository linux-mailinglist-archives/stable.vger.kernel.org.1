Return-Path: <stable+bounces-261835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NNvEAnxPJWooGwIAu9opvQ
	(envelope-from <stable+bounces-261835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:01:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8DE6503AA
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:01:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=A+oi6x8B;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261835-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261835-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6944830008B7
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052B63815ED;
	Sun,  7 Jun 2026 11:00:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAFF352006;
	Sun,  7 Jun 2026 11:00:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830029; cv=none; b=tR2cFv6OM6MZsjFFw3PtGrDe9wiga32wg+Iw2AnfSyseVElPqwVcfofrctva3/SwdpyBshtefNdFpXRfSVd4q+u/Ql3zgHXrrcxnplCIDKe3LlllzvPBCQSqqmj23Dfv4+hF+8rf4JtXDutLH12LzgL7KY440IUHhg/ToOy9rWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830029; c=relaxed/simple;
	bh=lAEiFHNcrwkhyy9od+kvUpAO0IVknjQLGf4bEjhhAmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgStiATgjwFTdJiE/LKsE3HzGktcMGharNe/fEfK3K+kqQp4Rn2jGj02bsV+d03plyhamj7aesIbTSNLc2r56ELn/HCRrd5wEBbppA2apux1RaTw305skZsWFZnJXIq5rXIgTFLM44rOiKV/zFQutVKKZmxJjsPt8OVJHbdspaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A+oi6x8B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60CD1F00893;
	Sun,  7 Jun 2026 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780830028;
	bh=YyBnrCnVy44jDWTXEIlT8CQ1mJOtmdqhW5WaEPPmlgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+oi6x8B0RUH4Fh+7QrMAGEsd0Ej4nhlx56kl/yh3bGN3Pv/YYyp8d56DdnjOtxCx
	 W57JevCTat5vD1EASLJ1Luk24j9UjEmAZ5objY+uhvRqXzZEIIKQEaGp+GJIaihHSX
	 AJ/VDrSRQf1gAKZ+mbt6yqJeJzOVT7VbHR7RSQhM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henry Tseng <henrytseng@qnap.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 301/315] cpufreq: intel_pstate: Use correct scaling factor on Raptor Lake-E
Date: Sun,  7 Jun 2026 12:01:28 +0200
Message-ID: <20260607095738.655874108@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261835-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:henrytseng@qnap.com,m:rafael.j.wysocki@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,qnap.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF8DE6503AA

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 0e7c710478b3089cdfe8669347f77b163e836c4f ]

Raptor Lake-E has the same processor ID as Raptor Lake-S, so there is
an entry in intel_hybrid_scaling_factor[] for it.  It does not contain
E-cores though and hybrid_get_cpu_type() returns 0 for its P-cores, so
they get the default "core" scaling factor.  However, the original
Raptor Lake scaling factor for P-cores still needs to be used for
mapping the HWP performance levels of the P-cores in Raptor Lake-E to
frequency, as though they were part of a real hybrid system.

To address this, update hwp_get_cpu_scaling() to return
hybrid_scaling_factor, which is the P-core scaling factor
retrieved from intel_hybrid_scaling_factor[], for all CPUs
that are not enumerated as E-cores.

Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling factors")
Link: https://lore.kernel.org/all/20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com/
Reported-by: Henry Tseng <henrytseng@qnap.com>
Closes: https://lore.kernel.org/linux-pm/20260508063032.3248602-1-henrytseng@qnap.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/4523296.ejJDZkT8p0@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2308,7 +2308,7 @@ static int hwp_get_cpu_scaling(int cpu)
 		 * Return the hybrid scaling factor for P-cores and use the
 		 * default core scaling for E-cores.
 		 */
-		if (hybrid_get_cpu_type(cpu) == INTEL_CPU_TYPE_CORE)
+		if (hybrid_get_cpu_type(cpu) != INTEL_CPU_TYPE_ATOM)
 			return hybrid_scaling_factor;
 
 		return core_get_scaling();



