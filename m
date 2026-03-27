Return-Path: <stable+bounces-230687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA/kG/CzxmmiNgUAu9opvQ
	(envelope-from <stable+bounces-230687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:44:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A499347A70
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2FF230FD2B3
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD0F355F23;
	Fri, 27 Mar 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YiI6Npr6"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7034A3D8;
	Fri, 27 Mar 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628713; cv=none; b=GH7KQ5jJJ7B257d6Lg/hhM7fYQ2VYLTtu/kAlgHXLgTFFXfuZ6WKADb4pKd2mSdoD361JGbpD7L66In2ydO4FrGomUr99cQtXZvIcUa2H2jnNGa68/lMNwGsH6pD02/AojnQMdxx0hvFIvQDswP4h4hG9QLnEIx2lGNfwSEu4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628713; c=relaxed/simple;
	bh=o37e/u2s3ApNY3T2Mivm5sQi2e7lLw78zt9EIlgSSfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcPRprlC2tUEiTqAwVPHTleBR11qdNlaqApv/RHHTJmszMJeGPStI6XWuKoiaopb5N+PrJHQqNX8K3YUDtz2s4acXj7Q180NWfbHbfZZQ1OSR8JFay/ZRWJQURH5umL16AkyYs/XbNV9YCp0PAQEsFSJRKHUYDWKLCb3RlcxDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YiI6Npr6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24FC935DA;
	Fri, 27 Mar 2026 09:25:05 -0700 (PDT)
Received: from [10.163.180.175] (unknown [10.163.180.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3E73F905;
	Fri, 27 Mar 2026 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774628711; bh=o37e/u2s3ApNY3T2Mivm5sQi2e7lLw78zt9EIlgSSfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YiI6Npr6YyJq4PlBLVpfqiUTOOL161bptBTF8MU82La2TI82X2RO4XSVDq+AGrDXt
	 LHhV9Pdl3j6OF27Npzjr4tIAziCsnEIupAbkdCevLtRBxf4jTYQjxcj+BAnG3ri7lV
	 w2AICP2O5dCu263VnHUEwfdWQqetcjrXRZ2nJ/Wg=
Message-ID: <346eeb8c-616b-4f4e-b811-ad1a3ae4a58f@arm.com>
Date: Fri, 27 Mar 2026 21:54:43 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] slab: replace cpu (partial) slabs with sheaves
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 "Harry Yoo (Oracle)" <harry@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <afe9ba0a-1924-42a8-a9c5-34eec709f883@arm.com>
 <ed58493b-0369-4729-bcf7-bc89f72a7913@kernel.org> <acV36oPNFMgL4puz@milan>
 <ea1cb2a1-b674-4d69-bbf6-00051a0e11df@kernel.org>
 <eafefe7a-a33b-4102-93cf-fecc33ddf49e@arm.com>
 <0f441d8f-d84c-470a-a4cb-0249b15220a2@kernel.org>
 <f100305b-6c56-4499-98a4-6a22f8c49443@arm.com> <acZVS-ehXCtvcA9s@hyeyoo>
 <d120d8d3-f785-47ec-9c6b-b28d42ebb1f7@kernel.org>
Content-Language: en-US
From: Aishwarya Rambhadran <aishwarya.rambhadran@arm.com>
In-Reply-To: <d120d8d3-f785-47ec-9c6b-b28d42ebb1f7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,oracle.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230687-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aishwarya.rambhadran@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A499347A70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

Thanks for the discussion and the insights.

For completeness, the SUTs used are single NUMA node:
$ numactl -H
available: 1 nodes (0)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
node 0 size: 257218 MB
node 0 free: 255376 MB
node distances:
node   0
   0:  10

As suggested by Ryan, I re-ran and compared the perf benchmarks
across 6.17, 6.18, and later kernels. The behavior is consistent
with what has been discussed in this thread and aligns with our
observations.

Thanks again for the clarifications and apologies for the table
rendering issues in the initial email.

Regards,
Aishwarya Rambhadran

On 27/03/26 4:51 PM, Vlastimil Babka (SUSE) wrote:
> On 3/27/26 11:00, Harry Yoo (Oracle) wrote:
>> On Fri, Mar 27, 2026 at 08:58:36AM +0000, Ryan Roberts wrote:
>>>>>>>> On 3/26/26 13:43, Aishwarya Rambhadran wrote: 
>>>>>> Right so there should be just the overhead of the extra 
>>>>>> is_vmalloc_addr() test. Possibly also the call of 
>>>>>> kfree_rcu_sheaf() if it's not inlined. I'd say it's something we 
>>>>>> can just accept? It seems this is a unit test being used as a 
>>>>>> microbenchmark, so it can be very sensitive even to such details, 
>>>>>> but it should be negligible in practice. 
>>>>> The perf/syscall cases might be a bit more concerning though? 
>>>>> (those tests are from "perf bench syscall fork|execve"). Yes they 
>>>>> are microbenchmarks, but a 7% increased cost for fork seems like 
>>>>> something we'd want to avoid if we can. 
>>>> Sure, I tried to explain those in my first reply. Harry then linked 
>>>> to how that explanation can be verified. Hopefully it's really the 
>>>> same reason. 
>>> Ahh sorry I missed your first email. We only added that benchmark 
>>> from 6.19 so don't have results for earlier kernels, but I'll ask 
>>> Aishu to run it for 6.17 and 6.18 to see if the results correlate 
>>> with your expectation. But from a high level perspective, a 7% 
>>> regression on fork is not ideal even if there was a 7% improvement 
>>> in 6.18. 
> In retrospect it was an oversight not to disable the pre-existing cpu 
> caching layer immediately for sheaf-enabled caches in 6.18. Can't undo 
> that mistake now, unfortunately.
>> If that improvement comes from the number of objects cached per CPU, 
>> I'm not sure if determining the default value (# of cached objs) 
>> based on "a point when microbenchmarks stop improving" is a 
>> reasonable measure because the default value affects all slab caches 
>> and will inevitably increase overall memory usage. 
> Yeah that's the thing, some workloads might just keep improving as you 
> throw more caching at them, but there's a memory usage cost to that. A 
> case of stress test doing nothing but forks might also not be 
> representative of performance of forks under normal workload where 
> other operations also happen, returning the related slab objects, so 
> in the end it doesn't expose the batch size that much.
>> Hopefully we could discuss what a reasonable heuristic that "works 
>> for most situations" looks like, and allow users to tune it further 
>> based on their needs. As a side note, changing sheaf capacity at 
>> runtime is not supported yet (I'm working on it) and targeting at 
>> least before the next LTS. 


