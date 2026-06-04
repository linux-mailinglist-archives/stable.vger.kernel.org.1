Return-Path: <stable+bounces-260489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MoDUKH54IWolHAEAu9opvQ
	(envelope-from <stable+bounces-260489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 15:07:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA0A6402DF
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 15:07:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=hymAQgjl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260489-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260489-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83BB7304DE9F
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A347DD51;
	Thu,  4 Jun 2026 12:58:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26247D955
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:58:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577910; cv=none; b=boeX65+/pQAnZWnJPFRSiGVn2rp8emmjMWXV3rgUdQ9Ittc2BFnqcDEBrMUa14jH6sOXOE2JT1ojlk+Bsix6zd/UsBXjdd8eN+7Yhux2G71+8HLE7/uzDEw5iLxNcnwKU5XaaelaAiNmaMFj4hGUlhQnmpvRrddbyfvz6IKuzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577910; c=relaxed/simple;
	bh=WTeAlVO0DRWMQLHY+AVCUlz1Ehp3ZPr3YJrQQQlXSb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b/0ajR82xoKEvb6RtkFbtwLvMB6ZLHwu6xcAaeYSeJ2r8uSjglZ7P01x8PU0vTR6yc5hP3/bVqCoLHpAoqSf+Dj44gwgsN414ORAGAJIotnmBWvFLKuA+ffnRo8zN/PZy2Br/mJxxpSw7axdQv16CKU6UCyPhyiMbuERKtAXz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hymAQgjl; arc=none smtp.client-ip=209.85.221.74
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45eec2badc4so345156f8f.2
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780577908; x=1781182708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xwe384gyxIbZlOev+w5QVkieSQ1N1l24QasZ+3nTCfs=;
        b=hymAQgjlycnxX4GViYv/Cgvgmg96cjw8d8Y/MKADdH8cODtlhC1eLNZ1zawB2C5Xba
         54YySIqfZJ1q0848vY8li2MaapnIMoM2QDi86HpK2IoiVEbUiBFowsi8iYNehOY4Qu0T
         F4k7O3BmCgVZ7BQFZm5SR2SQioiYhfqcx9/n76mZrctZDN+RrixR58hxOBBNIvAroooQ
         Gm+6iax/hYkuksFg+XQ4XQqXOMz/MjE6ML3zC21r0kSsxmtRCXgUTrZh2b2V/w3/7A5J
         Ht9RGxIIaXpruMw89i3xLa6rpvjTJgvp/q+M51YxtZGyZl4rgCwLX1AoFNH6hRQzvwDs
         eHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577908; x=1781182708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xwe384gyxIbZlOev+w5QVkieSQ1N1l24QasZ+3nTCfs=;
        b=ZizClH+psX2GL/GtCZc2DFqTTanvKtTJTboAEz5JNS2P3y4fSNZxn81lPO4XNlmusU
         J5vyroGoiUL2FbuqDZXqDPs0ZBCwTZqU9eLRfDMoR+rqhicEA0cZL0C3q9jkfQVYOVhw
         2ANFojlD3AtoOQxRHnBveDXXC5+/W+310yxM+fHoNotIX6prN9sDu7J6CgVZq+1Fimwh
         kn+lxRZHPtt4D0Ku8GuteEI6goQPXOTt3KV2TgPt5JKl6hOAB9M1KbWyyk5B+rklHfJu
         JNljcikJH4JJQr1phxaCTqVWK4VPmkj1Zea9Y0FaLdxN4yzfubDEvyZ8ND5Q51N75+DH
         VSvA==
X-Forwarded-Encrypted: i=1; AFNElJ+1bbti8on03X2KfvBDAv9fam90i+zghpL/8CxNFGfHfzfYT9uaQ1qOfrGmUny23CYQnT6g2jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyhjPNPpcB/po3D+PZu6QMnVN4VZOXTsjLY7H0G804vfRkaxMR
	vwhgGIzmziasJGn4R47LB4lneen8x1meBqmZHFOHPAt/QgkIsBgWQZvUf29lPnNRw8d8Qjfw2zf
	VcN3UAUm21jrRnp/MHg==
X-Received: from wmbje15.prod.google.com ([2002:a05:600c:1f8f:b0:490:4477:50d3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5250:b0:490:c015:21 with SMTP id 5b1f17b1804b1-490c0150155mr22460345e9.20.1780577907632;
 Thu, 04 Jun 2026 05:58:27 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:58:26 +0000
In-Reply-To: <20260604-set-extended-error-v2-1-fb0753e7ab53@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604-set-extended-error-v2-1-fb0753e7ab53@google.com>
Message-ID: <aiF2cpJKpyj3XFj4@google.com>
Subject: Re: [PATCH v2] rust_binder: fix BINDER_GET_EXTENDED_ERROR
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260489-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:cmllamas@google.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DA0A6402DF

On Thu, Jun 04, 2026 at 11:37:07AM +0000, Alice Ryhl wrote:
> This code currently copies the ExtendedError struct to the stack,
> modifies the copy, and then doesn't modify the original. Thus, fix it.
> 
> Furthermore, errors when replying must be delivered directly to the
> remote thread, so update deliver_reply() to take an extended error
> argument.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

>              BR_DEAD_REPLY => f.pad("BR_DEAD_REPLY"),
>              BR_FROZEN_REPLY => f.pad("BR_FROZEN_REPLY"),
>              BR_TRANSACTION_PENDING_FROZEN => f.pad("BR_TRANSACTION_PENDING_FROZEN"),
>              BR_TRANSACTION_COMPLETE => f.pad("BR_TRANSACTION_COMPLETE"),
> -            _ => f
> -                .debug_struct("BinderError")
> -                .field("reply", &self.reply)
> -                .finish(),
> +            _ => match self.source.as_ref() {
> +                Some(source) => source.fmt(f),
> +                None => f.pad("OTHER_ERROR"),

As sashiko points out, this is probably better as:

	self.reply.fmt(f)

to just print the raw integer.

> -            let reply = Err(BR_FAILED_REPLY);
> -            orig.from.deliver_reply(reply, &orig);
> +
> +            let param = err.source.as_ref().map_or(0, |e| e.to_errno());
> +            let ee = ExtendedError::new(orig.debug_id as u32, err.reply, param);
> +            orig.from
> +                .deliver_reply(Err(BR_FAILED_REPLY), &orig, Some(ee));

As sashiko points out it should be info.debug_id instead of
orig.debug_id here.

Alice

