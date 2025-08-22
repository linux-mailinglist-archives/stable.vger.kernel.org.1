Return-Path: <stable+bounces-172399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF4B31ABC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55377A077E5
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7472F90CE;
	Fri, 22 Aug 2025 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjwZnq2Q"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD982F066B
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871183; cv=none; b=MbjcH9BHLLwWBQOrnfMdsq73n5xZzP2xI639keY317uoKIQWbgIhgCkRwb77jEhHOQsQQRjX6/XOKWehv2Q3Oh4J2b2Q9m7ysnUAqPETip87e7rYUvaMkXgZZXfEEs5/larxH578rSjK2dnvlDAa/T8+kMUG7YAmSjOerRPtC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871183; c=relaxed/simple;
	bh=VF+xLya3ySUvhLm4vDWwokcjvbjrzp6uqdePmBQvo3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilF1V5VHpf5HIfBugbaIAfzQMDvFayIueAxJWs7Xx5FVxcS+JNg+l8uQ4elwgbsMd3IccyTo9Vvbv8cBThRGprEuD6ceHUp0+/RfTNQbtHH4mvnuN2DE4Aa3oBJ0j5RUZlaa9T8BKNaa1IszUxKBDz0+kmW7AeCXzqwyQE31Zec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjwZnq2Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755871180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnPvDlcUiGZQU6wBgxu7LXqKZV7ykR+RAYYj3wGlDkc=;
	b=ZjwZnq2Qjhjk39Gz4qc9SdU7qJTRkezlfi7aRlGCpeMYyl/1ktq0XB30LWTqSpFv1oMYJJ
	dxrSkeT3uAN0dQKPL8z4PG8dAl/5OZvfyNJrdVsTOQxlwJwHxHNl8It/xJEO32sPLfLgjz
	O6BV/6gcSMCiqJntzJ0HILLWNUZ8pBs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-VWnUrPgQM4-9lbCTBR2ujQ-1; Fri, 22 Aug 2025 09:59:38 -0400
X-MC-Unique: VWnUrPgQM4-9lbCTBR2ujQ-1
X-Mimecast-MFC-AGG-ID: VWnUrPgQM4-9lbCTBR2ujQ_1755871178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b51411839so5393025e9.0
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871177; x=1756475977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnPvDlcUiGZQU6wBgxu7LXqKZV7ykR+RAYYj3wGlDkc=;
        b=BWVC9c2OUm5Zl0Ra2JbdpbvzRWWFPq5EFCwLjTo6aHg4Ck7Obv31fw8KxJ/3xYB7Ih
         ta2jYuLKfUgbgufWUORfP13NDCJUvQ3LIX2Y17HO5xXyJXK1tW1NjEOqxsTrfYK72w76
         XSaAbuPUZS0vS2GmYb3T+xhfG8R/3RkEa69Gbuf7M4nnd9I6DWvzGvk3Bovf4UaHbO9z
         uEuIOv0HdzCjK4RMjzw5A7o5wFm+jAbqk2lJp1Lmlq3QRxV6Do+OfqZt8638AkFw3dAG
         4o4+9Ak5W1UR8Ln5kHFyrbw7MFRi8HC6a9TZCEo8TvUBwWBdFFV/W7AlioMROgpIPGeK
         wUEg==
X-Forwarded-Encrypted: i=1; AJvYcCXtlMZFU5LBa74tBSxtVAaTsv/Wa0+sQThxL9V7DnZheO2BRdGH3SYFg9eM2CHgjCpLD9q5Xes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZp3kx9ENzqbTtoxDqtL6dxgsS0NauHaFmsRg+kt4ERkof2dP
	Gv7CzsW1X3hJderyjc8vaBA5wDSwRiNRlvncDlf3dSeuWVW9qmHEz2EHnCWrAZMsm06LMziSb8+
	4323XWj9P901YbXb9wVr/z8xx07Keqr+gr4+L1DlsYAUFJ3JTRn5Nw88WnA==
X-Gm-Gg: ASbGncsjvQcD7SUlvRMUXgZvmBvdzLo4d9/MCBnjCOrUe9kXN73lj478FveyuRakF1p
	rQowieAb18C6KogwNJ81JIYca+fnriu7edwfavg5KrtAVqnQDKpvylfIbWooDfBJDV0EUGouVOj
	M1QXCbVy/5POUm8dO8YBdmIeRrfjl33QeWkpAWvWN3cauKMUeNXkg5DgCoCLURReLzFTggNzcXX
	2IBBxTuwtaCddSWlfKlJ4ModM8yPHfin41J0jVVeAjwcIeJhmY2uDl97/o1x9c69snpKLI7IK/i
	pLVAgwUStw0S/7e0qeopiYPtItGJ7oH1
X-Received: by 2002:a05:600c:1554:b0:459:e06b:afb4 with SMTP id 5b1f17b1804b1-45b5179b4fcmr28171505e9.4.1755871177517;
        Fri, 22 Aug 2025 06:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLtkZ5binTDGJP5H9sQ/FcahKe+0bwWJOvKaUEtMpcaAju5kmaQNlWbm/v3JiCp+8NfvNhfw==
X-Received: by 2002:a05:600c:1554:b0:459:e06b:afb4 with SMTP id 5b1f17b1804b1-45b5179b4fcmr28171195e9.4.1755871177074;
        Fri, 22 Aug 2025 06:59:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57417f61sm702715e9.4.2025.08.22.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:59:35 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:59:32 -0400
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
Message-ID: <20250822095225-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Fri, Aug 22, 2025 at 01:49:36PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 22 August 2025 06:34 PM
> > 
> > On Fri, Aug 22, 2025 at 12:22:50PM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 22 August 2025 03:52 PM
> > > >
> > > > On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > > removal of
> > > > virtio pci device").
> > > > >
> > > > > Virtio drivers and PCI devices have never fully supported true
> > > > > surprise (aka hot unplug) removal. Drivers historically continued
> > > > > processing and waiting for pending I/O and even continued
> > > > > synchronous device reset during surprise removal. Devices have
> > > > > also continued completing I/Os, doing DMA and allowing device
> > > > > reset after surprise removal to support such drivers.
> > > > >
> > > > > Supporting it correctly would require a new device capability
> > > >
> > > > If a device is removed, it is removed.
> > > This is how it was implemented and none of the virtio drivers supported it.
> > > So vendors had stepped away from such device implementation.
> > > (not just us).
> > 
> > 
> > If the slot does not have a mechanical interlock, I can pull the device out. It's
> > not up to a device implementation.
> 
> Sure yes, stack is not there yet to support it.
> Each of the virtio device drivers are not there yet.
> Lets build that infra, let device indicate it and it will be smooth ride for driver and device.

There is simply no way for the device to "support" for surprise removal,
or lack such support thereof. The support is up to the slot, not the
device.  Any pci compliant device can be placed in a slot that allows
surprise removal and that is all. The user can then remove the device.
Software can then either recover gracefully - it should - or hang or
crash - it does sometimes, now. The patch you are trying to revert
is an attempt to move some use-cases from the 1st to the 2nd category.

But what is going on now, as far as I could tell, is that someone developed
a surprise removal emulation that does not actually remove the device,
and is using that for testing the code in linux that
supports surprise removal.  That weird emulation
seems to lead to all kind of weird issues. You answer is to remove the
existing code and tell your testing team "we do not support surprise removal".

But just go ahead and tell this to them straight away. You do not need
this patch for this.


Or better still, let's fix the issues please.


-- 
MST


