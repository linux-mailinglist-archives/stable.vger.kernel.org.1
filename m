Return-Path: <stable+bounces-232956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJPQBJs7zmmAmAYAu9opvQ
	(envelope-from <stable+bounces-232956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:49:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 806383872AB
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80E733041147
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C03D8116;
	Thu,  2 Apr 2026 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgwMRDCL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AA38BF80;
	Thu,  2 Apr 2026 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123044; cv=none; b=jKWFXtZUL0DHINZPIsIC6NYYScTgFaBY7HynCYnYq5RtuNxd0Qk9fEVbkoW02Nv6GF3kKFurcGBKjE61QP59w1wHitFw+KBJ0+056Q/S2d6aUOUALPID7x9lEBr3zyy38m3fOJzau/DwsBjEjdl/mWwA8xCtAHBdj0mQOna71aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123044; c=relaxed/simple;
	bh=DkQkTR4cOeM81ijaClZAEHyxAqOKn5Kstf56snNni5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP6WtLHfQAS/GgWPaHjK6aqzVhd5vpYSdq4A5oxEpmkcYPxS8FoZei2scp5qifv8fZW2WN7ejHjdKKkAXrzJoJPrKdf1yiw9P0xvdZINI8HPO/280opkw4/KehphfOSHLbmoxavfXyuMTWhFC8rAZMDeGc8qSYGrS4xeLmfSlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgwMRDCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19B7C116C6;
	Thu,  2 Apr 2026 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775123043;
	bh=DkQkTR4cOeM81ijaClZAEHyxAqOKn5Kstf56snNni5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgwMRDCLItLtjdL7S6FD8bFOzF15zJEeVIbSiXW/42hY/r/rEwkDhEQnFhQ/paXi+
	 aMxDvXgSpue/hxDMNcjkFSSRfotDbunp9UJ8bJH8ff37788H3taruZh/h+VBNgA3qo
	 NSnL9ZX4pMc1kBSO9q7hwuRTCbl1ewDIevNZB4GNWxGR2ATnKtSEcSeyWKepHyKHWI
	 9L/9ato6ZS+5z1Wp0BH26fHBXtLGpO3WIu2fupRbkFbZTBDpmDDlMzL8xIVzHQ3jaT
	 bkIHiBYV+gXQWra8VMHJZgEOcilNS8Y5r9sAaGjME3LXudWVDU5MxSYowUQWjAUPTm
	 Ix3fRAo+HYw9w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8Ean-00000009qqy-32iT;
	Thu, 02 Apr 2026 11:44:01 +0200
Date: Thu, 2 Apr 2026 11:44:01 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: option: add Telit Cinterion FN990A MBIM
 composition
Message-ID: <ac46YeSJeYVvm0Hn@hovoldconsulting.com>
References: <20260402083722.100973-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402083722.100973-1-fabio.porcedda@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-232956-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 806383872AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 10:37:22AM +0200, Fabio Porcedda wrote:
> Add the following Telit Cinterion FN990A MBIM composition:
> 
> 0x1074: MBIM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (diag) +
>         DPL (Data Packet Logging) + adb
> 
> T:  Bus=01 Lev=01 Prnt=04 Port=06 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=1bc7 ProdID=1074 Rev=05.04
> S:  Manufacturer=Telit Wireless Solutions
> S:  Product=FN990
> S:  SerialNumber=70628d0c
> C:  #Ifs= 7 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> E:  Ad=8f(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

> @@ -1383,6 +1383,8 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = NCTRL(2) | RSVD(3) },
>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990A (ECM) */
>  	  .driver_info = NCTRL(0) | RSVD(1) },
> +	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1074, 0xff),	/* Telit FN990A (MBIM) */
> +	  .driver_info = NCTRL(5) | RSVD(6) | RSVD(7) },

There is no adb interface in the usb-devices output in the commit
message. Do you still need to reserve interface 7?

>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
>  	  .driver_info = RSVD(0) },
>  	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1077, 0xff),	/* Telit FN990A (rmnet + audio) */

Johan

