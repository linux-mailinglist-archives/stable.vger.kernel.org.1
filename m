Return-Path: <stable+bounces-75589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08652973550
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1291C23D85
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107B2190068;
	Tue, 10 Sep 2024 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxdAqf4I"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345CD18FC9C
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965175; cv=none; b=UW+YKWhpQLMwpBfv6BlpqDAji4jLA88NUjDhEyxKK9j0ZhWvX0klOyiTXkof3lcWFOzAmKB/vpD7CcESqAjhRoARTjm/Him5Ide2fCOeQWlCM0tSWkjCGXxltaRk0dRd3iVgYmb4grT0WxeShAHxuBdrnEzhsUD1hb1t+rGj//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965175; c=relaxed/simple;
	bh=A21/Yw6RCzeAQ2Jcz+5NV87+0c025XbW2Ht0x2ltIeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNuPVOZimhIings3lhxclwMtGy9VZqOC+A5WkUxx3noZzGrX2A9oS49Tozegomn7Wl310Z6a8q40BF8yePXTpWl8hEV7PvlrymAh0ev20bN9otFoDC1mADHqC6Eg5/4JN1hkAE+leIiTWBrgSfWj8z1aADIJnybTKSRkuF1fKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxdAqf4I; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c54b1f52f7so4659316d6.3
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725965173; x=1726569973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9rh49MHP0Xe6F3mYj7GTOn6QuND64p4wMdIuP8SbbM=;
        b=FxdAqf4IFyp7rEwiErAsN80N2jbekF17lhOwXUZRWdr9m5u0FNN0QNdqlpflEF5FOu
         tBIOJZliJxd1P1CSMysv8e1arjX4zAIIkGmQwo5kxjqpHp5awsuVIR2gpxMP9O3DbVUn
         HvJxGuDhoE3SBFW7egdFGkU8FjcArAuWewrlnf2CMHX1tZUml0Sc9duwUC7aNtOMddIH
         XV3Q3AasmqZsRrwv3WaCvqhTlMNjd8vjWaz5hklvGwA/zRJw+oIah0Sk677+LHMPhIay
         wiwpUKfT4zdUPzzummRM0dteEE9YDr0LeDAHE9y0zTHoLKVSkSArQfgTMciswaeT9Qyy
         l1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725965173; x=1726569973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9rh49MHP0Xe6F3mYj7GTOn6QuND64p4wMdIuP8SbbM=;
        b=OZPXfRbQ/fVUPXHhwfw70rybEHZAyK7jF2P9No1SFK8DUoCaqrnetySH7EHgVzTmBe
         /XcuU8UPQB1oHhI8Xhg2d/BoZRUxW55atvB+YCmRFmL33Jt+thHKjIQR1TWCta/zKUOZ
         eYswcOvMcCavs3hqBlCKtlFyYe3h8/m7eNfyYoetQKDMpCxFfkVTAEmHBmeq8IsL3VhN
         OpoqUjT9/O/AO7x7yHRrbF3K/qD7kPSFHrKHxsaD/9lsoEpHhJUXWyRIh5bLXuPp4C27
         P0ES/rvtEFdWrv/V6iHV4ksvW5C/1VPO/04Gb4z0282qfTDjk94j9hNnJIQq6umarCVk
         XG4w==
X-Forwarded-Encrypted: i=1; AJvYcCX7YxS3Tavf7IkGlimch8wr00fgnsHT4/96T6N7Z5M5JMcuMI/BzgcR9b94f8ovZjDulnIKNF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV931GVqRCnRHmSnOjlYFDklE3ZpMlvSroblIP+CCU6oTqzlpv
	4tDWM9ErpFNF/50xaumOIJqSrVQObdiPb+Oio38TkKOtg6BVVrZb
X-Google-Smtp-Source: AGHT+IE/QOjdchqpP2ve/IiPW7B09HA/ECf0AjaeFYR7s6KPnr33UtisLZ8GPuN0+jyjQmioLvm/KQ==
X-Received: by 2002:a05:6214:5409:b0:6c3:5c75:d2b6 with SMTP id 6a1803df08f44-6c5324002dcmr138797126d6.22.1725965172973;
        Tue, 10 Sep 2024 03:46:12 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53477bab4sm29018116d6.119.2024.09.10.03.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:46:12 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id DA39E1200075;
	Tue, 10 Sep 2024 06:30:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 10 Sep 2024 06:30:38 -0400
X-ME-Sender: <xms:zh_gZjRU-vu6weDepZtVg-4bz1Wf1SJ2zkLN2z3A2C8jI5M3t1JoZw>
    <xme:zh_gZkyuIjHHj5d2KuxaGhqfoL5tQ5S_E-6t2C_YcRpN8FmTjsAHChYHt-ampYCws
    sqU6rs6FVpBdIqaBA>
