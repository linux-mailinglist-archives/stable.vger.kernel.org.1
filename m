Return-Path: <stable+bounces-206022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 284EACFA8B7
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 606273161B23
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8D3587AA;
	Tue,  6 Jan 2026 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lp3ghFpq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE2357A5E
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723627; cv=none; b=NtsU87EFHnxikGPsbEyMTuKboe93JxyY+YkauJTHlKH1bNceRNujEGhLtzPzODto8l5f9reYH7QjQv+ozYkXaKeiXhz6rKLcKBZZOrGnhpoVp5Jtgwq+BmMnr9FuOCWb7LrOVXn0Z1SkpF696siWgUSat2hujkle21CYuINJSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723627; c=relaxed/simple;
	bh=LvrOXBIyJ+56pkklnl0rMcgxqybJWbL6RDGcsfnkXjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDmz6xr6mVjFCZoSIICeZeL/iRoiqKi33+dRKhjkfgkm09AjUHnVc8eQqQlj+Ru9pdP8yyDThSBp4PWR1Te0F3DbiOS3FM7Nhqt5Da6KcwtOzZAkL25MHW/jDPTa+Iw6ixn+Y65LnE03pODwgbZZIlKUJXB9qjhY/VDp8y5JMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lp3ghFpq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a35ae38bdfso4135ad.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 10:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767723625; x=1768328425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vFX3VuATVVY47kRmsI5fzfA4Hdj1OU59q5MkyZA5nU=;
        b=Lp3ghFpqv42Aj9QTG+TA0vMf/03DWIfM1VNEIXobMAmM44XI7TGNRhJmEvuhJRIP1P
         h5ehTclUADIp3yd9IfswxS7I4QSWgcil/J7JsqwJTCZaQfRVxreYXp0ZihACifqfnq1C
         1gTBu7raJSojS2QGFgE7NNDxZThfMv8/gdyU0XnaXZ31tJKvJoxJrDkRJjmiXEGFOmmZ
         AbvAWANIrJ0941A/2mbPUG10f0RHMvM7jJwQF1J+pQrueuYeNJFGEThAPNqg8cyZMQHJ
         GPgRgGLVayFm6KzmJPBvyZ/lo/FgpQRzz7+uxJV1xx9s+2smWSAhpaETNMOyCNlB2crA
         IBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767723625; x=1768328425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vFX3VuATVVY47kRmsI5fzfA4Hdj1OU59q5MkyZA5nU=;
        b=MTBG1UFl0GRKJxt+YmZkZcromvHjIarXoQx3Pgwe6AHW4oiBj4yVtB9LuY+HLZwh9o
         vzr+tzvZKsQSA7dDc74v9v36huoqkWsLb/LMKmCJcJg9XReUl2whtMRPbvfe/qitxesa
         949tJAPRCIwn5FXkBGd44G4MJzuIGiylDpcGr+e5UJ6U4LOHgtU3M7238Y9IZiKB6Xu6
         DTsUAFF1HtYEWQGF7l2qxMysnoVlyYvv3N6yJbZcpx0IZFP8Q/XN3xp7fgDdepZDvu36
         Orhmkw26RLwGtBdXXWbHPUpr8adzVtocO8s+uyxjBOlC4J7rQiETC69rrh3ggxL5F2Gt
         uW4A==
X-Forwarded-Encrypted: i=1; AJvYcCXF1tNZRtO9eHO2S+G+Bj7AM2keEfA4dQzAgsQiXUX2GsZpm4po7xNJb3zOKEEMnaurXfKsKA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31AfwCtUwxPhN4MkThl6fDa9NRxYuQXvIiC60B9RJ+tIJT3SE
	IELfhz1+88uq99xl4lRrOdkHPKZHlysBREPS8o7QPEUYtzDY6tG9w8MCJgI83AkP9g==
X-Gm-Gg: AY/fxX4vPTeqfXAELHExw4d1iqnaS1kAKKAZYSRFMIRYUBi5/gE2B4xVGilY18wUF2s
	hZ6gXjdY+4x+v8dRS7idC9wrBJ3CjO84q3ugg+Y4LIGDLeMyXH2J3oDynJEQAUbCSNyEDFLg+4/
	PMxumDUQYQxAPe/p7pSsefVYhop8pT+xEwnVMX5ULGOW/aj0B5o6akXwvWXqWThMdndaHmNF7AN
	iWTM6PmzpT9IsQYzofFM2Zlkfwm94VLQsUHUNuaIvew4NuDjF+NXUcuJlytsArYj9pr1ovyHEsA
	Y/rDAIDH3jRfhIHcrbslAOwGapmmg4QBvQvUkxvVwn7PXfh+2oLonad6m2bABUD14NSZfjVf15Z
	wZVHzffdhG9GwltEm20RIpOjkYfB/get4DIeynn0+87ssZuWhm3+Yki3fUxu/hGyzolC6V+X9kO
	5F3E7w7gKvx5Ry52bWjBIaEe+XobeXC22uCpx7jrQzkv8fKWYCOwM=
X-Received: by 2002:a17:902:e54e:b0:29f:2563:7772 with SMTP id d9443c01a7336-2a3edb4e78amr88525ad.8.1767723624752;
        Tue, 06 Jan 2026 10:20:24 -0800 (PST)
Received: from google.com (210.53.125.34.bc.googleusercontent.com. [34.125.53.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5edcd90sm2755546b3a.66.2026.01.06.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 10:20:24 -0800 (PST)
Date: Tue, 6 Jan 2026 18:20:18 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org,
	DeepChirp <DeepChirp@outlook.com>
Subject: Re: [PATCH] rust_binder: correctly handle FDA objects of length zero
Message-ID: <aV1SYnssUrstzd7B@google.com>
References: <20251229-fda-zero-v1-1-58a41cb0e7ec@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-fda-zero-v1-1-58a41cb0e7ec@google.com>

On Mon, Dec 29, 2025 at 03:38:14PM +0000, Alice Ryhl wrote:
> Fix a bug where an empty FDA (fd array) object with 0 fds would cause an
> out-of-bounds error. The previous implementation used `skip == 0` to
> mean "this is a pointer fixup", but 0 is also the correct skip length
> for an empty FDA. If the FDA is at the end of the buffer, then this
> results in an attempt to write 8-bytes out of bounds. This is caught and
> results in an EINVAL error being returned to userspace.
> 
> The pattern of using `skip == 0` as a special value originates from the
> C-implementation of Binder. As part of fixing this bug, this pattern is
> replaced with a Rust enum.
> 
> I considered the alternate option of not pushing a fixup when the length
> is zero, but I think it's cleaner to just get rid of the zero-is-special
> stuff.
> 
> The root cause of this bug was diagnosed by Gemini CLI on first try. I
> used the following prompt:
> 
> > There appears to be a bug in @drivers/android/binder/thread.rs where
> > the Fixups oob bug is triggered with 316 304 316 324. This implies
> > that we somehow ended up with a fixup where buffer A has a pointer to
> > buffer B, but the pointer is located at an index in buffer A that is
> > out of bounds. Please investigate the code to find the bug. You may
> > compare with @drivers/android/binder.c that implements this correctly.
> 
> Cc: stable@vger.kernel.org
> Reported-by: DeepChirp <DeepChirp@outlook.com>
> Closes: https://github.com/waydroid/waydroid/issues/2157
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Tested-by: DeepChirp <DeepChirp@outlook.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Acked-by: Carlos Llamas <cmllamas@google.com>

