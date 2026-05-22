Return-Path: <stable+bounces-253714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAp+Fj0VEGphTQYAu9opvQ
	(envelope-from <stable+bounces-253714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:35:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A935B0A3E
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98D6301BF65
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3D33E367;
	Fri, 22 May 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wEsqLI6s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B681A9F85;
	Fri, 22 May 2026 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438901; cv=none; b=JBvIh3VxUeKLxk0DPE09x9ALbOlVW02WFHNNjB9IQSY16QoHsKF+INtw73QtA4YRDJpzEZWReBsey9jBI07UCnbxQY6XZiVWO8zjvbnH8waThzCr/Y4HP2HkAWYP8Lw13Fahsgtt7K2UwSWVQpgFUdAmbkrFXaGjwlT5+1lUr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438901; c=relaxed/simple;
	bh=ghO5HdHVk9W9/8MfBV5bEDaB0ysAAPb44M/qGQe63+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH/RzwBuPi01JEaQ6IWcYOft0U7brr/Q0DX3JXzu8pX3B/N8ri0S68ykpYU6DR+5NxVQrfLZMK8edUSceZI6MxYvJJhW7pINqibESEOnIwnQSKKWXmunqiSLO3Nec3gvdXB6bYwBnNo9RHJLo3qVf9jjIBxBCOhggfu9AvRHjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wEsqLI6s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CC21F000E9;
	Fri, 22 May 2026 08:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779438900;
	bh=UjZcikDBn+mEyk9EwCKColgQiXbfJKIk1p+8IdzYj5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wEsqLI6smlUaweTseMJVGBkLMq5wxhRp/svFlLPIWqQxwhDW33HXOfBezWBSOG1tu
	 HqP7TXR1bSS94j9p3n1p4xGMemlIaHVL5UQFobkRM0QNHi55YkGfFcIXsJjeO2UQjE
	 DGJ3+kWmnvcfS/mROhqzel3f03a4OGTntrcIKopM=
Date: Fri, 22 May 2026 10:35:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bingquan Chen <patzilla007@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH v2] usb: gadget: configfs: fix OOB read in
 ext_prop_data_show()
Message-ID: <2026052255-pureblood-crying-38e1@gregkh>
References: <20260422023919.37588-1-patzilla007@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422023919.37588-1-patzilla007@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253714-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B3A935B0A3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:39:19AM +0800, Bingquan Chen wrote:
> In ext_prop_data_store(), for unicode property types, the data buffer
> is allocated via kmemdup() with size 'len', but data_len is set to
> len*2+2 to account for the UTF-16 encoding and a 2-byte null
> terminator, as required by the Microsoft OS Extended Properties
> Descriptor specification (dwPropertyDataLength must include the
> terminator).
> 
> However, the null terminator is never actually stored in the data
> buffer. When ext_prop_data_show() reads the data back, it computes the
> read length as data_len >> 1 = len+1, then does memcpy(page, data,
> len+1), reading 1 byte past the allocated buffer. This is a
> slab-out-of-bounds read that leaks 1 byte of adjacent heap data to
> userspace via configfs.
> 
> KASAN report (5.10.252):
> 
>   BUG: KASAN: slab-out-of-bounds in ext_prop_data_show+0x4a/0x60
>   Read of size 9 at addr ffff888005546008 by task poc/62
> 
>   Allocated by task 62:
>    kmemdup+0x17/0x40
>    ext_prop_data_store+0x52/0x130
>    configfs_write_file+0x168/0x200
> 
>   The buggy address belongs to the object at ffff888005546008
>    which belongs to the cache kmalloc-8 of size 8
> 
> Fix by allocating len+2 bytes and explicitly zero-terminating with a
> full 2-byte UTF-16 null terminator. This ensures the buffer fully
> matches the dwPropertyDataLength semantics (len*2+2) while eliminating
> the OOB read.
> 
> Fixes: 7419485f197c ("usb: gadget: configfs: OS Extended Properties descriptors support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bingquan Chen <patzilla007@gmail.com>
> ---
>  drivers/usb/gadget/configfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 183a25f65ac8..b2c3d4e5f6a7 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -1352,8 +1352,12 @@ static ssize_t ext_prop_data_store(struct config_item *item,
> 
>  	if (page[len - 1] == '\n' || page[len - 1] == '\0')
>  		--len;
> -	new_data = kmemdup(page, len, GFP_KERNEL);
> +	new_data = kmalloc(len + 2, GFP_KERNEL);
>  	if (!new_data)
>  		return -ENOMEM;
> +	memcpy(new_data, page, len);
> +	new_data[len]     = '\0';
> +	new_data[len + 1] = '\0';
> 
>  	if (desc->opts_mutex)
> --
> 2.43.0

This patch is corrupted and can not be applied :(

