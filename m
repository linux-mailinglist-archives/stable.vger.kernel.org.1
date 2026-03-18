Return-Path: <stable+bounces-227139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEEODTX1ummVdQIAu9opvQ
	(envelope-from <stable+bounces-227139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:55:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CDB2C1AAD
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE26304C947
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E6670830;
	Wed, 18 Mar 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ra4H/XW4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gTv5yeWb"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8212E03EA;
	Wed, 18 Mar 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859876; cv=none; b=OomUuuc4qMhziOT3uFFbx+ImbsMMdcWe+z+zPWxTVKToL8fNaNQ4XCtGftO3tgcoIgA83cKGEl6WKrZR9auclRRDCXkYAkOgFsJlrzx9/JYyx9sv1dfHnB/gfC1t3fdrxj/Hvuxb5+kTa57in5mNfTV7/Cv8yot9l/ppRQomB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859876; c=relaxed/simple;
	bh=j2ebi3UGBbz773wElReawGaSx37lFKvFPj2MYzzQfRY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JTmWzPQD+c2YDIFdrf/kLqzvmkFBMqNx1ATS223eXnoh5y1NWOEccout4AARCH2mYUV6oaBU3NbtwxmP/bYTEp+hB0Q9DodCjoL2cx65Tea5a74wxenQ3zBkFuV03pyf6UloFFm7dn+MwXxNLB/KbouTJHHBAcWurs39z9bGSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ra4H/XW4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gTv5yeWb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Mar 2026 18:51:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773859872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZzJvldoPN7rXoKePLq1/hZdEIUeq4H9TxGC0De+zoE=;
	b=Ra4H/XW4Tb5C+BAaq1liD3XhA4nL00P7EDJxTsYyEnZSAXO5f4mDkL/z6wfAQjRJNA4aPp
	jaDbkYBplmB/Wwv5eT53CAxLieV3u37LgMLMuoJC//JZvukEQfNDqJZb8UZBn9cN7mFH02
	l3lpssW+A7ibg1JkFj30XwFx9bIn+URWY6/jXjpq7mMFbzlMCrE+ZSMMtehFNbSk/5JHT2
	uREx4dGKxyMvu4LfDKl6e7uOJ/keKrZVSkHzirbJc5yhqyIZBgt8xnc5AUnD6YLGC8iROv
	2L2HoKW+cL1o0yj41FR/g8l43/ronOUS8HupCX7DE4XO0NN8Hv6OajdvnJV8NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773859872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZzJvldoPN7rXoKePLq1/hZdEIUeq4H9TxGC0De+zoE=;
	b=gTv5yeWbK+qVrT1wYuaog9oKHd4rY26aXNCKpLT+Osc02AOOFndTFYIfCA0vkgTcOcGMRu
	XmEfg85+s7v3SQDg==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Disable CR pinning during CPU bringup
Cc: Nikunj A Dadhania <nikunj@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.9+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260318075654.1792916-3-nikunj@amd.com>
References: <20260318075654.1792916-3-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177385987098.1647592.3381141860481415647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227139-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,msgid.link:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto,alien8.de:email,amd.com:email]
X-Rspamd-Queue-Id: A9CDB2C1AAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cccc0c8ff0a9849378dcbc1d2ee6ca8018740aab
Gitweb:        https://git.kernel.org/tip/cccc0c8ff0a9849378dcbc1d2ee6ca80187=
40aab
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 18 Mar 2026 07:56:53=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Mar 2026 16:40:54 +01:00

x86/cpu: Disable CR pinning during CPU bringup

=3D=3D CR Pinning Background =3D=3D

Modern CPU hardening features like SMAP/SMEP are enabled by flipping control
register (CR) bits. Attackers find these features inconvenient and often try
to disable them.

CR-pinning is a kernel hardening feature that detects when security-sensitive
control bits are flipped off, complains about it, then turns them back on. The
CR-pinning checks are performed in the CR manipulation helpers.

X86_CR4_FRED controls FRED enabling and is pinned. There is a single,
system-wide static key that controls CR-pinning behavior. The static key is
enabled by the boot CPU after it has established its CR configuration.

The end result is that CR-pinning is not active while initializing the boot
CPU but it is active while bringing up secondary CPUs.

