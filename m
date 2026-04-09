Return-Path: <stable+bounces-235367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHDDHzZ312nTOAgAu9opvQ
	(envelope-from <stable+bounces-235367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 11:53:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BAD3C8BE6
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 11:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 000A6300E5CD
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D53B6376;
	Thu,  9 Apr 2026 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ppy4nXOS"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E83B52EB;
	Thu,  9 Apr 2026 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728430; cv=none; b=UeZD34V1WR+rVgmYpY/fWcrEjIPtLJIurtjyxQNsAFh2k+f/UVsOiwEJEfP0WL9r3Q77RuXQhEJL/jM8p8pj4WVvQrVdvoHWdVQKNc4MnfRFstuO0shx1Kyvbj95z/7K0L9itO8FLWo10cAJT3e5oU0V2q0AnzXTWedAsCGAHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728430; c=relaxed/simple;
	bh=QhV34Pc+pkOLI+WwjcRnm/3IpWJhftPzSFRTNKk0g4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9hcAWpTRgZhMqAoIg3i0hXb8n2Gw/82NdH7sHYExGw+ZgwHej/azGj5wTxb+ONmAEKIWzK8ZwmIqELwskcJ8V08+w9Jlc9gLKmEBCWESfxfWv9TsTpmQXsF7CkDSP4vROgq4DmmDU9SiuuAIm58J1ybE66S9usJ7eRPlpnWY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ppy4nXOS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 001883297;
	Thu,  9 Apr 2026 02:53:42 -0700 (PDT)
Received: from [10.43.18.23] (e126510-lin.lund.arm.com [10.43.18.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD0913F641;
	Thu,  9 Apr 2026 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775728427; bh=QhV34Pc+pkOLI+WwjcRnm/3IpWJhftPzSFRTNKk0g4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ppy4nXOSL+Svl8Wj1/y+NNtzd/8t4TDG3CiO9YiESM4YRZoLvAgT0Z/WX4+mMvgbY
	 YUrbFqOsE4ObqBqYgXid652Muy2bAbRU7OPwUPhpXk9JEHYayM63jMVRp1ALbhe4lW
	 DZXIJcvLOX/9RibKmZN/7akNpnkNknwodP2aPbCU=
Message-ID: <567dff89-9f0f-40a0-ab10-22e061b4faaf@arm.com>
Date: Thu, 9 Apr 2026 11:53:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
To: Catalin Marinas <catalin.marinas@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com> <ac7VD4Z85nS30GCp@arm.com>
 <ac-W9oNM_O5RTtaf@arm.com> <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
 <adTPFrlVCEt-hioX@arm.com> <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com>
 <adTh8d9k3y5ybemL@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <adTh8d9k3y5ybemL@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235367-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.brodsky@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 17BAD3C8BE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 07/04/2026 12:52, Catalin Marinas wrote:
>> if we have forced pte mapping then the value of
>> can_set_direct_map() is irrelevant - we will never need to split because we are
>> already pte-mapped.
> can_set_direct_map() is used in other places, so its value is
> relevant, e.g. sys_memfd_secret() is rejected if this function returns
> false.

Indeed, I have noticed this before: currently set_direct_map_*_noflush()
and other functions will either fail or do nothing if none of the
features (rodata=full, etc.) is enabled, even if we would be able to
split the linear map using BBML2-noabort.

What would make more sense to me is to enable the use of BBML2-noabort
unconditionally if !force_pte_mapping(). We can then have
can_set_direct_map() return true if we have BBML2-noabort, and we no
longer need to check it in map_mem().

This is a functional change that doesn't have anything to do with realms
so it should probably be a separate series - happy to take care of it
once the dust settles on the realm handling.

- Kevin

