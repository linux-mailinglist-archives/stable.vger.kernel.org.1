Return-Path: <stable+bounces-100636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F09ECFC8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E5F16A5E4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914131D61A1;
	Wed, 11 Dec 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="kSXdqclo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF51C1F27
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931143; cv=none; b=bzjvRvlBXFXuGrL3BhSwcP7VRm9bcGl6iy3+zjjeNDOcOWDWyxF0fG3rTaUGJw6czVN85GUSwQK5sVNIIh8Rw5UuvY6zP3zL/8Q3prA3mnI+BVWDRqczrOVhg9WXjZ7zxYv2gZu3/O9liu0zTBOvt/5hqCp17qw9eYNUDZ7A4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931143; c=relaxed/simple;
	bh=xJJAdLG2MnL2RoVNzzNJI1Bb5jWfSVXky7a4pA4KYCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0G5srB3enb9NjrWhsita/wXYyj1ryffejPH/VY7OsPTpq0t2StYYJNSFcAdbe7R3VfbGXPTd+drxoiQUrFGdZYtpx5p2i8qWYwEje/D6Csgm6xYXK1X2MvD77i/So1GvcmrNttAxCInUpAnkB2nmx5eXgudXQ85JIYhEOZwVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=kSXdqclo; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6e4d38185so137954585a.0
        for <stable@vger.kernel.org>; Wed, 11 Dec 2024 07:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1733931139; x=1734535939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Awqg9NyNSHCYANmgf+Mn+5u0b6mI5gQklzYKZzm0vmc=;
        b=kSXdqcloGV5sVFDTGyEgz/qvzMXIb3o4S2fOGMxyA9rTtPB7ItxoQsRH3wQe8nfbaJ
         qYx/5F+GzIFBtZCR1yp9BJako/ADiFifAZjo0R6T3WTH70dNxxL4P6D2bu6jFQugy07U
         H8eGA1AoN9CsZ/aAE3qG/FSba0ssJBRrqqp9hUb+nZlXfm2hSeY2waz7HkoYkv7POyg+
         CvtVOt3JMHdOxiiErft2Y5WMClfHvrHEtANzZb/DYvQ76EiOpmUkcDgADVvmyg0fB75O
         m2lDM7ketWKRVqBqRF9hiLHyIiJY0lSTqtqiJbaY5gSmE/QmCYS2P84OM9BBICbhx/Qt
         O42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931139; x=1734535939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awqg9NyNSHCYANmgf+Mn+5u0b6mI5gQklzYKZzm0vmc=;
        b=hOORVt3yPUZkx2t1QU/Jegxtdf9Cj1WuXUiCPJH1mWtS4HBT2RP8kT/ksukyEO4k0F
         xfb9BYghj9/eh33qHyU2qph85emZTz5vzg0jQ83cMFbaO0fQsNl7ruvfJodpOWEUGSqY
         F2impT3wesbvihzNUOYbKFjrZN3tRBw1a7meRDNIMKKUEarxwx/J3IpR5Pt53UcSRYJw
         9myqgL9iMwgnPEYd9HKkeIzd9TAYPXiumu72MNstjJZjdsSX5GJztARZ9l/x5FN9ze0Y
         ofH25YloiFmM/bhtizQHOE/YME6KyPUOYRp1ZlxqsWmkUov7LTDpiA7CBhgt1NK+El2c
         EJIw==
X-Forwarded-Encrypted: i=1; AJvYcCVhBWRwCIc1f++oG/U5lE0NAK2Q/U2UkApi2cnb2cAgnEg3eVXygH1qIKnC6PCiiA4RXjE7rGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJDaPiVv0E56cThywXgvH6NbSeYC11LP6iPxrwSdVIX3ynWCy
	B2Sc2p2YsI95rSMX0DXagMtNsVkYqNcMYBJXsYleKIkwD/jTgc/Ct53eS1eQojo=
X-Gm-Gg: ASbGnctuqycfRlZqccoX8RYg63z0/VsPDIDVcJZXYssx/8BdBXi2Fpc8n4Lzwr2WEKc
	50wFqLNJIZiYFtZnkQM4O+ktuZjfg9XnN+Hhu4iz87AzN1WXouXPZvy9D2s4kjMS31JQxCfU0Zm
	GoW1LVsTN5CjOEqLn2tWkaAbAQjjSzKzttELZJNNxLRpcdKLPEIgEa6zu0WV4aKgjSvJyqf4g4o
	oOJMyIW21sHLIOcakEeZz++Osxhw5yiLd3YREaAscnS/ZFojAXx
X-Google-Smtp-Source: AGHT+IFOj5lGUuf6afp3JD+tDypMseeTH5+Ku4Z+VnrYYRy/zTpgcZlsC0+8gorvfeDMXfHHS/mZ0g==
X-Received: by 2002:a05:620a:4050:b0:7b6:6d5a:d51b with SMTP id af79cd13be357-7b6eb53b012mr449355685a.52.1733931138674;
        Wed, 11 Dec 2024 07:32:18 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d020783esm360340185a.96.2024.12.11.07.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:32:17 -0800 (PST)
Date: Wed, 11 Dec 2024 10:32:12 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] vmalloc: Fix accounting of VmallocUsed with i915
Message-ID: <20241211153212.GA3136251@cmpxchg.org>
References: <20241211043252.3295947-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211043252.3295947-1-willy@infradead.org>

On Wed, Dec 11, 2024 at 04:32:49AM +0000, Matthew Wilcox (Oracle) wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages in vfree() without ever
> incrementing it.  Check the flag before decrementing the counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

