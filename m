Return-Path: <stable+bounces-233706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEUKBD1B1Wk73gcAu9opvQ
	(envelope-from <stable+bounces-233706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:39:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9503B276B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 986F9305BDF9
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5850938655B;
	Tue,  7 Apr 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G87M6Y+g"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1782347537;
	Tue,  7 Apr 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583464; cv=none; b=gcib8lBDVBmNLTZPz+KitiWS6MEvwS8f9gpCeh/LemP4lcCmSLk+gW5yk3JseBeosF7ub1yQN4YAKBbb/zTvDzcPoTE/OhPa0RVbstRdm0JUTUkNLzb1sUt4bkYapak8ksvItTLMcc7mkB0/D9FMwvMvXCXwFYh1FJ6vjqUV5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583464; c=relaxed/simple;
	bh=3K2ie5NdZ04S5aKjaDNdkDTH3Ltu1X0/55T0Yza4qds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSkCt6Cas3X7wZ79s+uPAEyu/FqdkAVOPT4Q7m8bVoO+ykYBHmJGVa4svDvnUIYhb1HtKFw/KapBDfQ8YsjEOlXfax5VK394tHrhzG7hfNWbsv/hZyvbgevjK4iNrS3MclctaqpryvZZG6d33iqibDAB2R7GYKcnBftmIr6mOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G87M6Y+g; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D744132E3;
	Tue,  7 Apr 2026 10:37:32 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3837A3F7D8;
	Tue,  7 Apr 2026 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775583458; bh=3K2ie5NdZ04S5aKjaDNdkDTH3Ltu1X0/55T0Yza4qds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G87M6Y+gYhDzUMllohQnQ+3MzJz7GLiU7i5oO5C7QoOSYJQR1ygcMOTBhp+Xa7dT1
	 hKE9YT7k01mNLqUk3AgN6jyxMG7ud4ohKv1b9+WUvhZVAUAFNOdjaaVgIwyfWk5JW7
	 RljKoBhaoHV9AaXW3hRg20JMlaRC1npt6VcdXzew=
Date: Tue, 7 Apr 2026 18:37:34 +0100
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
Message-ID: <adVA3iyqzRr4FtSX@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com>
 <ac-W9oNM_O5RTtaf@arm.com>
 <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
 <adTPFrlVCEt-hioX@arm.com>
 <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com>
 <adTh8d9k3y5ybemL@arm.com>
 <b545e650-f84f-4911-9902-b914870f0e1d@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b545e650-f84f-4911-9902-b914870f0e1d@arm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233706-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 9C9503B276B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 02:06:10PM +0100, Ryan Roberts wrote:
> On 07/04/2026 11:52, Catalin Marinas wrote:
> > As the name implies, linear_map_requires_bbml2 tracks only this -
> > BBML2_NOABORT is required because the linear map uses large blocks.
> > Prior to your patches, that's only used as far as
> > linear_map_maybe_split_to_ptes() and if splitting took place, this
> > variable is no longer relevant (should be turned to false but since it's
> > not used, it doesn't matter).
> > 
> > With your patches, its use was extended to runtime and I think it
> > remains true even if linear_map_maybe_split_to_ptes() changed the block
> > mappings. Do we need this:
> 
> I'll admit it is ugly but it's not a bug; the system capabilitites are finalized
> by the time we call linear_map_maybe_split_to_ptes().
> 
> The "if (!linear_map_requires_bbml2 || is_kfence_address((void *)start))" check
> in split_kernel_leaf_mapping() would ideally be "if (!force_pte_mapping() ||
> is_kfence_address((void *)start))", but it is not safe to call
> force_pte_mapping() from a secondary cpu prior to finalizing the system caps.
> I'm reusing the flag that I already had available to work around that.

The confusing part is that the flag may be false incorrectly due to the
is_realm_world() evaluation. Nothing to do with this patch though and
the subject even mentions the rodata=full case. We should fix it
separately.

We could have set the flag to zero in linear_map_maybe_split_to_ptes(),
though split_kernel_leaf_mapping() already exits early due to the
!system_supports_bbml2_noabort() && system_capabilities_finalized(), so
not a correctness issue.

> But regardless, I think we are talking about the pre-existing
> is_real_world() bug, so I'm not personally planning to do anything further here
> unless you shout.

Not for this series. Steven or Suzuki should address the other problem
with is_realm_world().

-- 
Catalin

