Return-Path: <stable+bounces-252143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HDTDoT3DWpd5AUAu9opvQ
	(envelope-from <stable+bounces-252143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:03:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD24F595318
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85228305AF0B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ADD3FC5AE;
	Wed, 20 May 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEl8R9No"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC63FCB1E;
	Wed, 20 May 2026 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299905; cv=none; b=iot5tO+SC561tPZ0tR8CyuUpNZSFQIWJVYOUpiNvs9YbRmkRZfVLMbjEHIrqaJC0oNxPMQ1zGr9XPCUcpdWkS+pWHGEFqPpBcjMlLhMEb03ttZXrEri5G7yRfxVE3i73t7+mhj9OWS4ulD1Yah3X4Am/3+yCNoATw4tTzPLV04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299905; c=relaxed/simple;
	bh=Kv3HkD4XNO+7eUuVdEjpFoqOfVbdXWx6nO34BV8jUS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMNTrPDdTQeCrCVef8jYev4wZGj1LqwTIBJqRvIqnHz8kevzqmxKx4OKk5CteY4vYZ5dy8SXFs4/tGqm3E0AH0RhEbfmpNni5fd3FlJzbQE2DnUC0UWHWYsr9p/sTsMR3d7K35/+m2QBkC/KAD3u+yhueFqhFBhyvp5BCrB/vOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEl8R9No; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92AE1F00896;
	Wed, 20 May 2026 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299902;
	bh=5sFGp3DZGhwEzMaQPXc4t5V1/Ty5XwehKCe5ircoMtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kEl8R9NoTUWZcDmB1sNRmhj82Lp/2l3wfESB7HGQEot2sGz8PQshGJIcZp5gCh76L
	 gwKR2boTLpPxzRjbcB6j2XuDkcknOVX8g5FI3KLavzdMef+JNMS7Ke1tRe6X6OFBYk
	 J+ht/s6HZ0+s6NjbGUOzCuy3bD5EkDjOWAYNZD+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kim Phillips <kim.phillips@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.18 888/957] Revert "ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"
Date: Wed, 20 May 2026 18:22:51 +0200
Message-ID: <20260520162153.827187278@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252143-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: AD24F595318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit db5dadb562cabb6da49959b473ed0d9645b6f2da upstream.

Some older systems don't support CPPC in the firmware and this just makes
noise for them when booting.  Drop back to debug.

This reverts commit 21fb59ab4b9767085f4fe1edbdbe3177fbb9ec97.

Fixes: 21fb59ab4b976 ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn")
Suggested-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260504230141.484743-2-mario.limonciello@amd.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/acpi/cppc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -88,19 +88,19 @@ static void amd_set_max_freq_ratio(void)
 
 	rc = cppc_get_perf_caps(0, &perf_caps);
 	if (rc) {
-		pr_warn("Could not retrieve perf counters (%d)\n", rc);
+		pr_debug("Could not retrieve perf counters (%d)\n", rc);
 		return;
 	}
 
 	rc = amd_get_boost_ratio_numerator(0, &numerator);
 	if (rc) {
-		pr_warn("Could not retrieve highest performance (%d)\n", rc);
+		pr_debug("Could not retrieve highest performance (%d)\n", rc);
 		return;
 	}
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (!nominal_perf) {
-		pr_warn("Could not retrieve nominal performance\n");
+		pr_debug("Could not retrieve nominal performance\n");
 		return;
 	}
 



