Return-Path: <stable+bounces-150232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEF8ACB794
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD68A271F4
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E323184C;
	Mon,  2 Jun 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hU+2bDb/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEB221F00
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876463; cv=none; b=YJRouZCcKUytF4aoHJUWIMY5dZBLWw0KKlq0XOq3+JJ5In7Srgc28os4iH9+TDwsvo8Z9z/M5vz6tHBQiAqPXbS94tcoFWl7QT9BcUPI+bWL21cK/v7gXpwKsxKUd+PXT55zi/Bjp7g6fhtegfh2JK4r8qImj5DXGf2FwcCMvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876463; c=relaxed/simple;
	bh=5dRvYuDZHJt4dxtRSL6dPD9so8Zn1bK1pE7CkV2g2Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F01Ts44tHj+a3W2kXqjP2VF7DfxV6IJMCq40yzwnivGGXBYRyUHCYt0ZtQv2S+7ZoIr8bPKuYP5OqUqyucGCxYfongfH56Exi9aG92YygYuWdGcr8QGWkr1bavGzg6VjGW7+Hxt2jWkYRbhf2lnuPRTUer2dgNs8BZHJxL1INmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hU+2bDb/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72bd5f25ea6so1029684a34.1
        for <stable@vger.kernel.org>; Mon, 02 Jun 2025 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748876459; x=1749481259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKRRslHq9l+I796/Ew8fuJsvx+yR6BWkXnH67RqDqcg=;
        b=hU+2bDb/YufFv5TP3/Vt4IJ2p5GaGEr1PigKVuaZUr7Ib5W4nyT35HT1C0G/RcLMci
         JGZKpXIzvxGdCcTxaCq4Ntfn89Jxhdsm41zAZTDX8Yjd4JpNPzE+J6EkOu8X9tRPl3CG
         rH0+6mBCJESkwo0kF05vPdTj6aTWQv/Ci46Uq9EJawpcfW/Rt1h25pah94HgnmascrxH
         SJ6tVWzRNLD8EaKxiZV9qx0mNzIlKzUskx0+mHdEZyInlPzoZI8H5FMbwsp7xIZ28JMV
         RKdeW7IhiP5BIvV/KOIztNp15VMLAqU+zLORon3ozBQBiJpYF9o23rAlvx/Yq66URdWD
         qYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748876459; x=1749481259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKRRslHq9l+I796/Ew8fuJsvx+yR6BWkXnH67RqDqcg=;
        b=lrLxXVb8RlLPJuI1KROFZk0w3xdSXZAm3HYz4QJv0jlEHytqtIJhUL3ExfUQvEtdDC
         9FnMxHX80bTJAnZzMlRTBXq8UmnZ98eLiniJ5vswe78BU2ogMlPceiFCXW1pYzHuQRmt
         OYuYE71ZcMAFGqJzJL56Z6KZbeQliWQcKx9uMWd9o7bO77ae3jG//VWLMuywI+x1E+c4
         wy/K4LHHh2CuLY6CgxVcErrqFGRjxQi6hDRUPN+Fr8P+hMdUTEXq/KLue70hLkspDAz4
         7eHAuwqXK+DzwNB4LOrMScND/6ddyJep0SsKUApj48P5rr3nArk4Ok1TaqH72Uy4RkMh
         OIdw==
X-Forwarded-Encrypted: i=1; AJvYcCUwykZT17vsXDiACGcJYIRNVcQAoE8+z2u4umvahgIMGS4HotoqU785SfzsEPypH6tAQrzoJNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7+W0O2nsuZFDMPtag+5L+aUIG2JidASsl9QwQ+nJsQKsJ3n0u
	NtyZhDjUf/IBdSJ4655NTiWvM/fMsDz6eWHs6t7X2YetuYA73E1y0tZ+fIjJgffpXMM=
