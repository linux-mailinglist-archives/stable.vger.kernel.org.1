Return-Path: <stable+bounces-100845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359CB9EE0BC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E963F161439
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8B2010F2;
	Thu, 12 Dec 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G19mhfbR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E620B21F
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990282; cv=none; b=Vgc6Ia7mvcDKIk+ppbbpYpMWVyRV5jX9HUeQg0E+To44M9uVdvGtTBdiVkjlOsEjmNHdmw7DZnSewqlNHziP5v0A5xLuLpN77ZQxp9BuPxOI3LZFZbiQpfgx3JhMIjPAJqgMlw9kT57iS2AROj7FdzlwOpkWJGnnqHG3IE7iUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990282; c=relaxed/simple;
	bh=heTP8tw+ZcZqUJG3MUscB12GOrn8+k8zURC8CKYj6hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODmXMjntbdh3eYmdq/zjryy3rb01rsV7tlInDqw12ZFBLndtgl7TXPJrkXbEEPujBHkvrQOdxpSS9kTlpILuLza4x2mvn12go0SOFpPMjTZ9irXuU7f1A54uPwwSDy85JDZVJDGmKBIG4A1fis3EEIqwSoRZPlaHbZ6MQ/mcmmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G19mhfbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DBEC4CECE;
	Thu, 12 Dec 2024 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733990281;
	bh=heTP8tw+ZcZqUJG3MUscB12GOrn8+k8zURC8CKYj6hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G19mhfbRPAaexSMh+j1NOkDSvdNU1VQRHQjvzorXkEyy1HFB8G/xvi1c+MyE8YN9B
	 8vGHUva0JoBWL3/HvzRehbeZsTEqsPRnRK66AziqQNfjIE1Wph0taeo2r7yu5PH2gz
	 HYJoC9LHMeklETPWQL0NNC6jtbpnU9mdK4MgCJQQ=
Date: Thu, 12 Dec 2024 08:57:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: stable@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for
 overflow status
Message-ID: <2024121244-mannish-hermit-526d@gregkh>
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

What branch is this patch for?

thanks,

greg k-h

