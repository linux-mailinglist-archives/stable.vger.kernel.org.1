Return-Path: <stable+bounces-267401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bhUgOGFKNWrirQYAu9opvQ
	(envelope-from <stable+bounces-267401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:55:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFA66A633E
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:55:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GDDudzH5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267401-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267401-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 159F23008C1E
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580542F9C37;
	Fri, 19 Jun 2026 13:55:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42272F549C
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:55:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877341; cv=none; b=ogvnw6zQQLO73mzAYBNoWo0JRnvVza8a21wV4Y82DSNj4zojZfEyy4xmrtou8FY8MqvZsoa2KBszKqYuBWVZ2CMuqiG7CC2Biz5cz/jVamxtPAG12o3A64AYEZ+JithVE7jDnj4YmQrPFf7tjNNR5GzfJ/XRaN54pAu1X+KN6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877341; c=relaxed/simple;
	bh=o1qyyCUiLk2IZXBlGllDZQs6UDwzB2mUuHtD+qylVnw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWy5tTqkEUO5sg/bAtlX3QDSCCuxBy2iWpA3lVOYlTox7I8Z5EX7SLfjlh0ab50yeyteWuVvXOg5Z4fISANPu2acBaw+OhlM81+9OfSnPrvtBjjK0yn3dX4Y5+BGFZ6oW7OaXM4n6DHbl08GTlIqjGEv3x71gAKlIWF/DfAk4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDDudzH5; arc=none smtp.client-ip=209.85.128.172
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7e8833c99fcso23288327b3.3
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781877339; x=1782482139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5i1wrFSasHSAGriS0dR4ZgA28mfR2sHR4Unx4u3FPo0=;
        b=GDDudzH5lym7SIIdRU0Ylqjclpc/ktWBOTR6ZL+HXoe4G4ceGMovTN3wMJqh462liT
         oV8IEdl2Vc+nQSPNdn5mGZzIQwE1NetKyhBMRpXVX75hFTZ+fYrJUAtnEI2hXCl5VzI1
         +FbdhiJuQclVXuBNk6FhLHxsvxdeWxn+jiYqKotRiLtgSGWBUKgNHB8Z1rf7oANJ9qvw
         OaIt1r+JEE/HGHnmzy5k4nwX2uIbSUDCahk3j5fLFyPu7Z4OvlVcZJ7exx58x7/l9O3O
         OfNxhgs4ERy04saWQZWr4dAYY6Z2THntMyktQmhwfroAGSnib9zb9CLNwUB4VzgtsmMI
         GJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781877339; x=1782482139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i1wrFSasHSAGriS0dR4ZgA28mfR2sHR4Unx4u3FPo0=;
        b=oasHokvsu337sW8hAGnkjuKxtfYsZQNwXWhgpmRyaVGvR8Ogidy1S7ONM7ZpgPWRvQ
         0xcqlwnbx8eNZ1hQXNSTpYaVOPaCVy6Tzje3FxlHstP1YsIAimWOS9fO4MX8vCWe5A2p
         76xa0Hr7bzBxOALUUF2M/fKQkVSoN6uPX3KDle+H/Z+TQ+D7p77W61V0rag3bWFmkP7F
         MP2i2uM9bNtmdlaCotOzQeFh6ksP6CubesPya0UAdvTb/h7yrAJbGXhkYjtVsioYsDgv
         vLkm/8LLjNnD5z393pxt0Waq2dNDsA29JGdkuxJWwvQDi+s9kZMVF3sQwcWnrARwCZLv
         TRwg==
X-Forwarded-Encrypted: i=1; AFNElJ8mdJHcI8IaYZdhQgPh+YQPuH0ZH9rs8sAlwcvq5HN5Mb9s8O1BDrwbmH4jA8SzpKuSO6xno7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXIiS40Gv8208gOhAPsWhRO0OSKSZZmAGkF/vtxskKJ8LrV6l
	Vi4SFj/R5BwvqIudq4jUT8iha0cVhgUY0N/a34JTHdUmuxRSt52TQ1YX
X-Gm-Gg: AfdE7cm2mZ2JzdOg4PzjqdB9enyvY2XD+f0uGRMzTkAj3Wd87TP6a+5TyS8BThMvcDQ
	MyLGX4knMvP8VEkSRCe/LJsw9EgNgkm5IVnISMwq6FNlGej/5L+rSYMFfQBaMUXo9s4ImtFrqfs
	rRHn6YsKq5jrw3C0JB+hBDoujR6XriS83PamG0fnnzavGnEB0MAaRyoPFh7fjuZjAEV22dK3e6B
	dtx+22OvqXULg8LAFc8o1F6wdTlARjb8wl3OG+mDTHpzDdrILjE6qYpT8KZRkV16BQgV0jsjQni
	ozis0Roawqb0cuP7//kZ8t1B0Wf4XCZ9/eIJ/U7MrU0gYaAiEi+SuMQdCmXzeP6VACkBic+MHQK
	JFhoJ3HbVZC/AC3yiYHRViBfUezB6t6cowtEaGbmHkS+rBJMb+L+WKgmtXj6MISmv0etDIvFW3E
	aL6NCSN3wcc6PEMHrKzHXhcI/P0UKbBIKW6PNL2/milED+Xf79XQuFavn0
X-Received: by 2002:a05:690c:f15:b0:7db:f8b1:cd7a with SMTP id 00721157ae682-801765be25bmr19662807b3.8.1781877338474;
        Fri, 19 Jun 2026 06:55:38 -0700 (PDT)
Received: from localhost (syn-035-130-123-074.biz.spectrum.com. [35.130.123.74])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80119810889sm11815567b3.1.2026.06.19.06.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:55:37 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Fri, 19 Jun 2026 09:55:37 -0400
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 net] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <ajVKWabkua_X3zRh@yury>
References: <20260619073338.481035-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619073338.481035-1-shradhagupta@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267401-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[yurynorov@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:shradhagupta@linux.microsoft.com,m:decui@microsoft.com,m:wei.liu@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:mhklinux@outlook.com,m:longli@microsoft.com,m:yury.norov@gmail.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:paulros@microsoft.com,m:shradhagupta@microsoft.com,m:ssengar@microsoft.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurynorov@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,yury:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CFA66A633E

On Fri, Jun 19, 2026 at 12:33:35AM -0700, Shradha Gupta wrote:
> In mana driver, the number of IRQs allocated is capped by the
> min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> than the vcpu count, we want to utilize all the vCPUs, irrespective of
> their NUMA/core bindings.
> 
> This is important, especially in the envs where number of vCPUs are so
> few that the softIRQ handling overhead on two IRQs on the same vCPU is
> much more than their overheads if they were spread across sibling vCPUs.
> 
> This behaviour is more evident with dynamic IRQ allocation. Since MANA
> IRQs are assigned at a later stage compared to static allocation, other
> device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> weights become imbalanced, causing multiple MANA IRQs to land on the
> same vCPU, while some vCPUs have none.
> 
> In such cases when many parallel TCP connections are tested, the
> throughput drops significantly.
> 
> We also studied the results of setting the affinity and hint to
> NULL in these cases, and observed that, with this logic if there are
> pre existing IRQs allocated on the VM(apart from MANA), during MANA
> IRQs allocation, it leads to clustering of the MANA queue IRQs again.
> These results can be seen through case 3 in the following data.
> 
> Test envs:
> =======================================================
> Case 1: without this patch
> =======================================================
> 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> 
> 	TYPE		effective vCPU aff
> =======================================================
> IRQ0:	HWC		0
> IRQ1:	mana_q1		0
> IRQ2:	mana_q2		2
> IRQ3:	mana_q3		0
> IRQ4:	mana_q4		3
> 
> %soft on each vCPU(mpstat -P ALL 1) on receiver
> vCPU		0	1	2	3
> =======================================================
> pass 1:		38.85	0.03	24.89	24.65
> pass 2:		39.15	0.03	24.57	25.28
> pass 3:		40.36	0.03	23.20	23.17
> 
> =======================================================
> Case 2: with this patch
> =======================================================
> 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> 
>         TYPE            effective vCPU aff
> =======================================================
> IRQ0:   HWC             0
> IRQ1:   mana_q1         0
> IRQ2:   mana_q2         1
> IRQ3:   mana_q3         2
> IRQ4:   mana_q4         3
> 
> %soft on each vCPU(mpstat -P ALL 1) on receiver
> vCPU            0       1       2       3
> =======================================================
> pass 1:         15.42	15.85	14.99	14.51
> pass 2:         15.53	15.94	15.81	15.93
> pass 3:         16.41	16.35	16.40	16.36
> 
> =======================================================
> Case 3: with affinity set to NULL
> =======================================================
> 4 vCPU(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> 
> 	TYPE		effective vCPU aff
> =======================================================
> IRQ0:	HWC			0
> IRQ1:	mana_q1			2
> IRQ2:	mana_q2			3
> IRQ3:	mana_q3			2
> IRQ4:	mana_q4			3
> 
> =======================================================
> Throughput Impact(in Gbps, same env)
> =======================================================
> TCP conn	with patch	w/o patch	aff NULL
> 20480		15.65		7.73		5.25
> 10240		15.63		8.93		5.77
> 8192		15.64		9.69		7.16
> 6144		15.64		13.16		9.33
> 4096		15.69		15.75		13.50
> 2048		15.69		15.83		13.61
> 1024		15.71		15.28		13.60
> 
> Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> Cc: stable@vger.kernel.org
> Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
> Changes in v4
>  * Add mana prefix on irq_affinity_*() in mana driver
>  * Corrected grammar, comment for mana_irq_setup_linear()
>  * added new line as per guidelines
>  * added case 3 in commit message for when affinity is NULL
> ---
> Changes in v3
>  * Optimize the comments in mana_gd_setup_dyn_irqs()
>  * add more details in the dev_dbg for extra IRQs
> ---
> Changes in v2
>  * Removed the unused skip_first_cpu variable
>  * fixed exit condition in irq_setup_linear() with len == 0
>  * changed return type of irq_setup_linear() as it will always be 0
>  * removed the unnecessary rcu_read_lock() in irq_setup_linear()
>  * added appropriate comments to indicate expected behaviour when
>    IRQs are more than or equal to num_online_cpus()
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 78 +++++++++++++++----
>  1 file changed, 64 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index a0fdd052d7f1..e8b7ffb47eb9 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -210,6 +210,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	} else {
>  		/* If dynamic allocation is enabled we have already allocated
>  		 * hwc msi
> +		 * Also, we make sure in this case the following is always true
> +		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
>  		 */
>  		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
>  	}
> @@ -1909,8 +1911,8 @@ void mana_gd_free_res_map(struct gdma_resource *r)
>   * do the same thing.
>   */
>  
> -static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> -		     bool skip_first_cpu)
> +static int mana_irq_setup_numa_aware(unsigned int *irqs, unsigned int len,
> +				     int node, bool skip_first_cpu)
>  {
>  	const struct cpumask *next, *prev = cpu_none_mask;
>  	cpumask_var_t cpus __free(free_cpumask_var);
> @@ -1946,11 +1948,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
>  	return 0;
>  }
>  
> +/* must be called with cpus_read_lock() held */
> +static void mana_irq_setup_linear(unsigned int *irqs, unsigned int len)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (len == 0)
> +			break;
> +
> +		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
> +		len--;
> +	}
> +}
> +
>  static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	struct gdma_irq_context *gic;
> -	bool skip_first_cpu = false;
>  	int *irqs, err, i, msi;
>  
>  	irqs = kmalloc_objs(int, nvec);
> @@ -1958,10 +1973,12 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  		return -ENOMEM;
>  
>  	/*
> +	 * In this function, num_msix_usable = HWC IRQ + Queue IRQ.
> +	 * nvec is only Queue IRQ (HWC already setup).
>  	 * While processing the next pci irq vector, we start with index 1,
>  	 * as IRQ vector at index 0 is already processed for HWC.
>  	 * However, the population of irqs array starts with index 0, to be
> -	 * further used in irq_setup()
> +	 * further used in mana_irq_setup_numa_aware()
>  	 */
>  	for (i = 1; i <= nvec; i++) {
>  		msi = i;
> @@ -1975,18 +1992,51 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  	}
>  
>  	/*
> -	 * When calling irq_setup() for dynamically added IRQs, if number of
> -	 * CPUs is more than or equal to allocated MSI-X, we need to skip the
> -	 * first CPU sibling group since they are already affinitized to HWC IRQ
> +	 * When calling mana_irq_setup_numa_aware() for dynamically added IRQs,
> +	 * if number of CPUs is more than or equal to allocated MSI-X, we need to
> +	 * skip the first CPU sibling group since they are already affinitized to
> +	 * HWC IRQ
>  	 */
>  	cpus_read_lock();
> -	if (gc->num_msix_usable <= num_online_cpus())
> -		skip_first_cpu = true;
> +	if (gc->num_msix_usable <= num_online_cpus()) {
> +		err = mana_irq_setup_numa_aware(irqs, nvec, gc->numa_node,
> +						true);
> +		if (err) {
> +			cpus_read_unlock();
> +			goto free_irq;
> +		}
> +	} else {
> +		/*
> +		 * When num_msix_usable are more than num_online_cpus, our
> +		 * queue IRQs should be equal to num of online vCPUs.
> +		 * We try to make sure queue IRQs spread across all vCPUs.
> +		 * In such a case NUMA or CPU core affinity does not matter.
> +		 * Note: in this case the total mana IRQ should always be
> +		 * num_online_cpus + 1. The first HWC IRQ is already handled
> +		 * in HWC setup calls
> +		 * However, if CPUs went offline since num_msix_usable was
> +		 * computed, queue IRQs will be more than num_online_cpus().
> +		 * In such cases remaining extra IRQs will retain their default
> +		 * affinity.
> +		 */
> +		int first_unassigned = num_online_cpus();
>  
> -	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> -	if (err) {
> -		cpus_read_unlock();
> -		goto free_irq;
> +		if (nvec > first_unassigned) {
> +			char buf[32];
> +
> +			if (first_unassigned == nvec - 1)
> +				snprintf(buf, sizeof(buf), "%d",
> +					 first_unassigned);
> +			else
> +				snprintf(buf, sizeof(buf), "%d-%d",
> +					 first_unassigned, nvec - 1);
> +
> +			dev_dbg(&pdev->dev,
> +				"MANA IRQ indices #%s will retain the default CPU affinity\n",
> +				buf);
> +		}
> +
> +		mana_irq_setup_linear(irqs, nvec);
>  	}
>  
>  	cpus_read_unlock();
> @@ -2041,7 +2091,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
>  		nvec -= 1;
>  	}
>  
> -	err = irq_setup(irqs, nvec, gc->numa_node, false);
> +	err = mana_irq_setup_numa_aware(irqs, nvec, gc->numa_node, false);
>  	if (err) {
>  		cpus_read_unlock();
>  		goto free_irq;
> 
> base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
> -- 
> 2.34.1

