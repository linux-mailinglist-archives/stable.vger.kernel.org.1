Return-Path: <stable+bounces-249198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOmDKhS6CmoB6QQAu9opvQ
	(envelope-from <stable+bounces-249198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:04:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFF3567264
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D73B93019C9D
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0783C9EE7;
	Mon, 18 May 2026 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B++w1fVf"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF630567B;
	Mon, 18 May 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087884; cv=none; b=nY4K+CCfnvcXtldLDfjDOEq+3BVRzPU7aKCjq5NntxttvhkZ7CHvQpYiAEK00DBtwyefYSyPqrPj9lvqEwreueoMRKlr5KFrRRyhYg1Wufclbm5GlIN4LRCpqoMIFoz8oK1fHp4CNLT60czvsC9ytRF9grPvt30Sgp+4eYuxl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087884; c=relaxed/simple;
	bh=1Zpx91UIrCFshD9UpU0MncVJjkdoTSOFrfZsMaXI0Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lky1+2vPI9UtAlywrc86INQnoZ+Z4eiUelgqhFEWksI4v03tmFsqxoahkM2OQD2KC1bkMINSiqqYX4sC+Os7SJbEMJRgu5LKOIUKVdcMhumOVGxXvQsM08k2+ylkGraf6rPs1JnSZWbiT+wh22pjO/4oj+kbAE+S5cmxzwZGZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B++w1fVf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id EB5DF20B7166; Mon, 18 May 2026 00:04:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB5DF20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779087871;
	bh=Y/nI2WCvH8QntJMDSNRBtqdYD4cCYsGeIc87zsm4JIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B++w1fVfJ+/Xrv4m7Fjdo812+X4Vks9mANb+DQzJR7NeFklFfJVc9/8Oa1KBrovXt
	 VBF83qoIs/DQYo9exJ8NBIrTyatSvufWa1DCfsjnXSPE4mKsYl2EErWFihygpjbOC+
	 bLada1tOJtrSjHQWuFL2IIR29hZ0HGH8qB/jlPLc=
Date: Mon, 18 May 2026 00:04:31 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <agq5/8rUFp3ttOFz@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
 <afTTPLClWwIMWTOh@yury>
 <afYMN6vbiX7Rzss+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <afYxOPL4DNjXM7tL@yury>
 <afmK531eRcPCecKm@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <afoQHm28qj8JnKww@yury>
 <af15yfdotzVbK8Kb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <af4X_52txN28b9RV@yury>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4X_52txN28b9RV@yury>
X-Rspamd-Queue-Id: 6BFF3567264
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249198-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[linux.microsoft.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,outlook.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> > But one observation I had was that " irq_set_affinity_and_hint(*irqs++,
> > NULL);" is essentially a no-op and we end up relying on the initial
> > placement from pci_alloc_irq_vectors().
> 
> Yes you are, assuming you're not binding them before in your call chain.
> 
> > Even though in these tests we
> > were not able to reproduce it, but with this distribution there is a
> > chance we end up clustering the mana queue IRQs, while other vCPUs are
> > not running any network load.
> 
> That sounds like an IRQ balancer bug which you're unable to reproduce. 
> 
> > It's because the placement depends on
> > system-wide IRQ state at allocation time.
> 
> I don't understand this point. The 
> 
>         irq_set_affinity_and_hint(*irqs++, NULL);
> 
> simply means: I trust system IRQ balancer to pick the best CPU for my
> IRQ at runtime. It doesn't refer any "IRQ state at allocation time".
>   
> > The linear approach however gaurantees each queue IRQ lands on a
> > distinct vCPU regardless of system state. Even after stressing the cpus
> > using stress-ng, we did not observe any significant throughput drop.
> 
> If you just do nothing, it would lead to the same numbers, right? What
> does that "non-significant throughput drop" mean? It sounds like the
> linear approach is slightly worse.

The numbers are not worse, they almost same in both the cases.
> 
> --
> 
> So, as you can't demonstrate solid benefit for the 'linear' IRQ placement,
> I would just stick to the no-affinity logic.

Thankyou Yury,
We are investigating on more test scenarios and trying to
capture numbers with both, your proposed change and the one from this
patch. We will keep you updated about the results.


- Vennela

