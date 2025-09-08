Return-Path: <stable+bounces-178913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BEDB49013
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 15:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB9C164ADA
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DDC2FF153;
	Mon,  8 Sep 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lKfMG8a1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QfCzh9S6"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1C1E5B64;
	Mon,  8 Sep 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339281; cv=none; b=kjXltj6CESE7DJrx54L1I6kYJth1JEUcthO6Vp2kv9hg8ymiE9vB6NEVOmHyLqhR1XaAMI8W7Meo/aqbc9mE3FObJiqEmoXCAlJ0VUXCDZPUbCOf2fOlkIU24qmBMbeH8CU5z7QpNthYC0MV6zFAG994cB0W1dtBAv4k9/pMXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339281; c=relaxed/simple;
	bh=U7IqCyU23/VAExA6N48clU4WBs9N/sB4w7Za04VZNv8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=V7YqyAqc1PlxokpPhSwjQfM17aWoh6QL70zB1mwT635pb51gvLupuxRHdWwQ54gWY4wJBIH3SQtKSuIW0lSDEJcLQikOwrdUUFD9V5a6HmpPy0fx2k811ZGuBezRny5LD3gzt5NY1wOCSTZ3zGKySJSN771s5MV7X7eubZdNGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lKfMG8a1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QfCzh9S6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Sep 2025 13:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757339275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ennO6DFYiDanYyZ3yCUIBSy72hcmz7WE43LpKjrUOaw=;
	b=lKfMG8a1wxV4KTljJ1mN4jvE2y2uxQ1/SlaYIcXr/jay24X7IbEBkeGZ5YZlw6a98msKbc
	gdoKEuZD4uh1TcqUSM8oaSPjT7W+D7zRoRPHhiBKGkg/23yvICxXP4Yg7ft2KajcStnrXn
	wqHuVHPcD/Hc6AIW33N3gH+c0V1CtRC9cyUpYlKC5Wl9tWDVSLeN9/D2oHHydAcZTUM+qm
	LGAqXZl9c/odAl9iqjgnIvuFM0ecH2IJnyz9bt1KH/k/Q4VXOyzj8Zn/tJxuoLp53VPWcD
	TO3TK+7wqCJlmBjDHhSzK6v6AtYNEOpS6FSE2ZPtMavFOj3ZlsNmuZA/W2Bjcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757339275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ennO6DFYiDanYyZ3yCUIBSy72hcmz7WE43LpKjrUOaw=;
	b=QfCzh9S6U09MmOfDi4r+70DSf5ts4xwip3VMagy9KM3IKnwTCB3SL7sdYPnl+nXuTzTULi
	I6Ih7itNDNQ/lnCQ==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/topology: Always try
 cpu_parse_topology_ext() on AMD/Hygon
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, Only@tip-bot2.tec.linutronix.de,
	v6.9@tip-bot2.tec.linutronix.de, and@tip-bot2.tec.linutronix.de,
	above@tip-bot2.tec.linutronix.de;,
	depends@tip-bot2.tec.linutronix.de, on@tip-bot2.tec.linutronix.de,
	x86@tip-bot2.tec.linutronix.de, topology@tip-bot2.tec.linutronix.de,
	rewrite@tip-bot2.tec.linutronix.de, x86@kernel.org,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175733927167.1920.13029463870144392599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cba4262a19afae21665ee242b3404bcede5a94d7
Gitweb:        https://git.kernel.org/tip/cba4262a19afae21665ee242b3404bcede5=
a94d7
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 01 Sep 2025 17:04:15=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 Sep 2025 11:37:49 +02:00

x86/cpu/topology: Always try cpu_parse_topology_ext() on AMD/Hygon

