Return-Path: <stable+bounces-114369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE90FA2D46F
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 08:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091B23AA2D4
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242CF1A8F74;
	Sat,  8 Feb 2025 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYR2UTBS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834001A5BA3;
	Sat,  8 Feb 2025 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738998875; cv=none; b=nQpjTWFuzDRZ0c0XUcFHJUkK27yK0Qkf8sParwM8pBWioXxPEySWAy51zncVoRWTVhptrDrZzjNe+YPWsxs6YJ2sibWnW0XrGqpP2aOKEb5unVVCW91SS2oArveHR80AtxMlyjxis8YQdw048o+fXXYSzLbC3qNtgKAlRNzi/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738998875; c=relaxed/simple;
	bh=5PPzswXLCYycw4FzLaiLH/vyU5KIFGf5TLEB/UdgT0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpBcGvjTI7B4Na9AMLM+0OrfZDnj19GfVSJoffM/5h06lUrHVHDM+zq5Ksz/yT6TCy6WWXyXhsA4ZgHik3I/geWY06rWG1XjbPlqSrofzmXi3+cuRRUGWmpQxqV+0kxEJzxkMfbCMvjL6AS79FXo56hG17wCZ0HBcHlKbcvr0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYR2UTBS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9d627b5fbso5118342a91.2;
        Fri, 07 Feb 2025 23:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738998874; x=1739603674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8AtJO3Auz+wNQ7YcvRVGGTP1+wDxutvZ8uaptDjAaE=;
        b=EYR2UTBS9O+h++KUNt41EmDNgMpG6JMYvANHkNYRqY4611QjUdZczw8yfznmNbArAm
         /uEjAHQoJ6jmwX5iQ+6aNPp+DD3OQRrRW9qSXxpzLIcw6RT1spln9Mj77cgtd65pugRX
         aI7b3vr3kqOg/23zKXJsmN+wUtejupIu87hnL82n8qoRvAJK9QavoCb9DGe4h07RWWEt
         9b/Zq75+3hwmTTrR0IB0+8po4SrKuTg7r+FEUYl83Q1fWOK1aeVk8IWjHw/d5p27HJQu
         t7PoEgKnSZZqNvsLByugL6XU2wxh9Oar7F/N5008ZuExOJdSzQh8OxrOiCN5akOvsrqK
         3ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738998874; x=1739603674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8AtJO3Auz+wNQ7YcvRVGGTP1+wDxutvZ8uaptDjAaE=;
        b=TZRGrehbam22H7LHz2ZshWX15OjqjYa9ijN1mxXsM6A/hLVTHvvVa+HoFJdqJz1K6u
         +iUMWeEi9oPxAy1TiCg8S1QD/20DtJOwXsTk28Ixe+aecklz4VMOLRwK0bDfuAcm0AGu
         nCRPJPZeiVebMYU60ARrbQKZ0Laa2THEKmtAh6F4vDSsD+I9ZRVJBB4BJ7HoCNjGyTbw
         XX6I4w5CYtGa63VaQlK82Kgk3yZ1ID9YcsUEGurnTNo9b4rfRJfvU4KfMuSAp9V9U8wv
         jfX6jyHBr0gDkfBMFf9vUY2A4HOccDswf/sEx7FagdzJo+ByhB0lY7Ln8Rok9j2lD+wi
         depg==
X-Forwarded-Encrypted: i=1; AJvYcCVFAcKAXDQKpnuyBR8S/RsEWncyi+It4b1/CnILxmeTx0rW4XYC9HKlmmJC6MEthzlBYzl/CtxZ@vger.kernel.org, AJvYcCVkwIqca5ccSIvttpNXxxeBKvsFPZg+aOTlxONvAQPjIrS120UYL8EeziYa4L/Ia+iOT2sNcHbX4lquW671PUE=@vger.kernel.org, AJvYcCX/W3aXm+VwXUdWvgWxQjaxjUjkEWd2RUgWUP+rZP6/bDJZpEGuHYhvDDXz23O4pVdnNYItnlGJw3Tsgis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGIp3GqOk1qrJL4LY9nsNe8MP19RjLbF2auLye4sFBKP/AtZhf
	E5bwDqi4TR5efhdT+HVYHLTbFdNFiLu/SkLwR48JCpAo46v6Ol/D7V1RtpOp
