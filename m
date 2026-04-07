Return-Path: <stable+bounces-233528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDRMMl7Q1GlJxwcAu9opvQ
	(envelope-from <stable+bounces-233528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:37:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF423AC257
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A4F3300421F
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1623A5445;
	Tue,  7 Apr 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NhWYcbEh"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FC63A63EF;
	Tue,  7 Apr 2026 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554332; cv=none; b=mrkK5adFlSipa2xmAKtL8HXze34fA+vf+zEJABjUBGgMmCBYY2AEKAXNcToOZkMVXbFhz9ObuhKqWWbxdA76t/99OpADCOz3nouejbxcDFd3L8UiYdItKu5ppgB7kjYQUaxCj1TH3QjlnJDgUQXoXf5ZDkQwm2swjrL/haUrflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554332; c=relaxed/simple;
	bh=bghqVgVi2rFpebPFdJZ8KlldKSei03ZbC3RuMA7fBIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V14hZ+ajXdD1t3KE0MdCB03SzQ6Su6ZjlGR1QVtc66hI6VOY8HheyN6vo2wymAboDp6n5otaQueWiAD/9C0Kc/5SpL0VE7nnyR6OpDqDvYGx23xE7Y9CZtwN7NiQaEpCt8G7C5MALZJW1Oqsf+nBZ/9USaVQRmw0hJDfdLQ+V0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NhWYcbEh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C121A00;
	Tue,  7 Apr 2026 02:32:04 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8770B3F7D8;
	Tue,  7 Apr 2026 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775554330; bh=bghqVgVi2rFpebPFdJZ8KlldKSei03ZbC3RuMA7fBIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhWYcbEhkFfiMRGOXn92UL+3h4avxJGszc0GnCTCQst0YLBovrcfCb2id6UFMHVgq
	 lNnUC1uqwmd74JeQbK0LBmuCFiIYw/dECq6d/pDT8ZmGmNiVDaNDy6eOI8/ZkgUczG
	 Zz1hOhxPL9x+aJNcEQBXD2WbAyOcplVVWlsipxo8=
Date: Tue, 7 Apr 2026 10:32:06 +0100
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
Message-ID: <adTPFrlVCEt-hioX@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com>
 <ac-W9oNM_O5RTtaf@arm.com>
 <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
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
	TAGGED_FROM(0.00)[bounces-233528-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 4AF423AC257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 09:43:42AM +0100, Ryan Roberts wrote:
> On 03/04/2026 11:31, Catalin Marinas wrote:
> > On Thu, Apr 02, 2026 at 09:43:59PM +0100, Catalin Marinas wrote:
> >> Another thing I couldn't get my head around - IIUC is_realm_world()
> >> won't return true for map_mem() yet (if in a realm). Can we have realms
> >> on hardware that does not support BBML2_NOABORT? We may not have
> >> configuration with rodata_full set (it should be complementary to realm
> >> support).
> > 
> > With rodata_full==false, can_set_direct_map() returns false initially
> > but after arm64_rsi_init() it starts returning true if is_realm_world().
> > The side-effect is that map_mem() goes for block mappings and
> > linear_map_requires_bbml2 set to false. Later on,
> > linear_map_maybe_split_to_ptes() will skip the splitting.
> > 
> > Unless I'm missing something, is_realm_world() calls in
> > force_pte_mapping() and can_set_direct_map() are useless. I'd remove
> > them and either require BBML2_NOABORT with CCA or get the user to force
> > rodata_full when running in realms. Or move arm64_rsi_init() even
> > earlier?
> 
> I'd need Suzuki to comment on this. As I said in the other mail, I was treating
> this like a pre-existing bug. But I guess linear_map_requires_bbml2 ending up
> wrong is a problem here. I'm not sure it's quite as simple as requiring
> BBML2_NOABORT with CCA as we still need can_set_direct_map() to return true if
> we are in a realm.

can_set_direct_map() == true is not a property of the realm but rather a
requirement. In the absence of BBML2_NOABORT, I guess the test was added
under the assumption that force_pte_mapping() also returns true if
is_realm_world(). We might as well add a variable or static label to
track whether can_set_direct_map() is possible and avoid tests that
duplicate force_pte_mapping().

This won't solve the is_realm_world() changing polarity during boot but
at least we know it won't suddenly make can_set_direct_map() return
true when it shouldn't.

-- 
Catalin

