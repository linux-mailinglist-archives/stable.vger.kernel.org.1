Return-Path: <stable+bounces-235374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMdCFfiF12mwPAgAu9opvQ
	(envelope-from <stable+bounces-235374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:56:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5133C9519
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37031300751A
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1593B6371;
	Thu,  9 Apr 2026 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t5HcD8Pr"
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9FB3AEF5D;
	Thu,  9 Apr 2026 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775732211; cv=none; b=qvH5LNOJnCeJX5gGLZEXf1KNI1/Ex/c94s8EUmHEFL48hPOapncuhXSGiqb7TGqtZ3X7rsVH1QCmsBdQno4aTrSBd5zWZCWGsnwrrsufkaZcEFTXKkcc+55/iCpNcYJIQHnzwgS6rVSvB4MOnRFASJ4nFg5/ZkdPJ1Qti4HTp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775732211; c=relaxed/simple;
	bh=PmdelLBzfNDIWV+33epjCwYgz4N6+4c8k8arY9A+8AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Foc5oM85LL2H9FIhueM1P6DbSzFnV/vcyYK3/XqUNkXyi1eRrGok/+gTChzw3y5+WgSXTyU+BwSjY/Jyyw/NBrdLqBGDsS3Fr5bBVIF27lpR5ixSHu7SIU1jUyvBGCGahwXjjKMrA26R1Dce68FCaNYvxQUAihky6/WM9Ps54Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t5HcD8Pr; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775732205; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CBfTM9xBob73GimIL4JdnF/RxealF87d/9oNo4Ik0D0=;
	b=t5HcD8PrlntzUQ+yrydDhH3m7NfCndiYzB+tq8r6WoZwItMUEjpokvPjlAbOpK3qmpclMTWBu8+UaWQRVWvnHIsZAwhP8Z7oReA5tg6j1yKFWJIFRwJn2AKJTwEUXxJYoBk9hrn53amzg2kViKuAA1a4nK6sv1mB53LynfLwGDc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0iBlhJ_1775732203;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0iBlhJ_1775732203 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 18:56:45 +0800
Message-ID: <f608d440-6d26-4dd9-b838-b5ad1e70541c@linux.alibaba.com>
Date: Thu, 9 Apr 2026 18:56:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
 <3F909329-EB34-4B5E-A26D-081D9031DE01@outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3F909329-EB34-4B5E-A26D-081D9031DE01@outlook.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235374-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: EA5133C9519
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/9 18:38, Junrui Luo wrote:
> Hi Gao Xiang,
> 
> Thank you for the review.
>   
> On Thu, Apr 09, 2026 at 03:28:21PM +0800, Gao Xiang wrote:
> 
>> For this kind of stuff, do you have a reproducer?
> 
> I constructed a crafted EROFS image declaring plen=8192 and i_size=4096, giving
> inpages=2 and outpages=1. Tested under QEMU with kernel (v7.0-rc6) plus a temporary
> pr_warn trace in z_erofs_lz4_handle_overlap():
> 
> [   12.889652] erofs: BOUNDARY CHECK: outpages=1 < inpages=2
> 
> The image mounts and the decompressor is reached with
> partial_decoding=false and outpages < inpages.
> 
>> I'm not sure what you're saying, but I don't think
>> you really understand the entire logic.
>>
>> `m_la + m_llen` should not be page-aligned for typical
>> erofs images, you can just mkfs.erofs -zlz4hc with some
>> file and check it yourself.
>>
>> BTW, I just check upstream, and the inplace branch
>> works prefectly.
> 
> During testing I observed that the inplace branch was not entered with
> my crafted image and incorrectly concluded it was structurally unreachable.
> I apologize for the incorrect analysis.
Can you share your initial crafted image binary
with `gzip -9 | base64` encoding here?

I think the proper place to fix this is in
z_erofs_map_sanity_check().

But we only accept patches with proper reproducible
ways (e.g. base64-encoded zipped images or syzbot
link).

Thanks,
Gao Xiang

