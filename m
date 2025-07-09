Return-Path: <stable+bounces-161413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA745AFE548
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D64547F23
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACB628A415;
	Wed,  9 Jul 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQYD7sLD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689D28A1DE;
	Wed,  9 Jul 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055700; cv=none; b=UktfzRXH/Jj8lkwyiA4QNnWOSdFIDcIca1ILnxYNG7vpwYYxz5xnTHIOsh9gn2o7jAT0NQngU4Gv0Xr9S7nE278daAhF1PkP1ixl6QA3W+4vwraVLe3iKkn683tQRRVs73Hj4ewQZCs6PzUtlO88IY0oQoFzu7lUViKNJQtEkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055700; c=relaxed/simple;
	bh=J9wQBPRf65to7Du2jOBgbZiz5xuY4eVddw0agBMcDFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgNzOBplf+G7TlUNbZT9hQQl6lFJ/B8+RHVzaev1APu+l0FNzcFcbX2NZUzUaEFbCwu9FveHTUdDSK032KwpMY4pC3z375/kLLweOSwfWsmbJcxgjAS2CPa1Rr0kqSgxQ/zEXXyH6nz0Pv6LaYWPeS/dOVEGboGMTNNugze7PMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQYD7sLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000E4C4CEEF;
	Wed,  9 Jul 2025 10:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752055700;
	bh=J9wQBPRf65to7Du2jOBgbZiz5xuY4eVddw0agBMcDFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQYD7sLDjO3T26gq87Tko0KFpFoqmsuC1VI2wdFCY5GcSITQYf1RfYnXNDVL7nTTA
	 l24/rYbXstfqnm+clEx7vPxmH7aCu7y2mMjZt2QCRBtGqP3F26TTIfNmOaYui8l7hS
	 4OOtyJvLVwLZPfP0FYfzmNhydSSM97knAcIFUIXXSpgflz/v9+QKRJe0gFJ2v2lciQ
	 NXJDxKq6W1G9tTbYIREIbjNnCUauud0logt3/uvTBAThQbxpYLXjptPPLlsJL3gYBZ
	 GjX2CY47dY/tr/Chvel2/jyj9Iz66UF2TVhFCDhmuP4B6frpkJwisBQj5z9X9zgVDF
	 TlbPDuLPzYbtw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZRim-000000001zi-3cZk;
	Wed, 09 Jul 2025 12:08:12 +0200
Date: Wed, 9 Jul 2025 12:08:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Telit Cinterion FE910C04 (ECM)
 composition
Message-ID: <aG4_jEQmeD9a_oWo@hovoldconsulting.com>
References: <20250708120004.100254-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708120004.100254-1-fabio.porcedda@gmail.com>

On Tue, Jul 08, 2025 at 02:00:04PM +0200, Fabio Porcedda wrote:
> Add Telit Cinterion FE910C04 (ECM) composition:
> 0x10c7: ECM + tty (AT) + tty (AT) + tty (diag)
> 
> usb-devices output:
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=10c7 Rev=05.15
> S:  Manufacturer=Telit Cinterion
> S:  Product=FE910
> S:  SerialNumber=f71b8b32
> C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
 
>  /* Interface does not support modem-control requests */
>  #define NCTRL(ifnum)	((BIT(ifnum) & 0xff) << 8)
> +#define NCTRL_ALL	(0xff << 8)
>  
>  /* Interface is reserved */
>  #define RSVD(ifnum)	((BIT(ifnum) & 0xff) << 0)
> @@ -1415,6 +1416,9 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = NCTRL(5) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x60) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x30),	/* Telit FE910C04 (ECM) */
> +	  .driver_info = NCTRL_ALL },

Please just use NCTRL(4) here. (And remember to mention additions like
this in the commit message in the future.)

Or do you have reasons to believe the interface numbering may change? Or
is it just to avoid matching on both number and protocol?

Perhaps we should try to generalise these rules at some point in case
there is some logic to it these days (e.g. 0x30 => diag and NCTRL)...

> +	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x40) },

Johan

