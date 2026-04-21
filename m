Return-Path: <stable+bounces-240203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDyYHEqn52lQ+wEAu9opvQ
	(envelope-from <stable+bounces-240203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:35:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9341143D73F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B6203043E50
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F851378814;
	Tue, 21 Apr 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HG4oPFC2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA38377560;
	Tue, 21 Apr 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789100; cv=none; b=VvStyQ6TgfFFk4CIAflwNgjM6kRgEBnqvEh+bzpH9XxcN5T7REJtvFZx95QixPcUapmXcTaxLy/FlrW6H5E6S/PGA9XU0w38AHZkjzzawPfZnXqhqlzTa94SIMF+391iUFqPicpcgiJWTYX7kHtTX41ZqaOGOgfIe8DGdWuyM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789100; c=relaxed/simple;
	bh=4JAIfFbFSM9E2yZTApah1kYZ2IsLtrPyrYsZwbN9rZA=;
	h=Subject:To:Cc:From:Date:Message-Id; b=S8GoR7heCx77oFHAcz2KI44g4QvTjMuUj19PO9lwMQZtIDfxkdJmrhBuw4sOrQqeP88+6IkhTn2bfhndD5JbjJKWTfIfEsWviMHiBAcviMvVMOoPvvGKEpGUQG22GGqj+s/STK+6MpgdlG7xA6EMcRKGcmV2y2hQwZNOnVjzcV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HG4oPFC2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776789098; x=1808325098;
  h=subject:to:cc:from:date:message-id;
  bh=4JAIfFbFSM9E2yZTApah1kYZ2IsLtrPyrYsZwbN9rZA=;
  b=HG4oPFC2/xve7L4wGUiWOKnKm1x7y7bm7HLL7A2TkfNE5xSakD+T8y8W
   m0Y+GWdUBU+DQ1rxSl7pIOxZohmxl/rbJwtsDANWEwA41bdmaRNtTR+h/
   DUsK/K8fBiWzAG04H9Ky3hnwYF4U5ZQkbORMQ27sOzbsz6wdGxCsqc1it
   k9yKf3aCZw8UtreOaQbN1q5mqYAIfnQP+b1YcZsr+JO4n1sTi1MqJKsOT
   SurHoFthgh9H3X58twXD3vs/xNf3FU69/gnW93pU8FaOsWUJ4N1LNqGMX
   j7N02F8rqwFVlOmEuddfMDZltYndau9sOfURZpqjt5BfjAJhBKrkPx9Es
   A==;
X-CSE-ConnectionGUID: C59EkK++RUiXJdj5Gerh5Q==
X-CSE-MsgGUID: IiN0yPryTaW7xXGwiQ7jPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65264899"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="65264899"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 09:31:37 -0700
X-CSE-ConnectionGUID: N1D78VCEQx2CDw7aVSCbMQ==
X-CSE-MsgGUID: JGQ1nE+dTpyrLbditwYmxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231194395"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 21 Apr 2026 09:31:37 -0700
Subject: [PATCH] x86/cpu: Disable FRED when PTI is forced on
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Gayatri Kammela <Gayatri.Kammela@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 21 Apr 2026 09:31:36 -0700
Message-Id: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240203-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,amd.com:email,zytor.com:email,infradead.org:email]
X-Rspamd-Queue-Id: 9341143D73F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


From: Dave Hansen <dave.hansen@linux.intel.com>

FRED and PTI were never intended to work together. No FRED hardware is
vulnerable to Meltdown and all of it should have LASS anyway.
Nevertheless, if you boot a system with pti=on and fred=on, the kernel
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

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Gayatri Kammela <Gayatri.Kammela@amd.com>
Cc: stable@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---

 b/arch/x86/mm/pti.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -puN arch/x86/mm/pti.c~fred-vs-kpti arch/x86/mm/pti.c
--- a/arch/x86/mm/pti.c~fred-vs-kpti	2026-04-21 08:37:01.124709928 -0700
+++ b/arch/x86/mm/pti.c	2026-04-21 08:41:11.219700206 -0700
@@ -105,6 +105,11 @@ void __init pti_check_boottime_disable(v
 		pr_debug("PTI enabled, disabling INVLPGB\n");
 		setup_clear_cpu_cap(X86_FEATURE_INVLPGB);
 	}
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		pr_debug("PTI enabled, disabling FRED\n");
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+	}
 }
 
 static int __init pti_parse_cmdline(char *arg)
_

