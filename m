Return-Path: <stable+bounces-172748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E16B33069
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 16:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EAF201C5E
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9227A129;
	Sun, 24 Aug 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxBIVt0a"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBA1F4161
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045782; cv=none; b=Btq/1P4OfX9mXSb91lqzcyc3lCGKrAeNjV5PptDXVY7pxEM6Nak3cKwl2Y3GIeV/rlEHjFQr1H/7khNHByHmmtbCalrqkbOvCqWsBV1GSFE1QM6zOyKs9vDOaW3nN6kR3sRF3S4hyKwYsi8PMiZgUl7K9CdiLM9Bo8Z3DOdBP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045782; c=relaxed/simple;
	bh=XuWL24Y83YEtYFRotPSZdAyjeZ7hd63abpLM4Ak6Mms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHZqCGsNNJVKVpuwdjhydk8k/D5dDEBilcp76MgWFvF6OfnFFR+b+DOSnQi7A6wXSrToJodM0w21IcnEms4PEWfX1vIJzIfvskIF53GDG81GUqfArw5U48HEFWPoYzdm1j7G1IFlQVLyWyA4jmiNryWbMi40cfJT9v9HXrbrpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxBIVt0a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756045779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+h5cKX+MmfMrhq03RArt3rkQSwMq8jB/rkMBe7TwXY=;
	b=JxBIVt0aAoBUPxfbkM+zFs3gZS5ZTsvLnnn5SBX7cFs86nOEx2QnDhtq0BYy5ZmlBbU8tS
	pqf3TCIB+gQLRpHIWQPRjC2EqE+OSlOp9BARE04EV55B+cRj9m0PoZkG/8guLN3SWlG0JF
	k9s1/nnvyFtPfKObotIrLTuzrX9qCSQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-8ECcoNCaNY6QVEuPyYrnvw-1; Sun, 24 Aug 2025 10:29:38 -0400
X-MC-Unique: 8ECcoNCaNY6QVEuPyYrnvw-1
X-Mimecast-MFC-AGG-ID: 8ECcoNCaNY6QVEuPyYrnvw_1756045777
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0071c1so17793915e9.0
        for <stable@vger.kernel.org>; Sun, 24 Aug 2025 07:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756045776; x=1756650576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+h5cKX+MmfMrhq03RArt3rkQSwMq8jB/rkMBe7TwXY=;
        b=h+rISx01Ljp7IutedCRqLB/+6YGJUs3r2ZrkP3sbsQtT4TzJ8yRYcs68LaehwzYkhs
         7aI8v65EEJIK74xxU2TLWOZ9Jtr5tR3M6sSJFDYixRuGW3WGnD5zP3eO70/+iOyh3acz
         AJcP5AvQtpX2zrAo5W+I4vqaF9wCfxaNwe0jWOfPTrNutCMbD2fHu7CJuRVim7JzGN/f
         0hrN5vHc63c3IbiQG5aKFP2jUYcDQDj9rztbBCHKwuPTEupSZdgwzjmu+8eIzaGg2DBS
         DeuhRCvP25wwwJC1X1Taup2HGjZ+4Y60thmdHP0QOb05YDrgVo0RzfBPhTxtWt6G+W8W
         OWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT/qHbl+RDXaGdaVhaxE8HzZNvk2hCxhwp+erBWbwe51eKKF4k4HqjiHtgq8x9jFg9inaT3Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YytvfLxUXgR1Srn+LT4iQ7U2c6hmeFc+WpE5W4Xi4DgZeKzZdS2
	KApr1LTmoIKWyenXGvtDzhjeB6DYes/qW6cHYmJu8ia26wiwFMrzpDNTfZ5vmMpcUapx9f2WU+i
	IpVJzm8yr6GDvdbURM+v0grBnXB3AORFEaAAAnoNolCZeWBNjIcGGcNTkEVdLGMnDew==
X-Gm-Gg: ASbGnct7cykzzU3G4b0zTOZNFwIC6un5iHfQj0jsarp84raElgtXYVlWAzu62rvRfTK
	AgG7ZB5+YDA/L7Z67xJtR9/kBDzy/+F1+NJpp8d8zcrA2SS1R7rixWHgd1TFDoBkLVaoSkh4srx
	bzliKowyqgtLhAS9VpPGLDb1gsnAJoIBh6bByGvFzXgFCdNdllbpsOt/6hXCojF16/zmjcLLy4c
	RZTxa+5/o0WqeliYtxMtO0m7jQDvUxVxsxe2cXmmNcHfxaREiIjCVPBYYJb5n0hLvlhGjIiu6Ib
	rV73FY0Ia0DXv9M0UmAiEuPDgRSIuS/t
X-Received: by 2002:a05:600c:4fcd:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-45b517cfe71mr94700845e9.17.1756045776310;
        Sun, 24 Aug 2025 07:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUNNSx/EAsLGZc9eSde38ATdxUavu26xApKf9MfadoABaFK57oo8Mjk4C7vwfE1B1fDbhoGQ==
