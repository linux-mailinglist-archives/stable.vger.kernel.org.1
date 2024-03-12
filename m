Return-Path: <stable+bounces-27502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C165879B2A
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372C9284EFE
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B513956C;
	Tue, 12 Mar 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ji3MNaKm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095AB139590
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267431; cv=none; b=qDl1C+5PTKVbuO/x/OeODNTIRtTmo8cdu6MP+t4D4ifn8rH9qZgoCxWnrfcDuLNFEzEBAHeMbt1FCTobbOjGakNQ4Gok1zYFGXKShBcORp3evna4OWCO+kPk5SZV4gR/FaXEyqGjAWfgpaRT9/rht0kc3Fegwr0zd9mTDxhSyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267431; c=relaxed/simple;
	bh=P3UKvBZvYrVmsKx9MgCnHzD5pJASddrI7Cp2guEnQ18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JDV9rJZ5/usXTHIkkSupOfhMvAlRcITCyltyfd3IppfxEWMTRzAuPtDdIFOUeGAcoqRQAah+404lk3SCSd7akhYZEyCCIra97FUu8M8qK4LxeK/CaEPAnuZE88fcKH0bLKgDUFoXoRsrY9usta+mmT2xbnUnMhBXc6Qlo1gkxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ji3MNaKm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710267430; x=1741803430;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P3UKvBZvYrVmsKx9MgCnHzD5pJASddrI7Cp2guEnQ18=;
  b=ji3MNaKmduNTEk0XaUqQYRVIR/c5ho9Oirymuh/kjrCUXS1MCkYtXIqR
   m8m+iaw0n9iOp2KG0fMKVsiXm4niYecyAoDNOAeeM3IKlnFZRKQehgEJg
   am32Hf6z/vPnaghUv/T3EPvIJOKe2vbVLnhw0aF+5H2WdItTaUM1GZHmg
   6lJuMiCNE+wCiw7jUX3/rTWuqvR1g0YhmZDzbzpkil11shKJBi1+8E00C
   qASV+NHuEveXyVP1XSXBIqikwWvHcKjoTa58vL9lAEHTIx+ghSvXyONnh
   XlCJR3lGTf77mQT/eiFlfKEsh0wIOiQn4OqQqQn+po1zRQ9tcYO45ZbU5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16136412"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16136412"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11717869"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:17:09 -0700
Date: Tue, 12 Mar 2024 11:17:08 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 0/4] RFDS backport 6.1.y
Message-ID: <20240312-rfds-backport-6-1-y-v1-0-31cae244c4de@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIANyb8GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Mj3aK0lGLdpMTk7IL8ohJdM11D3UrdFEPz1OQ0i2TD1GRTJaDOgqL
 UtMwKsKnRsbW1AI+RW6RlAAAA
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a backport of recently upstreamed mitigation of a CPU
vulnerability Register File Data Sampling (RFDS) (CVE-2023-28746). It
has a dependency on "Delay VERW" series which is already backported and
merged in linux-6.1.y.

- There was a minor conflict for patch 2/4 in Documentation index.
- There were many easy to resolve conflicts in patch 3/4 related to
  sysfs reporting.
- s/ATOM_GRACEMONT/ALDERLAKE_N/
  - ATOM_GRACEMONT is called ALDERLAKE_N in 6.6.

Cc: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Pawan Gupta (4):
      x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
      Documentation/hw-vuln: Add documentation for RFDS
      x86/rfds: Mitigate Register File Data Sampling (RFDS)
      KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../admin-guide/hw-vuln/reg-file-data-sampling.rst | 104 +++++++++++++++++++++
 Documentation/admin-guide/kernel-parameters.txt    |  21 +++++
 arch/x86/Kconfig                                   |  11 +++
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/msr-index.h                   |   8 ++
 arch/x86/kernel/cpu/bugs.c                         |  92 +++++++++++++++++-
 arch/x86/kernel/cpu/common.c                       |  38 +++++++-
 arch/x86/kvm/x86.c                                 |   5 +-
 drivers/base/cpu.c                                 |   8 ++
 include/linux/cpu.h                                |   2 +
 12 files changed, 283 insertions(+), 9 deletions(-)
---
base-commit: 61adba85cc40287232a539e607164f273260e0fe
change-id: 20240312-rfds-backport-6-1-y-d17ecf8c1ec5

Best regards,
-- 
Thanks,
Pawan



