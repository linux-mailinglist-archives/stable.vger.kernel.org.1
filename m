Return-Path: <stable+bounces-45646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDA8CD098
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63AE1F2323D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 10:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB680031;
	Thu, 23 May 2024 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1Km9hZX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DC7E578;
	Thu, 23 May 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461126; cv=none; b=PvV020xXA4gPuTrhdPrF1cx+duWU2k2FpjIOUfkSbL6Eb38+OxcfXYVZly8jYx85WUJa7tiWeOUccwCyoYAfWjap3W8gBs+qNcnmvm/diW6ZsC9p/0vbvcTPE7GjNXAdauDJt7/gKWgUvsOlWrrAJVUNV+hZbGdwwHHFpqHvFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461126; c=relaxed/simple;
	bh=LtY8Bz+UluFBG0jjCCt3DnEDxvwmGzf99HLmzlygbLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG4sfTvlZAPliYVJ99BQurE8fx1kUa8jaV/QnkOYWSB4Jfmg6og/jxx7Ifc3NS5VzExwrzKnPB1Gs4BPXmyyMe84PSLX69D8PdyGTCD26nL2lztbR8DGPcVVHBU00kxvgmWS1DaFvPAMNZLCJXMFqyBQCV52WTFEYGaXYzfDKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1Km9hZX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716461125; x=1747997125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LtY8Bz+UluFBG0jjCCt3DnEDxvwmGzf99HLmzlygbLM=;
  b=B1Km9hZXEd1yyra9efTJxSKlJHJhKeV8sNWwwdbhaVbAYLOeFzsPObt8
   lOztWamRk5kgP9SQsUTKNJnt4St9iQtysJ00zBuzDOmtsnzcSP/U1B4N5
   LcgnYLiDNHl58dszcRMVNXFrPbPAZXKANn1FAVSenKFqrmEBiJGHMTkNI
   qqXkvT9ZokcY7rcDAINEN4h9fe92n/RUD5nAKGfcLb7QdeOGaoVGbEeXQ
   0zDiNJaTFC80EqKlwAudShDmwMoZizcMhJ/bCp5l8jIilFSwN1n0bt9eN
   WwtwuhtmbNlyjtWyK2PaPhL60KBIN/iOvUU+8+s4coXVOaS5CKxpd4KPs
   w==;
X-CSE-ConnectionGUID: sWF1JENRROaZIQpHIvFUmw==
X-CSE-MsgGUID: zSa5XzlYQoOgenI4LUAHhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12618665"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="12618665"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 03:45:24 -0700
X-CSE-ConnectionGUID: kvvoQ6EWSX+QP0nghq9u5A==
X-CSE-MsgGUID: oau7CDpaSw6+uKqQbRblqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33699104"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 03:45:23 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 9742311F82A;
	Thu, 23 May 2024 13:45:19 +0300 (EEST)
Date: Thu, 23 May 2024 10:45:19 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: tomas.winkler@intel.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, hao.yao@intel.com,
	stable@vger.kernel.org, Jason Chen <jason.z.chen@intel.com>
Subject: Re: [PATCH] mei: vsc: Don't stop/restart mei device during system
 suspend/resume
Message-ID: <Zk8eP2-UEPSxv42v@kekkonen.localdomain>
References: <20240516015400.3281634-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516015400.3281634-1-wentong.wu@intel.com>

Hi Wentong,

Thanks for the patch. I thought something like this would indeed have been
possible.

On Thu, May 16, 2024 at 09:54:00AM +0800, Wentong Wu wrote:
> The dynamically created mei client device (mei csi) is used as one V4L2
> sub device of the whole video pipeline, and the V4L2 connection graph is
> built by software node. The mei_stop() and mei_restart() will delete the
> old mei csi client device and create a new mei client device, which will
> cause the software node information saved in old mei csi device lost and
> the whole video pipeline will be broken.
> 
> Removing mei_stop()/mei_restart() during system suspend/resume can fix
> the issue above and won't impact hardware actual power saving logic.
> 
> Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")

I think this should be instead:

Fixes: f6085a96c973 ("mei: vsc: Unregister interrupt handler for system suspend")

As this fix depends on the previous not-quite-as-good fix.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> Cc: stable@vger.kernel.org # for 6.8+
> Reported-by: Hao Yao <hao.yao@intel.com>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>
> ---
>  drivers/misc/mei/platform-vsc.c | 39 +++++++++++++--------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
> index b543e6b9f3cf..1ec65d87488a 100644
> --- a/drivers/misc/mei/platform-vsc.c
> +++ b/drivers/misc/mei/platform-vsc.c
> @@ -399,41 +399,32 @@ static void mei_vsc_remove(struct platform_device *pdev)
>  
>  static int mei_vsc_suspend(struct device *dev)
>  {
> -	struct mei_device *mei_dev = dev_get_drvdata(dev);
> -	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
> +	struct mei_device *mei_dev;
> +	int ret = 0;
>  
> -	mei_stop(mei_dev);
> +	mei_dev = dev_get_drvdata(dev);
> +	if (!mei_dev)
> +		return -ENODEV;
>  
> -	mei_disable_interrupts(mei_dev);
> +	mutex_lock(&mei_dev->device_lock);
>  
> -	vsc_tp_free_irq(hw->tp);
> +	if (!mei_write_is_idle(mei_dev))
> +		ret = -EAGAIN;
>  
> -	return 0;
> +	mutex_unlock(&mei_dev->device_lock);
> +
> +	return ret;
>  }
>  
>  static int mei_vsc_resume(struct device *dev)
>  {
> -	struct mei_device *mei_dev = dev_get_drvdata(dev);
> -	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
> -	int ret;
> -
> -	ret = vsc_tp_request_irq(hw->tp);
> -	if (ret)
> -		return ret;
> -
> -	ret = mei_restart(mei_dev);
> -	if (ret)
> -		goto err_free;
> +	struct mei_device *mei_dev;
>  
> -	/* start timer if stopped in suspend */
> -	schedule_delayed_work(&mei_dev->timer_work, HZ);
> +	mei_dev = dev_get_drvdata(dev);
> +	if (!mei_dev)
> +		return -ENODEV;
>  
>  	return 0;
> -
> -err_free:
> -	vsc_tp_free_irq(hw->tp);
> -
> -	return ret;
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(mei_vsc_pm_ops, mei_vsc_suspend, mei_vsc_resume);

-- 
Kind regards,

Sakari Ailus

