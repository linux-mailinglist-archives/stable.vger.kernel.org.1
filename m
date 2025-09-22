Return-Path: <stable+bounces-180949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F4B91487
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC5818A1F34
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C553B308F3D;
	Mon, 22 Sep 2025 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dVI0L7M6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA872608
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546145; cv=none; b=tr7ZHg/YaPdI8iJvndRk0QRmoWPcu8YJfbJGn9q18sSn4dCThHKUN9eqtfayE526Ibr/GylARRWyvBpacrCAVu9G/4goCGgs2PzY+HqzU5JNaLOEa6rqf+8twxjrfs4JuTBQ92jZka4JvS9++PVEVxx8w+qz4qtydqsvmu6l8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546145; c=relaxed/simple;
	bh=zCJZQaGMV7DeUHFgiP5VUvTeBc76Osl5IXFpblnovgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjEYNq+hTSboy09NtCOyEaeEo5jsGj52TKfB8JvsnWINJosnw9AfbGuKyAZT10clp+KkQUV6zYRFG1OSs4GsVSnfr8xgyDRZfwIPoI4IXISM00VB/p3Xx1/H9sWdWkgxvTLi7+v85AO5VNVyKF4fUwoy1sCtgMuhde6vq45HkZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dVI0L7M6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-267dff524d1so31860765ad.3
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758546143; x=1759150943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsl2ly4me8UmHDMkRt9NyvebrtmZ4APkli4pzDgp5iY=;
        b=dVI0L7M6OO/YUKKg75P4Pi8haKMXHKiAa71sfpXGYTUn59whfkElnIGEkdSM/iJArJ
         xUVgEZ1Jp7FN0v3qYF1JKBYDrrP9hNBO6EMWISwLge6BwSUDoKtMd0zIAvEGMh7RyBHF
         sBYCyizcs/XEX9Lxrdksjq0G5HOPfjErLCldXx1GleskmU0T5Mfw09+5iS1X8XAN3xNU
         Lvf7QUbT6iNYaFfdNOnrhHOaUrjAn5NAatYwOJdIncPl2VIQfvNCanJ9I2aeLxOwQ3Mh
         UQbe2VxX2lQO5mYFHTOMGWj+XedeTeCVYHVCeE7tXNKWtzWwvvvvmkwP09ovrWCF73h8
         b+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546143; x=1759150943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hsl2ly4me8UmHDMkRt9NyvebrtmZ4APkli4pzDgp5iY=;
        b=cSJkpMAYAJLQm57bKpxRIIX6WanDKl49bBwex28TXVn9pPS2YoG2G6fjznekc/b4F2
         h2RWpdxb+bW4h+DLzCtHys9aZC/kL25JxfeAtAVRNyxbH0tCONaddex7Q996aWenP/AE
         dqFXb/haZUvTcoaTTvdHl9r0KJ7T0qWH+uWHC5w7DvyjjeesrpqshvMqdCtaIeKbtHzw
         Lao+OYqfTONU7s5WolUmqOSX43Z+jpkaCcWcqemaRKoX+mOPvjE3tCiGpyGMmAbBHtbM
         S+s7QtHpCTG7+TcVas1V3tLScswk+0cqzfcRe6npnYaoCqGsKzczyYRw4qyGzvwVLlKP
         6L1w==
X-Forwarded-Encrypted: i=1; AJvYcCX/VsOerX58c0OehEbUnApVSLpAHaAnnEThJP7+htDc2if8DxM5lm6U7sRjgLH/24F5fQBFD2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDkEeDk6XLbEzuyW7cIMtkCWpgTuFPt24Jb99E/OphpE6kmeb
	3TVt3SEC/31Q42xTHnW0wet/VZMxQRP7DfVraQPdaFK6v2P0VwOXbE7vkiVsfguQRGYzxk4oEJ/
	G2QT9Lls=
X-Gm-Gg: ASbGnctNG+/LVM4bNQ+7DQCtL/7zYOzA0EoPP0frBxm7YBbaOLYGQudcY9sW2dhukxy
	/4h7hqRdwA+X24LUbajh+M7Pnxwb4spLeSco+p1xl9Pz+Dyy1WC5945dG21C7eC7c9/hXwpMH/F
	wWaO16t/NLeWAN5hzNvkJBtD95QJVCP1c9V1KB+LZPC0tibf8GHnu2oeqvaiFd0BCQ92m4DI6xN
	1+nWA4QpGU2l8yCno7myFkuJIc4Zlct7TkODUjLifn/NwwCl2zrE25v9r794V1cs/J8HtAHuVxe
	OSSumzs95NeAEgobdoc6zbo0YuF9pGm2sbGa6/jYu8Vii0wwh5ZitSana/yRmD38I8mVTdNQ
X-Google-Smtp-Source: AGHT+IEwv94cgMdvdUliR3uxXVS/A4nFW/1Uk+w9E+kVZKrcO7lHiL9BEZgyiij4H8dwtTrp7ERipw==
X-Received: by 2002:a17:902:dac4:b0:275:c1e7:c7e with SMTP id d9443c01a7336-275c1e70ff3mr55507925ad.4.1758546141378;
        Mon, 22 Sep 2025 06:02:21 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deb3dsm132892235ad.93.2025.09.22.06.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:02:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v0gBP-0000000ALNw-0bkc;
	Mon, 22 Sep 2025 10:02:19 -0300
Date: Mon, 22 Sep 2025 10:02:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page
 table level
Message-ID: <20250922130219.GX1326709@ziepe.ca>
References: <20250911121416.633216-1-vasant.hegde@amd.com>
 <20250918141737.GP1326709@ziepe.ca>
 <c09b3679-00f9-43e8-a620-1a6051cc6db3@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09b3679-00f9-43e8-a620-1a6051cc6db3@amd.com>

On Mon, Sep 22, 2025 at 03:35:07PM +0530, Vasant Hegde wrote:
> > IMHO unless someone is actually hitting this I'd leave it and focus on
> > merging iomupt which fully fixes this without adding any locks to the
> > fast path.
> 
> Unfortunately yes. We had customer reporting this issue.

If a customer is actually hitting this then you definately need to
solve the whole problem including the mmap race.

I guess adding a lock makes it easer to deal with, but this:

+	write_seqcount_begin(&pgtable->seqcount);
 	pgtable->root  = pte;
 	pgtable->mode += 1;
+	write_seqcount_end(&pgtable->seqcount);
+
 	amd_iommu_update_and_flush_device_table(domain);

Is out of order.

The DTE has to be updated and caches flushed *before* writing the new
information to the pgtable for other threads to observe.

You can look at what I did, but broadly you have to feed the new top
as a function argument through to set_dte:
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data)
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level)
 {
 	u16 domid;

So the above can be ordered correctly.

You may also want to think about just disabling this optimization,
always start with a 6 level table.

Jason

