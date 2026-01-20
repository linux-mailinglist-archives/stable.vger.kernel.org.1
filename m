Return-Path: <stable+bounces-210500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJNFK+ZhcWkHGgAAu9opvQ
	(envelope-from <stable+bounces-210500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:31:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 218405F8D7
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99E298627AC
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C05C3E9F6B;
	Tue, 20 Jan 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5hRf789"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75746427A13
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910716; cv=none; b=dvd5z89sMVoXp8vHXh1x7AoPL/ctKb5M3UH0NhEuE9wDG3Y/ue6A+driyGQBP62L6oT8NnHw7RJ8uXOjTrOVzDX+s5Pi2JDpaUFUS1V22Lb7+aphCJEbMq3tjYXIMiCfwCy15C0IBnocYWP65ySZBFdLKKqTYbZ0Gd87h25LVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910716; c=relaxed/simple;
	bh=1SUJOIbcpKZ97vROXHZbc4uywvg5mICVVTFXnu+8N0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7/J+jdITVZNDlwRGOv8XRaPDpTXc5NKX3c93ijJ46K34g8tX7i3qR6stExn8TyfhCRRKDVC3PiS934KSZWy+HWKej/YV4IeF3lO4YVIjsqsU+swZ6jbS7c89DPI9474GyDnvr5nz3RpjV5/i7XfHxu3Rx5iaMB/SAw/teNi0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5hRf789; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so30443255e9.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 04:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768910713; x=1769515513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JckE27aaTC/MenhzlCHYt+N31ilQSZiKPy2PxHLLEmg=;
        b=e5hRf789+sDFQRo4cko4z9oRXrlGElRU7lc3q4NIGtOKRke9YROX5TAjFeOGYG6zAW
         3afOnjx6LtmlHGG8SnjkSYi60DZlm+xWEtNPl5XHhbOigMUkNQXq9Vkjk2/KUM83xdJe
         Qr2vyCN7NhlYNZEXAyhadErhC5U7UxK8mu7qesPXXLphqQgmkfTwyKPcv0UgmLCtO3+w
         g+K5+owI/G78G9+Buz9UkqF9jdtxHHto+udzSPwkkLdMvZ/B4qq3NFxDUjuyQaQUStO9
         Qm1FFIHgeC/RgGVPEBVFXfQbTnr+LDxjUuqkJSa9bwCJKjns+s+IcSIgwoq0ffvymAIB
         DKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768910713; x=1769515513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JckE27aaTC/MenhzlCHYt+N31ilQSZiKPy2PxHLLEmg=;
        b=QBtiLP96vL+D4YfAWrBbJhhGEz+nA5H9CP8POPoAQPfAbTHSy4frFrT3H14qYtgDBu
         X5hs4lDtyfCxHz08B6ushOSM+1jBEmRPxNZ70ErB9zd6FXObXlNskvZAAexrHyhEWEpp
         LPZyl59YLTpz+bSoFVzV2CF09SzbNKIk3Cy6XIZdg8jQHLeuXAYyGebDkYIigxkLxnxE
         T1Vprzdddc//LVvQdAE2tsXKrq+z3OXRLoRkqPiulGbNYSFRsCNYXZCGGBcRKtB9vg9V
         3VgD2E5/ufibLnbp8J+v/teFhnNzHH9JHq2SyNiVnTdYRUUawHKrHG0FnKOcLdQmhpdg
         5nYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXthyYgfTQn+rGrfN0xLen9wNNh2+HcWsa1yOy5ooSzmufXNmOE4thUYOV3nzXFNGfrNJpO/7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqv0YBW74D6AlBdADQrLAhzOoVoPt2YC9Wl8J5GR5BHDNJwP4Q
	MwgM433KzBbSu0Hpg7iU+jM5nkLaqE0FXHbM8CP8uh3/9QObYYZlHUPz
X-Gm-Gg: AY/fxX5eXl3fAZdYpwhK2V3qAfJmpWuiHH5hg3G64oAS0MHzp3NOKJmSjUlDOA2SJs2
	v8goGy1dRLlQjwgdtJY2du/P31mvFSWpmLIJ1mapWrdUH15/rAfm2bgkzRUQXLvgpFw3/l0zyxV
	w/k/1Y4e9MHixRNCeJ7xorF0WgC5t7VDA9VPIrkD6imuGYLT1sBRJ+TuHaID2AwgiV1DolsLnA7
	0FW839mT9ZVXBoxrpsqGPQGhhD7cZjaLL1+Reb9wIsLM+oRYGmD0xnOhJNQu15lvfiM6Vc6pd4A
	NUJGb8iq+RSBygeQfbI2qzf7s3wlbcIQ3DCOJmSrzWpjVFoMLGSVlswGCFEAgiGY2hZ7GS6agQw
	4AxCkDr15d60dtyGA/LprSqspwyG1KIQPoF6a+nwbVkv2zcHHdz62rGhk3fkwJq7MzQLf7bNnHV
	pdGPoj5tDrPPcziJmI1iUqu9wYdIIN5GcQgyHEfX930x2tsszqLD0iNqgO/FiqQhWR7C+6FO3Cl
	fRAfrubg2NK7f3lytAUjYV7GfFXtoadgahiaWLGOxfU7ttfFed5749tyTEP93y1
X-Received: by 2002:a05:600c:8b6c:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4801e66fcc5mr167787885e9.10.1768910712480;
        Tue, 20 Jan 2026 04:05:12 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b789sm302284295e9.1.2026.01.20.04.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 04:05:11 -0800 (PST)
Message-ID: <d8d28435-2a89-4b25-925e-14fdb346839b@gmail.com>
Date: Tue, 20 Jan 2026 12:05:09 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring/rsrc: fix RLIMIT_MEMLOCK bypass by removing
 cross-buffer accounting
To: Yuhao Jiang <danisjiang@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260119071039.2113739-1-danisjiang@gmail.com>
 <bc2e8ec1-8809-4603-9519-788cfff2ae12@kernel.dk>
 <CAHYQsXTHfRKBuTDYWus9r5jDLO2WLBeopt4_bGH_vVm=0z7mWw@mail.gmail.com>
 <2919f3c5-2510-4e97-ab7f-c9eef1c76a69@kernel.dk>
 <CAHYQsXQK4nKu+fcni71__=V241RN=QxUHrvNQMQtPMzeL_z=BA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHYQsXQK4nKu+fcni71__=V241RN=QxUHrvNQMQtPMzeL_z=BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	DATE_IN_PAST(1.00)[35];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-210500-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 218405F8D7
X-Rspamd-Action: no action

On 1/20/26 07:05, Yuhao Jiang wrote:
> Hi Jens,
> 
> On Mon, Jan 19, 2026 at 5:40 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/19/26 4:34 PM, Yuhao Jiang wrote:
>>> On Mon, Jan 19, 2026 at 11:03 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 1/19/26 12:10 AM, Yuhao Jiang wrote:
>>>>> The trade-off is that memory accounting may be overestimated when
>>>>> multiple buffers share compound pages, but this is safe and prevents
>>>>> the security issue.
>>>>
>>>> I'd be worried that this would break existing setups. We obviously need
>>>> to get the unmap accounting correct, but in terms of practicality, any
>>>> user of registered buffers will have had to bump distro limits manually
>>>> anyway, and in that case it's usually just set very high. Otherwise
>>>> there's very little you can do with it.
>>>>
>>>> How about something else entirely - just track the accounted pages on
>>>> the side. If we ref those, then we can ensure that if a huge page is
>>>> accounted, it's only unaccounted when all existing "users" of it have
>>>> gone away. That means if you drop parts of it, it'll remain accounted.
>>>>
>>>> Something totally untested like the below... Yes it's not a trivial
>>>> amount of code, but it is actually fairly trivial code.
>>>
>>> Thanks, this approach makes sense. I'll send a v3 based on this.
>>
>> Great, thanks! I think the key is tracking this on the side, and then
>> a ref to tell when it's safe to unaccount it. The rest is just
>> implementation details.
>>
>> --
>> Jens Axboe
>>
> 
> I've been implementing the xarray-based ref tracking approach for v3.
> While working on it, I discovered an issue with buffer cloning.
> 
> If ctx1 has two buffers sharing a huge page, ctx1->hpage_acct[page] = 2.
> Clone to ctx2, now both have a refcount of 2. On cleanup both hit zero
> and unaccount, so we double-unaccount and user->locked_vm goes negative.
> 
> The per-context xarray can't coordinate across clones - each context
> tracks its own refcount independently. I think we either need a global
> xarray (shared across all contexts), or just go back to v2. What do
> you think?

The Jens' diff is functionally equivalent to your v1 and has
exactly same problems. Global tracking won't work well. You can try
to double account clones, or wrap it all together with the xarray
into an object that you share b/w rings on clone. Just make sure
it's protected right.

-- 
Pavel Begunkov


