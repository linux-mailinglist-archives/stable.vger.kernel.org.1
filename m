Return-Path: <stable+bounces-152645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74506AD9E47
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 18:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B03175264
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6575D2550A6;
	Sat, 14 Jun 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2orf1u8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205061DFF8;
	Sat, 14 Jun 2025 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749917510; cv=none; b=tWT1AykD/MCN+WLWV0KgDFuhAZvgX1BY7IK1i4F3TvazU6JTwMExGdTwzHpOvUuLT+dSKdocFdwDA1GLlgcUMQDy0fYnyDsD7djQptHtaU3Sn7BHR9FzNr8OUPUH7yoY07j8b+gdybRVktAQevt8zGWyKMZFEFDIHJaJNWni5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749917510; c=relaxed/simple;
	bh=HO/u7vcWpyzvd4aazv+YkQNHkXRKrNyBuXtN6IvKMiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSw3BcVy6vjgh9krrjhrsDtlRtXnXjkRaPnh7uX4R4vWkBUa3uUeJyuVarBrgeeWbCd0GcOyxMSUs+h1D3Rq1Iu7rLa3pE8bia/g7+Cr+Y/beLETW7/Bry4Nprk17e0FVD/gt/W4WGLf9J3fKw1RyzPXyc1HUseJDm5sbM4PKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2orf1u8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E9EC4CEEB;
	Sat, 14 Jun 2025 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749917509;
	bh=HO/u7vcWpyzvd4aazv+YkQNHkXRKrNyBuXtN6IvKMiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2orf1u8vuPP6Eg99pXSM0WRp/xayRX75R+Y4znpgwLU9YBM+zt76BEN6ynpjkLmv
	 a/2l474V+1zdTtYFotraKp88JhWNex8bpYqdn6ijjJPraR9LaltFNRdNNPTEsSJgF0
	 6TBjx3NnS1Y1lXE99Nh5iW5XJ2xBhqBPfue1NEM+piLb7FT/Iw4EoysbB84uNvbmGa
	 em6PHTd2EcBb6rWvvRXYiZGO8WdZHtUNgUFjH3XR6krxapuinYFRDcxrc8SwYRMNZF
	 zl+r5hif0nRuWuMr4KHriMDn7Dm62ty+AU5VYTRVntKA/LmmsbtycyXqOtTEZzftIz
	 5Kd9Kq8wXbIOw==
Date: Sat, 14 Jun 2025 12:11:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>
Subject: Re: Patch "PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus
 Reset" has been added to the 6.15-stable tree
Message-ID: <aE2fRMmnmhJLBZ8w@lappy>
References: <20250610121606.1556304-1-sashal@kernel.org>
 <aEuhJ_ldVUwI6u-V@wunner.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aEuhJ_ldVUwI6u-V@wunner.de>

On Fri, Jun 13, 2025 at 05:55:19AM +0200, Lukas Wunner wrote:
>[cc += Joel Mathew Thomas]
>
>On Tue, Jun 10, 2025 at 08:16:05AM -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus Reset
>>
>> to the 6.15-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      pci-pciehp-ignore-link-down-up-caused-by-secondary-b.patch
>> and it can be found in the queue-6.15 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Hi Sasha, thanks for selecting the above (which is 2af781a9edc4 upstream)
>as a 6.15 backport.
>
>A small feature request, could you amend the stable tooling to cc
>people tagged as Reported-by and Tested-by?  I think they're the
>ones most interested in seeing something backported.

I'll see if git-send-email supports something like that...

-- 
Thanks,
Sasha

