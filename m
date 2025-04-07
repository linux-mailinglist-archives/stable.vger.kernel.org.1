Return-Path: <stable+bounces-128501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8790AA7D9CF
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 11:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FC6168D7D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF72230278;
	Mon,  7 Apr 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULpTT6T6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20BC22FDF3
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018679; cv=none; b=UCHaRGEe2/vL6az05bxd3KiKgKa7N8PFG7hJB5Vtdz2K+Uwpl48m4CDf7BzS/OJN93hOOp7XxnddjWiKQIcqxWXaC3lHK137G8n+SK1pQ1Sb76lsFleU2Eh2HZvW/c/NDrUhUg0nKNdkflzaGrtHnH7h40OJdbj+8vsWMcizUdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018679; c=relaxed/simple;
	bh=UYVpnQToVhKkeD2a7choe2evBwk4oKQuBCk3T1e9dSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAODZAIBszNVd9LZXaCnh/+J6yiKOMBmyIBP+QCxtkTj/Yq9rV5YEE+t9l7yyMUW98C9jXZRHOhM/zyt0Yd2vQEjVnEGJNwQs5NanuJ/7ox6zonipym1cIl2wtcTXpruixqUwt7K7/BTQsKFuhiOyEbyeuZcRyzhlUtboSmrXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULpTT6T6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744018676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTru+5exuSFoOa7/E+HIvTf2c8suoUygvHtY3wcFXLI=;
	b=ULpTT6T6iGiNJcL3sX2ESxUoQhcAzY3E4DKrinfNzGVX6P8HQCbJ520+YNyhZ7PnA++irY
	PixymnCwgQaFh0pcB3TzarF1Fq7Itz22G7hEafH84ugh7ZPLv8zX5HuGeVePP652+9U95x
	Bj016KmptQo00vFgMNhk+mfXzft3Go4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-upW6kD9ONHGbzYm_vS2VgA-1; Mon, 07 Apr 2025 05:37:55 -0400
X-MC-Unique: upW6kD9ONHGbzYm_vS2VgA-1
X-Mimecast-MFC-AGG-ID: upW6kD9ONHGbzYm_vS2VgA_1744018675
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so27617275e9.2
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 02:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744018674; x=1744623474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTru+5exuSFoOa7/E+HIvTf2c8suoUygvHtY3wcFXLI=;
        b=tetDlfeB0fCP5EbWl41E0SLKORNaL8tKTjbywqgbQShTDD/GcirihFCLddYrGul6ed
         pWzo1qpIHeEm3S7+WAe4YdjNVqhey43eyKqGIeY9+1TunMNO08OJw7Dz11j7gy2CiB+j
         xgZ0rtGpKcEklmVJ6Kw8yMvDdvCroYjFZ8bsWjdcqjALnpP2T1YC5VomhGDjNVzZKYjj
         U/YWGrFAmW5Po3X73R3OYUpwNcZ8KjZKKZycVLqN5HZEGJmF5DOhx6Gl35ViuGWdJPNS
         mxHnWiuPIfyhV0htIHKUIM0suU8xZSmGimhde/cFSfbDcEMYsf7x7fGsfQMxOf7+JCr8
         M6ig==
X-Forwarded-Encrypted: i=1; AJvYcCWWE4B+XmX86ss9gBJnmEXIH3mF5vtFJX7myccJC3XBJS5Y9Nebwim5NQbvp97/yN0SfvsBH3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7eAWzcaiB4DWJ9VMqx0lu79GZVOwHXVMvQuJeJpAKOjDI1c/
	ns9ykbUgxz5ZxyBEe5hMN+nfIxoYOgdlkEv6unEEqk83aFl3HIfeCHPjXNJyPQE7fHbHsl0soP6
	8qnieaisAB7/d2iPnQFhTtGH1O0FLWMBjLE/u+ENya7nY20dD5if39w==
