Return-Path: <stable+bounces-187988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1FFBEFDFC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84DD54E4B56
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E422E54A1;
	Mon, 20 Oct 2025 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jc/IrtFT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9C72D7DFC
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948239; cv=none; b=Bd/5j4iEFddVnz+aUkjNfeOldhP9+ib6++enZdWnGCvQ7Cdf9IBy1QREhoMl2SnrMVvUfLR3S8Lf1zMOi/sS3FCc5xmFzrlQ+I444Aqk8AkfX1yXOuhyJZYnst/bU1rmdOc5s59YNXCLxpG0p0FH36vVZpnGClH9it0/1oN4tDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948239; c=relaxed/simple;
	bh=H0tga9DZv6zHPlXhb6ysF3xK2cSNnzfEhWaT6A6Prn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BDqd16QCX1JTZFwicuzan52zP27xkbUQxxgRRPhUNsKct0RK75+KsS1k8aCPJZqoLLJR4gTsS6yuDtuxU+rBDgNLZ4+ORGZgEuSyinGy2xoDvs3qI2im4L+8APGLPWNVC1RpeqR78Tx4m+dF9rhNdvXyOBfuPlKrBxF/vacQNUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jc/IrtFT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47113dcc15dso29942925e9.1
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760948236; x=1761553036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjMEk6mNBH8WSN8eHPXPJ3fCRbx/T8IK9tLp1EWYzkM=;
        b=jc/IrtFT9Ir9m6PYewmOL9GHlnHv9NaKjZGCw3ewMSVMJesMC3tGNxBA65wzsDHCiw
         8cwdmtGgdgZtKf7FiWxab+lEuZpIAc4pHFCbBTlUjcOsrAZCQ9gDoFQNCYlW34pqFo9i
         n7yE34OavRLQMAljgQqS1n/6ssRoVjBOk4UI0vg8prlMnzsmCHYjxCtv96q27MvKv0RA
         lyTbj931DMHJB8BOCdkVb6UNQu/ofdubclUNM/beah41hdhVDHEYhPgHbgTir6RsAVUT
         rEZ9BghEtbfj1mVD7I1ybLjqn49qxIXysd5rDf4Y3I1FjlJT/3NmUPZLkvE8exMF/fQL
         4thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948236; x=1761553036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjMEk6mNBH8WSN8eHPXPJ3fCRbx/T8IK9tLp1EWYzkM=;
        b=np144aXlP3FrVNuyMT+UZxtB4VOaS17EDwjGaz7SHEoAOx9CCp6kZouokzaGqitGYX
         cFxK0a2wI2h4v6oOs5sJBKQosdL/JB6pjvqd5BADXG6zrxDvoQKdK/hJWCIX01rUtBsx
         t3CzxCt/qpZuXX48oL/dZSNiSqr6Co5v30bsWF5CD1XZn/GavgS8gRBx6UbiV8YL2zNP
         6simYOBMLzSlk08F14vnYmsMyPrz6qx14YqcNFIXPsLgalfQ5Fye99qvQrFErwj8HZwL
         h9wIWXoifvzt4Aax/oRiiRWb3xZcCE+d3LsdTEfHS5oVuE3mp+0d7l1E3L8ZjL6064V1
         V00A==
X-Forwarded-Encrypted: i=1; AJvYcCWNdJfsAMQGzXtRoLDZEEdHPGWemL19wG61JZAZK7vQ/axYhtpqGLgXSMuvoU5w7dIxmjXR2QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/NRihn8tR6oUGUp3VCdmVYUBhBqckaLqlPFkBD7fFXoUTTkxB
	sLTFxhux7bRle6AXmlEJCIyoc0AKnSE47ebX0xtMr3PRbTNwuf0ZPRD9IRtEBtMahuUxtFWfNqi
	rQfInXCGLTcQ7wAFKAg==
X-Google-Smtp-Source: AGHT+IFFA8Am2fnybv9rvlh//I4Iw/BUP5vE4Qrvs/2x2IMy3Yp6BBWo4VkpWJV7hHHYkfYEkHZgL37ArvDw8k0=
X-Received: from wmbdr13.prod.google.com ([2002:a05:600c:608d:b0:46f:aa50:d6ff])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548a:b0:471:ff3:7514 with SMTP id 5b1f17b1804b1-47117877736mr89174955e9.12.1760948235873;
 Mon, 20 Oct 2025 01:17:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:17:15 +0000
In-Reply-To: <20251020020714.2511718-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020020714.2511718-1-ojeda@kernel.org>
Message-ID: <aPXwCwc4uevRO951@google.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Oct 20, 2025 at 04:07:14AM +0200, Miguel Ojeda wrote:
> Between Rust 1.79 and 1.86, under `CONFIG_RUST_KERNEL_DOCTESTS=y`,
> `objtool` may report:
> 
>     rust/doctests_kernel_generated.o: warning: objtool:
>     rust_doctest_kernel_alloc_kbox_rs_13() falls through to next
>     function rust_doctest_kernel_alloc_kvec_rs_0()
> 
> (as well as in rust_doctest_kernel_alloc_kvec_rs_0) due to calls to the
> `noreturn` symbol:
> 
>     core::option::expect_failed
> 
> from code added in commits 779db37373a3 ("rust: alloc: kvec: implement
> AsPageIter for VVec") and 671618432f46 ("rust: alloc: kbox: implement
> AsPageIter for VBox").
> 
> Thus add the mangled one to the list so that `objtool` knows it is
> actually `noreturn`.
> 
> This can be reproduced as well in other versions by tweaking the code,
> such as the latest stable Rust (1.90.0).
> 
> Stable does not have code that triggers this, but it could have it in
> the future. Downstream forks could too. Thus tag it for backport.
> 
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later.
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

