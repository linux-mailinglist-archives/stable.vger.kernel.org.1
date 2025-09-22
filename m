Return-Path: <stable+bounces-180898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE5B8F7B2
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 10:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2323A8B21
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D680F2FDC25;
	Mon, 22 Sep 2025 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZgUGbpG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99B248F69
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529449; cv=none; b=Eu01ytHtrQk1JmPTB5VBqeTjzjWQ1hXX6nXHiwF8mhigsZBJI7lgqhHoGy/S8jnsDUW7KKinjZTT8F0MVTq6TQ0ffioKTzmcnH3uA0Nxa/zHnMzQ5b9+me6d19seACtlvxwI4NIauhs+10kboEhqPdObNA+32gQ8489WBueWhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529449; c=relaxed/simple;
	bh=8TZnnyQakAEjErDizPjxo9AqfqKj7iYISZD5GSnJ2n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvtIEHz5Q49WJndcjy3l9AThupQN/GBEsCZxSbcWVujFr5S6GfumfUOJFJh8i6IBPBBYgM/4E3H9nFKVkYLyuKy13nxPauPMSMzycMvaP0nFs8O4qFzgPGQeLVeEl31Qr8nejv8qf8NNGAGUtcj4l+2HpkWWM0wP46x2pk59q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZgUGbpG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso2922946f8f.0
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758529446; x=1759134246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LDmzSNY//3bfqaJ6YjqbvFTHQWUglXrj6TuZ+YI6XM=;
        b=NZgUGbpGNf++mCXd9grp+FgzTlbZ00uOyrLsGgMlP1BA4UODsdpohIR9WCJD7jnkhg
         bRaCehajLyLzYmk+v5L/ltTAz9MeAfyujAbGnO7gLUhwhHdIC+YwyX5FJWn33WiA5WVA
         jCHznxisGsadwAvXFnM4LILtDWbXmQkung+TOk3xlwpxJh0IeFaTCap5jB3cQM9ege+s
         IwzgdUX7jSKaFEnmY+ITHFlmgOsDlnf3ONF3DxYxU9fr59xHwzvFjitXFOMKxePJkLr+
         P8UwfcdpPtNmbcvqAxUfPZRbLP9yflyFPAsk5ZVm8SrsJqstWTN2CmCoHyzywcG2BNeG
         DAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529446; x=1759134246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LDmzSNY//3bfqaJ6YjqbvFTHQWUglXrj6TuZ+YI6XM=;
        b=KDe3XQmvqUGcgLEMBMOA3bnQC8LkoxOOUCzVlA+1BgCh4w/a7EuuutGh0fhmJ9PVVA
         fO25voLppeGT3o9qqBnjvgYf4WK1zHBK914d0dNh1tjCTqnkZwNcquUf12VsyX6gLLjN
         wS3g0/MXCEp0VlFMjecR6ztS3UvrghWnH1XCg2axrKP9Jo2wYbGTc/F5IAGTOJKmzoWm
         9NKMfxiqpN8j/1W0eFcm9buykzrmEvedjEYuxA2oB2JlbBImDV8TEL1FeJQaM9C8e/ld
         WZVhvlb5sOQd1lrOeZo8/UGD/wSs9Dmbhv7UN91pfrQc+pe5/Gp6Yd6bJCAZQANGB7BV
         +WEA==
X-Forwarded-Encrypted: i=1; AJvYcCWLHXGLvG9N/H5j5BMyacqIuvBVAjlz/kon5erkf6F6j89uQhuyw739v6OnDU/yE4yygeNHsGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJ+1IqblO9WzKYwXi5LJBokDwj7vUi9gPN+NhRc4AF3WSxBDm
	HHLEhiSvNGUFbpmmX5Us52RK+setSGJOWOWonBiuTtaJDQhBxmzI5NVu
