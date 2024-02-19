Return-Path: <stable+bounces-20511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DC85A144
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 11:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035321F2160A
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113C28DC8;
	Mon, 19 Feb 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHSWqWu2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5C28684
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339646; cv=none; b=j1dBXyA2EGiS9H9gYtmTOXPl4oPh/7ADWzKFoSzL054a1bA9fgIghxEG8XUoRdKFUhBFy986cTUD/2trLa3wDBvNnwIVDKi0yi6ZOuiIf5ePke3aVbZv6Q29yd9x2GdE6xrSXnQn8Wkeb82jUrztN4NW57lyvOpI5HvFb3QsmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339646; c=relaxed/simple;
	bh=CbS8EfhDRka7Q6wEyhHmEPKriZqIsMZYy+gfG/xziFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I//9ZmtF/mCBXaGWL5jHwXV4Zi1OiQve3SPIR3HDdPh4nRpnZRo/tWyJSYgUxWHA0baDCVHPMgKpzZyHTzVWo9qttN3j4dlCJzNA7IkV6KXu2VoC09OQnNCkxO3mZ9tYhIHD1S3IwZsqgf9sZlNnVBDpaUzmBqj09AQjvgTvjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHSWqWu2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708339643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ko3bpSB6LFYSpgZ7lp23nszsYntVgh+j/LkPwXE8CwA=;
	b=ZHSWqWu2pt9VF97jKABSAo6zUZKozMNVjZHXLuzPmkHUHdieUthGjUV/EKbBFpoFfswJNV
	to4TBddEoIkD2JkSE9gL1aDMZmplmBbgtftgIVaQpVECz1Ho1900dcTpzbiCdeWo6K3IQu
	bqCOJgdolZ5mAd3eyx1vClt7ZTIJiLg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-4ygx-coNNzCI__E6AdXAfg-1; Mon, 19 Feb 2024 05:47:19 -0500
X-MC-Unique: 4ygx-coNNzCI__E6AdXAfg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-512a00a2651so2078507e87.1
        for <stable@vger.kernel.org>; Mon, 19 Feb 2024 02:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708339637; x=1708944437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko3bpSB6LFYSpgZ7lp23nszsYntVgh+j/LkPwXE8CwA=;
        b=BA34LKtms/eqJpKFyzSMZ1Ddotgb+RET6G4gjBdrCan5kJHVdR+G63HQZfroF8Hb7B
         EMx69B4m4woxlLERJgJ99RBbf1pxWkSGGmfq2iDECvJkADfqTofYhn4grnli6bjhl0Pt
         GRp3M621qks3GyqaxoAxCUeRJJzG1C6pTuG/XrAxRda/t/NjW57CmRus9R0MD5BMkVlX
         o/p++s2wzF55tf4rgkTs2Q6rThoMkPnF0Pg5rVLe6IsUw5enGjUJyTnn1iyTXNGwdUIp
         i8Cb3vcdSC170tv6lDQTgvRM/F7sfdLStOYA11+M8dUhH73AhDd19Rnsm0vpjI92sCbc
         MnRg==
X-Forwarded-Encrypted: i=1; AJvYcCUhn0n9qPejF+aIJuta5Gv1DEbJWfAexNpW1SgwPNiIM0w0YALFazIIkUEI0n6NoCNmswCXsaGczRTrPTN+U6/fA0dDQybS
X-Gm-Message-State: AOJu0YzOcfN8a3p6dk+lFuFSgC6/QndVsvwk9VcmSdLJ8G2amZTRIWWE
	2kwJ5T3R74K8aDV6uOF+o76Gwyd+hnlZwmqYdz/yF002yMIj8CJWtiyvvsO5/1zN/kwny0OraNo
	TsBilUVbO4a5oY9hPRODykdlygwDxF0tn3DTiuwe3eKsIQWMpIdgOVQ==
X-Received: by 2002:a2e:8085:0:b0:2d0:c396:f5b2 with SMTP id i5-20020a2e8085000000b002d0c396f5b2mr7365309ljg.27.1708339637619;
        Mon, 19 Feb 2024 02:47:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGhWKUj8jz9hZvXJzX/Lii21jxx3r1v/utV+TrgxtPsn0JzFtwNZxLPfJJLOPwMCNsgx6o/g==
X-Received: by 2002:a2e:8085:0:b0:2d0:c396:f5b2 with SMTP id i5-20020a2e8085000000b002d0c396f5b2mr7365295ljg.27.1708339637230;
        Mon, 19 Feb 2024 02:47:17 -0800 (PST)
Received: from redhat.com ([2.52.19.211])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b0033cdbe335bcsm10016533wrm.71.2024.02.19.02.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 02:47:16 -0800 (PST)
Date: Mon, 19 Feb 2024 05:47:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] virtio_blk: Fix device surprise removal
Message-ID: <20240219054459-mutt-send-email-mst@kernel.org>
References: <20240217180848.241068-1-parav@nvidia.com>
 <ZdIFpqa23YHwJACh@fedora>
 <PH0PR12MB5481DCCE8127FB12C24EF74DDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240219024301-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548151B646CDE618F71DDAFEDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB548151B646CDE618F71DDAFEDC512@PH0PR12MB5481.namprd12.prod.outlook.com>

