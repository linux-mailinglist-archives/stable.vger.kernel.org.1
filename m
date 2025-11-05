Return-Path: <stable+bounces-192508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E1AC35EB3
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 14:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8DFF4F9748
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572F324B35;
	Wed,  5 Nov 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N3pZ3d1Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE36311971
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350423; cv=none; b=l1UPVF1mu4ah/hsPvH2AsBRzG373TbJaX3x0TFXSkO/wjV3vPFt1FDlfKLmHWynTQtY94DNIw/ZNqi+F+tHvpeax1jC78ACD30nll5SleaeCmjOSH3UDQoBag3srqu+fhJvEi0u8Y1CN/xhPAEXwdxjnfNUiRrVxsr7Ix5ZyhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350423; c=relaxed/simple;
	bh=bvfb8EO/Jqx4CYfgIOHPa1nosqTQWDLTokUveNsd720=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6yAaEUm7dNbpd5+Pad5P8h7XknBxMiHEBcu5SHgd9otTVS3ZuSzCX1OYylgBeUaYiTymhVVCmBEyReaSF7iGJVj/bix1iSCHZM4D9wB7HNNiS+qFoQw9LvQwtaFLCaxzAnO7lG9QgmKx/TPwRbQJBSngHaGzP7TJFvBA0S9HYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N3pZ3d1Z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed0d6d3144so61232801cf.0
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762350421; x=1762955221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zp2fLrlqJdhZLczeGkjeF6Ah1WqCYQgeoq7QTO4hMM=;
        b=N3pZ3d1Z8mSqvUg0662RC8bZpvOpu1qb+bANagfhvp5hZFNgEHpxU2PahBcew+Pa/u
         utZnfv9zIa9G34AoF7vaFOZoZ1gJsjSWlt+X1VCQX8Smq+blDDOCQWHW6MDWg+ww/wy1
         VRwkhKVRJFydAxQNS/3lZw44TocdqEqYzKvXFK5VccnNTL+lznJkK3FZyzzvy4l/dVe7
         ZDaDoa6p0vAbN8GraudRxwJEm72c9ML32aeyhrj7sOGy1Gq2OHxwLoot7zIQ4Bwma3V5
         E9oI73lULX4bRzmH7Af+/3DcoDsTKaz7guepOdSAONKPqeWmfWvoCKuyKA56QhlMY1oK
         HquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350421; x=1762955221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zp2fLrlqJdhZLczeGkjeF6Ah1WqCYQgeoq7QTO4hMM=;
        b=xVUt3RaydYZYfN08Cx4/HP72gbfoQmmkdHq8XrKb6hAAXs9bk4kOQ8WOAKueVWlecr
         CwKu5UV/NgsDFrwa8OEggPSUBLy9VNcdR0iZQCzs44PT18iyQH41IZq+wcQ7J7p6y6DG
         u7vEpXNAnY1alciaBRP5a0zC29vgE/2BBIn1h4aTjvkmXDMuhkrdKSEw3x/7Ni2VGLZG
         ZdQaHX9Gmm7qL2LwdDCQJXEPkPZ+3hybPD/zit7zfrBa4vKDTM367S/eFiQvmlsvkL3n
         8ORvAAqd13T9SmGjXVdgrrQX1sQ04ln5o6lfRH/O18FKLMu6j9Ymut6snbpFoL1hOJJS
         TE+w==
X-Forwarded-Encrypted: i=1; AJvYcCVSVt8WXUmdjGdPQuCKndMroEDytNRfTrcsBlM+/qQy39PTs9QhiSaZUjrAGGp7mDvNGh/d9/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg18jFYAXBUW79fokzsw0smElsMnkoVYSRHNspP/6SJYelMk3h
	AyfsZaYn2bh8Yzhr8vXq9xMjWk4vH6Wt8hy5zWfbnv0odctZvVgSKcMPJV6Rf2KBajE=
X-Gm-Gg: ASbGnctfbAalCzbvU+mkqL7+tBvd/lMDkNEz2Os/XS97gkTikW98JNGN2sbvcDnzYa2
	GXv4jmH4zfItc/62usGXUZ7Vf1Q0PB5C3VMRXVeyzad6XcsnSNpAHJnX8GOTp97kK5V22wFLUB1
	T3LjSw8Ww6vL4xYDPc6/eM/GCNMrjjLbwVPbR7hxu5Ivbiz9cVBxHnMzc3WMZJ48tqZvjSjj7hy
	su5eQvqGyImhr65RDLXEVEw7zOq/IxK1k4Wxz/Mb06PgRtwa53b3lFf+RFclgz0ZXI0pLfkhEoG
	dxmCVqLv6EVVpYA3dhgI9RfSekx7nozpDdgCUnErWwW7cv0ubJVYE8X+HVW5hR5zz6qy7gMwcej
	7rvg9mtugnUuddhhHHF3E+mB/Ron+q1i8ylTM+Wmnxo57Y4XLR0xde5L+rX5ZeD4443kIfSLq1C
	sgBhdp79F6E/1vSCMPDhisDdmq8geqHTQwNpkfFbgkT9iJow==
X-Google-Smtp-Source: AGHT+IHiV3DU9pUwV6yRzvNAkLqpA9Q0anM5JtolaRsT/xrM1GR0vgEGuAlaC/LkLUMiyZ6hyzBu1w==
X-Received: by 2002:a05:622a:110b:b0:4ec:fafd:7607 with SMTP id d75a77b69052e-4ed72673eb5mr39574611cf.81.1762350420869;
        Wed, 05 Nov 2025 05:47:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5faf6038sm36924761cf.11.2025.11.05.05.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:47:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGdql-000000079Nw-3Qc1;
	Wed, 05 Nov 2025 09:46:59 -0400
Date: Wed, 5 Nov 2025 09:46:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Ma Ke <make24@iscas.ac.cn>, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: server: Fix error handling in
 get_or_create_srv
Message-ID: <20251105134659.GM1204670@ziepe.ca>
References: <20251104021900.11896-1-make24@iscas.ac.cn>
 <20251105125713.GC16832@unreal>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105125713.GC16832@unreal>

On Wed, Nov 05, 2025 at 02:57:13PM +0200, Leon Romanovsky wrote:
> On Tue, Nov 04, 2025 at 10:19:00AM +0800, Ma Ke wrote:
> > get_or_create_srv() fails to call put_device() after
> > device_initialize() when memory allocation fails. This could cause
> > reference count leaks during error handling, preventing proper device
> > cleanup and resulting in memory leaks.
> 
> Nothing from above is true. put_device is preferable way to release
> memory after call to device_initialize(), but direct call to kfree is
> also fine.

Once device_initialize() happens you must call put_device(), it is one
of Greg's rules.

Jason

