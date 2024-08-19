Return-Path: <stable+bounces-69584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59320956B5A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 14:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B434283A5C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67A16C69A;
	Mon, 19 Aug 2024 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="UaYZKnes"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3D16C680;
	Mon, 19 Aug 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072266; cv=fail; b=KN+wxqwaqmYVkliOaPwagygZTQY+oZcpOITQ9jWGxp2V/xtUTBJud42iVk2QlsbK8afzBsn3y7S3h9zwoFE7Fsf6yJqjs3k85gmXf81uicsiQSIfGnbXlDEGpRAAHJJ/l4shJqTRhGAe3A3Qi9FDnyyotgNc/FSHQ5qFzHvfEYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072266; c=relaxed/simple;
	bh=8wcQm2TRowUR70Vf/1ltgJDY3wlwNstuirCmkrZyJCs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBZ7QW7M0i/kkirc5lVg0XdrfCkFYTkjg/q9NM+fX/AM+pBM7fvLY2uABSZhZE/YKrTRCMYAnRiCu/FGrR5VFbicE3Ssox08c8mH2eaJZKHOcPUeF6doRY1Va62MJevCO+P5RMO5JPHKwBIiPF9LgXnLiZT+Ehvxdb3eGjNKwc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=UaYZKnes; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TasZoIHuyDX/YFQd8iAGHAwVrNvlnocV2jAqgZCDmI2Xp+eZ2fTgLhmgukq101y1ZPF44dXczf2AdrI7LutMJyckmTxkRMiGC4IyP4iv16zW7jIq39kWuqHdty6kxbCRGYm2y9b9Ao7aW+UAtNLCDbASJ366P3ipW2yUvb/tKyXsXHzCR4dPNFPIkNtRPsWAIfFoQed0YoaeNHtcc2DRmfAyG+Ohu2LX9kVAkJQ3GiY3Bz1O1rEvsmEGXugDF0MN+zXAkgxwlD8lBj4IOuq/z9bYQsmP6sOuMsWHh0IAf8bY10vM1xtmrPrSgooTiypNqNsw35BxJu0qW/a7/0vPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAUWZTI3cBPdoY4BNnwpgO3WU7BxoW4iCiNiLw72uSI=;
 b=YND5KnCMCMeSxdg+5nFeRljvluk88VOo1wUsQfmzKVV/kgL7tIHqxsdt6dr99YUaOXMb7VPTgdxSmtxuVJqTkx4lqB1UNJGMfN9h9N50K+Yr50376fCvD/Zq+n91LMM0mtwPO63Ebb7/EeYtijv08oqHEXGA+bHoyohg2esPsEgF6JHqQzWRae0Oy3A2OUm/BWnaLONN2E0zCr6GK7X5K0mX4zpv8VY/6CLTI2ewaPkYLhJ00/b2Mza+Ueo82Z0Qqpa6DCDXrZeI8Jwkp9HPx/Y1/g5plO3wnkatDxMsLYUxfQxU1zXHUr8oSqhkWxJlSIAAOFY2QZGy2R1mJIaKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAUWZTI3cBPdoY4BNnwpgO3WU7BxoW4iCiNiLw72uSI=;
 b=UaYZKnesl9lOs/r/R0q7zxvoq5s8UAw3tVfPvnDA72jTiciDTLldjD/i+QqICZsidO6CaLCABieNthYCOd3KbDIN/wt3G02Xgu0zXgl9w+++1yj9eRpijVt4QCOWo9FdAlDUGnLCUce+D9LFHeFHt/JB3IFflCpiZmT8jeHt4KA=
