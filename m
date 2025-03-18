Return-Path: <stable+bounces-124849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A43A67B7C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 19:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ABB174B50
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30C212B31;
	Tue, 18 Mar 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8smKr3o"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED2212F8A
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320804; cv=none; b=N2aBE2ySb1wPHp9WoC8wxiDfv21KLbHVNL99VmYOp01Mj8Trki61j0enZqSKryzFWe68qexSkIU8NCwAsM+PLE9EnZZEH3OgvTNM5Etnl3wcGhVTlUyqR11IydNuweoOJGOU5SjnJZXb+vRrSQQ6Cbi++5Oh1K3SgPYfXAfCISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320804; c=relaxed/simple;
	bh=YCRyyk8wKSuBnTf8FSsXwCUk1iLpEv863Em2NqKuLmQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X11eR9SZddINZPpVRwCTM60SdVXfTfZXqpzmjKS77Q3pOa8zb/rX6bA87571IcWmJrjqF2LQAMe71s4XvGiGx1wC57nKB9IlT3m3OJQ1DGrnMMQ7qwhy6FLqsKhnQbS7V7+bwF/gmQ8p1CMQGvaqD1YA3aQpaEoNVu3YVawqWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8smKr3o; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c55b53a459so565989885a.3
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 11:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742320801; x=1742925601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr3zM0P7JWa2X4u5YxIE44a6METV/p+/yTKDJf07qdk=;
        b=N8smKr3o0NkwEHbgqpW849sVRbTX9FCqfNDhF3Lir02CHSASxJp7bdyZsBCcBTn8e+
         M1gMp/HBsRxfqbXNhuawiWn19VsAtWBPrdBQJY1aS4l+0XPd0UK9OaCuT+uT7CYjGSPP
         RUL++kxqKL4nMx3rTt7DLaq3mN0ZHWzAk5VomnZ/7RhtZWHov+MIHDBxDiBzFO9AeGLb
         2DxwG1NfQsRmuA18OebSUisf0u1OEtOW2ca0VUBQCPqFCuD3eXIU/3V1uY6yh8kt7yt/
         V8ezzRiIcMIY0+sbYQxABkrnXFmr+8endSNWvYJONjB5x6n+DfpNa3yDrSEq6F0DXS6a
         UYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320801; x=1742925601;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr3zM0P7JWa2X4u5YxIE44a6METV/p+/yTKDJf07qdk=;
        b=EwXG8YcG3FMlVAoPtVGWxXtY8+3r3NG7ynI5XU9hzHKaFehAJnimKKeCRc6RXwkLa0
         c63+64vSYKi8EzIyQrgJpmtnpkJhT1og38Pww6rKryh+ANYCbaCoCZiwzZfFgaghlVhL
         jclZ0QKavWeS8VYVFDg4YajmevHiGPh0csOb3H/wBoDWXoY7YT/BOzLDPeMvtx6k9djB
         CZHNxca831aH4dwGj6F2/FZDkmarUYDUVbOAhqwGMTOTmFevArhYEGPl665U+Ez6uwGJ
         vZUXFuTq2bv3WYHyk1Jbh7K8dZrPovM6Pb7gGqvNSVld17hejbF2kGbvfLW5q4o4TjA7
         6IhA==
X-Forwarded-Encrypted: i=1; AJvYcCXdDvxvwJ3YNFmYtva0rsOGZTbZ/kSiztFsufa+Fww5Z/0YOaWftyABbIkcWirRRyD2DT1gmeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGq2KYqqiEaCAb3yHAJjXJx19M4dpLUBc1hmuzFk5GAXYiFA/
	hB8CvuKpzeMz6x0sQ05LglCosFk5qWwMuTCODp6lNW9w/yi3Lhdm
X-Gm-Gg: ASbGncsXETC1QjQZtfJtsMnL1kw7GC2GvZTa/nwLlYpU3j5GzaoBp5MgvKMtQX4JWOb
	123dUqyZTve2Plet7ijJL4321DYGr5z2rBv7LpcSB4dBE9EQWYEPq8xAmSr3BSJa9hzn8ORMnBr
	pGmTBcWbwTZy5SplHq8Z7riAyHLAEP9N8utlfg18wYSuJgOGJm0QwaFz/iZaqyrYcoH8QHVpaqP
	a6f0O5fXUwBO0OEaXEUwf8fV8cMzbGSd/XGec8WwdofHFe4scmWG2Tb4F13QH70oiYfZ24EQZnH
	Ge4MceN9BlLis3cn5F0YWpsndmgxBv0lRaJmxx3xtB/FgCtPxMOw1jshQsTzC77DrTyp1rBsLM/
	4ORIZ1kY9uecN0HAay7ILMps6uCjt7MJJeTg=
