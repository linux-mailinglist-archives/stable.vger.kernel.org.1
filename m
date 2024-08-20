Return-Path: <stable+bounces-69676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38F957EB5
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 08:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6CF2824C5
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 06:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209853F9C5;
	Tue, 20 Aug 2024 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="fjwm3FHh"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F018E35B;
	Tue, 20 Aug 2024 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136885; cv=fail; b=bKZkeNil83Q7cz4mCiQrnYVT+QWDVbP0gNH4raOKsQa3IpXLZPFaf1W1de9Y4N7RRjWhNkpwckOijwN2oe83ZGgitKKBV5Xq/N/qIyCsYsi2LCFp94RiuYQ3qwQKQqsSppyxRVeyKoA2uJ7+ck2k+7WBVFwi6jnR5exlij5wuPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136885; c=relaxed/simple;
	bh=Te0X6nS3Lvpd6oKYBAsTzXe60ed+cqfwU9A08ivfIcE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohUMVj+xkE4qxcGO0RM2B4neUpQqA+cOJVlMVW5Jr9xonmaLFCFjgT76Nk0sVyep4kQd+YFsFMhWcCsvkY7KUgymTOqaAvJG1LQGxyQQYV9FILIhOx5CQY2fUCoWt6wSnEcB33x4wE358TRR06w3wqN+MoB3okzvS9rXDtysDAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=fjwm3FHh; arc=fail smtp.client-ip=40.107.215.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvIxPjhL3qROJ5il6ABY2t5jrGGFxo+LY/JcsHr1DW+u+RmzsDkeqO6z0kby++r6GNSgcEAozEZZSZDKDnSH4o8LU0p5MYtVXbd1hwJ1BGgEMppxjA/L36aot7C7YjdrkROcMB5H8RnX+Trkry3eByhZALWTGCZWSVFh/D4RI2XbT780YVeiDHm46faH+ALDPbgG6MQgCaur2iIaXqYEtVSyQFbhE5w7Zi7jz/we0HeFpG268n8CKcebssiZ6TdkhrbwdrptpeIuJCr94vm7tHLGlzSLDnywoiMH4pqbZn1a5I+RF5i4F3EJLz9SjgX6EU64JQqJuhm1h1h0PVBvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64VfPkM5jiyfI3QlIZiidjo2FiQDaBn0oS3fIM40ors=;
 b=D74MZywgIvsjFojQdNByvPTr7PTo7AHqnU3IOSYQdRCzoL+ySX8SAjNMCvDPuHX2ReO4n/BBnlwcmM40ILghfhMEmYDhD+vdItmuB3JEoaSxFp1ZZ9bXUj8tLK/FdIwyj4MWvXuW7pTUjNz74BqVqOaDEff3+CKA77kputsQgF7uICpvN08V/hD+VD9/asCdTZRd4MNInxyT/cpHtsuIcTzgd0o7GWh1QuBbC1ff13Y904JEBC/k5AnkMz66QhFyeORARwOrI717AWXCeDnP77fblIZTvi4hRKemm/lFbhkk6mnqR5Px0elbGswgji9S0FNHpYcNqFYvC6NwUUZCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64VfPkM5jiyfI3QlIZiidjo2FiQDaBn0oS3fIM40ors=;
 b=fjwm3FHhTERPwueJU+YqOJC1CNGr6Zlt6tfR6x5Cy89t2HBraeA10pMjMjhfGeYXyVxuGFazKWkyXH/Jr0Iaus06hcoiz7YR0isgSSWg/0gqU6/nu9wy2cduR1dan5huYzjCNwbmIlpHpzc8GaG0Qje+SdsLTDkSSQZMEdfBk+0=
