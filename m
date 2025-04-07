Return-Path: <stable+bounces-128491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D4AA7D8B7
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AEC1895CE5
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17522B584;
	Mon,  7 Apr 2025 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OI6D7Op7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9222A7E8
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016085; cv=none; b=ZDed7XN6SmHy5kXEZfzappc2fGQbJ99GxCws6wGBDkP1u6Zd47Z3lEMfSVh2IJz30PoTJQOlMhvfZAt7LdyvLwF3Zb7X9nkPVN4u03mvlc7Sqd3dyiFt6MLwHUlfnNG0awqUAPj8/5HRLB3i+ptf3DkfDXGzYN7sSwW7pd5xB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016085; c=relaxed/simple;
	bh=R+0sWKhqbThzPkae+5wVut0fKNCyuXS4OYJ/SETg+GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1O5Aome/d/9zd/iMvBosqLVCSJYITz5exzRlFljk717AQRX5ANH1M9No+c385iLBmXXnoruZge+OYj98Saq//a0vdSdB2xh9BzylpnyWuoFV+2ByKSadV3JjClAm9zuCWxjPoRiBm5phl7fdIQDx+GFyK0RU4vm47QGQvO/7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OI6D7Op7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744016082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAmqbLHdw+HuKBAeHI83rPkmOKB4Sfbwt9oiDo5180k=;
	b=OI6D7Op7j81Ld2tGFDWanBI/NtuPw8FNZbFIximhPKwXGVWzDfSaetmGOSkEK8pubNG4be
	sF/cT3ZJprHYxzZVSdhneM1LaaTMEXmQZDpvZ5N10uEKpMjnDe9++2Kv0bXodtdLn0KQl3
	BnI0mG3s0onTc7m/4bAtAKsBonOpVz4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-zZZPJK9uPnSYmTH9-wOLWw-1; Mon, 07 Apr 2025 04:54:41 -0400
X-MC-Unique: zZZPJK9uPnSYmTH9-wOLWw-1
X-Mimecast-MFC-AGG-ID: zZZPJK9uPnSYmTH9-wOLWw_1744016080
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c489babso20260385e9.1
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 01:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016080; x=1744620880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAmqbLHdw+HuKBAeHI83rPkmOKB4Sfbwt9oiDo5180k=;
        b=UThYugQnlR+iWc8Gz6AQkWf/OeUzmvQ35RpV6e5UqaIO0Hf1e91wPHO+uB4ymkJBXs
         73CjGGmE9b0L/z++4LUSe2aDNS2JLPf+lmttpw79mP1nqqAeB3obi5RIZH/FRiLtIb0e
         F8h4G20LVWIKvClt6L2siVi4wHocQirGD4mBYnBLsL8hA+OS3vyKi9akwzZ2KWh/1Juu
         /Tvar6/7ER2PjrJc95RwuKgoIiYuxNLzYgf4jERHWXdtOUD5QyGFf14vEyPrR981ltUA
         ECGpubrCRjE+fuhRRgT15eQ0uXrFYs5XAtXFT63XqkfDz1IX9nTXbG3BkPeMZrhL2OkC
         xArw==
X-Forwarded-Encrypted: i=1; AJvYcCXrH1M5WBxq6vCYUSWOuhp/uY9D7b4HX8gy2w2iJZilQIIMM0Ad7xK/rT+GPMGukUCqWj1IVKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjkV/RR/008hawyWFrLmsSZLfxqpxO1GL0Fnq3Zs24NgLGg1u
	yCziEF/+E0b1AIRXjNEB4DVwpBee2mqHf6UAca0qrWZ6p1I1RD+VQmIWE5QUYrDgXzAEVpBxNGg
	1LEOTmTKJ/5JE4neuesk9cbsnJICTwCqow/rI02fQozk6dZT/7UYnaw==
X-Gm-Gg: ASbGncteszaTIN+370/w2MSy/T4+/62/h5KlXhii72ehZOjGTkR+8Axlx7ymSRvA/9B
	kme+rki6ua6VQh4LmYfiI0omOEhdMwaaplk/3grpWpObRDsx0D4RVKlEAlDQPQzTgjNTt0FX3Kw
	PQsLfybgQOSEP15d3ZINg4ikB1E3fyQ88dJ+YFvq0E38aZqA19gXJ1pWBvwfjfEXN5zNEIBB9fl
	3OyjHVSnZuKnf3orcqtxujn/8LxrTSN2Xz9ndPvtQDgBGXtTsCw7THDULdbf3BsD6VbyFG6u3ad
	mfGLg/xk8w==
X-Received: by 2002:a05:600c:8411:b0:43d:d06:3798 with SMTP id 5b1f17b1804b1-43ecf9fe1f0mr95894195e9.20.1744016080219;
        Mon, 07 Apr 2025 01:54:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH8IW0yqzJPKyGZGPD6qVstVRgqzDFHSOjqPBtRY8GjulSPFiJgnNYxrGMbcuC1XF3d2jQRg==
X-Received: by 2002:a05:600c:8411:b0:43d:d06:3798 with SMTP id 5b1f17b1804b1-43ecf9fe1f0mr95893945e9.20.1744016079846;
        Mon, 07 Apr 2025 01:54:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a75fcsm121633225e9.11.2025.04.07.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:54:39 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:54:36 -0400
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
Message-ID: <20250407045009-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250406144025-mutt-send-email-mst@kernel.org>
 <4450ec71-8a8f-478c-a66e-b53d858beb02@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4450ec71-8a8f-478c-a66e-b53d858beb02@redhat.com>

On Mon, Apr 07, 2025 at 09:18:21AM +0200, David Hildenbrand wrote:
> > Now I am beginning to think we should leave the spec alone
> > and fix the drivers ... Ugh ....
> 
> We could always say that starting with feature X, queue indexes are fixed
> again. E.g., VIRTIO_BALLOON_F_X would have it's virtqueue fixed at index 5,
> independent of the other (older) features where the virtqueue indexes are
> determined like today.
> 
> Won't make the implementation easier, though, I'm afraid.
> 
> (I also thought about a way to query the virtqueue index for a feature, but
> that's probably overengineering)

The best contract we have is the spec. Sometimes it is hopelessly broken
and we have to fix it, but not in this case.

Let's do a theoretical excercise, assuming we want to fix the drivers,
but we also want to have workarounds in place in qemu and in
drivers to support existing ones. How would we go about it?



Maybe we want a feature bit BALLOON_FIXED and ask everyone
to negotiate it?  But if we go this way, we really need to fix
the 48 bit limitation too.




-- 
MST


