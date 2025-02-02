Return-Path: <stable+bounces-111971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D251BA24F4E
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE88D7A2459
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB51FBCAD;
	Sun,  2 Feb 2025 17:39:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76EBA34;
	Sun,  2 Feb 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738517996; cv=none; b=pqJJhw2GFh3btU23oFvutlLvGC63ZGItUSzg/hfdXcsm5ZDdayRUo0KtQNQXEDW80B37i5IXQZJqwDyKmCf9KcvTMcHqtUjHa9gglx4prDlPWwXcsPZJ+G05jFQ89farZW70UpoG09IXn49XapiaDfY8p5C1+47FHm/BQczPRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738517996; c=relaxed/simple;
	bh=5RqB0QDeFhHfYjER3VWKrW8nhieCjt06QxBNN0mNfSg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Jt4pj1787V32SnIErG1jB3suRBUiEcUqzhOfUFU+6doFreNylDdLiovzNL0DKp5h5bKel9kHznbPZTEHqK7ZvsQtzZWRFaHCq1kN5pjZ3EN71PBriy9o6fdPbq7M/DTgs1h701uS4VcJLzH2nltL1tZAnCS3GpmmEZ7Fui1B1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7C0C292009C; Sun,  2 Feb 2025 18:39:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 70FA292009B;
	Sun,  2 Feb 2025 17:39:52 +0000 (GMT)
Date: Sun, 2 Feb 2025 17:39:52 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
    Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] alpha/uapi: do not expose kernel-only stack frame
 structures
In-Reply-To: <20250131104129.11052-2-ink@unseen.parts>
Message-ID: <alpine.DEB.2.21.2502020051280.41663@angie.orcam.me.uk>
References: <20250131104129.11052-1-ink@unseen.parts> <20250131104129.11052-2-ink@unseen.parts>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Jan 2025, Ivan Kokshaysky wrote:

> Parts of asm/ptrace.h went into UAPI with commit 96433f6ee490
> ("UAPI: (Scripted) Disintegrate arch/alpha/include/asm") back in 2012.
> At first glance it looked correct, as many other architectures expose
> 'struct pt_regs' for ptrace(2) PTRACE_GETREGS/PTRACE_SETREGS requests
> and bpf(2) BPF_PROG_TYPE_KPROBE/BPF_PROG_TYPE_PERF_EVENT program
> types.
> 
> On Alpha, however, these requests have never been implemented;
> 'struct pt_regs' describes internal kernel stack frame which has
> nothing to do with userspace. Same applies to 'struct switch_stack',
> as PTRACE_GETFPREG/PTRACE_SETFPREG are not implemented either.

 I note that we, unusually, neither save nor even have room for statics in 
`struct pt_regs', so this structure by itself is unsuitable to pass the 
register file around with tracing calls and the like.  So it seems to me 
there's no point in exporting `struct pt_regs' in any way to the userland.

 What do you think about providing arch/alpha/include/asm/bpf_perf_event.h 
instead with either a dummy definition of `bpf_user_pt_regs_t', or perhaps 
one typedef'd to `struct sigcontext' (as it seems to provide all that's 
needed), and then reverting to v1 of arch/alpha/include/uapi/asm/ptrace.h 
(and then just copying the contents of arch/alpha/include/asm/ftrace.h 
over rather than leaving all the useless CPP stuff in) so that we don't 
have useless `struct pt_regs' exported at all?

> Move this stuff back into internal asm, where we can ajust it

s/ajust/adjust/ (NB scripts/checkpatch.pl does complain about it).

  Maciej

