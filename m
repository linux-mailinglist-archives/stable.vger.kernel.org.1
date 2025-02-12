Return-Path: <stable+bounces-115081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712CCA3329A
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 23:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E1F167170
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5384E259487;
	Wed, 12 Feb 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvuWtecb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC24256C6A;
	Wed, 12 Feb 2025 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399388; cv=none; b=SeWwTLCPOfABDxJ8FDY4bwe60bMTm1bC2W89s6dCvrCu0yAL8zJx3kkSJ0BfmBXcGPPnf+8vZflg2fMM0v+I96JJCcRypSoKH/hBuIfwsLXKs2atDa7RY3RZV9cmo/RY8QTGhz5vIT+tnSGAoCKex6brjP4hd9jIFUN9hxUCo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399388; c=relaxed/simple;
	bh=BFRXywWhuF494EJYNCYLCR8TnlqDFSbUwgsOkRXCO4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP5YwC4724YKClr1A8paN00Tck25Bnq4TAgPsimhjIAodQnDY+JmMcyrxUs2AptySCTKCwCQBiUuom2MjbfJ1XD6vvlxCBH1TFL4T0/qRcHWLPNHp7QCptSEPemPRRmISIfrY96hteloBcIukqtRH3IGUq5lIiKn5nXTNipnbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvuWtecb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so66678a91.0;
        Wed, 12 Feb 2025 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739399386; x=1740004186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ/n9bqBDmoNTEbi3+gOvCn9UNpfuZOs7Z4fB5U9DNQ=;
        b=BvuWtecb6kwLy/tpZGDWBoCq27CwTWKSpev4f2IXb+08mpiJ52EQDKAOd2uNHR2SVc
         fbU766Tr2ZuF6+yh9Ra3DuTJDc7vLdwpj2A7G0T0v1k+QruVBzidUkMaWuNzoDdApsSA
         RojYGZu0URpuhlybIONfUU2qokDFd4aSnfzmO8klq9T2gbWUrptNAS/Ce60waMy8/nEh
         zcFLf0XSwMHEWvx06KJF3pg47Pd4FERrtNxnFcoLdtk7Q3ZBGCUuxolyNsszn2ozU+xy
         SfHaxD+KtCxVrX1o3KOqiWSLDpFUm0WBr4Ln+T6Kt/9m+VoOsxX/hzk6OZrTkRB0u1lu
         gpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399386; x=1740004186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZ/n9bqBDmoNTEbi3+gOvCn9UNpfuZOs7Z4fB5U9DNQ=;
        b=FdDAdYj6tFOq3yMPTtVzDC5WI+GgmtYfGbf2EPi1UqQ8GTWaeDN29pW81pmRObftWJ
         p5pPDlHoGdUl+okl6mprIOWY1ZcpbrFqTaA1dDCOX+U2zLn5QBMMC4QjGzP4ffc6tnrw
         CVKDwgdF7dZ7qqDQ95s5ycwV1VcP01A+fb9OoDAUPcocyE+i/Rmf9WAhrSw2iJEz1UPz
         5v48iJuUo2XzX4y5XWebHr94ArkahVE9B8rPGvSYlaUh0oJBuiVleu4thRRXbLB2AV71
         I5DWzge3rBpFONltDreAi3tUMUCZG1I7DRfxmwB1aEhQZc6vVFfjKwVGuyyncnWzY08/
         KjeA==
X-Forwarded-Encrypted: i=1; AJvYcCVcs3oYuL2NNMJLpDqcd8ojyjxgOq+uRT+5k7x4AcVp4nnpQ8Q5OR+z92XuWLTTTlZOswik3HICdw7d/Xw=@vger.kernel.org, AJvYcCW5cTiejgec5mOfy4TymQx8B6Ka0ENXpcn0A1yQSwH1CZhjWF4skJ88NzQwervemLX3AWxlPgu2@vger.kernel.org, AJvYcCWgrZVz6Fr1FSFyzhFnQm/EneNm/JQJX213pHdj097HgvML6UjNCK8PUR/74OgKNlyW5RXPCMCk97egXmc+HOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAGpPY9aN5BnDS2m6tbEcXUmxh72lnmIf992BcVfWhPURuhKj
	ogTRhV8+NCKRi2zVXnruP5ug4I8RRAminBNEVYlDBvcnCOu2Ywzbl6+zsxZZp+lz3C//ZWqt9jj
	EEEhOrhPaJhIk/8zCyu56fTNmjrc=
X-Gm-Gg: ASbGncv2Zy31GkdfGsdR0u9g5C01Jc955Sj1uAWb352lLX5dWM9GK15CpfwV4DVAjrF
	lds6xchVM0Ewwj6aUtDSlhoWWA13iF2YBsJO2IxBZYkkcXuqFFshlgWHcJh7xEH6fT+j+3iYM
X-Google-Smtp-Source: AGHT+IHadNrgevyrSkaQZhOhsxlrzLkSyiZy1ey/P41VMurfsqDNouU1k4AFyaXrZKXXjkyODVF3l1r5ZtwFJzNg/Tw=
X-Received: by 2002:a17:90b:3b52:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2fbf5c8b19amr2771748a91.3.1739399385115; Wed, 12 Feb 2025
 14:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206232022.599998-1-ojeda@kernel.org>
In-Reply-To: <20250206232022.599998-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Feb 2025 23:29:32 +0100
X-Gm-Features: AWEUYZnuk0VGL_AzcBee1c5Y4k5tHfvfuNR0sTon-_manIWBu0BxLrpeWaavqr4
Message-ID: <CANiq72kCKgcp6f-K1gtKdq_O6UkkC0A8WmZ-vGGGepvQHT3zLA@mail.gmail.com>
Subject: Re: [PATCH] rust: rbtree: fix overindented list item
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Yutaro Ohno <yutaro.ono.418@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:20=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.86.0 (to be released 2025-04-03), Clippy will have
> a new lint, `doc_overindented_list_items` [1], which catches cases of
> overindented list items.
>
> The lint has been added by Yutaro Ohno, based on feedback from the kernel
> [2] on a patch that fixed a similar case -- commit 0c5928deada1 ("rust:
> block: fix formatting in GenDisk doc").
>
> Clippy reports a single case in the kernel, apart from the one already
> fixed in the commit above:
>
>     error: doc list item overindented
>         --> rust/kernel/rbtree.rs:1152:5
>          |
>     1152 | ///     null, it is a pointer to the root of the [`RBTree`].
>          |     ^^^^ help: try using `  ` (2 spaces)
>          |
>          =3D help: for further information visit https://rust-lang.github=
.io/rust-clippy/master/index.html#doc_overindented_list_items
>          =3D note: `-D clippy::doc-overindented-list-items` implied by `-=
D warnings`
>          =3D help: to override `-D warnings` add `#[allow(clippy::doc_ove=
rindented_list_items)]`
>
> Thus clean it up.
>
> Cc: Yutaro Ohno <yutaro.ono.418@gmail.com>
> Cc: <stable@vger.kernel.org> # Needed in 6.12.y and 6.13.y only (Rust is =
pinned in older LTSs).
> Fixes: a335e9591404 ("rust: rbtree: add `RBTree::entry`")
> Link: https://github.com/rust-lang/rust-clippy/pull/13711 [1]
> Link: https://github.com/rust-lang/rust-clippy/issues/13601 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

    [ There are a few other cases, so updated message. - Miguel ]

Cheers,
Miguel

