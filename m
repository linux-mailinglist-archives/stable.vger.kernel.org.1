Return-Path: <stable+bounces-194582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5B2C5164A
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF62188B469
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402AC301000;
	Wed, 12 Nov 2025 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9oOxxT7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324A3002BD
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940264; cv=none; b=VQLkK5QwssZny+9U/oFw/oVxE7p1sRSLWWffoMXHxdxeQOKtpst83EZxi2b/wlH9D0hR7s/O01o09eHg6/ZKoBwMzClNoMvC2goZNknz1z7Ov9ayIcS2h9p+WYpqe7OiOerpYJlQxstq0lkcxJfAFec5kQwVgyqsoiC0BgTihas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940264; c=relaxed/simple;
	bh=kqDDnduyUUh9PtMAAC8Iw27n6POgWt5b/f0jd8ADwGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPRcfFYrujUYlZIXMIVsc1h6yy8vpm6fuTz5MflwxF9D/zAdX1it3pwyQS60bK1AAqXtJRhbQS/cC/cHAfNAvD0CNWhNLjz4hd29NkhzqwBnLEkLx/j1yGOqUvBDxU0cAcXFDRQEAC1k7AuOXCS2Nfmi6Mu6i1pxyPVMxfvpA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9oOxxT7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so400390f8f.3
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762940260; x=1763545060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kkR3PECBtgg2Ta+T3zNVyfwyQ39/v40ObIhIUJF1Ho=;
        b=J9oOxxT7Ju//2ES9jzGeCSntrAyadTvcBePrvjzmAaNYwI1jadsazyU9EwAvziBTdS
         lb3PeIrTXqmvym96RAlhkJCSZ+ZLcuTkD9p84Zu4pObAAZ7DfeWHfrlv2IoopdmTG9Dp
         z2PHpjDx4AU6E+AAEVb2W8WabuA2gKcECUq+kXCtLFleghfDlUZIA+OfCoHQDBt9k5yx
         lRmLeHAoS4PCM6MCOFYiKADhF+YC4n33Q980W0EsCMupAxm48cY9bsb11EvgiCGhM9vV
         /Z9Ha6x8EJm5+aKwlK9hHFg9Jy7oxmHBYkrXjnq4kvJ5rS4U3c18pDEbfzgDDNrnaUdj
         3ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940260; x=1763545060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kkR3PECBtgg2Ta+T3zNVyfwyQ39/v40ObIhIUJF1Ho=;
        b=D3pRYm/bpt3aVQnyrpRs/Z2oJptrLrLzeC70O/Wm2cMBXvWcJuL2ovgr+BMvGqdUQ3
         Lb4L9qR4Zr3wBuZhQpm+Vbj437kmRhhNXte8GAw3cy2KAHOwV7V1oyq2ympna326/3TJ
         UKFyn6CYAWSrpUKcgJoKqZ9FOXb4BYqOhw74ZNwXEKoBOFOvxcQi32ZM74nugHIV2Rx1
         8gigdYyArXNIoSUHRKdLDxgkgBykdQP0CKCibYVsuITvv/xAhvcDrk37l7zK3sgrmB9O
         RNX3rYS2wwNG5FK704y9tGMwcsJ98+ECbLwDchM+i9S2eaWaMmWrsCDgMe+q8nY7G4nQ
         nd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUVDbAbNfSQoCxixdrmngcQL5NVGm3Sk45sx1vN2B0boxgJZjJ8pb4rNpO6AXVr6C+Jp0D2ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VBhC4I/tSzHXCay5xR1wTWVx1/njiKfkCwH/bEg8HhBsrKAO
	Uw+dXpjD9Hp9Nf8JlzdFanU9lMKS3HgFdhgSxEVp/fJ8gogyN68u9qywtNHq6kE0/uo=
X-Gm-Gg: ASbGncvzO9wi9c9issbU/g5FslNBb6Z+opv2E7nB0pry8b6bB2hUdD7Gji8lksNJZYN
	RGz5V5gQE9/crAQI/pNFbFOQkkeXZMrFxhv3Zrgo0TEl82dP6leTRIQ9L/HZWpmxUWZ5yRiO6Xk
	xH0ORxgfzwqnSkXPUQvj8zj1wqFTVK9B61ZB728/4NnEURfpkkoC2nvTJIAajubSTi361LDyNE2
	dwA4qs5I6E+sO/+yjRM5coH1mISzKlpopdPaCVoYYwZFELa6qHko3564u94Qk8o9GwK8zaJ0oU6
	QenCNOB9yCoYCBSS2/rFIy8F47pYQwMJN5bbasTBxlvExxJB0aN9eki6kfpW3rpVsIoC/1OYUoc
	ex9J+gPo6t9GaUgg4vUoM0v23mtM/DD1ND0UfszFbAPZ1MLV6675ljQuO2EBRol+3WhE5Zol9MA
	2Soa1zQA==
X-Google-Smtp-Source: AGHT+IGZSi7yScfYmi/h+1qIucc+YYMtcUxa9jmazfcfm23PzWB2Va5yBYWI09vRuMxpAqpjCguVyw==
X-Received: by 2002:a05:6000:1847:b0:42b:3dfb:645f with SMTP id ffacd0b85a97d-42b4bdb7d81mr1738754f8f.47.1762940260515;
        Wed, 12 Nov 2025 01:37:40 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63ba87sm33821589f8f.14.2025.11.12.01.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:37:40 -0800 (PST)
Message-ID: <8a370764-e093-4987-9a5f-3a8c1d6d900c@linaro.org>
Date: Wed, 12 Nov 2025 11:37:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Hello,
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sean Anderson <sean.anderson@linux.dev>
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
 <c67466c0-c133-4fac-82d5-b412693f9d30@linaro.org>
 <87seej7fv6.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87seej7fv6.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/12/25 11:35 AM, Miquel Raynal wrote:
> On 10/11/2025 at 08:54:24 +02, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> Hi, Miquel,
>>
>> On 11/5/25 7:26 PM, Miquel Raynal wrote:
>>> Here is a series adding support for 6 Winbond SPI NOR chips. Describing
>>> these chips is needed otherwise the block protection feature is not
>>> available. Everything else looks fine otherwise.
>>
>> I'm glad to see this, you're an locking expert now :). Do you care to
>> extend the SPI NOR testing requirements [1] with steps on how to test the
>> locking? There's some testing proposed at [2], would you please check and
>> review it?
> 
> Good idea. Let me have a loot at what Sean proposed.

I proposed to him as well to update the testing requirements if he cares,
he said he'll take a look. Sync with him please.

Cheers,
ta

> 
>> [1] https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requirements
>> [2] https://lore.kernel.org/linux-mtd/92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev/
> 
> Thanks,
> Miquèl


