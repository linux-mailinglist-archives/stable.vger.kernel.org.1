Return-Path: <stable+bounces-144284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82485AB6072
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 03:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F583177C56
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 01:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F334D14D2BB;
	Wed, 14 May 2025 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE6eQ9nB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294E3C00;
	Wed, 14 May 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747186150; cv=none; b=aGUFu/+8DfGgjANzurCqiUGmxGtfaJBw0Og+G2bkswBljy6Mgwms9ugy7Uy3bDfwg/AkexriWYKE06NBPGa5kLRu7uRNX+MCWtWa4B+omqhtNfvPNAptiWUaQfpSWtBiYThfytj1Od50xMFxhu3bchUppOVZwpUbfi09TDHLLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747186150; c=relaxed/simple;
	bh=eO7mKv1YT1/mJYncjN+haZ+QIoFNpinoMkZuKwUqknY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkNZIHcoXVggYpN9asDPHBZ6TD7w4BkmbA0Nbyk5IiPMeYZqMVGb1HLue8W6Wyo7R9ImBIap8rrNEdoDPI+2i3jKIuTAIXs6icZSeUoEAyT7/YaORleAebIznKdSLkGd/M1657PoCuwapL7QIYmSXkkZ3U0daW9tJUvwiBZyYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE6eQ9nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2100AC4CEE4;
	Wed, 14 May 2025 01:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747186149;
	bh=eO7mKv1YT1/mJYncjN+haZ+QIoFNpinoMkZuKwUqknY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bE6eQ9nBPoZt7V6l9fIIem1TS4bvnJP5gdi/DY7Fgy1sZpWP7aNwkO8jaDuhqatBM
	 pKMLW61eHY30FWqsmYfYtuZxnLSgqzX7QJwPq6JxRg66u7mvBFih99Egrrx6qIRKKi
	 MkXDdVM3idPGjCMT5jQa737aXmBx7C1TP+lzwTSPexc2LJ62GfWXiJ4PQECwKrTfa+
	 nune5gCN71vpLVwS6Ws7aCjdzTXLl41abdMZKGPGBm19VcLsObPWlMYel/QSA4aEhq
	 4rakbPFDjQiXkHvyf0U4TAscHhUHWcSSfegKb25u4X1agO3AAmnOtB3wW/MO0oYWci
	 EVpOBB35PLHBg==
Date: Wed, 14 May 2025 09:29:01 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Fix issue with detecting USB 3.2 speed
Message-ID: <20250514012901.GB623775@nchen-desktop>
References: <20250513065010.476366-1-pawell@cadence.com>
 <PH7PR07MB95387AD98EDCA695FECE52BADD96A@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95387AD98EDCA695FECE52BADD96A@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-05-13 06:54:03, Pawel Laszczak wrote:
> Patch adds support for detecting SuperSpeedPlus Gen1 x2
> and SuperSpeedPlus Gen2 x2 speed.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 3 ++-
>  drivers/usb/cdns3/cdnsp-gadget.h | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 52431ea41669..893b55823261 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -29,7 +29,8 @@
>  unsigned int cdnsp_port_speed(unsigned int port_status)
>  {
>  	/*Detect gadget speed based on PORTSC register*/
> -	if (DEV_SUPERSPEEDPLUS(port_status))
> +	if (DEV_SUPERSPEEDPLUS(port_status) ||
> +	    DEV_SSP_GEN1x2(port_status) || DEV_SSP_GEN2x2(port_status))
>  		return USB_SPEED_SUPER_PLUS;
>  	else if (DEV_SUPERSPEED(port_status))
>  		return USB_SPEED_SUPER;
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index 12534be52f39..2afa3e558f85 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -285,11 +285,15 @@ struct cdnsp_port_regs {
>  #define XDEV_HS			(0x3 << 10)
>  #define XDEV_SS			(0x4 << 10)
>  #define XDEV_SSP		(0x5 << 10)
> +#define XDEV_SSP1x2		(0x6 << 10)
> +#define XDEV_SSP2x2		(0x7 << 10)
>  #define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0 << 10))
>  #define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
>  #define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
>  #define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
>  #define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
> +#define DEV_SSP_GEN1x2(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP1x2)
> +#define DEV_SSP_GEN2x2(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP2x2)
>  #define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
>  #define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
>  /* Port Link State Write Strobe - set this when changing link state */
> -- 
> 2.43.0
> 

-- 

Best regards,
Peter

