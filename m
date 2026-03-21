Return-Path: <stable+bounces-227769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA+LA+OevmnoUgMAu9opvQ
	(envelope-from <stable+bounces-227769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 14:36:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 090482E58C5
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 14:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7D30300C6F0
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4038C402;
	Sat, 21 Mar 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfWkyGW4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340438B7B1;
	Sat, 21 Mar 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774100179; cv=none; b=ohBCfM+Fu2BwpCk1ZCEyP4tQzZFzLUJnXQxB8yw+gvcaaoFhWUhhdO71PL96vR2ZUEwiLVcfPXY/lbferssov/9UmDN6rW0izL+dnX6DLBiVAenHcTUXxCEAppvYRN1UZIkS3cqsX06JVUlY2/dMYbRQi2HVomB7k//FO9UWr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774100179; c=relaxed/simple;
	bh=ScEthUcLfpX621z6HtFnqRquosLH06QLxz8gxt9F8Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smoUfaj3seZRPraza6GDr2IdU+9uIWtJUEFoEal3A6E7CerdE/WwiAO9qPNxAd/PDlZDIj3ystXj25BtEVmdK6Y+FQPVLKupmV8gOo2HnSTlJiG1o51bWZKTJnAsAArnhHfZs77n9f1zQZVutFWv5kB67hoZCuE7RM6fG539nsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfWkyGW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6C1C19421;
	Sat, 21 Mar 2026 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774100179;
	bh=ScEthUcLfpX621z6HtFnqRquosLH06QLxz8gxt9F8Lc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mfWkyGW4u4C/onbagpRCHYFYfGetckJWs751FJGNn3t/wq4qxg8U+CqrhtGqHIh6T
	 8uxouxrbuZF4Gf6h87cyP55Zc8BXYfFXgfrs9Kxd/0viswRCyaZ1F7IAV4A2Yi341s
	 D5KOpW0S7nTg85tDinOHVmYKHE9+3p7HhX/VaIF61UYgpQ0/8cpnWhtUKOq06Ug/EM
	 rpQUDL7wWyq7LHOqA8zCSvWUIQOVvVC5XB7Ikau0Eppr6pje9jbSwDS7FzRPEgFpF+
	 lss+2fn2KEG1ly43nFju+p9JVvDT9byhEw0M2i/wazJi6B/ehFS+0LOYnTatiJmzwa
	 3EPe3RXJfKsnw==
Message-ID: <224fb6d5-47aa-4677-a257-aa470e05c5dd@kernel.org>
Date: Sat, 21 Mar 2026 14:36:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: fusb302: Switch to threaded IRQ handler
To: Alexey Charkov <alchark@flipper.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260317-fusb302-irq-v2-1-dbabd5c5c961@flipper.net>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260317-fusb302-irq-v2-1-dbabd5c5c961@flipper.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227769-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 090482E58C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 17-Mar-26 17:30, Alexey Charkov wrote:
> FUSB302 fails to probe with -EINVAL if its interrupt line is connected via
> an I2C GPIO expander, such as TI TCA6416.
> 
> Switch the interrupt handler to a threaded one, which also works behind
> such GPIO expanders.
> 
> Cc: stable@vger.kernel.org
> Fixes: 309b6341d557 ("usb: typec: fusb302: Revert incorrect threaded irq fix")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
> Changes in v2:
> - Re-added the IRQF_ONESHOT flag to the request_threaded_irq() call
>   (thanks Hans de Goede and Sebastian Andrzej Siewior)
> - Link to v1: https://lore.kernel.org/r/20260311-fusb302-irq-v1-1-7e7105706629@flipper.net
> ---
>  drivers/usb/typec/tcpm/fusb302.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index ce7069fb4be6..889c4c29c1b8 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1764,8 +1764,9 @@ static int fusb302_probe(struct i2c_client *client)
>  		goto destroy_workqueue;
>  	}
>  
> -	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
> -			  IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
> +	ret = request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
> +				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +				   "fsc_interrupt_int_n", chip);
>  	if (ret < 0) {
>  		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
>  		goto tcpm_unregister_port;
> 
> ---
> base-commit: 95c541ddfb0815a0ea8477af778bb13bb075079a
> change-id: 20260311-fusb302-irq-316834765871
> 
> Best regards,


