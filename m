Return-Path: <stable+bounces-235417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DNvARqz12kORggAu9opvQ
	(envelope-from <stable+bounces-235417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:09:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B48A3CBC73
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 119BC300F109
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD130BF5C;
	Thu,  9 Apr 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sv1jHw2M"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD8302CD5;
	Thu,  9 Apr 2026 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743753; cv=none; b=APtCYi22vrao4OQaCPsbfl3Ced7UYmkMAwGtLrLXjaLcluLkUtTtSyVNLtXFENARh/g+ov3KzOjyGxDrtHCpytek/b2lXypJV+DgkV+xU6cgL/ESytoDB9l/JIj+JLGU6nhsa1G3eKiEfyfjBXnwujiNeu3Oe0MTzscb2T4S8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743753; c=relaxed/simple;
	bh=ipsSLoMfiPqYFIbUKTrfChsu5vns0/lAN8ULtLYM75Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO0LaCL/G48ywYE7wvoousdKTcGoXSA2gKuK9mFykfFOKPXSQAFQijAOxvPumix9qXCLc3buMoDKrfH2Iu6oJmWvXYWCFX3FMMK+gTUHdJYfaC7SoyJ2XglZBB0znHihA0Yr4Q3yN85kcBPWOmlQ49ZtQdFufonl0U1nxL66HDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sv1jHw2M; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67300328E;
	Thu,  9 Apr 2026 07:09:04 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73AF13F632;
	Thu,  9 Apr 2026 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775743750; bh=ipsSLoMfiPqYFIbUKTrfChsu5vns0/lAN8ULtLYM75Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sv1jHw2MnnzhZ95ZAtsy9ohqi0q0sg1raSFQx/D6Sc5yebvU6+mk44j5jcp2D4bp3
	 ATO69PDQQiFKd9MZtDbzDQqM4+w8ktvn2NUL4sT400bYAKEpXXSG0RFrMumBZxBfCs
	 zCd5yijVGGncEZrFYCl3JX5qrICdlR/kARi3old4=
Date: Thu, 9 Apr 2026 15:09:05 +0100
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
Message-ID: <adezAR6w9yNfILsn@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com>
 <1db93bd3-cb47-445b-b8ca-6de6f04b41cc@arm.com>
 <adU9KxLC7yKgmyJy@arm.com>
 <d1ecba64-898f-433b-93d4-7a33b9c3f378@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ecba64-898f-433b-93d4-7a33b9c3f378@arm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235417-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 8B48A3CBC73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 10:38:03AM +0100, Suzuki K Poulose wrote:
> On 07/04/2026 18:21, Catalin Marinas wrote:
> > a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
> > introduced force_pte_mapping() but it just copied the logic in the
> > existing can_set_direct_map(). Looking at the linear_map_requires_bbml2
> > assignment, we get (!is_realm_world() && is_realm_world()) and it
> > cancels out, no effect on it but we don't get pte mappings either (even
> > if we don't have BBML2).
> 
> Yep, that's right.
> > 
> > I think we need at least some safety checks:
> > 
> > 1. BBML2_NOABORT support on the boot CPU - continue with the existing
> >     logic (as per Ryan's series)
> > 
> > 2. !system_supports_bbml2_noabort() - split in
> >     linear_map_maybe_split_to_ptes(). This does not currently happen
> >     because linear_map_requires_bbml2 may be false in the absence of
> >     rodata=full. Not sure how to fix this without some variable telling
> >     us how the linear map was mapped. The requires_bbml2 flag doesn't
> > 
> > 3. Panic in arm64_rsi_init() if !BBML2_NOABORT on the boot CPU _and_ we
> >     have block mappings already. People can avoid it with rodata=full
> 
> It looks like this will be a common case :-(
> 
> > 
> > 4. If (3) is a common case, a better alternative is to rewrite the
> >     linear map sometime after arm64_rsi_init() but before we call
> >     split_kernel_leaf_mapping().
> 
> We will explore this route.
> 
> The other option is to move the RSI detection (and the PSCI probe)
> earlier to be able to make better decisions early on. I will play with
> that a bit too.

I thought we could reuse linear_map_split_to_ptes() but this function
assumes that the primary CPU supports BBML2_NOABORT. To do this live,
we'd have to clone the active kernel pgtable hierarchy, switch to it and
then continue with the splitting. kasan_init_shadow() does a bit of this
but not fully as it only cares about the shadow mapping.

Hmm, maybe probing the RSI early is easier ;).

-- 
Catalin

