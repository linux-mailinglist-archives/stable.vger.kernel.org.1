Return-Path: <stable+bounces-172404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22DCB31AD4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A571B23D7A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B683074AE;
	Fri, 22 Aug 2025 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChjNx2py"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7A303C91
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871340; cv=none; b=rGYGhfsOVwbil/pA2FxQ+BFX9IhSv73dnkF/d7OKnSedWM0lyE4R82xf8Ye3PNX349nUMjgUOhAFp1cbqZzVPAhPTdKsAgez9jCORRSFcLidKJebgmdFgClTQz72J6nlsecDoDifP/a/IrBQF2emw4YSGmRibCqA9OMQCOtuOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871340; c=relaxed/simple;
	bh=EUugAze3VMED93D4VtFJSu8FPTFEw4CKpNd1sov95Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWLoeq7p/jXeCNnFExZ98gYOzsyZruTPY+ysbR0EqlDccmOHc3bhUzROJX1pZtzxU7Z8oypvj9UeO/q0qf6HNNgunPXtBUFbvx/GLkI5wJ/5xqdonW7D4Vr/HUxMdERkjBaKd6ar7Pi88QG7CW1K8foMfA2NgLxwJO54HZvAzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChjNx2py; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755871338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fENUkrFAFKQ1Z6kTSqloFTTjWbakLg84clSG3sD2bb4=;
	b=ChjNx2pylUSi2zz71YObKeRI3Qje6jLAUEGgg8alFmtuA6AMA9+mOtTvfM8PH1bdYvVWBe
	GTSYqg8MlKS9K3q/jFfAh7337cmvk8mRwHqDlchhbqnuxC3zMJGYD7/ZqB/56efnX3GoQr
	nMKKwbwmpKV+ls2I5Hp7Ut4fTyQwxr8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-c0kAJu1NMKCjorTpC8l-7w-1; Fri, 22 Aug 2025 10:02:13 -0400
X-MC-Unique: c0kAJu1NMKCjorTpC8l-7w-1
X-Mimecast-MFC-AGG-ID: c0kAJu1NMKCjorTpC8l-7w_1755871332
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c6abcfd1c0so152077f8f.1
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 07:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871332; x=1756476132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fENUkrFAFKQ1Z6kTSqloFTTjWbakLg84clSG3sD2bb4=;
        b=bePI1VEztchgE//370zPiLyZVzUpRFjeA0VEPePNp0rWS/eRspEVEOPshYAegwJysK
         49zNKyQ7dTX9sTh6eNNdHAX07q6pVy1M1cLg99unqqC2PVoWc4seNlUrWW0OQSFpScJ+
         PqkZoqyV+DFi21DAytI1MegHTRrpub+ucI7ZRywVatdcjVEZ1UGri8JXJjNzfTewwsso
         2P1oZtsFmKgq+Wo/HlBEp5OgXR1h6xq+w/+qrzpqkWPBdNobPuJs4TSS4NctRfKGRwpT
         PyvFGCBW9VFid/debU9K/+Q4mv4HHz4pSxd1O9ykSKpAbsjq1fYoA62KpZ1A2CKUlorA
         LbbA==
X-Forwarded-Encrypted: i=1; AJvYcCW6EDRC+H2olOK0CO321QQAP48fyuxbsuSsaCayMGNapDN5FBo5XiWmJ9QURAyeN8ktvP1q/xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUF8lzGRcb6n7NK9KS+4uf+Oy3gWgbW3Mez/aPadx6FoTcg2G
	W9m4/aahFDPIrKu1o0nykiWiBevL7xuLJXO0TQSk4ieMCnD1PU6itIkoaC5BBYVSZCP7q8Fl9SE
	hzLzSV7OwMukkT6LDiFZ/J25uip3+XEfyUkQFqoNxxh4sir0EriltJHOEPA==
X-Gm-Gg: ASbGnctdrhZ6AFjukOz9Ue/0jOZ5b3M06ILBWcMNFPmpNsDD5pemEzr4CfbxG08jldo
	f9wYMB5NEQX3+MbIVazrzQHtWOoGT4C7CmjWppCbdpooT0hVSHsMr6BCJYe0L21PzRWH6Z4fhVA
	5f+hnQNSutTkHmAjF9dlRgqUMoiSim/AF3b15HKWTsCbrkqsfRVvVbbbOQe3rW3tFaIGzu3+aKm
	CFbEAB4zwyotc7JmYiAA3HBmPmIfmCo+kKLICxZry0mkJbfTqXq1dg/Q3KbA491DKmQP9P99++F
	LamE1wSJsWfBMh6UydaQJkojdQG0dQvb
