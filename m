Return-Path: <stable+bounces-43150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3372C8BD674
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFC41F20FED
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54DD15B556;
	Mon,  6 May 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gCMgh7qI"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE61591E0
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028334; cv=none; b=NF08VGrPxmLw3lzQ4b0ZfJDQ8wV8MOJW5T4K//Rq663w1Pef1W38Fjk47rMoUz7BKJJL+V1IYpTkQGidnPseUJx/C02Ege10W2p0G7QIV+F/EzuMipi3iAUWdZUrFZ7sNf7Ipvl2dz44v3PurmvxScwls96VvfHsgeLgDLSdXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028334; c=relaxed/simple;
	bh=Emtm6v1QqHW3jrUYECt+1vgyZukXnjqMluLJuwrGbuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9Chw44CUItSgWMbjsKtXUDT9M9kYloCvJAdt7KTxTCv/0Mz9gx+m2TEUp4fe08Xad/wkmGAbTH6AOK+TIxVSv/b7d/DzvM3fKr1I3dhjAjLiwYpcYHRehvq6mkJVNWc3KeJompC5seAjbBshUgJjvd7aer8D4twsOaW5Rjkbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gCMgh7qI; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b21def5773so437658eaf.0
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028331; x=1715633131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GvI65fz6PdvkqRbxEG9KIgR0no7B3heTJ21Y4zn9+U=;
        b=gCMgh7qIAswzlEpiDlrCKjhBBjH5CW8Klq0lnk4yI3PoEGl1C1YF/CO0dP82flE9/A
         xUTtOb84KaU3COMRWyvRR4Wfu5tIjCx7++tvH3voE9UOjzQe6d2Lb0IhFh7CRjsDms2y
         F7dbMc13F9i9GRyRugO/21rmcl4axky1kfUgWo5wb7vbbYlHRrob+NtNqpEAf5X9fMqM
         C2Di2HTCd8nq9P0nyn67tyU4eWFdw1PNMdxBAyp6BoZuFU6MDA0aG6uhd+7HSV1Mkjkr
         Xi3IEBZ6002bxOfkNCE8V3XNDLkLPAwkJXe4Kb9M2bbHtu0MUGUq4pS53XdEQB6hr53b
         oYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028331; x=1715633131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GvI65fz6PdvkqRbxEG9KIgR0no7B3heTJ21Y4zn9+U=;
        b=GqWdrgmvtKR4Np/uZ1u3Xhyce3TOibhC6Vaj4cbwq8XVZwyvGL2N9lQ6RXBS1do0d5
         bFUXsVANNspNZ0YlYz7vIgFkKvXILiNhCUSpevci5HLMoUnGimfFBYK8/0iw8YY3AUsx
         PaeFaJd8BOtGHPydcHM6PrmCbGAqc040eRvcdBnBOR4001Rarjqb8wLfJux9u44H0BF/
         j28/eoZlJFsbuFe6K119B6QSWc0VUzo+txEkaRatDG0XV7pxiq0pSyF8Jjl9xVhLQXdC
         twE9FKNXFeQGnsz8Tnks0aua80C0xBTo7cCagd74SpktQbD4MsOZ55DsM/HDiPg8kSQF
         E8yQ==
X-Gm-Message-State: AOJu0YwTUyuVK396JTFC4GX0Wg1azAVj2FDhyx976RI8yWhADJRSQ8q1
	Mu805Rk/iFUrWOXe52tFaG+bETtFjTrDNIrBv8oDNnp5rljoA0PRMPi8zlVkQmLC5Qd5wQwyj5D
	HiD4=
X-Google-Smtp-Source: AGHT+IEkLlEUJU9v+Vsg4LBY0ErfNEL23LFuCKprn1xi6lX1tzkITJHpKQgrIyuOVdB+4iNWI7mfIw==
X-Received: by 2002:a4a:a4d2:0:b0:5b1:d589:6d52 with SMTP id c18-20020a4aa4d2000000b005b1d5896d52mr11083808oom.1.1715028331449;
        Mon, 06 May 2024 13:45:31 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05682008c800b005afb5a216c5sm2094883oob.15.2024.05.06.13.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:45:31 -0700 (PDT)
Message-ID: <f2294ef5-fdde-4562-ae70-0fc57cbd84ec@baylibre.com>
Date: Mon, 6 May 2024 15:45:30 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: simplify driver data allocation" has
 been added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193015.271874-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506193015.271874-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:30 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: simplify driver data allocation
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-simplify-driver-data-allocation.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 


Does not meet the criteria for stable.



