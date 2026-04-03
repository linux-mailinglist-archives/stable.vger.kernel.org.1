Return-Path: <stable+bounces-233171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL9THo+Xz2nmxQYAu9opvQ
	(envelope-from <stable+bounces-233171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:33:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF54393539
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE5C330447A9
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503673AC0E9;
	Fri,  3 Apr 2026 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Em5QGKqF"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AEB3AC0F4;
	Fri,  3 Apr 2026 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212291; cv=none; b=BX6mSs5FSxCnG2zzLPur6eHifJu+nxrD8RJNJO+eAaiNtuMjqE13DI+osNc1izm9Lp4rrBh1FvFNSHVxnNb91nAC3hF1A1cfw2wMGIEfwu6sR9kYOS2H8PlINyelkocTa47SXpQzS+PEPpqduOSZ7keWH7FFjHEXQtHefAve7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212291; c=relaxed/simple;
	bh=RFoHuYAOuSg8suqDOc5oy+GI9ugNPsS9Z9CDnsI79wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lo8ZC+12tHgia1FHgYrKZxertDxtoHUCEBzgf0eCZ0GWakB5+CezmpAKoCGouKnhQkYEkUR+e6UsHvslLHURHqPX+kn+5XwzzyJHmYxM87tdYFqfPQS+B5vvuRTyinABCp6vV5TDF3wYv5KbrPP2fogFNLs5UQZWWGuBPxQA7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Em5QGKqF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3083415A1;
	Fri,  3 Apr 2026 03:31:16 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994913F915;
	Fri,  3 Apr 2026 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775212282; bh=RFoHuYAOuSg8suqDOc5oy+GI9ugNPsS9Z9CDnsI79wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Em5QGKqFHxDxjoGmHrGqLTSRM5oX4iEti0dkapei8+pk30T6omUACran4A6p5K931
	 uSUuqjuxG+jgQW+FizNyMe6J0oQQ/G+AOb1auXzRffHdvaDS0WszgL20qQdjkuLV4N
	 TGM9wXEMan6QRSPvpjslWYECQLeAOak6XlEbIg4o=
Date: Fri, 3 Apr 2026 11:31:18 +0100
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
Message-ID: <ac-W9oNM_O5RTtaf@arm.com>
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7VD4Z85nS30GCp@arm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233171-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EF54393539
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:43:59PM +0100, Catalin Marinas wrote:
> Another thing I couldn't get my head around - IIUC is_realm_world()
> won't return true for map_mem() yet (if in a realm). Can we have realms
> on hardware that does not support BBML2_NOABORT? We may not have
> configuration with rodata_full set (it should be complementary to realm
> support).

With rodata_full==false, can_set_direct_map() returns false initially
but after arm64_rsi_init() it starts returning true if is_realm_world().
The side-effect is that map_mem() goes for block mappings and
linear_map_requires_bbml2 set to false. Later on,
linear_map_maybe_split_to_ptes() will skip the splitting.

Unless I'm missing something, is_realm_world() calls in
force_pte_mapping() and can_set_direct_map() are useless. I'd remove
them and either require BBML2_NOABORT with CCA or get the user to force
rodata_full when running in realms. Or move arm64_rsi_init() even
earlier?

-- 
Catalin

