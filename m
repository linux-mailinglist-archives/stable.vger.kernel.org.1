Return-Path: <stable+bounces-50479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1648906839
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3823C281679
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C341113E04A;
	Thu, 13 Jun 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="SSVqO/jI"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEE913D8B2;
	Thu, 13 Jun 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269877; cv=fail; b=VEd6Uyh84WkT3Pe9dB0EM7s6svMFQ3a5P0lYe9Eq500/JcjbYztOp8s+O08O03q8xK2MqcOTW0LgQNeX8ePRuwLnewmoI1hh6o8JsAGFzi+VQksR95NbtCQTB2qqyQEFVzMMhud7WF3oGv+6aX/pr6lUdYGEB/AT9WoJnhS7tHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269877; c=relaxed/simple;
	bh=7sjjSFQywCt7jSBX8NAc7fV60e4i44xgOjvk2jo2Vhw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0B1lF/SKlhWpYBhJ5zOt1XM+v6AhO+CAI1WXFdTQ20UN87e5HMGi+4C10qia0UUeGU/mzgD1bAVYdSwnXFzIFvZLcdc0H4eUuym65CT4AVe0yrukX0JT8eawwBxEudkPOvnGBooWx7gYT+enOA0CclHbFskA8/I/vJ3JRwJtdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=SSVqO/jI; arc=fail smtp.client-ip=40.107.255.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0wVhswaz68E1qDEC39LVLukxS/IAjQPIeMnWXZpXs9m9gqEZ8r0elLHSac2TGhqunQ3/IqodIgOrxwW8IkZRYNzOquA4gBGcB+yLLImmlPEpPRiL6n+FjH+6PsIBDhz4eY9HGhw161y0qxfm2NHCB9WCuLmmCnFMXtHTV9m0xhhsXGvRZzUMpV79BpE03VGWiv57isc5uJg7VUA0Bf5ZqaloGGI4LxnHa97IbANSSLgyIxPfxLNm27k/O/HE2JQjR0SDiv1VtqrCFJkvhQwzFN66MH27HXKUDzOnpZOtLksoK/TuPPNKFdobsOaZj5JntXkfJu34q3j49bCHJbpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sjjSFQywCt7jSBX8NAc7fV60e4i44xgOjvk2jo2Vhw=;
 b=PuoltwHduhTeB5FTWH7Y6gSXfE6QNoZtpsGg+yEF+HgQXJ0hG4qRkwlXMsBna0qqWf+UQmWej7xZI2xSrO/M3WH7gT5tn5Ad9ttE4AvMR/HWKw7sJ2HoeuO603+rWEbBfFG8gQaUAYr99DEJ9k3TF7Y1+94xUOBKvkQQDpiXzE8NV5pGcGsseSe6wDFRfKM0/YxuVfN085jsWPwVCYCqoLh2U7VmhYv5YosWGmkxLEgZzp4dvEE29c5u3lKdVENxAfaUcBy/dmDO3HqR3HQ9akLyYpGaGHkT2ppusuYtdso2ad1LVR9lPP4IciNXvhr0jKrGf2pdmYahYbqtZASglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sjjSFQywCt7jSBX8NAc7fV60e4i44xgOjvk2jo2Vhw=;
 b=SSVqO/jIch/nlJjua1oYhR025L72B9DPn2dyj1oIX5zn/Q561EKIu7dnxYDDtrBnvkYt9JXBM6oaUascGekmJXg9/KTNr6Bo3FwpoM5xN0OeExWEdqvGWjt4UCQtH/ooKAg4UeE5kYRCwQ3LOwBeAAHRWmhlG/2pHAjisql3nuk=
