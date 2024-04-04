Return-Path: <stable+bounces-35941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE7898B0C
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 17:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060EC1C21A10
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047884FDF;
	Thu,  4 Apr 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3KbwrrJQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C182C189
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244327; cv=none; b=LnE3/q1+whx7fncnRPmVKnrP4poE51eYAX8Pb9J4kFzwTmsgASI3YAQ+GU/5BffCOZvj3FSt1X4bYoOuTQMRc+iWJ4wuGNVIhBf0Z84uDLDCY6axuqQouuEmt/pBMnCA0urzOIRjT0EqQAzf0kz1yoXdiBiZYXX9Blwx3y/GSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244327; c=relaxed/simple;
	bh=ByPtciC+URhiVQn652U1XVXGfMYChxV1rxw8MNlXaIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9DiMtAecdy4fIuLCMKJW3jx4oggCu+3VQ/DCx3WfcGdKxodXguGfztjSfkXiukPSf8dtcy164V5cEfwK1Ghoyl59rgPw2tYppfj/cjU5OEMlF0V81B1v28T9/teujkWBqGefK35JaMV++2AZASmuWvQA4AEDC8Ayv8frKGPxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3KbwrrJQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so12806a12.1
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712244324; x=1712849124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ByPtciC+URhiVQn652U1XVXGfMYChxV1rxw8MNlXaIw=;
        b=3KbwrrJQZzfIrIw9kmj5cAwEQcQe+0cQnLbAtma5TERwj6wcfCE6ZBwEZrc8GBQgfd
         nlisOW0fe6K0IcWmdHupK7T0l94BQkYP6YJORP6rpGJPLZMGZeUmNPZZOudKY+QoUkHZ
         nlFVDvvnypBAHuFzeY2WIkVAmNjHFn/eOCIcO95ndgR6Wy5nIcOIlyoSkSUjbwuXnpsi
         plka2E9MmNY6aqwGdt7w9bX/tLEDhm8hDMkK2YSZpfFMOHRWrRsAOocQvAKIDZ/BIWrH
         t0tIxSik+9PS4aLEsc0d6c5feBKF5WWeo1u9J67F0dVw3/o0cMwQRTYPJjA/amRbZ3o2
         cXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712244324; x=1712849124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByPtciC+URhiVQn652U1XVXGfMYChxV1rxw8MNlXaIw=;
        b=MN8hnsbBjUrZ8G1M0UTHe04waoMvbudRj08ANLZGbyxWdaXNB2bx9Kw4KMKJuJxXtP
         BfsrnWhgTUkAMTqOP6rlSaCChmSCEKfvqILrt7BIFYWJn9bRbV/lQ5PunqfhKBwuqjFK
         OeiAaWneetw2mZ9LA19XN2T5vAealCQsWsWiV4qwlRaOdFYUOwVbD9GEG6c6ZilEvin/
         REBP2qZzLj2E1ORtWqRaclpRce3uYIt6zVKrf6UWMd7uPBkfoOinYM2mkyXoPhvf2RFm
         Hy9Hrce/LCBxPRkXRxlFwLgZ725ZFZaxUTn8yu2TCkU7qAA3Zm7GdGZdD62OzOuBgXHL
         x7uA==
X-Forwarded-Encrypted: i=1; AJvYcCUtm4RLeYs9dLaiFqrtYBy8UM3xY1JtBW4RCVBkL64w5aiAHoXXEwZtXqAgqUUvG8xKsCZ8iF3izXSnojDVveIqZXyVAbyT
X-Gm-Message-State: AOJu0YyO7O8qZQprFb0uB5HRLiq++Inun7OSIjIO+Tdif8kYcemTYONc
	hXTQ4zwgH6SQLjslLbr8jvL0PDeN6sea2bHebxpC0tFuY6iJo29+fTgCMG4xYAXF3QKwVraKLa4
	uyY+ZVPsNbm/43Bn2jfq5kW+AfQ6E6p1edT6W
X-Google-Smtp-Source: AGHT+IGu/Cr/TzqDAagcQzAh2crALYKXnU9saXFMj2Uan9qVNOsYqiQC9yQvytlJZqCQ8hhUrVOQhul4utm/mgjk4xU=
X-Received: by 2002:aa7:c38a:0:b0:56e:234f:b44 with SMTP id
 k10-20020aa7c38a000000b0056e234f0b44mr71333edq.5.1712244324404; Thu, 04 Apr
 2024 08:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-providing-emporium-e652e359c711@spud> <CANiq72m9YAu=dr1=WMSHOqfpszj4S6OkMEQ05vqbv_zKO5pOsg@mail.gmail.com>
In-Reply-To: <CANiq72m9YAu=dr1=WMSHOqfpszj4S6OkMEQ05vqbv_zKO5pOsg@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Thu, 4 Apr 2024 08:25:11 -0700
Message-ID: <CAGSQo024u1gHJgzsO38Xg3c4or+JupoPABQx_+0BLEpPg0cOEA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	Ramon de C Valle <rcvalle@google.com>
Content-Type: text/plain; charset="UTF-8"

>
> Cc'ing Matthew & Ramon as well so that they are aware and in case they
> want to comment.
>
> Cheers,
> Miguel

This patch is fine by me - the last patch needed for KCFI to be
functional in Rust just landed upstream last night, so we should
revisit this (in the form of enabling it) once we move to
`rustc-1.79.0` or later. In case anyone wants it for local
experimentation, I have a backport branch [1] which applies these to
the 1.73.0 compiler and enables it in the kernel [2] (not upstreamed
because the feature isn't yet in kernel's `rustc`), which Android will
be using for the Rust binder driver. This patch will require a recent
(last year or so) clang, as it relies on
`-fsanitize-cfi-icall-experimental-normalize-integers`.

[1]: https://github.com/maurer/rust/tree/1.73.0%2Bcfi
[2]: https://android-review.git.corp.google.com/c/kernel/common/+/2930616

