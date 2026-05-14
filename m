Return-Path: <stable+bounces-247190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KZsC7vBBWrXawIAu9opvQ
	(envelope-from <stable+bounces-247190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:36:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D50FE541B50
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EDCF3051480
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9432397E85;
	Thu, 14 May 2026 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrwDRyN4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9D03168E1;
	Thu, 14 May 2026 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762145; cv=none; b=p/wQVyxDv8UcujpYQF7o2LZEsuXbMUkxxNxiUGEnzdyKnabblTQkfiuiry70jOHfupbZiuRRUOFmVVMr83FHadOtjUWcPpbDCtrLvL773WrqQPtmxrjAK7kkSkuNh+C6YjyrouxN8TuHRraUjgVJrlaPLa9Nn2vpmqhgGnMvoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762145; c=relaxed/simple;
	bh=01wIi3Eg793RqUdLUINzl55/L7rDJ6f1+4go/N9Ni18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx1Xn6BM5lnlGreFtWJMBhFFg1W4HnKDP2/TfKAqDNntBRJtQkV6Tr8eOEq/841miJv3z5/w6ApdCIi3FTXGMctHxkRNkz3E0zlQwjyWWwSv7dM7YyASf8BWz4HX35OF56WQwpFJU4s28tQX3hwy/pjzOroU5g7FHWmDmZv6+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrwDRyN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC77EC2BCB3;
	Thu, 14 May 2026 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778762145;
	bh=01wIi3Eg793RqUdLUINzl55/L7rDJ6f1+4go/N9Ni18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrwDRyN4AgqVMXw3KuRwBzAfJrIIdCTNDKXfRSCN6uhnF33xjn34VsUf7eNO4Shxl
	 b+Ou5xTdyoy0zTU61cH0ynbhKtJcN/EbydBiqtxVQiW5nIjF5bpkEatXawTVeOKkxD
	 RDD/WkQXgkASg5dr4bMeY88Z8/YASSmHImiuM18MPlZYuQqNDgcdsVz7Xcblqeu01D
	 0aL4k7nYGt0bbnrZRb/pTQrlb2A8c2OwH9zlUbcq7euoUYwkuatDdWx3E3T7mWEimE
	 u+6xSXVSTzk7vEIlNuyVsRVAQuo6FWy4khY/43DXdl9+TbZVxOT64MsJff+ViLVjZF
	 SznMZ9roUQULg==
Date: Thu, 14 May 2026 21:35:39 +0900
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Schrrefl <chrisi.schrefl@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: Do not select HAVE_RUST when KASAN is enabled
Message-ID: <20260514123539.GA1781775@ax162>
References: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
 <agGRnHVTLiwobb9W@google.com>
 <20260511090943.GA1029560@ax162>
 <CANiq72nm_3KM4gMnb0x34oJk1+_8XrUz-43zwW58Mr1UHG8qtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nm_3KM4gMnb0x34oJk1+_8XrUz-43zwW58Mr1UHG8qtQ@mail.gmail.com>
X-Rspamd-Queue-Id: D50FE541B50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247190-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,armlinux.org.uk,kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,lists.infradead.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:58:42AM +0200, Miguel Ojeda wrote:
> On Mon, May 11, 2026 at 11:09 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Sure, I kept it simple for backporting purposes but I don't mind
> > breaking out the dependencies into their own symbol, even though it
> > feels like that could be done when support for the sanitizer is
> > re-enabled, which would truly mirror what you did. No strong opinion
> > though, so I will send a v2 after giving some time for other comments.
> 
> I think it is fine either way, especially for a fix, but up to the
> KASAN/arm maintainers of course.
> 
> Thanks for the patch!
> 
> If KASAN or arm maintainers want to pick it up:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Otherwise I can send it in a fixes PR I will likely need to send later
> this cycle, so please let me know!

FWIW, I think Russell has been away dealing with personal stuff
recently:

  https://lore.kernel.org/aeDSTIS9-TDSihbX@shell.armlinux.org.uk/

So I doubt he would fight you taking it, given that it is Rust related.
I am rather selfishly motivated to have it picked up and merged because
I have to remember to pass KCONFIG_ALLCONFIG=<(echo CONFIG_RUST=n) every
time that I have to test arm allmodconfig. But don't feel rushed to pick
it up if you want to wait for a formal agreement on the path forward.

-- 
Cheers,
Nathan

