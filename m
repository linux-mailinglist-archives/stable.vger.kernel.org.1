Return-Path: <stable+bounces-230146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJDCBTt5wmnqdAQAu9opvQ
	(envelope-from <stable+bounces-230146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:44:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9864307809
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA5DC3052FA5
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403A3EF0C9;
	Tue, 24 Mar 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sb08j1DU"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ABA3ECBE1;
	Tue, 24 Mar 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352420; cv=none; b=XICO4yihRIDVqHV8KFHv6S/a5PEcuRWXx72rjnD5Ze+HGJl6nO+GAbKuDFictwAH9Jt0fK/mU+lL1JL6u2gs5CCZHS1X2IvvOjHybmd9l8MzZyQ7+/COBQUhF8Xzh7anOlNvqMUsO8vdZYOB2HBPHcvf3MIUO9RqbCkOnWqjDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352420; c=relaxed/simple;
	bh=t5cmH5k66x4vyuWZdylInzIFhVjZz3G/EcBlvfb5IkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1fuxiwTPPTzqOognpjyOvH5y69vQB9zmAPWFTO+5/3lkHFnINBT7++adtI6+XsXJHmIeizD0hE26c1CzHKx9HZw3DhRtawgSL91s/gfQUuohQecnjILvK7rbPfc6DJJZoMLa+F8aM1p/IIzOJoKBuVMFOYSKOcZ/Msr9doAyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sb08j1DU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1FC21477;
	Tue, 24 Mar 2026 04:40:08 -0700 (PDT)
Received: from [10.57.76.67] (unknown [10.57.76.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7165F3FE14;
	Tue, 24 Mar 2026 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774352414; bh=t5cmH5k66x4vyuWZdylInzIFhVjZz3G/EcBlvfb5IkI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sb08j1DUqE3iHoUeZIzDlyRRn9uO1/zkckxkSz04us34juigVSoX6nO+nH39zMQfZ
	 L2TjOy/FMkLRxvc9+wLYoOW3sHJVjObO4dB03CVVShhAHlQhW1n12++7DhextAb0vI
	 LnfjazUCiMfsR/Xzt9D1Epg0EuwoGuso6qR2tpAI=
Message-ID: <13510f0d-fa8e-4094-af45-aeef59b128b3@arm.com>
Date: Tue, 24 Mar 2026 11:40:09 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 peter.griffin@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com,
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TAGGED_FROM(0.00)[bounces-230146-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A9864307809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-23 1:09 pm, Tudor Ambarus wrote:
> Commit da33e87bd2bf ("iommu: Handle yet another race around
> registration") introduced a readiness check in `iommu_fwspec_init()` to
> prevent client drivers from configuring their IOMMUs before
> `bus_iommu_probe()` has completed.
> 
> To optimize the replay path, the readiness check was conditionally
> gated behind `!dev->iommu`:
>      if (!dev->iommu && !READ_ONCE(iommu->ready))
>          return -EPROBE_DEFER;
> 
> However, this assumption breaks down for devices that map to multiple
> IOMMU instances. During the initialization loop over multiple IOMMUs in
> `of_iommu_configure_device()`, the first IOMMU successfully allocates
> `dev->iommu`. When `iommu_fwspec_init()` is called for the second
> IOMMU, `!dev->iommu` evaluates to false, short-circuiting the logic and
> entirely bypassing the `iommu->ready` check.
> 
> If the second IOMMU is still executing its `bus_iommu_probe()`
> concurrently, this allows the client driver to proceed prematurely,
> resulting in a late IOMMU probe warning:
>      dev: late IOMMU probe at driver bind, something fishy here!
>      WARNING: drivers/iommu/iommu.c:645 at __iommu_probe_device
> 
> Fix this by making the `iommu->ready` check unconditional, ensuring
> that a device will defer its probe until *all* of its required IOMMUs
> are fully registered and ready.

...which is obviously wrong, since the whole point is that we *do* want 
of_iommu_xlate() to succeed in the bus_iommu_probe() path before the 
IOMMU driver has finished registering, because that's how we get probe 
to actually happen correctly in the expected order. This change would 
effectively undo the whole thing, except leaving ACPI systems without 
IOMMU functionality at all - it'll only be sort-of-working for you 
because DT still has the sketchy iommu_probe_device() replay in the 
driver bind path.

Honestly we just need to get rid of that replay call, which is the root 
of almost all of the problems, but I don't know what to do about all the 
remaining of_dma_configure() abusers that are relying on it... :(

Thanks,
Robin.

> Cc: stable@vger.kernel.org
> Fixes: da33e87bd2bf ("iommu: Handle yet another race around registration")
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> The warning was observed using an Android 6.19 tree, using downstream
> drivers (exynos-decon and samsung-sysmmu-v9).
> ---
>   drivers/iommu/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 78756c3f3c40..e61927b4d41f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3042,7 +3042,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
>   
>   	if (!iommu)
>   		return driver_deferred_probe_check_state(dev);
> -	if (!dev->iommu && !READ_ONCE(iommu->ready))
> +	if (!READ_ONCE(iommu->ready))
>   		return -EPROBE_DEFER;
>   
>   	if (fwspec)
> 
> ---
> base-commit: ca3bbc9287400c1274d87ee57a16e3126ba2969a
> change-id: 20260320-iommu-ready-check-4976863957c2
> 
> Best regards,


