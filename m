Return-Path: <stable+bounces-176492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B03FCB37FF4
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 12:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DE1D4E19DD
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8E27605A;
	Wed, 27 Aug 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O9Qgak1A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UMqebvip"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9472610;
	Wed, 27 Aug 2025 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290866; cv=none; b=bh2R5phUsUm18FPa5AXTHGcQFWoTjYpz7TT58poMJF9gPf0W2TxPvH6/+hiLbhSeS6xv398hIViS7XAOu/iUIBnrNXU4jKJaQz/1R17SUKsp/6WZllBeTG6898RUTxIHMFS6laB/OHkOoAIsQT4MRdeJ2PrlvGQYCi7Ed3ijCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290866; c=relaxed/simple;
	bh=eCS5hfcdjbm9MfUiUc4bZbE/VT9m5NWcWjRKXD0X2sc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sXxmlQNTf9fZk/SViiI9Z1cNVtRF3wzt0foWjrW0FviwT6o9LLBsFWUTr0dpsEdgo1kez3GE5TQKGC1SCHe9cPN6bSY9RrqH1x6QigXNkb1clw0ikPQD6rvd+5myVfbeX2gZ6rXzMeaiN5qYEac7OWRBX22mamobHPWhbLRZqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O9Qgak1A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UMqebvip; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 10:34:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756290862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvnPT4kzFsPVxOt5kvlxt5NOPOn31/A8mkcFHiFNlVw=;
	b=O9Qgak1AVROpVDbGWi4x2Y6Mqx3w+vqYspv1MNlFVjA5hXKInfUSJ7kxWrtVBJjX2HpIls
	A4xMKbq439I3vfle6tTTvrbI/SMsFpGFTGD9NxZCeo4D7V4+O3Q2p5zt6fV8XC7WXEDQcI
	5bLGJcQNeCXpDYxlbpkhWH+Jc0arxmxGSpOqUUVdVu5etwmjxfmBp1pTYkSWMcJ88+H4Hr
	i2s2dIuO/d6XFotg2q6y7UqpuFFqjkPyE0S5ZH8xLFW+8fNNbdK2dl9sIIRDivhbxIK70g
	pPk6ickzkCV3HCs4jLJtNFmvOJBqbl70WUUBrngrqMem8boAN0M6lReGz5nBpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756290862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvnPT4kzFsPVxOt5kvlxt5NOPOn31/A8mkcFHiFNlVw=;
	b=UMqebvipgte7Z9VhwLX8/d9RR9qcat/37YtXGiAgeGRpLjRadx0JKlBXqH4OCUmJSIUVjy
	4nwOSGsb58O7SWDA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/topology: Use initial APIC ID from
 XTOPOLOGY leaf on AMD/HYGON
Cc: Thomas Gleixner <tglx@linutronix.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Naveen N Rao (AMD)" <naveen@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250825075732.10694-2-kprateek.nayak@amd.com>
References: <20250825075732.10694-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175629086019.1920.18385757222899714519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c2415c407a2cde01290d52ce2a1f81b0616379a3
Gitweb:        https://git.kernel.org/tip/c2415c407a2cde01290d52ce2a1f81b0616=
379a3
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 25 Aug 2025 07:57:29=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 27 Aug 2025 11:31:11 +02:00

x86/cpu/topology: Use initial APIC ID from XTOPOLOGY leaf on AMD/HYGON

Prior to the topology parsing rewrite and the switchover to the new parsing
logic for AMD processors in

  c749ce393b8f ("x86/cpu: Use common topology code for AMD"),

the initial_apicid on these platforms was:

- First initialized to the LocalApicId from CPUID leaf 0x1 EBX[31:24].

- Then overwritten by the ExtendedLocalApicId in CPUID leaf 0xb
  EDX[31:0] on processors that supported topoext.

With the new parsing flow introduced in

  f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser"),

parse_8000_001e() now unconditionally overwrites the initial_apicid already
parsed during cpu_parse_topology_ext().

