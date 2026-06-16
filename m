Return-Path: <stable+bounces-266552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qGIAFkugMWpcogUAu9opvQ
	(envelope-from <stable+bounces-266552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:13:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D9694DE9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:13:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=G0qVAuEu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266552-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266552-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC6F73082C15
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA493DE422;
	Tue, 16 Jun 2026 19:09:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618D34751B;
	Tue, 16 Jun 2026 19:09:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636982; cv=none; b=UKVzPcTXcQePvrRFF6JMegadBmHrfzjFA4NfjB+b/NiuBiduosUKTMDuEJ2D8ZWihMtnAPxk/6atKYcxPDuke2/6Z3Z35l6HLnaSvyrrNDvCySS1XLnX6IlgtvQYTZT0Kvk+yZdh1Jurz7XylpQkp9uEduh7KmRBJ5odEHG1KtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636982; c=relaxed/simple;
	bh=PO7p62PbTmlTpAPLkOGSUa4yb7DtKByUHQc+ZnQCQBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFUPsZ2Swwt7i7p3vjpDXWihQGda7oqRKLA3RpaoouxPNbD7JNOtKTu+jMSMmYuSR30HG/G7EqnB+sh/HZMv3nlX46ebCl6nQmc/KUAcWcWbuchEkoOsRnrgsaazFYErJ/ykWuSVmC2mTDyA70A92ILyxU9E4AjO44OsmWpPJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0qVAuEu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0995C1F000E9;
	Tue, 16 Jun 2026 19:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636980;
	bh=pknKpH47+hbQGgl5w9OQ1UjGNok01MzfRXMpgrrptWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G0qVAuEuYNewCmqZ65dbg5vsbn+kmyUIhzmdpc4hXjmTAmufJOU/L93+ds8Om8WA9
	 aX3Mhw/7NSBJ/cHnxS65YsaRv0Wya1uM4O3xACQO+jL47kATVLdjuK9kRfbd5tZk71
	 pNTtVL0QJUDnclk4JsFIZjz9/BdPAP75jw7l/MrY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Ben Hutchings <benh@debian.org>
Subject: [PATCH 5.10 342/342] x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3 init function
Date: Tue, 16 Jun 2026 20:30:38 +0530
Message-ID: <20260616145104.591363763@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266552-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bp@alien8.de,m:nik.borisov@suse.com,m:benh@debian.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alien8.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC1D9694DE9

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

commit affc66cb96f865b3763a8e18add52e133d864f04 upstream.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-4-bp@alien8.de
Stable-dep-of: 7c81ad8e8bc2 ("x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()")
[bwh: Adjusted to apply after backports of the above commit which actually
 depended on this]
Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1138,14 +1138,6 @@ static void init_amd_zen1(struct cpuinfo
 		/* Erratum 1076: CPB feature bit not being set in CPUID. */
 		if (!cpu_has(c, X86_FEATURE_CPB))
 			set_cpu_cap(c, X86_FEATURE_CPB);
-
-		/*
-		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
-		 * Branch Type Confusion, but predate the allocation of the
-		 * BTC_NO bit.
-		 */
-		if (c->x86 == 0x19 && !cpu_has(c, X86_FEATURE_BTC_NO))
-			set_cpu_cap(c, X86_FEATURE_BTC_NO);
 	}
 
 	pr_notice_once("AMD Zen1 FPDSS bug detected, enabling mitigation.\n");
@@ -1205,6 +1197,16 @@ static void init_amd_zen2(struct cpuinfo
 static void init_amd_zen3(struct cpuinfo_x86 *c)
 {
 	init_amd_zen_common();
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
+		/*
+		 * Zen3 (Fam19 model < 0x10) parts are not susceptible to
+		 * Branch Type Confusion, but predate the allocation of the
+		 * BTC_NO bit.
+		 */
+		if (!cpu_has(c, X86_FEATURE_BTC_NO))
+			set_cpu_cap(c, X86_FEATURE_BTC_NO);
+	}
 }
 
 static void init_amd_zen4(struct cpuinfo_x86 *c)



