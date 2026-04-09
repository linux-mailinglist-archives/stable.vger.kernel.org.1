Return-Path: <stable+bounces-235403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMt+IsmY12lNQAgAu9opvQ
	(envelope-from <stable+bounces-235403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:17:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CCE3CA48B
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB0B3300D17B
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AAE36BCDA;
	Thu,  9 Apr 2026 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eP1+KH5j"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02293019A9;
	Thu,  9 Apr 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736899; cv=none; b=QKI0DO97mi3UFzDZZY4qE2bMLha8tzWxYN/s06YccPl+4kap8u+41EK7Y0Ga0V0p9p2K3UKNFrKD2+74YsE+8X8euJ8i948ThRrUqx1Pjxvu42c5X/4XQQNHFegs1iqwmhLYFA0dzP5MYSd6AoiP2cotUwkHAiy62Rx4U54EaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736899; c=relaxed/simple;
	bh=SWg8DKhVcl43so8mnnHDhT+ciypgKIMxPg31VgMQprg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZH/250VjRUiXcKism5wWGfqxllxCkNtPgSfTATUJPYuFLbyvQuvJrXmszw4r2ZpR/Cg4rbYbEBXEAkCdg2Zf79e89iiJeBIKD1V+VfUIs+DJ8k4GJWPoXKOPZarkYiXwbA5YPdKajcd9At7ny9jM154PZFTNdSssiHs32ZMzbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eP1+KH5j; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775736891; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QsBZlsOs/aPVR09Nx2+/RG2UPFE2Ga7fdOknV0byQxw=;
	b=eP1+KH5jV31zS+eSbnzS4RcnTGeqTp2oqQvq1pf5h0KSLwBPhtZ+yS17tLnrMTbMmK6pemwo9ivibSNQKS5Nya57GhcJC2v6i9Ug0AiOh1va1qE7SkpIi7e6LRY17wCWmJ9e+iIOvN3aKWzOjSWu6Wy6NsO38PC6dCy3pUD7R6A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0iI0If_1775736888;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0iI0If_1775736888 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 20:14:50 +0800
Message-ID: <17f2ec58-e8ec-4f59-9e8f-0e88bde7d98b@linux.alibaba.com>
Date: Thu, 9 Apr 2026 20:14:46 +0800
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
 <f608d440-6d26-4dd9-b838-b5ad1e70541c@linux.alibaba.com>
 <1922A494-0E56-4E11-9D3E-3604BCBE33AD@outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1922A494-0E56-4E11-9D3E-3604BCBE33AD@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235403-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 04CCE3CA48B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/9 19:49, Junrui Luo wrote:
> On Thu, Apr 09, 2026 at 06:56:42PM +0800, Gao Xiang wrote:
>> Can you share your initial crafted image binary
>> with `gzip -9 | base64` encoding here?
> 
> $ gzip -9 < /tmp/erofs-test/test.erofs | base64
> H4sIAJGR12kCA+3SPUoDQRgG4MkmkkZk8QRbRFIIi9hbpEjrHQI5ghfwCN5BLCzTGtLbBI+gdilS
> Jo1CnIm7GEXFxhT6PDDwfrs73/ywIQD/1ePD4r7Ou6ETsrq4mu7XcWfj++Pb58nJU/9iPNtbjhan
> 04/9GtX4qVYc814WDqt6FaX5s+ZwXXeq52lndT6IuVvlblytLMvh4Gzwaf90nsvz2DF/21+20T/l
> dgp5s1jXRaN4t/8izsy/OUB6e/Qa79r+JwAAAAAAAL52vQVuGQAAAP6+my1wywAAAAAAAADwu14A
> TsEYtgBQAAA=
> 
> In QEMU:
> $ mount -t erofs -o cache_strategy=disabled test.erofs /mnt
> $ dd if=/mnt/data of=/dev/null bs=4096 count=1
> 
>> I think the proper place to fix this is in
>> z_erofs_map_sanity_check().
>   
> I will resend with the check in
> z_erofs_map_sanity_check() instead if the reproducer is acceptable.

It's not a very trivial fix without having some more
understanding of EROFS compression codebase, I will
add your `Repored-by:` and try to tidy up the related
code.

Thanks,
Gao Xiang

> 
> Thanks,
> Junrui Luo


