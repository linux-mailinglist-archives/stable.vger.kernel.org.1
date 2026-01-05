Return-Path: <stable+bounces-204890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7D5CF5461
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 19:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13DA03057447
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 18:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E420340A5A;
	Mon,  5 Jan 2026 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lL6a0PUh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39B2222C9
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639268; cv=none; b=kyGIMTIWjJAibGPwwBGwog7qpACK3Bh3EYZpExRuOjSsFHwSZXoqbjGhY53m/xO+vFjgTm8aUZNrrBKd5L7CW54dw8sT645IAjqdL0S6zuXA3XgK1TP0AZZBiHwVMXGJe8bt5Xt1n6TJBw6yP0kX7AP/eAPDZmPIKMmlSY/vaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639268; c=relaxed/simple;
	bh=ye4WgWUCpvD2gGQR0QMsre2IOoSU2Qr1YG9uLKSAPu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WADD0+GcVZ6aECVFsTcuXEnO4B3TDtDi0l4pFBZucCROmCYtZQQf8Roasy+wuIUXR3Wa+Ko5lKOucacTJ7lSGZ1cIuPkoEDRvoA5eRSW5YLISYwKKwJnQkMyPS4j4/P8uRakKyORNLvcqrkSayPx4taYsaOoBIIYdmhNe+L8QKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lL6a0PUh; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so2447881cf.3
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 10:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767639265; x=1768244065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffKzN1sLhhBqUNkiha1w3dy/564YXw9eASHrYEoDuBI=;
        b=lL6a0PUh5hFbD+jGwKhFYw+mmBcAwY9uyrnKVqBnvP2sucHLePyOzRttZJWE/wafk4
         ZHm2+YzJy4BrPnPEYergxuY6nEy7xjuNwdarmAjljYTxDY59GhABCovuJt696uR/Wo45
         yM9auSwFt82COCondpF8oTiRO7JvH7t+26PKozuwRj2LOQAPU+qyIT8Xpc1ThGQ+AvKX
         kLL884LCzAtdA3kybeuK4h6uenA4VRHqxx7oU6LcutyVujBYlu9NteAK37r/I1PwvA4D
         bQAmAvQn6FspMu8NtXEGeOzVOkdOqXUDfuiKQTLK7UHVHjE9w6MNlGrFARCI4q9TrMGs
         RggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639265; x=1768244065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffKzN1sLhhBqUNkiha1w3dy/564YXw9eASHrYEoDuBI=;
        b=TN4U2+0MkSsJnwbZzSh5WDmzQfYhN0BmEHmwRAnBIYFp5Bm9dEBhzRkom3XorV6EI1
         UG8NjG8tQorcB4dYPmoC3TlvNDqzQ/ubY1Kgd2nW23E3XNF0uI+2tH4Y9sxmC9awQlFk
         W7hKCiJcrM1Rgu0oMxwpkHOVi2F72pBSTJr6eT2WXfavSQ+F0IrBTCZcu4OC4c7XNWdd
         rUeE0QQjvoiynHAV9qXMq2o2ktDdyJBLk8pb5XXeWWSGDYx5v8Hx/G0XkJ90jzFSTP2i
         hpzhe5Vn+MKPI3NPwPdDykIoTzl4CVVzkwfbiP/EpGX1Frv4iVqHHYdTg3q0q5gjdAl6
         IJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7wKuN+wz6Ssx3NSIvwl7nAPDX5t3wG/zr4quN1K154Te+W4ibcronoEcEiGv3F7L/8vyeAsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxw6XFCls7fOYQpfezRLoJOXYguPnXO33a18sEyZpAXf5XfFEc
	GBEHQDhDHeV2wKpoy75foHQHC+8qMJgP4LUGnC0eWG0tR2i/t8wtZTxgTz1AuqEQAmk=
