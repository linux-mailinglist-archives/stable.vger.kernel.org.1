Return-Path: <stable+bounces-227921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJCbDqwCwWlUPgQAu9opvQ
	(envelope-from <stable+bounces-227921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:06:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB4E2EEACC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 514B4305B2A5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC383845A7;
	Mon, 23 Mar 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BNIKejrC"
X-Original-To: stable@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF143382F16;
	Mon, 23 Mar 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256349; cv=none; b=QWTfgpmXNtOdFsFg2XCmm1QXlACex4fv+pY6XJTtnBIVmEj+PtbxzxidbveAsg5mngUYK1R64gYb5WPuiDTfcrroulG9xi75sfcv5ACM4sbHVxn1O0HHXWDwThAAV6YunDGJhqSPAkj51iJAPrA+4NRxLhp3zh1Yn8R4tcXH5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256349; c=relaxed/simple;
	bh=Z8IX14CqrJWdkP7g/80eSXyQQmwburzWRHA9aEW3PG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7SL74dN/vAgbWEoMZcTlqXurhqStEUqE2V8Kku8ex2O//D4wMSn7YrsYwj0aFZIG8mStfMb3CG73SicVH3HscKyq93B4inEKFQ06xXB0mFqPfFyaYk9palAMneBRO2jQqpJYXnuPL1KewqMtOfzlvFpnZFrPVB9ztwOLGegAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BNIKejrC; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774256339; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H6naz5viM7Xu+VTy8JB833V7Y7xXzzJWGleVlAWy85U=;
	b=BNIKejrCJqSfwM2RNH2F1+bWX+hmprReusoqiVuWcrS0nDeAb+X+Xp3/aAeNsvZIsGJWhYA3cguwgCo2jDs4rxd39P9a5BNh0l9AcEzxKNu+OOFUbZNN/TicL3lntrL8/UPCOEVWk+yC76Zg/ozTn1oMuWJS8SXE1HXHcBktgx0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X.VeY6Q_1774256338;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.VeY6Q_1774256338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 16:58:58 +0800
Message-ID: <8ac4cd88-3460-4a34-ad11-45f9d4f27a69@linux.alibaba.com>
Date: Mon, 23 Mar 2026 16:58:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1] erofs: Fix the slab-out-of-bounds in drop_buffers()
To: Denis Arefev <arefev@swemel.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com
References: <20260323085216.7965-1-arefev@swemel.ru>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260323085216.7965-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227921-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,5b886a2e03529dbcef81];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,swemel.ru:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 8EB4E2EEACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/23 16:52, Denis Arefev wrote:
> No upstream commit exists for this patch.

That is also strange, since people would ask why not submiting a patch
upstream, I think you still need to mention the upstream commit

ce529cc25b184e93397b94a8a322128fc0095cbb
("erofs: enable large folios for iomap mode").

also see another commit in linux 6.1 branch:
1ce9ebc96eda ("erofs: ensure that the post-EOF tails are all zeroed").

Thanks,
Gao Xiang

> 
> Syzbot reported that a KASAN slab-out-of-bounds bug was discovered in
> the drop_buffers() function [1].
> 
> The root cause is that erofs_raw_access_aops does not define .release_folio
> and .invalidate_folio. When using iomap-based operations, folio->private
> may contain iomap-specific data rather than buffer_heads. Without special
> handlers, the kernel may fall back to generic functions (such as
> drop_buffers), which incorrectly treat folio->private as a list of
> buffer_head structures, leading to incorrect memory interpretation and
> out-of-bounds access.
> 
> Fix this by explicitly setting .release_folio and .invalidate_folio to the
> values of iomap_release_folio and iomap_invalidate_folio, respectively.
> 
> [1] https://syzkaller.appspot.com/x/report.txt?x=12e5a142580000
> 
> Fixes: 7479c505b4ab ("fs: Convert iomap_readpage to iomap_read_folio")
> Reported-by: syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=c6aeabd0c4ad2466f63a274faf2a123103f8fbf7
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>   fs/erofs/data.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 7b648bec61fd..302e824827fc 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -406,6 +406,8 @@ const struct address_space_operations erofs_raw_access_aops = {
>   	.readahead = erofs_readahead,
>   	.bmap = erofs_bmap,
>   	.direct_IO = noop_direct_IO,
> +	.release_folio = iomap_release_folio,
> +	.invalidate_folio = iomap_invalidate_folio,
>   };
>   
>   #ifdef CONFIG_FS_DAX


