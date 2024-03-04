Return-Path: <stable+bounces-25802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17FE86F928
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 05:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE3B20AE4
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 04:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846F553A6;
	Mon,  4 Mar 2024 04:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqu4ucg9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4363D9
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526245; cv=none; b=AWUUtzZCKvS+LcZ68qMprYIxb8wqF0eBI2Q++FLY4ny6xZU9oJ9fQwB2zhMcL2EEUVdrjvpgvbpPOCiA3Z4NqXpMqJvwFC4EDPpqp5uZb/QKjQ1qeLqdrbBx25TKEEIORce06JUXnA8/BZMDv1KYEoy68C5ENECV9j2LIsA4GmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526245; c=relaxed/simple;
	bh=9Kp0f8C39I+LWoDdVPl4n9Px3yx6xYr5bjocRBrjgxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xka5X99AAwhlR71Jw8YnuJ1C5bIZWkVhB09IffNFruHr9Lgu1WtqXKFrqmUL4YYjXtwtYmdU7ooadFamjAHPvyQrWPOPRIIMvLzsCzZ/NP4dKwBqekuETbWLycSgDmjRftZYHBCNAIQbkBg143/OIUHFRWOsGT+XawKqvUU9lyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqu4ucg9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709526244; x=1741062244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9Kp0f8C39I+LWoDdVPl4n9Px3yx6xYr5bjocRBrjgxw=;
  b=lqu4ucg9ROuOeWq6/crS7j5/6r/LKIMkbN/zywbNhI9bS7dZ6VZHqAxl
   u/5786GQ9W6o9tfuWMXg6KdHNWuMCHUELfCW1kIsDdpzn5I6t7yYr5p7D
   Ahi+brPm95wHQBhCRZ0RLPVoCEkjyoFrTzl2rrR+yeCpmzUtJ6Tu1hk4E
   PVF9+wZ9PjNiGBhwTH2oTKXUW9Q3YyRYPLYFwpQc/UUvlir6KSUYjAbWu
   yYoJ6c6QeT9EdAo+1Dx3X5GshKdKNp8QztT/wJc5iyV8l1xxv0psj0clY
   cEpnKvLUjwEF00kedbYpiV0GaLww1PX3BwYjScfjpxpenffN/4ivpIDNE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3849958"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3849958"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 20:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13420745"
Received: from dhorstma-mobl.amr.corp.intel.com (HELO desk) ([10.209.64.132])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 20:24:02 -0800
Date: Sun, 3 Mar 2024 20:24:01 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.7.y v2 0/5] Delay VERW - 6.7.y backport
Message-ID: <20240303-delay-verw-backport-6-7-y-v2-0-439b1829d099@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIABpM5WUC/42NQQ6DIBREr9L8dT9BtJh21Xs0LgCx/tSCAUslx
 ruXeIIu30zmzQbRBrIRbqcNgk0UybsC4nwCMyr3tEh9YRBcNFwIib2dVMZkwxe1Mq/ZhwUltph
 RCaPrQUitrxzKfg52oPVwP0CylmXoSjxSXHzIx2OqjvIPeaqQo9LiMsimrtpa3ydyn5WRW+zEj
 H9Dt+/7DwXb75LPAAAA
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
  executing VERW".
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.7.8&id=09b0b1a090b74c9b453f9281e72289834c1a3dbb
- Boot tested with KASLR and KPTI enabled.
- Rebased to v6.7.8

v1: https://lore.kernel.org/r/20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com

This is the backport of recently upstreamed series that moves VERW
execution to a later point in exit-to-user path. This is needed because
in some cases it may be possible for data accessed after VERW executions
may end into MDS affected CPU buffers. Moving VERW closer to ring
transition reduces the attack surface.

Patch 2/7: A conflict was resolved for the hunk
           swapgs_restore_regs_and_return_to_usermode.

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
base-commit: d6d6c49dbf4512f1421f5e42896e2d70dc121f9a
change-id: 20240226-delay-verw-backport-6-7-y-a2cb3f26bb90

Best regards,
-- 
Thanks,
Pawan