X-Gm-Gg: ASbGncvx/nK+ek3swSEchC8mYWim6a0q8Wj4iBcUl59PxHPx+b4rpUn+DF+wsKmUAvR
	kdGAJluNm5KnCw1D3T3nF4tVldry9XTGrs2C3AagDnp2N/FlMvOSZvbcB/0F3eQUx9FMqH7ciTK
	iSRNxOl/bFV9m+iJe78iMqxF49yM7LehwL9wSPNA9BDhnJDL4+9yvu+9PwhkrkZmGXyVzQriw8G
	LtA+dEhnOOsrmiqSKqJuOySOinXdMvJVIzp77jXVL6KM5H0SzUlpbYdzd0ng1W5yHYURv8Of2Ug
	6KUr/fiLZg==
X-Received: by 2002:a05:600c:470d:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43ecf85f23bmr79396925e9.11.1744018674548;
        Mon, 07 Apr 2025 02:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRDexwe+g43YwqQL8SzrJOq1OlI7SDdhXyepzHhoBm7gIYyJsaf0/QWV3+ztzeILwqBFtKrA==
X-Received: by 2002:a05:600c:470d:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43ecf85f23bmr79396625e9.11.1744018674172;
        Mon, 07 Apr 2025 02:37:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b33c2sm132022505e9.40.2025.04.07.02.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:37:53 -0700 (PDT)
Date: Mon, 7 Apr 2025 05:37:50 -0400
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
Message-ID: <20250407053037-mutt-send-email-mst@kernel.org>
References: <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
 <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
 <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>

On Mon, Apr 07, 2025 at 11:11:34AM +0200, David Hildenbrand wrote:
> On 07.04.25 10:58, Michael S. Tsirkin wrote:
> > On Mon, Apr 07, 2025 at 10:54:00AM +0200, David Hildenbrand wrote:
> > > On 07.04.25 10:49, Michael S. Tsirkin wrote:
> > > > On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > Whoever adds new feat_X *must be aware* about all previous features,
> > > > > > > otherwise we'd be reusing feature bits and everything falls to pieces.
> > > > > > 
> > > > > > 
> > > > > > The knowledge is supposed be limited to which feature bit to use.
> > > > > 
> > > > > I think we also have to know which virtqueue bits can be used, right?
> > > > > 
> > > > 
> > > > what are virtqueue bits? vq number?
> > > 
> > > Yes, sorry.
> > 
> > I got confused myself, it's vq index actually now, we made the spec
> > consistent with that terminology. used to be number/index
> > interchangeably.
> > 
> > > Assume cross-vm as an example. It would make use of virtqueue indexes 5+6
> > > with their VIRTIO_BALLOON_F_WS_REPORTING.
> > 
> > 
> > crossvm guys really should have reserved the feature bit even if they
> > did not bother specifying it. Let's reserve it now at least?
> 
> Along with the virtqueue indices, right?

Well ... as long as the implementation is careful to check that feature
is negotiated, reusing vq index at least causes no trouble for others.


> Note that there was
> 
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02503.html
> 
> and
> 
> https://groups.oasis-open.org/communities/community-home/digestviewer/viewthread?GroupId=3973&MessageKey=afb07613-f56c-4d40-8981-2fad1c723998&CommunityKey=2f26be99-3aa1-48f6-93a5-018dce262226&hlmlt=VT
> 
> But it only was RFC, and as the QEMU implementation didn't materialize,
> nobody seemed to care ...

Thanks! I will try poke the author again.


> > 
> > 
> > > So whatever feature another device implements couldn't use this feature bit
> > > or these virtqueue indexes.
> > > 
> > > (as long the other device never intends to implement
> > > VIRTIO_BALLOON_F_WS_REPORTING, the virtqueue indexes could be reused. But
> > > the spec will also be a mess, because virtqueue indexes could also have
> > > duplicate meanings ... ugh)
> > 
> > what do they do with vq indices btw?
> 
> See above links, they use the two for "s_vq and notification_vq".
> 
> -- 
> Cheers,
> 
> David / dhildenb


