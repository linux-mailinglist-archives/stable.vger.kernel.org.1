Return-Path: <stable+bounces-43182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6298BE4FE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 15:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B171F21968
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE0915B10A;
	Tue,  7 May 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jOBlwp3I"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8515ECE5
	for <stable@vger.kernel.org>; Tue,  7 May 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090360; cv=none; b=TGOBHT1FEY5DuVkCSh7YXB1kiPwwopmm9ABkb4O6b1dP+Sg4VYDhO061yVqGbqFfEfuyLJ7lVGsmsK8yXi9XBxERBw8w3Uhdw1D2tz8YfgB2i9saEoMRTVog7Qyo+yqp401UQBTny+0fRIHQLBd7BHF2HtTRpfLYSOFEu2L7X7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090360; c=relaxed/simple;
	bh=nxWRMnUowF+32cnWIZ79Q8aFGNIlpnZjt/CFe992tYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsNHdhfQEOURQWWLxj4XON6eC7CAK6rPZ27Ak1D9OvyJ6RSLP5kq8WrrKLvNwdiQqYWEFyVVtjFuNObcaQKDJe/goNx4FnhPEXGsQaDrr6vyDGg4XZ/r2S1N7ZrZVwHn+o0h9h+RsgyL38JmmOp9gw6LfoTx95lZgjyQc204g74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jOBlwp3I; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f0812c4500so870976a34.0
        for <stable@vger.kernel.org>; Tue, 07 May 2024 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715090358; x=1715695158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c25swySNhf2FRMVIkxDuLSvdvkppv5nM1EGqt7Jyrtk=;
        b=jOBlwp3I464Xj5pB6veNz1hXWoI3rAfa0VIU72aJ+YeMkRiVMqmi21efsOfuv+fugy
         yGgsUVMiXh0mW2qecsV20Zc+940lmg435SFB/fp6vIGIKiqKPOVki3L5Em+wu4Y7s+Zt
         OpDEv778XIc9vVDRPIo4MSr1SgXkifRrNzKDmFOFPALSis9VxWwU8nwJfzCipf5DUfKl
         vo4+RyvJO4aIfsilXvgS2ceMcuup/p3hj0z0DivMDA07LwpmISKfV1SIaSzWdUH2sD6z
         YbOe0E1r2VhAd8EubqMJ0ujbijCYbSSXiGI5CSFM/MCtHvyA+GAjuGtW+FXDCTQhcUY5
         c4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715090358; x=1715695158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c25swySNhf2FRMVIkxDuLSvdvkppv5nM1EGqt7Jyrtk=;
        b=lmq8U5wrkxfAAF4j8pEEVLN4Mh7Qf9bya9rzF2vH1c47Fmg9DQh6oX9bvIMEbVBvSk
         zJ4hBLW0eHyY23oqUW+3BnzqHbyceCd4mbpyECzy3BcK2OHOR6MMhwjmZWVVl23VZw4v
         TS8M0Ym2J+saKSpN/cureuN4QEwPBu5pO47jmk6CNUBMvD+hPOJYZ8FuJGAPn/OhPcNr
         al61NNF/sjoae6VKLOGrIgfFE/t/RCFqXFPwyhKuKCT/xskHZTdM/0KPR9nxI9mspckR
         50fwEuUaM1ywltYlJj+sZ+68HWpERhlAFChpd77Kn9469VXR8xHhDCYOKUuz+7GqPDZc
         mjug==
X-Gm-Message-State: AOJu0YyuQc5GyKT8xWyjIqhykhzmBG1jCfR2XH66ir0A1Uc18PdMDvjH
	0fNNYnpQNlxIUE8dU6URFJEHpkvRE9Cq02/NE4blOwXMpMv59Fq8w8rwFXZeWFE=
X-Google-Smtp-Source: AGHT+IFTh2z3ptPXGqDvAA3dc5rnWsIaw2igyJvzy+5ds7XJoRPVB7M6l0L8jJRMbvc/0L6dALGRrQ==
X-Received: by 2002:a05:6830:124f:b0:6f0:4201:973a with SMTP id s15-20020a056830124f00b006f04201973amr6809492otp.13.1715090357783;
        Tue, 07 May 2024 06:59:17 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id cy14-20020a056830698e00b006eb7b0ee326sm2473492otb.65.2024.05.07.06.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 06:59:17 -0700 (PDT)
Message-ID: <0ba14e0f-6808-45ae-a6cd-9b9610d119db@baylibre.com>
Date: Tue, 7 May 2024 08:59:16 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: Convert to platform remove callback
 returning void" has been added to the 6.1-stable tree
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193007.271745-1-sashal@kernel.org>
 <668fcb3c-d00c-4082-b55d-c8584f1b3f7a@baylibre.com>
 <xoadzhyfsjcmvrolb7smsjsvvhfb67m6rcata7sox54yeqm54n@neow3nvsxcti>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <xoadzhyfsjcmvrolb7smsjsvvhfb67m6rcata7sox54yeqm54n@neow3nvsxcti>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/24 1:13 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, May 06, 2024 at 03:43:47PM -0500, David Lechner wrote:
>> Does not meet the criteria for stable.
> 
> It was identified as a dependency of another patch. But I agree to
> David, it should be trivial to back this patch out. If you need help,
> please tell me.
> 

The "fix" patch isn't something that should be backported to stable
either, so we shouldn't need to do anything here other than drop
the whole series from the stable queue.


