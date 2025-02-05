Return-Path: <stable+bounces-112292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D07A287B6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 11:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3163A31F8
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C6922A4FE;
	Wed,  5 Feb 2025 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ma/tp+dD"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE622A7E9;
	Wed,  5 Feb 2025 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750574; cv=none; b=RQCZPkAaUyU5u92YRWPoYElsPC2OVN+hl2THmqztD4jxBieknsm9JyNRKxfqudeIi6JOu8UtOZ1zfgbNA6KtRzAcyfGTCxbW9Vm8SbODyKL7huZJHa6cMvg7sV7MYMVuxYLBlcaat7qYKdtDcnbhFDtUfs8ZHTTcUX1B8Bj4Fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750574; c=relaxed/simple;
	bh=A1COUhFMiYkZ6jWZ4rEG5AaYuGBBBYVEG3AG8lJPcvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLTpJlKQYvuULQW5/J3ykw9LO0mwHB/Fi6533SlShNjydylkBTSY6SnGcM8P3oXBn8KM2qA6Y5td+9aqnW/JVYdpA8aJZhiwuh0Ci0jJSS/aTQjW6JJHXvNUcuw+vvemus7y5I90pH2wJUxQlJuu1FasGDRuNruJQUVSTl87VHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ma/tp+dD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9qXcAANLcizackECdOPJD2ARkgdD5l7NyBSWXT9HO1A=; b=Ma/tp+dDFNvt9ACHB9KS8/jzjV
	9Tg5pLwrMjO/fDEYREdAxAO2M+icsWv7IYG9possNI3spAyBSM/BnI6zldcwfvJRwpvnA8zm5pfEb
	SGFdGEq6q/llKTT+VWcbKjM8F/IWhZLJxnvWOxqeB9VLgYo1gmvZO3aR59S/sJH/JTp0oip1BFk15
	gpRLUCpVeH8vX+kCTvhMO3hJL4oF4eH35/COestyz92i2M4lyB8MxHdYLxbTp6ajYipk5tirYmEP4
	9XRv0FL0jPmf4jlspF3bVcyedulflMfKzH3eWFvehPu5Uhok1mxQyGVzZIs5IsGiKCRGaKRhVJ63W
	uk8I4v6Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfcRt-0000000GbiU-3UNP;
	Wed, 05 Feb 2025 10:16:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8C4C03002F0; Wed,  5 Feb 2025 11:16:00 +0100 (CET)
Date: Wed, 5 Feb 2025 11:16:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	srivatsa@csail.mit.edu, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
Message-ID: <20250205101600.GC7145@noisy.programming.kicks-ass.net>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
 <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>

On Wed, Feb 05, 2025 at 03:43:54PM +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> Thank you for the background!
> 
> On 2/5/2025 3:25 PM, Peter Zijlstra wrote:
> > On Wed, Feb 05, 2025 at 03:18:24PM +0530, K Prateek Nayak wrote:
> > 
> > > Have there been any reports on an x86 system / VM where
> > > topology_span_sane() was tripped?
> > 
> > At the very least Intel SNC 'feature' tripped it at some point. They
> > figured it made sense to have the LLC span two nodes.
> > 
> > But I think there were some really dodgy VMs too.
> > 
> > But yeah, its not been often. But basically dodgy BIOS/VM data can mess
> > up things badly enough for it to trip.
> 
> Has it ever happened without tripping the topology_sane() check first
> on the x86 side?

That I can't remember, sorry :/

