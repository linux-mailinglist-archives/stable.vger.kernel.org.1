Return-Path: <stable+bounces-163540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2016B0C0A0
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC29189F09B
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4828D8CB;
	Mon, 21 Jul 2025 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhpEd42j"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2028D8C3;
	Mon, 21 Jul 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091288; cv=none; b=FUKt7BRBsydFVCJRoOM4OsbSUCkoA+zA8b5n9Skbc5q2S93QSutIr1BZupvans8PbzGWsip6FlEP+gPl0NREXo6pSY+WBPA+1tnKA3YVQuUsXRv/sDIcVT4AQUjUgFwNk9Qbs3+biCgmbgG/OR7dox1PzFotU4zzK0/T/jEE4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091288; c=relaxed/simple;
	bh=IByGw2ZxVkuZD7DNtFgIg2yVP6vR9IXMunELCO9fnfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrP5jUjM7JVxG7kURnK/oacCaAtGnWNCTfNtCwQ3JcW5aRUGuDJ4baChhFideFZ25dQRKF2oEwDs9Ta6QybYXRnQLyP1/Mk1yV4l2+1zUyeF93aYvsfFtC05wSJEPvUnm755hX3ZO41VhlNy2FC4Mq2X4zLwzx5/2R2XpYj++RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhpEd42j; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753091287; x=1784627287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IByGw2ZxVkuZD7DNtFgIg2yVP6vR9IXMunELCO9fnfg=;
  b=FhpEd42jihIIS0VmQ5FtcIUoSJwSjQb5jTfe0EvE0grZAOMc8Qbi7Ngb
   1HbFWSUhqG6EA7v7In64mIZ4xS+DC0DunVqSuvrUNBVspRhqa5vNSSeJp
   nXA2jP4fK/WJbGmxsiPQT+7fSb1ZBOSdI9+NM/Msak85hfmHO8Z59iYCI
   XbtXTibG7Cao33OYGsp5dhRfdIIsfvS2elIYjSiEOVo4TKXZ+ldEooowY
   5u6vsF5yqAHrLqasxZuvm7bgIbVcZE9RTU5HSxY9m6SdnsI7mqx8/nks9
   BR/Sl3SuArikctsYPJpyy0sDKqK6OVA44+ybGHcv3zsPyex6T5rKEut4r
   Q==;
X-CSE-ConnectionGUID: ZxxV34q/TN2msjUCzp3X3Q==
X-CSE-MsgGUID: JEFu3tDBSnu4I2xC3dNcWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55243822"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55243822"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 02:48:06 -0700
X-CSE-ConnectionGUID: xou+KRvxSzSOFCV2PENd2w==
X-CSE-MsgGUID: y0U9bH/gRbS7yDDDabfaMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158847575"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 21 Jul 2025 02:48:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Jul 2025 12:48:03 +0300
Date: Mon, 21 Jul 2025 12:48:03 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Update power_supply on power role
 change
Message-ID: <aH4M074PasIlWzTQ@kuha.fi.intel.com>
References: <20250721-fix-ucsi-pwr-dir-notify-v1-1-e53d5340cb38@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-fix-ucsi-pwr-dir-notify-v1-1-e53d5340cb38@qtmlabs.xyz>

On Mon, Jul 21, 2025 at 01:32:51PM +0700, Myrrh Periwinkle wrote:
> The current power direction of an USB-C port also influences the
> power_supply's online status, so a power role change should also update
> the power_supply.
> 
> Fixes an issue on some systems where plugging in a normal USB device in
> for the first time after a reboot will cause upower to erroneously
> consider the system to be connected to AC power.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0e6371fbfba3 ("usb: typec: ucsi: Report power supply changes")
> Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 01ce858a1a2b3466155db340e213c767d1e79479..8ff31963970bb384e28b460e5307e32cf421396b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1246,6 +1246,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  
>  	if (change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
>  		typec_set_pwr_role(con->port, role);
> +		ucsi_port_psy_changed(con);
>  
>  		/* Complete pending power role swap */
>  		if (!completion_done(&con->complete))
> 
> ---
> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
> change-id: 20250721-fix-ucsi-pwr-dir-notify-8a953aab42e5
> 
> Best regards,
> -- 
> Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

-- 
heikki

