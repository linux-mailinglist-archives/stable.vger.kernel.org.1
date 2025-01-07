Return-Path: <stable+bounces-107821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A4DA03BEC
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 11:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239CC3A0869
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 10:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F6D1E47C2;
	Tue,  7 Jan 2025 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+6N6C3/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BCD1E2859;
	Tue,  7 Jan 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736244708; cv=none; b=Z1pbNY+Gwe1hSAnWEovbQJLhOobO8m+lWCSwSaBPmgJ9xgCjCKTDSLoLpfLjIHGEcaoaQ+TvRINt0+0n0c0Swt6FNueWplrCiHAxpod0Uh4gDI6/UkKjpYT2/GwaNCJXtdDcGZFtaE8OuAcaONLdjM4PSlXBycwybVY3CJ6CPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736244708; c=relaxed/simple;
	bh=U8nJTewkDyyYy5u5lCfEQFdF5V6Q9fjiIvWY8TDclPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th8fFtFKxALdgtyk/WzmTUUK37mVyKV+eZW4vTdJSM1hRWLenNWvwn3fvwDUFHEVPhjyNZiVO662fyhnw82LAEZYBCrD1MP/xI9PjH0qq4IU+JehJE1iVo+rmsBUGW34AtmonR1sObC86F67wg06+HRG7E/W4EANE8rrjJA3M4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+6N6C3/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736244705; x=1767780705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U8nJTewkDyyYy5u5lCfEQFdF5V6Q9fjiIvWY8TDclPw=;
  b=I+6N6C3/V9oI0UKOtsXNCA44ZqNjrn7CZuhoSVWI3kyU7d/gnbVg67mJ
   d9ZivhZS0vcC7t2uy1SNkc4LiPC2jfmZdBampLvUlwK3mvo3Mqz0rXOea
   6rcny3Rsc30rKH889hMqGfPf4P9PRehRSR/D+EODwEkVRXI1rRHd2tqgJ
   v4BlfztTKbtW9m69yqVw3j5X2O+e7hM2brA2HW7ZQnL7ZucSF4wUBkpLk
   j3D0uA2h4+rgWzmA924aTVtIqABKqqkU55h52I2wIFHspuKQdIiGoYh5j
   NtYS6Xfc42136p/8up37iAfbRv1woqplG7QM9saXN+dpEV1vMTF2Ou8JT
   Q==;
X-CSE-ConnectionGUID: IQNOwXIRRGC2biXMtFWCzQ==
X-CSE-MsgGUID: wiAnwkCpRw2mDSvblydBcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="40365223"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="40365223"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 02:11:43 -0800
X-CSE-ConnectionGUID: 2Wi28eQ+RryDKL4VApcqMw==
X-CSE-MsgGUID: 91LuMaFZQ2y63nqpwoDRaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="107783107"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 07 Jan 2025 02:11:40 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 07 Jan 2025 12:11:38 +0200
Date: Tue, 7 Jan 2025 12:11:38 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: joswang <joswang1221@gmail.com>,
	Badhri Jagan Sridharan <badhri@google.com>
Cc: dmitry.baryshkov@linaro.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: typec: tcpm: set SRC_SEND_CAPABILITIES timeout
 to PD_T_SENDER_RESPONSE
Message-ID: <Z3z92o0XlaqXLwrb@kuha.fi.intel.com>
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

+Badhri

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

This looks okay to me, but let's get comments from Badhri, just in
case.

thanks,

-- 
heikki

