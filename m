Return-Path: <stable+bounces-195090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C5C688FC
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 215632AA20
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 09:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611CD311C1B;
	Tue, 18 Nov 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HwCqNjRY"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350430F7FE;
	Tue, 18 Nov 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458438; cv=none; b=SKW4yVbljz2JIoCwixGl2/kEnJMoliZ8IPBXU15euG0xCF4AvegRScjCQnShhxKHTSnHTt+a3wQnGjYqKy0s/mtbQSkCcsqmKjnSu4+7wqJ9E+xozR68ERDO7covegC0uHArhsa+L+x5S8BXfEfXakjRBTXU62p/5aNj09jW/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458438; c=relaxed/simple;
	bh=dW2AEXqk6P2sXmyjlacrGHM1NhsZMhFn/uNFvTWRm28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JEjNzokA92YSsVrMrNY7bFcijRzLhx1nqCTwRwLx5G1HhdyXYy5I/q081HEPlSdGPLBX1DEyX+Rd+g/DxQ24Mx6Ft0PK9M69c25tPxI/BNYRdA4/cfHTpIlzdubS2L2ad21wQt2GIEQ44f91OAKR0IjXY0jgV+ua9Dc34lx+YP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=HwCqNjRY; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d9fZ23n24z9v0Q;
	Tue, 18 Nov 2025 10:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763458426; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dW2AEXqk6P2sXmyjlacrGHM1NhsZMhFn/uNFvTWRm28=;
	b=HwCqNjRY36Y3Pv0+GnBUXrvecLeQf0Aug7gAOuC9eLINkOIiG/7wnuZ9ugpDpd+4+aTyCH
	+uxlz01T530YG0/UWBnUSfSWNurLzrpAKHpjWC/g2t0vqSMedMMRvW/QO7+utq+ALezUCi
	Ai69AuuW+mjRv1siX0DubeKMYTqbn8sXn/OF6jDgrcLtudpA02ogVkF3KslyrfMpDH7GDC
	Vh3zV87BBzHyB+cKaSGgO4ukRac99w4dgJkkGNbQRY262NlxadwsT/rwP1uM0CadrhKHQD
	GF2rpVP3NFwo73Zx70u4KH4Vcd7RURm/O+espVim2/TwwY1XQ1D9hMSjI/BrpQ==
Message-ID: <d31b24c850957c9026c9ff12ce7d0c9bbf26477a.camel@mailbox.org>
Subject: Re: [PATCH v2] rust: list: Add unsafe for container_of
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Christian Schrefl
 <chrisi.schrefl@gmail.com>,  rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Date: Tue, 18 Nov 2025 10:33:40 +0100
In-Reply-To: <CANiq72k_ez+M_xEJaDCKS9uSbzHd35osnuXjGqZf1jq=sM_uxA@mail.gmail.com>
References: <20251118072833.196876-3-phasta@kernel.org>
	 <CANiq72md+0Lerj+kqr6QiU6ySR3XjRzmuBiLjkpWWieM72wyeQ@mail.gmail.com>
	 <4db9dae5f659512146bd441cf2edf5a4aca16b93.camel@mailbox.org>
	 <CANiq72k_ez+M_xEJaDCKS9uSbzHd35osnuXjGqZf1jq=sM_uxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: c7701d4be713fefdf60
X-MBO-RS-META: aaey8q4p697xsqx6998mx936c1ygriip

On Tue, 2025-11-18 at 10:00 +0100, Miguel Ojeda wrote:
> On Tue, Nov 18, 2025 at 9:30=E2=80=AFAM Philipp Stanner <phasta@mailbox.o=
rg> wrote:
> >=20
> > It's absolutely common to provide it. If you feel better without it, I
> > can omit it, I guess.
>=20
> No, it is not "absolutely common" to provide it in a case like this,
> and it is not about "feeling better" either.

It *is* absolutely common, or at least frequent, and you are the first
guy in the entire project I ever heard complaining about it. Maybe it
is often used wrongly or unnecessarily, though.

But no worries, be assured that I will take this detail into account
when working with you.

>=20
> > I ran rustfmt.
>=20
> Yes, but this is a macro -- `rustfmt` is likely not formatting that
> code. In formatted code, there are no multiline `unsafe` blocks that
> contain code after the opening brace, so it looks off.

So why then do you even suggest running rustfmt? How should I make it
check the formatting?

