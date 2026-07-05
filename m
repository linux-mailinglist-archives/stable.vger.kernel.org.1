Return-Path: <stable+bounces-272033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tTp9IlcnSmpc+wAAu9opvQ
	(envelope-from <stable+bounces-272033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 11:43:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52E709A0D
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 11:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272033-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272033-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4900300D6BD
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DFE38C40B;
	Sun,  5 Jul 2026 09:43:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB824A05D;
	Sun,  5 Jul 2026 09:43:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244624; cv=none; b=qjahpkdUyRlQp+HTqOLht0aqEhffo19b0pvHmhjaMYOfVMHSetQmN1eqpg6Nsypt2EKFlIpf+zCdk1nQifqpS5Qp9sO1Yo2igEE8bYy3tcD/7/7tfoYgvtbB92PUnsiFYUu4oEX2bRtQyGmZbuwXLeqNHNlip6LfnfUg1fUxVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244624; c=relaxed/simple;
	bh=gvDob2Ln9IDFA97c/8LfF0YOV3KJzTk2b8e9bdBoeAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBjCshdOYUbobiyoxs20JswrbxaLdc1DSPqGYmblq7bcxX2nlYZkfmjUw9CJZsmWj/3VUFLqihWFLHTLjW8cWspcLWvhLE5S5bNJjrTYb0QhCz64uTnb8m3IJUK43HRHERB6NahpGLf4rYdctiqdwpB3oXzHByT5ctGl94Y98gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Received: from [192.168.2.222] (p5dc55dc6.dip0.t-ipconnect.de [93.197.93.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9E4D84C2C37D72;
	Sun, 05 Jul 2026 11:43:32 +0200 (CEST)
Message-ID: <a3a6b0cc-3eee-4f45-82a9-af9a04345c4b@molgen.mpg.de>
Date: Sun, 5 Jul 2026 11:43:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: Add ASUS USB-BT540 for Realtek
 8761CU
To: cito@online.de
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260704231312.340274-1-cito@online.de>
 <20260705092857.27050-2-cito@online.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260705092857.27050-2-cito@online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272033-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:cito@online.de,m:linux-bluetooth@vger.kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[online.de:email,mpg.de:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA52E709A0D

Dear Christoph,


Thank you for sending v2.

Am 05.07.26 um 11:28 schrieb cito@online.de:
> From: Christoph Zwerschke <cito@online.de>
> 
> Add the vendor/product ID (0x0b05, 0x1bef) to the usb_device_id table for
> the Realtek RTL8761CU-based ASUS USB-BT540 adapter. It binds via the
> generic Bluetooth class today, so BTUSB_REALTEK is never set and the
> rtl8761cu firmware is not loaded, leaving the controller non-functional.
> With the entry the driver loads rtl_bt/rtl8761cu_fw.bin (already shipped by
> linux-firmware) and the adapter works (tested: A2DP and ASHA).
> 
> Similar to commit bc597f0cc44f
> ("Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV").
> 
> Device info from /sys/kernel/debug/usb/devices:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 22 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0b05 ProdID=1bef Rev= 2.00
> S:  Manufacturer=Realtek
> S:  Product=Bluetooth Controller
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Christoph Zwerschke <cito@online.de>
> ---
>   drivers/bluetooth/btusb.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e9b0b1dcc1d1..c15c7ab5bd2e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -856,6 +856,10 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x37ad, 0x0600), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
>   
> +	/* Additional Realtek 8761CU Bluetooth devices */
> +	{ USB_DEVICE(0x0b05, 0x1bef), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +
>   	/* Additional Realtek 8821AE Bluetooth devices */
>   	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
>   	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

