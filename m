Return-Path: <stable+bounces-139423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA1AA6869
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 03:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566CE1707E3
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 01:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0991413C81B;
	Fri,  2 May 2025 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SPprT+1n"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8144C63
	for <stable@vger.kernel.org>; Fri,  2 May 2025 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746149720; cv=none; b=Kq6pyM1PJoK19Yj+dGqRUdgEhDY1dvg7FS0v3cLmXkkL3YJndVb/9T2L/Mil4W2k5ppmUk7XxT4PQGay4g639hesOYWgGx1j4fptnFQJIUwcTnDJ12l2a/I0YWMTPFdFl5ZmNh0BHGeVl/dfwZqtyZrhcE81Fj3EvuedLG3MUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746149720; c=relaxed/simple;
	bh=0As8xmw9EhCI8l9UThvyG5mZVKiCmUiyNh+yysJrxBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHQ7v1okrE+V9CnDU7yqRbgfOoiCMCuAuNcUzWZxN33kTbPXZ0kReQ90GOaSeXKXJXvSheuBvEwmVy/VpMz9w0YKAtQ0nccg8pTQL8X4RfF/ugU6F9mgk0fnxHhZf3GXi2aLhWXNucZ5mtsIgN3e90cnWBh+2U44MiKCI0Sm0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SPprT+1n; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso2236628a12.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746149716; x=1746754516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=97MRcwlNgiaSiCPIOhEJ8niynAiuZuA+VUyMszsZ0b0=;
        b=SPprT+1nFQ67fCpBtccCG0ezIC35XPVenOv47cyWL9UlhZCiEimwZxGyirEa1bosTv
         HopzMfWDPB6cRJF4iA0xDZmbTQJxBVwhDCR2i4KNNGmC2ubug6/2gzVBy6hosWrFnSTz
         Cp0Ieax/SA3Uzs648PAVJeVcM2HB2B5TGAXhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746149716; x=1746754516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97MRcwlNgiaSiCPIOhEJ8niynAiuZuA+VUyMszsZ0b0=;
        b=a4iwpUWaVcTbUnDl+N7v9YiHw4Vwds0Z7iZK961qHQgdwPl6aVWqGHfWMPbQeWUMei
         j7nM0c7w/Y/4B+1xl4vlKgiugHrNMMreB9KAuKQ5vmNfRR9JmzoYlwvJD3AnpmHZkUWc
         pQmqZP7+TpUziehFY1Ha7TeXEYb6gZxUrxGnAOFXNSjRWUZuvAZTB4FGkSFPfY5C4786
         dqfQWNc5hztm/yx7JCOvTVRAHcHbEQKPjfdc5zkxEZieHVKbl4sPH3rsLqeYtezrRl4c
         4pBd6l+GBNbYwbvoftU8mfYfa7BlV+n/E1Kh1XPCeQTyuiK+UgJj3meFKC7cwWFSxHBl
         SCjw==
X-Forwarded-Encrypted: i=1; AJvYcCUARTysfmGppKe5AcGMngpO5ZBfW+G0sLOEykvfuMvFOjaf8E+wBIjdWRxYcxMGx+3xHrtGNbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxET79VoGr4etAqvJNLyh03CkUnEEoj5fktVthoERrLn5huIwMd
	1fY7CXjtvuXHH3PnYpGgHSbWroewskvKx7YKeuBzLDFdq70TNSW1HcbjEdkiDs8Yja5AifrjXWV
	EkH8=
X-Gm-Gg: ASbGnctPI+RTiNToIqcKm9vK9Ya/0peoOpLVkkT8A4V9lafT1WDecaqT/ehQEu1qTIa
	2fZ8xLj1qP1RK2nh/8mYB99Y4OuUr98bL1Xz++ltemnzLHdjTcek23nd7njcIZsHqQ24gnjD5hu
	JP2a09qXfs8xtk3FHnrIi8QdKjkqevM8nZdQH2OnxViJSAzLmitiVel9rvKdoKzaOFJa0P8wC0h
	bN9mawfUdOr1p2JrSrIclVVWb5zoG7wp2FfXRkCn0SeudedMPNkkVL5LJ7roDTvsFMhI7Sj4pA+
	3GGj53PAhcOnWwWNcFTUq5q6B4F26jNun77k+Ddm8Slok7lDSxOhTpsfBDDY3D98F8NdzLYhkUw
	ZZ0vcQZeNB+ArZG4=
X-Google-Smtp-Source: AGHT+IE3t2JBQUzR2i7/2Zw+m4QmPYwcW3+MUllNeZI7vTKcI8o+MbbzI9EIQZdz2OuXy79QVR8lnQ==
X-Received: by 2002:a05:6402:849:b0:5f6:f998:3c6e with SMTP id 4fb4d7f45d1cf-5fa78054ee0mr756920a12.18.1746149715951;
        Thu, 01 May 2025 18:35:15 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa7781bf6asm411698a12.44.2025.05.01.18.35.14
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 18:35:14 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso2236606a12.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 18:35:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoWvAxv38kGKQwVcBfAQs9Q3akC0TE6huOvyhnaLtrm5ngqS+uqMjBi/5twVgYiRyC/5yBvX4=@vger.kernel.org
X-Received: by 2002:a05:6402:3806:b0:5f4:35c4:a935 with SMTP id
 4fb4d7f45d1cf-5fa788ade3emr571279a12.21.1746149713941; Thu, 01 May 2025
 18:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-default-const-init-clang-v1-0-3d2c6c185dbb@kernel.org>
 <20250501-default-const-init-clang-v1-2-3d2c6c185dbb@kernel.org>
 <CAHk-=whL8rmneKbrXpccouEN1LYDtEX3L6xTr20rkn7O_XT4uw@mail.gmail.com> <20250502012449.GA1744689@ax162>
In-Reply-To: <20250502012449.GA1744689@ax162>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 May 2025 18:34:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif4eOpn3YaUXMKUhSrF1t-2ABasBiBRXR2Mxm059yXqQ@mail.gmail.com>
X-Gm-Features: ATxdqUH6AO9B4IM6TzOpfLne5kIG1EGNzVEfwRIWeNnmYRyNorzVe6ZE38sDwtI
Message-ID: <CAHk-=wif4eOpn3YaUXMKUhSrF1t-2ABasBiBRXR2Mxm059yXqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] include/linux/typecheck.h: Zero initialize dummy variables
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	stable@vger.kernel.org, Linux Kernel Functional Testing <lkft@linaro.org>, 
	Marcus Seyfarth <m.seyfarth@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 18:24, Nathan Chancellor <nathan@kernel.org> wrote:
>
> but '= {0}' appears to work: https://godbolt.org/z/x7eae5vex
>
> If using that instead upsets sparse still, then I can just abandon this
> change and update the other patch to disable -Wdefault-const-init-unsafe
> altogether (

The "= { 0 }" form makes sparse unhappy for a different reason:

       void *a = { 0 };

makes sparse (correctly) complain about the use of '0' for 'NULL'.

    warning: Using plain integer as NULL pointer

and gcc has also finally adopted that warning for braindamage:

    warning: zero as null pointer constant [-Wzero-as-null-pointer-constant]

although it's not on by default (and apparently we've never enabled it
for the kernel - although we really should).

sparse has complained about this since day one, because I personally
find the "plain 0 as NULL" to be a complete BS mistake in the language
(that came from avoiding a keyword, not from some "design" reason),
and while it took C++ people three decades to figure that out, in the
end they did indeed figure it out.

In case anybody wonders why '0' is so broken for NULL, think stdarg.

But also think "Christ people, it's fundamental type safety!!%^%!!"

           Linus

