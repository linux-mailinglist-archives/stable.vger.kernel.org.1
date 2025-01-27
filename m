Return-Path: <stable+bounces-110912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4059DA1FFA7
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 22:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A643A17DE
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140D01B412B;
	Mon, 27 Jan 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KqMWOfU9"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A81ACED1;
	Mon, 27 Jan 2025 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013359; cv=none; b=FVMSiuLA3TMduyqOCXc3J3OcFDkt8MwC8wX8bsStH3ydYchQA9YxPZOxxba3riY9q29LW3SymZdLPzsFX1sH845NWHboiEleFrhbUcWKT58H4y1ZVlqGTzq39PVBL3r/7354VCvAVtWP2Pgj3qyb3RT3WjgBpjwuWP5KwILur1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013359; c=relaxed/simple;
	bh=eq7mXsIBZmPuN99dbvkvON7tjy2PdfJnRNaYIqoWbvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaLlxwafMesfO5upjOU8Xm9rBIM4kJfjYypi+J6i0BJQx/KTGFrOnBLMwBhwmedy5rx+r6GtE7+k2vc+hRe/ILvuW/A8xF1cqWAQM0ZGc+Dg3CXXQcq8x+0tbvBmsf9oSo+u2XXUl+vftjZSMnRtxGpArREcEm3RE9dHc6x2vaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KqMWOfU9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eq7mXsIBZmPuN99dbvkvON7tjy2PdfJnRNaYIqoWbvU=; b=KqMWOfU9wAmiBF4SWvd9EO47wY
	G6/c+HNFj5+uyK7n52DMOmBax5Uec7pmKObZXeQ2DQWKeZl1rg9zzN+HK/PboxwNzKqQ4vs150lqH
	U9MXIZRa02wBnPj0vI4/5x9FfjVORtIbJzJgvQnW/5njx5lhuBgF4ciTy8BHrramvPSeAmC0Z7+kf
	W+w4dVNi8A5eyxxgyUuxn2w8bQ2v4qhWTGc4Owf4rAyqmjCNQmMX5AKIt6D11nxWfzijhUiPHKAyB
	eXJTdFxur6THxxpVtN5enKWAy51/4p1x1CIqMo6LFE6Yw0B+eedjXqpLZTud5XA/iNjk30njbMrq5
	dytg26fw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcWfG-00000009ubs-29Ep;
	Mon, 27 Jan 2025 21:29:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E91373004DE; Mon, 27 Jan 2025 22:29:01 +0100 (CET)
Date: Mon, 27 Jan 2025 22:29:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/20] perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
Message-ID: <20250127212901.GB9557@noisy.programming.kicks-ass.net>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-3-dapeng1.mi@linux.intel.com>
 <20250127162917.GM16742@noisy.programming.kicks-ass.net>
 <6d5c45b4-53ad-403f-9de3-a25b80a44e0e@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d5c45b4-53ad-403f-9de3-a25b80a44e0e@linux.intel.com>

On Mon, Jan 27, 2025 at 11:43:53AM -0500, Liang, Kan wrote:

> But they are used for a 64-bit register.
> The ARCH_PERFMON_NUM_COUNTER_LEAF is for the CPUID enumeration, which is
> a u32.

A well, but CPUID should be using unions, no?

we have cpuid10_e[abd]x cpuid28_e[abc]x, so wheres cpuid23_e?x at?

