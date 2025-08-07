Return-Path: <stable+bounces-166784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963ABB1D971
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 15:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA27188FF08
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C292561AA;
	Thu,  7 Aug 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcmY6+QC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922041EB5B
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574882; cv=none; b=DSOEVhwO/TE7J54iOHQyTbLVrhrVE1Yfx8MvgvZSuDIqV7gFzp1RE0+9VMuRUSSiNMuDRLqmDRG6UMlvLDhikWegI1kzDb/daJ4zYqanNB/PDmm4vDkcl1iBqojd+HviNXP9YxLfKflcdsbNrojfzg5HcCPkKrXxVJ90wAWey4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574882; c=relaxed/simple;
	bh=k0YdI7ysp8/x+FYG8D8iw4nAJiZLYMH5/mMb8vlyWRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCFOb/9DiaQSxSDU4u1rQp91zygtcvrUDZ9GlHTTwdn3UEqyI5jkARcegkI8UiOg9vXybXcYdkN/cNbvna7UdpHzV/lzzlVX7d6g5f6jf/sgjci7Jfcc1Fqb0+nCbX7OhrY5I/NzOhO3o09EgOd977/qn0EU0lD3/sDq0Z5F1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcmY6+QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D445AC4CEEB;
	Thu,  7 Aug 2025 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754574882;
	bh=k0YdI7ysp8/x+FYG8D8iw4nAJiZLYMH5/mMb8vlyWRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZcmY6+QCsK506xc1pEclzejD20slHtHje6qbY+84Gh4UxiVuXKmgINN83ocE38XA+
	 xsdCDB73G7smoi6WgkWMnL8YP3LQUJjD3/snyPfX4DDO9730x9FJ2U675NshW/av+w
	 7Gs5s8I62pew2h9dypAh3aVDMjjUCXAzHQBsoX8764c7JTqiJO4wJ3xJz0NXBSRb+4
	 LmXGKLMtrs53DBYVdKuK2sUm44TIexffD7zSGT0eiNnNL1MlqaxULOPujVvuMmbM+/
	 sQbPcOHj4a8NlWwhlbONAQ27AdjBd82K/x9W8eO1Txmdf85J9duIOSWYsWn1WafzbP
	 bG8LuAALCYZrQ==
Date: Thu, 7 Aug 2025 09:54:39 -0400
From: Sasha Levin <sashal@kernel.org>
To: Markus =?iso-8859-1?Q?Bl=F6chl?= <markus@blochl.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] ice/ptp: fix crosstimestamp reporting
Message-ID: <aJSwHwQWAAseN871@lappy>
References: <20250725-ice_crosstimestamp_reporting-v1-1-3d0473bb7b57@blochl.de>
 <1753492278-e3830ff7@stable.kernel.org>
 <ngpaxbcoagu6uiusrnqds7i62qv3c3nk6ppqv4eovrltnnlvqs@opvhzljlgpib>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ngpaxbcoagu6uiusrnqds7i62qv3c3nk6ppqv4eovrltnnlvqs@opvhzljlgpib>

On Thu, Aug 07, 2025 at 02:34:10PM +0200, Markus Blöchl wrote:
>Hi Sasha,
>
>Sorry, I don't really know how to handle this response from your bot:
>
>On Fri, Jul 25, 2025 at 09:37:11PM -0400, Sasha Levin wrote:
>> [ Sasha's backport helper bot ]
>>
>> Hi,
>>
>> Summary of potential issues:
>> ❌ Patch application failures detected
>> ⚠️ Found matching upstream commit but patch is missing proper reference to it
>
>The patch clearly mentions `commit a5a441ae283d upstream.` to me.
>Am I too blind to spot a typo or similar?

It should be the fully 40 char sha1, not a shortened version.

>>
>> Found matching upstream commit: a5a441ae283d54ec329aadc7426991dc32786d52
>>
>> WARNING: Author mismatch between patch and found commit:
>> Backport author: Markus Blöchl <markus@blochl.de>
>> Commit author: Anton Nadezhdin <anton.nadezhdin@intel.com>
>
>This mismatch is intentional.
>I did not author the original fix. I merely backported it to 6.12.y.
>So I kept the original author when cherry-picking.

That ok, it's mostly just a warning for us to see if we need to get
additional acks or do a more careful review.

>>
>> Note: Could not generate a diff with upstream commit:
>> ---
>> Note: Could not generate diff - patch failed to apply for comparison
>> ---
>>
>> Results of testing on various branches:
>>
>> | Branch                    | Patch Apply | Build Test |
>> |---------------------------|-------------|------------|
>> | origin/linux-6.15.y       | Failed      | N/A        |
>> | origin/linux-6.12.y       | Success     | Success    |
>> | origin/linux-6.6.y        | Failed      | N/A        |
>> | origin/linux-6.1.y        | Failed      | N/A        |
>> | origin/linux-5.15.y       | Failed      | N/A        |
>> | origin/linux-5.10.y       | Failed      | N/A        |
>> | origin/linux-5.4.y        | Failed      | N/A        |
>
>As written, the backport is for 6.12.y only.

Normally you'd indicate which trees you want the patch to be applied to
in the subject line. In this case it would be something like:

	[PATCH 6.12] ice/ptp: fix crosstimestamp reporting

-- 
Thanks,
Sasha

