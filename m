Return-Path: <stable+bounces-69713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FF69586D2
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 14:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B03B25774
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A314218F2F9;
	Tue, 20 Aug 2024 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7rb2rrF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DED18A6BC;
	Tue, 20 Aug 2024 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156612; cv=none; b=DUYZER3JTsrcllvVsjaBQvFc+TmDOPgvl5QU5rAi/18/O+BxxS0cK4Mgx9guDBJYuEUzmU0abUvLLQhNtZpAzkmluaJF7Ia8w2DoAVoqwvD6O0kx6zzOvKqOW7wPfWF44gIQ+hIgpnlCezwwTw9bGs4Pm94zaWiRH88GqUQJ/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156612; c=relaxed/simple;
	bh=g+GdkY0+g6ipSrrWAIZdnVGE2RX5KXWWZi7rwdOp4tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCpwL0a/fHpMHatuKASoZhEz+nvFfXj0Gx8+Y+gfmLwxvVHPjjlOk8v7bnRnUTTMb2W03JnTdXhLj0GXk4mwlj9+xcJHpZM3aq8xXrimtwJnFPIbA3+rIjO57BY40jNFOqRbAgxBaMMFLHT69SKYWnK20mMeoRZYZVdMdzlks+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7rb2rrF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso353853a12.0;
        Tue, 20 Aug 2024 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724156610; x=1724761410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeGezspaF0RbcCLq8YWLfxysx3omce87Ydb/Fu8hfXM=;
        b=V7rb2rrFEAG9jKHVVeahUhJ/4eMQo4v1nSYl7wbxLeA8Xak3f/T4rlTQ1+NHVZa7Gp
         U5DXQ2U80xfVDE0vBOSEYHkFfG7Wow7My0AU5WdZRiOv/Juvn/zxezIEQ7fIaJEpJcft
         zFadQaDIaRe+NLfTeW6wvNZ5OIc3qZk3s4M+H0DOhypNuUoNOAXOuRZzlJkcdLCPuZMf
         t/EiH4nuvrKC/+8mIUPem710AbbTn4cxKjrxeaUvD3ayvOSNVYwfBgIx2lMPgXiVVyHJ
         mSgSZiHUFANtxND3tttv7PUPgPzcu7nB2zrt45hwx0QAt6KQVs+hdATC0MFNCY9TEpLx
         AnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724156610; x=1724761410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeGezspaF0RbcCLq8YWLfxysx3omce87Ydb/Fu8hfXM=;
        b=Oy739SIXky+a+vpIFz0UM+sxdKCn14EpakolNzEvW+z52UWVX74kUdji8/7ogm6aJi
         XHXhI4fnO+cknwLdgQRJfm8gx5THQGB9hZ6JG3aYduT/AH1hbmM+a5ZyQHtx+pEhwsNE
         wKNG0glVYubeGH3X9Lm0cjP2KgvwWcQBRjwh8A0wxT/ZKkX2tf+Lt6R057ZWpcqki7ob
         hQCedUNBpipZtNMcgrjTz2omXqwaMFQqSGMmVcCo0iakMyb30JYkA7X6A07s4niilKf/
         LF8vRDPTjeSdgOLb7UrfZqPmF9D+tXEuVdQtiKigxORbHSBPoEUVz2DKytSU8btS/v25
         1mgw==
X-Gm-Message-State: AOJu0YwpBjfpKToSlw3WUET2BF+vt9ECNwsVxP4v5v5fwP2qTomGA9gC
	UfT/GhJdNoxS7qJALSQ9vewXk4j4wIMCyrk2eWLphbaW0GlKdFkDdPxGn7ghDj26cGSRhZHE1vv
	lDoxtIgXI2D9cchDtixmByvDrlYKHd0d5
X-Google-Smtp-Source: AGHT+IHgJqPsD12drm5l3caUlrcxYyZ7Ks2ndGmw0VE0h5VJ42RvlKQiPiDIy1lIljqlfvh7Oq8Poyn9wDB+HPNQOqI=
X-Received: by 2002:a05:6a21:9999:b0:1c4:92fc:7c79 with SMTP id
 adf61e73a8af0-1c9a1e9bd0fmr11050581637.5.1724156610228; Tue, 20 Aug 2024
 05:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820120424.2975898-1-sashal@kernel.org>
In-Reply-To: <20240820120424.2975898-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Aug 2024 14:23:18 +0200
Message-ID: <CANiq72=Zxg9mZ29yES0mH=nZ4k9TT6kRm-VTBscgg2ZMEjYtVw@mail.gmail.com>
Subject: Re: Patch "rust: work around `bindgen` 0.69.0 issue" has been added
 to the 6.1-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, ojeda@kernel.org, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:04=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     rust: work around `bindgen` 0.69.0 issue
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      rust-work-around-bindgen-0.69.0-issue.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This should not hurt as a dependency of the other, but just in case:
it does not do anything and the comments may be confusing, since we
pin bindgen's version in the stable/LTS versions.

Thanks!

Cheers,
Miguel

