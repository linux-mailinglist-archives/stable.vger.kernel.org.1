Return-Path: <stable+bounces-45230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86918C6D00
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C2928302E
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B40815ADA4;
	Wed, 15 May 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFqlvdo9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D151591FD;
	Wed, 15 May 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802685; cv=none; b=TDCIqxdPlKspuj14UpE7SzSw4rfsJK44siqz3sNg6mKZ+3Z9ZqbV9U2++/GE+l9n8pP8j8Y1mgM1PNwFzAXWPHvbEm27BVBhlHgsn+vlXpwU60hLTS4YLaKH82FVW/TFt2F8MqHlw5TU6C25WC1SFe4dFKdlG4E+H1WeQ6SCNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802685; c=relaxed/simple;
	bh=xUdwyyc9DDJMLZ61thjjioNQXbXlTBzS5tFbsMz+eiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl87f+gcTjDEoKhZk5qwMkH33dXhwgquCgWRiMINbu1qEWBnFN83QJXy/bQ5ZUSTqiG53eTSXo8VfZzKQIZiHPjM5tO+/767ntyl+0Uyzma/4u5xnAnxSsCvf1vXDdquVbZS6ONr7RBfGBmd6PYpkCq5hagAD8xD58OvhA3XZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFqlvdo9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572af0b12b8so2360921a12.2;
        Wed, 15 May 2024 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715802682; x=1716407482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bv6Y52OPQ45b8PiWsJQ93RfatvvEmIVGeOXnyCxO5FU=;
        b=NFqlvdo9N8+8YGqUxZrXKDfpoyN3zgmDp2CSJVAFTlG4unsK30aOaqwVZBxyCe636C
         FKbqF3usn49RUUE/scqclxM77IIFG13IDzaiQnWrpU9S+mi4HuDfrXnfx1J5fEzCwgS+
         nnEtZJ0/+lNG8FpmmcGkjvsDV27dbWFHebFc7FbSm0Bpiak5bHA2PO+T1l8ZGA+pD+SK
         XfDLvoNrIQgEHPGAGytrBelAgqs+DewLYSdz6eptQ5hzxGxHCjcoUOO779Hj+4N6na0G
         6IpaEAez+N846xt43g8gXRRJiimWYiEe1O3D9XovHrVSmN7J/QnvizgEhXJN9EfU671H
         uuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802682; x=1716407482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bv6Y52OPQ45b8PiWsJQ93RfatvvEmIVGeOXnyCxO5FU=;
        b=DQuFNZxo4LymVson0zXfHH9T708SqgRGOaEnUTiuyTZpcUvurNlV3LBUI+NjLs6gmo
         IhXfp7zi5Qxh9/tgKhs2F5rTgK95ERlgZgb7gRYZES0IZzF45m+U8wUZf0N4K+AvW4BT
         23dzxZCo7RDp9MMiclJ6XwsrkGBtZ9++G2c+3BcaMmVC6gHWaa2MZ2AlYQ4Y5SxjpV10
         PJbNLxtuWkEliwNYL46bd1c8OsHvKwb0XU1qn/p2/GzeSZMjEoEOeM/eKIJiosnIoQXG
         PPY4OUSacNLK9M5UpMzmhz6GGtsKQ6uJgFAxkSjbn3LrMwCtnS8waEWN/BIZIzCC69IS
         ua3w==
X-Forwarded-Encrypted: i=1; AJvYcCXpiFxw2DTL6cw1ZhSia67jdb1SfoNKbLcTdl6OFjeZ1+hTbmHAFjnLC5nWxR0714J4F8AoYsh5HT8icYQ4ujyE4WD/dTo23INkg1zx
X-Gm-Message-State: AOJu0YxEWekA+QzfUvLej9zMqQF9BtC1DZkXEJW0IXEm2/52incAGL+o
	hDnWlUYs39FQEcbHy4p0BHWYKtUhTNaNN5CECLEyDGz7CaUp4H/XYfEvyaB4YHAiYC+LK+JZwxH
	XxLBA2bH4+5bYlEniQpY0o6WaSU8=
X-Google-Smtp-Source: AGHT+IFnG3YKmbtnr5G5j/7XAJy6uS82VIYWqDP7F7G6aYqhTJgctHd1HPS5diLdOftxXl/0W/6S3/bEGt8kjGdUNH4=
X-Received: by 2002:a17:906:9815:b0:a5a:c194:b53d with SMTP id
 a640c23a62f3a-a5ac194b61fmr261965866b.20.1715802682025; Wed, 15 May 2024
 12:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082517.910544858@linuxfoundation.org>
In-Reply-To: <20240515082517.910544858@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 15 May 2024 12:51:09 -0700
Message-ID: <CAOMdWSLtpXkvXTckfsD6BWPg4V-qAFX2NhJsR0nm3F9DBm6F8A@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/340] 6.8.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.8.10 release.
> There are 340 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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

