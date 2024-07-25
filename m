Return-Path: <stable+bounces-61340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593B593BB34
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 05:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2ED284AC8
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80FD17550;
	Thu, 25 Jul 2024 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCRraxse"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63832D299;
	Thu, 25 Jul 2024 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721878001; cv=none; b=o23EQXfJzUg+vzjPtJATpI0H6IvS0E6ewQgbBvBdHZl80nlDGYn5I9LF1fezGoQO62SFnM5g2W3L8lCZ2mB2Y9RuhUqroxSi8Ky6jOe7CSPXtvxQD9Q/opYKee6hr8l4ZT3Pm63+nxWbipOAhc8n+3OjXq3kNTxaRQMmaH57T74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721878001; c=relaxed/simple;
	bh=myy1FSn0Kxe1zQoxZ6SSh2q07lr40llh8kdQajzGCBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzArbtarVVexmFvhotK+J/9GbT9zrDDgU4RnLnbqw67b/nQO+JFJ5szKLJYHbbn6boCQX6E1pI8NtpIhEtclPSD3bdDipRj+3rPfTDmgI9CzmPV9Odvdsoh31YHq12MvSHgTYFMXXOVt8uvfr9E9c6rLqK3BelHFDYxx8AuQcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCRraxse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6390AC116B1;
	Thu, 25 Jul 2024 03:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721878000;
	bh=myy1FSn0Kxe1zQoxZ6SSh2q07lr40llh8kdQajzGCBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LCRraxsee92KNhDchsFDUnboRTaowt9XM9iebkgve3BRIg8NGsmq/BsiJ/tOiDmBM
	 uJSbS4PHFlpgR2V2bUGtmFDqaJTzELWiAO4OfC5WLE01mA5M6/g5j8EvOobMq4VwTO
	 TTpWAgZvzD8QdrWh5RqP9Ek/1nsqOybuFbW7rrk5axAvG+Hr5Bm+beVKlg2X7Pk6Rb
	 UzqOI8EERiAME8rpMU182bAKBFtw1rqmpT9eJv6Xs9RwDn/RuHf79hD4s0P2+g98kJ
	 mDJacT56j0i+Sf1SZxPRdqyXBotbovfxMrERvKlM2QgnEKQJQa2xGnKxsSi40fRPAc
	 /daKbOpozrjGw==
Message-ID: <37e07368-3000-46e2-822c-584b29011f6e@kernel.org>
Date: Thu, 25 Jul 2024 11:26:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix several potential integer overflows in file
 offsets
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20240724172838.11614-1-n.zhandarovich@fintech.ru>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240724172838.11614-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/25 1:28, Nikita Zhandarovich wrote:
> When dealing with large extents and calculating file offsets by
> summing up according extent offsets and lengths of unsigned int type,
> one may encounter possible integer overflow if the values are
> big enough.
> 
> Prevent this from happening by expanding one of the addends to
> (pgoff_t) type.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: d323d005ac4a ("f2fs: support file defragment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

