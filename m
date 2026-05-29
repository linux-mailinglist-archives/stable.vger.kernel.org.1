Return-Path: <stable+bounces-256587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMegGH1oGWpMwQgAu9opvQ
	(envelope-from <stable+bounces-256587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:20:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596A6600B2A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8162B3083E58
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C39231827;
	Fri, 29 May 2026 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hSV/vthy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140032741B5;
	Fri, 29 May 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049749; cv=none; b=KzRTLK3eXyGtpuBFJWA7Zm92EZ1JjkBoSffiP4LTVfz8wJt9s2EdO5lz+W6nsiQYfMqPC5n5D/2FWaEa2z2EKKE0sA38d0mUkeak3seSiNcJPYjbQRTRop+ODckO3ycGjVCsysy1kw6CpMPXStJLPdcgwPXocgZVmk+o3UABYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049749; c=relaxed/simple;
	bh=ZHzfii8xK/ftUdVJRxfkWuueMhXA62aGgA97PZv1iAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+Trwng9+hyMwC/P/QrCxqr6coGPJJJFa8U23M1LRylKCsRgJohDRcZrraJZeJE1pTvPVPHhOZ7FWu/qjhbHGwNQj2bEM6jZuTDA26bBD5qr+bzJQmbEINy2k+eilxxTrG5hIwG3O88NNuaF0cX6Qtdk7GMMZuU1lyJxOYRCeNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hSV/vthy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlhCX1684655;
	Fri, 29 May 2026 10:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=uy6t5ppD1nY+GglA2XoAi
	IuSE97XRVs9Lr9qT794SiM=; b=hSV/vthy5rrvWcEUEjF4xtTtt9H9DHoUg0Xep
	3ApAMW9c2I4KPMujcrYH0TRZvo3ZQih7Fh0aeGXcA2TB/loEV3ytkRt39hZqQ/xq
	lXpR6B31EpPhZ7RpxB+sXO2xrIlOxk0rOnFRTEPqvC9zjZXuNlX8jHMR1sIimI11
	RRuu7SpulT8s9arHUhkyFPKXrrVOwcwcU/HNDdJeUIk4cN5I+13GKtlhSdR3yOzy
	TdF55pQ9LOxYegcElLsjEq9At3DbpmPBByM8qQcrlcsgq23HT6d66MlM5HAZqRnA
	Dlcp7Vq6JdmhwYnK1+fR/xajeHiGCgIkr4Zam/MdC7h0egiUg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884g1k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:15:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TA9O0q022777;
	Fri, 29 May 2026 10:15:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc51nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:15:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TAFMWe8454638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:15:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E223F20040;
	Fri, 29 May 2026 10:15:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438582004B;
	Fri, 29 May 2026 10:15:19 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 29 May 2026 10:15:19 +0000 (GMT)
Date: Fri, 29 May 2026 15:45:18 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        mingo@kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, venkat88@linux.ibm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
        kprateek.nayak@amd.com, riteshh@linux.ibm.com, stable@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH] sched/topology: Provide arch_llc_mask for cache aware
 scheduling
