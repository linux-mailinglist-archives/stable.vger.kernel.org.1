Return-Path: <stable+bounces-212842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC28IxdNfGlwLwIAu9opvQ
	(envelope-from <stable+bounces-212842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 07:17:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31295B796D
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 07:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97CEA30065F9
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 06:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F52E0405;
	Fri, 30 Jan 2026 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uh/m2RGZ"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBEE25B662
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769753876; cv=none; b=SC3sEP1uVG5b1MGoTu8+KtpqHhPFn9lIiDH0rvzgbCSmmvzxciYv8aJmcYC43LB62cP8VKcvyiIKSIKjOQ5ucpZ2GKLpwGcUuit6AMF4STxu54hy0eNTviX692oX15KZ3Fcn1I23WI8XtofteQ098PmjpylRujDAPgX1HNupPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769753876; c=relaxed/simple;
	bh=gi56fCFxndmZS3u5rZn7lLKjCFP6jws0mcuR3jguaLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXZ0QthRgGJWtWkIqzk5q2DKoxSVa1bfhaFlkhd/WMhJKaXlasUg3JRlHMHt1m/nsjwWFOfcbqkb9HG6ORTniqs/eoC8uTyIHWQbkU6zvYT8d91C/owWOOhwGtsphLP9hpwckgpGI/DEhUjeI37T0OgnL7EylDecu1lZZOnrmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uh/m2RGZ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 30 Jan 2026 14:17:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769753863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc43I2XjtgSCW/lhB/Z+tW4u7IMzTAGJYJqdI4VSEG8=;
	b=uh/m2RGZONlBv4grhrNFYxpeBB+mzaqQU52VLKVj8SSwhbfi1jnn0JW0X+4pOg5bJL5MqN
	o46QNk0LCfDriaEtLad5Vrtq/JHJ+bpLCNRk7tPdv48NALYk4ZsqIe55oErjRhM1dOsD5P
	+OEXEBCY2GU8MBZBsUmCb2GAq6Khez4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 00/22] slab: replace cpu (partial) slabs with sheaves
Message-ID: <oj5ossmsvybogs5fr2fjdmms66usoh7pdpkuxwlkagxniscrrb@vghtzkxauvix>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb>
 <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz>
 <pdmjsvpkl5nsntiwfwguplajq27ak3xpboq3ab77zrbu763pq7@la3hyiqigpir>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pdmjsvpkl5nsntiwfwguplajq27ak3xpboq3ab77zrbu763pq7@la3hyiqigpir>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212842-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31295B796D
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:50:25PM +0800, Hao Li wrote:
> On Thu, Jan 29, 2026 at 04:28:01PM +0100, Vlastimil Babka wrote:
> > 
> > So previously those would become kind of double
> > cached by both sheaves and cpu (partial) slabs (and thus hopefully benefited
> > more than they should) since sheaves introduction in 6.18, and now they are
> > not double cached anymore?
> > 
> 
> I've conducted new tests, and here are the details of three scenarios:
> 
>   1. Checked out commit 9d4e6ab865c4, which represents the state before the
>      introduction of the sheaves mechanism.
>   2. Tested with 6.19-rc5, which includes sheaves but does not yet apply the
>      "sheaves for all" patchset.
>   3. Applied the "sheaves for all" patchset and also included the "avoid
>      list_lock contention" patch.

Here is my testing environment information and the raw test data.

Command:

cd will-it-scale/
python3 ./runtest.py mmap2 25 process 0 0 64 128 192

Env:

CPU(s):                                  192
Thread(s) per core:                      1
Core(s) per socket:                      96
Socket(s):                               2
NUMA node(s):                            4
NUMA node0 CPU(s):                       0-47
NUMA node1 CPU(s):                       48-95
NUMA node2 CPU(s):                       96-143
NUMA node3 CPU(s):                       144-191
Memory:                                  1.5T

Raw data:

1. Checked out commit 9d4e6ab865c4, which represents the state before the
   introduction of the sheaves mechanism.

{
  "time.elapsed_time": 93.88,
  "time.elapsed_time.max": 93.88,
  "time.file_system_inputs": 2640,
  "time.file_system_outputs": 128,
  "time.involuntary_context_switches": 417738,
  "time.major_page_faults": 54,
  "time.maximum_resident_set_size": 90012,
  "time.minor_page_faults": 80569,
  "time.page_size": 4096,
  "time.percent_of_cpu_this_job_got": 5707,
  "time.system_time": 5272.97,
  "time.user_time": 85.59,
  "time.voluntary_context_switches": 2436,
  "will-it-scale.128.processes": 28445014,
  "will-it-scale.128.processes_idle": 33.89,
  "will-it-scale.192.processes": 39899678,
  "will-it-scale.192.processes_idle": 1.29,
  "will-it-scale.64.processes": 15645502,
  "will-it-scale.64.processes_idle": 66.75,
  "will-it-scale.per_process_ops": 224832,
  "will-it-scale.time.elapsed_time": 93.88,
  "will-it-scale.time.elapsed_time.max": 93.88,
  "will-it-scale.time.file_system_inputs": 2640,
  "will-it-scale.time.file_system_outputs": 128,
  "will-it-scale.time.involuntary_context_switches": 417738,
  "will-it-scale.time.major_page_faults": 54,
  "will-it-scale.time.maximum_resident_set_size": 90012,
  "will-it-scale.time.minor_page_faults": 80569,
  "will-it-scale.time.page_size": 4096,
  "will-it-scale.time.percent_of_cpu_this_job_got": 5707,
  "will-it-scale.time.system_time": 5272.97,
  "will-it-scale.time.user_time": 85.59,
  "will-it-scale.time.voluntary_context_switches": 2436,
  "will-it-scale.workload": 83990194
}

