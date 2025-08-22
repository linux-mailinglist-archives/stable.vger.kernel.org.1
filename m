Return-Path: <stable+bounces-172386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AED7B318E3
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B992F3BA13A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE242D7DDC;
	Fri, 22 Aug 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBLUvTW+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD1199FAC
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867900; cv=none; b=DppH/406HBF6Za9hIaEGrgBzopC6pHWyl233qG0ks2hvnHFViR+Q5c33WoZV5qe4NAuPMFBX+K4YmwPYl4EfzL2nXB2JeQQyCxRpHz93LUcpwUNRFQmcYABe0GlFVQ3YgyBFzAWn7/w3dIyWuyh7J3nBy1ge2L4a/RCOSETZP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867900; c=relaxed/simple;
	bh=w0Q+FsNizwQyUYK9BsZ2M/EWU17/ju7wdDubu9d4kts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVadcGLavJi/gMYiKo59OUXWBqTE0/+2Ve5/j9XB5ofM1g+qLeTVU73kx8qK97rwOIgtwKpzVrPeyFvVM34cdGJaXTLpFLNMS5J6iw6GP+/nzALME7EvTJP/4NTnMpf8ul+hwh6SLWwUICp17wL7yj1Z19Z4FEf84XJB1RDXdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBLUvTW+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755867897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HbdcQpncCh7btF+aNsL0pGSPRE3CkROlaSyGQtuUHUw=;
	b=RBLUvTW+IDXB0K4j3p1hFW7sA6NI6Lfx5o2M1KZ7DNj20cAozTczLmSo6ktlkQ0T3fIRGg
	5uVUcEgX9IWDx9SZA4QKAuYFjUds62OnUt9eVL8mflvfVbqXlawQibSwZzzJ/IrwmwVuVf
	jH1MJIMqWt33f+lyVJ4YnE2Ca/nWsGQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-G1YmV5RXMR2lJ8V1JM_K7A-1; Fri, 22 Aug 2025 09:04:56 -0400
X-MC-Unique: G1YmV5RXMR2lJ8V1JM_K7A-1
X-Mimecast-MFC-AGG-ID: G1YmV5RXMR2lJ8V1JM_K7A_1755867895
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so14300655e9.3
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867895; x=1756472695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbdcQpncCh7btF+aNsL0pGSPRE3CkROlaSyGQtuUHUw=;
        b=Q0YncUnqtAvKI5anwhucxBqwdRtWxOJFvQi1nV7+mvlpRNyQqYiNF/AjpXsiCTBwid
         QEFH5D3wBwgXMT5S8vqJrN123wsb6uuqYeEd3FcCCbXd29ytBOhfbTn+vZEsjfVVRxYe
         V+nqayPzZ1HvuRyb/DP9mWFMdHMmhEDW5ZS0KJR//gPEo5Gw7NvuY+pJ0qrER0ST8pb5
         3BS1rwvEq96Y95q7RAKHjathPtKNxi0adH91OM14d/JkS4FLgcxsUU9fALJ1ysxhfTBY
         s5Da82JEyS6WPBCLUuKCi+p2Em0YABynTbsjWkhFtHVtlx1Ae+cBetu55grZ6E/s7NOd
         7PEg==
X-Forwarded-Encrypted: i=1; AJvYcCUeygoHS85NSdPlpBVVcRm/lDc08Wq3x6Yh+ewGkdnCWnGeRKOhl50pz2STyi16E/tNgkXecY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRJLFMAJw44mPQ7B28tcFi9hYDa78PzSUTkUjY3EZ8rCgEwmA
	ynP+FCSiAHpi7YX4ok1AWE4coMQVyQxd4hi+YiyPF9Xx9sgNY3TwoM0Oca5m8jZa5FG1SmpQAF8
	xgVlFh6L3cELvqBzB4TZARBQG9wt2XJp/q2kTe3K90d6eI2/RuQh7S5bkKQ==
X-Gm-Gg: ASbGncs7HqqpZJn1HogsccR2UvU0odylZH6n8i+qphQQVUqBo2lMDC1aqrw0NhOYWW/
	4VqxrRbl3olmjIIfZM2/LhgNUU25lvKgbwzdaGhPD85z2fD6LFkMe6HYZyh+OsZRrUokNg1itlX
	cqBKzl4SETJaPI+9zUXQL/Fzb2Mmrqy5ZM9CQIzNjR/z/C71sxIcwtvgo7Mg5FyEjkDkHAkA3/6
	M6iQ9UWz1jIBnMTuXtFF6c6qhrJCkbJ0S3hN8iaRN3CWp/u2YxbIJHkDPV3r64R3mv2CyOK0buN
	llAop8OQCSSTPSCYB0/D0Ju2wn0PHNBV
X-Received: by 2002:a05:600c:8b17:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45b517e8dc2mr23760075e9.35.1755867894752;
        Fri, 22 Aug 2025 06:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFngGGmvja+c3hZ9pHn+YWINTUlG6R2wYP0GDnbBthnGEIHH5TrUNX9aU7b3F3Zm40FnvOqRg==
X-Received: by 2002:a05:600c:8b17:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45b517e8dc2mr23759625e9.35.1755867894246;
        Fri, 22 Aug 2025 06:04:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e269d20sm37762895e9.2.2025.08.22.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:04:53 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:04:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250822090407-mutt-send-email-mst@kernel.org>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Fri, Aug 22, 2025 at 12:24:06PM +0000, Parav Pandit wrote:
> 
> > From: Li,Rongqing <lirongqing@baidu.com>
> > Sent: 22 August 2025 03:57 PM
> > 
> > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > removal of virtio pci device").
> > >
> > > Virtio drivers and PCI devices have never fully supported true
> > > surprise (aka hot
> > > unplug) removal. Drivers historically continued processing and waiting
> > > for pending I/O and even continued synchronous device reset during
> > > surprise removal. Devices have also continued completing I/Os, doing
> > > DMA and allowing device reset after surprise removal to support such drivers.
> > >
> > > Supporting it correctly would require a new device capability and
> > > driver negotiation in the virtio specification to safely stop I/O and free queue
> > memory.
> > > Failure to do so either breaks all the existing drivers with call
> > > trace listed in the commit or crashes the host on continuing the DMA.
> > > Hence, until such specification and devices are invented, restore the
> > > previous behavior of treating surprise removal as graceful removal to
> > > avoid regressions and maintain system stability same as before the
> > > commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> > device").
> > >
> > > As explained above, previous analysis of solving this only in driver
> > > was incomplete and non-reliable at [1] and at [2]; Hence reverting
> > > commit
> > > 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> > > device") is still the best stand to restore failures of virtio net and block
> > devices.
> > >
> > > [1]
> > >
> > https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6C6
> > > 38 DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> > > [2]
> > > https://lore.kernel.org/virtualization/20250602024358.57114-1-parav@nv
> > > idia.c
> > > om/
> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@b
> > > aidu.com/
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > 
> > 
> > Tested-by: Li RongQing <lirongqing@baidu.com>
> > 
> > Thanks
> > 
> > -Li
> >
> Multiple users are blocked to have this fix in stable kernel.

what are these users doing that is blocked by this fix?

-- 
MST