Although this has not been a problem on baremetal platforms, on virtualized A=
MD
guests that feature more than 255 cores, QEMU zeros out the CPUID leaf
0x8000001e on CPUs with CoreID > 255 to prevent collision of these IDs in
EBX[7:0] which can only represent a maximum of 255 cores [1].

This results in the following FW_BUG being logged when booting a guest
with more than 255 cores:

    [Firmware Bug]: CPU 512: APIC ID mismatch. CPUID: 0x0000 APIC: 0x0200

AMD64 Architecture Programmer's Manual Volume 2: System Programming Pub.
24593 Rev. 3.42 [2] Section 16.12 "x2APIC_ID" mentions the Extended
Enumeration leaf 0xb (Fn0000_000B_EDX[31:0])(which was later superseded by the
extended leaf 0x80000026) provides the full x2APIC ID under all circumstances
unlike the one reported by CPUID leaf 0x8000001e EAX which depends on the mode
in which APIC is configured.

Rely on the APIC ID parsed during cpu_parse_topology_ext() from CPUID leaf
0x80000026 or 0xb and only use the APIC ID from leaf 0x8000001e if
cpu_parse_topology_ext() failed (has_topoext is false).

On platforms that support the 0xb leaf (Zen2 or later, AMD guests on
QEMU) or the extended leaf 0x80000026 (Zen4 or later), the
initial_apicid is now set to the value parsed from EDX[31:0].

On older AMD/Hygon platforms that do not support the 0xb leaf but support the
TOPOEXT extension (families 0x15, 0x16, 0x17[Zen1], and Hygon), retain current
behavior where the initial_apicid is set using the 0x8000001e leaf.

Issue debugged by Naveen N Rao (AMD) <naveen@kernel.org> and Sairaj Kodilkar
<sarunkod@amd.com>.

  [ bp: Massage commit message. ]

Fixes: c749ce393b8f ("x86/cpu: Use common topology code for AMD")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Cc: stable@vger.kernel.org
Link: https://github.com/qemu/qemu/commit/35ac5dfbcaa4b [1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537 [2]
Link: https://lore.kernel.org/20250825075732.10694-2-kprateek.nayak@amd.com
---
 arch/x86/kernel/cpu/topology_amd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topolog=
y_amd.c
index 843b165..827dd0d 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -81,20 +81,25 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool=
 has_topoext)
=20
 	cpuid_leaf(0x8000001e, &leaf);
=20
-	tscan->c->topo.initial_apicid =3D leaf.ext_apic_id;
-
 	/*
-	 * If leaf 0xb is available, then the domain shifts are set
-	 * already and nothing to do here. Only valid for family >=3D 0x17.
+	 * If leaf 0xb/0x26 is available, then the APIC ID and the domain
+	 * shifts are set already.
 	 */
-	if (!has_topoext && tscan->c->x86 >=3D 0x17) {
+	if (!has_topoext) {
+		tscan->c->topo.initial_apicid =3D leaf.ext_apic_id;
+
 		/*
-		 * Leaf 0x80000008 set the CORE domain shift already.
-		 * Update the SMT domain, but do not propagate it.
+		 * Leaf 0x8000008 sets the CORE domain shift but not the
+		 * SMT domain shift. On CPUs with family >=3D 0x17, there
+		 * might be hyperthreads.
 		 */
-		unsigned int nthreads =3D leaf.core_nthreads + 1;
+		if (tscan->c->x86 >=3D 0x17) {
+			/* Update the SMT domain, but do not propagate it. */
+			unsigned int nthreads =3D leaf.core_nthreads + 1;
=20
-		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nth=
reads);
+			topology_update_dom(tscan, TOPO_SMT_DOMAIN,
+					    get_count_order(nthreads), nthreads);
+		}
 	}
=20
 	store_node(tscan, leaf.nnodes_per_socket + 1, leaf.node_id);

