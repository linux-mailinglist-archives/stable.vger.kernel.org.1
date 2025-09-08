Return-Path: <stable+bounces-178912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97BB48FA7
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 15:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC46E3C60BF
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBBB30AD1B;
	Mon,  8 Sep 2025 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLo08wZi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531812EFD86;
	Mon,  8 Sep 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338313; cv=none; b=hOKGwBf5jO9X52tewyX7NAY2rK3ZCG7Ubat/zLhsCJR2v1D65abij2ORYdorunHEtwAvDhxOYkpvNKhkmjtn11VoWLan8MDt0CkL7cYWVMTaMNzaGBqXV3OWiTjfDQr/D7817YMZ0y/7jUl4C20lHxQT+AuRbmbp9i3WxnZE0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338313; c=relaxed/simple;
	bh=XFpcrUgCAAnn+5N6WDRSRAoI/KMeWCd6gX4KF7ThquQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nsl/ZuvLiAPXZbyRRe10ZDYii+HOzZBfK+AsDE3eGdwMujIQs7lRCf8lTtlxR4hC13JJciF0VSFvFQyYwkpnTSS7FC/DbjVvr2g/77+m1KLU5kxSBezdCw7KvD3VCndkHTAZrfhdkVcPnUiyDCAZhWBdlF/H9lqpMhX2Vy3wtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLo08wZi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77264a94031so3045918b3a.2;
        Mon, 08 Sep 2025 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757338311; x=1757943111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0VRxysBWR4+1ubG2BRwz4IYmQyW3YuwNfLayCI3GgPU=;
        b=kLo08wZiCUIbYPuAtcNNIJqOGugUVy4xa/hWO1L7nzf3RZDDVf0YVtvuN3yFGIt3Vp
         leNuWHgsBwHlz/uaRXrWWxyICd5Y6W0uSzjk+RiIhQ2idVSKIC59S8KFGuZPVk+TsJyw
         5qNdarYlo4xlzjgSUnOYRXbLeGXWE2lXfcO0HRjJhPEoikCBv5D3+ivLMyA17glqQ6gr
         IuU6gxGRVQImXB8X5fiNxNQmfuxhcUCAi3jwctf1cCkt47jEky9y6J85ZPSqdZxEYrYM
         Nv8Zg4q8V635SZFKPB8rtvq4gQsfGsmMAPQXiq/sQOGlD0HLZn3pBjc3+oKUiQompWsm
         v3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757338311; x=1757943111;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VRxysBWR4+1ubG2BRwz4IYmQyW3YuwNfLayCI3GgPU=;
        b=QV9cbzz3ZZ9maqLs3DNH9aTuOWL73GvW93AHj2k36Yo0AgIo+dCPPhwZkbcf0xHQb7
         b2N4fuCkNHyLM/rIpwAq64I32dUVWKx0vEnASO49fuAPy9vU55Qw4FXDQYZVN8eMJ7Et
         JVKGuO+jV+OL8bTf/0h49+huNQPkKnk9gZcDmtRagEDjSQ1cLmdK3tQcjUkqvAsthEmH
         vJaq2UtHvbmQ2YHUJSew7MvGq1r2GQTHkM0te/CGPXDF2FaY0aqWg+t4zgrd91B6ivFU
         IxYVmhFJNJZNBe+4ExfxFl8snobFtUiO77+T7YHWY0tMLDbH6kMBcse9XjpLNA1RBH+n
         AbpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Q5HGxDywspGjXpX5DE4kkdliPPWULabrXrNWpunvsUJVugN89Wjf0oyAD6e5AV5V4gySPcNKx6Y7@vger.kernel.org, AJvYcCUALjlkMO0edfH/gWXkrml+hJn9L/9P/MehHRQO6cL91+DT5K2llL1/q7y735t1x9XyG3OrbNSj@vger.kernel.org, AJvYcCUVsvHrosBVmK4SOTRIJ+yJ7nRs8TwOjivlu58yjTHgBfLBuS6+RMYLCw41WqfPf9uegKEk4hKnANqOV64d@vger.kernel.org, AJvYcCUs1zExYpAYcwl4pMIRxmB2sujIQRn61EIwn8eA5PnJ1zaW22HsFWDmRdQ+2t02EGOXL4LTbuzQK3jv@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFx03mf4XlHQGYEWJSqmBx5KdLqXTsPNSMzxBsV2/tBM61OA5
	mXd9g5H7B/8aJpD8iw6nnPDjq+33WhwaCcwJIuZA6u7bh3r4jsefEMNq
X-Gm-Gg: ASbGncusenCT5sKQvZ8bkuAEbxf+7VV8pJVdt3xd0O/H56zYsGO3iELCR5FONxw/d+5
	ADSnpXQ3njKKrP/m8bWi5a9TVzqskAvFANCpRwZOyeYC/BrTiBPhqLLerC7RSv3F93IvKlaXwvh
	DtAdj/bslC4L0K+REHFCmIYeIFRWqX/UFD6kQChXAogUIdniIhiiDjqJC16n4dADAzyKzl/Kkya
	YVw3xkO9fRecbG+N7NKzeZZvNIdf+gI96wi0Kq6B5yL0Tz+0L8fy7Wl6+0fynUCow55zHTfEPfX
	dIzlDhn5YETz3plQFiIJHec+0OBbM8DAWRgObaqX9rhRmQPhKc0O/0UZtLAzY3oybVstQx97QlQ
	rAEPKjpP4vAH7xwQhiFLgCn8PT9dg8QBC7eXZBZwjIOPDaah9FlAfsKJsd8VZTgETMMt703Y=
X-Google-Smtp-Source: AGHT+IFHxpOI9zw8ViQQBt2bv0fmbzjwjCKonJOpVHHtbawBcf7zvtU8dcDIKtWbgtSTokjP6MN1Ag==
X-Received: by 2002:a17:902:ecc6:b0:251:259a:23eb with SMTP id d9443c01a7336-2516da05ddemr114592935ad.20.1757338311400;
        Mon, 08 Sep 2025 06:31:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced597370sm97949445ad.128.2025.09.08.06.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:31:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c596e196-7e5f-4600-ada1-7c96af8c0a38@roeck-us.net>
Date: Mon, 8 Sep 2025 06:31:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hwmon: (sht21) Add support for SHT20, SHT25 chips
To: Kurt Borja <kuurtb@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 stable@vger.kernel.org
References: <20250907-sht2x-v3-0-bf846bd1534b@gmail.com>
 <20250907-sht2x-v3-2-bf846bd1534b@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250907-sht2x-v3-2-bf846bd1534b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 18:33, Kurt Borja wrote:
> All sht2x chips share the same communication protocol so add support for
> them.
> 
> Cc: stable@vger.kernel.org

FWIW, I am going to drop this when applying. I don't add stable tags
for patches which are not bug fixes. Anyone who wants such patches
backported can request that separately after the patch is upstream.

Guenter


