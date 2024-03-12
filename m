Return-Path: <stable+bounces-27526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC61A879D47
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662E0282F5E
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255114290A;
	Tue, 12 Mar 2024 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8IaHrw5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591113B2BF
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277859; cv=none; b=kTIws/9hFsRlgnDAT1nTqXQSNE2NvY33U9R88lHih0fZ3YyzKk5WtXwpwEgYqCO0R0xxYU6eHABCTd0O3g75pQISoWR7r0N1m9+6AMem3KeuWTv+G/zumazhsXeEoMxiRci2TQwBA7RVNHeNC8mbGLecpbg/qKeC1L3QRB35z7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277859; c=relaxed/simple;
	bh=qlBAjcPmIlOhvjzrXnzbZJwDSNCdsrhaj4x0+b/5wVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnDly1NkTYQa4e+Dv9cw0TMFGAXfm1HtCCo/PZjJZ1a77JBpz6NYEaj6RvHXYl8lB7ADAPKHOZprltGsaELNPY1FwVXtr59QgFJANVL31iCWLXWjBx8819Gthn7bn5t3t5lnFCyJBjc+qPa3RUnhE/WJDu4W7lqnVBK56kp3Y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8IaHrw5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710277858; x=1741813858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qlBAjcPmIlOhvjzrXnzbZJwDSNCdsrhaj4x0+b/5wVY=;
  b=Z8IaHrw58so0aHudLD3tbJA9fnLPCCNbDAtdw65rmuOIHnV8fBfVigd/
   o8vYvPiNBSVnojTw7hRFP37HYjYPpv6rHtoDvg18oxDGuMNo/88K3nHsY
   UMxHboj+VtYwz9zFytj8sd1QNzHRbVcnZUzyaEd5hxKhCihvpHB7gX3Qh
   hZJP6qaA70Wjfn8KNRsShDdPKBH2AF4EBQCpQ0+fjRCVjVjFR93yFlsOq
   dpfyTDv6R3GTS3FT4+eG9w4sCkeo1/ANxf0r2KjYUgMaIabgCf3syV9c2
   2BPW28b9uzX/9AVe9mP5wL2guurFIg8DMSnYX0w8rlYAV+hQLV8Dmc9NN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5146066"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5146066"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42609803"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:10:58 -0700
Date: Tue, 12 Mar 2024 14:10:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.15.y v2 04/11] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240312-delay-verw-backport-5-15-y-v2-4-e0f71d17ed1b@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>

commit a0e2dab44d22b913b4c228c8b52b2a104434b0b3 upstream.

As done for entry_64, add support for executing VERW late in exit to
user path for 32-bit mode.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-3-a6216d83edb7%40linux.intel.com
---
 arch/x86/entry/entry_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index e309e7156038..ee5def1060c8 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -912,6 +912,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -981,6 +982,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1173,6 +1175,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:

-- 
2.34.1



