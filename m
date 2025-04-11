Return-Path: <stable+bounces-132266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDDA8605C
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD414A3CD5
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6E81E5B99;
	Fri, 11 Apr 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBjYwzpC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A51E89C;
	Fri, 11 Apr 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381033; cv=none; b=ld8ngPNgKNVQJRZNE1gQea81JI4TIaC0EMny4ZM+PDkW37LEi8R9UcDbtJizCQPAs6ZVCa3xvWcrcf3sBk+lkv4sUMP2SHRuoBRiNVOIDDxqGHbHziRKSHz4JNE8Xti2NixgcszGmr3haxb9kz29/R8jYb9WNK9Fbelx3ymEJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381033; c=relaxed/simple;
	bh=dq0L6tQYUSAcSdcqt6jk2P9Paxbojlt97D0W4MpXgiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkUUh1/FM/k4oFy5jFl07Ojwec1dza4CStlpu1Eea8mQJVRvvWnjn0RwgrNA1f8rOFFy9Zw2M7MhEjQYKu0yFIcpgZHPskV2yJHyXvQozHdzP93V62vFStV89ycumqw2ktKxKxG+7NzWR49Vs/km9dFSP4bT4exHfeHvaZHU9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBjYwzpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82350C4CEE7;
	Fri, 11 Apr 2025 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744381032;
	bh=dq0L6tQYUSAcSdcqt6jk2P9Paxbojlt97D0W4MpXgiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBjYwzpCZpyerfG6K5aGh4518j7WK2C974hjpgftJoe8j6jxO2juVgS3Pgvleplw0
	 j2dyd9exKXGPI+5mw3r8XQ41aZgHPWSaCZi37Hc/ExgCQCjKfDttz4Qtd4Ufv+OvRv
	 WVZpZCvFbzxSf2OU15nq+t4236Od8T19VKrpN8e1Uf7prU64nWRIsZu8RjKy8ukI0E
	 0sPgDn4bnSL7bSP8CaZAuT7dnAUQ14Z0xFPvMa1P1sLwppvL4w2rmPQVeoFMhk4zf4
	 zP9gXOe8o1Oktu70gYQ2VDuS428ZjuvBAj6nIhwOhLd1ZTV6FJ8r6MGx/BXp2XgYQM
	 s3KUzGu0019jg==
Date: Fri, 11 Apr 2025 16:17:06 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
Message-ID: <Z_kkYsLNiZ_t4z5b@cassiopeiae>
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
 <Z_jwXsQae9DjLWha@pollux>
 <99070274-4891-411a-89e1-420ca4d5d0fb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99070274-4891-411a-89e1-420ca4d5d0fb@gmail.com>

On Fri, Apr 11, 2025 at 03:47:28PM +0200, Christian Schrefl wrote:
> On 11.04.25 12:35 PM, Danilo Krummrich wrote:
> > On Fri, Apr 11, 2025 at 09:14:48AM +0200, Christian Schrefl wrote:
> > I did a test build with multi_v7_defconfig and I can't reproduce this issue.
> > 
> Interesting, I've it seems this is only an issue on 6.13 with my arm patches applied.
> 
> It seems that it works on v6.14 and v6.15-rc1 but the error occurs on ffd294d346d1 (tag: v6.13)
> with my 32-bit arm patches applied.

That makes sense, commit 1bae8729e50a ("rust: map `long` to `isize` and `char`
to `u8`") changed FwFunc to take a *const u8, which previously was *const i8.

> >> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> >> index f04b058b09b2d2397e26344d0e055b3aa5061432..1d6284316f2a4652ef3f76272670e5e29b0ff924 100644
> >> --- a/rust/kernel/firmware.rs
> >> +++ b/rust/kernel/firmware.rs
> >> @@ -5,14 +5,18 @@
> >>  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
> >>  
> >>  use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> >> -use core::ptr::NonNull;
> >> +use core::{ffi, ptr::NonNull};
> > 
> > The change itself seems to be fine anyways, but I think we should use crate::ffi
> > instead.
> Right, I just did what RA recommended without thinking about it much.
> 
> I guess this patch isn't really needed. Should I still send a V2 using `crate::ffi`?

Yes, please. I think it's still an improvement.

