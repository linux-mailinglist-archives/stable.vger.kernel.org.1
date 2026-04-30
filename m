Return-Path: <stable+bounces-242171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGmYKGaJ82mS4wEAu9opvQ
	(envelope-from <stable+bounces-242171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:55:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB4D4A612A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB50C300FA07
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C042B75A;
	Thu, 30 Apr 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="la+T50yT"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FE2DEA61
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568100; cv=none; b=W4B310prcmTNq7pkjwO4+iK3rBokMh2b+2R5HKITc7RGdNQxRCohBv2GXB313EAgUcd9wlSsMS6wKVGaQakZnwNvNPGbYBERLiiiJm8P9Vxe1QU0YxQecvQ/fHd7yS7UQslqqaiiH7r3DZAIzyd+mXV/ceruWzaX1OMLm3okgXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568100; c=relaxed/simple;
	bh=eUBp07JKTe82zy1ykUrgvp3E6cfoSBuBKsp0BQUA5sM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m96x01vP46S0CjqOakXQRGC13unWCxGzNAkiewS6Nd4qH+h/H1eHFW7DXynf0VgU6wQmkZc5d/tm3U/rcw3y7YdxyHQAMtRGeDj3Y9zSjOso3NmZLwLcHFOD3LZ03HsVZXbXjZG4w71awgAFnkOX9g09GOUMaghFPw4xF9WJLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=la+T50yT; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d9916deb14so908800eec.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777568098; x=1778172898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nSw+yolZYnlsfqzqQJDRiH90jYV8jI3JvmhNU4UgfQ8=;
        b=la+T50yT46UYls8wd9vBo9pXd4/tj2bcTxIu4bambdQoDJPCPZ2egjDPqeAj8oYlX2
         gHz7qwDpPautLnVmijMOK/HbbhxbPTpc7NbGGlJSAdyt0ZjyPlIt60+/E+yQ/6giPD9i
         VNk3JBUvvf7fWlVmW5DXSdf5FqqtO34OhCHyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777568098; x=1778172898;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSw+yolZYnlsfqzqQJDRiH90jYV8jI3JvmhNU4UgfQ8=;
        b=q0Qilxsjx4rOjtKttKdPI43yKzuZbld+TsujoV9Tv8KeSUmd5FQGbBYBzS5tDygRNo
         8EEwIyJoS8NFqZVGbNERxAL4xNJfDLh7a+1RQi11BGQkD3VcFnlEkB7t4/z38uTlXPFH
         1bmPVzlZWAOtgmiZ655JgFAc5lKRjlaHfSiphlWcFKfJdZnok/tBc5eHxuo1na3fjuPz
         5Q80XoMMUPJFRf7WnUA+KFJCegWlGMNexvCzHUciEXADAUwayff9k6iMz26Bnp7eUCFY
         pLXv0mHhpiQr8l99oVoIZ9JRkdL5TcPx/VdyQUN/GDYP1kLEYjtsLwqrHz1IQPSmKQzh
         FVZA==
X-Forwarded-Encrypted: i=1; AFNElJ+MzQSeA7Co0h9X5Sv0mCLVYaa2hMM3yshzJK6oeJlbb6hC33ExvzFzDPob79qbOVmKzj9ButU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVT5mdJJ4jmMTHk0uR6PyTHq11wUQNdUQdMKq/rndZM0N3o5k
	fz/GZoPwR5dQuNZ5rUykk3+PWVA3oV5lhEulq+kuVWWY1QwFx/hRj3y6PCqhxKDIO+8=
X-Gm-Gg: AeBDieuXlkMUFdArgVvvQzsD9wQiTn7mIQch0B7OsqwHQcWURe3cvMR6epkF3lta9pt
	8ptHVOD+vGwEWu+4jqy017/0cynIs/ENLCGimjm4+W1HK4GuywoxTG+uQtWKkv0VhBK4cEMLlIK
	8olLU0e1SXhHgoDk7ktbpGL2Q3EtsKzajlZap8fK2bZCnMWiOrDyQ9D/3XTbkgpLcSi2NimIaMj
	yjplJ/d0zcLSJ2DKt6kTKJdmD3zwDCOrHkAFbt9XlbDfQRqNB2ie2f81Ph9rIgmi3OmcP2Qs+J1
	GuF94+67c7JH/O5aQm1V5+qXu8QslLIsWJ2jzjH6R6uow2TPjwn5GRVOsLpV9+tQNIe031pgW1L
	3lZbc6sEqPHJSmA9aWV2P0b9258dM2IsLMCdvj3RDuvsGYkAVt65jgrZ5uymf5QLeHHrSHArq9F
	vKV7H7MfWq/HpkMC9YdCNWt/c8ZjwkVthhYMs0ao7/YYCn79YAgKR7CH/SlGhp2u2CncmHKbt5k
	dibvabmYZVTTfRshhLSkKezvwBrYyxgkc5pa2NFf3F8EIm690Y9dv7qqVlzzWWIUhd7NXeT2fx8
	n90V33JzOo9NtfoEdZCroNjjrFgdh8UecGc0
X-Received: by 2002:a05:7301:6508:b0:2df:7b88:a1b0 with SMTP id 5a478bee46e88-2ed3e67ba53mr2079292eec.27.1777568097436;
        Thu, 30 Apr 2026 09:54:57 -0700 (PDT)
Received: from [10.10.10.191] (97-120-253-104.ptld.qwest.net. [97.120.253.104])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b11fsm553662eec.19.2026.04.30.09.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 09:54:56 -0700 (PDT)
From: Kris Bahnsen <kris@embeddedts.com>
X-Google-Original-From: Kris Bahnsen <kris@embeddedTS.com>
Message-ID: <271d8aeb-1159-46f3-b290-31b6e094d8a0@embeddedTS.com>
Date: Thu, 30 Apr 2026 09:54:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org,
 Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260427174657.691272-1-kris@embeddedTS.com>
 <afJZSCXeoSO502o1@google.com>
Content-Language: en-US
In-Reply-To: <afJZSCXeoSO502o1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8CB4D4A612A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[embeddedts.com,none];
	R_DKIM_ALLOW(-0.20)[embeddedts.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242171-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[embeddedts.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kris@embeddedts.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,embeddedts.com:dkim,embeddedTS.com:mid]

Dmitry,

On 4/29/26 12:19 PM, Dmitry Torokhov wrote:
> On Mon, Apr 27, 2026 at 05:46:57PM +0000, Kris Bahnsen wrote:
>> The workaround for XPT2046 clears the command register, giving the
>> touchscreen controller a NOP. The change incorrectly re-uses the
>> req->scratch variable which is used as rx_buf for xfer[5], so by
>> the time xfer[6] occurs, the contents of req->scratch may not be
>> 0. It was found that the touchscreen controller can end up in
>> a completely unresponsive state due to it being given a command
>> the driver does not expect.
>>
>> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
>> transmit all 0 bits. Also set rx_buf to NULL because the value
>> returned does not matter. Thus moving the 3 byte pattern to clear
>> the command register to a single message.
> 
> Unfortunately my suggestion was flawed: I think this will flood the logs
> with "Bufferless transfer has length %3". We need to have either tx or
> rx buffer :(

Ah. I do see that dev_err() line in spi_transfer_one_message().
All of my testing up to this point has been with an SPI host driver
that implements its own transfer_one() operation so that error
was never actually reached.

I'll send a v3 today that reverts back to the two separate xfers,
using scratch for the rx_buf, and then NULL for tx_buf. That
sounds like that should be the path of least resistance.

> 
> Thanks.
> 

-- 
Kris Bahnsen
Software Engineer
embeddedTS


