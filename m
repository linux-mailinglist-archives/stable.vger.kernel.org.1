Return-Path: <stable+bounces-33842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B9892C11
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 17:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8AE1C213F4
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38EE2AF13;
	Sat, 30 Mar 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DOS+OIid"
X-Original-To: stable@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BDC31A66
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711817021; cv=none; b=UmtyRs4PCynWKA2+vQkCdaGF1xlethELnL/jPHUvxWaLtnYaEoGjMPQic2o5QgQ3aWkDcLsk17tTZpqvMRohVKfO//A6WN1Cf22fNXx2UDTNWMJDRHmHPYylNVrWRykV6rpUm/0V7SyoULxCIcV4G1J0VUTJEkH2ZBHHeBGmUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711817021; c=relaxed/simple;
	bh=ZFpvrxWSvNr6wqynleztpvB5AWZ9CKRmkMrNuTxQSPc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tk4QarmXJvUh3xrP/C8vYq3BhHwde3o+SD7D+ILH1UGusktgd+9BGZO9yh9Yj6lsWU1lLnq5YX9Ig23AZhjTHws6NPFDn0V23ClA24WgSeUJMeFO7di45eso9QLcHQ72qmH0v6aE8c9woZLadIl42q0ADehifzLChVYfyP+8rpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DOS+OIid; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711817017; x=1712076217;
	bh=ZFpvrxWSvNr6wqynleztpvB5AWZ9CKRmkMrNuTxQSPc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DOS+OIidn7P20S1+PyBA2B8wEmgtw1iVhxTRYxU1QGaLmJrGSr4JAJC1mnrWLIHpH
	 CBBQF15z3OZEgyGu+OYVT9h5bBE8NTI6zXaJdFVNzZNOICpEEar6NMGR0vAnXzSKTA
	 lpcKbW02EJ9Dbvg7wIjuqzzHmd3eW3YMd8+vFrygT6FD2rpbY10RrVEmnz+y6u+G3i
	 LCZSVHkNb2yqM7YngcwtISM0BSoMHeLAfHBx8goo24v+tDd06MMf5eFYCXkltwq+Tb
	 rVKuoaazYmhjf6D7ecuo/YrZjlD8cPLMRXPfs1DkjPhTrg9PIcVl0i1d8JsgzzY9Zi
	 oHhRltiCtTBjQ==
Date: Sat, 30 Mar 2024 16:43:30 +0000
To: Laine Taffin Altman <alexanderaltman@me.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
Message-ID: <96fc2017-7dbf-4311-976f-3ee5ae645e2b@proton.me>
In-Reply-To: <AA29E05A-DCA7-4857-8473-C183C50EBE81@me.com>
References: <2dd2c052-0d1f-4a77-9fff-1d6db80310e1@proton.me> <AA29E05A-DCA7-4857-8473-C183C50EBE81@me.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.03.24 17:36, Laine Taffin Altman wrote:
> I=E2=80=99ll do it myself tomorrow night; sorry for the delay!

Great, and no worries (it's fine if you still need a couple days)!

>=20
> Thanks,
> Laine
>=20
> On Mar 30, 2024, at 5:03=E2=80=AFAM, Benno Lossin <benno.lossin@proton.me=
> wrote:
>>
>> =EF=BB=BF
>> <mime-attachment>
>> <encrypted.asc>

Sorry about that, I hope this one is not encrypted.

--=20
Cheers,
Benno


