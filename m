Return-Path: <stable+bounces-127538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDEA7A56A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25D93B7880
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2824EF8B;
	Thu,  3 Apr 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJpQEpy5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9324EF7F
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690944; cv=none; b=XQfoizg0fHTlPXCG5XixpKRuKJNynxnTlt0xzYWM4zT4x7GSVNA2l/b2d9QGiqdcJfT/0rEoaHYER9XLlzcDKj95Y3YY4P/NlZ4SoGZlzOqbKSqpTQ5VOPA5Iw2d/a/GbKBgnZV6cVRHOqKu/ik/IY+CAAsK9omxpuyUQOaeRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690944; c=relaxed/simple;
	bh=VVx6R47TuFIQGBjJefnPKH6pjjD0ilkcfGKvlV0Oiyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMmH7nNSUn7lY9QUzapvddmmuf1jZhqc7QxeVoE8YprecDwr4EWF5Rz0BQw7pQCsN3PLwW+rUkLcXHuDHi4kd/FK4bg1zIcyG6kArtT5N2mv84L4MtgXBvEy79leSYPzf2dkiv3oMqY37UK5u7+EvArjQVui9kIN5Zu3Hesrir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJpQEpy5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743690940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=378ZLKAn6VFAF4a5RVvN8NmNgzNa+OCnXLX5wlVPRjk=;
	b=QJpQEpy58QyUSKrLbLvyTFG29xRpu3vyB+xV53Hg8c0HSAusDwSDktZt7BrTm3CEFeu/GE
	9SZRJI5SGRY+CZijeanGCHrlz0Cy+wWB0dopfK9j6DV9dMUbi5+AZk4E6cmv51hQYE1Dgn
	iMtcWLbgmEA1Tkh5pAponu1cDfNmKDc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-88wYN8LvOYCX2NOq2JxTZA-1; Thu, 03 Apr 2025 10:35:39 -0400
X-MC-Unique: 88wYN8LvOYCX2NOq2JxTZA-1
X-Mimecast-MFC-AGG-ID: 88wYN8LvOYCX2NOq2JxTZA_1743690938
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so5967795e9.3
        for <Stable@vger.kernel.org>; Thu, 03 Apr 2025 07:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690937; x=1744295737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=378ZLKAn6VFAF4a5RVvN8NmNgzNa+OCnXLX5wlVPRjk=;
        b=myCXqwmrq9dJzhDDWIHTh5O1pbJJBaBJC4gfAHN8RgCdTj5CjZ89+XGzzvMfEhgJoh
         r5QlDm56+270Ux4P/BA/wrZmmdm/Gf9jaFAZ7v6cFLVilu+MbeKwDpEp5gpt8HSnr9lb
         sw/lofBSq2u8s1dHGcwgnz0Om7EgDWMefp90DNKmU6XOvGO8mAADC1kzgKI4uftn3Mv8
         IKwANNYvSEnCdZVoKAQFFK3jKJ0hGQ/ZvIWopIZvcH7VRX0Wh9lM9+K3/2ulb4CirCh8
         tKU3DDFpUyO7x0+tSI7t2CyKowreVPHNV0qukK0GOeVfrBIpYZI8cUpmq8vWd9WapzSJ
         19Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWNKDpQ0j2ZPemOB/fZufIfM+c4GNsMGRI0wBdANUOdvm64vd0wUM3WBpa35efVrH9hyeG8mRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlO3PpPZ8fiQG2pMIWbj3zDXfWeX1e6wkyEF7w2adOLw5i3r77
	bOA7M/st0sKezxu/MxeQryiKpYIc2X6nS4BoPFFPOnPSLgvbBoZJ4xCHlO0FJ7Q9QqAOf/IbY0J
	PieSFQ2HXVlY8SXXFU6UBeFDtwQU3m71d/E4bxDRmMdPCiiG0p0koczARRHGZ2g==
X-Gm-Gg: ASbGncvMlURDL3UguoAufwUNwkWnNd9QtJpwMwDEW7gEgsZhZWvyQuMRFykrpvBg6Ac
	iNpml0mBwwYpyERVUC6R3mWRnleKLQDFbJd22GDKz1HdsaHdIt2McY5836Jp717cn6/cuKHMHih
	RMd9ofUY31ZTyAtF7EtlisASE9I99knYW+96qMmpHrX3V61WZAlDEJP1Z4V/5ru8uVwh124oKc1
	AhqdxAiZujDWbfRx/Gj/m6sJfv2k07hyIowXDdS5aXFMonaG8ergUNrYS/gRkl24pQuuBUianS3
	S5o9CYRaLw==
X-Received: by 2002:a05:6000:2503:b0:399:737f:4de3 with SMTP id ffacd0b85a97d-39c303389ecmr2163817f8f.29.1743690937504;
        Thu, 03 Apr 2025 07:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMqd/k72wEUHJmQoR1gc5ioRBplFkIbZAtw9O7H6BmO4sOWQ/nHk2zg4ZobK6Yp864CCo+5w==
