Return-Path: <stable+bounces-244124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIlHEUbf+WlPEwMAu9opvQ
	(envelope-from <stable+bounces-244124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:15:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3DC4CD48A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 053AF3011060
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B343423A95;
	Tue,  5 May 2026 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glcoBprD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE8421A06
	for <stable@vger.kernel.org>; Tue,  5 May 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983290; cv=none; b=KIi5StzwWS99fpIOvVTZICcZ0PDOt9J97NZ/JIIzjePsThN/EK7tMY8SdcZzCGtSMpIRHRoXF1Rqc2LJmnC0DoRup4ZyShDQQlyjq4VzJ8iLh7wkN44Mxag6yc6ZMoD2YDH594Gt48eHWDnyskFuIXD2HsWZa3TqzevNEXAnd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983290; c=relaxed/simple;
	bh=sp+LO4TT1w2KXKSdG77dGU2CwJG8n8ZXUH1+jk/AMic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFIjX7/sDhcBaKiSz10dDlBZ00qJKwvDzA1MZk2zoVYMRfUEMIs5C0xCMZTyYkYbmgZBaQjbtAe020XJP3O2MbcYf2pweosLSf2jZxHkhtooN+pZdvZj0/JKkFCLivdpOyWQtJd0K+NzZbJg293EFFvaQWuZpHOC8iwah006kyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=glcoBprD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so34832855e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777983287; x=1778588087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzVA3bAqqUzorx+k6MSHtdqUxfZ3J2aAaM3KCVizFPE=;
        b=glcoBprDTlo4VZhJnk2MeW3gMc+RDZvRBJ5RG0dC0HBt42AMK8Oael440uwO3pq9vY
         kpDYAQ+9KzkIwPUhGoopXYqquLAq4O6r76N4NEWuqHp/AkfsRnS5IGJIPwH7nVkohJ4c
         3zMKhpgfTgBG8DIOGqP9+l6u1z1iNsGXaKwPuHkYUapXVc+nfiwFnvYPiGX+7VV07QDp
         GHfy4333F1Phhho8cl/KJDYAkQKbBviU3BqpgfhLf6P+ziOf0nC+x7CKDqKwpZJGXsiq
         5fWAACFM/WU0BT0aS7zI5ZJhnMyUl+bO6f93X5WJect2A7FMwYh1+qyl44NZ9ps4w5rH
         W36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983287; x=1778588087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzVA3bAqqUzorx+k6MSHtdqUxfZ3J2aAaM3KCVizFPE=;
        b=haQc/4EDXZxc0BZcaEq6vj9bUHtEmzEUpyzCjd6SFSCpt0NLP6gnw308rPNMvYaIYh
         u6E4fcnA2wnXZvCY6ziAZCaT6ydIF9PSHX0XlDctAzHhJFNVdNvPWEAz+MjoAgvlYP4B
         bc6h047zaLL7jU6GpIXbFdSU2Xl3KQVuMYPuz7r4x6QKar86nhapC+hJa+2sJ6ayhNeH
         2U/Hf269JJaU0vbFSQyzaqzKt0igeZqRkFI3XwlvwiLG4v24szrKfXQkzan/7fobgGDs
         afOiaeqZ7chmukq1kXFWzrhR63Tr5d8JsA4qbKyOTd16x81hIORkQ264IrojYphyPM+v
         72Qw==
X-Forwarded-Encrypted: i=1; AFNElJ+NaaV8alAqzy0Pzc9AqG50fwr4f8vnVZ/oX8REuD7o/lGFaz1a5izigYUSkDl7pziI+EpGrD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4KvXD+mJ81mylshsW2QbKRf4Au9+Lwzna+wH9KtWaLoBB8Yh
	ogtCgb41LQHcHPbJRuOBlRZXidukru1RBffSo9Tt91bWoispLgKZQPrxiWO5ZPB44XU=
X-Gm-Gg: AeBDievpA/YjmatB3odqKIPhT6QQfQ/MphlVgoWQ3XqJGZpKLtSI/QI/bRKKwKV4avt
	dhSWr9/NlB5cXr0yFHdXt29aIuOGQhTYwcp3s7ntooS1FKuB8TLdZQtIkuiCkdWwXOQO3ai/Btw
	hiWqLJIFe05Dl/zJnVgy4+EZuzi2eU0ktaHevn87P/qs6h2u4CDJQSTlN0AMs7SXrF0LuraIM22
	GGGaaMF91FTwnMHlJvZPXfYfFnCw9ra789KChF2d8hZVaAKmowEmn6yOH2M79nGWlcgV68cYXZ+
	I6Jgrh3LbuYwYr//BLPm2RKig02WrLSM2NlwB+ycxY60tiW/TZh/FKVMhb4B8V904tYduCwLFIZ
	MhY2V8nP9RAtJXNKcvB1sE9Yovn5TFgS0/RUjLPcEUVt7w0HcqRE/meQVZtzAA8m7yqMsrdNf18
	vCfnTLfk4A36BOOkzBWMBh2omZmXo0nFgOEhfTnOhnPec=
X-Received: by 2002:a05:600c:3f06:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48d1424a351mr58621115e9.8.1777983286660;
        Tue, 05 May 2026 05:14:46 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm362772905e9.6.2026.05.05.05.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 05:14:46 -0700 (PDT)
Message-ID: <366fc343-0cac-4e03-a08e-aa50a6e17314@linaro.org>
Date: Tue, 5 May 2026 15:14:42 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] firmware: samsung: acpm: Fix false timeouts in
 polling path
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com,
 stable@vger.kernel.org
