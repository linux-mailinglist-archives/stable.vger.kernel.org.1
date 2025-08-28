Return-Path: <stable+bounces-176581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A636B39826
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 11:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDC12064EB
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5E2BB13;
	Thu, 28 Aug 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvQ/+DmH"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEA28313F
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373007; cv=none; b=JyOnI9E01ReH4lR1z2LS4Ednfb0lRcDkJGjiBAyRA8VoGub0nFhXgC5RgFySbcP2/KMzr6rjNpIQEjqmT89zn+bZdiyQnHfI5mcdibc40eYrC6tT7DmYGGJhoEjhcVASINWuLJhZi5qt0mavTFzH8RdmaCR9IhAzSAVvduGBA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373007; c=relaxed/simple;
	bh=X5/mm30DCcXHuNcOaAjmcKM10wUx1QZvOoXLHltdXw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJV+ANVSSkrj/yw6akpYmrBKZsfVHwHWjSvQ5EZsv9I/nCBmzyql9239ncHr31TZqGQbMob0e4KF6LrSBgmDQkh3xy/rFS8fjkaYXb3e44e5hyspYiE0oxnNGZOP5ozzLRP5ylZ/3rikuZMV8W+fSiysZxEgu09amuNaSM5gTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvQ/+DmH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756373004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRf45igs8DyZy1Xb/KozNOVC9d10iPYkxYVMeNdvMcE=;
	b=EvQ/+DmHazLGXQyje0mjkPPPT3fOSr/NyA9Ag+uTKjZeVzEok2KKDy1mM3i4ejUAOp29Nc
	S2a+sgzZRZ9dUt08ZsRspf+Qbxo/3saWCrbkp5lnQedwR76SANoFxR1t62UJxlBnIppYJo
	50LobdrP2HqVaf5Rp4Ws8b9pZRgrWmg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-GUuVNjMIMvWqTApa5yVD3A-1; Thu, 28 Aug 2025 05:23:22 -0400
X-MC-Unique: GUuVNjMIMvWqTApa5yVD3A-1
X-Mimecast-MFC-AGG-ID: GUuVNjMIMvWqTApa5yVD3A_1756373001
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso4182705e9.2
        for <stable@vger.kernel.org>; Thu, 28 Aug 2025 02:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756373001; x=1756977801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRf45igs8DyZy1Xb/KozNOVC9d10iPYkxYVMeNdvMcE=;
        b=Q/48jbwJzdfwrVhLeDEX45GK8AsQ5cnmF6TvjQoK2pXb169x7n0FufCnsfwCg8TVU5
         UYPqgTdm3JVC27mNMi0zHUfprkQJjfQJfiuWUBA/sB1JliDwJM3bNfUcwDqzSsOAJr+d
         n91UBcPxYtJSoJ+ipbfxAIKv8X7KeRzqoYIjLwVYb1CeS4/cDdSemwfgmwFe2DvDCrz6
         Cr2VvAH2q/9OIqR+fA8cK/8xovLxzDfnI53KjNq6lNhUakbohmloIpcjD5WEDa5zr0Da
         a3l/wWb5h/zfH2syCrWGSXYGlSTtXizaF4A4Iaj14Wx8AgrXorXUhe/gAVdxmD/NsbKd
         81oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlRMo0eWaDbpoV5ehy4EDprjWKXKUGIO97LEj6VpvshYw7zilhQlAQmEwyRGeBNhlPDPEZN6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkbVYNU6qYqP1rZw1vQcfDQVXB4Bu3JNxXYBP67wpevGzL4n0
	z7XyRo0T82dtzdFCMB3ST2Ti6JdNeDQvmGoxHoKLt/79SXDLc/K3wS0yihtw4zS5RDRwoPRAINL
	9qtaNH6kKOmTzFlgII6Ibe6+pekWqmr8ygXE7S3sgdTakkDwdLpd1sG6bxg==
X-Gm-Gg: ASbGncv5KhfdzdJsJHqJIlIzUYo3JsuCjPpX8bpOTArVctyJ03umiga6d3fwXFBUBNg
	n3sMNBejVbBsxxo9Z8aQwKIwekrcv0hOERUFwddY2fhXjYSFj+7In31OFcBSBsv2CK18Mr49v/2
	ZMgPKCAZ8DcQwGo2sPp8uwc2OB7eJRqxXw4X4lkpKKvdTr0sJHwbzgRKg48p/JetOPAFEbzXMre
	zAYkeMRaObUgWK1rAi/PQ6+XdjT0K40o+K8PT4gvTotAvTpOXDhfxtaGn91XRyxa8BWB29oLt+a
	xtdO86ErXove+smuAEpvBgqDyA2Vkzhi
X-Received: by 2002:a05:600c:4715:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-45b517406fcmr176501535e9.0.1756373000901;
        Thu, 28 Aug 2025 02:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEua+jNTn1N9k+3zdhlbKarEWIC5ym4baEN46OI/f8wqkIX9E9+c1gWJ0ujKRXU1OZ4SThfzg==
X-Received: by 2002:a05:600c:4715:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-45b517406fcmr176501195e9.0.1756373000384;
        Thu, 28 Aug 2025 02:23:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797ce6d4sm23246455e9.14.2025.08.28.02.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:23:19 -0700 (PDT)
