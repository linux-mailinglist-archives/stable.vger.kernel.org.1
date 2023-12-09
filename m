Return-Path: <stable+bounces-5094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A918B80B2BA
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 08:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CA91C209FB
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748101FB7;
	Sat,  9 Dec 2023 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxUH4xyd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47777D5B
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 23:22:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso18215e9.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 23:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702106523; x=1702711323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUtgNSYOEKLeTvF1TpNJq/Ub8mwqgxKokq1l9Seizro=;
        b=ZxUH4xyd+S8IiVfH71BCjZIiZPqAJOjwjDgZGeLKGKItntiJNwc/NKMVH0Bmj3vcPi
         SnQhwgQqj9mFUwvKwgNvDHBJS/fPlKxudFKB00rOTOVtHsYH+n0XXOu2s5qMkYbL2hzk
         m4F1vSkOWgyBf/wF6AD8pfs3txky3NRvq6/Fz9ZJCLzmeRV1yckxWmlPeW41b6dsf+ot
         LeMMBxfTdjRh02qcmBBOXKTEETTnmaZvrZfhhLhJ2waqIXNc6coFMtiSEg1CPS3vxGCf
         wtBv5I7mRWU6vI6qwnkWnwSbR67Gii2wteVEtYlCO9rylZlPsdTZmNJoV9ISGvmTXN1P
         XwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702106523; x=1702711323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUtgNSYOEKLeTvF1TpNJq/Ub8mwqgxKokq1l9Seizro=;
        b=S6BqGV5IDjlqWwkkxaEI6VSGw3QdWPNzHvtHeauByOJryjJIObp6235hP5n63DR996
         aySaN9X76KGBFL4jh056MJGnCVOiMPyfrZsRCkffL5kQT6wgip71H9uRyuy2EoVZSSp6
         J90spDvsnZMHwUfCfuiN3selqtoina1+zKa1qKe86uUYcdItr80H0wkwacTfTu67Cdo7
         PDH9nd/HJae7pW8NEYlVtljzw+WaRl1WcNFbZOOHs5xfhYBeMYiH5fXe02Yx9/U0frJZ
         ryJ9HaJBQt/Yi8C/WOyoOM8HWMkW1t/ohnEvtwCwlUo8mIUNd8QV3rM+taiy5iI5IANs
         3XHw==
X-Gm-Message-State: AOJu0YyPJkPOoTKGHwhV60pCxTgWVWkf3fNDEWucvg1pflyEDIHFqT1f
	YzJcE9d6b/owK6n7UEP7U393Af13yNtc9qDgcd1Kfo6W3nRSmfsnpoERlg==
X-Google-Smtp-Source: AGHT+IHl67Rn66PFZhBDl8Pgoenc1uOMEHESZ3EUCutZlPVi1KF+zHxl+Cxd4M0Z2RxSCAqWHZuZ+JErnHuiuU/o/B0=
X-Received: by 2002:a05:600c:600a:b0:40a:483f:f828 with SMTP id
 az10-20020a05600c600a00b0040a483ff828mr125628wmb.4.1702106523505; Fri, 08 Dec
 2023 23:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGcj8zskLQLcZTDZUET-LEtvixpp7K25m4c64wQhvg++zA@mail.gmail.com>
 <ZXQRKHut5BQGBWOb@sashalap>
In-Reply-To: <ZXQRKHut5BQGBWOb@sashalap>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 8 Dec 2023 23:21:52 -0800
Message-ID: <CANP3RGdMVR-9F8awedpeqbH9Lb0Vk0dUC16OaOxUO1+A3yrrwA@mail.gmail.com>
Subject: Re: Request for 3 patches.
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 11:03=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Fri, Dec 08, 2023 at 02:17:36PM -0800, Maciej =C5=BBenczykowski wrote:
> >It appears that 4.14 (.332) and 4.19 (.301) LTS missed out on:
> >
> >  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D66b5f1c439843bcbab01cc7f3854ae2742f3d1e3
> >  net-ipv6-ndisc: add support for RFC7710 RA Captive Portal Identifier
> >
> >while 4.14, 4.19 and 5.4 (.263) LTS missed out on:
> >
> >  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dc24a77edc9a7ac9b5fea75407f197fe1469262f4
> >  ipv6: ndisc: add support for 'PREF64' dns64 prefix identifier
> >and
> >  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D9175d3f38816835b0801bacbf4f6aff1a1672b71
> >  ipv6: ndisc: RFC-ietf-6man-ra-pref64-09 is now published as RFC8781
> >
> >Could we get these included?
> >They're trivial.
>
> They're trivial, but it really doesn't look like fixes...
>
> Isn't it there just to support a new RFC?

True, but the entirety of the rest of the required implementation is
entirely userspace.
This information just somehow has to be passed in from the RA to
userspace, and while using raw packet sockets is possible, it's a bit
painful.

If it helps any they're already in Android Common Kernel as far back as 4.9=
:
  https://android-review.googlesource.com/q/project:kernel/common+status:me=
rged+pref64
which I guess does mean it doesn't really matter for me, just clearing
out an AI from my list...

> Thanks,
> Sasha

