Return-Path: <stable+bounces-132232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CDCA85DB8
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403539C4C91
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA512BD591;
	Fri, 11 Apr 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Hoonq1a5"
X-Original-To: stable@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB3221FC6
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375559; cv=none; b=q5782a7Kmp+kurkDAceviasKpUaXYwX4AzElkonieHaH4UjXe2zLgq9kNvDvFpxukiJ9iUKozMj+7VC66dvTEVlvSmvmep7TivGsXwA8ZdqwSrKVShTLuwylE/yMIkeHSsQ5QrpoNk5p5IYP+rV4bZxAURiM3eAGYjpRKxfIr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375559; c=relaxed/simple;
	bh=/HNd+QkoMbeAX0KHP75tvcfQbMwYgYkOOj6Tg9PEK+U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAV+Ke0CPEKG6gz8sWeB7dEec+3JbZtk9ExsEGUJuptMyolNk7UkPyvFMOvbdqKFfugF7gzC78YkoxrZ+GoKUIUZdm20SvBiXKV5Id9XqRid0vd8S8+BhAd3MiVWvjHeLeEeuXVsZMPeMssnhGs2YvhlwDnipiO/nE/daTE23Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Hoonq1a5; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744375555; x=1744634755;
	bh=Fh+FKGX+Y9fOCN69/ljiuvLedUjPMaCkLNhQDgz4a2U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Hoonq1a5EgdoisHqgZgwpPaHOb4t1YHkLKLOG+hVYxDrw79mkLxLaf69CU2sTIsR+
	 64E1af/4QFDDQsiRuEwY9sll1WMlATWiYtRnJzHX32ZF2nO4EJhpKoNydG6EFhpB8J
	 ieDLCPnzumwClJHOpzHY2Wa1tUx0fV3ktDaeQZS4CiBUCyQbh79p9GKlcIcOtIeay4
	 0yREd0qIU49xsbyljc/nGPYQwh/3DJUDFDRYtjDg7JPID7mtZqklUasrV+fFKSU9H9
	 plROzvJBg8axrIIYL6puLihDMpkqFAOxLk2xTW+wf9BhfRcnZElGrJgAXRCRnngBu2
	 /w3nBJ5Vtvi2w==
Date: Fri, 11 Apr 2025 12:45:51 +0000
To: Christian Schrefl <chrisi.schrefl@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
Message-ID: <D93TIWHR8EZM.25205EFWBLJLM@proton.me>
In-Reply-To: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3b63c182f67726b2715a931202f2c16430149f9c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 11, 2025 at 9:14 AM CEST, Christian Schrefl wrote:
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index f04b058b09b2d2397e26344d0e055b3aa5061432..1d6284316f2a4652ef3f76272=
670e5e29b0ff924 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -5,14 +5,18 @@
>  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmwar=
e.h)
> =20
>  use crate::{bindings, device::Device, error::Error, error::Result, str::=
CStr};
> -use core::ptr::NonNull;
> +use core::{ffi, ptr::NonNull};

Ah I overlooked this, you should be using `kernel::ffi` (or
`crate::ffi`) instead of `core`. (for `c_char` it doesn't matter, but we
shouldn't be using `core::ffi`, since we have our own mappings).

---
Cheers,
Benno