Message-ID: <ahlnNsaQH-zg5tV2@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20260529075712.1181039-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260529075712.1181039-1-sshegde@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19673f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=UZhIc3m1dWDYcD9tvD4A:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 84M-2t6QsD-y15zqN6r6FdqxPN0jhaF7
X-Proofpoint-GUID: nwXy-Tm7YMjuiWDOdsK30iKORNlUITXV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX0hnZS8YC9wVD
 QYHyvNoXC7jpVx4jT4ZppDeHTeUMTEG44HcJCPGjY+X5k35NAcp+lgDjS9Xeuiquo0i5OVPf3Ug
 F6AOhd1y6Oq21MPVjdqXIAkeUaeeY57mmSS+NZsLEmKlvGS5B33iW+C+L0IWfiZOpVl17AI4k4b
 RXNnyJT005qyFGtXLiOFx83jHP9aA3mfQaMQTYz2bxWVUbFp3gS2QnWs5+OK4TgIVvp/HoAfmjg
 2VJZI7snZylAcFPpQOhcpR/IznVm8dl+7Z8orZurntX1Egwqp6XW+y5z56fO677L3Hs4/wH0QUi
 BRPaZ+DfXzeIB9DUoVEea2OJcsltl8vPbIEgWQEk5zISDLuP63EzQbQTfOLN5iDt0ANLCWVMikV
 PF0C5JpQp716vfHUbKuAteErBIZSo+lpNJ3qPyP04597c1KeKpVEvy6dBOh6gERYwIAqLk0k/WA
 wO4C6zDxnCtrYIiO5UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290100
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,infradead.org,kernel.org,csgroup.eu,vger.kernel.org,intel.com,linux.intel.com,amd.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-256587-lists,stable=lfdr.de];
	REPLYTO_EQ_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[srikar@linux.ibm.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srikar@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 596A6600B2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-05-29 13:27:12]:

> Venkat Reported a boot kernel panic next-20260522. Git bisect pointed to
> b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> 
> Stacktrace points to llc_mask being null.
> 
> NIP [c000000000e58504] _find_first_bit+0x44/0x130
> LR [c000000000e58500] _find_first_bit+0x40/0x130
> Call Trace:
> build_sched_domains+0xad8/0xe50
> sched_init_smp+0xa8/0x164
> kernel_init_freeable+0x250/0x370
> ret_from_kernel_user_thread+0x14/0x1c
> 
> On powerpc, cpu_coregroup_mask is available only when the underlying
> hardware support coregroup. In shared LPAR, QEMU guest or power9 etc
> coregroup isn't supported. In such cases llc_mask was being referenced
> when it was null leading to panic.
> 
> On powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
> domain point to LLC is wrong. Provide a way for archs to say where its
> LLC is if it not at MC domain. 
> 
> Based on tip/master at 5c89783224e9 ("Merge branch into tip/master: 'x86/tdx'")
> Cc: stable@vger.kernel.org
> 
> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com> 
> Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Co-developed-by: Chen, Yu C <yu.c.chen@intel.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/topology.h |  6 ++++++
>  kernel/sched/topology.c             | 13 +++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 66ed5fe1b718..e3de0f3d8b86 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -135,6 +135,12 @@ struct cpumask *cpu_coregroup_mask(int cpu);
>  const struct cpumask *cpu_die_mask(int cpu);
>  int cpu_die_id(int cpu);
>  
> +/* Points to where the LLC is. On power9 this will point at CACHE
> + * domain, On others it will point to SMT domain. In all cases
> + * cpu_l2_cache_mask points to where LLC is
> + */

Nit: Regular comment style could have been better.

> +#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
> +
>  #ifdef CONFIG_PPC64
>  #include <asm/smp.h>
>  
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index df2ceb54c970..622e2e01974c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2063,12 +2063,21 @@ const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu
>  	return cpu_coregroup_mask(cpu);
>  }
>  
> -#define llc_mask(cpu) cpu_coregroup_mask(cpu)
> +/*
> + * Majority of architectures have LLC at MC domain level with exception
> + * such as powerpc. Provide a way for arch to specify where its LLC is
> + * if it falls in exception category
> + */
> +# ifndef arch_llc_mask
> +#define arch_llc_mask(cpu) cpu_coregroup_mask(cpu)
> +# endif
>  
>  #else
> -#define llc_mask(cpu) cpumask_of(cpu)
> +#define arch_llc_mask(cpu) cpumask_of(cpu)
>  #endif
>  
> +#define llc_mask(cpu) arch_llc_mask(cpu)
> +

Instead of having another define, could we have modified current users of
llc_mask() to arch_llc_mask()? Again its not a problem, but why have 2
defines since both point to the same thing.

>  const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
>  {
>  	return cpu_node_mask(cpu);
> -- 
> 2.47.3
> 

Otherwise, looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

