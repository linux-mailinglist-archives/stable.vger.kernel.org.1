Return-Path: <stable+bounces-191956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E610C26AD5
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 20:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4668D188A785
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF12FF659;
	Fri, 31 Oct 2025 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="gkFVYKms"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8FF2F83B3
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937925; cv=none; b=pk/6plLxgMMUz8LiQt2Zfn6UeY7gOO16JnMCYd5aU1NeEnHI8i6dNwxYufhwl1VXwx0ZPsg15yt+i1UZsovcM3oBvwARV2cO96d9X3pT8f/luACiW4m4caqfjZuNCTZXwgqNTpXgo/WXDWz7NLM++UXc7I5P1KwnSiaXf0H8VKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937925; c=relaxed/simple;
	bh=VW52jNshrh5SwG3OJpB/yIJkkVhz+nrrHyDT6wGQ7DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDklZhjpl6Sb/Y3xz/sAeS9W17oEHBxdxUISd7gvMRji2tkFu9H+LAndTH1ZgNROtYgK2FXGK8UXRzQhvQvBDc0IvUaagFbypC9vf8+G840IKjlVZnT1aydq+g/hcA4EFb5mON+5B68l7SZkVj2DnQaxrBJlaKvDBjCSpI/e5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=gkFVYKms; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-89ead335959so238087385a.2
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1761937923; x=1762542723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKR7crf4GwOivpvRLCbaBASd2D3y96XEYtat0+ID5i0=;
        b=gkFVYKmsUhH7219PMU5/7DzGttB7UVX4MOYWtHDgDdwSCNzferrPWTe22WVx8LDtWV
         T28AyLes6ntM1TULE6UdIvciUJOlqSaDCMVhzZm2oqvtlZWLFrgtvP6qJTSeuytmcRRK
         0Z+1i8LgbQOWqWM7X9QAJvVu/MGucxB+vAyDdPoNS7zV07YzlZZyug1M9QwPSqm6spAt
         euGKj5KlWk9U34w+7X5/gKGCrG0Vvx14vPrmKbh9FLU54VWoD6fY5RnbcGAhU98+ldqs
         jEBXkXzyxZ8/kiAN5gHMMO4EQ4/ApskO+553acQaVcdOggCYnbusaJETBgxJr+13/uly
         LZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761937923; x=1762542723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKR7crf4GwOivpvRLCbaBASd2D3y96XEYtat0+ID5i0=;
        b=YGbWz6zrZw05C0csXyX6ZYw/mMCAB2pRj+Znf7qCJV7d3WXRGd4kuFg0Qb/2TB3nuq
         mDUQrv87XIV0q1YEwrjrdIt4JOrCULKDChEufpT6CwuailLJ+5dEOmsQDoEVOP/YHbf/
         +NjAunh1Widkw52V+JGw/a2TR9q7+CoA1X7Ygs9gkGGm64ubine7tLB/lsPRSu2AkhdA
         R/22vRDIkGz61eOjmp6q3svNCTfbonoDj1vWwrLY8KXLxfzl4O/0Se7oE7ryowyPWlDb
         gW1fnQLiupqOwCJApitbZDZAP5lnTIlC0V6JIrQ43oBlQeXbvGm5Lv35FpBtOANC/MAz
         2ynw==
X-Gm-Message-State: AOJu0Yym+XadK+9EXwb8QIaVczdPjAUU+KqYAyYKFT3xHGhfIgRH2/OC
	mMPyvb7QI3VKTeUDlEGxEZbflgCjXhcboVRuGRVyVxTKYYqRyHuCY9cZYvPhUH+n9yobbU5rAMV
	0k2TYDodiSqcELeqOglEQMG/3nHsuH7b8T8L4Pl+E+Q==
X-Gm-Gg: ASbGncuud3qPXcfR8f+d4pi0np6fg7auHb+B5svCsFB7nUY3WajvZPsuaySPB1adD5+
	ECPxJ/C3dc60X5hNGqdmaP95yIWZjSSe+UxgTsPIg7ArEcm+DtYmNEHbsqz8icVbTMtVbwOHuLm
	C9QMqUw5Pd3tXLA7P9htExs4PB9pTXoRM9rvw69nMfvZMy5xqPw6z0G+5HXDqv0bVXPMfxDpLSf
	gZnrM8OmbcWWnwu6qG/ZTCT6ldcczEfdN3lniONoVC+/tL3JbPD6Vx/MprmHg==
X-Google-Smtp-Source: AGHT+IG3iKrNw7U2RiWr5RCEwmcEiYiWNVXYOelNJaGUT4rwn4en67o6PjcX93opjYUMUdYHKXkmLkViJEygAirpqBk=
X-Received: by 2002:a05:620a:170c:b0:829:b669:c791 with SMTP id
 af79cd13be357-8ab9b2b5fb2mr518908385a.78.1761937922975; Fri, 31 Oct 2025
 12:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.939381518@linuxfoundation.org>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 31 Oct 2025 15:11:51 -0400
X-Gm-Features: AWmQ_blubeC_F1ghhkUZnTlNc4Rapn6sY8JSKK6GBZ0QDFQnn6VHLBWB30ACz6U
Message-ID: <CAOBMUvhbgiLkKC7rhz02-+V6RySpirEd=6FzsBZDQQHf3ix+XQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 10:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.57-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

