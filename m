Return-Path: <stable+bounces-201014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DA3CBD12C
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5FF430285AB
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00B329C5F;
	Mon, 15 Dec 2025 08:56:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E00329383
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788961; cv=none; b=BVEjBqY0n+ySY2qD+y5b+GMWqxYluSU7R9iiWFd9q45lcX7DCQVc8B6eYIJ3Z2oNaxffdBFHPT0p9M1Uib3BV3KPI5OuVPE4YO7UrUdkTWjk3GNRnZJQjaAFVHSixU4STyAbR4JdE9GwDO1wwUgkIDOSIk1iIQ12SK/b/xR25hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788961; c=relaxed/simple;
	bh=JZz9JU4z69cVYdUg7URaUVpfzMhnOcFJCKbJFU1XYuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAKr5AIsD3p/2UhAMMvKx70YRUDeZ6jXcWWc0H4fGoch5SpfjfbtZv/TP9f2S9U/DGxcZ096qfFN3KkBMxASShMRh6qkWbjoHL89lcISn7dfFiGiy5NZNw2p50SHZRxYj3y2/w0upz/guRgutNcWHd1CKCLPfZJy4EZ/P2uOOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64470c64c1bso4334827d50.1
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 00:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788958; x=1766393758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZmZ392SyRouDGiRBywTbyIPFjYGlT+0xiRyvkmmrxg=;
        b=mB9Q1BZaX0BV2d39UX6JREYNlIM1BMUJDgjWLfSGfP6nD2JUVXjnXk/9m6Lz6MYb8q
         oRmupQvvANejz55Nm2HsMyeiHRsu62+U/V0Qhe3c7Qn5adlw27/CEuC5Ok+HKhYJ0Lgj
         Uv16yrVM9Eumd3rsgY6nmBqV3RuWKXPvD0KJjB4g4fnyuJosynRK1TrB+NF/xB1pYJye
         kw/p+Abdw+DvEA2hMTO3BbTnO5kMBI89loQYfa8fd54skmSZ1jQiynLohgQ13tE3bn3o
         sX0hyzufJLVtz8yl0Ki7Em8y7Yvj9MKCQOFfGgqYRGxiEWBHrnneeKbBrOZ/AQWXApco
         NuEA==
X-Forwarded-Encrypted: i=1; AJvYcCX3MlzTe0eZ72h7GFC6+uvh1NHcOjUd6bVKqAiSMGWnOZkiH34TmTO49X/3Ctgdf1tCidvGFG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+sg2PdKAM46kpMdffLm/inOpaD0yZ8NvE5vEHRGYszeGX20+
	VELe93SiQG21RgV5vM+gVyXAVq6G/KTF5oX0YNDt/nF82mCDsQBIoBItd2KG9G23kms=
X-Gm-Gg: AY/fxX6aFMkuuYRG2E3Yxlbjt2oDmUFu1jHO4D62pTdXBOFnyfZgkoYgY5gFNRm9IjJ
	F7GThA+lJ+ofh4Taeh3GRaGjONrm8V8uSfU03910QAM9/4tUbGn3/bZ5LfiT6PRC+thqCxGvFQP
	+WRxTmWX5unUMCn/czbAHeR34+0jyCgyzCek66fByqkG8RO40iMf+s5h8A/UU3wvycAHQBNlzjI
	CLdMq2mC2nfq4E5K0vDjVJKWnQKcnIGMVWB8QB1E9kpFJZHS8YkMXQ8adr8kG7/nQp0qspNVhHY
	hzM0v0bJCRFEygwAk2y/E/PIRttRumhCQb+SMAcyPIar5sJ7HWr6AH2+9aYAfAFJCrEPNsTNRI9
	DOA9b05Hmon/xWjzk74xdgG4nqCs17N9nxbWaIJUBBde4pgMBeX0Ts8c1vA6uyRWcMqqzz7zgoQ
	JAeridvUsl2t3WQEOx05gSdxDuy2j5RUV267abjjFEusa8CQc=
X-Google-Smtp-Source: AGHT+IEYcVbneELeFWDWkYB+YsGkRGaNQ6ITKdAZJ0cqUNK+ZBE5VxHp4h18VDpe16sR3R67+SgIeA==
X-Received: by 2002:a05:690e:400e:b0:644:6c19:8a26 with SMTP id 956f58d0204a3-6455515a83fmr6938627d50.19.1765788958360;
        Mon, 15 Dec 2025 00:55:58 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477dab9fbsm6154778d50.14.2025.12.15.00.55.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 00:55:58 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-787eb2d8663so35791937b3.0
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 00:55:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaPZh/kucrQ/WxE25pW/cSX3PgcsSf+q7zEy3ePs+CIC7E2TqCkqK8CEKZsgXnHCRs1QD8/mE=@vger.kernel.org
X-Received: by 2002:a05:690c:dc5:b0:786:a68f:aec7 with SMTP id
 00721157ae682-78d6ded488cmr126790657b3.14.1765788957951; Mon, 15 Dec 2025
 00:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213-mount-ebusy-v1-1-7b2907b7b0b2@black-desk.cn> <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd>
In-Reply-To: <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd>
From: Chen Linxuan <me@black-desk.cn>
Date: Mon, 15 Dec 2025 16:55:46 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMrF_vZAbPatzgQP_RDowCwOpBV71V1acv5VpogWuhzXg@mail.gmail.com>
X-Gm-Features: AQt7F2q8dQ6TO1jnmhgh6xV5sZ0ve5sQZxU4h-8wlLqKz3QYB8QPxcDhRrAZ-k4
Message-ID: <CAC1kPDMrF_vZAbPatzgQP_RDowCwOpBV71V1acv5VpogWuhzXg@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix EBUSY on FSCONFIG_CMD_CREATE retry
To: Jan Kara <jack@suse.cz>
Cc: me@black-desk.cn, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 4:46=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 13-12-25 02:03:56, Chen Linxuan via B4 Relay wrote:
> > If the syscall is restarted, fsconfig() is called again and retrieves
> > the *same* fs_context. However, vfs_cmd_create() rejects the call
> > because the phase was left as FS_CONTEXT_CREATING during the first
> > attempt:
>
> Well, not quite. The phase is actually set to FS_CONTEXT_FAILED if
> vfs_get_tree() returns any error. Still the effect is the same.

Oh, that's a mistake.

> Thanks for the patch. It looks good to me. I'd slightly prefer style like=
:
>
>         if (ret) {
>                 if (ret =3D=3D -ERESTARTNOINTR)
>                         fc->phase =3D FS_CONTEXT_CREATE_PARAMS;
>                 else
>                         fc->phase =3D FS_CONTEXT_FAILED;
>                 return ret;
>         }

Will be applied in v2.

