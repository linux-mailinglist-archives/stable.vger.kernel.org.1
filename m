Return-Path: <stable+bounces-176493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB72B3804B
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 12:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E22364BCB
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB0525B1DA;
	Wed, 27 Aug 2025 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beM2Q4Sw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDC239E8B
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291766; cv=none; b=bStA+W/kIkiSd8ThzAO48BB6cnU4HduxZ7TJ4/a3R/WciqyXI2NmSREdrV9iXWzNm/wymVHiNMp5T23DLFdt+ns4IUAUhA94dG7FbPXyZ5fvj2Q+VW34okulsMouP3UmGNHn5zQGgBG/I2nLxx3cVP5Fp7bde7CZ8W7LiVjZo3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291766; c=relaxed/simple;
	bh=IC7fCUvyHICjYQqihsUvTpBaupm1KvP3zRZoT8zc5As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWKwBSgFRZ6j1pCfRbrYtkUG0DANUf4Cbep6PrPHXRdtZ3WdMwcpGzGbg3DvbHXh2uj/vzoXigFe5nkSMUa45kYxVeIRXNeyhvRrXP1Y6thwU7zzQBnIgFoK/ToUeRkuEIg477bRzK9RBONTgO4wSbUbX/zILWNYcItCq+70Ugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beM2Q4Sw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756291763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5RFPwfFP+Eg1oHSanrF7jLQgxXPAmT3vCxZYmVFSSs=;
	b=beM2Q4Sw+uwef4K8TFdI1B1+/M/Q5UufuPq9dj9ZNzUJ3xfHCheD0WAAM5EjvizGEqAV8b
	Z+A9w7pn026ZKCTpxzYZJmSzhiyMjucD3KkIo+D3Ks6IiUG24pLmf796ibSnHXtlVlQYhc
	akkzG0Qnq/pZ8kiW4ryGuSC5vsnLwwo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-jnF6ywXPOlGMiZ3NGSGcrg-1; Wed, 27 Aug 2025 06:49:22 -0400
X-MC-Unique: jnF6ywXPOlGMiZ3NGSGcrg-1
X-Mimecast-MFC-AGG-ID: jnF6ywXPOlGMiZ3NGSGcrg_1756291761
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c6abcfd218so3106023f8f.3
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 03:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291761; x=1756896561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5RFPwfFP+Eg1oHSanrF7jLQgxXPAmT3vCxZYmVFSSs=;
        b=lHVSiglY2w8kO/Z8vMv0rfD/63vgPUKloRmocKNQJH1pz4CDoPPbHJI2tQZCr27wnx
         GKhxKUvpaaENn6e+r9k3t+lyBYC38+FJ7U4ZyjOwocxe/lMZHWU9Po7PX/it71NHKfre
         pNMDlR2X5Pkq6lISIP0BWdLDV5jdVJ6iCZde6gXpf4vVFAaLQGCfKK1d5X7Pm5aHXCJl
         PqrDt4nTFdtr6xms4LAU6Zz6zDZjFZ6lHP94uNBewnhFWslmz+DkscFeft+qZ9Yvgcwy
         CnYETzDAsPKHWQ7tF/6sHjUpYIYrnykmMxQcu4om7vzj3aeryuCWA0podKbniCWLILFP
         7VPA==
X-Forwarded-Encrypted: i=1; AJvYcCVyYwUgBycAIOB0vzqHk3vVmFkRsQcmf2m2q3CW8ud5s3yzkaWo5AQ0ncTg+5gzwFF/7RBxElQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFP297bwZfvyo2/dgvL5v/5FKDw8kz4V78sWDFQTt+RfsWUzlH
	O4evZ89FM0PaInqXY9F2HotmifGnXIU6yp++vBJN1dw69rTHjpyKlrxJSbVPisFni4tjrZm61aO
	dq4S0Oda7ugSaHz4k+MokMXcTfzi9kltzCD+MA+AneuFHuPAWTtHVGsEH3g==
X-Gm-Gg: ASbGnctTdKAA6Tup2ep+bbJxGs9vydQqTn5fh/ZpatjEt2x9ngjFbZlt4GBuelsBbFW
	tpUOrR6T6flvu5BgVBum3/1mG/AkXrsJV9bg37IeuQm1U4jYGOYFmLq8a7CnS713MjotqYZo2vQ
	K0OuWEp+m3us1NpthcbwzfINv/xqLUHhbIv/TTU3WUblHk2Rzuj5qBTifPuhclc57sBfhRikugv
	KxMa5tU+Ztol1mwE8BzRMhdOD/KsDH7KCy5j47Nz2AQTUpOhU1gKRPnEYcuXN95iQkPoJVuP6k2
	XSCpS3yO8VlMtyOf6/mOIMXcwLvWzLI=
X-Received: by 2002:a05:6000:250f:b0:3cd:6477:a3ad with SMTP id ffacd0b85a97d-3cd6486e9c6mr178772f8f.26.1756291760796;
        Wed, 27 Aug 2025 03:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf0+K6BppvH8Hb/OqhP9C5oAmG47R8bj5G86xkmW64GR6L8venV4qa54EUuuubVB9HOzRqag==
X-Received: by 2002:a05:6000:250f:b0:3cd:6477:a3ad with SMTP id ffacd0b85a97d-3cd6486e9c6mr178741f8f.26.1756291760292;
        Wed, 27 Aug 2025 03:49:20 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc98998781sm2603758f8f.49.2025.08.27.03.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:49:19 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:49:16 -0400
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
Message-ID: <20250827064404-mutt-send-email-mst@kernel.org>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061925-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827061925-mutt-send-email-mst@kernel.org>

On Wed, Aug 27, 2025 at 06:21:28AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > > If it does not, and a user pull out the working device, how does
> > > > > your patch help?
> > > > >
> > > > A driver must tell that it will not follow broken ancient behaviour and at that
> > > point device would stop its ancient backward compatibility mode.
> > > 
> > > 
> > > 
> > > I don't know what is "ancient backward compatibility mode".
> > > 
> > Let me explain.
> > Sadly, CSPs virtio pci device implementation is done such a way that, it works with ancient Linux kernel which does not have commit 43bb40c5b9265.
> 
> 
> OK we are getting new information here.
> 
> So let me summarize. There's a virtual system that pretends, to the
> guest, that device was removed by surprise removal, but actually
> device is there and is still doing DMA.
> Is that a fair summary?

If that is the case, the thing to do would be to try and detect the fake
removal and then work with device as usual - device not doing DMA
after removal is pretty fundamental, after all.

For example, how about reading device control+status?

If we get all ones device has been removed
If we get 0 in bus master: device has been removed but re-inserted
Anything else is a fake removal

Hmm?



> -- 
> MST


