Return-Path: <stable+bounces-100485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E09EBA1E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E918879AE
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50FA21423A;
	Tue, 10 Dec 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MlzcHmQF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0D214227
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858750; cv=none; b=dGBsob6j98UF4Rd8OMDBPqej3kjuIVevz+9it3kWAKZki/nWv81GlLe7Tx01cIIsNc9bGM3SXQs8PFH9b6mQhuiOXn14InVlyJdUMOv4/oIxYIaM4XpubPjIExA4cVi1FQb+Przmhrw4SyMz2S3b7ZPi2DZG6cy7JAh8Y0/hJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858750; c=relaxed/simple;
	bh=yI+m22eZ47zXqA5alDA7J22lteBOg4qMNlifPwfSWN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvLwB8dWEPLaIpjIzRxVVYgfIGBk42wHAfEdRTZiKcGumdGf7PHKSC8LCAe3J+3idQPP0vjaemHZitKmI2CIp5XqUeBN3snznsDMYP43McOvhsaqdjX7on5qiCmnEliYQqgODn2Xf3iAhAjF3JAOhkr0dspDKI/SxecPYFvijr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MlzcHmQF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b15467f383so507436285a.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1733858747; x=1734463547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NtCkjYpTzUEcQtUOoTZj6Gta+taIvsFh5ZGDIhZ+nM=;
        b=MlzcHmQFLx1B/vUsWXUWnPSqa/I+ywcQr1V1YOM+wk7muYD9AsVjVjDCIVqm1BMQwz
         mrsyDHUoNX99txgOWsmnu1aHSHTH46UkmqXwqPO/i+RhTB8AkATGTxcnCk5CuOGPJPsp
         cjJWDPRGfr3F0kbHJozMLH1cVbAMX/OIyaGRy2zvfDj5OtNDzOwRginQtZHmB37fWmXh
         8/YqhNt1ajZGgeEStvRaQ4HU9wcKfwcnTOYaJnQ2iFEj0Q+FgKUXaBiMX57noag4APbp
         CaGatOs2Twh8kOx5Gyj0T4EAjHioF1tv3AnjQbR1Ig3lVYYIJIRSHgJbGGlqsaGOYe3f
         4YIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858747; x=1734463547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NtCkjYpTzUEcQtUOoTZj6Gta+taIvsFh5ZGDIhZ+nM=;
        b=Qf59cBizaXHiDRcr/4w/YDx/3eqEC1UBSp14dOM8zhWHjJXeeOP7NhY9Z4ppTuEOmW
         R9vGqifL0Dia/aPkhnF92GOFjg3GuMKhQZYxZhnN6MfqtNIlh0u0bzQ+25m1eDIUoK3r
         67YAlo/ik1Jd8+jYuBAwCtHXcgCCupUyyCSARVmfOP1Wsgtq4oBFu4Jr65srbmYohCt3
         v5UTFWyuoOm4RUE572PC6CC68OgtAE9auSb8amh6/+QCc2HxUXL3yl1YUmONpcoTR+K8
         2nhCfgJ/as1njHMX9P/9vhUArGErpJEjumgAYgJ+se9WZFBMQOciw76LfQ45Ru1UVKVj
         4jGw==
X-Forwarded-Encrypted: i=1; AJvYcCUGytryXU/uYFEC4Oe+xuA9ffFoAperLeGXr8Sggt3fSS+VxwnoMv6O0dj3v2mLBHKcQDLu6/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguWfXsz6X1B/I6BabsmyN2jgftE8iXdgLP6gSccw3nN2UcBIK
	fCG98A0cUJQfqKSgtYbuHPxcldHJxPcxU1zS5rad7dSo23pvxO4pe/rpmSNjZ1M=
X-Gm-Gg: ASbGncvMcd19DoBWSw5Lx7p06CBrlFqMdzCT6M9kq7FhVq+A49DC9GansR9MzGSGSp4
	Ry8Hx5aCXru5uvS9FsAZKbbaXof/vLa1prINUsV5VeP563S60lILOZkZLcD8PIn+7DQWsWvIpTO
	5WpyoHexS7c9rhjak71IGzNrAHojRxnBwzjwrRX5JFvbldNCgMyeS69w0etTziluttwj7VNnOrr
	vOTAtObNx3yTj9L3Jy2TZ5gfB0zkWWdC3ONy8HNNnwbsdSzovWy
X-Google-Smtp-Source: AGHT+IF/PTmpj9i0eiqNi7DD7EhCR9J4pLF5hz9u4sVHQ4rKtXJ+Bv6P1uvkZZ4zn3fhHcXYYjzUQQ==
X-Received: by 2002:a05:6214:2488:b0:6d8:ab7e:e552 with SMTP id 6a1803df08f44-6d934bc47d7mr3204126d6.39.1733858746985;
        Tue, 10 Dec 2024 11:25:46 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6c3591a10sm392911785a.129.2024.12.10.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:25:45 -0800 (PST)
Date: Tue, 10 Dec 2024 14:25:41 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] mm/page_alloc: don't call pfn_to_page() on possibly
 non-existent PFN in split_large_buddy()
Message-ID: <20241210192541.GB2508492@cmpxchg.org>
References: <20241210093437.174413-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093437.174413-1-david@redhat.com>

On Tue, Dec 10, 2024 at 10:34:37AM +0100, David Hildenbrand wrote:
> In split_large_buddy(), we might call pfn_to_page() on a PFN that might
> not exist. In corner cases, such as when freeing the highest pageblock in
> the last memory section, this could result with CONFIG_SPARSEMEM &&
> !CONFIG_SPARSEMEM_EXTREME in __pfn_to_section() returning NULL and
> and __section_mem_map_addr() dereferencing that NULL pointer.
> 
> Let's fix it, and avoid doing a pfn_to_page() call for the first
> iteration, where we already have the page.
> 
> So far this was found by code inspection, but let's just CC stable as
> the fix is easy.
> 
> Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic freelists")
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Closes: https://lkml.kernel.org/r/e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

