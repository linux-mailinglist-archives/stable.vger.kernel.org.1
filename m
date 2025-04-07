Return-Path: <stable+bounces-128519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD30EA7DC83
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16AC1893638
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAF223E356;
	Mon,  7 Apr 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVdj2ZZn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AC23C8C7;
	Mon,  7 Apr 2025 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025923; cv=none; b=PivqZ0mlVxC85jQ4OC9vnLRcTgy53q5CvHIYKupYwji0qckmEeStj2hp/kFB33oYXbxikAHT8kt48hmy+UqPiUGbndVPqPC+KrJ+GAISb/PO53ZvKI8qiC7gs0rqNymFktbL8joIPKQrbqqSJkEPAU1KMBw3UCtObRCM++9ktoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025923; c=relaxed/simple;
	bh=FipsQrVxRRzx0gAaWn73bIQfIwQBi/3bfri3Exj8TG8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z2i2gnuHsDvasKwqTgVX1HmVM9zhrQm0QWxahk0CgHwu0uOn1Eknlno6IIKTBVpE/63qfOGz1svt+9iBZlc8D/n/J2buBhmQwXZAKt1FLfnqGAitP8/iFUC23LaJxIv1C/noVCc0ZQaffQvYEbN+07I0blJfDgD97iinf/fkeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVdj2ZZn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744025922; x=1775561922;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FipsQrVxRRzx0gAaWn73bIQfIwQBi/3bfri3Exj8TG8=;
  b=MVdj2ZZnUJZnMM/impXe43KlDuiRp9WDyNreI5F2ZvmoOZ8zmWyDBGBk
   7T6jUUoIsU7RisMPRKMO8yoLyDxwMVa/JY0Jg05KvEWryTLkcOS7wqB23
   fngSSLWPjk0/8ju8Vg9WC5FFPKmyQKtk9AXhwi1uxbpEhXfAh/lR3AzH8
   ACW4CqEQyUJeB+13I24fy9hMT7F3UON0tiEHI8+qcoiA+fWx4N2qnCeUX
   tiq7lOqSBG2z4oWjWgO0e2FHWReMnUQtMp95AG8Ti/LgnSRBL85u4JfYT
   4+HPTh0OtObDT//xFQX/nociTzp9KFafiUfx/u2vrZTOETUyE7xWScatw
   g==;
X-CSE-ConnectionGUID: KC86cfQ4Q9mqV1mnU1RTWA==
X-CSE-MsgGUID: lfy9t3RlQ/+g7AoH+pW2AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45425423"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45425423"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 04:38:41 -0700
X-CSE-ConnectionGUID: bnG+Jrf1Tdui82kFHrQwIQ==
X-CSE-MsgGUID: DSVfj0YUSBuCD3/pALeA1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="127814613"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 04:38:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 7 Apr 2025 14:38:31 +0300 (EEST)
To: Wentao Liang <vulab@iscas.ac.cn>
cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>, 
    ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad-acpi: Add error handling for
 tpacpi_check_quirks
In-Reply-To: <20250402143807.3650-1-vulab@iscas.ac.cn>
Message-ID: <6850403a-dba8-2334-50f7-76cda9e9685f@linux.intel.com>
References: <20250402143807.3650-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Apr 2025, Wentao Liang wrote:

> In tpacpi_battery_init(), the return value of tpacpi_check_quirks() needs
> to be checked. The battery should not be hooked if there is no matched
> battery information in quirk table.
> 
> Add an error check and return -ENODEV immediately if the device fail
> the check.
> 
> Fixes: 1a32ebb26ba9 ("platform/x86: thinkpad_acpi: Support battery quirk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 2cfb2ac3f465..a3227f60aa43 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9969,11 +9969,15 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
>  
>  static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
>  {
> +	unsigned long r;
> +
>  	memset(&battery_info, 0, sizeof(battery_info));
>  
> -	tp_features.battery_force_primary = tpacpi_check_quirks(
> +	r = tp_features.battery_force_primary = tpacpi_check_quirks(

Please don't do a double assignment. You can assign r to 
tp_features.battery_force_primary after the if check.

>  					battery_quirk_table,
>  					ARRAY_SIZE(battery_quirk_table));
> +	if (!r)
> +		return -ENODEV;
>  
>  	battery_hook_register(&battery_hook);
>  	return 0;
> 

-- 
 i.


