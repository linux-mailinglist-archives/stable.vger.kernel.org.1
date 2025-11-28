Return-Path: <stable+bounces-197625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C46DDC92E26
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 19:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A06A4E18DF
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462FE2D5948;
	Fri, 28 Nov 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV1DrBJU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986D253B59
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764353392; cv=none; b=T21k7YUyzEIZLnt3kiFPu+k3rCvHGY5q8tVwOefVRKO3mwJU9/748AmS3udlGYFaNmQGFl3tnDd25GO2V/Cvb3xJGssa/cKLpdf2p7idYr3dT4AKvgnvrhAM3qfe71/PRPm7jwDiHflXiK4cWewVtWaMm5I9tl8vlxxEdRy8h6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764353392; c=relaxed/simple;
	bh=qSso203uNfBdcfdMfxOxPQdJPuQCQsRjIUvWlFzvw+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KORv/q/dEvWXX/UxIYkojhAMG2gGKNpuela4iiCdIwwbxqLH3mx4dLt3YIbk7vSnaebKNckj16sw6oSCxMIfGJc8iUVLj80NaSwuHC6Z5m3xLvDey2Wn6AN2pvCuT2HpLJy+jOxemloGrTT8sTrFMJjIyfyqZbyehba5IuVFO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV1DrBJU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so2474644b3a.3
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764353390; x=1764958190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uuufsf1wc8s/+4qxTfV5drQiKWWTHW29EK0nf2exhek=;
        b=CV1DrBJUmD/2o9RlIYtOfCk/OtbbWgYX754oWtoAjkaZ/yL/ITbsL0Yw8zHhY0cNFx
         V3AlHrrMI9dJDr29jfV/+01/atv1ZSP06kEUjviIUG6FoMgWKhDMe81NeeOIe6QzeTY+
         0ucX/D2TgbZW7gGiDvskf0jG/tyucQF30c+q6rcXWWITHXiMXWjzMQFdQjE1e0MXQ3jZ
         rInI//Wui/H8teNwsJazggano59TNcCIYDckJ65fo491TDDozt3YQ1/KvxC5T3NdIzl8
         EHj3IzpBBRMfJybfOW9RhsCD5fb1dlJ5SUVF0sM2JLSj+aVXeI8pf3EHVZ0nAKfjm4Cf
         vXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764353390; x=1764958190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuufsf1wc8s/+4qxTfV5drQiKWWTHW29EK0nf2exhek=;
        b=Cd4I9rsul+cn4AzbPxU2abd833NStS/oEUtiEJIn8DdWvcz2V1mh0zy/alI5qxliCo
         eA1qngEtFiiFvwzEWomOyirLmdNrrgwBmxrgn943OjbVrAb5Raqr08YXk1USAuVh/6VQ
         C2EExOWwuV3nu8XSvGeTxQ+foVZ1OaKV6KhYjHQ5JVoDR96acMWlKfFqeAa69jhOx+6f
         9SEIY77uk8FyrejJqvYBvTd+9ma9PjW7klAh9btkPbixtctpyCJ/XIjWEzNC+CMeJQC5
         9a07TNCwRBe2mzNoAusTzZ2jzePVixcZVkhWbYIlikBf7ms72zJPwnNGQGaIcK5vityE
         YQag==
X-Forwarded-Encrypted: i=1; AJvYcCXv/efFR7Bt/7XUc/aNanFMfiP0K5geU3KsBseqPcicd2BNaPdcFnry/p4PG0a2tJrd71lzlAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7pJjm/Z8brcQk6qSgB2/QnCB2vMEQ37PeAUaf7JmlVDjT0AP0
	tlq5lkIOme6txY1FwgepQR4ijXraACXefVmwDfRHlQdp/OBO1DUqK0CS
