Return-Path: <stable+bounces-27488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96729879ADE
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4922840D5
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29491386C1;
	Tue, 12 Mar 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+kii5ML"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CE1386B8
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266143; cv=none; b=k8oT3jALpaFFinXrqy11wVtAWfU8GBa/WNX6EBYbE5OPNPkBv7um7/SeFrNFqxh9yu6IzMD8g+X0ZfB3kRAvz4Kwhc8tbgV+zEPsumGfDSQDixi50f1YnpNzaFdrrNonfG+ZaWquiAKdc4Y1h2Ms095t53T+TfiGHusgEkhlPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266143; c=relaxed/simple;
	bh=z0oAlQMfDHDnoZVTRE2pPFHMhLKM1JD1FPyZQVDlms0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=putxpvvNXlGi/iVEkPa+YsfuhXTzu0lsQi2nKdvDPofmCpRdD0CrnxYx/xgx84F2kcqcRFyHq3VY8aDmW4nHVphoqDt7OZeUpZTnjxROEO3qdfJx5iq6MvCbfE+WW9O3LDkcClgv/cyvldvF3/rShS6UTPxnkyMaxLKTaecUivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+kii5ML; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710266142; x=1741802142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0oAlQMfDHDnoZVTRE2pPFHMhLKM1JD1FPyZQVDlms0=;
  b=S+kii5MLvxwknC35fwtD8peFWe4kxJFuWWjSlfhqoIfbWV8gwX4vH8qP
   XECkdnAcIUHqzVwBI8RReA60DNfpmxPHO4Vq2uXby0AkQFk/Ww3ekMX3Q
   EiqoWkz0JAGg65znTPcQBPzYd5r4QmqXIVk+Ouzsyy0Tmg+i9qvK+rZKi
   JPJ2RUiYq7P6W5nFgAd3jOXxrma/x98oIADXZGX95LeBwt21lr6FO3LoD
   i7ISp8DuiqQF6stfpgajHer9ggiLVEd5pGrWNlzLs3NLUWDu836Ge0s4Q
   /eYTwq44MRM2pI0G0yubE7S2HkELwgkds0uSs4aG/6sMt/i0yW8DUOFk9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5177937"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5177937"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 10:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16188286"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 10:55:40 -0700
Date: Tue, 12 Mar 2024 10:55:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 2/4] Documentation/hw-vuln: Add documentation for RFDS
Message-ID: <20240312-rfds-backport-6-8-y-v1-2-d4ab515a4b4f@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-rfds-backport-6-8-y-v1-0-d4ab515a4b4f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-rfds-backport-6-8-y-v1-0-d4ab515a4b4f@linux.intel.com>

commit 4e42765d1be01111df0c0275bbaf1db1acef346e upstream.

Add the documentation for transient execution vulnerability Register
File Data Sampling (RFDS) that affects Intel Atom CPUs.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../admin-guide/hw-vuln/reg-file-data-sampling.rst | 104 +++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index de99caabf65a..ff0b440ef2dc 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -21,3 +21,4 @@ are configurable at compile, boot or run time.
    cross-thread-rsb
    srso
    gather_data_sampling
+   reg-file-data-sampling
diff --git a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
new file mode 100644
index 000000000000..0585d02b9a6c
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
@@ -0,0 +1,104 @@
+==================================
+Register File Data Sampling (RFDS)
+==================================
+
+Register File Data Sampling (RFDS) is a microarchitectural vulnerability that
+only affects Intel Atom parts(also branded as E-cores). RFDS may allow
+a malicious actor to infer data values previously used in floating point
+registers, vector registers, or integer registers. RFDS does not provide the
+ability to choose which data is inferred. CVE-2023-28746 is assigned to RFDS.
+
+Affected Processors
+===================
+Below is the list of affected Intel processors [#f1]_:
+
+   ===================  ============
+   Common name          Family_Model
+   ===================  ============
+   ATOM_GOLDMONT           06_5CH
+   ATOM_GOLDMONT_D         06_5FH
+   ATOM_GOLDMONT_PLUS      06_7AH
+   ATOM_TREMONT_D          06_86H
+   ATOM_TREMONT            06_96H
+   ALDERLAKE               06_97H
+   ALDERLAKE_L             06_9AH
+   ATOM_TREMONT_L          06_9CH
+   RAPTORLAKE              06_B7H
+   RAPTORLAKE_P            06_BAH
+   ATOM_GRACEMONT          06_BEH
+   RAPTORLAKE_S            06_BFH
+   ===================  ============
+
+As an exception to this table, Intel Xeon E family parts ALDERLAKE(06_97H) and
+RAPTORLAKE(06_B7H) codenamed Catlow are not affected. They are reported as
+vulnerable in Linux because they share the same family/model with an affected
+part. Unlike their affected counterparts, they do not enumerate RFDS_CLEAR or
+CPUID.HYBRID. This information could be used to distinguish between the
+affected and unaffected parts, but it is deemed not worth adding complexity as
+the reporting is fixed automatically when these parts enumerate RFDS_NO.
+
+Mitigation
+==========
+Intel released a microcode update that enables software to clear sensitive
+information using the VERW instruction. Like MDS, RFDS deploys the same
+mitigation strategy to force the CPU to clear the affected buffers before an
+attacker can extract the secrets. This is achieved by using the otherwise
+unused and obsolete VERW instruction in combination with a microcode update.
+The microcode clears the affected CPU buffers when the VERW instruction is
+executed.
+
+Mitigation points
+-----------------
+VERW is executed by the kernel before returning to user space, and by KVM
+before VMentry. None of the affected cores support SMT, so VERW is not required
+at C-state transitions.
+
+New bits in IA32_ARCH_CAPABILITIES
+----------------------------------
+Newer processors and microcode update on existing affected processors added new
+bits to IA32_ARCH_CAPABILITIES MSR. These bits can be used to enumerate
+vulnerability and mitigation capability:
+
+- Bit 27 - RFDS_NO - When set, processor is not affected by RFDS.
+- Bit 28 - RFDS_CLEAR - When set, processor is affected by RFDS, and has the
+  microcode that clears the affected buffers on VERW execution.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+The kernel command line allows to control RFDS mitigation at boot time with the
+parameter "reg_file_data_sampling=". The valid arguments are:
+
+  ==========  =================================================================
+  on          If the CPU is vulnerable, enable mitigation; CPU buffer clearing
+              on exit to userspace and before entering a VM.
+  off         Disables mitigation.
+  ==========  =================================================================
+
+Mitigation default is selected by CONFIG_MITIGATION_RFDS.
+
+Mitigation status information
+-----------------------------
+The Linux kernel provides a sysfs interface to enumerate the current
+vulnerability status of the system: whether the system is vulnerable, and
+which mitigations are active. The relevant sysfs file is:
+
+	/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
+
+The possible values in this file are:
+
+  .. list-table::
+
+     * - 'Not affected'
+       - The processor is not vulnerable
+     * - 'Vulnerable'
+       - The processor is vulnerable, but no mitigation enabled
+     * - 'Vulnerable: No microcode'
+       - The processor is vulnerable but microcode is not updated.
+     * - 'Mitigation: Clear Register File'
+       - The processor is vulnerable and the CPU buffer clearing mitigation is
+	 enabled.
+
+References
+----------
+.. [#f1] Affected Processors
+   https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html

-- 
2.34.1



