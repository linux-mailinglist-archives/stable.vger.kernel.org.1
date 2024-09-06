Return-Path: <stable+bounces-73692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94396E710
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 03:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FCE286EEB
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 01:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D014286;
	Fri,  6 Sep 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZu0u1pJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F43186A
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584517; cv=none; b=oRaIfMxwKOLUoV9HYVzf6cCyd7jh+FdI6Xffj8Vdm8dkz3TUBe1o0AxL7pZGMk9+pNDuFk8kZTZtVhZIMmk953/tjA0yFbzorVP1M/ZABsBEp+pQ1dlfhjOmGYTrFg6RnYe4f5h/yPr4L3x8+E3B1SJnxoxLo6mb5sV7iWEng5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584517; c=relaxed/simple;
	bh=UwRlrUHpdjEnWaOSXEbV/JptmuI+VM5iPjRYoBnr4SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1AXqsZRHw/QRKJhZOHe70EqtIBQ3iUJENY73I2ev/HNzWop1FnVQBca/mdeqOcvrz1c9erFApCchNSrbZWiu8PV+5XLaQTLCjQO22XG1aI4VJKkt9S2lamHfdzJM2Zv8AitMcRZBwCzkPr5KaICDMluO3uekTJ10LZ4VqCETHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZu0u1pJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725584514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlPGS1sqdlq54vfzS+MIwPHUFlRFFlVkoRPHvKLRxbs=;
	b=BZu0u1pJI/EKf8DE4fdtzt/DTPB15GR0tHLsWW5zILfKcHpzKGvL3Jwj4OXfa3HcZp8oTG
	/w4YyhY7DbjWVEh99irTmsVA3wsAsSFOXwTjbj99p9S02sJCcx+XzSVm7TLXZM7fiPDb1Q
	QaGKixRU62Ns77F9CZXi3TMzWW9RI8s=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-R7cl3s8RODaaZZIC9kLOdw-1; Thu, 05 Sep 2024 21:01:52 -0400
X-MC-Unique: R7cl3s8RODaaZZIC9kLOdw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-70f76425958so2253676a34.0
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 18:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725584512; x=1726189312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlPGS1sqdlq54vfzS+MIwPHUFlRFFlVkoRPHvKLRxbs=;
        b=qXA7FklcOOp3nr5hf0E2YfVKMwqY2bxpPHJhM+7tD0VY1+ELq/0hl5Ei86Lauvd14M
         w2XqykHIQR6XAtMeSK3uzEbjDEwSQX4Hx6hGUphDq8bKrWCc4JyixvZ9i72fmbtZiNaN
         zSvgZ++AqzgV2zx0b6tZ5vfN8moT1TdMAf/XTSP/BTfy8AyRAvEwBqZqVLvNX5mjaYWs
         XL23VMhJo+4Xc3uLFuq01BZggQWNO+5w4oaXKxa4NeNQ1gEeF2Fo+DVye76ZY2daaWAt
         qRtMkAa9U4j/kajsBfusv8b/R2FOKbUoHqbdagDz8cKnxBQNbTXAZiRbWkLCjYcfaIko
         E6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6GNDRJu1cIQsBN4W3LnqzJKK7z0xngACBodBMXw7rpRihP6k+zmyulRmgj88MMeQERiLUEDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJkDb2ooSjJ2HGy/jw3fAzdOLIi6ENSCZPXX8rIT/fwk5LIy3
	7bI05gfsVipHu8yu3Zft+qe6Fz5T6rb9UJq51lqhHYEG9l9GD8MX1w11VKAYgsXB+7n9yhYgzOJ
	FwkXAuvigjI8SX0LnKWKD1iX2+ItLoh8RGuhQCGlfXczX8ZbdHd92wA==
X-Received: by 2002:a05:6359:4ca2:b0:1b3:9413:fa6f with SMTP id e5c5f4694b2df-1b83859d0f3mr129981255d.3.1725584511946;
        Thu, 05 Sep 2024 18:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuJ1X1hccViLHgON/IOx1N5KG1rIdnNOKi5STkspuBw4Ij2Ig/0vCgO6yL/sDB4dZjoU8Wqw==
X-Received: by 2002:a05:6359:4ca2:b0:1b3:9413:fa6f with SMTP id e5c5f4694b2df-1b83859d0f3mr129977655d.3.1725584511443;
        Thu, 05 Sep 2024 18:01:51 -0700 (PDT)
