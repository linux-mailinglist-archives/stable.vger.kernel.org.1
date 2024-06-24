Return-Path: <stable+bounces-54979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B67EC91443A
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 10:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD81B2295B
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 08:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DF3487A9;
	Mon, 24 Jun 2024 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRZ4cJ0d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9C1F93E;
	Mon, 24 Jun 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216469; cv=none; b=nfKLkdtUOZZSIaZnJI8S+hg6Bo+15Iwq9ixUUkQccQrguuGqO7IuXiQShlc+Apu53y27ao3NyzRgdlzRVMcz4gIGbqgKOAnQA5bYbnVVGJunBfWFBMCQ1bixPYqn2MXWnfiuSOiSCL8KtqeW7DJh+1sUzXF7mzf9SJj4goSsx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216469; c=relaxed/simple;
	bh=9c5oNZS+LjHH9na3DaPVfqiVtLQU+XdlPYhiu+MRJ28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4+TcCPI6gY8oj5eharPhCuKB5zJpHqvk8/P6OYG6SQIT2HCezZCOkX0SdKIVrto/efhs0SbDppklMvE+na+hljKcINNm4x7xrEV3lBSc0V6Df6DJcuzLMPUaVU0rFXC9YW0ZpV0/eI+px5O6vLEwoq9cPMkdQsQJwdriqteq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRZ4cJ0d; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719216468; x=1750752468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9c5oNZS+LjHH9na3DaPVfqiVtLQU+XdlPYhiu+MRJ28=;
  b=gRZ4cJ0dVJzcCl9tIq8UffVG9H7k7I1wQIIPh0SqI5sgHEHw691hppfT
   5nofj8G8sRfC4zSV0zaEWAzyTouqWcSgZy4GQdmmofWq0LlCs3ytvkceJ
   nIIbTurJ6wP4Vgr4efFXSCid60xXncGmelIhm4Cc/st6vY5x5HfYqxPhi
   j6BjJYLhfY69ZGTvdQ+HZOqji+oAzo8h1w0u+5eY3Gelcm2jMUSdVcNgR
   5EH54pj9QdODjDNnmAS3+cuS1b5CGJwOo/07E25KYqyRNWtE+77s3FXpm
   PqL2nnH7EYkGw/zGbU/5dYNl3XTRu0qr2kOwCgnX9Gj1QSUAdJiga0WwP
   Q==;
X-CSE-ConnectionGUID: 49PhHZ3MSleKXrVAk6GUBw==
X-CSE-MsgGUID: 23tEh7f+QGiixPNX23JjWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="33716755"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33716755"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:07:47 -0700
X-CSE-ConnectionGUID: MQvdXJ9TSkKVqXhme9l+hw==
X-CSE-MsgGUID: Bt7kKibZQGOUh8mDi6jAmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43318449"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:07:46 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C6EC011FA94;
	Mon, 24 Jun 2024 11:07:42 +0300 (EEST)
Date: Mon, 24 Jun 2024 08:07:42 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH v2 2/5] mei: vsc: Enhance SPI transfer of IVSC rom
Message-ID: <ZnkpTmeuHI53xrmf@kekkonen.localdomain>
References: <20240624014223.4171341-1-wentong.wu@intel.com>
 <20240624014223.4171341-3-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624014223.4171341-3-wentong.wu@intel.com>

Hi Wentong,

On Mon, Jun 24, 2024 at 09:42:20AM +0800, Wentong Wu wrote:
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
> index 5f3195636e53..fed156919fda 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
>  		return ret;
>  	}
>  
> -	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
> +	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : ibuf, len);

The latter ibuf should be NULL explicitly.

>  	if (ret)
>  		return ret;
>  

-- 
Kind regards,

Sakari Ailus

