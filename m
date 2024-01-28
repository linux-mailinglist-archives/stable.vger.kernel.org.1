Return-Path: <stable+bounces-16229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE18383F362
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 03:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076441C2137E
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 02:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4D415C0;
	Sun, 28 Jan 2024 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F7iEJmKS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635FD3FE4
	for <stable@vger.kernel.org>; Sun, 28 Jan 2024 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706410661; cv=none; b=rcPdbTomtxm8ts0Zn4rH3a97qGKdWiGg9qGCG2+c+shYKZ3SsbcCX+C6C+0f9rsJekp9sgQLryTJYjRL6i1RmYQ4ch47jgmEIU9GCXoHc075Nnf9ts9IMqqogg1COna4wQj5pEQ4yk5jxN2G7E2eP2042sJwWvHPjdR4VUdI004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706410661; c=relaxed/simple;
	bh=0Ljyz9aN5fI8hdU4LP4IKaxXlOnZcbkEh0t788GhUf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6Kxt+sP2XkeSLIAHXZij79i6KZ6/XEUw1wRl8b3mLsjyi9f2TNvuwJmMbl/8cOk5Z6VjPw1YRT9MHGB6pg//k78HkEi5a3MAprb39ZCzXAyfmAu0lAqWl6VeTvkeeWVQ/jHp+9k2rIHUDtz75YJMOvlpoAehwOD1lVMnoEc4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=F7iEJmKS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51028acdcf0so1853224e87.0
        for <stable@vger.kernel.org>; Sat, 27 Jan 2024 18:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706410656; x=1707015456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUPe8kS/dYQxcvPbyImR2zb7xWJbztZ0Yj4HdTeCp4I=;
        b=F7iEJmKS3dc9yegruNfpg2IKaWJ535A4l07YyviCrLvIst5Lnd5r1lTPL738+9g2+/
         HBaw4JQL5/xhgs2oDrgiQJBEsVVkpn6Q+xSOVhcYYD4sDDctOJ2webOGoqiv+ub8tTQX
         mf59kdgluItHMJv3xXE2ph1JTC+u/Ek7E/1Lqh71isNsCQQmsLPCYtIsJQAPzU8SMaSw
         b7dO237A/tZFmKK4bWXiLpGpNotPBFLNNlRoXHUSkkCfXibapW87Cl2AvM+dY2Ydo2SI
         VLkAXKaB7OxPJ6Kw0cN1goqod8zChhV3+P+qZj42BWqqRJjzpCZTkThUZMSCmSERWqc6
         bwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706410656; x=1707015456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUPe8kS/dYQxcvPbyImR2zb7xWJbztZ0Yj4HdTeCp4I=;
        b=ZDSGCsz34/EZQLtnG5n28Yuh8JukwHsGyY50Y/s6pHfiHOz+ucbxep+9usiMlLTAuJ
         jjiEr0C8kOG04mnN4m2jCwJBL5HjnHpqtcJrPnKyffrP9VPjPjjzBAIJKfBYJmzmxxz9
         brSFkQ75jo2iWGweVisxBd5XyOmY9Uct2yzi4GMeGVpizfexdOIkajMrWKeWVcZBzVZL
         hdqrPlo1bzJwhGDV5RIJAmbD+9UTrZ5KtL7mWIckLtfquQfyYiois0l+P9NRKn9zxQiF
         sLN15BJ9SupEvGGksnov4lp+0F/kAzKkutsnPqkHQdZRvDcqVtY1fm+brnQTsnQYVAOB
         gdWw==
X-Gm-Message-State: AOJu0Yx63+yWhS1EFisDMbQXdRI5ShcnaAZnPl82NrP1UufcOtg6pc4Q
	vn8bFfqHmzD63kPQeU5tTJKsHcK4KzVo5FXa4NUAL7nBFzLh3nvdZdZnxb0drDD4tHRzyT/alC7
	h7w5zy4gGEBmCubKTpOrVshOhiHth052AhTtZuA==
X-Google-Smtp-Source: AGHT+IH9hs8nV3EIySrlhWIGxmnGMq22449h+fsNcRpbxaYZsJKDaLHJx2IgCnzvK9tg/L1sdXMDyhVz1NejyYUort8=
X-Received: by 2002:ac2:4893:0:b0:50e:630d:7364 with SMTP id
 x19-20020ac24893000000b0050e630d7364mr1500830lfc.28.1706410655622; Sat, 27
 Jan 2024 18:57:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-fix-riscv-option-arch-llvm-18-v1-0-390ac9cc3cd0@kernel.org>
 <20240127090310.GF11935@sol.localdomain>
In-Reply-To: <20240127090310.GF11935@sol.localdomain>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Sun, 28 Jan 2024 10:57:24 +0800
Message-ID: <CABgGipVMv-+AJkGMPzFhimaPCUVATk3gjUDG0P4btRJWtXcMxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V: Fix CONFIG_AS_HAS_OPTION_ARCH with tip of
 tree LLVM
To: Eric Biggers <ebiggers@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	masahiroy@kernel.org, nicolas@fjasle.eu, conor.dooley@microchip.com, 
	linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 5:03=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Thu, Jan 25, 2024 at 10:32:10AM -0700, Nathan Chancellor wrote:
> > Hi all,
> >
> > Eric reported that builds of LLVM with [1] (close to tip of tree) have
> > CONFIG_AS_HAS_OPTION_ARCH=3Dn because the test for expected failure on
> > invalid input has started succeeding.
> >
> > This Kconfig test was added because '.option arch' only causes an
> > assembler warning when it is unsupported, rather than a hard error,
> > which is what users of as-instr expect when something is unsupported.
> >
> > This can be resolved by turning assembler warnings into errors with
> > '-Wa,--fatal-warnings' like we do with the compiler with '-Werror',
> > which is what the first patch does. The second patch removes the invali=
d
> > test, as the valid test is good enough with fatal warnings.
> >
> > I have diffed several configurations for the different architectures
> > that use as-instr and I have found no issues.
> >
> > I think this could go in through either the kbuild or RISC-V tree with
> > sufficient acks but I will let them fight over who takes it :)
> >
> > [1]: https://github.com/llvm/llvm-project/commit/3ac9fe69f70a2b3541266d=
aedbaaa7dc9c007a2a
> >
> > ---
> > Nathan Chancellor (2):
> >       kbuild: Add -Wa,--fatal-warnings to as-instr invocation
> >       RISC-V: Drop invalid test from CONFIG_AS_HAS_OPTION_ARCH
> >
> >  arch/riscv/Kconfig        | 1 -
> >  scripts/Kconfig.include   | 2 +-
> >  scripts/Makefile.compiler | 2 +-
> >  3 files changed, 2 insertions(+), 3 deletions(-)
>
> Looks good,
>
> Tested-by: Eric Biggers <ebiggers@google.com>
>
> Unfortunately another LLVM commit just broke TOOLCHAIN_HAS_VECTOR_CRYPTO,=
 so
> I've sent out a patch to fix that too...
>
> But with all the fixes applied it works again.
>
> - Eric

For this series

Tested-by: Andy Chiu <andybnac@gmail.com>
Reviewed-by: Andy Chiu <andybnac@gmail.com>

Thanks,
Andy

