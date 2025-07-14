Return-Path: <stable+bounces-161834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7DAB03EDF
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 14:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29721897E6B
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848BD225771;
	Mon, 14 Jul 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOuHotqw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01D24888F;
	Mon, 14 Jul 2025 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496765; cv=none; b=oQBa6rm5ik9NH1Zf2TQjEInOI86vvyYOPdI0hgGXQuvrRgIKxUszeB1Jmge5tYwSpgTM3yDWuxD96o0OF2BPzRQteDakR07gIiZ0LNGjHjB6oJth1+1wbURw6OBH0uTeOcGXmIHAtWT6f4r5ZvB+CYBfSSR+jVLXVu7M0bZh5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496765; c=relaxed/simple;
	bh=TnP+vFs7IXRlmpvE3Fk2ALLQD/fNY7FOCcgBNk0jD4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUmA2+bkKDEzOId1QGcd2yf5fub+QQOLRWv56zAiot5clXmHfI3OlEUYzlkGBIsn/PPo3rvq177sI3HRtMHiii0bopi/c3+fw+cLqUBMmXuYeD2sbLaOgAfPxByzr6DWRFfQT6+bcrP10/NX3w89DBZT8XixzGQj4OM8xbAlXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOuHotqw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d6ade159so30763065e9.1;
        Mon, 14 Jul 2025 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752496762; x=1753101562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu7d6TzejWOVv1PWLxvsbY8Bo8x9azrAfli/oRpw5r0=;
        b=iOuHotqwLPBPZKpXHIamngyTskvsjOfEjbvFdnYI3j16Un+/Fbxh2IHFBvjX01nT0u
         H4NXCu/42E/H4iOUf/rguzZ8bbjnDQL6YcflYZtfFztNQXz8tJMteI9yUUNk6kbFO9R4
         7bLAbhtWe04h4YkES7fsog0T8xxIminv3wE9McY1keb1EDeTodJMP2kNZuoM5u8nFrbW
         zTeVDm/jW8JeGLqiUJ4bkxI8jhHbHtUQtDO2KOapJPsy/xe21rvpghO0DuX1o8/JxJ10
         ttlduY3VzVO/EIp7gxxVogI1DKlVe/2yWpRyoSXYx93bX9dCXm0GGa64mB2RdZC33n9C
         ocag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496762; x=1753101562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu7d6TzejWOVv1PWLxvsbY8Bo8x9azrAfli/oRpw5r0=;
        b=XMZZfBOAeMirZNonGU0A0vzWsJQNmSnuB6x/MfhZUvNkmLQFsBQcUYySOUJ9vPj92M
         cp1HzpL0Kv4aZJ2tmyAJTB+gac1Hi5K4q6G5WF/HKwyquvWjAk3hLn2y9yS9KnQUDBTF
         MhbF/cIzkNzuyLja3Y8mo5dn+mriztTmR+OKAImJGFrNDVu/rcdlwVBPjG7bR+amFSOe
         h6cascrK2Z0Z7FK5nzdqGpxZ+9V+nYiwaVmIJRkoXLtBbbZeSNaDy9yiCPcecIdYAX5J
         ub6pwolsMO+bQ1zt6EmKus4WIhY/Yg8RF7a4yWiVZLKbrofNg/TGVTaQHe0u/7dSNupa
         aUUg==
X-Forwarded-Encrypted: i=1; AJvYcCV1EhBwNKAgoJa6l1XQUcQ39HmHqDGk9GtpE9zj3VwFyWAeX1BeyH8AWPNKO59VFpazMZZTrkGAiZVNx2U=@vger.kernel.org, AJvYcCVnl9D38y2Zd93PkByS4GMU47SH5pGn/kuNRhAAcLPvHrGUQ5z77n3M62XR0a28AgSW60m0qT2Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfgl9L+RIrEAEakakYuYADS6ee/QDNWcptfjDfKjeKQh+FOW7
	RpPUZwWgJvOrZ2KA9hyGBKZBjc3j+t1qUFe9HJrktFEycThW8LjVWuun
X-Gm-Gg: ASbGnctL39od5sP58nXXOkqz5Ntbl15rzEDXuQjtSwX6jDG2GP+wUT8VkgGa+4V+M2V
	eRo+jOnPGTf2I1Hl/v1hZV3OicV1V5kvQrV5JO0OiI/tOftgVAsowaJUh6++149ryg6YsCv0QbB
	xsJkRHUlwsCVIIq4g4BySdp1mZcWlNE/PBzqnvabujpiNFx9QNZtf8/EN8hA1yaDWrMfCTBSNJw
	B3UFIqjNKp0Vy0MQ141KmEffU4eedx11D9jYhyAOljEHTAmnC83H4+mImofyKBwcIFSjGefnuuY
	JwuTqNjJPjxKd/uJ2W2Ts5PEY4i/TDvns19fhbyny6mYnuo+7J98H0PXeRIgLomCTSl9v/fyJ2z
	gcHWZOhI/bbOIJh8GxfZjclxFZhUcXi9+HcRthzutWOp27DC9LQQcBBN5ETzMI/DIeo3pq8s=
X-Google-Smtp-Source: AGHT+IGYYRHzkc0tCtHZgZ1HBPkUbfByAJiZ46m1oEz+lW6gbL5TanX3NgxDe/beQeMjz+LASAM6nw==
X-Received: by 2002:a05:6000:5c2:b0:3a5:2b1d:7889 with SMTP id ffacd0b85a97d-3b5f2e26c9cmr9474793f8f.43.1752496761755;
        Mon, 14 Jul 2025 05:39:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2710bsm12288225f8f.99.2025.07.14.05.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:39:21 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:39:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
 <kevin.tian@intel.com>, Jann Horn <jannh@google.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>, Peter
 Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Lutomirski
 <luto@kernel.org>, iommu@lists.linux.dev, security@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250714133920.55fde0f5@pumpkin>
In-Reply-To: <42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
	<20250709085158.0f050630@DESKTOP-0403QTC.>
	<20250709162724.GE1599700@nvidia.com>
	<20250709111527.5ba9bc31@DESKTOP-0403QTC.>
	<42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 11:22:34 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 7/9/25 11:15, Jacob Pan wrote:
> >>> Is there a use case where a SVA user can access kernel memory in the
> >>> first place?    
> >> No. It should be fully blocked.
> >>  
> > Then I don't understand what is the "vulnerability condition" being
> > addressed here. We are talking about KVA range here.  
> 
> SVA users can't access kernel memory, but they can compel walks of
> kernel page tables, which the IOMMU caches. The trouble starts if the
> kernel happens to free that page table page and the IOMMU is using the
> cache after the page is freed.
> 
> That was covered in the changelog, but I guess it could be made a bit
> more succinct.
> 

Is it worth just never freeing the page tables used for vmalloc() memory?
After all they are likely to be reallocated again.

That (should) only require IOMMU invalidate for pages that are actually
used for io.

	David

