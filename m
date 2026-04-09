Return-Path: <stable+bounces-235422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKKiKGa212lURwgAu9opvQ
	(envelope-from <stable+bounces-235422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:23:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89A3CBF5D
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F8F300B3E5
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C65D3CCFA5;
	Thu,  9 Apr 2026 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v3Me7/Cn"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172AA37D137;
	Thu,  9 Apr 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744495; cv=none; b=dO849y8l0qGsq3CwBQBpynj6x9IKw+oQWw8uk2YsHIoXU63+DM/A2udmUGvyAfOdLAakgg9v0H+lbkVAJVaKPwW/0i11+KyCROa19AmyVKHSDMJ9CzreJzUuzts6RQYYWkw2akgD1ZPCO0Hq12uOo5HmUxCSHMzFrwkQUEzqICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744495; c=relaxed/simple;
	bh=TAhrCU1yS5iTWjB8mULVyAwL6hib3FysshaOPV+TjXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QT0kFTTRQuiD/kI9gFnRBnPJTWW6S864I2dgS5OPuume0lSRveF3Fq5Ivknpl51h+kjZYXWzEfd29N0zT9gsEdepKHldvGXOKikICHHu/yQFSRNxMJ6ifXvoczUw/NVCjyeFug1qRm/4fzR7AcPQ1o/Z5Ad3l0/gaMHiq21kbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v3Me7/Cn; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775744487; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aTxGI8l0r04nOEb3UC/ArkCWhXNCZAZID+kdMOdexuI=;
	b=v3Me7/CnsaHbaESZs+UpPOi12DZ/YhqsaJWR58z5UHfZAT+UN8t5IZJfoPo8xgr/7AlfVbHkQWxbdwAE2uqFYATqUAHPfNyU9VZX73lb8hnuQMalzNtidCqH8QuNrFo2U+/Urw4qwR0pWSn7QxcTPLJmiCweX9LdPGJcMam7uEE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0ibMHm_1775744485;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0ibMHm_1775744485 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 22:21:26 +0800
Message-ID: <d82bf7e2-a076-468f-89d1-754210c1e190@linux.alibaba.com>
Date: Thu, 9 Apr 2026 22:21:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
To: Junrui Luo <moonafterrain@outlook.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
References: <SYBPR01MB788118F7F3CBCD0B894B5460AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <SYBPR01MB788118F7F3CBCD0B894B5460AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-235422-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,linux.alibaba.com,google.com,huawei.com,vivo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,alibaba.com:email]
X-Rspamd-Queue-Id: 1D89A3CBF5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/9 21:59, Junrui Luo wrote:
> Some crafted images can have illegal (!partial_decoding &&
> m_llen < m_plen) extents, and the LZ4 inplace decompression path
> can be wrongly hit, but it cannot handle (outpages < inpages)
> properly: "outpages - inpages" wraps to a large value and
> the subsequent rq->out[] access reads past the decompressed_pages
> array.
> 
> However, such crafted cases can correctly result in a corruption
> report in the normal LZ4 non-inplace path.
> 
> Let's add an additional check to fix this for backporting.
> 
> Reproducible image (base64-encoded gzipped blob):
> 
> H4sIAJGR12kCA+3SPUoDQRgG4MkmkkZk8QRbRFIIi9hbpEjrHQI5ghfwCN5BLCzTGtLbBI+g
> dilSJo1CnIm7GEXFxhT6PDDwfrs73/ywIQD/1ePD4r7Ou6ETsrq4mu7XcWfj++Pb58nJU/9i
> PNtbjhan04/9GtX4qVYc814WDqt6FaX5s+ZwXXeq52lndT6IuVvlblytLMvh4Gzwaf90nsvz
> 2DF/21+20T/ldgp5s1jXRaN4t/8izsy/OUB6e/Qa79r+JwAAAAAAAL52vQVuGQAAAP6+my1w
> ywAAAAAAAADwu14ATsEYtgBQAAA=
> 
> $ mount -t erofs -o cache_strategy=disabled foo.erofs /mnt
> $ dd if=/mnt/data of=/dev/null bs=4096 count=1
> 
> Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Thanks for catching this:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang


