Return-Path: <stable+bounces-244026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIuQHBu1+WnUAwMAu9opvQ
	(envelope-from <stable+bounces-244026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:15:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E21DE4C9650
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C766303649C
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECC630E82C;
	Tue,  5 May 2026 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9mQicBP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530730F816
	for <stable@vger.kernel.org>; Tue,  5 May 2026 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972495; cv=none; b=kZLMzHtHIH3aXISP9UwzNM0NxNriemdeaPIofgNXybprh2UCyquoog5iQlqpwQLj9TO/2rk2ukrx+q8llzDn8DAFAC083cP0GyklgssgSbWTLhhRKWZvUtPoXFY9k1HmJKAg9dquj5CnJHMmhGqT4g1YHerHjmOcOirZkh/uNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972495; c=relaxed/simple;
	bh=21bhpduPBAzP/8bbIcPKvaU7pSC8NYtoArYXu1/phn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMGz7s/2EelRvOOl3me5Nq72in2Zc6l8/SWe894QiLCRzxyTwP/ROhpUYtY1GkroPjw1LfjFCjwf0MQhf+b05jr0qnHwep+6xsJ48WcORF58gY+NKTpAI4i84g8JJ/M5QFebI7iuo/tmCFinleDDwZ+7XTTU3uIpoJ5A68TCOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9mQicBP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso36238505e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777972492; x=1778577292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MJ5jvSmy3GosoYN4CBc5oeGoIhzHzzIKBuMNkH0u8Q=;
        b=a9mQicBPMAScg61mtgHczRkrfBpppDxn0875T5gwUUe9fKDI/5dKUMtStHVBjux1fP
         bXda+1zqlHFL/tDCxI0mlxdEG9tuuqSbC91wmG9Io1qcF1JoY0vZpgq+5Gslsde5zVPC
         uu4PBNuMoeTjswgPPVVdxG3LyyohPObOYL4OiDY2QX9j5zZ9B4Ihaf9xmDBqhXNdPeph
         /yINJM9z7AQCtVafKZ7y61qBCsJX5XqnpM1YXSpmxZkm0Xl3g+3rMcSd5qXYFHLVlwCV
         PzByXd0x+9Fnnq1rR3wXf7CMqrFbeA+r76wCuaWqKaF2jBYr8FEZGTLMtnPrPSc2WyHy
         Cf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972492; x=1778577292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MJ5jvSmy3GosoYN4CBc5oeGoIhzHzzIKBuMNkH0u8Q=;
        b=oZM9AIUvC/KyT/NiTCN16z+oJwl+1gGIhraTvykBZWVV2stRVtVtk12c89g8EFdBsV
         PwUEhDPiGnYr76V+Yh9YOmK8SHooqo018fTRKQNQsj5b3Faw5VjwoPq6+SgeuZEe9aDA
         jSJPraLDRLb/TCgNhEeQmE9ymk+CSZqEuHo9NRv7gSoq8VB4m+o0bDeQUh6tOmC0Kv3R
         an+pw1oDlzGamwpOBZP8uLN4BNiso6TmcvR40eLKeKRgHsMK6h36Ujq9Q1vwB/5HxWQA
         f6mOvkD9LzSQcxzhTnkJ9oeU4nRE9CP93+b3uCQF1KJdX0gZbAkL3noEyrUzhH/zlI6f
         c0ug==
X-Forwarded-Encrypted: i=1; AFNElJ//S65Eu0b5EK5vSjECi+shKgGVLhdWXlFj+YDS9V4wwlrW2BZQOvFma3ZK1daaGPk3lsXSqzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxns0N8YkhG4crAZR38rRn3GZpHa3ZJrGajsbNGRjFNZvnGjVlJ
	X3xAGju1WSqi+AKy9+2gGPua7RpE7ODLXiW5L9rVUlMP2Uowt9A6H0tyVxLTVil7lT0=
X-Gm-Gg: AeBDiesj1CrGiu0W2ev6HmhGwtm+MzozZf8tNZirNjXYvvF/e5915ZnOaYWU0zdi+f3
	wPIBCiWYX4svjcl+Ryg7TfEGjsCYfJBSDqrYbnIC1wnluI81ZIG3VoAdX1O0v0TShVwVWjKcAju
	9BmTfUVFs97ka+VbEYlw3qk9s+z+mxaiEZJS/o9FnBJ7BYugYdeTfCNVZFrWH1Q4/tKU3QoShCp
	zK6/nDFCwE2Sljla6ih9UGfFZ/HakE/2HGyDqRCkBLI17vpNUMZtXjqvnwO0+vTjKkrQO33SoDV
	Gb33eoK2wMhzSD/2Qh6itbd4yzQwV3k7aBPVpkd6udex2K11Xi5Zu39jHvbG2l16FgGZe003CUw
	SIqxMd2wOIDxdbKrYVaXUVJHDrlJILOIif0sdy8LJ0NUrNJdut5iCh0qYmQ89i3PsVaMalJhgv7
	IVolBG6vOFJE2C1AZFXwknf8dmglQrfF7ShjvIBLyzO5k=
X-Received: by 2002:a05:600c:4f48:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-48a988ccc94mr241921645e9.27.1777972492118;
        Tue, 05 May 2026 02:14:52 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17708195sm19352525e9.3.2026.05.05.02.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:14:51 -0700 (PDT)
Message-ID: <cc973c62-4e33-4055-8059-dfc454447d0e@linaro.org>
Date: Tue, 5 May 2026 12:14:48 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] firmware: samsung: acpm: Fix cross-thread RX
 length corruption
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com,
 stable@vger.kernel.org
References: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
 <20260504-acpm-fixes-sashiko-reports-v4-1-529246be6b2b@linaro.org>
 <8e5ad1bc-e404-4247-8a38-aa2a51df24bb@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <8e5ad1bc-e404-4247-8a38-aa2a51df24bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E21DE4C9650
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244026-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]



On 5/4/26 9:36 PM, Krzysztof Kozlowski wrote:
> On 04/05/2026 12:15, Tudor Ambarus wrote:
>> Sashiko identified a cross-thread RX length corruption bug when
>> reviewing the thermal addition to ACPM [1].
>>
>> When multiple threads concurrently send IPC requests, the ACPM polling
>> mechanism can encounter responses belonging to other threads. To drain
>> the queue, the driver saves these concurrent responses into an internal
>> cache (`rx_data->cmd`) to be retrieved later by the owning thread.
>>
>> Previously, the driver incorrectly used `xfer->rxcnt` (the expected
>> receive length of the *current* polling thread) when copying data for
>> *other* threads into this cache. If the threads expected responses of
>> different lengths, this resulted in buffer underflows (leading to reads
>> of uninitialized memory) or potential buffer overflows.
>>
>> Fix this by replacing the boolean `response` flag in
>> `struct acpm_rx_data` with `rxcnt`, caching the exact expected receive
>> length for each specific transaction during transfer preparation. Use
>> this cached length when saving concurrent responses.
>>
>> Consequently, ensure that `xfer->rxcnt` is explicitly zeroed in driver
>> helpers (e.g., `acpm_dvfs_set_xfer`) for fire-and-forget messages to
>> prevent uninitialized stack garbage from being interpreted as a massive
>> expected receive length.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
>> Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> I think parallel credits for Titouan Ameline would be suitable here.

I agree.

> If there is going to be new version, please also add:

There's going to be a new version, will add. I have to admit I'm
impressed by sashiko's review skills.

Cheers,
ta

