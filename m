Return-Path: <stable+bounces-132216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F78A856C4
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E8C1BC0DBD
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F272980AC;
	Fri, 11 Apr 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Iff5vv69"
X-Original-To: stable@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41823296169;
	Fri, 11 Apr 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360682; cv=none; b=GoIv6IGeHFmVRkCMxSA3IQpGN6OspLaFvw09zI4cN6cjEZ7ecroTWYrlK9rozWERb3CFTqRgv0FlFlRJIVHWE3MYVw9QhtGXAwzGUSElLcNnIfv+pXP4gv9HtNguCzHBfPprIRDR15pHDDjuJ2+b3WeUVEb2O29Snt63BGD7UXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360682; c=relaxed/simple;
	bh=zeOdHeb0cEPOLGeV5uDXd9eThquhAqBHHrmbSduW4ZE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwtKfaiUrMAddE2kD9VnFG0qJ+6bEogxUK01suRzHVnewcNekHQXJ4igo6vXsfuwFalf5+eJHOTZXRRHlcg/tC06EyBZlRjujF4tHVp6yPAL5TmTOGbJ6d27da8tRArPoAfMy55Vnfo5RbIYfgP9IzayaelgGh9LN8B7nxGwhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Iff5vv69; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744360677; x=1744619877;
	bh=kWNQ84PWxU3tqA/geC7N9i9pPYvKCqLN+AhB6yEpDAU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Iff5vv69TYmnu/JfH4IWYjE9DPYpO906ksMXhQ9VrmeMlMtJqywsGtLtwtoWMub/i
	 jDT+ExcpmSQgllTyCEFhej/B1bzyn1+UW8qk2ZBVqsQn6w4ZJcL0VdI5xpepu94si6
	 kwWyS1j2T5SzCxNPtRT7NJq579u6y4sXG7HZQldbXMRUrPM/PT9yGIhv1SiQBWOZMu
	 WH1kUSbxi0LCikkJokXzCdidFAHYWcQKIiE7swHiXy2q2PzKJgalcKL7VVHZ7mlSHz
	 dufxSV8TDWeI1eg+vHol6TH3uC7uYGUI1DUbWOsrzaXJbI3aSlIKeYrDQzHeC8ofyP
	 gsfjW2dFIk4bQ==
Date: Fri, 11 Apr 2025 08:37:53 +0000
To: Christian Schrefl <chrisi.schrefl@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
Message-ID: <D93O91QMOY5T.2D9WVF0PF1WRR@proton.me>
In-Reply-To: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c315255c6f7011f1b79d60b9175108d002de031e
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 11, 2025 at 9:14 AM CEST, Christian Schrefl wrote:
> When trying to build the rust firmware abstractions on 32 bit arm the
> following build error occures:
>
> ```

[...]

> ```
>
> To fix this error the char pointer type in `FwFunc` is converted to
> `ffi::c_char`.
>
> Fixes: de6582833db0 ("rust: add firmware abstractions")
> Cc: stable@vger.kernel.org # Backport only to 6.15 needed
>
> Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/firmware.rs | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)


