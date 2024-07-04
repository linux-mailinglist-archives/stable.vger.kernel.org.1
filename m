Return-Path: <stable+bounces-58081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50080927B96
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 19:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CD11F255AC
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D2A1B3742;
	Thu,  4 Jul 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gx5oiL5b"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20381B0139
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112897; cv=none; b=GPXcOxIDPH71kQp0oHbPqkD8uVzmEU+Y7ldwO7G54Wypl6aeYd0jHxuCUFieQzTbS5B9FZLMyahOUg72MYJYh9Rs1ByINGBAbYDz9NFyvszS2559IwMqYURT8Bqns2Y+Eyqd0Dzugi2ebnalvT/cyDCpJOrNAdg6dRBYGIXXFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112897; c=relaxed/simple;
	bh=QguQgLZBBttmrru34w9QMLWo5wJFt+WRZM0wpZpr6UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/z//t3S/Wyn2oTNhA8fg88xmCtb0YoxmR4/+qkaxuetSodIx93azTBEyKjtymCs87Vt5rFZOXNt7a1TKpZiOhDrEYvk2c+/LrcarMRjlI+aWg6RcCBcWf2iNXt6rF0vI/vEETF66jH0Z4PbLhSDxXur2fTpe8JRKgkE7Pf9lXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gx5oiL5b; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so11647151fa.2
        for <stable@vger.kernel.org>; Thu, 04 Jul 2024 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720112893; x=1720717693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UlrKQa45wt6qlKqqrZr7W5l7lANNYZzO1+mSmOq7i9c=;
        b=gx5oiL5bsb/6Fpg5sY0pBKn4MJJVD0R+ICfKDUkbAcQNL79nHbSEAEk6WPLvISjj/O
         JfsCbm6ZrSSup1K7bylzSmV3IK/uCF+2Fplf3dolGlQ20uQgNH4SoyLOdW8XPQbiCllJ
         xAUZvMT1ntAIhvWyNuRrDNUt7/JUOFYGf6jto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112893; x=1720717693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlrKQa45wt6qlKqqrZr7W5l7lANNYZzO1+mSmOq7i9c=;
        b=j7V0RK8Ug5A+c3hOxbWM+1OP9doXTFKeORB/ddVtdIKKyhSEr6+2T55Pq6uJXeFCoS
         XcoGrRioTRT2omR18to2fLKC4T3BaXMHqord5OpTz+pA4dJHn1R7n+xgKgPqlLg8P/vK
         fT/qizP5Mjn6IPbWIoqHyiGR4dMDr3BwMJSBtt+OGq+9Qh2I9XcmsBsR6FdgcHX7HvXw
         cxn7qbZA7ClDP4Go54gXid8rmDJf1RUc440TE4Z77Uoh3JXRtG7Un4k4it0FNjjHp409
         x8adAog64IhLGrBoXKlhsyrooinuB9dTwdgATXRxU0FiHUmMwJ0CPCvBXyyMZyR+x0yW
         jzPw==
X-Forwarded-Encrypted: i=1; AJvYcCWNxcyHxg3jVYk8OBFov1R1bPY5CQAJbE+n9oz9Raf/6MWLG0xEYeZl9hr/A8M+I/c2c0A9JJYU2mfoGaCqz0I2rB7HwQLo
X-Gm-Message-State: AOJu0Yyv3M8b96zmI6W0gtHNRQ74X4Ytq5JPF2hf/ZVuovfTIQ8EM9qY
	PF0J/e9WIaOFYyz3rI4uolJvuUVsOj3ALlTaZkTHEjwk1YEwWK3Gl/qfvXn0c5GtxgIK5EPWRWQ
	ezhFddw==
X-Google-Smtp-Source: AGHT+IEgai4CTMF4ZMhrOzjJj60mOQlcevXeclLlgJE22pN/YNhxJINV9XY118+2mifimsSzNFMblQ==
X-Received: by 2002:a2e:2205:0:b0:2ec:165a:224d with SMTP id 38308e7fff4ca-2ee8ee0e7a1mr19110481fa.38.1720112893664;
        Thu, 04 Jul 2024 10:08:13 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee81c79a73sm5963971fa.45.2024.07.04.10.08.12
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso1204074e87.2
        for <stable@vger.kernel.org>; Thu, 04 Jul 2024 10:08:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJkQ3Z4D910R2u07QpK48ZW5YVDcAeZH48n9NbjCHcifqu66d6OXRH9WeDAH1FvSUCyTkgVY30MRrKqNTwf5Hna32Id3iK
X-Received: by 2002:a05:6512:204:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52ea0632781mr2063767e87.36.1720112891664; Thu, 04 Jul 2024
 10:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703182453.1580888-1-jarkko@kernel.org> <20240703182453.1580888-3-jarkko@kernel.org>
 <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
In-Reply-To: <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 10:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
Message-ID: <CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tpm: Address !chip->auth in tpm_buf_append_name()
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org, 
	Stefan Berger <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 13:11, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> if (__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth))

Augh. Please don't do this.

That "__and()" thing may work, but it's entirely accidental that it does.

It's designed for config options _only_, and the fact that it then
happens to work for "first argument is config option, second argument
is C conditional".

The comment says that it's implementing "&&" using preprocessor
expansion only, but it's a *really* limited form of it. The arguments
are *not* arbitrary.

So no. Don't do this.

Just create a helper inline like

    static inline struct tpm2_auth *chip_auth(struct tpm_chip *chip)
    {
    #ifdef CONFIG_TCG_TPM2_HMAC
        return chip->auth;
    #else
        return NULL;
    #endif
    }

and if we really want to have some kind of automatic way of doing
this, we will *NOT* be using __and(), we'd do something like

        /* Return zero or 'value' depending on whether OPTION is
enabled or not */
        #define IF_ENABLED(option, value) __and(IS_ENABLED(option), value)

that actually would be documented and meaningful.

Not this internal random __and() implementation that is purely a
kconfig.h helper macro and SHOULD NOT be used anywhere else.

             Linus

