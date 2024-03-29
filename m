Return-Path: <stable+bounces-33743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356F4892263
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 18:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE10E28B0F7
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547111327EF;
	Fri, 29 Mar 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+1Lu79e"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB251C2B
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731882; cv=none; b=Vi/YmvgoN5D2J1h4xeqbt+IfXfGLU22K4mPHKgqtmiYBF1Yvb45BjAdYl6BPeGGt61dZkue3sNtGFSRuSkHSA13IFK1wYxEqrc7WETOyxnrW/g7KF9VVe9DldmoDUN9TnQj2T4jG9jIeMHjTfj9pkOwkS20Pw4izQ7nprI/mBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731882; c=relaxed/simple;
	bh=1UzpalG2KJyb/9IqCpEjtkC/+GHlE5HI+ODmcHOpd7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTDUY3HndlJMYfy5IRghPxaE7UcyFULb85PSZHqTUdP7LO6kjCW0R07zSqRrgAJ211Gheqdu5ILJd+BN99ThoI30u4v6/GdAJNGLFdXcXb2xpU/fnZ67RQ/EXl2SLjV6XdVBXbDQbrh6JnEeGKoCsX1xqocNDQ9SKpOHVDodbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+1Lu79e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711731879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LY1HBvJtGYA9lxhc8huo2ah3IOerLrRBRNZIk8iTvA8=;
	b=C+1Lu79eiOZAwX/By53EUbPOZtcgtO3Soq75lZcm9yiQeicg5Je8CORxldbiZnKQe7HgsB
	UWKj7WZAs47T97OltNLtepo/AIHucgFrHvvrCaV7EpgJbUYrj1nYGyVl+g1RCnVhLcORbe
	rvNNefbdkbxw8Yot3IyT+DuTGu4XlpI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-ogAs0r9xN_2SXvROQvU4nA-1; Fri, 29 Mar 2024 13:04:37 -0400
X-MC-Unique: ogAs0r9xN_2SXvROQvU4nA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d096c4d64eso74773839f.1
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 10:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711731877; x=1712336677;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LY1HBvJtGYA9lxhc8huo2ah3IOerLrRBRNZIk8iTvA8=;
        b=qScEmBOB+PL0sJkjXbRblUuDhI5tEhzaLUkJUywlVdf8vNDdSik+N5hD4JYncr8izn
         iP0jI59HZQZtxVRyDLVnRZSNBapt/8MyCLXA/0TNJewIBn8UdejClC3f4jFBX8SNl+l9
         ys5Lmx1V+BCSccaW587kUx/iJKuk+x8iFL9KWmrdJ8Xpe259WtFLFrN36uOtXgWHVIGP
         u/nLxc27psyIG1jiWx21ttblQjWC+4wVX6mU5u2KxGm97iBMo6oQkZWYEWcOpvJpTcbt
         JsCst7ZzVQfY4WDbDl/IncXTLAngtaQlpUA/W9NmCcCqCR5jSN/zDH6G0cWtgvn+XXpA
         N6DA==
X-Gm-Message-State: AOJu0YyMWTbVYhix3g9w8o/393/ZKrxW79Fzn8QU/Ab/yRfmVMjtvtNa
	QNaJ/DxhB3IKdBfyBMxdPasMP3wkUfnwXe4zeLehPLIvptLv+vljLuPZuZzJVvle0YNCTe5amh8
	qQcp5Gg2Zf8NPCtq25KiS73TjF34AJ3YjGHGlvs/mxZoZnLdZe7g0LA==
X-Received: by 2002:a5d:9045:0:b0:7d0:605d:1625 with SMTP id v5-20020a5d9045000000b007d0605d1625mr2122850ioq.9.1711731876856;
        Fri, 29 Mar 2024 10:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDEM7qPnFfZDtOy5iLemW/RWpx3RIVNuvrj6a9yAn3/7E56umxrRmpfVUWd/OvLM/DBcwVjQ==
