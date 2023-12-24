Return-Path: <stable+bounces-8427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D036581DC4B
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 21:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D9B1C21271
	for <lists+stable@lfdr.de>; Sun, 24 Dec 2023 20:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F0CDF57;
	Sun, 24 Dec 2023 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WBiU3PqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC565DDB6
	for <stable@vger.kernel.org>; Sun, 24 Dec 2023 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4b71f735969so361971e0c.2
        for <stable@vger.kernel.org>; Sun, 24 Dec 2023 12:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703448597; x=1704053397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwa4i2sQcNHaHPebPXB7JmpfvXbtVVdhZXHxe6sJ2Hg=;
        b=WBiU3PqA4kSgs4Jgu7ud73YLfg6JpcE+TjZWk1JLra7NEKy8Sh634DouirgB7vioPf
         UOGFWhg1/9VaRBDZ7GjKvdmWdiFSZKwiCZnPa/jsfNP/ZoLdqGtHTNbA9I6dVsM6AclD
         8Lx7zOcDFcu9S5KqtF9Zj8Y8SLaE2pe7VWS2+53NQJhlpkYd/25UBUf2DHfevt/raA+Y
         wJYI5bIbhulQjPGWohGZNHxamODmiyPb1y5Kd3Ynja7gYbm3/qJDlCl3VqEfoswRK69O
         TwvdV3avFG9JqIkV6i3NxLmyrg6LcAN5ImBttqf/MC/ESxkOV2JpiNo6+5mPl4xbrYdE
         NsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703448597; x=1704053397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wwa4i2sQcNHaHPebPXB7JmpfvXbtVVdhZXHxe6sJ2Hg=;
        b=DlN32x3xC6t1E6ZevVM/Ylt0mnn147O7Cqv6dyRXrEUHaUHlb2AlCcJkr4b938m8pu
         dhLBj+fTIYAg7UZzdIOKVCwSC8Iz25yhVNw5uL1DlG4AU2OMfm2hHZZ5pUKrXiuZkwP1
         NvnWXQmrbW8HKIy/bp17b6P94ohTCQI3vJ1Ays1IbEpAdENMIVlgO2Gn+A/wCANQWZhp
         hXySQX6jsPbKBOrOItC5N9SdSVMqKJ7ByZAVjYH0+tzjsdF/wAHJiywDqgnXxMLAi/sO
         VsNSgpzJG28C27GY46u/8RrSVXqtLVu9UnNhm0Cm7Z51JCcFQw+x7oa69gOWWIEhTV2L
         Mjdw==
X-Gm-Message-State: AOJu0YwqCoBMOHYqPfz+fOdZP+pmsKIV4omPIbFNINcJiASLpzwWvT4D
	JhhWzYbOzIEXG4eLCEVtQruH91Ls7ARkxUCuB9gM2wy+itkC
X-Google-Smtp-Source: AGHT+IGauJFx9VUqFigiARR83mRm8QOMsq0OQC9u9Mv8DCQsBXCXvbj6mjeB+wom/UI6tOGYn6anKpU3EOHGDTbp31M=
X-Received: by 2002:a05:6102:1501:b0:467:432:4ec0 with SMTP id
 f1-20020a056102150100b0046704324ec0mr28150vsv.54.1703448596766; Sun, 24 Dec
 2023 12:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
 <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com>
 <20231223153411.GB901@quark.localdomain> <CAHC9VhRV9WN_pQgQUvkz7wb_oHO86JRV5r7twG6ropoJaR3Ujw@mail.gmail.com>
In-Reply-To: <CAHC9VhRV9WN_pQgQUvkz7wb_oHO86JRV5r7twG6ropoJaR3Ujw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 24 Dec 2023 15:09:45 -0500
Message-ID: <CAHC9VhRgw+xphjO+vBUuf45DJMTau-PzRY_ZxqWxpg-K0u+pDA@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alfred Piccioni <alpic@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 3:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Sat, Dec 23, 2023 at 10:34=E2=80=AFAM Eric Biggers <ebiggers@kernel.or=
g> wrote:
> > On Fri, Dec 22, 2023 at 08:23:26PM -0500, Paul Moore wrote:
> > > Is it considered valid for a native 64-bit task to use 32-bit
> > > FS_IO32_XXX flags?
> >
> > No, that's not valid.
>
> Excellent, thank you.
>
> > > If not, do we want to remove the FS_IO32_XXX flag
> > > checks in selinux_file_ioctl()?
> >
> > I don't see any such flag checks in selinux_file_ioctl().
>
> Neither do I ... I'm not sure what I was looking at when I made that
> comment, I'm going to chalk that up to a bit of holiday fog.  Sorry
> for the noise.

Ah ha, I think I found the problem - the tools I use to pull in
patches for review seemed to have grabbed an old version of the patch
that *did* as the 32-bit ioctl commands to selinux_file_ioctl().

https://lore.kernel.org/selinux/20230906102557.3432236-1-alpic@google.com/

--=20
paul-moore.com

