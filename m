Return-Path: <stable+bounces-144648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E0ABA6D7
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2453C1BC3906
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52529A1;
	Sat, 17 May 2025 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1AwUreV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A120ED
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440053; cv=none; b=MfDk6rXj8CZly4AMczpqn+N+8AYJ12Kk0EW5RVcvNFW1iiw8VtWycbjFglzQMF/qyRxblM9LbCnQ4wgLuRcfkU96kILe5PoDeZ05lF1UM7wvx/k/T8C8cfxES6yJrhEasqbIEP6uD1O2mYZfkGvaVFxVmZBzLgCjj1Qt9Wk2Dh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440053; c=relaxed/simple;
	bh=SCj7bU8d4bT9VlVx3sSwhL9PMIMURahtxM1n0AXv7II=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASHltXloWeHJBNAPJOG5R/2r0Qav9OzVsKLHC7FXsuyEQdJj6MtleoZhReokRr/AY2Q8p1Nhzl3LDvK/9mj2vcgoHDGk+3Hs0SOpd8i/R4ul1ye9SmWwH1RNDA2x0Kbev1GjeEn0kU0Plz/+8S/hI00t6ihhbUflxXI6feNkp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1AwUreV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440052; x=1778976052;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=SCj7bU8d4bT9VlVx3sSwhL9PMIMURahtxM1n0AXv7II=;
  b=S1AwUreVdz+7BZAeXdIjec9Fx07ZizYfdkX+8lMKgPtgTHnWnMcycwkU
   o++VGymXY4ojEfsZbrRrLwJVzlBVQ7ed5Dllk6IUmJ3ztsYsS2F24Xdqc
   gW7kPPZQu/UyR+JVnS1hwuvyIV3iWNBBPWtqmJCFiYIOMwYKlFdrU2s1A
   oxcXGK1PVyH4BRUJKdVumUFZkwGZWVOUnNGlZIfyGbDcQCLxbYkYmCVAO
   6Yz42ssUEAkdn7EI3LstEpMdk7kbSg8RRqF4BKqSSv9tnfrW6wOE6rSh5
   AEFOVOv0uxrl7yrZhFsECR22cQlMV6NwVCHEEV8xTIMsL+vFWe4ep0bzy
   A==;
X-CSE-ConnectionGUID: J2BwZI/4SICF7NPzfemBkA==
X-CSE-MsgGUID: SZBARdzcTCO0ToP4V1lSIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="60766194"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="60766194"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:00:47 -0700
X-CSE-ConnectionGUID: iRGMd67+Re2krXbRw2BJFg==
X-CSE-MsgGUID: Oy3TtfjEQkibeGimrU7mmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="143608854"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:00:46 -0700
Date: Fri, 16 May 2025 17:00:46 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15 v3 05/16] Documentation: x86/bugs/its: Add ITS
 documentation
Message-ID: <20250516-its-5-15-v3-5-16fcdaaea544@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>

commit 1ac116ce6468670eeda39345a5585df308243dca upstream.

Add the admin-guide for Indirect Target Selection (ITS).

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../hw-vuln/indirect-target-selection.rst          | 156 +++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 3e4a14e38b49e860b0b2dfebb6c0210e85518fb9..dc69ba0b05e47445f24214a64348d98e91895c71 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -22,3 +22,4 @@ are configurable at compile, boot or run time.
    gather_data_sampling.rst
    srso
    reg-file-data-sampling
