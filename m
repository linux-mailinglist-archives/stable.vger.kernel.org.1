Return-Path: <stable+bounces-176490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC4B37FC0
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 12:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B783BEDD6
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140927CCCD;
	Wed, 27 Aug 2025 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC2tYQqN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A695322774
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290094; cv=none; b=o3vM2dpaOxs4DCb6bSkH9YC+luJ1dWzL2Lfq/y08csmvWllceKtgBtyuoX44X0iAKSCb2r/2hg8IZpJZuI8V/eh4n0K4z6RLvsml7ryjBokj8hxvcifuV/Qx5pJk7PzQRsugh6b3pfTti9s9IPpLfN4FoMdFP7ETDm2Tm83U9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290094; c=relaxed/simple;
	bh=esf3pW05M6lYQ00AimXfav10o9MWvvAhi0ueNrtACRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4Prly8gd+UDvbRUDWN7B7xbIJNfjpZ4lchOxtc1hWt9dty0VrnLFIIgWcIA1y2hbOY6myG19vUG1CqlKmIySwyy5LIU2bbb3bSyj42uRML95SfPwKybtLiFPS0/KudRJCVGEvTfImraCFQjEVwQq8z7OUFp1R7iNc6fsEYDwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YC2tYQqN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756290091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XyxfiCP+1G5kZ2DAEzfezCwimO+RIme3KfTRPyKTkF0=;
	b=YC2tYQqN37p4arIPqRFMFlPq+wdo3Y2+pqaVdKjFZzVHugRaQLUZLv9fNmGWeaZ40xtAuj
	hICRM0HJva5vjGbhGcGEF4LVZA6dj3B2ggVKoltIN49l1KDToAHWVZrIyTSaCHHDZYKCCM
	KI2TwIU0F+dxxiLABu5wF5O0PlTeywo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-p1dBsmBvOzSng0DHVx_jHQ-1; Wed, 27 Aug 2025 06:21:29 -0400
X-MC-Unique: p1dBsmBvOzSng0DHVx_jHQ-1
X-Mimecast-MFC-AGG-ID: p1dBsmBvOzSng0DHVx_jHQ_1756290089
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b05d31cso33734995e9.1
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 03:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756290088; x=1756894888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyxfiCP+1G5kZ2DAEzfezCwimO+RIme3KfTRPyKTkF0=;
        b=OHnTDeZc9AtluZDurlZjGjTkLPU/VrnO/n9Ibcy6ehunsXPv2A5YFNwVP+uur9lbTR
         QlgBBEwK27E7V6ZIwjvVJxHnVqqs1zeBq39krA53h7MmHrZVFNfGW8Ax48lCHKDH8wMx
         hZ3QQ68WPE6VR2Ff4k4bGRB4tZJTSou+r5t2P1iDu8oIWjZFc/I6ecmEnAOXWd5Gd4Qr
         swxt7Fcl440C/iR1vGxkRc1yeLzbHgHJ0uqKkYNzudTLrpUTht3xQzFEDC8Zwt5b5vo9
         ZxVFGknKCWXbePOVny9lSgbHlJnY2kqXRVmXWA2f9AOFdJMe9p+NVCmtfAis11KQyNaC
         BK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZbMxS/7md82aAb/T/V6Lu6/ecu8Pk9BB9hHT4mesayU3kYEmN02jb3/rnJQ2vJsk1XpXaY6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlJfw7gRaf8Qy3kjFIsSAqR5nAIm254RvE8L+flEVI/zkO5bj
	wEK6MpKmejCGXZLVYqp4xyAhVX2wwR0oJhtCFI2DdTLyOxRA2fMmfidCfLIWs7nf2cJp7gDPnp5
	+EzFO56pEYh+cWboN6XYGFdkwzjsVrKrGFaLurhWqn91lfE8snLMDzo/9UQ==
X-Gm-Gg: ASbGncuF4NhyyyiP4MBeW6k9WJLO/hO2bSk88ZmDyQEdbBscE3yAnHzqcRM5CysRS1u
	FyVKhY4awqImNzb21IcmqFd0R0Qv46OuvcDkxPDUyLvfvxwG2lb/1GRgo/GbzpoBHrD3+PE1cuV
	FFn7rgJUL2c/wH5gsXepaMEYolC4aOJiE5lMfEzz3fF3meL6hUHXXrMH/quJwN50GZmeqBvTWxB
	sqpidJh1sQa6vibnEfMYFuHdQZd5+dM61k0X/ZEWor4i76tdqwbD5sGoGDtech9AN4R360D+giD
	dDMbfB3o74XI/DMraZjRcDaOALFtALY=
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr235285135e9.16.1756290088561;
        Wed, 27 Aug 2025 03:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiT33UYG85Zv6s7SgGE8Jo4L0oXbrtqo8q2OpqMIxgaNeeaSUd15eQcfPIlw8qzssJ22sbDQ==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr235284755e9.16.1756290088122;
        Wed, 27 Aug 2025 03:21:28 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cca0dd7014sm2437932f8f.13.2025.08.27.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:21:27 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:21:24 -0400
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
Message-ID: <20250827061925-mutt-send-email-mst@kernel.org>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>

On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > If it does not, and a user pull out the working device, how does
> > > > your patch help?
> > > >
> > > A driver must tell that it will not follow broken ancient behaviour and at that
> > point device would stop its ancient backward compatibility mode.
> > 
> > 
> > 
> > I don't know what is "ancient backward compatibility mode".
> > 
> Let me explain.
> Sadly, CSPs virtio pci device implementation is done such a way that, it works with ancient Linux kernel which does not have commit 43bb40c5b9265.


OK we are getting new information here.

So let me summarize. There's a virtual system that pretends, to the
guest, that device was removed by surprise removal, but actually
device is there and is still doing DMA.
Is that a fair summary?

-- 
MST


