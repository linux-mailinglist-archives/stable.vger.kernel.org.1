Return-Path: <stable+bounces-192424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C826C32062
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F41DD4EEB78
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF8232AADA;
	Tue,  4 Nov 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG/yapY/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9BD32B9B7
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273272; cv=none; b=g+7q3QCuoi0HnQIYvmXcgh4Zoi5v4DxwPvkoxx5dLXZzrcdcm4BvtOQgnQ/z6LzBYVcRbhy75OAmcfcRMPdLNZ7IgoEbd1OnWLdk0gYtRBfBMMO1HQDGLMAVh3bpUK6UbX5azi3IEDoL/R6xg92Cx4mb9ElZftKmpLjMKJFfows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273272; c=relaxed/simple;
	bh=CQtHWO1T1LZaZkB4CcCLjZDictjbTTqJDQAVMpe48s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4oJvrn5T8FQ9J8BxtjYUZJkIkL/vcl59ow0NJgDSU/nPikBGrx57W8ItKJbePW4LSNQvqpRuhbKEicCOqr767KTMyk8EmlW19ucq1jmy0LsQnTV9baLsPelJLDI64c5sJCAMpK+I7EC4pigWQ6NzcJWaHw6rwHE4VK0E5wIgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG/yapY/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775895d69cso4172365e9.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762273268; x=1762878068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQtHWO1T1LZaZkB4CcCLjZDictjbTTqJDQAVMpe48s0=;
        b=mG/yapY/+LDww5emYkLIvTb3laZ6j9ZRN771x3i/qNRFgJgaVFFRm+i+LPMa09OBL4
         TGRqRKDr69wsbl6OILHlkOszmjrBr1WtKXMuulyo3datUPNZjlI6BV4rewQXwth2FRqU
         CCdjw2KnoY51XcBdBhS86ltid4Z11b48u1ja3Vcey5lfe75NYJJFcMzJPlzKgpwSW/w9
         jL6jdLmujLt556d89NJgta1Jr3JqVik+QD9WkyiP/Qe1dfdXdU/zvw9pqWEMn24mZtpv
         TZnwlFQVZsLFje99vsOLObYNujxUqUYo3JobCcI91r6mV0SaJMVR6VgcEMQMzQtOcCZl
         OXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273268; x=1762878068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQtHWO1T1LZaZkB4CcCLjZDictjbTTqJDQAVMpe48s0=;
        b=BGbctW2bbJktMM8IyxfCPML/PEq2sVqoY25n4mdujZGexqjyntibSayyutNhNztDTq
         ngQmCW6RoIdSmMqUchBYNw6/kQiikDLuCnFt1nXa9v4EfwXoMfPmzZDmCyBroabUTnl+
         0FM8mwq88c+HlTc3spNXnYsUbsCHVq3qZnXWuYeZ3AwAMi0EmipjJxHf+HGjTgV2WgWc
         AE+zTmzmWoKqkHQRCqMIBLOGtRyIhc/IlEaiRky/E/NjepuDbs0Z0R3LGr0ovr+1NeqX
         mBqtioswmLcrTHthAN6Y1RFGrQahoZCjQ1F6pEhRn+j3MT36shq39Bv9O3DZrXyPes+u
         N8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU8X8sUlbfmtXMmh2YUxnwUW8xSCJE/RTnMdN748xXa4PDYA7+YxU7S3lHmpncM4eYEP5B7joo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4C+XfmA31YVGfBBp0JhqDhpC8MLLYZ7XiRhAXnT7aF6GF9IRN
	Dt+WuuSKw0Wp66w+/a9gfaeeunRW2cdxi71NJ0Fczjsq8JOPV8MzGE1EWnDAiSgwh57j+fbTK46
	jVQehwXFrIzz0hTl19PSB0Hg3yspDpe0=
X-Gm-Gg: ASbGncskizjhyp1kLg5leA7wWqVG07b//y+/Qkd3hPRlmhf5fjEAh/LTAkBtgzkPDZi
	rg+58v5mrC8Mj7Er5Rt2sRU79MPr635KYndeHjAV1AvuKbBlq4P9ZNg6dsyAeVP7vTJm+f6IPvG
	GfKiKpIGkPH86sPe2pC6JopljPZv6/NPjF9UZaOD5Ms2YxNhascnd6U14ws3kBqbx2KXTNRzCJV
	R9t45CGFYd8keLNJNdAQUm4afU8G1Dnlx4Qp8uVz+gXR1vP+DzKnmeR1Q==
X-Google-Smtp-Source: AGHT+IGOvvt9b59SLVpbCsEQFt3dZXMd+Hg1SaHjukt1cqE5ShIxaX6RrkT8ZwcinfKPHIjF4o1jvMQQiUentZ5PUsQ=
X-Received: by 2002:a05:600c:4ed0:b0:471:1415:b545 with SMTP id
 5b1f17b1804b1-477307b8f57mr160302895e9.7.1762273268414; Tue, 04 Nov 2025
 08:21:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102082456.79807-1-youngjun.park@lge.com>
In-Reply-To: <20251102082456.79807-1-youngjun.park@lge.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 4 Nov 2025 08:20:55 -0800
X-Gm-Features: AWmQ_bmrV6AP0g2hXaOpOwjGzlcqcVGvqC6-WugJU_CSuWMfjkTAWh9WliBt2RE
Message-ID: <CAKEwX=Pe1NpQKneE0q62orCteu8=V7L9Xp8uDd5T6c-e2vpd6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: swap: remove duplicate nr_swap_pages decrement
 in get_swap_page_of_type()
To: Youngjun Park <youngjun.park@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 1:25=E2=80=AFAM Youngjun Park <youngjun.park@lge.com=
> wrote:
>
> After commit 4f78252da887, nr_swap_pages is decremented in
> swap_range_alloc(). Since cluster_alloc_swap_entry() calls
> swap_range_alloc() internally, the decrement in get_swap_page_of_type()
> causes double-decrementing.
>
> Remove the duplicate decrement.
>
> Fixes: 4f78252da887 ("mm: swap: move nr_swap_pages counter decrement from=
 folio_alloc_swap() to swap_range_alloc()")
> Cc: stable@vger.kernel.org # v6.17-rc1
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>

