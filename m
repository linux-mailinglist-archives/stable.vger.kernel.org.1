Return-Path: <stable+bounces-204112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F619CE7B44
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DF88300E820
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8632FA3C;
	Mon, 29 Dec 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7XAhona"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BC2367DC
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767027861; cv=none; b=uXBp2uXCCd0+LLqmqdGJbJg4nWKzd2EE1mvEiHEd+kSLIdoeNPwAwIDTfCbb0dVEtvU80t6ddWu//eyBBCpjddox09lh1SyHYbrzaZzlg5YNYjujB5DUeQ1IoNsmu0p9bEgCToAMhRcHF/jkpLgs7vCitUgYJcg/Xz/+JTU2bnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767027861; c=relaxed/simple;
	bh=zF2T1FIl8egI/W9aqc85qpNv1XV7tvAFANGtUovKdKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hosha6UHverXL1zwDEhE3i1f7Q1Zm8l81rHihb3oNpJ5lN9uR2cYNIW5kBmEaR7yysWUqI2Dk7VONSLPFdzdi9aSDx/HGdWMj16KcYpFiCJpuWf1bmjnDwO7upkcx+/yEKREiDSFzKewKUXv5brUZyvXyePjRq6p6K2wW0qswfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7XAhona; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-64d5bec0e59so8109022a12.0
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 09:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767027859; x=1767632659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1dWu0jtPAE2ll/Vi4qV+X83f54fPzcnMdMPnW/x9j4=;
        b=d7XAhona9cWgvTrVcgAgmpSUxrawsZnr4PCDwh8XKyS9jHzVAllFSKLn42sVrYzmma
         E8NI/KsBlGeLKpMeUf6DkhO2YCzmUJgqawBamCA6OtoIFA3/yzA49ZZo42oh/WipBmmC
         Kl4JPhp1geEQ8c3Il7SCrGbUSi2usRMzpt9lpBmurjQ9Jbr8dGNiY4NpIAmkmAPYqGXJ
         qRS+McjU9jPFUMNOB7jKaxpnppe3yiIrCfJUdcYM8x7hpqpfiaPsdz+4BHcbuEhz4D8r
         soveB55I3cO1QzXE4sKfBRhGgYrImPk3J7yviqPIJsey6ktcCUoF0MZM+HddeR10BNv1
         uiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767027859; x=1767632659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1dWu0jtPAE2ll/Vi4qV+X83f54fPzcnMdMPnW/x9j4=;
        b=LJSx1yo+Lyzw1SzKGsnCl6g0fnZHgPy7yODiIM3I2jB48NgPIhre6IaTGvPR7iP9/n
         LwXOTwk4rBBiHL1YRuhqf5tZmfIUu+6tbl2u5bqAZSaiUzPoidyWaMvy0Uu16l5+0Pgj
         Q9fCT6CkR6AcjSJtmu1R44eE7vOMyn1xo27M78FUQp/6k8YGFkRywkU4U0KKQnBcdvrU
         cC1r3m/QcLYHra8V01Yui0sK45Od/MhiZqq9WcNynLw2CLFfQE6fOAutoNvV86EH+UNN
         bep6zQQ7NP1VQ/2Mtlf9ZeNlGqV6dcrU/uPpAi6ZqZcw+mxCoEIngNw2r5E83WnCNlWY
         6bQA==
X-Forwarded-Encrypted: i=1; AJvYcCVOsygwRR0AvYZjHjHbSu5sVEoxzGXFZiGHOelxAzru2Q06rgvVU2G56Cg0RRQwM73F/ZNfkCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxTIEv+zIx5mK7gYivPAl7Penr2OpU/0UDpBB+jy4qYrv7JX8
	wCFgwPqBzOYxL6Pt/So77SGp+taDdks2JbloFInevSDaEGUqsRDQY3dxcTb3k9h7oJl7j1L+hJ0
	QOndL0B2ENHl3Y9TUfg==
X-Google-Smtp-Source: AGHT+IGLicJi0comVcZ+prfwADDY35NYQ7QvSvuuC0CbbcqM5kwPagTxVkdtOrm9mfXbStXzIexWIboT7EXsQU4=
X-Received: from edvf21.prod.google.com ([2002:a05:6402:1615:b0:64b:96ec:ef6a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5213:b0:640:edb3:90b5 with SMTP id 4fb4d7f45d1cf-64b8e93c176mr31064441a12.7.1767027858737;
 Mon, 29 Dec 2025 09:04:18 -0800 (PST)
Date: Mon, 29 Dec 2025 17:04:17 +0000
In-Reply-To: <20251229164544.1baf659b.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251229-fda-zero-v1-1-58a41cb0e7ec@google.com> <20251229164544.1baf659b.gary@garyguo.net>
Message-ID: <aVK0kS3KqUmpGSDz@google.com>
Subject: Re: [PATCH] rust_binder: correctly handle FDA objects of length zero
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
	DeepChirp <DeepChirp@outlook.com>
Content-Type: text/plain; charset="utf-8"

On Mon, Dec 29, 2025 at 04:45:44PM +0000, Gary Guo wrote:
> On Mon, 29 Dec 2025 15:38:14 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > Fix a bug where an empty FDA (fd array) object with 0 fds would cause an
> > out-of-bounds error. The previous implementation used `skip == 0` to
> > mean "this is a pointer fixup", but 0 is also the correct skip length
> > for an empty FDA. If the FDA is at the end of the buffer, then this
> > results in an attempt to write 8-bytes out of bounds. This is caught and
> > results in an EINVAL error being returned to userspace.
> > 
> > The pattern of using `skip == 0` as a special value originates from the
> > C-implementation of Binder. As part of fixing this bug, this pattern is
> > replaced with a Rust enum.
> 
> I was curious and checked the C binder implementation. Apparently the C
> binder implementation returns early when translating a FD array with
> length 0.
> 
> Would it still make sense to do something similar in the Rust binder? The
> enum change is still good to make, though.

Based on where the early return is, that'd be equivalent in wrapping
this:

	parent_entry
	    .pointer_fixups
	    .push(
	        PointerFixupEntry::Skip {
	            skip: fds_len,
	            target_offset: info.target_offset,
	        },
	        GFP_KERNEL,
	    )
	    .map_err(|_| ENOMEM)?;

in an `if fds_len > 0 {}` block. I don't believe it makes any
difference, but not having a special case may be cleaner?

Alice

