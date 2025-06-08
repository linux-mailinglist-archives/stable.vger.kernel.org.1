Return-Path: <stable+bounces-151944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC36AD134B
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F153AB5FA
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A3194A73;
	Sun,  8 Jun 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqbGZ0vW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A8188A3A;
	Sun,  8 Jun 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749399958; cv=none; b=C4imyO0SvDibyo4t4e//21/DfpeaNYcFudd3BX3xoKRbuPg8O9JMJ1Mrx8iatsNH+KqjVjd0nOZeCEvBI/Pe1K0KJ8z7ii9JIckWOfiDRTxHgy0Wlib4kkq3YTeCCnlwOUBydfBYPjfI8AXoHrygCaaUPd8sZ5K757+QPjSTOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749399958; c=relaxed/simple;
	bh=ylpMEiw8aCEOuAGH9DrHPUqKk8M9ynLjDqJMkNpj3fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVulnqNi8A7r4Luvm1oNXapiPezFN6zHvJlmLUAd5wSw2KnL0wWFGnJlVNIUfEAYx3GVjWfLdlomy6eUMCqVypBU9ZzFI7Qsv6doAmZQdn2+vK6jlnSztKJJ1vHFVME+/+UOFH+GK1STXI/RNngG65xk+XOIjDUxV15JmQ9f/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqbGZ0vW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234eaea2e4eso6604195ad.0;
        Sun, 08 Jun 2025 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749399957; x=1750004757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylpMEiw8aCEOuAGH9DrHPUqKk8M9ynLjDqJMkNpj3fs=;
        b=jqbGZ0vWnaorsWAg2MoiiU99NjgAvwdHH6EpytbbkBjBFJhxA0JiUwhG93jSimW9aK
         +ch9/WLyrWL2MF0hKmZGyQY1MYk05g7Uqpz7rDuDNV7eq81F3UwgMkEjNGBYUh+BF2cj
         +4WnuDY0bMc3Gr7/u68HqMUx3K4h+6lT0J4B0p8VCIc8q0rgaQqec4yKJ4LfRY1Lzhqs
         FgpkDCe5PTMsUCzTeiOAKSfCE+CagK9e7KhbCARW8d41bNkSPB18Vb1Fp6S+7cBlLMPg
         00/PjmjpUaq8jcsM9gD/z6AqtDcJIH8YU92+v9lnd1qx0Nq+TY6r7nlTce33IPa8skgB
         j66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749399957; x=1750004757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylpMEiw8aCEOuAGH9DrHPUqKk8M9ynLjDqJMkNpj3fs=;
        b=tH7JuU38ljoHjH6dTdiASh9hY6xnMz8Sr74v08biFJXLvopD2+lbHTEcY890mfvZXs
         rB0xoYHa5VpwS1Q8LFklppkR4fuK+xl8ApRHiB/CSwlRXF6D7Nwek/61h9yWRnUK9RMM
         z11pd/heG5UBwQAlj3y+F0YSPlUKs8mOYCNZuwUWyPNd9oFBW8Qz5IVjIdjuWT7fevAK
         tRsXPGZA4D5T5x6gtuCw0Cswyc+iASBe4GbaV0es9NCCHncVGFEhmy5Ckm+xIATjQDaR
         hNyyTnWLJbQyg66IQkQdJDCHhANeJb8Y4NHnNtP61+ASlVO8RirqIEfDbVlLWCI9MLvQ
         PT9w==
X-Forwarded-Encrypted: i=1; AJvYcCUj37PnAu9XXcw0Qbr7woZxFhnPiR9Un6mThmKOpjFjb4wxB8XWN3vWFJyvusGdRugMY/rG/AKLsk2bBXCrPQ==@vger.kernel.org, AJvYcCW3Cbej8rrlFrDzg5ZL6u7N8RQh0ibWZSGG00Ah6BCfp5sb6Cf/fh1AfrFcOK0Bz0hd8Qog+Wnn@vger.kernel.org
X-Gm-Message-State: AOJu0YyMf7pXF9uMlq/W/r/vB+eaW3A6JKF8fE+iPSU47RX9wOpye3f7
	i16t+WZ0jMgcVCqpAJdOxbsYd7A5M6xAchGXO0ld3B7eawO4yg/BLaB8UETORVsoTjsTf1ww7eE
	3qEB13ErGrJ7GMdDqLko/7EHTcKdi1ws=
X-Gm-Gg: ASbGncvcsFYjg73CLAiH5lQ1tzBfct/q4fBv1k9ZW0KoHDI9JClOT4/UhbgswRdDTTl
	j1L7BezWJIbhGD5xYYbkE5mMSWl4BMZ5Nbn5YGAYsVnudO7CbLmQUu+YKpSi3KohkjVYrfwKLlx
	jCHyXff96+EJKnx4ph56b9zWdToe4Qoc+pHVGvvpkQHI0=
X-Google-Smtp-Source: AGHT+IHzL4OxbSuKuyusu9pJe6b72lYXe3EwmKWcESLOWIozcbAjtXYVbs+pfNUgdLqHMqJRxwBHgDYwhnIQDX+c3SM=
X-Received: by 2002:a17:90b:2886:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-3134e4531e8mr5126568a91.8.1749399956661; Sun, 08 Jun 2025
 09:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608125447.933686-1-sashal@kernel.org> <20250608125447.933686-4-sashal@kernel.org>
In-Reply-To: <20250608125447.933686-4-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 18:25:43 +0200
X-Gm-Features: AX0GCFs-ooVc7qRwQ2yxF2Jw3GhihlUC2Pij1EJ-_8GViuKvWdBe5Xpml3aVFlU
Message-ID: <CANiq72nOxVAfDrns6QimMUma4Nkq6nPCYL7QYyr+fD40LK-pow@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 04/10] rust: arm: fix unknown (to Clang)
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

This does not need to be backported to 6.14 since there is no support
for arm (32-bit) before 6.15.

However, it should not hurt either.

Cheers,
Miguel

