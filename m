Return-Path: <stable+bounces-265271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QXHIBqSFMWo+lgUAu9opvQ
	(envelope-from <stable+bounces-265271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:19:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A804E692FF0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:19:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CI7n5SLq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265271-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-265271-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9269301E553
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257141A6803;
	Tue, 16 Jun 2026 17:19:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9047AF65;
	Tue, 16 Jun 2026 17:19:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630355; cv=none; b=Svqb8ZT/eXuvo/dbqjmxhOJBchC5OQTzuvApyByFf54lcRP34ecLPluS0SEezG1uojNkql+ailGVUhKpYvbj/ncuhjQtUxMb5zlKfPCWHcAu3g1U58RIrjchkGSuR2ZVvHyT2Ji+mo/gjxol4fi1gAC5xulYEoN7Aj0AhdwPRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630355; c=relaxed/simple;
	bh=PBsQS6AQ1MPWTZQGe9a90NMrQWeCPT52ZpIiTxaHsE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcF9iSRgOP1nVxTrPY3wWRnRnJULqi+WJjXjRMTOXaUtS/MUdE/sOMeANjAleSW8crtaxoXzG5h64GHvBia2b4XUxcZMJKHRio1UaWHc4aOQrhPgtXSvtVsX3c5IJ+BaI9rsSozEx8ZDZMWzgOlHQK8mo0Ex8YbrRo0CxrBSQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CI7n5SLq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D953E1F000E9;
	Tue, 16 Jun 2026 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630354;
	bh=h59QY0Ln9Css3Szo+tQvJrwPEzxYOITLa9hJDab+mtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CI7n5SLq+3EotRfI7tFSBwSduIyymGwsjI68BxQuVAU/1RHsA889ery0i9UcIr4AF
	 fdS5HAkkFUCOlruUNAHTpLRGai+KaGZWMGMgDKVzqQzAF8AedQp9LoPek2mWgECWRj
	 44sS8cYlUmO5pUzPMxCDWX5/3Ee9ShcLRkNauJOU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.6 451/452] x86/CPU/AMD: Call the spectral chicken in the Zen2 init function
Date: Tue, 16 Jun 2026 20:31:18 +0530
Message-ID: <20260616145140.177192824@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265271-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bp@alien8.de,m:nik.borisov@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email,alien8.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A804E692FF0

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

commit cfbf4f992bfce1fa9f2f347a79cbbea0368e7971 upstream.

No functional change.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-6-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1060,10 +1060,8 @@ void init_spectral_chicken(struct cpuinf
 	 *
 	 * This suppresses speculation from the middle of a basic block, i.e. it
 	 * suppresses non-branch predictions.
-	 *
-	 * We use STIBP as a heuristic to filter out Zen2 from the rest of F17H
 	 */
-	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && cpu_has(c, X86_FEATURE_AMD_STIBP)) {
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		if (!rdmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, &value)) {
 			value |= MSR_ZEN2_SPECTRAL_CHICKEN_BIT;
 			wrmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, value);
@@ -1149,6 +1147,7 @@ static void zen2_zenbleed_check(struct c
 
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
+	init_spectral_chicken(c);
 	fix_erratum_1386(c);
 	zen2_zenbleed_check(c);
 
@@ -1213,7 +1212,7 @@ static void init_amd(struct cpuinfo_x86
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
 	case 0x16: init_amd_jg(c); break;
-	case 0x17: init_spectral_chicken(c);
+	case 0x17:
 		   fallthrough;
 	case 0x19: init_amd_zn(c); break;
 	}



