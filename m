Return-Path: <stable+bounces-40098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E358A81B1
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 13:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F211C215A0
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B9013C825;
	Wed, 17 Apr 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jia6gPHm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACC13C80D;
	Wed, 17 Apr 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352139; cv=none; b=JTO6iww5P6pqOKzxmgVQaQSIAddBITijAAcARMRvKbuiSC3fRpMklEyVUAzaacnLUN3UY5gb+MgjtDGBS9xvufkbKv9NTFn6bfTOokRt04RlzVVQlOeGjQSD2p8M7+EoxG1wl1dolzHKFbbdTDANxxq+NElx+Oetg7hya4ET+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352139; c=relaxed/simple;
	bh=FQhALE+6s0qIVhKCT3HoFfW7JHeZPXnl/ULDZpvtXbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR5BfV52Sfs7qzS//y3/zTHgaTd0CAz3pOv5HHm6FDb2ipBsgpUPmx/iIVGOzQc7f5h7ZJ6o21bab9iTwehQAxQvdYUbx47nMSrDVReOpxOBnq+Uo7BCHNR6lvEf6nmHQ/Pfb4q9eaO5ad0kJWliq3gcJgW/ASPfPqUUgSnHy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jia6gPHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1C2C2BD10;
	Wed, 17 Apr 2024 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713352139;
	bh=FQhALE+6s0qIVhKCT3HoFfW7JHeZPXnl/ULDZpvtXbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jia6gPHmcrJH/cN92xINtIxQ6wM6GJoci08yeslnnXgrucoVD6kIhT77Jiw323XoG
	 O8SKAsQtPYjqjUT4cSd6/mvBjFxXliwloszQSPpuRR92v/631aLYBHIr92H6U5ZKX+
	 zh9n08OOgCgYUbg/gD4XhBjb80k+ihFYUajusRh8=
Date: Wed, 17 Apr 2024 13:08:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	John Youn <John.Youn@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: xhci-plat: Don't include xhci.h
Message-ID: <2024041749-cheese-schedule-d21b@gregkh>
References: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
 <900465dc09f1c8e12c4df98d625b9985965951a8.1713310411.git.Thinh.Nguyen@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900465dc09f1c8e12c4df98d625b9985965951a8.1713310411.git.Thinh.Nguyen@synopsys.com>

On Tue, Apr 16, 2024 at 11:41:36PM +0000, Thinh Nguyen wrote:
> The xhci_plat.h should not need to include the entire xhci.h header.
> This can cause redefinition in dwc3 if it selectively includes some xHCI
> definitions. This is a prerequisite change for a fix to disable suspend
> during initialization for dwc3.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
>  drivers/usb/host/xhci-plat.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
> index 2d15386f2c50..6475130eac4b 100644
> --- a/drivers/usb/host/xhci-plat.h
> +++ b/drivers/usb/host/xhci-plat.h
> @@ -8,7 +8,9 @@
>  #ifndef _XHCI_PLAT_H
>  #define _XHCI_PLAT_H
>  
> -#include "xhci.h"	/* for hcd_to_xhci() */
> +struct device;
> +struct platform_device;
> +struct usb_hcd;
>  
>  struct xhci_plat_priv {
>  	const char *firmware_name;
> -- 
> 2.28.0
> 

Seems to break the build :(

