Return-Path: <stable+bounces-181424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3DBB93F93
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 04:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990D53B139C
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37AB26FA57;
	Tue, 23 Sep 2025 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhzuXE9i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A0615ECCC
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758593447; cv=none; b=mNdtG1yLKfFoCKaeBTjNgHYbM5QFmZVHmzaZPybYflBARRl4/pxTB26wWFCzrKiW2wpmkydjfDfYJ6DXNxG7DnG1b0IcsbTOZEtx3O7rBXpqZOpeYz5y6r6eHE+LjLpNDseul4Ho+ZiTZ951uhkzu7bd/0y6F+UUnojgXxnZF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758593447; c=relaxed/simple;
	bh=Vokk7nMMKn1nAZIr8dh0NVdcYT6ZkINY/dhjWCksAVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxigzpP8Hr9YyT7e9TLuvbXWY0rlbKttE+9/gMxHeL660kOl9bQQwHx6TVTpM7RLn1QRrekleIqw23ijWZwCVbEuHG0y+RgPZf7WyePAtJDtCHtpB5W9sw3UiLl83VaSwv7Cx7sW2Us1JnJfPZ9c0k1YN4Vnk2J0sOJhiUq5jkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhzuXE9i; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b256c8ca246so687186366b.1
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 19:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758593444; x=1759198244; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2o3DubClAWsVDJ1BnGOUzNOsvzg6slCDhpRe/M692Y=;
        b=PhzuXE9i8CV3KzZx/f/3wJY8oRHwnlG5xP1iBvundtUEZ15HNJ55Ho3WQqREgpbkLw
         FzLLNvVtPYf0pplOUPTTe10Egq/ykzTpPiVV0Jswa2cYJ6R0M2PvsG5jVnouK4VShPqW
         rimpf6+8bBnDI7SkO32iDIdfJJZWsKcejDykAcm/F4l1RfG40LDPs21ILYji484WV4lU
         rYjV1UT8dBcsXWj/QkNMjkzkrxn0VhGe8mDhFJ+83DdHvoMrVeSCX/xwblnRfKjZIzlL
         KEpwydeJfTkfLCOftt00o7dLbiOCIKUEMs+Rlk50jR0CNCt7W5Ud8sBca0LFJfzGea0i
         6yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758593444; x=1759198244;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2o3DubClAWsVDJ1BnGOUzNOsvzg6slCDhpRe/M692Y=;
        b=B+blkP1wklRNo5SQCje+0LHytuwRVRmVcnBZLAvP/EL5f1bdo7hE4DYbjdMMJj1ZVf
         gaAMuq7r32k9nA2eyYaMWSQp4+JBPFXhLJScS0lOOViCatZ5upimBUNV30D6KfVEkK1X
         Z9ZhUO1700S/hEIS4DCOdXI3rFqT/zax2CC9Yr5KevppFpMYamUfLkigYb1KkCHOTaUy
         doyJKX2kvrrR0CW1hiUs+d4QeOcSdvh4h0yGhzMXCGkCxebpZ6vZxIHEWyIIHfFwgcR3
         lRg+9RbQWCh26cz+wcgyM0IFe90kDAPjCX4flw/klBnr2pMI1nc6UECdzOFsA4e+woma
         GaQw==
X-Forwarded-Encrypted: i=1; AJvYcCUdC4AgDCs03Egw6e2R64ZETWwQO1FCUXeImiZIR2ygamv9St9ylyMeGWIyn/iuPurD3AMgCIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhiIiObSb6psitCp7NFcD48CDdYJVjWlDxgtGvFOt0Iy6OFE/O
	+hlNZEi2XablvmuV+kQLMOxOSDCLgYhWGQY0h0Ts33shq9rh7KlAVBgM
X-Gm-Gg: ASbGnct0/QDd7cHbdHIuQNSWk+e8IzSWTogEVdc2F/wZrp7CGhZXaEiv7Gx77I5Mnit
	C+Y+v7F3qUDfMKjHUNkiHWOQcsB3AntvihtZWHtoSIK/3qjkzFIQ09Le3wS28g+ClaAVK922Bkw
	o9StmwwUlBD+sT6iiyM+086MKz1U/wXOipvWIFL+F5ocmKtrb/KC+i4rx0YGjGp/L8oB0iaTI6q
	VNasazy6xw0OELQQ/lqpaplTN/BL3HLgsothgp4DRnfWmPyZKE5MxmcfPeaxlL5+iJDHXTXLv2K
	ARahCYV/WjTtikItVQGGzJWrFJyUCqTVufFc6zV+9ZK2n0Alc1ZXoxGcS12zgM+GHCkDXqQBzfa
	9ftU2RAbqOfDlTt4txv9ePT0tiar7smrmKCNTEFuL
X-Google-Smtp-Source: AGHT+IHh1ALlBKynJpngfEEL3Ms5mRjlxZlK1yneebgFCzG1payJHzKI+8XXxoWxK83o13jhnY/w3Q==
X-Received: by 2002:a17:907:6ea0:b0:b0b:f228:25a with SMTP id a640c23a62f3a-b302cccb3e8mr56042366b.64.1758593444044;
        Mon, 22 Sep 2025 19:10:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b28a990f6e1sm658553266b.37.2025.09.22.19.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Sep 2025 19:10:43 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:10:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	usamaarif642@gmail.com, yuzhao@google.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, baohua@kernel.org, voidice@gmail.com,
	Liam.Howlett@oracle.com, catalin.marinas@arm.com,
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
	kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
	dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
	surenb@google.com, hughd@google.com, willy@infradead.org,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, qun-wei.lin@mediatek.com,
	Andrew.Yang@mediatek.com, casper.li@mediatek.com,
	chinwen.chang@mediatek.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
Message-ID: <20250923021043.nx2k4ftzle6e2jht@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250922021458.68123-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922021458.68123-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Sep 22, 2025 at 10:14:58AM +0800, Lance Yang wrote:
>From: Lance Yang <lance.yang@linux.dev>
>
>When both THP and MTE are enabled, splitting a THP and replacing its
>zero-filled subpages with the shared zeropage can cause MTE tag mismatch
>faults in userspace.
>
>Remapping zero-filled subpages to the shared zeropage is unsafe, as the
>zeropage has a fixed tag of zero, which may not match the tag expected by
>the userspace pointer.
>
>KSM already avoids this problem by using memcmp_pages(), which on arm64
>intentionally reports MTE-tagged pages as non-identical to prevent unsafe
>merging.
>
>As suggested by David[1], this patch adopts the same pattern, replacing the
>memchr_inv() byte-level check with a call to pages_identical(). This
>leverages existing architecture-specific logic to determine if a page is
>truly identical to the shared zeropage.
>
>Having both the THP shrinker and KSM rely on pages_identical() makes the
>design more future-proof, IMO. Instead of handling quirks in generic code,
>we just let the architecture decide what makes two pages identical.
>
>[1] https://lore.kernel.org/all/ca2106a3-4bb2-4457-81af-301fd99fbef4@redhat.com
>
>Cc: <stable@vger.kernel.org>
>Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
>Closes: https://lore.kernel.org/all/a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com
>Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
>Suggested-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Lance Yang <lance.yang@linux.dev>

Nice catch.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