X-Gm-Gg: ASbGncvr25hqAVvcNzNSBv/6JbNpmoRAl9LtjkeZ86wDw8+W+whu+y56/2tpGVF0sAZ
	G8OfVvrqc24vvRTAqBzGkh3QwqFC82sQZbqYdh/FVMCTX9lGLOpo9qw/U8sKmu9ARKIcNFllwzN
	JZgs8tz+4DVRM+Ux66jrK3oYhloNatijcTjT/z2cBZF+f6c5mfpdQq/Qen7I/AOBd/4nN9RtNF+
	NI4/1CHa7Tq7Dh9iJ7L7oiaqvXuOVs0UE43cM/8T8UsteiyE89Ok+WFdQigQsQfhjeTDi/l4WBQ
	3dCvcdDxrWoBpK/L
X-Google-Smtp-Source: AGHT+IEH0fRD2QBs5bdODlFNhgw4SMnj2geK3gnFsTsUxiB7yi52Yig5fr8iMNQ8Mlq7WbrzHMPldA==
X-Received: by 2002:a17:90b:4d05:b0:2fa:d95:4501 with SMTP id 98e67ed59e1d1-2fa24177388mr10674686a91.18.1738998873593;
        Fri, 07 Feb 2025 23:14:33 -0800 (PST)
Received: from ohnotp ([2001:f70:860:4100:e712:ac1a:da07:2e53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa5312f4c5sm285405a91.8.2025.02.07.23.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 23:14:33 -0800 (PST)
Date: Sat, 8 Feb 2025 16:14:37 +0900
From: Yutaro Ohno <yutaro.ono.418@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: rbtree: fix overindented list item
Message-ID: <Z6cEXXvAbbDa13j5@ohnotp>
References: <20250206232022.599998-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206232022.599998-1-ojeda@kernel.org>

On 02/07, Miguel Ojeda wrote:
> Starting with Rust 1.86.0 (to be released 2025-04-03), Clippy will have
> a new lint, `doc_overindented_list_items` [1], which catches cases of
> overindented list items.
> 
> The lint has been added by Yutaro Ohno, based on feedback from the kernel
> [2] on a patch that fixed a similar case -- commit 0c5928deada1 ("rust:
> block: fix formatting in GenDisk doc").
> 
> Clippy reports a single case in the kernel, apart from the one already
> fixed in the commit above:
> 
>     error: doc list item overindented
>         --> rust/kernel/rbtree.rs:1152:5
>          |
>     1152 | ///     null, it is a pointer to the root of the [`RBTree`].
>          |     ^^^^ help: try using `  ` (2 spaces)
>          |
>          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#doc_overindented_list_items
>          = note: `-D clippy::doc-overindented-list-items` implied by `-D warnings`
>          = help: to override `-D warnings` add `#[allow(clippy::doc_overindented_list_items)]`
> 
> Thus clean it up.
> 
> Cc: Yutaro Ohno <yutaro.ono.418@gmail.com>
> Cc: <stable@vger.kernel.org> # Needed in 6.12.y and 6.13.y only (Rust is pinned in older LTSs).
> Fixes: a335e9591404 ("rust: rbtree: add `RBTree::entry`")
> Link: https://github.com/rust-lang/rust-clippy/pull/13711 [1]
> Link: https://github.com/rust-lang/rust-clippy/issues/13601 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Hi Miguel,
Nice to see this change so quickly.

Reviewed-by: Yutaro Ohno <yutaro.ono.418@gmail.com>

Cheers,
Yutaro

