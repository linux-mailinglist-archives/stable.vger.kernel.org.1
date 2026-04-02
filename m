Return-Path: <stable+bounces-233118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHPrIwbYzmmGqgYAu9opvQ
	(envelope-from <stable+bounces-233118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA638E2B6
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3707C3026AA2
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50236604A;
	Thu,  2 Apr 2026 20:56:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733430F816;
	Thu,  2 Apr 2026 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163391; cv=none; b=o8+GhFQK28nfZzhs9voFaXkCUVy/CBg1dcvcJX6kV2tdCs/I4L5StEspsGotGRTy5rDZtGn/gJQP4vB998tDlUVsUdFZClCmdg8VupmW63O0IocWS2Ez1yrrqq8NyhabtYdQSbgc/P7z9M+uepMSBpJ+Qx342MYNJSvAptID7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163391; c=relaxed/simple;
	bh=1zotro0gKzhUhtGeNvJw9wplZhtNFy2WyCXqQf1WZNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRiIsXD5G+9A8bKXExGmoipR0yi6Jc9saKAlljxFBzB3La4uybO1YELUzvIKaP5lP7G8xUtLZHFtRN6rP+ygpFTwq8dfVUccVsZDKuKaiPCwc/onlW4cspCs5GjGvY5eAUo/ixMCT0XQzhUkqs0NRCwUy3hDZwQsLMt/EnNxwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5b13a32b.dip0.t-ipconnect.de [91.19.163.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8FE4E4C2C37D60;
	Thu, 02 Apr 2026 22:56:17 +0200 (CEST)
Message-ID: <8697c336-3fff-470c-9a37-26a7f8f89189@molgen.mpg.de>
Date: Thu, 2 Apr 2026 22:56:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] Bluetooth: btusb: fix use-after-free on
 registration failure
To: Johan Hovold <johan@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260402154810.2467291-1-johan@kernel.org>
 <20260402154810.2467291-2-johan@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260402154810.2467291-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233118-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.021];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[molgen.mpg.de:mid,mpg.de:email]
X-Rspamd-Queue-Id: E9AA638E2B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Johan,


Thank you for looking into and fixing the additional comments.

Am 02.04.26 um 17:48 schrieb Johan Hovold:
> Make sure to release the sibling interfaces in case controller
> registration fails to avoid use-after-free and double-free when they are
> eventually disconnected.
> 
> This issue was reported by Sashiko while reviewing a fix for a wakeup
> source leak in the btusb probe errors paths.
> 
> Link: https://sashiko.dev/#/patchset/20260402092704.2346710-1-johan%40kernel.org
> Fixes: 9bfa35fe422c ("[Bluetooth] Add SCO support to btusb driver")
> Fixes: 9d08f50401ac ("Bluetooth: btusb: Add support for Broadcom LM_DIAG interface")
> Cc: stable@vger.kernel.org	# 2.6.27
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/bluetooth/btusb.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 21e85c212506..97de6e6e7dbc 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4372,7 +4372,7 @@ static int btusb_probe(struct usb_interface *intf,
>   
>   	err = hci_register_dev(hdev);
>   	if (err < 0)
> -		goto out_free_dev;
> +		goto err_release_siblings;
>   
>   	usb_set_intfdata(intf, data);
>   
> @@ -4381,6 +4381,15 @@ static int btusb_probe(struct usb_interface *intf,
>   
>   	return 0;
>   
> +err_release_siblings:
> +	if (data->diag) {
> +		usb_set_intfdata(data->diag, NULL);
> +		usb_driver_release_interface(&btusb_driver, data->diag);
> +	}
> +	if (data->isoc) {
> +		usb_set_intfdata(data->isoc, NULL);
> +		usb_driver_release_interface(&btusb_driver, data->isoc);
> +	}
>   out_free_dev:
>   	if (data->reset_gpio)
>   		gpiod_put(data->reset_gpio);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

