Return-Path: <stable+bounces-114372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AFDA2D4D6
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 09:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD51716B04D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7941AA791;
	Sat,  8 Feb 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="T9S2VnTZ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A028F3;
	Sat,  8 Feb 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739002852; cv=none; b=CRkDzm70l3SR8WsGEaFcBBWdtvO3VBm/8f6dr2MjCRr09tiJ9/sZBRkVzIXHrvD2NycN09FUIqkPflMxzMJveBUqOW6PFKuUVTAmACrCVbtdyNm1ali8WZNnVQ+ubt9KaijgwkQiMD6vZEfvvGgluMMOl0uhUL2N8eB3iSgPaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739002852; c=relaxed/simple;
	bh=Q5tFmK9Dx/jYFT5jjn7eRKWJ/m+/EqD028c0bB+1lc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbF9/OCWWU2JHO9s6fNY5V/tFPq/7SynMuIofZqAvbi1IxflxcwcsBvAoioli3iYGE+n8q07cpUw4vTy1loluRglTuU06L+17/TxbCeDI5E84otm74lQS8C0izPGYkBYwcVjpoZeF86SL7B1hrskalBgCS1w3710FK28gyhOTmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=T9S2VnTZ; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=O/6oF6QZtuE1SEVVzE9A/EGVwIjr3rT++GFL4llueWU=;
	b=T9S2VnTZknIrKIaxPKXR60KgUqlSz7dfFg5riq0RflWbjf9UVBNv7GZgTdNPXf
	ONfYqhS1YC9s4QQFpuyufPGs3JFtbylMW1rBkve/H/cAOBhB4cuB8j3ixjXPYKDR
	Ykm/0PBtQCOfzB7bzVDfyAj2luRlnuq7ia8m3B+zIhVSA=
Received: from [172.19.20.199] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDXT2mME6dnD4_UAg--.46618S2;
	Sat, 08 Feb 2025 16:19:25 +0800 (CST)
Message-ID: <44348250-64f2-4420-a786-d42c3ad923b0@126.com>
Date: Sat, 8 Feb 2025 16:19:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: add an API to enable/disable concurrent memory
 allocation for the CMA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
 aisheng.dong@nxp.com, liuzixing@hygon.cn
References: <1737717687-16744-1-git-send-email-yangge1116@126.com>
 <20250127150412.875e666a728c3d7bde0726b0@linux-foundation.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <20250127150412.875e666a728c3d7bde0726b0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgDXT2mME6dnD4_UAg--.46618S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw18ur1fCw15Xw45Jr48Crg_yoW8Ar47pr
	WxXr4ayrn7JrZ3ArZ7ta1kZF1rua4fGF4UJF1YkwnrAw43Ww17Xr47t34F9as8ur9Iga1U
	tw40v3WYyw4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgntG2enDWFDUQAAs7



在 2025/1/28 7:04, Andrew Morton 写道:
> On Fri, 24 Jan 2025 19:21:27 +0800 yangge1116@126.com wrote:
> 
>> From: yangge <yangge1116@126.com>
>>
>> Commit 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
>> simply reverts to the original method of using the cma_mutex to ensure
>> that alloc_contig_range() runs sequentially. This change was made to avoid
>> concurrency allocation failures. However, it can negatively impact
>> performance when concurrent allocation of CMA memory is required.
>>
>> To address this issue, we could introduce an API for concurrency settings,
>> allowing users to decide whether their CMA can perform concurrent memory
>> allocations or not.
> 
> The term "users" tends to refer to userspace code.  Here I'm thinking
> you mean in-kernel code, so a better term to use is "callers".
Ok, thank you. I will change it in the next version.

> 
> This new interface has no callers.  We prefer not to merge unused code!
> Please send along the patch which calls cma_set_concurrency() so we
> can better understand this proposal and so that the new code is
> testable.
Ok, thank you. I will add the caller in the next version.

   In fact the patch has cc:stable, which makes things
> stranger.  Why should the -stable maintainers merge a patch which
> doesn't do anything?
> 
> And please quantify the benefit.  "negatively impact" is too vague.
> How much benefit can we expect our users to see from this?  Some
> runtime testing results would be good.
> 
> And please describe in more detail why this particular caller doesn't
> require concurrency protection.  And help other developers understand
> when it is safe for them to use concurr_alloc==false.
Ok, thank you.