Support for parsing the topology on AMD/Hygon processors using CPUID leaf 0xb
was added in

  3986a0a805e6 ("x86/CPU/AMD: Derive CPU topology from CPUID function 0xB whe=
n available").

In an effort to keep all the topology parsing bits in one place, this commit
also introduced a pseudo dependency on the TOPOEXT feature to parse the CPUID
leaf 0xb.

The TOPOEXT feature (CPUID 0x80000001 ECX[22]) advertises the support for
Cache Properties leaf 0x8000001d and the CPUID leaf 0x8000001e EAX for
"Extended APIC ID" however support for 0xb was introduced alongside the x2APIC
support not only on AMD [1], but also historically on x86 [2].

Similar to 0xb, the support for extended CPU topology leaf 0x80000026 too does
not depend on the TOPOEXT feature.

The support for these leaves is expected to be confirmed by ensuring

  leaf <=3D {extended_}cpuid_level

and then parsing the level 0 of the respective leaf to confirm EBX[15:0]
(LogProcAtThisLevel) is non-zero as stated in the definition of
"CPUID_Fn0000000B_EAX_x00 [Extended Topology Enumeration]
(Core::X86::Cpuid::ExtTopEnumEax0)" in Processor Programming Reference (PPR)
for AMD Family 19h Model 01h Rev B1 Vol1 [3] Sec. 2.1.15.1 "CPUID Instruction
Functions".

This has not been a problem on baremetal platforms since support for TOPOEXT
(Fam 0x15 and later) predates the support for CPUID leaf 0xb (Fam 0x17[Zen2]
and later), however, for AMD guests on QEMU, the "x2apic" feature can be
enabled independent of the "topoext" feature where QEMU expects topology and
the initial APICID to be parsed using the CPUID leaf 0xb (especially when
number of cores > 255) which is populated independent of the "topoext" feature
flag.

Unconditionally call cpu_parse_topology_ext() on AMD and Hygon processors to
first parse the topology using the XTOPOLOGY leaves (0x80000026 / 0xb) before
using the TOPOEXT leaf (0x8000001e).

While at it, break down the single large comment in parse_topology_amd() to
better highlight the purpose of each CPUID leaf.

Fixes: 3986a0a805e6 ("x86/CPU/AMD: Derive CPU topology from CPUID function 0x=
B when available")
Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org # Only v6.9 and above; depends on x86 topology rew=
rite
Link: https://lore.kernel.org/lkml/1529686927-7665-1-git-send-email-suravee.s=
uthikulpanit@amd.com/ [1]
Link: https://lore.kernel.org/lkml/20080818181435.523309000@linux-os.sc.intel=
.com/ [2]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537 [3]
---
 arch/x86/kernel/cpu/topology_amd.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topolog=
y_amd.c
index 827dd0d..c79ebbb 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -175,27 +175,30 @@ static void topoext_fixup(struct topo_scan *tscan)
=20
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	bool has_topoext =3D false;
-
 	/*
-	 * If the extended topology leaf 0x8000_001e is available
-	 * try to get SMT, CORE, TILE, and DIE shifts from extended
+	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
 	 * CPUID leaf 0x8000_0026 on supported processors first. If
 	 * extended CPUID leaf 0x8000_0026 is not supported, try to
-	 * get SMT and CORE shift from leaf 0xb first, then try to
-	 * get the CORE shift from leaf 0x8000_0008.
+	 * get SMT and CORE shift from leaf 0xb. If either leaf is
+	 * available, cpu_parse_topology_ext() will return true.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
-		has_topoext =3D cpu_parse_topology_ext(tscan);
+	bool has_xtopology =3D cpu_parse_topology_ext(tscan);
=20
 	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
 		tscan->c->topo.cpu_type =3D cpuid_ebx(0x80000026);
=20
-	if (!has_topoext && !parse_8000_0008(tscan))
+	/*
+	 * If XTOPOLOGY leaves (0x26/0xb) are not available, try to
+	 * get the CORE shift from leaf 0x8000_0008 first.
+	 */
+	if (!has_xtopology && !parse_8000_0008(tscan))
 		return;
=20
-	/* Prefer leaf 0x8000001e if available */
-	if (parse_8000_001e(tscan, has_topoext))
+	/*
+	 * Prefer leaf 0x8000001e if available to get the SMT shift and
+	 * the initial APIC ID if XTOPOLOGY leaves are not available.
+	 */
+	if (parse_8000_001e(tscan, has_xtopology))
 		return;
=20
 	/* Try the NODEID MSR */

