Return-Path: <stable+bounces-86483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 680559A082E
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46DCB25417
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB831202F98;
	Wed, 16 Oct 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrFdDo9V"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA171B0F0D
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077398; cv=none; b=YU0sqsDKrgu8PkumYAMlIAqQgHbHf1zHEXu6rb6H5M6R66LodENZL7Wb2Stz98YcesQbHJRvQZ2Lwlpcha4/r/bQCoKxfODT5BU/SNetx4pf9WXxtgjRYxA2KglWRsxjhksLpk9al1KDwah7QW5jP567M6KLRpiYh4TmyjETUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077398; c=relaxed/simple;
	bh=ionG4jDjTyVSCbBxsm9pbenqEucVFWILHnagSxWDumc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mj4Bi5kcKecEcShqECaFfGKSm1hHscsfwIFvqPu6oiL3lHi1akRbtV9Fxg53060k4PjCQazgG6OhJQ+xDUk6fXpMVCny3gAAXt98XWXH66dAseDBZk8d80ntWKzEfrNBl7zsy3vMLudwTc0T7Nx3FOVEYL+DFFcvxrz5GLtT9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrFdDo9V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729077396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ionG4jDjTyVSCbBxsm9pbenqEucVFWILHnagSxWDumc=;
	b=BrFdDo9VKSPz8kBaY39X0spgy26ENQH8k/0TvkN5vZp0Wzv5dE23YtTfBAxpsOyJ8aGimx
	tZpLCaxYK7jqWHUFqo/RLkwuabz72/LKfzdouT/DJD/PIKpgpux41ngryHy19mi8yCWP9a
	T9av996x6uqd1lHCxQZnRkcq55wg+Tw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-BKDhUEIbNYyRUma4JERvZw-1; Wed, 16 Oct 2024 07:16:35 -0400
X-MC-Unique: BKDhUEIbNYyRUma4JERvZw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43052e05c8fso43624175e9.2
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 04:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729077394; x=1729682194;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ionG4jDjTyVSCbBxsm9pbenqEucVFWILHnagSxWDumc=;
        b=XoyugiArYt2gppb4xrZkMnJWV8YJxXz0aDjgfGsY1LR/Mm9yOumGORzjV3bDQDofix
         aXc5rRp7tCq5vUmELmt/vBnboAqIKN4ShUPJshgj7JFAnTfleEgwoM4oeCc/kUMaQVf5
         K7O0EOqyEZfBVmI0SRXOicEYeQUdJuZWbkY+q2HkdsLs2IUk2u+vRABCPRspDdGtFCjQ
         Ae/dTcT0WW3JiLPmM6o0ESjIfxB6ciS7QD6ggWh3M/cyvPTYEpOhgxG0zfhj8gtOO5g1
         SrPKHRRY7RpM7yLNoDlVTlLMLzjHdriTDW0TEO6vTRJfuTVCLIbqUCGl6/HCtTq2+Zpu
         3SOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoKG5jJAp+clobTmRvM0G/9IbXCHQQ6tAaFdm9kosAbluVFJcv6DTdmm9n7DTnf0C/qz5Wq2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dHVTKLmSYqkbKmCj4yGmNY0ry+jKD4R2GCShJMBHy0jbiHw8
	tomN+2gftM+Lj7nQDzOA/SY6BX6N/dw8c4DoeiivLiG7YMEi72nmfQY7q4ezYhNcZsdQ6q3VAVl
	HHYUKsRMQUmplbjOszc/FUXTt2w/KstmnxONpKSlniS9IoIRz2crjcw==
X-Received: by 2002:a05:600c:c0d:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-4311ddffb8dmr160143325e9.0.1729077393821;
        Wed, 16 Oct 2024 04:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF6mlruAq+rlftht0xklUty2+K9bi4n84O7QB16BRpDQ0gUnzdPdf71NDf6zOxbjqpZa7ZqQ==
X-Received: by 2002:a05:600c:c0d:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-4311ddffb8dmr160143025e9.0.1729077393411;
        Wed, 16 Oct 2024 04:16:33 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314f5e2258sm22567745e9.10.2024.10.16.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:16:33 -0700 (PDT)
Message-ID: <482d0c45ea2121484a85ed9be6a1863b6d39ac1e.camel@redhat.com>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>, Alvaro Karsz
 <alvaro.karsz@solid-run.com>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 16 Oct 2024 13:16:32 +0200
In-Reply-To: <2024101627-tacking-foothill-cdf9@gregkh>
References: <20241016072553.8891-2-pstanner@redhat.com>
	 <Zw-CqayFcWzOwci_@smile.fi.intel.com>
	 <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
	 <2024101627-tacking-foothill-cdf9@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 12:51 +0200, Greg KH wrote:
> On Wed, Oct 16, 2024 at 11:22:48AM +0200, Philipp Stanner wrote:
> > On Wed, 2024-10-16 at 12:08 +0300, Andy Shevchenko wrote:
> > > On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:
> > > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later
> > > > passed
> > > > to
> > > > pcim_iomap_regions() is placed on the stack. Neither
> > > > pcim_iomap_regions() nor the functions it calls copy that
> > > > string.
> > > >=20
> > > > Should the string later ever be used, this, consequently,
> > > > causes
> > > > undefined behavior since the stack frame will by then have
> > > > disappeared.
> > > >=20
> > > > Fix the bug by allocating the strings on the heap through
> > > > devm_kasprintf().
> > >=20
> > > > ---
> > >=20
> > > I haven't found the reason for resending. Can you elaborate here?
> >=20
> > Impatience ;p
> >=20
> > This is not a v2.
> >=20
> > I mean, it's a bug, easy to fix and merge [and it's blocking my
> > other
> > PCI work, *cough*]. Should contributors wait longer than 8 days
> > until
> > resending in your opinion?
>=20
> 2 weeks is normally the expected response time, but each subsystem
> might
> have other time limites, the documentation should show those that do.

Where do we document that?

Regarding resend intervals, the official guide line is contradictory:
"You should receive comments within a few weeks (typically 2-3)" <->
"Wait for a minimum of one week before resubmitting or pinging
reviewers" <--> "It=E2=80=99s also ok to resend the patch or the patch seri=
es
after a couple of weeks"

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#don-=
t-get-discouraged-or-impatient


We could make the docu more consistent and specify 2 weeks as the
minimum time.

P.


>=20
> While you wait, take the time to review other pending patches for
> that
> maintainer, that will ensure that your patches move to the top as
> they
> will be the only ones remaining.
>=20
> thanks,
>=20
> greg k-h
>=20


