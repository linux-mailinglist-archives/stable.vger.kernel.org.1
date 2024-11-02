Return-Path: <stable+bounces-89574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EF09BA2BD
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 23:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5555C1C21846
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 22:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF601684A1;
	Sat,  2 Nov 2024 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUzFYvjT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE983157A6B
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730586387; cv=none; b=FkPS8s6TCRveQKupSNFYrifT7pu5Puc6d6M8+h9hjw2sk92ticnFaXiD8mbjRjw+4zpCqvBoBNCjGYe1f7MKjiJBDF2rTjHW/rfnvnWv5WvI0tqMF3gm2zVZ2lnaHb/PqMt7MEOU4t1hmKVgE5IVyOOWQSfmP647uF3yTT9NoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730586387; c=relaxed/simple;
	bh=nAQxc/PidVP50ELM/jHfGS68cE7nwN57aN0v/4rM31c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuDOknS2ZPdvsIqvLiHy5PCUp3EHk8TG2lWEKO78AkigwaAJsznzXJ4XRT5XTsEFwlrJpG2QYjhpZHuRwzYwQ3Tta9iYYFxVmKqHvIpoWOanXMUeXX/YZKAO+dQaxsWmEllRFNntwO7I2W4cQxyhbvkwgfPcmjKecH4WjRTcXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUzFYvjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFFDC4CEC3;
	Sat,  2 Nov 2024 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730586387;
	bh=nAQxc/PidVP50ELM/jHfGS68cE7nwN57aN0v/4rM31c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUzFYvjTzpX7AA+kuGc+qiB/GwE5bbhjxmkczT4whemtGNTpfmvgbtWRolVeRr8eL
	 ao3Ch59Ga/rAGiaZoPL/pkcxXUQ33dAxYi1/20yak0xpTFtJHIHiq/WYc+3ywpHC2j
	 /SUh2j+PFuV0acy93QY0RmErl0HLtnrqhSNOJJOOGa3eTFBAdgqYSMrd/oRO7GBFfp
	 UhnrfA2S8uUBiHrHo83/rk/Ufl2UMwtKon17b67ttMC/FuBvZ/eJ38WpHFTt4PpaTJ
	 iEC6RnSmPa84BuNJmNAyri4iOjpG93pr569uXKq2IBYs9O5xhV+sak2DiDgNDQwO/8
	 fEPqXhJtKK5nw==
Date: Sat, 2 Nov 2024 18:26:25 -0400
From: Sasha Levin <sashal@kernel.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>, stable@vger.kernel.org
Subject: Re: Backport smb client char/block fixes
Message-ID: <ZyanEXGIv7l48n04@sashalap>
References: <20241028094339.zrywdlzguj6udyg7@pali>
 <20241101235645.yqwqqipzhzoyprch@pali>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101235645.yqwqqipzhzoyprch@pali>

On Sat, Nov 02, 2024 at 12:56:45AM +0100, Pali Rohár wrote:
>Hello Greg and Sasha, do you have any opinion about this?
>
>On Monday 28 October 2024 10:43:39 Pali Rohár wrote:
>> Hello,
>>
>> I would like to propose backporting these two commits into stable:
>> * 663f295e3559 ("smb: client: fix parsing of device numbers")
>> * a9de67336a4a ("smb: client: set correct device number on nfs reparse points")
>>
>> Linux SMB client without these two recent fixes swaps device major and
>> minor numbers, which makes basically char/block device nodes unusable.
>>
>> Commit 663f295e3559 ("smb: client: fix parsing of device numbers")
>> should have had following Fixes line:
>> Fixes: 45e724022e27 ("smb: client: set correct file type from NFS reparse points")
>>
>> And commit a9de67336a4a ("smb: client: set correct device number on nfs
>> reparse points") should have contained line:
>> Fixes: 102466f303ff ("smb: client: allow creating special files via reparse points")
>>
>> Pali

I'll queue both for 6.11 and 6.6, thanks!

-- 
Thanks,
Sasha

