Return-Path: <stable+bounces-241272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL2PF7cp72lE8AAAu9opvQ
	(envelope-from <stable+bounces-241272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:17:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D42C046FB87
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BB33301024B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8868C3B0AF8;
	Mon, 27 Apr 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2WpVS3ko"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841BF39A058;
	Mon, 27 Apr 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281221; cv=none; b=Suy8Odx4EQq9dLBMkI6lvkJ858OcVPZqqlCnR0GK4VEH4oOGwTmUhD590ubgITp3EBarcRjDJVWxRsluq0wbJtMQ/BYj/lBAiYc/J9MXLCs16qy13/UCFWc07hExw8qc/R4c5ahFuvhSdl/0GJA8b5nNd20/UO/7wmuPVkdGTSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281221; c=relaxed/simple;
	bh=0ha8yBEvs42W28gD9yr4WPPWo6TisTzNZCWX5YgqU/Q=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=daVKDEw9Fz2Bh4Zhqy5VMSbothfFsUqraYGSPnNS6dkUi8i8io2nu2/825RCdXUpDjWd9ekpQwpeAWlluwR3cwUKqcNZXfMx9hYPsJJBw9V4FN+I+eH4LBhRfwWOgD/BUge8cE1re54QIPG6dL38Yc+t7dzcXlkJgZgVRHeA8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2WpVS3ko; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zmRjeX6dNGOmmOZ8y2g2riqMomZtnDChlOtrdiwKxyA=;
	b=2WpVS3kovfqkUg90WSAUnAPn7LuxSDyzTmtBZOzDWGZz5QJ7rF6G/1xhcl7HwcNENtuH0fmpe
	+zYUcaoLqGaMQIJ2WU2b2maEofBnlG2xr6WWKADTl4L8Rfc99FmqSniEjel140NpxbdUlcRPo5i
	Opcc3WmEjCy3zoCKUZpuLGE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4g3yNz69cSzcb0l;
	Mon, 27 Apr 2026 17:06:43 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D3B954056D;
	Mon, 27 Apr 2026 17:13:35 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 17:13:35 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 17:13:34 +0800
Subject: Re: [PATCH 2/2] drivers/base/memory: fix memory block reference leak
 in poison accounting
To: Muchun Song <songmuchun@bytedance.com>
CC: <muchun.song@linux.dev>, Ying Huang <huang.ying.caritas@gmail.com>, "Dan
 Williams" <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <driver-core@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, David Hildenbrand
	<david@kernel.org>, Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
References: <20260426144447.817722-1-songmuchun@bytedance.com>
 <20260426144447.817722-2-songmuchun@bytedance.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7fe73023-1fd1-0c10-107e-5c0f47383453@huawei.com>
Date: Mon, 27 Apr 2026 17:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260426144447.817722-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-Rspamd-Queue-Id: D42C046FB87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241272-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,intel.com,kvack.org,vger.kernel.org,lists.linux.dev,suse.de,linux-foundation.org,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmiaohe@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 2026/4/26 22:44, Muchun Song wrote:
> memblk_nr_poison_inc() and memblk_nr_poison_sub() look up a memory
> block via find_memory_block_by_id(), which acquires a reference to the
> memory block device.
> 
> Both helpers use the returned memory block without dropping that
> reference, leaking the device reference on each successful lookup. Drop
> the reference after updating nr_hwpoison.
> 
> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This patch looks good to me with one question below:

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  drivers/base/memory.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f806a683b767..6981b55d582a 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -1230,8 +1230,10 @@ void memblk_nr_poison_inc(unsigned long pfn)
>  	const unsigned long block_id = pfn_to_block_id(pfn);
>  	struct memory_block *mem = find_memory_block_by_id(block_id);
>  
> -	if (mem)
> +	if (mem) {
>  		atomic_long_inc(&mem->nr_hwpoison);
> +		put_device(&mem->dev);

Comment above find_memory_block_by_id says it's called under device_hotplug_lock.

/*
 * A reference for the returned memory block device is acquired.
 *
 * Called under device_hotplug_lock.
 */
struct memory_block *find_memory_block_by_id(unsigned long block_id)

But device_hotplug_lock is missing here. Should we add it?

Thanks.
.


