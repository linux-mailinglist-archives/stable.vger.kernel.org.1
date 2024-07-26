Return-Path: <stable+bounces-61855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A993D0AC
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 11:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D836F1C21391
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA47176AAC;
	Fri, 26 Jul 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtaaSgdx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8968219EA;
	Fri, 26 Jul 2024 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987791; cv=none; b=AtIhnhVykHLcl/GcTlF6POWPlgHPW9f/Bf497MptLTeRfDIzOqMvvKzkNHOpdQ2hpeNWRd2IUT6jtl/fjhA6cLsrPw6rOPI/xPBaJoZPxjabHmKlk/Wgeej/+nBGHabwN73H7rzP8Pzc7sSiUAxeW82ClmD/UxHKgW1wMZdXsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987791; c=relaxed/simple;
	bh=fhyq/g+G0TEX3v1BnRO3G8NSctBsT3B907kuzzS/knE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qh4zKygeyElET3wfcSXbzHApgbtO7llfjtWbpQ2gQ4xItPmK7iRug25oULvz0kzSTrDbXYuygLp5MxzR/1ajvTUly+imh8vk57w5U9UovHb3a4XxU57Cgw5zZm79jfV27uXrZmgiQg41rOkMu7HnCZHkxJwcoTr4kRk2NMJO4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtaaSgdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD58FC4AF07;
	Fri, 26 Jul 2024 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721987790;
	bh=fhyq/g+G0TEX3v1BnRO3G8NSctBsT3B907kuzzS/knE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YtaaSgdxYwvRUqPGGDe8gXs3l4Aa3M1Yoa+znwWiql7hZSnY7ML+5FncQHzDxr5PT
	 3uDLhSby+W7L4Zz1VQGarYZzyVXXcZFYpFBtWOeNhomW5GJ1hPGDSj7po63JN3cT12
	 1pgFXnSOjr+BcwIBNiGGJVcfDFLIMXARMobTTe7ZibNQdI2eh1z6jBu651tP2TI8Oq
	 JXI9oE56UiB21sa+HHKOnQeKTp5pmnzi1Ym0s7bqozTKq43WR/kwWIV9OOYvAPwoQn
	 gkwvFRldGXJlcQXaoCHno5PskOV+vinQiO6DKmX/Q7vcQrVMtErf6fjcLRKXKbJz+c
	 pJ+QlM7HNxtvQ==
Message-ID: <dcc063ac-3597-41a4-a10e-6f4e9585f96f@kernel.org>
Date: Fri, 26 Jul 2024 17:56:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix race in z_erofs_get_gbuf()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 Chunhai Guo <guochunhai@vivo.com>
References: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/22 11:51, Gao Xiang wrote:
> In z_erofs_get_gbuf(), the current task may be migrated to another
> CPU between `z_erofs_gbuf_id()` and `spin_lock(&gbuf->lock)`.
> 
> Therefore, z_erofs_put_gbuf() will trigger the following issue
> which was found by stress test:
> 
> <2>[772156.434168] kernel BUG at fs/erofs/zutil.c:58!
> ..
> <4>[772156.435007]
> <4>[772156.439237] CPU: 0 PID: 3078 Comm: stress Kdump: loaded Tainted: G            E      6.10.0-rc7+ #2
> <4>[772156.439239] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 1.0.0 01/01/2017
> <4>[772156.439241] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> <4>[772156.439243] pc : z_erofs_put_gbuf+0x64/0x70 [erofs]
> <4>[772156.439252] lr : z_erofs_lz4_decompress+0x600/0x6a0 [erofs]
> ..
> <6>[772156.445958] stress (3127): drop_caches: 1
> <4>[772156.446120] Call trace:
> <4>[772156.446121]  z_erofs_put_gbuf+0x64/0x70 [erofs]
> <4>[772156.446761]  z_erofs_lz4_decompress+0x600/0x6a0 [erofs]
> <4>[772156.446897]  z_erofs_decompress_queue+0x740/0xa10 [erofs]
> <4>[772156.447036]  z_erofs_runqueue+0x428/0x8c0 [erofs]
> <4>[772156.447160]  z_erofs_readahead+0x224/0x390 [erofs]
> ..
> 
> Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
> Cc: <stable@vger.kernel.org> # 6.10+
> Cc: Chunhai Guo <guochunhai@vivo.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