Received: from PS2PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::34) by TYZPR02MB7267.apcprd02.prod.outlook.com
 (2603:1096:405:40::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 06:54:39 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:57:cafe::2c) by PS2PR01CA0070.outlook.office365.com
 (2603:1096:300:57::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 06:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 06:54:38 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 14:54:37 +0800
Date: Tue, 20 Aug 2024 14:54:36 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Tangquan Zheng <zhengtangquan@oppo.com>,
	<stable@vger.kernel.org>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <20240820065436.7na2c74tuqxmvpbp@oppo.com>
References: <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <ZsMzq4bAIUCTJspN@pc636>
 <20240819125738.vbjlw3qbv2v2rj57@oppo.com>
 <ZsNK61ilMr9wMzJl@pc636>
 <20240820015950.toqohtw7ofpembjg@oppo.com>
 <ZsQ7WP7iiB2NmfdV@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsQ7WP7iiB2NmfdV@pc636>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYZPR02MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a32754-d2f0-4fb3-ac37-08dcc0e4f569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYPQWkM5E0kwLQ4kCcOxVBokT85UJdZgXmU31sTGnXqavop344z3uVjZcDYM?=
 =?us-ascii?Q?y9UyeFKcRskkmWELvhtHAgMkdVGEPvmnGrHUi8LdjjUYjpCsbnHYiXKenvp1?=
 =?us-ascii?Q?t0tzuhhgQm7TlGUCpVsbKLKai4gDiM4YzBfOv9fzrv1iweY23Y06MAhbUaVY?=
 =?us-ascii?Q?obB+aVu+PhRpQu5yKjhC+4Hwu4lfBy+vnLdmefIJCXLHqdo92/w3ac1ncoA9?=
 =?us-ascii?Q?kiZSygeiqw+LEyk/xMNLcmBkLBsA/2lAFwUpB+43GwwFJhhIAv6SxWuQ7kyy?=
 =?us-ascii?Q?dVwZE+MJ7gXlUw8+FWidGn0Ot6Cq7U0RF/2G9JrkI1T7+CS5bqaWwp37haf9?=
 =?us-ascii?Q?hjJSzymOFH3M2FiEFKurxAa+BEfdem2zG9BCnN/hpjZB6ui6J3NZsmRe2+m0?=
 =?us-ascii?Q?LU6ozi9znxMPH3MUxTgxcqtJKmx7ZKrXyBY65ZdmlQTP779/TZkPJXnXZLhM?=
 =?us-ascii?Q?empIHUK17osqZkyeztGv7c5vH8YtODupqemMdq6j4mWOMgbpA1VTsBf4V7mM?=
 =?us-ascii?Q?Vrz+heatj/SOasi+zHIJliPdWlpU2tg4bYUypUMOU2L1mxw8tOYH/IXG2Rry?=
 =?us-ascii?Q?EhcKiq+gAB7kKaUY7P2dJi9KeKqh2Q1211hjQ1OcSoNOFrnX77basBFh91XJ?=
 =?us-ascii?Q?2V+amdkq+LxR0NUpfXQwT3FRE/9EytJUcfa58wEv9uzsB9rHpbZb4qBLNI+E?=
 =?us-ascii?Q?XxUuOKTd6D7XY0Rr+iEvngA5hPXY/ztvgJAEKlO5DneyFIe++kGyXNQ9XqLr?=
 =?us-ascii?Q?yw2j4qORkqVibMTuBgY5WJAToaTMoZ2VuPu3QdwZP1luWnbw2sgHDxX272sw?=
 =?us-ascii?Q?hBmkBGLuipYRjuS25Egp7VkBEh7YAXuSykNQ2E/VTnsSSMEXaP4wJ7Cid9zc?=
 =?us-ascii?Q?+a2vIlenwmFrcKN1oRTHG+/X47RIF3HkMw97flkoxzdkKfqYOVgeiVahSQmC?=
 =?us-ascii?Q?TLo2Qxh4BN/GZP/VZCTDpPbKg2/1Kz99x2TxtjBTBI/CSmvvxNbVoVXD3irc?=
 =?us-ascii?Q?8J9g4G53cB2KRytDS0nHXeWNz7IDJ49MQfxT2zOToj+82Z/hh/MQm9zY/dTQ?=
 =?us-ascii?Q?rBMp4KEq6kvTGmraRiHRXB7IKi1AJ2UViPg2oOYsX7V7U3Vtu6YeRApSZl+M?=
 =?us-ascii?Q?t+TmghAcNRYVLBr3havuf+zPP8y9VJzwvjv3DSrD90tZfkC5Tpq3vWbRu0p4?=
 =?us-ascii?Q?1lQ5zcQtJAdsQCY4COsmJ8PoVxvq/xZvYugSVVVEdmWLlt4ey/nXGO2OsQYZ?=
 =?us-ascii?Q?keI/3y8dXSkGrHkh9RBkMCVwEsSYCscuFktdCjKhomHlgdnU40sGoauDUbM/?=
 =?us-ascii?Q?trSlwcD4hZTb/3AEzbEEcDzA+R/5ENRwv47956HsqQW6szz2ec3majIVtGHU?=
 =?us-ascii?Q?qVUtD+RW3aDjhf14r0ObNBNjMAoRT325r2uQEP0tiSQNON7MvwOAo8wT351I?=
 =?us-ascii?Q?TXMIwlsUYpjBeEZUzV6/enHryCX9FNQO?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 06:54:38.0468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a32754-d2f0-4fb3-ac37-08dcc0e4f569
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7267

On Tue, 20. Aug 08:44, Uladzislau Rezki wrote:
> On Tue, Aug 20, 2024 at 09:59:50AM +0800, Hailong Liu wrote:
> > On Mon, 19. Aug 15:38, Uladzislau Rezki wrote:
> > > On Mon, Aug 19, 2024 at 08:57:38PM +0800, Hailong Liu wrote:
> > > > On Mon, 19. Aug 13:59, Uladzislau Rezki wrote:
> > > > > On Fri, Aug 16, 2024 at 07:46:26PM +0800, Hailong Liu wrote:
> > > > > > On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> > > > > > > On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > > > > > > > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > > > > > > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > > > > > > > >
> > > > > > > > > > > > because we already have a fallback here:
> > > > > > > > > > > >
> > > > > > > > > > > > void *__vmalloc_node_range_noprof :
> > > > > > > > > > > >
> > > > > > > > > > > > fail:
> > > > > > > > > > > >         if (shift > PAGE_SHIFT) {
> > > > > > > > > > > >                 shift = PAGE_SHIFT;
> > > > > > > > > > > >                 align = real_align;
> > > > > > > > > > > >                 size = real_size;
> > > > > > > > > > > >                 goto again;
> > > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > This really deserves a comment because this is not really clear at all.
> > > > > > > > > > > The code is also fragile and it would benefit from some re-org.
> > > > > > > > > > >
> > > > > > > > > > > Thanks for the fix.
> > > > > > > > > > >
> > > > > > > > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > > > > > > >
> > > > > > > > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > > > > > > > to order-0 should be commented.
> > > > > > > > >
> > > > > > > > > It's been a week.  Could someone please propose a fixup patch to add
> > > > > > > > > this comment?
> > > > > > > >
> > > > > > > > Hi Andrew:
> > > > > > > >
> > > > > > > > Do you mean that I need to send a v2 patch with the the comments included?
> > > > > > > >
> > > > > > > It is better to post v2.
> > > > > > Got it.
> > > > > >
> > > > > > >
> > > > > > > But before, could you please comment on:
> > > > > > >
> > > > > > > in case of order-0, bulk path may easily fail and fallback to the single
> > > > > > > page allocator. If an request is marked as NO_FAIL, i am talking about
> > > > > > > order-0 request, your change breaks GFP_NOFAIL for !order.
> > > > > > >
> > > > > > > Am i missing something obvious?
> > > > > > For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
> > > > > > the flag correctly. IMO we don't need to handle the flag here.
> > > > > >
> > > > > Agree. As for comment, i meant to comment the below fallback:
> > > > Michal send a craft that make nofail logic more clearer and I check the branch
> > > > found Andrew already merged in -stable branch. So we can include these with a
> > > > new patch.
> > > >
> > > Just to confirm. Will you send an extra patch with the comment?
> > >
> > If this is not urgent, I can send this patch later this week. :)
> >
> This is for synchronization, so we both do not do a double work :)
Ahh I guess you already have a plan, so I don't need to do this. Wating for your
patch :)
>
> --
> Uladzislau Rezki

--

Help you, Help me,
Hailong.

