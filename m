Return-Path: <stable+bounces-179534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12043B5639C
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 00:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D001786C7
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFC2C08AF;
	Sat, 13 Sep 2025 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkujNk45"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015E259C92
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757803259; cv=none; b=WEus9Bau98zysVpqczKxWWE5A/b4Ry6DT97SsM9NeV26weWWzdYWH50jaJZzEF3raci3MX+SDWtnifNpo0VAGawDJuXoLcxxT1rw15aESJ3hwNK5x9R2F6CwnSJrvJh3SGxSSk4KrBzWNrIJlNFQPHNPSBHaoPHgNXnVV3QwhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757803259; c=relaxed/simple;
	bh=5A698XP+0lJFfC5l4xGGNFGdB0BbNgT4DqPSHAUll7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWOv3M0j3yRDQfNrrIPnDHqIZ6W6CvhXWpEe3fSWgO6GDAiwczxYzfWGbQtAheWOzvv+q5o2xtVhgef51pjWNzLNPWKy2s/V/0BISvpnxOQITXM5KGGIucscfA6Q6VWkVTjwwjLsZUzqynPPQ2BMNidsfMboahhlYjG7k/SuGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkujNk45; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso6060537a12.3
        for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757803256; x=1758408056; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIyqUhB1pC6+qHWKldxN6/IXlcUmORgD+qGLpajGseE=;
        b=KkujNk45ngjDjpfVczAfsj+4F4kW5rpLgQvekbFA+Kij1maDQSSz3MqyaRjTJ9mrpy
         sKZYZkzXYdsa78TW1s0hC1kdjOqwgW57md9urt71IgUysR8bV2xqd6o14AsZr7i0v3vI
         ozfwgxjariBDHgpjmMhdUXpMEqbwmzgIx7InIw/u/hr1MqOOlWLhX9aluwAULI1Phmol
         9BUwkeIwXfN5fkryCckwynS3gIyik2wOIbqlmuwT5bNXiT3WgZHmYz60k03vCtYfus9W
         afEl8UrvTjGG+tOvo35sKYrcY2YNY6y34KrVg9X/G+/rAO1lmZjalKectzNrCpDnu5Ag
         DePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757803256; x=1758408056;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GIyqUhB1pC6+qHWKldxN6/IXlcUmORgD+qGLpajGseE=;
        b=W9OxGmWYdoSCGi2xFHuTyD+T3S8i+ZAe6NhN+lc10yCBUNdTOUojOyECR5k45sj01e
         4yWO/j1ZEutibZZ+h1j83PAGT0/Hdjgkbp8Qee1TIaLv/ajfnyg6A/25fNd5wLsTRN+9
         D+CoVuLeFJc7gqjG6fJVHdABVYbwC9dN3IvixP4ZMDa/5bu14q1fvSYZo0Ht6vkadyqr
         Ahk2MduB8C4Ir/WCbSbvEXG5L6lKkde0Z2FvKFkUOrA6Ltb3EKXePu6Jej8+KBq9P/9L
         aB66YR+p+oNLywJ+FMDCfUUk1WggOpf7DXdJZX5A4acaoTTVTmh9f7RZ+V16I4kmo7k8
         wuQQ==
X-Gm-Message-State: AOJu0YyrgMM7hEs7zgFxJOkVgcrOjOlwMlRcz46ZgeK7u1Abafe8JQLR
	3DDnU8vAM+bIARiGkdKyjPBtYwxnDsh5XljCg1MHCuMoJIxhIFqBk4Uo
X-Gm-Gg: ASbGnctW5zQJ1mR5dk4kESI1szqpU5MqwgJuPx7mL135MDDDVJSYgYXFd6u0jYzK/V+
	qFgKd4plzJ7zL2FCfGYX8AplH2MbL3uYqLe0u5yRuc8AjGVfc+R1bnEp0xdvMeurARAogtYfWn2
	TyvZwHeNfa3j6K+ugK7mL9KEJBuqcXwNB4HchAnatWCDTB7rw92Zw++kG+qJmU2GTrE9s8HyvKs
	LT0CVhw2/TrenqWoY/h31lYjO9A8qlzb074X2m4ygY6x/9Ja3fYM1LwL+j6UqW+WoLEusL2WQ+q
	EbhhE7pUyPtMesCXJgIqXsfz/nYdtj70L/7JVDPFqlkIydkIWyBtX6VYMsLlYCj7ydHwwbr4LKX
	4Xnzo9kxNIRofrelMPR8MFg==
X-Google-Smtp-Source: AGHT+IFN/6qT/KpOnob+Yzl/Pse6IqWRipEhPJroKeidy1moOPNGmvmyfSO8OiyXnNogED/Vbkhh6w==
X-Received: by 2002:a05:6402:505a:b0:615:c5a9:4cab with SMTP id 4fb4d7f45d1cf-62ed8241153mr7248020a12.13.1757803255794;
        Sat, 13 Sep 2025 15:40:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec3400d1bsm6192476a12.44.2025.09.13.15.40.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Sep 2025 15:40:54 -0700 (PDT)
Date: Sat, 13 Sep 2025 22:40:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
	Dev Jain <dev.jain@arm.com>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y 2/2] mm/khugepaged: fix the address passed to
 notifier on testing young
Message-ID: <20250913224054.lc4kgsfay4rgsnwr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <2025091344-pronounce-zoning-2e65@gregkh>
 <20250913190337.1520681-1-sashal@kernel.org>
 <20250913190337.1520681-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913190337.1520681-2-sashal@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Sep 13, 2025 at 03:03:37PM -0400, Sasha Levin wrote:
>From: Wei Yang <richard.weiyang@gmail.com>
>
>[ Upstream commit 394bfac1c7f7b701c2c93834c5761b9c9ceeebcf ]
>
>Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
>mmu_notifier_test_young(), but we are passing the wrong address.
>In xxx_scan_pmd(), the actual iteration address is "_address" not
>"address".  We seem to misuse the variable on the very beginning.
>
>Change it to the right one.
>

Thanks :-)


-- 
Wei Yang
Help you, Help me

