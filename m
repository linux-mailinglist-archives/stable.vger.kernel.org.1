Return-Path: <stable+bounces-188361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E5BF73F0
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896FD1893E9B
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09899341671;
	Tue, 21 Oct 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSDQFfNs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7B341AD5
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058948; cv=none; b=QDIpWWt48f/pJysFpfqr8sBQJZJQu1dL4+X6H4TUO8kaXSwlKrVw1/Pwn6yy1RetsLh/LVAV0QhxJJc/IqIQB3Xo0Yxc3D+g1KFlRGlYkFICWtNkY2oTYlO4PVGjzCFc/bB7/n9i0t8u8PxMH42HTnyYPmlT7+zs11jbY1Vks+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058948; c=relaxed/simple;
	bh=BJs6Ir9670bWClN5+YBMCCT/SwUup2iPOdwkLS4jjsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Watsa4i+sIkFiDjUYTpf8IqSnuxoepxstGI1+IRmkzpzWDVMwzmlb65lO7DO3iN5dY9uwjWSwpkggkM4awTqb5YS1SsOweNzWNk/H6PW2bomCVvD6OO9StGputfPfwpfTG7rL+DCrHgpdEtm3TzXbfaXWewMjBjC6wptzCAj/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSDQFfNs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2699ef1b4e3so9810245ad.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761058947; x=1761663747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL1NUF9v9eOhRL7BYek4+tEdXvWfoRp05X0T2l2evBo=;
        b=mSDQFfNsKIFyxaUWSMUbchvdV5pxUVUr1g34CvZFwwA/5Qm/ixZTicN55ourD6c5C2
         dnUorulj10Ve9+1SxKEJRM3vrluseKqGbZ/bge4KdCA763eUsLymQ6yGQ2yhbvYAP1Zr
         NHhVTNWfe65zW0h7wUzn42XhfRzpvTHyDr/PpALi9ZniKnXTvwT2npwp9jeVJYCRG6f+
         CHnFA91Q+3DIHpDXECW6JGBJxm2NtmPvyY2bcT8qzhyeT6w/4FUePQ4RKUbdXoRanwTJ
         UUiExb0QKOaJAwI/lmWOMPwz8Ngipt1F5nXUCzlBhCPJgtCD+VO70gbJXIGozBtHe93G
         +vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058947; x=1761663747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wL1NUF9v9eOhRL7BYek4+tEdXvWfoRp05X0T2l2evBo=;
        b=hvKe2GChdWR8O43BrwhlRezFLzYNLY642CbVlAxjkOJnFYstBWYQkHLeUeimCyOUv4
         O6keQ/mVU4MrECoLyNqzLCzleZsiYS6DHJ3caPkfgqLV9iIBWr2RmnlgpePdI0/s9E2z
         kRAQfpMWAWbYXHRJMHmQyFSfUtdCzgruAb1Y5J2ml0XKg9b2UDgH8l3O/obGT4ifCOP5
         4pUjrxXsDOLV0OU6LOHpo88SJj+qkXa0eW0OBXAPE8srp1TbHowmpk2IOMrG7lZql1+M
         y+D9LLCJf2dg+OKCYAej2xUZn2yS4J34jkFnIjiT3jz/JU00IDc3gI6GtO+B1LRMvK58
         MYiQ==
X-Gm-Message-State: AOJu0YyeFvVYRUIAwZ3zffWuSfKEovqgJCWfTKGxWo2TR4LRhEmi8fNs
	EFX/7tY3QSBQcB+WYloCsDJK+ceuIEGA8SrD0dYkQ+PCneOXh4P7Ng5VXGq2DsjxGckvh26Cqge
	+xuclw9IssgaIQVinJSHJhTRgR4VFU+KBMYai
X-Gm-Gg: ASbGncu2mZsJXmusLLtBgx81t/Ja8U6PF/TXjb09V92PTypF8wjJIihrYJBnZB8Jl6S
	A5BWai5qtrNgwZtmchU7vGcUSa0CCO3mHYyYw9xvahV99nxmGrcqEFF311vq+sOngiXBzXxf0Fu
	pi4pqOw069VdbgbvVGPuc/zYU+eJ8pBg7dlZM1zeognLy6IuN/DfcyE1xxBjhPMLRMfZRABdKDq
	t6tyqXzQZm0L03kTw7IixzdGtUf31U+c+P8B+Y/vxj9AOQ6BMP9QG/qecqho1fdwD4eGyNQq8LZ
	nzwB3arxw2RyqWtutw5ygXkXyJITfgPHv0Q9UjRBKslPAnUjwL+wxk+hPDkyTrih/yQw+vN7+UW
	ncUVnkfe1kdyL2Q==
X-Google-Smtp-Source: AGHT+IGN3iA250a5jPK1QuTk8o0uyzfB1B8Dw+jNR52vCCtVHEMefhckwvVweYdqqBYz5TtRbRhXJRJIGcR33KI2Vw8=
X-Received: by 2002:a17:903:19e6:b0:27a:186f:53ec with SMTP id
 d9443c01a7336-290cc2023d8mr127425665ad.9.1761058946416; Tue, 21 Oct 2025
 08:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021145842.2241496-1-sashal@kernel.org>
In-Reply-To: <20251021145842.2241496-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 17:02:13 +0200
X-Gm-Features: AS18NWBE_YloELBW71lfoBBgs0uKe2nuayynx_YTuiu4yvOOEyKFLmzYv9DGO5Y
Message-ID: <CANiq72=FCsw6HQvGjPqwQuN7SJsN=81KS4s5HQf1oAJhR5KhFQ@mail.gmail.com>
Subject: Re: Patch "rust: cpufreq: fix formatting" has been added to the
 6.17-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, ojeda@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:58=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     rust: cpufreq: fix formatting
>
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      rust-cpufreq-fix-formatting.patch
> and it can be found in the queue-6.17 subdirectory.

Yes, thanks -- with this one 6.17.y should be `rustfmt` clean again
too, like mainline.

Cheers,
Miguel

