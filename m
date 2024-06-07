Return-Path: <stable+bounces-49995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90FB900BAD
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 20:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F8DB22D76
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBD619B59D;
	Fri,  7 Jun 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MryGsSfo"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460F19B3F8;
	Fri,  7 Jun 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783288; cv=none; b=u8bZdbYYgUpKkVdTtA6hRwqxJNs0OdOmANgQb+WcJKZfyRyOP1rKXrH8bTx3PUVYwbp9YxNtB8FcAwvaQzpCN+C1w5eNpmePDvy4R14+alfzkXzcvOioZrTWBzv5M1sE9eXzvhG163B7ea+WbCT2LN7R4n7BVIjWKojPYLbR+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783288; c=relaxed/simple;
	bh=Y6ZGPlPk4FkOhLXv3Zk2jZLvzmkHxo2CEA9fnJyhh8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgY9e5qffBYsGBJeCTI5uDzlpWGZ219KxJZjKDeVBQDiQwgwbRhYMNpOVoVLThmo7CIcpwEhpzzlfHQzESWdpN3K1g0lwaLNBr9OhmlG4ouYo9jkhJgaCa529j+aVTcdz5Vpc2r+T/9qaW517zI2ao06upwja38QpKeQfw0z5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MryGsSfo; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9d70d93dbso1409248b6e.3;
        Fri, 07 Jun 2024 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717783287; x=1718388087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pS0ds05HCCXOM+EbDOyp7PVbh5OG5LcLHQllkmtfZTU=;
        b=MryGsSfo7DUjaCTDi46/qY9xBTbJ5bCYHSfhYGppdzm8SHZDm16hDlmC1SbDfluFOb
         EagoUBXWGC0pGTrmA78SAm3mZwGni+A0cEBCAZE2FJt6p7f+YtXdjCAmsOVdmnd9gpSZ
         /IZOX6I3lMSObNsvGFf0mIx2aAZaMSJd/d+sx8EACxOEuBEWfyNhRVr9/EpFMxDFXvfo
         Wn7okFSrir1N+inP2i8XW5WDySoDK7cfPvvqjRVGxujPyiSoRMP4CSZrgiiS/Pw6xfWo
         hepaVOFRZ2CN/W8mEpxX7Xu9bX0E/qcVBf3r5V6SJfgynZ7SxDs8H/Q/1vKhGqz90wcQ
         d29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717783287; x=1718388087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS0ds05HCCXOM+EbDOyp7PVbh5OG5LcLHQllkmtfZTU=;
        b=FyY752Sg2jcgVOsBR4p2MYLnPCEuPYvTrT3ItX1sEZbJFP0dyah2UVtqgBLw4dKwV0
         2sJpGWgNdXDCnEiJyaOkLj4YKFrJZeqpCM1xVBO32yQYDv1Liya2gwio2OwsKKaoFzMY
         jTbxxMQ7q09tkhaPTV10VwYxKSznSZ3KBizam9HRp7G52CusI7J2oIKN+YWeqh6iFasa
         /kEr+fU+bDqmt+OMkxX7tXSy1girjHq9vAfKawxoOmvvNzli678vuCT09NY3DTVnIPMn
         MAJqbSy1vl2I1ivsRSQQ1kffUN5n3Mz3Gon/L4CK8omTr0cvJjcIxNvgzZrSthe5nNCb
         jCdw==
X-Forwarded-Encrypted: i=1; AJvYcCU7/RNz0AvG4Se3L2WuAmRVsYkYr6txotoWkxjcxlqaNGAE49YWx5oyVF33gttbNDgac76pqk2tzFdGVt6iGTUjT1/2dPZ5difjjgLl
X-Gm-Message-State: AOJu0YzM8PottZt//4TsVIxhNiB7qx7cYi/ajj2HHMJhxU+3S2xdjn9e
	QdKuMEa6+CAHgxhamy1lDeNpeqJJuaSM6QqbV2k3kuLW6RrmGH+riEfIESFSsM/VTrWTvQlAgQ4
	WLOhZb89p/RYqZhvNiFksKVv1F8w=
X-Google-Smtp-Source: AGHT+IHOuWJjlat2L7E458dgn7PdsQdmans6AbDIbXmnipcWq3CNPFhMFfo6LZu5ztdtr8ghESzUsWn/Ly5gfmovM5I=
X-Received: by 2002:a05:6808:489:b0:3d2:80a:644e with SMTP id
 5614622812f47-3d210d28aa4mr3298220b6e.4.1717783285863; Fri, 07 Jun 2024
 11:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131651.683718371@linuxfoundation.org>
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 7 Jun 2024 11:01:14 -0700
Message-ID: <CAOMdWS+Myg1+1oL7T2BuKG4=W4oNjBX1kW1_nDnmnO883h9Lqg@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

