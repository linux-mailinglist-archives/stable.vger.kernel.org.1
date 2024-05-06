Return-Path: <stable+bounces-43148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19A8BD672
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2D7282DBE
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2715B57C;
	Mon,  6 May 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="teXmew1q"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532071581EC
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028294; cv=none; b=LJ84Yh8Xf3ve9urBwd0D1T9ogjY6ozYZocbfLp0yIdZ0dJqg921fQ+tmm6a2HOrBbgkjFjYYWVK7c7rZts15CPYhHpYAQg8oBesaVU44LhnGzPrqaAAMLtcF13XjOFcrbMdJKZ8HBz4oQP8jQ4ryJ3YudbEkWqEosEUjKdUj/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028294; c=relaxed/simple;
	bh=drCcBSrlzxJErR715w6Te36qsnKWmqq9cVsFnUeIcuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoOXFXailxNzTkH2nzw9QakjkhvnkY0OxyGuf6nmpLuhgUIR2drlzhoJB06X54CYSCeZumeyl3ukFWUb0WUP2jTqTStMSLbjHw/LGx8wV40VHJqZRtHWC12gTZCK9yDRd/vwyL/WU7+4UAxCE6xCA4TI3/TMLMnbNOU3WghGLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=teXmew1q; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23d477a1a4fso1796797fac.3
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028292; x=1715633092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIYUSfxnqcB3NTYw8qzJ1HpCK1phCS/ngs47R8UiAzc=;
        b=teXmew1qIfAkQFJEDckQVBNZAcR4DdhQLpuMFVhccKSAzVm2LcqDJi8Igqfa+6ic8+
         7XyuPqtgCwxhKZEUmNCFgx2I/ht/G78UuxYHERYvOAXnvYgW5BXO9xxwMLJxRH2P+TMB
         P2ARTG7OKDB6mcG9LmOtEg3fhVyGB2NTWE0WG7jBYWMhdI8xXO4ChWC1I5o9nA+ep2i8
         nd8liU1VWCfQiC6Qncb9ZQpxHVAeM32Men+CfWZkS/lDCS9jQJGByMcxni3L4hAhhUdR
         Wln7fuufj/68lEdGmoqlwEDhP+XjNaM3eM3J77ik/WmaS8JmGxntIgXziHeD7hYLgk6z
         PsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028292; x=1715633092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIYUSfxnqcB3NTYw8qzJ1HpCK1phCS/ngs47R8UiAzc=;
        b=HbNisnqXkfmfct+MaiIkUYWJf5tF+pPAeaPPEcFpTxZJVsP3PPIggW7yN7VFS535pM
         iU3+1AFs84172+wdIYNHou2lcv9FYvfDM74rECw1+1OWYsSutJUiEZL5a8RpdFzOKC0Z
         7aXuAqlqog4LTHdZNO/qrlC0287/4nZCWkBPwbIcjnYSQtxRho3nyH7QQzXCi/UEozQg
         an46NLPD09eIbIMekLDymqvAHz66S6YXc7w5T5cJJn73rHmn/KG6mjRdH7bdSD1pOAgz
         l1BheFVotxUiT0P67jGCoXEKpf7pNG7tsTfgcOQCW1fy2HGaP+FoywcGHIJ550RFPjem
         AcBA==
X-Gm-Message-State: AOJu0Yy6z6i6qUMuuQoTsTSTexk+x2R2fzTq0NiFG7l+nq32UcCrpYwB
	z2tF383T4Pb6L1/fgBz/07HBGqj8+q6SWDJao7x2SwUimFHkNo6G67hxSeEH6+TsBsVN5Dwekdt
	NN7U=
X-Google-Smtp-Source: AGHT+IFVFOEtJO2XNIkh3KoPgxs0M2fWuU3w0X6ZRVfGEfzAl3unDEuSxQrfX3CpZKeOd8U/OpLI4g==
X-Received: by 2002:a05:6870:c10e:b0:23f:5a92:c810 with SMTP id f14-20020a056870c10e00b0023f5a92c810mr6621216oad.12.1715028291503;
        Mon, 06 May 2024 13:44:51 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pu7-20020a0568709e8700b0023b50a85913sm2104196oab.38.2024.05.06.13.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:44:51 -0700 (PDT)
Message-ID: <5c3e14f8-af04-4e52-9521-8a49a21dcd71@baylibre.com>
Date: Mon, 6 May 2024 15:44:50 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: spi-axi-spi-engine: switch to use modern name" has
 been added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 yangyingliang@huawei.com
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193010.271790-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506193010.271790-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:30 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: spi-axi-spi-engine: switch to use modern name
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-spi-axi-spi-engine-switch-to-use-modern-name.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 


Does not meet the criteria for stable.



