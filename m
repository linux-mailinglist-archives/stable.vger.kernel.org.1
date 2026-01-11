Return-Path: <stable+bounces-208025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE1AD0FA26
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 20:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CC853012C48
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4347434C820;
	Sun, 11 Jan 2026 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRq/z4mE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E51EDA3C
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159326; cv=none; b=fCTFSavJDXed2Mt8RAw1xog58DGujJqwV3HOOD1zeMlC5A4bkK6maHkVN0rEjOT7Oy3hwCT4oLARXO7327zStD9gIazUkUU0Om04SNMOLxAruhKjTSz9cYuUjwqrJtISY1q9IAtIsiunp83p9bnF1wEdZ/E52HCxH8ZUg5lWWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159326; c=relaxed/simple;
	bh=t7Fi0K92BEMxoSm0DNOFEU+HP9unM116ztTFN/5Z21A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOpBpLaSIWmg8GWfyIfsOx40rU1uB1/DB1Z0LTKapGsyMpUy5vBXxya6VdztfZ0xu8mQZgYHOOU2zUCUM595mpc6H9MQoUATdzCTwIav4kx+fIpzr35FFla/ZsRJ0weI5qMG8ZihU1wKFQkbothOeK+5oMKtUS3gttvrtWZjVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRq/z4mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D42C116C6;
	Sun, 11 Jan 2026 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768159325;
	bh=t7Fi0K92BEMxoSm0DNOFEU+HP9unM116ztTFN/5Z21A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dRq/z4mETgXEv0fT84i6ip0Qv4DQSky3rzT696ygTOeOYBfAe4/4ffRPIqk9N+8IZ
	 SqAbfrjxmJ6+ccTkT1IAJcXtjS8rOJMWnzWcsUa4fMwSiDNnBJn3lmgLVcWnbaY9KO
	 qmT4ntSo4V0xfyVgwFeoO1mt3j8UytzMAdnFwSB4ZPHMtxsfr2GZLnBWJla9BrdVeO
	 peKtZmKp+48H/kKh8zg5//ljmoatH7C61PnpWdQs7QmHBD2I1ew7arNG5MDd1lzTY1
	 jFLD3RrA17HXt3Zeyxua1FbLslyjXM6tTTyFBbBCRz1TF9wzE9j9vF6F8hgX+VmjVU
	 KPnLqiMt6UasA==
Message-ID: <b228e697-1907-40da-ac58-afc0c1f51d16@kernel.org>
Date: Sun, 11 Jan 2026 13:22:02 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SRU][Q][PATCH 2/2] drm/amdkfd: Export the cwsr_size and
 ctl_stack_size to userspace
To: Greg KH <gregkh@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: kernel-team@lists.ubuntu.com, Kent Russell <kent.russell@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20260111184001.23241-1-mario.limonciello@amd.com>
 <20260111184001.23241-3-mario.limonciello@amd.com> <2026011115--624e@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2026011115--624e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/26 12:51 PM, Greg KH wrote:
> On Sun, Jan 11, 2026 at 12:40:01PM -0600, Mario Limonciello wrote:
>> This is important for userspace to avoid hardcoding VGPR size.
>>
>> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2134491
>> Reviewed-by: Kent Russell <kent.russell@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> (cherry picked from commit 71776e0965f9f730af19c5f548827f2a7c91f5a8)
>> Cc: stable@vger.kernel.org
>> (cherry picked from commit 8fc2796dea6f1210e1a01573961d5836a7ce531e)
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> What stable kernel(s) is this supposed to be applied to?
> 
> thanks,
> 
> greg k-h

Actually this is already applied to stable kernels.

I was sending this separately to Ubuntu because ROCm on Ubuntu needs it 
and the kernel in Ubuntu is EOL upstream.

I forgot to use --suppress-cc=body and the original commit had a @stable 
tag.

Sorry about the noise!

