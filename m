Return-Path: <stable+bounces-54889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E57D913965
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2D11C2108A
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50A82C67;
	Sun, 23 Jun 2024 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMT9NTFw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5F199BC;
	Sun, 23 Jun 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719137307; cv=none; b=tnQWhIhqI9bjCggEogw6xJk7d0i9cAIhJsw/UNVyY6rs30kRWavicQq3a78m4R7wNGaMcdH0u6538fM4pwfeXzoQvPysg7AUbRlOn07VC8JNoFbh8YXJrEK0KbQw8lKILjOaa2xd8CWwfwKWIrj6Kw7JeuMhAufWYXkuXjzRu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719137307; c=relaxed/simple;
	bh=yrcaQyTNB3G6zc1bO5I/I2TqROA9PlAjQKpzjiDZRB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc0ztOif4aAEcOu/lZ64vXBt5KgjJY4ycmHJQeRUvrkmI2dpT6fDOC6bas4+pW7zh2wGnvU11VRQR4GYy8x4S7o6J3onnJip4YT/VGB7ZjdJX7xJ1lp0d3BBNc45/4giqjhJN67sUnuvePfP+iHIinrqnN1pf7YwRRELRZLTrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMT9NTFw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719137306; x=1750673306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yrcaQyTNB3G6zc1bO5I/I2TqROA9PlAjQKpzjiDZRB0=;
  b=mMT9NTFwC7W5QoAL0Dm6mwN1WVc+0L+f70E+Dhrkeklsa0ukBDXtzJGJ
   WexqH6OGdFiXFm30TQX+sYPBYAn+sD5ACiDg1Q4LsxrttuSCJ0VTdhzt6
   N+KfOPLbkua7loYsx6dpiEvft61OpmwRcjyw4zLLK9ymAsJalB9r/c3E2
   1V8P6gOeHxjKFmG8iYm3y2lWoN79xBXX2yX6+zlRX+8pPvO8wsUqQL+p+
   JENTBnuFNaQVnW33mnVaUu0cVM2pudDonbFLAId/GRi44PwXWYiqAUC6I
   iN0EIBRfxYxp9dbpTAkVBROLlcYnnjqm8hMEs9eIF6s1HkvEp78E/2fov
   g==;
X-CSE-ConnectionGUID: 0H9YkdFEQtu72yFx/WsMgQ==
X-CSE-MsgGUID: 45BaOdVbRpC+k+12RbvzTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="15948298"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="15948298"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 03:08:25 -0700
X-CSE-ConnectionGUID: 9me+/fzoSsi7ZAYWyzT6lA==
X-CSE-MsgGUID: NpkEe/FPQ52m+BjtV2SMUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="47476664"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 03:08:23 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 13E6D11FA94;
	Sun, 23 Jun 2024 13:08:21 +0300 (EEST)
Date: Sun, 23 Jun 2024 10:08:21 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH 6/6] mei: vsc: Fix spelling error
Message-ID: <Znf0FavptG0qVgDJ@kekkonen.localdomain>
References: <20240623093056.4169438-1-wentong.wu@intel.com>
 <20240623093056.4169438-7-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623093056.4169438-7-wentong.wu@intel.com>

Hi Wentong,

On Sun, Jun 23, 2024 at 05:30:56PM +0800, Wentong Wu wrote:
> Fix a spelling error in a comment.
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8+

There's hardly a need to cc this to stable.

> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>
> ---
>  drivers/misc/mei/vsc-fw-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
> index 596a9d695dfc..084d0205f97d 100644
> --- a/drivers/misc/mei/vsc-fw-loader.c
> +++ b/drivers/misc/mei/vsc-fw-loader.c
> @@ -204,7 +204,7 @@ struct vsc_img_frag {
>  
>  /**
>   * struct vsc_fw_loader - represent vsc firmware loader
> - * @dev: device used to request fimware
> + * @dev: device used to request firmware
>   * @tp: transport layer used with the firmware loader
>   * @csi: CSI image
>   * @ace: ACE image

-- 
Kind regards,

Sakari Ailus

