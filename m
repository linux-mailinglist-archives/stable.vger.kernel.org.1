Return-Path: <stable+bounces-128155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1756A7B1A5
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 23:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C459C3B51AE
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB98136E37;
	Thu,  3 Apr 2025 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cKHQfY7C"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0102E62D4;
	Thu,  3 Apr 2025 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716696; cv=none; b=mLr2FcfIme+Ltv4TnwLYbwgAuZIisVx/wkFvJqKQ01iBUY24nLUyAuNbxsKdahuN5BTFDh4e/DyICc+XTPxkhOcTOWEPpjjdqddGA9BIOOKVInervR9Mf76CMlTO//BPrvcPd5S6swWyYpwx53s1Mjh6/6Qtuxvjm5129pc9irg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716696; c=relaxed/simple;
	bh=VsKeWx/5z9BSGQhMr+QuyPGurWoYs8YeA6BMBWvYqcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4fjJ1mxg2JY8FwbM2NDOZh31g7Nma+SpDeabrfTq8Sn1a3jcjBPebzQwyA93hYV7TWXtl9xm7TYCr6tYU+r6/zX4I6h+jSSOwvvQ8SMNHwmH+YzjfQ1gkwCNGgTJIrlQOFFBz7aVEwx56mOPBBhEVRLeNTSnVyKUN40e3/Obdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cKHQfY7C; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf257158fso9301535e9.2;
        Thu, 03 Apr 2025 14:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743716693; x=1744321493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37i28HC0qMX+6A6d+lctFmGy/UQvwqNYdMvj7tEDVvQ=;
        b=cKHQfY7CePiPK4WnUdKtbllGR3zri2GNqk3OJuRC3kNiWwOeuHyE9CtdnpOi7nYtMo
         4ADoLv48lOlXCyA01SNirup01MUorU+62tAJ9kORbljp+VW7Myuh9NEZFNGjmxcVQYmp
         QuS8Vu1xdDF9IgEyFUXfSpsehvhjySni7I0k63ELrY8LGcheqr5sDrZTGtsk3WqtzZ51
         y9aip4T0n4AJ0XjlDIdOdwSDaDOKV70SWOGuDEQcXwCPBl1XeALjA+n5aEIwuATlIu6g
         YlxYl5qTd+53hWKAoRODtvuV7AWciiu5RgvwOqbLP72N8hKIP/17RjynO/mLwcsDYsRJ
         pkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743716693; x=1744321493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37i28HC0qMX+6A6d+lctFmGy/UQvwqNYdMvj7tEDVvQ=;
        b=sHn1zWaDvd/B6drI6iBmqS2dOykinkMvOzTYH6dT4D5n0Kx0o6ppVhLJDOAOMay0He
         OqlCUcG7nHt5B/4LPMJ+GZ2dpSpicAqU0OUE/qnldDxEFWf5HWlaaMnP0IvGfvlriZ6M
         SXOcmziyUXqmh6RFl/hTSyUg4rATgdAqoKLqyu3F/6Ifc31gkV8Vm1IMVbl2taGIYTEt
         ogpEri2dk/vL4PVdxhVmIcU2qKpg9Acu8GGwBpmro2otmLLtrdUi3Jjzvk0n2uzQMazC
         ug/T5Ct//UoM3E3k89MJoX32UCgHBq+0omqP4xDNOYnYjcOOJnv76RwO5IwXIo4Rvdhq
         ofWg==
X-Forwarded-Encrypted: i=1; AJvYcCXezQYKKq8hJdodzGA9i9VqZxTbeO3vyx/8Wxr1clzvc1K5kSd5OBOcwlc7B/NjI+3oZodjVaKK@vger.kernel.org, AJvYcCXy012mAp2+Q4IgaBDl/gVrzot2q8VCm5dsdMQmYh7Cd/p3QoIOwwRWghCLliXPTYI0Sm9Yu+XFy6ROhwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynA/hGBMESwTzai/zpt85k0YSZqi4Fg5muNWUgQH/PKUvXCjwR
	NzOKAdcpn0D4UlEITq1H1MGaLwPj15OmjdpYuti3RqhiE/wZSRQ=
X-Gm-Gg: ASbGnctvIt+G5kKqMxqSYCe1NsNfo6mmayCME1HyNrbjb4IRBEn9bZfAKDiEChTYqG5
	BsEG7qZk/iTUiwPBfgRUGWg0M02Ho5gFsMME6qBWlKwBHxy6rnbeKvj9A6WAuMsxCUzM8N9QDwY
	wIRmW1bJsskLjSpc6H9gcapJVFJoNGTuTzrpQK0pIZEdmODI2VJ1Dws4bnx0JvhLV41+v3kUHew
	Fbt2Dt+//ChvyCd5m+u/+VdvtPJ/n1S3wBOQ+KYWmLXH7sipvo4ufX0OLKGfYw+j9LdptAH4dcr
	LJzYQ+kT4PvJ2ZLupbKBMxUErs/iM7C2jMMZRLyyDPXqQb30/LLMHcJqJTgr6+aR3kpIC83qOQ1
	wg7oAsa9YRjOHImSXaNMuY+k=
X-Google-Smtp-Source: AGHT+IFLgVvUktsx3KtqIiNk8P/LU11g7Dn00Oo0wTs5GCHL77EF+7bVU8+AjuqbTJBpFlLBso07MA==
X-Received: by 2002:a5d:6da1:0:b0:38f:3224:65ff with SMTP id ffacd0b85a97d-39cb357585amr623532f8f.5.1743716693050;
        Thu, 03 Apr 2025 14:44:53 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac393.dip0.t-ipconnect.de. [91.42.195.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a92desm28441915e9.14.2025.04.03.14.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 14:44:52 -0700 (PDT)
Message-ID: <d918b7db-9e6d-4330-bc86-3bcf0c3825a6@googlemail.com>
Date: Thu, 3 Apr 2025 23:44:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/22] 6.12.22-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151622.055059925@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250403151622.055059925@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.04.2025 um 17:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.22 release.
> There are 22 patches in this series, all will be posted as a response
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