X-Gm-Gg: ASbGncsHIKRbfDP2W0PjBYgmlZ3hGgigETIQjOosLNiB4GEVz5B/F4Oyrm1FcsMYibZ
	obw7JkLanP+09nzwEa9B0tz5pqoSEK6Y1takRXa17VAl7jEbHwdwAjQcYA8Pk3V2a0JTDQDw/4p
	q3IJuU7POt/czLui71bxlMpyHK5QfknjgaIUUx5iyfl8sFPSz1jPgx5HyR+OY6b1g0RRQKPzooE
	epMcaLkci8z2kemEGtY0oaUKNnMENpNLK8I8I+UhEGyl+LtlSTmyZueNe7NPbtKU+HOgOxYAJkY
	S3nqz5LE7f5TZ6vaYYZs6GgDDDCsY94LSRsyYgbCscC97+rcAd4qtGr7D86/Ychp59lSIEmeNtn
	lSpa9Nmg31pqIVfzp1IdricXK1VKYc6ZIAd7LS+0kizoUtSk1o20mJECQvaxntxUwoqgS/yPIYM
	RoW1WEM6Dj5opcJsw7MlafxLuRyrMWqEF3b8BXDIoGhhlypk9Ls928rbrBKkgDMGKxIBs00A==
X-Google-Smtp-Source: AGHT+IFwEVgM2Y8VugYE8LnLCVwhlY38xOhyysV16vA7ayWTYcGkztcIeDItSTWHlE2B+kYDjVhYiQ==
X-Received: by 2002:a05:6a00:1ad1:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7c58c2b19e8mr29165494b3a.10.1764353389658;
        Fri, 28 Nov 2025 10:09:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150c618e7sm5707343b3a.3.2025.11.28.10.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 10:09:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d3b5379d-4900-492f-a5bc-49078468df06@roeck-us.net>
Date: Fri, 28 Nov 2025 10:09:47 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (max6620) Add locking to avoid TOCTOU
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251128124351.3778-1-hanguidong02@gmail.com>
 <f5a0e99d-306a-4367-8283-b5790a74dfcb@roeck-us.net>
 <CALbr=LbzgLK7Y-e3TTpusXGZEq4+DJJ=mbVMP=M3gt6XDGNUGA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CALbr=LbzgLK7Y-e3TTpusXGZEq4+DJJ=mbVMP=M3gt6XDGNUGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/28/25 09:59, Gui-Dong Han wrote:
> On Sat, Nov 29, 2025 at 12:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Nov 28, 2025 at 08:43:51PM +0800, Gui-Dong Han wrote:
>>> The function max6620_read checks shared data (tach and target) for zero
>>> before passing it to max6620_fan_tach_to_rpm, which uses it as a divisor.
>>> These accesses are currently lockless. If the data changes to zero
>>> between the check and the division, it causes a divide-by-zero error.
>>>
>>> Explicitly acquire the update lock around these checks and calculations
>>> to ensure the data remains stable, preventing Time-of-Check to
>>> Time-of-Use (TOCTOU) race conditions.
>>>
>>> This change also aligns the locking behavior with the hwmon_fan_alarm
>>> case, which already uses the update lock.
>>>
>>> Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
>>> Fixes: e8ac01e5db32 ("hwmon: Add Maxim MAX6620 hardware monitoring driver")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
>>> ---
>>> Based on the discussion in the link, I will submit a series of patches to
>>> address TOCTOU issues in the hwmon subsystem by converting macros to
>>> functions or adjusting locking where appropriate.
>>
>> This patch is not necessary. The driver registers with the hwmon subsystem
>> using devm_hwmon_device_register_with_info(). That means the hwmon subsystem
>> handles the necessary locking. On top of that, removing the existing driver
>> internal locking code is queued for v6.19.
> 
> Hi Guenter,
> 
> Thanks for the information. I missed the new hwmon subsystem locking
> implementation earlier as it wasn't present in v6.17.9. I have since
> studied the code in v6.18-rc, and it looks like an excellent
> improvement. I will focus exclusively on drivers not using
> devm_hwmon_device_register_with_info() going forward.
> 
> In our previous discussion, you also suggested adding a note to
> submitting-patches.rst about "avoiding calculations in macros" to
> explicitly explain the risk of race conditions. Is this something you
> would still like to see added? If so, I would be happy to prepare a
> patch.
> 

Yes, that would be great. Thanks!

Guenter


