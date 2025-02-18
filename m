Return-Path: <stable+bounces-116699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C4A39892
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332CC1757A7
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35465239578;
	Tue, 18 Feb 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCpbU/bM"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F7F23956B;
	Tue, 18 Feb 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873699; cv=none; b=d++f2dg1qxlee1QOg1bd/BjsgAtOwrR+YJwd4JIugMVqalbOavo4D12b5aWRjO6YHNMaJt+8wUr3LTU+O+ye1AZm1RPVyfc1ixhiGP6rEbXbavlHEWITJ71Ou1DB5StTTO/r9kip26rXCPhfPb8fsPc+TyEqTPeIfQdMyoc02YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873699; c=relaxed/simple;
	bh=iBCQzC+4mpN17iyLXyVxwLHAYW5djzv6zjSai/ZpUZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRtbUMvhKuI0wEc6ris2r5uIsZL/mOQ2BZ3gAjUAPppNQS5+sq8kWItoWSIQZOtzM28uksCc3Huv6spntOIi1VFNg63I2oivw7GAWebjB7uMdTkNaRr57WNJptPNFEv/5LfpzXxkmwLIVO9hrqv11x9KOu9pfwSTPhXhjl3H0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCpbU/bM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A2E411400A2;
	Tue, 18 Feb 2025 05:14:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 18 Feb 2025 05:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739873697; x=1739960097; bh=z/iU5sPU7OWwLHOvBYdegxpJ93nXBD7FcUj
	3iXW3bSg=; b=gCpbU/bMcId6lwHXLlryvsafO1uzRhZyRtYS0SVq/RCKnOL+oqH
	t2jyUKnyz1DfEFNzchMhBAHq/mEhrfcT6e8HZa1CYEbUYs0RwZ2zyWGK7Dd5cNB1
	dwUaGytpHixTPKX9DaUu79PERP3ikocp5lAxJdELqdTilqG95XiGxXvE+wXXwIia
	L3+6ZiCmmSSGzJL3RxJeligPj+8UJNvOlyVf3OBmJUmtEJMkeb+Tb1WYCSyA2YNW
	WyeBbIwf5eZWDT+ca7/WV6PvXHARFpWW1YrsJjQqtw/nYNzgvpQQ747o3tzO/1S1
	ib/LifpWnMKbBhpsJ+jy2Mc9Sh6FHMThgTg==
X-ME-Sender: <xms:oF20Z0WnRB0cUsodofqlZ20vwt-ZvIRdUlpTCbx7l7GBV5t4zb_Xyg>
    <xme:oF20Z4lSFXbIxEYMEDFCOK8jyLeGT-nBjuDN13Hse4Q7--ElE966igRZ5fzvPmTgH
    cHzXuq4kxoNC_0>
X-ME-Received: <xmr:oF20Z4aS50rQibsY9QmQsGL0eLmIR-eFhwvq5a7TN5WQLKIed4KJEm7YmK8O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiuddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefg
    udffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepsggrohhluhdrlhhusehlihhnuhigrdhinhhtvghlrdgtohhmpdhr
    tghpthhtohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopeifihhllheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgt
    ohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpth
    htohepihhomhhmuheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsth
    grsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghithgrohes
    uggvsghirghnrdhorhhg
X-ME-Proxy: <xmx:oF20ZzUzqX65eFvrbjVkpTDaltaA5xpjivGBahSI71DA9AwOX1qAEA>
    <xmx:oF20Z-kvLFnRBEIrmXZVxQG2ATaRD27lOYaNPtxJPRGJ4k26BlcQKA>
    <xmx:oF20Z4dYjmQGd1fJpY5Xlr2EgpmWCKTm9JP5XpapW0QDJZd_iiB3LA>
    <xmx:oF20ZwGNNtXRWJikLbFXEpI7cZzBgJvfm37W-3hymMja6FmxNg-KVw>
    <xmx:oV20Z44oWLDnauOHhaEkseg3L4MDekdXcbvZrmMWdPgj1DLXmfXk0lYP>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 05:14:55 -0500 (EST)
Date: Tue, 18 Feb 2025 12:14:53 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	leitao@debian.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix suspicious RCU usage
Message-ID: <Z7RdnR2onJ2AZIJl@shredder>
References: <20250218022422.2315082-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218022422.2315082-1-baolu.lu@linux.intel.com>

+ Breno who also encountered this issue

On Tue, Feb 18, 2025 at 10:24:21AM +0800, Lu Baolu wrote:
> Commit <d74169ceb0d2> ("iommu/vt-d: Allocate DMAR fault interrupts
> locally") moved the call to enable_drhd_fault_handling() to a code
> path that does not hold any lock while traversing the drhd list. Fix
> it by ensuring the dmar_global_lock lock is held when traversing the
> drhd list.
> 
> Without this fix, the following warning is triggered:
>  =============================
>  WARNING: suspicious RCU usage
>  6.14.0-rc3 #55 Not tainted
>  -----------------------------
>  drivers/iommu/intel/dmar.c:2046 RCU-list traversed in non-reader section!!
>                other info that might help us debug this:
>                rcu_scheduler_active = 1, debug_locks = 1
>  2 locks held by cpuhp/1/23:
>  #0: ffffffff84a67c50 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
>  #1: ffffffff84a6a380 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x87/0x2c0
>  stack backtrace:
>  CPU: 1 UID: 0 PID: 23 Comm: cpuhp/1 Not tainted 6.14.0-rc3 #55
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0xb7/0xd0
>   lockdep_rcu_suspicious+0x159/0x1f0
>   ? __pfx_enable_drhd_fault_handling+0x10/0x10
>   enable_drhd_fault_handling+0x151/0x180
>   cpuhp_invoke_callback+0x1df/0x990
>   cpuhp_thread_fun+0x1ea/0x2c0
>   smpboot_thread_fn+0x1f5/0x2e0
>   ? __pfx_smpboot_thread_fn+0x10/0x10
>   kthread+0x12a/0x2d0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x4a/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> Simply holding the lock in enable_drhd_fault_handling() will trigger a
> lock order splat. Avoid holding the dmar_global_lock when calling
> iommu_device_register(), which starts the device probe process.
> 
> Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> Reported-by: Ido Schimmel <idosch@idosch.org>
> Closes: https://lore.kernel.org/linux-iommu/Zx9OwdLIc_VoQ0-a@shredder.mtl.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the fix. I tested it and the warning is gone.

Tested-by: Ido Schimmel <idosch@nvidia.com>

