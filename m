Return-Path: <stable+bounces-151948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B2AD136A
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376367A55CE
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFA81A0728;
	Sun,  8 Jun 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRPyAn5B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047A8633F;
	Sun,  8 Jun 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749401872; cv=none; b=sUEwYhKJG63LPBArR0pH83N2Swl9S8aMELE5QpkWdNVhSqMv/2CMRsVvqMaVxQBKhIgsxZVfhY0iRBgAjt/JMWb3xaTwakAVhTaQ6DKJk7Xszr0o2qQbvt4RumTGOVvcIrjlHNUseGm7w6Sq6IRzN1WYB1bJVApqFKHTO73jQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749401872; c=relaxed/simple;
	bh=V97iY1Sq/zaYk+CjyZO3kcrQTN6xQUok5+0Jb8EJswI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYO0t07hLOOhMm1uZgYlCj7KKbkINVMLnsUZBTHii723k1OkPp5Mx/MZef8GbTD6uvO0Hn9PLGxU6gmJSu6Hy4/Eoty4ENtDfk/mlkRfr5pJA/HgqCX2eX98+dfGM112mHPcNMfQ2biQuZKYA4HDoFmaRXyrKGIo4zVylYjdWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRPyAn5B; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31305ee3281so538316a91.0;
        Sun, 08 Jun 2025 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749401870; x=1750006670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V97iY1Sq/zaYk+CjyZO3kcrQTN6xQUok5+0Jb8EJswI=;
        b=cRPyAn5BCnDha5Xrg4JO42MZZot3XcEBqV9ZpQZcqz19yHhFGaAtnnRS6fa5SCu/0A
         u6wDIzgyZsSqYd0FekZAuwY8JZDgbE3hmbkOEPPTFRaJZYeMepKJCOhieQszbwnT7fll
         n8pMvwjYkFuiJulKSdNo7roOr6ROtrDMQt03U6vmOeO1Ekm1NGInIYlx5u3DU/NgPGbg
         jtT1FwzbJ6Y/bYcL39AsyF81JlXzIAHrwVBGxRobhQ/kPt0/5/XdMtiPkgeBxCnAZpPw
         eTwi4t45TNm5SvbKSyn5RX0EOQyMj8mkHgHgFqwpQXicApYjjg6jkkcys9p1c0P9N6US
         3sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749401870; x=1750006670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V97iY1Sq/zaYk+CjyZO3kcrQTN6xQUok5+0Jb8EJswI=;
        b=cJa+G3mGG13Fi5h1NlZB2gsnoHdWHWsjyqxRz5AKbMyvYPru3GvJwkBeK2LeXCvtmy
         HrNKc5G8E9gg239DJuykS55rrM3qYJQOi86rzUfYTKaX0hcqXYFWKHobQ1KOhq+9XR3w
         DdAQLG0J2d/LxsBRDrLcQ79MRgOQLr2b+5mL2vriNolYhIT1Oa6CKrP2FGjgSHbPPkC7
         s3pw4FB2gkyZO1xMWolTK3hVVD/TdwY/+vDy3PubD+/COZR8Ulj/mPvrFeOUXHzvJrOM
         jMwsX/F9Il1ytmldIyJhNEHeCe6syjgEuhHgoGldQM2XpfUAkQSK/EvrUfx+3LdTvBA/
         RqUg==
X-Forwarded-Encrypted: i=1; AJvYcCUpjrpjUlVtztmYldbI7rTFiPLqIJflfVjp/Edy3SY0dDD8GGihwxzRX2z7sSahIZDwit02VOEZNrYiMAUZ8Q==@vger.kernel.org, AJvYcCWXUI8Eg7NDXoxarZhD999JTqNQJ6BTFjb9OfcVkAhMx0RaKZrStZnej/t0O2wLNENSZZx4HH4S@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvhtq6UZL/IYmBk61MWuFveVlSTjnmtuD0FiGXFnpgfFBzesuu
	m1Vn0lAMt5bELgVrgmYkcIFSz7enDlYy/bgB/aUoiykYNg3kM49zeKMHbUU+CulWJZGEbOopPOh
	berWYvgzhDFpu9nBQQbHux+pATEmRHUY=
X-Gm-Gg: ASbGnctb24RfTcuEambF6LN8xQTCwnDqZZgZGrZnvUY9QT9W7wHXKuM1cdcWx6+yM3l
	4H8dnMa35pcCh1enqUUc5cveBGSgWsuTJ7szKfk2cScmQEBo01ItOPipnwYuOCuVp/95gHHXCyd
	77F43RYLs6Kn6/J4CBtpNdK/tWCETRTLzK
X-Google-Smtp-Source: AGHT+IEF2US5fJhPDCUr0zqu3y97vNhUhrFfv40wDL8whslXrtkv2lLuWp2e6TAgkQkr6IJlrkWA6WJB918dTFlaWe4=
X-Received: by 2002:a17:90b:3d04:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-3134e3fa0e4mr5065645a91.3.1749401870302; Sun, 08 Jun 2025
 09:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608125507.934032-1-sashal@kernel.org> <20250608125507.934032-3-sashal@kernel.org>
In-Reply-To: <20250608125507.934032-3-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 18:57:38 +0200
X-Gm-Features: AX0GCFv9TBDVmHG78YzkdTI0QzxeKMKORLyul7ZTok5DuZiL-KNBn7ier0GIHk8
Message-ID: <CANiq72kkWkgzHAmBbfqj5cVBg7M-ubt5BW1UAXu1ns-XbUdinQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.12 03/10] rust: module: place cleanup_module()
 in .exit.text section
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com, lossin@kernel.org, 
	aliceryhl@google.com, gary@garyguo.net, dakr@kernel.org, boqun.feng@gmail.com, 
	tamird@gmail.com, igor.korotin.linux@gmail.com, walmeida@microsoft.com, 
	anisse@astier.eu, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 2:55=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> **YES**

Same as: https://lore.kernel.org/rust-for-linux/CANiq72kEoavu3UOxBxjYx3XwnO=
StPkUmVaeKRrLSRgghar3L5w@mail.gmail.com/

Cheers,
Miguel

