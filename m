Return-Path: <stable+bounces-115013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043DDA3202D
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419541882E51
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D7F204C0F;
	Wed, 12 Feb 2025 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="H/hn7/sX"
X-Original-To: stable@vger.kernel.org
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F44204682;
	Wed, 12 Feb 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346192; cv=none; b=ACTzo7eebXIHGfLwexrGzaE3YaXayztq0IM1rWYHHFmoSJ9b9Op2psQpL2EcQlmV9vxLyQbbquXQep3ahk5Drs1rVB98gD9TQ9adZ+bChm0B/Hfx6Y/1MteWeEq5+ifeLnZlooe+ighAN1JvjG6r1M4mP75OudwkNLjq375sluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346192; c=relaxed/simple;
	bh=dNEJPQCFXFXFYv8LsS8D1rVs3y39N2Beg7o2UW6ryMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uA1ZTyCiwjJZqb+EwkUbx50hew3cNUGKhpUB+5nGxMJMGkLz3Oe1MYZSTJrloStLGWFtIW/leWkwaeR1/ZbrARyUOFQi9o/7tr0DhZaECE5DsCT+rgjyCb/3TFpUl3jaIw2xjt2FR2Q649w6m/AHm3KVCZSulDkd7Y3ftEBiTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=H/hn7/sX; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1739345687; bh=dNEJPQCFXFXFYv8LsS8D1rVs3y39N2Beg7o2UW6ryMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H/hn7/sX5xM/uw2kg30IfwLHDywFTYAajrHTQq3WN22+Jmf6LCU4Po3PR5oZVnBu6
	 KDSBUlfksxwBNExOvWdUR3v9Wt3mNE5iQg56I3tYms3SM0yOIExAka4cfZ/ZSrx6gU
	 NpSnAI3A7GGQgE2vW16DX7RsFEuqEmSF+XKvA7X4=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 267B22050FE1;
	Wed, 12 Feb 2025 08:34:47 +0100 (CET)
Message-ID: <1cfca789-bbb9-4899-92e9-94ff78d07c50@ralfj.de>
Date: Wed, 12 Feb 2025 08:34:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: rust: clean Rust 1.85.0 warning using softfloat
 target
To: Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, stable@vger.kernel.org,
 Matthew Maurer <mmaurer@google.com>, Jubilee Young <workingjubilee@gmail.com>
References: <20250210163732.281786-1-ojeda@kernel.org>
 <CALNs47uBcyTmBdTBAPXiBcAkE0-4tih9j=VAv1rRcTcf_c2yTg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CALNs47uBcyTmBdTBAPXiBcAkE0-4tih9j=VAv1rRcTcf_c2yTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.02.25 12:10, Trevor Gross wrote:
> On Mon, Feb 10, 2025 at 10:38 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>>
>> Starting with Rust 1.85.0 (to be released 2025-02-20), `rustc` warns
>> [1] about disabling neon in the aarch64 hardfloat target:
>>
>>      warning: target feature `neon` cannot be toggled with
>>               `-Ctarget-feature`: unsound on hard-float targets
>>               because it changes float ABI
>>        |
>>        = note: this was previously accepted by the compiler but
>>                is being phased out; it will become a hard error
>>                in a future release!
>>        = note: for more information, see issue #116344
>>                <https://github.com/rust-lang/rust/issues/116344>
>>
>> Thus, instead, use the softfloat target instead.
>>
>> While trying it out, I found that the kernel sanitizers were not enabled
>> for that built-in target [2]. Upstream Rust agreed to backport
>> the enablement for the current beta so that it is ready for
>> the 1.85.0 release [3] -- thanks!
>>
>> However, that still means that before Rust 1.85.0, we cannot switch
>> since sanitizers could be in use. Thus conditionally do so.
>>
>> Cc: <stable@vger.kernel.org> # Needed in 6.12.y and 6.13.y only (Rust is pinned in older LTSs).
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Matthew Maurer <mmaurer@google.com>
>> Cc: Alice Ryhl <aliceryhl@google.com>
>> Cc: Ralf Jung <post@ralfj.de>
>> Cc: Jubilee Young <workingjubilee@gmail.com>
>> Link: https://github.com/rust-lang/rust/pull/133417 [1]
>> Link: https://rust-lang.zulipchat.com/#narrow/channel/131828-t-compiler/topic/arm64.20neon.20.60-Ctarget-feature.60.20warning/near/495358442 [2]
>> Link: https://github.com/rust-lang/rust/pull/135905 [3]
>> Link: https://github.com/rust-lang/rust/issues/116344
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> This is consistent with what has been discussed for a while on the Rust side.
> 
> Reviewed-by: Trevor Gross <tmgross@umich.edu>

I don't know the kernel side of this, but from a Rust compiler perspective using 
the "-softfloat" target is definitely the right call here, at least for now 
(where none of the crypto/compression code that needs SIMD is written in Rust).

Reviewed-by: Ralf Jung <post@ralfj.de>

Kind regards,
Ralf