On Mon, Feb 19, 2024 at 10:39:36AM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, February 19, 2024 1:45 PM
> > 
> > On Mon, Feb 19, 2024 at 03:14:54AM +0000, Parav Pandit wrote:
> > > Hi Ming,
> > >
> > > > From: Ming Lei <ming.lei@redhat.com>
> > > > Sent: Sunday, February 18, 2024 6:57 PM
> > > >
> > > > On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> > > > > When the PCI device is surprise removed, requests won't complete
> > > > > from the device. These IOs are never completed and disk deletion
> > > > > hangs indefinitely.
> > > > >
> > > > > Fix it by aborting the IOs which the device will never complete
> > > > > when the VQ is broken.
> > > > >
> > > > > With this fix now fio completes swiftly.
> > > > > An alternative of IO timeout has been considered, however when the
> > > > > driver knows about unresponsive block device, swiftly clearing
> > > > > them enables users and upper layers to react quickly.
> > > > >
> > > > > Verified with multiple device unplug cycles with pending IOs in
> > > > > virtio used ring and some pending with device.
> > > > >
> > > > > In future instead of VQ broken, a more elegant method can be used.
> > > > > At the moment the patch is kept to its minimal changes given its
> > > > > urgency to fix broken kernels.
> > > > >
> > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > virtio pci device")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: lirongqing@baidu.com
> > > > > Closes:
> > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9
> > > > > b474
> > > > > 1@baidu.com/
> > > > > Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > ---
> > > > >  drivers/block/virtio_blk.c | 54
> > > > > ++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 54 insertions(+)
> > > > >
> > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > b/drivers/block/virtio_blk.c index 2bf14a0e2815..59b49899b229
> > > > > 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct
> > > > > virtio_device
> > > > *vdev)
> > > > >  	return err;
> > > > >  }
> > > > >
> > > > > +static bool virtblk_cancel_request(struct request *rq, void *data) {
> > > > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > > > +
> > > > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > > > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > > > +		blk_mq_complete_request(rq);
> > > > > +
> > > > > +	return true;
> > > > > +}
> > > > > +
> > > > > +static void virtblk_cleanup_reqs(struct virtio_blk *vblk) {
> > > > > +	struct virtio_blk_vq *blk_vq;
> > > > > +	struct request_queue *q;
> > > > > +	struct virtqueue *vq;
> > > > > +	unsigned long flags;
> > > > > +	int i;
> > > > > +
> > > > > +	vq = vblk->vqs[0].vq;
> > > > > +	if (!virtqueue_is_broken(vq))
> > > > > +		return;
> > > > > +
> > > >
> > > > What if the surprise happens after the above check?
> > > >
> > > >
> > > In that small timing window, the race still exists.
> > >
> > > I think, blk_mq_quiesce_queue(q); should move up before cleanup_reqs()
> > regardless of surprise case along with other below changes.
> > >
> > > Additionally, for non-surprise case, better to have a graceful timeout to
> > complete already queued requests.
> > > In absence of timeout scheme for this regression, shall we only complete the
> > requests which the device has already completed (instead of waiting for the
> > grace time)?
> > > There was past work from Chaitanaya, for the graceful timeout.
> > >
> > > The sequence for the fix I have in mind is:
> > > 1. quiesce the queue
> > > 2. complete all requests which has completed, with its status 3. stop
> > > the transport (queues) 4. complete remaining pending requests with
> > > error status
> > >
> > > This should work regardless of surprise case.
> > > An additional/optional graceful timeout on non-surprise case can be helpful
> > for #2.
> > >
> > > WDYT?
> > 
> > All this is unnecessarily hard for drivers... I am thinking maybe after we set
> > broken we should go ahead and invoke all callbacks. 
> 
> Yes, #2 is about invoking the callbacks.
> 
> The issue is not with setting the flag broken. As Ming pointed, the issue is : we may miss setting the broken.


So if we did get callbacks, we'd be able to test broken flag in the
callback.

> Without graceful time out it is straight forward code, just rearrangement of APIs in this patch with existing code.
> 
> The question is : it is really if we really care for that grace period when the device or driver is already on its exit path and VQ is not broken.
> If we don't wait for the request in progress, is it ok?
> 

If we are talking about physical hardware, it seems quite possible that
removal triggers then user gets impatient and yanks the card out.


> > interrupt handling core is not making it easy for us - we must disable real
> > interrupts if we do, and in the past we failed to do it.
> > See e.g.
> > 
> > 
> > commit eb4cecb453a19b34d5454b49532e09e9cb0c1529
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Wed Mar 23 11:15:24 2022 +0800
> > 
> >     Revert "virtio_pci: harden MSI-X interrupts"
> > 
> >     This reverts commit 9e35276a5344f74d4a3600fc4100b3dd251d5c56.
> > Issue
> >     were reported for the drivers that are using affinity managed IRQ
> >     where manually toggling IRQ status is not expected. And we forget to
> >     enable the interrupts in the restore path as well.
> > 
> >     In the future, we will rework on the interrupt hardening.
> > 
> >     Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> > 
> > 
> > 
> > If someone can figure out a way to make toggling interrupt state play nice with
> > affinity managed interrupts, that would solve a host of issues I feel.
> > 
> > 
> > 
> > > > Thanks,
> > > > Ming


