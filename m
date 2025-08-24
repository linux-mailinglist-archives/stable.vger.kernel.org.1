Return-Path: <stable+bounces-172749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C24B3306C
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2CF202213
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78721A08A4;
	Sun, 24 Aug 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuUt90+2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0334A08
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756046001; cv=none; b=hNLPpulLJrqKDu8NUVgsbD4AtwYGC1FVcrJOMoAhMFD7sxBfpidsJf9cw5rNYQQWA35bXqaiuJOikjm0lUXNw3P3AWQoUJSlUBT5KX/rJihczoCcBDuEDlZ/N8KGl5bY6O+M4kX4t7KVS/THSxFxrEld+OTlnrvSyFHGsqh4Cfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756046001; c=relaxed/simple;
	bh=AAydxmtXdOEr9pUQiFzLGmLEfxElC6MQjjUnrMu4GUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PykY1hXBBNeOGPRFqY9jF2sRyF3/toSwG9q3tf4O9hakbrVSGqeG/beLyggouZcu8C0wo12HcG6T2hQR+VeXmNJAqN1MYPr2kaq+NdNqCPM63rB/k63trnoN25HdQfrbKOU2CR7s9+N8F74OmXo2XalNEC0H6DhVGRQgXZu912c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuUt90+2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756045998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXOZi6fX2O22AbP7K5PtVdG4I/B05K0GknRoq68gV8w=;
	b=MuUt90+2b1qx8/s66ZU837rlPP/QE1Autha7WFtqzhP+TwRXYVj3kphibdRraFBtsXiVkZ
	lTqTOgntdWTfyX/BOK5HcJju5/DrVGPfc3EMBaHa+C5z+fRllBlCeGx1JyoA9Ja01+bbip
	i02JD+LY5OEu3FeIjxh7fbUcQZ9W11Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-lZgeAbtLMUec415n53uaDA-1; Sun, 24 Aug 2025 10:33:14 -0400
X-MC-Unique: lZgeAbtLMUec415n53uaDA-1
X-Mimecast-MFC-AGG-ID: lZgeAbtLMUec415n53uaDA_1756045993
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a256a20fcso20229335e9.2
        for <stable@vger.kernel.org>; Sun, 24 Aug 2025 07:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756045993; x=1756650793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXOZi6fX2O22AbP7K5PtVdG4I/B05K0GknRoq68gV8w=;
        b=wbiqgk2ermyildxWiQzu2rlriu22jyxhGQPhVGWMalFwEvJMreQbdYiyNRbxWkZ7lN
         nQ+/Y3eovrpn9848VTMVKe1ZIxcUEbERY/L9JaM+MSYN5fq2mfnLdb/6kowb9SsIOYw4
         sMbZT2RpTfgd7aWoFJl+spqW/4NhBxFR5QNqgbKW2AYtcHu12fYl6V5jYDwwwHJyhCUo
         L5QsqOlzIqLXXUoj1Bm3mHCvyM0qhcgKfMx2qObDJqOK/3qFL/1cvF+qMud4aM/wS4LQ
         mZa1kYmJpHCW7eOx9cKlTs7G+FtFZyfDISAa4Nl7IOm/dl0nAVTUd8rMTUX+6kw50gdg
         zbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+B2jYLYUjianJ7CI3ZMJA8Zzd9vmnbERYZLqsZQeYSgaLwgiYPO8r+vYD4iyOwpm3jqeVPhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2l4nYWtvwzEDwQLMcasDXbn/582E4FJoTLbQVucD/BP4Xi+FR
	JL76La7nkojf/C5jqJetpeqr5pqVjkNKGJdXc4fLPAWlpgeUDlGZ3SleWBhaohJVwSKfukYC1NS
	lf69tUxgw1/VRG+8j+hg8/+4mlS9518X8bpNVNwmkj5liIo0c2yDsdabp2s4yxv7Udg==
X-Gm-Gg: ASbGnctCNKbtKfQ3+18PogC7hRZyIH9pi1VRan//wvND19SzPCE8PWVUUQyJNVFceEp
	g8lvY221EkzdzkR0YKz8odzKIbgHxZYSy4K/ZR5XObM1fQLBtgWTztYlzLQthI7H4ufWmqfC54M
	sWiZuvkiETt5Yb/bgXMK5j5VVfmWnERiqYkqD+Uxuk3M+Twwi3b+lliMU3yEoOhZS5WBemk+Ax4
	8X4PYxzpBVJHGFpovY3CCBmTN/Unaoqgbvy0odHs0kN/YnN63mB0Tk/JrQwdzdU++YQCO4gI7Iy
	947/N9454/8dMqFiUUI2McW+fH5rYgQa
