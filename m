Return-Path: <stable+bounces-180982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A4B91FF5
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB2A3A869D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F012E8B72;
	Mon, 22 Sep 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WjH5A3gT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650A2EA731;
	Mon, 22 Sep 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555608; cv=none; b=cfHyi+ml0hUcG32aCyLBh0OuQym84tBXkSPzzpYR2dIYd+25lnIKVwh+aJSvRF2+9EibgiON0ODds8y6yzmjEhw3B8pdhJP+NcxPVpfT7r2fJUgz+MR22hqVu0DecdobCpDnCYoT0E0h3H0q0ZA1HZzmjG3c7TX7mwIoMBO0aRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555608; c=relaxed/simple;
	bh=PZ1kMf+7vAyT7H+4UuB5PxqYsoANEJ1LL/IEn5lyBYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYBgyy10f+tixnTDRbM7vs62wjIKLRZotWVVmDyjXJrVK2/QvfbYddFQn9WVVnfHxfZiV6qda9rw/zJEc905YUhvqa8Jdx9BeF9ssjRh06w6hzu9v8UEr6rZGrN6FA0t9Ucm9qzMOZ5o1fIs2L6bwX1SiDLBMGVl9s59IHh9g4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WjH5A3gT; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 0ictvBDlTbkOW0ictvpHmD; Mon, 22 Sep 2025 17:38:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1758555533;
	bh=V2p0dOk8nY38bVB5z/4E1OBvSqe8R/NqMBDLVbvEpuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=WjH5A3gTeEuFhNiV/B2GK5o5zo4aJPBHMJZKCSJn88Z3vjHhHunVXfNgG7ne+JHhj
	 dkWTWzVNM1MtalryFtHg8wJ5Bf7KUg9JyG5pBUjZACfRTLNcjhtbxYLmX1dCURrXDW
	 lGJoQGlN15G80bkx/vwTIjR5kr6SREILz+4jJV0++xF+dmFjE+8ynWpd6DQnVRKQAc
	 T0MGwJxpyrtN1MSS6OC1NCIuJLs2ll5vpYgrNBo9uYTk7vAG11n7cQiWiGNCEl2i03
	 gfcmed8rR5wu8eDBzhta+pMOub0lNqEfIPoBINJl8BB2q3HR/5XnVWP8gCW6sHGnwx
	 rHRjAoAIALE9Q==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 22 Sep 2025 17:38:53 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <a7453bdc-16f3-43e6-a06d-bd6144eeae72@wanadoo.fr>
Date: Mon, 22 Sep 2025 17:38:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/smp: Add check for kcalloc() failure in
 parse_thread_groups()
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250922151025.1821411-1-lgs201920130244@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250922151025.1821411-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/09/2025 à 17:10, Guangshuo Li a écrit :
> As kcalloc() may fail, check its return value to avoid a NULL pointer
> dereference when passing it to of_property_read_u32_array().
> 
> Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
> Cc: stable@vger.kernel.org

Signed-off-by that was part of v1, is missing in v2.

> ---
> changelog:
> v2:
> - Return -ENOMEM directly on allocation failure.

Except for a newline that is removed, v2 is the same as v1, or I miss 
something?

CJ

> 
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   arch/powerpc/kernel/smp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 5ac7084eebc0..cfccb9389760 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node *dn,
>   
>   	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
>   	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
> +	if (!thread_group_array)
> +		return -ENOMEM;
>   	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
>   					 thread_group_array, count);
>   	if (ret)


