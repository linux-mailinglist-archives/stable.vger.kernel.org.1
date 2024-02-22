Return-Path: <stable+bounces-23360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 212B385FDEF
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73C5285532
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61541509A1;
	Thu, 22 Feb 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b="s2tbDZaV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4715098B
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619049; cv=none; b=N5YnpLBGLZ/kMu9Uk8PCBZ2947Gws5UoiPHVN7Wj8TGwiT969rXNaGsU26fB7KjB8VF53fSsvGSkDXEWVkIYqzL9i2WppKwsGFUT9x49wH3LiU+8PJkbiKDk4XxmqzMpLATvzS0LjVssW4ocLvarZTrfdZ5TgzTNh88OQ9LGewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619049; c=relaxed/simple;
	bh=G8m3KQkWjv7BRhPW611QZ34S3V2Gg7ugNi4X4Ek4k6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeQKZ1avBhBu8R/g3jDDzHQilzG028oPc8qSfo4qlFwkixCW0oFz0yIxZLNLC97I5txWbE/xe13/T9YqeK8bcTRnLHop7fRAMIGxrxWMPi8ljwqgATIY/jOOLgDrDc8Eijdz5Ml007qyV/M2GnUm3WoFYaz/P46HRCcNyLdWXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com; spf=pass smtp.mailfrom=gigaio.com; dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b=s2tbDZaV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigaio.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a34c5ca2537so268348466b.0
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20230601.gappssmtp.com; s=20230601; t=1708619046; x=1709223846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8m3KQkWjv7BRhPW611QZ34S3V2Gg7ugNi4X4Ek4k6A=;
        b=s2tbDZaVnn32tt+5zJlqIVPpmpZJfWulHh0pVWKls/qtSMwTb2VlT6CjqQaHhe7IJZ
         k8pkY9+Fhh9hIXDL1m6xhWG4BzFOtUA+hKIDw/9lGrxpx9LyRycz/8fkd9wdCJlVHqvC
         2Tr5c4u0Kaoh+n106OewFMFOuAPexcoXuUQcrvEiWXl6uAoLY3pGPA9Vsf6U/DW/eoQA
         CSkjeQtFpPPxFLhYiTA61VTUzxV05hrHrH8UFZjYKVv8dRhZBGJ12BVeVfkb0GvWm6Ex
         xYll4ydyfum9lEDipbTivfQcrvNU+X9rPJg53/jJkXyPf4XVOPrx7UGp/Uj5MOyD+wzu
         XRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619046; x=1709223846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8m3KQkWjv7BRhPW611QZ34S3V2Gg7ugNi4X4Ek4k6A=;
        b=kPCldpqJ7ozeAOPXd7UzbySyEgGKT811cajXocIfzwQvHTCj3UdwkIzfolsLR2u7yx
         ynB3V5315OTGl51lVWyXYaZbBTcomAvPgY0qxIZWjK9mD/cppUbKOoZL4xUcY0MDPsC/
         p4kEGArGGaTaF55eTMoRJnZz1NVtKPYwYO+OnAkjUiRgrPSMAyAMfBSvALkPIVgXXXtX
         RTL8Afb/HeWfDPE2kSNXQUS1ts7BKar3on6jUcdH0YkokRGSUcotDhJ7yolW+ADgtRSF
         NuoZ4W8FtdyDCU30uDzaTiItSqFfe0UC1nAyTpDUtxEj0RTEAJ3LFVyh3Q8iQ1ecg4k6
         7KTA==
X-Forwarded-Encrypted: i=1; AJvYcCVe11s0T9rSM6wLEqKs36h/FQy5VdEzzkffebf9rdh+2ZfUk/wvCgIPsfQQlVVK+Ct5juVIFOJBwhxEz0f54MFrH6o9wdEf
X-Gm-Message-State: AOJu0YzNLOCCLHLCLve599CDlul3fsUIyDbKyeZVsaaHZeFrZA2/8dbE
	by7MG0w67DjqNb5cM3jcwzmuoLmQ4XrsSXbUIVmx6k8zrjfBS6oLmzsdAV5apjxJfzo8Oq7D7zv
	ay0A=
X-Google-Smtp-Source: AGHT+IGzEZi9bsQsyZndEsMep6CrsR+JbJq6VZETkVdaA+y5zYTtO9TwqJ2vjCoLuBPqEDSV/0NOhg==
X-Received: by 2002:a17:906:2c0d:b0:a3f:9f38:ded with SMTP id e13-20020a1709062c0d00b00a3f9f380dedmr953165ejh.69.1708619045894;
        Thu, 22 Feb 2024 08:24:05 -0800 (PST)
Received: from [192.168.1.104] ([46.151.20.23])
        by smtp.gmail.com with ESMTPSA id lu16-20020a170906fad000b00a3d5efc65e0sm4763133ejb.91.2024.02.22.08.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:24:05 -0800 (PST)
Message-ID: <c1467910-760e-4a96-befa-9645aea70b95@gigaio.com>
Date: Thu, 22 Feb 2024 17:24:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ptdma: use consistent DMA masks
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, Tadeusz Struk <tstruk@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Sanjay R Mehta
 <sanju.mehta@amd.com>, Eric Pilmore <epilmore@gigaio.com>,
 dmaengine@vger.kernel.org, stable@vger.kernel.org
References: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
 <20240219201039.40379-1-tstruk@gigaio.com> <ZddShyFNaozKwB66@matsya>
From: Tadeusz Struk <tstruk@gigaio.com>
In-Reply-To: <ZddShyFNaozKwB66@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 14:56, Vinod Koul wrote:
>> Signed-off-by: Tadeusz Struk<tstruk@gigaio.com>
> I cant pick this, it was sent by email which this patch was not
> signed-off by, please either resend from same id as sob or sign with
> both

I will resend with a proper "From" line now.
Thanks,
Tadeusz