=3D=3D FRED Background =3D=3D

FRED is a new hardware entry/exit feature for the kernel. It is not on by
default and started out as Intel-only. AMD is just adding support now.

FRED has MSRs for configuration and is enabled by the pinned X86_CR4_FRED
bit. It should not be enabled until after MSRs are properly initialized.

=3D=3D SEV Background =3D=3D

AMD SEV-ES and SEV-SNP use #VC (Virtualization Communication) exceptions to
handle operations that require hypervisor assistance. These exceptions
occur during various operations including MMIO access, CPUID instructions,
and certain memory accesses.

Writes to the console can generate #VC.

=3D=3D Problem =3D=3D

CR-pinning implicitly enables FRED on secondary CPUs at a different point
than the boot CPU. This point is *before* the CPU has done an explicit
cr4_set_bits(X86_CR4_FRED) and before the MSRs are initialized. This means
that there is a window where no exceptions can be handled.

For SEV-ES/SNP and TDX guests, any console output during this window
triggers #VC or #VE exceptions that result in triple faults because the
exception handlers rely on FRED MSRs that aren't yet configured.

=3D=3D Fix =3D=3D

Defer CR-pinning enforcement during secondary CPU bringup. This avoids any
implicit CR changes during CPU bringup, ensuring that FRED is not enabled
before it is configured and able to handle a #VC or #VE.

Drop CR4 pinning logic from cr4_init() as it runs only during early
secondary bring up while the CPU is still offline, so CR4 pinning is never
in effect there. Remove the redundant pinned-mask application and add
WARN_ON_ONCE() to detect any future changes that might violate this
assumption.

This also aligns boot and secondary CPU bringup.

Note: FRED is not on by default anywhere so this is not likely to be
causing many problems. The only reason this was noticed was that AMD
started to enable FRED and was turning it on.

  [ Nikunj: Updated SEV background section wording ]

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: stable@vger.kernel.org # 6.9+
Link: https://patch.msgid.link/20260318075654.1792916-3-nikunj@amd.com
---
 arch/x86/kernel/cpu/common.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7840b22..dbd7bce 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -437,6 +437,21 @@ static const unsigned long cr4_pinned_mask =3D X86_CR4_S=
MEP | X86_CR4_SMAP | X86_C
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
=20
+static bool cr_pinning_enabled(void)
+{
+	if (!static_branch_likely(&cr_pinning))
+		return false;
+
+	/*
+	 * Do not enforce pinning during CPU bringup. It might
+	 * turn on features that are not set up yet, like FRED.
+	 */
+	if (!cpu_online(smp_processor_id()))
+		return false;
+
+	return true;
+}
+
 void native_write_cr0(unsigned long val)
 {
 	unsigned long bits_missing =3D 0;
@@ -444,7 +459,7 @@ void native_write_cr0(unsigned long val)
 set_register:
 	asm volatile("mov %0,%%cr0": "+r" (val) : : "memory");
=20
-	if (static_branch_likely(&cr_pinning)) {
+	if (cr_pinning_enabled()) {
 		if (unlikely((val & X86_CR0_WP) !=3D X86_CR0_WP)) {
 			bits_missing =3D X86_CR0_WP;
 			val |=3D bits_missing;
@@ -463,7 +478,7 @@ void __no_profile native_write_cr4(unsigned long val)
 set_register:
 	asm volatile("mov %0,%%cr4": "+r" (val) : : "memory");
=20
-	if (static_branch_likely(&cr_pinning)) {
+	if (cr_pinning_enabled()) {
 		if (unlikely((val & cr4_pinned_mask) !=3D cr4_pinned_bits)) {
 			bits_changed =3D (val & cr4_pinned_mask) ^ cr4_pinned_bits;
 			val =3D (val & ~cr4_pinned_mask) | cr4_pinned_bits;
@@ -505,8 +520,8 @@ void cr4_init(void)
=20
 	if (boot_cpu_has(X86_FEATURE_PCID))
 		cr4 |=3D X86_CR4_PCIDE;
-	if (static_branch_likely(&cr_pinning))
-		cr4 =3D (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
+
+	WARN_ON_ONCE(cr_pinning_enabled());
=20
 	__write_cr4(cr4);
=20

