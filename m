Return-Path: <stable+bounces-128277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98DA7B75B
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 07:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5007A178A41
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 05:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B891624DD;
	Fri,  4 Apr 2025 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWgGmVDV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E42E62C0
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744817; cv=none; b=dKN8OsuU+A39TRkKyzUZ2tOBCpmlx51QuM46rPeS2Bbxxruwe51bacRvQo0xcbEU4q0QSizTsLJKFv+wK1LM6G0b8Cwp0+hqFgsadzzfyrflYdXi8ywllr+jvJ5CiSpRMdly9tQvBaBXRKU76pvRLK5zLKcXC447Wu/1gdnyF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744817; c=relaxed/simple;
	bh=t5YrEvo1Qv7V/OOCE0jzPDPPWuEcHK5DHyugrkXD3oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryunYYsT7ud2w/w9/4IquMaT3oZbqTPmk6dUixVAISiqrW9Pe0pz3XpnWfprMMKeo57fbp6M7eAIN6VS+SxzeI1vTK88X3TJnL9/z9M0Yoz8JLwvqT0lWnUm0728HNQ/BDPc5v90hZY1Z7wtjuHWl2WPNhr1K32yP3T54zWx+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWgGmVDV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743744815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8DadzuBkB0b+TswMeRC57LXNTfY/qY6jGCVQ+lHwe0=;
	b=RWgGmVDVEz2mbKbGB/sZ/+MSuhg3xTGQWDw5nXp1ATy/WmNtcLDQkdVaWKBnWso3QUMmQe
	V22vKxkcmsBVGkq4R0nja3WP7cCbQqrFmIr/FOh6/CpV+kqqKQjytir+cbxT1aok1rW0bq
	nZE4tjtqjfmHpnRfwFF+Zxhcc/ybTlQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-rw7wkYhLN-y9c-nmto45Rw-1; Fri, 04 Apr 2025 01:33:33 -0400
X-MC-Unique: rw7wkYhLN-y9c-nmto45Rw-1
X-Mimecast-MFC-AGG-ID: rw7wkYhLN-y9c-nmto45Rw_1743744813
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c489babso8248835e9.1
        for <Stable@vger.kernel.org>; Thu, 03 Apr 2025 22:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743744812; x=1744349612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8DadzuBkB0b+TswMeRC57LXNTfY/qY6jGCVQ+lHwe0=;
        b=Wir4b6PJyE9WjwvdjMoh+HiYc2F/VFHAhrRFnUXLenhv04KPSY8K5V55QG4o2GXErP
         RNxBbwYSuXR/Oy0KjVOhh/2QfDv4TCLuCR/C2yZs21oaJK5DFGyUeZkE59B+AOnFP6gx
         rSRZE2fXIrKw81BVHr1X2LRJDT39ID53spSleI052UNDFl2b0HIOjLZKhLWrYogHLZUp
         MtVbe3O/J1IGAw/GSSVe9Zn8uMb/unfNf2ozTIfXApZ6PKpFVUPBe/qcSssCPgsv2UsB
         jB99c4M+J/cayN0in2zJrtYfEhiBFG6e6oO9JY9iNqw+vBRTNsmc23kxoRBCSJXpMSMl
         SV0w==
X-Forwarded-Encrypted: i=1; AJvYcCXPO89aIQXJ9z1GSG63HNP+9JNvHBd3Br5jlj+Yf2M5Y+CeH0fQVUhB75sordQeWjQlmgaJZeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmnCW0r4xjxOJistagcyBXvS9MAsL/Cjt+5X9Z4rMPvIBsuoa
	FdwgFavGHmGCg7U25kfBa9/RDd03U9+nwPa1WWb6xNbSlMcQl8L77BWt2MhdXYAhOG1SSddPqEm
	Qvs08S1c5tSRffDoMbiyaeG/PNFszUr/gPNdIWJ9jHAA5upgCQvKFNlhPpxKXDw==
