Return-Path: <stable+bounces-32376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811DB88CD2A
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 20:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09ED7B29D80
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A23A8D0;
	Tue, 26 Mar 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOpRYTEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C6802;
	Tue, 26 Mar 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480983; cv=none; b=Hdm2NMBJP8Z1RbUVFRnvRbvSPINarNKyjDPeBp/F2pnXfQLYFp2/KZid0X7Pz4dSVWfMrSl5D4lFSKxSUBOrDxivLyfBnguOhmOPH9JCrFKUMbrygBmJ/+cZ9EvItdRH64/Ega0VEnD9+BHR34l5dQhFaJS9DT/dEZCq6NhQqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480983; c=relaxed/simple;
	bh=iU53mz5gVhq7abaXjUhQvx4ORrW9DRxK/HIImuuyIds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCbsakZqkbtgYbYSS9uXFxrUNGT2/1MfsQp4cHo0jaK2uQG1oZSfa4hUnXqai396DUOB5pUR+nP7DBlB1DuOlffK7Z+3NW5ZA6qk83+fkTZIPtTdYFK8ox+iZH5GH+MISsZvCYjXSo42P00EiwlNEZm7B+5h7UGJ4ExIehOKIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOpRYTEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010C7C433C7;
	Tue, 26 Mar 2024 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711480983;
	bh=iU53mz5gVhq7abaXjUhQvx4ORrW9DRxK/HIImuuyIds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOpRYTEjb87rY0ta/eyqmfeD7t0ZUKI7b89BThwplqDjAbcHsH5o2H2EEi0v8t1ix
	 vJ+5EbN6G71Rn8bsJHNniEl+hUmQjOF4oQA6hC6gzGVQIyJuguC/XjI6F0wWaC7ERj
	 KJTsnHNxnbhP90o0MVYLFsKBiL/8KziOvM1Ugoji3RsAaPmcWNCK1Ht7/8aj5XHysC
	 EfUxee+QoVNj6Skd3MrxXd5XYAT8jsppQxJYkkJ0w5+nGGyvUw+6AfYfdn19Hd4ucP
	 CHVf/aeAChuo7h/FEKlPTtJI0aUQ0h+aKRfBvyfWublMzzhS8AwqBXcimGIqY5glus
	 vdsLH0/vkjtmg==
Date: Tue, 26 Mar 2024 15:23:02 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 5.15 005/317] btrfs: add and use helper to check if block
 group is used
Message-ID: <ZgMgljyKh01iWOzt@sashalap>
References: <20240324233458.1352854-1-sashal@kernel.org>
 <20240324233458.1352854-6-sashal@kernel.org>
 <20240325182556.GN14596@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240325182556.GN14596@twin.jikos.cz>

On Mon, Mar 25, 2024 at 07:25:56PM +0100, David Sterba wrote:
>On Sun, Mar 24, 2024 at 07:29:45PM -0400, Sasha Levin wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> [ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]
>>
>> Add a helper function to determine if a block group is being used and make
>> use of it at btrfs_delete_unused_bgs(). This helper will also be used in
>> future code changes.
>>
>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> Reviewed-by: Boris Burkov <boris@bur.io>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> Reviewed-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Please drop this patch from all stable branches unless it's a
>prerequisite for some other patch. This is clearly a cleanup.

Ack, thanks!

-- 
Thanks,
Sasha

