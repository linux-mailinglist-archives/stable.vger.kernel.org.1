Return-Path: <stable+bounces-69394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3279558E5
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611FC1C20C66
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0731154BE0;
	Sat, 17 Aug 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iuplds8D"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322825570;
	Sat, 17 Aug 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723911886; cv=none; b=gLwpNs/MOHdJ9igsMYfG6PP6dzCs1Ju62D3O2fGW3hNqW3rjW3X2E4v0tdaYZHAzTRpIgsMSxqLd7v0vSkCJ3NKaXrQ6zFHvT591KKtvzR7zDh3GKqAJqhgtrWoVirXhA6ZCzrQf2ABQzHnOZo0e733bQcJseRgVzc40W4tK6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723911886; c=relaxed/simple;
	bh=Zyy9deutAUi693FcRc0OvVYLdpY3l3WzCKhvyhNdZ2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKFKjDHWNEOm3hBvMD6duh1HV4MXmYm0i8M7cZN3kLB4BSMH6febDiPht13Tvp2nxZr3zM6mEf8RiskJ+WA5RK3lwT16DG6nf9HjWTPRwP6JEHsWVnQ2c5qIrgVW3GPiJlV3/lfWimd0BYb86oAdCQa4O2MH//9fz57Gws9evTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iuplds8D; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f6be9d13cdso1010205e0c.3;
        Sat, 17 Aug 2024 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723911884; x=1724516684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPgaOuVAOD59RJaGVw9YG5oS9tkxJ6USqmcmqvXCjag=;
        b=Iuplds8DAbTDDRdJIJG5Q/poAjDvafmK25tLZCm5EoLF9i506LKafN4iRplDFEa7DH
         Dqivqr0KrYdNfLgLZY7XYvBxlmZBTe9rpZ0A6fKw5h8eQYjLkNXkW54TkdRcRWXvYf/X
         q3qIgbV0CKYQM0+SZUob78uXBBZYgh51JPRarxHewO+k63P1BLIxGiHDpOjQU7QZX2ES
         nub4FLWjhKSuigIl8KghxZlRuVWruftPQdVbPIyb7J+PuO0ctswi6SbycssCkpL//Jz/
         brrK5x9liO83/NJD4esdzwq4dPuSBjUz7PbHxWcR7rpxGx7+F9BJ6l+PxMvrUbOW62v5
         uXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723911884; x=1724516684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPgaOuVAOD59RJaGVw9YG5oS9tkxJ6USqmcmqvXCjag=;
        b=W84ijADCyFbAT4t6coVXkaJLz4WsdmNe5idvUsiu2hjrgY2NXcyivB/ioIagaZtENW
         A74HY72BEoVwwSEayavbi7Y1MKpmTcB4yuDXdztz5HKj5e7hWut59fo8oN19LrZSPKuu
         C3akW5L17fAsI0Ep3hnXeDB9+EgiT50rYRHuRP1Y5oYO2YWjRnTJd4pDYQIMqUmFpYB4
         5RFepdJU2PpMX6RmqxKuRPu+iHyBf3dgVfj9eDB/riQlZGKN8MZyKTS5vgsPbz9LeJqt
         MEsNZM+Cjo6Z/a7dPRZMRY1PIJZBAztRLtq0zUoUX/F+9of3pO5mO3vNg4b0wUlxHGWW
         rJGg==
X-Forwarded-Encrypted: i=1; AJvYcCX5n+BU0es33ql6fFoxqMISWdoOCdADxwe8AEXaKcMDYHGPdMhIof1xcmYDcPFBZIwBGUsHIgQq2VlYXEUdOTgls9U9d6UheiT9fekp
X-Gm-Message-State: AOJu0YxgErwDIu7R150bPWv0ehqAL2ZnB7pYg7lUPFss72Yq5kYmaEyD
	uJdBWzJjLNxT9lBZTSfBxHo2n5sWehrElrIqU4bYq6oo1hBJMxGOiA5LE4mAd5ZMpQZFO7yqBye
	2onTO1WqsMXew3Y3v2oYOKW+f4Xc=
X-Google-Smtp-Source: AGHT+IEZMsH9C7KHaMNbRAnt2nOEGnrNERfk+CVoemEb4jOhqbS2pD1sG6Ubo59e8/Ph4IoHgwV6XJnRbTlhS9Xcafw=
X-Received: by 2002:a05:6122:4123:b0:4ec:f6f2:f1cd with SMTP id
 71dfb90a1353d-4fc6c9d70aamr5190196e0c.9.1723911883814; Sat, 17 Aug 2024
 09:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816085226.888902473@linuxfoundation.org>
In-Reply-To: <20240816085226.888902473@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Sat, 17 Aug 2024 09:24:32 -0700
Message-ID: <CAOMdWSLwqWtcNF=ZnryAEyg+RDT5_bU-B=q=Z_PUo_t3O1m1nQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.10.6 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Aug 2024 08:52:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.6-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
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

