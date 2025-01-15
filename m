Return-Path: <stable+bounces-108681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0314CA11B5C
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 08:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC273A697A
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6F622F152;
	Wed, 15 Jan 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Ct43ahka";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKBu93XS"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A041DB123;
	Wed, 15 Jan 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927844; cv=none; b=Fx1U4AjNuVNXj+1A5rOkcln+5yAzC2KDmm0r8DOW17zqo+RPkbSSMgvgaFKD/6fPxcX4AB2lFmExVC+dRvyPURM88g+yKVZqQilIWzJnJvchJH4FV5apqvVLw1FPr99GwiQ3otAV3sEXqgz1fMRBpydBoOwqRQKEjr9TK+x+Jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927844; c=relaxed/simple;
	bh=qsvzSv0qRBJdleSHYPPiUrC/+SObfNvqoObJnmciACI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAtr3j1rBXweuMYHyMGJZWTEQZLAxm+Nd66wKq4whOunQscOoej8JxRow+pllHZCzYAyyxQPb3/Iv2LWQFnhgyyrNA5RqBkrbZwShT36rAGgTbF4bLI+Bk20yAI1In/2588L3mnqoEz95WAlj45B+xZVYaUaEHHlTljko/oGGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Ct43ahka; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKBu93XS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C8EE1140212;
	Wed, 15 Jan 2025 02:57:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jan 2025 02:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736927841; x=1737014241; bh=w563hfhd+B
	DMMJr6Q3ZoixUAdyy5P1R3/CjpcfLHGlw=; b=Ct43ahkaX2qeC6CUwi9pZL2QGV
	U98ClqNRLOtjZDgvUInlVgdwVfbJHjgFjZ3x5jsEbQo7IaPTNLRx+nxjaTfzgMNu
	1lmYm6lOK/JySfQ1ZfsTN9gxJp+CZwIoORgdf9esYldxRMh0OObxt1Z6/mZ+pXyx
	JAJrNUsU74jWA+lQjXtauV2/rC049cutSLGztTUtzmvL36HJPi1fdvo92q1y4BkM
	tISVAT57gM5r5RNZ6IK8LMf8EuO5u30YqWRYN8jieq5M+xnyEVhNIpsyk1ufoR+r
	KwpwT0aM9sX70oDfFFNhF0Nz7uHrRTIEf30iGCPmkGVDgvQCoCxdMHh0cLAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736927841; x=1737014241; bh=w563hfhd+BDMMJr6Q3ZoixUAdyy5P1R3/Cj
	pcfLHGlw=; b=LKBu93XSkSgDKogkMHENVfCbf+Dq5V+N/7XkSQu82UmliViS1u1
	RrhzPU3yESG1JFCCQ3U7Dc9Pv20pQbmM9n2A5kYFPbHfFzh13zn26MnOpo4rL+Og
	vmOxl/IdK+G1NJSzypFL/mOV8wOUX817zH1r2luYNgyhJq882LofonK1W7K8DNjS
	FrUT/o9QFsTh4J5V4SCrCPAlT9CPfWZVR/W2uMir5jcuSboatxsNxm9Zib1dyYbl
	MRxg6p6/eit5t38yLf6qvqmwrhtg6KWnOr8cdsXcc7mdrq6g0HULub6Mwo4tomQH
	DtxR5KcmRFriYItF8yft0easF0QDRxx2vbA==
X-ME-Sender: <xms:YWqHZ95IER35KFnhpzpUCn7oshmhTJK4CKoFnUxM7NR9cnGWQMUj0w>
    <xme:YWqHZ66WceC15P3Aki4EcP32gOgfQCFMOEOHrQRlPkjKkOiYo5UP5O99IywTrPMEB
    jNE9YWedGaWjw>
X-ME-Received: <xmr:YWqHZ0fUhWGNorjesj7TOi7AQldUvkoKdTit1EfYN7vH5jiO58DFPsYtDGuuJkXwfy3yKPbaEr93m56Q7nZxfcBR2R8tWJc5eqt0KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehjedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueef
    hffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhgvnhhqihhujhhiieeiieesghhmrghilhdrtg
    homhdprhgtphhtthhopehnihhpuhhnrdhguhhpthgrsegrmhgurdgtohhmpdhrtghpthht
    ohepnhhikhhhihhlrdgrghgrrhifrghlsegrmhgurdgtohhmpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggr
    ihhjihgrjhhuudelledtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtrggslhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YWqHZ2KYCksQIpHvNGkIyiSSTHIoWbHEU2PK0ZH8ic2jh2bR2JZRDg>
    <xmx:YWqHZxKyBit6Fd3_isHh69hTO017G7tWkPA9yRlKhSC9Mlyv3bSKoQ>
    <xmx:YWqHZ_yZVJuP8IAGrYh84IuOt59Rhma0nac1ApvVPQLSpF-UGGQ_Sw>
    <xmx:YWqHZ9KJSxSFwfM1bE4oDzKJF4-uFS8glREwEzoYNhGYjAXQWzMzQQ>
    <xmx:YWqHZ7CiFZjLVyuVVQm25KaHW58TMg1tpxGm2uk8Ugiys-qlCf9S683l>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 02:57:20 -0500 (EST)
Date: Wed, 15 Jan 2025 08:57:19 +0100
From: Greg KH <greg@kroah.com>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: nipun.gupta@amd.com, nikhil.agarwal@amd.com,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] cdx: Fix possible UAF error in driver_override_show()
Message-ID: <2025011523-stage-snowbound-291a@gregkh>
References: <20241112162338.39689-1-chenqiuji666@gmail.com>
 <2024111230-snowdrop-haven-3a54@gregkh>
 <CANgpojV8P7+LmDPNiJWezER6PK83Wj_QyX8iOKzfxO98WkSnDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgpojV8P7+LmDPNiJWezER6PK83Wj_QyX8iOKzfxO98WkSnDg@mail.gmail.com>

On Wed, Jan 15, 2025 at 12:04:16PM +0800, Qiu-ji Chen wrote:
> > > ---
> > >  drivers/cdx/cdx.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > > index 07371cb653d3..4af1901c9d52 100644
> > > --- a/drivers/cdx/cdx.c
> > > +++ b/drivers/cdx/cdx.c
> > > @@ -470,8 +470,12 @@ static ssize_t driver_override_show(struct device *dev,
> > >                                   struct device_attribute *attr, char *buf)
> > >  {
> > >       struct cdx_device *cdx_dev = to_cdx_device(dev);
> > > +     ssize_t len;
> > >
> > > -     return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
> > > +     device_lock(dev);
> > > +     len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
> > > +     device_unlock(dev);
> >
> > No, you should not need to lock a device in a sysfs callback like this,
> > especially for just printing out a string.
> 
> This function is part of DEVICE_ATTR_RW, which includes both
> driver_override_show() and driver_override_store(). These functions
> can be executed concurrently in sysfs.
> 
> The driver_override_store() function uses driver_set_override() to
> update the driver_override value, and driver_set_override() internally
> locks the device (device_lock(dev)). If driver_override_show() reads
> cdx_dev->driver_override without locking, it could potentially access
> a freed pointer if driver_override_store() frees the string
> concurrently. This could lead to printing a kernel address, which is a
> security risk since DEVICE_ATTR can be read by all users.

Ah, I missed the mess in driver_override_store(), so yes, that does make
more sense now.  Please document this in the changelog so we understand
it when you resubmit it as normally, we do not care about racing in
sysfs attributes because it does not matter for simple values.

thanks,

greg k-h

