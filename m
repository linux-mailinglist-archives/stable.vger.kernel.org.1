Return-Path: <stable+bounces-25808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10386F95E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 06:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743202816BF
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 05:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42DF566D;
	Mon,  4 Mar 2024 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Evzw9efw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF93C39
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709528908; cv=none; b=jQYvbfzlgQ/wnfpZwxfM3kDs8IJ7kOElBhOwDHC7fXN1zY4ZSoGYSh9JkhU/OBRj3I/71IznXu2Yln8FlJkmJvPy3eYPtTVAVuFK20WQCnVlOrOLweB+DHPgWF6VueCAh1UFbtTJo1E/FE/GXgjgajrGZff4uIBU0PLrf7rZ2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709528908; c=relaxed/simple;
	bh=5g305USwadF/K3iLa+/q9OuIWmkofEGcdeNRtpJ1Z60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XZsqufRzlU1fo/N7t77XkRkBncuCnPlkoUCeV0R8x0r8UVo7hsLf3Wjg0LKRGZ8ScDxsEd59Ca1UZi4QRh3A+cOvx4BMPZrN01Wn9d6Ci7Pr3ioGcYqH6uKvQClQ07fooF2E1DbL8K5tlgvVK2Gu1hiYeJ7gvPo/PQUYG3iyvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Evzw9efw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709528907; x=1741064907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5g305USwadF/K3iLa+/q9OuIWmkofEGcdeNRtpJ1Z60=;
  b=Evzw9efwBGz/qExZQbCpianp/gzTu+2JXe2pTLQwSyeK+BQPaRtszG9f
   qbO0/rT9p2B1EZZk4CHWTo3p7QBkDDw54+BsvooI+qi4I/e+PhP/xqPcE
   X490ZrAzbKnAbFtIsszcWNqeb4PpVuyf1HjkKM5m/Q7+5IMoAec3ylq/a
   zaoRsei9VvMOae1+ncI1WovYF2MHhdtUr9SSrGNrMCOvLqVd1iWIL/kfa
   osCLMzJz2Ty2G1yk2k2N2S2/32Hm8NW18SEHvX07yQjjJvCPU5PNxCmqc
   D2D/ddFNna1+2rkKpVfnMltmxZbv6F0UJzuJEHIkxkdfolFHKUtCCyuW4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4127458"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4127458"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9061290"
Received: from dhorstma-mobl.amr.corp.intel.com (HELO desk) ([10.209.64.132])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 21:08:25 -0800
Date: Sun, 3 Mar 2024 21:08:24 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.6.y v2 0/5] Delay VERW - 6.6.y backport
Message-ID: <20240303-delay-verw-backport-6-6-y-v2-0-40ce56b521a5@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAPZW5WUC/42NQQ6CMBREr0L+2t+UrxZx5T0Mi1K+0oiUtFhpC
 He34QRmVm8mM7NCYG85wLVYwXO0wboxAx0KML0en4y2ywwk6SSJFHY86ISR/RdbbV6T8zOqrIR
 kOn2k+sJKSsj9yfPDLvv2HZRQIkGT7d6G2fm0P8ZyD/8YjyVK1LqsWqqJKjrfBjt+FmHHmQdh3
 Buabdt+R+9Bks8AAAA=
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v2:
- Dropped already backported patch "x86/bugs: Add asm helpers for
  executing VERW"
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.20&id=48985d64c4c8105aa3497219df063e1489792e59
- Booted fine with KASLR and KPTI enabled.
- Rebased to v6.6.20

v1: https://lore.kernel.org/r/20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com

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
Pawan Gupta (4):
      x86/entry_64: Add VERW just before userspace transition
      x86/entry_32: Add VERW just before userspace transition
      x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
      KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Sean Christopherson (1):
      KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

 Documentation/arch/x86/mds.rst       | 38 +++++++++++++++++++++++++-----------
 arch/x86/entry/entry_32.S            |  3 +++
 arch/x86/entry/entry_64.S            | 11 +++++++++++
 arch/x86/entry/entry_64_compat.S     |  1 +
 arch/x86/include/asm/entry-common.h  |  1 -
 arch/x86/include/asm/nospec-branch.h | 12 ------------
 arch/x86/kernel/cpu/bugs.c           | 15 ++++++--------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/run_flags.h         |  7 +++++--
 arch/x86/kvm/vmx/vmenter.S           |  9 ++++++---
 arch/x86/kvm/vmx/vmx.c               | 20 +++++++++++++++----
 11 files changed, 75 insertions(+), 45 deletions(-)
---
base-commit: 9b4a8eac17f0d840729384618b4b1e876233026c
change-id: 20240226-delay-verw-backport-6-6-y-2cda3298e600

Best regards,
-- 
Thanks,
Pawan



