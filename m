Return-Path: <stable+bounces-235414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L9JCPur12kMRQgAu9opvQ
	(envelope-from <stable+bounces-235414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 15:39:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 805833CB5EA
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7FE93093555
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B529B8CF;
	Thu,  9 Apr 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q2UtYV3t"
X-Original-To: stable@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574B28C009;
	Thu,  9 Apr 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740974; cv=none; b=oUnVH3F4E7K047Ixm9ft2mn7l+XyLOtRiFs5kW8IbsUx7jW2Khdm4U/WxGmlaD1fAkmckWQ5AYyZxIRJ4KX5Ju4if74sQIh3Yv6etArA9Xy2E7SFDr9Pfx79NBgMydiq9P9R/OFhb6IBIOjRVuwaNyWx4fdbdtZGSHJxgwSRwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740974; c=relaxed/simple;
	bh=PB+Rxv5czz1oKtiI33Qn7iABdca5wABfWXJa6EYKBj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TX5cm6y6v+P4NfRotnHgSi1zbqdY2WBiMLFlql/yZwlba1iIFJMeH9yGhf7A0oTwEXJGkJOyaJ5z1YtuOLGp0aN6YPczpc2eltpP6d8B79h9M8mO8aVt6L2yun3/Xo6zy79jzKRSzDcqEnpQ5DP8CTpwZy+8q8ggAxqrIGHJU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q2UtYV3t; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775740966; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1IJi7Kgt9MzT0qPxwcgishVD95LZU8u0hTGKrYKuTA0=;
	b=Q2UtYV3tkzXUI5OC8wdSMy+fExmBOFm1ldwTyhwWKZJXcHTPapvNzlDR2XE6ttIIvoQVbgqrVTKxMQPl3LNBQEb5uTN94S7b30x7H/lJvADa3P4Y8Olbwg3nb7Euv3CTRjYk5QTnCpSPXW8+DwKwwodEilmpU9bHLsEyS86w7oo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0iPoRL_1775740964;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0iPoRL_1775740964 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 21:22:45 +0800
Message-ID: <49dd4ae7-f703-4d39-8145-bf38f840b444@linux.alibaba.com>
Date: Thu, 9 Apr 2026 21:22:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
To: Junrui Luo <moonafterrain@outlook.com>, Gao Xiang <xiang@kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
References: <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235414-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 805833CB5EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Junrui,

On 2026/4/9 14:57, Junrui Luo wrote:
> In z_erofs_lz4_handle_overlap(), the index expression
> "rq->outpages - rq->inpages + i" is computed in unsigned arithmetic.
> If outpages < inpages, the subtraction wraps to a large value and
> the subsequent rq->out[] access reads past the decompressed_pages
> array.
> 
> z_erofs_map_sanity_check() does not enforce m_plen <= m_llen, so a
> crafted image declaring m_plen > m_llen can produce outpages < inpages.
> 
> The in-place branch is currently unreachable: it requires both
> partial_decoding == false and omargin > 0, but these are mutually
> exclusive. partial_decoding == false requires pcl->length == m_llen,
> which in turn requires (offset + end == m_la + m_llen) where
> offset + end is page-aligned from folio boundaries. This forces
> m_la + m_llen to be page-aligned, making oend page-aligned and
> omargin zero.
> 
> Nonetheless, guard the branch with an explicit outpages >= inpages
> check so the underflow cannot occur if future changes break this
> alignment invariant.
> 
> Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

After the second thinking, I think this patch is better for
easy stable backporting since other algorithms can already
handle such case (although we should return earilier in
z_erofs_map_sanity_check() formally), and I will submit a
follow-up patch to revise the related code, but it's not
for backporting.

How about refine the commit message as below:

==============

erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()

Some crafted images can have illegal (!partial_decoding &&
m_llen < m_plen) extents, and the LZ4 inplace decompression path
can be wrongly hit, but it cannot handle (outpages < inpages)
properly: "outpages - inpages" wraps to a large value and
the subsequent rq->out[] access reads past the decompressed_pages
array.

However, such crafted cases can correctly result in a corruption
report in the normal LZ4 non-inplace path.

Let's add an additional check to fix this for backporting.

Reproducible image (base64-encoded gzipped blob):

H4sIAJGR12kCA+3SPUoDQRgG4MkmkkZk8QRbRFIIi9hbpEjrHQI5ghfwCN5BLCzTGtLbBI+g
dilSJo1CnIm7GEXFxhT6PDDwfrs73/ywIQD/1ePD4r7Ou6ETsrq4mu7XcWfj++Pb58nJU/9i
PNtbjhan04/9GtX4qVYc814WDqt6FaX5s+ZwXXeq52lndT6IuVvlblytLMvh4Gzwaf90nsvz
2DF/21+20T/ldgp5s1jXRaN4t/8izsy/OUB6e/Qa79r+JwAAAAAAAL52vQVuGQAAAP6+my1w
ywAAAAAAAADwu14ATsEYtgBQAAA=

$ mount -t erofs -o cache_strategy=disabled foo.erofs /mnt
$ dd if=/mnt/data of=/dev/null bs=4096 count=1

Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

==============

Could you send a quick v2 for this so I can apply?

Thanks,
Gao Xiang

