Return-Path: <stable+bounces-233039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL08NVl/zmkWoAYAu9opvQ
	(envelope-from <stable+bounces-233039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:38:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 964FF38AA8C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 16:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 156AE303478C
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D13DFC98;
	Thu,  2 Apr 2026 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fl33Lh9w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56E32860F;
	Thu,  2 Apr 2026 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140235; cv=none; b=DK24cFFn1XqYe+4RLijgbRDkbhZnMxBaKMutj3zJQNw7YxwlZlWMHizV5UIjj1AT+4usuGGVca+vmbZuRL1qA9G0Z8wSGCUhUZW/QpVipLI32gR/Z7gGn7oNHbhe/i7EQqCFbmjrhrLJ4DxRDYOyLH+6N+8a8ncp0UXuYPXJMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140235; c=relaxed/simple;
	bh=KUMXYFAQHcBixB5esGEhaung2dJFI8UmBxNtKtZQn+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiaHRLiCqMqpoTd/JhW1RqmsRjWhlisI8FxLW4s732F+zRA6eVKxQ8BEZP6mou2yex+JGk+pWgfD3eD6RHJQ86JMxCRAiDTps+SArMecZWbjbJR6ePB1V8NB0g1CzBAqM2OAj61Y/LrmnyRuKtmhyjQ3zkQRrCIiARihXkvc/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fl33Lh9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA44C116C6;
	Thu,  2 Apr 2026 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775140235;
	bh=KUMXYFAQHcBixB5esGEhaung2dJFI8UmBxNtKtZQn+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fl33Lh9wGT67xV+pOYNAfnqJ3UAC53VslcyZOYExXnpmqqGJHMuzM7JEzfS/fxX/Z
	 cd626mExxAEcJ0NTCQV/X/jndu/K/cFtuxBE0j85wbCRsYgeaYoBqp61f2Cug/sg/K
	 iTZPx/4k/nojq+8wt4CHtItGyzZVaBhr9SSF4BFA=
Date: Thu, 2 Apr 2026 16:30:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tyllis Xu <livelycarpet87@gmail.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	ychen@northwestern.edu, danisjiang@gmail.com
Subject: Re: [PATCH] ibmasm: validate MFA offset against BAR0 size
Message-ID: <2026040209-slogan-voting-4342@gregkh>
References: <20260308060411.258298-1-LivelyCarpet87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308060411.258298-1-LivelyCarpet87@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233039-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,vger.kernel.org,northwestern.edu,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,northwestern.edu:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 964FF38AA8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 08, 2026 at 12:04:10AM -0600, Tyllis Xu wrote:
> ibmasm_interrupt_handler() and ibmasm_send_i2o_message() dereference an
> MMIO pointer derived from a hardware-supplied MFA offset without bounds
> checking, allowing out-of-bounds MMIO reads and writes.
> 
> A compromised service processor can supply a crafted MFA value whose offset
> exceeds the size of the mapped BAR0 region. The driver passes this
> through valid_mfa(), which only rejects the sentinel 0xFFFFFFFF, then
> immediately uses it to compute an MMIO pointer in interrupt context.
> A malicious message_size field can additionally drive
> ibmasm_receive_message() to read further beyond the end of the BAR.
> 
> The root cause is that get_i2o_message() adds the hardware-supplied
> GET_MFA_ADDR(mfa) offset to base_address with no upper bound check, and
> incoming_data_size() trusts the hardware message_size field without
> clamping it to the remaining mapped space.
> 
> Fix by storing the BAR0 length at probe time and rejecting any MFA whose
> computed offset would place the i2o_message structure outside the mapped
> region. Also clamp the data sizes passed to ibmasm_receive_message() and
> the outbound memcpy_toio() to the remaining mapped space so that a
> crafted message_size or oversized dot command cannot drive reads or
> writes beyond the end of the BAR.
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: ychen@northwestern.edu
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
> ---
>  drivers/misc/ibmasm/ibmasm.h   |  1 +
>  drivers/misc/ibmasm/lowlevel.c | 33 +++++++++++++++++++++++++++------
>  drivers/misc/ibmasm/module.c   |  1 +
>  3 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/ibmasm/ibmasm.h b/drivers/misc/ibmasm/ibmasm.h
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/misc/ibmasm/ibmasm.h
> +++ b/drivers/misc/ibmasm/ibmasm.h
> @@ -139,6 +139,7 @@ struct service_processor {
>  	struct list_head	node;
>  	spinlock_t		lock;
>  	void __iomem		*base_address;
> +	resource_size_t		bar0_size;
>  	unsigned int		irq;
>  	struct command		*current_command;
>  	struct command		*heartbeat;
> diff --git a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/misc/ibmasm/module.c
> +++ b/drivers/misc/ibmasm/module.c
> @@ -96,6 +96,7 @@ static int ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (!sp->base_address) {
>  		dev_err(sp->dev, "Failed to ioremap pci memory\n");
>  		result =  -ENODEV;
>  		goto error_ioremap;
>  	}
> +	sp->bar0_size = pci_resource_len(pdev, 0);
> 
>  	result = request_irq(sp->irq, ibmasm_interrupt_handler, IRQF_SHARED,
> diff --git a/drivers/misc/ibmasm/lowlevel.c b/drivers/misc/ibmasm/lowlevel.c
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/misc/ibmasm/lowlevel.c
> +++ b/drivers/misc/ibmasm/lowlevel.c
> @@ -26,9 +26,17 @@ int ibmasm_send_i2o_message(struct service_processor *sp)
>  	mfa = get_mfa_inbound(sp->base_address);
>  	if (!mfa)
>  		return 1;
> +	if (GET_MFA_ADDR(mfa) + sizeof(struct i2o_message) > sp->bar0_size) {
> +		dev_err(sp->dev, "ignoring out-of-range MFA 0x%08x\n", mfa);
> +		return 1;
> +	}
> 
>  	command_size = get_dot_command_size(command->buffer);
> +	command_size = min_t(unsigned int, command_size,
> +			     (unsigned int)(sp->bar0_size - GET_MFA_ADDR(mfa) -
> +					    sizeof(struct i2o_header)));
>  	header.message_size = outgoing_message_size(command_size);
> @@ -60,12 +68,25 @@ irqreturn_t ibmasm_interrupt_handler(int irq, void * dev_id)
> 
>  	mfa = get_mfa_outbound(base_address);
>  	if (valid_mfa(mfa)) {
> -		struct i2o_message *msg = get_i2o_message(base_address, mfa);
> -		ibmasm_receive_message(sp, &msg->data, incoming_data_size(msg));
> -	} else
> -		dbg("didn't get a valid MFA\n");
> +		if (GET_MFA_ADDR(mfa) + sizeof(struct i2o_message) > sp->bar0_size) {
> +			dev_err(sp->dev,
> +				"ignoring out-of-range MFA 0x%08x\n", mfa);
> +		} else {
> +			struct i2o_message *msg = get_i2o_message(base_address, mfa);
> +			u32 max_data = (u32)(sp->bar0_size - GET_MFA_ADDR(mfa) -
> +					     sizeof(struct i2o_header));
> +
> +			ibmasm_receive_message(sp, &msg->data,
> +					       min_t(u32, incoming_data_size(msg),
> +						     max_data));
> +		}
> +	} else {
> +		dbg("didn't get a valid MFA\n");
> +	}
> 
>  	set_mfa_outbound(base_address, mfa);
> 

Patch does not apply to the char-misc next branch, and seems to be
corrupted?

Please fix up and resend.

thanks,

greg k-h

