Return-Path: <stable+bounces-128488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A60EA7D872
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F41D3B5143
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392F422A1F1;
	Mon,  7 Apr 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBjHgpqL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C72288EA
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015764; cv=none; b=f35MqtK7mJGSzKu98YWH32DBtUNEVfNX9XeV4cdjDfEEP4iEid3MLgHr+oHUtNUV1S2wwmYuXA2zpSZfHfsb+UVs8stDbebVOi0Nl9VbHQwDdrDd8X5WtP5vwwbg0p0zWuGyYIqGV+xo/TVyk9zzVs7uCdNTFGs7xYLKZwtfoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015764; c=relaxed/simple;
	bh=IZtLDURYDTq0b32MVRHTcY8RDwEllmanE9uQZcvW3gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6o5mX2J4if9B4P1zo5AEs8xj0+STJFdM9onTfV485VWX5tsRZFmtpX4Cn1/YJLnbwXz+6ghLDU10xB/vuocz6xoHbhSebkbReofcjuG51ru3cij61CIyxqlx9Lu42iA0LcAWxwq2iRhgTSwXe6IAyEvAJ5H87n+CJqjiXsFejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBjHgpqL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpu5KqbXEO7FQHIb0ETZFO78MX8aCe7lEYNvf8XqmxY=;
	b=bBjHgpqLOT9Hxr1/6stSSdF9X7KTgTJkI2zyzL85Jk8lRCg8PDUOnZO29eiH9v204rtwlJ
	TNUtN/fGWJu783G0GPwlWMH5VW3QZ8Z7kcRLKzZN9vxzN9vAdajI0SMZoPZnJfjNLgIwIT
	JkLJgUzo7Csz/hZ21WtBP+a1/9+M9MQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-PTfy6FpWN-yC8nzFeXu6xw-1; Mon, 07 Apr 2025 04:49:20 -0400
X-MC-Unique: PTfy6FpWN-yC8nzFeXu6xw-1
X-Mimecast-MFC-AGG-ID: PTfy6FpWN-yC8nzFeXu6xw_1744015759
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so32021185e9.3
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 01:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015758; x=1744620558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hpu5KqbXEO7FQHIb0ETZFO78MX8aCe7lEYNvf8XqmxY=;
        b=VpDOAG7fwrqNJeGNMwDmT5YkjkPoRG/lg+N6Q8eqnKhZGbbt6LGbj2aRP8RNHn4j5v
         S0mIejmGM/SIuowaDJuEmLzhtAR56ATdfvx+uFino7oxkazT2Eb31e07U1fGMZoxD3P5
         VmAfD0y3oK+0vo96jKCr9skxFu3MiHJlBWXTCoCn0/j3BuRdmu/n0AIM3ki9WnZFFJ9/
         fCoFAubFWXecHGJ7QY9yTJv/CraTxIcrnuKpSWXXQyyri7jwugXX8HtsiD8CfDAN+vNE
         HFpb82uIA5rdteMf2A2Si3YYloeJYBMRhgboqNTsJUgxHUcFIVtEnh3tjvtE44x8oy0M
         u7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCW6bZuO5N7rSqvvVAyZoDz//2j6n/H8GNpLCI3pCbgMN5Tz+At+6njgDt3SMGgIeZg+zhBgpHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuVosZ8ax075rq//0XFPjvRfasy+mby0LVsE9vOBw8c6ndUO7
	uGYPDiryVlk90LJizXoDvBp6iR0B9ynNXa0+267k8iZNrtBrwh6YnCqTcw5U3UMvaPoKmDab0+Q
	7Wu5Ng6XQ4WaZNie6PRLJRQv7li/MGdXu3k5s1BLeOqF5TEEm3cKopMzRm62yjA==
X-Gm-Gg: ASbGncsFNSbJOcIn8yVc7SH5YOws/YQIRoSDTv1mOItyHFENM506F1TIBqMVnxO7w86
	Sab3Ysnx7yQHcanChSFUpGKJgIcKChkNUNi4yreIf3/R6X3yg44tU9ZL7uNd5ZCHsyMHx9rkKbm
	bE0TMHRvk2LYezf+3a2zCVz6+ELHphgB+H+V75sXQ4eUjojVcR7vlyefaWkiTIPT8gVw4Dio9WP
	qGBnNSdNm2FCJKcgU1Z/aa7S304Ti1tBu4BFjnlVP2PJy8hXQWKJJON/B9SYBfKRD9/7mAfHULB
	Xk3JNvghAw==
X-Received: by 2002:a05:600c:3306:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-43ee2aff1a0mr38130025e9.32.1744015758295;
        Mon, 07 Apr 2025 01:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNYPVVGEAhzNqS2UPVe5mcCou0C3HnRif0zA9AGHI8Xqo5GZ7Z22p9jJeCaR5blASlwYtuCg==
X-Received: by 2002:a05:600c:3306:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-43ee2aff1a0mr38129915e9.32.1744015757955;
        Mon, 07 Apr 2025 01:49:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7586sm11552495f8f.38.2025.04.07.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:49:17 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:49:14 -0400
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
Message-ID: <20250407044743-mutt-send-email-mst@kernel.org>
References: <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>

On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
> > 
> > 
> > 
> > > Whoever adds new feat_X *must be aware* about all previous features,
> > > otherwise we'd be reusing feature bits and everything falls to pieces.
> > 
> > 
> > The knowledge is supposed be limited to which feature bit to use.
> 
> I think we also have to know which virtqueue bits can be used, right?
> 

what are virtqueue bits? vq number?


-- 
MST


