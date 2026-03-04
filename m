Return-Path: <stable+bounces-223102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFgzJVpsqGn9uQAAu9opvQ
	(envelope-from <stable+bounces-223102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:31:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BCA2052DC
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13982302DF43
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE663A5E6E;
	Wed,  4 Mar 2026 17:25:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB93AE192
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645128; cv=none; b=iKRltmi1yweC0msat6Dn0WYvRGPmZvURLPAvkobZTntLE5iebFUoyGUUjON70khjXj9LTq44zpRjM3LBA5oWkRtKspM78Lf+/ag8vZw075CCmx3/2r21f5zaK2zASJUblugSd6APPc+USuKpoylAtlvCdZ9j0AJPPBX/Z/ou/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645128; c=relaxed/simple;
	bh=67bOIxQRhaOaL+Bl0hFqP1e77dKoUcI7f6kD9A+4XWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZCgEG+V9EJeyD1JRkH1ffASz6PdmbezYRPlGMRuZWhPzIOWcbSOjXA4BiQCu35Nh0laZFIQrAXjicB+MU4J6xhL/FFMsTHSl1e8uL8KwoxmfASmlaqoOBdpxvrQxEvuKXExjKTTn7Lp21aE3cUWZ+zwYwAudGescz1x2kMSxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AFBF339;
	Wed,  4 Mar 2026 09:25:12 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A59AB3F73B;
	Wed,  4 Mar 2026 09:25:16 -0800 (PST)
Date: Wed, 4 Mar 2026 17:25:10 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Piotr Jaroszynski <pjaroszynski@nvidia.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
Message-ID: <aahq9i7XNYOBG49y@arm.com>
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
 <aagUtDTca5d0le2Y@arm.com>
 <20260304134313.GM972761@nvidia.com>
 <aahJX0NwtYHy1ILe@arm.com>
 <20260304153949.GP972761@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304153949.GP972761@nvidia.com>
X-Rspamd-Queue-Id: 29BCA2052DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223102-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arm.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:39:49AM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 04, 2026 at 03:01:51PM +0000, Catalin Marinas wrote:
> > Good point. For the AF bit, the hardware is not allowed to cache it in
> > the TLB, so we can't get an AF fault for an unrelated VA nearby.
> 
> The way we have read the spec is there is no restriction on what PTE
> the HW accesses when it encounters a CONT group.

Trying to find some rule in the Arm ARM, it only says that hardware
AF/DBM only happens to a single entry but it is not specific about which
in a contiguous range.

So yeah, it's better not to assume anything. If it helps software, we
could tighten the architecture but I think the benefit is marginal.

-- 
Catalin

