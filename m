Return-Path: <stable+bounces-121453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53466A573FD
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 22:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCA31899DB9
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 21:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942B220296C;
	Fri,  7 Mar 2025 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb02LTDH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6485931;
	Fri,  7 Mar 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384212; cv=none; b=EUlrCGphe9VQV4Mt2I4jNMZ7YbKF67kHGJoy87cpHfSnyNsuuxBaoNtgm3O+L3h/oai8nRZC6sFjKxKZR0nQsyb6IXlSJAU8sUlsb2GeyTBUFMMMtboTdJvxE6f7R2SCcnLmoqZx+NWz3ffEAef83PMRlPbVFMMbh37z+704rAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384212; c=relaxed/simple;
	bh=t3J9Jbzv3WAbF/p3VfDFeviiTiXXWFrij1QqVAZd35Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2UieGKQqWKu+XpFhVdwg770V8rj4d0a7tekNov0b+mGAR+IaMcvs3dwbQwrFWqalFMBokHrZ2KC5RrO2WTzwymn9jhax7RLs31+0f4Hadj4gVAepY4gMl94nnD+mUZvd0zVecNRaGq8JJxgb4ILLr60Mhf0JJ3mljSjcf86VuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb02LTDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A138C4CED1;
	Fri,  7 Mar 2025 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741384211;
	bh=t3J9Jbzv3WAbF/p3VfDFeviiTiXXWFrij1QqVAZd35Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fb02LTDH7hor0YmkayUrHN4QiBx4M2WCZEvl37aytUv8JnhvMIJS9eAxoKI4/Uprg
	 grVRPcGg0SVHLB6iuIOOpHaHP6lCpLpvwEmVfTDc2dzpbqOsWzrGhtsD1Gq1jOLkMW
	 kYLiJxfzR999hpZLQGTbWBtehMUFjgFQ3mxE1BB6t0/pYBm1EDuNTIMh6vWmYlVWRX
	 +8krqjDNe8RiOf7XYraAb+B4SnkTYw8R5iazCoQZJxUXlGuO+rBmRtX3L+6TKYc8QU
	 QoEklri//+t1zHEM/GLUDMN74iKC479iPPp1eNd/2RVp/bOm7XA8OE6MJlyy+yoDs8
	 FYVgVcmHpiALw==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	jslaby@suse.cz,
	linux-kernel@vger.kernel.org,
	lwn@lwn.net,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: Re: Linux 6.12.18
Date: Fri,  7 Mar 2025 22:49:43 +0100
Message-ID: <20250307214943.372210-1-ojeda@kernel.org>
In-Reply-To: <2025030745-flaxseed-unsubtly-c5e3@gregkh>
References: <2025030745-flaxseed-unsubtly-c5e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 07 Mar 2025 18:52:44 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> I'm announcing the release of the 6.12.18 kernel.
>
> All users of the 6.12 kernel series must upgrade.

While testing another backport, I found an unrelated build failure for
loongarch in v6.12.18 that I did not see in v6.12.17 -- I cannot find it
reported from a quick look, so I am doing so here:

       CC      arch/loongarch/kernel/asm-offsets.s - due to target missing
    In file included from arch/loongarch/kernel/asm-offsets.c:8:
    In file included from ./include/linux/sched.h:12:
    In file included from ./arch/loongarch/include/generated/asm/current.h:1:
    In file included from ./include/asm-generic/current.h:6:
    ./include/linux/thread_info.h:249:6: error: call to undeclared function 'annotate_reachable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      249 |         if (WARN_ON_ONCE(bytes > INT_MAX))
          |             ^
    ./include/asm-generic/bug.h:113:3: note: expanded from macro 'WARN_ON_ONCE'
      113 |                 __WARN_FLAGS(BUGFLAG_ONCE |                     \
          |                 ^
    ./arch/loongarch/include/asm/bug.h:47:2: note: expanded from macro '__WARN_FLAGS'
       47 |         annotate_reachable();                                   \
          |         ^

As well as warnings:

    In file included from arch/loongarch/kernel/asm-offsets.c:9:
    In file included from ./include/linux/mm.h:1120:
    In file included from ./include/linux/huge_mm.h:8:
    In file included from ./include/linux/fs.h:33:
    In file included from ./include/linux/percpu-rwsem.h:7:
    In file included from ./include/linux/rcuwait.h:6:
    In file included from ./include/linux/sched/signal.h:6:
    ./include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
      114 |                 return  (set1->sig[3] == set2->sig[3]) &&
          |                                          ^         ~
    ./include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
       62 |         unsigned long sig[_NSIG_WORDS];
          |         ^

I hope that helps.

Cheers,
Miguel

