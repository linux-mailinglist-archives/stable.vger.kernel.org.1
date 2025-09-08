Return-Path: <stable+bounces-178840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59A1B482EB
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917D73AB518
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC6214228;
	Mon,  8 Sep 2025 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="FhL8Ol9d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5391DFE26
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757302895; cv=none; b=LibTNxTDCu8zVht+cC+IwMRsTLU6DlZoWvE+ho4EEplHMgE7Ixlg+FH2MkxjW03Mr764czfnNxo4O3wkJ5HPzurw9X04zrfaAFKztuwITlUh2gj8KKzZ2yXO1u4PNQXsuIdavrj0c4r27SFzWjrY6aUkHpsdXJOuOVI/ODrm1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757302895; c=relaxed/simple;
	bh=FlRezqGlNzRwo/eQaMve/P6wVjIVJ17qa7oQA0cRpLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxttU+6ssZGTx+49AX6bOtnRb54FqQIBeSLjCJ26xiUftLzdhg/6OmO+TskxhTxc+2BgFosXIcf5oMHi6PE0lb8Q4ZyMGfiv7zqKXnUIqape7mqsnk2m8tJo8gaFn/OGW3dhUO8VzASCusmZxUijMj3ZunuY/egQYQQ6cV/35jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=FhL8Ol9d; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2570bf6050bso2150235ad.2
        for <stable@vger.kernel.org>; Sun, 07 Sep 2025 20:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1757302893; x=1757907693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6Z8zaRh25HsvwFwmLDi9HGVEV4yypZcSaE2HnnfjeM=;
        b=FhL8Ol9dM+ZIgGmMwuzsP4Tv8qIVwya7JHjIx1nZyQQKKJZh8mDGOlxNc3i5kxXgdr
         XJmYG9X8kT5KIWMaIUmCfOZlfsfP0//JwfY4aHFAjCyKXkKg4x8WvPYvYnj9ONEu4+xL
         X+hjjhyUSZaVMmTdlorIXD+oowhrT7Nxjcb8bY0Ag+72W67gBc89jZP27Lew4cxj6LgU
         JVk4hcFSAHwq5hdm2AyB5lDMJNb6bYbUGgR1friiNw55oD4h4LHDReZSVLZ4QxYOqDCP
         +KWDmR6D+cAKJQNoBG/U4SLGLczu2NqQS2EjYeZUVYhvslBx+R66zlrkNA8L7Nil98RF
         2x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757302893; x=1757907693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6Z8zaRh25HsvwFwmLDi9HGVEV4yypZcSaE2HnnfjeM=;
        b=RmMW31TREchFoTmN5TtZC6TWXd6gKnw2BPCgG5eaGZnlN2II3Lv8ApiERBJSIYweSR
         1yGWB2PR9o68WmNziNHgBU2Fq8bqy8G+44qveOqBFcyngJSTwK9ci6kEDKa9YnOExl/h
         H3Zm6qq0YOy+Gmg6qXYBTkvPjDJVveCuwM2dmjZhgFHpyHAZ5EGrUKdj/Ea0S+hkpna9
         Vyeb3pu3JS7fOWep0S5TT+BJ97KDYC/DrSiCY5vKHFTJavCvgBlivVc2lBkjbEAq6Zb+
         vp39jHOFSx3XJ2VIogpl7MY5QTPKsiRqjpqxpJKcEgF2kwOakW4E8Ze5oPtWOeLFoXOX
         38FA==
X-Gm-Message-State: AOJu0YwM6d4NBZdS6wuWuBJ6JAgnA7czjeaPivMWBMF4C42s0nsen86G
	o1vpxtlSifC9XckUAvluRPiOpNtUGTgNZCgZE/d29lVP4cdLoOop73pQWnRS4LqAADYPQDt6Jo/
	uazS7j90sUoQS5+o5yrq6m/DGiKQDmIvHwEbXPswkOw==
X-Gm-Gg: ASbGnctjAv18zjD1xMYCQCVDodm8e+Zzwt54Hul5AVD//RPSitW5FxRRHuLkQN5vEkv
	69D4uTawqSa6Cws9yVyxJNYwMRVIrI1okDNOQvOTdZY0jMKeDPUaO58YXjT6fpxH+hGP+XA4R5T
	cgpKLmom6lJVfdv8QnTz8pnWRr9ERbFwoagkZI4C6SvcpBwZlRcWwk0K73TDKKQZxyTG7OZWvHa
	JdWLY+s
X-Google-Smtp-Source: AGHT+IFEijA1F2cyMlEG8dJZx0or8k5xZbxobkL5zQPTFxwayqkrYZYJ+tsFu455csFDZ1bmP4sWayZ0f0NIhk8/C3s=
X-Received: by 2002:a17:902:ebd2:b0:248:fbc1:daf6 with SMTP id
 d9443c01a7336-25174c1a946mr92202915ad.43.1757302893478; Sun, 07 Sep 2025
 20:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195615.802693401@linuxfoundation.org>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 8 Sep 2025 12:41:17 +0900
X-Gm-Features: Ac12FXw1Y1FbZHyIhDFMEyNA6f0UWtK_eXEwjIPuuju3SYeQdj5KpDMQrKsENTM
Message-ID: <CAKL4bV7O=GXXAujmwHXPFuBBd32Vc38n528qCNGshFQUHzHK9Q@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Mon, Sep 8, 2025 at 5:37=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.6-rc1rv-g665877a17a1b
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Mon Sep  8 11:19:48 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

