Return-Path: <stable+bounces-109248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47EA138D2
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB327A2391
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C0D1DE3B8;
	Thu, 16 Jan 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlWusOUN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CED1A4F09;
	Thu, 16 Jan 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026504; cv=none; b=HvhsPUD+bT9DghOMr4JOtJcQFrjjBK3ZlA7PmehK7sFnaQeO5Q2tcVb7fM4rem5s3S8mfCEeFGiSf0kj1MX9Uip3eet1aPkcOBcrZYk4xod6ZeatolQGdvpOeRJJvY54XWK7YmhMjLQ2Gc1cOP4lUR4tXSevdzZWvS21PvWs/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026504; c=relaxed/simple;
	bh=R1lgrVf6NbLRGWPpc188JEmN0OukZASQpJVStCU3T3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eT+h97xtiDMODN9d+Wk829kPWL7KuMx3ESuabYRzlM7SDoq5Zmtkp29qkHebiS/PjSkJsnWw54aah410LfrN6RFuPu6/Y00tUDNKoCj5gW7NXd5uvgnhFjKK7RdF6IKHdExc0ro55U2zqu80z/OqaG7WhLh/CE+dZhS9jCR/EOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlWusOUN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737026503; x=1768562503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R1lgrVf6NbLRGWPpc188JEmN0OukZASQpJVStCU3T3w=;
  b=nlWusOUNrGF4RI/BD77ajGqBGEe/0XomtcERGUJj1nbERIM0sZv8YuIV
   yv5B5vDW76vhCUe9Z/S36VEw/6JQ4m4dupPhMNgC1Dyq6oGAByoRzuF5s
   V5vRb3Xy/020F8vaHlz6s8szV0J9VmQm+r3i73mOjcmeWAQPHaK/QUd5b
   b1Qr22B6uzTXWZAZ0TSTMybiewje4RWqSd1MSCNfNH8Yeu4IdTqRp55Rv
   dYpXBMU8JcgfqSimpj/8SC75uqDqnvBZ9jx/H6rbl1n+iLfaMh3HlJO3n
   zE5x1sFZKL8hVHFrzOv+Pt54P5pVM2T8boNne1f+m1jDItcDhzQFzNUIR
   g==;
X-CSE-ConnectionGUID: 3RmRtJV6S92MRILSDSWYsg==
X-CSE-MsgGUID: 4cRFjDsnTJCaxGS/SAszhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="41172502"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="41172502"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 03:21:41 -0800
X-CSE-ConnectionGUID: QFa8FCdnS5G8PMYxOvCVXQ==
X-CSE-MsgGUID: XEBn2x/yTMKKt5NbfjZJQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128721524"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa002.fm.intel.com with SMTP; 16 Jan 2025 03:21:38 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 16 Jan 2025 13:21:37 +0200
Date: Thu, 16 Jan 2025 13:21:37 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: joswang <joswang1221@gmail.com>
Cc: dmitry.baryshkov@linaro.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: typec: tcpm: set SRC_SEND_CAPABILITIES timeout
 to PD_T_SENDER_RESPONSE
Message-ID: <Z4jrwSOBSXrZakRy@kuha.fi.intel.com>
References: <20250105135245.7493-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105135245.7493-1-joswang1221@gmail.com>

On Sun, Jan 05, 2025 at 09:52:45PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> As PD2.0 spec ("8.3.3.2.3 PE_SRC_Send_Capabilities state"), after the
> Source receives the GoodCRC Message from the Sink in response to the
> Source_Capabilities message, it should start the SenderResponseTimer,
> after the timer times out, the state machine transitions to the
> HARD_RESET state.
> 
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 460dbde9fe22..57fae1118ac9 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4821,7 +4821,7 @@ static void run_state_machine(struct tcpm_port *port)
>  			port->caps_count = 0;
>  			port->pd_capable = true;
>  			tcpm_set_state_cond(port, SRC_SEND_CAPABILITIES_TIMEOUT,
> -					    PD_T_SEND_SOURCE_CAP);
> +					    PD_T_SENDER_RESPONSE);
>  		}
>  		break;
>  	case SRC_SEND_CAPABILITIES_TIMEOUT:
> -- 
> 2.17.1

-- 
heikki

