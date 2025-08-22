Return-Path: <stable+bounces-172385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED8B318B8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1EAA4E1259
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD6A2F99AE;
	Fri, 22 Aug 2025 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDQbHX/8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45028AB1E
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867846; cv=none; b=r4oAwEibqZy9Smzku83Z3sWPcc4UMsGNQO3QnZFfRdmva/EwqgWtJyrxS02AxmYdELIYNQxyAEv1eOyMYZoVaLMFV/gb3U+Pwc5FzUyDpEVO4QKeFzT22CPSLRQ9N6Cktru4ODmPt/5dxA8+rKUhi+jiRZ5FD/bwP0Dk+6NyZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867846; c=relaxed/simple;
	bh=n922tzKEixyTFAkTAqnzJwmbXE0RKvWKZfpZ/AspRKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TET9oiiv8Fpo28UuCJynXzPylVLZevx6N/JiS9ZN8MsnHi8mhGoMuSrOrJK/lxXTyCt04KIRP8bg259MzFqj5Gcjavara5EQmLGGRkpCZSJA6suA2UMX4FgsP4M/9OxmjXRrvgAnRkgWRakDx7uMus9rXlVPNMhAqlSu7QEk534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDQbHX/8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755867843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HQb772XW6mDHLLr/wV9DU+xM69+Gf7mm1yUdHyKM7eE=;
	b=JDQbHX/8DQU3GzCITTQ+M6W/djzb+ObKmvm+ulLWE2mV3W6/UtH8DrOfV0m7wqeivNvdrh
	+IjiKDsOp0MGeAolUwRih9HKMr9UAM4+2YqNbF7Q05K6MhcCM8l4mtglTGVwCoOnlpb46y
	lEogEUYbzOfDzG/2WRVnWCPrgkWGK8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-pPePhOKeNySF4Ixx7nKDIQ-1; Fri, 22 Aug 2025 09:04:01 -0400
X-MC-Unique: pPePhOKeNySF4Ixx7nKDIQ-1
X-Mimecast-MFC-AGG-ID: pPePhOKeNySF4Ixx7nKDIQ_1755867840
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c6abcfd1c0so123517f8f.1
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867840; x=1756472640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQb772XW6mDHLLr/wV9DU+xM69+Gf7mm1yUdHyKM7eE=;
        b=D6C6oVP5l4XHP6mHHZedlVuLGDJOLW+MrJrmeA3U+FnhDdjf0dh0aRiwErr2fjjTVD
         UkbW90JfwXZbrXjehPVYH2Qgua0jFgFj78E2/az5Ux40P5/zYuZS9pA8JwcS5fDR7H1w
         DFBpmPEUAX2Rwc//37S1Ilhfs7cBb+unWDOW4p/6WmEAQ7F2FQnNDPuTh7gKXzyt1XiJ
         cVTdUv+lgZw34MuvOSTtr96q/7dnRSQu0mmn20WLNqMJM0XWQUcHTfNlvvUyNDwiA5nc
         4ZfnuhpDeN895F/RtJF+qu+xd3HMCn94yDeQNaKom3GtufhtktTypCrdD7a19c/z6M5b
         SPog==
X-Forwarded-Encrypted: i=1; AJvYcCU7XAn2F/QMl0SvlwW5hFlQkg5+sg+NFeHHzNVoOlRDUwIBK1b3ZaltEGgp3kfQ26eYsjDcO4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jVD43z5eAfK1kooYORXhySgSZdlhAhyKk09Np8BL/9lchNHj
	qIzOw8HShPAyOVS/SQIQ4BiIl1dXhQunRunEBAeKJqlZ70ojqrCGfH5nlRjbrTV8UFJh205IKe/
	hlaGSqu6z0MvC6g+zdH2rE3W6RTsEvVokuHYTdsnp6M8JN3DhsRP99OTocezvp0R6Xw==
X-Gm-Gg: ASbGncssp4zH+FPKpnabTKcM4vwlDzdDONSR/sPIS2nwxjqu0WBRtC+P8Cvpty2Ni/U
	dWXIvqYU14ZhN5X/KjLIpAXWothKOyqQVJzWsoQSCem3kNvaF6nm0QV1oT455kAvTIi85DRLnEX
	gEAyncX54wZrBKE2lPEHtYnHO0u2kyKHORZM3CP888MbBiN84VcRXa6hPH65R5gYLfIkVFM6HlN
	k7xrSlNlJqrW3JZ6frr2qCL8cHYtADic19xLt9zwt5uw4LZVJMAbms0O2vXUhZnLdIfhuzYPp3C
	Cg7Tc0MtYDrJd857JMgp9BpBT5+d92rF
X-Received: by 2002:a5d:4283:0:b0:3c6:71c4:15b1 with SMTP id ffacd0b85a97d-3c671c41891mr1015388f8f.37.1755867840146;
        Fri, 22 Aug 2025 06:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFhC5B1jD8ZfPwkZJ3jikuS5+ewej/ZadWsC7KMuAIXD26cfW9TJH3ggA76ktwpgn5qb6F8Q==
X-Received: by 2002:a5d:4283:0:b0:3c6:71c4:15b1 with SMTP id ffacd0b85a97d-3c671c41891mr1015358f8f.37.1755867839631;
        Fri, 22 Aug 2025 06:03:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c66f532992sm1535036f8f.38.2025.08.22.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:03:59 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:03:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250822090249-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Fri, Aug 22, 2025 at 12:22:50PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 22 August 2025 03:52 PM
> > 
> > On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > virtio pci device").
> > >
> > > Virtio drivers and PCI devices have never fully supported true
> > > surprise (aka hot unplug) removal. Drivers historically continued
> > > processing and waiting for pending I/O and even continued synchronous
> > > device reset during surprise removal. Devices have also continued
> > > completing I/Os, doing DMA and allowing device reset after surprise
> > > removal to support such drivers.
> > >
> > > Supporting it correctly would require a new device capability
> > 
> > If a device is removed, it is removed. 
> This is how it was implemented and none of the virtio drivers supported it.
> So vendors had stepped away from such device implementation.
> (not just us).


If the slot does not have a mechanical interlock, I can pull the device
out. It's not up to a device implementation.

-- 
MST


