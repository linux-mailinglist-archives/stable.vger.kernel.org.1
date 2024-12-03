Return-Path: <stable+bounces-96305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6179E1DAF
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DAABB62FD9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1411EC012;
	Tue,  3 Dec 2024 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5EhhMPn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304C13B2A8;
	Tue,  3 Dec 2024 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230141; cv=none; b=oDcVjzaVsuL25WUXAO5oJhHbJnU+hMlS8YRWCcMfREkIE+0U5V5/0sYegGCwDQywmH2oCpGiESAxTOFO0hlZuRCyseqHJJJKygxtD5w7Z8uEQGcay5ziWkBOqqW1MtU9NNfTbC+1iHFweg8IwLHg0oR+E1+3Tz8gmAJtI2Q1ym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230141; c=relaxed/simple;
	bh=x79f+c+3iq1bx+rKcEWlbRI4VgwvmHa5W+XtZ2zIDvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRRtRaCN1Z68vDYeQFxBZs4jc8CKTaUP5AI+PL2MvqapqrTJSnEVS4rx/iJiWX3d+G3qylPAiXSgz9oJpTwUbd/ZrrWGtC4Nd3QACcA3CZarPRzzRDf+oqAQvZd+apypWRK3gOzsss8SM4HGLSo2Qu87MbI/LtgZjcASFNvCZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5EhhMPn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733230140; x=1764766140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x79f+c+3iq1bx+rKcEWlbRI4VgwvmHa5W+XtZ2zIDvg=;
  b=k5EhhMPnp8qXSw/WPEEuPzNMFzUAgCF5hWkXlhCp2c3cKgFwkGzOOIFE
   /PrEBYyvmG2RHja7rXvZFj0c0ry7BwTOyfyq2x1jxu6byDF8LD7VNHatT
   leBVP9MNZwZXRNDGOcm7h5K8Ei4nIXdtROiNHB1/gjYf6r3mCfjiwinn9
   OwgT/hfoGYIKImjJ82pbnNUUi9DjrSM45btBD9hxqRRigBZ6p2FvPVOpb
   ivU3tq7iw/Jt+U3Csfvb4KXVDRu+8zaw8ASnvF52JcsI2I2ljQb4oBvkr
   DdS4QwRqTw1a45X6IZq7s/ofRIzgB1aw7DBWZqWy7oYLg+HRqRUhGtB65
   w==;
X-CSE-ConnectionGUID: 6nnHXxdOS7er+h/pK7v+Ig==
X-CSE-MsgGUID: LhBoEKyNQsW+b08YCsrwNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="55925899"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="55925899"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 04:48:59 -0800
X-CSE-ConnectionGUID: z31j7FK4QoeBt1aP3Lfg7A==
X-CSE-MsgGUID: qO8nMRooRdK84etLT1ahoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93313995"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa010.jf.intel.com with SMTP; 03 Dec 2024 04:48:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Dec 2024 14:48:55 +0200
Date: Tue, 3 Dec 2024 14:48:54 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: Fix completion notifications
Message-ID: <Z07-NoXOTO0yJNKk@kuha.fi.intel.com>
References: <20241203102318.3386345-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241203102318.3386345-1-ukaszb@chromium.org>

On Tue, Dec 03, 2024 at 10:23:18AM +0000, Łukasz Bartosik wrote:
> OPM                         PPM                         LPM
>  |        1.send cmd         |                           |
>  |-------------------------->|                           |
>  |                           |--                         |
>  |                           |  | 2.set busy bit in CCI  |
>  |                           |<-                         |
>  |      3.notify the OPM     |                           |
>  |<--------------------------|                           |
>  |                           | 4.send cmd to be executed |
>  |                           |-------------------------->|
>  |                           |                           |
>  |                           |      5.cmd completed      |
>  |                           |<--------------------------|
>  |                           |                           |
>  |                           |--                         |
>  |                           |  | 6.set cmd completed    |
>  |                           |<-       bit in CCI        |
>  |                           |                           |
>  |     7.notify the OPM      |                           |
>  |<--------------------------|                           |
>  |                           |                           |
>  |   8.handle notification   |                           |
>  |   from point 3, read CCI  |                           |
>  |<--------------------------|                           |
>  |                           |                           |
> 
> When the PPM receives command from the OPM (p.1) it sets the busy bit
> in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
> command to be executed by the LPM (p.4). When the PPM receives command
> completion from the LPM (p.5) it sets command completion bit in the CCI
> (p.6) and sends notification to the OPM (p.7). If command execution by
> the LPM is fast enough then when the OPM starts handling the notification
> from p.3 in p.8 and reads the CCI value it will see command completion bit
> set and will call complete(). Then complete() might be called again when
> the OPM handles notification from p.7.
> 
> This fix replaces test_bit() with test_and_clear_bit()
> in ucsi_notify_common() in order to call complete() only
> once per request.
> 
> This fix also reinitializes completion variable in
> ucsi_sync_control_common() before a command is sent.
> 
> Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com

> ---
> 
> Changes in v2:
> - Swapped points 7 and 8 in the commit description
> in order to make diagram more clear. 
> - Added reinitialization of completion variable
> in the ucsi_sync_control_common().
> ---
> 
>  drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index c435c0835744..7a65a7672e18 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -46,11 +46,11 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>  		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>  
>  	if (cci & UCSI_CCI_ACK_COMPLETE &&
> -	    test_bit(ACK_PENDING, &ucsi->flags))
> +	    test_and_clear_bit(ACK_PENDING, &ucsi->flags))
>  		complete(&ucsi->complete);
>  
>  	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> -	    test_bit(COMMAND_PENDING, &ucsi->flags))
> +	    test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
>  		complete(&ucsi->complete);
>  }
>  EXPORT_SYMBOL_GPL(ucsi_notify_common);
> @@ -65,6 +65,8 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
>  	else
>  		set_bit(COMMAND_PENDING, &ucsi->flags);
>  
> +	reinit_completion(&ucsi->complete);
> +
>  	ret = ucsi->ops->async_control(ucsi, command);
>  	if (ret)
>  		goto out_clear_bit;
> -- 
> 2.47.0.338.g60cca15819-goog

-- 
heikki