Received: from SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) by KL1PR02MB7613.apcprd02.prod.outlook.com
 (2603:1096:820:11d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:57:39 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:8f:cafe::25) by SG2PR01CA0142.outlook.office365.com
 (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 12:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 12:57:39 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 20:57:38 +0800
Date: Mon, 19 Aug 2024 20:57:38 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Tangquan Zheng <zhengtangquan@oppo.com>,
	<stable@vger.kernel.org>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <20240819125738.vbjlw3qbv2v2rj57@oppo.com>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <ZsMzq4bAIUCTJspN@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsMzq4bAIUCTJspN@pc636>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|KL1PR02MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: a439c2e0-1893-4791-f15d-08dcc04e818a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ssqj6826UMTGQEvlXGDCTUEJRJfz3kmYvIrdJ8TU+KRZkp9BYI0j+bXJUKK7?=
 =?us-ascii?Q?esGyZyrkTom3Zxn1RmEoZmTj8jpWqEdnqPLlEQep2QzCIaU8m60UFQFIZvzR?=
 =?us-ascii?Q?p5e+wJDrL8xkIRoQtxxOEQX92wSPlgucgunVgNTVbNoBWlGlaalKsmnYmgYW?=
 =?us-ascii?Q?c/APy70WVpjtCnD/BRSGgrCGFXfXYHVAa+eW8K0PR/9ro394cBtNXI9SEZlL?=
 =?us-ascii?Q?EUK7WZNvWBAgkWF8P1h1q/pIY5k1EB574EJSVAobtfBGnkQjktT46yJ60aUM?=
 =?us-ascii?Q?Yo6rEYG8WkHsZ6a9uTWXf0R+H91gSG/4yG6EUwuFuFw8Bv7ARgMcqT/TL0ZX?=
 =?us-ascii?Q?lFO7VxSlmfCvr0oKeV38xa1H4uZPsQjvl+dGRA3Pv/5Iv64PFKTywpL3F7Xo?=
 =?us-ascii?Q?zPNTetqyFqFaYwxHpMC51Rb+pdOVV1m81DF54A+oi8dvKBRcdIhGllKshegP?=
 =?us-ascii?Q?oGrNoz7CG7cVSBYXztBYVmDy9bzqaPk+Bytj8hB5LZ4DaWZ11gZlDHZAaMix?=
 =?us-ascii?Q?py8HYs7+1iQ3v/SbeRNADVbAjbV4H6KSlNIhxF6Jv/4592nIMr6H8T2wFgID?=
 =?us-ascii?Q?m31ILvmqPOSUOBnJbDN3IJ3vLLqq5l5gBsvsY9ZpGOg+t4RhrX5LeNvglNu6?=
 =?us-ascii?Q?lKjrAIfrChf8XOS2u6R/hKYVMn8lLQ5n+lWuxxbuYyu5M0RceMqar7uwjr2k?=
 =?us-ascii?Q?Gup05TmLUBOVWefKkn7Nc+zbzW/9T3md5UQWEP+skaDd6pmoIC1bZVxLzLb3?=
 =?us-ascii?Q?ItMyo4HuW6Xdmk8XWBueFX54YLS0MpNmxzKr3yd4ZgK0ShdUtrTl7PEHe+5c?=
 =?us-ascii?Q?Q/ncqg8LDhDHaGoWk+U0LwIfPIQkFVZLNk/5Cq6UIAM6nr/hQfMInMDDKpE+?=
 =?us-ascii?Q?pgANmK8+q5GmvqQ4HC8rEoVrSV8dd1ZoltD5+KoC6kNHJMscuwpHy/MFA2fk?=
 =?us-ascii?Q?ccwUgAWe2MJ/BhGp2Bk9fGpO76g2Gv7y9sx1FemQLRgykKfOcBl6HZeMYIkz?=
 =?us-ascii?Q?jqHT/nBbHEKjuExxu4Ie1wEf+YT/ZbckPZUkpS6FiJ125bP8KKLjZKzU3MFa?=
 =?us-ascii?Q?wkGunRa+KdjJ5Wqdr0UNASgMMjapfNAWMiJay3wVSlBgYq5Y23hAYPgyA0U3?=
 =?us-ascii?Q?SAVlhCg2g9w94CqfG0CDgcjucvpI41djPnX0kvT87w8jAXszqX2Z+9rSKsoo?=
 =?us-ascii?Q?L+04k4h0izPrHk9DQE/SVfzQKL/tc3Y+En7lBUa14kHwTQTSs8JFzc9UO2ew?=
 =?us-ascii?Q?iAN5xXm4/XUjHbkxCDb/bbbkg/b+Uhg5Eyp6+oyy1bLyFQezvpPCQEE+EHiM?=
 =?us-ascii?Q?Qu/vpdiVWsai4gmagIgf0i9+GbtQrwDiR4wpDmb0RLhUZ9G/Ndf6JgeaqjPu?=
 =?us-ascii?Q?hKtPN6PZWmM5ZPz+mRpTZdaTig8mg3Y0RDdeOcBzUdQKw4K+0bvdvthsD7CH?=
 =?us-ascii?Q?ESgeUpLbxBu8/3dhyUaJJbiCeNW0YZaa?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 12:57:39.2178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a439c2e0-1893-4791-f15d-08dcc04e818a
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7613

On Mon, 19. Aug 13:59, Uladzislau Rezki wrote:
> On Fri, Aug 16, 2024 at 07:46:26PM +0800, Hailong Liu wrote:
> > On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> > > On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > > > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >
> > > > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > > > >
> > > > > > > > because we already have a fallback here:
> > > > > > > >
> > > > > > > > void *__vmalloc_node_range_noprof :
> > > > > > > >
> > > > > > > > fail:
> > > > > > > >         if (shift > PAGE_SHIFT) {
> > > > > > > >                 shift = PAGE_SHIFT;
> > > > > > > >                 align = real_align;
> > > > > > > >                 size = real_size;
> > > > > > > >                 goto again;
> > > > > > > >         }
> > > > > > >
> > > > > > > This really deserves a comment because this is not really clear at all.
> > > > > > > The code is also fragile and it would benefit from some re-org.
> > > > > > >
> > > > > > > Thanks for the fix.
> > > > > > >
> > > > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > > >
> > > > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > > > to order-0 should be commented.
> > > > >
> > > > > It's been a week.  Could someone please propose a fixup patch to add
> > > > > this comment?
> > > >
> > > > Hi Andrew:
> > > >
> > > > Do you mean that I need to send a v2 patch with the the comments included?
> > > >
> > > It is better to post v2.
> > Got it.
> >
> > >
> > > But before, could you please comment on:
> > >
> > > in case of order-0, bulk path may easily fail and fallback to the single
> > > page allocator. If an request is marked as NO_FAIL, i am talking about
> > > order-0 request, your change breaks GFP_NOFAIL for !order.
> > >
> > > Am i missing something obvious?
> > For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
> > the flag correctly. IMO we don't need to handle the flag here.
> >
> Agree. As for comment, i meant to comment the below fallback:
Michal send a craft that make nofail logic more clearer and I check the branch
found Andrew already merged in -stable branch. So we can include these with a
new patch.
>
> <snip>
> fail:
> 	if (shift > PAGE_SHIFT) {
> 		shift = PAGE_SHIFT;
> 		align = real_align;
> 		size = real_size;
> 		goto again;
> 	}
> <snip>
>
> --
> Uladzislau Rezki

--

Help you, Help me,
Hailong.