Received: from [10.72.116.51] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785307cesm3798314b3a.55.2024.09.05.18.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 18:01:51 -0700 (PDT)
Message-ID: <0e60c3b8-f9af-489a-ba6f-968cb12b55dd@redhat.com>
Date: Fri, 6 Sep 2024 09:01:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION]: cephfs: file corruption when reading content via
 in-kernel ceph client
To: Christian Ebner <c.ebner@proxmox.com>, David Howells
 <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>
Cc: regressions@lists.linux.dev, ceph-devel@vger.kernel.org,
 stable@vger.kernel.org
References: <85bef384-4aef-4294-b604-83508e2fc350@proxmox.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <85bef384-4aef-4294-b604-83508e2fc350@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

Thanks for reporting this.

Let me have a look and how to fix this.

- Xiubo

On 9/4/24 23:49, Christian Ebner wrote:
> Hi,
>
> some of our customers (Proxmox VE) are seeing issues with file 
> corruptions when accessing contents located on CephFS via the 
> in-kernel Ceph client [0,1], we managed to reproduce this regression 
> on kernels up to the latest 6.11-rc6.
> Accessing the same content on the CephFS using the FUSE client or the 
> in-kernel ceph client with older kernels (Ubuntu kernel on v6.5) does 
> not show file corruptions.
> Unfortunately the corruption is hard to reproduce, seemingly only a 
> small subset of files is affected. However, once a file is affected, 
> the issue is persistent and can easily be reproduced.
>
> Bisection with the reproducer points to this commit:
>
> "92b6cc5d: netfs: Add iov_iters to (sub)requests to describe various 
> buffers"
>
> Description of the issue:
>
> A file was copied from local filesystem to cephfs via:
> ```
> cp /tmp/proxmox-backup-server_3.2-1.iso 
> /mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso
> ```
> * sha256sum on local 
> filesystem:`1d19698e8f7e769cf0a0dcc7ba0018ef5416c5ec495d5e61313f9c84a4237607 
> /tmp/proxmox-backup-server_3.2-1.iso`
> * sha256sum on cephfs with kernel up to above commit: 
> `1d19698e8f7e769cf0a0dcc7ba0018ef5416c5ec495d5e61313f9c84a4237607 
> /mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso`
> * sha256sum on cephfs with kernel after above commit: 
> `89ad3620bf7b1e0913b534516cfbe48580efbaec944b79951e2c14e5e551f736 
> /mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso`
> * removing and/or recopying the file does not change the issue, the 
> corrupt checksum remains the same.
> * accessing the same file from different clients results in the same 
> output: the one with above patch applied do show the incorrect 
> checksum, ones without the patch show the correct checksum.
> * the issue persists even across reboot of the ceph cluster and/or 
> clients.
> * the file is indeed corrupt after reading, as verified by a `cmp -b`. 
> Interestingly, the first 4M contain the correct data, the following 4M 
> are read as all zeros, which differs from the original data.
> * the issue is related to the readahead size: mounting the cephfs with 
> a `rasize=0` makes the issue disappear, same is true for sizes up to 
> 128k (please note that the ranges as initially reported on the mailing 
> list [3] are not correct for rasize [0..128k] the file is not corrupted).
>
> In the bugtracker issue [4] I attached a  ftrace with "*ceph*" as 
> filter while performing a read on the latest kernel 6.11-rc6 while 
> performing
> ```
> dd if=/mnt/pve/cephfs/proxmox-backup-server_3.2-1.iso of=/tmp/test.out 
> bs=8M count=1
> ```
> the relevant part shown by task `dd-26192`.
>
> Please let me know if I can provide further information or debug 
> outputs in order to narrow down the issue.
>
> [0] https://forum.proxmox.com/threads/78340/post-676129
> [1] https://forum.proxmox.com/threads/149249/
> [2] https://forum.proxmox.com/threads/151291/
> [3] 
> https://lore.kernel.org/lkml/db686d0c-2f27-47c8-8c14-26969433b13b@proxmox.com/
> [4] https://bugzilla.kernel.org/show_bug.cgi?id=219237
>
> #regzbot introduced: 92b6cc5d
>
> Regards,
> Christian Ebner
>


