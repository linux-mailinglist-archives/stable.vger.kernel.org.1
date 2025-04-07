Return-Path: <stable+bounces-128484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21ACA7D837
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 10:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C593AEA2F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1022837F;
	Mon,  7 Apr 2025 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bx5ZAoS3"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2111227E86
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015314; cv=none; b=n0Di6NO9wLh5Kvet7+XWc+AcMMOPNMyCe+EoAd88+tDYq/CjLKyq+Wn9HusCMeGEoWYH9CW5vGl2VKrw1IANttPWxe648qJbDzjySQk9Zl7T9ausEDEm7t6is/pjHC8ibhswkrWj1VX/LZSwrLCMs2ZjbC4UzqVnhqOiwBXTi9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015314; c=relaxed/simple;
	bh=dubat8tCLJKpXwu98mOgPZCaGLWjN3X5sHoHO7zCnlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4uyc9e0TiCdv1jfbYvQQK4rIZi2RfVt/Sltk9ZWeyw3hI0TpatZLZtqOXEYEzz2CcchmcIN06S3p2EbwP4q2e/4XsmYHeqsAt22IONhc9gxNI4XcISUrbikoLDjdGOanQK9ijmXUHdEuboSl4GzkE1BATwhDr/Km3cPR9AUDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bx5ZAoS3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3pK6yIdPNYZ4p3nnxwbYWeXbQyAyM0EzrK62OMGx28=;
	b=bx5ZAoS3UwOKTWEVPCAen1bCVlFGjOUbOSPgB/Q2yxSxkKyOrfQbALqBG0ANrnoSXWuUM1
	GqjHJG4opdNzy/+jNfBVl0tUccgzpfJgViYAEtTzqi/loIpSqqKxw+K3cRSMjF1CBAVFqH
	vSUhdWj7ZoviBRJ99M11TmGXjRJUTCg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-c5LsGacnNeOVOAOjJB8oDw-1; Mon, 07 Apr 2025 04:41:50 -0400
X-MC-Unique: c5LsGacnNeOVOAOjJB8oDw-1
X-Mimecast-MFC-AGG-ID: c5LsGacnNeOVOAOjJB8oDw_1744015309
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so26286095e9.0
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 01:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015309; x=1744620109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3pK6yIdPNYZ4p3nnxwbYWeXbQyAyM0EzrK62OMGx28=;
        b=lbc0chxVDs7itbfVzfNXciFb74hCGLcBEm41I8bJFIYHaz/re7BvYp5l4tsDTP8Z6Q
         8biL+y3T0M+6cuHd9tCuK1z32yUlJlNOTW818Z54hMtP9a/nvhiZPaHnBKbDgjd76ubf
         QNfvSpIe5Qv2m/7f1xHuciieCjnFBnVBGyU8zDcSOras9P1QbUt6nDnM/bZhrOxUyC1o
         CZ5wbs8R7ODRfgh9KV2sKyVLT30ooa6dR93KPlD66vi4kUmfChOn4fdSwjZrkHZT9A0F
         1SPM8K1342wR6KsRDdUF+b/30FfhaztvwDrK2M4VA5YxROPWrkdSqc+GlVswzRdfFd+g
         +/rg==
X-Forwarded-Encrypted: i=1; AJvYcCWSl/Yly9leYqJeZKK0cPCLzhzJGFDzAn0UxjGAJrDFQJtDJOjcVHOxDlUL+h1d3gi0eO6XrcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqdWhddMHxvAD5trziyq/76fc6Ed2M4NTI9BrjdJ9Nih7SLABf
	D1XoQHVRoRbFzYFrehoDjav1el31B2zuQuLNzvV6YVPBRd3hgHExKm3mPS0Owzec1SL+vsOra/J
	ZVWMCsznJRSmhOn+Or93LlaOrbQgEPJtH0MB9DKnn18LknvFYZWj32w==
X-Gm-Gg: ASbGncupJAY1iKy67Vyz844cm0ENVkdbWt9iCekyLqexuuaep/8dbGwyhUlyx3lbLJC
	+BBpeGISEnVAoQGLbrSncjDDQrd7Tc1//KyPGVwqgF7R0GNkgSCCb0XLW2MSCjLsq+4Vs6w0Aq5
	5DRYT/22cPTbqoWXt++tdZ3S+Y0Uczf9Lg5hZ8WUsBjugPKHO9HMdHNAUcPOxIaHEMNbRmxHkj6
	vy1jIR1gE/pv5prcOs2Le0qP6udQeAz6FOWibz04ES1jQyo3rEH15EBKH6hFHsuoli//6dZQ/Bg
	MVwP/hm7XA==
X-Received: by 2002:a05:600c:5248:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43edf8a28d1mr45333035e9.22.1744015309272;
        Mon, 07 Apr 2025 01:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnMOiX9O9gk9kURjhnnuCNT1UVrytArjtGV7ecRUIBKrJSc0PSzOsjWjaDnmkVaY/+rUOMfQ==
X-Received: by 2002:a05:600c:5248:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43edf8a28d1mr45332875e9.22.1744015308965;
        Mon, 07 Apr 2025 01:41:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c302269a2sm11484143f8f.91.2025.04.07.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:41:48 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:41:45 -0400
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
Message-ID: <20250407044029-mutt-send-email-mst@kernel.org>
References: <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404173910.6581706a.pasic@linux.ibm.com>

On Fri, Apr 04, 2025 at 05:39:10PM +0200, Halil Pasic wrote:
> That basically means that if I was, for the sake of fun do
> 
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1197,7 +1197,6 @@ static unsigned int features[] = {
>         VIRTIO_BALLOON_F_MUST_TELL_HOST,
>         VIRTIO_BALLOON_F_STATS_VQ,
>         VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
> -       VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>         VIRTIO_BALLOON_F_PAGE_POISON,
>         VIRTIO_BALLOON_F_REPORTING,
>  };
> 
> I would end up with virtio_check_driver_offered_feature() calling
> BUG().


I mean, yes, this is exactly to catch drivers that use
features without negotiating them first. 


-- 
MST


