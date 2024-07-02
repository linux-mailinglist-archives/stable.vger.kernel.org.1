Return-Path: <stable+bounces-56340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D314923B9F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7FE284FD2
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A142158DAA;
	Tue,  2 Jul 2024 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CoARCZ6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF42154449
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916898; cv=none; b=mzvNATHhtRBVsUjABOb96gUnHLoHj944vjcmyldvXGlka4MK0GSP6lWwgZIherY4rh5/AxMw3Q9ZPnEzbB5TJhrXa3TJziE3995k0bhmkw89WR1CIBl+X1VzbVdY6IlYdYl2rv8nedXM2vaIaMPBtzWIDYRx5ppK89tP7VGMVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916898; c=relaxed/simple;
	bh=MyxhLr3/QJ6nKRPyKPEpJpS9XP/kgkhJwci8YmT6yyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHhtL6rjUdDohymPjTmbobULZ8RALYlhV94eXvMKcmDM5RT97LM4MtP6ActQbZ9DeY2OsmyXJIBveFQZK5qoXVx23bZc4wgVcaqmw18iKeUH/I4gdYvjJ56N2wULHjbJUn1943i0HA0JFQkv7Lux4eN8EbDNc4uOJRU6QipMHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CoARCZ6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E954BC116B1;
	Tue,  2 Jul 2024 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719916897;
	bh=MyxhLr3/QJ6nKRPyKPEpJpS9XP/kgkhJwci8YmT6yyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CoARCZ6Qvp17PVutP+YAjnijI2cC+a0tud7Y+NJci9dMFaurEpl4bosLslklFTi5t
	 B35E5C6BgYBEMDl4L7/mYD91XxWh89SbZJPyBbqoFuevDXY3rDjSstXOGBuCkTKLgs
	 bhztlBpOiV3/VniXN2d+wvyMCHpae/397MhtkqKc=
Date: Tue, 2 Jul 2024 12:41:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: James Gowans <jgowans@amazon.com>
Cc: stable@vger.kernel.org, chenxiang66@hisilicon.com, maz@kernel.org,
	oliver.upton@linux.dev, yuzenghui@huawei.com, sironi@amazon.de
Subject: Re: [PATCH 5.15.y] KVM: arm64: vgic-v4: Make the doorbell request
 robust w.r.t preemption
Message-ID: <2024070221-lurch-implode-229f@gregkh>
References: <2023072323-trident-unturned-7999@gregkh>
 <20240701111933.41973-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701111933.41973-1-jgowans@amazon.com>

On Mon, Jul 01, 2024 at 01:19:33PM +0200, James Gowans wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> Xiang reports that VMs occasionally fail to boot on GICv4.1 systems when
> running a preemptible kernel, as it is possible that a vCPU is blocked
> without requesting a doorbell interrupt.
> 
> The issue is that any preemption that occurs between vgic_v4_put() and
> schedule() on the block path will mark the vPE as nonresident and *not*
> request a doorbell irq. This occurs because when the vcpu thread is
> resumed on its way to block, vcpu_load() will make the vPE resident
> again. Once the vcpu actually blocks, we don't request a doorbell
> anymore, and the vcpu won't be woken up on interrupt delivery.
> 
> Fix it by tracking that we're entering WFI, and key the doorbell
> request on that flag. This allows us not to make the vPE resident
> when going through a preempt/schedule cycle, meaning we don't lose
> any state.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8e01d9a396e6 ("KVM: arm64: vgic-v4: Move the GICv4 residency flow to be driven by vcpu_load/put")
> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
> Suggested-by: Zenghui Yu <yuzenghui@huawei.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Acked-by: Zenghui Yu <yuzenghui@huawei.com>
> Link: https://lore.kernel.org/r/20230713070657.3873244-1-maz@kernel.org
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> 
> (cherry picked from commit b321c31c9b7b309dcde5e8854b741c8e6a9a05f0)
> 
> [modified to wrangle the vCPU flags directly instead of going through
> the flag helper macros as they have not yet been introduced. Also doing
> the flag wranging in the kvm_arch_vcpu_{un}blocking() hooks as the
> introduction of kvm_vcpu_wfi has not yet happened. See:
> 6109c5a6ab7f ("KVM: arm64: Move vGIC v4 handling for WFI out arch callback hook")]
> 
> Signed-off-by: James Gowans <jgowans@amazon.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 1 +
>  arch/arm64/kvm/arm.c              | 6 ++++--
>  arch/arm64/kvm/vgic/vgic-v3.c     | 2 +-
>  arch/arm64/kvm/vgic/vgic-v4.c     | 8 ++++++--
>  include/kvm/arm_vgic.h            | 2 +-
>  5 files changed, 13 insertions(+), 6 deletions(-)
> 

All now queued up.

greg k-h

