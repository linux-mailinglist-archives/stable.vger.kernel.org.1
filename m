Return-Path: <stable+bounces-99079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17329E6FD7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8171B28258D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5AD207670;
	Fri,  6 Dec 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LacXbEam"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CC02E859;
	Fri,  6 Dec 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494210; cv=none; b=R8JwBC8jsVhhL1DFTqBW+6jRL6UZ6PRXtkqMmAHRCuHqpeaU6YVhIYGXZ4CkQjzKyuAKP1SfYP7gL06ojpGzHe0Qm5x9uw2fYnO7a3s9RMWBtckoMcajTQkgL/sog1SzyKusAMLVMgiQv42hRc4p8nMZAN2KajOyE3hd4AH6qUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494210; c=relaxed/simple;
	bh=8PFPN7DbZZGHpYlhMxeWbMPrpnXKX3Dkt/Q2/+aIyaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbyLZuDRForZx60oHBg419adGb/eouI6/BGL/1ZY4/fuM8f6IN2THbG3WLMiJHUSAqVJ7W+IVIc9rk0xo608VkfK5Ayw5CPeVW1ItVvn2L4/rW/YJZVeAYB+jujvFLUM2eJpLkJYOZZL6ksnihwBjCj9sU342DuhNfPREjP2nGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LacXbEam; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so1946759e87.3;
        Fri, 06 Dec 2024 06:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733494207; x=1734099007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ9IUcbryk0YazN7Sa5TOtgGdDNEInD45SiDVANUoqs=;
        b=LacXbEamzHiOouoomoi6B/EyG1v2tdcp3UaFR46QA7a4tSiA5LpDIeiriFwNrEW9oO
         8Plag1/sNtshuSfhg8Tvk5itIlWc1oR1Wqt0xJ+dhrAC+yLQ9DzJTsYxjiMDmAeePtZw
         9vhpOyeYdkbVeI4fYsVrxPCxn1JPvI8Sfn0i5atOVzwKbTR85XDXVSbPkhdFkFdlpU6w
         uhUKBKn5IjVyJrWYIkcKDE8UN5fYW5nullBxk9p9oTq+Eix8mvFby5nSBPJqG4X9jfQ3
         ivZv+PaaJEo5ZEOnYyZRnSzoRalDBJbPGQ3my397eTmC4N0FojL4p1SGGmKCWM9tdwFY
         lYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733494207; x=1734099007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJ9IUcbryk0YazN7Sa5TOtgGdDNEInD45SiDVANUoqs=;
        b=ZytnZ1MGUzroR7rG4ZnoDeBu2Vzj3HVyU2s6OJ/q+RWntipwzV0OT/cFVPSLWnSVkg
         tIk5QfPklaF6VQFNQkrgbTGXjZai1mDhtzn1+nehJURCx9DwpEPiVx5JmUl2F4m0Ufta
         1Wm/STQFwZvCtKhhamP1Y+YsgOlEM3P43Uh/7kXkQEWUfqxIasLagDDaCGmUApItYtgm
         DjxSryz8/sH8kfRbfYW5Zsbmms115+riGycHg3wWf0hBx1rePaij96iSGLnPZWoIwuuc
         XkAWdEnFm8GwS1VsnsAtMiqsrcuQ4DvOSg5yy+NJjvvdeRmjDRn4gXMGhNRpYF6zR/5S
         9qhw==
X-Forwarded-Encrypted: i=1; AJvYcCV76x6c6HJEns7Wdeye5W9LtHJB3cb5W0Dqct8NZLQqTLxJ99dANUHyLpldHndQ5n+leBbNtdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjW59x++aK9UXYvDfhBE9VnrRsoJwiUfCrz0BljwgawfZffxfX
	rJdrsXfCF9Hf3C6wmeIzkpA9hHxRvGgnG1dudHP60m1bvcxaAxcK3eREPwAF+AEhFfx3E3VpHTc
	RdkJlrc7WaWNC7u3KmgMeWpN/swg2
X-Gm-Gg: ASbGncuFDssWLNlNO+0trdc4e5D10u9awVXQklPu6cbaicAjcYRY5v1wAa5lDPNv531
	gX3HrYtEMnUpe+T62KqJS1kw9YDMlfx+v9RMUrlsWQD9JoQ==
X-Google-Smtp-Source: AGHT+IFmPgaxVCncnxSpgGFH2NGYgVn6CI4Sy8CIqD74igkDri8YqGT7RQpReqsWcGBJ+i/X88yERPyj1yI/64Yzmfs=
X-Received: by 2002:a05:6512:e88:b0:53e:12f2:68f7 with SMTP id
 2adb3069b0e04-53e2c2b1a6amr767751e87.1.1733494206924; Fri, 06 Dec 2024
 06:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-2-brgerst@gmail.com>
 <20241206115154.GA32491@redhat.com>
In-Reply-To: <20241206115154.GA32491@redhat.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 6 Dec 2024 09:09:55 -0500
Message-ID: <CAMzpN2g8eenLASqXA36LwP=Zr+8Z1cO7Cpz0ijiUdOr_+7G-3A@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] x86/stackprotector: Work around strict Clang TLS
 symbol requirements
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
	stable@vger.kernel.org, Fangrui Song <i@maskray.me>, 
	Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 6:52=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 11/05, Brian Gerst wrote:
> >
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -468,6 +468,9 @@ SECTIONS
> >  . =3D ASSERT((_end - LOAD_OFFSET <=3D KERNEL_IMAGE_SIZE),
> >          "kernel image bigger than KERNEL_IMAGE_SIZE");
> >
> > +/* needed for Clang - see arch/x86/entry/entry.S */
> > +PROVIDE(__ref_stack_chk_guard =3D __stack_chk_guard);
>
> Don't we need the simple fix below?
>
> without this patch I can't build the kernel with CONFIG_STACKPROTECTOR=3D=
n.
>
> Oleg.
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index fab3ac9a4574..2ff48645bab9 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -472,8 +472,10 @@ SECTIONS
>  . =3D ASSERT((_end - LOAD_OFFSET <=3D KERNEL_IMAGE_SIZE),
>            "kernel image bigger than KERNEL_IMAGE_SIZE");
>
> +#ifdef CONFIG_STACKPROTECTOR
>  /* needed for Clang - see arch/x86/entry/entry.S */
>  PROVIDE(__ref_stack_chk_guard =3D __stack_chk_guard);
> +#endif
>
>  #ifdef CONFIG_X86_64
>  /*

Which compiler are you using?  It builds fine with GCC 14 and clang 18.


Brian Gerst

