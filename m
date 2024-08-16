Return-Path: <stable+bounces-69306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E4954538
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 11:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF0B22ADE
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC913C801;
	Fri, 16 Aug 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="UuWup3DH"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2076.outbound.protection.outlook.com [40.107.117.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA87581B;
	Fri, 16 Aug 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799565; cv=fail; b=mtZZ7Gfl0JRWdQ5ge8BF9UCilKESLmZxkRInpDxEHbxqxS3IiYrymmy+/9hrw8ge1yjQW4lsyXOI4+96gdPKLl8C4Py1J1CoFiZtqzQy2EumRfQQTIsTrEF2SAwweJX81V+w1/p5nbNTdDU9MmoLPp+tn7dsOrWrbJq0QtyYtSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799565; c=relaxed/simple;
	bh=fx8mhbNKRlWfgJM9SBpm1uER3ZlFGyn/j4klw6wMEBg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geNGWD0DITmvHEFEyCo+SjcVImp2LAB9S59+N1zDSmCJusccqmHYtZAlgJKAs9zuEQQJCRQPU2jwhgAQKHfLXaRaUXkXPocHfXD5UmG4lHxMccCaaXKQDmCO5d+ItKogeMRKzdT0jVtYZvdTAvdwLaIYg67asFCSdRxzPIZSI14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=UuWup3DH; arc=fail smtp.client-ip=40.107.117.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcUuat7zq0H02u8TjKz8JjR7gAw0BYe75Icr0XhnXZXbRI9qpsIaKdzVCS0TYurqqxDGl8K+ElW/PLV5xpWic/WnJyymlKk4PBLMmZQRchWJzvxO25YNsmr5Ya41KPxw7AS0NBCDdhCB3QCDUio2BdpIlzRWKq0CI6zyTIBm2yg7IZ7KJzbCealCH69pQrYvPwS4f9KT4uGA4tS9S6OhDBwz/CqGPYuKSuTennwcm8wojf+T02oxYEGYCU8a96+36noIOYCUfs1w5ZnJOpxOzU5xBeXkVyaSha1GO2CPu8ovnF0xqPXr2V/CmD0CrdskLw+Q+whuYQHjpnLmHXfzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY9QOS5fN3AZlL4R3zdWzY382CXbfWPb5wa+SD0wRjg=;
 b=vLrpkXD4+z9ulQkU/H/CAxeVDsxqb9zgvqT6NfHKTCGXBvUeDEs1M9liw+yoYBSZCy11Fd0XxeT1R4B11DXGQb2cM7cheXm2LKXSgO8zrUxQZ7CKdoCDjzzQf1DMQ3dQEJd8qjGxu0UtdSsTosAKNsV6cWNkQTbP9EFSd7c+oga/vqOle1oGlHX/5m1wt5RdsZ3rLPLFVQ/Vtj8fqkkai+8K6ZbPj2tx69CjFyzRmII0RneRlemHX+WIL81WwVHaIj6VITMxi3LITNJJq4OP7s/6jCA3FY9x1IkbCqm//tNkkBSvBxiMBCSACgG1j7bBBEhCJd1bBNUkVMAngsRkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY9QOS5fN3AZlL4R3zdWzY382CXbfWPb5wa+SD0wRjg=;
 b=UuWup3DH99BccC7PDEwTksOhNv6ktNoM3gYX2MVc02xZ4LD9JrOwm5FEiAyyaAt6HxqVBji2w27tSF50VcyW0fMDLX9+hrkdVn/UnYq4f6Q/UlNC6DoF0GP8WBh13IgGTV/5P0NuHwzdAlRXz6cBYShq8RDmDX/NbzI4xxmUohc=
Received: from SI2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::10) by
 SEYPR02MB7067.apcprd02.prod.outlook.com (2603:1096:101:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:12:39 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::8) by SI2P153CA0017.outlook.office365.com
 (2603:1096:4:140::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10 via Frontend
 Transport; Fri, 16 Aug 2024 09:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:12:38 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 17:12:38 +0800
Date: Fri, 16 Aug 2024 17:12:32 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Uladzislau Rezki <urezki@gmail.com>, Michal Hocko <mhocko@suse.com>,
	"Barry Song" <21cnbao@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	"Vlastimil Babka" <vbabka@suse.cz>, Tangquan Zheng <zhengtangquan@oppo.com>,
	<stable@vger.kernel.org>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <20240816091232.fsliktqgza5o5x6t@oppo.com>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|SEYPR02MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6985adc2-2f9a-4a67-254b-08dcbdd3937b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TxPAzu/sLQM3YEJM/zIAUexJuRXlHLpYXq76Oda9p4ZSK+vPNCfjIxNFN7YP?=
 =?us-ascii?Q?PdPUQMUp7Rn8/8feXA6cdIUUQuTWXz1iZr6d+7wgP/YiC+p+9PqHBuu52QpE?=
 =?us-ascii?Q?C7evlxv2b89qEN/2nz8qp4c6R4P6bbuKIta00+XsRySYy3u3wkypbA3A8X5p?=
 =?us-ascii?Q?UlZuWaWPFdzmtiGiCfZ8VTGwDdPy1pAE6GHCSpGCBtvLYRsViHVoldnkpmKX?=
 =?us-ascii?Q?OsUSwERkdLtwK1VXPoqAzCKljl7d1mLtfbyNMk87DSjQ0MoUwOeKZGMqNF5b?=
 =?us-ascii?Q?9ll3ALIXfV54THPYib98P5VOXXr9uX6diHWkiHMUgyjq+5Oxd594J2N/lHU6?=
 =?us-ascii?Q?pqZcLQmE3huMCti4i6xII2S1Uqff3/IpLBDcZTdwMw90KtCy/b2mm/Ylt6rN?=
 =?us-ascii?Q?/c9xaMy0hcDzoGQbAuvQ9jcWbjZwZ1R+3B1NHSZ2vQiRCSHE53OzTkXu9bjY?=
 =?us-ascii?Q?ULLAMMsjRtVHDKker68SmY7XcdFe0dfwrYocpUHKrU5HOe9/6cur9U2VjHmN?=
 =?us-ascii?Q?+l0dmRqQqTKx1nALftcgNiliSqLtt1MLXkdP6E79P7ayogbVN8c7TzmPPegC?=
 =?us-ascii?Q?dm+I0o1G51bmyp1uw0HcclakgHW8UdCnYKz5XPR5dLfzrN7J3aQKmDAJi18o?=
 =?us-ascii?Q?hotM4CXoZl7XQOehbReZyZyKmucdr2LfIWbOUCUfUqWx2kppqnn/ppavRacC?=
 =?us-ascii?Q?ID4uGB0qy44So40+DvoS2Z3fom630MnxZ8aTyCf8nV7i/EmPOFqsGI3WTt6d?=
 =?us-ascii?Q?3FQ45zji6xmk/ZHbv7qvpxcwSST4P3cAHZ7AmHhjr9eix/WXOxgsx9t+pL7b?=
 =?us-ascii?Q?AwoK1NAfY6RhHNu7xtouni2ln9KUHV8T6ox33kly3pq8PwsBqwcBYP9KkDUM?=
 =?us-ascii?Q?6Kylg1UGOQSRxpSdwAg/xfU/XEcRM9azdWzm5nNWr/tfj3jSxqvQQxufMVNa?=
 =?us-ascii?Q?P8r7biSk20TvU5fH1HX5N6TSkeM7pxtLQh/Wyrp/v3C2dygoWpVa8yJRz3s4?=
 =?us-ascii?Q?ODbAdmTWn5YTiJMsNviQfWMsuB/kl06tMTtozfb0IQJvC9y6+su7rxiHdzBL?=
 =?us-ascii?Q?vvpiZA6fmjJO6EBivoJhBfQTsXuF5i9D6wrK2ZsyWRlkantGG0S+GFJC4jBU?=
 =?us-ascii?Q?KNDrqA2/QFFjgeqK8QECk8AsVyYOZgH/Yrg4qxzAHry6DYg0/r2PExTSDWXL?=
 =?us-ascii?Q?KMc7Xnw5/SPuQ/CMrVe7p+CCZyy2+66IkyGfWcDROwmZLzb+gAPMCAIxN4AN?=
 =?us-ascii?Q?M6Og8B1YyeqJdTTJqggzwhDYcdaI/1IcvQniQo66y4fWc+9iec0gWEYWowML?=
 =?us-ascii?Q?iDTkFHrMjtJwdaxCt7vzPNo/edR3XmU5xTw6y17f939Ucyn/IK359O48bcrY?=
 =?us-ascii?Q?JkJ/wshS1lpc2+DOO07CzLK/LRzwpaF4vPQB20pouZH8NBj/K7VNIZrvsKOE?=
 =?us-ascii?Q?B5sOgaJoQDJolq/cYmzZ8xFT5pl+nVOX?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:12:38.8900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6985adc2-2f9a-4a67-254b-08dcbdd3937b
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7067

On Thu, 15. Aug 22:07, Andrew Morton wrote:
> On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > > > Acked-by: Barry Song <baohua@kernel.org>
> > > >
> > > > because we already have a fallback here:
> > > >
> > > > void *__vmalloc_node_range_noprof :
> > > >
> > > > fail:
> > > >         if (shift > PAGE_SHIFT) {
> > > >                 shift = PAGE_SHIFT;
> > > >                 align = real_align;
> > > >                 size = real_size;
> > > >                 goto again;
> > > >         }
> > >
> > > This really deserves a comment because this is not really clear at all.
> > > The code is also fragile and it would benefit from some re-org.
> > >
> > > Thanks for the fix.
> > >
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > >
> > I agree. This is only clear for people who know the code. A "fallback"
> > to order-0 should be commented.
>
> It's been a week.  Could someone please propose a fixup patch to add
> this comment?

Hi Andrew:

Do you mean that I need to send a v2 patch with the the comments included?

--
Brs,
hailong.

