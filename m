Return-Path: <stable+bounces-89811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748609BCA4F
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 11:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D06E1F22699
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D71D1F76;
	Tue,  5 Nov 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDFTa7jQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B191CC881;
	Tue,  5 Nov 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802127; cv=none; b=QPJyVzcAdvCvpoxdJfams94NxC6Kpx2cI4pabyCnLYhdz9huCTMvZydar+/3YkFaHP2nVsRpB6xykNmFs75t7+qTueGoFpDFphN0ZVhMdPEbID7g5tqUrFxCDRQyIo1aP8/lWIhFL2Mf5We738fOcuD54e//aWxIEiv2/Ngipsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802127; c=relaxed/simple;
	bh=6SST80Lrw52AOm8Di2WQBB2K9EII9rAmVpZEiIYk4tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3i9Kv4AlBmgQpNlnrz+FQdCTVnZypqoFCObby5UPkQdYMaE0epKbel4zUxFvqvRU9cEEkkmqKJYJkNLL3s6mcfWw/eodhm4OSRdhzPNOvkOc1vA+OaLdhQui0z5AdZovb6nRj2tsRJX4wt68d4odwQonserVnSZOq/Z+2hdNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDFTa7jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBCDC4CECF;
	Tue,  5 Nov 2024 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730802127;
	bh=6SST80Lrw52AOm8Di2WQBB2K9EII9rAmVpZEiIYk4tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDFTa7jQAHkls4uub9hBXsRnvqXsNRjDmcS9+XvV8yu5YKcgZK6fqjRuvbSRY6e7v
	 0Fz+dMSjfFWtoh5P4ErV04BPgvHX5McUJNvCXwkvbVtz2zMPTh/Qj95dUWAQ84Uq7v
	 OZsq+wK1h85vkQ1PmtI7uGxeX9NUSKAL1cTd0nvTiWqmaS+VkgYXKLiyQGsNBuDsdI
	 VeELPLOdsmILkT35JMkcLVyUeelwf1uNNwzyamFUM/egnpiNVSszp05eIWzQs3ALPF
	 6h9cB9LdGwfAz7GLTXOO998YK0amoKLITrP5c6qJ/LUEzr8q65NsloC0U/kLFp53bC
	 Du3jUmy77Kr6w==
Date: Tue, 5 Nov 2024 05:22:04 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	shenjian15@huawei.com, Salil Mehta <salil.mehta@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "net: hns3: add sync command to sync io-pgtable" has been
 added to the 6.11-stable tree
Message-ID: <ZynxzJD7A6uBNrbA@sashalap>
References: <20241101192250.3849110-1-sashal@kernel.org>
 <8ce8ba06-acb9-400f-acee-ef0dbd023dc1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8ce8ba06-acb9-400f-acee-ef0dbd023dc1@huawei.com>

On Tue, Nov 05, 2024 at 10:59:54AM +0800, Jijie Shao wrote:
>
>on 2024/11/2 3:22, Sasha Levin wrote:
>>This is a note to let you know that I've just added the patch titled
>>
>>     net: hns3: add sync command to sync io-pgtable
>>
>>to the 6.11-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>>The filename of the patch is:
>>      net-hns3-add-sync-command-to-sync-io-pgtable.patch
>>and it can be found in the queue-6.11 subdirectory.
>>
>>If you, or anyone else, feels it should not be added to the stable tree,
>>please let <stable@vger.kernel.org> know about it.
>
>Hi:
>This patch was reverted from netdev,
>so, it also need be reverted from stable tree.
>I am sorry for that.

I'll drop this and the other hns3 commits that were reverted. Thanks!

-- 
Thanks,
Sasha

