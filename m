Return-Path: <stable+bounces-59236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A896930777
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 23:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA64282471
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 21:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDBE143C52;
	Sat, 13 Jul 2024 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUvXxTW9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A63715E
	for <stable@vger.kernel.org>; Sat, 13 Jul 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720906405; cv=none; b=fSsjKXB7hPTzcTcX5ShAy6e9kHSjy4Ntxd+56aoVnNbXN8fqq29HoBFze9+qI/qjqgrWikaZQBvTPA5QYQPH6oyR2nKLnILg8xUZ6/lXRNVSo+8xTMAEvEukYlBNcUAoapdxqI9aumNITOUAQR/3meaJEZktBUKrgxfrbrNlUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720906405; c=relaxed/simple;
	bh=Vusn7UHaxQAQY0YUueIvI+g7Z5kxxJyekM1rkM9hdNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYWLAidM+Qo+JbB+YHQUhtmZe16P/glF8U9QLuG2VLogb5Tvl89O1Z0MYKnPzlHRlDWpzRr7TlHa+ouuqMMlooQitpMHrlIIlq23ufDn+kOcun2FzyFdLiTIDdCGLZXd2ObuVQqgKgVi2hHbD0mY/wJreuGFm8XJxZeh/LVf18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EUvXxTW9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so24155685e9.2
        for <stable@vger.kernel.org>; Sat, 13 Jul 2024 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720906402; x=1721511202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fz17i36I7m4owU1mibp18squ47YXW4OEhL9zh6yelVo=;
        b=EUvXxTW9KpP8y+7m6/3DX8197x0NccRltx804zAXmdOX4eAhB9Y+PRUZ9/fll3lP9u
         b05fKLWv/8633snbdjDlLWpPo8pT/TIkhIPI1vg9j5/acESxoNOoNId9lVLpGDe238Vb
         85qPXDK+zIfIf3mjyUiZomDuRDCJDqPGKP8UqiEjvAFFwV5XgYkwrcUfGmygWgLeeAkk
         Mzqz6k6MvNgo5dyMB7HaphzmiISxiVBq8IPHyQ5vp2chY031csNN/qvsbCR55L5JqawD
         Dg32kQWFP7hTZ62Nw4N7/dQYFhik+opiqYmmKQeF1CJJFgpuxx54ndTVxLeeKZxv14Go
         IfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720906402; x=1721511202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz17i36I7m4owU1mibp18squ47YXW4OEhL9zh6yelVo=;
        b=gVcQX/bS1gHiCs7dZEQnC7bowpeRkd523dsjPmdrwcLjgqJeP0PkbGFs1w2R7UFceh
         UrhWq1mH8wxhGlm2AUTEikv6L0Nn/iYE/I0JxKiITOjzKUi7vh17irC0j6DKSjB3SOOL
         CGRiNbkllGL4HZa5mX47I1mVy1n4Z6PzBijefU1T++RYN57e5AGNJkKpEbQuEGWhrwPL
         exauHXz2yyEJqWs6U2vnswSY1lCthlwBFcj6p9rpfSESRAW9kgLXkkTI9z9eGXeYhDPj
         IUa9aMHE8FlUgN9WwlDeBbPuD5LQkL2lkwo23koDj6a0s5YyYNNDqqoSprLtpZnAVkT7
         UK0w==
X-Forwarded-Encrypted: i=1; AJvYcCV+3sN5aFd2HdnAXakiWW4nVSlXGeU/ibHfHp72AsjzAb6QJFGwmVcys/gvfUkBtO4rji1Btunkna8Vqgyj6bA7kz0+zU0E
X-Gm-Message-State: AOJu0YzJZ0WkPwJjWh+UeR65svIlCgUpbRMZKdHWQHHwl9L/O9iCRpNG
	rOFAqqAlN1iDgCLLFkStY8nKSAlPjmUMj+CLul2LT91wToo4A2gmzXpvG9WlQ4Y=
X-Google-Smtp-Source: AGHT+IEOMoQqlOgQawmmZYK4yrBI/QNZDqNkHtUSrKh8egh9PPW62H7nwbsv6sDw71RaCOLs7/mUDw==
X-Received: by 2002:a7b:c052:0:b0:426:5c81:2538 with SMTP id 5b1f17b1804b1-426707cf827mr113176125e9.14.1720906402024;
        Sat, 13 Jul 2024 14:33:22 -0700 (PDT)
Received: from [192.168.0.22] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f27846bsm68001995e9.25.2024.07.13.14.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 14:33:21 -0700 (PDT)
Message-ID: <d0c0c4f2-1959-4afd-922f-2afe652544a6@linaro.org>
Date: Sat, 13 Jul 2024 22:33:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: ov5675: Fix power on/off delay timings
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jacopo Mondi <jacopo@jmondi.org>, Johan Hovold <johan@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240711-linux-next-ov5675-v2-1-d0ea6ac2e6e9@linaro.org>
 <CAPY8ntBvJFDtUKxQkzmnitCH5+uAijswwHmyvc0O=SKGpUSbjg@mail.gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAPY8ntBvJFDtUKxQkzmnitCH5+uAijswwHmyvc0O=SKGpUSbjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2024 19:05, Dave Stevenson wrote:
> I think you've got the decimal point in the wrong place for power off.
> 
> The comment you've removed in the power off path says
> /* 512 xvclk cycles after the last SCCB transation or MIPI frame end */
> 
> 512 clocks at 6MHz I make 85.3usecs.
> 
> I'm happy to be corrected if I've blundered on my maths though.

Nope, I meant and wrote 85.3 and the "corrected" it to the wrong value.

Good job bod - thanks, I'll fix.

---
bod

