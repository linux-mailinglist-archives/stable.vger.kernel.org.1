Return-Path: <stable+bounces-131973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A5A82BE5
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1B1175A5C
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26A71C4A13;
	Wed,  9 Apr 2025 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Laf8YytN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F41C1F0C
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214550; cv=none; b=UBxZffvSRCjCLpia8VrzBqGUBbrITcMkM59DtgvkvtCwv1WDMD5ZQXkFXMx7o6Q1URYxHn35nf/jdzCB4+J6U4kUYJ4H6UNL2VKjI+9tRYVHkMRJJjiK2WSAMi76h1z6ffYz8R+qBmTgf64x9VaKH0ti1AwiEGZiDnWjRvWQ0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214550; c=relaxed/simple;
	bh=iLOOZgcKCxmS9diP1p/CTcxPlq8i83pLfIIeCIiFfHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuy/SZ+6vRW1Y76zJ1M+qASpAELQNy476i7CNiaI1vdDlQXd+exIjRK+pGcL9OwNgzFYh6Bl9uhAdW62iJoOvDb+NUHDdkFuE/dLlu8Vt4d2v0aAL+130shcUZQbPvcfXKvXxjnXHlQgZnG12ZwIv4c8P+Q9dVEJ52TXyRNxmeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Laf8YytN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744214547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7S6RTtnxjFtETXDaFSyTSU/GXOPgC2C8pONoXXV9POg=;
	b=Laf8YytNFfoJIkWEXBfg7ycnMvbygAt4RMJTwvc0gH6BQ28ukrOw1gU30lDxDM51N68mOs
	pTXs5/f8SRJvvPHuFjrVSl/oRHotAmIUtEeyJ9EQo97EXXNgzIFmpljU4dT2RC6nmMsT7p
	Y4WfWVwJChfcWzk5L7rtTdgyIrTzI/8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-5SnC2YZ7PKalXKR9Lmhwag-1; Wed, 09 Apr 2025 12:02:26 -0400
X-MC-Unique: 5SnC2YZ7PKalXKR9Lmhwag-1
X-Mimecast-MFC-AGG-ID: 5SnC2YZ7PKalXKR9Lmhwag_1744214545
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so52838235e9.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 09:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744214545; x=1744819345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S6RTtnxjFtETXDaFSyTSU/GXOPgC2C8pONoXXV9POg=;
        b=QIqL78f8ixQ7UbbEQktdo0CSqFmGXu1jfEz+EB9fT2GdLR+SB8teegUGXsmBmXpMYA
         W3MtY2/yuBmaFNzWbI+0WTSMV24ynO/NapMNzMYg0hNO/CoCgqlLy1BKzYZmfv/RDmpn
         KDrhu+unsiU/t3TwuQDuxh4D3FmO+04XbzjyTfq8ibvSUb5Ssc+OqKzhtkyKldgf0CPu
         BLHJoAe+AYVVbakS1pnWUALDa8LCMU4SHc3MsRdYebkw5QUGfS8NXMZep+umpmW0oE56
         hYkCNEst9X6wDuzDMXz4K0iDDWEFSbZVAqK2nq9sIah0zpCw1mhYaYlj2PgT62Xxw+oc
         nWrw==
X-Forwarded-Encrypted: i=1; AJvYcCWsckr9RNAROz0DjQZ+OpCuObJkQQzJu8DzntICRVebHwANqRmhpBMRsctOxAmcGqgKBIyoorg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNexOjpj+dR9R3I4+P/1wDrjdV0nexGtLr3k6wty5a5+tZzKr
	hwxsxOEnyRu1WPCGybI80QDzrdDdv/ROZXc7xu7aYzA5x0q75rKYFqJpFvFKbs0is/mHezMipb5
	XHa9jU8d/bS2dkY2LixhKtU24rB1qTDzGrxO+jZJ1uxXaA43YwSaWJg==