Date: Thu, 28 Aug 2025 05:23:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250828051435-mutt-send-email-mst@kernel.org>
References: <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061925-mutt-send-email-mst@kernel.org>
 <20250827064404-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71950328172FA0A696839623DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250828022502-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956D1AB42BFA9BF19AE134DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71956D1AB42BFA9BF19AE134DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Aug 28, 2025 at 06:59:26AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 28 August 2025 12:04 PM
> > 
> > On Thu, Aug 28, 2025 at 06:23:02AM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 27 August 2025 04:19 PM
> > > >
> > > > On Wed, Aug 27, 2025 at 06:21:28AM -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > > > > > > If it does not, and a user pull out the working device,
> > > > > > > > > how does your patch help?
> > > > > > > > >
> > > > > > > > A driver must tell that it will not follow broken ancient
> > > > > > > > behaviour and at that
> > > > > > > point device would stop its ancient backward compatibility mode.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > I don't know what is "ancient backward compatibility mode".
> > > > > > >
> > > > > > Let me explain.
> > > > > > Sadly, CSPs virtio pci device implementation is done such a way
> > > > > > that, it
> > > > works with ancient Linux kernel which does not have commit
> > > > 43bb40c5b9265.
> > > > >
> > > > >
> > > > > OK we are getting new information here.
> > > > >
> > > > > So let me summarize. There's a virtual system that pretends, to
> > > > > the guest, that device was removed by surprise removal, but
> > > > > actually device is there and is still doing DMA.
> > > > > Is that a fair summary?
> > > >
> > > Yes.
> > >
> > > > If that is the case, the thing to do would be to try and detect the
> > > > fake removal and then work with device as usual - device not doing
> > > > DMA after removal is pretty fundamental, after all.
> > > >
> > > The issue is: one can build the device to stop the DMA.
> > > There is no predictable combination for the driver and device that can work
> > for the user.
> > > For example,
> > > Device that stops the dma will not work before the commit 43bb40c5b9265.
> > > Device that continues the dma will not work with whatever new
> > implementation done in future kernels.
> > >
> > > Hence the capability negotiation would be needed so that device can stop the
> > DMA, config interrupts etc.
> > 
> > So this is a broken implementation at the pci level. We really can't fix removal
> > for this device at all, except by fixing the device. 
> The device to be told how to behave with/without commit 43bb40c5b9265.
> Not sure what you mean by 'fix the device'.
> 
> Users are running stable kernel that has commit 43bb40c5b9265 and its broken setup for them.
> 
> > Whatever works, works by
> > chance.  Feature negotiation in spec is not the way to fix that, but some work
> > arounds in the driver to skip the device are acceptable, mostly to not bother
> > with it.
> >
> Why not?
> It sounds like we need feature bit like VERSION_1 or ORDER_PLATFORM.


Because the device is out of spec (PCI spec which virtio references).

Besides the bug is not in the device, it's in the pci emulation.


> To _fix_ a stable kernel, if you have a suggestion, please suggest.
> 
> > Pls document exactly how this pci looks. Does it have an id we can use to detect
> > it?
> >
> CSPs have different device and vendor id for vnet, blk vfs.
> Is that what you mean by id?

vendor id is one way, yes. maybe a revision check, too.

> > > > For example, how about reading device control+status?
> > > >
> > > Most platforms read 0xffff on non-existing device, but not sure if this the
> > standard or well defined.
> > 
> > IIRC it's in the pci spec as a note.
> > 
> Checking.
> 
> > > > If we get all ones device has been removed If we get 0 in bus
> > > > master: device has been removed but re-inserted Anything else is a
> > > > fake removal
> > > >
> > > Bus master check may pass, right returning all 1s, even if the device is
> > removed, isn't it?
> > 
> > 
> > So we check all ones 1st, only check bus master if not all ones?
> >
> Pci subsystem typically checks the vendor and device ids, and if its not all 1s, its safe enough check.
> 
> How about a fix something like this:
> 
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -746,12 +746,16 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  {
>         struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>         struct device *dev = get_device(&vp_dev->vdev.dev);
> +       u32 v;
> 
>         /*
>          * Device is marked broken on surprise removal so that virtio upper
>          * layers can abort any ongoing operation.
> +        * Make sure that device is truly removed by directly interacting
> +        * with the device (and not just depend on the slot registers).
>          */
> -       if (!pci_device_is_present(pci_dev))
> +       if (!pci_device_is_present(pci_dev) &&
> +           !pci_bus_read_dev_vendor_id(pci_dev->bus, pci_dev->devfn, &v, 0))
>                 virtio_break_device(&vp_dev->vdev);
> 
> So if the device is still there, it let it go through its usual cleanup flow.
> And post this fix, a proper implementation with callback etc that you described can be implemented.


I don't have a big problem with this, but I don't understand the
scenario now again. report_error_detected relies on dev->error_state and
bus read. error_state is set on AER reporting an error. This is
not what you described.

Does the patch actually solve the problem for you?

Also can we limit this to a specific vendor id, or something like that?


I also still like the idea of reading dev control and status, since
it always bothered me that there's a theoretical chance that device
is re-inserted and bus read will succeed. Or maybe I'm imagining it.


-- 
MST


