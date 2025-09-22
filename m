Return-Path: <stable+bounces-181407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D9FB93396
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 22:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E1E3A2727
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475D3090CA;
	Mon, 22 Sep 2025 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eEHNyk35";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+tpdkuwe"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF71F91E3;
	Mon, 22 Sep 2025 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572834; cv=none; b=WpXHdts+knhSOMFxHnhAESCWEYrpvKSuJ6o4OaW1PgIEaBmKmwDQBu31vvHPlALCbR/vUi+jnsPrEHoyvBivLIxQC4yBMYijY+cAPjxuUQaTLynhZBjUFrFXeoXbsRar8pcFTvVTfqwa1EnNQV7k6lqB06MSiViaXCh4JFb8AW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572834; c=relaxed/simple;
	bh=mCgp/7RadOWTpRmrXG8hqPptGQTCwh5WwhQ5Lhm3z/Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tZzDs6VS3cYHJQwqbNKS3fb3vg2yikWmpOwq9PSGCX01DRc17+spmC2BB5YGksefq2Ja0+nVIDfNIs3Wb3V9cxsAv2G7/NJ57lpFbtCZlplCJRg/HPnkU2SgWJXi6atu+8U0hZkOZZ45PTK5Vtl4u+e/xtpW5RYq7hRSygVz0xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eEHNyk35; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+tpdkuwe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Sep 2025 20:26:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758572824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/Xm1F4jPoDCutpFQATFslC6fsMVWAzEBHzTOUlynjo=;
	b=eEHNyk35d7dJnRphHqwU4VpbfAbZbM0VU5DuaFC6o+VirDljfAVAs5mAvH8QyikiFgLsTv
	gRf2jhXVMEe/+qHd2aEvw05rwnfQop63gYQ8PKZdcfc2BDAJFt5EnbabuNM4sIza0wUyNK
	3aBBElt0JTM8HbhrwRDDfKeiYwqc0AevPvq2MT8GCCBDtRCAYQElJruul+pNOT7/0vz9jM
	/cRBDkUTmrr0cSRy3OqCr+dXp0jF36sUfKLrd8rK7kyHy20HcIWsI/xuU3rgmdRw1cbAv4
	pT85EDe2em3KezZSbs+16Bx7jjgFKiDfuBRLTwuGE9/UsuyadXsSGG9JEEZRMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758572824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/Xm1F4jPoDCutpFQATFslC6fsMVWAzEBHzTOUlynjo=;
	b=+tpdkuwe7vYZPx/lXU10kvsWuRu5E9duIiGL5ukI127Y4Cn1Jv3YQMnOrIvbomqUIidQTc
	nd3V/ftmRt+w4yBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topology: Implement topology_is_core_online()
 to address SMT regression
Cc: Christian Loehle <christian.loehle@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87cy7k5gl3.ffs@tglx>
References: <87cy7k5gl3.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175857281995.709179.12663818315862568128.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2066f00e5b2dc061fb6d8c88fadaebc97f11feaa
Gitweb:        https://git.kernel.org/tip/2066f00e5b2dc061fb6d8c88fadaebc97f1=
1feaa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 21 Sep 2025 10:56:40 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Sep 2025 21:25:36 +02:00

x86/topology: Implement topology_is_core_online() to address SMT regression

Christian reported that commit a430c11f4015 ("intel_idle: Rescan "dead" SMT
siblings during initialization") broke the use case in which both 'nosmt'
and 'maxcpus' are on the kernel command line because it onlines primary
threads, which were offline due to the maxcpus limit.

The initially proposed fix to skip primary threads in the loop is
inconsistent. While it prevents the primary thread to be onlined, it then
onlines the corresponding hyperthread(s), which does not really make sense.

The CPU iterator in cpuhp_smt_enable() contains a check which excludes all
threads of a core, when the primary thread is offline. The default
implementation is a NOOP and therefore not effective on x86.

Implement topology_is_core_online() on x86 to address this issue. This
makes the behaviour consistent between x86 and PowerPC.

Fixes: a430c11f4015 ("intel_idle: Rescan "dead" SMT siblings during initializ=
ation")
Fixes: f694481b1d31 ("ACPI: processor: Rescan "dead" SMT siblings during init=
ialization")
Closes: https://lore.kernel.org/linux-pm/724616a2-6374-4ba3-8ce3-ea9c45e2ae3b=
@arm.com/
Reported-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/12740505.O9o76ZdvQC@rafael.j.wysocki
---
 arch/x86/include/asm/topology.h | 10 ++++++++++
 arch/x86/kernel/cpu/topology.c  | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 6c79ee7..2104189 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -231,6 +231,16 @@ static inline bool topology_is_primary_thread(unsigned i=
nt cpu)
 }
 #define topology_is_primary_thread topology_is_primary_thread
=20
+int topology_get_primary_thread(unsigned int cpu);
+
+static inline bool topology_is_core_online(unsigned int cpu)
+{
+	int pcpu =3D topology_get_primary_thread(cpu);
+
+	return pcpu >=3D 0 ? cpu_online(pcpu) : false;
+}
+#define topology_is_core_online topology_is_core_online
+
 #else /* CONFIG_SMP */
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0;=
 }
 static inline int topology_max_smt_threads(void) { return 1; }
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index e35ccdc..6073a16 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -372,6 +372,19 @@ unsigned int topology_unit_count(u32 apicid, enum x86_to=
pology_domains which_uni
 	return topo_unit_count(lvlid, at_level, apic_maps[which_units].map);
 }
=20
+#ifdef CONFIG_SMP
+int topology_get_primary_thread(unsigned int cpu)
+{
+	u32 apic_id =3D cpuid_to_apicid[cpu];
+
+	/*
+	 * Get the core domain level APIC id, which is the primary thread
+	 * and return the CPU number assigned to it.
+	 */
+	return topo_lookup_cpuid(topo_apicid(apic_id, TOPO_CORE_DOMAIN));
+}
+#endif
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /**
  * topology_hotplug_apic - Handle a physical hotplugged APIC after boot

