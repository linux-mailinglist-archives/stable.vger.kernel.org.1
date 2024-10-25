Return-Path: <stable+bounces-88127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC49AF967
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 07:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A162283593
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658B18E76C;
	Fri, 25 Oct 2024 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L2A+2Tlk"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C418BB89;
	Fri, 25 Oct 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835870; cv=none; b=i5QSs47fCP5QIte/4tisNV2myROZFpnqKahSdYd37GsjtjyG0Go/QAm86UDeZzTLRXc4Q+DH/SWwFMTOKPKkDbcC1bUN9XnwGw3AkCQ6qNSyZ0l3EONa9r7MqAez7zXm1f2vIL4/efZAwmptiM9F3W6V0T4WJ0BjQICmDFDWegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835870; c=relaxed/simple;
	bh=44nlQ61xtKlViEZbHLZo3wssRWfP7SavUPjJqVaWWLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSPGrih6turKHFkXhxrnUb5JLmXe4iGsXgjepw7xWxeQWvAhXcCbZKkyW+QadrtIuGZIIHAox9NqUQ5xU07GZOle7iZfAN8ZzqTD+90+z4NnKQ8P+W6JkTiAptF0I6WqrrryC4lgFcwUKv+uyv3oMzfWh7+ZzEAI1NsCwP832e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L2A+2Tlk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 4941A211A536; Thu, 24 Oct 2024 22:57:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4941A211A536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729835862;
	bh=UIIhnRqjV6h0yjPSM88EYu2gh7SLLk6FJcI1uVxDcNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2A+2TlkEuO31+vchht75PqmmLfoYbqcR5EFVO+gmb3FVuFVJeEiJbtPRhmeJXk0v
	 SYYWyJD++XWQusixW7UwK4W0vV37vduf/nWCwSWU8hHy92W/PZzhQoJd1qvfbNPcRp
	 zQgjA9dkWXuWt0aIQLVs777Y3hmswhYDj7OQ5uus=
Date: Thu, 24 Oct 2024 22:57:42 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	ssengar@microsoft.com, srivatsa@csail.mit.edu
Subject: Re: [PATCH] sched/topology: Enable topology_span_sane check only for
 debug builds
Message-ID: <20241025055742.GA8206@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1729619853-2597-1-git-send-email-ssengar@linux.microsoft.com>
 <xhsmhsesmu62e.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhsesmu62e.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Oct 23, 2024 at 06:39:37PM +0200, Valentin Schneider wrote:
> On 22/10/24 10:57, Saurabh Sengar wrote:
> > On a x86 system under test with 1780 CPUs, topology_span_sane() takes
> > around 8 seconds cumulatively for all the iterations. It is an expensive
> > operation which does the sanity of non-NUMA topology masks.
> >
> > CPU topology is not something which changes very frequently hence make
> > this check optional for the systems where the topology is trusted and
> > need faster bootup.
> >
> > Restrict this to SCHED_DEBUG builds so that this penalty can be avoided
> > for the systems who wants to avoid it.
> >
> > Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> Please see:
> http://lore.kernel.org/r/20241010155111.230674-1-steve.wahl@hpe.com
> 
> Also note that most distros ship with CONFIG_SCHED_DEBUG=y, so while I'm
> not 100% against it this would at the very least need to be gated behind
> e.g. the sched_verbose cmdline argument to be useful.

Thanks for your review. I thought of using sched_verbose first, but I assumed
that many systems might not be using this command line option and I didn't
want them to have change in behaviour after my patch.

But if you think this is the right approach, I can send the V2.

> 
> But before that I'd like the "just run it once" option to be explored
> first.

That's a great improvement, but I understand there will still be a linear
penalty to pay for this sanity check. In my opinion, regardless of whether
these improvements are accepted or not, we should make this sanity check
optional.

- Saurabh