X-Received: by 2002:a05:6000:2503:b0:399:737f:4de3 with SMTP id ffacd0b85a97d-39c303389ecmr2163797f8f.29.1743690937132;
        Thu, 03 Apr 2025 07:35:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c300968c4sm1999368f8f.9.2025.04.03.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:35:36 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:35:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250403103127-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403161836.7fe9fea5.pasic@linux.ibm.com>

On Thu, Apr 03, 2025 at 04:18:36PM +0200, Halil Pasic wrote:
> On Wed,  2 Apr 2025 22:36:21 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> > If we finds a vq without a name in our input array in
> > virtio_ccw_find_vqs(), we treat it as "non-existing" and set the vq pointer
> > to NULL; we will not call virtio_ccw_setup_vq() to allocate/setup a vq.
> > 
> > Consequently, we create only a queue if it actually exists (name != NULL)
> > and assign an incremental queue index to each such existing queue.
> 
> First and foremost: thank you for addressing this! I have to admit, I'm
> still plagued by some cognitive dissonance here. Please bear with me.
> 
> For starters the commit message of a229989d975e ("virtio: don't
> allocate vqs when names[i] = NULL") goes like this:
> """
>     virtio: don't allocate vqs when names[i] = NULL
>     
>     Some vqs may not need to be allocated when their related feature bits
>     are disabled. So callers may pass in such vqs with "names = NULL".
>     Then we skip such vq allocations.
> """
> 
> In my reading it does not talk about "non-existent" queues, but queues
> that do not need to be allocated. This could make sense for something
> like virtio-net where controlq 2N is with N being max_virtqueue_pairs.
> 
> I guess for the guest it could make sense to not set up some of the
> queues initially, but those, I guess would be perfectly existent queues
> spec-wise and we would expect the index of controlq being 2N. And the
> queues that don't get set up initially can get set up later. At least
> this is my naive understanding at the moment.
> 
> Now apparently there is a different case where queues may or may not
> exist, but we would, for some reason like to have the non-existent
> queues in the array, because for an other set of features negotiated
> those queues would actually exist and occupy and index. Frankly
> I don't fully comprehend it at the moment, but I will have another look
> at the code and at the spec.
> 
> So lookign at the spec for virtio-ballon I see:
> 
> 
> 
> 5.5.2 Virtqueues
> 
> 0
>     inflateq 
> 1
>     deflateq 
> 2
>     statsq 
> 3
>     free_page_vq 
> 4
>     reporting_vq

Indeed. Unfortunately, no one at all implemented this properly as
per spec :(.

Balloon is the worst offender here but other devices are broken
too in some configurations.


Given it has been like this for many years I'm inclined in this
instance to fix the spec not the implementations.




> statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> 
> free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> 
> reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set. 
> 
> Which is IMHO weird.  I used to think about the number in front of the
> name as the virtqueue index. But based on this patch I'm wondering if
> that is compatible with the approach of this patch.
> 
> What does for example mean if we have VIRTIO_BALLOON_F_STATS_VQ not
> offered, VIRTIO_BALLOON_F_FREE_PAGE_HINT offered but not negotiated
> and VIRTIO_BALLOON_F_PAGE_REPORTING negotiated.
> 
> One reading of the things is that statq is does not exist for sure,
> free_page_vq is a little tricky because "is set" is not precise enough,
> and reporting_vq exists for sure. And in your reading of the spec, if
> I understood you correctly and we assume that free_page_vq does not
> exist, it has index 2. But I from the top of my head, I don't know why
> interpreting the spec like it reporting_vq has index 4 and indexes 2
> and 3 are not mapped to existing-queues would be considered wrong.
> 
> And even if we do want reportig_vq to have index 2, the virtio-balloon
> code could still give us an array where reportig_vq is at index 2. Why
> not?
> 
> Sorry this ended up being a very long rant. the bottom line is that, I
> lack conceptual clarity on where the problem exactly is and how it needs
> to be addressed. I would like to understand this properly before moving
> forward.
> 
> [..]
> > 
> > There was recently a discussion [1] whether the "holes" should be
> > treated differently again, effectively assigning also non-existing
> > queues a queue index: that should also fix the issue, but requires other
> > workarounds to not break existing setups.


Yep. I tried that, and it is basically a terrible mess :(.


> > 
> 
> Sorry I have to have a look at that discussion. Maybe it will answer
> some my questions.
> 
> > Let's fix it without affecting existing setups for now by properly ignoring
> > the non-existing queues, so the indicator bits will match the queue
> > indexes.
> 
> Just one question. My understanding is that the crux is that Linux
> and QEMU (or the driver and the device) disagree at which index
> reporting_vq is actually sitting. Is that right?
> 
> Regards,


> Halil


