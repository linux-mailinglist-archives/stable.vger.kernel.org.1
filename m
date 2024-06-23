Return-Path: <stable+bounces-54890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AFE913967
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 12:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300181C210C1
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95658ADD;
	Sun, 23 Jun 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eo1GdwMa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1B2F2D;
	Sun, 23 Jun 2024 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719137374; cv=none; b=K3FbJAxhISCsom53ET+7TZ+oIoAzT4mf1sMbQnRgDTrWSNoqdElsJD01vq/zMZx8Lu8OgI4Zsxkiy6H2MsTWBQ/HCXQLrDzN+VpEglFpo8Uc02al/3XGWNEjVoDhYjkv1B27tSJ182HUVZscVsklXvRb98S2kX/R+m/ZmteLlDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719137374; c=relaxed/simple;
	bh=T0x51yyktXNOggWHnfyO0OzgkzeHLVtKDWKvNhSjOUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWg+R+D+CBZ+Gj/ZebjFLBLrgBDcxui4dabuH8gQIUnuNE9FcWHkTxO0cZrdYpzg0bsGm4zeWt0twHEADW2hlyO/ihdcWfT1yauX+/wE62zIokToKQnJ+5abeoqpWkYTXitcm3qsbo+cSCpwscaX7pyoTtTDNWkU2tLAFeNr0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eo1GdwMa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719137372; x=1750673372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T0x51yyktXNOggWHnfyO0OzgkzeHLVtKDWKvNhSjOUk=;
  b=Eo1GdwMafwHfpisJc3Qaz+4wBNfr03Dd5ZxtvIgroO5UV3RA6Qtc4Cd7
   1fBU3WStQqNPeiKXwmzg/2clzQXltxbcRZ0diCktNiKInBhOVYwLmsLSO
   xi7IieDri9WzTJsovgxws5oqteqkzq08jH5mxN1d3gW+UIuauJVzg0Obk
   0ep+BgIP29sq8AwujhGQLb/7DS4P7I0I+gNIFBvA/ZSVBpoSMEps4Uiz3
   QcP61zWs7FYcwxjnTxXFuOl2HumEKqIKS1wfG08ISGJ2dA9BEgAaS2c2C
   goYfN1jNt21ObZLLzYkp5rfRquU3pjP8CtGk/arjNAyxXb/7LlUDhTQjC
   w==;
X-CSE-ConnectionGUID: mdSt4kg2RumN1kMnU3ZRlg==
X-CSE-MsgGUID: pGP58yhBRtKEUL/y8ChmQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="27533383"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="27533383"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 03:09:32 -0700
X-CSE-ConnectionGUID: cMYYwD0yS4ODMyZpawmBig==
X-CSE-MsgGUID: 201nCYB1SAqVeXO7OUnNUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="66256182"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 03:09:30 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6FB9211FA94;
	Sun, 23 Jun 2024 13:09:27 +0300 (EEST)
Date: Sun, 23 Jun 2024 10:09:27 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH 3/6] mei: vsc: Enhance SPI transfer of IVSC rom
Message-ID: <Znf0V9roQaUDu7_b@kekkonen.localdomain>
References: <20240623093056.4169438-1-wentong.wu@intel.com>
 <20240623093056.4169438-4-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623093056.4169438-4-wentong.wu@intel.com>

Hi Wentong,

On Sun, Jun 23, 2024 at 05:30:53PM +0800, Wentong Wu wrote:
> Constructing the SPI transfer command as per the specific request.
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8+
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>
> ---
>  drivers/misc/mei/vsc-tp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> index 4595b1a25536..7a89e4e5d553 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
>  		return ret;
>  	}
>  
> -	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
> +	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : ibuf, len);

Is this correct? I.e. use ibuf when it's NULL, otherwise use tp->rx_buf?

>  	if (ret)
>  		return ret;
>  

-- 
Kind regards,

Sakari Ailus

