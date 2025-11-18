Return-Path: <stable+bounces-195080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1FC686AC
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 10:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F20C9367929
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA94730DD22;
	Tue, 18 Nov 2025 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaWfxnPb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B401FC0EF
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456437; cv=none; b=szpEyspGaAm8pOy9hYGQpq6zCXqTSyck20AqYYnQ4jrsX5OcdklvDI0LEEFESu5nt9ceXvtm3HzyvsPucZfibmFJDLEK7pnhrbNf1Nk4u8im++dq/LFf6t/WP+iaar7yVpHz46O18TQuHpF6M5gsVnUUO3UPwye0PE0dNi1/zrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456437; c=relaxed/simple;
	bh=bfBS4B1cFVXph0/HoluC7HZmxTuxmaD6b1yYGsefgw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPiKHF0jYxGPJ1Z6bk11aYE23D8DA8CMz3IzSnEwyxhx7b6yRDBdh8DahEafg9rUOGl+d7iJnmZO/lug9JHELt8Utzl/Rxx96hBaj9/G8lFv1DO21Clxz1G1vEqM7HPQql6zpPqtwOPp1oJ7dYn1bSkmaXY0KUg3Ms//KUhRR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaWfxnPb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-299e43c1adbso2783925ad.3
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 01:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763456435; x=1764061235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfBS4B1cFVXph0/HoluC7HZmxTuxmaD6b1yYGsefgw4=;
        b=eaWfxnPbSzvWiei2c17AEcj9CylNSm+VccpByLZmiIapDiIPHNTtu37nwRt8UzIdsE
         xnyggUNc+zqEHAe4pzBJiPW6rmZ8f9+tetREyVmQC8eNmxx0lTbhLLv9O7NGlYQ9BALH
         mVBZXJrOuVTuFJvm9NltuPuutynESbKfnIM0605jV4XKVzkX0UMXw+vzAL0Y5UIlzr8F
         b5wXucGsTwcOHzamODBiSPJie4NthLMWFAFBBcFL0ZfIZ71N2RSRlcbaW1HAZYyyEYIC
         1MXBqxWnuvn5oe7BdN59SSLX3M+vCVdmheNe3FIHspF5BHpjdDPo2C6iCYEyqSrryPTl
         uykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456435; x=1764061235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfBS4B1cFVXph0/HoluC7HZmxTuxmaD6b1yYGsefgw4=;
        b=eD/s7pEj0U71xg+em5Ng4WjqCWGuMLRbVkEJgNxuapGxyKMmqUPMls9KRVp38ekMZK
         kLvxPGctZQkOoZTGEvxMSn/LXh8dQVUXMNG0j9SWjLfbVv92V479sqHektLuSQIRMODE
         /e+e1UNBsf5CJzcoIDkDs+67ae+YP7LJbtBTPk9Ei1DeECvIY9lGikSraMTyltmwy+nI
         fL44gRv4J0cvA2IfCFMjnf3HmKi6XkMIS9B3HDo2cnOcrX4eJgJkS42VpGArx1LS0d/e
         OX4HrKH+D+wETFcPtym7LgnqnwdVqMjHzn4ucwAJt+o79ZLZE5TbGFLYt56v8r5C/X0n
         Za6w==
X-Forwarded-Encrypted: i=1; AJvYcCUQWYhzP5xZic2akfQtwqLb2MSbX+PtvDYmdjzh7bvjtAyBj8BOFoLTrXY7/NvvB7s830HObsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYEHkpSS8Wjr/w7G4i0TpYB65sCKedAktGfCKR69iWasgTR4D
	zFHV06OQS1iUaLbKk9lPyM0R702LMFZV8N2de4ILYUGrT/pQkH2y+peKftQG/FdWbAgG0Ql6EnN
	LzTk0ejkZRR78NjdM13MOcyxWu5xZ33A=
X-Gm-Gg: ASbGncuvooy6hldIX1KHKDUmBncIoLjZNc79woQYCV2B/Y54TsYi9Al13HzI5Rz5dtC
	9yC79e32DW4usfSMnMN3oRxAYTMrGZsPo1V7o6FRlhhipquhMEUqg2tCikML0Xo+qtRCLoJugMB
	jbWrNf+Jt2MX6AybMX78v/naB7LGpIUsfzcgarflJCtrz1lNIDFy9kT5TUBQArxL/uU3cBpPGOJ
	EarWSBIgOwADK6r1OJhR5AexunRDn77apMva3JK+uy2epnDxMpT1py+a4So16B3pqurMZMfy5w7
	aU83F7ZGs+c5ICnJx+i+J95OT2N/EKNCYyJ77cd5PPlVBtYO3TQ3mfE3us0UkYI+tI6ugsC008u
	+w84jVm6pJu/xjw==
X-Google-Smtp-Source: AGHT+IF+XxSaqQN0TKooaKualkKFdHU+4N4g+aXk9v5r4izolXbnH7pTq1RHmcFFhIlh2QE4yrmkB4O7KyrtosqcBxw=
X-Received: by 2002:a05:7022:6885:b0:11a:344f:7a74 with SMTP id
 a92af1059eb24-11b4120a7cemr5943075c88.3.1763456435186; Tue, 18 Nov 2025
 01:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118072833.196876-3-phasta@kernel.org> <CANiq72md+0Lerj+kqr6QiU6ySR3XjRzmuBiLjkpWWieM72wyeQ@mail.gmail.com>
 <4db9dae5f659512146bd441cf2edf5a4aca16b93.camel@mailbox.org>
In-Reply-To: <4db9dae5f659512146bd441cf2edf5a4aca16b93.camel@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Nov 2025 10:00:23 +0100
X-Gm-Features: AWmQ_bmoKYvqTof5S0Dhcc0_0ej1sv2c2-FmRF0gCVNccMMPRwgcbsgBfjDeqrs
Message-ID: <CANiq72k_ez+M_xEJaDCKS9uSbzHd35osnuXjGqZf1jq=sM_uxA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: list: Add unsafe for container_of
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 9:30=E2=80=AFAM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> It's absolutely common to provide it. If you feel better without it, I
> can omit it, I guess.

No, it is not "absolutely common" to provide it in a case like this,
and it is not about "feeling better" either.

As I already explained, it is confusing and takes more time to review.
For instance, it made me double-check why you wanted to skip some
versions or why the constraint was there. Please understand that
maintainers will need to check what you wrote there and whether it is
correct.

It is also riskier for yourself, since one can also easily get it wrong.

Those constraints, as the stable kernel rules explain, are about
sending additional instructions. It also explicitly says such tagging
is unnecessary when the Fixes tag is enough.

So, no, please do not add redundant constraints when they are not needed.

> I ran rustfmt.

Yes, but this is a macro -- `rustfmt` is likely not formatting that
code. In formatted code, there are no multiline `unsafe` blocks that
contain code after the opening brace, so it looks off.

Cheers,
Miguel

