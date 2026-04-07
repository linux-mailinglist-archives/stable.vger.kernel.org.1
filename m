Return-Path: <stable+bounces-233559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAwsKyfj1Gn0yQcAu9opvQ
	(envelope-from <stable+bounces-233559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:57:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F753AD5EF
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBE3430570D8
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8DA38B7CF;
	Tue,  7 Apr 2026 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="goTgIKJY"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670EE3932F7;
	Tue,  7 Apr 2026 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559160; cv=none; b=fiLTuFsLnPZRh4i7iTBmNkT05pd9pTY3ZKk2w0NDCaAKiSMLCuzuUZ2Xo0gdlWIqAIMQAw79SzvEIGGy4s7kjV6Wwj3FiwZ3X47/paYGciIo7L3kq04u43VvZajeUQN30zCmiA2KPxUYusOO71AjIWZ/GBTb2gGXmtzWd3CWJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559160; c=relaxed/simple;
	bh=1ncnVOsuWYAw3IF70eygWx6t1LxyZ2q+2MYl6USa5l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg4D0nxa1QBSPZbdxOYVBkkTUx3Z/3CcoLi2qhxCIV7gqNzWu40lFFX5MWQz0HYZc1hlFjbagcmpRkASZr8JBao64OYwTBAejm8br54/QcxcaYY0mLWucDLhb41wYUXoPSiYMxNWt74mfXI0JrUpz35+/mqIazpr9JxQjcDX3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=goTgIKJY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A0BD175A;
	Tue,  7 Apr 2026 03:52:32 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 631303F641;
	Tue,  7 Apr 2026 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775559157; bh=1ncnVOsuWYAw3IF70eygWx6t1LxyZ2q+2MYl6USa5l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goTgIKJYCyiF0jjX3GevgPVxT47rpBu2snee3BGmA92MrZOu157NaMc9wiRHl+pbD
	 V1ckcrJt/bqn6L3vwXy5FtANYeLFvbH776nrjcSMNW+xw6C6lnfOktzPfx7lWuXq/q
	 lloWUp2GS5oXGbVTH2omprFCSbY4afyBtZWPW+Hc=
Date: Tue, 7 Apr 2026 11:52:33 +0100
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
Message-ID: <adTh8d9k3y5ybemL@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com>
 <ac-W9oNM_O5RTtaf@arm.com>
 <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
 <adTPFrlVCEt-hioX@arm.com>
 <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com>
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
	TAGGED_FROM(0.00)[bounces-233559-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30F753AD5EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 11:13:07AM +0100, Ryan Roberts wrote:
> On 07/04/2026 10:32, Catalin Marinas wrote:
> > On Tue, Apr 07, 2026 at 09:43:42AM +0100, Ryan Roberts wrote:
> >> On 03/04/2026 11:31, Catalin Marinas wrote:
> >>> On Thu, Apr 02, 2026 at 09:43:59PM +0100, Catalin Marinas wrote:
> >>>> Another thing I couldn't get my head around - IIUC is_realm_world()
> >>>> won't return true for map_mem() yet (if in a realm). Can we have realms
> >>>> on hardware that does not support BBML2_NOABORT? We may not have
> >>>> configuration with rodata_full set (it should be complementary to realm
> >>>> support).
> >>>
> >>> With rodata_full==false, can_set_direct_map() returns false initially
> >>> but after arm64_rsi_init() it starts returning true if is_realm_world().
> >>> The side-effect is that map_mem() goes for block mappings and
> >>> linear_map_requires_bbml2 set to false. Later on,
> >>> linear_map_maybe_split_to_ptes() will skip the splitting.
> >>>
> >>> Unless I'm missing something, is_realm_world() calls in
> >>> force_pte_mapping() and can_set_direct_map() are useless. I'd remove
> >>> them and either require BBML2_NOABORT with CCA or get the user to force
> >>> rodata_full when running in realms. Or move arm64_rsi_init() even
> >>> earlier?
> >>
> >> I'd need Suzuki to comment on this. As I said in the other mail, I was treating
> >> this like a pre-existing bug. But I guess linear_map_requires_bbml2 ending up
> >> wrong is a problem here. I'm not sure it's quite as simple as requiring
> >> BBML2_NOABORT with CCA as we still need can_set_direct_map() to return true if
> >> we are in a realm.
> > 
> > can_set_direct_map() == true is not a property of the realm but rather a
> > requirement. 
> 
> Yes indeed. It would be better to call it might_set_direct_map() or something
> like that...

The way it is used means "is allowed to set the direct map". I guess
"may set..." works as well. My reading of "might" is more like in
might_sleep(), more of hint than a permission check.

If you only look at the linear_map_requires_bbml2 setting in map_mem(),
yes, something like might_set_direct_map() makes sense but that's not
how this function is used in the rest of the kernel (to reject the
direct map change if not supported).

> > In the absence of BBML2_NOABORT, I guess the test was added
> > under the assumption that force_pte_mapping() also returns true if
> > is_realm_world(). We might as well add a variable or static label to
> > track whether can_set_direct_map() is possible and avoid tests that
> > duplicate force_pte_mapping().
> 
> I'm not sure I follow. We have linear_map_requires_bbml2 which is inteded to
> track this shape of thing;

As the name implies, linear_map_requires_bbml2 tracks only this -
BBML2_NOABORT is required because the linear map uses large blocks.
Prior to your patches, that's only used as far as
linear_map_maybe_split_to_ptes() and if splitting took place, this
variable is no longer relevant (should be turned to false but since it's
not used, it doesn't matter).

With your patches, its use was extended to runtime and I think it
remains true even if linear_map_maybe_split_to_ptes() changed the block
mappings. Do we need this:

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dcee56bb622a..595d35fdd8c3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -988,6 +988,7 @@ void __init linear_map_maybe_split_to_ptes(void)
 	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()) {
 		init_idmap_kpti_bbml2_flag();
 		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
+		linear_map_requires_bbml2 = false;
 	}
 }
 

> if we have forced pte mapping then the value of
> can_set_direct_map() is irrelevant - we will never need to split because we are
> already pte-mapped.

can_set_direct_map() is used in other places, so its value is relevant,
e.g. sys_memfd_secret() is rejected if this function returns false.

> But if can_set_direct_map() initially returns false because
> is_realm_world() incorrectly returns false in the early boot environment, then
> linear_map_requires_bbml2 will be set to false, and we will incorrectly
> short-circuit splitting any block mappings in split_kernel_leaf_mapping().
> 
> I think we are agreed on the problem. But I don't understand how tracking
> can_set_direct_map() in a cached variable helps with that.

It's not about the map_mem() decision and linear_map_requires_bbml2
setting but rather its other uses like sys_memfd_secret().

> > This won't solve the is_realm_world() changing polarity during boot but
> > at least we know it won't suddenly make can_set_direct_map() return
> > true when it shouldn't.
> 
> But is_real_world() _should_ make can_set_direct_map() return true, shouldn't
> it?

Yes but not directly. If is_realm_world() is true, we either have
(linear_map_requires_bbml2 && system_supports_bbml2_noabort()) or
linear_map_requires_bbml2 is false and we have pte mappings. Adding
is_realm_world() to can_set_direct_map() does not imply any of these.
It's just a hope that something before actually ensured the conditions
are true.

It might be better if we rename the current function to
might_set_direct_map() and introduce a new can_set_direct_map() that
actually tells the truth if all the conditions are met. I suggested a
variable or static label but checking some conditions related to the
actual linear map work as well, just not is_realm_world() directly.

-- 
Catalin

