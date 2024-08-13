Return-Path: <stable+bounces-67428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D10594FE19
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323E51C224A4
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186E3CF4F;
	Tue, 13 Aug 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="F+FUHMhL"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2082.outbound.protection.outlook.com [40.107.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66339FF2;
	Tue, 13 Aug 2024 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531894; cv=fail; b=Y/vWSBqPFN3DKmaMMQssHAkN1Vchxdtr8CVJfApXf9IPmFqhOE/HlO4PB1/xZKjfZK/f/uUd8cQa/o3SbKTheFWZLrf8XSYsWiOZc+LrQnF0XFeLiIL01V1aFGbCxvchKezSeaAkjwFMFhh5HLC5WziUhESqUQCcBAf5uLW4dqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531894; c=relaxed/simple;
	bh=fiRkBJ5Cubk6O9HIGaMBJwRw6xH4EuiuT+ffWjE+ENM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDu9iE6/SgThbBKalCLAK6Kq3X3fzbzVoqRGYmcpbA8WVLVI6Z5/Iewfmfm42/XDLi7g1c5K508v71YE4GWJBJg3+6SD+0SJAkPlQmd203OPjL7gas1xMwgSbHwh4X1IgTFUrCn2ssrr03IGDxMK6VXANtEaVlDhYYhAHBhQpd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=F+FUHMhL; arc=fail smtp.client-ip=40.107.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6GTUxtrJXKubk+fRKgCah0Mz3lSeFdlPGlOn1Fm3wHgWAa1umwNpOdrf+UGMh84xkffczLj1vHibMH5wAy7P1ckHB572ftzXce516pD/DwKPNIMR5ej1qwZs5okgkHZxoZqrUCNLOeibjVjw/xSabG0MJi6EovmUCoTpuHYCgvAT1fdmTn+Dk8wgdQ2uLY/Fu+oEfM/3qmqHSYqHihVWGeDQb6KOpFHn0U9ZKQXWd7xMXg3YOehDXxjC6aJPHnBrsZIflMAOe374KNfQnbOcMHUy6V/MbueMFyhEmtykLRUyHP1EQ4l57iOd/6XEe17pL8BABu2j4AQfxuAuX/6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h2q6LRuC6T+SsGvNtNEgLFa5Q/PBALDTTZOEgbmvGk=;
 b=l9gb1c7/kOK2D74lA/kCD1csbr3FFIkk0zfkCmEb3ez2f/VFOOSLL46jy+BaKfZ/PrURiZEBXVvt5gfLtwPHdgr+BJzV6/2Dju4SZ5mPcpjYLswPV3cCECC6m5qxHWuxMoe+UE25xmwjmXtIJUAwpaaKW/F09kbleJm3SY0zBjTgBililriR++4jhFP67aZrMZsBGe4THnJyIHC8+YziscTXya4y4RCS9RqAFhnTLiv3uXVKf3pTYfJJ7Mu3jAu2gi9bAMWpd1IADAPZSJxea0ENLKuS2rwsKlh27zHopCWKEgWMkrtuMq6tUoPRdqICFoFceblIkykDii3WFzXTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=kernel.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h2q6LRuC6T+SsGvNtNEgLFa5Q/PBALDTTZOEgbmvGk=;
 b=F+FUHMhLUvy9ZtSaqrRPEvVyt5Whr5VkMLpKBmk6WGQLjcN89nl+rVqdqicXghxXSdnEHtIJSc3Q4Jf7w6Okas50O9HNGH3OdCbOf0klwbNQQocb2y+VT6Mb3pjAykHNTc+DE/QdYKSxyCrahLx65/3dTfhLrf6w03F7MTXdR9A=
Received: from SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) by PUZPR02MB6099.apcprd02.prod.outlook.com
 (2603:1096:301:e5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 06:51:26 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:193:cafe::e4) by SI2PR01CA0046.outlook.office365.com
 (2603:1096:4:193::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Tue, 13 Aug 2024 06:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 13 Aug 2024 06:51:26 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 14:51:25 +0800
Date: Tue, 13 Aug 2024 14:51:25 +0800
From: "Hailong . Liu" <hailong.liu@oppo.com>
To: Will Deacon <will@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Zhaoyang Huang
	<zhaoyang.huang@unisoc.com>, Uladzislau Rezki <urezki@gmail.com>, Baoquan He
	<bhe@redhat.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] mm: vmalloc: Ensure vmap_block is initialised before
 adding to queue
