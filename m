Return-Path: <stable+bounces-205086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 945A8CF8B2C
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 15:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3A5F3033D6A
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B369F3358B6;
	Tue,  6 Jan 2026 14:05:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEA33556D
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767708342; cv=none; b=pdlHYFC6tjxu04f6rATQovnYB4r2CbkAosnNQJv0GSWiUJ7tHZm4mhhf7+QpJQjNxqMUQ/9ZF+wWFFdcwXpZxwIaI1RIgRk5AMurwCWB3KtlU0gm94eRdhddaMwKp4a4r2luNTHWU7lQxeMmRKJ+PBkyGRzHz0Y+Q71dstEDiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767708342; c=relaxed/simple;
	bh=jn+4SpWXKb7N3/U9AAui93xy+20kHsX2m1NThTyiOfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcD4e6WjKVrDRGkMSK1Q+08FpS7/+W1jTUS3qlt8rpiNJMrwEC+hS7At3quT57pxqfHAAx/boGEVyW+qr3hfNbkHJ6Mud8ZvWamJqnDwkO/5fiunG76eOZLZMLdd/1wao91egYn7YyVa3B2fGgPA/h79Jl6iMtVbD/wzrBNYM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ce2b17a2e4so623549a34.3
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 06:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767708340; x=1768313140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu154TMX/+mXm3su25sIKI5TQFzYMOjfJ7G1hsxByO0=;
        b=aI8dzoEobP7fvC5EXn0h7vG6C69FnsIzrImxclknffiYCkU7QSgSQGop1xe+gLoAst
         H3bL4iod+j/xUkS3tLNcRP+0aJn8uHd/PSSCcoyrSHNvFvvfWe/ocFRCabAKOd+NI8jZ
         Ij8B2++6g62WZinJH9xH22b+Euqvuzc+Ah8LAGdR6nNwjROcY6tji7CjDyCITBhEgYiC
         3StPL9x4Zgx/448cr+hpYHS+LYAhbIXrtZp+uTFyqy7guvywgIz7nab4VsR+HZU41O9u
         gO0B0AIvZ/b15KOXDFDMf8o+gsbKBOY6YQaclAeWYbQ/PDlVCug1770b3fh8mVWECIYK
         yZqA==
X-Forwarded-Encrypted: i=1; AJvYcCVJqbS4bEKt1ynBfbGHkcTgXUgHuGF7t1aCynQDP4N4c3/gxi0h2HygQDiJMLau5seQ/JnIp0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/uT6R+gRj0au1f6eWraQAzTG6uYADc0/m9ihQEqouNNcmn4j
	le6aNyV2M4eYoZKCbMDtO+XBq/ydmAmpWM4zdUXfj/fZkCQrz7IWBqe1
X-Gm-Gg: AY/fxX7/3gnuDQ7mtAgD0/ZdhSVJ+WREADWM8SGjNfouWVFvp6sNO4ZU9Q8wL4Mt+Od
	dKM6k9in28MAMGLOq2rWYuAkq/xiLYRIh50+4CWwEXkbw/FbT4zTheG17qdWqsOwK8sVUdj9duW
	HHMoAtALDBRbwGctxQKZ19lm3mK8dLc0wCwwoBzol5qywk0khJf38Ank6vw30l9D5iR0jcNBPGn
	1aftDfEqg9Zpz4uxdrlxvYHyJDVw5pGr1J5KdcvyJprh+LJISxF5mSdOgzCfMzrVqMpv/GPr3NJ
	tGoGeYADFduXxpfzA1xRmSQO/6EYrRNTxHok9P2HLgzioNKvmNIVFwmuHbqo/xa0ikZJQDfjPVP
	ALeppWa5Lfx1nGn1R3q/MXzqX99zw+AvyvwF913FlQLT0Zq6Q9+ZK1AE6qL6+W74Z2hTr3RKb6E
	qBeokSS9EE7edgPg==
X-Google-Smtp-Source: AGHT+IFAyCOognsDglACCwRtgGmfQBOzfISqmFQxoBN8Ni16ip7RMf//hSvC9Q3nMRwn6KHPU/PCow==
X-Received: by 2002:a05:6830:439e:b0:7c7:827f:872b with SMTP id 46e09a7af769-7ce46767c8fmr2483407a34.37.1767708339811;
        Tue, 06 Jan 2026 06:05:39 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47832780sm1459846a34.12.2026.01.06.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:05:39 -0800 (PST)
Date: Tue, 6 Jan 2026 06:05:37 -0800
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Laura Abbott <labbott@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com, 
	puranjay@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Message-ID: <tj43kozcibuidfzoqzrvk6gsxylddfpyftkdiy7xb2zm7yncx5@z33xu7tavuts>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
 <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>

On Tue, Jan 06, 2026 at 12:21:47PM +0000, Mark Rutland wrote:
> On Tue, Jan 06, 2026 at 02:16:35AM -0800, Breno Leitao wrote:
> > The arm64 kernel doesn't boot with annotated branches
> > (PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.
> > 
> > Bisecting it, I found that disabling branch profiling in arch/arm64/mm
> > solved the problem. Narrowing down a bit further, I found that
> > physaddr.c is the file that needs to have branch profiling disabled to
> > get the machine to boot.
> > 
> > I suspect that it might invoke some ftrace helper very early in the boot
> > process and ftrace is still not enabled(!?).
> > 
> > Rather than playing whack-a-mole with individual files, disable branch
> > profiling for the entire arch/arm64 tree, similar to what x86 already
> > does in arch/x86/Kbuild.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> I don't think ec6d06efb0bac is to blame here, and CONFIG_DEBUG_VIRTUAL
> is unsound in a number of places, so I'd prefer to remove that Fixes tag
> and backport this for all stable trees.

That is fair, thanks for the review.

Should I submit a new version without the fixes tag, or, do you guys do
it while merging the patch?

thanks
--breno