2. Tested with 6.19-rc5, which includes sheaves but does not yet apply the
   "sheaves for all" patchset.

{
  "time.elapsed_time": 93.86000000000001,
  "time.elapsed_time.max": 93.86000000000001,
  "time.file_system_inputs": 1952,
  "time.file_system_outputs": 160,
  "time.involuntary_context_switches": 766225,
  "time.major_page_faults": 50.666666666666664,
  "time.maximum_resident_set_size": 90012,
  "time.minor_page_faults": 80635,
  "time.page_size": 4096,
  "time.percent_of_cpu_this_job_got": 5738,
  "time.system_time": 5251.88,
  "time.user_time": 134.57666666666665,
  "time.voluntary_context_switches": 2539,
  "will-it-scale.128.processes": 38223543.333333336,
  "will-it-scale.128.processes_idle": 33.833333333333336,
  "will-it-scale.192.processes": 54039039,
  "will-it-scale.192.processes_idle": 1.26,
  "will-it-scale.64.processes": 20579207.666666668,
  "will-it-scale.64.processes_idle": 66.74333333333334,
  "will-it-scale.per_process_ops": 300541,
  "will-it-scale.time.elapsed_time": 93.86000000000001,
  "will-it-scale.time.elapsed_time.max": 93.86000000000001,
  "will-it-scale.time.file_system_inputs": 1952,
  "will-it-scale.time.file_system_outputs": 160,
  "will-it-scale.time.involuntary_context_switches": 766225,
  "will-it-scale.time.major_page_faults": 50.666666666666664,
  "will-it-scale.time.maximum_resident_set_size": 90012,
  "will-it-scale.time.minor_page_faults": 80635,
  "will-it-scale.time.page_size": 4096,
  "will-it-scale.time.percent_of_cpu_this_job_got": 5738,
  "will-it-scale.time.system_time": 5251.88,
  "will-it-scale.time.user_time": 134.57666666666665,
  "will-it-scale.time.voluntary_context_switches": 2539,
  "will-it-scale.workload": 112841790
}

3. Applied the "sheaves for all" patchset and also included the "avoid
   list_lock contention" patch.

{
  "time.elapsed_time": 93.86666666666667,
  "time.elapsed_time.max": 93.86666666666667,
  "time.file_system_inputs": 1800,
  "time.file_system_outputs": 149.33333333333334,
  "time.involuntary_context_switches": 421120,
  "time.major_page_faults": 37,
  "time.maximum_resident_set_size": 90016,
  "time.minor_page_faults": 80645,
  "time.page_size": 4096,
  "time.percent_of_cpu_this_job_got": 5714.666666666667,
  "time.system_time": 5256.176666666667,
  "time.user_time": 108.88333333333333,
  "time.voluntary_context_switches": 2513,
  "will-it-scale.128.processes": 28067051.333333332,
  "will-it-scale.128.processes_idle": 33.82,
  "will-it-scale.192.processes": 38232965.666666664,
  "will-it-scale.192.processes_idle": 1.2733333333333334,
  "will-it-scale.64.processes": 15464041.333333334,
  "will-it-scale.64.processes_idle": 66.76333333333334,
  "will-it-scale.per_process_ops": 220009.33333333334,
  "will-it-scale.time.elapsed_time": 93.86666666666667,
  "will-it-scale.time.elapsed_time.max": 93.86666666666667,
  "will-it-scale.time.file_system_inputs": 1800,
  "will-it-scale.time.file_system_outputs": 149.33333333333334,
  "will-it-scale.time.involuntary_context_switches": 421120,
  "will-it-scale.time.major_page_faults": 37,
  "will-it-scale.time.maximum_resident_set_size": 90016,
  "will-it-scale.time.minor_page_faults": 80645,
  "will-it-scale.time.page_size": 4096,
  "will-it-scale.time.percent_of_cpu_this_job_got": 5714.666666666667,
  "will-it-scale.time.system_time": 5256.176666666667,
  "will-it-scale.time.user_time": 108.88333333333333,
  "will-it-scale.time.voluntary_context_switches": 2513,
  "will-it-scale.workload": 81764058.33333333
}

> 
> 
> Results:
> 
> For scenario 2 (with sheaves but without "sheaves for all"), there is a
> noticeable performance improvement compared to scenario 1:
> 
> will-it-scale.128.processes +34.3%
> will-it-scale.192.processes +35.4%
> will-it-scale.64.processes +31.5%
> will-it-scale.per_process_ops +33.7%
> 
> For scenario 3 (after applying "sheaves for all"), performance slightly
> regressed compared to scenario 1:
> 
> will-it-scale.128.processes -1.3%
> will-it-scale.192.processes -4.2%
> will-it-scale.64.processes -1.2%
> will-it-scale.per_process_ops -2.1%
> 
> Analysis:
> 
> So when the sheaf size for maple nodes is set to 32 by default, the performance
> of fully adopting the sheaves mechanism roughly matches the performance of the
> previous approach that relied solely on the percpu slab partial list.
> 
> The performance regression observed with the "sheaves for all" patchset can
> actually be explained as follows: moving from scenario 1 to scenario 2
> introduces an additional cache layer, which boosts performance temporarily.
> When moving from scenario 2 to scenario 3, this additional cache layer is
> removed, then performance reverted to its original level.
> 
> So I think the performance of the percpu partial list and the sheaves mechanism
> is roughly the same, which is consistent with our expectations.
> 
> -- 
> Thanks,
> Hao

