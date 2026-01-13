Return-Path: <stable+bounces-208281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC5FD1A220
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 17:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8601F30490A4
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A66638A9B8;
	Tue, 13 Jan 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufUXOyli";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oLdKMJWX"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2230F80F;
	Tue, 13 Jan 2026 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320844; cv=none; b=riZHIQTyRjhHdmusAbMYxv5MEx9KsEW6c4FyUtvaNsCiC2xxXWoJazQp576puudyDKO4AmI6RGZjS0pvPzeiL67bD8cde8NuN0PQyVL+opwSIO+oABTtswA1IYr4Ifqz66QBZPIkmxpEa3Ca2vKTvogj0f4uelL35tDHbv6BfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320844; c=relaxed/simple;
	bh=EmiiEqY2Eykt1SqjlZl2cMLHNHbtNov8uCSsOgX/Z3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l11Ls7HHYyZTVCXEWrycshk5OiWfherTiKvIMN4yVM2pfsiFxXidygpq8PfunohvfrI2lrOQYu7Iomji3t99fSwBk+6muXCGknHBjVeyhzkWERQVR0ccmWbFDB4p858psqZ/qzbSSPvOtXA/GIvhJz65yVvXOK4spZuOzWtxwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufUXOyli; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLdKMJWX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 16:14:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768320841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSgcNUCY9dtgwiA69Kx7IvG8d8ZE5876cfCAVU4dcjE=;
	b=ufUXOylimDjYJsSH3ZekgKxVX4lEvYqRGmy6pv3w7J8LE+MCB3sHVZcnqF7UkPGEMIJjLL
	JRoQaXL3HdnI2FZ2FyEALbvSWJmZGhoU7jifjOTLiIozhB3+hyZV6yAbU/ywZgNKXlncQX
	/gR2caZSJb8s28EgqCeiw5tYILzqBdYfYlwQ4ulaFyXpVssoDMQYZgMQvcRisZwC37iodE
	DriAOCgci6WcnHLMXvOYPew7LCKpiMF3wd12e00qIV7nK24kj73RENBFAFAEQtwmWOawlE
	1v0CHt4D9nTJQWrj1wUaQeOp9+jbOPj0XgmCjW2Kn/OwrhXHdUmMLmX+48LBEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768320841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSgcNUCY9dtgwiA69Kx7IvG8d8ZE5876cfCAVU4dcjE=;
	b=oLdKMJWXjOqeeyvcc+j0VEzcWWbqm7y8ajwZxsscplzBuUJi5AuQ0QLZMQV8fv5Sz0ZPbA
	1J5sc6Yd1xxvJmBw==
From: "tip-bot2 for Xiaochen Shen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/resctrl: Add missing resctrl initialization for Hygon
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251209062650.1536952-2-shenxiaochen@open-hieco.net>
References: <20251209062650.1536952-2-shenxiaochen@open-hieco.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176832084042.510.2796952283536723674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6ee98aabdc700b5705e4f1833e2edc82a826b53b
Gitweb:        https://git.kernel.org/tip/6ee98aabdc700b5705e4f1833e2edc82a82=
6b53b
Author:        Xiaochen Shen <shenxiaochen@open-hieco.net>
AuthorDate:    Tue, 09 Dec 2025 14:26:49 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Jan 2026 16:20:01 +01:00

x86/resctrl: Add missing resctrl initialization for Hygon

Hygon CPUs supporting Platform QoS features currently undergo partial resctrl
initialization through resctrl_cpu_detect() in the Hygon BSP init helper and
AMD/Hygon common initialization code. However, several critical data
structures remain uninitialized for Hygon CPUs in the following paths:

 - get_mem_config()-> __rdt_get_mem_config_amd():
     rdt_resource::membw,alloc_capable
     hw_res::num_closid

 - rdt_init_res_defs()->rdt_init_res_defs_amd():
     rdt_resource::cache
     hw_res::msr_base,msr_update

Add the missing AMD/Hygon common initialization to ensure proper Platform QoS
functionality on Hygon CPUs.

Fixes: d8df126349da ("x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_=
init helper")
Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251209062650.1536952-2-shenxiaochen@open-hie=
co.net
---
 arch/x86/kernel/cpu/resctrl/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 3792ab4..10de159 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -825,7 +825,8 @@ static __init bool get_mem_config(void)
=20
 	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
 		return __get_mem_config_intel(&hw_res->r_resctrl);
-	else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+	else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
+		 boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
 		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
=20
 	return false;
@@ -987,7 +988,8 @@ static __init void rdt_init_res_defs(void)
 {
 	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL)
 		rdt_init_res_defs_intel();
-	else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+	else if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
+		 boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
 		rdt_init_res_defs_amd();
 }
=20

