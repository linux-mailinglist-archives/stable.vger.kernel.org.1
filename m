Return-Path: <stable+bounces-119821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B73A47972
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 10:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8961C3B25F1
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC922655B;
	Thu, 27 Feb 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QGQOAmta"
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03137227EBF
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740649216; cv=none; b=iXGCTVcoCaJURPGm3YFhegxQ7uLjQUEW1yHXlnnYfEAGuoYqLOHVhzf+IRzs6jtuZQ+S6pDBzowe2Z7hyb09TM0tQOQPKZWdiKIZXpNrgxUibN5YEnf6Li60LHp81xov/e2lOY+OMJGnlwu1SNT6zN5toQ600MzVFa0C3RV9mZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740649216; c=relaxed/simple;
	bh=EEXIRx6reIB0eQTcIZZ/5RTO9C7ruM7nE+KfhaCS6jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vt6pEcnJcFTSR8MbEh1n+AKLYgKQOKG2ifwXX4RREdrt2qnvhfsPqEmB1oRAqgUjhA1Hb65DLgnhb0F62e+lmayu6vYzZl5UNjkwT7ChP2E+iJ/5jr0+nTw1C8NNC6oob9DS0QaCahX9nUhO/ikeueMvZY0wSSA6MUjObbCRaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QGQOAmta; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740649204; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=j9ZR+GBvrG/gafVcZuHcfzZzaTrIy3pXM8NhiHSvvgY=;
	b=QGQOAmtaxfjfymuAd5RMnZHqn8IVxVq+aZg1A169ENR0N5Aeli5Hmhme2poVTYpKzMFsoo9snCoMWQIeNr/1Bi2Ynj1vhEOeyJAImuM6FnJ9ayPrb6nu5Lx5rGPpEMtW5M2gYMxbSlbMONeZjkwX3SWr0btqzLuBedvMQv/FEts=
Received: from 30.74.130.95(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WQLwyRm_1740649203 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Feb 2025 17:40:04 +0800
Message-ID: <445cf95d-b695-4e8d-b4ba-6ca0c12b1c52@linux.alibaba.com>
Date: Thu, 27 Feb 2025 17:40:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.6 238/676] bpf, sockmap: Several fixes to
 bpf_msg_pop_data
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: patches@lists.linux.dev, Zijian Zhang <zijianzhang@bytedance.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Sasha Levin <sashal@kernel.org>,
 stable@vger.kernel.org, Levi Zim <rsworktech@outlook.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20241206143653.344873888@linuxfoundation.org>
 <20241206143702.627526560@linuxfoundation.org>
Content-Language: en-US
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20241206143702.627526560@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/6/24 10:30 PM, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> [ Upstream commit 5d609ba262475db450ba69b8e8a557bd768ac07a ]
> 
> Several fixes to bpf_msg_pop_data,
> 1. In sk_msg_shift_left, we should put_page
> 2. if (len == 0), return early is better
> 3. pop the entire sk_msg (last == msg->sg.size) should be supported
> 4. Fix for the value of variable "a"
> 5. In sk_msg_shift_left, after shifting, i has already pointed to the next
> element. Addtional sk_msg_iter_var_next may result in BUG.
> 
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Link: https://lore.kernel.org/r/20241106222520.527076-8-zijianzhang@bytedance.com
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

We found the kernel crashed when running kselftests (bpf/test_sockmap) in 
kernel 6.6 LTS, which is introduced by this commit. I guess all other 
stable kernels (containing this commit) are also affected.

Please consider backporting the following 2 commits:
fdf478d236dc ("skmsg: Return copied bytes in sk_msg_memcopy_from_iter")
5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")

Thanks.

