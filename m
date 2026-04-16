Return-Path: <stable+bounces-238287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKBWMumu4GkRkwAAu9opvQ
	(envelope-from <stable+bounces-238287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:42:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB740C86F
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02E3A301AB94
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A839B94C;
	Thu, 16 Apr 2026 09:36:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292D33F595;
	Thu, 16 Apr 2026 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332191; cv=none; b=OexlQURCq07lQ5vgl/KNC/5soXh6S7E7gS3tqWevHmYI89gkn12ScKHmqQpteAymr7fdHohz5tNPvMPA2Kf5ZRSaQF5x5tQS0B7pRbLkgmVC14MH1HjxW9aWfd5MuXD02tZmW7vMA1JkXAlbyUAzKAHdb4ElOXxlIS+A7jKBCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332191; c=relaxed/simple;
	bh=hoInmZ73SZ0TC4oz/P60lYrFRq/SfRLDJNoAx+zCHxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDso2UW7spHzsE6bCzPoUqJC9yrr+6gQ4aEoyocUeByPAiGpaEepXKCmgfixIHWUMeqhnHHmRRIWVH+yzxPuxCcknscoYfCRUNCFvhE86uRGxGV3kTZOk2FMFm/SYxQGectfWpjPJpF37Jpjhj86lGQzCPGVD+yzNP2TcH/Qlbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id C822B5830F6;
	Thu, 16 Apr 2026 09:32:23 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DB5F3EBD5;
	Thu, 16 Apr 2026 09:32:14 +0000 (UTC)
Message-ID: <8fedad8e9caecd379f2296562cd6abd37f7cee46.camel@hadess.net>
Subject: Re: [PATCH 2/4] HID: core: introduce hid_safe_input_report()
From: Bastien Nocera <hadess@hadess.net>
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Filipe =?ISO-8859-1?Q?La=EDns?=	 <lains@riseup.net>, Ping Cheng
 <ping.cheng@wacom.com>, Jason Gerecke	 <jason.gerecke@wacom.com>, Viresh
 Kumar <vireshk@kernel.org>, Johan Hovold	 <johan@kernel.org>, Alex Elder
 <elder@kernel.org>, Greg Kroah-Hartman	 <gregkh@linuxfoundation.org>, Lee
 Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 16 Apr 2026 11:32:14 +0200
In-Reply-To: <20260415-wip-fix-core-v1-2-ed3c4c823175@kernel.org>
References: <20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org>
	 <20260415-wip-fix-core-v1-2-ed3c4c823175@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEqBTRK5tvLZzwWSgB/1iJazKNDFIG9byJ8UVkzpHcdH0usiWKsROoc8Q2CRru0qWFQORNAF/Tb04YmWqG32X+x5nBDVo/u8NkoEzWCUHzK2un2k1fYD5mKn6XzX6mYnfVOHNLU9m0W90nOhD0PA3yoG4nrzzlK0PtSmD82ncFPd7HIZGaxRdIIlljDzx2aitBkm2FkdYbs6FVpZK/Lmx7w8ejEhx3SbTi0JL0QI1Oi4JbCJXQlRtjvcZzLkoGGGZYoPjaP3qXrxOcWXyn4LQjwvCgp+DR30ABShmHhs5abvDEv2veZG1z1PX4KhVg+iKO5vRt3Yj82Fq/dJ/ucBHNNJ68t643Vg0eFUdAXvO0oGI4TRUIgFg1DAIW4xdq89pBlAjnI4UEWBs/UBJk2uMQ3ksqBBmey/z0Jm8GpMvkXHf4xWwS0HnfiYFAOWaZiRKnZmegara1pPlzIAgn064hqdZ6OV6qGb54kpGE1/jQpL33e26TrDmyizOFueMs+WI42ez5u6TWtWeZQ1Dg+DBzySQFowwqKiy7TTOlHSUEnP8nPG/xC1HlnctqmDegj4xZs8oB9Iwfk9OVbWc4uVXAl7OzVREg73SnT0vo7Q30SGCGO+1pumgOyVBtpy0oohmiCbfq9lFVMFL0IHZ3Vy+abHKSCboIOrhy5siR8YCE1sA
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238287-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[hadess.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hadess@hadess.net,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hadess.net:mid]
X-Rspamd-Queue-Id: 33EB740C86F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-15 at 11:38 +0200, Benjamin Tissoires wrote:
> hid_input_report() is used in too many places to have a commit that
> doesn't cross subsystem borders. Instead of changing the API,
> introduce
> a new one when things matters in the transport layers:
> - usbhid
> - i2chid
>=20
> This effectively revert to the old behavior for those two transport
> layers.
>=20
> Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> =C2=A0drivers/hid/hid-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++++++++++++++++++
> =C2=A0drivers/hid/i2c-hid/i2c-hid-core.c |=C2=A0 7 ++++---
> =C2=A0drivers/hid/usbhid/hid-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++=
++++-----
> =C2=A0include/linux/hid.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A04 files changed, 33 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a806820df7e5..cb0ad99e7a0a 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2191,6 +2191,27 @@ int hid_input_report(struct hid_device *hid,
> enum hid_report_type type, u8 *data
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(hid_input_report);
> =C2=A0
> +/**
> + * hid_safe_input_report - report data from lower layer (usb, bt...)
> + *
> + * @hid: hid device
> + * @type: HID report type (HID_*_REPORT)
> + * @data: report contents
> + * @bufsize: allocated size of the data buffer
> + * @size: useful size of data parameter
> + * @interrupt: distinguish between interrupt and control transfers
> + *
> + * This is data entry for lower layers.

You probably want to explain why it should be used instead of
hid_input_report() in this doc blurb, and modify the hid_input_report()
docs to mention that this should be used.

Maybe hid_input_report() should also be marked as deprecated somehow,
to avoid new users?

Cheers

> + */
> +int hid_safe_input_report(struct hid_device *hid, enum
> hid_report_type type, u8 *data,
> +			=C2=A0 size_t bufsize, u32 size, int interrupt)
> +{
> +	return __hid_input_report(hid, type, data, bufsize, size,
> interrupt, 0,
> +				=C2=A0 false, /* from_bpf */
> +				=C2=A0 false /* lock_already_taken */);
> +}
> +EXPORT_SYMBOL_GPL(hid_safe_input_report);
> +
> =C2=A0bool hid_match_one_id(const struct hid_device *hdev,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct hid_device_id *id)
> =C2=A0{
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-
> hid/i2c-hid-core.c
> index 5a183af3d5c6..e0a302544cef 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -574,9 +574,10 @@ static void i2c_hid_get_input(struct i2c_hid
> *ihid)
> =C2=A0		if (ihid->hid->group !=3D HID_GROUP_RMI)
> =C2=A0			pm_wakeup_event(&ihid->client->dev, 0);
> =C2=A0
> -		hid_input_report(ihid->hid, HID_INPUT_REPORT,
> -				ihid->inbuf + sizeof(__le16),
> -				ret_size - sizeof(__le16), 1);
> +		hid_safe_input_report(ihid->hid, HID_INPUT_REPORT,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ihid->inbuf + sizeof(__le16),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ihid->bufsize -
> sizeof(__le16),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_size - sizeof(__le16), 1);
> =C2=A0	}
> =C2=A0
> =C2=A0	return;
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-
> core.c
> index fbbfc0f60829..5af93b9b1fb5 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -283,9 +283,9 @@ static void hid_irq_in(struct urb *urb)
> =C2=A0			break;
> =C2=A0		usbhid_mark_busy(usbhid);
> =C2=A0		if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
> -			hid_input_report(urb->context,
> HID_INPUT_REPORT,
> -					 urb->transfer_buffer,
> -					 urb->actual_length, 1);
> +			hid_safe_input_report(urb->context,
> HID_INPUT_REPORT,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 urb->transfer_buffer,
> urb->transfer_buffer_length,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 urb->actual_length,
> 1);
> =C2=A0			/*
> =C2=A0			 * autosuspend refused while keys are
> pressed
> =C2=A0			 * because most keyboards don't wake up when
> @@ -482,9 +482,10 @@ static void hid_ctrl(struct urb *urb)
> =C2=A0	switch (status) {
> =C2=A0	case 0:			/* success */
> =C2=A0		if (usbhid->ctrl[usbhid->ctrltail].dir =3D=3D
> USB_DIR_IN)
> -			hid_input_report(urb->context,
> +			hid_safe_input_report(urb->context,
> =C2=A0				usbhid->ctrl[usbhid-
> >ctrltail].report->type,
> -				urb->transfer_buffer, urb-
> >actual_length, 0);
> +				urb->transfer_buffer, urb-
> >transfer_buffer_length,
> +				urb->actual_length, 0);
> =C2=A0		break;
> =C2=A0	case -ESHUTDOWN:	/* unplug */
> =C2=A0		unplug =3D 1;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ac432a2ef415..bfb9859f391e 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -1030,6 +1030,8 @@ struct hid_field *hid_find_field(struct
> hid_device *hdev, unsigned int report_ty
> =C2=A0int hid_set_field(struct hid_field *, unsigned, __s32);
> =C2=A0int hid_input_report(struct hid_device *hid, enum hid_report_type
> type, u8 *data, u32 size,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 int interrupt);
> +int hid_safe_input_report(struct hid_device *hid, enum
> hid_report_type type, u8 *data,
> +			=C2=A0 size_t bufsize, u32 size, int interrupt);
> =C2=A0struct hid_field *hidinput_get_led_field(struct hid_device *hid);
> =C2=A0unsigned int hidinput_count_leds(struct hid_device *hid);
> =C2=A0__s32 hidinput_calc_abs_res(const struct hid_field *field, __u16
> code);

