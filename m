Return-Path: <stable+bounces-109167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C509A12C8E
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 21:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A351C188A4AA
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA031D9A5D;
	Wed, 15 Jan 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7XCO/lV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F61D95AA
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972892; cv=none; b=jLnFR4amNwOIYQoM1P5V8uDa1CLU/O4TVeXYzeNbrSBGo7oqIftsk3YCXCQhkffXopdyQI29JQp+kLJRatSUUgc/GLv6NZkzQvOpALsh1yuSpFORLuh9hWXue8r0jjnPfb6C67kx8rg0Zl7LbnF/sQ85iWhk7prQli6zAxD40Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972892; c=relaxed/simple;
	bh=j2tbwbmQn5ojyoQrRWYpmGHNivSH/dzW0guO2sBJeaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+LF0emuOw59t6Kfi+rvaNRcclUY1CfYSbQ2j7CAqzZD6hLxslrXgNHuizj3Kb2beJTVv+EkHfYYqsUqwZXYSpiarMinm6OI3E28Mhq5D0eFohCSYMcBS1QQ3qS/W9vDf/SPofWoeS1ZYdHLRKOUBWCMAOkmEWtPjPu9NWHWhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7XCO/lV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736972888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLWon5AXaxh3rMajeQBRrd7Zc/AYxckEZbRB/3d+iIc=;
	b=Y7XCO/lVA5sDg+UQnUCiRJo3/H7/u5Yzlaa1pCGyvI3LOM88sFjq4ZCTf8hw9vGEo0i93Q
	lRm0XnC93nYdYr4uF9/d4rJBrYhdkfIpfXjgZFEVAPaCkxd8RFxhITIUf92jdyckXuMEW0
	9wd2GKhV3L4Yeksk3BXZrhWh2MjT1Bw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-57KFLZ4TNByVRwPGxwFpXQ-1; Wed, 15 Jan 2025 15:28:04 -0500
X-MC-Unique: 57KFLZ4TNByVRwPGxwFpXQ-1
X-Mimecast-MFC-AGG-ID: 57KFLZ4TNByVRwPGxwFpXQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6dfa69e6983so3747656d6.1
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 12:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972884; x=1737577684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLWon5AXaxh3rMajeQBRrd7Zc/AYxckEZbRB/3d+iIc=;
        b=ql+bX1Jmu3ZYr7E+aydtLZLtaQ/qsDETqYOqd8FnMEu4RpI4f+7euyTnQFDK/Vc1iW
         Y6cAFra7qydekCKvXiNNf3f3d9twU6DuIDHHLk/3kwWlqCFIoLWhN5Tp3wIGYpWLy+4r
         IaXk+PyIxLjJumrCxwOtZP8L16Qt9NcxYGV505g2CgHTfzNvVJuDvj7Iv/uL+yLf4y10
         VG6B3XOzIafacs78b+NLGwmInU1shHpe6bgTQld9OEzRQ+Ma9PICO99FzDyS/nVvioOq
         DI9TjQ1091OE0DVgm5GN+bVXPFNazjz0UjFbkzSveYPHMhhNzSK88Z4qV6dbhP8BppvR
         f89A==
X-Forwarded-Encrypted: i=1; AJvYcCU94L3ZvzjufegBb5xh+v5K1XKT9M22qk7f+y2f+5xau3chPMaNIhJZlZXuW1d6vb++Pn6+1NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZr1oTz4YIDRppeSAvBgzj23NEMjDr5/loF7coDBx+JCBa72yY
	w2+m6pYl3cX/apZXGML58cVXV1MSQjhUU2qPtB0uLi08lBeCoaxa2V1cp81hqYL1MMkfo7h9RCv
	GoZ5cYJjR9qc/lKEk0upn25a+p97t6uRjseYsfsFX2Ha0qvNr3Fjasg==
X-Gm-Gg: ASbGncsRj/W1Oq/byNe9Em5VD1tX9zIE3Zbu7VZ7AlyK8ZuKVe6tFPngJlls/neR07e
	8melZKQs3uhIj9LIlQ9/WUOXqRufTSI8nN16GE1TICyQwI9yhqNET0U3wF72NR6IZ9hd0dTPky1
	5vWlRS4+7del3l1bUHVio+hV7DwEOaWw2jIBxZNg9K39XIjkqXk68E6feJnCHzFMWoc2PCir7lx
	IrEIwBvEV2CrQqX0UcK4aC3CzhZiNIJbEUCFjvMICRZWkKDqSlKBZQCadapxnsOA6AfLAw6jSwc
	fTiVEOlC7l6wLsMYqA==
X-Received: by 2002:ad4:576c:0:b0:6d8:8b9d:1500 with SMTP id 6a1803df08f44-6df9b2ddabfmr548161476d6.36.1736972883929;
        Wed, 15 Jan 2025 12:28:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkSIbuo3F6Xt9mSQetiuDbpnaGmRVyr2seY+8TScQrao1ZzQitek2oxSDQy2ErmvKglV0oCg==
X-Received: by 2002:ad4:576c:0:b0:6d8:8b9d:1500 with SMTP id 6a1803df08f44-6df9b2ddabfmr548161216d6.36.1736972883643;
        Wed, 15 Jan 2025 12:28:03 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad9adf79sm68242536d6.51.2025.01.15.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:28:02 -0800 (PST)
Date: Wed, 15 Jan 2025 15:28:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Message-ID: <Z4gaUAt9w8s1rLPK@x1n>
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107144755.1871363-2-ryan.roberts@arm.com>

On Tue, Jan 07, 2025 at 02:47:52PM +0000, Ryan Roberts wrote:
> When mremap()ing a memory region previously registered with userfaultfd
> as write-protected but without UFFD_FEATURE_EVENT_REMAP, an
> inconsistency in flag clearing leads to a mismatch between the vma flags
> (which have uffd-wp cleared) and the pte/pmd flags (which do not have
> uffd-wp cleared). This mismatch causes a subsequent mprotect(PROT_WRITE)
> to trigger a warning in page_table_check_pte_flags() due to setting the
> pte to writable while uffd-wp is still set.
> 
> Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
> such mremap() so that the values are consistent with the existing
> clearing of VM_UFFD_WP. Be careful to clear the logical flag regardless
> of its physical form; a PTE bit, a swap PTE bit, or a PTE marker. Cover
> PTE, huge PMD and hugetlb paths.
> 
> Co-developed-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/linux-mm/810b44a8-d2ae-4107-b665-5a42eae2d948@arm.com/
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org

Nothing I see wrong:

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial thing: some multiple-line comments is following the net/ coding
style rather than mm/, but well.. I don't think it's a huge deal.

https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting

Thanks again.

-- 
Peter Xu


