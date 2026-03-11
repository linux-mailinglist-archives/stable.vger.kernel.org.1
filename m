Return-Path: <stable+bounces-224653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMSoFnsnsWkBrgIAu9opvQ
	(envelope-from <stable+bounces-224653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:27:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C754C25F3F4
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 317FA30C9DC7
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227835A381;
	Wed, 11 Mar 2026 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yiu9aa/n"
X-Original-To: stable@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C23BAD99
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217165; cv=none; b=p1Yy4TLUiOj8O9O2LEKBcaHYCpzDFGO+hOUDvLq26IqoqUJySiGGjFhL8RqR0RCfCtqayrRwGp82IVqxhD6/GkFbtqfh3uEq9UhXDnEhoELDmhWWZTLVt3VFoWSV3UsnDRWQflMVIquEf+9K5Hq5NMAT/FpUPKfQiWHsdKxhJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217165; c=relaxed/simple;
	bh=Vk5PP1+s95S6LvcYMft1n7h21kIjbbW9VGBohfTXnBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGD6X/aOOzYLLlC43mXDeG2oQVUVRkkVG0dL5zjVB2A1grXHVAq/AW7BsFsdGvoN2tX0Z0uyDh3AvkMPq9XtUpXy3EC5lamPyVOyJ3X/OTdiNhCNMRvdTRRLKwdzAmVmb8Y05tZXl63vtcho0tLIBJJ1cg04yAG6xtxB0FAcUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yiu9aa/n; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773217159; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JTxTDVVq0upaxuI0ouj/OP39FpslhCyMw1g3MsypxGU=;
	b=yiu9aa/nU3aWiF4B/lrwsTRk8xKOHgxUTKmKBr/Ey6sg8kGld643vRnzfhZpv6HjcnZ4EHQEs4GEx0FfNYYP0ApWIPVYwgz5baoCdr3rSjS+LbZbXKV7cxF5ed0s35pgIE8knBcfvjD2dIq2N62ISU5N6qk4yAQfKYmsEYUOAek=
Received: from 30.221.132.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-jMXHR_1773217158 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 16:19:18 +0800
Message-ID: <2e5c6004-af37-4483-aa3a-fac0e10fcb6a@linux.alibaba.com>
Date: Wed, 11 Mar 2026 16:19:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y v2] erofs: fix inline data read failure for
 ztailpacking pclusters
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com,
 linux-erofs@lists.ozlabs.org
References: <1773216869-2760-1-git-send-email-zhiguo.niu@unisoc.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1773216869-2760-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C754C25F3F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,unisoc.com,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224653-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,unisoc.com:email]
X-Rspamd-Action: no action



On 2026/3/11 16:14, Zhiguo Niu wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> [ Upstream commit c134a40f86efb8d6b5a949ef70e06d5752209be5 ]
> 
> Compressed folios for ztailpacking pclusters must be valid before adding
> these pclusters to I/O chains. Otherwise, z_erofs_decompress_pcluster()
> may assume they are already valid and then trigger a NULL pointer
> dereference.
> 
> It is somewhat hard to reproduce because the inline data is in the same
> block as the tail of the compressed indexes, which are usually read just
> before. However, it may still happen if a fatal signal arrives while
> read_mapping_folio() is running, as shown below:
> 
>   erofs: (device dm-1): z_erofs_pcluster_begin: failed to get inline data -4
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> 
>   ...
> 
>   pc : z_erofs_decompress_queue+0x4c8/0xa14
>   lr : z_erofs_decompress_queue+0x160/0xa14
>   sp : ffffffc08b3eb3a0
>   x29: ffffffc08b3eb570 x28: ffffffc08b3eb418 x27: 0000000000001000
>   x26: ffffff8086ebdbb8 x25: ffffff8086ebdbb8 x24: 0000000000000001
>   x23: 0000000000000008 x22: 00000000fffffffb x21: dead000000000700
>   x20: 00000000000015e7 x19: ffffff808babb400 x18: ffffffc089edc098
>   x17: 00000000c006287d x16: 00000000c006287d x15: 0000000000000004
>   x14: ffffff80ba8f8000 x13: 0000000000000004 x12: 00000006589a77c9
>   x11: 0000000000000015 x10: 0000000000000000 x9 : 0000000000000000
>   x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
>   x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
>   x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
>   Call trace:
>    z_erofs_decompress_queue+0x4c8/0xa14
>    z_erofs_runqueue+0x908/0x97c
>    z_erofs_read_folio+0x128/0x228
>    filemap_read_folio+0x68/0x128
>    filemap_get_pages+0x44c/0x8b4
>    filemap_read+0x12c/0x5b8
>    generic_file_read_iter+0x4c/0x15c
>    do_iter_readv_writev+0x188/0x1e0
>    vfs_iter_read+0xac/0x1a4
>    backing_file_read_iter+0x170/0x34c
>    ovl_read_iter+0xf0/0x140
>    vfs_read+0x28c/0x344
>    ksys_read+0x80/0xf0
>    __arm64_sys_read+0x24/0x34
>    invoke_syscall+0x60/0x114
>    el0_svc_common+0x88/0xe4
>    do_el0_svc+0x24/0x30
>    el0_svc+0x40/0xa8
>    el0t_64_sync_handler+0x70/0xbc
>    el0t_64_sync+0x1bc/0x1c0
> 
> Fix this by reading the inline data before allocating and adding
> the pclusters to the I/O chains.
> 
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Reviewed-and-tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

