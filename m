Return-Path: <stable+bounces-200131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A2CA6BD7
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 09:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E613830084A9
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09B32B9A8;
	Fri,  5 Dec 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="2yOCMlQ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813FE30B50B
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922907; cv=none; b=hk4b06RnGaLDG7KfeNBMGXkwLk33KsXi5QGLhESFdsaGM2CZv9DZyC2KLiB9jBbGzdnWNOOPnZw4TRtH7b19AukIHk67B6g/m9Ie+ErXMN58//fCUvNHKkzSHXrOTj+Hmx/Vd/tO15z/0dQz1w3MaSov6L8RcD5dh1qgmQJSx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922907; c=relaxed/simple;
	bh=r/FEYp9G7BrUaKaqwcSpDLY7KkubmezBOfuvt/6isEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9nN85zM6mKd8i1rszEe9Y0Qm2ecPOm9GRPM6TKRxX4cWptteaoop6rk8k3rYEgZ2Y/BkNQ+dP9OxncWeX0RQLkjXM3cl5ViAlX9yiPlwPzagbGuHXsG2LoXEcFb254dPNXveRs+Co8aih7pMbFQshdIVWjQ2btSVwhoEa5gHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=2yOCMlQ3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7697e8b01aso82976666b.2
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 00:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1764922888; x=1765527688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFTqnO/Fd2sawQQhIPcCoLFvSOoCx15UbnxbNG9nqpA=;
        b=2yOCMlQ3v3lIDkADH+lN8/RKb0AQ7DRS3IswrTVdWaXTRiTeLSGAYRtbTilSVXz8LW
         OSxi7zv1mzFDz6VXxkbCbuoNzPWMdLXPtoYQvGpB6sLUF2toj24KWjeqzJz3sXB9EaBE
         jDdME7YFtwEIvKXx9C07lUy/vGrxc7IW3+fA8uerKKkkrEfu6I1v4l93TuFQ+w+ZUwbf
         lD7gDyKm7VhSEAa2wXZ4nFjlUWlUkdP41ooyEO6kNM18pmxRRjQ3ub8zruuE9jSn/vcE
         zMC99SMpck84JsKTNU3eai/m9JakXsqZpiBE0bQADMs2azJTrxsUCS8uu7AWdAoNDmFi
         GoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764922888; x=1765527688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFTqnO/Fd2sawQQhIPcCoLFvSOoCx15UbnxbNG9nqpA=;
        b=k8ll4WbvbxrsFaOTgsTYdDitpGiY7u0eq1IMxIDJecM8DGNpmxWYLe1xVT0mCTC+vZ
         uQSlwG30Y7FeUdH8RoOzdyzNMjdUiknaRP0QodH1zw6vLiZ+rkuZnYkPBDGItKM3OR/Y
         S4x7PR6+1gX5oJaPjb967UCIu9WJM5zY3IabeZ8VfCa/DUGg/TfoKWLi7xA7iBFdfV6U
         vSJcXa8+q+3BAHOtYaml6a+kr0gobBkj3z7MFTEzs0726SoFJQ1AIBiJElJwUH2xs69r
         VLKf27AP2cDUixOP1pWLkFrrqoqIEIYYPTxB6vBU4ERvcjHtZpSbAe4cjQVlWUPv0eOj
         w8wA==
X-Gm-Message-State: AOJu0YyUaqePAJ0NvhrhoyOM9xCPfa9ECYTT6sPfVqSfQL7jZdNWjZks
	k+AIUGET8l7VApCdkZAtOsFn8uE8+z9QQgSR27yavXOWoy/quE6q4GKUjkxTJEoshA+k0GOZE+K
	PMcP3VUsv2bMvkD968Zql3xKUXjusrWtOXbJAi1tE6HudaEljsdw6bKovdQ==
X-Gm-Gg: ASbGncuOFFl7eW3Uph2gp1AXQ5sZZmBqtYHz1w91bwukagYcKg7NB/yb8liLeoQkLn0
	IUzdMPaGW9lqN0P4QwrLmiSNmxV4Z3xyjqXTBoGlhgokWj9nMJwsLTIQhAiPuNyzsK7mi/UMWeu
	6/71QFflLwnQ4Tde0Q4uqYwvEnaezdPakWmsbpEifge3aE9HfE1w2qULvCCrixkk0eOiYXgl3lS
	7de+AEyA6oWPAbqC4VwNXaxbgFu6s2R9P7H5VSZ8dqar+pLBIRew///2PxNOoJ5e2NuhoQ=
X-Google-Smtp-Source: AGHT+IEhwwxVHvBzGnvcRs1ZBsC6V2SXb5WppN3WR1olH3vWXdyabaLt9X81lmdZJ3z1dsJ5nsyoiNdGQcjQaOVSH5w=
X-Received: by 2002:a17:907:1c27:b0:b73:848b:34ae with SMTP id
 a640c23a62f3a-b79dbea8994mr919780966b.18.1764922888243; Fri, 05 Dec 2025
 00:21:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152346.456176474@linuxfoundation.org> <CAG=yYw=7i7O7nLLDQ5hdP03wHFSQ04QEXtP8dX-2ytBmiJWsaw@mail.gmail.com>
 <2025120413-impotence-cornfield-16aa@gregkh>
In-Reply-To: <2025120413-impotence-cornfield-16aa@gregkh>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 5 Dec 2025 13:50:51 +0530
X-Gm-Features: AWmQ_bnFM0yAOGrLLgGAq_Fa0ruYEvV3PENXxVfn2W7oaTqf_5z9_nXm-BZquAA
Message-ID: <CAG=yYw=8ZXmf3KE8QDAOJrJ8VtRWgMtCNv6=6FNJw1P_jFw+Rw@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
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

On Thu, Dec 4, 2025 at 9:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Are these new from 6.17.10?  if so, can you bisect to find the offending
> commit?
>
> thanks,
>
> greg k-h
i Have not  compiled 6.17.10
This machine  is not the normal machine i compile  for kernek testin
THis is a typically old  processor and motherboard
But let me try to compile 6.17.10.
and see if i can do git bisec ( i kind of forgot .. i have to learn again)

anyway THANKSt

--=20
software engineer
rajagiri school of engineering and technology

