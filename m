Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877C9769464
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjGaLOP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjGaLOO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 07:14:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D69E79
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 04:14:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d58b3efbso3892585f8f.0
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1690802050; x=1691406850;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+yXtCYwJ1vp4lh1G4+6nAEpCQWF+yOkcXs9SOROqGU=;
        b=eTpl40ucewCsFMrQBu0kMJ/J9h7WUG8ZwDVthoX9ympKu1DDdzDGoSO4pfrbo1q4lT
         VMS2+6v5e4TcA1hj9UFwPgxEyUDPkKJEwzZkpfIo8iP9o7XCUCImbYbPBqW+q7CnRKst
         Lj1gL/d0bPyzvYAqpNII4QDo1S+u14uH2I56NxuYK2EgrlVefWuAwtT8+se6XUkAHXYJ
         tlimaNnYJp3U8U6ab+VBF2UNMFetpuFVB2TrTC8EDnljcFGNBjnMKHzgPOo/Mf1BCnDm
         +tC8P4rab6qd/cVIyFbr+CMqsXXpHpuHX2mC8ZCH/+uygP6vpGdG4zxh4axf/DGg1Sz0
         LYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802050; x=1691406850;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+yXtCYwJ1vp4lh1G4+6nAEpCQWF+yOkcXs9SOROqGU=;
        b=PWadlTOTpS71gUC4sawuIHBOEZNWMHVn1+Q1gU7OnolsbccPnYkFMBtt3EM9Z/JoEv
         geecl+bFEaQIGjr9uenmWrL6aQQ1k4O1IpuGxsHhN9E3Ak/c+pGaf1mJA4GoS47aWi1l
         kvqqwrBSQ5Hp5yP9hL+658lRSqGTDJ7jFHVehw3iSqYRQi8a9y8aC4+6U/ehyKQUYtbc
         dnXt2Y4jR4YJeNgEMQ29ikzL9XjFQC5LaXS2bAVxorJLEbDHmxD8poFT1bqB0baX/kOt
         pXr1BNwkzDJIwmUlHCiLP2jc5zCEm3vacAyx+sQ2v8juy75+Ot/CTwhu+p6fEZz7wMjx
         XAGw==
X-Gm-Message-State: ABy/qLZ40aTMIU3af0j8rCkZ/eU5RVEZli06S5jq7O62mMoWIy8gY1U2
        Nwsiskb/TXWdzTHETsKmm+POxA==
X-Google-Smtp-Source: APBJJlF6tBQNOBgzMGTKGd+XwA4tKDou2MjpSwYuH4U0eRW22f6ni/4ZHQfT3TJzV5b6WDQPTzegYA==
X-Received: by 2002:a5d:452f:0:b0:317:6262:87af with SMTP id j15-20020a5d452f000000b00317626287afmr5251217wra.16.1690802049408;
        Mon, 31 Jul 2023 04:14:09 -0700 (PDT)
Received: from localhost ([165.225.194.195])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm12713940wrq.115.2023.07.31.04.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:14:09 -0700 (PDT)
References: <20230730012905.643822-1-boqun.feng@gmail.com>
 <20230730012905.643822-4-boqun.feng@gmail.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
Date:   Mon, 31 Jul 2023 13:12:17 +0200
In-reply-to: <20230730012905.643822-4-boqun.feng@gmail.com>
Message-ID: <87y1iwpc3j.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


Boqun Feng <boqun.feng@gmail.com> writes:

> From: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
>
> While there are default impls for these methods, using the respective C
> api's is faster. Currently neither the existing nor these new
> GlobalAlloc method implementations are actually called. Instead the
> __rust_* function defined below the GlobalAlloc impl are used. With
> rustc 1.71 these functions will be gone and all allocation calls will go
> through the GlobalAlloc implementation.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/68
> Signed-off-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> [boqun: add size adjustment for alignment requirement]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/allocator.rs | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
> index 1aec688cf0e0..6f1f50465ab3 100644
> --- a/rust/kernel/allocator.rs
> +++ b/rust/kernel/allocator.rs
> @@ -51,6 +51,33 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout=
) {
>              bindings::kfree(ptr as *const core::ffi::c_void);
>          }
>      }
> +
> +    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usi=
ze) -> *mut u8 {
> +        // SAFETY:
> +        // - `new_size`, when rounded up to the nearest multiple of `lay=
out.align()`, will not
> +        //   overflow `isize` by the function safety requirement.
> +        // - `layout.align()` is a proper alignment (i.e. not zero and m=
ust be a power of two).
> +        let layout =3D unsafe { Layout::from_size_align_unchecked(new_si=
ze, layout.align()) };
> +
> +        // SAFETY:
> +        // - `ptr` is either null or a pointer allocated by this allocat=
or by the function safety
> +        //   requirement.
> +        // - the size of `layout` is not zero because `new_size` is not =
zero by the function safety
> +        //   requirement.
> +        unsafe { krealloc_aligned(ptr, layout, bindings::GFP_KERNEL) }
> +    }
> +
> +    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> +        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> +        // requirement.
> +        unsafe {
> +            krealloc_aligned(
> +                ptr::null_mut(),
> +                layout,
> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO,
> +            )
> +        }
> +    }
>  }
>=20=20
>  #[global_allocator]

