Return-Path: <stable+bounces-147991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB63AC6F68
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 19:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C74F3A180D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF701FA859;
	Wed, 28 May 2025 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT8UkacD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F01EA91;
	Wed, 28 May 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453487; cv=none; b=FwBgsXntm8uznF7+HBC7/fi6dtP+NJXvGJtM6GXnXpwOn/vWkMnHPNi0dL5HtaEpxUQGRF1xJykgWRub/4eaJ2M4p6djX6w1N7WPFQKGssh2ukmc1g38cWX7wXftzcRbBwDuHbQS/JCoTlU7sRR09fOm2oyOmgdydsLCJrwLk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453487; c=relaxed/simple;
	bh=/Th+Pz8Nrw7iBiRuBIiL0T1wvKZ7+6gYKRu1TAAFNoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmCNQHmDrRwoiXf5WoU1jPex/nYwk5o7no7O4rGX+sLzaRqMUnbiYFAfnRK5SxqkKSykKcWKUp657YK1+ikTAF6GmsVBQEt2BOoKlLlpEmNF8SmpZykYFYg7pOK0mjyg1k3NQlfpdRmGgV1RQpR12dxvoWOQ4HsGRIYjXPjppIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT8UkacD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631D5C4CEE3;
	Wed, 28 May 2025 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748453486;
	bh=/Th+Pz8Nrw7iBiRuBIiL0T1wvKZ7+6gYKRu1TAAFNoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hT8UkacD3Qpuag/oApBDUAZISWgJCi1/ayoMAYg9bwAphNxHDqvY7VaDfvZ6v8juJ
	 bI87hNUvwrpnbNfW01jxO9eQkYo40g/cpBI8x4laFS0r0q5uGX23hz22J46snnJMI7
	 FwJJrxP3Snu66iNheffkHsj/Txha+IChG2fIFFQNZVpqniPugt0xqghu0bZYUspSfY
	 xlnZIH1fJ4DxbLir3Bs4rnZm3YBwvnuzbhKrLergznFx5jpoVH6fanp+8mkUbVoyxo
	 ZTn8c4s6xGLGVz1HzMNsMNF4EVpNSVFxXhfjhGf7Q2qDvDs5KIFx5hxME6UYYuXqev
	 guSZ/lDLbdaCQ==
Date: Wed, 28 May 2025 20:31:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
Message-ID: <aDdIZ9vBQ3JQoIN5@kernel.org>
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-4-jgross@suse.com>
 <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
 <044f0048-95bb-4822-978e-a23528f3891f@suse.com>
 <20250528132231.GB39944@noisy.programming.kicks-ass.net>
 <7c8bf4f5-29a0-4147-b31a-5e420b11468e@suse.com>
 <20250528155821.GD39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528155821.GD39944@noisy.programming.kicks-ass.net>

On Wed, May 28, 2025 at 05:58:21PM +0200, Peter Zijlstra wrote:
> On Wed, May 28, 2025 at 03:30:33PM +0200, Jürgen Groß wrote:
> 
> > Have a look at its_fini_mod().
> 
> Oh, that's what you mean. But this still isn't very nice, you now have
> restore_rox() without make_temp_rw(), which was the intended usage
> pattern.
> 
> Bah, I hate how execmem works different for !PSE, Mike, you see a sane
> way to fix this?

The least ugly thing I could think of is to replace the current pattern of

	execmem_alloc()
	exemem_make_temp_rw()
	/* update */
	execmem_restore_rox()

with

	execmem_alloc_rw()
	/* update */
	execmem_protect()

but I still haven't got to try it.

-- 
Sincerely yours,
Mike.

