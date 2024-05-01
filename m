Return-Path: <stable+bounces-42924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DD28B9119
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 23:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781A9B22154
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D77165FB6;
	Wed,  1 May 2024 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKHGAC3K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F01607B4
	for <stable@vger.kernel.org>; Wed,  1 May 2024 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714599335; cv=none; b=LgggTPRjW3WkR0AsKxjKEQqDKeSGn8ipbzgMuPpgeJYAvcoxWbye9emCxZ6+k5SE7CuJngoY0nJy8Fbf7Fz0l5zbGGLUl1KnU2hSGSEQ5lCbs9y8QgAB+v3011vJb5Hi8yjTMO4WSlQ69B9VbdC672WMU0rtFBiP6pG8bSD/RKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714599335; c=relaxed/simple;
	bh=NAyz/NYH5PuN9Hq2KI40h7D4WoloqO/Uz5gYnihIWpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fh+40f88WaTYf6uyhBHDXGz9K5rp1yaoUElgQeWiz11AJrrohCPfsWQBf+X3Y/z+qiFQSFvFlfx80ZnMCw1Q2FjEUCPY8dlX0sI/LTx3SnWzJdqaj00KkcQmpELb0AwtJrXkeM28tIrdqK2JpTYD0JZFy1pzeSekNLHNFuoyv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKHGAC3K; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b346712919so535036a91.2
        for <stable@vger.kernel.org>; Wed, 01 May 2024 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714599333; x=1715204133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAyz/NYH5PuN9Hq2KI40h7D4WoloqO/Uz5gYnihIWpU=;
        b=RKHGAC3KIAorOjEnsPRKtdbL17EMNMjlzqJ+ZSZQ+ZCxoY6vYxCk8NoNiwPuiWXL/T
         n2FetO7UxGcO+ZP559di66ZBFREv9U0TFok3EYDZjva8JfucAgyUg2At96EsC+2LLIRR
         Ge9BnlCBIbjF1OWjbpUVi1is9xMgzAsrI9xhyCd/u/Jztk4Ylgidw6f8JpQ9xKslkm6o
         ACPIDpoYqKkVsE14VXrsdtEu4do4EZ3Z01sJCrxFgP0ikuRStLoB3KSzR5MyJ2YnHExn
         ZaNHREOiU8pPARRAb5B7wikgAQtDj43wowNEp4WGz98enxtdB4LGwA8qo1QPRSwsxLRa
         ULhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714599333; x=1715204133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAyz/NYH5PuN9Hq2KI40h7D4WoloqO/Uz5gYnihIWpU=;
        b=s8p7uxdv1mdKHIf2nmoIuG3nkZBH/5D0IHX5ubR7UXfCV7hPZ+XET+6s8w55xld5IC
         lRwpxguztufbeyGE1FzTjzJGprLrTrIhUZ5E3muKB2uZkofC0Ziph4B4zWKyD4CmHqND
         cWFdzBG/XgOwg19Gc/+MwjP0hdnNttGmtOtttvr07Svd3tGi22/ClfwMiKPzLZvPTtcE
         t39Mr28oZjEZlZNlow+PC9vlrRgv61BSdRJ6sq8ijcpmJntOMbIrdbCKW7mNfsxKtPhS
         evArQsfQC8exZ75O+oAvRFxrkhCVfnXni3j/oQvihIElqjrl7oRL1xHLYEnbQPJzrx2L
         JpMw==
X-Forwarded-Encrypted: i=1; AJvYcCU32mmYpTPu+EcQEtHwTFMqIAxYdKgYuZOiNbRZGX8MKcRiij89Y9lS/oVE4UgYDewCwk9x4cfed4mOc5u8pnVdrBbh7Vyf
X-Gm-Message-State: AOJu0YwCFMTSd79jccclIF+aVlpr2UtfmT7AQGwrf56BQh1zYB558uix
	AXj143IWrCJKaScTMaabl4dInScVWaLmJMurUrOhnXuoQUsqNCVUtoYFevB6Uwkoe/+j1r4MryB
	1e0n5h57LEovohJBpeZmKcgbXAcY=
X-Google-Smtp-Source: AGHT+IFA5AVIY20T90uzuTb/k0pbeiIElJ0X8Bk6rc+mf2kprsu1vhkJJ0jAjvCR3VSiT3p+N+ncfQXAZYeshpMKm08=
X-Received: by 2002:a17:90b:60a:b0:2af:4a2c:653f with SMTP id
 gb10-20020a17090b060a00b002af4a2c653fmr3541531pjb.12.1714599333282; Wed, 01
 May 2024 14:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024042940-plod-embellish-5a76@gregkh> <CANiq72npZyXLXBZQe3gzPX-geyUqkF1HNg6H28TKr9t_BE+DuQ@mail.gmail.com>
 <c3quwogwcekhndus6zfls2acrjbcjhcatqryotkpis2jzdudbw@db5qqg3vodpg>
In-Reply-To: <c3quwogwcekhndus6zfls2acrjbcjhcatqryotkpis2jzdudbw@db5qqg3vodpg>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 May 2024 23:34:15 +0200
Message-ID: <CANiq72m-MZPyO+3QLZDsFoAXU9ctyHWtUx=HPoCO1AZatr=-mw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: macros: fix soundness issue in
 `module!` macro" failed to apply to 6.1-stable tree
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: gregkh@linuxfoundation.org, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, ojeda@kernel.org, walmeida@microsoft.com, 
	stable@vger.kernel.org, Andrea Righi <andrea.righi@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 11:02=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Yep, sounds right to me.

Thanks for the confirmation! I appreciate it.

Cheers,
Miguel

