Return-Path: <stable+bounces-272638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lSnKEMQ3Tmq9JAIAu9opvQ
	(envelope-from <stable+bounces-272638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 13:43:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9CC725F78
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 13:42:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VPTPKnwS;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272638-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272638-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A12F30C4EB7
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E38435A91;
	Wed,  8 Jul 2026 11:36:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E225433E99;
	Wed,  8 Jul 2026 11:35:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783510560; cv=none; b=mPfpXCzToDlZpQbBAF6uhNJY7O72AaWIG6sVAo7kBcFqvtQCaOkYNuSJw13l9SYRfQ9ATq4mqiaI8miZqLgU+n+2T4YMV6hnXULG5OvTWccDA8nj0AwfUPXP6kAki9+dLwmJo9pvvRqB5QFAwbBlHiZj5J6N9q2QJBjAvRlz6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783510560; c=relaxed/simple;
	bh=Q2Qnk1hogSqDDsPQYYaS7M/yFKkup3CqxIVtncozZqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+6qNuZuLFbS4q5EiTV7a8cjMdAY9UGBaU0QKep/wLQAICHNGA9WqBqw3KqYx8t4g4sRWeD6dbwjbwoRkHNkddG4Xn1gI6U0mdzpPc0bxwEFC02vNOwoUGAfKThXzD66gKnXvd4cgmY/onK4PBjcyalr81q05X8jBAcx/6cf108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VPTPKnwS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EECB1F00A3A;
	Wed,  8 Jul 2026 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783510559;
	bh=EEbcityEZ0Yex7B8TH8L8kxhoIKkE2qcglVaaqevIfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VPTPKnwSe5X/kbPP13nBrvlt5ZX4vrrFQpjcjYfqkmnJyAP9G/rZh55RC6gOo9GLY
	 dIqF1Y90jkBhydUEhNjGXav0C/mMgazQDhcrvk9yvyoNpIPMlnn3z7+kj8ZrDBsmTO
	 cphsiwdFb5PfEAN9Wgvm6ru5c1/6yTbJihlfdfwo=
Date: Wed, 8 Jul 2026 13:34:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: printer: fix infinite loop in
 printer_read()
Message-ID: <2026070828-salvaging-brook-67cb@gregkh>
References: <20260701205320.227791-1-mlbnkm1@gmail.com>
 <20260703075429.302687-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703075429.302687-1-mlbnkm1@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mlbnkm1@gmail.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:peter.chen@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272638-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B9CC725F78

On Fri, Jul 03, 2026 at 09:54:29AM +0200, Melbin K Mathew wrote:
> printer_read() uses the same variable for the requested copy size and
> the number of bytes actually copied to user space. copy_to_user()
> returns the number of bytes not copied, so when it fails to copy
> anything, the computed copied length becomes zero.
> 
> In that case len, buf, current_rx_bytes and current_rx_buf are left
> unchanged. If RX data is available and the user buffer remains
> unwritable, the read loop can repeat indefinitely.
> 
> Track the copied length separately and return -EFAULT, or the number of
> bytes already copied, if an iteration makes no progress.
> 
> Fixes: b185f01a9ab7 ("usb: gadget: printer: factor out f_printer")
> Cc: stable@vger.kernel.org
> Reviewed-by: Peter Chen <peter.chen@kernel.org>
> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> ---
> Changes in v2:
> - Drop unrelated comment wording change.
> - Add Reviewed-by tag from Peter Chen.
> 
>  drivers/usb/gadget/function/f_printer.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index e4f7828ae7..e346e4c26e 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -432,7 +432,7 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
>  {
>  	struct printer_dev		*dev = fd->private_data;
>  	unsigned long			flags;
> -	size_t				size;
> +	size_t				size, not_copied, copied;
>  	size_t				bytes_copied;
>  	struct usb_request		*req;
>  	/* This is a pointer to the current USB rx request. */
> @@ -525,14 +525,16 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
>  		else
>  			size = len;
>  
> -		size -= copy_to_user(buf, current_rx_buf, size);
> -		bytes_copied += size;
> -		len -= size;
> -		buf += size;
> +		not_copied = copy_to_user(buf, current_rx_buf, size);
> +		copied = size - not_copied;
> +
> +		bytes_copied += copied;
> +		len -= copied;
> +		buf += copied;
>  
>  		spin_lock_irqsave(&dev->lock, flags);
>  
>  		if (dev->reset_printer) {
>  			list_add(&current_rx_req->list, &dev->rx_reqs);
>  			spin_unlock_irqrestore(&dev->lock, flags);
> @@ -543,6 +545,17 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
>  		if (dev->interface < 0)
>  			goto out_disabled;
>  
> +		if (!copied) {
> +			dev->current_rx_req = current_rx_req;
> +			dev->current_rx_bytes = current_rx_bytes;
> +			dev->current_rx_buf = current_rx_buf;
> +			spin_unlock_irqrestore(&dev->lock, flags);
> +			mutex_unlock(&dev->lock_printer_io);
> +			return bytes_copied ? bytes_copied : -EFAULT;
> +		}
> +
> +		size = copied;
> +
>  		/* If we not returning all the data left in this RX request
>  		 * buffer then adjust the amount of data left in the buffer.
>  		 * Othewise if we are done with this RX request buffer then
> -- 
> 2.39.5
> 

Patch is corrupted and can not be applied :(

can you fix that up and resend?

thanks,

greg k-h

