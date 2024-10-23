Return-Path: <stable+bounces-87822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC679AC95C
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 13:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B001F21C1F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF48C1AB6E2;
	Wed, 23 Oct 2024 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+Kap43Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F449652;
	Wed, 23 Oct 2024 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684022; cv=none; b=EFYAQ7CrsgjsfKPJIlbl4H4Yfhl56f2y5E9FUtppPfO6T7sEDCQoi2IeyIeswK9ncYTjK4+h96ebtz/UVixrLS9Z5n8/Kg3Wmc/tTPYJp1ZOej2Z6MBUf+nLMJHb+uQ/71lBGZBrvdBK8byoaABgUrdzhj7Vy2U4DQ58hjhho7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684022; c=relaxed/simple;
	bh=qbPFGKEQrBpWkIDc1DIDzhTXQsG1ArOFLgz6REp0Y3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMmHszwKL2LUzrf6k1DYYWJhj5EBs9TZHBii0RLN6uh5ckG9tErIkAIm2gv5/RDyM4TfIGOZG0rFYiopsWdtUgbYuApWDu6iNKxLAs/VjbflKL5ZoRy0OoUZIK6nBkADyW/NKAxbTDJMiwYDiGCl5TTqvtQRWjc+sbgbclC19v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+Kap43Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43F9C4CEE5;
	Wed, 23 Oct 2024 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729684022;
	bh=qbPFGKEQrBpWkIDc1DIDzhTXQsG1ArOFLgz6REp0Y3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+Kap43ZXpKFt/GvfD4/Omk8n+UMTHt347dfps0iThvluPdvuk7XCWGFpcCUxPRDl
	 9fF1/x1cK260RU/O0QkPG+0amBHfKE+8XAoMRqyL9iJhlIU6RvHXFtRPbn4woLgS3z
	 0qrSDId+L21xbIv8gjdYXPwXlli49WguPaoTAwc+sS4uh6xDoUWuczQCunBgyU0hFo
	 f/IFvkKtkm1NxlYu7SwffzdluhUBWgRDirSi2VWcmmb+a/SY5yNsAF0vihv63f7yoG
	 95e9acEfrTGT0IV6gF6osWmnSHPWUWA5NC5jAQrdi8f7jKROHCLXyr+3MjIRmIDo0z
	 2sFoeliVj4iDQ==
Date: Wed, 23 Oct 2024 07:47:00 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: Patch "selftests: mm: fix the incorrect usage() info of
 khugepaged" has been added to the 6.11-stable tree
Message-ID: <ZxjiNHPvny8oaVbq@sashalap>
References: <20241022174426.2836479-1-sashal@kernel.org>
 <9a81f472-22ab-c921-ae2e-ec5843be4490@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a81f472-22ab-c921-ae2e-ec5843be4490@huawei.com>

On Wed, Oct 23, 2024 at 09:22:35AM +0800, Nanyong Sun wrote:
>On 2024/10/23 1:44, Sasha Levin wrote:
>
>>This is a note to let you know that I've just added the patch titled
>>
>>     selftests: mm: fix the incorrect usage() info of khugepaged
>>
>>to the 6.11-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>>The filename of the patch is:
>>      selftests-mm-fix-the-incorrect-usage-info-of-khugepa.patch
>>and it can be found in the queue-6.11 subdirectory.
>>
>>If you, or anyone else, feels it should not be added to the stable tree,
>>please let <stable@vger.kernel.org> know about it.
>Hi，
>  I don't think this patch needs to be added to the stable tree 
>because this just fixes usage
>information, as Andrew had previously said：
>https://lore.kernel.org/lkml/20241017001441.2db5adaaa63dc3faa0934204@linux-foundation.org/

I'll drop it, but really - why not? It's a cheap fix that is very
unlikely to introduce regressions and it improves the user's experience.

-- 
Thanks,
Sasha

