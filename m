Return-Path: <stable+bounces-56268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E291E558
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 18:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4626E285416
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9227716D9DE;
	Mon,  1 Jul 2024 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7hyPkxV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D31116D4F1
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851299; cv=none; b=u5QQkHouj3RzbtIB/VU3Atc5usVutdTbwSq9JQX2k80ypZ1vl9L1r71c5lP4rZ73pHbhxNDyciXUgp5QPzCJ9z1NeNgHbgLWXxECdCjIqALKRds5pRuUt8WrR1bk+lxwtSjmqgg3ss5fxDesAvqoCOr2RTP10k3/gohGLU7n07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851299; c=relaxed/simple;
	bh=Qw0tSVuuk9bbLHPolxT0JhG/GtaUcbxpxg9Pc3oVhOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3OBFXjkHkBRjlKCscYYuzkmzNVzfSnml4CBsf5PZtyq2JffFArpp8zO3CwjOKPAQd9yRl9PLV+e8ng6F1EeXND+tw9N36ICEKpQ+M3MQNvtKPNZNFd/IGbMn0YuaqflvHvFamJpl6anXJ4Nb9jaL3rDvXSUXEovqZCRq8XJJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w7hyPkxV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424a3cb87f1so98885e9.1
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719851296; x=1720456096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32I00GXFICMXRehUGmkx9FyGROjOFkbV4tT1/xanQNs=;
        b=w7hyPkxV2Lk1oq0fBbIo+OZWY2328JZjO+opf5z2gGgnKB/9Shm8ti0MdXrEqdMx5j
         YzcA9yYII2SxjbDqgmoShaIsCj30liUeidGZ6rXq+hfAPhxVEU1/WbRyPKdLwt8OSHHu
         zsqPpwHeaZgZo0YTw3+B+DDZi5NqojS8XKe/UqqYSDZIcSasQRseHb4foJn/O4CPubc5
         KRU+5/0SBl9aeQeRnW7DctkCSwOYC9bLKdbjmnaHhPmfj31oZu8/nSlCDx4nBMS9dxx+
         gLzY6N5po0Fdwha+xss75meY3seas+TgoThikVxsebFfrvzNwjmX2aF3LrqQNEqossiJ
         Rk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851296; x=1720456096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32I00GXFICMXRehUGmkx9FyGROjOFkbV4tT1/xanQNs=;
        b=s4TVQWmtd5t8deDiLprffgIO0c7D2i/WEeCTPAFSKJTi+IyU2mAlx40ozRFiPI3N3Y
         HS22ZhefthahZcpGsQC1Ec/nqptI+HcQRK0Oht9PQh17D6+4AIlE+SkG/HSK5QmUZGoR
         2mhXKpxpieW487SUdTprpyjy41JtXi+GqWv7MX4OcS35aVPHeXWtQBTiMV5oa4tgZJrf
         /To911lO/+1YnKDBjlsQhZMdgBVp7+yHdH75aJ1JMmLGQ8HKnR0bFY4dGo4a8hByJosp
         7Y3k2JWLcacV9vHyieCP+Et3IKB6PtSlZ4rqQu8cbReB+qdVeXEb7X8VkSg5nipZ/7J+
         +JVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsI26d06sqs2stttCgEasZYAEJWz8UUu6qV2SwsOL257gZZLRfu4NcDzHidrIcvbQGQBEqjMLtVSTF4Hqc7tdcrDaYiUQT
X-Gm-Message-State: AOJu0Yzyqfjia5Y7+ba86N9EVxf6LaYfF2x4q8AxYa3LYU4keDHGHYl/
	JUMKgQB+HYngsSgiJ7lXBIaJwvKWugHKorRiisZR9NUESyZoVNS2HqLLhX232Q==
X-Google-Smtp-Source: AGHT+IGdg13g17HYf+9jxwKwacnWwSM/6351fSb+bo1pZ5uhDTxETXU0DPcfrlWl+YHslU5VvJSkuA==
X-Received: by 2002:a05:600c:3b99:b0:421:6c54:3a8 with SMTP id 5b1f17b1804b1-4257815c709mr3462245e9.7.1719851295730;
        Mon, 01 Jul 2024 09:28:15 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc434sm10460704f8f.76.2024.07.01.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:28:15 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:28:11 +0000
From: Mostafa Saleh <smostafa@google.com>
To: gregkh@linuxfoundation.org
Cc: bhelgaas@google.com, tglx@linutronix.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] PCI/MSI: Fix UAF in msi_capability_init"
 failed to apply to 6.1-stable tree
Message-ID: <ZoLZG7HEFPVvxt0T@google.com>
References: <2024070120-undergo-stipulate-9aae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024070120-undergo-stipulate-9aae@gregkh>

Hi Greg,

On Mon, Jul 01, 2024 at 04:22:20PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 

