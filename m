Return-Path: <stable+bounces-214800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCeuDF1ah2mbXAQAu9opvQ
	(envelope-from <stable+bounces-214800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:29:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B1D1065DB
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28DF73018BCE
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A6F3542DE;
	Sat,  7 Feb 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gMAp2f9W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A39433AD;
	Sat,  7 Feb 2026 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770478169; cv=none; b=C7JrF0SO8fAGWFoRtFVmABCY4M0czT9BJ0HDlsQ4Ex4FxLfYJk3yAy4Jk7CSxQ2MYGo2iGE0AqGfY0LEooQbia0m72an5EiR4hA+mffvX/jMDU11TC3UnYYQM7gY6P5TlqUdL1YWacgO+LgV8FCqc401aE2Qhzt54I2JUA3KjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770478169; c=relaxed/simple;
	bh=vKllZ5mbGDfmKkXvBZbJFbDkuBA5VgMUWVz4AkCzxhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bos40WJaJZPSTeTKeKp/SmKLRzDjK+e5RI4BUY9xWBFwlqD1iq/CNxkcJjgKtmKFmb7pJkzJjKYhhzZIIo9eyaG1fOEvupYEi99hgr6zAvbWsrduzQhZPlrZwXiE2jC6TVbV90zWYBAFCwr58ZnIqELW2CVjEYrX5czS5wtnAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gMAp2f9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15204C116D0;
	Sat,  7 Feb 2026 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770478168;
	bh=vKllZ5mbGDfmKkXvBZbJFbDkuBA5VgMUWVz4AkCzxhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMAp2f9WOTRvf9aaSSekiwQWW1fTWWzNeV4h5eR+KN7xZ4c1wYHLwwYEefIKvN+Mw
	 j/dpM3R5rxDDXmPPlRz5fppUNfRP1I89aQ8z6UQCz7rgvY911HFobc4f3MFMsJoqci
	 NyRnw/hjbKe/VoJU7VM3OQAk65IYCbS2pWE+lbq0=
Date: Sat, 7 Feb 2026 16:29:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [PATCH 6.18 2/2] sched/topology: Fix sched domain build error
 for GNR, CWF in SNC-3 mode
Message-ID: <2026020701-ether-wieldable-f250@gregkh>
References: <cover.1768948644.git.tim.c.chen@linux.intel.com>
 <741531fc98d3c3d364451113b26c4900a868348a.1768948644.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <741531fc98d3c3d364451113b26c4900a868348a.1768948644.git.tim.c.chen@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214800-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 54B1D1065DB
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 01:33:34PM -0800, Tim Chen wrote:
> [ Upstream commit 4d6dd05d07d00bc3bd91183dab4d75caa8018db9 ]
> 
> It is possible for Granite Rapids (GNR) and Clearwater Forest
> (CWF) to have up to 3 dies per package. When sub-numa cluster (SNC-3)
> is enabled, each die will become a separate NUMA node in the package
> with different distances between dies within the same package.
> 
> For example, on GNR, we see the following numa distances for a 2 socket
> system with 3 dies per socket:
> 
>     package 1       package2
> 	----------------
> 	|               |
>     ---------       ---------
>     |   0   |       |   3   |
>     ---------       ---------
> 	|               |
>     ---------       ---------
>     |   1   |       |   4   |
>     ---------       ---------
> 	|               |
>     ---------       ---------
>     |   2   |       |   5   |
>     ---------       ---------
> 	|               |
> 	----------------
> 
> node distances:
> node     0    1    2    3    4    5
> 0:   	10   15   17   21   28   26
> 1:   	15   10   15   23   26   23
> 2:   	17   15   10   26   23   21
> 3:   	21   28   26   10   15   17
> 4:   	23   26   23   15   10   15
> 5:   	26   23   21   17   15   10
> 
> The node distances above led to 2 problems:
> 
> 1. Asymmetric routes taken between nodes in different packages led to
> asymmetric scheduler domain perspective depending on which node you
> are on.  Current scheduler code failed to build domains properly with
> asymmetric distances.
> 
> 2. Multiple remote distances to respective tiles on remote package create
> too many levels of domain hierarchies grouping different nodes between
> remote packages.
> 
> For example, the above GNR topology lead to NUMA domains below:
> 
> Sched domains from the perspective of a CPU in node 0, where the number
> in bracket represent node number.
> 
> NUMA-level 1    [0,1] [2]
> NUMA-level 2    [0,1,2] [3]
> NUMA-level 3    [0,1,2,3] [5]
> NUMA-level 4    [0,1,2,3,5] [4]
> 
> Sched domains from the perspective of a CPU in node 4
> NUMA-level 1    [4] [3,5]
> NUMA-level 2    [3,4,5] [0,2]
> NUMA-level 3    [0,2,3,4,5] [1]
> 
> Scheduler group peers for load balancing from the perspective of CPU 0
> and 4 are different.  Improper task could be chosen for load balancing
> between groups such as [0,2,3,4,5] [1].  Ideally you should choose nodes
> in 0 or 2 that are in same package as node 1 first.  But instead tasks
> in the remote package node 3, 4, 5 could be chosen with an equal chance
> and could lead to excessive remote package migrations and imbalance of
> load between packages.  We should not group partial remote nodes and
> local nodes together.
> Simplify the remote distances for CWF and GNR for the purpose of
> sched domains building, which maintains symmetry and leads to a more
> reasonable load balance hierarchy.
> 
> The sched domains from the perspective of a CPU in node 0 NUMA-level 1
> is now
> NUMA-level 1    [0,1] [2]
> NUMA-level 2    [0,1,2] [3,4,5]
> 
> The sched domains from the perspective of a CPU in node 4 NUMA-level 1
> is now
> NUMA-level 1    [4] [3,5]
> NUMA-level 2    [3,4,5] [0,1,2]
> 
> We have the same balancing perspective from node 0 or node 4.  Loads are
> now balanced equally between packages.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 70 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index eb289abece23..5709c9cab195 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -515,6 +515,76 @@ static void __init build_sched_topology(void)
>  	set_sched_topology(topology);
>  }
>  
> +#ifdef CONFIG_NUMA
> +static int sched_avg_remote_distance;
> +static int avg_remote_numa_distance(void)
> +{
> +	int i, j;
> +	int distance, nr_remote, total_distance;
> +
> +	if (sched_avg_remote_distance > 0)
> +		return sched_avg_remote_distance;
> +
> +	nr_remote = 0;
> +	total_distance = 0;
> +	for_each_node_state(i, N_CPU) {
> +		for_each_node_state(j, N_CPU) {
> +			distance = node_distance(i, j);
> +
> +			if (distance >= REMOTE_DISTANCE) {
> +				nr_remote++;
> +				total_distance += distance;
> +			}
> +		}
> +	}
> +	if (nr_remote)
> +		sched_avg_remote_distance = total_distance / nr_remote;
> +	else
> +		sched_avg_remote_distance = REMOTE_DISTANCE;
> +
> +	return sched_avg_remote_distance;
> +}
> +
> +int arch_sched_node_distance(int from, int to)
> +{
> +	int d = node_distance(from, to);
> +
> +	switch (boot_cpu_data.x86_vfm) {
> +	case INTEL_GRANITERAPIDS_X:
> +	case INTEL_ATOM_DARKMONT_X:
> +
> +		if (!x86_has_numa_in_package || topology_max_packages() == 1 ||
> +		    d < REMOTE_DISTANCE)
> +			return d;
> +
> +		/*
> +		 * With SNC enabled, there could be too many levels of remote
> +		 * NUMA node distances, creating NUMA domain levels
> +		 * including local nodes and partial remote nodes.
> +		 *
> +		 * Trim finer distance tuning for NUMA nodes in remote package
> +		 * for the purpose of building sched domains. Group NUMA nodes
> +		 * in the remote package in the same sched group.
> +		 * Simplify NUMA domains and avoid extra NUMA levels including
> +		 * different remote NUMA nodes and local nodes.
> +		 *
> +		 * GNR and CWF don't expect systems with more than 2 packages
> +		 * and more than 2 hops between packages. Single average remote
> +		 * distance won't be appropriate if there are more than 2
> +		 * packages as average distance to different remote packages
> +		 * could be different.
> +		 */
> +		WARN_ONCE(topology_max_packages() > 2,
> +			  "sched: Expect only up to 2 packages for GNR or CWF, "
> +			  "but saw %d packages when building sched domains.",
> +			  topology_max_packages());
> +
> +		d = avg_remote_numa_distance();
> +	}
> +	return d;
> +}
> +#endif /* CONFIG_NUMA */
> +
>  void set_cpu_sibling_map(int cpu)
>  {
>  	bool has_smt = __max_threads_per_core > 1;
> -- 
> 2.32.0
> 
> 

This breaks the build:
  CC      arch/x86/kernel/smpboot.o
arch/x86/kernel/smpboot.c:548:5: error: no previous prototype for ‘arch_sched_node_distance’ [-Werror=missing-prototypes]
  548 | int arch_sched_node_distance(int from, int to)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

How was it tested?

thanks,

greg k-h

