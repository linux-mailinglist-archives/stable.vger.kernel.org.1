Return-Path: <stable+bounces-235429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKdKI9TD12mdSQgAu9opvQ
	(envelope-from <stable+bounces-235429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:20:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 982513CC8A5
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7C7A300D766
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA93DCD81;
	Thu,  9 Apr 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SpeqoFZ7"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614333D88E4;
	Thu,  9 Apr 2026 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748013; cv=none; b=XjLjX5rJVaUiyeSezX9pJHY4C9QarqR3CtdbzPdstIgu/5hDm7fNhh2Amc+dW0wc4Yxmf/OBlLVGM9k8yPGBrEJD0Ta6eeax1SqhOwxTJbJGyXrsj7JWCwp/8UXCiV6djQrZOWOE7amYNEAiWEMC6Nld/utiVgmuGDbX1CPLfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748013; c=relaxed/simple;
	bh=KerjMnaZbfpIlkpvrXSliiJWrSFz9KRVNy8sm9UfXNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxFe8EgC6x1sgF7cv68HemxbnLcLh+QTo4wp+YjD5q5GEamFNL2VpsaUWVn+SS/fdiECojSf2YnR64C51nQH9tL67FxvwivNiVqTFgYG69iRGcrfMFCEa1OpXx0T7r7OQVPcEyyzGTBJ5iZXealfm9BQqYgl3nLCTg0edc8XYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SpeqoFZ7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B282C1E7D;
	Thu,  9 Apr 2026 08:20:04 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B63A33F632;
	Thu,  9 Apr 2026 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775748010; bh=KerjMnaZbfpIlkpvrXSliiJWrSFz9KRVNy8sm9UfXNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpeqoFZ70V9fK8ZbqkJX+IaOX6lOReIfZ5HI8HTLWt+OY0BTljBMQzT+Pe+cNm/rV
	 gE/q6NzUJ7ceBGS8P5POeS16bJlewubyPHxMBWKgfM6hQFxbrG3kfGRbtDyJDKFr8E
	 uKkPugUVopRi2ogCua++AfZf/JJg46wrGQVNLW2Q=
Date: Thu, 9 Apr 2026 16:20:01 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
Message-ID: <adfDoatH8hj6zN7_@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com>
 <ac-W9oNM_O5RTtaf@arm.com>
 <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
 <adTPFrlVCEt-hioX@arm.com>
 <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com>
 <adTh8d9k3y5ybemL@arm.com>
 <567dff89-9f0f-40a0-ab10-22e061b4faaf@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <567dff89-9f0f-40a0-ab10-22e061b4faaf@arm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235429-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 982513CC8A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 11:53:41AM +0200, Kevin Brodsky wrote:
> On 07/04/2026 12:52, Catalin Marinas wrote:
> >> if we have forced pte mapping then the value of
> >> can_set_direct_map() is irrelevant - we will never need to split because we are
> >> already pte-mapped.
> >
> > can_set_direct_map() is used in other places, so its value is
> > relevant, e.g. sys_memfd_secret() is rejected if this function returns
> > false.
> 
> Indeed, I have noticed this before: currently set_direct_map_*_noflush()
> and other functions will either fail or do nothing if none of the
> features (rodata=full, etc.) is enabled, even if we would be able to
> split the linear map using BBML2-noabort.

That's what I have been trying to say to Ryan ;), can_set_direct_map()
has different meanings depending on the caller: hint that it might split
or asking whether splitting is permitted. The latter is not captured.
Ignoring realms, if we have BBML2_NOABORT the kernel won't force pte
mappings under the assumption that split_kernel_leaf_mapping() is safe.
However set_direct_map_*_noflush() won't even reach the split function
because the "can" part says "no, you can't".

> What would make more sense to me is to enable the use of BBML2-noabort
> unconditionally if !force_pte_mapping(). We can then have
> can_set_direct_map() return true if we have BBML2-noabort, and we no
> longer need to check it in map_mem().

Indeed.

> This is a functional change that doesn't have anything to do with realms
> so it should probably be a separate series - happy to take care of it
> once the dust settles on the realm handling.

I think it can be done in parallel, it shouldn't interfere with realms.
The realm part should just affect force_pte_mapping() and
can_set_direct_map() should return just what's possible, not what may
need to set the direct map.

-- 
Catalin

