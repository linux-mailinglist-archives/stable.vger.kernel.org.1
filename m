Return-Path: <stable+bounces-128486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B2A7D85B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DC1167BC0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1D122A7E1;
	Mon,  7 Apr 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RT/3AVT0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9A229B38
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015480; cv=none; b=H26KbGVswqSie8WGq2DTjQ6KEYJlGPzN1KRX60S1hSz685Lp7bdWwb/X2o8qlvOxsi+zzkDr2dEfpmyMpTLSh1rgH01xnMNwH9HcfEJrGR6h2F/yJI84FTYrrnPK7IZQl8oI2StX0osCkq8tuQl8PuSPAMJLNsc9XG/amm/GvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015480; c=relaxed/simple;
	bh=PtiFvCi0OCxZqEy7v1TJKjthTCLnjNTw9mDEXSxL+Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXvr+zNZ48HRDdIA2BIdCRHPmTP+zGuLl/Ik7r6haPbhLArajlSPat0Q8ltocjAURTzu35U41JCQB4IYG7I73ADKyQoFGID8BNE6lT3QTSZlGdfDQqr3tXGzFFjEu49H7ZGZEcWz2YbSaSXjB3PTP6ik34EAH4G6aRiV6vui8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RT/3AVT0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxsyOJ1xzReb7dqRLf34SXfhgO/SwPIG7kI1XoYIq/U=;
	b=RT/3AVT0TVDl9dvu2MbB0201U/CHSEO4EDr9iNyFFqsPaisifv1cGvXYCBfo4Uis6crzxu
	nRdoBWREaoAKgkk9KJiEJ0MvN7Z1pcd00OGhr5+pkhIGk4K68tYqCINnlw8YTAQaUsgoy2
	2pglUdTqVBApgpu9McWjbkzV6MAI89Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-UMSGxs9kMRyiC83RtEQB8w-1; Mon, 07 Apr 2025 04:44:37 -0400
X-MC-Unique: UMSGxs9kMRyiC83RtEQB8w-1
X-Mimecast-MFC-AGG-ID: UMSGxs9kMRyiC83RtEQB8w_1744015476
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3914608e90eso2563127f8f.2
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 01:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015476; x=1744620276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxsyOJ1xzReb7dqRLf34SXfhgO/SwPIG7kI1XoYIq/U=;
        b=DnS9LcqpPPTyGpDGZcW4CtN4UANuOitZqgzC0tg8Ze+uJiksPSTWNf9vPUqTmer4fQ
         9XN6tknjYBRY78qYYxJr+QXSOBqE9jzpSMTYl33K93I0uZqger6rDQsnpUaZh/dN73dc
         Oeg1FDSLYMv2Y7m55KjA0Ix39ipgZ53bhrSTD/Qa/7KmXaE5o7padA9tggH75qw9nnVs
         gBx5FJBPccmAVNun8UwAHPBuCvaMpC0vPuJjk69JG9tUNxKEw/bhXGUMQz+hgbHy2lGK
         FzQtt/UXQtSM0YsVk0WcWjAxswqlYvMOeUFwV1YyzngBlmEStf9RDxEgFmvaHlUd4N6v
         YSMg==
X-Forwarded-Encrypted: i=1; AJvYcCXkTrZhOpHNlrkRr29fsCKIlkcwNt78GvG26R2biUEIRIAE/H2eZjpR/O0w/mQ3HwYAg7wkqHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdfI0NLzGa34ZFK2oU/wCAFTQS9myhizFN1EekQXJjFS8p6EQ
	6mpSfPTlEfmNdjlOPlGjKuI8BsVIucB+dnKoS5vhqIixkCZp/TD89jTfPvX2WiYumt7/BMcWy70
	772rQ2ns0OX1rx7VxAkXkA6qPN/6fXbGJs+vy3amKgIPGizA+8VXvRA==
X-Gm-Gg: ASbGncs5O6udYu0e4BB548ZOxZX5M07KOnp9zW2VNKJwQK7tv/q+Q7xOc24+qXyo8kH
	neiUUYGC8INDLRay26YguO48U2nTmOh8PBtNLN3T/oZw//y9M8qLAjbkJe9LLaTzFWE7BmbgmO9
	NK/nEfK9gECYdxRvlxVGBKnZgLxzmoahweeSPQZk/ZoKw/hO5YdF6BwnstfOYohVMmL/xLax5ou
	b0KnzBgRR765V1okE/1plhwUd3lUZGTWPZgGQvpVunmPldr05hJHP+CMHRPNlMPkh8iUzaC90b0
	+ocoEkletQ==
X-Received: by 2002:a05:6000:2285:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39cadc85ab6mr9887027f8f.0.1744015476158;
        Mon, 07 Apr 2025 01:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5RHnKh0qDdKz/5Ine63hPlJA3HH3Ym3a+73u+PAR+VrXtWlXlmPf7sT0QkaNygBVDWFb9Aw==
X-Received: by 2002:a05:6000:2285:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39cadc85ab6mr9886995f8f.0.1744015475774;
        Mon, 07 Apr 2025 01:44:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226be7sm11211086f8f.89.2025.04.07.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:44:35 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:44:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250407044246-mutt-send-email-mst@kernel.org>
References: <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <39a67ca9-966b-40c1-b080-95d8e2cde376@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a67ca9-966b-40c1-b080-95d8e2cde376@redhat.com>

Wow great job digging through all these hypervisors!

On Mon, Apr 07, 2025 at 10:38:59AM +0200, David Hildenbrand wrote:
> crossvm:
> https://github.com/google/crosvm/blob/main/devices/src/virtio/balloon.rs
> 
> -> Hard-codes queue numbers; does *not* offer/implement
>    VIRTIO_BALLOON_F_STATS_VQ but does offer VIRTIO_BALLOON_F_STATS_VQ
>    and VIRTIO_BALLOON_F_DEFLATE_ON_OOM.
> 
> -> Implements something that is not in the virtio-spec
> 
> const VIRTIO_BALLOON_F_WS_REPORTING: u32 = 8; // Working Set Reporting
> virtqueues
> 
> and
> 
> const WS_DATA_VQ: usize = 5;
> const WS_OP_VQ: usize = 6;
> 
> 
> IIUC, Linux inside cross-vm might actually be problematic? They would
> disagree on the virtqueue for free-page-reporting


That's why things must be tied to negotiated features, not to offered
ones.


> 
> Maybe I am missing something, it's a mess ...

Indeed. Let's fix the implementations while keeping work arounds for
existing ones.

-- 
MST


