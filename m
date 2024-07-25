Return-Path: <stable+bounces-61339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB693BB2A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 05:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D5D1F239AC
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 03:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA9513AD8;
	Thu, 25 Jul 2024 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgMH+8RY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB911CA9;
	Thu, 25 Jul 2024 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721877715; cv=none; b=SyVo3SxssDDcLgqhES56mEt4AWTf1YgRbc5kOiQ2OkVTFt9GXH1gy0/YXKzego2KLkV8KRWSMwOigKR3M0HyXKDOtiGHfFEmzrrF0koIfra5qT9xYK10NZwOO4PPfRr/XXXR1HlsnzhcMBJEmgybKeDePg9j0l+VOvwMT4IG9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721877715; c=relaxed/simple;
	bh=g74e3WBgbVSeQta0CVKZFBOP7VtQ2Ll8vRhMwBAW99I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWkjj+1Cz8hB8oF6r4zHU9lGYiiOH5XXVMqpNxYp8MgvuoXXlc2GGXt0JPF7L6s3ejgYEiXLt3mDcRwjiv3XDHj72dieLK979r8+3LQF4b9tRGBfJ4m1rqAsg71C9oSQA23ONXWH9CKwz8ZOSIxS6b1V/22+dhturbqTwyfS3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgMH+8RY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319DDC32781;
	Thu, 25 Jul 2024 03:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721877714;
	bh=g74e3WBgbVSeQta0CVKZFBOP7VtQ2Ll8vRhMwBAW99I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UgMH+8RYjRyIV+kmXBFgw7xHESnHJ/iQdYfQzdW7wcpH1Ame+7ixb0hmuWdPdU/gv
	 h5dgB6AX+VcqrMF+QKLBl8FdJmBHw4HZF6GF+DSNorG+0ry6psiG7FfCSJEI2RAcF4
	 tNQ+GRHKnzSIaRQQJV3tWBIM8az5y+cMDuXbL0hewtxSISYOLay2sk0hqq5dpWSL+T
	 ljGL47L+AqziR4gSw0gTv7Fkf6v7Kv5uH1/K8Cv6xXAIZnRgooBc+tdLumH3rVJwz5
	 /wZXjmp/ZCkKOAXq0tGCZjrohuVX/FjVWq10JnJhQ/iGfJMTCPB5dx9FXp/vx9AUir
	 Gp8deLmfFBF7Q==
Message-ID: <3446a775-99b7-43c3-a35c-1a0f72688e97@kernel.org>
Date: Thu, 25 Jul 2024 11:21:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: prevent possible int overflow in dir_block_index()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20240724170544.11372-1-n.zhandarovich@fintech.ru>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240724170544.11372-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/25 1:05, Nikita Zhandarovich wrote:
> The result of multiplication between values derived from functions
> dir_buckets() and bucket_blocks() *could* technically reach
> 2^30 * 2^2 = 2^32.
> 
> While unlikely to happen, it is prudent to ensure that it will not
> lead to integer overflow. Thus, use mul_u32_u32() as it's more
> appropriate to mitigate the issue.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 3843154598a0 ("f2fs: introduce large directory support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

