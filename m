Return-Path: <stable+bounces-206247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8C9D013A0
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 07:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DEB03002897
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF16B329E43;
	Thu,  8 Jan 2026 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9+kVHKl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802271BF33;
	Thu,  8 Jan 2026 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767852888; cv=none; b=RP2fBJziYVyrRrN6a7+IuTGs6O0MNE9hhqtrguzY+NiaMrNh/BKi0MnJ9SFL/Sb0sKWanMaTfZ3PN3FaQd26y3TgnHmLkNYOenEllUQqQ6oRgYbaKbpWq5dAsUIuryKw//WyGdH8dcipdP5Fq+XV9fr+gKSC05aV8NY6N0YTEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767852888; c=relaxed/simple;
	bh=2DqGijERy8ZUB3Ij4gLZRKUro8yrw/b3O+VjgrW4TE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+oPBBx53VRVn43reW+oqMbnpZQzy4Ydc0gg895eGk+5XzSvQRt6KeAagxJJov5Nt48CKQidX8qs9UlEJJzf1+U6z3oWHIlkA0UVAjDPct6OCCcGzjKZ1FiHDHVnc6gqkcCnRdzdIDfRAnnEthqn0PIxQd2sRAZQy0Z/fOXqKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9+kVHKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D05C116C6;
	Thu,  8 Jan 2026 06:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767852888;
	bh=2DqGijERy8ZUB3Ij4gLZRKUro8yrw/b3O+VjgrW4TE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9+kVHKlMMXb98NELNTbZgR0KaMyP/LrLfZkJR3eQLNmq/wtsfuOGGBg55zPvIzBR
	 KE4C15J245Qp//QvofPlO2DwRxnm94Dcgiy5JmifuYjjOptSaZ5qpYViEVZcTToRot
	 YXqwRbMq9y8xR1H87o0tQncFsai8hLHZAeqWRqyJ7D8SWbipE+Ej0Y0RBtOYPm5Tlv
	 /tAnyygCAIgOi9/1TmOyewpNC54zdv8XRLihtJlqA2JIwhv/7ZUUAKw+IIFw0e8aa4
	 mFqJkszgklwUbzP/417TBMrMKkq9e0eQZ69RPx7Z5RqsONfzU2zgUROq7yGIYCNMqd
	 KY9eUy8TEth3A==
Date: Wed, 7 Jan 2026 22:14:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf Documentation: Correct branch stack sampling
 call-stack option
Message-ID: <aV9LVqqrhfW6DfbQ@google.com>
References: <20251216013949.1557008-1-dapeng1.mi@linux.intel.com>
 <e2a105fc-8b5c-4c7d-ba29-de8bb560cc85@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2a105fc-8b5c-4c7d-ba29-de8bb560cc85@linux.intel.com>

Hello,

On Wed, Jan 07, 2026 at 08:58:53AM +0800, Mi, Dapeng wrote:
> @Arnaldo, @Kim, @Ian
> 
> Kindly ping ... 

Sorry for the delay.

> 
> On 12/16/2025 9:39 AM, Dapeng Mi wrote:
> > The correct call-stack option for branch stack sampling should be "stack"
> > instead of "call_stack". Correct it.
> >
> > $perf record -e instructions -j call_stack -- sleep 1
> > unknown branch filter call_stack, check man page
> >
> >  Usage: perf record [<options>] [<command>]
> >     or: perf record [<options>] -- <command> [<options>]
> >
> >     -j, --branch-filter <branch filter mask>
> >                           branch stack filter modes
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 955f6def5590 ("perf record: Add remaining branch filters: "no_cycles", "no_flags" & "hw_index"")
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> > ---
> >  tools/perf/Documentation/perf-record.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index e8b9aadbbfa5..3d19e77c9c53 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -454,7 +454,7 @@ following filters are defined:
> >  	- no_tx: only when the target is not in a hardware transaction
> >  	- abort_tx: only when the target is a hardware transaction abort
> >  	- cond: conditional branches
> > -	- call_stack: save call stack
> > +	- stack: save call stack
> >  	- no_flags: don't save branch flags e.g prediction, misprediction etc
> >  	- no_cycles: don't save branch cycles
> >  	- hw_index: save branch hardware index
> >
> > base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821

