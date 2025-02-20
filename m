Return-Path: <stable+bounces-118478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6318A3E0F7
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8696A188F5AC
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C922204F94;
	Thu, 20 Feb 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dYl+y0q2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D91FECCE
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069438; cv=none; b=PkqefEc2hHwuMIdB5U4dSVWoTjQc9p7CoKHW0VjZOvqB2QufF3qYsxjRJ/0r4aZ9L3rDEvoDEgagcOHMn/QeI2sQvRyIhccJQK8qZ9WtEZv8h8h/2n+wKUV0Ed5Yo02T5I6K7PU3eCDAk6b/fppS0+F/l3IioO6qznmrLqaYo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069438; c=relaxed/simple;
	bh=e5OElGZh6KmJdjjwzmB1j2XVSJtzS1oPw1gnkXHTcWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyn90X+/fzje1K3yKiUXVB6wTXnIyNWtx32sAK4gukC6CDwyQ3NpDp894wuO3IGaVI+m3no2bKnIgiuXaUyLxlaZNYz01KMMN7W8GC8S2oHkFUlly+VUy5q+oapGikS7XquL4u5XL1gHG/qZNySG+WaHURW739dEILJV4lke+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dYl+y0q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E914BC4CED1;
	Thu, 20 Feb 2025 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740069438;
	bh=e5OElGZh6KmJdjjwzmB1j2XVSJtzS1oPw1gnkXHTcWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYl+y0q2zqTjn682/9a7R+HN18m4REjJEghV/FcHOUS1CH29HdrbK/Zksta6QvKMV
	 WU2DKl4+01PJWLUXv0u/87/f0jAuTZIkzaoYjDh89QvsN2rWt1BAaRZaEQk9Zl8ktp
	 gQWm0sP7c9wPToBfRlv6DoKdxbXBuLGF/7ckSFD4=
Date: Thu, 20 Feb 2025 17:37:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.6.y] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Message-ID: <2025022058-sloppy-harmless-78eb@gregkh>
References: <2025021817-pull-grievance-de31@gregkh>
 <20250220163146.3030320-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220163146.3030320-1-kan.liang@linux.intel.com>

On Thu, Feb 20, 2025 at 08:31:46AM -0800, Kan Liang wrote:
> The EAX of the CPUID Leaf 023H enumerates the mask of valid sub-leaves.
> To tell the availability of the sub-leaf 1 (enumerate the counter mask),
> perf should check the bit 1 (0x2) of EAS, rather than bit 0 (0x1).
> 
> The error is not user-visible on bare metal. Because the sub-leaf 0 and
> the sub-leaf 1 are always available. However, it may bring issues in a
> virtualization environment when a VMM only enumerates the sub-leaf 0.
> 
> Introduce the cpuid35_e?x to replace the macros, which makes the
> implementation style consistent.
> 
> Fixes: eb467aaac21e ("perf/x86/intel: Support Architectural PerfMon Extension leaf")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/20250129154820.3755948-3-kan.liang@linux.intel.com
> ---
>  arch/x86/events/intel/core.c      | 17 ++++++++++-------
>  arch/x86/include/asm/perf_event.h | 26 +++++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 8 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

