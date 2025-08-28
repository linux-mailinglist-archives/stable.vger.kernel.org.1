Return-Path: <stable+bounces-176564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC55B393DF
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 08:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1BB1BA4295
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 06:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE427A461;
	Thu, 28 Aug 2025 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYa7tFio"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A427AC3A
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362860; cv=none; b=Ib0erxwgQ/dn/blvc2mJAyc6IMyzFaqOO51wj0hnoL1HSqKMjBR+XUJxeS4V6AcvqnvGyRu2JBRJUcUaeHT15/CYq8SZOTUVRCe+vyabet8+P2GHfAMuvHgBo1fEWCBEo7JUoDvjqNj2sa+1kiC1tXiqzyZxM3JBmKBZUbaSVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362860; c=relaxed/simple;
	bh=O+hoOkpxKzFagM4YINohrcCRbkfOC3WyapBZoGGUub0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyMHPZjkOPDUfLZgGJe8SY0Uc4ogHMn4c6/SxNpK/QIRC77f/HdaDLmtB4AI51lUAj6TV8UL1xrwGKis4VLUhwHQb54dEaoSKPtXlvbJA4EW8MxL8L5D48FAW0BN+aHkknBJ682gcafAM3yUAtR0RXOlANiZ3XP8azraHlHFLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYa7tFio; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756362857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NBle0psK83326FXvykrXUefZ5fJAW3yvhWvuCeWq0c4=;
	b=HYa7tFioTE1CrZuqrQntqzaP/qc9TUVYPifGnypbCq/fEXqY3DgIgaLSAPbn4iwEhTj5ta
	91g5+CZbnTEKJnIKmK2I0O43awCf3MY03X0Hc1qXtKy3cx3MckpGSqwpecqfGDpK/cHmQq
	czbX0cySNe1m3NUtbRGIgP5JuPRH+eU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-oSIYmwtkMbaXKqyRhCFkng-1; Thu, 28 Aug 2025 02:34:14 -0400
X-MC-Unique: oSIYmwtkMbaXKqyRhCFkng-1
X-Mimecast-MFC-AGG-ID: oSIYmwtkMbaXKqyRhCFkng_1756362854
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3cceb92ea73so318935f8f.0
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 23:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756362853; x=1756967653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBle0psK83326FXvykrXUefZ5fJAW3yvhWvuCeWq0c4=;
        b=ILTqibBDf3QjUFO7F2b08GW6LVVPHwiepekN3oo63+nxLrB06c4VYMPo2LsL5/ck2B
         nEnR0HhDnGXB3d4Rbw4zs70Oi6+YDS+Xtgj9D0Hyk8OqDx19XesInqgu8ehjhBx7CYvL
         h3rRm6SWfAI47B5a7s5oQ+hwfwHUVCgp7hvT7voI+imMwUrhPtYkzKisio4uWRb6ThFb
         lhxL/LVQkiSau36KcmmI4bbKj2V59zhwO9gf8B25QTgHCrBnib62ercI7L4o9IEkOsNi
         YwdGgLos4sMBxzbv31m77TNlRk/ooIZtW6Xu7VBNqYzSK6ZOnA1BfZW2cFTFBpgbU+NM
         brqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB1BFzpa7wageDFQChKj807WjVXKo423yV+gK8kLjSz9Lr/P1NIHr19rbG88r/AvqMUJ5Le2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CGamzpx5OGD94AFlpco63j0yVFIN73we5BJzqRjUv3VO1hlD
	sWT+JS7DdbblP8LQMshsUYOSpl3fofuq8M4hUKsHJosEWseuvalEa6OtTuqgmUzzdkIW39w/9tg
	pZ13gE3ZKe+kd3QMVEM2dspDhfL8Bf23ilzLQiOXlvSCx2ioJwFHiTrjzTBklDayBZPR7
