Return-Path: <stable+bounces-132633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FD3A88540
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0BC3B9D75
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C5E275865;
	Mon, 14 Apr 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipXhlbOv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802C275866
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639671; cv=none; b=VIbid5kG9l1CL2rD7Xd1xylORfQZ79MBapplr15mM9Bw8Bw2/Z8JzI/OJpElNuH+Dv4/QxEQFk+Yx0UlnxRGxx1biLkbrlJuN25hmonIJcFBwP+jez032G8LSXUcWAWZYlIziK9pCGY8Bp9exWnKBCT/gmG92/Sq4K9HLio06vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639671; c=relaxed/simple;
	bh=AYWkkj9NyBWLE+vHeCXHgbQh4tX6WsCz2DwqzolPXQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fYnwDBQXvpckb2PRuTmyB1/YGsXj/nP/ycEWOonrPhpOw5EZykNCVLTcb9VaQi4YpxC5fHbsuieXXeqGB1W+0zuEmMe+pXrf9/T6S5OL1TyOS525UD6BB6qPqa2cHy2E6kGdYDj3tuAdjsaE6wbaaKGkUc+zi14j2eDnWhfg1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipXhlbOv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43eed325461so27492215e9.3
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744639668; x=1745244468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=99k4XkFNDnG3EsiHLB6vmh114esekQLkfPzps9wZH3s=;
        b=ipXhlbOvvW8tOfQXgeqpXiKHRjCloi8PAp1SHqDO+YFdqx47gk/va9gz0DkJ87mLUd
         wkR9SeecTd6le3K+82/apQZwRTbCNGEVPTcZeo4Vk2zFA9brhS5zwnWLk/NzTsX9NKL3
         ZHHL8HEl4LGe20gK48B8imfXxRM3nm7TIXcWl5rpink1UPPGW0DEsOD2OXlQ3NXlsbSs
         f1wZSGnkJsM2GkAXeDaHHBT318wkNL25QzZmQVw+JR5Eu8dnPRVL+CtoxBzXZ5fsIntK
         pfuHdJX6i6bBKP7WcaoOhDO7Klysz8L3lNZwBGAePSABkc+7PikVzhKsx6kA/bI0ZWL4
         j65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639668; x=1745244468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99k4XkFNDnG3EsiHLB6vmh114esekQLkfPzps9wZH3s=;
        b=SRjvZQ7lxs1zVv4IcxOErnLb4aX6FlOcyLgtdIFFKQFOaGzz2QxKZfXe6jY8r/v+A8
         mVq3mA8rOpAd4Ly/Vt5unEknbg0UYOPiQDHUrxmh+gFbrBsSQlreXWW3mnfiUFWfzmun
         cT9BBH4p9KVcAFPP3yJ7pJ15vHUSPoOJsz60tavBs3cuf7xA699llc2JEGXPjxqllHCn
         CpKyfB23pCNXU867SvcecT6dzbpmUVFMOdW+z0aExEYN1dl+RP7y5p/mopa438IYJ5At
         7gUGSNfEbUtgKbqYKteW/p4uGUPV8dJxTqjwqc/UijazMTw2xCPg6i6PNUCA+k8kT5DQ
         K4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyFps0WtszzxrNTPntDouquivfvIkSdbAt9SvRFJ/chZBBekEHQZVrju/gSowX5xJjIROgPG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysNVLIoG69hm8hzop5WG3vvsYwwUzCjNrESmAplu6NKCdCrZj5
	HsdfPOfp34l23QOIzT6l+tnRBu9FWDGMcNU/5A2uTL57K2+ff5TFbKuf6woEvwyZ9Wt05aPnL9d
	cHLlTW4nDroZ7pw==
X-Google-Smtp-Source: AGHT+IEN9Rftc6XcCDbvh31R9vqfEr61DrJmd3at5EtnCIlCs+9Wd11hNl1/CdDZ62/r1z3umTWHKnoW1ogWl8g=
X-Received: from wmbgz6.prod.google.com ([2002:a05:600c:8886:b0:43c:f517:ac4e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f94:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-43f3a925899mr111059205e9.3.1744639668562;
 Mon, 14 Apr 2025 07:07:48 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:07:46 +0000
In-Reply-To: <20250413002338.1741593-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250413002338.1741593-1-ojeda@kernel.org>
Message-ID: <Z_0WsnalDXDEmPdk@google.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Apr 13, 2025 at 02:23:38AM +0200, Miguel Ojeda wrote:
> Starting with Rust 1.86.0 (see upstream commit b151b513ba2b ("Insert null
> checks for pointer dereferences when debug assertions are enabled") [1]),
> under some kernel configurations with `CONFIG_RUST_DEBUG_ASSERTIONS=y`,
> one may trigger a new `objtool` warning:
> 
>     rust/kernel.o: warning: objtool: _R..._6kernel9workqueue6system()
>     falls through to next function _R...9workqueue14system_highpri()
> 
> due to a call to the `noreturn` symbol:
> 
>     core::panicking::panic_null_pointer_dereference
> 
> Thus add it to the list so that `objtool` knows it is actually `noreturn`.
> 
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Fixes: 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> Link: https://github.com/rust-lang/rust/commit/b151b513ba2b65c7506ec1a80f2712bbd09154d1 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