X-ME-Received: <xmr:zh_gZo3WzKE5jJKMhGzwGvuinnfof7N9-FHqahIK97uQDuqG-W1wE3GSvR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegs
    ohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeghe
    ekgfeuteefveetheevvdefieetleevhfelueelueejieeifeelgeejkeelnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpiihulhhiphgthhgrthdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqd
    gsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgs
    pghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkh
    hhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghlihgtvghr
    hihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnse
    hprhhothhonhdrmhgvpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhr
    tghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhmghhroh
    hsshesuhhmihgthhdrvgguuhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:zh_gZjB02UHQhv16avS8x812as9w31G0Z3AYEavW94Eq6iqM_QsyKA>
    <xmx:zh_gZshcfWDT6GS0QAIKK2yAV0JiccJEqxVy-OXJrwaFiONNPh5ZCQ>
    <xmx:zh_gZnrNAjC8X3Axv7Xr42DBMcI26Xm1phR3GdiZvMBCbDVvrfjUUw>
    <xmx:zh_gZniq4qCv9C3Xpr-wWZIB6T8xiTHauMaXPpDEYMKGvN-Q5hhQZA>
    <xmx:zh_gZvQx-2QE2hZpcIHZRIt1cNBYGTozvP1vWfZ6Jw7dnF_f9KOJlP9Y>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 06:30:38 -0400 (EDT)
Date: Tue, 10 Sep 2024 03:29:34 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: gregkh@linuxfoundation.org
Cc: aliceryhl@google.com, benno.lossin@proton.me, gary@garyguo.net,
	ojeda@kernel.org, tmgross@umich.edu, stable@vger.kernel.org,
	sashal@kernel.org
Subject: Re: FAILED: patch "[PATCH] rust: macros: provide correct provenance
 when constructing" failed to apply to 6.1-stable tree
Message-ID: <ZuAfjlv1cp79-NTV@boqun-archlinux>
References: <2024090831-camera-backlands-a643@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024090831-camera-backlands-a643@gregkh>

[Cc Sasha]

On Sun, Sep 08, 2024 at 01:26:32PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x a5a3c952e82c1ada12bf8c55b73af26f1a454bd2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090831-camera-backlands-a643@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 
> a5a3c952e82c ("rust: macros: provide correct provenance when constructing THIS_MODULE")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From a5a3c952e82c1ada12bf8c55b73af26f1a454bd2 Mon Sep 17 00:00:00 2001
> From: Boqun Feng <boqun.feng@gmail.com>
> Date: Wed, 28 Aug 2024 11:01:29 -0700
> Subject: [PATCH] rust: macros: provide correct provenance when constructing
>  THIS_MODULE
> 
> Currently while defining `THIS_MODULE` symbol in `module!()`, the
> pointer used to construct `ThisModule` is derived from an immutable
> reference of `__this_module`, which means the pointer doesn't have
> the provenance for writing, and that means any write to that pointer
> is UB regardless of data races or not. However, the usage of
> `THIS_MODULE` includes passing this pointer to functions that may write
> to it (probably in unsafe code), and this will create soundness issues.
> 
> One way to fix this is using `addr_of_mut!()` but that requires the
> unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
> an extern static `Opaque` is used here: since `Opaque<T>` is transparent
> to `T`, an extern static `Opaque` will just wrap the C symbol (defined
> in a C compile unit) in an `Opaque`, which provides a pointer with
> writable provenance via `Opaque::get()`. This fix the potential UBs
> because of pointer provenance unmatched.
> 
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/near/465412664
> Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> Cc: stable@vger.kernel.org # 6.6.x: be2ca1e03965: ("rust: types: Make Opaque::get const")
> Link: https://lore.kernel.org/r/20240828180129.4046355-1-boqun.feng@gmail.com
> [ Fixed two typos, reworded title. - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 411dc103d82e..7a5b899e47b7 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -217,7 +217,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>              // freed until the module is unloaded.
>              #[cfg(MODULE)]
>              static THIS_MODULE: kernel::ThisModule = unsafe {{
> -                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
> +                extern \"C\" {{
> +                    static __this_module: kernel::types::Opaque<kernel::bindings::module>;

As Gary mentioned:

	https://lore.kernel.org/stable/20240910105557.7ada99d1.gary@garyguo.net/

`Opaque` doesn't exist in 6.1. We could use `UnsafeCell` here to replace
`Opaque`. I will send a backport patch later today if needed.

Regards,
Boqun

> +                }}
> +
> +                kernel::ThisModule::from_ptr(__this_module.get())
>              }};
>              #[cfg(not(MODULE))]
>              static THIS_MODULE: kernel::ThisModule = unsafe {{
> 