X-Received: by 2002:a5d:9045:0:b0:7d0:605d:1625 with SMTP id v5-20020a5d9045000000b007d0605d1625mr2122824ioq.9.1711731876152;
        Fri, 29 Mar 2024 10:04:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id j12-20020a6b794c000000b007cf134765cdsm1077288iop.31.2024.03.29.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:04:35 -0700 (PDT)
Date: Fri, 29 Mar 2024 11:04:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 reinette.chatre@intel.com
Subject: Re: Patch "vfio/pci: Prepare for dynamic interrupt context storage"
 has been added to the 6.1-stable tree
Message-ID: <20240329110433.156ff56c.alex.williamson@redhat.com>
In-Reply-To: <20240327114133.2806020-1-sashal@kernel.org>
References: <20240327114133.2806020-1-sashal@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 07:41:33 -0400
Sasha Levin <sashal@kernel.org> wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     vfio/pci: Prepare for dynamic interrupt context storage
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      vfio-pci-prepare-for-dynamic-interrupt-context-stora.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit bca808da62c6a87ef168554caa318c2801d19b70
> Author: Reinette Chatre <reinette.chatre@intel.com>
> Date:   Thu May 11 08:44:30 2023 -0700
> 
>     vfio/pci: Prepare for dynamic interrupt context storage
>     
>     [ Upstream commit d977e0f7663961368f6442589e52d27484c2f5c2 ]
>     
>     Interrupt context storage is statically allocated at the time
>     interrupts are allocated. Following allocation, the interrupt
>     context is managed by directly accessing the elements of the
>     array using the vector as index.
>     
>     It is possible to allocate additional MSI-X vectors after
>     MSI-X has been enabled. Dynamic storage of interrupt context
>     is needed to support adding new MSI-X vectors after initial
>     allocation.
>     
>     Replace direct access of array elements with pointers to the
>     array elements. Doing so reduces impact of moving to a new data
>     structure. Move interactions with the array to helpers to
>     mostly contain changes needed to transition to a dynamic
>     data structure.
>     
>     No functional change intended.
>     
>     Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>     Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>     Acked-by: Thomas Gleixner <tglx@linutronix.de>
>     Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>     Link: https://lore.kernel.org/r/eab289693c8325ede9aba99380f8b8d5143980a4.1683740667.git.reinette.chatre@intel.com
>     Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>     Stable-dep-of: fe9a7082684e ("vfio/pci: Disable auto-enable of exclusive INTx IRQ")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
...
> @@ -171,15 +225,24 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
>  
>  static int vfio_intx_enable(struct vfio_pci_core_device *vdev)
>  {
> +	struct vfio_pci_irq_ctx *ctx;
> +	int ret;
> +
>  	if (!is_irq_none(vdev))
>  		return -EINVAL;
>  
>  	if (!vdev->pdev->irq)
>  		return -ENODEV;
>  
> -	vdev->ctx = kzalloc(sizeof(struct vfio_pci_irq_ctx), GFP_KERNEL_ACCOUNT);
> -	if (!vdev->ctx)
> -		return -ENOMEM;
> +	ret = vfio_irq_ctx_alloc_num(vdev, 1);
> +	if (ret)
> +		return ret;
> +
> +	ctx = vfio_irq_ctx_get(vdev, 0);
> +	if (!ctx) {
> +		vfio_irq_ctx_free_all(vdev);
> +		return -EINVAL;
> +	}
>  
>  	vdev->num_ctx = 1;

This is broken on it's own, vfio_irq_ctx_get() depends on a valid
num_ctx, therefore this function always returns -EINVAL.  This was
resolved upstream by b156e48fffa9 ("vfio/pci: Use xarray for interrupt
context storage") which was from the same series, so this issue was
never apparent upstream.  Suggest dropping this and fe9a7082684e
("vfio/pci: Disable auto-enable of exclusive INTx IRQ") for now and
we'll try to rework the latter to remove the dependency.  Thanks,

Alex


