Return-Path: <stable+bounces-197575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3153BC91875
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2048A4E3245
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F0307AFC;
	Fri, 28 Nov 2025 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNHN7Agz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AF221FB4;
	Fri, 28 Nov 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323656; cv=none; b=KPEgvnxXRzo1K7i1lg883/0GbRl8yNDuAAllAr1Fk6+oxbSBhClE7d29pusmbYcrO57Q3h68TrxElTEIRQC6XMhU+CvOKxDwqGiscHVNZETn6qTquBX0uDBqjtmZCEuLiCksoGZXD5+MEEKNeT17PAMNU0b4/5NlUaNDdHUubxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323656; c=relaxed/simple;
	bh=cCaovgPy60ze+udjrzKZrBRHOZZjE+uRfiTspW5X9M4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VzBxWt7kK1qsgOqRGG8TQcEBOJtT2gU0nTT10GnpM7I9AUb+8nTE8c4/uy/HZ/M1b79j+a+JDLWvFx6Pfy7kafFw5wGsziddW/GQTSGb9N2sIYA4vJgiOy3KKjLJe2zB2BIwqVD2xwcZ0kIzLwqzFNoEt28TxTR4YG/uu8w9mxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNHN7Agz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764323655; x=1795859655;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cCaovgPy60ze+udjrzKZrBRHOZZjE+uRfiTspW5X9M4=;
  b=cNHN7AgzdPnwxqQ82JdcP9JEnm6nPDsFEGEdKrcvviOdBqJLLp8kYBZo
   7Wl+2HiJQkHQo+vMfnDGj2qmpa+DMfAo3TkvifsQNxMUzAyWR+yliRkkg
   0sUQdIZob28/tgZUds8wCWoqoAc45nr9POeihcPaG9zYmseTy1pBmR4Ui
   za823P0w+4nE6wXDpuF+bj3lgy3PNZgKf355jhpUkl05s7GmEPbj/hqUw
   4JNZ8Fbz+H8Mpz1/8F3q/LS8fdhYE2zZKLcjsEpmQ0fWGiQ5qy+GjsqJP
   v5F0HsHWuNGa7t97arg+9i8QO1pBHbEQMqETEnTyvZfKWnFRP2PBckmXi
   g==;
X-CSE-ConnectionGUID: OwtWOcM6RF6EWei51pqp6A==
X-CSE-MsgGUID: Pi81CLXeRoCM1gd9LwjG/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66520776"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66520776"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 01:54:14 -0800
X-CSE-ConnectionGUID: ic6Rd41TTBe5f4Y/bmTTxw==
X-CSE-MsgGUID: FXtRcpi4S7qAfTR9kHXGZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="193428734"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.229])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 01:54:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 28 Nov 2025 11:54:08 +0200 (EET)
To: yongxin.liu@windriver.com
cc: platform-driver-x86@vger.kernel.org, david.e.box@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>, andrew@lunn.ch, kuba@kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: intel_pmc_ipc: fix ACPI buffer memory
 leak
In-Reply-To: <20251128033254.3247322-2-yongxin.liu@windriver.com>
Message-ID: <42e5a7c5-4d18-4e89-07c0-fdfb2b3bc28e@linux.intel.com>
References: <20251128033254.3247322-2-yongxin.liu@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Nov 2025, yongxin.liu@windriver.com wrote:

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
> Add __free(kfree) for ACPI object to properly release the allocated buffer.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add SoC register access")
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> ---
> V2->V3:
> Use __free(kfree) instead of goto and kfree();
> 
> V1->V2:
> Cover all potential paths for kfree();
> ---
>  include/linux/platform_data/x86/intel_pmc_ipc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
> index 1d34435b7001..cf0b78048b0e 100644
> --- a/include/linux/platform_data/x86/intel_pmc_ipc.h
> +++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
> @@ -9,6 +9,7 @@
>  #ifndef INTEL_PMC_IPC_H
>  #define INTEL_PMC_IPC_H
>  #include <linux/acpi.h>
> +#include <linux/cleanup.h>
>  
>  #define IPC_SOC_REGISTER_ACCESS			0xAA
>  #define IPC_SOC_SUB_CMD_READ			0x00
> @@ -48,7 +49,7 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
>  		{.type = ACPI_TYPE_INTEGER,},
>  	};
>  	struct acpi_object_list arg_list = { PMC_IPCS_PARAM_COUNT, params };
> -	union acpi_object *obj;
> +	union acpi_object *obj __free(kfree) = NULL;

Please declare it where the value is getting assigned to it like I 
instructed in v1. While not strictly necessary here, I want us to 
reinforce the only correct pattern to use cleanup.h helpers at every
usage site.

The placement matters when there is more than once cleanup.h thing done 
within a function. The cleanup order depends on the order you declared the 
variables.

>  	int status;
>  
>  	if (!ipc_cmd || !rbuf)
> 

-- 
 i.