Received: from SG2PR02CA0018.apcprd02.prod.outlook.com (2603:1096:3:17::30) by
 SI6PR02MB7945.apcprd02.prod.outlook.com (2603:1096:4:241::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Thu, 13 Jun 2024 09:11:12 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:3:17:cafe::e2) by SG2PR02CA0018.outlook.office365.com
 (2603:1096:3:17::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23 via Frontend
 Transport; Thu, 13 Jun 2024 09:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 09:11:12 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 17:11:11 +0800
Date: Thu, 13 Jun 2024 17:11:06 +0800
From: hailong liu <hailong.liu@oppo.com>
To: Baoquan He <bhe@redhat.com>
CC: Uladzislau Rezki <urezki@gmail.com>, Zhaoyang Huang
	<huangzhaoyang@gmail.com>, zhaoyang.huang <zhaoyang.huang@unisoc.com>, Andrew
 Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <steve.kang@unisoc.com>
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <20240613091106.sfgtmoto6u4tslq6@oppo.com>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
 <ZmiUgPDjzI32Cqr9@pc636>
 <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>
 <ZmmGHhUDk5PqSHPB@pc636>
 <ZmqwvtZQwYLNYf+V@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmqwvtZQwYLNYf+V@MiWiFi-R3L-srv>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SI6PR02MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 13694598-8edb-447e-cd25-08dc8b88c59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|36860700007|7416008|376008|1800799018|82310400020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3QvMVY2dUkwMDZiTmphenRBaHM2dHhCNlJsY0VrcUZkYmwvUGFLT3NweVh5?=
 =?utf-8?B?SmdVU2M1TE1XT3ltdU4xeGVIMDM4R3E3WmxGaVBMcTVXYUlqZnloZVlJSEx4?=
 =?utf-8?B?MmVDcUdJTFJNWWs1bkFuMUd3KzI2aXQ5UnNtZVE5ekh5dXlDU29SR2g2SHhT?=
 =?utf-8?B?a3JqZjFubGszS3NsWFhwSTM0dHJPdDlwcDRneGRPRjFnQmlBNzVtcVRKOFp6?=
 =?utf-8?B?M0tvWXhXYkRmNDZyVExNZWhJaHpCRlhaNk1leVk1alhXRHJLVS9yUlE4V09R?=
 =?utf-8?B?SnkyaHAzV05TbnBoNXJLVkphOUhIL2RXNnRCSjNyWUhnaXFiaTNSQVE5aGV2?=
 =?utf-8?B?aXVXbk53djlFR3dJVW1maGJGUjc2TXBGTUgvZDRrQUhud04xNUdZNkkySitQ?=
 =?utf-8?B?eXBIWFhHYjdMVmdiendxbFBzNWtmSG5lejVvUUJ6QythaEVmRzUvSUJ0ZkVC?=
 =?utf-8?B?VWNXZVZ3QnVHdDNoS2JqN09iNjhIUkNmMlZrWVF6QnpBd0lGYUliRUtXcGdQ?=
 =?utf-8?B?VG4wcXpPWVl3SlQ5eFFNTHlBS29VS3plMW85ZStISFc3MGtPVmowT3hJemgy?=
 =?utf-8?B?NjIwd2ErN1hSOE5JL2dYMTZvOVIzTTRWTURKMUxneWtIbUhFeG8ydkYxYmxk?=
 =?utf-8?B?MnIyQzBjeTZkVDZTL3dML1djYnUvOU1BeCtzTk15L2VwK1NIUjVMMmJoK1l2?=
 =?utf-8?B?TlpTZ0RxSWJTTnY3dFhBd3IyNHNwMkhNaFFOYXdZNnp2NjFkSFgwVDlpOXBI?=
 =?utf-8?B?akFSdjdRWjBVekFaTHhNMTdXTXdXa09LaDBXRmU5bGVReUt4NGc1NEtMSk44?=
 =?utf-8?B?NmlIdE5WeXU2V0NvWllnZFMrZE9oNEU3VVVhOWI2YW1JbVBEUmhXZlYvcFpF?=
 =?utf-8?B?L0txMysvdW1yOHBKcEJLb0FQaUZvRDlKdmJWNUpjc2JocndDVkRGelpXTmdK?=
 =?utf-8?B?dDc4QUd4SHVnSEh5OVhISFM2SVRUQm5abEdjbjRad0w0ei9GSFVlRnhtMEw5?=
 =?utf-8?B?a1RoL25Od0lYck51QVF2ZEFEa1Z4TXovczlobG1SKytpTVBNWTJhZGNXeEF0?=
 =?utf-8?B?OVlybU83R1hNUnlldlBkSld5NTN4VkI4VW5rWHlqZHBFczAzK2hPWElnYzl2?=
 =?utf-8?B?MENYekRvV0djejc3amZuTnMyazA5SjdzRmlMb1c0TGRuelR5c0ZYSTdvL1hW?=
 =?utf-8?B?bEF4cFNVcS9jZjJkcldpNHN5VDNyQ0ZqNmRwVlNLREdKTUtjelNseEhjUjE1?=
 =?utf-8?B?bENlMkEva0RZNXR3M1hDZW8yMTM3L2dsMk5McVNJaDJPU2xPY09QZU43RVpU?=
 =?utf-8?B?a0FZaVRwVkU1dlJzMDFQVGVjZll6cXExbXA0djQ1NktCZmtPWVFhUlF3YkI1?=
 =?utf-8?B?RURWcksrMHZrdm9nL2ZGOUpkcnh0WHU4U05UaVYwbjZzMEFsMzVYUVRDcXdG?=
 =?utf-8?B?bG83L2szYit4R25VTkcrNWxaQWhiRWxuaCtOeWo0NW9FWkpZUVlkYnBqcmVh?=
 =?utf-8?B?eHB0dVJ1OUhmV05zcGxxb2M3ZUlHZ3N4VWpXdDQwdmZ1Z3I1NHdkdmcvNDBG?=
 =?utf-8?B?N2NCMFpyTWRTZDdrVmJJdTc5NGRkUXhRVlhNSU9HR29EeEdYRUJ4VVNqZjQ0?=
 =?utf-8?B?YnI5UE0zaDlMVWhkZ2VoclE5VXJURStoMEVBNURyeElXZDlxbnd2b2J2WmtG?=
 =?utf-8?B?QzJ4RHNERGtKRnU3Q2x3VG5BQ3FEeTNKVU91TVVqVksxZ1FjV24vQy9VcmtF?=
 =?utf-8?B?M3FWd0xLZy9nRWVzbFpFcmwzMnJtS1BRaVJRd04vZVEwNGlRWkllS0ozTHdl?=
 =?utf-8?B?cEx4MkRwV0hVdzhydmZoY2dsTWFxNzZCbXdaRFJQeHdjcmszY3BJMytMZlBZ?=
 =?utf-8?B?ZEFGSVZKeDdhdGVLd3NNL3AwV1dlNitMTWhZNmZWTnppUXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(36860700007)(7416008)(376008)(1800799018)(82310400020);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 09:11:12.6096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13694598-8edb-447e-cd25-08dc8b88c59d
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR02MB7945

On Thu, 13. Jun 16:41, Baoquan He wrote:
> On 06/12/24 at 01:27pm, Uladzislau Rezki wrote:
> > On Wed, Jun 12, 2024 at 10:00:14AM +0800, Zhaoyang Huang wrote:
> > > On Wed, Jun 12, 2024 at 2:16 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > >
> > > > > Sorry to bother you again. Are there any other comments or new patch
> > > > > on this which block some test cases of ANDROID that only accept ACKed
> > > > > one on its tree.
> > > > >
> > > > I have just returned from vacation. Give me some time to review your
> > > > patch. Meanwhile, do you have a reproducer? So i would like to see how
> > > > i can trigger an issue that is in question.
> > > This bug arises from an system wide android test which has been
> > > reported by many vendors. Keep mount/unmount an erofs partition is
> > > supposed to be a simple reproducer. IMO, the logic defect is obvious
> > > enough to be found by code review.
> > >
> > Baoquan, any objection about this v4?
> >
> > Your proposal about inserting a new vmap-block based on it belongs
> > to, i.e. not per-this-cpu, should fix an issue. The problem is that
> > such way does __not__ pre-load a current CPU what is not good.
>
> With my understand, when we start handling to insert vb to vbq->xa and
> vbq->free, the vmap_area allocation has been done, it doesn't impact the
> CPU preloading when adding it into which CPU's vbq->free, does it?
>
> Not sure if I miss anything about the CPU preloading.
>
>

IIUC, if vb put by hashing funcation. and the following scenario may occur:

A kthread limit on CPU_x and continuously calls vm_map_ram()
The 1 call vm_map_ram(): no vb in cpu_x->free, so
CPU_0->vb
CPU_1
...
CPU_x

The 2 call vm_map_ram(): no vb in cpu_x->free, so
CPU_0->vb
CPU_1->vb
...
CPU_x

--
help you, help me,
Hailong.

