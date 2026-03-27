Return-Path: <stable+bounces-230615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH63MSJWxmmMIwUAu9opvQ
	(envelope-from <stable+bounces-230615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:04:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6942C342234
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10ECB30B93EE
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3723A75A0;
	Fri, 27 Mar 2026 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGpUVyiJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F2361DD1;
	Fri, 27 Mar 2026 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605645; cv=none; b=N9jpMbIPk+Zlu6cJ0CKVFMQUDpssJKtTv3vZQrYx9w33T+88fh6xaFnaz4slIy2f4ZD5clkTI0wVHpst/3SSZiTzdQqwqIByEjvgFHTSjdlM6gwQ1X/8QYeOa76LRC5u7L2l3CXuj4Kz8Tc/W1O4v81/Xkr9my5PLlfZNuhVctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605645; c=relaxed/simple;
	bh=8CaLLkSgumSYT7IJ6abf2lHJKc4ycWuvxtapyXVpyac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlnpUlVMlAnhnWWHPykfRdE1UL+MdlcoeEqvRCijFZyijdd14HsgEtO0mGdofNdG79PEwXFs/1KNX/MPaJDqklYNi27FX72FA4bwcE4Lf3E2aRaMsb5MZXaz5j9Ku2Cgpm5cEzHNp4ZWO4FbtCDbTkBal3/ZEPfZZuRybjDoJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGpUVyiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F342CC19423;
	Fri, 27 Mar 2026 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774605645;
	bh=8CaLLkSgumSYT7IJ6abf2lHJKc4ycWuvxtapyXVpyac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGpUVyiJMP4UazDfTLYwE+zeASuQdCPtsTHi/T5V93Qx4ufFer+yJBmEI0KQx7Pdl
	 szM4zo8FVLWf4zAUKMgynpU1T4fppMgr0JrdxK1cErr8HKJ46IHsJupFWgB6PxQcyq
	 lopKGMGX8wRxHHAXz2yfG9HTgf+uHpnWN9+HgxWFXXTltxUvB9SQRtkDeaNd2w5Wex
	 nnCmicZ+PQ+Uy+AMllm+X/JKg+s1zyzRNdFh98DyOVxEYx+79c9UzGexJ1FwYLv/lJ
	 eKurtVMw/eKFIYCy0hF62t51vUEvd+yOwNA2WBAYx9c20mPhg9veTWby1KCYXml7nn
	 H1MqdMS80syig==
Date: Fri, 27 Mar 2026 19:00:43 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Aishwarya Rambhadran <aishwarya.rambhadran@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>, Petr Tesarik <ptesarik@suse.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org, kasan-dev@googlegroups.com,
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [REGRESSION] slab: replace cpu (partial) slabs with sheaves
Message-ID: <acZVS-ehXCtvcA9s@hyeyoo>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <afe9ba0a-1924-42a8-a9c5-34eec709f883@arm.com>
 <ed58493b-0369-4729-bcf7-bc89f72a7913@kernel.org>
 <acV36oPNFMgL4puz@milan>
 <ea1cb2a1-b674-4d69-bbf6-00051a0e11df@kernel.org>
 <eafefe7a-a33b-4102-93cf-fecc33ddf49e@arm.com>
 <0f441d8f-d84c-470a-a4cb-0249b15220a2@kernel.org>
 <f100305b-6c56-4499-98a4-6a22f8c49443@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f100305b-6c56-4499-98a4-6a22f8c49443@arm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230615-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arm.com,suse.cz,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,oracle.com,linutronix.de,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6942C342234
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:58:36AM +0000, Ryan Roberts wrote:
> >>>>> On 3/26/26 13:43, Aishwarya Rambhadran wrote:
> >>> Right so there should be just the overhead of the extra is_vmalloc_addr()
> >>> test. Possibly also the call of kfree_rcu_sheaf() if it's not inlined.
> >>> I'd say it's something we can just accept? It seems this is a unit test
> >>> being used as a microbenchmark, so it can be very sensitive even to such
> >>> details, but it should be negligible in practice.
> >>
> >> The perf/syscall cases might be a bit more concerning though? (those tests are
> >> from "perf bench syscall fork|execve"). Yes they are microbenchmarks, but a 7%
> >> increased cost for fork seems like something we'd want to avoid if we can.
> > 
> > Sure, I tried to explain those in my first reply. Harry then linked to how
> > that explanation can be verified. Hopefully it's really the same reason.
> 
> Ahh sorry I missed your first email. We only added that benchmark from 6.19 so
> don't have results for earlier kernels, but I'll ask Aishu to run it for 6.17
> and 6.18 to see if the results correlate with your expectation.
> 
> But from a high level perspective, a 7% regression on fork is not ideal even if
> there was a 7% improvement in 6.18.

If that improvement comes from the number of objects cached per CPU,
I'm not sure if determining the default value (# of cached objs) based on
"a point when microbenchmarks stop improving" is a reasonable measure
because the default value affects all slab caches and will inevitably
increase overall memory usage.

Hopefully we could discuss what a reasonable heuristic that
"works for most situations" looks like, and allow users to tune it further
based on their needs.

As a side note, changing sheaf capacity at runtime is not supported yet
(I'm working on it) and targeting at least before the next LTS.

-- 
Cheers,
Harry / Hyeonggon