X-Google-Smtp-Source: AGHT+IE6A9BF2aEZGP1ELeXDwupKEsyur2Ld9SZiOM8DlRGmcAva4vEzMFAT5KsQ4MVGcNd2bVR3qg==
X-Received: by 2002:a05:620a:4549:b0:7c5:4b91:6a38 with SMTP id af79cd13be357-7c57c832049mr2172194485a.28.1742320801468;
        Tue, 18 Mar 2025 11:00:01 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9a80dsm745739885a.52.2025.03.18.11.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:00:00 -0700 (PDT)
Message-ID: <67d9b4a0.e90a0220.3d651b.b756@mx.google.com>
X-Google-Original-Message-ID: <Z9m0nl5umvBhnZx-@winterfell.>
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 410D91200075;
	Tue, 18 Mar 2025 14:00:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 18 Mar 2025 14:00:00 -0400
X-ME-Sender: <xms:oLTZZ3A7o9haAVkGXQsPJ12OgEi1QWTyt6PSP4KmKuLaEOEMu7eBWA>
    <xme:oLTZZ9gKHRhBYXI-CwOIntTuF2muXuL7BahkpWKrqZyPSEpFy5H0m9v7uCtgUeaBV
    spgF8GG0VuqU1W_Jg>
X-ME-Received: <xmr:oLTZZykGnKJlpbjvye9L6GH8_5LUKcdOziZRDT8T0bwS9kEjxogD9PlxjnaJ9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcu
    oegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephf
    etvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedtnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtoheplhgvvhihmhhithgthhgvlhhltdesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthho
    pehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghm
    vg
X-ME-Proxy: <xmx:oLTZZ5zhpuqQSXcI2wXpFigMOB__zGs_I3ZdW_lQ8B5svYPt7puc-w>
    <xmx:oLTZZ8T701eMaoXra9lbbMt07XyIRXXThDKfPTgNUcgAs3ZQRuRFpg>
    <xmx:oLTZZ8bmCms_ZH2GO-BjgDTvqGWS7vdMKsBkaAynyHK9ebELujvfvQ>
    <xmx:oLTZZ9S3H0Quh_-axLULbCIAZkIQHr9coWkQV3DbFwB9JSszdZM2LQ>
    <xmx:oLTZZyCKytjKvC7QiXi36WSzRJCqVKZhAE33xAuyf9qJ5B9_3qNbB1Op>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 13:59:59 -0400 (EDT)
Date: Tue, 18 Mar 2025 10:59:58 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: gregkh@linuxfoundation.org
Cc: levymitchell0@gmail.com, aliceryhl@google.com, benno.lossin@proton.me,
	mingo@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] rust: lockdep: Remove support for
 dynamically allocated" failed to apply to 6.6-stable tree
References: <2025031632-divorcee-duly-868e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031632-divorcee-duly-868e@gregkh>

Hi Greg,

On Sun, Mar 16, 2025 at 08:15:32AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 966944f3711665db13e214fef6d02982c49bb972

It's weird because `cherry-pick` works for me:

$ git cherry-pick -x 966944f3711665db13e214fef6d02982c49bb972
Auto-merging rust/kernel/sync.rs
[stable-6.6 f5771e91eac3] rust: lockdep: Remove support for dynamically allocated LockClassKeys
 Author: Mitchell Levy <levymitchell0@gmail.com>
 Date: Fri Mar 7 15:27:00 2025 -0800
 1 file changed, 4 insertions(+), 6 deletions(-)

my base is 594a1dd5138a ("Linux 6.6.83").

I checked the original commit in Linus' tree, it removes the `impl
Default` which doesn't exist in 6.6, however it seems my `cherry-pick`
can realise and fix this! Anyway I will send the fixed patch soon.

Regards,
Boqun

> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031632-divorcee-duly-868e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 966944f3711665db13e214fef6d02982c49bb972 Mon Sep 17 00:00:00 2001
> From: Mitchell Levy <levymitchell0@gmail.com>
> Date: Fri, 7 Mar 2025 15:27:00 -0800
> Subject: [PATCH] rust: lockdep: Remove support for dynamically allocated
>  LockClassKeys
> 
> Currently, dynamically allocated LockCLassKeys can be used from the Rust
> side without having them registered. This is a soundness issue, so
> remove them.
> 
> Fixes: 6ea5aa08857a ("rust: sync: introduce `LockClassKey`")
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250307232717.1759087-11-boqun.feng@gmail.com
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 3498fb344dc9..16eab9138b2b 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -30,28 +30,20 @@
>  unsafe impl Sync for LockClassKey {}
>  
>  impl LockClassKey {
> -    /// Creates a new lock class key.
> -    pub const fn new() -> Self {
> -        Self(Opaque::uninit())
> -    }
> -
>      pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>          self.0.get()
>      }
>  }
>  
> -impl Default for LockClassKey {
> -    fn default() -> Self {
> -        Self::new()
> -    }
> -}
> -
>  /// Defines a new static lock class and returns a pointer to it.
>  #[doc(hidden)]
>  #[macro_export]
>  macro_rules! static_lock_class {
>      () => {{
> -        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
> +        static CLASS: $crate::sync::LockClassKey =
> +            // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
> +            // lock_class_key
> +            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
>          &CLASS
>      }};
>  }
> 