X-Gm-Gg: ASbGnctSiM6HhAd8Yb860nciWYaAv2O/vm84ygGEweGBGinBa70ePeAl0Mdh2nitcqE
	JWI0ZCzuaP1ODg+6bOnRiUVGVjuQ36W3jSVTW7u6MJZFGBwZ1fD7xGOjFDHM80z3w9xCf8awBdH
	dI2PBuxjP2CO12thSbsDD/X2S24rMTKIjJETTIuprIVZjSwK4FCSvyPLG+YJYaPY7wxabHLSzHf
	dLqc09sKKywix5qihS5h6CH36Jp2iKUCS0x2u6ZYozuBH4rxYkvBhYHeCroZR23xEcKeV2O24m+
	09wxoXBwoSbYFd/dVx0oRJXdDjXihGxmTsqawe1HwLuc7UOZAjYigF/ELUdQNhm7S3r7Q+VZkDX
	BHILE2ecgqBKVtRs6xhmKZ+aQwxLn/hkc+VY+5VcFdg==
X-Google-Smtp-Source: AGHT+IH5Ss/MexQLwWH32bSqKyK5FwYfHlZSIMK20q+jLV1U7CXiGcXfpzejzl0MccyrWKA2QZ6x2w==
X-Received: by 2002:a5d:524d:0:b0:3f2:97a6:db6b with SMTP id ffacd0b85a97d-3f297a70589mr6175117f8f.3.1758529445981;
        Mon, 22 Sep 2025 01:24:05 -0700 (PDT)
Received: from [172.20.10.9] ([148.252.145.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ef166e62e5sm13972312f8f.40.2025.09.22.01.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:24:05 -0700 (PDT)
Message-ID: <8884d7df-9709-4f5f-abfc-6b74aa220295@gmail.com>
Date: Mon, 22 Sep 2025 10:24:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
Content-Language: en-GB
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: yuzhao@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, voidice@gmail.com, Liam.Howlett@oracle.com,
 catalin.marinas@arm.com, cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
 kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
 roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
 dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, hughd@google.com, willy@infradead.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, qun-wei.lin@mediatek.com, Andrew.Yang@mediatek.com,
 casper.li@mediatek.com, chinwen.chang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mm@kvack.org, ioworker0@gmail.com,
 stable@vger.kernel.org
References: <20250922021458.68123-1-lance.yang@linux.dev>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250922021458.68123-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/09/2025 03:14, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When both THP and MTE are enabled, splitting a THP and replacing its
> zero-filled subpages with the shared zeropage can cause MTE tag mismatch
> faults in userspace.
> 
> Remapping zero-filled subpages to the shared zeropage is unsafe, as the
> zeropage has a fixed tag of zero, which may not match the tag expected by
> the userspace pointer.
> 
> KSM already avoids this problem by using memcmp_pages(), which on arm64
> intentionally reports MTE-tagged pages as non-identical to prevent unsafe
> merging.
> 
> As suggested by David[1], this patch adopts the same pattern, replacing the
> memchr_inv() byte-level check with a call to pages_identical(). This
> leverages existing architecture-specific logic to determine if a page is
> truly identical to the shared zeropage.
> 
> Having both the THP shrinker and KSM rely on pages_identical() makes the
> design more future-proof, IMO. Instead of handling quirks in generic code,
> we just let the architecture decide what makes two pages identical.
> 
> [1] https://lore.kernel.org/all/ca2106a3-4bb2-4457-81af-301fd99fbef4@redhat.com
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
> Closes: https://lore.kernel.org/all/a7944523fcc3634607691c35311a5d59d1a3f8d4.camel@mediatek.com
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> Tested on x86_64 and on QEMU for arm64 (with and without MTE support),
> and the fix works as expected.
> 
>  mm/huge_memory.c | 15 +++------------
>  mm/migrate.c     |  8 +-------
>  2 files changed, 4 insertions(+), 19 deletions(-)
> 

Thanks for the fix!

Acked-by: Usama Arif <usamaarif642@gmail.com>

