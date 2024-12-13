Return-Path: <stable+bounces-103968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890FF9F04FF
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 07:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B7F282216
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69953187561;
	Fri, 13 Dec 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UrlWiLYm"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA333F3;
	Fri, 13 Dec 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072331; cv=none; b=ozxnQS7cahzoh+jmRcHjZ8SM3DxNhJGZmiCtP/+H5nkRxPPxib1N50juruNISOaG+6IvvN84AXPBuyzMTjhD+8jwAQDWVitzLBY8i//IkI63XhO+kf1cMXMVN9TfiWeDG8NYPWTLg8wFNBGGuy0eEWgvjDTp4ERTbvZ1/6kccbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072331; c=relaxed/simple;
	bh=GzL2AtSDMbTNYxTMSPdcwc2SIerdy8fdBdsvpRXc3ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPa9K4VW7Ipr6ql2qCcgAnTepsQioYNnxHtPTprTZFwq0mWi5wfu8PJ0nFmu0xaCVZJ0e5I2Kfp6qTmoD6eNJxi05E4iMpNTYvyD1AC0nDORtsv1HgdWwe53Vhj/60PXKLRWLtv7Y5yFwYPnqVZZYAOkODJTiNsqJ0nm4zSJTdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UrlWiLYm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 61A89204BA95; Thu, 12 Dec 2024 22:45:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61A89204BA95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734072329;
	bh=0zbGji4qwwGq65ZdKdxz7k9d0tV8I0XmHkLnVnKe27I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrlWiLYmfeMUqCR8rcNj1vzOi35kzJ66ymiJ4XSMd5ZYmwW8Grbe+DfEbrptsBjgg
	 V7mnVAaj8CSOXMPxd/9YRTBDgoix/05tnETNGYZLew1lnoDlEoUfBvlPHnk2KgguVS
	 jU2ULyF/s1rQgSxGnAPi2whvEamGgH1oPXfe2YnU=
Date: Thu, 12 Dec 2024 22:45:29 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org,
	ssengar@microsoft.com, srivatsa@csail.mit.edu
Subject: Re: [PATCH v2] sched/topology: Enable topology_span_sane check only
 for debug builds
Message-ID: <20241213064529.GA17588@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1731922777-7121-1-git-send-email-ssengar@linux.microsoft.com>
 <1e4c0bda-380e-5aba-984f-2a48debd7562@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e4c0bda-380e-5aba-984f-2a48debd7562@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 19, 2024 at 11:54:57AM +0530, K Prateek Nayak wrote:
> (+ Steve)
> 
> Hello Saurabh,
> On 11/18/2024 3:09 PM, Saurabh Sengar wrote:
> >On a x86 system under test with 1780 CPUs, topology_span_sane() takes
> >around 8 seconds cumulatively for all the iterations. It is an expensive
> >operation which does the sanity of non-NUMA topology masks.
> 
> Steve too was optimizing this path. I believe his latest version can be
> found at:
> https://lore.kernel.org/lkml/20241031200431.182443-1-steve.wahl@hpe.com/
> 
> Does that approach help improving bootup time for you? Valentine
> suggested the same approach as yours on a previous version of Steve's
> optimization but Steve believed returning true can possibly have other
> implication in the sched-domain building path. The thread can be found
> at:
> https://lore.kernel.org/lkml/Zw_k_WFeYFli87ck@swahl-home.5wahls.com/
>

I see that Steve's patch focuses on optimizing the topology sanity check,
whereas my patch aims to make it optional. I believe both patches can
coexist, as even with optimization, there will still be some performance
overhead for this check. My goal is to provide an option to bypass it
if desired. Please do check my discussion with Valentin on V1.

> >
> >CPU topology is not something which changes very frequently hence make
> >this check optional for the systems where the topology is trusted and
> >need faster bootup.
> >
> >Restrict this to sched_verbose kernel cmdline option so that this penalty
> >can be avoided for the systems who wants to avoid it.
> >
> >Cc: stable@vger.kernel.org
> >Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")
> >Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >---
> >[V2]
> >	- Use kernel cmdline param instead of compile time flag.
> >
> >  kernel/sched/topology.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> >diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >index 9748a4c8d668..4ca63bff321d 100644
> >--- a/kernel/sched/topology.c
> >+++ b/kernel/sched/topology.c
> >@@ -2363,6 +2363,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
> >  {
> >  	int i = cpu + 1;
> >+	/* Skip the topology sanity check for non-debug, as it is a time-consuming operatin */
> >+	if (!sched_debug_verbose) {
> 
> nit.
> 
> I think the convention in topology.c is to call "sched_debug()" and not
> check "sched_debug_verbose" directly.

I will add this in next version

It would be greatly appreciated if a maintainer could share their
thoughts on these two patches aimed at enhancing the performance
of large-scale machines.

- Saurabh

