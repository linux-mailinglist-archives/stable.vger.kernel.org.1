Return-Path: <stable+bounces-23833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6BE868A50
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBD81F24BA7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281A755E63;
	Tue, 27 Feb 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AX4clb6Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962B54BCF
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020824; cv=none; b=uk2S8ExMQWCdOd4Sgq0bO9TGnuFxcqd4eTHA1TrQP0ee4dMyhscC5b6Fd/iZS4yL70L5FHqw5uji1rcecOWnXZhhLX7065pigtm5Lu/79KPuCHbr56wxK5YMYQyF0J1uQy7xeszwDN6Q9a0QhhLcfdjx4obGabLxAAajnJUeeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020824; c=relaxed/simple;
	bh=qlBAjcPmIlOhvjzrXnzbZJwDSNCdsrhaj4x0+b/5wVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbhMiJr4PloaQIk0WCK/AqLlGFHb4jKqWjPkppxaDxwvsXh00D9ukv03pwkd1j3QLiYzbvk9LxsuTB6VoXPLxxAnC8Ghu4jvFPKIJe1EV8+/1AI3purx+fXFKGt/pntjxu6DStvaB00fz7DFgjbuk4OChWHQ+pMrNjSqaq9OMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AX4clb6Q; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709020823; x=1740556823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qlBAjcPmIlOhvjzrXnzbZJwDSNCdsrhaj4x0+b/5wVY=;
  b=AX4clb6QFR0GKXGgU4okZuHj0PILLhPqQa2lQQ+eH+ffKHJphFMNYzrG
   HUgM/uYb81RCmcZT83ivc4xrb6ZTI9pHclOi4mAkA9BVI6p4LOMjDsq4V
   0WlRApDbZuE1iHo1nyuz8FeJFHNLdHpilJjdp3JtL+J4BeeqANB49mvtd
   5hxwZgRduK2FWKfRQwHTLXPdxgdoSXBlPGIzR63KzTikaD1hfS8EjP5XH
   yBJATCybAi0MVNwcCIiplUkWwAvP17ANIVApJ4DPg1tvxPL++CPhl6mUj
   Shdas0kE9EbjuhjCLGx1JYduyyfl3uyrDpNqPRwjC10aPHK7vRVQm36Mu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3464603"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3464603"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6887294"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:00:19 -0800
Date: Tue, 27 Feb 2024 00:00:18 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.1.y 3/6] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240226-delay-verw-backport-6-1-y-v1-3-b3a2c5b9b0cb@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com>

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



