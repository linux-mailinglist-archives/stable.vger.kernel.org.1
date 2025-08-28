Return-Path: <stable+bounces-176602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A70DB39D02
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC811C830C3
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474A3112DD;
	Thu, 28 Aug 2025 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vol8/bCp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2B31062E
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383555; cv=none; b=Q1V6W+S+wm9hntpNC5+iZnspnAl96lZ6fWWK+lIgNwyyDxCYIG8hiF+YKaCgvxDSdp16hzkWAA6kdnEuUQXBWAE34ZzYwHRIHS+8eIwjJyyrdLbuf9H0vySgdZ1OxEYxqrDZZT9yAra088vd8CMnCX9mAAaNKOMGu7NYdkZJtGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383555; c=relaxed/simple;
	bh=F+mheq4O2TyVZUQvPtr2Mdpd5dqUvirPgEbavwBKIYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiUgU7zCSoD3VZkJ4WD6BUafp+KrAdjplqfQs+2ynGHvuqhW0KLrnXWPYJZaAE+B2pIW4uLaboc2b6e0ylfj2Z9+T/NtGrLI1wsnNFj/XxKlLCKxBu5gbcdSA7GNGfIi+m72I2YRPckh0bLV4SzBTtyEw2WB4fRhpiupOYFI76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vol8/bCp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756383553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq9u0cnhGJ/BdyM1GbcnyYUNgnWTAGwoq7wtSCyMB/E=;
	b=Vol8/bCpGY6gJakqBF316q9AxIuwJ4GDDMWxMlFfJ+roOvBa/mRbycSs3jK5Lv8x1bqgaZ
	n1uP8uDyA7+XOyvXO4K5iBUgOZuZLPZWDxdCCN1Hw3ysWBhB0DQ6hdT2zPmx3H3YPNpphm
	10lVzO7Z2lsyP5IjgUuUcmXLRUb40z0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-zeQ9Z4ZYNuOTlY7kUJpTiw-1; Thu, 28 Aug 2025 08:19:11 -0400
X-MC-Unique: zeQ9Z4ZYNuOTlY7kUJpTiw-1
X-Mimecast-MFC-AGG-ID: zeQ9Z4ZYNuOTlY7kUJpTiw_1756383550
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c79f0a5feaso713923f8f.2
        for <stable@vger.kernel.org>; Thu, 28 Aug 2025 05:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383550; x=1756988350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq9u0cnhGJ/BdyM1GbcnyYUNgnWTAGwoq7wtSCyMB/E=;
        b=UY+k7GuK9I+lHj5nQT6GjZaH0juJJHHION/FpxBoJavrrvCmD/OFfDnyhZxeu/eXbp
         TTfMGJQkVhHsgdI1isAamAN8K9toaDnFDPmqzmrvoeypcGzxW82lVhPXdhzxvK7lD7dC
         n4D08Ks3d41ZUsDB3lZbCrBh1VrbQlKsUl51C7OI2tbR1sbANAj2oCTzo1whFP2lyiHh
         +pXTpktFRY5iKqWBRPVcQpid5giSaO5/1NdARjkCMEy4Ikf77MXlTATH/hdBZDISW6TB
         oSmyxrrwQSKdJ9tM+z+ox+H6vyoo3yyI3oDf218XEa2SkUXokuX4A4ZfeuGuYLMOZerb
         i9Tg==
X-Forwarded-Encrypted: i=1; AJvYcCV+CQYyUgdz4GqDe9scSgZKBG+anDTJlTEhD5P3bwcAg5+yhonzfU6GwyNJXD5CcRows7bLtyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiYG5bZx8D+oxi7ZOoS3V7egHPQRz8ocH1ootN0QdifLTra7o
	YJYQPcebyoubVXwvK4pZ7+1RTK7qM74QK79xG19CChPMbkbg9pg7NARE65KTE89TJNpcM7MeQ5F
	nyxFKWUo7tuQgDZsJsepT0B/lFaTWooHUuKFm5wGPOlXS+LRQ7JhqknbmDA==
X-Gm-Gg: ASbGncvkIDWfJP621yKEzpySGPX0w2715gbJl8tt0vbErBjge1NWsJQA92SbMcORrOB
	m1SL1m88c6xLrF95quyE/mniWcMGF39q0i7EFMUJhEUOft2zBGm5znAyB/ciAbjqJG5r1Ql7gro
	v7VN8n9Z4R1OT81NDJY1bcmrfCWOTL2xbI6/vh/eGIozzkiyEtgENFW2Gk23fT1vebqiaVed28b
	+B3KH93P2Y6kBS+8fyuOLjVAWZWEcCRmCVcddBpfik9GTh1xriuxyX8ifvugejghIdo0LWFa0ag
	yztOsXrm8o6amxIqkND+gwUctLJMNjNG
X-Received: by 2002:a05:6000:402c:b0:3ce:d43c:673f with SMTP id ffacd0b85a97d-3ced43c6c3fmr105126f8f.4.1756383550328;
        Thu, 28 Aug 2025 05:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4J85snhq1BAsqwZjK+n9dKliu/Y1mrIx2XDMWIXXrAB06TFT0/Jbg+him3WiQwpHNUEOCTw==
X-Received: by 2002:a05:6000:402c:b0:3ce:d43c:673f with SMTP id ffacd0b85a97d-3ced43c6c3fmr105090f8f.4.1756383549792;
        Thu, 28 Aug 2025 05:19:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7112129b9sm24574050f8f.34.2025.08.28.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:19:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 08:19:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250828081717-mutt-send-email-mst@kernel.org>
References: <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org>
 <87frdddmni.fsf@redhat.com>
 <CY8PR12MB7195FD9F90C45CC2B17A4776DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <87cy8fej4z.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cy8fej4z.fsf@redhat.com>

On Thu, Aug 28, 2025 at 02:16:28PM +0200, Cornelia Huck wrote:
> On Thu, Aug 28 2025, Parav Pandit <parav@nvidia.com> wrote:
> 
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: 27 August 2025 05:04 PM
> >> 
> >> On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> >> >> > What I do not understand, is what good does the revert do. Sorry.
> >> >> >
> >> >> Let me explain.
> >> >> It prevents the issue of vblk requests being stuck due to broken VQ.
> >> >> It prevents the vnet driver start_xmit() to be not stuck on skb completions.
> >> >
> >> > This is the part I don't get.  In what scenario, before 43bb40c5b9265
> >> > start_xmit is not stuck, but after 43bb40c5b9265 it is stuck?
> >> >
> >> > Once the device is gone, it is not using any buffers at all.
> >> 
> >> What I also don't understand: virtio-ccw does exactly the same thing
> >> (virtio_break_device(), added in 2014), and it supports surprise removal
> >> _only_, yet I don't remember seeing bug reports?
> >
> > I suspect that stress testing may not have happened for ccw with active vblk Ios and outstanding transmit pkt and cvq commands.
> > Hard to say as we don't have ccw hw or systems.
> 
> cc:ing linux-s390 list. I'd be surprised if nobody ever tested surprise
> removal on a loaded system in the last 11 years.


As it became very clear from follow up discussion, the issue is nothing
to do with virtio, it is with a broken hypervisor that allows device to
DMA into guest memory while also telling the guest that the device has
been removed.

I guess s390 is just not broken like this.

-- 
MST