X-Gm-Gg: ASbGncvOw4FmWvDcr75G/crqJb72K4IPofymMFLeudjuh4h/SlAkd3/ZKTUb+wjcvUM
	EqmIsxZQVmKYVP74qimewHg7p/BQ/nd+wIkAllgTakjHCwZb5K/4r/EOe6wIlw2SbWdrgrmQzHl
	D23XLYekbm4mJBeaQKfHFQaLdsRQmZfawHtd6+lqVxJaPtBgAOiJwUa2oBP2eSYA2Uvnaey/8p/
	CccuCgxaf988WpSrbz3ZP4pUaovh7pv98jx8ffncHLqJ+T3Mo/GBkc1WFvVbztXvY8+1ReUQHxC
	Rbrv40a7x79eRErGOpbgVHpk5PHTkMAZ
X-Received: by 2002:a05:600c:a46:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45b517d459dmr188529445e9.20.1756362853195;
        Wed, 27 Aug 2025 23:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ8ShxovhE59HtjACcDksQuottjD5sgqN9H8NEO7Hjz/jKK66gFgjy+2JmPy1tKxjXKq2wUw==
X-Received: by 2002:a05:600c:a46:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45b517d459dmr188529155e9.20.1756362852764;
        Wed, 27 Aug 2025 23:34:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dcad5sm17887505e9.18.2025.08.27.23.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 23:34:12 -0700 (PDT)
Date: Thu, 28 Aug 2025 02:34:09 -0400
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
Message-ID: <20250828022502-mutt-send-email-mst@kernel.org>
References: <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061925-mutt-send-email-mst@kernel.org>
 <20250827064404-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71950328172FA0A696839623DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71950328172FA0A696839623DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Aug 28, 2025 at 06:23:02AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 27 August 2025 04:19 PM
> > 
> > On Wed, Aug 27, 2025 at 06:21:28AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > > > > If it does not, and a user pull out the working device, how
> > > > > > > does your patch help?
> > > > > > >
> > > > > > A driver must tell that it will not follow broken ancient
> > > > > > behaviour and at that
> > > > > point device would stop its ancient backward compatibility mode.
> > > > >
> > > > >
> > > > >
> > > > > I don't know what is "ancient backward compatibility mode".
> > > > >
> > > > Let me explain.
> > > > Sadly, CSPs virtio pci device implementation is done such a way that, it
> > works with ancient Linux kernel which does not have commit
> > 43bb40c5b9265.
> > >
> > >
> > > OK we are getting new information here.
> > >
> > > So let me summarize. There's a virtual system that pretends, to the
> > > guest, that device was removed by surprise removal, but actually
> > > device is there and is still doing DMA.
> > > Is that a fair summary?
> > 
> Yes.
>
> > If that is the case, the thing to do would be to try and detect the fake removal
> > and then work with device as usual - device not doing DMA after removal is
> > pretty fundamental, after all.
> > 
> The issue is: one can build the device to stop the DMA.
> There is no predictable combination for the driver and device that can work for the user.
> For example, 
> Device that stops the dma will not work before the commit 43bb40c5b9265.
> Device that continues the dma will not work with whatever new implementation done in future kernels.
> 
> Hence the capability negotiation would be needed so that device can stop the DMA, config interrupts etc.

So this is a broken implementation at the pci level. We really can't fix
removal for this device at all, except by fixing the device. Whatever
works, works by chance.  Feature negotiation in spec is not the way to
fix that, but some work arounds in the driver to skip the device are
acceptable, mostly to not bother with it.

Pls document exactly how this pci looks. Does it have an id we can use
to detect it?

> > For example, how about reading device control+status?
> > 
> Most platforms read 0xffff on non-existing device, but not sure if this the standard or well defined.

IIRC it's in the pci spec as a note.

> > If we get all ones device has been removed If we get 0 in bus master: device
> > has been removed but re-inserted Anything else is a fake removal
> > 
> Bus master check may pass, right returning all 1s, even if the device is removed, isn't it?


So we check all ones 1st, only check bus master if not all ones?


> > Hmm?
> > 
> > 
> > 
> > > --
> > > MST
> > 


