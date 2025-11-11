Return-Path: <stable+bounces-194505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CCFC4EC73
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 16:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED8D189FDF3
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1C6365A11;
	Tue, 11 Nov 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1wlY9uu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD903659EE
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874725; cv=none; b=UJUOVrav84FWy7siYkM98q831mNTaXq4Sp9+HbmiwEyNcmi+bcaiy/qYv2BtDYnMl3Q9enBYPG+Dft4OaU8BosQiE3Fu4Y7U9XK7/g4m1zp4FlL+l4JWmZcnO7zO8wMhHIwtNhByWfHHROEGVPm3qbeMdAorUtUfvye2pJnWokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874725; c=relaxed/simple;
	bh=kH2n8iyTfgAxz6xqhPaYcBszdchDNAlkl6wsHl2bXLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/Zb+Lmrwpr7EN2S7Y4w7Se4wIqFdHRuSrVbjq9gUz4eIjfTNObkj1VozW0g1zbVsVBc7Z6+KCkjPVrSvCj2q/J/V8mkkmTTOhk3qNcRndPQLpx+ogwXdvDKvryHnqsGoIKvK/QtxN/VNwTarCzuA026d7j2Kx0c9Ww9TxiFZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1wlY9uu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378d6fa5aebso37797071fa.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874722; x=1763479522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kH2n8iyTfgAxz6xqhPaYcBszdchDNAlkl6wsHl2bXLA=;
        b=T1wlY9uuIBJOoaom8q+pU3Ew+ovnvnwgbeFT6DNqOzxc17R2wq6OHP1jZN36fZVZFA
         qmYgyMDj+/2s1sVW7MVBjxMbpOfkCFWRS+kY3xo79G4ZIQtswVLh+9CJNEFyNxsdBz6h
         IqTZZrgLtMjb2kwbspqmcdMrcCjdoOnZc++p87074QOuGvi44zMiHWjrwo9WBb1AS6zq
         2g+Tfml17OcZGzLFFbD8Bjbt4eqaRfwwRNLr3JFTjxvWdt+Vzlg2bVKIYY3kpbmNR9v+
         6EPvWcr7TAApF/xiHk07HMXmH5LBUuHKndKSmXs+4TzhsdrFZ9iHLgWqAkiuakklzPka
         2ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874722; x=1763479522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kH2n8iyTfgAxz6xqhPaYcBszdchDNAlkl6wsHl2bXLA=;
        b=hwlXBFR8N0TnJMFEzbH/63ns1rjCUqUc+H0fb/qSZQAK475ow+uNQ1ws3BZo0omJaN
         Y3Dukb1awSsLE4ng6QxGb7bXT6EFDe0kf6O+vn5AmSJnx9tW6WIGZF5gE8yWNvsbiNk9
         GstE8E9nxbrFZwdGgRlm2vTLaD+dOtmDto/+QNfvxtnIRQabGPQyHbtEg95MOpPP53Bl
         GpRX+GQBvT1v9rf6Bfe/ofM6ffd9DThwTlvKLDuXqVdNWA07HeMYDZ1wGOl0+ni+DkbH
         UppBeOtmjMzE/Iib0okIPPn832zYJRLtaOv1pOelFzN1bvvSLTZV3hSS2kfzbipEKN8u
         olSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWPfzFRupamV6Pbhkx4gz8pez+hON/tlmX3nMO3/rt7+dty32dcxaZYixrYifxrmwZvcm5jco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbO1tD/1sKb5ZFYElE0xmZTzD1YfzHkseHOrUtLXU+c7UbEpRu
	ViKCGAvKUdcb6U1usfMEayk/F1YlwgOu4EdiTQt1vgGCizfGU09I8MAPj/5yZcoKGzN25MBXq2+
	bijBJBJrSS7Iet+KETD/Kbc5yhME5fvA=
X-Gm-Gg: ASbGncv00U2iN3LA5khLyHDi3XK8NlqtX62zTVEAMpEkEtfUVlg6S0WJv8IpGv0T5ps
	7wNzu0vAj+a9MGTzSjerkVZZXzY2I4l+CA7HegWHJKtk7jquv/aknZU315DLMg+4PVfN8kQKzeI
	vKXmipoYw5Qeylo1zVvqGj6UfBYf2814+jpegTxZEohIrkL3N6/B68RmarDu5Nl54BxvAsEgmFr
	87Xhs+bs7BhhqjnmKZcQZ4zycU9DLbwGquqLP/RRbGAzcBwWOUCaltyMHNe8CukpCbhw0WuCw==
X-Google-Smtp-Source: AGHT+IELN2Wzp2bTqYWDhcQjlFtX9DA00ce12BJNW8cO2c8JdiyexJqlAubB4Ie5Gjviyerq6QZ+GfCfwjPRPrxTi4A=
X-Received: by 2002:a05:651c:f06:b0:37a:7c41:79e with SMTP id
 38308e7fff4ca-37a7c410bf5mr32947351fa.13.1762874721655; Tue, 11 Nov 2025
 07:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
In-Reply-To: <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 11 Nov 2025 16:24:45 +0100
X-Gm-Features: AWmQ_bl70oXfEo-1yQ9VfgUdYtwxWC_v2530llNoS_lks6MxxMHeFjNTi0L0Vkg
Message-ID: <CA+icZUVcHfLru9SRfhNGToiRmyOY+fLw-ASEvQakZYfU1Kxq4g@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Tue, Nov 11, 2025 at 2:58=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
...
>
> I will send a couple other fixes to Linus this week, so if nobody
> shouts, I will be picking this one.
>

Hi Miguel, Hi Sami,

I switched over to gendwarfksyms in the very early testing days.
Faster builds. DWARFv5 fan.

And was using v5 of Sami's patchset against Linux v6.12 as it cleanly appli=
ed.

Last week, I jumped over to Linux v6.17.6 and the next testing will be
Linux v6.18-rc5+ (upcoming next LTS kernel-version).

I will try this patch - might be you will get a Tested-by.

Best regards,
-Sedat-

