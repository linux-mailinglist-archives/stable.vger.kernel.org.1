Return-Path: <stable+bounces-65479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265C4948DB3
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 13:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48CC1F24BB4
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB11C233E;
	Tue,  6 Aug 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OF+Vycns"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B41BD015;
	Tue,  6 Aug 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943836; cv=none; b=DEorPImABkM0/pdk3/pTAVigBEEGsMyIUnM0GUeV6DeIlqdKB0m8WGkeQ3o7MUWfyNrYRmNFGtRKxn1XolQqP4X2SP8Z4BdRKxMFcA7QEH50+1bATOJgFdv+IfDaL1vInyOin4jHN3WwB1FoiqO15Sbvu/SGwY7WsGSkZpluOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943836; c=relaxed/simple;
	bh=IwL2QjC0w8fShIeDbhbbpIeCelIOZ+vlqPl9bgGH2Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qssKONkndyED4LFTQUhJPEnlRFhxUaqWU4cZA+nJYBZdw3rW70VO2ByhhhCO758YXFiqtSfqZHeOyIsWPctR49mGQhA322CFXXHEvxsmBZQhKdNMCJADyz2XX+t4EBtxlEPRNA6b7j9na0H+tt+2tPay2Co+A29TzrHyJ9fUT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OF+Vycns; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722943834; x=1754479834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IwL2QjC0w8fShIeDbhbbpIeCelIOZ+vlqPl9bgGH2Mo=;
  b=OF+Vycns1kBAF1YFSVFBzUBv7pOb9LH9HBMe+7jvs3AJimrH8JmBA3wI
   iY2mpUEleX8mdxH7zAlIRt/vz48tDmiTfkkQ77DQWxROeaL52Gvdupe17
   CxVFXpvL0IhMVgE8GWYrwrcEjRA9rwLhbkfw+/MDVA75XN5zEkO0zwERM
   nYm9PYMHkgDPZBq5QF30VhyMwyKnP9qXZExOmXv9m8p2ZXjXLqb3c2w3w
   Wj9D4czJiCsKUCHZ3FdCF0BKZrALiTGGSPd66QcUKF1kKkjeAq23DoSpT
   NlmJuIIfxEQHCs204mXU0EMJm8QeTjtfsWmopXdYKyMTZbDHSsWKkmiBp
   A==;
X-CSE-ConnectionGUID: O6xVGt5nTOCzC0NjdNkgdg==
X-CSE-MsgGUID: jxQ2IQ9GRuWre3RCb9HXxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21075053"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21075053"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:30:02 -0700
X-CSE-ConnectionGUID: CSgCT9V9Qnqp6JT5Tcl4jA==
X-CSE-MsgGUID: cbpHyyRoQ+K/JsHD1l2kLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="61109552"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa004.fm.intel.com with SMTP; 06 Aug 2024 04:29:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 06 Aug 2024 14:29:58 +0300
Date: Tue, 6 Aug 2024 14:29:58 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-usb@vger.kernel.org,
	Luciano Coelho <luciano.coelho@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix a deadlock in
 ucsi_send_command_common()
Message-ID: <ZrIJNjHYTdMsXeno@kuha.fi.intel.com>
References: <20240806112029.2984319-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806112029.2984319-1-heikki.krogerus@linux.intel.com>

On Tue, Aug 06, 2024 at 02:20:29PM +0300, Heikki Krogerus wrote:
> The function returns with the ppm_lock held if the PPM is
> busy or there's an error.
> 
> Reported-and-tested-by: Luciano Coelho <luciano.coelho@intel.com>
> Fixes: 5e9c1662a89b ("usb: typec: ucsi: rework command execution functions")
> Cc: stable@vger.kernel.org

This does not go to the stable trees after all. The regression is in
v6.11-rc1.

I'm sorry about that.


> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index dcd3765cc1f5..432a2d6266d7 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -238,13 +238,10 @@ static int ucsi_send_command_common(struct ucsi *ucsi, u64 cmd,
>  	mutex_lock(&ucsi->ppm_lock);
>  
>  	ret = ucsi_run_command(ucsi, cmd, &cci, data, size, conn_ack);
> -	if (cci & UCSI_CCI_BUSY) {
> -		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false);
> -		return ret ? ret : -EBUSY;
> -	}
> -
> -	if (cci & UCSI_CCI_ERROR)
> -		return ucsi_read_error(ucsi, connector_num);
> +	if (cci & UCSI_CCI_BUSY)
> +		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false) ?: -EBUSY;
> +	else if (cci & UCSI_CCI_ERROR)
> +		ret = ucsi_read_error(ucsi, connector_num);
>  
>  	mutex_unlock(&ucsi->ppm_lock);
>  	return ret;
> -- 
> 2.43.0

-- 
heikki

