Return-Path: <stable+bounces-26708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A284787150F
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 06:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49681C215D8
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 05:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B044C87;
	Tue,  5 Mar 2024 05:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOfHTGFZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983F1803A
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 05:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614937; cv=none; b=sVqUAi45DJ7WLZBfxEJRjAcgLQuaIFrZXDjZqmGay1lAQd1+FkXtmTV6s9+gCqY10iH5XPs1M8cMvSfC7GEYN2XfZMQ58Vvlr1UOwWTflMrtINtpNp6R5wYsCpgUQ75XENF0CXSYmIqzjGWnEUB0y1EZbWYDrhttT+kYnqt6gmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614937; c=relaxed/simple;
	bh=qlBAjcPmIlOhvjzrXnzbZJwDSNCdsrhaj4x0+b/5wVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJWmqUaiQTirVlnjvMbJ+Ik4r+VRn+TPnCJVt/hIwA92Dh1iTkhMXFkFTe3Cq0ataH8xCIeudzF50sTTcBaoKonHSaPW5bnunSK+ZJ7MkzKcobHCQy/g+Q1aNw/mgQ5CCeXR4+mg9MAgMRWVnKmdNTdMuHOSRKdo95UO8g2Xkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOfHTGFZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709614936; x=1741150936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qlBAjcPmIlOhvjzrXnzbZJwDSNCdsrhaj4x0+b/5wVY=;
  b=jOfHTGFZPXJ7Pv43JDnwj5FU8UmQfMv2kkh+S+latTT2AxzULjgiRIu+
   TsVjLldOZbqL+8MeNM2fCJmpq+cGt8nESZZQStknWRWqy+RlX2CAFj7JS
   +TE8DqKf6eDDOiIek4Rq6+cLC8TH0u2LTyXM3BHmjVPJlrBdZbHCsNz11
   okYLYdoS7WjNdXbp7wOya0Ddk0uwHX4u5FAH3O/fXL4vELa0NroqCAppL
   Jk/XbdDRCtzIuZ8KZRiFZ3w2nip6TVX+yl4TP754CLc/Gc9GR72bTyCyI
   HduGEg+H/8CjEWI0G0pnXJFezESsE8AX+bprmNF5Q9k+CMhoaqFvVftzB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15285275"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="15285275"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:02:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9822713"
Received: from egolubev-mobl.amr.corp.intel.com (HELO desk) ([10.212.137.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:02:16 -0800
Date: Mon, 4 Mar 2024 21:02:15 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.15.y 4/7] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240304-delay-verw-backport-5-15-y-v1-4-fd02afc00fec@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>

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



