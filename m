Return-Path: <stable+bounces-35532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353AA894AB9
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E29286B8E
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 05:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F371803A;
	Tue,  2 Apr 2024 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKQ2fQqV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B718654
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034085; cv=none; b=dXoOe576X8LocjtBv8yseZj8NR3lyj1JjkIGKiHbpjmYCNHc0vv2KmAJSG1qzkQUZuq1IxXwzOKsWyo7S6oYPCT1fbCFls/zGnnkfP51VpIy1qNqmSOiuKaaitmJLztf5ZrIqqqjfT9bnCwkvDZgUMtADr5LCNjPbO5JDYnuxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034085; c=relaxed/simple;
	bh=NlyBxPHAyNv7/T8iQ/z8RSMGympsoOOW1QAfZRFQQYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbrVBMljrd9By557O0YFNWSnZhwK5wwiUSKd2xYqW1l8LUymmPPs1gNM5WwIbbKDQQ1MBQ+9b+ChuY2sWeIDAWZCRjtzZ8u95MJH95yjHm3b18Z54yKUAggJlR/ybB/VTAznOYseY7x4RxsMxW19O+d0GT5sDnzog1VfFmJMlTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKQ2fQqV; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e33b9db07eso1285879241.0
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 22:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712034083; x=1712638883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1gSlS8fLmBzxegVrsxC5VK6VZWbcNLQNxJqECmZ5UM=;
        b=GKQ2fQqV2eSfPoBaW8hY1Sqrk08lLy85JT6OGGNhs7KxkFJ20EtcBM0FAYx/q7XNmm
         V8pAcO0kdGSE5yk1Kpw1gjJIELD7LO/5Cqc17zZgbKrhMAlM4PPhEasSyRPJJwrqIemi
         Ar5sF0Ux/1vXUUnsvWGWYVNpsrnUuuaqa7EWljbWCgRKCMGlejzZsMb4d5iRG9XPHmPE
         EHtKRyQi62w1xWlt1Ge4jPJfhsaubao+LYCCOftNgF7ENPiLZrXwqibmOkg71uzqjHaV
         XrcCO3hhxWRwux+eHF0CAZCQM9eZS8ZJB44yCmbSLSycYo9sGjawuOffFhgO4SEFMwE4
         XRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712034083; x=1712638883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1gSlS8fLmBzxegVrsxC5VK6VZWbcNLQNxJqECmZ5UM=;
        b=QGJ04tgU4nOgs9iO/ZFT+NaQ1lhyd7+R2L2wvi38n6+hzf85bR2CXjnPgjCqE93Zc2
         unsxuNCvYUZUVWwgE9/J0EfXyb7lBS8ADes6nU5hZtlcQoVeb837fAyK0Pbczs+zlThI
         Q/vl59mg3ipQJRbWYMdOWSX8EQxcY0IrQn6ApoyP6PDGwvNfaTnCSQhL3jkid34/QU+u
         /P5gNzriW9T4ic2kutMvdJapf6FBcJB+WHEecLV2A6+bJCTEf0VLKAUhFSH5gr4aQWqD
         UJYIWuHP5g5TGmBrJHJnhUgdP4M6rMtN9UdJRQvVAMAAt2sfRXQhDcliyMgZafcryURF
         w5WA==
X-Forwarded-Encrypted: i=1; AJvYcCXarS2Atow+6sahQ3scJoEnW/LuF52X21G92SYm1zplWiBTPzM+clKJDZgvPBwlonTpEoC7MB7J1sjRurzHt1OG42x5P5Z+
X-Gm-Message-State: AOJu0YyKoRhVynsBEYJY6qP8/OONmPZXy/H12oseM7nKSPvEKWrLXVJ/
	VpOuBVZOSskGgc3XO5WxlcPq0F6lbPH74+gxDbO24AXiXpHt+2FG3LopKjcdVw/1Hcjq8myyXs7
	C8wOf3NsW5VQoQx6sLETaFGr8LEdP0EIcgFDi/g==
X-Google-Smtp-Source: AGHT+IFbWd87Vw4lUKJrcGZtFq6L8tz7Pk5A3fnIVM0X6MCy+GrJJQRDnUgtXO3nhQHsmMS7Qn2OwbW+bWyfrDvPcd0=
X-Received: by 2002:a05:6122:a05:b0:4d8:787c:4a6c with SMTP id
 5-20020a0561220a0500b004d8787c4a6cmr9108749vkn.5.1712034082741; Mon, 01 Apr
 2024 22:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152549.131030308@linuxfoundation.org> <CA+G9fYuHZ9TCsGYMuxisqSFVoJ3brQx4C5Xk7=FJ+23PHbhKWw@mail.gmail.com>
 <20240401205103.606cba95@kernel.org>
In-Reply-To: <20240401205103.606cba95@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 10:31:11 +0530
Message-ID: <CA+G9fYu+U1kkxt+OGyg=qSr3PfZipuazaANNTdfKvdY_zQBxyg@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, 
	Netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Arnd Bergmann <arnd@arndb.de>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 09:21, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 2 Apr 2024 01:10:11 +0530 Naresh Kamboju wrote:
> > The following kernel BUG: unable to handle page fault for address and followed
> > by Kernel panic - not syncing: Fatal exception in interrupt noticed
> > on the qemu-i386 running  selftests: net: pmtu.sh test case and the kernel
> > built with kselftest merge net configs with clang.
> >
> > We are investigating this problem on qemu-i386.
>
> One-off or does it repro?

one-off.
I have tried reproducing this problem and no luck yet.

- Naresh

