Return-Path: <stable+bounces-104469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F09F490F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 11:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CB41882B1B
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140391E282D;
	Tue, 17 Dec 2024 10:41:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C81E22FB
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432067; cv=none; b=PERPTd4jPYsw30g/vEj3Sq9vybMIjyTSk2+XZ1c7aJWhD07YWwe9yZozkNWdXLss12kY+xy5U1JKtrlqaLYnVjn3c4V7pihg81SSTYKk2UfixslUHd9Csdhj/DepkKHS9c1C04nqoXM99jpHSHgCuKtLd3Cb3oWwf/+7G0pZE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432067; c=relaxed/simple;
	bh=aAycJgXnOkrXr7gy855/I4y532oL0myxx9xjae+yWvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bms4NLlRBG9Hn59P6Z0al9htHRIff8HKiGs7wK+H57OcBLt9I+ZxJFTmdjJyKYyey9JeJH5l9gux9MC0xANEcM3FEwXGEozQCEQbuMXhA76LitkniRRzvOxcHusjseQKI62QRZvMmOynt/ldRUO8GUrKRS/oQg0RYLi2DzMVm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 608111007;
	Tue, 17 Dec 2024 02:41:33 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FD993F528;
	Tue, 17 Dec 2024 02:41:03 -0800 (PST)
Date: Tue, 17 Dec 2024 10:40:58 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, gshan@redhat.com, james.morse@arm.com,
	maz@kernel.org, oliver.upton@linux.dev,
	shameerali.kolothum.thodi@huawei.com, vt@altlinux.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Jing Zhang <jingzhangos@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.6 v1] KVM: arm64: Disable MPAM visibility by default
 and ignore VMM writes
Message-ID: <20241217104058.GA2151333@e124191.cambridge.arm.com>
References: <20241212151406.1436382-1-joey.gouly@arm.com>
 <2024121528-refurbish-plausibly-31c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121528-refurbish-plausibly-31c7@gregkh>

On Sun, Dec 15, 2024 at 10:22:53AM +0100, Greg KH wrote:
> On Thu, Dec 12, 2024 at 03:14:06PM +0000, Joey Gouly wrote:
> > From: James Morse <james.morse@arm.com>
> > 
> > commit 6685f5d572c22e1003e7c0d089afe1c64340ab1f upstream.
> > 
> > commit 011e5f5bf529f ("arm64/cpufeature: Add remaining feature bits in
> > ID_AA64PFR0 register") exposed the MPAM field of AA64PFR0_EL1 to guests,
> > but didn't add trap handling. A previous patch supplied the missing trap
> > handling.
> > 
> > Existing VMs that have the MPAM field of ID_AA64PFR0_EL1 set need to
> > be migratable, but there is little point enabling the MPAM CPU
> > interface on new VMs until there is something a guest can do with it.
> > 
> > Clear the MPAM field from the guest's ID_AA64PFR0_EL1 and on hardware
> > that supports MPAM, politely ignore the VMMs attempts to set this bit.
> > 
> > Guests exposed to this bug have the sanitised value of the MPAM field,
> > so only the correct value needs to be ignored. This means the field
> > can continue to be used to block migration to incompatible hardware
> > (between MPAM=1 and MPAM=5), and the VMM can't rely on the field
> > being ignored.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Co-developed-by: Joey Gouly <joey.gouly@arm.com>
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Reviewed-by: Marc Zyngier <maz@kernel.org>
> > Link: https://lore.kernel.org/r/20241030160317.2528209-7-joey.gouly@arm.com
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > [ joey: fixed up merge conflict, no ID_FILTERED macro in 6.6 ]
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: stable@vger.kernel.org # 6.6.x
> > Cc: Vitaly Chikunov <vt@altlinux.org>
> > Link: https://lore.kernel.org/linux-arm-kernel/20241202045830.e4yy3nkvxtzaybxk@altlinux.org/
> > ---
> > 
> > This fixes an issue seen when using KVM with a 6.6 host kernel, and
> > newer (6.13+) kernels in the guest.
> > 
> > Tested with a stripped down version of set_id_regs from the original
> > patch series.
> 
> What about 6.12.y?  You can't just skip a stable tree, otherwise you
> will get a regression when you upgrade to 6.12.y, right?

I did have it ported/tested locally, but I wasn't sure of the stable process,
so just sent out one!  Next time I will send all the backports at the same
time.

Thanks Marc Z for sending it out!

Joey

