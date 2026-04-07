Return-Path: <stable+bounces-233699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG/jJO091WlY3AcAu9opvQ
	(envelope-from <stable+bounces-233699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:25:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846143B2557
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E67CE30BB327
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF8DF59;
	Tue,  7 Apr 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="h7Z3X3BK"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7360733B6C6;
	Tue,  7 Apr 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582521; cv=none; b=OJfKOaIllWNTwVW9oH5kqpqa+Hz6RTPBMFSyLYCH7gjq8vo4ZjVoQxnxCQ/a7k//h0Ek2OQTJ3ubJrkVthtcw69g/JOPqJ5FdVd5cFi/+zhPTNfYnciJA8UCHy6nb/WcuqdVMg5HeLwI5bj0K9gBlHX+NJ+bTTjug8RUNwiqGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582521; c=relaxed/simple;
	bh=vE/AzNTfxAsg7nwOsnitaQKhZsQBUYcc/ffth8fx+bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArT1+4PKMbMhbXRonlblFtip57hrYQ0UEHM2LJMbK2szv1zMJxZPeeMjDfHQ1RRoKNqmlJXRQvvBh6jqiqJ5qPd9YfQnQLS1sFHn0DLqJenPdqBUF+79cC22rShLegE34KV8OgkgDKE/O3UQB3hgqYBnmS7YK1fdpctSH43g2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=h7Z3X3BK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 216B032E3;
	Tue,  7 Apr 2026 10:21:46 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D52E3F7D8;
	Tue,  7 Apr 2026 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775582511; bh=vE/AzNTfxAsg7nwOsnitaQKhZsQBUYcc/ffth8fx+bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7Z3X3BK/362O7Vz9OIZI86q27eRa/LA1xc0dXRnrXZUnIpaHf0rKSF7N80DEBhWO
	 AGzbcJ48pRiJUqTA+qqJHR05e1ozCHdLAuAUdJ4i+s13fq0yXHT+eAP1EhBD2Wd1vh
	 31Ycs7Bp/OQ/017uELGc0nViD+mDktdsld9TwgKM=
Date: Tue, 7 Apr 2026 18:21:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
Message-ID: <adU9KxLC7yKgmyJy@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com>
 <1db93bd3-cb47-445b-b8ca-6de6f04b41cc@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db93bd3-cb47-445b-b8ca-6de6f04b41cc@arm.com>
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
	TAGGED_FROM(0.00)[bounces-233699-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 846143B2557
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 10:57:35AM +0100, Suzuki K Poulose wrote:
> On 02/04/2026 21:43, Catalin Marinas wrote:
> > On Mon, Mar 30, 2026 at 05:17:02PM +0100, Ryan Roberts wrote:
> > >   int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
> > >   {
> > >   	int ret;
> > > -	/*
> > > -	 * !BBML2_NOABORT systems should not be trying to change permissions on
> > > -	 * anything that is not pte-mapped in the first place. Just return early
> > > -	 * and let the permission change code raise a warning if not already
> > > -	 * pte-mapped.
> > > -	 */
> > > -	if (!system_supports_bbml2_noabort())
> > > -		return 0;
> > > -
> > >   	/*
> > >   	 * If the region is within a pte-mapped area, there is no need to try to
> > >   	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
> > >   	 * change permissions from atomic context so for those cases (which are
> > >   	 * always pte-mapped), we must not go any further because taking the
> > > -	 * mutex below may sleep.
> > > +	 * mutex below may sleep. Do not call force_pte_mapping() here because
> > > +	 * it could return a confusing result if called from a secondary cpu
> > > +	 * prior to finalizing caps. Instead, linear_map_requires_bbml2 gives us
> > > +	 * what we need.
> > >   	 */
> > > -	if (force_pte_mapping() || is_kfence_address((void *)start))
> > > +	if (!linear_map_requires_bbml2 || is_kfence_address((void *)start))
> > >   		return 0;
> > > +	if (!system_supports_bbml2_noabort()) {
> > > +		/*
> > > +		 * !BBML2_NOABORT systems should not be trying to change
> > > +		 * permissions on anything that is not pte-mapped in the first
> > > +		 * place. Just return early and let the permission change code
> > > +		 * raise a warning if not already pte-mapped.
> > > +		 */
> > > +		if (system_capabilities_finalized())
> > > +			return 0;
> > > +
> > > +		/*
> > > +		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
> > > +		 * page allocator. Can't split until it's available.
> > > +		 */
> > > +		if (WARN_ON(!page_alloc_available))
> > > +			return -EBUSY;
> > > +
> > > +		/*
> > > +		 * Boot-time: Started secondary cpus but don't know if they
> > > +		 * support BBML2_NOABORT yet. Can't allow splitting in this
> > > +		 * window in case they don't.
> > > +		 */
> > > +		if (WARN_ON(num_online_cpus() > 1))
> > > +			return -EBUSY;
> > > +	}
> > 
> > I think sashiko is over cautions here
> > (https://sashiko.dev/#/patchset/20260330161705.3349825-1-ryan.roberts@arm.com)
> > but it has a somewhat valid point from the perspective of
> > num_online_cpus() semantics. We have have num_online_cpus() == 1 while
> > having a secondary CPU just booted and with its MMU enabled. I don't
> > think we can have any asynchronous tasks running at that point to
> > trigger a spit though. Even async_init() is called after smp_init().
> > 
> > An option may be to attempt cpus_read_trylock() as this lock is taken by
> > _cpu_up(). If it fails, return -EBUSY, otherwise check num_online_cpus()
> > and unlock (and return -EBUSY if secondaries already started).
> > 
> > Another thing I couldn't get my head around - IIUC is_realm_world()
> > won't return true for map_mem() yet (if in a realm).
> 
> That is correct. map_mem() comes from paginig_init(), which gets called
> before arm64_rsi_init(). Realm check was delayed until psci_xx_init().
> We had a version which parsed the DT for PSCI conduit early enough
> to be able to make the SMC calls to detect the Realm. But there
> were concerns around it.

Ah, yes, I remember.

Does it mean that commit 42be24a4178f ("arm64: Enable memory encrypt for
Realms") was broken without rodata=full w.r.t. the linear map? Commit
a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
introduced force_pte_mapping() but it just copied the logic in the
existing can_set_direct_map(). Looking at the linear_map_requires_bbml2
assignment, we get (!is_realm_world() && is_realm_world()) and it
cancels out, no effect on it but we don't get pte mappings either (even
if we don't have BBML2).

I think we need at least some safety checks:

1. BBML2_NOABORT support on the boot CPU - continue with the existing
   logic (as per Ryan's series)

2. !system_supports_bbml2_noabort() - split in
   linear_map_maybe_split_to_ptes(). This does not currently happen
   because linear_map_requires_bbml2 may be false in the absence of
   rodata=full. Not sure how to fix this without some variable telling
   us how the linear map was mapped. The requires_bbml2 flag doesn't

3. Panic in arm64_rsi_init() if !BBML2_NOABORT on the boot CPU _and_ we
   have block mappings already. People can avoid it with rodata=full

4. If (3) is a common case, a better alternative is to rewrite the
   linear map sometime after arm64_rsi_init() but before we call
   split_kernel_leaf_mapping().

-- 
Catalin

