Return-Path: <stable+bounces-245164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBWDBuKgAWpKgwEAu9opvQ
	(envelope-from <stable+bounces-245164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:26:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D76850AD83
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C509305DA9E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D82343D83;
	Mon, 11 May 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smQLFT2y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04D1D5CE0;
	Mon, 11 May 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490589; cv=none; b=US8hm6LmJYkoA9eq+XH38IjamJv9wpFWxYeCiOWIrZUZEqaOQzrB5JvE84rO9ibbYVxvu+fxnH0JSw8Jxzf7aofVth6k3bVZc1ngTTZMzbvREUGd3awg4b2ayFjv9MPBUsnwM7AImZunKDVJDYNhtuHapODAadeIEOwesZdytBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490589; c=relaxed/simple;
	bh=pnPO1CrEA1FQe9xDcrN7whB/TUmM3QUmKYvPyURJ78I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1q+FPMJyWQeeCOsmrlWiV5qXAIvuPdNMqdZ3/t6RwuGCBJqifbDqNEbpLgbE4s4wF2a3kfZvC2aPCOimjnZ/LUX3qpVcS+Hnoth5YDUAVfPJ0MBiC5z7MlnnWxWQJ8PxY3n1tza1es0F6k7vCrCWU4j5Mr/65PUJeulpIA66qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smQLFT2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FA0C2BCB0;
	Mon, 11 May 2026 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778490589;
	bh=pnPO1CrEA1FQe9xDcrN7whB/TUmM3QUmKYvPyURJ78I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smQLFT2ynutYERKsr/eFczsT1AiyS7PWL5ILAAOFi2DcdHRZyLGrvLSD5pYCnf33V
	 sh2YmSuGMr9hdnPr3W33ycWcAsCKgjbqIPscyZdEDtTJU6E6HweTvyN9eYJY/sJE26
	 OeJULwcO2tzROWxtiv/fuX3wvKdiWXW//6IU2NQDWnTQ/ifVv5gGl4hlzpd0EBFtQ2
	 RG4sJ83xAsShCOsz4b2VDDECW2Ru/xIV8lJ97Sd9WRdqUoKwqRdoTePBPeetnQy/iw
	 o8RP8Y55fGLUC+ucvaqRElII6akzSkrVYHFbzMhe43L39ddHGN2ibhiH1+9UT3PxwB
	 gSEqVcG+6uawQ==
Date: Mon, 11 May 2026 18:09:43 +0900
From: Nathan Chancellor <nathan@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Russell King <linux@armlinux.org.uk>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Schrrefl <chrisi.schrefl@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: Do not select HAVE_RUST when KASAN is enabled
Message-ID: <20260511090943.GA1029560@ax162>
References: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
 <agGRnHVTLiwobb9W@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agGRnHVTLiwobb9W@google.com>
X-Rspamd-Queue-Id: 8D76850AD83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245164-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 08:21:48AM +0000, Alice Ryhl wrote:
> On Mon, May 11, 2026 at 05:02:44PM +0900, Nathan Chancellor wrote:
> > When KASAN is enabled, such as with allmodconfig, the build fails when
> > building the Rust code with:
> > 
> >   error: kernel-address sanitizer is not supported for this target
> > 
> >   error: aborting due to 1 previous error
> > 
> >   make[4]: *** [rust/Makefile:654: rust/core.o] Error 1
> > 
> > The arm-unknown-linux-gnueabi target does not support KASAN, so avoid
> > saying Rust is supported when it is enabled.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ccb8ce526807 ("ARM: 9441/1: rust: Enable Rust support for ARMv7")
> > Link: https://github.com/Rust-for-Linux/linux/issues/1234
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> I would probably suggest moving the conditions out to a separate
> RUSTC_SUPPORTS_ARM config option similar to what I did in commit
> d077242d68a3 ("rust: support for shadow call stack sanitizer").
> 
> This way it will be simpler to adjust this logic when the target obtains
> support for this sanitizer.

Sure, I kept it simple for backporting purposes but I don't mind
breaking out the dependencies into their own symbol, even though it
feels like that could be done when support for the sanitizer is
re-enabled, which would truly mirror what you did. No strong opinion
though, so I will send a v2 after giving some time for other comments.

> Also, we may need the same change for CONFIG_CFI too.

I think the dependencies of HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
prevent RUST from being selected when CFI is enabled for ARM, so I don't
think there is a problem there.

-- 
Cheers,
Nathan

