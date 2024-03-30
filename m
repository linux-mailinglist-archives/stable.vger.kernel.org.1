Return-Path: <stable+bounces-33792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E88929BF
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D85828337C
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C63C2C;
	Sat, 30 Mar 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a28Ost9W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01B179;
	Sat, 30 Mar 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788297; cv=none; b=OOo0QNlZ1hp0qAfPI85fDx3zRy/cB6s/74GA3akHq32TuBv+x1CXH0EkUkazLiGi6Ma0eEutkrOGxq9CD/VgHk8nOLOKw+fLLlF5gOiiscI2mkx4S3jXMeYpkZwlhWe9nkOm/hct6SCLZai9xBlM4ybMXfyGsuLCVtcqDty26Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788297; c=relaxed/simple;
	bh=BM/rp191x6PVzDMU6Qyxx8uGr+tTrF3bNdEGN9ftIE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R93XnEP7nhD9CKLSmkI77GSHRj6eqmfj/3xcW+o5SIPGO9lGITm6TaQfcJ9TcXpTipXT8yKteZ+bmy+zaBsaosud3gWIhe8/CAx/L4ed0o8LDZn70LWNhLYZ5Eh9BUapR1CBpU2oNhnr2s+zst4RC999IIhLj+/vcV6miQludiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a28Ost9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05036C433C7;
	Sat, 30 Mar 2024 08:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711788296;
	bh=BM/rp191x6PVzDMU6Qyxx8uGr+tTrF3bNdEGN9ftIE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a28Ost9WwUai26ItBfDbm3bbVT/sKiVqPx2PUT6oNPrfz1b8Qgv8DoZd5pfnIQVtl
	 stB9ph02cpml3Y6RP0n7h8nUDIFu+Dsqy3Yj45aFB17kGRinY3jbMX6so5k5C8fj68
	 Foq8mjQEnaXRC98Ki10l1XAPufHbcPzZZ9Fuqnbg=
Date: Sat, 30 Mar 2024 09:44:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, reinette.chatre@intel.com
Subject: Re: Patch "vfio/pci: Prepare for dynamic interrupt context storage"
 has been added to the 6.1-stable tree
Message-ID: <2024033048-succulent-dirtiness-a1c8@gregkh>
References: <20240327114133.2806020-1-sashal@kernel.org>
 <20240329110433.156ff56c.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329110433.156ff56c.alex.williamson@redhat.com>

On Fri, Mar 29, 2024 at 11:04:33AM -0600, Alex Williamson wrote:
> On Wed, 27 Mar 2024 07:41:33 -0400
> Sasha Levin <sashal@kernel.org> wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     vfio/pci: Prepare for dynamic interrupt context storage
> > 
> > to the 6.1-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      vfio-pci-prepare-for-dynamic-interrupt-context-stora.patch
> > and it can be found in the queue-6.1 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit bca808da62c6a87ef168554caa318c2801d19b70
> > Author: Reinette Chatre <reinette.chatre@intel.com>
> > Date:   Thu May 11 08:44:30 2023 -0700
> > 
> >     vfio/pci: Prepare for dynamic interrupt context storage
> >     
> >     [ Upstream commit d977e0f7663961368f6442589e52d27484c2f5c2 ]
> >     
> >     Interrupt context storage is statically allocated at the time
> >     interrupts are allocated. Following allocation, the interrupt
> >     context is managed by directly accessing the elements of the
> >     array using the vector as index.
> >     
> >     It is possible to allocate additional MSI-X vectors after
> >     MSI-X has been enabled. Dynamic storage of interrupt context
> >     is needed to support adding new MSI-X vectors after initial
> >     allocation.
> >     
> >     Replace direct access of array elements with pointers to the
> >     array elements. Doing so reduces impact of moving to a new data
> >     structure. Move interactions with the array to helpers to
> >     mostly contain changes needed to transition to a dynamic
> >     data structure.
> >     
> >     No functional change intended.
> >     
> >     Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> >     Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> >     Acked-by: Thomas Gleixner <tglx@linutronix.de>
> >     Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >     Link: https://lore.kernel.org/r/eab289693c8325ede9aba99380f8b8d5143980a4.1683740667.git.reinette.chatre@intel.com
> >     Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >     Stable-dep-of: fe9a7082684e ("vfio/pci: Disable auto-enable of exclusive INTx IRQ")
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> ...
> > @@ -171,15 +225,24 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
> >  
> >  static int vfio_intx_enable(struct vfio_pci_core_device *vdev)
> >  {
> > +	struct vfio_pci_irq_ctx *ctx;
> > +	int ret;
> > +
> >  	if (!is_irq_none(vdev))
> >  		return -EINVAL;
> >  
> >  	if (!vdev->pdev->irq)
> >  		return -ENODEV;
> >  
> > -	vdev->ctx = kzalloc(sizeof(struct vfio_pci_irq_ctx), GFP_KERNEL_ACCOUNT);
> > -	if (!vdev->ctx)
> > -		return -ENOMEM;
> > +	ret = vfio_irq_ctx_alloc_num(vdev, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ctx = vfio_irq_ctx_get(vdev, 0);
> > +	if (!ctx) {
> > +		vfio_irq_ctx_free_all(vdev);
> > +		return -EINVAL;
> > +	}
> >  
> >  	vdev->num_ctx = 1;
> 
> This is broken on it's own, vfio_irq_ctx_get() depends on a valid
> num_ctx, therefore this function always returns -EINVAL.  This was
> resolved upstream by b156e48fffa9 ("vfio/pci: Use xarray for interrupt
> context storage") which was from the same series, so this issue was
> never apparent upstream.  Suggest dropping this and fe9a7082684e
> ("vfio/pci: Disable auto-enable of exclusive INTx IRQ") for now and
> we'll try to rework the latter to remove the dependency.  Thanks,

Ok, I'll go drop both of these and take the series you just sent,
thanks.

greg k-h

