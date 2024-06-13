Return-Path: <stable+bounces-50645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CC906BAE
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E779DB2459C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EF7143C61;
	Thu, 13 Jun 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="RTyvoXL7"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2057.outbound.protection.outlook.com [40.107.117.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3C143C5C;
	Thu, 13 Jun 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278972; cv=fail; b=aPay6n8ynI0JemT7/B2i+JQktLXjU4aYUVRvbGQQlgQ9hoYqIURoxSmMiXcaNaXv9RJmmpXQA16Xc1PpQ3wsovF0zX/Ri+dMkNQuIfjV1/flURcJslSyB4Mrn8lgu+1wyaSL1lIbu49KCmAXCZrU5RXF/uBlIK+ax2hOn+HCsew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278972; c=relaxed/simple;
	bh=o/IN1zUw6ZTCvui/JtGtquoAMJA6xV4G/uUI8NNPXo8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYNBmAp2qtJ6mPjHSklSqOHUVO7n7sxufx2IkTJh3ID9B1TscrJwFwvBSwjtGm/dE7ODB1iPFosPQcDBtYYX5MnhAcoQGbhYN0It2jhHExIvM6MZo7UYmMd455B1laNLCP92qfTTes5iLssGqvfeRM97fMS3ij0r9b/cqFKMdh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=RTyvoXL7; arc=fail smtp.client-ip=40.107.117.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDijf4yuOmMcXoKb9nImWIsLNloI3wPWk7SufOxMvrEFrJ3BChgpqKhTBmwBu9ytMBJ/lSWgaXLZ+TP3QrQboSP/1LDWZG5TgMwsUeB3ke02ZHiMD9QZfWE3fwJdqP6sfsG17eA6HpGrqq4lB08XD63z6QWZjTfHZa048QrVWTh0axo/9LAzSwgZ5usBeKVI5IMIRpX4kctxaac2k1oCbmxndBAN+dbNdtQiOwZtkqP2SGP+ZvKD2G2e3dXHbpQFHsBJw6GmZHrkzE0uVNve0sQh4vwuzAPxxo1RPx5g3fU1sLNCgLhsEj23Q1BtYHOAQhfhEa/rGSmVRkvSfdAX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/IN1zUw6ZTCvui/JtGtquoAMJA6xV4G/uUI8NNPXo8=;
 b=QiLAVynYF8qvoMGRFvEN8X8kAu4ThWiOujSHw1jXCAPLGcntWZjNfWYxNEJK8eDm/8b2YgrC7yPNYTLgQX87KrmYoUoyTF30tKdxDiWkucf3kjcd26/A5329hByn7LLZHwNGlzIDB7WDPPKMhnV253TUUGoroKdcG3LErkg0+S6tXPLYlEMzrawUmblCO1AvzQAaqG5wwl5J5vQSnRvR7JVE0InuxcOayZICdpjOeZJYZi4sSOsocn0eaKyXfBMv0LiDo3dfld2lV6E0D3Crd32PCFnqTUuN3i8RjW9ym4KMI09//tnCqqeo6+m+vuJpZzhAD5eCTVj/OqJGBTbOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/IN1zUw6ZTCvui/JtGtquoAMJA6xV4G/uUI8NNPXo8=;
 b=RTyvoXL7VjswzOzE5N1S9vovzGEIPTb7JVHdnqCoMuCnudtjcS/gzHMV8Cgddkvt2H0cfqp7CcVdjGm3BvLlBvy00LUJY1PLITNCjZvXyzQLB10Vda5L3RPmx5EqygBVzmVXVXaHirD13JnjlwCzkH4wd79GTFiyJVYjnQac+H8=
Received: from SI2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::16) by
 TYZPR02MB6293.apcprd02.prod.outlook.com (2603:1096:400:286::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 11:42:47 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:190:cafe::2d) by SI2P153CA0029.outlook.office365.com
 (2603:1096:4:190::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.15 via Frontend
 Transport; Thu, 13 Jun 2024 11:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 11:42:47 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 19:42:46 +0800
Date: Thu, 13 Jun 2024 19:42:46 +0800
From: hailong liu <hailong.liu@oppo.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: Zhaoyang Huang <huangzhaoyang@gmail.com>, Baoquan He <bhe@redhat.com>,
	zhaoyang.huang <zhaoyang.huang@unisoc.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Lorenzo
 Stoakes <lstoakes@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <steve.kang@unisoc.com>
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <20240613114246.3lmmeckydtdmvf32@oppo.com>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
 <ZmiUgPDjzI32Cqr9@pc636>
 <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>
 <ZmmGHhUDk5PqSHPB@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmmGHhUDk5PqSHPB@pc636>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TYZPR02MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 236078c3-ae44-494c-173d-08dc8b9df2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|1800799018|82310400020|7416008|376008|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlVwOUdvSVUxam9ueEFjNnYraTZqVTFCb2Y1cGV5TWVTazV3WnI0NmRxYjlm?=
 =?utf-8?B?K1NaQ3JUTVUrdEJBSHdkQ2NhYUl0b0k1R0Y1OUpnWEtpdnR0a1h4TkZXVjNP?=
 =?utf-8?B?eDYxWENqVlhLMGNHZ01GUGMrZHFtUW9mVGxxWVhkYzZPS0ZYRHN2T1RuTGxT?=
 =?utf-8?B?a3o5N0RSV2V4MVlubEVTbWQwbFRLb0ZFOGVlWVRpU1lpSEpkRTdyek44aCts?=
 =?utf-8?B?RTFrSTZtdGF5U1hxbTkrMVBsQWdBSUN5RDR6aXpTR25uRHNzYk1YWW92TEl2?=
 =?utf-8?B?dmNnblAyNjB3TEM4enRqbTV1ekVlZXdJQXZOR1hWTm1ITUhFUTRIMGxLZ2lk?=
 =?utf-8?B?YXgyZ3JhTUVyelVkalZSYjRydDgzeklhVXFJRE93NHovK0ZjR25jc3JzcEUz?=
 =?utf-8?B?a21lS2tmQ1hZZGkzMmZ4TXJLRXI5UHdDVmdWOUx2clNNaVIva1grRkZGSUV2?=
 =?utf-8?B?Y1lSbEZBMmdzM3VzRDNsUlg1Wlo0VmRPeG1kYTc2clFmeU1Ka0kxVDN3dUR4?=
 =?utf-8?B?NStNMzRYZC9vNGZ4RWJGaEJPYk5HdHpid2lCTHdvbWlabksxZmJQZjdGcnIr?=
 =?utf-8?B?TTQvSmhOTEp0QlZDSnNxMUYxM0cydjlScXlYYlA1dkxKb0NIU3pWRDcrYi8r?=
 =?utf-8?B?bVFLSjdVeUxDdEV2aEtqNXh0WTFZR05ZalNndlgvL2l0empsbVVLNFFudTcv?=
 =?utf-8?B?UlZVNzg0eVFmQmgzaEFDQy9ydysxTXlNSVBzam9aNVJrRitTVm90L0ozeS8r?=
 =?utf-8?B?dmZqZ0tGdEpLblczdzNFTnJPWUNWelROdGI5U2ozdFB3SlRLM2JCemtNRGxx?=
 =?utf-8?B?T1VGaHJWMVJOMUxQSUpmTG5OSzdwaUI5dUVzenhkVFd5ZnJBMEwybVRIUmgz?=
 =?utf-8?B?TnB3QlNQUVQ3UlJDRXZsQVRKaHE4bGhpMHFFSnVlclVVaFNmSkh6WUQ5TmNL?=
 =?utf-8?B?VlZidjF4dWhNYkw3aEl2ekhHOXJkNFBPMVRUSUNKNTkzbFNYZWZieHRVcGx6?=
 =?utf-8?B?Zml1U0hzbWh2c1JoWTU5ZEJvTjhjZVNmSzZwWUlUVWFXSzBVQ3RxSGdOWFQv?=
 =?utf-8?B?V2NJTWx1aGpXdk81a05hRENZN3F3THJFVWxFQmlzekZLeFYxN2tmYzlaRjll?=
 =?utf-8?B?c3FwN3M2c283dld2QlFwYVVkWmlscWhaNGpUQXlCR1l1N3VQdTVQRDJLQ0lM?=
 =?utf-8?B?MVRsd085ZFRzajdLN2xJekZkeG5PVElEWE5TQm1yTVVYbFBqVE1nTEludE83?=
 =?utf-8?B?bkVobjdidUNjY1VHajg1b3hSL3BWR1grdk9FN09KWVUrbVdyN2hoNktQck45?=
 =?utf-8?B?dC83NW04V2tpcSsrWVFOMWxFeXNxRkZZYjZHQzczZEkzQmhueWpNUXBWUm9V?=
 =?utf-8?B?NUZMYVNqTzJwNitTZElFSXUrNDR2WmdkeUh2VmRPbzQ1SGY1N25yRUZsUTl3?=
 =?utf-8?B?bUhTcUxrZTdKWG14MS91R0pjMkU0U1ZPZWpCRktYNWxJNkMxNEN4WldGQ0VV?=
 =?utf-8?B?M1hZMkVRajNnc3pUcjhKU2NPbThOTDR5WmNVT0dtQ2tFS1FXYkNDMXBDWndH?=
 =?utf-8?B?eitDZStra1lTV0dCS1o1eXBFZ1NRdlE3TmhPUE1MWUhKYXpOVkFSSTRaa0FS?=
 =?utf-8?B?K291NkwzblNzR2pMcFkwZFpLUGxiaFBnb29nTnhKbm1lQVVCT056d0V2QnBC?=
 =?utf-8?B?Q1pKUEphNlQ1OFBUMlMyL1BpejlMWHZFWVFwTHhvREFDMVRjTDJZQW56U2cw?=
 =?utf-8?B?ZmhpZXBDcThvS2JMY3BKRXVCUVZOYlZsSXB4UzR2U3pTNkh4amFCNHk3WjlM?=
 =?utf-8?B?L2R6OHlmZFVkR0E3NnpDYUdUN3NjZlg2bDV1VU1TY2ZRWlVJTWpsMEU2TXNh?=
 =?utf-8?B?ckpQTUZiWW5Tako1bU5reVg1ckZRdXFVNnZkbzl4dzBYTHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(1800799018)(82310400020)(7416008)(376008)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:42:47.5509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 236078c3-ae44-494c-173d-08dc8b9df2a2
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6293

On Wed, 12. Jun 13:27, Uladzislau Rezki wrote:
> On Wed, Jun 12, 2024 at 10:00:14AM +0800, Zhaoyang Huang wrote:
> > On Wed, Jun 12, 2024 at 2:16 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > >
> > > > Sorry to bother you again. Are there any other comments or new patch
> > > > on this which block some test cases of ANDROID that only accept ACKed
> > > > one on its tree.
> > > >
> > > I have just returned from vacation. Give me some time to review your
> > > patch. Meanwhile, do you have a reproducer? So i would like to see how
> > > i can trigger an issue that is in question.
> > This bug arises from an system wide android test which has been
> > reported by many vendors. Keep mount/unmount an erofs partition is
> > supposed to be a simple reproducer. IMO, the logic defect is obvious
> > enough to be found by code review.
> >
> Baoquan, any objection about this v4?
>
> Your proposal about inserting a new vmap-block based on it belongs
> to, i.e. not per-this-cpu, should fix an issue. The problem is that
> such way does __not__ pre-load a current CPU what is not good.
>
> --
> Uladzislau Rezki

mediatek & oppo also have this issue based on kernel-6.6,
The following call stack more clearly illustrates the issue:

[] notify_die+0x4c/0x8c
[] die+0x90/0x308
[] bug_handler+0x44/0xec
[] brk_handler+0x90/0x110
[] do_debug_exception+0xa0/0x140
[] el1_dbg+0x54/0x70
[] el1h_64_sync_handler+0x38/0x90
[] el1h_64_sync+0x64/0x6c
[] __list_del_entry_valid_or_report+0xec/0xf0
[] purge_fragmented_block+0xf0/0x104
[] _vm_unmap_aliases+0x12c/0x29c
[] vm_unmap_aliases+0x18/0x28
[] change_memory_common+0x184/0x218
[] set_memory_ro+0x14/0x24
[] bpf_jit_binary_lock_ro+0x38/0x60
[] bpf_int_jit_compile+0x4b4/0x5a0
[] bpf_prog_select_runtime+0x1a8/0x24c
[] bpf_prepare_filter+0x4f0/0x518
[] bpf_prog_create_from_user+0xfc/0x148
[] do_seccomp+0x2a0/0x498
[] prctl_set_seccomp+0x34/0x4c
[] __arm64_sys_prctl+0x4b4/0xea0
[] invoke_syscall+0x54/0x114
[] el0_svc_common+0xa8/0xe0
[] do_el0_svc+0x18/0x28
[] el0_svc+0x34/0x68
[] el0t_64_sync_handler+0x64/0xbc
[] el0t_64_sync+0x1a4/0x1ac

I placed the assignment to the CPU before xa_insert. In fact, putting
it afterwards wouldn’t be a problem either. I just thought this
way the content of vb remains stable. With this patch, the current
stability tests no longer report related issues. Hopefully
it would help you.

--
help you, help me,
Hailong.

