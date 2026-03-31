Return-Path: <stable+bounces-231383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB5cLsGhy2lHJwYAu9opvQ
	(envelope-from <stable+bounces-231383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:28:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA1367F1A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD0C31120AE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC803EC2C7;
	Tue, 31 Mar 2026 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O9kxkReV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4183E958B;
	Tue, 31 Mar 2026 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952434; cv=none; b=FAQGBVsCqfS/HGeaXAcczLxWS8mtjE+/1wyupqDq5o4c5FqyMoOLMx4Q3z4aTlnJWwAEEiLXux+EBjmAQIM7LL3GLui/9rWJ7Yc1Bq/utCuqg6Fd12rk1pLaD9vHKJ5f4N6RlKfuUgqExFxrTLQOkEKPAa73gSAeRnJ2yO6KMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952434; c=relaxed/simple;
	bh=dcGK9FVFrNjzJSj7qhp9VkG/t6kZQiqgY3IeTND0Z1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW3HVn0kQ+ZuJrnfc/J4400ONa/ajQiHw8vWGQ7xBZFZmhoXbNWkG8biDNFRQArD6aCev81vL5tim0kr2WoGIcOoLRYydCCKai4q6aGZkGvHwqRcrftqp03llFJHUjtsAbM0wlOwADAYRI/OAhxRvc9Og4XUP5gqA3TG3janH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O9kxkReV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97958C19423;
	Tue, 31 Mar 2026 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774952434;
	bh=dcGK9FVFrNjzJSj7qhp9VkG/t6kZQiqgY3IeTND0Z1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9kxkReVIQKjsZykwUjoCqiOZr3V4oG76Dp8rFuXlWMnodiXA+hQzNHkfePFsnzLC
	 mShRag4CGygSMWSgQN7bEwemeD3U2IiFPyyEtzxfBcb57ZuHCwBS9HXj73V4OLKwNn
	 PjYuye1Ygwxtl15SleNwfdslu0XZxU57C3ylYDvo=
Date: Tue, 31 Mar 2026 12:20:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tim Chirananthavat <theemathas@gmail.com>, stable@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.18.y 2/2] rust: pin-init: replace shadowed return token
 by `unsafe`-to-create token
Message-ID: <2026033156-handclap-magical-7a0d@gregkh>
References: <20260325125753.944918-1-lossin@kernel.org>
 <20260325125753.944918-2-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325125753.944918-2-lossin@kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231383-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,msgid.link:url]
X-Rspamd-Queue-Id: 0DDA1367F1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 01:57:51PM +0100, Benno Lossin wrote:
> [ Upstream commit fdbaa9d2b78e0da9e1aeb303bbdc3adfe6d8e749 ]
> 
> We use a unit struct `__InitOk` in the closure generated by the
> initializer macros as the return value. We shadow it by creating a
> struct with the same name again inside of the closure, preventing early
> returns of `Ok` in the initializer (before all fields have been
> initialized).
> 
> In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
> this solution no longer works [1]. The shadowed struct can be named
> through type inference. In addition, there is an RFC proposing to add
> the feature of path inference to Rust, which would similarly allow [2].
> 
> Thus remove the shadowed token and replace it with an `unsafe` to create
> token.
> 
> The reason we initially used the shadowing solution was because an
> alternative solution used a builder pattern. Gary writes [3]:
> 
>     In the early builder-pattern based InitOk, having a single InitOk
>     type for token is unsound because one can launder an InitOk token
>     used for one place to another initializer. I used a branded lifetime
>     solution, and then you figured out that using a shadowed type would
>     work better because nobody could construct it at all.
> 
> The laundering issue does not apply to the approach we ended up with
> today.
> 
> With this change, the example by Tim Chirananthavat in [1] no longer
> compiles and results in this error:
> 
>     error: cannot construct `pin_init::__internal::InitOk` with struct literal syntax due to private fields
>       --> src/main.rs:26:17
>        |
>     26 |                 InferredType {}
>        |                 ^^^^^^^^^^^^
>        |
>        = note: private field `0` that was not provided
>     help: you might have meant to use the `new` associated function
>        |
>     26 -                 InferredType {}
>     26 +                 InferredType::new()
>        |
> 
> Applying the suggestion of using the `::new()` function, results in
> another expected error:
> 
>     error[E0133]: call to unsafe function `pin_init::__internal::InitOk::new` is unsafe and requires unsafe block
>       --> src/main.rs:26:17
>        |
>     26 |                 InferredType::new()
>        |                 ^^^^^^^^^^^^^^^^^^^ call to unsafe function
>        |
>        = note: consult the function's documentation for information on how to avoid undefined behavior
> 
> Reported-by: Tim Chirananthavat <theemathas@gmail.com>
> Link: https://github.com/rust-lang/rust/issues/153535 [1]
> Link: https://github.com/rust-lang/rfcs/pull/3444#issuecomment-4016145373 [2]
> Link: https://github.com/rust-lang/rust/issues/153535#issuecomment-4017620804 [3]
> Fixes: fc6c6baa1f40 ("rust: init: add initialization macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Link: https://patch.msgid.link/20260311105056.1425041-1-lossin@kernel.org
> [ Added period as mentioned. - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> [ Moved to declarative macro, because 6.19.y and earlier do not have
>   `syn`. - Benno ]
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---

I'll drop this one now too, as the 6.19.y version did not work.  Please
resend it when we have a 6.19.y version.

thanks,

greg k-h

