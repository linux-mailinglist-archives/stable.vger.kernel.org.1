Return-Path: <stable+bounces-195122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF9FC6AD75
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 18:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 475252C211
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609C53A1CF4;
	Tue, 18 Nov 2025 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAXPsQbV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB53A1CEE
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485822; cv=none; b=IGL5glAXpcf86meVLayRiqJfmO1NvmRgIhMzm4uBQx75LIh8UZbOs/YG3yG/fuabN5v7dt6cjuSQW/c/W4/mUdzgs11JhWwHQEQhr99N7RnZivwZJ2yxo31oOxprINSD9IVAPAaAbKSSapOaX1eenz3rcCMQ40HRRVdVB2u5db0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485822; c=relaxed/simple;
	bh=fslPMipxSHFdlEZigkiX4J0tsOkkEBsME1Uhhnj/iks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJAccoyGW0hyjNdgGzwYHuIgn9bQpmA9INSuMYyI1tvWEPB7pAOMXibKJ33EpEpKOsNWR5fGFzFLPB4snhwrdn4wA9FJW3NpBsiBYUSiuS4BBNeQ9lxajEJlhsxsiH4FnOLL/xXXdmPckbs1UV/nmxIAEo9XPVyXmSWwrEzfNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAXPsQbV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297f5278e5cso8433705ad.3
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485820; x=1764090620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fslPMipxSHFdlEZigkiX4J0tsOkkEBsME1Uhhnj/iks=;
        b=iAXPsQbV89zo7GjVESB4hHnnND/3he9CRsiyf/P6WPpoM0ltonatndiIzN08Y/ovUt
         2zFERXxtvP7iP+Fridbxm2M7wiK2wdaw1jMnvl0juI6ix5MoLGoQF+oFZkdeQmcoqQbX
         u9axRbmLxcJSwLd4rBIPe/d2i8FrGh24KbqvKNDX/PtN7XdtijQG8zYYtnLFtru6agPm
         +VD8X5hamXj6ip6zyIwg9wHVGieQsVc54rU0RQTT53dpH1jRVeuQymEB/9Rfn6LO3dOg
         DHHbNZrVKKNjRwSzhIttcGlXpCEqPGRWJ42j6KdLsARPnfX4ZsqTnUr3C+P/6dKda8JR
         JywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485820; x=1764090620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fslPMipxSHFdlEZigkiX4J0tsOkkEBsME1Uhhnj/iks=;
        b=BCLqZhC8rWTaeQ4cx7sqk8ekDPdUrBE6a6ZAhmXUrHIxWQK+3sgIP7ot0nf3QPxHP2
         kB76wEExG0BlYHsoNKA+qIzcdLHjTtwj5rwPLOpMGc8Q1eroSf0rLF3v/AAnxB4/x8mv
         lHyKS6vvok9lVG7UDNtPq+GSqd9Eewg5wl+Vaq5O5IMNcviTxmRNpfPCxZUmg5XN7LAG
         qbkjgNmHqhR0tDOh5MncGrv/WzYhNMj4P2SOpUy66CYNeKbNfL1QmOUzEdmGrKPk5j4u
         plnuUA3XL5bdShPjKZ/lukPBv7EKi4F8DfB+f5NjkbPLGKi4c16Es+cHKzhnXZ0BSWEz
         JcvA==
X-Forwarded-Encrypted: i=1; AJvYcCWr+vx+8VXkjo4KLe/XgzaxsoaF6SB1K8FCh+g8AB3wM3CegT7o6MFSG4SzBEBJwLKtPk9p77k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PLXDyoxFioA94ehEOU1wmWxvs/R6aZ4XtMpVTqiI/P0xrbNw
	Dg0K7MVSuJ6kDyYyCPDg2OHqobpn5PANBfjC7eoLj1F7MJmtZqpBN0bKMpDbwHl10KNkHi6FT0E
	Ogy371S/+RuB+SqpZ0GGkgzXacBNlNwk=
X-Gm-Gg: ASbGncsUcTUR6//3jSmXubS8+DF7izNltweMqcaKVcMwDfKOH5YEwq21Kb4JubUWkGf
	pGnJmjjhlmiG0ha5aPJ1fEPPgGiFmEcr0OFSJSfnPf3209yCtfjSbl/p9NywFjIueSu01YczEJ4
	9F33CKyuIl/ytF0+cw9qP6AC//4ZFmrccYxpJRw6FvRmZ5GHGUGPVan00ZLYRcpTJBc+B2P1Ngq
	Jsdzp7OilFmdteShMiuP7q8ZA2HJIdF43Yas+FPRlcrDs1OFbcs1yZ5GBXwRtRaWWybnVBcgywd
	QqBPMl6qDjJdWwrYiKVQeqnxKebi2gTO1qJheTWxY6djq2XrumhZ8eogxRmmMUxQTtaeuFcscoh
	9HvMeSi8GjvhY7A==
X-Google-Smtp-Source: AGHT+IG87WbBUsF3x/zF+o1Qu2UZcBiWl5amIiz3Lh5gRGa1HIv/hRj0ixT3na47lf+qzvGD/5GVRs4gchDNGH2A+EY=
X-Received: by 2002:a05:693c:6017:b0:2a4:4862:c97a with SMTP id
 5a478bee46e88-2a6c9899146mr825330eec.0.1763485819789; Tue, 18 Nov 2025
 09:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118072833.196876-3-phasta@kernel.org> <CANiq72md+0Lerj+kqr6QiU6ySR3XjRzmuBiLjkpWWieM72wyeQ@mail.gmail.com>
 <4db9dae5f659512146bd441cf2edf5a4aca16b93.camel@mailbox.org>
 <CANiq72k_ez+M_xEJaDCKS9uSbzHd35osnuXjGqZf1jq=sM_uxA@mail.gmail.com> <d31b24c850957c9026c9ff12ce7d0c9bbf26477a.camel@mailbox.org>
In-Reply-To: <d31b24c850957c9026c9ff12ce7d0c9bbf26477a.camel@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Nov 2025 18:10:07 +0100
X-Gm-Features: AWmQ_bmPc7Pdxa4HTqMeTreIcWd1c3f64ytsv1JIBsPJlKm0HOVfUtoJNp9n-KU
Message-ID: <CANiq72mKH2oxcWHGef++Vw6Y8q9Q141KSu5AvA30a4j2W96-Og@mail.gmail.com>
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

On Tue, Nov 18, 2025 at 10:33=E2=80=AFAM Philipp Stanner <phasta@mailbox.or=
g> wrote:
>
> It *is* absolutely common, or at least frequent, and you are the first
> guy in the entire project I ever heard complaining about it. Maybe it
> is often used wrongly or unnecessarily, though.
>
> But no worries, be assured that I will take this detail into account
> when working with you.

It is not, and since you seem to be keen on making an issue out of
this, I took a quick look.

What is actually common is using Cc: stable *without* constraints:
~84% of the cases in 2025.

And that is *before* removing the cases where the constraint is actually ne=
eded.

> So why then do you even suggest running rustfmt? How should I make it
> check the formatting?

I didn't suggest running `rustfmt`. I asked to please double-check if
that is the formatting that `rustfmt` *would* use, i.e. how those
blocks are normally formatted elsewhere, precisely because the tool
does not format it here.

Now, it isn't nice to try to frame things as if the issue is with the
other person (with remarks such as "first guy in the entire project"
and "when working with you").

So I will help you no further.

Cheers,
Miguel