Message-ID: <20240813065125.ymrzb4fdz26trovw@oppo.com>
References: <20240812171606.17486-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240812171606.17486-1-will@kernel.org>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|PUZPR02MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 57130490-846c-493f-0f8f-08dcbb645a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJp5I5xwUdxo5ogVbr7dxlcuIwaot5gUUG5tjWQhdoQVc0RVn/s1RTgXQu5o?=
 =?us-ascii?Q?GbAoHptzsJ1EMdU3t3Db/WhGD4WftphYM5bVFPeK7JJelWDf6tQO3nHy5XyZ?=
 =?us-ascii?Q?1dgz5iU6FK7aJZ31MW+rgTgjvOsEDvlWal+1M/u3OXhUswk5LKM62XdL83pU?=
 =?us-ascii?Q?vek4W1L03rEtBgejptTaZVaThnRIfg7/M4cMmCN9LKB7QPop3KMbjKOOCcEM?=
 =?us-ascii?Q?TGlMw4upKdsbFmHUh3QHNO6CkAbFpdFsypIVhsjPHlx9Qhlzq5mGkwLPIN41?=
 =?us-ascii?Q?9891o9JJjdwlE9wn/hK22forKOiAfyCAeRkXOR6InfBKO4O5tF+IWDIeE6bF?=
 =?us-ascii?Q?2FNKd6EyXW1QaYm6NqBp9Mek9AKxlqQILUWqfpf1cHabZqRZoTEvZ7UmJeVF?=
 =?us-ascii?Q?RWVAy7xiAqLu/Q89xegQhKoCNK9qU3HO0FysIZ1LA8RcchuxOfdwQwf3vchP?=
 =?us-ascii?Q?amVElB8TZe4jw76TE2shhpxPdR0VGqOdC5U8bCGlcJ2Kzu+GIs7hf4w6Rsbc?=
 =?us-ascii?Q?/h4GXifLqlqS+1K/ZaENR2PXoTTDw8vILrba31+w0GLmzyc8uX9UHIBxOEPt?=
 =?us-ascii?Q?4DWk9mkOlsSsAoFIee0RHrK+5oE03aIFpToaYPG7y0nsvOSNgVI7jZYM/kHm?=
 =?us-ascii?Q?lUSDNnONCGtCMf4hoz53+xJEIIXHedtTsHTUvqoZgzT5cDJaRe6ZlU6yLOn/?=
 =?us-ascii?Q?k3N7ITV+xEFn/P8JBtL/ZINq+lu5wWBEA5akWwTZfDFwAJMckm9/pL8Sm23S?=
 =?us-ascii?Q?De1EEs9+6dwwTGfTd+qnjYDZvPz+YSsmJqNBR8dxXlX7qhrCe4QjMHEWZ/nm?=
 =?us-ascii?Q?uS8LzX4x3mw3/86/CvnOASoYhWOKVJVJvkDJLs8Jo/2MSyV74jGGbUDjGb0J?=
 =?us-ascii?Q?p6aJUNUqHW9jzCTEZ5EJWUw3x8Ir0+DKlyWzFWh/mFdQ4Qwv6//5AvO43gLh?=
 =?us-ascii?Q?HXeN2qKytDFmHkWFKvwiG6QlCsvjBCU7WydGdA4ihm2n5QOyrcBbh2rkE/3h?=
 =?us-ascii?Q?IBdOw76+fZHPUKY8Fz6DiQqbtWUS9iDddzHJ0gXikl1htpsNiFMfWPdWlv8H?=
 =?us-ascii?Q?XYpk/i9x4imiSdYFoY6OWNDHdFc9qXhtPo/XnA+ihx8Cv1KttPradIuIa8zf?=
 =?us-ascii?Q?W5uC0jexxueXRPqStJ9RRq/KWl19Sep/qT3Q7QjJg/VIy7UEhTUvorZvbj7W?=
 =?us-ascii?Q?nR9c2ZyRCFrWa+6f8jNYV9ESWwPii5+IurNLKsqe6iRJmHQqwrWXXY6Af/6Z?=
 =?us-ascii?Q?0ZJEvdG7HSKcHy1JnVavrIYazPnnVL4qkWN8jrLsBX2v61atbm6v8f02i/A3?=
 =?us-ascii?Q?Se0lYHJlWgidA34zuB1q+Y+wh3H9W5u2NiaztGhsGCAoZguXSyVc15XTBFdj?=
 =?us-ascii?Q?CyTEiqxUod59NLIXUPZyxLvxkSVJj2jwpAsfIM+Q9pdYEcEQqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 06:51:26.2715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57130490-846c-493f-0f8f-08dcbb645a32
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6099

