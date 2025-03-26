Return-Path: <stable+bounces-126792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDE4A71E94
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E15188AF5D
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F581253337;
	Wed, 26 Mar 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqqicsDb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275D24EA9A;
	Wed, 26 Mar 2025 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014544; cv=none; b=qab9dlsx1H3LdPs4iI4n8w39XYbfaAiS1muy6bCk7XfKeDCiqppH/lqtrXSohHxoiFGT/azktY1G3PvLvu3Pmfg306Z/enCPj2sW/++K5RTZOrqVVQb6B679UiWim2ktxPtdlL8Z0BG7JTjPlQ24KipFIszzJhRa3hpkAZw3vKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014544; c=relaxed/simple;
	bh=3GCuaFRiBJqbAVFYSqi9R3hp1bxmX5HXeie7MDE5R1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqX7VnVfjdLnLxnpQLeUMqqG/B7WdLD8IorHLSDJVpvMvBxLEzJSMcWVLdc7MYhUxMGKNVtSYTX9Nac0jDBMYMXTQ709epM7X0TRzMT5ikrHIP+vOK+80kPWfTCnBCjPv3r5tmqxKvr09Vp4lE2WO/xlaYQYVBpHsF4jkmjScqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqqicsDb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so216109a12.3;
        Wed, 26 Mar 2025 11:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743014541; x=1743619341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsiPA+wQiDjy+/qU9eR9YHSnTKpdRuheNLQ9Ls8sYTc=;
        b=JqqicsDbY6fcYq5vS0SauUOioRJb0A5+IdzUpYgQt7y9aLAxbeH8jDUlfuf3QtOcJu
         unAie76QDHkvr+70lcEM2nvmW+bzG8+daWoG5DpPht0R2rxHGqkfUocIwn/v9pz5clQQ
         rNYLHfrvxCm1+G1gc6pmu4MHngWlQioeTupdzEQjAhKkPqD3IjavpXAVX8IflP0tQ/8D
         XNOxE/ggNNzLJimN30i8kCLDDECm2tMuz5Gmqr6SfJIHnS3uRh6m1RmM6byco+DXg8ZS
         AhK9FkvjTtR0tkS2XYhPqbkvodXz041MYyDp366H7oqtuKQkB33B+HqD3Eo/jCIrbbbI
         92TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743014541; x=1743619341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsiPA+wQiDjy+/qU9eR9YHSnTKpdRuheNLQ9Ls8sYTc=;
        b=Sd+oOYGgnqMQkBGo7m6su+VPdopQk0d1QoA1PWBrYl/hE1pipKe5DjhuUFwQiiCbO4
         OvKEPHpfeGN6pRoT/S6y5+xmPjlWpvs6QMZhg2ohTtz2o1KMPjeCKIMCP4u6jRMUB+tb
         Gljyzww5vwK0ql6YFIx1p0tigxdFFX87TI5qrX1n6ip1dvC9ZIG414wLBlaQivlaUJtY
         FnzsvF8f/LXiArTcj2TdI+nThcY+a0WpapJholwtHfJJunVqQxowF8mIsKMTBltMvBXu
         qYoYcX7lD6PYKq2YoqT+U6aEeNvPe+dWl7132mSMY+38jloya07Yyfdq5TsJyYMGYKv7
         9WbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjhKaansyV4AsNebIDjWmRZ5KcY3BL0GlMKh9IiV+kjKO0XeHkKBSypCarBjGWdOSGITGjDEna0LhIIrq8@vger.kernel.org, AJvYcCWGxcasJo/IClsY8kkb522tGSn/yypYclNKfW8VAwRwXzOeT9XZi2OFEWM0WvyNH6ffQf4MYRCP@vger.kernel.org, AJvYcCXIng3Sa1kY0oN5RzzbyW7K11jXtdQZvBE+68C+fpDfiP9EfT4nSwXf/iG3PGiWiIeY7eX9r3vK6l50BIqN2Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlexyx0YnYYBmy+kgmSY1Jl5nAZiahpNcMXBwKK6KKLTGENrX8
	ZCUm27Ylbd8Lf5QjLZKMTUQo8doNzCa+JpcY5V+pO1gB2dKOchY6JS9Kmkq/pi+b5k+OgfTot2X
	x+2g4++Mxh3uADnbRfrzinjZkLfM=
X-Gm-Gg: ASbGncv5lLaGu7Y5EhFJSOOOUiuvEfcj1whT7liWfPJkxjHKZghjhKawn5/bVX6sGWG
	ewmysAS90WIn7WouAAXHO4GocC98yeyWvKuAI7Eu5Vc2WtsVn7misEpOhzj8oQfWzn2ms3P55YE
	VlWq/OVOyH7mESxxCyGPhPhNxnXOgagut0EsYl
X-Google-Smtp-Source: AGHT+IHvjBEb8u3bGux3ahHtVwunzcocu6dQwS2Xse9Cp8eI4Z66HuwdqhCdzBpOe4XmdyMVe7tLDyY+cjoIXRJFZBM=
X-Received: by 2002:a17:907:3fa3:b0:abf:6ebf:5500 with SMTP id
 a640c23a62f3a-ac6faeb7134mr50473666b.16.1743014540877; Wed, 26 Mar 2025
 11:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
 <20250326-string-add-wcslen-for-llvm-opt-v2-2-d864ab2cbfe4@kernel.org> <CAHp75Vd_mJggRRLfziWUf0tgr3K125uVBNh9VdSo9LHVJz2r_w@mail.gmail.com>
In-Reply-To: <CAHp75Vd_mJggRRLfziWUf0tgr3K125uVBNh9VdSo9LHVJz2r_w@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Mar 2025 20:41:44 +0200
X-Gm-Features: AQ5f1JqGF7dttWsEgjPhabIJU0Qow2xz-VT0UfD-t8uVq_PkVNBOsCT8C5GAZHk
Message-ID: <CAHp75VdQv=0wvgMDGNoXojALWh2B-92gjkO7zrv=d42ocamM4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/string.c: Add wcslen()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 8:39=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Mar 26, 2025 at 7:19=E2=80=AFPM Nathan Chancellor <nathan@kernel.=
org> wrote:

...

> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -7,6 +7,7 @@
> >  #include <linux/cleanup.h>     /* for DEFINE_FREE() */
> >  #include <linux/compiler.h>    /* for inline */
> >  #include <linux/types.h>       /* for size_t */
>
> > +#include <linux/nls_types.h>   /* for wchar_t */
>
> I know it's not ordered, but can we at least not make it worse, i.e.
> squeeze this to be after the compiler.h? Or even somewhere after below
> the err*.h? Whatever gives a better (sparsely) ordered overall
> result...

I just checked, and the only unordered piece is those two: types +
stddef right now, and if you move nls_types.h after errno.h it will
keep the status quo.

> >  #include <linux/stddef.h>      /* for NULL */
> >  #include <linux/err.h>         /* for ERR_PTR() */

--=20
With Best Regards,
Andy Shevchenko

