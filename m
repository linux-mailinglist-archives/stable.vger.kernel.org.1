Return-Path: <stable+bounces-227904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MjQOP7xwGkUOwQAu9opvQ
	(envelope-from <stable+bounces-227904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:55:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBDD2EDEBA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 085563004D34
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B303E36998B;
	Mon, 23 Mar 2026 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ycjfbneb"
X-Original-To: stable@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF504365A07;
	Mon, 23 Mar 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252533; cv=none; b=Pw164N8aVQkV9lcD0E/8qAzAMh/ehDECfPvvtLLtxZND8S5jrMH6ppimQNeGs460io1SA41YXxwNbTG0VUbU4zbU12OHiSDbb2wtwmQx1+kv0sn7Lw9emB730TTgaoqBhQhMtUxgmQVBitErNTxf/muoCVTacsVa43rw1zrcdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252533; c=relaxed/simple;
	bh=TTHo8jrPrlCmbmIyrYd6pXhgJGBq5VZzmriJqjg7z1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpiauaLqoGpFliBm6Oz4fRxQYk/tLIhjial2Inzv6cwMGE+/OSGFERNjj3Ep9oK1thbAHTmWWhqNmAZQb5aPntNVZXW4/lJMxJpsvBZ9AhZ5iyfKbXVaxVMfbml8+Y9F/k3nc17s0jwjQjI63N1lo5nVqNoj8jf3GH8crDsIk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ycjfbneb; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774252521; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ln27PU6iTQhPj8tFQuQHGkfOiUwIVWgP9XLp448zqaw=;
	b=ycjfbnebbd0ZD696QJhFXrqkxQqYQ+DDwsX6y++TU+jqxdvCXYo2rx/CWJOw8thQxEAdoZgPQArih6g0EQeWdjX/zNCkY1fZxfQaubYPBIFLhQSYvqNFyDkBjX2jDSOGOvGt76LCLdyEIYwwXwUnsrzF87a9px4PKVjF2rSlhV4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X.UhD8J_1774252520;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.UhD8J_1774252520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 15:55:21 +0800
Message-ID: <a53e8e57-c54e-4fdd-8738-7e423e6ca37b@linux.alibaba.com>
Date: Mon, 23 Mar 2026 15:55:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0/1] erofs: Fix the slab-out-of-bounds in
 drop_buffers()
To: Denis Arefev <arefev@swemel.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20260323074809.4542-1-arefev@swemel.ru>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260323074809.4542-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227904-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 8FBDD2EDEBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Denis,

On 2026/3/23 15:48, Denis Arefev wrote:
> Syzbot reported that a KASAN slab-out-of-bounds bug was discovered in the drop_buffers()
> function [1].
> 
> The root cause is that erofs_raw_access_aops does not define .release_folio and
> .invalidate_folio. When using iomap-based operations, folio->private may contain
> iomap-specific data rather than buffer_heads. Without special handlers, the kernel
> may fall back to generic functions (e.g., drop_buffers), which incorrectly treat
> folio->private as a list of buffer_head structures, leading to incorrect memory
> interpretation and out-of-bounds access.
> 
> This can be fixed by explicitly setting .release_folio and .invalidate_folio to
> iomap_release_folio and iomap_invalidate_folio, respectively, but there is a
> commit ce529cc25b184e93397b94a8a322128fc0095cbb in upstream  that implicitly
> fixes this bug.

See my previous reply to the patch.

Thanks,
Gao Xiang

> 
> Please commit it to the stable branch v6.1.y .
> 
> [1] https://syzkaller.appspot.com/bug?id=c6aeabd0c4ad2466f63a274faf2a123103f8fbf7
> 
> Jingbo Xu (1):
>    erofs: enable large folios for iomap mode
> 
>   fs/erofs/data.c  | 2 ++
>   fs/erofs/inode.c | 2 ++
>   2 files changed, 4 insertions(+)
> 


