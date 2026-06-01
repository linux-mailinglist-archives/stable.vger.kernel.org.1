Return-Path: <stable+bounces-259463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMq3HA01HWoqWQkAu9opvQ
	(envelope-from <stable+bounces-259463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 09:30:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFEA61AE5C
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 09:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D44753007ADA
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BBE385D91;
	Mon,  1 Jun 2026 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPtTOlbB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98B38642C;
	Mon,  1 Jun 2026 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299012; cv=none; b=kUpP8mzbPd0in6ssnyTgVHjK0ihHqpKmbQdgezqMkHN+XbsY24nBUCnirXL68SjYbj4TvPhphkiAcTjFXDy2F+6kdsR4Ye3pIjTjOLHac3DWAqQzBDyCvm/a3Jr6hrC/AL473CCZtWLyWQRzWllOmc9w+OqRtHgDV4Zm2XHDh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299012; c=relaxed/simple;
	bh=quItyXVXLVGSC6o/bMwaJUmgthrEoXAqy3yY7DAoKgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwniZ61nStHEJHSdVMkb4U+QuwywlFh9DxQrKS0IEJu/WdJk3Qo5uOB7LKTH9szE7cwdyxfnp+2FgGCACrHpguAnWQ+uZ1EoBKu4bXjoi1m2B62d3062QI9g55pUVPruDzP0bjRj/8AbOUtZ7C6HXIbEq2OKK2TXO0bysZ7Gc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPtTOlbB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643151F00893;
	Mon,  1 Jun 2026 07:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780299010;
	bh=gzL2SkcPkY1ldzSUTPG15UAH/VU6zt02ppqwKAVNiNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KPtTOlbBxe1Yje7/O/XLhDQ1xUOBh7WMYZ0z1ajw90/Hy78HgnC0veSYnWX7n0i1Q
	 EmmWADIPMpshoRg3Ya4GAsAgow/NXBOVd7MKyfeM8iMn+UGfrXi1BFhmmkxWnFcA8v
	 Kv7buAIJvrNL+bra9gaS6oSrJcl8hH0nD8w7jyYIbEHvK3WUW0xe6oW6ynxnqM88or
	 9ZDg8zZz+aMcN+QaQJwiDvEuNggHslQnH1FXnG+cwdhwPjIZ+YDWq7Mt4ZaRRWkpB8
	 9vbeZeYJShgotMvQmg6jVXRkekg/TzHbfytrkS/NQKVXyYcbsB0nmW/OWojFhtWMKU
	 VG126C8Kk8qqg==
Date: Mon, 1 Jun 2026 09:30:04 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>, 
	Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Viresh Kumar <vireshk@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] HID: core: introduce hid_safe_input_report()
Message-ID: <ah00D_yttLtjlYA-@beelink>
References: <20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org>
 <20260415-wip-fix-core-v1-2-ed3c4c823175@kernel.org>
 <8fedad8e9caecd379f2296562cd6abd37f7cee46.camel@hadess.net>
 <CAO-hwJ+EgC0pM6L6vGFEaRFt2Nwj5b-CCf_5e5VkvrXgdHrjNg@mail.gmail.com>
 <ahsh0UtTX6e0ZeHa@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahsh0UtTX6e0ZeHa@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259463-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hadess.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5DFEA61AE5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Carlos,

On May 30 2026, Carlos Llamas wrote:
> On Thu, Apr 16, 2026 at 04:46:28PM +0200, Benjamin Tissoires wrote:
> > On Thu, Apr 16, 2026 at 11:41 AM Bastien Nocera <hadess@hadess.net> wrote:
> > >
> > > On Wed, 2026-04-15 at 11:38 +0200, Benjamin Tissoires wrote:
> > > > hid_input_report() is used in too many places to have a commit that
> > > > doesn't cross subsystem borders. Instead of changing the API,
> > > > introduce
> > > > a new one when things matters in the transport layers:
> > > > - usbhid
> > > > - i2chid
> > > >
> > > > This effectively revert to the old behavior for those two transport
> > > > layers.
> > > >
> > > > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> > > > bogus memset()")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > > ---
[...]
> 
> Hi Benjamin, our CI started failing with commit 0a3fe972a7cb ("HID:
> core: Mitigate potential OOB by removing bogus memset()"), so I was
> hoping your patchset would fix this.
> 
> However, I just realized our call path goes through uhid precisely,
> which still triggers the EINVAL error since uhid as not converted to
> hid_safe_input_report().
> 
> My vague understanding though, is that uhid_event uses a static buffer
> in ev->data[UHID_DATA_MAX], so maybe we can use that through
> uhid_dev_input{2}()?
> 
> I ran the following path through our CI and it fixed our issue, so I
> wanted to get your thoughts on this.

Oh, yes, you are correct. Sorry with all the back and forth on this
paritcular topic, my brain assumed that uhid was only allocating the
useful part of the payload and was not safe.

For the future me: the problem with uhid was that we were emultaing
devices that would trigger a bug elsewhere in the stack not in
uhid_dev_input*().

Patch looks good, please send it normally to the ML with your SoB :)

Cheers,
Benjamin

> 
> Carlos Llamas
> 
> ---
>  drivers/hid/uhid.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 524b53a3c87b..37b60c3aaf66 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -595,8 +595,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
>  	if (!READ_ONCE(uhid->running))
>  		return -EINVAL;
>  
> -	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
> -			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
> +	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
> +			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
>  
>  	return 0;
>  }
> @@ -606,8 +606,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
>  	if (!READ_ONCE(uhid->running))
>  		return -EINVAL;
>  
> -	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
> -			 min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
> +	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data, UHID_DATA_MAX,
> +			      min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
>  
>  	return 0;
>  }
> 

