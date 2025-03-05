Return-Path: <stable+bounces-121091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADE6A50A53
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26DF3AD30C
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9625333D;
	Wed,  5 Mar 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYVfNlNU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A824C062;
	Wed,  5 Mar 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200736; cv=none; b=QlCjqJNZchRqke6Wh+A/MlqZ/a0lUNWKsOvP03lagyO3p9e3GACi2xzPpJuc7funI1an9X1Ep4ukcdpzwiqsQcesfrsANwSYZVWFL9qxCWKy6W0p1Op/57ZDat3GlPxVgAcW9WX/0ZS2vf/EKiesp7lFVvlMAkKLiKuwObB0Lxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200736; c=relaxed/simple;
	bh=EYpYX1LgHQBETK8SepZsHgMn4BIaNlRJVO1E8lO7/DY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FW/0Arr49A0pAP4bxPhWPngze6UyMpcaVEuo65hCdMIcxT4TASKmK0Ux4/iZ1pLqQRz1u4vU0Sfvs41wiuKvg64xv4hU9pLUzqPI8bqoT3urNQKU1Md27+nuurW+/asDX5vkkqQ8FGwNJB9OKKvq0+itRAklBB1ud+V41KYvB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYVfNlNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647A0C4CEE0;
	Wed,  5 Mar 2025 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741200735;
	bh=EYpYX1LgHQBETK8SepZsHgMn4BIaNlRJVO1E8lO7/DY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pYVfNlNUmDqphukT2KTPQZmeW+mHaIoj6ioIR02cav0KBMBdBPw76rkUKonCp0M5g
	 cE77q4uUSRXPoY6Yt1P+vfDvjY5Lbki4r6DJvh8DEhnc1huHschH8xxxep23tM0rlD
	 JWLRFRs0dAJgdl4ZMy6yJJ3Wo/XVCSmFnFtYJT/1j+3lEX04fZ/QbYBimrfJNA64xi
	 luZl5pJHCWeXq0zEVc/Fm889nlFblESLORMH/SxgfbqBN5H3tDs5Gf07iDq6BoDGcx
	 gcLxcDblIZN9yJ45SMMBM2oWMieiSxfcKrcp+sZzckQvj3ltU/6IXtbF1eOOcZj2Nx
	 5AsX2h3jC32Zg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  <stable@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<KBox<T>>`
In-Reply-To: <20250305132836.2145476-1-benno.lossin@proton.me> (Benno Lossin's
	message of "Wed, 05 Mar 2025 13:29:01 +0000")
References: <t9wrOFEcf8XZ-aKch1r7feu9gBB6Wqs6_KgnLoSF6eZ01wvr4zV4Rbl4McWKaM25TlwevH55D6Yy_gLi2idFLA==@protonmail.internalid>
	<20250305132836.2145476-1-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 19:52:08 +0100
Message-ID: <878qpj71k7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> According to [1], `NonNull<T>` and `#[repr(transparent)]` wrapper types
> such as our custom `KBox<T>` have the null pointer optimization only if
> `T: Sized`. Thus remove the `Zeroable` implementation for the unsized
> case.
>
> Link: https://doc.rust-lang.org/stable/std/option/index.html#representation [1]
> Cc: stable@vger.kernel.org # v6.12+ (a custom patch will be needed for 6.6.y)
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed` function")
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




