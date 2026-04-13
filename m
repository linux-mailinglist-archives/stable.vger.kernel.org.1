Return-Path: <stable+bounces-236001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAdrNvrX3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-236001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:48:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 692883EB7D0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A35F300A51C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31D31AF1B;
	Mon, 13 Apr 2026 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YaWnVFBr"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA743241690;
	Mon, 13 Apr 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080886; cv=none; b=A/RfjnSBy49Cag7kkthE5REmwLftysW4TY2eO6TwZF8Grm9ffnfRSz3a/VtXICAKbt0caoIP6thGqkmVmld+ZlUEhtC2W0yc74n3ns1kbsvGPIlt5zms6c/hABvBMjYoGd7Gb/hIgZKSjzvQO6IDRdAyyqD8jItgK1ejI3+K33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080886; c=relaxed/simple;
	bh=evhBVSjuTjhT8AZO7ALqiR4oNX8BYOQjZt5OTWr3Ezw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8ou/i/yMdLLyZU80qYkFTacADnH8VsFF8ISQI3artON50lUk/Zy9WT7PQkWvQ4BKNTD/NMboRfWLr2vdEJeZChNJnVn6gami/VU7p9zMMLThznrGrCXjlKE80zMcLVYjBg23+y/+jG4Bcp7e0W5eEGNusozOoKBJOJ10SSts2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YaWnVFBr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56251357A;
	Mon, 13 Apr 2026 04:47:58 -0700 (PDT)
Received: from [10.57.62.88] (unknown [10.57.62.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B053F93E;
	Mon, 13 Apr 2026 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776080884; bh=evhBVSjuTjhT8AZO7ALqiR4oNX8BYOQjZt5OTWr3Ezw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YaWnVFBrwC0Eg04p77bwiv1keGMJvUXOueR4q8XLZcsWqZXhBry1x/GeYZa16HucH
	 zhSFjRx9tRhig59WdPy5jvMsxPmGXxymsq9WK5jH4c4NMDp9yVkSTou4Ay4RS+L85m
	 lDGalKbe2j/0CSWqrscuyR92t3mwl1Cqe7Czc9Zc=
Message-ID: <9e47d3a9-e1ae-480b-a202-54d9d72479a2@arm.com>
Date: Mon, 13 Apr 2026 13:47:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260330161705.3349825-2-ryan.roberts@arm.com>
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
	TAGGED_FROM(0.00)[bounces-236001-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 692883EB7D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30/03/2026 18:17, Ryan Roberts wrote:
> +bool page_alloc_available __ro_after_init;
> +
> +void __init mem_init(void)
> +{
> + page_alloc_available = true;

I knew I had seen a simpler solution to this: vmemmap_alloc_block() uses
slab_is_available() to tell whether the buddy allocator is available.
AFAICT this becomes true somewhere in kmem_cache_init(), which is called
just after mem_init(). Probably good enough for our purpose?

- Kevin

> + swiotlb_update_mem_attributes();
> +}

