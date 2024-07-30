Return-Path: <stable+bounces-64678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0809422F1
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 00:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D540D1F2320E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60404157466;
	Tue, 30 Jul 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEuVepDD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C518DF9D
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378615; cv=none; b=e7c8pT7oEVhT7h/jxcDrTk7kMA0i/rPrVH4PQ2HQvNlZyFnsG/Dc6PAOeek0f86PkB5DJ4a1JR0c86ZwpIG2iR22/7QjplajVb9B2fFP0pWsrNjRHf7RIvcUIrlPV+MZy1Q5nJ/1wYb62/IdnoKjgvK9QQv41KSsfapwDdVRbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378615; c=relaxed/simple;
	bh=lukyko6WhLd86bIprzKWnfPyMYA0WNaoHkIQZi8WLTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYB66Qf7dD1dlAIRva01k6yUIE+5YqdiPrPAHRSxwXvQ2HdqAZEYHH6O6UPYWBKjvVsnyTGnYVOS1th4bYOOZAUtEb3sbpgnBL0Nfl4SQdF6XMvNyn4YfATxvul7U8IPpap7unF6oCmyyWAfrALqKyVJgs5g9sSVWSUsncFtMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEuVepDD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722378612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5kNYpg9eUUfaVFQlHs3iXOjdZpeVmxNiRg//4lRozI=;
	b=bEuVepDDHuRZPnoRaO5DGFC+XJbTZOsTV5euOlAK3eEXKaVtIf7Z7pVj3WeJpy4qVuueWE
	JZlk5sAgAe/+U1uv6SAxbQj1l3ZsxvSjoElJT+rEQv2pltFg/wOiP7gpFMgRksTqigZUQo
	7rsoknJOlvXr4tMEG8JMYsWWItMJ7B4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-y4ZyhBb5OxCUcFejk4Jv-A-1; Tue, 30 Jul 2024 18:30:10 -0400
X-MC-Unique: y4ZyhBb5OxCUcFejk4Jv-A-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5d5b4ffa0c8so1027349eaf.1
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 15:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378609; x=1722983409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5kNYpg9eUUfaVFQlHs3iXOjdZpeVmxNiRg//4lRozI=;
        b=riexM55xAwGR51KLQjB5ZU/wUD+0J1EIWrnwC8pfW2VtqRi3r4Yg8j+xEwyxtjX5cV
         kVsH4DexYnDnGpw5l1yLBFF32bsL3WfsaAUNxmMoqd0FdVmiV/Xah1qegAQwJZEdxdOl
         7KhGHIMrLDZ0kdiqSyabJXLwn0ajqHEU6+UY+3nteWsswJ7+iq0L0MuaFAdmqFtNADYy
         5hEL3qqMYvdb3vNUHWYWonkl6FjZmx8q/QsdOCgJpFuuOAVEM63CpKw7frjUqmDuOo3A
         dGImmt9ET8gO+p6G8gz6zcEzUBt/flUl+OC2XSNhBHaxHTuresNQkObYLfnmvNk3Jswd
         j16Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLgGlBb9xKq6XVtz24i5uYiynxI4BiS4HBXHpGM9JFi2XNF2wI0zS1vm8DhwCss/Hm6jE48eahhJEqHJfLxNV3ZvtIGUsx
X-Gm-Message-State: AOJu0YzlpC8TJarZp8gkrU1IyCHCWzhxFR53Kbg6ScbeNN4FT/oSW0xN
	DWjuXBPk9mOpPynhYuHQn8yUsks63ZT+v5pnC3IJtypcRt4oBxl/YZqYCcUQQhlUDIn0HO5jnih
	LNb765Izo/yq8B5JtlZ0/1EOwgMb0nwnOC/PKH0u7A5nOwL0xU1a2eQ==
X-Received: by 2002:a4a:a542:0:b0:5c7:b587:40a7 with SMTP id 006d021491bc7-5d5b15373c5mr10749406eaf.1.1722378609525;
        Tue, 30 Jul 2024 15:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJByCxdD1t4UZwfqqPdgCZsn2gbVDdIJGfCxxyPNKDP8T1DbcoLV+Wd5i1D2Eds9HHRRl71Q==
X-Received: by 2002:a4a:a542:0:b0:5c7:b587:40a7 with SMTP id 006d021491bc7-5d5b15373c5mr10749390eaf.1.1722378609089;
        Tue, 30 Jul 2024 15:30:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb5bcffd18sm45807036d6.15.2024.07.30.15.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:30:08 -0700 (PDT)
Date: Tue, 30 Jul 2024 18:30:06 -0400
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Message-ID: <ZqlpbuJ7bXE_r9dO@x1n>
References: <20240730200341.1642904-1-david@redhat.com>
 <CADrL8HXRCNFzmg67p=j0_0Y_NAFo5rUDmvnr40F5HGAsQMvbnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HXRCNFzmg67p=j0_0Y_NAFo5rUDmvnr40F5HGAsQMvbnw@mail.gmail.com>

On Tue, Jul 30, 2024 at 01:43:35PM -0700, James Houghton wrote:
> On Tue, Jul 30, 2024 at 1:03 PM David Hildenbrand <david@redhat.com> wrote:
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index b100df8cb5857..1b1f40ff00b7d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2926,6 +2926,12 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
> >         return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
> >  }
> >
> > +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> > +{
> > +       BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
> > +       return ptlock_ptr(virt_to_ptdesc(pte));
> 
> Hi David,
> 
> Small question: ptep_lockptr() does not handle the case where the size
> of the PTE table is larger than PAGE_SIZE, but pmd_lockptr() does.
> IIUC, for pte_lockptr() and ptep_lockptr() to return the same result
> in this case, ptep_lockptr() should be doing the masking that
> pmd_lockptr() is doing. Are you sure that you don't need to be doing
> it? (Or maybe I am misunderstanding something.)

I was just curious and looked at pte_alloc_one(), not too much archs
implemented it besides the default (which calls pte_alloc_one_noprof(), and
should be order=0 there).  I didn't see any arch that actually allocated
with non-zero orders.

The motorola/m68k one is slightly involved, but still.. nothing I spot yet.

Thanks,

-- 
Peter Xu