X-Gm-Gg: ASbGnctjJ6rfL6attBgiyAIwkXwb1kLMZKWsXKa5rG9/ruswGtdwIlrrE6YTGvzsw4S
	fol5UCOiOMXNHbYNngRDCbXDaZA1V93TmqZsj6UadFsK1RUVoDEdQTv7hiCyzCfz9/qG2k/dlvS
	FaHAQBPewyNViZJ6VAQF+YPHAtWd2REdLKQfh8YGC+2Wdez4jS4/wLiFit66P6qbYyxGmaiFSVv
	6tV9rGRQR4UcBi/ul0xS3sSOG5DQ10YDgqUzzafRiAZkc0uu7p4YygceRlm6UAdnzHYFArFS09N
	Co6z6sFx2gqSyLcs7HP67kXkNQP84R2nd61cLkBoC/hW4R9BRxLPIk3kuA9Uw8kdtiHeWZ9vDiZ
	Dk+Qy+IMo1e8e8rW258quF/+0EK2we314akZHnc8=
X-Google-Smtp-Source: AGHT+IE+kAIBR0NheiTCHpkl4+yPXWEfW3+c5RK6WjfBdTqWkx83ge6s8Nuep+dL1P8pXQzSBEB20Q==
X-Received: by 2002:a05:6830:6582:b0:727:36a0:a2ae with SMTP id 46e09a7af769-736ece4918emr8154398a34.14.1748876457933;
        Mon, 02 Jun 2025 08:00:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf? ([2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af82d086sm1555913a34.11.2025.06.02.08.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 08:00:57 -0700 (PDT)
Message-ID: <f0c94748-7d09-41c0-9557-b37a1f6a8f7b@baylibre.com>
Date: Mon, 2 Jun 2025 10:00:56 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush
To: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com>
 <20250531175302.05b2da17@jic23-huawei>
 <x6lmsxsz6njt22z23l3nbetlstkwn4jk5ohgtpyd23idwleeg5@szatvfu4drjj>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <x6lmsxsz6njt22z23l3nbetlstkwn4jk5ohgtpyd23idwleeg5@szatvfu4drjj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 5:50 AM, Sean Nyekjaer wrote:
> Hi Jonathan,
> 
> On Sat, May 31, 2025 at 05:53:02PM +0100, Jonathan Cameron wrote:
>> On Sat, 24 May 2025 12:34:09 +0200
>> Sean Nyekjaer <sean@geanix.com> wrote:
>>
>>> fxls8962af_fifo_flush() uses indio_dev->active_scan_mask (with
>>> iio_for_each_active_channel()) without making sure the indio_dev
>>> stays in buffer mode.
>>> There is a race if indio_dev exits buffer mode in the middle of the
>>> interrupt that flushes the fifo. Fix this by calling
>>> iio_device_claim_buffer_mode() to ensure indio_dev can't exit buffer
>>> mode during the flush.
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
>>> [...]
>>> _find_first_bit_le from fxls8962af_fifo_flush+0x17c/0x290
>>> fxls8962af_fifo_flush from fxls8962af_interrupt+0x80/0x178
>>> fxls8962af_interrupt from irq_thread_fn+0x1c/0x7c
>>> irq_thread_fn from irq_thread+0x110/0x1f4
>>> irq_thread from kthread+0xe0/0xfc
>>> kthread from ret_from_fork+0x14/0x2c
>>>
>>> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>
>> That's nasty and a case I'd never thought about.  Most of the
>> races around disabling end up with an extra sample or two which then gets
>> dropped because there are no buffers enabled.
>>
>> We need to consider the active scan mask as part of the buffer state.
>> So effectively taking mlock if we enter this code will delay the state
>> transition (and change of active_scan_mask until after this interrupt is done).
>>
>> If David's synchronize_irq() is enough maybe that's a lighter weight path?
> 
> I agree if David's proposal is sufficient, I can try it.
> It's something we have seen once in some unrelated testing, so it's
> quite hard to reproduce :/
> 
> /Sean

Maybe temporarily adding a time delay of one sample period towards the
beginning of fxls8962af_interrupt() could make it easier to reproduce?

