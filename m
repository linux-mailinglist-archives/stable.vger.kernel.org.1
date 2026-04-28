Return-Path: <stable+bounces-241636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG78H82r8GnOWwEAu9opvQ
	(envelope-from <stable+bounces-241636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:45:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE7485097
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14AFC3057152
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A583AEF56;
	Tue, 28 Apr 2026 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="v0bFUI0B"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACF3ACA6A;
	Tue, 28 Apr 2026 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376249; cv=none; b=dLOcagCEeyxCqNlUDPJQMfbxP0cxlU3tMob2M4hgsncrUpEHwNBmEoqGxhRCoYPoJ9Bsood1Po45w6T9LKl3F3TbvTdMVLDa73USOizjSqzyXFpwwWb5A5Koa/+5PtxdwmZdXFFmFSePzP95tJNpsfHeMgxHpRyNFF0C8/kqYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376249; c=relaxed/simple;
	bh=cIhFdiuC/sLMm2BsvD39eZ3qa9Yt1htop66XZgtLjHA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=epFHqDV1myhrWExbcl4oYxXMukX/kRaRWQftuxpRnDzOO7BqA5kGba57QVySIIsazS8Xhu0AcA17NqtZvkkHBzD8DJNJw9X7PIAJ3FpWQkdGUgg66yhR/g+dAUWeE0Ucb4cVAMKweta4Z+nTakNasVgZqJFJP6KzO0O+oVgBeg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=v0bFUI0B; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yP5OQNhMmcwIxI1oI5Mx5fKdBBjTBBmIQZkVZovEd3g=;
	b=v0bFUI0BEOyWueLy7pxnHCOKVoR0igzwxlVGdMA0Qyw81uWFz3SqQ8IPZMcyLRX01XUCsllDq
	buzpaLWGFTiho+PSVkEx0QUmIuhhGNY9chtIZr3xID27VtEzn6XPzSqZ2zQ1nG4KdfnWkjZEDqE
	lN3A5Uglgi494HwPD5AeF4k=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4g4dXv4h6bzmV6X;
	Tue, 28 Apr 2026 19:30:55 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7998540565;
	Tue, 28 Apr 2026 19:37:23 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 19:37:23 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 19:37:22 +0800
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison
 accounting lookup
To: Muchun Song <songmuchun@bytedance.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ying Huang
	<huang.ying.caritas@gmail.com>, Dan Williams <djbw@kernel.org>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <driver-core@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>, Oscar Salvador
	<osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
 <20260428085219.1316047-4-songmuchun@bytedance.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fae6e568-fbdd-e697-8ea4-b12c73750ec9@huawei.com>
Date: Tue, 28 Apr 2026 19:37:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260428085219.1316047-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-Rspamd-Queue-Id: 3DDE7485097
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241636-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,linux.dev,suse.de,linuxfoundation.org,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

On 2026/4/28 16:52, Muchun Song wrote:
> memblk_nr_poison_inc() and memblk_nr_poison_sub() call
> find_memory_block_by_id(), which requires device_hotplug_lock to
> serialize the xarray lookup against memory block removal.
> 
> Take device_hotplug_lock around the lookup and nr_hwpoison update so
> the memory block cannot disappear between xa_load() and get_device().
> 
> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Thanks for update.

> ---
>  drivers/base/memory.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 6981b55d582a..f76aee29e9a5 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -1228,23 +1228,29 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  void memblk_nr_poison_inc(unsigned long pfn)
>  {
>  	const unsigned long block_id = pfn_to_block_id(pfn);
> -	struct memory_block *mem = find_memory_block_by_id(block_id);
> +	struct memory_block *mem;
>  
> +	lock_device_hotplug();

memblk_nr_poison_inc() and memblk_nr_poison_sub() are both called from memory_failure() context.
I'm afraid if memory_failure() is triggered while lock_device_hotplug is held, it will lead to
deadlock. Or am I miss something?

Thanks.
.

