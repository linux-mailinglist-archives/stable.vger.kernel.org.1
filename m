Return-Path: <stable+bounces-229204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFs6HohawWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:21:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 193852F62F4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1EC830A029F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF643B6340;
	Mon, 23 Mar 2026 15:06:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0F275AEB;
	Mon, 23 Mar 2026 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278386; cv=none; b=hWw42vg1MAas75SpmNZdOLJNqb5kOIewCemDY5IRrOyoIA4ozun5avRmLZzbNPhYRvrtceiN2tKvsLQzS/1NmK0AgZU2WOP0/JMIVMTdUO3u0n9FMLJvPRw5CWiJTNAtR7Pv7vr27+6tJ1ziwo15TJK335p/TimLd8oumeKzmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278386; c=relaxed/simple;
	bh=d6fUVUXOyQ0Ynmvf06L27JKrW5C3q6p3P5UYEYPuncQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qx6v/DvuH0Jekw9w2EX1siPAHVZtN30GqQPWO4y4IH2uWQQYuqZoCckjWgcaBimblvoEkGYd0Ym0yoVOx5PRlG9gi0vKu58x6adlrARJ9kNEo6AJE3kDMvXsZw6UvEXIBVfqqy1HLXqenvs4t2Iu0X4+khk3YpFEoLXIvli5k3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 411E614BF;
	Mon, 23 Mar 2026 08:06:18 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E98B03F694;
	Mon, 23 Mar 2026 08:06:22 -0700 (PDT)
Message-ID: <fad11c37-5bfb-44fd-b0bf-2a2d15b3382c@arm.com>
Date: Mon, 23 Mar 2026 15:06:16 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU for
 OF platforms"
To: Manivannan Sadhasivam <mani@kernel.org>,
 John Hancock <john@kernel.doghat.io>
Cc: stable@vger.kernel.org, bhelgaas@google.com,
 manivannan.sadhasivam@oss.qualcomm.com, joro@8bytes.org,
 linux-pci@vger.kernel.org, iommu@lists.linux.dev
References: <20260320172335.29778-1-john@kernel.doghat.io>
 <o7nnlvtkmatzafs44um6h5wnqo755msiukfn6kbu2zxdhe45ws@mde5lt2ufusz>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <o7nnlvtkmatzafs44um6h5wnqo755msiukfn6kbu2zxdhe45ws@mde5lt2ufusz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-229204-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 193852F62F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 1:54 pm, Manivannan Sadhasivam wrote:
> + Robin
> 
> On Fri, Mar 20, 2026 at 01:23:35PM -0400, John Hancock wrote:
>> Commit 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF
>> platforms") introduced a regression affecting AMD IOMMU group isolation
>> on x86 systems, making PCIe passthrough non-functional.
>>
>> While the commit addresses a legitimate ordering issue on OF/Device Tree
>> platforms, the fix modifies pci_dma_configure(), which executes on all
>> platforms regardless of firmware interface. On AMD systems with IOMMU,
>> moving pci_enable_acs() from pci_acs_init() to pci_dma_configure() alters
>> the point at which ACS is evaluated relative to IOMMU group assignment.
>> The result is that devices which previously occupied individual, exclusive
>> IOMMU groups are merged into a single group containing both passthrough
>> and non-passthrough members, violating IOMMU isolation requirements.
>>
> 
> Ouch! Sorry for the breakage.
> 
>> The commit author notes that pci_enable_acs() is now called twice per
>> device and that this is "presumably not an issue." On AMD IOMMU hardware
>> this assumption does not hold -- the change in call ordering has
>> observable and breaking consequences for group topology.
>>
>> It is worth noting that this is a stable/LTS series (6.12.y), where
>> changes to fundamental PCI initialization ordering carry significant
>> risk for production and specialized workloads that depend on stable
>> IOMMU behavior across kernel updates. A regression of this nature --
>> silently breaking PCIe passthrough without any configuration change on
>> the part of the user -- is particularly disruptive in a series that
>> users reasonably expect to be conservative.
>>
> 
> I still haven't investigated this failure deeply, but it is also worth noting
> that this regression only happens with v6.12 and earlier stable kernels as
> mentioned in [1].

Oops, indeed, relying on pci_dma_configure() to be called prior to group 
assignment in iommu_init_device() only works since bcb81ac6ae3c ("iommu: 
Get DT/ACPI parsing into the proper probe path") added that call path in 
6.15 - thus the backport probably doesn't actually work for OF platforms 
either.

Dropping this from 6.12.y and earlier stable branches seems like the 
correct action to me (but not a mainline revert, obviously). ACS had 
essentially *never* worked properly on OF platforms prior to 6.15, but 
that was more down to fundamental design flaws in the OF-based IOMMU 
probe path (dating back to 4.12) rather than any easily-fixable bug as 
such, so realistically I think we just leave it that way.

Thanks,
Robin.

>> This revert restores pci_enable_acs() to pci_acs_init() and marks it
>> static again, fully restoring correct IOMMU group topology on affected
>> hardware.
>>
>> Regression introduced in: 6.12.75
>> Tested on: 6.12.77 with this revert applied
>>
>> Hardware:
>>    CPU:   AMD Ryzen Threadripper 2990WX (family 23h, Zen+)
>>    IOMMU: AMD-Vi
>>
>> Bisect:
>>    6.12.74: GOOD -- IOMMU groups correct, passthrough functional
>>    6.12.75: BAD  -- IOMMU groups collapsed, passthrough broken
>>    6.12.76: BAD  -- still broken
>>    6.12.77: BAD  -- still broken
>>
>> Fixes: 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF platforms")
>> Signed-off-by: John Hancock <john@kernel.doghat.io>
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> - Mani
> 
> [1] https://lore.kernel.org/all/2c30f181-ffc6-4d63-a64e-763cf4528f48@leemhuis.info/
> 


