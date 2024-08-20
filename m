Return-Path: <stable+bounces-69662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BA7957B48
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 04:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9951F225D4
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 02:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE91C2BD;
	Tue, 20 Aug 2024 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="SpoR0Pn7"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2055.outbound.protection.outlook.com [40.107.117.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D883208A5;
	Tue, 20 Aug 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724119205; cv=fail; b=ZWa2/cDlHjcdnpB0seFQGWV9OqI/rk0jLmUrQ+YvZ6jWugeaqRiFt5M9i2kgRRwaQzmLnyPXWCh8dcG/trwRVabhZ7/0kohLIxJ76gS7s7xGwEsBH5P1DyVxdzB8MGvvG48ND2wrvPMiMvHWxWSmtmjEqO4eBquSRogv6saxpKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724119205; c=relaxed/simple;
	bh=TalZLtZLGFPpmixnQG+FzCTl/YlMUAn/RIr2qdMrS24=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+931SAGuHnkOrICszZXFFfCNVu4eQhw4UYShPVpGJTuYe1Qh40z/EsfYjbafyLHcbfmyfzhlKBK8ic+PXj8b4UuhkBH9nEzhYCAp3uubfJ5rXkt5CkmOVo66cpXrdaUPjk68fOwP28C+g6P3vU043gFKyJVTezEQLkbyTgow+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=SpoR0Pn7; arc=fail smtp.client-ip=40.107.117.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyex4P/4nLb4UzcPhMm1T1hJNsZLgw27x8vFKXalJn/XpV5Uj05A3dG9DKz205OX8EphYDSFu7flyYQlhS6rvWYnZ6BRkJWeq/wbrJ9Y+6DPnNm+3GW8dmcQpF1rm46FyOhaDYCbH8xIJSN0MPYb+58uU9MZEqDNcXwBuCtI1tQxVFrfMXsUMePwUU5eyNWPA3UJ8wkVKDEDX6PfTw/sUfmQx4dUDzaGMb4rjIYqIkj6y5eXA4lU8n4AGVIULViUgza6ZDUB5ifmxJZB0arU6rwlXED1EH1AvG8uL0H8UKpkm/5pinlSlvKIzn1GNxVDBHoJyw/Y/yPcVVNHg/eCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1DlBJNfzdNmsaPC7FD4fUhz9105rcqGnm7Atu0dalg=;
 b=C3SPiMnOz85HrZut9+fRFkpeBGyM5D4Z7OhUzY5oyn+CZtOFeZQAUP9OSIN5+4SI2id4C+xcN2lVcTRyocOr19GRbED667pEznTDv63ZWzF1EDZhL7s+7JQYFEdj19++mYrStqjQ6OmBUXZgxpeEX816W74v9Ks4iKfXBvBeKmXRC0Qmj5vF31Vhf+1mZnR3jx47OiljekSr+JKG0cZOVephx0gYHvR7yt/FlCbb0HQiz94eyRR/58Z+Ij5oGhsi326/b16w7PrlLz254swXQ71RjAEaU8PI2aKa8BnEMgSLAT2MTYnv//T70QfvmmeBq2f1TWSfsOXcOOjPaEci+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1DlBJNfzdNmsaPC7FD4fUhz9105rcqGnm7Atu0dalg=;
 b=SpoR0Pn7SsBUeuVO/uKNKyg9Yz1u+8sE6NVRsek5uwLDFYpiH6+pN0ARmjvMsNpdzRbOH2VbqnQm1dWx0FNNOgp2nHzRduzK45+NgvAmOIO3DFpqxXNgHmZwUOCA2acCU1OEGBVpsDoh6mWShCsdw2KHSsMQfiRj1vnsUrfYUp4=
Received: from SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) by JH0PR02MB6592.apcprd02.prod.outlook.com
 (2603:1096:990:d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 01:59:58 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:28:cafe::9b) by SG2PR01CA0174.outlook.office365.com
 (2603:1096:4:28::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 01:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 01:59:58 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 09:59:55 +0800
Date: Tue, 20 Aug 2024 09:59:50 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Tangquan Zheng <zhengtangquan@oppo.com>,
	<stable@vger.kernel.org>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <20240820015950.toqohtw7ofpembjg@oppo.com>
References: <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <ZsMzq4bAIUCTJspN@pc636>
 <20240819125738.vbjlw3qbv2v2rj57@oppo.com>
 <ZsNK61ilMr9wMzJl@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsNK61ilMr9wMzJl@pc636>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|JH0PR02MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 224e2a3f-d08b-4e33-752b-08dcc0bbcb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b3+hICadticrjWtVt1uqog9nn5zAzTeBcpgHwylJUVqmo2FI1BvZQQEFnbvK?=
 =?us-ascii?Q?xze38q7yHfpDlD8or3DRi3JKyKCggUUQ/B2F+y++Cc4NyF33EcV4Io6s0wfy?=
 =?us-ascii?Q?f8Zj7H6vMkRJMvPiCeRtjXUPMuzVOUOh5kifNb2GIfkYt8FUbSbhFeiZHbVz?=
 =?us-ascii?Q?oOzVTM1ag5iNxXOaSU+1z0NSwnwncdNtMsmC1BBbe/R823lmRUTC5fqO0buD?=
 =?us-ascii?Q?1OisekOUSbWXa1lgwEvNQtAW+7v7nsjkytWzb0RGPIYff1Fp/SML3sFiZxMT?=
 =?us-ascii?Q?B/5Y5Mcn/HgCPMT1li5DRubYShLsKNfM/LqvUYYk1OEgdTqqkVv6R1Ijj2qS?=
 =?us-ascii?Q?V02SgQu3WxxKqchsKRTyLVagvRWDcE9Y+f1nQAt2Wm4C6MLq+5U1NS0zufXf?=
 =?us-ascii?Q?7sT741WMlPs/BCyS7yEtpkuP1y/sGlKRg6jUYziy4b13SVWB4h24Q0BpP/we?=
 =?us-ascii?Q?SSiLnIvLWbJY1a6uRORmYwdazRL/Fu8BQmwDxPtw5aiZCB+0T2c6Ycpv3HKz?=
 =?us-ascii?Q?0xyxnE/JkMmYq3KehdAh3nZLx8if+/WpJLi0ejIMJe29mH0f1E4kff7EOCSO?=
 =?us-ascii?Q?VZP/m5Mp1MIB5I3c6Jy7KUlH9EKWKD826EvJeU86FyhwhcsPHQuS7jU69yBv?=
 =?us-ascii?Q?zHgZUF391AdFTSvx2ZsTAyx8HvdU0sCoxvxLcy3uB4uPbLMKNeMZRkpPDVb7?=
 =?us-ascii?Q?j5h28Dq/QjNyogWMX1mK2YZPwz3p0w7CmMiMEhWaTSlTiNTRW7ip+R01K7/Z?=
 =?us-ascii?Q?k4CvjL5pe0FuTTUrq1ss/QFBOf3lYnNI0+rtI5q2J6d9kf8gs4Yu7JyqBVnX?=
 =?us-ascii?Q?X56a6dWGQQgqXgvM79QWMiX82Ue7EohJhN1djWEJhYbkeOYBeYNbb6r/6Bis?=
 =?us-ascii?Q?dwwLbt58TbQao+JsCmNJcNbP0LdlZbLjkEm3wu7uH7qytZxkMr51tffdvOM0?=
 =?us-ascii?Q?jI/RylfxbGAPAVlT/WD5bu6RAafTi4LiHsnowe2riowJdVHP+GRObqUWkyH8?=
 =?us-ascii?Q?SV9GYqG9vIRtS0iJm1mAf53Z2D+o6hMyW6vo/13cPGckYNpFLntwhQrzHCAw?=
 =?us-ascii?Q?iHe9iIMo8TG25qLFRAkn/IU7bRyaOjXF3hFYzxyoLlX4ArEhUrCoqYTmx+Oi?=
 =?us-ascii?Q?coZ0mquP+yYPf1aFIZBxtQciNE9WJDKeQexAPLjHX5ewslVdoxbxj6Luru+Y?=
 =?us-ascii?Q?hDptrTXCePOiadFX5AeVocfWr11ZCvnEXRZv6KKIKe39Xdws7FXV+gHCW5CW?=
 =?us-ascii?Q?HniF0cyLyPpLn5qUtPGmFpJqjteMALQcl5giDjiPovkoiUYSugqmdx9pzMmV?=
 =?us-ascii?Q?A/qJrhOe1HzfZX6gX13e7Mtqmu5TtOjoPZkq3LE6oDnaeW2OWa8S9U4295Bk?=
 =?us-ascii?Q?cD2F7JTG1EDtRN3S3G0yfuuXYnwnxGWtr7otOXVqzU0d1NU7duh3xedy3Gd2?=
 =?us-ascii?Q?aZY7r5LNx30Q70M9T8b55VfI/vsRcG4E?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 01:59:58.4834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224e2a3f-d08b-4e33-752b-08dcc0bbcb86
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6592

On Mon, 19. Aug 15:38, Uladzislau Rezki wrote:
> On Mon, Aug 19, 2024 at 08:57:38PM +0800, Hailong Liu wrote:
> > On Mon, 19. Aug 13:59, Uladzislau Rezki wrote:
> > > On Fri, Aug 16, 2024 at 07:46:26PM +0800, Hailong Liu wrote:
> > > > On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> > > > > On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > > > > > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > > > > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > > >
> > > > > > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > > > > > >
> > > > > > > > > > because we already have a fallback here:
> > > > > > > > > >
> > > > > > > > > > void *__vmalloc_node_range_noprof :
> > > > > > > > > >
> > > > > > > > > > fail:
> > > > > > > > > >         if (shift > PAGE_SHIFT) {
> > > > > > > > > >                 shift = PAGE_SHIFT;
> > > > > > > > > >                 align = real_align;
> > > > > > > > > >                 size = real_size;
> > > > > > > > > >                 goto again;
> > > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > This really deserves a comment because this is not really clear at all.
> > > > > > > > > The code is also fragile and it would benefit from some re-org.
> > > > > > > > >
> > > > > > > > > Thanks for the fix.
> > > > > > > > >
> > > > > > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > > > > >
> > > > > > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > > > > > to order-0 should be commented.
> > > > > > >
> > > > > > > It's been a week.  Could someone please propose a fixup patch to add
> > > > > > > this comment?
> > > > > >
> > > > > > Hi Andrew:
> > > > > >
> > > > > > Do you mean that I need to send a v2 patch with the the comments included?
> > > > > >
> > > > > It is better to post v2.
> > > > Got it.
> > > >
> > > > >
> > > > > But before, could you please comment on:
> > > > >
> > > > > in case of order-0, bulk path may easily fail and fallback to the single
> > > > > page allocator. If an request is marked as NO_FAIL, i am talking about
> > > > > order-0 request, your change breaks GFP_NOFAIL for !order.
> > > > >
> > > > > Am i missing something obvious?
> > > > For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
> > > > the flag correctly. IMO we don't need to handle the flag here.
> > > >
> > > Agree. As for comment, i meant to comment the below fallback:
> > Michal send a craft that make nofail logic more clearer and I check the branch
> > found Andrew already merged in -stable branch. So we can include these with a
> > new patch.
> >
> Just to confirm. Will you send an extra patch with the comment?
>
If this is not urgent, I can send this patch later this week. :)
> --
> Uladzislau Rezki

--

Help you, Help me,
Hailong.

