Return-Path: <stable+bounces-76104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391D4978813
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 20:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738CB1C20C9F
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEF112F588;
	Fri, 13 Sep 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YFLfK5Jq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A77580A
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253123; cv=none; b=LwnmwZEXTTGB6xzhUiOnunx8qkJnN5nTTAN/hxSown9K4e3PEz7MmNf/9UZ/+kYusGTJTu2xfmz0t2p65aSUgOZIB1PjwV9P3u0ochY8VX/gsJrVNuc2JdWPjLWWuYyQs/yRfm/VvL1peXY6BLtwDJEp8Pj5uZBZfXMfGBqOLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253123; c=relaxed/simple;
	bh=GlBvP3ViV9KPWtoucCkWNwSLKlfFG/0mIg/gEdqo61M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga8kHIZADEUtih09WDkloCxVYXzaWQ/45ij3TOXwrzNH4VruHnTTnMdJQsMap3TgnlAaizm4MPcciybIOdhP4TQF55PL8vO14k8AHFBT4FJhYB7uP/4JxQMRYADFBEmeGUb59H5mabFKGTAGZjSLpaLuXv1pnHcOQMhEDd0kxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=YFLfK5Jq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so24143885e9.0
        for <stable@vger.kernel.org>; Fri, 13 Sep 2024 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1726253119; x=1726857919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSzjfySTjvZJGJIQqb4ynY2CDR7SAt/ILMEUtxFMYeE=;
        b=YFLfK5JqKannNOx07APWZygbKmCAMb6NOqUFEZsWYDWzi1/KWoJtMxKmBaVRnhtPIn
         r9medNucrg+cbHiR2iP6Ja2bGK/uCK6hznXX11EB6dT1YZpnvKi/134sHKPy5+RSzvSH
         BTKdT7WJB33NgfHkVeyahrhsIRStu5LtBrCYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726253119; x=1726857919;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSzjfySTjvZJGJIQqb4ynY2CDR7SAt/ILMEUtxFMYeE=;
        b=gXA5p4/nm4Xis5YasiOf+vk5r/34cMq9wUZtPehanPXxD25+WBfBF0kj5s5BRTMioS
         pMEixc7XSKBw+PMHpqtUGh5tEb6Ha3bdf1bNHaRngq7RyQiTZ1B3KXV2h9DCA4RGpf1X
         VbyB6PNhrfJx3XSzmXfqzofLrxGrHXehChQccrPUUMPrB2XiEF8EeXY7W1bCkQL9mTXD
         H9Ud1JL2yR8opwJs/8rXWppXgIOY/axLYdROLb5w3cKs3+jagmOq2zVbQBUNkG14sE4y
         77YeVsPNBqh5v+N6qKujEIgSK/foAB0WwWY07tceB69XaTkhCJnk6tYCm4IRN2KOp6mJ
         m8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWZzvwexrdl7AgGf/l8dy40SNHtm6awK7F6wIafBexlcT6JCG4n6lWBo48ypQVK9zKflwgoYMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsStqyaz2Df7nSpEXS+os+UdvwrU83UX3W9y2X3X2uDAFW3iMt
	CZw7j6PQUML2620JttxmIszMHEaTXFMou7V/kckPo/fwKoXCASxgvYG/rxSeXDc=
X-Google-Smtp-Source: AGHT+IFPN0GwoCbn4Rkz9K4zq2VjUv9KlAEsC/5ciNxXM3x3Pn5uZy49vr9hXmEsYYlJz6eJPjBoDg==
X-Received: by 2002:a05:600c:6b0b:b0:42c:bb41:a077 with SMTP id 5b1f17b1804b1-42cdb56daacmr58188035e9.23.1726253118897;
        Fri, 13 Sep 2024 11:45:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665632sm17538008f8f.37.2024.09.13.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 11:45:18 -0700 (PDT)
Date: Fri, 13 Sep 2024 20:45:16 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: sync: fix incorrect Sync bounds for LockedBy
Message-ID: <ZuSIPIHn4gDLm4si@phenom.ffwll.local>
Mail-Followup-To: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Thu, Sep 12, 2024 at 02:20:06PM +0000, Alice Ryhl wrote:
> The `impl Sync for LockedBy` implementation has insufficient trait
> bounds, as it only requires `T: Send`. However, `T: Sync` is also
> required for soundness because the `LockedBy::access` method could be
> used to provide shared access to the inner value from several threads in
> parallel.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

So I was pondering this forever, because we don't yet have read locks and
for exclusive locks Send is enough. But since Arc<T> allows us to build
really funny read locks already we need to require Sync for LockedBy,
unlike Lock.

We could split access and access_mut up with a newtype so that Sync is
only required when needed, but that's not too hard to sneak in when we
actually need it.

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  rust/kernel/sync/locked_by.rs | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
> index babc731bd5f6..153ba4edcb03 100644
> --- a/rust/kernel/sync/locked_by.rs
> +++ b/rust/kernel/sync/locked_by.rs
> @@ -83,9 +83,10 @@ pub struct LockedBy<T: ?Sized, U: ?Sized> {
>  // SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
>  unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
>  
> -// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
> -// data it protects is `Send`.
> -unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
> +// SAFETY: Shared access to the `LockedBy` can provide both `&mut T` references in a synchronized
> +// manner, or `&T` access in an unsynchronized manner. The `Send` trait is sufficient for the first
> +// case, and `Sync` is sufficient for the second case.
> +unsafe impl<T: ?Sized + Send + Sync, U: ?Sized> Sync for LockedBy<T, U> {}
>  
>  impl<T, U> LockedBy<T, U> {
>      /// Constructs a new instance of [`LockedBy`].
> @@ -127,7 +128,7 @@ pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
>              panic!("mismatched owners");
>          }
>  
> -        // SAFETY: `owner` is evidence that the owner is locked.
> +        // SAFETY: `owner` is evidence that there are only shared references to the owner.
>          unsafe { &*self.data.get() }
>      }
>  
> 
> ---
> base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
> change-id: 20240912-locked-by-sync-fix-07193df52f98
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

