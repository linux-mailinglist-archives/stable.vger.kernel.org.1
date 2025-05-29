Return-Path: <stable+bounces-148083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7679AAC7BE5
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 12:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465DB4A7378
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 10:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11F28DB5B;
	Thu, 29 May 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fY7021ds"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C604288C8D
	for <stable@vger.kernel.org>; Thu, 29 May 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515440; cv=none; b=X/25TobDkTOITGlRTB9YENvH3HcC+MFUli2N6iDTtjN1Aqmug3J278J2yr2rVexybL3mR403P4hIGXemzfCGal7SEO+iwl+lbbvqPr2oEJTTgG+bGTUnkMyo5VHpHZVi8Z3xizHQ/fLpErNFI0Kr4trskFu1FkXbzWXnSqxiTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515440; c=relaxed/simple;
	bh=d70cOs+yRjLV9v1g4IMElU9hP9dP3kaHVrgHH82h00Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfkAPqD92tFdqdb5N44tWMtHEdfmpB7GeLLzLcEnBbpeHKvVQV/k5L0mBLunwF29TyPN5/jo7fD2bk+sMzz8vfDcotbx2gEQTL3O8mFs7q9nUmHv/rW+mJqazBv4YtUX714qRcZzANGnqjwna0CXEEkdMDLlmoldeZIQGPRMUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fY7021ds; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dd781c24adso2784675ab.2
        for <stable@vger.kernel.org>; Thu, 29 May 2025 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748515436; x=1749120236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBKHhBlBfRf8OS9bGTTn4Xut5Q4UhzCrCrJUCDJ3k2w=;
        b=fY7021dsgTqxeleVgj7g2RpOf1gM8Tqdl9b6YDc7pJaju4nCxudcuB1D0Kel+EqOlS
         34GxCvoywEJshq57MHAGu3/4yg1BPuJiRixwwYk6FFluDLFJ6VvqdvdYcmF+5ty/a1C1
         5J2JeGHzEvekuovBN1lHA8UxFiHk/nG2/GdNQSbKDIE3tOZ6wnXsMfh0SgEHAuN4yzVH
         7suGD0fvnhcFpHX+/z6v+Cc0zJNZyHGCaNqPPGJvIuu65ONo6Gzr3nbN0HV5s5kAbFOf
         3CfHXdsZGhF2h4GJAGspiL+KKDgQmTy7l31D+0EOnFTQ1OosIGJnKmTKQllZIvb1sivI
         U+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748515436; x=1749120236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBKHhBlBfRf8OS9bGTTn4Xut5Q4UhzCrCrJUCDJ3k2w=;
        b=JlR/8yNM5Hpm3eFprwCbW4BYGVlFK9RqpjLd5iAL39j2zc6fj/XJ88gkjql2ciLR0N
         o3X5BgrtIkEpJG6T4TxeNRzOlyiKOUHL9BfF0Khgk4qgP9w7/wQD6fFq9yhzNqNKAwPn
         Ack1Doz7oWV5ilzptPmhnGoL36H82mClttuQ7EkOwvTqekdXJofEy5OfI+ZfcyApbgXC
         5a/JL4Zwtxq1+jfUUTo9OolEOtgCrNU1r7n3v2gTF8F5Om6FjxW2mixQIXqPIFGsqr0p
         1vOvxSNB5gq3JYkeZONdEdcWJNv+yWUAWGPigMTqInQ8FNuRmXk4YfpgeT3xWuhbLGrQ
         t0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCX72ww8twWleeqYlqo+fQDHq1YjMG2MgkFWCUU2miAJvlgoJulfgKeiqp5I6bsedNMBtZ96Ufs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwOneJZdsVPoAJH9iG3qoB/Cx93TyuU0FEEbta88NknKWRoy9
	kSx5pNIA1SAIZ0k7V7EwFsadCaxJNy/KFg4KKFnRqkbCLf0dFv4n8Tm8+/qUh8YO6U8=
X-Gm-Gg: ASbGncvO0XQ+cr0m40GocAbSeJJ4GUwkTVXX1r26irvc5/uVoYif7Pfpsqk7nv578XX
	ttHaWlHW0qdS9U1G5zpm0JIO1liBTep0GQ/o+EV5gKz1UuVLjQG9BgElKyNXHdEBjD7EgFC9+sv
	UNRnO1Y1FBe0jS80oY918bRB2ycMI3NsmLFr4knxjs4/ucD8tlgBbCe6ZTbByq91gwAWwhB/RBC
	zeye9bucb9n0UI1jYg2XY+2EIBhal5cll80wj7FwZlG+k8TJ8M2C97b9R9Y732WvC91eg/xj3+j
	G1EUXX1uF45yzLmG9LCSxbh2G1VjDTBuxYhp+l+F3ti8quwppcLf6g2sHOE=
X-Google-Smtp-Source: AGHT+IHGVGn+63JWl0t2CYty2GIDIfHTGjGGUyr3yYuuyCx1E71eWmROwfUZXoYGh7QKeqcJ+9RtFw==
X-Received: by 2002:a05:6e02:2289:b0:3dc:8a5f:7cc1 with SMTP id e9e14a558f8ab-3dd943d0d04mr17643405ab.3.1748515436218;
        Thu, 29 May 2025 03:43:56 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdbd4bb1e4sm608197173.43.2025.05.29.03.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 03:43:55 -0700 (PDT)
Message-ID: <cd3307c0-4af5-4477-9258-2eec57c7003d@kernel.dk>
Date: Thu, 29 May 2025 04:43:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hongyu Ning <hongyu.ning@linux.intel.com>,
 stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/25 4:38 AM, Kirill A. Shutemov wrote:
> Hongyu noticed that the nr_unaccepted counter kept growing even in the
> absence of unaccepted memory on the machine.
> 
> This happens due to a commit that removed NR_BOUNCE: it removed the
> counter from the enum zone_stat_item, but left it in the vmstat_text
> array.
> 
> As a result, all counters below nr_bounce in /proc/vmstat are
> shifted by one line, causing the numa_hit counter to be labeled as
> nr_unaccepted.
> 
> To fix this issue, remove nr_bounce from the vmstat_text array.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

> Cc: stable@vger.kernel.org

No need for a stable tag, the patch went into the 6.16 merge window.

-- 
Jens Axboe


