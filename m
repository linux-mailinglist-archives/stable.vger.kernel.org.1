Return-Path: <stable+bounces-167103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B6B21F08
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 09:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1843AC116
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 07:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6882D7809;
	Tue, 12 Aug 2025 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9r9OFZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C52D6E7A;
	Tue, 12 Aug 2025 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982631; cv=none; b=cLp4rceJfnsg+1MCIa9jflBY0WkH7hv1C3Jakdn69neVmRlQQD4jmgiX5X1QM0dwL+AE8O39yWU6UBdqqgTL4vMkJ6Q4CAXCLkKXsUeXg2LB3iaW5cJFHg2fP0E5pscf6biN58yei4WYGctO6ueUDyNJrMFle0OiICpiNWJOTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982631; c=relaxed/simple;
	bh=B+eNOKNbtodD+znFABmxjT8K6g5YAEHrMgmMns8bHq0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=iW2NHyLX3YutqnQ99Dz+Hi6QzaPtFIqRfGyHPPnV/etXFFkJ8ia2JFV1QcSrp08uP5h3xKw191y4UB+z5NFBG3pYLh3m7tcNz/sS4oPE3S0PO3B5R83qvoxC/Ds9CJjwGM8KvZfClyiWLBtfmnWnVH1CC41hP/e60uDpI8+egNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9r9OFZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99431C4CEF0;
	Tue, 12 Aug 2025 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754982631;
	bh=B+eNOKNbtodD+znFABmxjT8K6g5YAEHrMgmMns8bHq0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=p9r9OFZDh2YO7Y+qTqWPJ7OiqY5xrYTnvPf35Pkc6VKkQ++qEpe/XpVt3Hv/70dVF
	 NOqcF2aWuJW5DrI/Oi+EIBBSXpO5a+UUSUP3PdZwkrgNGGkU3C7Cd8XFKKwplxpCPa
	 v613fn5xo5y9Ow/Yy39PWkQs01S7MKq4tGM1Efkd/5UN/MSoFQhHqbwMlrpsYFbi2f
	 8W3/t9f32wK04WKLYMbqE7W63eIvR/bqXTYciFzkWP8e9RI/cQZm/mnS9eUqw3zjlS
	 sSpgfIWWjPknl9L0kNpKYbY3wiYrPnzx3ZNxq9qFDvVhmlYKHJRtWAavoJBEByYVXr
	 OTodw7RWzHCbQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 09:10:26 +0200
Message-Id: <DC09F4MPGE3B.1HCG1U3C0KVAA@kernel.org>
Subject: Re: [PATCH] rust: devres: fix leaking call to devm_add_action()
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250811214619.29166-1-dakr@kernel.org>
 <DBZYO8O9YTO3.10MKWPYN8YEOB@kernel.org>
 <DBZZBNP278NH.2DR4PMWX9HKST@kernel.org>
In-Reply-To: <DBZZBNP278NH.2DR4PMWX9HKST@kernel.org>

On Tue Aug 12, 2025 at 1:15 AM CEST, Danilo Krummrich wrote:
> On Tue Aug 12, 2025 at 12:45 AM CEST, Benno Lossin wrote:
>> On Mon Aug 11, 2025 at 11:44 PM CEST, Danilo Krummrich wrote:
>> One solution would be to use `pin_chain` on the initializer for `Inner`
>> (not opaque). Another one would be to not use opaque, `UnsafePinned`
>> actually looks like the better fit for this use-case.
>
> Yeah, the problem should go away with UnsafePinned. Maybe, until we have =
it, we
> can just do the following:
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index bfccf4177644..1981201fa7f9 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -161,6 +161,9 @@ pub fn new<'a, E>(
>                  //    live at least as long as the returned `impl PinIni=
t<Self, Error>`.
>                  to_result(unsafe {
>                      bindings::devm_add_action(dev.as_raw(), Some(callbac=
k), inner.cast())
> +                }).inspect_err(|_| {
> +                    // SAFETY: `inner` is valid for dropping.
> +                    unsafe { core::ptr::drop_in_place(inner) };

Yeah that works too. Though I'd add a comment & improve the safety
comment.

---
Cheers,
Benno

