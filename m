Return-Path: <stable+bounces-210688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KECSFIJjcGkVXwAAu9opvQ
	(envelope-from <stable+bounces-210688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:26:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11302517E7
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CF3B3A73BF
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5183C196E;
	Wed, 21 Jan 2026 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h55vB+Ep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1C3AE6F7;
	Wed, 21 Jan 2026 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973178; cv=none; b=mGvSnFHm90Zspkm6mXsnW4A7Ln3nKvfUOwj+8ozD8OAf5TGz0eEN7XMI0uoq1jlBLOTtoNdFEwAvp0/8kUxx+dmgYh1S2wEumhEZ4E3Hvf/K2Vvm/olrDUMaNgqAvcbMIFpaTwvjrmIVjMbdx3S5ScV4Qt4SUHq/g8rUtdNhINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973178; c=relaxed/simple;
	bh=RDkIzU1M1GBUXwDEehGXspAVBhm6BfIX4T89ZMX1nb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WD1u+GhP0oeTRfi0KiHLERbZArAcUKicI7U/0pOO9vOdD46aixmAZbgSqJAF+enA2H521N8taDpaMbuExqvj1rHydtgpC60+rCkuxOc2k+Vi9WuQRmkVAPp+peDnj6sZqartmSRKkLFCXIeOTdusy7S/ikjSowmh0uiUBjLPhxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h55vB+Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AC6C116D0;
	Wed, 21 Jan 2026 05:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768973177;
	bh=RDkIzU1M1GBUXwDEehGXspAVBhm6BfIX4T89ZMX1nb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h55vB+Epr+eJT5v0DdOeqotnGiueC8jmHAlr+A3mLZXuTIpBxaaRoYN0MLQqHroIe
	 24vON2zNIlaYqRMr0O0kYDPbgvfY27eMyEev5vGwFieTtbfu2H5iFRc6MW9XZ7G/7Y
	 hUkiGvjZxsu69XwX390bVcbBhBOA0Z9lxQFrunOiY3bfYgg2JGZsbpKherUb7VEb0I
	 4KsVH3jttxI4CqRypmpCL3+hmkiRG01Eh30JvCsd22KdO+AxaIDw7gjtRmztd93+D7
	 soev5ydrVTK3XdFB8wY/OhLX/RJxHuANaa03u8PGz0KPn46nKHdwJa8Her2m2uawPr
	 duoJi2mkqTvng==
Message-ID: <c51ed4bf-ec2a-45f1-a077-8e2236076827@kernel.org>
Date: Tue, 20 Jan 2026 23:26:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IOMMU regression in linux-6.18.y
To: Mario Limonciello <mario.limonciello@amd.com>,
 regressions <regressions@lists.linux.dev>, stable@vger.kernel.org
Cc: iommu@lists.linux.dev, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 "Hou, Lizhi" <lizhi.hou@amd.com>
References: <870872aa-28e9-412a-bac6-8020bf560e4f@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <870872aa-28e9-412a-bac6-8020bf560e4f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-210688-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 11302517E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/20/26 8:08 PM, Mario Limonciello wrote:
> Hi,
> 
> Recently I found out that amdxdna stopped working in linux-6.18.4.  This 
> is because of this commit in linux-6.18.y:
> 
> commit c341dee80b5d ("iommu: disable SVA when CONFIG_X86 is set")
> 
> That was originally backported from upstream:
> 
> commit 72f98ef9a4be ("iommu: disable SVA when CONFIG_X86 is set")
> 
> ---
> 
> SVA support is a requirement for amdxdna.
> 
> The series that this commit came from was part of a larger 8 patch 
> series, but this was the only commit that was CC'ed to stable.
> 
> As a result this is not broken in 6.19-rc, but it is broken in 
> linux-6.18.y (and presumably any older stable kernels still around that 
> picked it up).
> 
> So there are two options I see:
> 
> 1) Revert c341dee80b5d in linux-6.18.y (and any other stable kernel that 
> picked it up but has amdxdna)
> 
> 2) Bring the entire 8 patch series to linux-6.18.y.
> 
> This is the entire series (I didn't look up the hashes from mainline, 
> but they should have all landed):
> https://lore.kernel.org/linux-iommu/20251022082635.2462433-1- 
> baolu.lu@linux.intel.com/
> 
> What should we do?
> 

If the decision is to take the remaining commits to 6.18.y to fix this I 
did confirm they cleanly cherry pick and build.  Here are the hashes.

commit 27bfafac65d8 ("mm: add a ptdesc flag to mark kernel page tables")
commit 977870522af3 ("mm: actually mark kernel page table pages")
commit 412d000346ea ("x86/mm: use 'ptdesc' when freeing PMD pages")
commit 018942956723 ("mm: introduce pure page table freeing function")
commit bf9e4e30f353 ("x86/mm: use pagetable_free()")
commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page 
tables")
commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for 
kernel address space")

