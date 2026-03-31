Return-Path: <stable+bounces-232606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cClUMCtWzGn/SQYAu9opvQ
	(envelope-from <stable+bounces-232606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:18:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F6372A87
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D309F301C59D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73133A782B;
	Tue, 31 Mar 2026 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BVCnSKrM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC42DF68
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999068; cv=none; b=dVLuO/Nx6q/FDvTaX4hEq44s8ZMDkgVljq5Q81ow+pp17/GcdhvddFvXodDogLYQUWavq1H8NFEKcgy+f8SuDPW37IqXnavDPF1y0C4VYYcq97eHMQBBJ3HpmdUKfoqUYJ9CJ70BPNwQSKdnmd8rSXRzsBymNIu+mHt4bYqbalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999068; c=relaxed/simple;
	bh=aHZRNoTvbdlI/EombGoD9iP8bTf4Aj4gSIgmhshYEx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3Ny2DmYepwEd3ykS1nQU+0z3llSaiFMoSl3iH1QYzIXUpp29a7oUctEJuKdjb9TQ7pera9M0n9+Iye07P/9cp6UQe3yS/3Vf74RDCGbp3q8cNJKsE6Mo5oyGvJJnRRcW6PapMiecfQlvXJw+cjhN2avRZ0cFin/qzUNIaupJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BVCnSKrM; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d751ef36ccso3381425a34.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 16:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774999066; x=1775603866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mwEv/M/xQBFIbRAjlXXEdV7PZOOUIQNp5LFHgoTzio=;
        b=BVCnSKrM9DvXuhNrDHYF8dDrfGbTXc2b0h1u9bjWhhnjlsXyWtBmxEtuabf990UrNj
         eaDlMMn2mlxlOjD0/0hHNXrIMucgm7hBPEitUVBRBWrddwtnmMAcf2pCbrVXit+f+lxP
         fNBQwGNOezu93ALYcvJ80bPQPJ0d36Cz384xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774999066; x=1775603866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mwEv/M/xQBFIbRAjlXXEdV7PZOOUIQNp5LFHgoTzio=;
        b=okmRfhmUSGUoS7wrT3RLGzqqe5RCC/HyN01yVWzlTs9HA0COlaqwjpOZ71XQSf+D96
         eMSrLwHq14SgdkwHyzD5goiCKQMg1p86ALJEoyDypH/lbkmTLgl9wcIltQQZkGLG7P7K
         R3moeLqyHb9nY8YpFzC7XmCdCVMi1TzTKJOVkfJ04rhMCo+Gy+d8wUW1pxGgtalNRnYL
         EvOhNtyJSMs0Fpe7JdvHqmI1St4cod94eYXtlWxY6VD4i575y45zziQa22cIVMuDq8Kw
         CZQcnX1wS33/9En+ZWQkYvmOcpgG/pTzz3QWCtjOgs4twVZdiWhYKNLUc3osxhLMvzsA
         UG7w==
X-Forwarded-Encrypted: i=1; AJvYcCVVgHOznyf95h21oxijU1RSmDNeRT12457dQwN4Cs62omo0vr+rw6p463R0TFOUgrxPvdvzQQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOFCCJ6ihdORwG8QBf3Sl7eo6xS97xqdgcauH95LrljktTQNG9
	bdtLSCc9McnpL9yQLHotoY2V5NS0CEQZ4dblMlah0pgoaS4X/HK9pXIW2ntZpqGDytw=
X-Gm-Gg: ATEYQzyX1Jlj+S4VGR1rStb+p4xOQz+EB384BjohQqTgmh7O/R3IRZUQcMkvwYY5ae/
	6ye5zz3qMokL8X3VVegZEn/TktUhWw4U6+405g0fhGjGwZ5SVvpDtwAdsdn3DA+/uG253ol6S+8
	1OAV343RVgMMVpetXXLIMiiEIfWTkfNH8sBUEEtuNz2CEIxWdA3qq5DgsjsW6bZ762vAu02WpSM
	VOBX1CW/VJ/23RMzd7nLSpPnWY3O7yEEWdKVtgRV5LYIil1q3NLHB65p3M4hpxmTq+ql0qIImak
	0n5UQFHbmQIKZl00h5iaU6XhA3GaM/KmNRsuhq13hUdg0n208b1WTrlDEnXec59zHlGxxg85jw7
	VF1wrCvYbKmhLsRNw609XnFxwbmb/jUgV2zpMXnVMhgC36xMPyCb7zvTy/WrJrWErVn775/8tbw
	d2FZiuG4niA1cUxlG7CWiJ2UvwAvX9nk6k080=
X-Received: by 2002:a05:6830:7009:b0:7d7:ecef:1460 with SMTP id 46e09a7af769-7db9946a0d8mr1102070a34.31.1774999065919;
        Tue, 31 Mar 2026 16:17:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a335440sm9117890a34.4.2026.03.31.16.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:17:45 -0700 (PDT)
Message-ID: <34da1928-f6e7-43fb-a436-6bc02e262698@linuxfoundation.org>
Date: Tue, 31 Mar 2026 17:17:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbip: vhci: reject RET_SUBMIT with inflated
 number_of_packets
To: Nathan Rebello <nathan.c.rebello@gmail.com>, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, addcontent08@gmail.com,
 kyungtae.kim@dartmouth.edu, stable@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260327064449.735-1-nathan.c.rebello@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260327064449.735-1-nathan.c.rebello@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,dartmouth.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232606-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 471F6372A87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 00:44, Nathan Rebello wrote:
> When a USB/IP client receives a RET_SUBMIT response,
> usbip_pack_ret_submit() unconditionally overwrites
> urb->number_of_packets from the network PDU. This value is
> subsequently used as the loop bound in usbip_recv_iso() and
> usbip_pad_iso() to iterate over urb->iso_frame_desc[], a flexible
> array whose size was fixed at URB allocation time based on the
> *original* number_of_packets from the CMD_SUBMIT.
> 
> A malicious USB/IP server can set number_of_packets in the response
> to a value larger than what was originally submitted, causing a heap
> out-of-bounds write when usbip_recv_iso() writes to
> urb->iso_frame_desc[i] beyond the allocated region.
> 
> KASAN confirmed this with kernel 7.0.0-rc5:
> 
>    BUG: KASAN: slab-out-of-bounds in usbip_recv_iso+0x46a/0x640
>    Write of size 4 at addr ffff888106351d40 by task vhci_rx/69
> 
>    The buggy address is located 0 bytes to the right of
>     allocated 320-byte region [ffff888106351c00, ffff888106351d40)
> 
> The server side (stub_rx.c) and gadget side (vudc_rx.c) already
> validate number_of_packets in the CMD_SUBMIT path since commits
> c6688ef9f297 ("usbip: fix stub_rx: harden CMD_SUBMIT path to handle
> malicious input") and b78d830f0049 ("usbip: fix vudc_rx: harden
> CMD_SUBMIT path to handle malicious input"). The server side validates
> against USBIP_MAX_ISO_PACKETS because no URB exists yet at that point.
> On the client side we have the original URB, so we can use the tighter
> bound: the response must not exceed the original number_of_packets.
> 
> This mirrors the existing validation of actual_length against
> transfer_buffer_length in usbip_recv_xbuff(), which checks the
> response value against the original allocation size.
> 
> Kelvin Mbogo's series ("usb: usbip: fix integer overflow in
> usbip_recv_iso()", v2) hardens the receive-side functions themselves;
> this patch complements that work by catching the bad value at its
> source -- in usbip_pack_ret_submit() before the overwrite -- and
> using the tighter per-URB allocation bound rather than the global
> USBIP_MAX_ISO_PACKETS limit.
> 
> Fix this by checking rpdu->number_of_packets against
> urb->number_of_packets in usbip_pack_ret_submit() before the
> overwrite. On violation, clamp to zero so that usbip_recv_iso() and
> usbip_pad_iso() safely return early.
> 
> Fixes: 0775a9cbc798 ("staging: usbip: vhci extension: modifications to the client side")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
> ---
>   drivers/usb/usbip/usbip_common.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
> --- a/drivers/usb/usbip/usbip_common.c
> +++ b/drivers/usb/usbip/usbip_common.c
> @@ -470,7 +470,18 @@ static void usbip_pack_ret_submit(struct usbip_header *pdu, struct urb *urb,
>   		urb->status		= rpdu->status;
>   		urb->actual_length	= rpdu->actual_length;
>   		urb->start_frame	= rpdu->start_frame;
> -		urb->number_of_packets = rpdu->number_of_packets;
> +		/*
> +		 * The number_of_packets field determines the length of
> +		 * iso_frame_desc[], which is a flexible array allocated
> +		 * at URB creation time. A response must never claim more
> +		 * packets than originally submitted; doing so would cause
> +		 * an out-of-bounds write in usbip_recv_iso() and
> +		 * usbip_pad_iso(). Clamp to zero on violation so both
> +		 * functions safely return early.
> +		 */
> +		if (rpdu->number_of_packets < 0 ||
> +		    rpdu->number_of_packets > urb->number_of_packets)
> +			rpdu->number_of_packets = 0;
> +		urb->number_of_packets = rpdu->number_of_packets;
>   		urb->error_count	= rpdu->error_count;
>   	}
>   }

Look good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

