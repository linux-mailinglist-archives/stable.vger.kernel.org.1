Return-Path: <stable+bounces-100854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39109EE13E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DF82818D0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2B20C03D;
	Thu, 12 Dec 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+fh3KBU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E58558BA
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992044; cv=none; b=G8rJdIjrOy/c/EUhWvmRTtHW0Eh83RId8Blp39sT23MwraFF8ZP93qR8MWLBB+QxWkpJ6TKUeQ+cCPJUM1RBu5+otlxmppX/ojLT4X3ZWfZ2OMqecX8O4OH1Swh4SztoBHQPW+3tI2dlPIfmmCoUpGm6JKm8Hc/bIaS7gJvU9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992044; c=relaxed/simple;
	bh=Tel1BkHJpen074ZtOGgaIX6RbRgWdbKYKdq8pdZTfEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRtiiYEcIW4OlNk8pkQvYssLl8RPn4oFw86tFA7l5rc8xT5z41xo18dQFCbgrVL4egdyY2iz1PFklVHs68x5QGOqbBRJR/pJn4wt5lBJDV28GELx9wNhuvkLHt55CjV/l9tocyI4ZEoyZVunu1tF2kKEJVHYnp7kG1lelMTG7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+fh3KBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABB9C4CED1;
	Thu, 12 Dec 2024 08:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733992044;
	bh=Tel1BkHJpen074ZtOGgaIX6RbRgWdbKYKdq8pdZTfEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+fh3KBU3wYEZDBSmZ9OuCoaI75S3UWp5zazMM008Rm7CzCNz3X4SMAPKXf8Z0FG1
	 CSbY5UdV++wYpCjYqkz0vAb0/tAzjQwui3LgCVZ1FP4RD6Fd8VKyXvEeiwt1ZA3JP0
	 hbB/02WxVAB/5CVCIqiAIx2KWXaRKGeVTahG+Ex4=
Date: Thu, 12 Dec 2024 09:27:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: stable@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for
 overflow status
Message-ID: <2024121209-dreaded-champion-4cae@gregkh>
References: <2024120223-stunner-letter-9d09@gregkh>
 <20241203190236.2711302-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203190236.2711302-1-rananta@google.com>

On Tue, Dec 03, 2024 at 07:02:36PM +0000, Raghavendra Rao Ananta wrote:
> commit 54bbee190d42166209185d89070c58a343bf514b upstream.
> 
> DDI0487K.a D13.3.1 describes the PMU overflow condition, which evaluates
> to true if any counter's global enable (PMCR_EL0.E), overflow flag
> (PMOVSSET_EL0[n]), and interrupt enable (PMINTENSET_EL1[n]) are all 1.
> Of note, this does not require a counter to be enabled
> (i.e. PMCNTENSET_EL0[n] = 1) to generate an overflow.
> 
> Align kvm_pmu_overflow_status() with the reality of the architecture
> and stop using PMCNTENSET_EL0 as part of the overflow condition. The
> bug was discovered while running an SBSA PMU test [*], which only sets
> PMCR.E, PMOVSSET<0>, PMINTENSET<0>, and expects an overflow interrupt.
> 
> Cc: stable@vger.kernel.org
> Fixes: 76d883c4e640 ("arm64: KVM: Add access handler for PMOVSSET and PMOVSCLR register")
> Link: https://github.com/ARM-software/sbsa-acs/blob/master/test_pool/pmu/operating_system/test_pmu001.c
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> [ oliver: massaged changelog ]
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20241120005230.2335682-2-oliver.upton@linux.dev
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  virt/kvm/arm/pmu.c | 1 -
>  1 file changed, 1 deletion(-)

What kernel branch(es) is this backport for?

