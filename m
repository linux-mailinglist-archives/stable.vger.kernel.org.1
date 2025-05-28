Return-Path: <stable+bounces-147896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C899AC5E01
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 02:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521991BA4209
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 00:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739F8F77;
	Wed, 28 May 2025 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="frraiNTX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6D257D;
	Wed, 28 May 2025 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390854; cv=none; b=i8OkkuDt/6gS++f1lD+eDchs7SiZN2KYozasC49KbN4haFpPYteUgFwHvLS3vLGfeVeKQiyW+i7PsJHQlkwnsq5EPkIqY8Lj1IdnrSB6NHHbMOkzWrJVNZeR1cJ8lNBAxLS45WgkoaxkBBoPyJY+D3NkZq5NhKTcCKHjHqy4zJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390854; c=relaxed/simple;
	bh=mVsiKfQgdtbPqQDx5dHFsxK7Gt0Bw6dcd5djeHlSsd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZp5zi6INWIOqajp7df0/LyKKyc6T7c+m18zbsnyViOT4i/XG9BR9270/24dHeJUE513tREgLAJ4JkP9W83EdiXYPdl2d0+OdvtN61bTtnrjDLvVcb5AsGQ9CRpWihp6GXygROYUWh+YeCgYMgAhIDOsP2sCikBed5WfPfyeLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=frraiNTX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf680d351so2287285e9.0;
        Tue, 27 May 2025 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748390851; x=1748995651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmxHPv6GLmc8eS7jcRRS2Vo/3s79/PTvlaYFC6JXyAE=;
        b=frraiNTXJxPyayiiu4NyiA3DS/NMi58bZgRLeAyy9u7La9kI/B6mxihDpIKMQfRmJl
         HU4pP8DFa2MuaVcv6JeHunMJL41kHJwINCZCsGpyupMY1OtTZBQN9Ao6nC01o1dIgfDX
         933Cad+zbWnBNFG4hkJr65xgC7ZXeeHImVfv3a6yGarYFJN3bY0v2vkRrkUIMSNBllif
         pkKdnwSEGoXZPmF0o2loSjBR3nZw9yYi88wWR1FEmhBfoa9jPDnCkK5vxLB4lM10FWBZ
         GrWdQVS/D7U35nEfAy2PzS0qDtf8bj/+rFu1pbol0VmQW4PeJHOT6Wfnd8LO2tnT8Ch2
         1hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748390851; x=1748995651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmxHPv6GLmc8eS7jcRRS2Vo/3s79/PTvlaYFC6JXyAE=;
        b=dfZDk4OGcV7158Pzv8SZU+3+S+r683QWVpMtrebdmumfh4Bnfu6HIj2/lcI/SRyYr2
         q3/QgjW2QvNFy0GwFu5Z6/s3UlLCMkUjxA8NW61nTDIyMKeaaWyv3FnuwgXrCQ3Ze39f
         OLeMfPO0Lzd0qUeKvAIYeVRWDFarqE1WbHOKJieYFaUZYTow5iKVXqkGABtcdUNrs3WE
         o+B/zVc8vUtPMUSp0MFDRp1Zs+/NgMS+XlxkaONB67VKxWjNsun/3lWgRWGuZ4Djm2mx
         bz8UHfd9D07auIATsed+ZH9Kyhl2JSKnMlQxcMviowCu2eqFCKpKcuTTYAiRtjOgqchz
         jJpA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ykOEoWCUfmwhOBArPwNT9kY6RqW9QJQyR+Y0xmd7dvw42NyeJU/KQncm1vSUo71ZG8dYD1/9MKmHvi8=@vger.kernel.org, AJvYcCXRWw0gn8aWvXhBskgnGHBI/5HJt7DQhd2ULkEvuKhbGbXXFYDdbrqlyzqKZ8WQSa0QZ0PdY9lq@vger.kernel.org
X-Gm-Message-State: AOJu0YyQfrUsaHqzfhimnopYSwMYOiziHZDEqVN1KwjxSlu3GU2sgPur
	ko6R8Rcb+2bEDKEfZLnjueGuJ1EkszyRSRcX098TFnDqeTxC7E69cT4=
X-Gm-Gg: ASbGncsWYnZjI/zwodOpwYRh8WQAJJN5Q580vr68Yu0CBaMowM1OvUJtoyns2oeOI+U
	YjebsZw/DfngzPjmBombVPZnoFwCubx++8O6vjxeoV91G5vQ9yrOz2nLk1SKUS5co0NVsq9l9YP
	L9a3UZPOhoabLIvRux62kgPc7crCK0Nz8A14b3yoylq/HuCMef9b2t+Gr45MnqrP7T1oEjSKbRD
	I0ZRLsx96YStXHxuIsI/AftD71VzFcxqldnKDhKLPOEkE98Cc/VFUikxWdiKuJds67+JBzVGyal
	lpAIQEs3FO839edTkkUxjczceuNGSdiUcetNfWj1S+h4yZnfi6+vMVfHUGZqkKvhLT9+iZmTapk
	HeTB+IagOLYT6MjZMYh6tf8tEa4E=
X-Google-Smtp-Source: AGHT+IHBGYoAjORKLfnGej3XpZtxv04W4+zzbnuU+YN1whrwnc7991n9oDySvfYwvFf92ZxmXZ5owQ==
X-Received: by 2002:a05:600c:6209:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-44fd1a67ac0mr23646255e9.16.1748390850777;
        Tue, 27 May 2025 17:07:30 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b402f.dip0.t-ipconnect.de. [91.43.64.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4500e1dd65fsm3544515e9.33.2025.05.27.17.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 17:07:29 -0700 (PDT)
Message-ID: <0a14b70c-cfd6-4894-a5db-965e43c1ca15@googlemail.com>
Date: Wed, 28 May 2025 02:07:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/626] 6.12.31-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250527162445.028718347@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.05.2025 um 18:18 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.31 release.
> There are 626 patches in this series, all will be posted as a response
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

