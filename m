Return-Path: <stable+bounces-147982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D2AAC6DB4
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6304417EA38
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3B128C86C;
	Wed, 28 May 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYUs5Bhd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFD28D843
	for <stable@vger.kernel.org>; Wed, 28 May 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449000; cv=none; b=hmlC8tTzYEenILsVfjXjELGUl0r6H+FE+WKJ09C2wS7VWEOINvjYrnVIpuaqSr3b/eiXq6f4NF5D6vn5k1HIzQcUvSRrksphyDwYbuFSyBId0aiO8e8emUwFBdLFg9I4uIT9gn+gTZYZrrZWRTN/qznMojLSIa7h+igL/ZDWgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449000; c=relaxed/simple;
	bh=Z/yuNRvutEMonw93F9Xzr0/LAs06gPGkEly7k12Zexs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN4OwLhakSwDFVigVw/uwKH+O9rZQXEhQMpAZ9nwBRr+6Lt9Xzes4yu6hso8Gus/stJSjku10996G92t/qJ++1rmcXwTmGFSX37Ie63yCpx3GcZZ5OYQSMtkxPlFQbX0W+rAXw0MiaPdKrP8j0TUHneIBvgyrCY9hjee3Nqq9ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYUs5Bhd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748448997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2k2PY9MAHKt+UL2NC1MP+obMfgPvXhyJk5Kn5YL16Pc=;
	b=LYUs5Bhd5uttkVpJLARuTyBTBhWl81escZMchCXLn4+BKxMTzq1ofQU+frNPVRTPKA+Cxi
	XcDO95gGfJuW5c8mrQSgt8WgUv4hNPEQ5yxXkue7RyPMWqL0uuCzxrdwBLhBEQ734AGjym
	eppktTyMfrEivxuSY+dI8rA/OrdGRH8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-NvUVXB3lO5CDZs9Xmm7R9w-1; Wed, 28 May 2025 12:16:35 -0400
X-MC-Unique: NvUVXB3lO5CDZs9Xmm7R9w-1
X-Mimecast-MFC-AGG-ID: NvUVXB3lO5CDZs9Xmm7R9w_1748448995
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f8d0bdd023so853926d6.1
        for <stable@vger.kernel.org>; Wed, 28 May 2025 09:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748448995; x=1749053795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k2PY9MAHKt+UL2NC1MP+obMfgPvXhyJk5Kn5YL16Pc=;
        b=FQEr2dOM7tCIBi6VXoVNjxNCUZJsLxVJvxaDQlcQ+xJUtG6es+9vYAgaKpmz1cAvtD
         4BiiPSlpYEIHD9ZvJDUL6/3g8k4+Fnx4ro++BCWfaDCZeI7nASR2rTz4fhEkh0M2pZQ+
         tkWliMIc//Ef7Rpwa0kBtD9b8+HNm0rpyYYZ2dTDu6Bc+7MTu3fR6HXUg0D32Sqifv3l
         MWD/fFtyIklHm9UdorpPaaeVNcWryM7Snryk1FTCc5paLVTv5mJ3paN1FLjZTsMoWGNT
         ZuPa9fc3IHxiYWMgvXGGKwnkur5XlXLB/vx1lyn7bgLAnvPGsc5Qrk1bK7wFdJfIckn8
         Am4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe0e6/dtCoUmetiR49urQcuiCAms8viWFDnItN17xgHVkZPI48hV2ZUc03Tz+TqURWk9sSHyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySfzPqVlSoCE4dkzDG3STHzj6rqb9sTDC4K4pLQicDV8kMjCBB
	ckcwzC6wL97TuTLCKBfy8V8KRIUeYwLghKM5Tdl29jpvtMfSDBSksjx+ncHRsl35hHzFDnIxVcL
	5xvq1Axz6xs53b4YI/IKdf9CaAL+/FCL003JizDCgqsZR+fCpZoNPufu4wg==
X-Gm-Gg: ASbGncuRCk6G43ysy5JU0FuqNodWf6zItu7hYqNuIbF3H145JDqcJGrU2Iq1s3mDsgg
	1SEKb3qfy0mDSzgLwAj5FyUN1oUxcwST8q0/B2UswOc+e1nkKg53GIsFsHGCKlygO8yCi0dphma
	M3/pJF/vBtFyMZG76THmFcX69Fagh4rOp2bBrrw+cmyYo/sLKDqmX+uq7istKhDRxVlIXGyZpHq
	FMdjs93hHZ9XRcLQEk/6k9KmwtlrRvJCxXdC5t+RwDDQnMzm0Uowqf/ITRaDis34p1fy7zwrrAM
	0xM=
X-Received: by 2002:a05:6214:224a:b0:6fa:bb44:fde5 with SMTP id 6a1803df08f44-6fabb4512fcmr72527236d6.17.1748448995307;
        Wed, 28 May 2025 09:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENfqhaMY+uKyU1t2Uqx80D80R06TLTQ2+Ckhg9TBWJtJ9d2fj3zGpcfKCZJVlZCQeNfczAMw==
X-Received: by 2002:a05:6214:224a:b0:6fa:bb44:fde5 with SMTP id 6a1803df08f44-6fabb4512fcmr72526776d6.17.1748448994766;
        Wed, 28 May 2025 09:16:34 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0bca20asm7994226d6.110.2025.05.28.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 09:16:34 -0700 (PDT)
Date: Wed, 28 May 2025 12:16:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>, Gavin Guo <gavinguo@igalia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	mike.kravetz@oracle.com, kernel-dev@igalia.com,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aDc23-d2fsQbdIKe@x1.local>
References: <20250528023326.3499204-1-gavinguo@igalia.com>
 <aDbXEnqnpDnAx4Mw@localhost.localdomain>
 <aDcl2YM5wX-MwzbM@x1.local>
 <629bb87e-c493-4069-866c-20e02c14ddcc@redhat.com>
 <aDcvplLNH0nGsLD1@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDcvplLNH0nGsLD1@localhost.localdomain>

On Wed, May 28, 2025 at 05:45:42PM +0200, Oscar Salvador wrote:
> I thought the main reason was because PageLock protects us against writes,
> so when copying (in case of copying the underlying file), we want the
> file to be stable throughout the copy?

The folio can already been mapped writable in other VM_SHARED vmas.. which
means the userspace is free to write whatever while kernel copying, right?

IIUC there's no way to make sure the folio content is stable as long as it
can be mapped, CoW should just happen and the result of the copied page is
unpredictable if there're concurrent writes.

IMHO it's the userspace's job if it wants to make sure the folio (when
triggering CoW) copies a stable piece of content.

That's also why I was thinking maybe we don't need the folio lock at all.
We still will need a refcount though for the pagecache to make sure it
wont' get freed concurrently.

Thanks,

-- 
Peter Xu