X-Gm-Gg: ASbGncth8Z+GUCBXJjCL4o/Cmj9ql56apPxvyedrPc5YXVIyskT/nXqmcnTs6X9Rdh8
	gfbwgxTYrpBwuVoqXvObg03HTyozd7AFCuVXahgQ/PoS2PbTwFpyc6HjLO+RN+LDNkgeh/HKacp
	pUsmBYNO2Ct22CQI33VF60GlIMxaLJRbwssL5Bighb4XQjKvTcZt5kjohtPTTNsdIvKZFYYgP0/
	Lj7haeVF2L9ExqXaJIQIvGdzNoPPbN5+vTS+9bO2/fbg4Prp4IkEgA971MmLZVp7YSTu5jew46F
	AGuGWg==
X-Received: by 2002:a05:600c:1d94:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-43f1ed0b0eamr35743065e9.18.1744214544888;
        Wed, 09 Apr 2025 09:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Bb6EmagTxZr/IPFdSrQ4pZmpEZzF/2D8XI9ZNwOy9pr/mbv5QWqwhjozrawKvYW7bh/KpA==
X-Received: by 2002:a05:600c:1d94:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-43f1ed0b0eamr35740785e9.18.1744214542977;
        Wed, 09 Apr 2025 09:02:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fdfd9sm2035636f8f.92.2025.04.09.09.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:02:22 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:02:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250409115557-mutt-send-email-mst@kernel.org>
References: <20250408145908.51811-1-parav@nvidia.com>
 <20250408155057-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71957D9729A72B8BD76513C0DCB42@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71957D9729A72B8BD76513C0DCB42@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, Apr 09, 2025 at 01:50:18PM +0000, Parav Pandit wrote:
> Hi Michael,
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 9, 2025 1:45 AM
> > 
> > On Tue, Apr 08, 2025 at 05:59:08PM +0300, Parav Pandit wrote:
> > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > virtio pci device").
> > >
> > > The cited commit introduced a fix that marks the device as broken
> > > during surprise removal. However, this approach causes uncompleted I/O
> > > requests on virtio-blk device. The presence of uncompleted I/O
> > > requests prevents the successful removal of virtio-blk devices.
> > >
> > > This fix allows devices that simulate a surprise removal but actually
> > > remove gracefully to continue working as before.
> > >
> > > For surprise removals, a better solution will be preferred in the future.
> > 
> > Sorry I'm not breaking one thing to fix another.
> > Device is gone so no new requests will be completed. Why not complete all
> > unfinished requests, for example?
> > 
> > Come up with a proper fix pls.
> > 
> I would also like to have a proper fix that can be backportable.
> However, an attempt [1] had race.
> To overcome the race, a different approach also tried, however the block layer was stuck even if all requests in virtio-blk driver layer was completed like you suggested.
> 
> It appeared that supporting uncompleted requests won't be so straightforward to backport.
> 
> Hence, the request is to revert and restore the previous behavior.
> This at least improves the case where the OS thinks that surprise removal occurred, but the device eventually completes the IO.
> And hence, virtio block driver successfully unloads.
> And virtio-net also does not experience the mentioned crash.
> 
> [1] https://lore.kernel.org/all/20240217180848.241068-1-parav@nvidia.com/

Parav this is a commit from 2021. I am not reverting it "because it
seems to help". We'll never make progress like this.
You will have to debug and fix it properly. Sorry.

Once we have a fix, we will worry about backports and stuff, this
is how we do kernel development here.


> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@baidu.com/
> > > Reviewed-by: Max Gurtovoy<mgurtovoy@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > 
> > > ---
> > >  drivers/virtio/virtio_pci_common.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c
> > > b/drivers/virtio/virtio_pci_common.c
> > > index d6d79af44569..dba5eb2eaff9 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev
> > *pci_dev)
> > >  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > >  	struct device *dev = get_device(&vp_dev->vdev.dev);
> > >
> > > -	/*
> > > -	 * Device is marked broken on surprise removal so that virtio upper
> > > -	 * layers can abort any ongoing operation.
> > > -	 */
> > > -	if (!pci_device_is_present(pci_dev))
> > > -		virtio_break_device(&vp_dev->vdev);
> > > -
> > >  	pci_disable_sriov(pci_dev);
> > >
> > >  	unregister_virtio_device(&vp_dev->vdev);
> > > --
> > > 2.26.2


