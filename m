Return-Path: <stable+bounces-267532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /rhvOTieN2p5PQcAu9opvQ
	(envelope-from <stable+bounces-267532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 10:18:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 532846AA678
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 10:18:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IGIPkLRA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267532-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267532-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 132BC301CC37
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA82848BE;
	Sun, 21 Jun 2026 08:17:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A01274B44
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 08:17:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029832; cv=none; b=pGjC9SX7DJue32RzfFdrNtF1aMQ275hIeNYzG/LMa22wHYtFnoqvEG7hh1ciELGX+7kNOv98htJX5UjL5h/DEJHy16EI6/r7dqwuv+XNa3rsivWgPtl74WJsIuEU1mvYOq1WdqgZYXd8yfZXjt3pAJvPszXspvWcIi4HNUu4xTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029832; c=relaxed/simple;
	bh=gmAnStZ8FyZx2TvUXcP7lf5VWLG1jbjrk1AXQ6cghxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RipBf1KAWvgnw4mg83zcaOuLTB0IRFfs5+ocaMuQXZzX5UGUh9blHxnuNAxydv/JhvYvlWOOTSKBC36/JtIp8wwtAatBCU9ieCslvT0JOxDGTEbqm0h4n7UWK5Vyv6AzRFjCGCXsiwa5IXB51oDo0GY0H9+VuMrFtFcXmw/6anM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGIPkLRA; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-46019b190b6so2659479f8f.3
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782029828; x=1782634628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xv8167L13PZ/JQZMUsJG/gGl8WHuMlNvKPvQHLdring=;
        b=IGIPkLRAKULhs6PPvfp54vjEI13GYwoqM7T6hUu9c0YfkBdgXqV693kxtcBpzMOeVs
         bTekNvAF2IBMV9XKtLoR3vaC+/z9rtRv0dpmmxKW/zb6eDtNH/oJcvCuyQgaBhVVJqbZ
         B22I/IMTgIocYy5xpss9U4Uq+j2D0iNk2opMm1kfM4A4wpmFZWOVIl4Zfp4QR3e62yxl
         At+XCDFbvoG/ZXs+VlJo2Ytqq+J0P1kwKm7brhY1JgFcBRi/4CZ2sb/TeIbOZ7ZJl7jN
         ZPrdqMcakXTSXomAF0FBoxsFpUdk/zkmJUDFZBHh4jdSrG2RbvVDDoxhIzyXA9DmSEed
         uCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782029828; x=1782634628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv8167L13PZ/JQZMUsJG/gGl8WHuMlNvKPvQHLdring=;
        b=cH0ulnLBydV2Y7Yb6IDDKnR8c30feL0K/hOLfNGRfzqv/J9u1mBiIJo3KVWhr4SBbr
         lxh/QfyjKF4gxmgQhF9errtlVxtQ/dzdkvU3cax+eSb9l91KI7qyTc+36LUtKgsPIx7F
         FQHKkvLOfU/HRbW6EYvvYEArIk3vKmeeookwYDtx4fyRksbxU6MMKVEelwE6rd2bEIR+
         XUec54ay/tiAH+2dcznmWE/PyD4G+9HzTfKkLoccyar+kHkSKDeR09ZFtoTFVVauekwg
         i21xag8rFI650OgNmXbYxvOm+SOk+qQ4GLlYObqF3aCuRKuSf0cqENQ4KJcpufl3TxyL
         megQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVOxe+JmqvxvKce5H5hhfOFOeP7r17BFN/7gKEJdbTFpnxHWFtoP/WdT01LXKnEn5qyy0r+v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu06IvNKh7rNJ1NK9x2MQdAUgn1CJz/UrdVJyUKkhGvBugThVE
	W8AajVl2mWHQ+DOWq7178QXhEJmzjcAa0O009U2VpVloYFmOn3s+xQ9Q
X-Gm-Gg: AfdE7cnD2PoPAEOAbXb3ubqy5q5as3Cs7r2Xvf4Irqqvv4gv5MX87vSRWQ7PkYEtyjm
	nNIEHVXErYl9Bz2Rz1WoeEpelm+IO6Ue6afCkr6iXWHiokRV6Bc6gI2FlOu3AFlg0wlkZ7MOrha
	dAjUhAvxh2Ly5fauURTf8Z8RDAUKgtBOqHWZuFVRjcxb1JI1xQmTma/TqC+AMDoGhG6yTs9xNTG
	Y7/W0aFeLEWC7xJHtMoxTrEe2t+JNCDmGjZYV/vek7maFexnOoSJpYUeaX/9iNbQcp8XhOt1Sp8
	tsocu8czOGIM4nBdAacMLo+1w23x18f4ULQkwRP858kiwKAvSkdral3F6Oxd1Bm0X3aft+Zdkbc
	7tSYeudOo2oofg4NO/nmA+D9jjd0hknIJn/ofWIUyyXc5BpLGdQ6iVLMQKsmTMu9RAtr1TLefF3
	eazg3nQbsmqRaP5BGPzxf3A6y7P10pMZHeGu5kaktHfr7KHYCpwHV/HqBFKPTRa+F2l5DVE/BWj
	76+P9WrRiI=
X-Received: by 2002:adf:fc8c:0:b0:43f:e934:50ac with SMTP id ffacd0b85a97d-464fff62e1emr13858379f8f.7.1782029828081;
        Sun, 21 Jun 2026 01:17:08 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5ddbsm15917211f8f.12.2026.06.21.01.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 01:17:07 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wbDH4-000000002RS-40So;
	Sun, 21 Jun 2026 10:17:06 +0200
Message-ID: <a2bc98ef-fae5-4309-9066-452ee780fe04@gmail.com>
Date: Sun, 21 Jun 2026 10:17:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: clamp command response copy to the read
 buffer size
To: Doruk Tan Ozturk <doruk@0sec.ai>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, kartikey406@gmail.com,
 Tristan Madani <tristmd@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260619224818.90751-1-doruk@0sec.ai>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260619224818.90751-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267532-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[0sec.ai,googlemail.com,sipsolutions.net,oss.qualcomm.com,gmail.com];
	FORGED_SENDER(0.00)[chunkeey@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:jeff.johnson@oss.qualcomm.com,m:kartikey406@gmail.com,m:tristmd@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:chunkeey@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,0sec.ai:email,appspotmail.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 532846AA678

Hi,

On 6/20/26 12:48 AM, Doruk Tan Ozturk wrote:
> carl9170_cmd_callback() copies len - 4 bytes from the device command
> response into ar->readbuf, which was allocated by the caller with
> ar->readlen bytes. When the firmware/device returns a response whose
> payload is larger than the requested ar->readlen, the mismatch is only
> logged (and the device is restarted via carl9170_restart()); the code
> then still performs the full-length memcpy(), writing past the end of
> ar->readbuf -- an out-of-bounds write driven by an attacker-controlled
> (malicious/compromised) carl9170 USB device.
> 
> Clamp the copy to ar->readlen so an over-sized response can never write
> past the caller's buffer. A response that fails the length check is
> already discarded by the restart, so copying only the buffer-sized
> prefix changes nothing for the valid path.

This is contested territory.
<https://lore.kernel.org/linux-wireless/26e33fea-c81e-48f4-a058-4b3bf0dc95c5@gmail.com/>

Original patch (as part of a series is from Tristan Madani)
<https://lore.kernel.org/linux-wireless/20260421134929.325662-2-tristmd@gmail.com/>

Yes, I do think each came up with the patch individually. But I have no idea how
this works with three authors / tools? Does anyone? I don't think this will get
any better though.

> Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> Tested-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> Verified with syzbot via "#syz test" against the public C reproducer
> (Tested-by above); I do not have carl9170 hardware locally.
> 
>   drivers/net/wireless/ath/carl9170/rx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index 908c4c8..897e682 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -150,7 +150,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
>   	spin_lock(&ar->cmd_lock);
>   	if (ar->readbuf) {
>   		if (len >= 4)
> -			memcpy(ar->readbuf, buffer + 4, len - 4);
> +			memcpy(ar->readbuf, buffer + 4,
> +			       min_t(unsigned int, len - 4, ar->readlen));
>   
>   		ar->readbuf = NULL;
>   	}

Regards,
Christian

