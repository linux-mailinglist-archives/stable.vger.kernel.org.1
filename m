Return-Path: <stable+bounces-215921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK28EneMjWnq3wAAu9opvQ
	(envelope-from <stable+bounces-215921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:16:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC412B2AF
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6916F300691D
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C042D028A;
	Thu, 12 Feb 2026 08:16:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266F2C236B;
	Thu, 12 Feb 2026 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884209; cv=none; b=AvGv7ZmUWAnyID/+ss/Tmxud8hEMzCbKh9+HN/Tdx4VzuJAoRizvhAcRdZs27hf5pHM68xAW+eCse/zLqu8lLbeYmtE1/ZMv2nexy1XQ2HyR8WronEXEurmgQeAiXcn7ykicyW5Ivdrs6QyHmSCGCbUqhTlFtkVvmyEuWSqwLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884209; c=relaxed/simple;
	bh=d/VoO/HeDmjeOI8y90MSAVJLI9O7yUzvouiqcwFR6hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMMyWmUUphLmzugMKrvjNhO1fNZL77LnBexOuyecQ4cu7Ky3i9lXhV8dgeNXsOiiadUdsX0ZXoX3KwhNWn3P+htYoT0SR84sgeO3wUQjDLeVh/8YWnjtZfX76etBKG/YZ/Huw+HbkwItYk/39KaBeMEm9sKmMz0XxkeYbYlNG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af117.dynamic.kabel-deutschland.de [95.90.241.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B4E674C1A25A2E;
	Thu, 12 Feb 2026 09:16:36 +0100 (CET)
Message-ID: <18fca2c1-c35f-4624-9520-7425f99e7781@molgen.mpg.de>
Date: Thu, 12 Feb 2026 09:16:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Fix CIS host feature condition
To: Mariusz Skamra <mariusz.skamra@codecoup.pl>,
 linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org, Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
References: <20260212074111.316980-1-mariusz.skamra@codecoup.pl>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260212074111.316980-1-mariusz.skamra@codecoup.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mpg.de:email,codecoup.pl:email];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215921-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: 5FBC412B2AF
X-Rspamd-Action: no action

[Cc: +Naga]

Dear Mariusz,


Thank you for your patch.

Am 12.02.26 um 08:41 schrieb Mariusz Skamra:
> This fixes the condition for sending the LE Set Host Feature command.
> The command is sent to indicate host support for Connected Isochronous
> Streams in this case. It has been observed that the system could not
> initialize BIS-only capable controllers because the controllers do not
> support the command.
> 
> As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
> supported if CIS Central or CIS Peripheral is supported; otherwise,
> the command is optional.

It’d be great if you documented the BIS-only controller you tested with.

Also to easier find your patch in the history, I’d find it useful to add 
the log messages of the failure.

I think you are missing the Fixes: tag.

Fixes: fe05e3c0593f ("Bluetooth: hci_sync: Add LE Channel Sounding HCI 
Command/event structures")

Though this was just merged in this 7.0 merge window.

(This seems to be a common mistake, and was fixed at another place in 
commit 5af69ab9bc62 (Bluetooth: ISO: Set CIS bit only for devices with 
CIS support).

> Signed-off-by: Mariusz Skamra <mariusz.skamra@codecoup.pl>
> ---
>   net/bluetooth/hci_sync.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index f04a90bce4a9..0b0dc0965f5a 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4592,7 +4592,7 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
>   {
>   	int err;
>   
> -	if (iso_capable(hdev)) {
> +	if (cis_capable(hdev)) {
>   		/* Connected Isochronous Channels (Host Support) */
>   		err = hci_le_set_host_feature_sync(hdev, 32,
>   						   (iso_enabled(hdev) ? 0x01 :

Feel free to add

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