X-Received: by 2002:a05:600c:c87:b0:456:475b:7af6 with SMTP id 5b1f17b1804b1-45b5179b6aamr65632115e9.7.1756045992566;
        Sun, 24 Aug 2025 07:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnuB6LlR7eU2gREcHAgZVnNkQuY/7F9VLSGBy1Hqh3QwVI8FGRhtEnh4i0AirRf60ui3aTcw==
X-Received: by 2002:a05:600c:c87:b0:456:475b:7af6 with SMTP id 5b1f17b1804b1-45b5179b6aamr65631965e9.7.1756045992120;
        Sun, 24 Aug 2025 07:33:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5f28fa02sm15104475e9.11.2025.08.24.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 07:33:11 -0700 (PDT)
Date: Sun, 24 Aug 2025 10:33:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250824102947-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Sun, Aug 24, 2025 at 02:36:23AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 22 August 2025 07:30 PM
> > 
> > On Fri, Aug 22, 2025 at 01:49:36PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 22 August 2025 06:34 PM
> > > >
> > > > On Fri, Aug 22, 2025 at 12:22:50PM +0000, Parav Pandit wrote:
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: 22 August 2025 03:52 PM
> > > > > >
> > > > > > On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > > > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support
> > > > > > > surprise removal of
> > > > > > virtio pci device").
> > > > > > >
> > > > > > > Virtio drivers and PCI devices have never fully supported true
> > > > > > > surprise (aka hot unplug) removal. Drivers historically
> > > > > > > continued processing and waiting for pending I/O and even
> > > > > > > continued synchronous device reset during surprise removal.
> > > > > > > Devices have also continued completing I/Os, doing DMA and
> > > > > > > allowing device reset after surprise removal to support such drivers.
> > > > > > >
> > > > > > > Supporting it correctly would require a new device capability
> > > > > >
> > > > > > If a device is removed, it is removed.
> > > > > This is how it was implemented and none of the virtio drivers supported it.
> > > > > So vendors had stepped away from such device implementation.
> > > > > (not just us).
> > > >
> > > >
> > > > If the slot does not have a mechanical interlock, I can pull the
> > > > device out. It's not up to a device implementation.
> > >
> > > Sure yes, stack is not there yet to support it.
> > > Each of the virtio device drivers are not there yet.
> > > Lets build that infra, let device indicate it and it will be smooth ride for driver
> > and device.
> > 
> > There is simply no way for the device to "support" for surprise removal, or lack
> > such support thereof. 
> > The support is up to the slot, not the device.  Any pci
> > compliant device can be placed in a slot that allows surprise removal and that is
> > all. The user can then remove the device.
> > Software can then either recover gracefully - it should - or hang or crash - it
> > does sometimes, now. The patch you are trying to revert is an attempt to move
> > some use-cases from the 1st to the 2nd category.
> > 
> It is the driver (and not the device) who needs to tell the device that it will do sane cleanup and not wait infinitely.

You can invent a way for driver to tell the device that it is not
broken. But even if the driver does not do it, nothing at all
prevents users from removing the device.


> > But what is going on now, as far as I could tell, is that someone developed a
> > surprise removal emulation that does not actually remove the device, and is
> > using that for testing the code in linux that supports surprise removal.  
> Nop. Your analysis is incorrect.
> And I explained you that already.
> The device implementation supports correct implementation where device stops all the dma and also does not support register access.
> And no single virtio driver supported that.
> 
> On a surprised removed device, driver expects I/Os to complete and this is beyond a 'bug fix' watermark.
> 
> > That
> > weird emulation seems to lead to all kind of weird issues. You answer is to
> > remove the existing code and tell your testing team "we do not support
> > surprise removal".
> >
> He he, it is no the device, it is the driver that does not support surprise removal as you can see in your proposed patches and other sw changes.

Then fix the driver. Or don't, for that matter, if you lack the time.

> > But just go ahead and tell this to them straight away. You do not need this patch
> > for this.
> > 
> It is needed until infrastructure in multiple subsystem is built.

What I do not understand, is what good does the revert do. Sorry.

> > 
> > Or better still, let's fix the issues please.
> > 
> The implementation is more than a fix category for stable kernels.
> Hence, what is asked is to do proper implementation for future kernels and until that point restore the bad use experience.



I am not at all interested in discussing ease of backporting fixes
before they are developed.
Not how we do kernel development, sorry.

> > 
> > --
> > MST


