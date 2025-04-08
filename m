Return-Path: <stable+bounces-131824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ACFA81414
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 19:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48819468508
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB5223DEAD;
	Tue,  8 Apr 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9Ybww+N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4722F39F;
	Tue,  8 Apr 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134841; cv=none; b=ZfPdA20pnqPH9qNhscn/iaZgyork9mDL3QyS0oMZB4BBRrPFVqg0uRhXUNbW8+VCMZ32h47MuqASAf3qFcXa1d3IeZ+EKMfYwsCYKwjCtczT0tsIXS8GiLOmRusmaZvR+hhi7+/zGnukRFXbTQptnXiglen6e1YJomU/n7HSvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134841; c=relaxed/simple;
	bh=8u/R4IJ+6xtmmt9hG8w5dzqqRQgisr9y0glGKVrx8Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+fnX3jHqETqMXzIiFhdshbj3u5+cE9B2YVPcmZRNoq9QARI6JaF3nukwpuwBgt7pY0UpHRqDtxNO0zgu0rXBIy7zrV7+vhj70iOuNHrk8vNKaeIauAebeFLzWkhhL93NGfjc8i1v2w/tVxexBflzpf7lWe82nWuSHo+xWsvcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9Ybww+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F343DC4CEEA;
	Tue,  8 Apr 2025 17:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744134841;
	bh=8u/R4IJ+6xtmmt9hG8w5dzqqRQgisr9y0glGKVrx8Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9Ybww+NEgApEINHlurbMXbRhqnEul7xv8rUjsZ6y1r3cmm9kw3ZmgjuxDkiFn9Po
	 6tGQlrS4jyjmg4z4dfnx6sy/ueVby5d0s9Fff8eZN3kBcQftXuoIUzpmGExdzffqd1
	 bP/gERHAcwrSxiwkI/WYPnBiQAABuhKWvRjpHAP2mOwHee2eqO5hoFI3x7QFIBFbWc
	 /KEU8K+8MdnOla2YGmJ8uVEhi4oGnZWVCWDkdGEU1kKxYhv6dBJHEN2KTT1bcL28A2
	 uYWsUxwAQZoyxWxTy+NBPAb6SUs7hoz+kPENrgIIOKa9sGsTp5M76sLNp34eCSn7jS
	 xD4KbYZz1QJiw==
Date: Tue, 8 Apr 2025 07:53:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
	stable@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v3] sched_ext: Use kvzalloc for large exit_dump allocation
Message-ID: <Z_Vit8V1J2rCrlRC@slm.duckdns.org>
References: <20250408-scx-v3-1-159b6c7a680d@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-scx-v3-1-159b6c7a680d@debian.org>

On Tue, Apr 08, 2025 at 09:50:42AM -0700, Breno Leitao wrote:
> Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
> can require large contiguous memory depending on the implementation.
> This change prevents allocation failures by allowing the system to fall
> back to vmalloc when contiguous memory allocation fails.
> 
> Since this buffer is only used for debugging purposes, physical memory
> contiguity is not required, making vmalloc a suitable alternative.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07814a9439a3b0 ("sched_ext: Print debug dump after an error exit")
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15-fixes.

Thanks.

-- 
tejun

