Return-Path: <stable+bounces-151945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8A2AD134C
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A42188B63D
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913E2110;
	Sun,  8 Jun 2025 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWpm5AeK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AC15746E;
	Sun,  8 Jun 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749399970; cv=none; b=fNRyXM+sCwlcrSdvf1L2+gG2gtchKcEQaXXvQOslv4hD7PAyEl4xtxLgdX7zAj1TGq6YVubkg2oO0WMv1pQ7J8IWQFGv6egyDfqfr14nkTR8ok5EJaG3/uEm/x5SGgvYHuFItbIKVEr4/2dRJcbPuQvb+FRJ7gWgRHeW0NLzF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749399970; c=relaxed/simple;
	bh=PzzNW4GYkHNomnaRXPXgFq59NQwY/BC5aMCaRCMv1HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3Nsc3VsGG57xQKtat4blUJPHYEHQny8IB9a6P+yyGYIZ/5S4KhfEmfd9qrK4MCOmITklcP0GpXZe/h3eN/R3b32MF77i3fxaYMsGJfIx1XNkaSyuadh9SMn4ceT/qnIX8UfUqmF8ZVdHjbAoyX7pmH1ZKrpqHPpNLrZnI4JhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWpm5AeK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31373948e08so168434a91.0;
        Sun, 08 Jun 2025 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749399968; x=1750004768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzzNW4GYkHNomnaRXPXgFq59NQwY/BC5aMCaRCMv1HY=;
        b=hWpm5AeKeNmxFD5LCAv5YSA9SCNeGjApu1drlvvi3CA81NMBys/PjbsGeQcmmoDX/i
         7fUGcFJMnGTAMWeZDI1DnUTdHNMTGVFcMmdCHkbbPDIJIzyTiL2doaqy26j5Q2JaammS
         pB7Jm3eusBodE6CzI6IrhobpkKAiG8ZnmLnHnXfTBGqvh6VbEcnhX5LDoDwv9Xo8QjYI
         rZx0TVjGIJiA0XuaWBzvYSJ5Ie/3vslIJLamIgzZrcxaiiNQHGKXY/OcY1cf3FKS2N5n
         Cxqf1W0+uTFeYCZJiHBSpltmIJbEyMQZ3gFwU4Tj6v8Si0dENGixFEOX04/qZrS/PEh9
         KfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749399968; x=1750004768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzzNW4GYkHNomnaRXPXgFq59NQwY/BC5aMCaRCMv1HY=;
        b=U0bcZhUP1RIRdyr5aAbBFN02/9wLBsJpxt0G16pJpOig/goayNomGUFMA67ivYbHME
         NoSgWkX9Kn6U4QK6e6N7zH1WCONBECZ0TPnrbDL7CRM8gFzeximGu7ovqEoQh7XV7ODm
         AC23FRXGFl4KyvgZfpyzJwDivEHdHSdym33pl+FALaiayukW2xkv8gUlqv735uqF8gbe
         t68zc6quCoPIDA2qHxeIBszv+VxT/10ArhJmINBCYsIYgO8RmVNXEMTZrK17PdJ0EnLf
         xHXuk9VhrkKvRm5nMGkfMKScukDqPMPQZCWRaRhLSgh+IikrDyha4gabDHCNp9UHVUJv
         E+pg==
X-Forwarded-Encrypted: i=1; AJvYcCUvzYej6FGN3YaISq5s1GCFyLPyPKMqWJj8JbGi3jilWF/iArCoYR66Oa3jLj/d2rIF+bv2/3ZHaLWW/JfFyg==@vger.kernel.org, AJvYcCVFDyQANWTHXbDZxsVSLjsFm7kVPbckJXzQoxVWxdkGzA7vyViMpv8t8aNkXYo2sI1hMcu0SlV4@vger.kernel.org
X-Gm-Message-State: AOJu0YzHHurZvW6jWzRnaKBta02m8AYWDgphtcVNgWNGxMa+Xok2+nky
	s/DaBCd/iilB0KnjTqjjmenvSMazpkCrVacP7Adr0jq6ltQ7lVYKiPPnylp9yLUyDgyzTqKawz/
	g6ShjHIx+o9F7T0m/doEdrMOm3dFSa4M=
X-Gm-Gg: ASbGnctOUNWMDYLea5tPSxPZe9k3EN51E0f6fKasENPkhffL+wR9iGRD5MfvUZJz/zy
	d7RpVEVANqwKasbESZv2hCU5K95ws5p+qAEI/pojrrSKqLZNHg/XkUtdhF3/jK+b+ZWFXZzqfJB
	zfdp2uG+H7tbxo13xVPFHxnHkiw1+FcPOc
X-Google-Smtp-Source: AGHT+IFwz+44MRpwrGOU7zTWXbEpeH22WJSUgw6M8gaL3W4srWY+3hAGTSCTgwmpWoQa5N5u6N7tE+Iglj29c0oFr/4=
X-Received: by 2002:a17:90b:350f:b0:311:c939:c855 with SMTP id
 98e67ed59e1d1-3134e415d0amr4910510a91.3.1749399968124; Sun, 08 Jun 2025
 09:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608125427.933430-1-sashal@kernel.org> <20250608125427.933430-4-sashal@kernel.org>
In-Reply-To: <20250608125427.933430-4-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 18:25:54 +0200
X-Gm-Features: AX0GCFu-XvgktcoXpc-hI4_GwrH820AkN_9rLwfDQdu_Z3TO0m2kpatiNuDMY90
Message-ID: <CANiq72mGuSUb=mKs1MTL4DUYCsh6T_O5AsseYOfOyZdRZvU1dA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.15 04/10] rust: arm: fix unknown (to Clang)
 argument '-mno-fdpic'
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Rudraksha Gupta <guptarud@gmail.com>, Linux Kernel Functional Testing <lkft@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, alex.gaynor@gmail.com, nathan@kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 2:54=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> **YES**

Yeah, this should be backported since support for arm (32-bit) started
in 6.15 -- we should have marked it as Cc: stable@ to begin with, in
fact (even if probably not many are using it since it is a bit in its
early stages).

Thanks!

Cheers,
Miguel

