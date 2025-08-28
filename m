Return-Path: <stable+bounces-176606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87009B39DF9
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 15:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F9C3BC7EC
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8583101D4;
	Thu, 28 Aug 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtymtjnB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3603101D3
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386057; cv=none; b=gaR/T87WdfNjBEK9ito/vllvXbHaZkqUg7iVeJPLNdEiL0GQCZT1rJik33cBQXVNrU4DDNz0qHsE3rKUhS4ODo4pnhpzI3iFsbrqzdtrX45S+dJYufrvUPJR0c2aQAo/3Jm6+oChiJ0IpoE0fcVVkT9B4usm+X0sXa7ANRE1XXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386057; c=relaxed/simple;
	bh=jKUgrkKGxwjF/OmmVzVGTm7SLGw0brqesEGq3+BW44I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiusXpiMzygqI3aR6C63sNBu1gH7h6UZbC4RAM9uIn9xDuXE8JuKSD/x9pr3K5Iw3h1FtayYsZ7E+asfPTmeS0SaBSdCCCwRhCHGyQvlADeF1CLio1x8Tf2Ltn7K+p5xE2+s/Lxakc1340tdGwLMWc10r8HO95I/saI61+p00l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JtymtjnB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756386055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbvuB6Au0zhNqXABCgDm8J3gFB0IHbInVCTp8q39tsI=;
	b=JtymtjnBrBg5ENlqe0750ST9jSSF3mHVGC6EN4IZWIYdP9mabgz+GfrNBDj6TSuneoZZ/K
	0Lef8pyNLefuuBu+YTO+oKjv6JtQ+bB62MKcqOVyS91slDLNu4uJXScGInPnfHiT/NFVjj
	JEu0wOCLRKhlyIwkUXn8e2msXq7IEBQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-RaOj-_ImNheU4L85yH0eNQ-1; Thu, 28 Aug 2025 09:00:52 -0400
X-MC-Unique: RaOj-_ImNheU4L85yH0eNQ-1
X-Mimecast-MFC-AGG-ID: RaOj-_ImNheU4L85yH0eNQ_1756386051
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b71fe31ffso5503105e9.2
        for <stable@vger.kernel.org>; Thu, 28 Aug 2025 06:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386051; x=1756990851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbvuB6Au0zhNqXABCgDm8J3gFB0IHbInVCTp8q39tsI=;
        b=Fax3d4+KH+gacWWmz2wPDVx3sFvYPkNKIzIQ7Zlc8S8CyDLD0btE9Pqi14xAkGf/bo
         Klln9B633pKa8QaNbIdhFhKeUo5eU8njhXmY7Y5GRNLf0ni/Mt023rqIMLTwea0nmKfj
         F0dZRpWZyj9IKSQE+bByfpp8XGlLOrXODow+SuuQL2HKP/pn22xHWxXYcM5YhuzKyFX/
         hE+MFHl/zVhRs/6W5u86oSzki4iKzBSrDsFfHdByzteKO689099lRGnPwxb722Oj3YbW
         HfXEfXXNYzsdgg3kvIDAEdN5BPb3ZmgZ433NXeWrFlXcJ6CjLIifg8QXnUWKQq/kzQJV
         1s6A==
X-Forwarded-Encrypted: i=1; AJvYcCUMyW16PHXALUzcN5al99LdW+MsGoVXBj19Ag2VnHJrnyOxPyowd6YBrpffZWrCINOG4OTYBRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywljfv/NurgrJ9IOiya2HKZ9V15hjOdC3et6LvbxaMHD61Te+9f
	CMuDiUiYiideXSo8Nyk7+lM0UndzvaF+GqrLoA+oWMWf8guod6yOG12o6jCapTpPGDl7deipcNn
	jCY0j/y4RlYZ6SdXZhl/cfaDJNK5RwpQ/tvvEVIENmz/hW5CWTJpuM5KErA==
X-Gm-Gg: ASbGncuRFp2tqXuaurHithhqEqJF1/31382a7K+5HQJA3WxTl7e/Q85kKFl1IXy8ETT
	6zhis5ftOWVebXE1vWGh83CgM9uXt+k7aywy2Cam9Os0dpIpOXRks+CC/+1EOpXR6+k5ztTEpyR
	gkqe5J3tO0/N0WL0RvFeO9zXhNqGEotKCx1+d8fTUwEcXdpm1mbzjmusHX27u6Cmi+xstDHnVxt
	ecP9k+aI26GnLeA/edslRnJ3F/8QPatS6rv/4YiXL47kEyVQ5QAT2DOnHmidWy6vgn9gnvxeAe2
	bvkzLDB+CQfWc/e29Zo1HZYLk1947cWw
