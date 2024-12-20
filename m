Return-Path: <stable+bounces-105386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C52E9F8A1A
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 03:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E3E16B4B6
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EB17583;
	Fri, 20 Dec 2024 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hNEilVb/"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC9C139
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734661900; cv=none; b=J0OM9T0oFTll8Qbtkx6lqljB72+/4awQJU57qyIk4i+a37Oq10SyuV/eDQWLffuG4gaHjW7lH26Orwr/TDnOSIsWuwowcRJJ3Krk2htE/96+HOX3qGsK6gegEy/AUoM3Oz+PEkS82N0UU/LgVuov1hi3pccM2G1SJC8ZprZB8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734661900; c=relaxed/simple;
	bh=skIYNzG6AUQFvqnpBgycnviNkI5cHpEfWKEhXCmd02U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrhUa05a/NM1seySNQ6/tD68Duw/tTvNdWWjR8tQ1TPbAGugA6MwjwiNQezigxanKsox+WtNY0NX9C0ZOwTbMTDpm2pa4K0gyX0aeUXjGJ4N9+s5uYxwPHX5eEJyt8+eQw5fIcmHQ2BC0q986c6YpTVXmekkbB8FltsbMlVppj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hNEilVb/; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5fd25908-8c1d-4caf-ab6d-9e2c578515db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734661896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHH9blCLbbdRFm3g4acwlY7ei2GOyp4N/b4u5S7BEjE=;
	b=hNEilVb/92pGfyAN2kGGp0Fs+sGZiQtKW1vgMc7XaiY3WwdHB/OkILRAYxAo94L2PX8SOq
	Lq9IBTVgMS8v9ZALJ1lbmsGrrGHc0cC2ZIMapuxhT4rQiO+OerjpbUOkRlvAukRyLbnwtl
	sUT4bgBeCC8/FpbdLqI9BfCo/5nTvX4=
Date: Fri, 20 Dec 2024 10:31:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: zswap: fix race between [de]compression and CPU
 hotunplug
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Vitaly Wool <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>,
 Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241219212437.2714151-1-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20241219212437.2714151-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/12/20 05:24, Yosry Ahmed wrote:
> In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
> current CPU at the beginning of the operation is retrieved and used
> throughout. However, since neither preemption nor migration are
> disabled, it is possible that the operation continues on a different
> CPU.
> 
> If the original CPU is hotunplugged while the acomp_ctx is still in use,
> we run into a UAF bug as the resources attached to the acomp_ctx are
> freed during hotunplug in zswap_cpu_comp_dead().
> 
> The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
> use crypto_acomp API for hardware acceleration") when the switch to the
> crypto_acomp API was made. Prior to that, the per-CPU crypto_comp was
> retrieved using get_cpu_ptr() which disables preemption and makes sure
> the CPU cannot go away from under us. Preemption cannot be disabled with
> the crypto_acomp API as a sleepable context is needed.
> 
> Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> per-acomp_ctx") increased the UAF surface area by making the per-CPU
> buffers dynamic, adding yet another resource that can be freed from
> under zswap compression/decompression by CPU hotunplug.
> 
> There are a few ways to fix this:
> (a) Add a refcount for acomp_ctx.
> (b) Disable migration while using the per-CPU acomp_ctx.
> (c) Disable CPU hotunplug while using the per-CPU acomp_ctx by holding
> the CPUs read lock.
> 
> Implement (c) since it's simpler than (a), and (b) involves using
> migrate_disable() which is apparently undesired (see huge comment in
> include/linux/preempt.h).
> 
> Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
> Reported-by: Sam Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---

Good analysis and solution!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

