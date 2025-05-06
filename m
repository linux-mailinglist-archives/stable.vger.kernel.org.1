Return-Path: <stable+bounces-141799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988DAAAC26A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7943B766A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2DC27A923;
	Tue,  6 May 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rswc+1X3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC17282EE;
	Tue,  6 May 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530610; cv=none; b=KLXlRLRN5ShwHfbj6LKi1OA/Bg/yvasuO1HywMoOHa7h4Hn5FUU9/bawjuPc8eV0KA4uzabtB46gojIxkGY7k027Dvdv4A3ZY4Gg9K8heXlu6OAxWLdpO7/NhS+3d7qJjm5DRyxXfBKxbJ6sZQDbXWSeCsZ0OnMl4wDAQ6KW8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530610; c=relaxed/simple;
	bh=JfGn9n7xtXq88oIfWghwV1vxPHFWWIwsPGpPzWmnofo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN+JVV7APY9WqjCslmp6JcZZ+FkqmwX4FOOOs0kxYpzeX5QbY6U9aLZoliEZVNlHge2gSARJ7e8DXVMYHa0TDncFAo1/AsQieD2rwisgIWosNLwG+FTuD6RqpJY8pRTQGFO2WlNwWHin51qvnyWmA7gX1UaguMHXJJFRuCffCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rswc+1X3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746530608; x=1778066608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JfGn9n7xtXq88oIfWghwV1vxPHFWWIwsPGpPzWmnofo=;
  b=Rswc+1X3HR8PqhDJ68ICBhcRuxk2O+jMEIeau8SQxFfrmws0h9oZATJ2
   4lBSBz97pfSFqfgaMyMfqZYzGp0xgDvolPWeUrUaEx77fZmxpA/7ukAie
   FGly1uGdKWszulI83qCMhmcW5V9r/vfGsvI9pa6PlBSYEF1Ntn6gi1jsr
   SIkDQOe7+fw8yd/Grza/0qtizBxYlPXQVzv95A7CDUKf7DL94V3+Xt7dc
   +ZL7d9By1phcBUVdL/7+pkXx7cTnOOXbPGC8uPHEzsVjIXg5aTdpzDIK9
   VCMwpU66QYwplernOsPXwPdd1640K+iXpHQzIOAlHwoXN96UOhxgxd0Tl
   A==;
X-CSE-ConnectionGUID: AMk/xE5ARzSrHOZJYIcOBg==
X-CSE-MsgGUID: dUb85tSpSz2yIhk4pWODeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="65727957"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="65727957"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 04:23:28 -0700
X-CSE-ConnectionGUID: soCurtFTT0aPgSHSckSn6g==
X-CSE-MsgGUID: z91GLQMBQGSUBRLmZSjGyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="139646881"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa003.fm.intel.com with SMTP; 06 May 2025 04:23:24 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 06 May 2025 14:23:22 +0300
Date: Tue, 6 May 2025 14:23:22 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	RD Babiera <rdbabiera@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: Fix bounds check in
 process_rx()
Message-ID: <aBnxKrVxurLZ_7k9@kuha.fi.intel.com>
References: <20250502-b4-new-fix-pd-rx-count-v1-1-e5711ed09b3d@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502-b4-new-fix-pd-rx-count-v1-1-e5711ed09b3d@google.com>

On Fri, May 02, 2025 at 04:57:03PM -0700, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Register read of TCPC_RX_BYTE_CNT returns the total size consisting of:
> 
>   PD message (pending read) size + 1 Byte for Frame Type (SOP*)
> 
> This is validated against the max PD message (`struct pd_message`) size
> without accounting for the extra byte for the frame type. Note that the
> struct pd_message does not contain a field for the frame_type. This
> results in false negatives when the "PD message (pending read)" is equal
> to the max PD message size.
> 
> Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index fd1b80593367641a6f997da2fb97a2b7238f6982..648311f5e3cf135f23b5cc0668001d2f177b9edd 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -166,7 +166,8 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>  		return;
>  	}
>  
> -	if (count > sizeof(struct pd_message) || count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
> +	if (count > sizeof(struct pd_message) + 1 ||
> +	    count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
>  		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d\n", count);
>  		return;
>  	}
> 
> ---
> base-commit: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
> change-id: 20250421-b4-new-fix-pd-rx-count-79297ba619b7
> 
> Best regards,
> -- 
> Amit Sunil Dhamne <amitsd@google.com>
> 

-- 
heikki