On Mon, 12. Aug 18:16, Will Deacon wrote:
> Commit 8c61291fd850 ("mm: fix incorrect vbq reference in
> purge_fragmented_block") extended the 'vmap_block' structure to contain
> a 'cpu' field which is set at allocation time to the id of the
> initialising CPU.
>
> When a new 'vmap_block' is being instantiated by new_vmap_block(), the
> partially initialised structure is added to the local 'vmap_block_queue'
> xarray before the 'cpu' field has been initialised. If another CPU is
> concurrently walking the xarray (e.g. via vm_unmap_aliases()), then it
> may perform an out-of-bounds access to the remote queue thanks to an
> uninitialised index.
>
> This has been observed as UBSAN errors in Android:
>
>  | Internal error: UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
>  |
>  | Call trace:
>  |  purge_fragmented_block+0x204/0x21c
>  |  _vm_unmap_aliases+0x170/0x378
>  |  vm_unmap_aliases+0x1c/0x28
>  |  change_memory_common+0x1dc/0x26c
>  |  set_memory_ro+0x18/0x24
>  |  module_enable_ro+0x98/0x238
>  |  do_init_module+0x1b0/0x310
>
> Move the initialisation of 'vb->cpu' in new_vmap_block() ahead of the
> addition to the xarray.
>
> Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> Cc: Hailong.Liu <hailong.liu@oppo.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 8c61291fd850 ("mm: fix incorrect vbq reference in purge_fragmented_block")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>
> I _think_ the insertion into the free list is ok, as the vb shouldn't be
> considered for purging if it's clean. It would be great if somebody more
> familiar with this code could confirm either way, however.
>
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6b783baf12a1..64c0a2c8a73c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2626,6 +2626,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	vb->dirty_max = 0;
>  	bitmap_set(vb->used_map, 0, (1UL << order));
>  	INIT_LIST_HEAD(&vb->free_list);
> +	vb->cpu = raw_smp_processor_id();
>
>  	xa = addr_to_vb_xa(va->va_start);
>  	vb_idx = addr_to_vb_idx(va->va_start);
> @@ -2642,7 +2643,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	 * integrity together with list_for_each_rcu from read
>  	 * side.
>  	 */
> -	vb->cpu = raw_smp_processor_id();
>  	vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
>  	spin_lock(&vbq->lock);
>  	list_add_tail_rcu(&vb->free_list, &vbq->free);
> --
> 2.46.0.76.ge559c4bf1a-goog
>
>
Agree, actully I had comment in
https://lore.kernel.org/lkml/20240604034945.tqwp2sxldpy6ido5@oppo.com/
myabe put this line in vb's initialization before xa_insert looks more reasonable for me.

Thanks.
--
help you, help me,
Hailong.