X-Received: by 2002:a05:6000:2204:b0:3b7:9233:ebb with SMTP id ffacd0b85a97d-3c5da83c50emr2191684f8f.6.1755871332088;
        Fri, 22 Aug 2025 07:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERxH7i9dCeBAL+SRO1DoCOF9nmq3u+cQ+qcL77Cd+BYpM2PRfxMKBLB/pOJbmzBNJzoU/GTQ==
X-Received: by 2002:a05:6000:2204:b0:3b7:9233:ebb with SMTP id ffacd0b85a97d-3c5da83c50emr2191645f8f.6.1755871331485;
        Fri, 22 Aug 2025 07:02:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c60b40dcf8sm2551505f8f.41.2025.08.22.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:02:10 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:02:08 -0400
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
Message-ID: <20250822095948-mutt-send-email-mst@kernel.org>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Fri, Aug 22, 2025 at 01:53:02PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 22 August 2025 06:35 PM
> > 
> > On Fri, Aug 22, 2025 at 12:24:06PM +0000, Parav Pandit wrote:
> > >
> > > > From: Li,Rongqing <lirongqing@baidu.com>
> > > > Sent: 22 August 2025 03:57 PM
> > > >
> > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > > removal of virtio pci device").
> > > > >
> > > > > Virtio drivers and PCI devices have never fully supported true
> > > > > surprise (aka hot
> > > > > unplug) removal. Drivers historically continued processing and
> > > > > waiting for pending I/O and even continued synchronous device
> > > > > reset during surprise removal. Devices have also continued
> > > > > completing I/Os, doing DMA and allowing device reset after surprise
> > removal to support such drivers.
> > > > >
> > > > > Supporting it correctly would require a new device capability and
> > > > > driver negotiation in the virtio specification to safely stop I/O
> > > > > and free queue
> > > > memory.
> > > > > Failure to do so either breaks all the existing drivers with call
> > > > > trace listed in the commit or crashes the host on continuing the DMA.
> > > > > Hence, until such specification and devices are invented, restore
> > > > > the previous behavior of treating surprise removal as graceful
> > > > > removal to avoid regressions and maintain system stability same as
> > > > > before the commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > > removal of virtio pci
> > > > device").
> > > > >
> > > > > As explained above, previous analysis of solving this only in
> > > > > driver was incomplete and non-reliable at [1] and at [2]; Hence
> > > > > reverting commit
> > > > > 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> > > > > device") is still the best stand to restore failures of virtio net
> > > > > and block
> > > > devices.
> > > > >
> > > > > [1]
> > > > >
> > > > https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6
> > > > C6
> > > > > 38 DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> > > > > [2]
> > > > > https://lore.kernel.org/virtualization/20250602024358.57114-1-para
> > > > > v@nv
> > > > > idia.c
> > > > > om/
> > > > >
> > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > virtio pci device")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: lirongqing@baidu.com
> > > > > Closes:
> > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9
> > > > > b474
> > > > > 1@b
> > > > > aidu.com/
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > >
> > > >
> > > >
> > > > Tested-by: Li RongQing <lirongqing@baidu.com>
> > > >
> > > > Thanks
> > > >
> > > > -Li
> > > >
> > > Multiple users are blocked to have this fix in stable kernel.
> > 
> > what are these users doing that is blocked by this fix?
> > 
> Not sure I understand the question. Let me try to answer.
> They are unable to dynamically add/remove the virtio net, block, fs devices in their systems.
> Users have their networking applications running over NS network and database and file system through these devices.
> Some of them keep reverting the patch. Some are unable to.
> They are in search of stable kernel.
> 
> Did I understand your question?
> 

Not really, sorry.

Does the system or does it not have a mechanical interlock?

If it does, how does a user run into surprise removal issues without
the ability to remove the device?

If it does not, and a user pull out the working device, how does your
patch help?

-- 
MST