+   indirect-target-selection
diff --git a/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
new file mode 100644
index 0000000000000000000000000000000000000000..4788e14ebce09aa715141c372188c37435f73dc1
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
@@ -0,0 +1,156 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Indirect Target Selection (ITS)
+===============================
+
+ITS is a vulnerability in some Intel CPUs that support Enhanced IBRS and were
+released before Alder Lake. ITS may allow an attacker to control the prediction
+of indirect branches and RETs located in the lower half of a cacheline.
+
+ITS is assigned CVE-2024-28956 with a CVSS score of 4.7 (Medium).
+
+Scope of Impact
+---------------
+- **eIBRS Guest/Host Isolation**: Indirect branches in KVM/kernel may still be
+  predicted with unintended target corresponding to a branch in the guest.
+
+- **Intra-Mode BTI**: In-kernel training such as through cBPF or other native
+  gadgets.
+
+- **Indirect Branch Prediction Barrier (IBPB)**: After an IBPB, indirect
+  branches may still be predicted with targets corresponding to direct branches
+  executed prior to the IBPB. This is fixed by the IPU 2025.1 microcode, which
+  should be available via distro updates. Alternatively microcode can be
+  obtained from Intel's github repository [#f1]_.
+
+Affected CPUs
+-------------
+Below is the list of ITS affected CPUs [#f2]_ [#f3]_:
+
+   ========================  ============  ====================  ===============
+   Common name               Family_Model  eIBRS                 Intra-mode BTI
+                                           Guest/Host Isolation
+   ========================  ============  ====================  ===============
+   SKYLAKE_X (step >= 6)     06_55H        Affected              Affected
+   ICELAKE_X                 06_6AH        Not affected          Affected
+   ICELAKE_D                 06_6CH        Not affected          Affected
+   ICELAKE_L                 06_7EH        Not affected          Affected
+   TIGERLAKE_L               06_8CH        Not affected          Affected
+   TIGERLAKE                 06_8DH        Not affected          Affected
+   KABYLAKE_L (step >= 12)   06_8EH        Affected              Affected
+   KABYLAKE (step >= 13)     06_9EH        Affected              Affected
+   COMETLAKE                 06_A5H        Affected              Affected
+   COMETLAKE_L               06_A6H        Affected              Affected
+   ROCKETLAKE                06_A7H        Not affected          Affected
+   ========================  ============  ====================  ===============
+
+- All affected CPUs enumerate Enhanced IBRS feature.
+- IBPB isolation is affected on all ITS affected CPUs, and need a microcode
+  update for mitigation.
+- None of the affected CPUs enumerate BHI_CTRL which was introduced in Golden
+  Cove (Alder Lake and Sapphire Rapids). This can help guests to determine the
+  host's affected status.
+- Intel Atom CPUs are not affected by ITS.
+
+Mitigation
+----------
+As only the indirect branches and RETs that have their last byte of instruction
+in the lower half of the cacheline are vulnerable to ITS, the basic idea behind
+the mitigation is to not allow indirect branches in the lower half.
+
+This is achieved by relying on existing retpoline support in the kernel, and in
+compilers. ITS-vulnerable retpoline sites are runtime patched to point to newly
+added ITS-safe thunks. These safe thunks consists of indirect branch in the
+second half of the cacheline. Not all retpoline sites are patched to thunks, if
+a retpoline site is evaluated to be ITS-safe, it is replaced with an inline
+indirect branch.
+
+Dynamic thunks
+~~~~~~~~~~~~~~
+From a dynamically allocated pool of safe-thunks, each vulnerable site is
+replaced with a new thunk, such that they get a unique address. This could
+improve the branch prediction accuracy. Also, it is a defense-in-depth measure
+against aliasing.
+
+Note, for simplicity, indirect branches in eBPF programs are always replaced
+with a jump to a static thunk in __x86_indirect_its_thunk_array. If required,
+in future this can be changed to use dynamic thunks.
+
+All vulnerable RETs are replaced with a static thunk, they do not use dynamic
+thunks. This is because RETs get their prediction from RSB mostly that does not
+depend on source address. RETs that underflow RSB may benefit from dynamic
+thunks. But, RETs significantly outnumber indirect branches, and any benefit
+from a unique source address could be outweighed by the increased icache
+footprint and iTLB pressure.
+
+Retpoline
+~~~~~~~~~
+Retpoline sequence also mitigates ITS-unsafe indirect branches. For this
+reason, when retpoline is enabled, ITS mitigation only relocates the RETs to
+safe thunks. Unless user requested the RSB-stuffing mitigation.
+
+Mitigation in guests
+^^^^^^^^^^^^^^^^^^^^
+All guests deploy ITS mitigation by default, irrespective of eIBRS enumeration
+and Family/Model of the guest. This is because eIBRS feature could be hidden
+from a guest. One exception to this is when a guest enumerates BHI_DIS_S, which
+indicates that the guest is running on an unaffected host.
+
+To prevent guests from unnecessarily deploying the mitigation on unaffected
+platforms, Intel has defined ITS_NO bit(62) in MSR IA32_ARCH_CAPABILITIES. When
+a guest sees this bit set, it should not enumerate the ITS bug. Note, this bit
+is not set by any hardware, but is **intended for VMMs to synthesize** it for
+guests as per the host's affected status.
+
+Mitigation options
+^^^^^^^^^^^^^^^^^^
+The ITS mitigation can be controlled using the "indirect_target_selection"
+kernel parameter. The available options are:
+
+   ======== ===================================================================
+   on       (default)  Deploy the "Aligned branch/return thunks" mitigation.
+	    If spectre_v2 mitigation enables retpoline, aligned-thunks are only
+	    deployed for the affected RET instructions. Retpoline mitigates
+	    indirect branches.
+
+   off      Disable ITS mitigation.
+
+   vmexit   Equivalent to "=on" if the CPU is affected by guest/host isolation
+	    part of ITS. Otherwise, mitigation is not deployed. This option is
+	    useful when host userspace is not in the threat model, and only
+	    attacks from guest to host are considered.
+
+   force    Force the ITS bug and deploy the default mitigation.
+   ======== ===================================================================
+
+Sysfs reporting
+---------------
+
+The sysfs file showing ITS mitigation status is:
+
+  /sys/devices/system/cpu/vulnerabilities/indirect_target_selection
+
+Note, microcode mitigation status is not reported in this file.
+
+The possible values in this file are:
+
+.. list-table::
+
+   * - Not affected
+     - The processor is not vulnerable.
+   * - Vulnerable
+     - System is vulnerable and no mitigation has been applied.
+   * - Vulnerable, KVM: Not affected
+     - System is vulnerable to intra-mode BTI, but not affected by eIBRS
+       guest/host isolation.
+   * - Mitigation: Aligned branch/return thunks
+     - The mitigation is enabled, affected indirect branches and RETs are
+       relocated to safe thunks.
+
+References
+----------
+.. [#f1] Microcode repository - https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files
+
+.. [#f2] Affected Processors list - https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html
+
+.. [#f3] Affected Processors list (machine readable) - https://github.com/intel/Intel-affected-processor-list

-- 
2.34.1



