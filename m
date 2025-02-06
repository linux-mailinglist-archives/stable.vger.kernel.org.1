Return-Path: <stable+bounces-114068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C436A2A69B
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 12:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0AA1681DF
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F6522ACCF;
	Thu,  6 Feb 2025 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Si/r/M8A"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C1235BEC;
	Thu,  6 Feb 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839324; cv=none; b=kKubm/HlURQORaTsIUUO+DxPiqBCU0Gkbjvrt+bIht1VRHOQLK9Bg5wWBkg9jsWcyefMR38xQa8ihMC10zsAqnTyiM+3AtbF2qI89N4yr6PUNOgFQAm9tE0PNpphGHcQNFI1XgxYe7MnxQ+aVHtCihrZ7zAvSoWPGRxVP/TXX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839324; c=relaxed/simple;
	bh=lIHT2lHe8Q3nM+RNpK+oriZOJIgZYknzqk4yPg42ZXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JunWhqWw3otY3OoYnZF5XcsiytC5HDHgIQIB1KDpGR6GDDOAMv5oJ8odznlPWI5amAjxptkIwLTsvRqtoNVuqksmvqVrxBTAfxGCgi/QM3nnu+QXGbSC835FfqTyGsJ7yZQpC6VelFbxBb+UXcff0HbrhdygT6ePfGuRkaA1ojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Si/r/M8A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.66.79] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 12E0720ACD7D;
	Thu,  6 Feb 2025 02:55:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12E0720ACD7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738839321;
	bh=wH2zmicyd08ER8DZcVlSuVfhJn0orEFVux79cvPbbM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Si/r/M8A6Ea7qJEIfSBgXH7HhZ6ekQA4opKxpmi7VjaHhOrR2tcMVKQSqbuwzvSO7
	 OtiitXRmJCIJ3QEwzZrlvdDNI9oh2NObSV2hi7O1zUZ8le9bDnWezkjQRcTRWLFyJf
	 A6AftwuoL/XigM7qUlmsg0D/qytXdG6/Q+qf8RVY=
Message-ID: <7f615780-3ccc-41e4-afe5-471df24e529c@linux.microsoft.com>
Date: Thu, 6 Feb 2025 16:25:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu,
 Michael Kelley <mhklinux@outlook.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
 <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
 <20250205101600.GC7145@noisy.programming.kicks-ass.net>
 <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
 <7042c53b-31b6-491d-8310-352d18334742@linux.microsoft.com>
 <f3f850a5-500f-4819-9884-c36e65d498cb@amd.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <f3f850a5-500f-4819-9884-c36e65d498cb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/6/2025 3:49 PM, K Prateek Nayak wrote:
> Hello Naman,
> 
> On 2/6/2025 3:17 PM, Naman Jain wrote:
>> [..snip..]
>>>
>>> This is why I think that the topology_span_sane() check is redundant
>>> when the x86 bits have already ensured masks cannot overlap in all
>>> cases except for potentially in the (*) case.
>>>
>>> So circling back to my original question around "SDTL_ARCH_VERIFIED",
>>> would folks be okay to an early bailout from topology_span_sane() on:
>>>
>>>      if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
>>>          return;
>>>
>>> and more importantly, do folks care enough about topology_span_sane()
>>> to have it run on other architectures and not just have it guarded
>>> behind just "sched_debug()" which starts off as false by default?
>>>
>>> (Sorry for the long answer explaining my thought process.)
>>>
>>
>>
>> Thanks for sharing your valuable insights.
>> I am sorry, I could not find SDTL_ARCH_VERIFIED in linux-next tip. Am I
>> missing something?
> 
> It does not exits yet. I was proposing on defining this new flag
> "SDTL_ARCH_VERIFIED" which a particular arch can set if the topology
> parsing code has taken care of making sure that the cpumasks cannot
> overlap. The original motivation for topology_span_sane() discussed in
> [1] came from an ARM processor where the functions that returns the
> cpumask is not based on ID checks and can possibly allow overlapping
> masks.
> 
> With the exception of AMD Fam 0x15 processors which populates cu_id
> (and that too it is theoretical case), I believe all x86 processors can
> set this new flag "SDTL_ARCH_VERIFIED" and can safely skip the
> topology_span_sane() since it checks for a condition that cannot
> possibly be false as result of how these masks are built on x86.
> 
> [1] https://lore.kernel.org/lkml/ 
> f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com/

I think the check for sched_debug() should suffice here, without making
it more complicated. This way, we give the control to the user to have
it or not. I'll wait for a few more days to get any additional feedback
and post v4 with your initial review comments addressed.

Regards,
Naman

