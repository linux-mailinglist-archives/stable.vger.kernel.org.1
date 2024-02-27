Return-Path: <stable+bounces-23819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2568688AF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 06:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427FE1F226B7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 05:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA852F83;
	Tue, 27 Feb 2024 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHsWAJFp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC81DA21
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012076; cv=none; b=pQ1Sf3UxnHyxJ+xJFAV74PIYpKr9DdcW/FdMfumVAIg47IRDPJ74wWalJCQ+FTmfFUntmzGWi25W4Eph7K5KS9wC0q/gZYigLhOn8F4mUDRo64l4QLyaniH3mOtUc72+qLDvi1ML3rDiOXh2Rlod6Xx68YTDd+0Tkg6gyOzT3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012076; c=relaxed/simple;
	bh=fsxcnPQk0UIJGmhhqFWDwr0XV56vguvj6FaGU0N7fl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KihAiTmKhgMAF73U7+6sdQFMbNxSoTjSg1tbG//Sn0b11EVYQVfb6qcEAVoQ4+ZexL+uSbSrGxvMYyaJ/f6c85g7qa8ZmvF47IXr1bHKu1yCviIN4mA4t+0hFlzaTSsR9hY5zQrKH/xSxm/aFWUnrzEGAv8WvMVXNuYzNYBEj+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHsWAJFp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709012074; x=1740548074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fsxcnPQk0UIJGmhhqFWDwr0XV56vguvj6FaGU0N7fl8=;
  b=RHsWAJFpZ5smf56LEp7y5Hx/PNDcinT21bj2dP0Jdhtvhh1/7/OohoBJ
   416Gx282r0xdp7sHvzDu0ABMKGbIaS9Qk3dz7bTOX7JwBtBIy1C0lEFy8
   4oKH4diHo+kFVdPn/+QrSl+22PTxtGg0E0DjoFCeYl4hXoLeQ0N0KjLJN
   QVrzQQa1h3UwSgEH0X9uRrr66gTyuE3MbOFAb5Mgjl2cBXj0BE1jlg27T
   vk69EjdSmVmp6MgKnbjXKLfs7eSC1LXi+dY4je2psuhkkIAqAorIP5+GR
   2JX71ep2m+j8Evwh9YHw7uYsjXHjBj7Qv1De+eHUxS0As62usKLq4pFg3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20882233"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="20882233"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 21:34:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11585761"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 21:34:34 -0800
Date: Mon, 26 Feb 2024 21:34:32 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.6.y 3/6] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240226-delay-verw-backport-6-6-y-v1-3-aa17b2922725@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com>

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
index 6e6af42e044a..74a4358c7f45 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -885,6 +885,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -954,6 +955,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1146,6 +1148,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:

-- 
2.34.1



