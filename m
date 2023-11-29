Return-Path: <stable+bounces-3188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F87FE3A7
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 23:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11F62824C1
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65C12F86F;
	Wed, 29 Nov 2023 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RC3w4GIH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8DF1B283
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 22:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A223C433C7;
	Wed, 29 Nov 2023 22:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701298488;
	bh=CauGVvFZVP32vkOcY5cg2nLN5FTRx/mzqnRb1nHXFlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RC3w4GIHEwQjkkuvoTWz4fw14yQ+ovAGzFRxTkodMdNtrM9xLvm/G6DnafvnzT6i4
	 j2aH6CmQq/zITzVrtKTMeNM4XzbQ6MkR9S40ngp8DIgUvgRdyZKiOolEQgkAxtgAl4
	 uPYAOIMSYsaxlWzfI1yJoDtqOH+w3o8d678Hf96g=
Date: Wed, 29 Nov 2023 14:54:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, eric_devolder@yahoo.com,
 agordeev@linux.ibm.com, bhe@redhat.com, kernel-team@cloudflare.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from
 CRASH_DUMP
Message-Id: <20231129145448.8cea3323a7eb19b8f6c6a18a@linux-foundation.org>
In-Reply-To: <CALrw=nF-zfmT+JNk9OKe7P3oRa7q820ATy3x4yc2A0z8j6_+AA@mail.gmail.com>
References: <20231129220409.55006-1-ignat@cloudflare.com>
	<20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
	<CALrw=nF-zfmT+JNk9OKe7P3oRa7q820ATy3x4yc2A0z8j6_+AA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Nov 2023 22:34:13 +0000 Ignat Korchagin <ignat@cloudflare.com> wrote:

> On Wed, Nov 29, 2023 at 10:23 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 29 Nov 2023 22:04:09 +0000 Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > > Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
> > > Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
> > > Cc: stable@vger.kernel.org # 6.6+
> >
> > I doubt if anyone knows what the two above lines mean.  What are your
> > recommendations for the merging of this patch?
> 
> Hmm... I was just following
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> and basically wanted to make sure that this patch gets backported
> together with commit f8ff234: kernel/Kconfig.kexec: drop select of
> KEXEC for CRASH_DUMP (they should go together)

I see, thanks.  I don't think I've ever received a patch which did this!



