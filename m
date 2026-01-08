Return-Path: <stable+bounces-206319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D7D03DFC
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89D6930AA3BC
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67A4ADDB6;
	Thu,  8 Jan 2026 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZNvIQ77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A292DF153;
	Thu,  8 Jan 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870697; cv=none; b=fExB6ySCk4QzGAFGcKlwvl9ijp3uLO94DhgdcFSAzSP8dMZfWLsKX0bcc+ivLsRExrmErRdD8MOXlBG9ERbqlnlqAIEgTJMYGwQMKX8tjo3HUbxIiXUv6PNkAi78X5VXCVuH4BJHLh1ZuwWFDDYox8pDrCAS6LGzLV9QRMeP/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870697; c=relaxed/simple;
	bh=8CGN48JNNgwKs+LFLKHS2Kg9Tyylj9zBMrAZ2Ix4NqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CawS+jJllwqjF2fZ1FJtitI6tCGacHW9PJh0NG5wFXfqbGmgFRw9S4zcuDbmHB0x5fjAU5tSJuiCW6jilr8qlM5//H6oDrGpmvxONrF5Hz4rAzR96Y/m5N9e23o0MpLczSQ2Y3c6IERrOx1plqCsJgHv8rC6j+dV8mKvHhThIow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZNvIQ77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504BAC116C6;
	Thu,  8 Jan 2026 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767870696;
	bh=8CGN48JNNgwKs+LFLKHS2Kg9Tyylj9zBMrAZ2Ix4NqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vZNvIQ77mok7jNAwIkIYd8+X0QzJ7gnG94/r/jd+BvcjzkwUA5kzRpUwhcaUNYJ+V
	 z21s4u8JmKM8/UUcN8VI9P5qo7ydIgBCHlMjLti+kle92Oc4JaccFiW2PgSiP/ms6c
	 atjUINLa/TW39k3436xld2zKjHngf3oRD6aM29r0=
Date: Thu, 8 Jan 2026 12:11:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y 0/4] perf/x86/amd: add LBR capture support outside
 of hardware events
Message-ID: <2026010809-matchless-reporter-3129@gregkh>
References: <20260102090320.32843-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102090320.32843-1-leon.hwang@linux.dev>

On Fri, Jan 02, 2026 at 05:03:16PM +0800, Leon Hwang wrote:
> Hi all,
> 
> This backport wires up AMD perfmon v2 so BPF and other software clients
> can snapshot LBR stacks on demand, similar to the Intel support
> upstream. The series keeps the LBR-freeze path branchless, adds the
> perf_snapshot_branch_stack callback for AMD, and drops the
> sampling-only restriction now that snapshots can be taken from software
> contexts.
> 
> Leon Hwang (4):
>   perf/x86/amd: Ensure amd_pmu_core_disable_all() is always inlined
>   perf/x86/amd: Avoid taking branches before disabling LBR
>   perf/x86/amd: Support capturing LBR from software events
>   perf/x86/amd: Don't reject non-sampling events with configured LBR


Why is this for a stable kernel?  Isn't it a new feature?  If you need
this feature, why not use a newer kernel tree?

thanks,

greg k-h

