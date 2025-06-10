Return-Path: <stable+bounces-152248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E1AD2AD7
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 02:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4101891E36
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 00:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9722338;
	Tue, 10 Jun 2025 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9QQcFpn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788E171CD;
	Tue, 10 Jun 2025 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749514629; cv=none; b=EiUjJLSPDokYzHQqwtuMyFaf1RoozlaACVNKD1ry0S/+HMzG3eyEQGQKtbK6Eb6nen9eRZXJBTmNg8jloCOelqVGNeiNDaSRYceJlfuMPOaYw361H9e6c3F2KRPpH4lK6pPXWnxETMVY6mZRhC70Ye87dWJ9RYj1FlQ5UIqswdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749514629; c=relaxed/simple;
	bh=TcK7wpbOO+Rouc2siLvE+OIFL+Jnwa3T6Apwy8d4Ppo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9EdNW8kkd/7JLthT0YWHKDpkDknXgCgue44A6WFwVBgaxUY4lwujZoybXItbeNKi6VBJuJxSM3UvNXwRqu6NjMBIszaRMcCrlSmP8Hzx+LuiRkcIPnb3c7+3RqYDAKqRgwXk1NwqYsVNW14BsZNpz2dttFcSPu80lbHIfd3GOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9QQcFpn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749514628; x=1781050628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TcK7wpbOO+Rouc2siLvE+OIFL+Jnwa3T6Apwy8d4Ppo=;
  b=W9QQcFpnBFLCr6uPb5weFZ6ZtqkkCFjYSnv0ZSoIL4UNMvvgp7ocNY1L
   MngGoU5daXF0rP2tpJGNMeXJlrv8teQtdDXL4tJkYPcm/jUWZqnZE8GOA
   PhdOFWOTwbb4huezs+54h0u3zMewya3aNfztlTzWleDL4brj36GATAh2A
   nOXMyatTX2eFM4c97r0Xr49IspXdiH/4gE2ZXA5RrWxwZDe/VJhxi1fVo
   W/J3oGEUvLs3S+P7B+23sVZTFCy6PipKL7GXJn24sbBWSuFMzmi3kq+jN
   b7I49P2ZMdQPYPMEC+fnOdxPwFZh8I4N615J7zdZ905krg0Po3ydsYyG5
   w==;
X-CSE-ConnectionGUID: BYQBaoU0S5SQRuDnm8i6tA==
X-CSE-MsgGUID: hDU2HX5wStyuJYjOGvJ+hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62265718"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62265718"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 17:17:07 -0700
X-CSE-ConnectionGUID: 9sRVPtChRi2F9h/cq3zDhw==
X-CSE-MsgGUID: AjEJhfx5SW+N+y2KvZ/atA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146643364"
Received: from pparames-mobl.gar.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.247.96.79])
  by orviesa009.jf.intel.com with ESMTP; 09 Jun 2025 17:17:03 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com,
	Sean Christopherson <seanjc@google.com>,
	Chao Gao <chao.gao@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] x86/fpu: Ensure XFD state on signal delivery
Date: Mon,  9 Jun 2025 17:16:59 -0700
Message-ID: <20250610001700.4097-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sean reported [1] the following splat when running KVM tests:

   WARNING: CPU: 232 PID: 15391 at xfd_validate_state+0x65/0x70
   Call Trace:
    <TASK>
    fpu__clear_user_states+0x9c/0x100
    arch_do_signal_or_restart+0x142/0x210
    exit_to_user_mode_loop+0x55/0x100
    do_syscall_64+0x205/0x2c0
    entry_SYSCALL_64_after_hwframe+0x4b/0x53

Chao further identified [2] a reproducible scenarios involving signal
delivery: a non-AMX task is preempted by an AMX-enabled task which
modifies the XFD MSR.

When the non-AMX task resumes and reloads XSTATE with init values,
a warning is triggered due to a mismatch between fpstate::xfd and the
CPU's current XFD state. fpu__clear_user_states() does not currently
re-synchronize the XFD state after such preemption.

Invoke xfd_update_state() which detects and corrects the mismatch if the
dynamic feature is enabled.

This also benefits the sigreturn path, as fpu__restore_sig() may call
fpu__clear_user_states() when the sigframe is inaccessible.

Fixes: 672365477ae8a ("x86/fpu: Update XFD state where required")
Reported-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/lkml/aDCo_SczQOUaB2rS@google.com [1]
Tested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/aDWbctO%2FRfTGiCg3@intel.com [2]
---
 arch/x86/kernel/fpu/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ea138583dd92..5fa782a2ae7c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -800,6 +800,9 @@ void fpu__clear_user_states(struct fpu *fpu)
 	    !fpregs_state_valid(fpu, smp_processor_id()))
 		os_xrstor_supervisor(fpu->fpstate);
 
+	/* Ensure XFD state is in sync before reloading XSTATE */
+	xfd_update_state(fpu->fpstate);
+
 	/* Reset user states in registers. */
 	restore_fpregs_from_init_fpstate(XFEATURE_MASK_USER_RESTORE);
 
-- 
2.48.1


