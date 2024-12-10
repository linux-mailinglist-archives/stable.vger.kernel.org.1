Return-Path: <stable+bounces-100419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBE9EB0C2
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC30169E5C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B15E1A2C0E;
	Tue, 10 Dec 2024 12:26:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3131A707D;
	Tue, 10 Dec 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833588; cv=none; b=qmmAFtcHOdt8xDkIS/HrFySCzd2bxOi9JAm/POhKggXpnQXxU9CtNlQsehDmUA3m7TN3RvNqDJrbM+5AtAgD9SMbn/NuRhj8g4oPouVSgJCF1eytHoHpvKK/Gh90AMrtFMlB1lc10MMXwrdlZizZcwVnQzTwaStrrkxWSHIIhHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833588; c=relaxed/simple;
	bh=1bKp1Azykws4tRv1nJYZOZ53DcWHEwXvVpnb7WdkpS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7z18iXbVKyXcDV7woK910zV1ftgJz5ylkUQhVQafry62Xb2mUteC6faPCVu0rWa5LysDd2RAJ8Dv3FoZSFBUUg7uEei+iyFeC4CmfpK/cBrkRhs7cxeVY1hMaXsOeF3GQqZTYEZjGC3+gYnu0yEM5HFkPWgHIowGcJ7yQ0yMsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564E81063;
	Tue, 10 Dec 2024 04:26:53 -0800 (PST)
Received: from [10.57.91.204] (unknown [10.57.91.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EDD53F5A1;
	Tue, 10 Dec 2024 04:26:23 -0800 (PST)
Message-ID: <c7446da1-11ca-4621-bc1a-8598e1a5a7fe@arm.com>
Date: Tue, 10 Dec 2024 12:26:21 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "iommu: Clean up open-coded ownership checks" has been
 added to the 6.6-stable tree
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Rob Clark <robdclark@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20241209112746.3166260-1-sashal@kernel.org>
 <cc3b7d5d-bd98-4813-b5ea-71bd019c014e@arm.com>
 <2024121015-duke-dispose-ecec@gregkh>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2024121015-duke-dispose-ecec@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-10 12:17 pm, Greg KH wrote:
> On Tue, Dec 10, 2024 at 12:09:42PM +0000, Robin Murphy wrote:
>> On 2024-12-09 11:27 am, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>       iommu: Clean up open-coded ownership checks
>>>
>>> to the 6.6-stable tree which can be found at:
>>>       http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>        iommu-clean-up-open-coded-ownership-checks.patch
>>> and it can be found in the queue-6.6 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree,
>>> please let <stable@vger.kernel.org> know about it.
>>
>> Unless you're also going to backport the rest of the larger redesign which
>> makes this commit message true, I don't think this is appropriate.
> 
> It's needed because of:
> 
>>>       Stable-dep-of: 229e6ee43d2a ("iommu/arm-smmu: Defer probe of clients after smmu device bound")
> 
> That commit.
> 
> Is this still not relevant?

It's not a functional dependency though, just context, and in this case 
I think a manual resolution is a lot safer to reason about. Lemme just 
remind myself how to write up a backport patch correctly, and I'll send 
it out shortly...

Cheers,
Robin.

> 
> thanks,
> 
> greg k-h


