Return-Path: <stable+bounces-69322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7F954833
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 13:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17E4B229D0
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224A719412A;
	Fri, 16 Aug 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Kl52zXl0"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2081.outbound.protection.outlook.com [40.107.117.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0F155726;
	Fri, 16 Aug 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808798; cv=fail; b=CEJ//tSl5y04AdvT5t5y8vrHaQul+s/2rGObQgLnWcK2SsLGv5nnLggK+F4H6ioc+NqpGGc4mM0cay9zfH0ZY6vQZ8HK8J8QzhR3aufiLjArHPhKuOPDzZjMS8ZxaMjuI1zdUeMGVhCC+1K9BaCVIhwynzYjbr8/l1cI0tuvf4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808798; c=relaxed/simple;
	bh=RpKQsJzhrXy/tWkzsi4WuU9mSJJ5u8FAj9iaY16rgWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLC+nmPA0o62yIAckiA6QhCK3IY8JeJyQTuonNm5OfT+6hzCe6tWvUvwaS6VSnG0YKIpHpH7SeT2bHQyzn+l/zP0ebPRWJ+49LxildXb6SxkTu06YpF7RKW/VSu13bFsWWHlMd6MBF752ZjdE0wy45MMGET2lJQ2bZ3Jwev99N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Kl52zXl0; arc=fail smtp.client-ip=40.107.117.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrbeLYRh30U1t6D3Smiy7bxAk067g1GwSlYDczSan8dmUni4II4RiCS2aa/NNJud0wT/itnNlyYDy0wS0/IKb/lw/1xYqbxN4qasFAjYkFP21jJejDJcwZSIj1aqjncgWAqwUY28hiiWkPgmBsFmIc8gQJosIGDmrskVxPO2HO43sbvWfxWIGy5q4KNZ9TasTsJE+Ifv1l//iteIc/6xRxh1NmnvO9t+v7zBACUeMzdKa6GFtjgpElCVMKllLjsy2mvIBqZlu3W+NaqbGjrLO3YVOSI3SiSsCN70XAlZijJFTXP51PaABrVK8uHBsmUcrQQqyJegIo6mFIc1Hc38ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZeS7C0dSse1jmhHclyd8W2Th58WHVg3vNviRVZGArE=;
 b=JNMKU91H/mtLSz/RsQHgTP3p3caB2P3+JkXgHNpAAGXaTaRTMl/JGJmmcebcRs26gw3jQPtXYDWvFWCqCWCsADARR7DZ+owR+859Kzd/MMOPGeopNUE7uSCh3R4TxSQ3joA/6LhoqZNuHOmr1RkBu2ENyh+r5EQhu0JNVkLqM0ktE+Vsl7tAeOVZgbaGkU/IX2CkBP6BzCWijE0OlP60+m6TAaNq9bFUYtxE0vO5tsII3IREWQ3X1P82jftYroFguOyPLM6orpAGE0EgmiAXrHAvQlE3ahZZH9AwOOltZdneVq3DzocD8fC6wj+wDE1S946LZ9ts+7u4Uu7IPvK+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZeS7C0dSse1jmhHclyd8W2Th58WHVg3vNviRVZGArE=;
 b=Kl52zXl05Y7a/GkqMLjAciSkTimaTgn1bw4miRqPruh1vmB1CI9OD18a8abfKAPRm5ERO/kaVmGWMeVrioTxgpY3yMwgxYlJCsK10hfoRXx5IxBOBfJ+be8fT+u7wIM8HOASLqwtICqVxbrqL1nIVNgRybmyQNkyWC8N8ioRQko=