X-Gm-Gg: AY/fxX4wl/dm1oSWIDLi6c1T5sxpb0li/EnVkLkcuJCDpKvHQ+/SSStKQzGLnL9io+c
	fPo89F8TqrmEcH8T7g7g61aJ7o1pszJYKahG2F2JwifW1JLRyHi5qNTrUKMMVG/zFCEt/DuAqTw
	TzCkyEHj7yRLXD9c2spR7iO95pjxLDNDTYyS8UoMUFnTJXwoY1H4wg7TQxdc+TziKA1kjltUpFv
	+iw1LdmraUVPuKHFo2QEUHyb+0mOB+Z/rjcu/dzN5+njirDz1ZqxTf6DbM7o1jsFl+SUKBW5dXW
	NKHbKfvKKumdyMTKnkYPIBMogdv2nGZiD3o313FMQXqhxVqXi2pIDv6HI3ib1vFn5Opk9O+r1PE
	Iqq6NGucClG/Aet6UMuR9TYveea08qIjjMnBqaeXIfBo5IFARL3lIQ6jGz6Vp/cWFwhrSa+R3Ki
	DDy1GMMwurFypw+1fSDdaWjaKynqWleW83PjGAk0zJZ4KwyKtZ2BsxteeJYRZgFEkhutA=
X-Google-Smtp-Source: AGHT+IFPnEh+/aHLidYNOpkwlSqg6n9Ja4S07lmjAzoYGYdPvIKU/oQn/q1c0tGHGXl/b++dfA2K6Q==
X-Received: by 2002:a05:622a:303:b0:4ed:af59:9df0 with SMTP id d75a77b69052e-4ffa77f5e8fmr6419151cf.40.1767639265008;
        Mon, 05 Jan 2026 10:54:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa71fc4bdsm3676911cf.31.2026.01.05.10.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:54:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcpih-00000001C7Y-21aN;
	Mon, 05 Jan 2026 14:54:23 -0400
Date: Mon, 5 Jan 2026 14:54:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Dawei Li <dawei.li@linux.dev>, will@kernel.org, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Maintain valid access attributes for
 non-coherent SMMU
Message-ID: <20260105185423.GI125261@ziepe.ca>
References: <20251229002354.162872-1-dawei.li@linux.dev>
 <c25309d1-0424-495e-82af-d025b3e6d8c8@arm.com>
 <20260105145321.GD125261@ziepe.ca>
 <f253d6aa-1dc2-4b1a-85df-f43b06719c04@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f253d6aa-1dc2-4b1a-85df-f43b06719c04@arm.com>

On Mon, Jan 05, 2026 at 04:02:34PM +0000, Robin Murphy wrote:

> > It is reasonable that Linux will set the attributes properly based on
> > what it is doing. Setting the wrong attributes and expecting the HW to
> > ignore them seems like a hacky direction.
> 
> Oh, I'm not saying that we *shouldn't* set our attributes more exactly -
> this would still be needed for doing things the "right" way too - I just
> want to be very clear on the reasons why. 

At least I know of HW where the SMMU fetches covered by COHACC:

 * Translation table walks.
 * Fetches of L1STD, STE, L1CD and CD.
 * Command queue, Event queue and PRI queue access.
 * GERROR, CMD_SYNC, Event queue and PRI queue MSIs, if supported.

Have a mixture of coherency support. The SOC has multiple fabrics, one
non-coherent one specifically for isochronous traffic.  In HW some
SMMU sub-units (like the table walk) been wired to the isochronous
fabric, while others are using the normal coherent fabric.

So when it comes to this statement:

 If either the SMMU or system cannot *fully* support IO-coherent
 access to SMMU structures/queues/translations, this reads as 0.

The HW is "partially" IO-coherent, so COHACC is 0.

It has been lucky that so far the incorrect attributes haven't caused a
problem, but the next spin of this HW may have issue here. I'd like to
see it fixed.

> bug per se, and although it's indeed not 100% robust, the cases where it
> doesn't hold are more often than not for the wrong reason. Therefore I would
> say doing this purely for the sake of working around bad firmware - and
> especially errata - is just as hacky if not more so.

Yeah, maybe, I am also curious what is motivating Dawei to do this work..

> the DMA API aspect I mean is that in
> general we need some sort of DMA_ATTR_NO_SNOOP when mapping/allocating such
> isochronous buffers/pagetables etc., to make the DMA layer still do the
> cache maintenance/non-cacheable remaps despite dev_is_dma_coherent() being
> true.

I have a feeling this missing support underlies some of the reasons
why FW might lie and set COHACC=0 as it resolves "how does the GPU
driver cache flush things" with no effort..

Jason

