Return-Path: <stable+bounces-43151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC26F8BD675
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66430282B10
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C51F15B556;
	Mon,  6 May 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fWKjFUAl"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7256B76
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028351; cv=none; b=RNNBeHGN/4TFD3/6hgN0KaUeMoVXc0bxMQBSteg8AhLOspQT72o1cymva9wDz4LepAXz3LFGWrxcB/M2cWxSBdwXwr/IDOLM7w3LVAcblPDJj6AX6CacOqvu2n1UlHjTSAK7rTfgtuSKnA7DsjbJotL7776fK9aOCb5yXo2Uez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028351; c=relaxed/simple;
	bh=ClI8/69zY2HpXJQCXsg32ylhnxXeZCshi87ibZGaLTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSo5Ezg/9eAQLNXL6lmvEeHFIlfFoIpKaCDQ4I5e6XFSLVmoXkIwP01v6iXNUjMnOVlD9H9GszjUCRAyI/zPXP/K8qHShMVtlNnexKEDR7G1yjQUJUwQs83XjPGoFO6wb7SJwn8A3dmhD1UhyE7vg9CkyROrz/VARZa2x8g5VBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fWKjFUAl; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b20b2f78ecso574652eaf.0
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028349; x=1715633149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1EhXo87Dy3xw+PW3ruh1UoFZrb/7Aedd+x6TWPZ+Gfo=;
        b=fWKjFUAlqt6Hgk//ZHAjbqt1yd2s+S2Hh+DcmoMoHGF0xhhnayl7ryeoumXvXSzunp
         FMhIvYpsdBNP1x2KHmxqrQpA99vM0bgdEeWETxtqqU6AhcZCad1JlhwKKKQGgch7y0CP
         vArFBQk+6qPhHBDEdre83/9jZwJIcFk2qHt4cCYZprTwyu9t9bfgpuCeioHSDlve1jyP
         EykqlTihm5hf6NGHokzl8s25TnqKSpIpVZlqibDwHIJc4wv1iUNG306Qml29gZqxrPm+
         N1tUmKKVrNk65uFHB6XEtj2hi+W4eFf3ih6KcOAKJnA1cAmrtsbXfK88auE6VYcfBzV3
         tImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028349; x=1715633149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EhXo87Dy3xw+PW3ruh1UoFZrb/7Aedd+x6TWPZ+Gfo=;
        b=EFwiU4z25qu3lqx/kPcgghYUF05TWph490EgybkxJXR1Fkqy/q/AKummSUmtqc+s27
         uLW7heeSkLBw3BRMxFZTAx9lIBUh77MAZz1ZZ24zNP0dtV5scMB8HSlxqOnfqy/ffQ/s
         XTp/Y2NM3qpWpO17ix5Q57dVWgTPT/8gCbDhvTQ2+7u+/+4RBAmyKYORI7CHwzcOnyp1
         0IwQX+ksOdWlKK+QbeEdRZD4bAbn5dXwwrV8SOvxIs7KbidMv/clos+Rxdh+N8CeMetj
         Itm5ygh32ZPpbKsaaWHfraZtQwWa3zW1Q5T4m6LlgDADXga9lc9iz9uJaIgOJcGyefMc
         +KhA==
X-Gm-Message-State: AOJu0Yy8dY3oBPiWH1ZvyyCmJwVu8xk71SFj1gQF6y49FbbpKERc/K7P
	K4TxUiHgc0jBPnAVsAayJtx9El2bg/OaYI8/ZmomzDm/cFbE+Mf+5YxHKxO1tRqL301W7IZAwmz
	i2M0=
X-Google-Smtp-Source: AGHT+IGg08/X3p5Xe2ejSUcdzNYKY3DdCdc0rzxRWst0aQ2JOlTl4YnkAkIeU5Ry0addE0Pet2CANw==
X-Received: by 2002:a05:6870:b14e:b0:22e:fd03:58c5 with SMTP id a14-20020a056870b14e00b0022efd0358c5mr305438oal.24.1715028348951;
        Mon, 06 May 2024 13:45:48 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pl11-20020a056871d28b00b0023c6ce5d25bsm2088237oac.17.2024.05.06.13.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:45:48 -0700 (PDT)
Message-ID: <64bd3b28-fb6f-4cde-8b32-a54de4937e46@baylibre.com>
Date: Mon, 6 May 2024 15:45:47 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: use devm_spi_alloc_host()" has been
 added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193017.271916-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506193017.271916-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:30 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: use devm_spi_alloc_host()
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-use-devm_spi_alloc_host.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable.