X-Received: by 2002:a05:6000:2386:b0:3cb:46fc:8ea2 with SMTP id ffacd0b85a97d-3cb46fc90eamr6842053f8f.6.1756386050919;
        Thu, 28 Aug 2025 06:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFwS7Qliz/HxgGv2dXJpTk5nUZcNUDdFuQrU+BPOwYcdT0gczDl4R2JQKuapyawZNMQWWyqw==
X-Received: by 2002:a05:6000:2386:b0:3cb:46fc:8ea2 with SMTP id ffacd0b85a97d-3cb46fc90eamr6842013f8f.6.1756386050171;
        Thu, 28 Aug 2025 06:00:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cd5997658fsm4839515f8f.46.2025.08.28.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:00:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:00:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250828085526-mutt-send-email-mst@kernel.org>
References: <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org>
 <87frdddmni.fsf@redhat.com>
 <CY8PR12MB7195FD9F90C45CC2B17A4776DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <87cy8fej4z.fsf@redhat.com>
 <20250828081717-mutt-send-email-mst@kernel.org>
 <87a53jeiv6.fsf@redhat.com>
 <CY8PR12MB719591FB70C7ACA82AD8ACF8DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719591FB70C7ACA82AD8ACF8DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Aug 28, 2025 at 12:33:58PM +0000, Parav Pandit wrote:
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: 28 August 2025 05:52 PM
> > 
> > On Thu, Aug 28 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Thu, Aug 28, 2025 at 02:16:28PM +0200, Cornelia Huck wrote:
> > >> On Thu, Aug 28 2025, Parav Pandit <parav@nvidia.com> wrote:
> > >>
> > >> >> From: Cornelia Huck <cohuck@redhat.com>
> > >> >> Sent: 27 August 2025 05:04 PM
> > >> >>
> > >> >> On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >> >>
> > >> >> > On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> > >> >> >> > What I do not understand, is what good does the revert do. Sorry.
> > >> >> >> >
> > >> >> >> Let me explain.
> > >> >> >> It prevents the issue of vblk requests being stuck due to broken VQ.
> > >> >> >> It prevents the vnet driver start_xmit() to be not stuck on skb
> > completions.
> > >> >> >
> > >> >> > This is the part I don't get.  In what scenario, before
> > >> >> > 43bb40c5b9265 start_xmit is not stuck, but after 43bb40c5b9265 it is
> > stuck?
> > >> >> >
> > >> >> > Once the device is gone, it is not using any buffers at all.
> > >> >>
> > >> >> What I also don't understand: virtio-ccw does exactly the same
> > >> >> thing (virtio_break_device(), added in 2014), and it supports
> > >> >> surprise removal _only_, yet I don't remember seeing bug reports?
> > >> >
> > >> > I suspect that stress testing may not have happened for ccw with active
> > vblk Ios and outstanding transmit pkt and cvq commands.
> > >> > Hard to say as we don't have ccw hw or systems.
> > >>
> > >> cc:ing linux-s390 list. I'd be surprised if nobody ever tested
> > >> surprise removal on a loaded system in the last 11 years.
> > >
> > >
> > > As it became very clear from follow up discussion, the issue is
> > > nothing to do with virtio, it is with a broken hypervisor that allows
> > > device to DMA into guest memory while also telling the guest that the
> > > device has been removed.
> > >
> > > I guess s390 is just not broken like this.
> > 
> > Ah good, I missed that -- that indeed sounds broken, and needs to be fixed
> > there.
> Nop. This is not the issue. You missed this focused on fixing the device.
> 
> The fact is: the driver is expecting the IOs and CVQ commands and DMA to succeed even after device is removed.
> The driver is expecting the device reset to also succeed.
> Stefan already pointed out this in the vblk driver patches.
> This is why you see call traces on del_gendisk(), CVQ commands.
> 
> Again, it is the broken drivers not the device.
> Device can stop the DMA and stop responding to the requests and kernel 6.X will continue to hang as long as it has cited commit.


Parav, the issues you cite are real but unrelated and will hang anyway
with or without the commit.

All you have to do is pull out the device while e.g. a command is in the
process of being submitted.

All the commit you want to revert does, is in some instances instead of
just hanging it will make queue as broken and release memory. Since you
device is not really gone and keeps DMAing into memory, guest memory
gets corrupted.


But your argument that the issue is that the fix is "incomplete" is
bogus - when we make the fix complete it will become even worse for
this broken devices.





-- 
MST


