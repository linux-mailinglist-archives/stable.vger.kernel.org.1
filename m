Return-Path: <stable+bounces-158779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DBBAEB78C
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 14:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBFD1C43223
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689552BF3E4;
	Fri, 27 Jun 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fkjl6Rv0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C092BEFE5
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026887; cv=none; b=FejcbEcHokPdDAQ5PT8bKRHJ4A24F6cIwuCf6qtM3XBrr9f82m0vTqnwbcwsV5YiHC27JUWbygZehGpe2KR9oaNuZaVD/MHG3LZ/d8M6X/bVt01hBLOuQSOKvA/a+pyI5aZUxYWuOMPzBK4+9fq5tmZ/LFzKZDiwEUnWdRFeFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026887; c=relaxed/simple;
	bh=+5aEYy8/LHHi4FXnbdS5ukMXKdh3+6yLZdvJXSlBL9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhAOzhZjak9cqhqewfZZIG9F9CJ9HsggKWSh616sKHZYcT0FIQgdvwuAVmNz4rsCUnvLMgSqRVuZNKmSZsSEkuALgS+2M1xvmRkB8IlnlvSvmwSN8boAVWVJhDtUzGYo4QzdS2qk/Hm4+3SCRfeDuRr6C1jSwdbJErICedLqLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fkjl6Rv0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751026884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJSFEuy9I5CCg7RQrigp77Ej+GXF1LquTOkHLyT7czY=;
	b=Fkjl6Rv0viCuUHy2OCXb6BRnTM0zWG9srx1WypwygXba0ay/ei/DNcLxibop2yMoMrTTwJ
	l0vfWPIraldeFVSvpSmFwcGKbP35Rp5ApDj/0TIngkEVuQ1ByaDDgLlVs/oo6jyTV2iYii
	7cIO2nVqWbUguPZomCW/Qohx1gF5Obc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-0_KPRZbDM9KI-TM0JdEijw-1; Fri, 27 Jun 2025 08:21:21 -0400
X-MC-Unique: 0_KPRZbDM9KI-TM0JdEijw-1
X-Mimecast-MFC-AGG-ID: 0_KPRZbDM9KI-TM0JdEijw_1751026880
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so10748225e9.2
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 05:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751026880; x=1751631680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJSFEuy9I5CCg7RQrigp77Ej+GXF1LquTOkHLyT7czY=;
        b=eOoh7adOEBbxiRbyaR7g0qm/tEXYHBcbkQ9qNTAP5Xqm0r8LG/8XlTRyRCgLoWyHjC
         /IA/15x/k4Nis7+njpcN+h/fQEm+43Xdqo9nFP4094Px9S7iBjfA4EZfrjLGhxpbg6k6
         EDao5zcljTJp7jNh8MJvHF3JbuCxMnXgl2G7uDlMJW+bg7aHg87oMuVUspC20eow6dib
         SCp4Ycz9QjVNlt+cqKwQqDJeLbXiIerOz5+lCemv1W6JjcuEOdrTYCtjXnbgvnrMeoh3
         x5cyaVSTtQDSyZke612OXtlPVWeF3LO5/BmsEObCdZXSUoUMiMmrikLhUJsmQkHSFcqI
         SJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5TOCsUviChhBn6RMqSeYVtOyeB6nPvG4wYtrm5R30AVO7Yphl0iQ7/ROhlLn39dsYnPD6iYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6dq2NBxz0wioDQ4Ub9LP/C1dinwQtLO4vFfHSw66rGwYJDzD
	pS+v2Zjy8bZLPpsBA8JhSAFN9l3IELO1CrS+hkhgxDpSK50zSOffp3ZcxtFuHhUWZFv88kISAXA
	z3K6J4PNu20wMtsQrSfx1jYXetSmTYFr3RzQvr2O5nTy3P0lMsuA6ZdGQQQ==
X-Gm-Gg: ASbGncsWuWlsDVfcgCOhLLoidKysTbu11W63maBttlHOvuMD2ArTmw4jnNdvlJD7VJb
	r0dRUQ+l3ICKIfJ3zMkzluDTpv4oY+zqxDqQQNhdCVuXbgkrh412JgchcA6CO5PYv7n5autkzPe
	c9uwL8R93mf3ya66iLvo/ZGYTGwbQ6EW/JAoF41ohJHxMHcmTwS7p4Cj5ncv4UGusCOutc9u0rE
	J8HZODZnm/YWliQCKExZcZsPDT1H2GgWpBrz4Y9Dw4yvKDuqZQbwitfUDnQq3S05EoELrz/qJbV
	P+DN76yBXmq8Q9Bl
X-Received: by 2002:a05:600c:1c1b:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4538f376511mr31929565e9.3.1751026880158;
        Fri, 27 Jun 2025 05:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPFIKbNJqoUHfjnJfvtoip1KeoRTxGz5M9CfWv8c4GpayUIF3Rky7v6/Rn9JzNgvu+kOV4tg==
X-Received: by 2002:a05:600c:1c1b:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4538f376511mr31929215e9.3.1751026879698;
        Fri, 27 Jun 2025 05:21:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45380fd167bsm58441225e9.0.2025.06.27.05.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 05:21:19 -0700 (PDT)
Date: Fri, 27 Jun 2025 08:21:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250627082048-mutt-send-email-mst@kernel.org>
References: <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626020230-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626023324-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71958505493CE570B5C519A0DC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71958505493CE570B5C519A0DC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Jun 26, 2025 at 09:19:49AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 26 June 2025 12:04 PM
> > To: Parav Pandit <parav@nvidia.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>; axboe@kernel.dk;
> > virtualization@lists.linux.dev; linux-block@vger.kernel.org;
> > stable@vger.kernel.org; NBU-Contact-Li Rongqing (EXTERNAL)
> > <lirongqing@baidu.com>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
> > xuanzhuo@linux.alibaba.com; pbonzini@redhat.com;
> > jasowang@redhat.com; alok.a.tiwari@oracle.com; Max Gurtovoy
> > <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> > Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
> > removal
> > 
> > On Thu, Jun 26, 2025 at 06:29:09AM +0000, Parav Pandit wrote:
> > > > > > yes however this is not at all different that hotunplug right after reset.
> > > > > >
> > > > > For hotunplug after reset, we likely need a timeout handler.
> > > > > Because block driver running inside the remove() callback waiting
> > > > > for the IO,
> > > > may not get notified from driver core to synchronize ongoing remove().
> > > >
> > > >
> > > > Notified of what?
> > > Notification that surprise-removal occurred.
> > >
> > > > So is the scenario that graceful remove starts, and meanwhile a
> > > > surprise removal happens?
> > > >
> > > Right.
> > 
> > 
> > where is it stuck then? can you explain?
> 
> I am not sure I understood the question.
> 
> Let me try:
> Following scenario will hang even with the current fix:
> 
> Say, 
> 1. the graceful removal is ongoing in the remove() callback, where disk deletion del_gendisk() is ongoing, which waits for the requests to complete,
> 
> 2. Now few requests are yet to complete, and surprise removal started.
> 
> At this point, virtio block driver will not get notified by the driver core layer, because it is likely serializing remove() happening by user/driver unload and PCI hotplug driver-initiated device removal.
> So vblk driver doesn't know that device is removed, block layer is waiting for requests completions to arrive which it never gets.
> So del_gendisk() gets stuck.
> 
> This needs some kind of timeout handling to improve the situation to make removal more robust.
> 
> Did I answer or I didn't understand the question?

You did, thanks! How do other drivers handle this? The issue seems generic.

-- 
MST


