Return-Path: <stable+bounces-87698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB829A9E3B
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B31B24BD3
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9F19C560;
	Tue, 22 Oct 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUUC9jj0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC219C54E;
	Tue, 22 Oct 2024 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588581; cv=none; b=OS5dbY4Na0Y1SN3Fa6ko8HH1EGfPLkxtOtUkltm7yW8TsiuuPPT6DKArPuVfQgmumS1GqEohfrLWEFwYrVs+yyo7YZhizg1THDaYS06vLRwrytjNWBa8oRemeu9jKkpkGuOgfGPIBSXmWQY2LTF7o9OTXtC6Y4TnOoEvtqgwGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588581; c=relaxed/simple;
	bh=f6tcasghV506QA3EP3+wDP8QUMsnpvEhlIKLb9DBfk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gn5M0BHj5mfZa8lNcieSI9Er3uOJGFiDu3Dh8nAr+nPu3VNEG7dLxGAH3L2V3ResTY59cyfABhTDguJLhMxTsGE2rzGrp8kLvFjE6qy4ekfnSEwVOrq64ro5ePkxMmEn3GklK3NWwrMsUHue8I2KRpSh6bA48Lqp1EcgV1P/Hn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUUC9jj0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso795644366b.3;
        Tue, 22 Oct 2024 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729588579; x=1730193379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6tcasghV506QA3EP3+wDP8QUMsnpvEhlIKLb9DBfk0=;
        b=mUUC9jj0a82H5U+TaxHIBEGqT7C91SZm76tDdHIpyO7hxVvOL6FtXOyiD2DqpRKLD6
         T530+KLxcqUe/GmbLypgBOPB4gxCg0yrzd0oAdsfdF+6w8F9db6vkqbxpyeP5Y3PUFLV
         UgSE+y29oUI/jnflwbM0a2nRHmvEhQ0RTM6SaGQE2nIfiV2xfoI7g0s/P6yCCz1tJqbt
         HbG0fneZozEjdgisu/0ZUEcGm56lRhXIbZ5X6RIhkoM8pUtnZ5OB0/UT42XoQuvtkDOu
         sooAGm0giCxvhStY8xlI930HjHccrxqFEfcbQol75hWLQ+jkRqplqkgFKHHaoYYN8FOr
         lcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588579; x=1730193379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6tcasghV506QA3EP3+wDP8QUMsnpvEhlIKLb9DBfk0=;
        b=AiYhjanMHQrAG0qatVWVPndpBSJzzrjL/qrlmQqGWar1Tvy2Zh+JbJ4PdlsI6EDCUA
         C2uPwF7usBSxtDz0iOtNny36woW/tTywZL9KXCFugXEwzlYHiuYQrsxKdr2eUMhK8BIT
         6mWvUa1gJb0S+QBuUlmkOQd1NNooRPUKe3FG4Vw9rEnaVAsOYi3qmPq6eKm/qCrD90N9
         OsuUvNYG16SobKwQ2z+hSq2607Hw6aQ+gw2vP5oqCb0i/fv4+I/gWkLK25dtJd6E9ACL
         EipifEAofneQxn5jSS+KKkF9WYxGzl3DeoScyTj7tp1I9toy2nBJQdbNmpP7m7VeHWNT
         oCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPY0cFW5ZeVZDAULDCsnsKOtgMHpa3sj+bMaGa1NjW6sTjA0THs5dKnMDeO21IYN5Y6ZSqZGP7o7/8Ft/d@vger.kernel.org, AJvYcCUiLpURSBQLzX6HyYvhJCZVAuOw4veXZGjMSypdl5DzvFqZZVzwHHX9B7D7uL2R9H7SfKH4XPo4@vger.kernel.org, AJvYcCW8azuZ1yOxa2Eij5uVLTNRk+GEBuTNoiWqfnZZpQsNu63e8wHN/uECdpL2qmbWxQPscEsmhWqik1ieEUd/1vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznW7mcyZ094cFwukwcNoTJHdp7Nftc4ab9KPgi36RzuB3Yptqi
	6cTtp9AvT8yp46XVmNc4rd+rmZCEFmZ8f7efce6yUpSKZ5nRmmiBNLtiisx1Kj3Ph1rQpiyiN7r
	ZMJ2Wlu/bcs29K1pUIh6czGPC8bk=
X-Google-Smtp-Source: AGHT+IEhXe5CPIvbNpaim7lA4Zyy9KDuP3cdxfKH+mUftW9Rv792YEOlvCA2BW1HJfaZHWYsrVkxZi5y7tPw7gAWhnI=
X-Received: by 2002:a17:906:f594:b0:a86:94e2:2a47 with SMTP id
 a640c23a62f3a-a9a69a79c72mr1650018466b.15.1729588578301; Tue, 22 Oct 2024
 02:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021100421.41734-1-brgl@bgdev.pl> <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
In-Reply-To: <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 Oct 2024 12:15:41 +0300
Message-ID: <CAHp75Ve1WUKYmv6sfGZ6amujs=C7MnxauLM+C2MeW8vxBV1NfQ@mail.gmail.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:15=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 21. 10. 24, 12:04, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The output of ".%03u" with the unsigned int in range [0, 4294966295] ma=
y
> > get truncated if the target buffer is not 12 bytes.
>
> Perhaps, if you elaborate on how 'remainder' can become > 999?

The problem here that we have a two-way road: on one hand we ought to
fix the bugs in the kernel, on the other hand the compiler warnings
(even false positives) better to be fixed as we don't know which
compiler gets it fixed, but now we have a problem with building with
`make W=3D1` for the default configurations (it prevents build due to
compilation errors), so this change is definitely is an improvement.

--=20
With Best Regards,
Andy Shevchenko

