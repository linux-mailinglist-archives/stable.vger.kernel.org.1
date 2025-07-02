Return-Path: <stable+bounces-159218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16615AF1114
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CCC188E316
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611F02417E6;
	Wed,  2 Jul 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MUZfxUV0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgpgVrOF"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3F2A1AA
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450637; cv=none; b=EPIagKmshoJieZgNhZWDtp2DWXkeLlvV4fJ31HoL1l5xKO540zZtQwlDoWDuG1DM8lEHiFDxfubKYZfgz6xteWcbJFHag0nDQD/6qeq0YbiHAr72kWmVDbDWlpg/EjiayMV7+mORtCcitq4rIfBz8vnpNFZDnIK4eAiLMzqiuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450637; c=relaxed/simple;
	bh=WqagJWOWNJIIEDMtwz9Am5AUvnR8bcTmoyVURwHdewc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og/9KfuSC0Qvd4PONqLwkLUVkbUBstlmIzIpZ+XSfukTDOJP/6a+5LVFyTN30AU0oIHtsBH1vbbvF+uQRB2tUEy63RN/bJU9Uz8JaivYYJq97yHEuxHm8UOtJGLvCt14IWsuyqTM8NsIOzS0VaGQJgRGyrRLQGlQcl/kJEF8iD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=MUZfxUV0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgpgVrOF; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 4618A1D000A0;
	Wed,  2 Jul 2025 06:03:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 02 Jul 2025 06:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751450632; x=1751537032; bh=jC8CfuOvx/
	KNTmRSD/2VUFEIcrhVecMZ373ils6PjdY=; b=MUZfxUV05qJSbsvHxH44agNV1N
	/Sr+rtGKU/XuJeFU/tbfYGOz73TNvIFwWENRPwCtRvP9aMPnV5Xk3E0jwC6htdw6
	VQLfZQ7qpzsTalsjAohq444Hjio4+FS1aJjLTpjQc59xGs4yTkKW2oCi9qKZp1zR
	1rZesENqlRKGnxE/FG3JRsj3nFZ3Qbaelg715jGSEad4u9h1C91F7geq4FmhUTIe
	MJ1qTLlfNh4xvrjo/NakCKYSAM5dnQNYQSHrpm1Bb0Tc/mlM9p+EddZZmZz04ZsT
	BUd+JXCRVFfqhMsaHNYfuzsP73S0sMa6S4k8kRpbUbBnLAWFAkr8h6zBoTZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751450632; x=1751537032; bh=jC8CfuOvx/KNTmRSD/2VUFEIcrhVecMZ373
	ils6PjdY=; b=XgpgVrOFk1F3scYMo73du4ON0eriXMExWTILI2jWiyCe6H0x+c7
	Pu7CHZ9/00UanRwtQxpqXf78w/iYDIMZ5iqY4PQd/Ws/W5ng4ASm19kV2GrRJmXq
	ddWKAfzL/beAt8AvNrLH/ul2zaBrGqoCNP6B1crfSdOJITqWnfrfpmmwiekdrTEg
	BPiiedGN0qRctk/pKABJD9RKcO5NbqyWB0dE6+2wf/X+LMZfp4GhKJzjXA8Wsh/b
	NJmOdMg/UNUewTZO0aG1tHhapx/uwfqZAvtbkOcVW72J6IakIGKn/E8V/yZyY1vO
	GPo9Kxe0io9kaudulcDtsYsScq/Abhb8h6g==
X-ME-Sender: <xms:BgRlaG__XF9UgRsaN5qXk53fusQrwokINsA9tr-ysRqYdxKaDl-1Kg>
    <xme:BgRlaGuYYCx0bf134DIKLyb1rT7PmccuCwPydWrM3qe9vqIGGIWgebYEB30Vel0HU
    2qSHfcXF9dfuA>
X-ME-Received: <xmr:BgRlaMBfFfKoGCu_lYrEiEnsyL3FKVD-6KphStn7MepAuQCoPOOgu02IkXK0pEEzh-1d0BpLDamTz6nLxKC5QjvEEr2cgEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedutddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrjhgrnhhikhgrnhhthhgrsegvnh
    hgihhnvggvrhdrtghomhdprhgtphhtthhopehkvggvshesihhjiigvrhgsohhuthdrnhhl
    pdhrtghpthhtohepsggrohhluhdrlhhusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtg
    hpthhtohepjhhrohgvuggvlhesshhushgvrdguvgdprhgtphhtthhopehsthgrsghlvges
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BgRlaOewA1Hinfcv214xLKeMK8xO9DgzF3nu-5hg9yV4CgDLaIJxMA>
    <xmx:BgRlaLOguXKZWKwNwHzzgkx8gmgVOTw4YVV_xszigzpCgsiO6mqXAQ>
    <xmx:BgRlaInaVH_6DQouram8Z0DLd5wECogvjHR_mMzXyziW4y0xY7gOvg>
    <xmx:BgRlaNuzYSolAiHsnNG6BoL0ZJ1HNcEkmEng2VDnDTpx8FB8-ZDcTQ>
    <xmx:CARlaEvcJSCKmxNj9LC-7oYlFyElTDj5zRkKW8BqZeIwa8jeeNOSaGmc>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 06:03:49 -0400 (EDT)
Date: Wed, 2 Jul 2025 12:03:48 +0200
From: Greg KH <greg@kroah.com>
To: Rajani kantha <rajanikantha@engineer.com>
Cc: kees@ijzerbout.nl, baolu.lu@linux.intel.com, jroedel@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
Message-ID: <2025070233-unimpeded-reversion-ab61@gregkh>
References: <trinity-5b3af13a-3731-4b47-80a1-8ac7af67791f-1751424444098@3c-app-mailcom-lxa07>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-5b3af13a-3731-4b47-80a1-8ac7af67791f-1751424444098@3c-app-mailcom-lxa07>

On Wed, Jul 02, 2025 at 04:47:24AM +0200, Rajani kantha wrote:
> From: Kees Bakker <kees@ijzerbout.nl>
> 
> [ Upstream commit 60f030f7418d3f1d94f2fb207fe3080e1844630b ]
> 
> There is a WARN_ON_ONCE to catch an unlikely situation when
> domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
> happens we must avoid using a NULL pointer.
> 
> Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
> Link: https://lore.kernel.org/r/20241218201048.E544818E57E@bout3.ijzerbout.nl
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Rajani Kantha <rajanikantha@engineer.com>
> ---
>  drivers/iommu/intel/iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 56e9f125cda9..7c351274d004 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4306,13 +4306,14 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>                         break;
>                 }
>         }
> -       WARN_ON_ONCE(!dev_pasid);
>         spin_unlock_irqrestore(&dmar_domain->lock, flags);
> 
>         cache_tag_unassign_domain(dmar_domain, dev, pasid);
>         domain_detach_iommu(dmar_domain, iommu);
> -       intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
> -       kfree(dev_pasid);
> +       if (!WARN_ON_ONCE(!dev_pasid)) {
> +               intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
> +               kfree(dev_pasid);
> +       }
>         intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>         intel_drain_pasid_prq(dev, pasid);
>  }
> --
> 2.34.1
> 

Does not apply to the 6.12.y branch at all, what was this made against?

thanks,

greg k-h

