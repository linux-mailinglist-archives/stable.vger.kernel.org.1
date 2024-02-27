Return-Path: <stable+bounces-23806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BC886886F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 06:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425591C21FEF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 05:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF6524BB;
	Tue, 27 Feb 2024 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdBjHJhR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF94C3CD
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010052; cv=none; b=lq/7uxJ5P/F274WQAtqcZpVtV0Ui3syNbJZjJpDeRF0e6nCNHwc5qDz5abHQXfd3OJibkBDtncWKBxRbtHX4z/knBe6cXDSZmsGUM7zVQQEMnTB4Rh90kc9q2/jzgGx4MQ6Q/Gwl6IBYw1iaFWyAniFCQSUbn5QewPuyCJInRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010052; c=relaxed/simple;
	bh=PDVtojUPF72yT35lz76VTXlVUpb+BOhydXPy9mp+JyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZehzMyDpcbzaY2ApD1U3eOvaU1LCzK1dAw8Tk4yRVURssG3t57YMZLhCU/+2WvMEnugAox+EZur/ydMfGMHppbUZBFiNrDyDlOg5Wdp14SySPqnAapAWeqHPyjjC8ypUorxWivO1Odgbo8jfK4Vq5nTThO36w7BvUR7aAFGNlCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdBjHJhR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709010051; x=1740546051;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PDVtojUPF72yT35lz76VTXlVUpb+BOhydXPy9mp+JyM=;
  b=UdBjHJhR8FMRBQMg/cYdtYM2VhIDKQmLhCvPldgz94KkEu0TkMmH2rOf
   p2wpaoALu3CJdBhdQMM3tWGWHyoL5Qy4WALCyr5Og0Vj9ZKoREhs6qAZ2
   SPCLbRXmorSkVKvp+rDXBPnG9CgtprNI4GJZBuZtYvV7iuHFjx7wVGLwV
   pB2SdhPqrJSPPCcuCOmSk4BTGEYOIMYyMkOjgxZ1sbkICU+caxoR3Oj5k
   5eQp333l8ceNQ6eEPc/F2aVWtEwAYun796HtTZ2kS9Cp4PPnODks2mLKP
   JMw77ZXdJoHyErQRp0JywiJv3TXgm4J4SUh9z/RRBoZ5kI1Roj/dgRYiU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13886435"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="13886435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 21:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11509171"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 21:00:48 -0800
Date: Mon, 26 Feb 2024 21:00:47 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Cc: Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.7.y 0/6] Delay VERW - 6.7.y backport
Message-ID: <20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAFFp3WUC/x3MQQqDMBBA0avIrDuSTiVir1JcJHHUQVGZiDaId
 2/o8i3+vyCyCkd4FxcoHxJlXTKejwLC6JaBUbpsIEOVIbLY8ewSHqwnehembdUdLdaY0FHwr56
 s942B3G/KvXz/7w/Ysi4TtPf9AxvoQ8RyAAAA
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
base-commit: b631f5b445dc3379f67ff63a2e4c58f22d4975dc
change-id: 20240226-delay-verw-backport-6-7-y-a2cb3f26bb90

Best regards,
-- 
Thanks,
Pawan



