Return-Path: <stable+bounces-244807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MiXKF8f/mkRnAAAu9opvQ
	(envelope-from <stable+bounces-244807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:37:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216B4FA09A
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E592303EC0F
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D3A410D04;
	Fri,  8 May 2026 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jJT2dfwz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21812EDD7D
	for <stable@vger.kernel.org>; Fri,  8 May 2026 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261794; cv=none; b=INOL8111MwXwGDtvjBg+6jEkB3BaGH6A+yNdyXaUwUXxm/ebYtV/GWzGpZVk2DguywT3pi7keAoJtk5FPHE8kR+hG+nPWdUz2MrYRBv25o2gHGXAk3qjiCWt3s6R8sXqnMnmhBLOppfU5GlUCUGQYCHhl9VSRDarj7njNDUr+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261794; c=relaxed/simple;
	bh=OU1gxYIqGS+hUlkKXFu7H/zFbRvTyfjfeFJIkBy9t/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMSA1pqY2fi5TUtWHKBtDU+XZ7aykP6qY5Co+OZeNWK8ujANf6m0KJ+49va2U8yiYnEkcG1wX4vKps28AnJsRRe6L5ZHIKBHWNm0qUpBx0t8v3iJALwajN/d5bDHlkt9muwUCfmagL50q0Hx/35pb0qsOHbM1vf8Whj0+BnIN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jJT2dfwz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8f231f3b130so171945985a.3
        for <stable@vger.kernel.org>; Fri, 08 May 2026 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778261792; x=1778866592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxmQhUJsbyd70+Vusdx4W/KBVOYgLDyj/k4cRH8CB0E=;
        b=jJT2dfwzzmnNHr8nKif7tHrlY992Qyyjjx/BeI1636SbSC7Dmq98dqN9YqP4NT6CuM
         d+/1U8Se4VCiiRKLSy/Rgly1biEqqgF+acK9k6ZIzkY675dEhjGr435VxhM4I7Z6meZ2
         4dCe5FWjntMLAkKIguKU/wwQ7NkIr+Xdmpmve2Ub2cVqc47nxNLQxlqTro5ftE0P4/G7
         q5Hfex3kYgb6FaPEZuEVOwZECF0oUINJyuiJiNjliC2URqtt67Jdtvy/p+j0CQsjLj7B
         n3i9yGU1YeGwUfOUHHIatxYoOnsyrnFRoumIyL1Sw2ca1Vv2s4kKlHIVpefBamB8y5CZ
         uksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261792; x=1778866592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxmQhUJsbyd70+Vusdx4W/KBVOYgLDyj/k4cRH8CB0E=;
        b=oX3La3JDo83gXn6TspEeAtDGZv5tb4WGOOM4zUKgWU3qLo+2Ik6LBxCtRX/bF9fkqi
         MiGEQMnHQOe3VjoCRk09gQ88RKX9pck2sGClPWsdkmzyJ4jz/z1A57avdxyMG36Wp34N
         BBreY7+pHxfTzv7anuLtW2a9vrwEwu3lWotG4vuhv6SrCEM/x63rPGizWCM/vXrbDL95
         DRb+/3TwT3g8mIAR7Tgy5HvLdoGwvcNLBoY9Kesu9JmdCWL5Q0EGk5Tm9onJry6xHnHM
         dF2A8gw6Cur0JLpsqhwoK4Kri1NKelcpnhnq0mOtARC8vKFlWJfoLgYwTvBmhwIyAIbW
         H08g==
X-Forwarded-Encrypted: i=1; AFNElJ+QmkB9uSrzz2bQu00TLoi7lqgIX1hqXEhodpLV+QAy+odWPn+cvRDvBaL/oUb6yGej53ojOL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8BZQGk3q98hqzdTMglfXHSnTAXX8L4Zw0bspkaf75ZrV45QTB
	V8gPraNcFDZpCkAjCl/iE+f2Bw+UKRnKNc0otKPmkHRqwzHBDN8j5YB43BxOq/HqyGC3JZdgo2k
	d/PTvrgZB7A==
X-Gm-Gg: AeBDiev+t9qXmZ/vJLuSM+fw5Zo9DIH4FQqZvzs9tw3CXSkM4u1cX46GVHXtP4MEvbC
	Oe/4TnT90r8bgclCsadJkHOHD5a02fVWLzR6974li/dvbBpA3jmuMk6IWJm8DzNR5jegInspQKs
	IbMKPINiC7jsUO0cYb9NWyB/3g3Yr6tb2UwbOFqRGT9eDuhsGssaqpAeCyvOL9DWc3yVT0VnGFB
	T3ClRhFMWw/r9zxYjeM5YfryEzJhwyfwmetbwBEC03pNTrM9prX5vbaZyBxeasT5qoWbMSIxRJ3
	EwTZxI9qRkf/D36Dn0yPu/OfkuQLywiHq11x0xEiMXV5wxGcv8MUtpAci5TkOdr0HkSQcgKCLEN
	PqbJDqq40Jg+zMJMkjd+EyOXpGgLZ6vYTs3gxxoSaZz8CFXCejjVhGKni3svUzePdU5+eiR8L3Q
	gBu6jDwroVx+u3I74mTN0NZuF/s7FULDeP39L6ewC5eK3A+lvC/U9A+BZTF8JfhZMmpVj6o6orW
	yTguA==
X-Received: by 2002:a05:620a:179e:b0:8cf:d88d:c46e with SMTP id af79cd13be357-904d69d8ef1mr1994373485a.48.1778261791849;
        Fri, 08 May 2026 10:36:31 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04c68sm2315053685a.46.2026.05.08.10.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:36:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLP7m-00000000Cx5-2s34;
	Fri, 08 May 2026 14:36:30 -0300
Date: Fri, 8 May 2026 14:36:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
	m.szyprowski@samsung.com, leon@kernel.org, kbusch@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
Message-ID: <20260508173630.GC9285@ziepe.ca>
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
 <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
 <20260508113100.GA9285@ziepe.ca>
 <662fdf07-6475-4807-94b0-54b3b439ae1c@arm.com>
 <20260508151857.GB9285@ziepe.ca>
 <4134fcd9-7d12-4e76-955d-5a679916a0c0@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4134fcd9-7d12-4e76-955d-5a679916a0c0@arm.com>
X-Rspamd-Queue-Id: 0216B4FA09A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-244807-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 05:04:31PM +0100, Robin Murphy wrote:
> On 2026-05-08 4:18 pm, Jason Gunthorpe wrote:
> > On Fri, May 08, 2026 at 01:16:25PM +0100, Robin Murphy wrote:
> > > On 2026-05-08 12:31 pm, Jason Gunthorpe wrote:
> > > > On Fri, May 08, 2026 at 06:01:01PM +0800, Jianpeng Chang wrote:
> > > > > > As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
> > > > > > would be enough for what we want here, although now it's strictly under
> > > > > > CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
> > > > > > might be less of an issue. Either way though, now that it's all
> > > > > > channelled through the single dma_map_phys() path, it would probably
> > > > > > make sense to consolidate any MMIO sanity-checking into
> > > > > > dma_debug_map_phys() anyway :/
> > > > 
> > > > > Thanks for the suggestion. Move the check into debug_dma_map_phys() is
> > > > > indeed better, and I will replace pfn_valid() with pfn_valid() &&
> > > > > !PageReserved() as you suggested.
> > > > 
> > > > I'm not sure that is right. IIRC pfn_valid() is true for ZONE_DEVICE
> > > > P2P pages that are used with map_phys but never with map_resource.
> > > > 
> > > > PageReserved isn't enough to fix it.
> > > 
> > > It fixes the false-positive on non-reserved pages, which is the important
> > > thing. Yes, we'll get false-negatives on reserved ZONE_DEVICE pages and
> > > similar, but that's still an improvement over getting false-negatives on
> > > _everything_ by not checking at all. Realistically, dma-debug can never be
> > > exhaustive and 100% accurate, but there's still value in catching as much
> > > obvious misuse as is straightforward to do.
> > 
> > I'm saying I think the new expression still has a false positive for
> > the common case of map_phys with ZONE_DEVICE P2P, and I don't want to
> > see debugging logging for normal as-designed scenarios in map_phys.
> > 
> > So we either need to narrow the expression further somehow, or leave
> > it in map_resource which has fewer users and doesn't accept
> > ZONE_DEVICE anyhow.
> 
> But surely anything with a ZONE_DEVICE page is "memory" to the degree that
> mapping it with DMA_ATTR_MMIO would be wrong, no?

If the ZONE_DEVICE subtype is MEMORY_DEVICE_PCI_P2PDMA it is mapped as
MMIO and must be used with DMA_ATTR_MMIO.

> However, IIRC ZONE_DEVICE pages _are_ reserved, so still wouldn't
> warn whether we'd like it or not. 

I didn't think that was the case for PCI_P2PDMA, but yes it does look
like the reserved flag remains set.

> I'm confused as to what you're objecting to...

I don't want to see a warning, if it turns out it doesn't then it's
fine, but it certainly isn't obvious that it was going to be OK for
phys and I explained what we were worried about when we had left this
behind in map resource. 

So this should all be summarized in the commit message moving the
check

Jason


