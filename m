Return-Path: <stable+bounces-268558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tLTIH8g0PWoozAgAu9opvQ
	(envelope-from <stable+bounces-268558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:01:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C12156C6590
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:01:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=UBihqjH2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268558-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268558-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1692300514D
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D0339853;
	Thu, 25 Jun 2026 14:01:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA42EDD7D;
	Thu, 25 Jun 2026 14:01:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396094; cv=none; b=OUMHzk7qxEfyWnpequEZACd6QL/AEUFpFiUT+QjFlaugt/koUeh2U99/NXA6k3xxmu7FFhsgbU9D8tTHXvNp+LKaRXrN9lQHOae7UWyptO2Bm3NDTL8mRlrVSqvNtjyz0q/RWQIutBTCzYUgyiBmNqErcBhVTCqczKFteynN/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396094; c=relaxed/simple;
	bh=2hc8qBoOkck7WCbYgfm7FidvX81QoZKx6sh7wleyU5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwBIwL129lwzFE7obHAM2S8nqpasHDPdEeI04v7UHgOXkzKmtjpYrrehBsvDV2zczHCaxLgmLQwYTVFZJm7bD8egjxuF4LphVhBa572p0JzNMwFdy1fXyG+kxaBjT2uZsjY0dQqp2FtMA+7yoPyrRhpsBP8LhEQYbEsngp3H2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UBihqjH2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000E61F000E9;
	Thu, 25 Jun 2026 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782396092;
	bh=UPjYKRx/JznPkgUBzNwXhhTkZxqTJPaIysGlReLI8jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UBihqjH23k5nnsBHhRWtajsrTp8HxLF+0rWzQC17uNrLFEpseJYLpTLLBROougkxq
	 2hmAaLuG3ZiZbu3p0wTNx+QjvUOnk7EVpxFwpbLktWzl0FFrW+mwoutvYllZcQVzh4
	 NSkvwqZVSLvLdZAKqXN/RHEJaxiwq2MlHwiE3dM0=
Date: Thu, 25 Jun 2026 15:00:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Korwel <adriank20047@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in
 gaudio_open_snd_dev()
Message-ID: <2026062500-thinness-crudeness-7036@gregkh>
References: <2026052517-undergrad-reformat-44bc@gregkh>
 <20260525202612.680-1-adriank20047@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525202612.680-1-adriank20047@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268558-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:adriank20047@gmail.com,m:linux-usb@vger.kernel.org,m:stable@vger.kernel.org,m:heikki.krogerus@linux.intel.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[stable@vger.kernel.org:query timed out];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C12156C6590

On Mon, May 25, 2026 at 03:26:09PM -0500, Adrian Korwel wrote:
> gaudio_open_snd_dev() opens the ALSA control device file first, then
> opens the PCM playback device. On two error paths the control file
> handle is leaked:
> 
> When filp_open() for the playback device fails, the function returns
> immediately without closing the already-opened control file handle.
> 
> When playback_default_hw_params() fails, its return value was ignored
> and both the playback and control file handles were leaked.
> 
> Both leaks result in gaudio_cleanup() calling filp_close() on already
> freed file objects, causing a use-after-free.
> 
> Fix by closing previously opened file handles before returning on
> each error path, and by checking the return value of
> playback_default_hw_params().
> 
> Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
> ---
>  drivers/usb/gadget/function/u_uac1_legacy.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Something is really odd with your email system, look at what is on the
list from you for these patches.  It looks like:

 525   C May 25 Adrian Korwel   (  43) ┬─>[PATCH 1/2] USB: serial: io_ti: fix heap overflow in get_manuf_info()                                        
 527   C May 25 Adrian Korwel   (  40) │ └─>[PATCH 2/2] USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()
 528   T May 25 Adrian Korwel   (  77) └─>Re: [PATCH] USB: serial: io_ti: fix heap overflows in get_manuf_info() and build_i2c_fw_hdr()
 623   C May 25 Adrian Korwel   (  54) ┬─>[PATCH 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()
 624   C May 25 Adrian Korwel   (  64) │ ├─>[PATCH 2/4] usb: gadget: f_uac1_legacy: fix use-after-free caused by bound guard
 625   C May 25 Adrian Korwel   (  40) │ ├─>[PATCH 4/4] usb: typec: thunderbolt: cancel work before altmode is removed
 626   C May 25 Adrian Korwel   (  35) │ └─>[PATCH 3/4] usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
 627   C May 25 Adrian Korwel   (  40) └─>[PATCH 1/4] USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()
 628   C May 25 Adrian Korwel   (  40)   ├─>[PATCH 4/4] usb: typec: thunderbolt: cancel work before altmode is removed
 629   C May 25 Adrian Korwel   (  35)   ├─>[PATCH 4/4] usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
 630   C May 25 Adrian Korwel   (  54)   ├─>[PATCH 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()
 631   C May 25 Adrian Korwel   (  64)   ├─>[PATCH 2/4] usb: gadget: f_uac1_legacy: fix use-after-free caused by bound guard
 632   C May 25 Adrian Korwel   (  64)   ├─>[PATCH 3/4] usb: gadget: f_uac1_legacy: fix use-after-free caused by bound guard
 633   C May 25 Adrian Korwel   (  35)   ├─>[PATCH 3/4] usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
 634   C May 25 Adrian Korwel   (  54)   └─>[PATCH 2/4] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()
 636   C May 24 Adrian Korwel   (  41) [PATCH] usb: typec: thunderbolt: cancel work before altmode is removed  
 637   C May 24 Adrian Korwel   (  62) [PATCH] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()


You have threading issues, patches in multiple places and resend, and all mixed
up.

Please resend everything that has not been accepted, as new versions, in the
correct way, and we will be glad to review them.

thanks,

greg k-h

