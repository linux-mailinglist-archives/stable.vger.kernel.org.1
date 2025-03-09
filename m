Return-Path: <stable+bounces-121580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41D1A584E7
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E150A16AEDF
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D2914D2BB;
	Sun,  9 Mar 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr8/piEp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB041C84C1
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741530070; cv=none; b=C4NkV/U4OXDgInSutRpHC8lgXMv3VdwTQmmuNHcmgfdyWIIEG8ieMiJFhvtVkZqkjdPal0ERR2ChYRezHc/tJA+hIqz1GuFzv/pj4uxQUH+YlJAhn9AT4L2PKdVUqMeIn07DGoLwI5ci/HgpASxQndC26ituGSn6NsAJyVDVt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741530070; c=relaxed/simple;
	bh=kFz5YSiZo92lO+L2dWa5k9GVCC5TiWRcKiFDODFxgac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TE9vYVl38UOxPfg7VDOZzgdE3BGeoHMtvYA8EoiQ+FPICy8fZyu0kjQ64G5ht8qzlafUZUE1sK3j65N7bUx6oTukcRACNMWG/8mbhtkTBltIYczofClLXqP84H8KzFvp6PZbV7wxDOJk0PpqW0cHe70H2QspWxQ+7OQ7ewFpJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr8/piEp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22400301e40so7236135ad.1
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741530068; x=1742134868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcZKJiEWpL/ikPP0BnD1JJpmE5wF+3Sm+aFgv0bnpmY=;
        b=Jr8/piEp/c5MIUEboh7p6U2OIP5GJqIxYmhk2y0SRzM7vq1fUBZvrVBIaRpN+gFlV4
         PdRvGXifEXNAinubW9Y7Iut6COcc1LQ9A61rxhTYluhkCoIbkPoUsxI15vHHGMcbe30/
         W6o3nEC9JgHR8Y0FK+wSnw5HEsaJLQ5pmHMIvUhOi9p7vnntslvtNOdf2i/Byl+cs0cL
         te2OTTUzA5yLlIe8Bjd8XAl9fwNro4LhYN7jEyO6duSnSLxxolteGDZgXVLXkAd35gFl
         DbLK+oFibnxEF4VJIOkR4e2zAzuHqy1QMuaH8FsJn0bPbzPW3pgGlTX0sQarw00xdInd
         tjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741530068; x=1742134868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcZKJiEWpL/ikPP0BnD1JJpmE5wF+3Sm+aFgv0bnpmY=;
        b=qhYu4juWD8sA/5ch6DNzt0yds5M3WbPtn5H/IqbazB7YiM+hGnwIO4/ZsQ26TgL9GW
         qV58zhC5n9wL5jroZfWnOXv42/Y5SXaO95Fu/nHBaQaiteKcPJTy8pnvzkEYRrqQ9xiq
         L1SHsnyovB8XqVr46QYIZiflx5y9NaGlkXgYxXhlKiWRrtoOBk7758Y3KOkMvkRPqZzG
         CBoI2OLLocYuhe+0Mj9md6aPbVoQQCHsUeSN0yieIp5An7QP1BnpvGN6++pkjzXJQzgD
         lYc10i6t/K5t66yBO6rRCyQVt30jIKypCGOdGfII0fbX/YTwDOMusEduWIbPyv+W7mMY
         0gQA==
X-Forwarded-Encrypted: i=1; AJvYcCXPs1muhiyaUqBz2lh6tQS5aDyJNSoIRZSSeepl6y84l8SGLPgaavMCcphzp+vTy1dD5+9qp/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRHlibpW7fmjMBcOctkl4JaiON9g2XlUT0zJBlv+cqM4x6oJt
	XIcfJmsD0J0ZDHP4YWDDLveFUoe2iYIp2tMpbXuA3y4Kd20UIDJimyTrnJza92453u2Cpb9G+FM
	v4kF3QOWLWjNDR76Z6/Ja1ao6hlk=
X-Gm-Gg: ASbGncsdfGEc4ke3ynFnceFOzewTz5lICK4Um8ZRp6q5twXxWRcM1K7q6RIckPmWBiD
	nWAsJuHzd2OuJvDDruePRGWH7DzHFq4RfF0iJxm4//ClGsfhOCcFscg6W4z2P1IEgFVhJUYjbVR
	jN/kD3eyq17yiP+iFrzC7gRRdbJf2KIHs3Sw3i
X-Google-Smtp-Source: AGHT+IFqt9+K+LkkhZQI/j7j18xLXdUrgiOh381NANrLpi56JrycNnjHKVXe6M7Y/1XtbBF36GrsX8R3V2l5l5/ytlA=
X-Received: by 2002:a17:902:ce05:b0:224:e0e:e08b with SMTP id
 d9443c01a7336-22541628a67mr37018065ad.0.1741530068141; Sun, 09 Mar 2025
 07:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307225008.779961-1-ojeda@kernel.org> <33f6c73c-4a2d-42b3-b033-921d2e1eaeac@0upti.me>
In-Reply-To: <33f6c73c-4a2d-42b3-b033-921d2e1eaeac@0upti.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Mar 2025 15:20:56 +0100
X-Gm-Features: AQ5f1JpUGPAQ7z4B6Amb_zgIIluN1p4Baws9MpoHBcRwia-Wvg6nXk_7CSYTFG8
Message-ID: <CANiq72nu71ETyLpu=GwbzpnMJg3jetL5zSSh3AE+DoQDMgHAwA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 00/60] `alloc`, `#[expect]` and "Custom FFI"
To: Ilya K <me@0upti.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Alyssa Ross <hi@alyssa.is>, 
	NoisyCoil <noisycoil@disroot.org>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 1:42=E2=80=AFPM Ilya K <me@0upti.me> wrote:
>
> Hi, I think this is missing one final change, specifically 27c7518e,
> or rather, the only line of it that applies:
>
>  pub unsafe extern "C" fn drm_panic_qr_generate(
> -    url: *const i8,
> +    url: *const kernel::ffi::c_char,
>
> Without it, the build fails on Rust 1.85 / aarch64.

Bah, sorry, my bad, that is embarrassing... It is not just that one --
the actual remap is not there. Let me re-send...

Greg: no changes except for the 2 extra on top you will see.

It still holds that the x86_64 build still builds commit-by-commit,
and I double-checked that hash builds for x86_64, arm64 and riscv64
with the min and max compilers.

Let me also run a test for loongarch64 with the unrelated fix applied.

Cheers,
Miguel

