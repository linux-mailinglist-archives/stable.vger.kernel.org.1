Return-Path: <stable+bounces-152418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E301AD5624
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2DE7A6645
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608728466D;
	Wed, 11 Jun 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3SNeEW8J"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD428314B
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646620; cv=none; b=qaV4hT7qlQGYPtdYUOZt2rsDRp8BqDDrZnrDeFuGex7geSSUMxj8crBoYL5tRAfQ7dOwG2N4afylQp29Mcq7+NeYtlXtbcju52hscVFDlAtseArxzlrk/Zb1xx2JiYzvf/L00w60tx+4uLrlLYwm4Zn0Lxz/3e2nEiuXkFhaOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646620; c=relaxed/simple;
	bh=WFBUbKMMnKHZdjkqyPfepwRYRaY3PMbvKPZrZUg2BWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VE8LcOzFaaQISFiK0iM7IloNM4ncV2WY78cQd9kmWJQxjQayE/RkZHUceZi22XN+Mrow0VnICZUcd8iUiIN4p1eRiNpIb1hIVHosfSEgwHZSEW3VDOoaLtOjZuU4g1cSnq0JCMBv2ytS/N0uRnyvB8kbg9HYQp4WujnzEOAHi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3SNeEW8J; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-873573bfe49so300521639f.2
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749646617; x=1750251417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=3SNeEW8JE6h/oz8q6m6QF2ImTL+tlmycebGzUU801zIFrCEDkbol5VveffiMdaCcVr
         DR4DtdLs0b+1vL/7V92uya5ywuKnyqGYVSg0ovhGxi0LJoY7dxjooMAxjnoIBEzQXMr+
         qMeCgAww9N0HEgBHk0ug5O3IF+BFEyTe1ylZYv+Y826rZiB61Q2HaxeJnbGKLVKmd7gE
         Aeg10w+4veLhgu4Nb+O8L6MkAU1TZQkC7AhlyIGuZtpexzE1kEY4l5aPG9Hz/W2teHnY
         49kehI159q8ArkYpHFN9doyq3ao1juv/h8HlhUTH3p4/xVB/T2oRSBlwS1sUivjQy8Bs
         7uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646617; x=1750251417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPGWj6XVqoqMlOowKe5NeP45YX5gIMyOrC/TyjewJiI=;
        b=pBH/2Ttit2w9cOIX8llXwRtFoABU7PCseCMEM46IY99ZW3mFHsnpUfBQUegNRa/A0k
         4s91GhzhoIsccz4zxg+wPW/3mVdD5JNMsFNX1n6ya7U2LcILyWSOBM6bZNplqipkDt96
         7ieY8kPre6QlN3VjGVOIIL3qOBoahk26EueH1wyMZGsc6ElOhprbo6c3m67z61bn/AUc
         EaEMLGjAPLxN1EQ2+PUGIwYwWjnfawX8tBzOi5cbyJDaIdOIztyKJDIUpfAeQ2gZ908I
         oYX8+hHy9sswmIAGIhuh9sur51J4z7Y3WDo1DQpdnntYKlL6MKF8IrFKAoalgAjODnK4
         34YA==
X-Gm-Message-State: AOJu0Yy0XjBkJ80wMcdhj16RbcMJnNxovuRtpQk3I5vdVbFst/TK9FhF
	4mUliFukM1n/nPiGmgNV7ob1Jlx4b0t8MPJ5u5HKcIqJbt8m7KzXSVbSoaGZizQuDJA=
X-Gm-Gg: ASbGncvMTskoEx0E2fLQX0A8z6OKXZAegSCWVodsJyaOxZEWI34ULGEAhMl7QQd5YS4
	DhJNf5Zyu80+mnX9qNXDg1E7rlMSJWb7Eu/JeTIDnf6f5zbAbLm44qjJAhUkz65SUH2jk1qayVK
	+qUVaPcS+nDlt0qibVpimk4rm5I55v3tLT7guebEQnGYQf7rX3f5WbbiW2Ak54dyAgGgcLXbeA+
	LtvOVNMdEZKjgkFkbTi6MqCG3/gRsOW0dWdOuHrdjfC0F4qCoMwaUjE0HUjGb+aKcQZi7eSo5Xt
	NTDrbERMeJUwg632iCbYphsL9uf945hpnrkl77Fdw5YqypLghVQAWx4Cgxhsu2pWF3FL3g==
X-Google-Smtp-Source: AGHT+IERz9UEhN3gPoO6s9ZO+TGganlwoJirBS1zd34gle1XGHdmdK7NOLrIX/f0q//+H5iwkCSLYQ==
X-Received: by 2002:a05:6e02:12e8:b0:3d9:668c:a702 with SMTP id e9e14a558f8ab-3ddf4d5d68emr25015895ab.9.1749646617386;
        Wed, 11 Jun 2025 05:56:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddf4768c0dsm3851505ab.55.2025.06.11.05.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:56:56 -0700 (PDT)
Message-ID: <ed33ffb7-31bf-490c-b1ae-304a6e4b9a0f@kernel.dk>
Date: Wed, 11 Jun 2025 06:56:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 6:14 AM, Hazem Mohamed Abuelfotoh wrote:
> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
> 
> Commit <e70c301faece> ("block: don't reorder requests in
> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
> list, this had significant impact on bio merging with requests exist on
> the plug list. This impact has been reported in [1] and could easily be
> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
> having any filesystem on the disk.

Rather than revert this commit, why not just attempt a tail merge?
Something ala this, totally untested.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3af1d284add5..708ded67d52a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -998,6 +998,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	if (!plug || rq_list_empty(&plug->mq_list))
 		return false;
 
+	rq = plug->mq_list.tail;
+	if (rq->q == q)
+		return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK;
+
 	rq_list_for_each(&plug->mq_list, rq) {
 		if (rq->q == q) {
 			if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==

-- 
Jens Axboe

