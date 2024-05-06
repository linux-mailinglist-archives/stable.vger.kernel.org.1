Return-Path: <stable+bounces-43146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6458BD66D
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DB0B20BEC
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9A1581EC;
	Mon,  6 May 2024 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gT3h224c"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821E56B76
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028188; cv=none; b=OBP4d+43rtHUeYsbHNzpQxuq0hRY2+2ArFxRDdYxz1VDKmW6/RFWu2d8cpeCv1XtIXEuAGxExoAyn8j7nYZCrKJqSncQOLPVHP5Ar7n7Kk+1SAAG1B1urYsofLImWeg8+xqq3jpPbxPrt23WQ8AQ1u+6XJVgHykYWvrN6Lkk+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028188; c=relaxed/simple;
	bh=JFvd8IqlDL6uNAKunqKiE/+ndUMhdj4UQQ/QMLxtECU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1Xkm6Y+/h9ilPiki2NPz0dZpBMsd8EpzGIiL1BU7YKGJxd/g4465kFO+hINwtALWLenLIXXrMc4zO5eGRX/bnCV31fQpui5c4/ugcHH5e8ism673UH3zJM1Q/6BsUlo/Yd32yQc1zp80I1BbfGvQlxrfTcF3nvQ2k6SCyIQbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gT3h224c; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23f5a31d948so1143531fac.0
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028186; x=1715632986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+gNwDKR5F5MoxynCywDGRrRMWEWOuNNk+ioPwxLUTI=;
        b=gT3h224cQGPP/JEM0cKq2dEBV2mvYry19SffaK6bo+nVT7f0bcq7gQ2Ji0AVHOYGIK
         vpp9DwWbt33BVnFcnrzxHqTxWt+Zj+5Sg3v2LdTDeo5zzGIE6Hl4FYsTJk2spYzZV26v
         xym7exAbr8oSDgVgE8gYozFMrfoRgSsWHt9k0zcq8nr/4/JuapoMOcXgr8/SKdvKxFYW
         PuUavQ8OPUznumgDKWTEnS0q8ulLIob+A2mU3pYwJdLg+aBTnAv/1UyWDlrSw20urqiD
         k0efRheJfIcE4kqD1ornG/KQ8gUfrLodsfL98WypFFTX66a/c3F4CsPTTqmn3x2MLWmU
         as5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028186; x=1715632986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+gNwDKR5F5MoxynCywDGRrRMWEWOuNNk+ioPwxLUTI=;
        b=dew1ja7PaQWpzMGRPT2I9zdd5APdMf/Z8ehVLgmd0/pzCGbiM4WexX/RIJolhlqeWb
         6TEV1rTcznUYs7fbD72+yvBfxtTNrjwbM7XZ2bN2YZE8kYQNSCpbR7lZvUR4H/RAv6ST
         pOGO/Gg8I9CBI8WzVh/tenN+1N11PHT//RGG+Fc65l58tVYS8H6DGB4PTvvj6U1F48IW
         mmdKRa0jOD3l2amLT/raSX/LGb+vSlZwRUx/1ygDQKr3EridE0lsButnO57gHrbI10pu
         oTPEJhd7f6D/5suXuu9Hj7a1gtqXZiz+QZ6ScE8wDGf9TbYGme70aJSEbz6yBAhlUBvt
         n4IQ==
X-Gm-Message-State: AOJu0Yxe5CPQV0koaFvPfHQDaTc0AZ7NnzZQtNYesiLhZqJSeqNarXCl
	DRgH/7Ml+z7SylI8n+y6E5nLDNO/yQCa6MyHQp96+L/lKfUZQww5fysE5UrVISJkhL+J1tvrpnv
	biYw=
X-Google-Smtp-Source: AGHT+IGweo6qi1KlzS0M5PIlw4ZkfrbQBFM8V1oUfTsqfG9PvdzG8jyliND3gNZnJmBRoVuXrWxvDA==
X-Received: by 2002:a05:6871:33a9:b0:23c:b686:f5a with SMTP id ng41-20020a05687133a900b0023cb6860f5amr13390687oac.49.1715028186266;
        Mon, 06 May 2024 13:43:06 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id db4-20020a0568306b0400b006edbba9a66dsm2134788otb.35.2024.05.06.13.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:43:05 -0700 (PDT)
Message-ID: <59eeebb8-340d-41db-9d96-2072f12e4a6f@baylibre.com>
Date: Mon, 6 May 2024 15:43:05 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: fix version format string" has been
 added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506192730.269411-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506192730.269411-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:27 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: fix version format string
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-fix-version-format-string.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable. 

(only fixes theoretical problem)



