Return-Path: <stable+bounces-100429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B69EB20F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374AB16B63B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342711AA1C6;
	Tue, 10 Dec 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VVRQH4iW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFoODN72"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D891A9B35
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838004; cv=none; b=uUXYK+Vhdl6wEaNl4imClTih2HKkzUQV5y40c5/xAUBuRewuTTRT/9emfMZI7Mtq2Uz8FCO3P0ri/yLuHrYFJC0c2dfoUOCLoQLhV33gfBNNYQsWyXxZgsRUd5ekO9fwKa6tSewjj+IYy53yGGM0QMccj83WfhsHqeyisVEtMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838004; c=relaxed/simple;
	bh=XYGc3SX+ZV41OTY5GSRvs3+PEfH/8C7Jrxh75o1C7io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj57So1Jv3Q23tp4R0aSmbm06WNr5oWG4zFtIrynOWSUo7ivnCFwzM9KDLsVlLnL3uxxeM+asVIRNwg+qHa12IB6LgHT/1TP+aNxDrJzvKDXJhCVAtSBwMjTmEJBMvcu1pV0ZQk7d6sSJKMnEluBDmaXq6lI0g9tP8i3fTgZGE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=VVRQH4iW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFoODN72; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D3EF1140122;
	Tue, 10 Dec 2024 08:40:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 10 Dec 2024 08:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733838000; x=1733924400; bh=DtzP8maEXQ
	E4GOx8kgb8UlN3Jkjm9c+8cJl1liWEviM=; b=VVRQH4iWrYrhaK6s3fhLPbzdjI
	4rabRBCsaR3/dHz0y4jpTVos0BJbM1rU/Q/Z3uc4JRWdzoKFoQ1FlBDfzcgAK8ZZ
	Gpc/Yv55hdJL0jm+hPzaQ3k6PEwr4iRoNw0g8jkcn8BYn3NzaAiysq0uf+ly9D9O
	r8Fm2bY1rbl9Dly/IE+V/uNEJC3eTS8zUPNVmE99akvbAtPw0IFA6Ndh76KF88wl
	wK+yq1sSJ+emcUwyD2QdHuSjzsbCLpCRsGeqql1kLBOKRVBMTRht/iGqDxg+gCyi
	+O/10Xi+u/jn3QNMY8Cpui0X61/2Kxvy/uDbKWLTKlm7yv4qzPBBsfKTttQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733838000; x=1733924400; bh=DtzP8maEXQE4GOx8kgb8UlN3Jkjm9c+8cJl
	1liWEviM=; b=TFoODN720RYkOGYdbuc8d0DhrLMSlaw4BahuBJYRDgWjXhvIhlS
	Ze+W1CiLAzALFhZY/wVwxFfiNI7MowNXkoImSxInrI6vBheQLKTNjVNNyk7xqOxv
	BHuNDpbg669ls5+xvryPYY/6qr8ZaRAWx+dfaBi293wrdAvuEGmHoZVw8cBx5CGO
	KLukBEkuqw9jwG05gMhzWEqe03yVmeLZSM1o98zhZ7SXjTi6V1Z246wsp3yeL97h
	02oEFUSkgXIOoXC4RzAcZPSp2FxVerY2dUXMN5OqQBohbCJIU9/RYC1JWxQXVw9D
	/7CACsSXehCEP1wdYvCsqyaQxmwJ8Dkfgcw==
X-ME-Sender: <xms:sERYZ9O7WT9S9_O3V-_QrqwwqVqSWXPycgYbj_dCBCSnUfdgpahEoA>
    <xme:sERYZ_-mbgDtDBfdxv2h-BQmB5W87MTVNNpvgOK1PksL3IzcUdgqrz0sa4mGc4nX5
    t-zBmY1ZigxdA>
X-ME-Received: <xmr:sERYZ8SMmqVcUWM-53jy9J9Me5e32I9K5aPq4qShwZ4Xy7Cyt7xPPSYBPaiqjlIJvhRoQI9yPTDCkAVe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleev
    tddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhosg
    hinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghpsghrrghhmhgrsehquh
    hitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghguhhpthgrphesqhhuihgtihhn
    tgdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sERYZ5tz2V7omjNKpCweaQnV4itDQLa2nNI4Bn4pAEvtZ9YVZeQ1QA>
    <xmx:sERYZ1c_m_kib-4CHLgX7hFeroAV7R_pEDtVlFOOdPRK73Q1UZCv5g>
    <xmx:sERYZ12-HBnTGf2-0mdVRciR62R-d-PgE56enueItMbsh6N3IYF2fw>
    <xmx:sERYZx8tnhrx_LknGNqFHES7FaokS0Up-crtXQfX3y2Ahnu9yLJnug>
    <xmx:sERYZ2VVvHo-yNI6kRn0Zx0jxXz2fOPB028qdL9erMrCxj8M5HL4NcnJ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 08:39:59 -0500 (EST)
Date: Tue, 10 Dec 2024 14:39:23 +0100
From: Greg KH <greg@kroah.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org, Pratyush Brahma <quic_pbrahma@quicinc.com>,
	Prakash Gupta <quic_guptap@quicinc.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.6.y] iommu/arm-smmu: Defer probe of clients after smmu
 device bound
Message-ID: <2024121015-reformist-ecology-005a@gregkh>
References: <acd8068372673fb881aa9e13531470669c985519.1733834302.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd8068372673fb881aa9e13531470669c985519.1733834302.git.robin.murphy@arm.com>

On Tue, Dec 10, 2024 at 12:42:16PM +0000, Robin Murphy wrote:
> From: Pratyush Brahma <quic_pbrahma@quicinc.com>
> 
> [ Upstream commit 229e6ee43d2a160a1592b83aad620d6027084aad ]
> 
> Null pointer dereference occurs due to a race between smmu
> driver probe and client driver probe, when of_dma_configure()
> for client is called after the iommu_device_register() for smmu driver
> probe has executed but before the driver_bound() for smmu driver
> has been called.
> 
> Following is how the race occurs:
> 
> T1:Smmu device probe		T2: Client device probe
> 
> really_probe()
> arm_smmu_device_probe()
> iommu_device_register()
> 					really_probe()
> 					platform_dma_configure()
> 					of_dma_configure()
> 					of_dma_configure_id()
> 					of_iommu_configure()
> 					iommu_probe_device()
> 					iommu_init_device()
> 					arm_smmu_probe_device()
> 					arm_smmu_get_by_fwnode()
> 						driver_find_device_by_fwnode()
> 						driver_find_device()
> 						next_device()
> 						klist_next()
> 						    /* null ptr
> 						       assigned to smmu */
> 					/* null ptr dereference
> 					   while smmu->streamid_mask */
> driver_bound()
> 	klist_add_tail()
> 
> When this null smmu pointer is dereferenced later in
> arm_smmu_probe_device, the device crashes.
> 
> Fix this by deferring the probe of the client device
> until the smmu device has bound to the arm smmu driver.
> 
> Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration support")
> Cc: stable@vger.kernel.org # 6.6
> Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
> Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
> Link: https://lore.kernel.org/r/20241004090428.2035-1-quic_pbrahma@quicinc.com
> [will: Add comment]
> Signed-off-by: Will Deacon <will@kernel.org>
> [rm: backport for context conflict prior to 6.8]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Now queued up, thanks.

greg k-h

