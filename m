Return-Path: <stable+bounces-240250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AakIqf352kVDgIAu9opvQ
	(envelope-from <stable+bounces-240250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:18:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A79D440191
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DE92306F307
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981053A5E71;
	Tue, 21 Apr 2026 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4HroXwv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMtb/ane"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAE26B2DA;
	Tue, 21 Apr 2026 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809812; cv=none; b=a+gAfrbLMxiQNp5e4soBUFt7L0feznEVzqbanEUpr54OLj6u5DU+xNBgEnkXu4Io+VA0n4ulXohhitMUlQXCi8DtZhtADNftI4eTuAmTjjcjdGklqjPvXXcKzwq84I/6bflHmRAflwQKyORHZMcxydBc3LoBHG6spYWW6uzVl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809812; c=relaxed/simple;
	bh=MO7LT3Wd4wCUZsRnxW9Th1ZlQ2STgxaOkMEhqlVI3bk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X+Pc0uQgpqee1DfSwsegrQm3Az/Z+zR04zZn5Je/HM8YQaRC5WnSrk8Y8sEA133y3WTT+2Gj8yuTFsuKbZDczDRte2W3wnVxFoKczUi39o0x1qCOzSNrASbcYNhaUpSWGc5+sGNyn9mxc9hx8lVxN6ld6ceQZ3qAUQQcj1xukgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4HroXwv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMtb/ane; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Apr 2026 22:16:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776809801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtUGH/+F659qA4GJAIiHYLMKbFHz4mce1PxHhKljapI=;
	b=E4HroXwvNWxO14AmtiNsLEoTbIj+eOu/CbSry5j1nCbItKDBNgVhWDGTv6K6MzBiL0KoTs
	AaKkDo01Xas2M2AH2mBL+MmVJTpcxeq3Ehjtq56Eo21CndaGqjW4VzGj0o2bzJoCtZQdZI
	9dq5heGd2bvYAFV6/+EZcCfKZ9giYdeqqJlUOd/QXIwLoq2w52TDClaZ51jGhL1yZm3pbf
	VWz3Ta+5WAIUPkXn7jQ/0jvyPUOCzE4UoreVb/d7REFGGJ6ESV7Yw616f5G+REgLTVsazv
	yoR1PRg7WX7HN8aVQXD1uTavgZ0YJpQvTvpiLglc8hpLRleZze0dsbBbpT/drw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776809801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtUGH/+F659qA4GJAIiHYLMKbFHz4mce1PxHhKljapI=;
	b=DMtb/aneQn45WkmsgLMiHzaYKj2+2OXAMojYcWLNIMmadstApLNYMIBkWUOnH04XoljB0S
	KdH+2gjMo4AhFfBw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Disable FRED when PTI is forced on
Cc: Gayatri Kammela <Gayatri.Kammela@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
References: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177680980021.2419917.7984257856496493958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240250-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto,intel.com:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: 2A79D440191
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     932d922285ef4d0d655a6f5def2779ae86ca0d73
Gitweb:        https://git.kernel.org/tip/932d922285ef4d0d655a6f5def2779ae86c=
a0d73
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 21 Apr 2026 09:31:36 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 21 Apr 2026 15:11:40 -07:00

x86/cpu: Disable FRED when PTI is forced on

FRED and PTI were never intended to work together. No FRED hardware is
vulnerable to Meltdown and all of it should have LASS anyway.
Nevertheless, if you boot a system with pti=3Don and fred=3Don, the kernel
tries to do what is asked of it and dies a horrible death on the first
attempt to run userspace (since it never switches to the user page
tables).

Disable FRED when PTI is forced on, and print a warning about it.

A quick brain dump about what a FRED+PTI implementation would look like
is below. I'm not sure it would make any sense to do it, but never say
never. All I know is that it's way too complicated to be worth it today.

<brain dump>
The SWITCH_TO_USER/KERNEL_CR3 bits are simple to fix (or at least we
have the assembly tools to do it already), as is sticking the FRED entry
text in .entry.text (it's not in there today).

The nasty part is the stacks. Today, the CPU pops into the kernel on
MSR_IA32_FRED_RSP0 which is normal old kernel memory and not mapped to
userspace. The hardware pushes gunk on to MSR_IA32_FRED_RSP0, which is
currently the task stacks. MSR_IA32_FRED_RSP0 would need to point
elsewhere, probably cpu_entry_stack(). Then, start playing games with
stacks on entry/exit, including copying gunk to and from the task stack.

While I'd *like* to have PTI everywhere, I'm not sure it's worth mucking
up the FRED code with PTI kludges. If a user wants fast entry/exit, they
use FRED. If you want PTI (and sekuritay), you certainly don't care
about fast entry and FRED isn't going to help you *all* that much, so
you can just stay with the IDT.

Plus, FRED hardware should have LASS which gives you a similar security
profile to PTI without the CR3 munging.
</brain dump>

Reported-by: Gayatri Kammela <Gayatri.Kammela@amd.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260421163136.E7C6788A@davehans-spike.ostc.in=
tel.com
---
 arch/x86/mm/pti.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index f7546e9..631f037 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -105,6 +105,11 @@ void __init pti_check_boottime_disable(void)
 		pr_debug("PTI enabled, disabling INVLPGB\n");
 		setup_clear_cpu_cap(X86_FEATURE_INVLPGB);
 	}
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		pr_debug("PTI enabled, disabling FRED\n");
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+	}
 }
=20
 static int __init pti_parse_cmdline(char *arg)