X-Received: by 2002:a05:600c:4fcd:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-45b517cfe71mr94700685e9.17.1756045775838;
        Sun, 24 Aug 2025 07:29:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba078sm8187184f8f.4.2025.08.24.07.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 07:29:34 -0700 (PDT)
Date: Sun, 24 Aug 2025 10:29:31 -0400
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
Message-ID: <20250824102542-mutt-send-email-mst@kernel.org>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Sun, Aug 24, 2025 at 02:36:11AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 22 August 2025 07:32 PM
> > 
> > On Fri, Aug 22, 2025 at 01:53:02PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 22 August 2025 06:35 PM
> > > >
> > > > On Fri, Aug 22, 2025 at 12:24:06PM +0000, Parav Pandit wrote:
> > > > >
> > > > > > From: Li,Rongqing <lirongqing@baidu.com>
> > > > > > Sent: 22 August 2025 03:57 PM
> > > > > >
> > > > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support
> > > > > > > surprise removal of virtio pci device").
> > > > > > >
> > > > > > > Virtio drivers and PCI devices have never fully supported true
> > > > > > > surprise (aka hot
> > > > > > > unplug) removal. Drivers historically continued processing and
> > > > > > > waiting for pending I/O and even continued synchronous device
> > > > > > > reset during surprise removal. Devices have also continued
> > > > > > > completing I/Os, doing DMA and allowing device reset after
> > > > > > > surprise
> > > > removal to support such drivers.
> > > > > > >
> > > > > > > Supporting it correctly would require a new device capability
> > > > > > > and driver negotiation in the virtio specification to safely
> > > > > > > stop I/O and free queue
> > > > > > memory.
> > > > > > > Failure to do so either breaks all the existing drivers with
> > > > > > > call trace listed in the commit or crashes the host on continuing the
> > DMA.
> > > > > > > Hence, until such specification and devices are invented,
> > > > > > > restore the previous behavior of treating surprise removal as
> > > > > > > graceful removal to avoid regressions and maintain system
> > > > > > > stability same as before the commit 43bb40c5b926 ("virtio_pci:
> > > > > > > Support surprise removal of virtio pci
> > > > > > device").
> > > > > > >
> > > > > > > As explained above, previous analysis of solving this only in
> > > > > > > driver was incomplete and non-reliable at [1] and at [2];
> > > > > > > Hence reverting commit
> > > > > > > 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > > > > > pci
> > > > > > > device") is still the best stand to restore failures of virtio
> > > > > > > net and block
> > > > > > devices.
> > > > > > >
> > > > > > > [1]
> > > > > > >
> > > > > > https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB10
> > > > > > 0BC6
> > > > > > C6
> > > > > > > 38 DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> > > > > > > [2]
> > > > > > > https://lore.kernel.org/virtualization/20250602024358.57114-1-
> > > > > > > para
> > > > > > > v@nv
> > > > > > > idia.c
> > > > > > > om/
> > > > > > >
> > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > > virtio pci device")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Reported-by: lirongqing@baidu.com
> > > > > > > Closes:
> > > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb7
> > > > > > > 3ca9
> > > > > > > b474
> > > > > > > 1@b
> > > > > > > aidu.com/
> > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > >
> > > > > >
> > > > > >
> > > > > > Tested-by: Li RongQing <lirongqing@baidu.com>
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > -Li
> > > > > >
> > > > > Multiple users are blocked to have this fix in stable kernel.
> > > >
> > > > what are these users doing that is blocked by this fix?
> > > >
> > > Not sure I understand the question. Let me try to answer.
> > > They are unable to dynamically add/remove the virtio net, block, fs devices in
> > their systems.
> > > Users have their networking applications running over NS network and
> > database and file system through these devices.
> > > Some of them keep reverting the patch. Some are unable to.
> > > They are in search of stable kernel.
> > >
> > > Did I understand your question?
> > >
> > 
> > Not really, sorry.
> > 
> > Does the system or does it not have a mechanical interlock?
> > 
> It is modern system beyond mechanical interlock but has the ability for surprise removal.

I am not sure what does "beyond" mean. I guess that it does not have it?

> > If it does, how does a user run into surprise removal issues without the ability
> > to remove the device?
> > 
> User has the ability to surprise removal a device from the slot via the slot's pci registers.

I don't know what this means. Surprise removal is done by removing the
device. Not via pci registers.

> Yet the device is capable enough to fulfil the needs of broken drivers which are waiting for the pending requests to arrive.

I don't know what this means. A removed device can not do anything at
all.

> > If it does not, and a user pull out the working device, how does your patch
> > help?
> >
> A driver must tell that it will not follow broken ancient behaviour and at that point device would stop its ancient backward compatibility mode.



I don't know what is "ancient backward compatibility mode".





> > --
> > MST


