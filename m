Return-Path: <stable+bounces-46182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D118CF019
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 18:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E83B281780
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184885628;
	Sat, 25 May 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT4fdphC"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140E8593B;
	Sat, 25 May 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716654349; cv=none; b=fTLTtMp6rztQi0EW8MuMxPONyUOtP/j8u3lMTzFmj8Xs1LId8w5ZG2MChb4k0uW4gZKEb0g61HwdU1P3Tlk4xUYqQGnzNlt4y/cEsSzOA8Zm33iyjWV9ZgwfKSYFpXgfrefeFD92DPMaI+LDl+UZvvOdYL0yY/GpSOroyiWgGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716654349; c=relaxed/simple;
	bh=A/aCx4XM1+vEZ+hKgzSWLtqfTQVhIgq3/f7CSTw8z3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbtlhNZz0psRHgJ9QdS1FZFbyhxgteDBfwGj+b4g0BgHUjn36OwrUPCjW88pv7OZCyYFwd+FXXNWDZak0bcl2Rvjv8IhRDOJeVSzl35LdldJP2jrFIxYG6130b4lr2i2E5SFq3WV7arbf3maY3hIuR46dHhh2+F1y+WlYiE7LhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT4fdphC; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4e160984c30so2351216e0c.0;
        Sat, 25 May 2024 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716654347; x=1717259147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gCc6amA/iN9A1y2eIzXZ7JQYMZlMS+mlWjyS0IHIzOk=;
        b=nT4fdphCbYL4ocBQms3Ey9iVIWxIiAY2WPHYECNigE9jsjFpQmaBodBSDuq8AAf7m+
         TOuU4+Weoi6DniChX2s4mYPQhnBEMoyNFOEdi+2+AUGo4toOt7bNhbzJvdD1XZA06KvF
         MQvdbp6x+E02DICUfA/JuTBIBEcMzV5mFElpPpadLufRYJdiNjHiHtoQuo0AF8dxQttx
         puX/iUs87rxL0kzUZgE/Jl/WZyLa7Pu3NpmaHzI98lN0Jv5mfucVJQDhhi2uER1qnsMM
         5GAOv8TZ8MdaODOWXuCQnkBKSqUR2ShjhcBi7EAxi5Y7hmuRZrDv1Pudxq3vpdneHq7q
         LHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716654347; x=1717259147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCc6amA/iN9A1y2eIzXZ7JQYMZlMS+mlWjyS0IHIzOk=;
        b=TOqPAC/mPz6Xh3mLsl6ekg4eFIUNt8rcVU7ZIKoaGmbQfvcqu+ZoZFHscoNi+dmlGc
         nWvv3rbo7TDJO046RBdpYbZqwE0RtUp0uhGIvaO/IX/tQ6y4o+/b170ud7pAEHENlUDC
         PzzywKCbcZ+1BI2y4bIvFrZ3Yb+kUYjSEqEdV5TdwZA+dM7Aj/YaKEp6XzTx5V5z1jwP
         LhdVZWCA07haKiSA3YH1/4z/U1d9gj4CPBTAsNjl47LbEeAI52CooIHuQMNjQZEiCNzQ
         ZRPanoJjRDyd/h9+lwLVztaHy2n42AM8PAmC/00K3kliszb6wWEL4PTrYAfqucJ/kd0b
         +yYA==
X-Forwarded-Encrypted: i=1; AJvYcCWI1ExC+2EnhBBulIJ5/3O+irnuW/BqY1LOO7yutUrRPMCQDhzkOeojEVn4DpktJv/O3Q1fLsTY2YOdM1X71L84AMKRBbVsAEgG/mgZ
X-Gm-Message-State: AOJu0YyEOtnaNNWjB490c68f7ejRhcS7EZiWtdk9gN11//CXVj0gtVyZ
	3qQHCIMsKProwXmF1GmTPLOqV8jdjUs3V/h2/kLQQ4HWVxvgcdFSl4g1rEIujMvfmEKLnZ+99lL
	wb3czGPdO/yhfy0r92vv2muwgW+0=
X-Google-Smtp-Source: AGHT+IFjspeZqU4Kulke2iDRbL9ljkczjIrcb02G6weogmeXljvX/qRl43slyx2kOzNDbRgyb7vcl5Iwk55/MGWKBh4=
X-Received: by 2002:a05:6122:251f:b0:4e4:ee41:7412 with SMTP id
 71dfb90a1353d-4e4ee417e6emr6517570e0c.5.1716654347337; Sat, 25 May 2024
 09:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130342.462912131@linuxfoundation.org>
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Sat, 25 May 2024 09:25:36 -0700
Message-ID: <CAOMdWSKQnNMzp2FLSGNvjsZnz=wOt2TRmq5O9aVnh42U7t6Whw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/102] 6.6.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.32 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.32-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

