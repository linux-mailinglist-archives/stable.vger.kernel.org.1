Return-Path: <stable+bounces-144165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 859D8AB5530
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 14:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF9919E5E1E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D5728DF05;
	Tue, 13 May 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="RVC0RZrL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43003243968
	for <stable@vger.kernel.org>; Tue, 13 May 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140649; cv=none; b=f+MPh/bxHtnHeSsh6cK9OdUlFBS27hHhiQP1E3NvH4eLZ+z4KOVX8bb7/dNKd3MGUMzgmWcDbuacPjkH7DGePr5BnmObFanbCe0FoQjCcwswUS3/D9yVD9EwZsm20qV46fL9KpvbDrI879zWjZqsCtFY7hagmn7oh8aK9u52IkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140649; c=relaxed/simple;
	bh=cbkNHpfCazDp/U2uIDhXT83+u8gzdMCgbpu2J3wJRIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4Ps08sdD4Qs6WfRuaakyPw9yj6bbg7rgsPKDg0W5m8Pu5HsjXVg995g/E+fkMVZmVAsKim0WUpEWhrQGWaOfs2JzUlnbU60rz+dchWs7SCEiM6BI/KDKpLetwiGBRYkE0/5bKSsD9Z4NUsVEV2R4VGb5gqpCx9aVhpjpyXOsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=RVC0RZrL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c922169051so335118285a.0
        for <stable@vger.kernel.org>; Tue, 13 May 2025 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1747140645; x=1747745445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fIGxDjB0SYqfDID/zzJ+9sqlaZDZdlnVxHTIBP3fm0=;
        b=RVC0RZrLA1j+1rc988RYMB/BOKcSbM8vAQoatix8JXJWQs0bdnqNIVfKal35JJGCFW
         Idq5tAAoATfdmFD+LYT86DLzlhvXfb3iyXRvyQTGuaUS2PX8oZwmTAe5mXzLIi2aYmQK
         w64BoibqR717T0w/e3av+r4vGiA+8ot1H/20JfNp/4tQsVoPq1/67NEeZkG6WV1GvYjc
         z3mYlUnRHw5SBg770sbO4PjfJgVGIeuzQeS0nYXQ0OvA8pHbPzapd9MKUH8fJLdvBvCw
         b+6H8SWuLgbuvOAnDMLGkTh8kv8meb9uAWxsj0zn9mcqNQJ9+CC39daOZDLyIcAqcvUS
         df6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747140645; x=1747745445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fIGxDjB0SYqfDID/zzJ+9sqlaZDZdlnVxHTIBP3fm0=;
        b=uqaRCGqHGuzg+6fM+2UKCJaYL5n7JWNHtt1WboB9lORqKgS2MHChQiWDQ01dlJs4LU
         tpllssRzbgpFgY6YSf3cveNm74kSTV7tnQw8MSRN/Ma4e9YYc7juVam5JLZhgMynsKRH
         gz4v2e99//b0BOlQIxaSVQXEQ0X9pTNMvd9vBqWAMCbOyzLzKHtV0WVXeGRD9s6hK9Yh
         Y0whoeQ+YlBK2ykNGq7RFOsyx2gXPRvxiqUkS/6vyGzu/u/T0KXNGD6hsvgTD8NtrpxY
         rrjKFBRiYhrcYDl9yeFDpGOcxZs2cY9ZEDnsutXcxaElDI7Zjyja1Q66gayVVtVrBXRR
         9ODA==
X-Gm-Message-State: AOJu0Yz5cCstbFx27lqq2Z4h/kUI63jiay1rLRYPoow14LA6qHTLiJMK
	5wStgGlt1v1uLXYJHcP9/B7jqqM7pk+GYBZNAUO/3Y2rYW3UY5MA8G3rkXmbgoSZ2bLRmLPYwjh
	LcC5/thTjMYIAUeLFxJwHumT6dYR1aJczIjA4Jg==
X-Gm-Gg: ASbGncsUfujy8FgEr86JLrtkjD+H8/khu72R+UXoO0q/E8fgepQ6bU07aeuDhJnFmuo
	WxucFTziFq3Cf/4sS0l/pLvpCdEoCUE5hHLh2IxcmMRAT5Q/v2fO1Ph7L+sCSMMawWiC+vUz3Nh
	yI49y8tr7Ewb/IxGAk/8jr+/Z/Smy9wdRi
X-Google-Smtp-Source: AGHT+IHBEdsF6gSFx1qwBk8MOhT+FX89ZCga3+pTyELVVHANhV/m9TZ/cnRgBn5szaUnkrhaLYyUlGiH0Cn/NnATxfw=
X-Received: by 2002:a05:620a:4403:b0:7cd:92:9f48 with SMTP id
 af79cd13be357-7cd0114f73dmr2851585985a.52.1747140644988; Tue, 13 May 2025
 05:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172041.624042835@linuxfoundation.org>
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Tue, 13 May 2025 08:50:34 -0400
X-Gm-Features: AX0GCFujP5y8odal_JrTQezDnw3_S4uS2-SeBQTOZ8FQ5LfW4rl2-L89_wnvi1c
Message-ID: <CAOBMUvgh215jYs+YzZ6+MxM3VNGL1_ZQ-yx9k9Fjn7NxSdbXCA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/184] 6.12.29-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.29 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.29-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

