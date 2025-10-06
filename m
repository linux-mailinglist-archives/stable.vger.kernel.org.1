Return-Path: <stable+bounces-183430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB408BBDFD7
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 14:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D8D3A7BDC
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0122B262FC0;
	Mon,  6 Oct 2025 12:14:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9149269CF1;
	Mon,  6 Oct 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752850; cv=none; b=KG2zJOP2u+92hB5mQ4YaOcgVOSdnjjMag2qG49uanMOkS4QjRcaF5zT4phqt0Jq6nmpK4AgaIYhTOtUWBBsdvZRIoYx5ESLpGMXAvY76ITSs0MY4Eu+ekHVyDd8atPcF3W64UotXeC6U2UvkBekwKc4dntU7r3KOPbqkWIUuOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752850; c=relaxed/simple;
	bh=YK4niNdQaM3H/jhjLOvTw+T2AmFLkKWKRBPumt1Nd1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQPl/1DrHW6MGmXNOssJqrjd4b/Wwy/CCzopoikqxBdpJXrbTVvXtIo1phZWgmbEU6kOZqHKCHM4ZsRwBzlDuSsnR6HqZsqJ9dI5vgDCk6aul8E/ioLUuR9epfeti8GNVLDJbMaP8jWRx722VNgs5TpONC1alYM5Bdw98F4iBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7B9A1515;
	Mon,  6 Oct 2025 05:13:57 -0700 (PDT)
Received: from [10.57.81.160] (unknown [10.57.81.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AAD73F738;
	Mon,  6 Oct 2025 05:14:03 -0700 (PDT)
Message-ID: <66251c3e-4970-4cac-a1fc-46749d2a727a@arm.com>
Date: Mon, 6 Oct 2025 13:14:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
 <edc832b4-5f4c-4f26-a306-954d65ec2e85@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <edc832b4-5f4c-4f26-a306-954d65ec2e85@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/2025 12:36, David Hildenbrand wrote:
> On 03.10.25 17:52, Ryan Roberts wrote:
>> fsnotify_mmap_perm() requires a byte offset for the file about to be
>> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
>> Previously the conversion was done incorrectly so let's fix it, being
>> careful not to overflow on 32-bit platforms.
>>
>> Discovered during code review.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>> Applies against today's mm-unstable (aa05a436eca8).
>>
> 
> Curious: is there some easy way to write a reproducer? Did you look into that?

I didn't; this was just a drive-by discovery.

It looks like there are some fanotify tests in the filesystems selftests; I
guess they could be extended to add a regression test?

But FWIW, I think the kernel is just passing the ofset/length info off to user
space and isn't acting on it itself. So there is no kernel vulnerability here.

> 
> LGTM, thanks
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


