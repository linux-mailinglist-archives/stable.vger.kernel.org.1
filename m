Return-Path: <stable+bounces-120436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CEDA500D0
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E07166EE5
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296724BBE1;
	Wed,  5 Mar 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VtkbnWZG"
X-Original-To: stable@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8024A068;
	Wed,  5 Mar 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182184; cv=none; b=hpRUNvE35FaZ2XnSn15qssqdhyqgbB9J+odNPe8fP4DaScypU1rKX1m+KKdkfOU6qtKne5DqKQGnK32X/iTOeuh3+qpo4Yv++anSFZLKl6s4KOMoqsk+q6mmTtAZnHr0qW5KkZDNc819FXN0bFB8iGMB4PMmSn5SclPbp0K7M6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182184; c=relaxed/simple;
	bh=PCw+fsFCg4iMevxCZ3WDBtFP6dh7QpfE1KSQU7/sx0o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nelxqKYUeauHEQ2Hvs45hz49h7fmiBym8/8kQbE0DfF3Rqhzjiq+Ey/Hqt0VQHExoq/HR37WIhCOO+16K1XznGMJTWBfJZu2Kiug1oyfeRcmCkv9PpAkGx47V9LANLjQbn9L0G0jw2t8NwZ0fv7yvslwLCj89y8v9L1wt1aOv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VtkbnWZG; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=islx75xhinebhcqxkzeybsabfi.protonmail; t=1741182181; x=1741441381;
	bh=PCw+fsFCg4iMevxCZ3WDBtFP6dh7QpfE1KSQU7/sx0o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VtkbnWZGyDqEYMboWBjvPEvvqvtZp+BX7QOyNE0XKXPYbu2MlEZQugMq4JdIPYi1f
	 21czmgoO9P6i8ASWaWiBx8/K4881UlkCicx8vL0BB8F/5gdm116QZbPlW1yifOeJqK
	 3csnHyr/qH77xBjw+Rrgug92SN25PN37Pvg3r62Yluq+cza1/eswLTDI1h+vil7cil
	 glI8lOgbtSWYFld6norsR2aO0bmypklm8icdsxurTtqy+JU9ujczIgVtr+3MpVWfHq
	 QnQQY536TEo19ee7DwGzo2DI81vqPUYnExRvuPHj2XMy9Jax2HAzsjR7Yhmdt0esqa
	 VsHC9hv/ia4ow==
Date: Wed, 05 Mar 2025 13:42:55 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<KBox<T>>`
Message-ID: <D88DKEJ9LHA0.3324DAQAUEI9T@proton.me>
In-Reply-To: <20250305132836.2145476-1-benno.lossin@proton.me>
References: <20250305132836.2145476-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b9f1163ef793328134ca0cf594bc4a3f8403279e
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 2:29 PM CET, Benno Lossin wrote:
> According to [1], `NonNull<T>` and `#[repr(transparent)]` wrapper types
> such as our custom `KBox<T>` have the null pointer optimization only if
> `T: Sized`. Thus remove the `Zeroable` implementation for the unsized
> case.
>
> Link: https://doc.rust-lang.org/stable/std/option/index.html#representati=
on [1]
> Cc: stable@vger.kernel.org # v6.12+ (a custom patch will be needed for 6.=
6.y)
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed`=
 function")
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Forgot to add this:

Reported-by: Alice Ryhl <aliceryhl@google.com>

---
Cheers,
Benno


