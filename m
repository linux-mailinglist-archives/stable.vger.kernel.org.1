Return-Path: <stable+bounces-196721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFDC80D0B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C6F3A6D22
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1464307AE4;
	Mon, 24 Nov 2025 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtlS8s/y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90A306495;
	Mon, 24 Nov 2025 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991578; cv=none; b=mOrTsvtTy753MlbBjzyOL+5MDE7VfD7pfJEewg79nxFdYgnkF583GJ3MUsWODMtOx8+029jbQtDZJ5R1WWIsD0lVIvUFjH6Zk9cXExsucpStqDWUdpNb0qS83tXClXhFozFl8aH2+Eb3SjYkzRSWAR1dkvn9emM5We8daSmmsIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991578; c=relaxed/simple;
	bh=N3yvsqVm0PJlZusMyFsk+KcUCnmo4tz7hXnLuS8Lf1Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oeoJRc0RyHBBAKO4MU1h2VZhTMIUUDN/LVAFWJw7RD2kmmumc+RJk6pCBQ7kC27hZ2+lQByZJpQK8+bOtv508CZIrtbfv9U8BejoWnHJ6hBnPV2znOMPmCgJlHScYywFjPGQUhOUZG6QRR4SgpPaEDqb03nrGzdw0NHoiVnYbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtlS8s/y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763991577; x=1795527577;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=N3yvsqVm0PJlZusMyFsk+KcUCnmo4tz7hXnLuS8Lf1Q=;
  b=GtlS8s/y7VHu33LaLA+jOfn3xzYVzflslJauEYiFmgpo1XuOxTAu5x5x
   bXwB9Pbj/cpfdl4fOamxXJLxVIa+ShBqtu+v+bIen3Znajb8fzr91shsd
   hmeFKyR4pdsfwJnPt11UMGAoODq070E9dTQpFIeXMbt/ycQGCFMENGD5Y
   enT2IHp1hqM1ROCtx77k5njHwsx4VJ/7u4fDXj9L1ABBxh13fQ9Xa9HZ6
   8IoXndXsd8XpYBYouRFz1TuqnDoZg/i6a5gOwkPhkmLmd8TjPnCbeoOz0
   OK9lmmVZMUMpZ8rEVoiCGDivQP75tXuO3YXpgmUTcahNtu69JNeAhWSqf
   Q==;
X-CSE-ConnectionGUID: ycr+2d0kS4yxCAySaF3UvA==
X-CSE-MsgGUID: sy+CvR5YTqWTtg5cquv0Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="83379575"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="83379575"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 05:39:36 -0800
X-CSE-ConnectionGUID: sqr3meneRlWX2YnoQ/LVzQ==
X-CSE-MsgGUID: KFq1qs2oR1KFeBa69NSZyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192142889"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 05:39:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Nov 2025 15:39:28 +0200 (EET)
To: yongxin.liu@windriver.com
cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
    david.e.box@linux.intel.com, chao.qin@intel.com, 
    yong.liang.choong@linux.intel.com, kuba@kernel.org, 
    platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] platform/x86: intel_pmc_ipc: fix ACPI buffer memory
 leak
In-Reply-To: <20251124075748.3028295-1-yongxin.liu@windriver.com>
Message-ID: <f1124090-a8e4-6220-093a-47c449c98436@linux.intel.com>
References: <20251124075748.3028295-1-yongxin.liu@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Nov 2025, yongxin.liu@windriver.com wrote:

> From: Yongxin Liu <yongxin.liu@windriver.com>
> 
> The intel_pmc_ipc() function uses ACPI_ALLOCATE_BUFFER to allocate memory
> for the ACPI evaluation result but never frees it, causing a 192-byte
> memory leak on each call.
> 
> This leak is triggered during network interface initialization when the
> stmmac driver calls intel_mac_finish() -> intel_pmc_ipc().
> 
>   unreferenced object 0xffff96a848d6ea80 (size 192):
>     comm "dhcpcd", pid 541, jiffies 4294684345
>     hex dump (first 32 bytes):
>       04 00 00 00 05 00 00 00 98 ea d6 48 a8 96 ff ff  ...........H....
>       00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>     backtrace (crc b1564374):
>       kmemleak_alloc+0x2d/0x40
>       __kmalloc_noprof+0x2fa/0x730
>       acpi_ut_initialize_buffer+0x83/0xc0
>       acpi_evaluate_object+0x29a/0x2f0
>       intel_pmc_ipc+0xfd/0x170
>       intel_mac_finish+0x168/0x230
>       stmmac_mac_finish+0x3d/0x50
>       phylink_major_config+0x22b/0x5b0
>       phylink_mac_initial_config.constprop.0+0xf1/0x1b0
>       phylink_start+0x8e/0x210
>       __stmmac_open+0x12c/0x2b0
>       stmmac_open+0x23c/0x380
>       __dev_open+0x11d/0x2c0
>       __dev_change_flags+0x1d2/0x250
>       netif_change_flags+0x2b/0x70
>       dev_change_flags+0x40/0xb0
> 
> Add kfree() to properly release the allocated buffer.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add SoC register access")
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> ---
>  include/linux/platform_data/x86/intel_pmc_ipc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
> index 1d34435b7001..2fd5e684ce26 100644
> --- a/include/linux/platform_data/x86/intel_pmc_ipc.h
> +++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
> @@ -89,6 +89,7 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
>  		return -EINVAL;
>  	}
>  
> +	kfree (obj);

Good catch but this fix doesn't address all possible paths. So please use 
cleanup.h instead:

	union acpi_object *obj __free(kfree) = buffer.pointer;

And don't forget to add the #include.

>  	return 0;
>  #else
>  	return -ENODEV;
> 

-- 
 i.


