Return-Path: <stable+bounces-77735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDFE986924
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 00:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED642860F1
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB38153BC1;
	Wed, 25 Sep 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQ0HeytU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D371148838;
	Wed, 25 Sep 2024 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303142; cv=none; b=Mygbbv3u+1i+rTWm9hi1RFEYWpgE8mStFkQMx1O1sMObwNrDM+fhhfEfSZXp4B6qE8GebxGwiA6XfW8hfU3nfRmKmIs1MWo/xI8rnhebJAy9MGjLdzUYbtuFVYxD/eodEqAhB++H7m03FkmJmaUKGgEKbnAw5sM/pa5b4Tphj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303142; c=relaxed/simple;
	bh=OduRHAVBGOjYFmib5cZvnd9hU/f1pWV6cNPWVVpgWck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je+wClwSPcYOZ+zN6doEzkFgQuz6gLDNTCnDUPOtP8PRX5NMmxHkeu51wEbVu4ABhT3YMZelaR0zN7yWfMxjLOOtB2Y4E46fnmuoiHeJuuIhIvaj/kMOKXijDbo4ZvUrEDK57MGHygGm6xMhW3Ot8oHCXcheNAc8ZCjipp8eqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQ0HeytU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727303141; x=1758839141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OduRHAVBGOjYFmib5cZvnd9hU/f1pWV6cNPWVVpgWck=;
  b=OQ0HeytUAPRAkjdeffHDIX3F90jCI0o918G3mqJlh5llAcZ65w24UW49
   E0qr87qohfXxBaAJ4OiHcNnSl6VYPVM2aKBNqq6mAS0skJz+LK14VId9K
   XNjRFBTgGqY7GkFcQhxWbXmntbTi/awOW0iEuN3Y/tgGQRwYbYNqIPN7B
   L8mtDI5Ts1Ngb6TU4LTChB05dApls9f7SwMswBTMkj421eeewH1zbydq3
   /CGnD4xnDQWNwGJYwq73sEaHE+jFWonzGnDvlX55KHSThsmCyc5qI2a5Z
   fKA98dVO2CpHliMB0iflrVHpgbzUycC4Da26YDWh6ubsP0h92lGdU8Rza
   Q==;
X-CSE-ConnectionGUID: Nixj/67cQcq/p1oGcfKt+w==
X-CSE-MsgGUID: gLxGSkLmRZuThyHFsXlmOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="43895126"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="43895126"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:25:40 -0700
X-CSE-ConnectionGUID: ylRPP6vTTViXmAkOvhxqFg==
X-CSE-MsgGUID: XqEOZxuLTpWVGAux8F33RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="71929250"
Received: from fecarpio-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:25:39 -0700
Date: Wed, 25 Sep 2024 15:25:38 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: [PATCH v7 1/3] x86/entry_32: Do not clobber user EFLAGS.ZF
Message-ID: <20240925-fix-dosemu-vm86-v7-1-1de0daca2d42@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>

Opportunistic SYSEXIT executes VERW to clear CPU buffers after user EFLAGS
are restored. This can clobber user EFLAGS.ZF.

Move CLEAR_CPU_BUFFERS before the user EFLAGS are restored. This ensures
that the user EFLAGS.ZF is not clobbered.

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Reported-by: Jari Ruusu <jariruusu@protonmail.com>
Closes: https://lore.kernel.org/lkml/yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com/
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814efbff6..9ad6cd89b7ac 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -871,6 +871,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Now ready to switch the cr3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	/* Clobbers ZF */
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
@@ -881,7 +883,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.

-- 
2.34.1



