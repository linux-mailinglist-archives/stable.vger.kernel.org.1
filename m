Return-Path: <stable+bounces-126007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B5A6F19F
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0958188D13F
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38651EFF85;
	Tue, 25 Mar 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBgiS/uH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5C2E337C;
	Tue, 25 Mar 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901496; cv=none; b=JfKOEliJ27jGtc+HayQNxw7Yv5EVDnC0YXSVwyfhN8XHTA2AS/+DxdRvtqFVqrZpmXtt2RUXrGxrygAghRBxBQmVvh3KwcHL1LzNHn4CGx6wBHPvFLyOi++LuY1n1/XJMQkXb+TPbSKB50rFeyGWmUPSLUsyPAKLeXkGdK6ymNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901496; c=relaxed/simple;
	bh=YKEx+3kZIuqatXHZs92dkeyJl2HsuW8fMwoN685s2eM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W/Wd0gT5lJv42ebPoitQAQqk/7QlAFRrWmmihdWgOkDKZu47dhZQb7QoEyf+8D7EXHH4Hl6j2/1LGAtB+jg8hHg0Q7SWk0WKzsMMhWDLSaIx4zRoA+Ip1Pqq4TbH/8aac/Fnucm00I1E0f3uGulD2k3S6x6vAjdBQ64y/4+EJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBgiS/uH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742901495; x=1774437495;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YKEx+3kZIuqatXHZs92dkeyJl2HsuW8fMwoN685s2eM=;
  b=NBgiS/uHfWGA1UQXzMRjaVTxN3Cgs7+DWwX8i6OeFKGmpBvsjgIQSp/H
   O5VCLiQRXmFWv47aG8OVryUxwWFal9EFUp7OG2Ij+FY7Q/UzuJBB/mr0D
   XTV6EhErUxOENFATrwoihtzXZnWVcbSAQpcL8pRosgPdPaeT/QN/XVdf4
   E3lyZLDcOBrlsNEoNVImZHp4GMLRkL1LJyrKe8TWLmEnUAXxn0QrxUGsI
   dkZDxQrnUdOtMon8N3xxgGeZge0uiEU/SJ88KpwsxjykCF73UriMxtUiU
   48FUIwZeHWv2OlrgKzwmZNQpQEfyLyovWWKXdf+jnFq4wRedi+4gZegz1
   w==;
X-CSE-ConnectionGUID: mfGZA3zaTHeEGYztOec0pg==
X-CSE-MsgGUID: xdSb7O34TDisk3Z6Bfyg2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="61533507"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="61533507"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:18:14 -0700
X-CSE-ConnectionGUID: ETlaG+zjShyFflCXccd3gQ==
X-CSE-MsgGUID: GG82ann7Qt2dq55Y88P8Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="129175108"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.158])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 04:18:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 25 Mar 2025 13:18:08 +0200 (EET)
To: Denis Arefev <arefev@swemel.ru>
cc: Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] asus-laptop: Fix an uninitialized variable
In-Reply-To: <20250325095739.20310-1-arefev@swemel.ru>
Message-ID: <88f06d15-0f98-2f24-7e68-eefb6434f108@linux.intel.com>
References: <20250325095739.20310-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Mar 2025, Denis Arefev wrote:

> The value returned by the acpi_evaluate_integer() function is not
> checked, but the result is not always successful, so an uninitialized
> 'val' variable may be used in calculations.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b23910c2194e ("asus-laptop: Pegatron Lucid accelerometer")
> Cc: stable@vger.kernel.org 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/platform/x86/asus-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index d460dd194f19..b74b7d0eb6c2 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -427,7 +427,7 @@ static int asus_pega_lucid_set(struct asus_laptop *asus, int unit, bool enable)
>  static int pega_acc_axis(struct asus_laptop *asus, int curr, char *method)
>  {
>  	int i, delta;
> -	unsigned long long val;
> +	unsigned long long val = PEGA_ACC_CLAMP;
>  	for (i = 0; i < PEGA_ACC_RETRIES; i++) {
>  		acpi_evaluate_integer(asus->handle, method, NULL, &val);

Shouldn't you handle the error from acpi_evaluate_integer() properly 
instead?

-- 
 i.


