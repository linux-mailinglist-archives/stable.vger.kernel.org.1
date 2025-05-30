Return-Path: <stable+bounces-148139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C7FAC8816
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 08:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6291BA32E3
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 06:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898361DE2A7;
	Fri, 30 May 2025 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPECMaHI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E13155C87
	for <stable@vger.kernel.org>; Fri, 30 May 2025 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748584917; cv=none; b=aoFqHiFFZNvl8iMW8LxNC7ddjuPSA9H39tWANbeDuohQEeCxweYwRrFe+4auug977NsoooF605wLrUYjmdtomDTnuJ+1pUMm5WjMkZF/s/5JzFjyW+CDNxCKCGUrOp1gcBy+BmAoW2qFhz//hiQ7yrZvuxhvhuwlRk+EJXS0Na4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748584917; c=relaxed/simple;
	bh=h6yKK3JxUf7eqCUqwK8AF1MSQ6ZkPApyAtDaC01/X5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BpEmkwPyixZWrmo/8tI1u3hkRj5T+aNU2kVlULYdq+2c8/9EKhvkcU0uACbCW203knAwkuarZY6avLBnCk6y7CDjesfBsnJv40r44x+172/2f0ZgTpsks4hv7JlWxFQKmNARZSeXpoeOXNMN0D077MrkwAovfwSkL+5eLK2G5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPECMaHI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748584915; x=1780120915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h6yKK3JxUf7eqCUqwK8AF1MSQ6ZkPApyAtDaC01/X5g=;
  b=GPECMaHIW46ZId4I5HZTn9u9gVjozuN1nIav24BTHAdZCu0K+ceP/f9q
   xvY9wCmbJ8rHRC75BuB9eEfE2S/ePLm41alAf+4MC/h/ZfCJjaP2RWivz
   GjIzdsh8YD80sIzEMses65101Dn3gNDkietwOL+sGqgmEHil/eL/AbO7u
   ds1XJVdQCYKgMJQIFOFPpQlpCFLI4ErL4qSX4ctVOqiFsSKlrBmVPPsXy
   brxnafjdV1o8ZfSBGAfaSXbE3NhDQ4CBeihNNHaPCxxgbCLfsV1jT/pRH
   IyDPCiIcD0CyAQusfnqDnS7bqip2Glga+A1lThQL0C2MnGY3Ckxhsmzaf
   Q==;
X-CSE-ConnectionGUID: 9iSnz3/oTpiEefakrS+JpQ==
X-CSE-MsgGUID: 7VoSjDiERLq7x7++PvGwzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50817308"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50817308"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 23:01:54 -0700
X-CSE-ConnectionGUID: fMXbMREzQUSqF6aY5Obncg==
X-CSE-MsgGUID: xiRVesRmRzqKPYzfC3Hexg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="143694229"
Received: from drlynch-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.32])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 23:01:55 -0700
Date: Thu, 29 May 2025 23:01:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Richard Narron <richard@aaazen.com>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15] x86/its: Fix undefined reference to
 cpu_wants_rethunk_at()
Message-ID: <8c84125f71aec2fd81adf423dbc12156ac11706a.1748584726.git.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Below error was reported in a 32-bit kernel build:

  static_call.c:(.ref.text+0x46): undefined reference to `cpu_wants_rethunk_at'
  make[1]: [Makefile:1234: vmlinux] Error

This is because the definition of cpu_wants_rethunk_at() depends on
CONFIG_STACK_VALIDATION which is only enabled in 64-bit mode.

Define the empty function for CONFIG_STACK_VALIDATION=n, rethunk mitigation
is anyways not supported without it.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 5d19a0574b75 ("x86/its: Add support for ITS-safe return thunk")
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/stable/0f597436-5da6-4319-b918-9f57bde5634a@roeck-us.net/
---
 arch/x86/include/asm/alternative.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 1797f80c10de..a5f704dbb4a1 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -98,7 +98,7 @@ static inline u8 *its_static_thunk(int reg)
 }
 #endif
 
-#ifdef CONFIG_RETHUNK
+#if defined(CONFIG_RETHUNK) && defined(CONFIG_STACK_VALIDATION)
 extern bool cpu_wants_rethunk(void);
 extern bool cpu_wants_rethunk_at(void *addr);
 #else
-- 
2.34.1



