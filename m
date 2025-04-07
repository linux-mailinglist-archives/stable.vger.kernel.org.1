Return-Path: <stable+bounces-128585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB879A7E6E1
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5787A3B0EB5
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39C20C022;
	Mon,  7 Apr 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id35yZj5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6F20A5C1;
	Mon,  7 Apr 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043457; cv=none; b=oAQReDo9CBTGlPSkUgv3jKjmwjyxWFmgpu0t2Tl/t2DIqLZ6rGxaj21VJi59SOZ3WQgZwmeF4oCYrXhs2Zi5gZebAMsxFSXJPQKPCH0Y28tQuhH4Tg1KBDc7Uzf5SO86YRs1MyqyV9alW1qnbkKlEEauNO4KEk3iCOHABVk+f3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043457; c=relaxed/simple;
	bh=4/eAx+z1rDRdsY31wrNn05fNKOvEcgHJxmNn4FBwm1I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IyLTw8s8/uLBDv7lxxB6809dojT3jy4jQVl4/8QhR9pXDpg9bt3F54nH78LNbcykm1oMvSc2uWPyGlxU/7EYdp1ul6M79Suso747PwT9h1ADipAKkb4W2eQxKo3ckF8zlZNGWRR6LgIeM/kGAxUfa4wi/zuzMIS89eY6MGYj7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id35yZj5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744043455; x=1775579455;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4/eAx+z1rDRdsY31wrNn05fNKOvEcgHJxmNn4FBwm1I=;
  b=Id35yZj5VKerWDkxdLiSKwbrTg7ldsRaNfY606L0StXEtWPy0bliyTHx
   BwQ9cmewqvQSz0w2PZ4l5euVQlGBCmfsAmon1z9k81n3ANSCw0StCXIy5
   FXg4yko84ycnyKKesm+arT13EhkZ0yQzwY98lSTnMZcRIoQyzDQDAEDCP
   LHfMh15WJcVqh/EoFpazKfJ2pjXLWWwyPCkUAoi3wO1jQKkqjwHFOnNa/
   zXEfbwYzUo1j8DP5oIVao7coClroiXpuknxISAbLYC2WAdcaUNt78rrOh
   uTbFLIC7+atAWjComla7/HiaqTrBOz4SfxGSN5kK6D0xLI3yK9nG7v3ks
   Q==;
X-CSE-ConnectionGUID: m1rNArxSQMyl7/02Z/AVog==
X-CSE-MsgGUID: cwYVJULVShGmvehojvR4mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44688022"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="44688022"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 09:30:54 -0700
X-CSE-ConnectionGUID: tM1YoT8rTMqNJJUKCooyyg==
X-CSE-MsgGUID: 3ORR2AfjQyq8TdXQSCUtHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="127764730"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 09:30:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 7 Apr 2025 19:30:47 +0300 (EEST)
To: Wentao Liang <vulab@iscas.ac.cn>
cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>, 
    ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: thinkpad-acpi: Add error check for
 tpacpi_check_quirks()
In-Reply-To: <20250407135808.2486-1-vulab@iscas.ac.cn>
Message-ID: <32dfd23a-7fa2-77d7-b4e5-3cfa90933ff5@linux.intel.com>
References: <20250407135808.2486-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 7 Apr 2025, Wentao Liang wrote:

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
> v2: Fix double assignment error.
> 
>  drivers/platform/x86/thinkpad_acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 2cfb2ac3f465..93eaca3bd9d1 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9973,7 +9973,9 @@ static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
>  
>  	tp_features.battery_force_primary = tpacpi_check_quirks(
>  					battery_quirk_table,
> -					ARRAY_SIZE(battery_quirk_table));
> +					ARRAY_SIZE(battery_quirk_table))

Fine, using the same variable is okay but this will fail build as remove 
that semicolon.

> +	if (!tp_features.battery_force_primary)
> +		return -ENODEV;
>  
>  	battery_hook_register(&battery_hook);
>  	return 0;
> 

-- 
 i.


