Return-Path: <stable+bounces-131850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3056CA8172A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA23D1B8837E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF65253B41;
	Tue,  8 Apr 2025 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jWVqHFcA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE9252905;
	Tue,  8 Apr 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145449; cv=none; b=WxcusMiZKMqAtH+XZZNbNigWc2cbxjRu4vUyIApEbFyP3Jd5EpuYnFWisAJeFfap+pCRBwxTDk3Q2hpJ2gO/jpxpmcb0pOE/tr2ZhFTZjD7wa10o4UcNHgJWM3L4TpqVrxUFK4aFQg3QQlobbeorRflJFqZtc+Exr4de3TkOkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145449; c=relaxed/simple;
	bh=BGo9KiR+dEgj65BI8ow4Kqtwa0jSt9YNIHwpxshAqrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGP8iMgb6QyGgyk+iG6gBbGYgAEZk5VKjVXuHxCF1ewV8nsXkIBmGnXL2FRV0NSZh+bvqM4EF41nJhLo+Ecj4aL2lgGQKNVUcDjMYNGJY0b/KI+1LUbKSj6QSdQvVJZCpq/YFscYLjJwygHEnhC07MVQsWIV1fZtcwFpayW006I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jWVqHFcA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so40645285e9.1;
        Tue, 08 Apr 2025 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744145446; x=1744750246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEbZgIwzpCbB+LN4qifjQaUH6u72AT7P05Hk+XIeZ74=;
        b=jWVqHFcAmZ5ERZhPuU0woRE5g5dQZNTH3diXkXPWlKaAzP/A2UAX5Z7z/5sO9xnhTY
         stdz69+o7tKIQfD4gfJizmNym+XuVhmTx9rd/wp6CJwbQDvud39n5+idhCy3vzyTx4QN
         RG3Hj+KPJmvMk7H3sSC16nYqwj3PHXmPd/+WGItS3tWImRr+cNvIhuAcJxugHJi7uYfT
         05Jb4yJUMjXqIqzEE0dDMXe78YHtcTQnKdx3YQagkjrnQHuy8fLa6riTYr7sqkGvcTLC
         m69OMEC7VGce9t/tnGGRYRetidMQm0DKitlGnFyyO4jvOGGWJd4P+0TLuY0vn4cCy7qc
         iYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744145446; x=1744750246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEbZgIwzpCbB+LN4qifjQaUH6u72AT7P05Hk+XIeZ74=;
        b=vWMLgSR4Q4U84GpEJAOkMeQyl7zfbQ9sYJ2JlSvdpprGf2h5ihVxfGmYhkno9eKXvp
         Znd8cxjUT2p3ZkNGjFeaURjz2XwtqCHFgokHTvZcRnI2Qr0reeAX1Fip7CLP7v+K0U5B
         gIIkof7yAWvhSHExK5P0bhkHUYwKk77cFrOnmFep+/YxMwrqgzgHh1xs1Upw+lpVUzYN
         KLHXZMjGWdv02sXPoZOu88+MeBrGP1q8FpQlacvgG+RrhT3gxvR6RnaUifZaNQJYT/4g
         9qNY0QrriHeuC49XtocU1CLxIJJ1ffnCs7rNP7+aIAnWhDULk+FBivzAfq3dFXGyB5HY
         8c6w==
X-Forwarded-Encrypted: i=1; AJvYcCW47zUxtpsqzCQrzWNgSwaNuNLkm9+O86u2xhBby69p6vnrYgQBZB++WmP7/DdHFri4ve0RhmUA@vger.kernel.org, AJvYcCXDCZLD7hdU5WujMOaWQmk9Raqg1FIiMAp7hWfVYF9OD8Sts93KaWQEgp49VQU3k1TaYM+Nj0LV6DfPQHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7AvFbCYigwuh7N6/mkb+JD916T/HhSS3IpSC0r1kj56iFu47
	qMnDqiAZMaZla43imHckiNC1W5t/iYRaRT3TUVW8AfvOLRCn6Nc=
X-Gm-Gg: ASbGnctOrbWS20kr2KvLOSnKv0GPWNuQJDOOTFOkHh1F1BF2vV5WClXsUaokV692z2X
	RF5v8lx8giX20Wkts8dfdz3NPWhWduDmJ3+Mad28KS4wtfEpKjWB7O57Gxd/nP949UykzYlcLDP
	T7U7TGfthHMpuDAXdBBazC2DBu17zv+a2qU4lIFKvypP4C8HlDavEQLCmljS8+cQ/95DzSoUkCZ
	+KHPpY0XeNgWSt9amyRELBlDM95OLJWvZEhMGzM3twGMpz4XzlypN/22CpVC+OwFPibPKf9+sU9
	MnNwsgCZyDnKJZ2eZWeBGc0nlmet56rC/AEaaiuHbqMBmu4peLdx5oFIrlYCX5shdUDVu6XKNxg
	i4meRX6dAUyCrwaIlDF3ikGMOKc8QN5D1
X-Google-Smtp-Source: AGHT+IFStHlYZcT+1NvXOJ+pEycIkbHFTdModnjqwJXeSbK2/ncchMYR0+AALkvYB58kmUyOyoOXnA==
X-Received: by 2002:a05:600c:1f11:b0:43d:98e7:38dc with SMTP id 5b1f17b1804b1-43f1ec8cf09mr4233525e9.5.1744145445703;
        Tue, 08 Apr 2025 13:50:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b057de8.dip0.t-ipconnect.de. [91.5.125.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34af0e6sm175193195e9.16.2025.04.08.13.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 13:50:45 -0700 (PDT)
Message-ID: <72890654-f927-4a6a-873d-c89d0ee1542a@googlemail.com>
Date: Tue, 8 Apr 2025 22:50:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/423] 6.12.23-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408154121.378213016@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250408154121.378213016@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.04.2025 um 17:53 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.23 release.
> There are 423 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

