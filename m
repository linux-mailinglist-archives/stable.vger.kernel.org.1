Return-Path: <stable+bounces-91714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0039BF5E5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 19:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32283B227E8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EFF20966E;
	Wed,  6 Nov 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAvKMxRR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177F208236
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919556; cv=none; b=BKEND9sj1EWa9vJaw3vSNA7+7FV9KRJILFByq+wQ3Z5h17zBU9rdvqlh3y+ZbgVnadsIkciI+s6io80NLxqeLzdlBQbi1t8Cmw14zZwkVNNvEZMQw96FWVNhRNKzMDuJbB2Az2OAhfGDbQQULNpXgJ/Ce/12OshEmJZBU0ej59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919556; c=relaxed/simple;
	bh=fPkbnEtILsrm7fBv+gVTn8aiRWCGWwF4GT3/vtF1utc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5EMOybWzJQqOW4hOnuUjHLD0GFvTElHndPONDOQLMCckUt5pJKXdYIZpygkkh1bwT5eFsyN46J5hG1ig2vaaNIR68zJ53Zp+8k3RRv0YkKbCrcqvsVdjVElD0H+pnVvTRerDX8hC+Un6xtFZDw6owEXvgnZzx713dlHX0Jg4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAvKMxRR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2da8529e1so16207a91.1
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 10:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730919554; x=1731524354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfyYHlZiiHlOJ55Ga/XIjofB2OSEpcClJAHmvQ8Zg1s=;
        b=lAvKMxRRqA5gyK7Xe7gECuW6mqvvmm0u3p6zib+UtGx6c2h4kw3oUfvjhn/a1V4GL1
         RP7o4eJcTyZPsdYXlDiKIzwx3HIK+ASIclzybzbn8KojX2HJyQNDdh79kC7OFJXA3tpe
         giETYw9pv1XneRMBfDoxx7IRO4czZovP6CbFmeEv36aDDA8DGCJGKexJ4i2Pwdxa9vuC
         dqbWB5I21+XwVNJ5M1V7M7R0+d3p26tcwpGfUoE8VctF+iTPWmY3e/KULnnxvi91LCD+
         ++qN5R1HBwNYGxG5iWXDDkihhC+PZouv+f4/lQXXCDWNuTMqnBiiuCN1uX+dg9RIoenD
         sz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919554; x=1731524354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfyYHlZiiHlOJ55Ga/XIjofB2OSEpcClJAHmvQ8Zg1s=;
        b=bdQYn5zltuc70v+J0MVSmS8+WU8bChNUXURnzW4SzvZ0mzaLNVRXDa4HyFV1+gGrHt
         5omGsuQgvzK/HbQP2nh3og5ZoKgOtOnh5n3Uw65f3aJQLIY1HWGhSmddNr7yCWHJl469
         olel27JqoIt9d52zRWruADDhM0D29UuFxPnD2RKblgiZ7UfH+NTwdRbFWHAsE0alwt6p
         GqmwwI3suWSCjzsIYBNUBdkLGL3zhqdhp0E0xLJlAbtA0zXxTQBO4W6Q1LO85CWxGA28
         /zQp2rTVs9kQywnMgWW1juA9cL1tb2c0Ay4CYvl3v9PR/lDBjbju0Kp7vpZtf4x5jhSI
         YPlA==
X-Gm-Message-State: AOJu0Ywpe55QPogsQNOywTsX7yFl2d7rjkzZ7AChvPQC5izE44KW1e+c
	zjo+fKp/D3AA9zO76WN9Dl91YRdEvaIkVkPPzeCiFWULUF9GvXBre8skq7byaShERcuTfLfsT9t
	7ajxScLYgTtc89DBBzHuNdVkC73M=
X-Google-Smtp-Source: AGHT+IFv/9wDlQ5Gely1DQOECBzo8gp5c3KiyzJWairSWFXE0bi3KYn8VYndGnT2orM2I8hGeGgB5IeH+L8Zd7su7Vk=
X-Received: by 2002:a17:90b:1a90:b0:2e2:c04b:da94 with SMTP id
 98e67ed59e1d1-2e9a4b246c9mr178569a91.5.1730919554594; Wed, 06 Nov 2024
 10:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120303.135636370@linuxfoundation.org> <20241106120305.369505633@linuxfoundation.org>
In-Reply-To: <20241106120305.369505633@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 6 Nov 2024 19:59:02 +0100
Message-ID: <CANiq72=a-qCB++wQjx9bZKdHfNg3Lj-1HMmjf1usdHSzAbTYZg@mail.gmail.com>
Subject: Re: [PATCH 5.10 079/110] compiler-gcc: remove attribute support check
 for `__no_sanitize_address__`
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Li <ashimida@linux.alibaba.com>, Kees Cook <keescook@chromium.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Marco Elver <elver@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 1:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The attribute was added in GCC 4.8, while the minimum GCC version
> supported by the kernel is GCC 5.1.
>
> Therefore, remove the check.

This is fine for 6.1 in the other thread, but for 5.10 here, it may
not be immediately obvious it is: GCC 5.1 is not the minimum there,
but 4.9, since these two are in e.g. v5.10.228:

    0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
    6ec4476ac825 ("Raise gcc version requirement to 4.9")

So the patch should still be good to apply, but just noting that down.

Thanks!

Cheers,
Miguel