X-Gm-Gg: ASbGncuQ1G9Lpy2nkkZa1FK5MOuiOuJDb/svjyqu/jutqtJFeZpPvps52jfSN7yiDzh
	TYrWt/H+tFgV/Y9tqmcUrsS7TWAGk//Dl3x6LGCb1RjU+sbqvDncn0dQE3a9L9K3qhiYxyMYgfz
	ESgrfUV/IcfFlD8aZvx+pIMsz2XK7QdlVtrA9RI9pZpkmwFPcU5AjJnEZicAgTxfyfxNhY97NfK
	wylmNUI2TMNPyV6pYpRTMN0cquSCpOQjaL9AdFKjKOCPkbpz2aWbuNzzGsF31hPhsj62P9Ie+xg
	mAZduhIrbg==
X-Received: by 2002:a05:600c:6986:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-43ecf822cf4mr12380165e9.6.1743744812316;
        Thu, 03 Apr 2025 22:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOWcVoqDuuU1EzwnYMSgwjMR/a8JCeY7bzgZQlbtecRuO04aJY8fG8iABZRmySxq9rz0/+0A==
X-Received: by 2002:a05:600c:6986:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-43ecf822cf4mr12380055e9.6.1743744811973;
        Thu, 03 Apr 2025 22:33:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm36561555e9.4.2025.04.03.22.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 22:33:31 -0700 (PDT)
Date: Fri, 4 Apr 2025 01:33:28 -0400
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
Message-ID: <20250404013208-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <20250403103127-mutt-send-email-mst@kernel.org>
 <20250404060204.04db301d.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404060204.04db301d.pasic@linux.ibm.com>

On Fri, Apr 04, 2025 at 06:02:04AM +0200, Halil Pasic wrote:
> On Thu, 3 Apr 2025 10:35:33 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Apr 03, 2025 at 04:18:36PM +0200, Halil Pasic wrote:
> > > On Wed,  2 Apr 2025 22:36:21 +0200
> [..]
> > > 
> > > 5.5.2 Virtqueues
> > > 
> > > 0
> > >     inflateq 
> > > 1
> > >     deflateq 
> > > 2
> > >     statsq 
> > > 3
> > >     free_page_vq 
> > > 4
> > >     reporting_vq  
> > 
> > Indeed. Unfortunately, no one at all implemented this properly as
> > per spec :(.
> > 
> > Balloon is the worst offender here but other devices are broken
> > too in some configurations.
> > 
> > 
> > Given it has been like this for many years I'm inclined in this
> > instance to fix the spec not the implementations.
> > 
> 
> I understand! For me at least knowing if we are going to change the
> spec or the implementations is pretty important. It would probably
> make sense to spin a patch for the spec, just for the unlikely case that
> somebody did end up implementing this by the spec and wants to protest.
> 
> I think, a consequence of this design is that all queues need to be
> created and allocated at initialization time.

Why? after feature negotiation.

> I mean in the spec we have something like 
> """
> 5.1.6.5.6.1 Driver Requirements: Automatic receive steering in multiqueue mode
> The driver MUST configure the virtqueues before enabling them with the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command. 
> """
> 
> For example one could want to hotplug 2 more vCPUs and still have a
> queue-pair per cpu (and a controlq). Those 2 extra queue-pairs could
> in theory be allocated on-demand instead of having to allocate memory
> for the rings for all the queues corresponding to the maxed out setup.
> I've had a look at the Linux virtio-net and it does allocate all the
> queues up front.
> 
> Also with this design, I believe we would effectively prohibit "holes".

For existing devices at least.

> Now if holes are prohibited, IMHO it does not make a whole lot of
> sense for the virtio_find_vqs() to support holes. Because the holes
> and a fair amount of complexity. Of course that would make sense as a
> cleanup on top.
> 
> Regards,
> Halil




