Return-Path: <stable+bounces-191605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C45C1A75F
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9773F358816
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0913271E2;
	Wed, 29 Oct 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZKycbMe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7A3271E0
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741905; cv=none; b=ExA0o0XDOV/urzTcUmOc87UlvdaRRDqPirn7IvKIiJxyut4LeAoyujaNBOkrdVZ76WFeWaJQ9vz++QdUQ6+jaEZKd10xixzpGqn1ncWqWohvN3uDaBosSTvWg3cHtXh0mjL5JalJ9T8ZnMWnc+ja15HR9D+kLAE3DiZmvzxOI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741905; c=relaxed/simple;
	bh=Lis8XgSRnA5YJBARphY+01JX7JiGiM3xwyWmHXnsc2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJ70VHTk1vVdK+XGcu/J9f4le+1fQaZcGUK9nnntlrPmiq5XSmw0x6F+cPvl+WkVF1ETFBQvCd/nLPETcWtcGj3EdUOELiarMZXX+xzbgJ3oxl8bxup/XKUj07lh/8Z59mS7Vjt5ZisAOTXdI2FLKM2IJ5AB5KOtGJkrIEwmfrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZKycbMe; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4270a273b6eso5526056f8f.0
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761741902; x=1762346702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9cuzKWbb4KNIohtS4TrqwKkjylaSR6bB/ye8dvPygA=;
        b=RZKycbMe3C+Kh9HpXsB4fVWevZ/7JW6+SiqRzzH/rg/bNezYJomocEzcib1HS+RwLn
         CVmCFkRer0fjN4vSsZ466D+LsQNo+hIaVsC0faj+O/m3w3DGl/1hSNEVi/BEgUyWu4jk
         c1phhCfFYLmzidKxDPmOGawLhtY79iLRlKhjBwnyrPasH7i1z71G49JCBGVYb5dmeBP7
         Y1GHydTnNjiZn99is49dCz2pHL1uaesbICRK0WZppFClxast0sAiknLafL72rIZEJryT
         Pf3c3aw5VA5AefIuGxlBfhra8BAWHUaUmyCHMX2Laa04JXXV+qQh5S99HFfeqnlszc/i
         l8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741902; x=1762346702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9cuzKWbb4KNIohtS4TrqwKkjylaSR6bB/ye8dvPygA=;
        b=N25mShdtci+Xv1/AxaR+hENPpwvrzVL06yUL6jgRExIhg/D3gPtFmXnpCUGP3OvPTQ
         F6lM4Gs7V0s30Pg/qHHD3hnkfDns0tcoEBg01mfntThkJRJBIo5m71Xrr2FFSxwaggGX
         yxCmtUa8fH3vUFj2aekIiQTFRgBJdHaGG0BeoQaGT1i+u2SdErFTPGlIUbhRLOBGGgcT
         ovSKvXDMZvdUC3ta5J5PeUcRBeUGv5D1yMi5AmEh2H/OEdE9TUPpoMu82FmP7OR3cFPm
         nhhmmWPmcTZxlDdEzyyrLp0LZXZiTC2U+/SrMl42tZkkY0mYnrkJOnpY2gQy0jtgHCGe
         bpCA==
X-Forwarded-Encrypted: i=1; AJvYcCX3lo74Mu+9hBXNWNG7Z2l+Z4NM2wM6xmRaWXwm9wB3hKJZU9RQnb6Q9r/R0NLYkNMfuWk+m+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO96jcfM0sIoM4s0a/u2YAQWTQvEper2F8pQXshKv4k6f+Ve7Z
	jC2/sW+X9740iMkZb4+jmHfWuMq7WieKu9RL2DVf1ozMDz69b7dWjtLmI68P5mvhFZ37EIDjl0W
	HSzMyj25UC0NPcW5toA==
X-Google-Smtp-Source: AGHT+IF6tS2K+sHdcmYL2m3Gzf5P+hOD9oht3waH8CGyonRKx29wIX6mnYWr9P3YR2G4rkduuBWQ0BGNCYQ/n6g=
X-Received: from wmbgx3.prod.google.com ([2002:a05:600c:8583:b0:475:dca0:4de3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:820c:b0:477:e70:592b with SMTP id 5b1f17b1804b1-4771e16e792mr30523355e9.2.1761741902165;
 Wed, 29 Oct 2025 05:45:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 12:45:01 +0000
In-Reply-To: <20251029073344.349341-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029073344.349341-1-ojeda@kernel.org>
Message-ID: <aQIMTQZK49B1FbTA@google.com>
Subject: Re: [PATCH] rust: condvar: fix broken intra-doc link
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 29, 2025 at 08:33:44AM +0100, Miguel Ojeda wrote:
> The future move of pin-init to `syn` uncovers the following broken
> intra-doc link:
> 
>     error: unresolved link to `crate::pin_init`
>       --> rust/kernel/sync/condvar.rs:39:40
>        |
>     39 | /// instances is with the [`pin_init`](crate::pin_init!) and [`new_condvar`] macros.
>        |                                        ^^^^^^^^^^^^^^^^ no item named `pin_init` in module `kernel`
>        |
>        = note: `-D rustdoc::broken-intra-doc-links` implied by `-D warnings`
>        = help: to override `-D warnings` add `#[allow(rustdoc::broken_intra_doc_links)]`
> 
> Currently, when rendered, the link points to a literal `crate::pin_init!`
> URL.
> 
> Thus fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 129e97be8e28 ("rust: pin-init: fix documentation links")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

