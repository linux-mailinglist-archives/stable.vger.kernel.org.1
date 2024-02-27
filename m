Return-Path: <stable+bounces-23816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC678688AC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 06:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1CA1C21604
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 05:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2152F83;
	Tue, 27 Feb 2024 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4EdKHb4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB91DA21
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012059; cv=none; b=fOB1aC3Xw9mOhs/GYr+DxKcTADi+mn0NgNsZhe2r3JuNjheI9TKr7cVT8cSNk6/l7rvkzGrrfNLJ9vAd74qqfrGvY2V3KOOUNvIPeDYj5cWLQqrUkGkC53jdUX9rxDCZTwVFHaaqF2eDGnEBS58FSSnRs7CrBDV8jXH010tdJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012059; c=relaxed/simple;
	bh=Qn/b7HjVZFNtZnn4ir1x6LDJOqmZ3njctEqc5QdNdeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W/Qx3/ZbeZt4DKD8BgNpiUh7YZwrgP/kNQGupgD1GKk1ynAmfdOmhvt6FkYC01aSSArvRYRGavGFV3zwg7diDCcozAO4IhY414oIy3yGI8llgChhv0ByCIpZXCD97owV8uRmyMnOXVS0cOQb3B6Vw38xA3RIIOqpO5daDIFm+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4EdKHb4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709012057; x=1740548057;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qn/b7HjVZFNtZnn4ir1x6LDJOqmZ3njctEqc5QdNdeE=;
  b=e4EdKHb44pbk1qr8DISds4qqw9vM3PT+wmhu7PT2fYFzrhp7V3an87Ld
   cBllv1jbl2krW9b06NVNtCBGmuhfaZpho1cb028LaknKGt4skq+i9Fldm
   nwAPxs5f36S6ZAfpkIIUzT2Vpox5ouQo+jFfVVnbt5rHiUc50ypOiuTUR
   yJptCxCTlP7DaGHKg6oHdbBHrwhERGygya6ji4Xvkwtb9RcBPceTzHpsF
   45GCEc4WUXIdnKI+mxlZdcJsW5WQWFBXhmdgYWQXNaSTO7+1FWHlhpGDQ
   kq3fAPyOm8W+O8nnqOKjjV3XGQpcy9iSUZHlQECMybvxldrZmOl560WBd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20882223"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="20882223"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 21:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11585719"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 21:34:16 -0800
Date: Mon, 26 Feb 2024 21:34:14 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.6.y 0/6] Delay VERW - 6.6.y backport
Message-ID: <20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAG1z3WUC/x2MQQqDMBAAvyJ7diWuZbH9SukhJtt2sahsim0Q/
 26QOc1hZoMkppLgVm1gsmrSeSrS1hWEt59eghqLAzm6OCLGKB+fcRX74eDDuMz2RS5kpBB9R9d
 e2Dko/WLy1P/5vgM33GR47PsBJFakUHIAAAA=
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the backport of recently upstreamed series that moves VERW
execution to a later point in exit-to-user path. This is needed because
in some cases it may be possible for data accessed after VERW executions
may end into MDS affected CPU buffers. Moving VERW closer to ring
transition reduces the attack surface.

Patch 1/6 includes a minor fix that is queued for upstream:
https://lore.kernel.org/lkml/170899674562.398.6398007479766564897.tip-bot2@tip-bot2/

Patch 2/6 needed a conflict to be resolved for the hunk
swapgs_restore_regs_and_return_to_usermode.

This is only compile and boot tested on qemu.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
To: stable@vger.kernel.org

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Pawan Gupta (5):
      x86/bugs: Add asm helpers for executing VERW
      x86/entry_64: Add VERW just before userspace transition
      x86/entry_32: Add VERW just before userspace transition
      x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
      KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Sean Christopherson (1):
      KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

 Documentation/arch/x86/mds.rst       | 38 +++++++++++++++++++++++++-----------
 arch/x86/entry/entry.S               | 23 ++++++++++++++++++++++
 arch/x86/entry/entry_32.S            |  3 +++
 arch/x86/entry/entry_64.S            | 11 +++++++++++
 arch/x86/entry/entry_64_compat.S     |  1 +
 arch/x86/include/asm/cpufeatures.h   |  2 +-
 arch/x86/include/asm/entry-common.h  |  1 -
 arch/x86/include/asm/nospec-branch.h | 25 ++++++++++++------------
 arch/x86/kernel/cpu/bugs.c           | 15 ++++++--------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/run_flags.h         |  7 +++++--
 arch/x86/kvm/vmx/vmenter.S           |  9 ++++++---
 arch/x86/kvm/vmx/vmx.c               | 20 +++++++++++++++----
 13 files changed, 112 insertions(+), 46 deletions(-)
---
base-commit: d8a27ea2c98685cdaa5fa66c809c7069a4ff394b
change-id: 20240226-delay-verw-backport-6-6-y-2cda3298e600