References: <20260504-acpm-fixes-sashiko-reports-v4-0-529246be6b2b@linaro.org>
 <20260504-acpm-fixes-sashiko-reports-v4-5-529246be6b2b@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260504-acpm-fixes-sashiko-reports-v4-5-529246be6b2b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EC3DC4CD48A
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
	TAGGED_FROM(0.00)[bounces-244124-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi all,

Before sending out the v5 of this series, I wanted to share what Sashiko
found when reviewing this patch, I think they are great examples of
tricky concurrency bugs. I'll also give some hints on how I'll be fixing
the problems in v5.

> @@ -261,6 +264,12 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
>  			if (rx_seqnum == tx_seqnum) {
>  				__ioread32_copy(xfer->rxd, addr, xfer->rxcnt);
>  				rx_set = true;
> +				/*
> +				 * Signal completion to the polling thread.
> +				 * Pairs with smp_load_acquire() in polling
> +				 * loop.
> +				 */
> +				smp_store_release(&rx_data->completed, true);
>  				clear_bit(seqnum, achan->bitmap_seqnum);

Sashiko pointed out that calling clear_bit() immediately after setting
completed = true creates a fatal Use-After-Free window.

If Thread A natively finds its message, it copies the payload, sets
completed = true, and clears the sequence bit. If Thread A is preempted
right before evaluating smp_load_acquire() in the polling loop, a
concurrent Thread C can claim that exact same sequence number, overwrite
the buffer, and reset completed = false. When Thread A finally resumes,
it reads false, misses its completion signal, and eventually times out.

>  			} else {
>  				/*
> @@ -271,8 +280,19 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
>  				 */
>  				__ioread32_copy(rx_data->cmd, addr,
>  						rx_data->rxcnt);
> +				/*
> +				 * Signal completion to the polling thread.
> +				 * Pairs with smp_load_acquire() in polling
> +				 * loop.
> +				 */
> +				smp_store_release(&rx_data->completed, true);

The second issue occurs when dealing with cross-thread responses. If
Thread B drains the queue and finds Thread A's response, it saves it to
the cache and sets completed = true. It intentionally skips calling
clear_bit(), expecting Thread A to do it.

However, if Thread A calls acpm_get_rx() (finding nothing) and is
preempted right before evaluating smp_load_acquire(), Thread B can
step in, cache the data, and set the completed flag. When Thread A
resumes, it sees completed == true and immediately returns 0 (success).

Because Thread A returns immediately, it completely bypasses calling
acpm_get_saved_rx(). The result: the sequence bit and the response are
permanently leaked.

Both of these bugs stem from a lack of strict ownership over the
sequence slot. To fix this in v5, I will be rewriting the polling loop
to enforce the following invariant: Only the polling thread that
allocated the TX sequence number is allowed to free it, and only right
before it exits the polling loop. Specifically:
- clear_bit() will be completely stripped out of the RX draining paths
  (acpm_get_rx and acpm_get_saved_rx).
- acpm_get_rx() will now return a native_match boolean, which evaluates
  to true only if the thread natively processed its own sequence number
  during the call
- the polling loop will use native_match to determine if it must pull
  data from the cache.
- the polling loop will execute clear_bit() on its own tx_seqnum only
  after the payload is safely in the caller's buffer.

Cheers,
ta

>  			}
>  		} else {
> +			/*
> +			 * Signal completion to the polling thread.
> +			 * Pairs with smp_load_acquire() in polling loop.
> +			 */
> +			smp_store_release(&rx_data->completed, true);
>  			clear_bit(seqnum, achan->bitmap_seqnum);
>  		}
>  
> @@ -318,7 +338,13 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
>  		if (ret)
>  			return ret;
>  
> -		if (!test_bit(seqnum - 1, achan->bitmap_seqnum))
> +		/*
> +		 * Safely check if our specific transaction has been processed.
> +		 * smp_load_acquire prevents the CPU from speculatively
> +		 * executing subsequent instructions before the transaction is
> +		 * synchronized.
> +		 */
> +		if (smp_load_acquire(&achan->rx_data[seqnum - 1].completed))
>  			return 0;
>  
>  		/* Determined experimentally. */
> @@ -384,6 +410,7 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
>  
>  	/* Clear data for upcoming responses */
>  	rx_data = &achan->rx_data[achan->seqnum - 1];
> +	rx_data->completed = false;
>  	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
>  	/* zero means no response expected */
>  	rx_data->rxcnt = xfer->rxcnt;
> 


