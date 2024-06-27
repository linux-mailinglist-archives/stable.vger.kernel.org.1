Return-Path: <stable+bounces-55966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F48891A8EA
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE5C28836B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25919750B;
	Thu, 27 Jun 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4/rNedT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8C195B08;
	Thu, 27 Jun 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497568; cv=none; b=bN//WDjI+opZKApbCC0F+NYOIa7ztpN51eaEloWnTtUiFj7Zw97kJ8ZpOQH3Q9MetU+hmvzjfLu2o9RH28LM1iAUu34JeRfTUDcEoyqHxEMblYGZcvFsErXWQxCG43WHtmihwFciHQqcbw0S477exBbpkTC/mgy99PcESTLWHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497568; c=relaxed/simple;
	bh=JhIkarDmL/2/aCuoDjTLetw1cDHiqWNPgdilQFa08wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za2opfKAwUbeRLWRsSreXilVWRr7fljELW9EiRG5cwWBgTPKi2ygRGfboHwuXaQShz5gL2PWesRUT4VF9OFJPXHt4TtgfEyJMs8u8XquiJ8lJGbtvRB8/WHSFUnypyxsdoVAmvJ1J89pes7gzaHqfj0OAURVjA3s3dkFaOCQZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4/rNedT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB642C2BBFC;
	Thu, 27 Jun 2024 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497567;
	bh=JhIkarDmL/2/aCuoDjTLetw1cDHiqWNPgdilQFa08wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4/rNedTO2MqmZhu//VjEh2HLUy7TLSTO5tRxnzJTQ/JC2cphtRHwBnIJT1UzXkY7
	 /HPVn3syiIGy0buFty3rsasPYSGbrunz0xp058y6SI1Osrj7loMBg/ljoVnlJr64xo
	 kSPSbFY6DeIzbUxcEMaz4yXTfF9sQxA0Fc/vsHoIapJMpXh1HIfuvhL8xZ/qUblZD0
	 z8y3mY6riGEG56cv4LinaTAfeS1rSHkGeIkJ8mSG2nEXNLsgT9G1Dx2zu0fU85v27Y
	 1XCvH0yPVeaTRr9ee/WJBtdLN+Ju3IyDAiFLY741FYY1+IdUfGWzknIZHfD5XFHH33
	 X8xdNDgxBrNiQ==
Date: Thu, 27 Jun 2024 10:12:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "mm: memblock: replace dereferences of memblock_region.nid
 with API calls" has been added to the 5.4-stable tree
Message-ID: <Zn1zXiis-yqRB2VO@sashalap>
References: <20240626190708.2059584-1-sashal@kernel.org>
 <Zn0Q_DKvcVF8P5f-@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zn0Q_DKvcVF8P5f-@kernel.org>

On Thu, Jun 27, 2024 at 10:13:00AM +0300, Mike Rapoport wrote:
>Hi Sasha,
>
>On Wed, Jun 26, 2024 at 03:07:08PM -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     mm: memblock: replace dereferences of memblock_region.nid with API calls
>>
>> to the 5.4-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      mm-memblock-replace-dereferences-of-memblock_region..patch
>> and it can be found in the queue-5.4 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit dd8d9169375a725cadd5e3635342a6e2d483cf4c
>> Author: Mike Rapoport <rppt@kernel.org>
>> Date:   Wed Jun 3 15:56:53 2020 -0700
>>
>>     mm: memblock: replace dereferences of memblock_region.nid with API calls
>>
>>     Stable-dep-of: 3ac36aa73073 ("x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()")
>
>The commit 3ac36aa73073 shouldn't be backported to 5.4 or anything before
>6.8 for that matter, I don't see a need to bring this in as well.

Sadly there was no fixes tag :(

Should this be reverted from 5.4 and older, or is it ok for it to be
there?

-- 
Thanks,
Sasha

