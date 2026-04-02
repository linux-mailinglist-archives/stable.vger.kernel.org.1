Return-Path: <stable+bounces-233117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPxgHofVzmloqgYAu9opvQ
	(envelope-from <stable+bounces-233117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:45:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB8D38E1F5
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A90A30247F8
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 20:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838AA3537D7;
	Thu,  2 Apr 2026 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rMISpFzg"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20772E2665;
	Thu,  2 Apr 2026 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162647; cv=none; b=O7tftvEa7Ynj6Vv8IKAZeBwFS5zAiUNPbJnUI6x9p89rvqbfSBMuWTCpYP/HRKM6bWldFtrg1mSNwCELNdIOEj+V0Gp+MDfG4BfHgs1bkajWUdbp9voA4EEsTPHAEsQW9ZTxDmq8YiUY6dPoDXcyYz5dfWYzi+rU1OSeH4VplkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162647; c=relaxed/simple;
	bh=cjEZkKQ+ODVU3DKbmEDkBuKAPPbwImPNm5BnHCLYCdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvFSkT/a8h6gPW62H/uDEcF47aGO6qHf5oanUDZAADw3scAQSznEiwSyvckDy7RV6+wDBGI8ZfwHRg9CCT3kymw3eAaCimZrD9SH2RSvBxbrtZXCHXUyysqRDmAlymf9PWt3GZ+3E+rPgTcV95pDerGfOO5V4aHqyDmlnfLgrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rMISpFzg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 192EA176B;
	Thu,  2 Apr 2026 13:43:58 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED233F915;
	Thu,  2 Apr 2026 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775162643; bh=cjEZkKQ+ODVU3DKbmEDkBuKAPPbwImPNm5BnHCLYCdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMISpFzgJPXbGvKghDviAPSjcuME2BDYXFgSL9AnIbxA4cAcDMShJErC2ayBI5Wdz
	 4AXjfquKWnELfq3rw5MB99YKMgHGZNzxLt9DFqQHuEXzExkBF9z5zR0fl/jfkORk1r
	 1hkhnj8rf6S/kx7qKb9lbVJe0u0k8T0CUysryFhI=
Date: Thu, 2 Apr 2026 21:43:59 +0100
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
Message-ID: <ac7VD4Z85nS30GCp@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330161705.3349825-2-ryan.roberts@arm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233117-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: CDB8D38E1F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 05:17:02PM +0100, Ryan Roberts wrote:
>  int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>  {
>  	int ret;
>  
> -	/*
> -	 * !BBML2_NOABORT systems should not be trying to change permissions on
> -	 * anything that is not pte-mapped in the first place. Just return early
> -	 * and let the permission change code raise a warning if not already
> -	 * pte-mapped.
> -	 */
> -	if (!system_supports_bbml2_noabort())
> -		return 0;
> -
>  	/*
>  	 * If the region is within a pte-mapped area, there is no need to try to
>  	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
>  	 * change permissions from atomic context so for those cases (which are
>  	 * always pte-mapped), we must not go any further because taking the
> -	 * mutex below may sleep.
> +	 * mutex below may sleep. Do not call force_pte_mapping() here because
> +	 * it could return a confusing result if called from a secondary cpu
> +	 * prior to finalizing caps. Instead, linear_map_requires_bbml2 gives us
> +	 * what we need.
>  	 */
> -	if (force_pte_mapping() || is_kfence_address((void *)start))
> +	if (!linear_map_requires_bbml2 || is_kfence_address((void *)start))
>  		return 0;
>  
> +	if (!system_supports_bbml2_noabort()) {
> +		/*
> +		 * !BBML2_NOABORT systems should not be trying to change
> +		 * permissions on anything that is not pte-mapped in the first
> +		 * place. Just return early and let the permission change code
> +		 * raise a warning if not already pte-mapped.
> +		 */
> +		if (system_capabilities_finalized())
> +			return 0;
> +
> +		/*
> +		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
> +		 * page allocator. Can't split until it's available.
> +		 */
> +		if (WARN_ON(!page_alloc_available))
> +			return -EBUSY;
> +
> +		/*
> +		 * Boot-time: Started secondary cpus but don't know if they
> +		 * support BBML2_NOABORT yet. Can't allow splitting in this
> +		 * window in case they don't.
> +		 */
> +		if (WARN_ON(num_online_cpus() > 1))
> +			return -EBUSY;
> +	}

I think sashiko is over cautions here
(https://sashiko.dev/#/patchset/20260330161705.3349825-1-ryan.roberts@arm.com)
but it has a somewhat valid point from the perspective of
num_online_cpus() semantics. We have have num_online_cpus() == 1 while
having a secondary CPU just booted and with its MMU enabled. I don't
think we can have any asynchronous tasks running at that point to
trigger a spit though. Even async_init() is called after smp_init().

An option may be to attempt cpus_read_trylock() as this lock is taken by
_cpu_up(). If it fails, return -EBUSY, otherwise check num_online_cpus()
and unlock (and return -EBUSY if secondaries already started).

Another thing I couldn't get my head around - IIUC is_realm_world()
won't return true for map_mem() yet (if in a realm). Can we have realms
on hardware that does not support BBML2_NOABORT? We may not have
configuration with rodata_full set (it should be complementary to realm
support).

I'll add the patches to for-next/core to give them a bit of time in
-next but let's see next week if we ignore this (with an updated
comment) or we try to avoid the issue altogether.

-- 
Catalin

