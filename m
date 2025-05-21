Return-Path: <stable+bounces-145875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB73ABF8DF
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618F77B8C3B
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FADB1E1E0B;
	Wed, 21 May 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k3yJDsP6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B501F12FC;
	Wed, 21 May 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840033; cv=none; b=GUYb9EOzjqqHndfPG5axx7TrrS/t9J4sqkN+cwd7k0f8biC9HzQhmK2cx9/HGiEK4T5MazlpyTSi4sCO9FdSunj5hL+ymzuOhZOxvRNlRYlt8H4qGNlVfbrgZHD90LUt1tk2E4eFPEXh3UoysiWCqMwKcL3k1JiVf1SR03xrCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840033; c=relaxed/simple;
	bh=Sjx9j827C3WnCbxCzyrv4hIEFQ7c0wVi4hBLajRNCAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhuQSj4Heleq16yTYFSg5XZo0llVmaCQHxvqXXzexlYkq+AjFmDhCOXgE72JWVcsAS34zwMO7ZhmjYjBYzkTkse1bjyTFg1ftwCphdqDyVGArVeddl2OfGBd3otWaxzNQ6os/RynkLPWxmX4URAdXI1G5p26UY5eWSzZQIlDjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=k3yJDsP6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a376da332aso2274652f8f.3;
        Wed, 21 May 2025 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747840028; x=1748444828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2f9J5MTYlnWEquYDQufb/Kk6K9vXfUxRcHQCizYOIA=;
        b=k3yJDsP67yNfDQiB90OAJ4Y+sOFH6T0OQFfoVlLdOKPFezoEigsiVwnigagdqCFjqD
         bLey13uMJsXjAYmXf2bDeiIJVOuuSZMIURvI+Rpe3rQwXFpuHopbYVcMsNE8Z4LIWqMo
         2syoFKVoqY69acngDIzwGrqbx/QwYIebigUT80kxn0aLgi9ZvYXTW25HBePz0ZtXgnW4
         6lffnn9iqQrq9yXTNTaTZh4UoGbxwUXl5tuqCWmTo/IBtw7gp/GdfnAjCOjLFGRHFicu
         ijYrtBHdi5jTy0awmSfyh275tFVNjm/3oYMYIVgrNGao4wD6FVOkOSXB6+DYhioVwamA
         TNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747840028; x=1748444828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2f9J5MTYlnWEquYDQufb/Kk6K9vXfUxRcHQCizYOIA=;
        b=fy0uPHBfM5FuIHmkvDUf6zEnZr/30x1HG2GCQCizQToAksMF72T5Kt7IC+Xx+OpXnF
         Ts6KSx9RsO/cEGQdT+aqoz8PDPRq9HNBebtYV0dLU8YXJSAW0kywhnEBmCelwR/qjFV/
         iV9NKx5Xcn59qItLs1IcdvnFjLTtcKpy+HGWMiZofJBO/sJk1jaw04TwJKTP+bv00bCQ
         ZgCLIaNUoCP55gFyAsHCns0vkb77w2eLG93Xgi7f6CRa9NhZDXc1h/O8pWmhx9wY/tXf
         0QFgPX57NFCykXLbel91S3rgo8QZOTmR4DvWyuUuz+XPi8GwH7kEYcA9jz/lvpq0SVz7
         OLhw==
X-Forwarded-Encrypted: i=1; AJvYcCUMKwm/OZ75pmTYtZ5gHDnD2msLxy1goT5aX8bm6lSlpGLNTjfAf42RFV/NaGp0BTiaO6QNfK59LUVi618=@vger.kernel.org, AJvYcCVzHM0yU81DBMNUKybNY0UF9rGkut46YVUNdZU0aFNBKaVVbPwnEpfPzeIrz+vC6gtxbddkUEFm@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3FfthGKQRtJrfdWk592L+UA8OAJAna8CT4vdoa4pHrvp/gkj
	wj3FzDn9KxzqgT8v6gyB7zHzdtZW93mC+4M7mTSvR0wvfliLJvw/WIM=
X-Gm-Gg: ASbGnctdPeGxsdGpx/KzY2QZfrVDFYyHyB8AKl7wQ00Gl6OEko/ZceFbePCrVmNxBPf
	2WAp+hCvMLc5jMp2F/xr9HJLVGGkccMM20f690dsol4RJFy990ZlF6sAsDfkJk4c3mNwZTsY2m4
	p4Uz3fFvWxNcXJxrZbOEMRKPfvOLfP/ckHfZXveXy4qjPJLi081aukEBgibUvZB65lz89SZt7cN
	2bHgWSMqN/b6wAB5WyIkR6+TKq2aeCmpPIu4KHyGMB9uDiZFsUCOpo/cZjyPYSLyVz2+H8ZQ7LO
	yLR5015dB7vpcc0Jvy2IGdaxxtOD2AzZQYDvlSRWKqQlt2bxXPesizgTv9DCgQ5XFw/HVmQwChB
	wD6/guf/KNdMbtomm6CJK3VhLFlM=
X-Google-Smtp-Source: AGHT+IEBWhnKMwSfgeat/ks2OGtoSRGNEoFgB5yoq0NLi0i1cR4Wwg5KRIS9wU+w34NcaoONhtKa6A==
X-Received: by 2002:a05:6000:400f:b0:3a0:b4f1:8bd5 with SMTP id ffacd0b85a97d-3a35fe67aa7mr16678351f8f.18.1747840028138;
        Wed, 21 May 2025 08:07:08 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac604.dip0.t-ipconnect.de. [91.42.198.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a892sm19630199f8f.24.2025.05.21.08.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:07:07 -0700 (PDT)
Message-ID: <524b71e8-4f03-4f6c-94a1-c78f382db25a@googlemail.com>
Date: Wed, 21 May 2025 17:07:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/117] 6.6.92-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125803.981048184@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.05.2025 um 15:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.92 release.
> There are 117 patches in this series, all will be posted as a response
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

