Return-Path: <stable+bounces-233526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKI8NADN1GmtxgcAu9opvQ
	(envelope-from <stable+bounces-233526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:23:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 293093ABE1D
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65DFB301F49E
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 09:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8148539C018;
	Tue,  7 Apr 2026 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="heEz3+lB"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52378397E9F;
	Tue,  7 Apr 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553563; cv=none; b=f7d5zrubbhLRij2JMAs5yYg9rKTmAO39CfRjCQjH2CPXX4FsHvAOjPPUNWaKwgFeDlSVR6SK18M3n5WXFQ+8RUSh2WZ1fInBetKUy6boT9I2udktMj9ZbHzrubpzhntj1J4MqL7O7EF9BV1OOSpluYH/C4YDB2HRpJ64RVcTOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553563; c=relaxed/simple;
	bh=BkwEBj8W525ocnu66Qj8mQxpO4CVD0nQ+xuY/hsT/6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmgVNsUWkyKrwK5S25A+8huRrj1rCnoATcUHgdh5vKmuwWVw9DfgxNGDxQEGKTsbahXs+Wm7plnAkULTs6/vEEeyQv4Bt7oKuEjhwxHL2SBfdb6/RvJF/yJl74LPtjBEEEKGuTQM0SP5xvj2xSvcaNz2v52kkhOQxeIYeTTJ3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=heEz3+lB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A671A00;
	Tue,  7 Apr 2026 02:19:14 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06B733F7D8;
	Tue,  7 Apr 2026 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775553560; bh=BkwEBj8W525ocnu66Qj8mQxpO4CVD0nQ+xuY/hsT/6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heEz3+lB8qCnbyoY8jWEfi1x8w3wgS4ZVS2TS9nXCnF2tiBYh58sQXHAinlQ5yN5r
	 PeH6elIIVZUzfEpc4LF8y1ZxNlbK9IX9mN/QnImlPxzuEeRw/Vok6kfbIW+cVcpT8y
	 7MErmbi5Zn6H36qYEwaclDLSw58JXiAn5aJk5hDQ=
Date: Tue, 7 Apr 2026 10:19:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
Message-ID: <adTMFFljx862f7TF@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com>
 <160ec79a-f842-421a-bfde-5b4da32b3b4e@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160ec79a-f842-421a-bfde-5b4da32b3b4e@arm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233526-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 293093ABE1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 09:33:50AM +0100, Ryan Roberts wrote:
> On 02/04/2026 21:43, Catalin Marinas wrote:
> > On Mon, Mar 30, 2026 at 05:17:02PM +0100, Ryan Roberts wrote:
> >>  int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
> >>  {
> >>  	int ret;
> >>  
> >> -	/*
> >> -	 * !BBML2_NOABORT systems should not be trying to change permissions on
> >> -	 * anything that is not pte-mapped in the first place. Just return early
> >> -	 * and let the permission change code raise a warning if not already
> >> -	 * pte-mapped.
> >> -	 */
> >> -	if (!system_supports_bbml2_noabort())
> >> -		return 0;
> >> -
> >>  	/*
> >>  	 * If the region is within a pte-mapped area, there is no need to try to
> >>  	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
> >>  	 * change permissions from atomic context so for those cases (which are
> >>  	 * always pte-mapped), we must not go any further because taking the
> >> -	 * mutex below may sleep.
> >> +	 * mutex below may sleep. Do not call force_pte_mapping() here because
> >> +	 * it could return a confusing result if called from a secondary cpu
> >> +	 * prior to finalizing caps. Instead, linear_map_requires_bbml2 gives us
> >> +	 * what we need.
> >>  	 */
> >> -	if (force_pte_mapping() || is_kfence_address((void *)start))
> >> +	if (!linear_map_requires_bbml2 || is_kfence_address((void *)start))
> >>  		return 0;
> >>  
> >> +	if (!system_supports_bbml2_noabort()) {
> >> +		/*
> >> +		 * !BBML2_NOABORT systems should not be trying to change
> >> +		 * permissions on anything that is not pte-mapped in the first
> >> +		 * place. Just return early and let the permission change code
> >> +		 * raise a warning if not already pte-mapped.
> >> +		 */
> >> +		if (system_capabilities_finalized())
> >> +			return 0;
> >> +
> >> +		/*
> >> +		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
> >> +		 * page allocator. Can't split until it's available.
> >> +		 */
> >> +		if (WARN_ON(!page_alloc_available))
> >> +			return -EBUSY;
> >> +
> >> +		/*
> >> +		 * Boot-time: Started secondary cpus but don't know if they
> >> +		 * support BBML2_NOABORT yet. Can't allow splitting in this
> >> +		 * window in case they don't.
> >> +		 */
> >> +		if (WARN_ON(num_online_cpus() > 1))
> >> +			return -EBUSY;
> >> +	}
> > 
> > I think sashiko is over cautions here
> > (https://sashiko.dev/#/patchset/20260330161705.3349825-1-ryan.roberts@arm.com)
> > but it has a somewhat valid point from the perspective of
> > num_online_cpus() semantics. We have have num_online_cpus() == 1 while
> > having a secondary CPU just booted and with its MMU enabled. I don't
> > think we can have any asynchronous tasks running at that point to
> > trigger a spit though. Even async_init() is called after smp_init().
> 
> Yes I saw the Sashiko report, but we had previously had a (private) discussion
> where I thought we had already concluded that this approach is safe in practice
> due to the way that the boot cpu brings the secondaries online.

Yes, I thought I'd mention it. I don't see how this could go wrong in
practice as we don't expect any page splitting on the primary CPU while
it waits for the secondaries to come up.

> > An option may be to attempt cpus_read_trylock() as this lock is taken by
> > _cpu_up(). If it fails, return -EBUSY, otherwise check num_online_cpus()
> > and unlock (and return -EBUSY if secondaries already started).
> 
> That sounds neat; I could dig deeper and have a go at something like this if you
> want?

I don't think it's worth it. We'll probably need to keep the lock for
the duration of the splitting (though that's only before the cpu
features are fully initialised). It's something we can look into if we
ever see an issue here. For now, the num_online_cpus() test will do.

> > Another thing I couldn't get my head around - IIUC is_realm_world()
> > won't return true for map_mem() yet (if in a realm). Can we have realms
> > on hardware that does not support BBML2_NOABORT? We may not have
> > configuration with rodata_full set (it should be complementary to realm
> > support).
> 
> My understanding is that this is a pre-existing (and known) bug. It's not
> related to the "map linear map by large leaves and split dynamically" feature so
> wasn't attempting to fix it.

Yes, it's an existing bug I noticed while trying to understand the code
paths. It doesn't need any action on this series but we should try to
fix it separately.

-- 
Catalin

