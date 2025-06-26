Return-Path: <stable+bounces-158659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086EAE9651
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 08:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D355A1439
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E9230D35;
	Thu, 26 Jun 2025 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIR3paP/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2913A3F7
	for <stable@vger.kernel.org>; Thu, 26 Jun 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919639; cv=none; b=FjODLam8vfW/4rM6v5WY5Ornh/QlTexUWeazvREpx8cT/Lj7RpTbqThRSW0paL6m72xpb+psRDTQvTADp0xDWShTHHQjUkMqu1Iq6Q+Q19j6WXEw6UnEg/JLRWhWpKAcJIbagCB4/7t7sguFhexrSByUFl3GPhDQiGd3xvny7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919639; c=relaxed/simple;
	bh=J4s9+J+hh9eMHsOMiBgtL6JiImJ/4Z+NIXFm3a0EhpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXp4vrDbAartGxMJxJulnQc0raBYkXS+TP/jvDF3kfxLhHEJL3EQkGW/cKfbGmIPXKfYWbfKUexCeHvG0sivbX4UAoRpnSYUkJWD5Rjnu+cuL1vAfoZzvpfy5Xwq7ztgPt1ARzjUVAm5sL04NUHoHaHeaNruEqIcW7ENheHn5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIR3paP/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750919636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/TLlMh3aXs2TRrbk8rfKXAxcWbrMfWOfFVjrAWZ8rQ=;
	b=aIR3paP/I7Jad4i6rnZoKfrZU/CExFQTaLTlgbY5DK/dWA8yzHgZs1GMV33PO4H2hvgMKI
	3cdekMXZdfNYXABIJFVOB+QFXPaxyqQpPtHF1s1s0nJ3PP32+dyQV1+XW5a3oR4uF1C5lk
	i1YGxeC+SFCgXgOOXX07ZDnHW7PWYUY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-0U7OSWu0NkalokMpKaxpQQ-1; Thu, 26 Jun 2025 02:33:54 -0400
X-MC-Unique: 0U7OSWu0NkalokMpKaxpQQ-1
X-Mimecast-MFC-AGG-ID: 0U7OSWu0NkalokMpKaxpQQ_1750919634
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-453817323afso3223895e9.1
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 23:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750919633; x=1751524433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/TLlMh3aXs2TRrbk8rfKXAxcWbrMfWOfFVjrAWZ8rQ=;
        b=Vh8tJtA5FOVCfvGxzPpj2yDMwmrNOVy28/dufkL93IHLO2j9AfMYEIXOhGXM1WUuQ6
         N5O4Md7gX2TRVZ6NtVE7NqwwfGPhID2/gFmk813dzMaIRwZAuRDKoqVfn+i+921ZOTmw
         9kSWjcO0UJfL57cJHH9acjpsAGYtz6tWWhd8Fv760O4MGJgIVoMDD9NCbBo5xCxGo3rx
         Cd/hi1qNZ6nuCo/bLn+z+ws6Zm3TY8BfDGopAOLTXJ5OoJ8gGdxfgeiccv7xDbWa63AG
         kBAr60hBsthRswYAokoi8FCpX0dY+WjbIUtPLB9KTRAggr/swsHoePB6qF9rH0Onbg7d
         +HOg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJbWGk49eSvX7j8/cUFwSRkQK4tWzVBzVr60Q3IcEHWwMPaZCUddkhHSPFDkTXLDpFwJ/YF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkkyfFEYxCFn9rNCvUxRSJhgBvf/VZRn8dEB6/XP3R7/DbPj5e
	6Inhfd9Ganj7YJMGT8A98fq2yrJtFdrtdoKIFBms3+g5uervIvZ4xPrjHNpIl7UZjbk2OkviB4Q
	7qQqKa6Cg/xfLqNWx/IMROSwFU6pQDScGRwPAN7HqpPzw6O7rKDw+Nqrh/Q==
X-Gm-Gg: ASbGncvwREeL1s9RR2InkvQmkfsfRdEUwowimVE1tcUX1/gbM0oDiFn+gsDi/QBdCVe
	U2TG/k4cEj3jxNpIX45K3T9M2qv5RSVacA6vdsCM5iLKjdoP4DHJjJM3kyksTAGkswGkQHQwFzz
	+EEdzw1yjZqtNsc4PIaAAfhbljSp71jZ09PtCwS2Bh+I1XsWlDF+BvEpHhEXc+7G7IAGy8QRf52
	xsJ9J8TW6B3D/P8m3mCX7QxSkj3XU3QIJQFoyuftB8frRbOrYrd75SgumKe76wCkG7gn0vyxNOU
	DpAFM2UJR0uRF6sE
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-45381af6a8fmr60953685e9.16.1750919633501;
        Wed, 25 Jun 2025 23:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY1gVtAu6xNPmuOKtlgkoZHvhQWkHC705oPq3RWgy6yjcOgBSGke0BghulB4p8vItj5d6DqQ==
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-45381af6a8fmr60953305e9.16.1750919633023;
        Wed, 25 Jun 2025 23:33:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c3c7csm39585545e9.36.2025.06.25.23.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 23:33:52 -0700 (PDT)
Date: Thu, 26 Jun 2025 02:33:49 -0400
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
Message-ID: <20250626023324-mutt-send-email-mst@kernel.org>
References: <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626020230-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Jun 26, 2025 at 06:29:09AM +0000, Parav Pandit wrote:
> > > > yes however this is not at all different that hotunplug right after reset.
> > > >
> > > For hotunplug after reset, we likely need a timeout handler.
> > > Because block driver running inside the remove() callback waiting for the IO,
> > may not get notified from driver core to synchronize ongoing remove().
> > 
> > 
> > Notified of what? 
> Notification that surprise-removal occurred.
> 
> > So is the scenario that graceful remove starts, and
> > meanwhile a surprise removal happens?
> > 
> Right.


where is it stuck then? can you explain?


