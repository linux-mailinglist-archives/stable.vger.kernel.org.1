Return-Path: <stable+bounces-121408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5205FA56CDA
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5558617AC21
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD325221578;
	Fri,  7 Mar 2025 15:58:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBCC21D3F7;
	Fri,  7 Mar 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363081; cv=none; b=Vv7hfRi5UPdbFvMSuZSGgV+JFC8XHFQv6KQCTDkauVMOJbpev3/LL3w2yH2tEU59WfLX+R4xj12cftfvZr1HHKDcy3I9FJH75JqnExUM/iFY9uqqbS0JgnTkGz2Oic8veaKAmlqsyttcS+SO5ofTgkG5MCauvszaGjUDniU69OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363081; c=relaxed/simple;
	bh=fRDrJH1m2u038pPBi26MkMxgn5EvMPa4VcxYn0IQTwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NG0teYhlSWMQ15VrvjwoTh+SdnosXnou5A+kabMhhcM8RDuP7kmKTOVRUb5KWL1M14Ghl8HeUYgqtJ8H87jfWZV/svYFZ0i9k/hnLELOrodhzefcKu12eItkC0W21NYwhJJjaLlgOQAgj2CIOL3/fBqzQbecue9xZKP/+IUx4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFE701477;
	Fri,  7 Mar 2025 07:58:05 -0800 (PST)
Received: from [10.57.84.99] (unknown [10.57.84.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496F83F673;
	Fri,  7 Mar 2025 07:57:52 -0800 (PST)
Message-ID: <ef069b96-aeec-4974-bbb4-59bc11a6d158@arm.com>
Date: Fri, 7 Mar 2025 15:57:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/madvise: Always set ptes via arch helpers
Content-Language: en-GB
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 David Hildenbrand <david@redhat.com>
References: <20250307123307.262298-1-ryan.roberts@arm.com>
 <dbdeb4d7-f7b9-4b10-ada3-c2d37e915f6d@lucifer.local>
 <03997253-0717-4ecb-8ac8-4a7ba49481a3@arm.com>
 <3653c47f-f21a-493e-bcc4-956b99b6c501@lucifer.local>
 <2308a4d0-273e-4cf8-9c9f-3008c42b6d18@arm.com>
 <d9cd67d7-f322-4131-a080-f7db9bf0f1fc@lucifer.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d9cd67d7-f322-4131-a080-f7db9bf0f1fc@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2025 14:55, Lorenzo Stoakes wrote:
> I'm not necessarily against just making this consitent, but I like this
> property of us controlling what happens instead of just giving a pointer
> into the page table - the principle of exposing the least possible.

Given the function is called walk_page_range(), I do wonder how much
insulation/abstraction from the page tables is actually required.

But I think in general we are on the same page. Feel free to put looking at this
quite a long way down your todo list, it's certainly not getting in anyone's way
right now. But given it tripped me up, it will probably trip more people up
eventually.

Thanks,
Ryan