I can’t repro the UAF in 6.1. Looking more, I think the bug was actual
introduced when MSI_COMMON_FLAGS was added with MSI_FLAG_FREE_MSI_DESCS in
commit "a737b7d0e721 (PCI/MSI: Add support for per device MSI[X] domains)"

And not from the freeing logic mentioned in the Fixes, so the first affected
version is 6.2

Thanks,
Mostafa

> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070120-undergo-stipulate-9aae@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:
> 
> 9eee5330656b ("PCI/MSI: Fix UAF in msi_capability_init")
> b12d0bec385b ("PCI/MSI: Move pci_disable_msi() to api.c")
> c93fd5266cff ("PCI/MSI: Move mask and unmask helpers to msi.h")
> a474d3fbe287 ("PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1 Mon Sep 17 00:00:00 2001
> From: Mostafa Saleh <smostafa@google.com>
> Date: Mon, 24 Jun 2024 20:37:28 +0000
> Subject: [PATCH] PCI/MSI: Fix UAF in msi_capability_init
> 
> KFENCE reports the following UAF:
> 
>  BUG: KFENCE: use-after-free read in __pci_enable_msi_range+0x2c0/0x488
> 
>  Use-after-free read at 0x0000000024629571 (in kfence-#12):
>   __pci_enable_msi_range+0x2c0/0x488
>   pci_alloc_irq_vectors_affinity+0xec/0x14c
>   pci_alloc_irq_vectors+0x18/0x28
> 
>  kfence-#12: 0x0000000008614900-0x00000000e06c228d, size=104, cache=kmalloc-128
> 
>  allocated by task 81 on cpu 7 at 10.808142s:
>   __kmem_cache_alloc_node+0x1f0/0x2bc
>   kmalloc_trace+0x44/0x138
>   msi_alloc_desc+0x3c/0x9c
>   msi_domain_insert_msi_desc+0x30/0x78
>   msi_setup_msi_desc+0x13c/0x184
>   __pci_enable_msi_range+0x258/0x488
>   pci_alloc_irq_vectors_affinity+0xec/0x14c
>   pci_alloc_irq_vectors+0x18/0x28
> 
>  freed by task 81 on cpu 7 at 10.811436s:
>   msi_domain_free_descs+0xd4/0x10c
>   msi_domain_free_locked.part.0+0xc0/0x1d8
>   msi_domain_alloc_irqs_all_locked+0xb4/0xbc
>   pci_msi_setup_msi_irqs+0x30/0x4c
>   __pci_enable_msi_range+0x2a8/0x488
>   pci_alloc_irq_vectors_affinity+0xec/0x14c
>   pci_alloc_irq_vectors+0x18/0x28
> 
> Descriptor allocation done in:
> __pci_enable_msi_range
>     msi_capability_init
>         msi_setup_msi_desc
>             msi_insert_msi_desc
>                 msi_domain_insert_msi_desc
>                     msi_alloc_desc
>                         ...
> 
> Freed in case of failure in __msi_domain_alloc_locked()
> __pci_enable_msi_range
>     msi_capability_init
>         pci_msi_setup_msi_irqs
>             msi_domain_alloc_irqs_all_locked
>                 msi_domain_alloc_locked
>                     __msi_domain_alloc_locked => fails
>                     msi_domain_free_locked
>                         ...
> 
> That failure propagates back to pci_msi_setup_msi_irqs() in
> msi_capability_init() which accesses the descriptor for unmasking in the
> error exit path.
> 
> Cure it by copying the descriptor and using the copy for the error exit path
> unmask operation.
> 
> [ tglx: Massaged change log ]
> 
> Fixes: bf6e054e0e3f ("genirq/msi: Provide msi_device_populate/destroy_sysfs()")
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Heelgas <bhelgaas@google.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240624203729.1094506-1-smostafa@google.com
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index c5625dd9bf49..3a45879d85db 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -352,7 +352,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>  			       struct irq_affinity *affd)
>  {
>  	struct irq_affinity_desc *masks = NULL;
> -	struct msi_desc *entry;
> +	struct msi_desc *entry, desc;
>  	int ret;
>  
>  	/* Reject multi-MSI early on irq domain enabled architectures */
> @@ -377,6 +377,12 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>  	/* All MSIs are unmasked by default; mask them all */
>  	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
>  	pci_msi_mask(entry, msi_multi_mask(entry));
> +	/*
> +	 * Copy the MSI descriptor for the error path because
> +	 * pci_msi_setup_msi_irqs() will free it for the hierarchical
> +	 * interrupt domain case.
> +	 */
> +	memcpy(&desc, entry, sizeof(desc));
>  
>  	/* Configure MSI capability structure */
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
> @@ -396,7 +402,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>  	goto unlock;
>  
>  err:
> -	pci_msi_unmask(entry, msi_multi_mask(entry));
> +	pci_msi_unmask(&desc, msi_multi_mask(&desc));
>  	pci_free_msi_irqs(dev);
>  fail:
>  	dev->msi_enabled = 0;
> 

