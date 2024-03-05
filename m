Return-Path: <stable+bounces-26830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24698726F2
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BB22848E5
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999791B26E;
	Tue,  5 Mar 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gIVSsA7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8934199B9
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664754; cv=none; b=fRwo0qW87NspFt4eHcF6ZuiemoeLpZYkknyAxKlyoENe8N8QxuNTBxM9dcVccV1PSvD+/Kn0jLx36c2ryxvUzZXBrU7DEZ8LUmGHZysYrgHaaAQbW1HexubNSxUKTh1A4JUD3QJcnpcG1q7bw9gISDFhP9ik4iEu9tdJQdzRvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664754; c=relaxed/simple;
	bh=LJ1VyEzT46GGcGZdysuPBEKZgskQ2Uy/0HABi37DaHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbvaaN1R4wJiChO71aRWEmyG6HL+kd5vpuL+Xcq1/oBiAxWbiugY0fQcGpaU5gdj4MWuAa+VgRExxPpUJijpgBfl5ML1hvovnWah1VGmAj+QiYl56TZ17A1SAUTAfTlyCP8S9T+7Dtn6zOAcXtXyXncMFcE7FAWiiTM6cevyYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gIVSsA7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e4c66a090so837882f8f.1
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 10:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709664751; x=1710269551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ1VyEzT46GGcGZdysuPBEKZgskQ2Uy/0HABi37DaHg=;
        b=1gIVSsA7LNewWWWHrUU4PRWztwvQEnRSF3ttQUSCRbI7JRMfW/Goc6pWvz55/Yb9VQ
         s6wSGFAhu2mDj7+a41kZ1GOV1GS4WuVy1YmctfwZJa4zcz0oEzmyr25Se0ga0Ymgw5V4
         4AU2bth171dZtzVXANmI6xuzyIp5UF+FuCfJk22PI+T4Cai/1rwQC/FP3eV2CMqU2l9Q
         79TA0fFh6PsynOkbMC2B3Fy7VMPwt3Z5AHWHmEnEfMfMDLO/kKm78Izi5b2u0I9sMYwp
         1eHIMzSYnICQ7Wv9QqSFzCiD7EeUA2YYQm4SNjWMa4Q930VKITKhn/q0bkneP80AXOE1
         LgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664751; x=1710269551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ1VyEzT46GGcGZdysuPBEKZgskQ2Uy/0HABi37DaHg=;
        b=ormnZQ4cm1tyE1S2mgSv2pdvaywaRxttuCQY09VA75cJzhtlLlT0v+fD6zY0I78DJ2
         AsjKTrNt+mg7C9TYamZj2jKWpLhJ4JItkjpzxRrBQtM1Azla1FQnGF1w3cQRrwgoA2l/
         mdCh0xecCig6XOBCIWCjfRY+zmKghyadorBd0JTmHo1tWB70DR0XnzrwvaXcujb8dbDX
         jIU09YeZhzD+Xcx5TXA/hlTtsloACwLMeHKH2OVJGR0qjYWVRGygdLvTkQ3TgiXXKM+6
         sss3i6krDwVA2YEzD2rl8ZSfWzkTN4MpLHL3duEbo1G4KBdE5TiH6eMmx/HZvzN4IR88
         hhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC7tmCAl3HZQJ643rXeTL8r8lJAv9LNQJp0hzzgZkmhJi/x8CTAQ3x2FC2gJwaNGzkbAz7++ZLjJsRi8Ik423S0fWJfA42
X-Gm-Message-State: AOJu0YwBvFTdqPUzDuXfSmMIjmZ7zR7sqc2WMqoc7uzB6zLnjbY4ue74
	c39tw86Q2u3WNfXEh8nBPOjp3q0AudHBtXPkq+z5TdWr4cPxG6MjxDWCyyvpX3yqbuMRKSOqqvA
	KbbtJCsfGZyVarQq+WHI7JJjAiEygZ8PVcP3Z
X-Google-Smtp-Source: AGHT+IE6iTVsszmymc0NXm8TpEIVOwbLQKCaadELBnL4QZrR9C4Q/dxgWr+oVGwQntbPMh9rJoXMRgKZMzGcc84yKvk=
X-Received: by 2002:adf:fdd2:0:b0:33e:17fd:47c8 with SMTP id
 i18-20020adffdd2000000b0033e17fd47c8mr10226695wrs.1.1709664751234; Tue, 05
 Mar 2024 10:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-disable-extra-clang-enum-warnings-v1-1-6a93ef3d35ff@kernel.org>
 <57abd8e9-3177-4260-b423-38d5cdcda44e@app.fastmail.com>
In-Reply-To: <57abd8e9-3177-4260-b423-38d5cdcda44e@app.fastmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 5 Mar 2024 10:52:16 -0800
Message-ID: <CAKwvOd=V_Qtd2pK8AKc6bv=zMPnAaCf08=QO74ckqH26A3sefA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable two Clang specific enumeration warnings
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:50=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Mar 5, 2024, at 18:42, Nathan Chancellor wrote:
> >
> > As the warnings do not appear to have a high signal to noise ratio and
> > the source level silencing options are not sustainable, disable the
> > warnings unconditionally, as they will be enabled with -Wenum-conversio=
n
> > and are supported in all versions of clang that can build the kernel.
>
> I took a look at a sample of warnings in an allmodconfig build
> and found a number that need attention. I would much prefer to
> leave these turned on at the W=3D1 level and only disable them
> at the default warning level.

Sounds like these new diagnostics are very noisy. 0day bot sends
people reports at W=3D1. Perhaps W=3D2?

--=20
Thanks,
~Nick Desaulniers

