Return-Path: <stable+bounces-128318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E59AA7BE18
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324AC177A18
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069461F03CD;
	Fri,  4 Apr 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uugS4K5E"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAB1EF0B4
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774055; cv=none; b=X85u42yb9natHIDAsW825hAF7NzUNDHydwPUjtdHvILWDYu0Rr22kA3wGOGTuQYSeYE/6HpMTTQuejHZ+Ay35rW6uWlSUwLElDU4YQ0s1o2UDObSrBjLlX77J0eV9wnfp+PlBtLBgpo0pBF8QBzLu7sMIScEhOutZ2Ubdr99nnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774055; c=relaxed/simple;
	bh=xANPefLqpcEQYBRE/NCV46oK1I/FrELUp3mVZEO+8co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKqmw0yGG8rr0+e5QMVUiB3Y+kKO7NI38IQVI3aO9ByjEe4jJbeoQDJP334soYF+6g+8ZGK/6QSkB8MP50xxXareKOK2g7kS8C9f7aSeRsU/yJt/1aWL1OcVAuXoasV0FYhr/yTKp3t9hYN2dri0F8LKkHBn8jpPvaDhfiyH8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uugS4K5E; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3291d0f9-40af-4e8d-aa08-b84132caf03d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743774041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WVYyYy47dRxRDE2y37KU6fRW5bT0lNVCJKYGaAjgBU=;
	b=uugS4K5EShcKvWJc+VGSsPwIPg4rMNQLThsiZLoVA7gjw0RdwfgRWXqG6XuvXjkc9V/UUy
	RPUEIM2kTvgk4rN/casblXmUQq6t/61LXHyHRG6aBGqKIqLOJ9uq3bqDk3NR7Z5JG9p2Kc
	bJVJUBEhVk3rq/XVylmp7GbTJX/Qz9k=
Date: Fri, 4 Apr 2025 15:40:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5.4.y] RDMA/srpt: Support specifying the srpt_service_guid
 parameter
To: Alok Tiwari <alok.a.tiwari@oracle.com>, bvanassche@acm.org,
 dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 target-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 darren.kenny@oracle.com
References: <20250403125955.2553106-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250403125955.2553106-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03.04.25 14:59, Alok Tiwari wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> [ Upstream commit fdfa083549de5d50ebf7f6811f33757781e838c0 ]
> 
> Make loading ib_srpt with this parameter set work. The current behavior is
> that setting that parameter while loading the ib_srpt kernel module
> triggers the following kernel crash:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> Call Trace:
>   <TASK>
>   parse_one+0x18c/0x1d0
>   parse_args+0xe1/0x230
>   load_module+0x8de/0xa60
>   init_module_from_file+0x8b/0xd0
>   idempotent_init_module+0x181/0x240
>   __x64_sys_finit_module+0x5a/0xb0
>   do_syscall_64+0x5f/0xe0
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Cc: LiHonggang <honggangli@163.com>
> Reported-by: LiHonggang <honggangli@163.com>
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Link: https://lore.kernel.org/r/20240205004207.17031-1-bvanassche@acm.org
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [Alok: Backport to 5.4.y since the commit has already been backported to
> 5.15y, 5.10.y, and 4.19.y]
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Not sure if this "Cc: stable@vger.kernel.org" is needed to notify the 
engineer of stable branch or not.

Zhu Yanjun

> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index d03a4f2e006f..f5fd8c1058ce 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -79,12 +79,16 @@ module_param(srpt_srq_size, int, 0444);
>   MODULE_PARM_DESC(srpt_srq_size,
>   		 "Shared receive queue (SRQ) size.");
>   
> +static int srpt_set_u64_x(const char *buffer, const struct kernel_param *kp)
> +{
> +	return kstrtou64(buffer, 16, (u64 *)kp->arg);
> +}
>   static int srpt_get_u64_x(char *buffer, const struct kernel_param *kp)
>   {
>   	return sprintf(buffer, "0x%016llx", *(u64 *)kp->arg);
>   }
> -module_param_call(srpt_service_guid, NULL, srpt_get_u64_x, &srpt_service_guid,
> -		  0444);
> +module_param_call(srpt_service_guid, srpt_set_u64_x, srpt_get_u64_x,
> +		  &srpt_service_guid, 0444);
>   MODULE_PARM_DESC(srpt_service_guid,
>   		 "Using this value for ioc_guid, id_ext, and cm_listen_id instead of using the node_guid of the first HCA.");
>   


