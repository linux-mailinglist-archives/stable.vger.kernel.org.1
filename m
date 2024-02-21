Return-Path: <stable+bounces-21814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5DA85D5E5
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 11:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900731C20EB3
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87884381A8;
	Wed, 21 Feb 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkR2Ks4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484861FDB
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512121; cv=none; b=idJZNKEvYAy+3GHdb+c7XvHypAs+jZGAFEeelb1TimBiPEjhYn5/lvw1hl6SuFsriOhggcUR0/ordD9aX+IU794qeOn31cjMVHSmVWfgm/Z8YfmGkK12BMpwO87T1WSmkjRxrFysR11ixzfGORQnR9uwnoMVSc4BP1juXTZqT38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512121; c=relaxed/simple;
	bh=72r2G9jfwpdYob9cxgljzS/PHGvY57J1ncvU7Sumaog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJMCWZ0Z+tlQBAeiyG2S6/s6sEcFRBrlp6JF7Yi7giBe/CHmpfgAs5gV3kEFQKyS87tAEwi4i1ofYbRxOX3MccZtkUAu7qb+mF9UiyoOYUcq0yK1m3iqcsuzcHdVpV+4iLcQZUiO08Ggvr55WvaolxrlIOGkPOi0O9//JuXBNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkR2Ks4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837AAC433F1;
	Wed, 21 Feb 2024 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708512120;
	bh=72r2G9jfwpdYob9cxgljzS/PHGvY57J1ncvU7Sumaog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkR2Ks4homfgeXLJW/I6LQH78Og0O7GMMvi3q3Y5K81byn/NjQxXTo5ifJsn3u8mI
	 zBmnrLE11Wg0lrLPO57bROEDKYXVfvPZywidT1JYAECp88+w4rO268PPKcof8F0T+2
	 HmPZ2MYrCtSiQ3HWBgv+8uiydMlSZl19awAYiq7M=
Date: Wed, 21 Feb 2024 11:41:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kishon Vijay Abraham I <kvijayab@amd.com>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <2024022146-chunk-fencing-1e8f@gregkh>
References: <20240130092628.1807154-1-kvijayab@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130092628.1807154-1-kvijayab@amd.com>

On Tue, Jan 30, 2024 at 09:26:28AM +0000, Kishon Vijay Abraham I wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> commit 04c3024560d3a14acd18d0a51a1d0a89d29b7eb5 upstream.
> 
> AMD does not have the requirement for a synchronization barrier when
> acccessing a certain group of MSRs. Do not incur that unnecessary
> penalty there.
> 
> There will be a CPUID bit which explicitly states that a MFENCE is not
> needed. Once that bit is added to the APM, this will be extended with
> it.
> 
> While at it, move to processor.h to avoid include hell. Untangling that
> file properly is a matter for another day.
> 
> Some notes on the performance aspect of why this is relevant, courtesy
> of Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>:
> 
> On a AMD Zen4 system with 96 cores, a modified ipi-bench[1] on a VM
> shows x2AVIC IPI rate is 3% to 4% lower than AVIC IPI rate. The
> ipi-bench is modified so that the IPIs are sent between two vCPUs in the
> same CCX. This also requires to pin the vCPU to a physical core to
> prevent any latencies. This simulates the use case of pinning vCPUs to
> the thread of a single CCX to avoid interrupt IPI latency.
> 
> In order to avoid run-to-run variance (for both x2AVIC and AVIC), the
> below configurations are done:
> 
>   1) Disable Power States in BIOS (to prevent the system from going to
>      lower power state)
> 
>   2) Run the system at fixed frequency 2500MHz (to prevent the system
>      from increasing the frequency when the load is more)
> 
> With the above configuration:
> 
> *) Performance measured using ipi-bench for AVIC:
>   Average Latency:  1124.98ns [Time to send IPI from one vCPU to another vCPU]
> 
>   Cumulative throughput: 42.6759M/s [Total number of IPIs sent in a second from
>   				     48 vCPUs simultaneously]
> 
> *) Performance measured using ipi-bench for x2AVIC:
>   Average Latency:  1172.42ns [Time to send IPI from one vCPU to another vCPU]
> 
>   Cumulative throughput: 40.9432M/s [Total number of IPIs sent in a second from
>   				     48 vCPUs simultaneously]
> 
> >From above, x2AVIC latency is ~4% more than AVIC. However, the expectation is
> x2AVIC performance to be better or equivalent to AVIC. Upon analyzing
> the perf captures, it is observed significant time is spent in
> weak_wrmsr_fence() invoked by x2apic_send_IPI().
> 
> With the fix to skip weak_wrmsr_fence()
> 
> *) Performance measured using ipi-bench for x2AVIC:
>   Average Latency:  1117.44ns [Time to send IPI from one vCPU to another vCPU]
> 
>   Cumulative throughput: 42.9608M/s [Total number of IPIs sent in a second from
>   				     48 vCPUs simultaneously]
> 
> Comparing the performance of x2AVIC with and without the fix, it can be seen
> the performance improves by ~4%.
> 
> Performance captured using an unmodified ipi-bench using the 'mesh-ipi' option
> with and without weak_wrmsr_fence() on a Zen4 system also showed significant
> performance improvement without weak_wrmsr_fence(). The 'mesh-ipi' option ignores
> CCX or CCD and just picks random vCPU.
> 
>   Average throughput (10 iterations) with weak_wrmsr_fence(),
>         Cumulative throughput: 4933374 IPI/s
> 
>   Average throughput (10 iterations) without weak_wrmsr_fence(),
>         Cumulative throughput: 6355156 IPI/s
> 
> [1] https://github.com/bytedance/kvm-utils/tree/master/microbenchmark/ipi-bench
> 
> Cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20230622095212.20940-1-bp@alien8.de
> Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> ---
> Kindly merge this patch to stable releases (v6.6+) as it's a perf optimization.
> [It does not apply as is on earlier releases and have to be reworked]

Sorry for the delay, now queued up.

greg k-h

