Return-Path: <stable+bounces-131974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38416A82C02
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FE4188A4CF
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052825291E;
	Wed,  9 Apr 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQoXkSEf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A971D5173
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214900; cv=none; b=ifhOVkQce9GzQzhjxYyHOlGiWoOcITs1d2O5XCKGxXtLOdoLsCUZT9G9NBtFdrxtT1T7UpDHpy8jW5UlD4LMCclkMg2YzkzKcEhATHTZVlDkUzZLpdj7/ey3UTRAxQ8h9OvQm5fQDw6CerShPHrAOwg2YILhFfZTe9Kj45l5hso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214900; c=relaxed/simple;
	bh=u88iK1Z2yhXsjmCslV466RjH4vgWiCfX1hsXNmpELU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbXAEKSBokH5top8sFlD4w3d5rZ+rA4+sJYCs6WCmSSzqY2G7RY5tFxznaA9RhkbpTLwEF8FWRy5ITLJYz0myKbQYVhTH0KbTobJCojeWz2SkRiydcGyfx6FK/BVsQztWKbrCeCrQFJUzwCyAL07oha4pNmp83KMx7uF8ZBhjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQoXkSEf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744214897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78AmE8RpcE4a72lQ1mWWnyl8tSqgeIRIaFNrpROmMX8=;
	b=UQoXkSEf65vbljUlHRvM1NaZHh3RS0VA8DtvxLYuz0YTbBXA7kZilNzuJxBIvgxIe7GOdN
	l1wtqngCI67WrPrcxuMJQmkTeg1wi/gXduocM1OO7Fi6SIn25FKpoO61CVYpoHkswoIFGQ
	8Icw6BAOHfjEbPB/LS0v4dvlq/fMNB8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-XfCSBQAEPM2CnsEyWHn1Dw-1; Wed, 09 Apr 2025 12:08:16 -0400
X-MC-Unique: XfCSBQAEPM2CnsEyWHn1Dw-1
X-Mimecast-MFC-AGG-ID: XfCSBQAEPM2CnsEyWHn1Dw_1744214895
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so43798805e9.3
        for <Stable@vger.kernel.org>; Wed, 09 Apr 2025 09:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744214895; x=1744819695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78AmE8RpcE4a72lQ1mWWnyl8tSqgeIRIaFNrpROmMX8=;
        b=cl+E+JLeKftC9edYlq3jLU1jpcYe3mC0D9uitDS1uzKRp137M0ish0yrFV51bKStdW
         HmZsLjOXu0ZydbKCrRsqoOlmYIucXVDt7Dasn9E/yRd3ahGir3ccH8BKNVIE5AJ640Ci
         xkZctmrz32sBT7ZI8gmhFDovS6rVXTP35OKR5qC20aJnPn+6mgLfbUAxOp65aGJ/TnlT
         IuHks9gKEtLROudisGErsH1/6d7kLyk4EfeOTdK5QnQbjp9/GwxKY3sdUUowT2IWZeiM
         yEomSZTWT3HV0hQf7nPpslFdyP77dI8OkqwlePpN1vkWpeyDJ0BljEMMjzPuSK9EN/h9
         yE/g==
X-Forwarded-Encrypted: i=1; AJvYcCWik6uD7IkXRs/EGYS6QM/rgSnlhrfCASpAolINK4mPThg7RTV2dp6x+X1uDURF+/0ocNDCFZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyftER0ilzCv4ZXHTjACkFSOVUX4lEzRnunucbU8Qmtq+n1IZrB
	y9X8wHBETydrVSPGSD/mrglrYB3CMmDIC7Uw7ZQ3hEipu2p7DHz+J8WVpuyAnQwY9DOob2MaDy3
	KV3jH2X+GHbC5HELTmpGQ9R5V9aRq2K7+ra5Sf34iLTNPeT+iQS6gxQ==
X-Gm-Gg: ASbGncuwxCCqXnciEGJSdOK7ECWrFHMqG77NkHHq0A+d2y7JiAmSIP8yj0B5m0XzpbH
	Rb3NLZlN9oy5U5FlL0/VZugGTB1XR9yjHaMU9B8j8ROBrJfy4AM9mLSC/lQwMByawcYx8ACDNex
	KzTD4NUzlJK1V8FgPLc4lqm7TYgZxCOg7XvkKYRc5vfK09VJSLheIa/iboLrTwpPW64oPZv9jh6
	oWiHSpxFjUk2jTu8Va0WT8cvXWNq3Qjx9Plit5ilX6QSH+NM/v4HEDJBPKjn9YGp4dh5jSN79IB
	TtS0gA==
X-Received: by 2002:a05:600c:8518:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43f1ed693ebmr44247925e9.30.1744214895076;
        Wed, 09 Apr 2025 09:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa8WvXPvdR9mW4X+Ki70qXHwL+hlbwdViRmCYAc7xQXDBe/sMhsY1YIaOF1Gj1cQgn8/YTXA==
X-Received: by 2002:a05:600c:8518:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43f1ed693ebmr44247295e9.30.1744214894624;
        Wed, 09 Apr 2025 09:08:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893774aasm2066312f8f.30.2025.04.09.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:08:13 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:08:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>,
	Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250409120320-mutt-send-email-mst@kernel.org>
