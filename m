Return-Path: <stable+bounces-43248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAE8BF08F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA5B2357B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BBD8592E;
	Tue,  7 May 2024 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvo2wprl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43868134723;
	Tue,  7 May 2024 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122805; cv=none; b=Ws/VqsRWtYEhUJ5oxX3XDHCXpeI/fpuQq7pAz3YFsI8qgrIKhWM0Mep+uHV+5sKYJtU58z40NDTxNrmT+NWJgQMdpXSTwnowqTNp8uCPVpCkcQkTtE0/J5XpWiLeqt7QbDqEufA0t47dqpuKe3fpTWULm+wCKqtn/VW+W5hh6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122805; c=relaxed/simple;
	bh=fdNl1HTTWF8d1DW1R+Tpk0YH1BP2PoIdU3FmdFefWuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq1naWNpaAASQ1JyGLt0js1blhnkw9wo2/Z3936qzCOCU5vyRpVpUhay3FbQM/f4IdhX7SbKbBYiFPPobaVZg9LP8k24BwIYq1VwxnxCHZsKv+ixF867393LZOlgLup4eIbd5wytKyidCMh0FeVwSMPif4M7cF0O7Uo9vNBtfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vvo2wprl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9590C2BBFC;
	Tue,  7 May 2024 23:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122805;
	bh=fdNl1HTTWF8d1DW1R+Tpk0YH1BP2PoIdU3FmdFefWuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vvo2wprl+CzeS/H/772F4aDjkA6p4eH/j+GcAFFtSEaB+gCME2dBWRGUAnnqAlLQL
	 b1cRWkjUKxq7ROpHQats2WJCD7BEgnuyrd82tSY+iRzmpj05nTMZgslwSBSdy+gXQ1
	 JQqAFvyZodxfIDm64fiVTx0+5OGkqduYxrlmtmC40hXu7u4RPgYZbxtC3ANp6oHvs9
	 IATQaLvCYG0B0+1Y7VO8Bbtxx67Zvm7gttDLdnO1yknyKuikgSKeCVmT0OgPc8VJ+v
	 ysowMCDCE3w0+I4YfBYDGCLd4gx7PObUdtgf83JkL3Zcze0EzBN/uYwMEDuaMkpXO6
	 kEm/LAfe+4q4g==
Date: Tue, 7 May 2024 19:00:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	ojeda@kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: Patch "kbuild: rust: force `alloc` extern to allow "empty" Rust
 files" has been added to the 6.1-stable tree
Message-ID: <Zjqyc-hu1GDlbGBa@sashalap>
References: <20240503164220.9073-1-sashal@kernel.org>
 <CANiq72=V1=D-X5ncqN1pyfE4L1bz5zFRdBot6HpkCYie-EQnPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=V1=D-X5ncqN1pyfE4L1bz5zFRdBot6HpkCYie-EQnPA@mail.gmail.com>

On Fri, May 03, 2024 at 07:10:35PM +0200, Miguel Ojeda wrote:
>On Fri, May 3, 2024 at 6:42 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>I don't think it should be added since it requires upgrading the
>compiler to Rust 1.71 (from 1.62) at least, given:
>
>>     be fairly confusing for kernel developers [1], thus use the unstable
>>     `force` option of `--extern` [2] (added in Rust 1.71 [3]) to force the
>>     compiler to resolve `alloc`.
>
>Now, we have upgraded the compiler in the past (in 6.6 LTS), so it
>could be done, but the issue here was small enough (it should only
>really affect kernel developers if they happen to create a new file or
>similar) that it felt too minor to warrant it (especially since it
>would a bigger compiler jump this time, with more changes required
>too), so I asked for doing it only in 6.6 and 6.8 since those were
>straightforward:
>
>    https://lore.kernel.org/stable/2024042909-whimsical-drapery-40d1@gregkh/
>
>If someone is actually doing development in 6.1 LTS with Rust enabled,
>we may create bigger problems for them (even if it is just time used)
>by upgrading the compiler than what this fix fixes here (which is an
>issue they may not even care about or ever notice).

Dropped, thanks!

In general, it would be nice to have a mechanism that matches supported
Rust compilers with whatever is in the kernel tree. This logic of "6.6
is ok but 6.1 is too old" feels so 90s.

-- 
Thanks,
Sasha

