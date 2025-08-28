Return-Path: <stable+bounces-176603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DCEB39D21
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730CE164C43
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F430EF9F;
	Thu, 28 Aug 2025 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9POBY2p"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB730DEA1
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383753; cv=none; b=MSZOq8gususPUqKxUyXvo0rEbG+DZ6QKBbPdqmOmsTxC1d1MOugCOm9e5nv8ddq/IHxfHVQXLSI9f6okoUWEdfVT3BA9+sa13aKgk0fAaZu04vBXFs3v7ctJtdWuEoRy/9MtFScnhdy/dHJgIeDHf8F/lgS3PuGT+JnkgedUJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383753; c=relaxed/simple;
	bh=XoHfNzd9TzAflaxVnsWKe6PmdGkidLY3mwWJ8PoI0Cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X5c35QfOOnrcUnHl6pdLrQUhP5LiUIQi7mXeWkDH9FjOkoHOYr7ZbExbtftkGHpvK3d+MJp0SMK+j85iyWwoIuMsUuv4+Ap1ZbShVhBUwIOpE1MKpCnTJZcH23aGF1tttNFf6a970IyCNENJrT2s0mAw3HWFTo1Ahpq7OwuJn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9POBY2p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756383751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RCok65salaUoQjWE+4RzDLHzVJ7fbcHVunYgHTZPTo=;
	b=d9POBY2pOiJVHJOUjul6so1Tc6CIPr/JctCy7VqBeAJng4epClpmHIGLQkJ6QpQ7/6Vcyq
	cHkhdKQMookmoEtCHBYFoVHXFXE662/pjEmrYG5SDS2H01dZvKYUjFzUOfBICI5PWz43Xv
	3/raoLWkfcZGuNJLN/SEZXkARW+WDdc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-5Ks8oVAcNF2gA11hoxKoKg-1; Thu,
 28 Aug 2025 08:22:27 -0400
X-MC-Unique: 5Ks8oVAcNF2gA11hoxKoKg-1
X-Mimecast-MFC-AGG-ID: 5Ks8oVAcNF2gA11hoxKoKg_1756383746
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EF1B18002A4;
	Thu, 28 Aug 2025 12:22:26 +0000 (UTC)
Received: from localhost (unknown [10.45.224.217])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7226300019F;
	Thu, 28 Aug 2025 12:22:24 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "xuanzhuo@linux.alibaba.com"
 <xuanzhuo@linux.alibaba.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
In-Reply-To: <20250828081717-mutt-send-email-mst@kernel.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org>
 <87frdddmni.fsf@redhat.com>
 <CY8PR12MB7195FD9F90C45CC2B17A4776DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <87cy8fej4z.fsf@redhat.com>
 <20250828081717-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 28 Aug 2025 14:22:21 +0200
Message-ID: <87a53jeiv6.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Aug 28 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Aug 28, 2025 at 02:16:28PM +0200, Cornelia Huck wrote:
>> On Thu, Aug 28 2025, Parav Pandit <parav@nvidia.com> wrote:
>> 
>> >> From: Cornelia Huck <cohuck@redhat.com>
>> >> Sent: 27 August 2025 05:04 PM
>> >> 
>> >> On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> 
>> >> > On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
>> >> >> > What I do not understand, is what good does the revert do. Sorry.
>> >> >> >
>> >> >> Let me explain.
>> >> >> It prevents the issue of vblk requests being stuck due to broken VQ.
>> >> >> It prevents the vnet driver start_xmit() to be not stuck on skb completions.
>> >> >
>> >> > This is the part I don't get.  In what scenario, before 43bb40c5b9265
>> >> > start_xmit is not stuck, but after 43bb40c5b9265 it is stuck?
>> >> >
>> >> > Once the device is gone, it is not using any buffers at all.
>> >> 
>> >> What I also don't understand: virtio-ccw does exactly the same thing
>> >> (virtio_break_device(), added in 2014), and it supports surprise removal
>> >> _only_, yet I don't remember seeing bug reports?
>> >
>> > I suspect that stress testing may not have happened for ccw with active vblk Ios and outstanding transmit pkt and cvq commands.
>> > Hard to say as we don't have ccw hw or systems.
>> 
>> cc:ing linux-s390 list. I'd be surprised if nobody ever tested surprise
>> removal on a loaded system in the last 11 years.
>
>
> As it became very clear from follow up discussion, the issue is nothing
> to do with virtio, it is with a broken hypervisor that allows device to
> DMA into guest memory while also telling the guest that the device has
> been removed.
>
> I guess s390 is just not broken like this.

Ah good, I missed that -- that indeed sounds broken, and needs to be
fixed there.


