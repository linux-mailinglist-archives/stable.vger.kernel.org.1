Return-Path: <stable+bounces-192766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDE1C42500
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 03:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCFA24EDE11
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A929BDA5;
	Sat,  8 Nov 2025 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Pz1O8f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2028312D
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569447; cv=none; b=JHoB9VPhCbC55Sa9onnY2TbRzdhiVFXQD2hnj4tqJ+Zv2EndMjYO6iIJj6fXmPcyVqXD6g3akkBpL/v0QiXDe9on18UKadYCBozLiEDTKQkBf2nJOiUX1qOvoGDPrxxVawuGxdt41ma+gS0wyir921zQ//sPB+mALnKskxS6K3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569447; c=relaxed/simple;
	bh=pZs543aQJXGBiZv1p3fT4nEMYNcLibbhNgR3xp64diA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZafAlbImp7ggpCGHZeZHUdNnGBHzaKNMd+5MOM6MMg+TWwnY2cIR6+4BZGXPONFeOx1MOVshC3njm7G6n3/wOda1pdoBr26DfnQvFafpVVkJ9fx6KovOK/j/S0WYIlI9t7yHTz0goFqmvQ2dcTdd1BjAfIezSIuryItfo5+rblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4Pz1O8f; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28d18e933a9so971665ad.3
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 18:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762569445; x=1763174245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZs543aQJXGBiZv1p3fT4nEMYNcLibbhNgR3xp64diA=;
        b=D4Pz1O8fBgxVfdLn0kGOEPXb0Nmg76AgpJ/stxFpJ6/vKMwRMy+tyE6VHmRef8yl5a
         J8sC7qAT32BKsKL2K+sbGtrDuSBnfDyI+7SfLKNmzGRO1uevSAXTYuv26lKUoFrw8U+Y
         B2iSh3SbPRyQIzoTfh5Aufl4OIfIF+RhjQYQT4e6cxaOWLx++qhEZNySZlLeQCZLhZTr
         JlJy7lOhCEQfh97v3Fv6CRy8JV/mXtkpggFW37TBz99luVoUGN6om9GQHH+RO930XbnQ
         R1Qp/PmzrTRGrjz9+oDbKhBd0qSgwkzT7MHKilazuxuiRpEcpB6Nti0nr3KLk1Y+q/5D
         o6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569445; x=1763174245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZs543aQJXGBiZv1p3fT4nEMYNcLibbhNgR3xp64diA=;
        b=baZgwXiiao5f04T2qmMYptnhmFW+DaFCSqUujvhPf4ZEr4jjR5G/Qr2YKY5sUoHl//
         c/uUTI7XZSkiD0A8vIj/2XhSsyS9xUWnpiuEeRpUf9QLwj9JXY+/r0fmptu9TqOufVQV
         dfDdLMNHIFK4zNhrtOQYADPIA257E0r8mD3aTli5iflXwATsAGgX2WycjuIPjUKAP50o
         rypIH81KJPJngeE4A3ZpM6sY6cYDM4XIgCPHbBRUQDi/58m9ti5tpBudTRMwQ4rdh3Sf
         YVYbVWJ/5040Xca35B7w5HeOvUFzs/irRpQMw/RfijmyHLObC1Eq6BpF84gzY92R5wKK
         hozQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZrMslJiD/CY8cJKp5Pl0nSwgP9sPPIJlIi90NeR61/P2sdxKpTpteVYMg6cXY2ALbA33/TgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZLlHLsEkcEyCxz5eg5h2zD1xUZ1b6sQFCxxWS/5f5LCQGj+cY
	o+uZ37De/P6CH+W4ButuqrNu3scEQuPlkwL7DaF2jwE8+4QE87d74a+ZVaDkXYq2EspEbENs54z
	kvF/suUC7IiFDXID2qjicqEEyX3P1DoA=
X-Gm-Gg: ASbGncvLWU6OyoNsyGqBnfce/eJ7P2xodBIgfTCtLEgTNuMN6CFRadqjZAw8KYrS7Uk
	+ER4TsAxgF98POyX876DoBIGKEyt3PZXL9qL24s1BFmWdi0SsCqhSTnUUEn1/yn/iJm1UfmNHOF
	+dAGHWv4uKgcgsFC/tzbNeKwJwFQjE8OyH6p+Ej/xj95TB6TKvAF1ssy4P8xeIceK+uiIKGJtz4
	AWp8A5oX20rqSE3pEc9zKJwJtV6JnFOpOgZucLKIvIklikvlfB3IlVKQNOYtup4MbKleK8rXrWA
	KSCj3WJVX2CruyU2ZcHonoHYPIGnhsfIs/HC2uoJKQZmn0M6re4sBkBkKvkkg+YqHpaV6I2dKE7
	2jeBm412w0u//Iw==
X-Google-Smtp-Source: AGHT+IEovvjVicfDdGQT2CYmrDOWKJSfWNjNZjATvixUw1CuI60OG2r2rmWY0cQTlJoWG3OL54m2HoMu3xt+gxb8f9U=
X-Received: by 2002:a17:902:c409:b0:295:3262:c695 with SMTP id
 d9443c01a7336-297e5646bd4mr8325045ad.3.1762569445056; Fri, 07 Nov 2025
 18:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108014246.689509-1-ojeda@kernel.org> <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
In-Reply-To: <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Nov 2025 03:37:12 +0100
X-Gm-Features: AWmQ_bkkl97L4KdKe3MLMAG94NJvyqaB6LbDFgvfVIDBf_nqC8JcMtGIqLcDcT4
Message-ID: <CANiq72kWWe_w-0088SiGvKFrh49P9wRcPxQvkSoU=SOpSrHbKQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: skip gendwarfksyms in `bindings.o` for Rust
 >= 1.91.0
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 3:30=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> With `#[no_mangle]` may be more reliable and it also gives an actual
> exported symbol.

Or `#[used]` to keep it mangled since we don't care.

Cheers,
Miguel

