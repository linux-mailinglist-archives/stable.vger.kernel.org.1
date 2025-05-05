Return-Path: <stable+bounces-139648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC750AA8F63
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512DE17520F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE61F3D2C;
	Mon,  5 May 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbAg5WgB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CB1F5617
	for <stable@vger.kernel.org>; Mon,  5 May 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436989; cv=none; b=XDu3BSC7d9VG2OWqFg/OSuVmn1Fsm4f/l4vt6D3o9MnhOEJkmdALVND+KhjJ6/RBMG2zqS+NTEu0OvwwLmi5Rg+ct+5LBfPiynf8bUy9pYO4eZr6dfrSrdtfPkuoKh9aGZuKTBWfBrp0A3lEMUXhhQpR4fUm5/uNn4lfa9dzqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436989; c=relaxed/simple;
	bh=VOdVgXxRjUc9ZrK+YEPI5gJ5KQN0O3vZhuF2gL43jZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VsgYjPh6z8UsA+Vk0rnKBxdehgayibdX/+sq1e8813oKzJEZhxFi8WHVoak2l4thS45+I6td14L8ddKAx+TfIePA2cUIJVOJqwPSG+WF/LfmpnBNVAxLP85SJjCEhIzsYi87Dgv0bRI44Zj7+ZaBzjJG5FTRqkI4yJ6iOhR87yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbAg5WgB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso20072335e9.3
        for <stable@vger.kernel.org>; Mon, 05 May 2025 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746436985; x=1747041785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYhLhqsz0QgAIGtWeBREADtT5U6NplMqh1ZF+EYzXS8=;
        b=gbAg5WgBMNtVDuWUCSbgxCGk0zPekgmYIDAzLlk714isQeDFzNfISmckcMqh37tL5r
         45Tk/+7eqw0EAez/ZCwt4nDX65ih6Ttj/1hMRJBNyrPqQJMtBWFC5N+Tq3/C5rf+133S
         NGnuEJX6Ah/Chk/ZN56ICkltHywauAsB3IEg+jXBZFLsbOz1ppCN5XRJ5JXsEN/bh30a
         kj7+V/G9ukGoRfYO0GTRsYKZyls5h+3zy1rUb3qft7J1hb2S90Kzdg4MBgjeqyho6pX2
         UfG4TGZvtk1KOkojwTQdgXtI9lgvDukf4zJKnkRMh00nQ98qIZEIiizOKLfZZ9Kn/I7t
         u2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436985; x=1747041785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYhLhqsz0QgAIGtWeBREADtT5U6NplMqh1ZF+EYzXS8=;
        b=iaHQQfbJE/Z65OzW6jS89Y79WpiU8UViGi2t032Y50PDPlRbwbWmAHnkNSxfFG6Qxe
         HnYvWmiLxac/gfQnyzYXDyTUUwN2wdy3zIRJrXnrfRYqqlaiDSY3yWGlFLSs1uOYCnk+
         nbqlrLtJNjL1JTQUL/Ewr829pALblGu3COO19I4usvxvDt9ThzXohIagkVG7IeXMFW/z
         s5vh4mEiFUE9rBXmJ9UZi0UNKmK/RyjEMb28QKHXIA0Ip/VobG2RCRBdJDkcBzadrLyC
         Ab+NdHKoitNRRWmr6TgRka/qOSV0nFFRTMtVgloCF71wupRMml5DMomHNaensLTly5Y5
         Y8pA==
X-Forwarded-Encrypted: i=1; AJvYcCWuE/CS1toA2JuR4Uwnp7/PDdw+3qHBMdfojlOkh4AgD3wh8aj/lc2aUy+o0Ece9Zjkxz2DDSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWh8HITSnogJHx3sw9Z+Gz+oQKfxzx2WosDUK1l8Wul+j+/ZP
	pvamqt+FBgNKp9qlETuEG3ROe2tVqeffd3DZfaFvQrR/utVBVtSk1VOW+IVIrcNvJsTuPYnHlU1
	k0prb+DpzsRAiJg==
X-Google-Smtp-Source: AGHT+IGKmUkyRXUGCux/8W5tzNoSQGrev54dx73LRy4mpzycYZ3R0Lrs7YdSqxCw934omv5QZx/C9TtcgUJDmVo=
X-Received: from wmbbi5.prod.google.com ([2002:a05:600c:3d85:b0:440:5e10:a5a6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a41:b0:43d:94:cfe6 with SMTP id 5b1f17b1804b1-441c48dbdaemr51294055e9.16.1746436985561;
 Mon, 05 May 2025 02:23:05 -0700 (PDT)
Date: Mon, 5 May 2025 09:23:03 +0000
In-Reply-To: <20250502140237.1659624-3-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250502140237.1659624-1-ojeda@kernel.org> <20250502140237.1659624-3-ojeda@kernel.org>
Message-ID: <aBiDd43KSHJJqpge@google.com>
Subject: Re: [PATCH 2/5] rust: clean Rust 1.87.0's `clippy::ptr_eq` lints
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, May 02, 2025 at 04:02:34PM +0200, Miguel Ojeda wrote:
> Starting with Rust 1.87.0 (expected 2025-05-15) [1], Clippy may expand
> the `ptr_eq` lint, e.g.:
> 
>     error: use `core::ptr::eq` when comparing raw pointers
>        --> rust/kernel/list.rs:438:12
>         |
>     438 |         if self.first == item {
>         |            ^^^^^^^^^^^^^^^^^^ help: try: `core::ptr::eq(self.first, item)`
>         |
>         = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#ptr_eq
>         = note: `-D clippy::ptr-eq` implied by `-D warnings`
>         = help: to override `-D warnings` add `#[allow(clippy::ptr_eq)]`
> 
> Thus clean the few cases we have.
> 
> This patch may not be actually needed by the time Rust 1.87.0 releases
> since a PR to relax the lint has been beta nominated [2] due to reports
> of being too eager (at least by default) [3].
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Link: https://github.com/rust-lang/rust-clippy/pull/14339 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/14526 [2]
> Link: https://github.com/rust-lang/rust-clippy/issues/14525 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

For the list file, it might be nice to import core::ptr instead of using
the full path each time. Or maybe just disable this lint.

Alice

