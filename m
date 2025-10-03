Return-Path: <stable+bounces-183295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F51BB787E
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBC519C6F7C
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739B28DB56;
	Fri,  3 Oct 2025 16:25:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BB110F1;
	Fri,  3 Oct 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508715; cv=none; b=dq9t/+NlAI4lh3fBtKrvPM7PCPsZM0s6t52WMh/z3h20HKTjD/PHEmv+klyzAl/Hn7yAqOnB5sCDBiiJCt8aiiPE9tfcSTwelWF/Gh8KtHlu9oVqa/5dy2eLBpMnog0zeCDTNXCbR8MmRJLSV1Dd0pBKmFVb25iqpyy1xIX8pQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508715; c=relaxed/simple;
	bh=MSGGQw0EHFBJFHMt+TlybKJnZJ8X0knV03efFYk/kkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPn048LVX2gNvHMr9uCe/28fNq+rqBlGrBeWsc7G0qWwC+vDtEsI/DPCNT2ejKc6f2Qio/9R16l6PJiuVPDeWi6cMaPLxEbTyVc2gWCMkSWDYdJgrJo9e2SUTGCboxlV+kLaCJ+R5haQ7uL62Ygj8vJ1OyILfoz/hQQkgNci5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A08E1655;
	Fri,  3 Oct 2025 09:25:04 -0700 (PDT)
Received: from [10.163.65.114] (unknown [10.163.65.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB1913F5A1;
	Fri,  3 Oct 2025 09:25:04 -0700 (PDT)
Message-ID: <39cb4556-f80a-44ba-a8ae-7990544673a8@arm.com>
Date: Fri, 3 Oct 2025 21:55:00 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mmap: Fix fsnotify_mmap_perm() call in vm_mmap_pgoff()
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, stable@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>
References: <20251003155804.1571242-1-kirill@shutemov.name>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251003155804.1571242-1-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 03/10/25 9:28 pm, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
>
> vm_mmap_pgoff() includes a fsnotify call that allows for pre-content
> hooks on mmap().
>
> The fsnotify_mmap_perm() function takes, among other arguments, an
> offset in the file in the form of loff_t. However, vm_mmap_pgoff() has
> file offset in the form of pgoff. This offset needs to be converted
> before being passed to fsnotify_mmap_perm().
>
> The conversion from pgoff to loff_t is incorrect. The pgoff value needs
> to be shifted left by PAGE_SHIFT to obtain loff_t, not right.
>
> This issue was identified through code inspection.
>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
> Cc: stable@vger.kernel.org
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


