Return-Path: <stable+bounces-177273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25409B4044A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700AD548402
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D740031DD91;
	Tue,  2 Sep 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9CCMdfN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947FA31CA5F;
	Tue,  2 Sep 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820126; cv=none; b=hlL8kSswUvSt5nnQOtJ8VL2TDiEWIznyycwc6QJYJByFqwdVcC2KWEJu1M53jZVqSXg6DzOiArabP2zwoYLhF5czBUmgdSoDSnke5LABCswOQZM4rKbVPcaumB3lBWYsLRb758fg1qHA/ztP9jSZGJBa7HrEFW+yY3AOchYBC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820126; c=relaxed/simple;
	bh=Slg65ry9HcMSQV6qwLc8Vq4BkXV+5kY9vA6LdBInXNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQgA7fYQdJHfLRLjl7vxJPPI3+7yFgwIZvrbF5EColRQcIzgdlK4Ko95fFgHjEd76Kl9mpk8Y0fxDRARJjPAaqd8e43WEiM1Wib5fJzs7Ew9QguBukbt1DDm3DkkoIxRMESt9MQ5AYPXWxkrLkYSQNXLhWCszy96Em2WezqYkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9CCMdfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA63C4CEED;
	Tue,  2 Sep 2025 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756820126;
	bh=Slg65ry9HcMSQV6qwLc8Vq4BkXV+5kY9vA6LdBInXNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9CCMdfN917NOJcT3eU4zN3L8arqaAEtx30O3/pNxF7qPBHuIjya6PXwBUYMQqUeg
	 zrgK3hx7xG/v9B5Er1C4e5NjjMUjdVi6UpJslhsmFLwu0DRTtiWLkBfP3DZdsUPe8q
	 SlHkuomQh4jjsaeK6edmXg07Bdl++7njUTK2WrZY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Naveen N Rao (AMD)" <naveen@kernel.org>
Subject: [PATCH 6.12 70/95] x86/cpu/topology: Use initial APIC ID from XTOPOLOGY leaf on AMD/HYGON
Date: Tue,  2 Sep 2025 15:20:46 +0200
Message-ID: <20250902131942.287686865@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
References: <20250902131939.601201881@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: K Prateek Nayak <kprateek.nayak@amd.com>

commit c2415c407a2cde01290d52ce2a1f81b0616379a3 upstream.

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

Although this has not been a problem on baremetal platforms, on virtualized AMD
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
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 [2]
Link: https://lore.kernel.org/20250825075732.10694-2-kprateek.nayak@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/topology_amd.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -80,20 +80,25 @@ static bool parse_8000_001e(struct topo_
 
 	cpuid_leaf(0x8000001e, &leaf);
 
-	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
-
 	/*
-	 * If leaf 0xb is available, then the domain shifts are set
-	 * already and nothing to do here. Only valid for family >= 0x17.
+	 * If leaf 0xb/0x26 is available, then the APIC ID and the domain
+	 * shifts are set already.
 	 */
-	if (!has_topoext && tscan->c->x86 >= 0x17) {
+	if (!has_topoext) {
+		tscan->c->topo.initial_apicid = leaf.ext_apic_id;
+
 		/*
-		 * Leaf 0x80000008 set the CORE domain shift already.
-		 * Update the SMT domain, but do not propagate it.
+		 * Leaf 0x8000008 sets the CORE domain shift but not the
+		 * SMT domain shift. On CPUs with family >= 0x17, there
+		 * might be hyperthreads.
 		 */
-		unsigned int nthreads = leaf.core_nthreads + 1;
+		if (tscan->c->x86 >= 0x17) {
+			/* Update the SMT domain, but do not propagate it. */
+			unsigned int nthreads = leaf.core_nthreads + 1;
 
-		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
+			topology_update_dom(tscan, TOPO_SMT_DOMAIN,
+					    get_count_order(nthreads), nthreads);
+		}
 	}
 
 	store_node(tscan, leaf.nnodes_per_socket + 1, leaf.node_id);



