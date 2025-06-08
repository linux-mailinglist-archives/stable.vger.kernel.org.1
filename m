Return-Path: <stable+bounces-151939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDA5AD1324
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA49116938E
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAF81898F8;
	Sun,  8 Jun 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/iBeXPW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3C15B0EC
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749398361; cv=none; b=t5P51KPlL/qqtKBMm3mCgUCXIju2dOSp+VQQDy/HQe8SshyuXtm1mBVbnaUCYYRa2sENgdijdZsRCeBUboDZZ6vqd1Fzzjy/Wr3AmXDYAazw4BmKxht8VwB/szHPvhrGcuccP3eD4qgfmpen/iftRaiV8XZINlpxvI+ZONONBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749398361; c=relaxed/simple;
	bh=1+u7U4B+dmoXda7LRNrjvNRAepAF1cB90kenZS/Y/Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWRjyXQAxIK4npftb9cFp9P0rc2Mq7h+ObNMh3LsSbn/IbwNzYFVwzrp/pRTeNmg41cBAu9vOsSeB21/SIcJAZCz4pR86QjHevv96d0HmO2OfxRH7OuxAlLdgmALqCs6TM8YY+W7vDHar4ZP/zfamLK1jg5csim4ooTgwlbdGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/iBeXPW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31306794b30so654718a91.2
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749398358; x=1750003158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85Jsnzj72Whi0BpwCungYmoLx6OnQvtFNfAddu/mDW4=;
        b=R/iBeXPWHPzTCaULrP+PZ1IYZwZ9PUEGnXntow9ySczWngD0UtCFe/KYFUporbZrn+
         ncgPwNj34IN0IE6XhTglBBc10k9Fo1hymhqBTSSjUbyAyM4Q3T1R4mATBp/yPMEZIo1+
         YPDlNdwz4fEVTlCApa0CaJfUi7r64e7o0uQaLlKog4tL34jtnQE1VnxobfnE2l7XUttm
         oIcysjOvvVGnTKUCXp+25/UDGdPzh54+j1xGTRPawkPkRUN82ptKmFsJbXbESOAQcXBH
         XAiW9hweQKUaTKuBRYpa0ouRL+RYvcxWalrRDEAgXjneMpzAh1i+OEBcleBb0Jww2hW2
         wsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749398358; x=1750003158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85Jsnzj72Whi0BpwCungYmoLx6OnQvtFNfAddu/mDW4=;
        b=oXSGTVeWSE9NYRPy7824URLYfqMiQBWhYM9yrlmiwR8IRK6I87zk7JJ2DbzNGfGCnS
         pNVKlwQq08Wlyn+xS5V3LhcFQh/duR4x022KkQ46zG0BCSv+CvUCh3VZO3VgI/h+9fFL
         l8pmtvJopPjnf7hEC5R8z9tAJjDf9bBpU5tgqrDXGNJaAlXKGgVPON/Rh++Zr1as/1c6
         Slvpzq8QU41QCxh0uMt5gOsvoktOui/7gWl1JA7Ub1b3/Aozrlg8Kns4Q0ejvnvofXS7
         iACr750CGbM7///NdUvUjB11kR0l33Oa8j4DtYgtGAp2Ab2RMEV4H6mN+2bdHvx7UKDc
         gd1Q==
X-Gm-Message-State: AOJu0YxiRt9R/sjZIlAe4exki7gqmp4UYsIbhVfAQJiPMz9ctzB9Q315
	kbh9Pee2TeEbti+9AtLNFmNdJw29C+2Q5yUk1P913BRCieaMQqtXswtvdSo9Ofnm6oUK+ZpJZOq
	gQeZHgUcqDaYbjN+ZGLq6hdLv49trrKI=
X-Gm-Gg: ASbGncuptet4zlbzsyJeBFNtJAHW92dvyzGcfgdfzjSXt6O1LqCtzpY1iJ2ZxO0GvM5
	Olh6nn/xXqitaEUBdbh+FdLY9HiIu5vIx2L6L/5PjT/k45kp0WJ3ThsLgPUA2gJkwq9V3m0UMF0
	7zFX/F5QeFMjgNgQzFDMz251FQrtHTOvZV
X-Google-Smtp-Source: AGHT+IFrIn8BgDCeso7QOD/aG7OAIg5c97ykv5+vx4gDnd4ntI7yMZRPOXu8mkap3JM2GPo2BkBPMrVi3IMPhyki5gk=
X-Received: by 2002:a17:903:2f8a:b0:235:f250:84be with SMTP id
 d9443c01a7336-23601dc0337mr52494205ad.9.1749398358143; Sun, 08 Jun 2025
 08:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608145450.7024-1-sergio.collado@gmail.com>
In-Reply-To: <20250608145450.7024-1-sergio.collado@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 17:59:05 +0200
X-Gm-Features: AX0GCFt2hfbzqOrUlECToBMshgw-R5Ee5P6Zj03i-NU6HC25qDQTmCyQEQKldKg
Message-ID: <CANiq72n5u2-tMk2ivK2fVFuf951r9mSDGKmXkuPwGJ2DBdJ32Q@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 0/2] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 4:55=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> This patch series presents two commits that implement a test to verify
> that a symbol with KSYM_NAME_LEN of 512 can be read.

The cover letter for a backport should mainly justify why the commits
need to be backported to a particular stable kernel, i.e. it is good
to explain the commits, but that should be already explain in the
upstream ones.

As far as I understood, this solved an actual error error in some
configs, which is the key part for the backport -- copy-pasting the
string here for future searches:

    arch/x86/tools/insn_decoder_test: error: malformed line

Thanks!

Cheers,
Miguel

