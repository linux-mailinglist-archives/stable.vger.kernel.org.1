Return-Path: <stable+bounces-194931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B9BC62A4E
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 08:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41C094E9A47
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 07:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A930DEC0;
	Mon, 17 Nov 2025 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+KcNBzA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F930C636
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363082; cv=none; b=KqiDj7M5yqPKu55YODdV+9l0AFG7lCD7gmwg8D+5eeS882Hu+7Ac7hD0F//2F/m6azZ0gKoOkVOIpjR0WDrVwEkFjIuh6iAq/oSoRCmPGAwDFel7096SVYxJ/XUUysH83Y/P3muCaFpqZ/CZxY2rMMUeijPsvzKf+cyj32zwJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363082; c=relaxed/simple;
	bh=CYPw329zmkubMZ4Oqp3vAoduc8Bm9/LkBfg4v4vKqr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcsl2qav5oKFW+vE6a/VCuzbE6xVpTl2Ls+sCtuSPx2IU6IU8PRONMppmGjQyq86eWGWz0JWqvRG7zXUuTJTUSZDhaA23/WoHLf+w8iSYKfHLZUsxfuMBaCxpPSGddRCZGYwgC4divIfYtRnaQopTHDRHLdLboCZESUE/T4048g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+KcNBzA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b8f70154354so391292a12.2
        for <stable@vger.kernel.org>; Sun, 16 Nov 2025 23:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763363080; x=1763967880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYPw329zmkubMZ4Oqp3vAoduc8Bm9/LkBfg4v4vKqr8=;
        b=R+KcNBzAAtB38gMoSP0V4W+ICzrEBQk5VbtjdMDIloAnAlHWiaaYxzECSsSWAJkblp
         qDJ2MW0Q+Q/fFgQIGprXWLo8T4Ih8LG08FAY3EXrojtQ6Z4ttcU2Q5zGvP+LWsWA9Kn0
         1tXEZNzAT9N5yqztzUcRSQjDxiejMfOYPBsq+QteEpeJVQJTGR/Zc75qn3kZlorZg0fw
         km2RjXF18X8QvvIxgzV7MEHAjJnTRZBgkU3/c/QqX6kqh2ZO3cxYFlTXJ/fSdXerXfyG
         /ni9Mgn/Af1IjQ5qVeg5ZUsH0XJXaOxKjsE7DFWwYB9RfcGQyCrkbNOI1DcORydnt/cp
         v0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763363080; x=1763967880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYPw329zmkubMZ4Oqp3vAoduc8Bm9/LkBfg4v4vKqr8=;
        b=MKrWQup62EsP1A2oihGyP4tv724NYgI48T7WowrOR/H9iOm7nGOM24K57hVw6GdnQf
         bWh9MvgovRw4ixcu0sRDjTRjJXfV8uTuviFcW2nXLPuDzn+oqKji5qYV8yYLuFlG69SA
         iSNnA8O+bF9NxksTMgOVlq7OvaWeSVi5lTlfTItbZo4zw3xeAXOL1q+Xvb0cNQc21KVL
         HG/y0Eq2M2XJ7KHHoY8GIGG7a65WNQM44/NuwSJudOxMIQvINbdORGhRVpZeQhAyJzur
         tGdDAL4X55fCkhjDX5qOeNJSPW3S1vaVqXkod5094zvJrflz3zv9EQoxdjHCJ2+BLv+p
         p8tg==
X-Forwarded-Encrypted: i=1; AJvYcCW98Bqw9soF+mvgChTYDMdkcvdY2ZoBxMJxsb7hNHQg2Wwev4p5k8khA0NMJOY5J2REuXOKUu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLF6pAKOpaOfChxeXcCiG4omaAGPhjx6uRyjiqh/IWZoJQsLa
	Ydb4vc5rUVrSyTODP7cmKd0kt++Dau+3H9d9lfo64h+8/gkLPGIP6d14jFQ6kmSgfvoaVsR5Z3j
	qBRv86S3TBmHaB9aci6IANddcLM3hRMg=
X-Gm-Gg: ASbGnct1sThcgmc0waW5wcBrCX0gXL8SS3IreMkptROzsIn4mw14gvJf5rjTG9kCE5t
	Bled8KDGvcsW2P+1QY4OcILlrbEU2MdkotHgeDTutgNX+kqmGM0x76EqG0L33nECTx2gLj0/3ew
	BTmPCtu1HqdeGQW94vWypsuNR/0yh9qro+UjCGaQ5KfTc6kb6/9MecUFKOo40KNHyu/gzdOaagN
	OvFG3YTfCwTN4FH4OM74m4L/iZmY7s8/e04WDOEaRCtakJcPUQypjCOVO+1ky0LH+6PNsQpxM0Y
	u/ftWhesFczBCOjFSTjuESbNFTjbkE3Jx1pPRBHWefEipuh5kTaFVRseeF7v2dCbFq49bq8kU8q
	3PpA=
X-Google-Smtp-Source: AGHT+IFF6tPDT0L4yizZVI1c10ZclGyviGsHkCQk4kxS7isKo2vtxkOxYRW0hlhC0Uw2BCeIjdVEY0/KECyEd/erkGE=
X-Received: by 2002:a05:7022:e0d:b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-11b493dbc02mr3847201c88.3.1763363079884; Sun, 16 Nov 2025
 23:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
 <CA+icZUVcHfLru9SRfhNGToiRmyOY+fLw-ASEvQakZYfU1Kxq4g@mail.gmail.com> <CA+icZUWqLbzK4ANrx=MDhhY9UFzazX6O3izbQeQ8bF0obuhT0g@mail.gmail.com>
In-Reply-To: <CA+icZUWqLbzK4ANrx=MDhhY9UFzazX6O3izbQeQ8bF0obuhT0g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 08:04:27 +0100
X-Gm-Features: AWmQ_bk19CSqQLRlb4nj4Al23oXTqmCbs9eMIWMN-W6GK2KEEvtJiaTpGvDsumk
Message-ID: <CANiq72=4-pM50mp+_0_+gEsd+Yu6m7yBaajnq5YZzdGOz7iGkw@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: sedat.dilek@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:28=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> Tested-by; Sedat Dilek <sedat.dilek@gmail.com> # Linux-v6.18-rc6 amd64
> with LLVM/Clang v19.1.7

Thanks!

Cheers,
Miguel