References: <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
 <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
 <20250407170239-mutt-send-email-mst@kernel.org>
 <440de313-e470-4afa-9f8a-59598fe8dc21@redhat.com>
 <20250409065216-mutt-send-email-mst@kernel.org>
 <4ad4b12e-b474-48bb-a665-6c1dc843cd51@redhat.com>
 <20250409073652-mutt-send-email-mst@kernel.org>
 <5cd8463e-21ed-4c99-a9b2-9af45c6eb7af@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd8463e-21ed-4c99-a9b2-9af45c6eb7af@redhat.com>

On Wed, Apr 09, 2025 at 02:24:32PM +0200, David Hildenbrand wrote:
> On 09.04.25 14:07, Michael S. Tsirkin wrote:
> > On Wed, Apr 09, 2025 at 01:12:19PM +0200, David Hildenbrand wrote:
> > > On 09.04.25 12:56, Michael S. Tsirkin wrote:
> > > > On Wed, Apr 09, 2025 at 12:46:41PM +0200, David Hildenbrand wrote:
> > > > > On 07.04.25 23:20, Michael S. Tsirkin wrote:
> > > > > > On Mon, Apr 07, 2025 at 08:47:05PM +0200, David Hildenbrand wrote:
> > > > > > > > In my opinion, it makes the most sense to keep the spec as it is and
> > > > > > > > change QEMU and the kernel to match, but obviously that's not trivial
> > > > > > > > to do in a way that doesn't break existing devices and drivers.
> > > > > > > 
> > > > > > > If only it would be limited to QEMU and Linux ... :)
> > > > > > > 
> > > > > > > Out of curiosity, assuming we'd make the spec match the current QEMU/Linux
> > > > > > > implementation at least for the 3 involved features only, would there be a
> > > > > > > way to adjust crossvm without any disruption?
> > > > > > > 
> > > > > > > I still have the feeling that it will be rather hard to get that all
> > > > > > > implementations match the spec ... For new features+queues it will be easy
> > > > > > > to force the usage of fixed virtqueue numbers, but for free-page-hinting and
> > > > > > > reporting, it's a mess :(
> > > > > > 
> > > > > > 
> > > > > > Still thinking about a way to fix drivers... We can discuss this
> > > > > > theoretically, maybe?
> > > > > 
> > > > > Yes, absolutely. I took the time to do some more digging; regarding drivers
> > > > > only Linux seems to be problematic.
> > > > > 
> > > > > virtio-win, FreeBSD, NetBSD and OpenBSD and don't seem to support
> > > > > problematic features (free page hinting, free page reporting) in their
> > > > > virtio-balloon implementations.
> > > > > 
> > > > > So from the known drivers, only Linux is applicable.
> > > > > 
> > > > > reporting_vq is either at idx 4/3/2
> > > > > free_page_vq is either at idx 3/2
> > > > > statsq is at idx2 (only relevant if the feature is offered)
> > > > > 
> > > > > So if we could test for the existence of a virtqueue at an idx easily, we
> > > > > could test from highest-to-smallest idx.
> > > > > 
> > > > > But I recall that testing for the existance of a virtqueue on s390x resulted
> > > > > in the problem/deadlock in the first place ...
> > > > > 
> > > > > -- 
> > > > > Cheers,
> > > > > 
> > > > > David / dhildenb
> > > > 
> > > > So let's talk about a new feature bit?
> > > 
> > > Are you thinking about a new feature that switches between "fixed queue
> > > indices" and "compressed queue indices", whereby the latter would be the
> > > legacy default and we would expect all devices to switch to the new
> > > fixed-queue-indices layout?
> > > 
> > > We could make all new features require "fixed-queue-indices".
> > 
> > I see two ways:
> > 1. we make driver behave correctly with in spec and out of spec devices
> >     and we make qemu behave correctly with in spec and out of spec devices
> > 2. a new feature bit
> > 
> > I prefer 1, and when we add a new feature we can also
> > document that it should be in spec if negotiated.
> > 
> > My question is if 1 is practical.
> 
> AFAIKT, 1) implies:
> 
> virtio-balloon:
> 
> a) Driver
> 
> As mentioned above, we'd need a reliable way to test for the existence of a
> virtqueue, so we can e.g., test for reporting_vq idx 4 -> 3 -> 2
> 
> With that we'd be able to support compressed+fixed at the same time.
> 
> Q: Is it possible/feasible?
> 
> b) Device: virtio-balloon: we can fake existence of STAT and
> FREE_PAGE_HINTING easily, such that the compressed layout corresponds to the
> fixed layout easily.
> 
> Q: alternatives? We could try creating multiple queues for the same feature,
> but it's going to be a mess I'm afraid ...
> 
> 
> virtio-fs:
> 
> a) Driver
> 
> Linux does not even implement VIRTIO_FS_F_NOTIFICATION or respect
> VIRTIO_FS_F_NOTIFICATION when calculating queue indices, ...
> 
> b) Device
> 
> Same applies to virtiofsd ...
> 
> Q: Did anybody actually implement VIRTIO_FS_F_NOTIFICATION ever? If not, can
> we just remove it from the spec completely and resolve the issue that way?

Donnu. Vivek?

Or we can check for queue number 1+num_request_queues maybe?
If that exists then it is spec compliant?


> -- 
> Cheers,
> 
> David / dhildenb