Received: from PSBPR02CA0007.apcprd02.prod.outlook.com (2603:1096:301::17) by
 TYSPR02MB7578.apcprd02.prod.outlook.com (2603:1096:405:32::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 16 Aug 2024 11:46:33 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:301:0:cafe::9b) by PSBPR02CA0007.outlook.office365.com
 (2603:1096:301::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 11:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 11:46:33 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 19:46:32 +0800
Date: Fri, 16 Aug 2024 19:46:26 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
	Barry Song <21cnbao@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Tangquan Zheng <zhengtangquan@oppo.com>,
	<stable@vger.kernel.org>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <20240816114626.jmhqh5ducbk7qeur@oppo.com>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zr8mQbc3ETdeOMIK@pc636>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYSPR02MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b12c48a-cddb-4dfd-b2cc-08dcbde91391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xx98F02asHyAzZ/xEZ7Qk0aM1GC+6BF9S93o7WMmWWBby0Kv4/hkCiRcxL2t?=
 =?us-ascii?Q?FxFEw67ehTWq2/WXtONGcA1cVGMyiDHWavDNn/i+WosL2IFdIu3og3uH/Klb?=
 =?us-ascii?Q?TxCaBKoBs+QVxsbs1+FVZy8pcuP517SeS3JHncjUsS8nCGX55bI3EN2b7Yaf?=
 =?us-ascii?Q?0qxU6GhHXM5j5umGUNkDb5j99xXchd9rYqY20bN9kWTy90c2CI0r34IUF7TX?=
 =?us-ascii?Q?Hf5k6L946XoKxcRRsNwdBX+gk095JK1/Ye0xe7z6kYvjtZD90ZNenCBByHqD?=
 =?us-ascii?Q?RUJlnlk93FObKoTUCA1bKj36FzQQqZhoK7n60i2G2XkXInmkW8XB6/ylv9fD?=
 =?us-ascii?Q?nIU2jX9TDMzuG97j3n1mgnaD3ARsVyAOFgrVS6dQvrkaoXWYsNwk8htbwATn?=
 =?us-ascii?Q?VcCoYOBR9fOsUkHcCgJa2P61Vib3GKdAD0wMfBtfpyc2XUxgfdg9dPAWCn1A?=
 =?us-ascii?Q?ZnrjN0MkozGydhKrRBKWn2V5u8DXqlOyB4M/yZc9jMiKKx78LWFJIohG578H?=
 =?us-ascii?Q?K4fPvGE53gY/H+cNUOhSEBvopyBNWDkXH84XS7w32QsfmxbAHoHBG17nqPm1?=
 =?us-ascii?Q?IZ1yy7NDMQV1nKZWhmjoHzk5Zpz3nGUXYlxh9h7CwNmIFoASG+c2HkWUDzCZ?=
 =?us-ascii?Q?N3vpu7jSoAPcR2dTHYxCzB5YrZdOm+NXbn7F/xpbPoczIKzNu0apOnGUIDjA?=
 =?us-ascii?Q?aQYr4bMgyj6Ek4ySM10P2tPjEIJc7qmI1Bfb0sqPZ4KsnzwxyOXkCkikSCws?=
 =?us-ascii?Q?uwxY6g7SlOrY876hbir7pi/sMxbNfMCz5gPdeatyihPTbjhkYkcgKKJA5GoK?=
 =?us-ascii?Q?BafHbx/d4WIolRR9aJn65COCVdndbOa5Ewx3rjCc3ujKAG5UHfoV5Cj+dBqj?=
 =?us-ascii?Q?DmZcqVwbrS3SM377e0zpo7uqOugHRkh5+xvkEYdgp4qgD7FYLD+iNrMdSJ3w?=
 =?us-ascii?Q?te2+aOwZGJNJ9jXzVVp+TIY9ezKRJjKCZ6T/ZI+0k335Py17RElr9NeqR5tT?=
 =?us-ascii?Q?eZJ3pUIxhKmuXFWGoXrMMP43UfJKwcPx7U4rpuPVvrsEvI2ZPIE8UtoTEPf3?=
 =?us-ascii?Q?u3nQ9kghg/wSgsQhKE4AIEcLOJQI82q6x8PJUEaHuKdHjVui0QeRbg+a8r0z?=
 =?us-ascii?Q?OyL9kMSl1evTSSCPZh1ZBcl/0fregPICsUe+qnns6COpdTO8WpkppLocFPOP?=
 =?us-ascii?Q?fECGLfI0RK1XiBA6Dzvm7l0SLZ3bS2/GDFvRrEDwf8fmxD17oP7NTT7UFPXn?=
 =?us-ascii?Q?sn/dzLsBqgPkSfeEB2S+6TX/jiccOx6F8Qy222DUqvATVOLxzJ+d18wJClZ5?=
 =?us-ascii?Q?rk2oIcnqt+aOkk5uFFNjaTOriNngKc5cA8GLU21r2tq17XCPYXgbPVjI0JQR?=
 =?us-ascii?Q?nTXOUBT28YfH6BgJyuvDxChHqGjheVvX2VIqSxaWYGRBmFrUfFfF9CeCRhVw?=
 =?us-ascii?Q?lWnmZnQArZCJFiGI58u4tLYmALFKR7PB?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 11:46:33.1394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b12c48a-cddb-4dfd-b2cc-08dcbde91391
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7578

On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > >
> > > > > > because we already have a fallback here:
> > > > > >
> > > > > > void *__vmalloc_node_range_noprof :
> > > > > >
> > > > > > fail:
> > > > > >         if (shift > PAGE_SHIFT) {
> > > > > >                 shift = PAGE_SHIFT;
> > > > > >                 align = real_align;
> > > > > >                 size = real_size;
> > > > > >                 goto again;
> > > > > >         }
> > > > >
> > > > > This really deserves a comment because this is not really clear at all.
> > > > > The code is also fragile and it would benefit from some re-org.
> > > > >
> > > > > Thanks for the fix.
> > > > >
> > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > >
> > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > to order-0 should be commented.
> > >
> > > It's been a week.  Could someone please propose a fixup patch to add
> > > this comment?
> >
> > Hi Andrew:
> >
> > Do you mean that I need to send a v2 patch with the the comments included?
> >
> It is better to post v2.
Got it.

>
> But before, could you please comment on:
>
> in case of order-0, bulk path may easily fail and fallback to the single
> page allocator. If an request is marked as NO_FAIL, i am talking about
> order-0 request, your change breaks GFP_NOFAIL for !order.
>
> Am i missing something obvious?
For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
the flag correctly. IMO we don't need to handle the flag here.

>
> Thanks!
>
> --
> Uladzsislau Rezki

--
help you, help me,
Hailong.

