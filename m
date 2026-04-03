Return-Path: <stable+bounces-233159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNjXGYKCz2nLwwYAu9opvQ
	(envelope-from <stable+bounces-233159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 11:04:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB8439288C
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87013304C044
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9623446A6;
	Fri,  3 Apr 2026 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gkoM6sjn"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F31F1304
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206786; cv=none; b=LuL7Sj1wc24NWlWg9KYWH+C1UL/AdoDM2azfZ+0tgxS/NWXA3GSHcT0jEU/qbaGNcU8aq2DdyadN1wYs9no5pjg2N9bo7AyxXF6eep9jZ0MXm6J3Mo6Gfj92DIIPDyiW7mfa4U2egvP5Cz8VkrJ3bM+mTaLXvdNhuwUWLVl5CgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206786; c=relaxed/simple;
	bh=EDJN//tox4rrpNG1MzYMscDAQT/LFvR8G/IoGdw+aQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qiixBN+HgvlDxX201lAEJmwntu5BeuxC36tuMt8OR2CzmLGSLr8Yib7p9DK2GPUEYNQcifhbQMh0HFDuALIIflIL2NFYz0W7Do471uadQvyipFo/XJ9tRrBi+cU5XvvzBk3dy49c6eNoJ65KExc2LI9QihhjsqopXPcg1mMPvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gkoM6sjn; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NQfGHQLvAEoUXucN/ii2mm0KWEqbxxSVip1UKyTR+SI=;
	b=gkoM6sjnROvHyr6iX+GmH1fTXFMqbyz6dLvNinKPz/WP0EPyGk7FUeo+MISSDGFVhwYJfQnoE
	OrrbuGAiDq3xxJLA2+c46KVXblBXJgIMiGECIMZVGEt708wE3jZtoizpieDOTy7aMuAcxfHXY92
	lGgFED+YO1oKTLqr9KBsBNo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fnCDq2DpDzcb0v;
	Fri,  3 Apr 2026 16:53:31 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 83F8740561;
	Fri,  3 Apr 2026 16:59:39 +0800 (CST)
Received: from [10.174.176.156] (10.174.176.156) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 16:59:38 +0800
Message-ID: <8a902208-675d-4564-bb31-fdefcaebb752@huawei.com>
Date: Fri, 3 Apr 2026 16:59:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be
 power of 2
To: Liew Rui Yan <aethernet65535@gmail.com>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, <stable@vger.kernel.org>,
	<sj@kernel.org>
References: <20260403052837.58063-1-aethernet65535@gmail.com>
 <20260403052837.58063-2-aethernet65535@gmail.com>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20260403052837.58063-2-aethernet65535@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233159-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanquanmin1@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: BEB8439288C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Liew,

在 2026/4/3 13:23, Liew Rui Yan 写道:
> The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
> However, if an invalid input is provided via the DAMON_LRU_SORT
> interface, the validation failure occurs too late, causing kdamond to
> terminate unexpectedly.

I'm a little confused, what does "causing kdamond to terminate
unexpectedly" mean? The damon_lru_sort_apply_parameters function will
eventually call damon_commit_ctx, and the power-of-2 check is always
performed. Is the early check here to prevent some more broken case
or am I missing something?


Thanks,
Quanmin Yan

> To reproduce:
> 1. Enable DAMON_LRU_SORT.
> 2. Set an invalid 'addr_unit' (e.g., addr_unit=3) so that
>     'min_region_sz = DAMON_MIN_REGION_SZ / addr_unit' becomes
>     non-power-of-2.
> 3. Commit parameters, and observe kdamond termination.
>
> This patch adds an early check in damon_lru_sort_apply_parameters() to
> validate 'min_region_sz' and return -EINVAL immediately if it is not
> a power-of-2, preventing unexpected kdamond termination.
>
> Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---
>   mm/damon/lru_sort.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..3fd176ef9d9c 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
>   	param_ctx->addr_unit = addr_unit;
>   	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>   
> +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>   	if (!damon_lru_sort_mon_attrs.sample_interval) {
>   		err = -EINVAL;
>   		goto out;

