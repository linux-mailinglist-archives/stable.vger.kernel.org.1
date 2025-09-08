Return-Path: <stable+bounces-178903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1715FB48DD1
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 14:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AEE188D98E
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DA92FB083;
	Mon,  8 Sep 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VsomZU4D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ug7eVRTL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48032147C9B
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335286; cv=fail; b=sPausWOGbwHNPeNhnR8diqK84qa/KXBhyTHu2AliRL9heCX3naQugzrVue2IniIBMDXa4YcgKmjKNwJPWZs6Wd4EioDg4rtvWddST9hve30OfTUi4zH1vSSmuSHJURh0VzUUyQARbgDlTt4LPEFyNx725zHq4/S9FNQHWCmh8cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335286; c=relaxed/simple;
	bh=8I74Ww82RgRrB0MDPsm4PHPlvGmq7dhCC9od0lbD3eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JlD4SZZdDZWduftkwX6x4671YW2DcTF4kFU9ahnc9+8ZS7hZ9BK7gr0mtiHOyhKV8Xf9rPEFy5WVis2Iq3tkBiry/J9VEAP8u1ojXeVF7GCU3lH5WFx3TSua4yVLxfJasXI7tjEUOSpIXyXMW0m1mgzeL51f4ME1k5LMnW+Gysk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VsomZU4D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ug7eVRTL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588CZ0fS025343;
	Mon, 8 Sep 2025 12:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iChlG6nw0CPcyMb5KX
	HkYongcKSxZfS2MMSN9S3o22A=; b=VsomZU4DhtLlijwYxao51EgjttpWrG0+g0
	qIzorGgypjnF9yZaBcKrwpnmMZ4A0jjTSduBUY5mRepu7nSNX0/FXjP89W0zX1pT
	wEPpXlnMnvIEqOSzeZmto+L66qYxS1KsA2QcGTyjtyOJWep+S6R3xbC5ZowW79oo
	4NGNCVFghpCM5QN4p11npKEPd95vMcjpZOpd50JvB2ruzS7kiPzcT78SC95zayDG
	txf4h0i4OIXLsdvhngaQS1RdFMNxTpP/ozA6d/80EQjYNudWZBFiepTeT9z8FLFi
	NPg2w5NtvdYkAFuaswh8jzAKM5x7SEnhZinmq8GTmzClTCTzT72Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491y92r0a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 12:40:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588CCqN4030781;
	Mon, 8 Sep 2025 12:40:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd84cqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 12:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRTKHrMquvVqVDDAxg4/yC/LHD2tjZpJJy5bXB6iYsyilrUlWUGzqcbIsI5Detl3ASFH4GF7TFXQEekcQ8msQBDn2vjP3r/2kYddhDDZjHGnLMCs6AKz3fcCk3Ne6kt4yBF+iPYbTOJLsFJf6m2HY95TQ/oHUyaYNtFXM6QXd+34Ax+MQ/F+MXCdOHttqlm0frBvpAVNmCuShRRptD+o1DfusXctWNoKQwfjdm/tgerwfIJWZJBPsZ1D/yZBZhlavCVYfl18KpGNZcdmH0UBrGHB7Nbr+3465Y9AP9ZcgGUsF0oW7yt26dCWXRpaxm0QxTzBplrcp1FlWT3VBR2FJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iChlG6nw0CPcyMb5KXHkYongcKSxZfS2MMSN9S3o22A=;
 b=qyXMtVo4kupl+Yhp/tV+CfM7WsM0YhO3yDUfe4OqisRM7kf/4WKrDBE2DpHQe4APGk7U89YoH8dNeNZayZYnifcoBG8WT3XT/JpZDcG3iMdHD86GEEj7lADTM2wSXKD/zNjtAYrfUNFIS5RT5FuGosLLdadMmKwX99Zvc0E3utzIXHvpoPEveFCExAByLkNMzJ86WdGwptcjK8S6P2JpqqGkXA5SliM84tyGyKABSFMNqudiThYgMGDhde9gFVL9Wl7TkdGLdFw2YrtzZL4baZm56xQcUKP193Af6i+dFDI16k8oJkefrKzfeMP2TB1DvueoMmGwFN+jegVgmZfWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iChlG6nw0CPcyMb5KXHkYongcKSxZfS2MMSN9S3o22A=;
 b=ug7eVRTLOqxXG5S9tQk4mzgjr2y7C359nX2hTjN+lGiyTmkVcwL4SGyRMXi6g3rEJHPPOSCX3QUVqbDxS9x2JclFh+e+oSsgbHZV222rtYTcbv9cn8WZro3Wz/kkyyC0B+bZQBH/xAnOCFOKzl0oSqZO3iB7HUjHrFgyBVqhWCo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 12:40:07 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 12:40:07 +0000
Date: Mon, 8 Sep 2025 21:39:54 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bibo mao <maobibo@loongson.cn>, Borislav Betkov <bp@alien8.de>,
        Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
        Dev Jain <dev.jain@arm.com>, Dmitriy Vyukov <dvyukov@google.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jane Chu <jane.chu@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <joro@8bytes.org>, John Hubbard <jhubbard@nvidia.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleinxer <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH 6.12.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Message-ID: <aL7OmhMtdLTGiVSp@hyeyoo>
References: <2025090602-bullwhip-runner-63fe@gregkh>
 <20250908010931.5757-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908010931.5757-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SE2P216CA0171.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: eb32b5d9-cbee-47c1-cb7b-08ddeed4d757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JMwk5QIvT011wN6gBROjOlmq5TARqfnokfeYqlvIiwZcUkqrK6pIK5bficdc?=
 =?us-ascii?Q?dxlyrknZzbzruZ+wda5kklXHo0mFS7og5pGKQuGcPC+442PabkC6xUnehfmQ?=
 =?us-ascii?Q?SoNZcj3yHakmI4GIPjfKQ+dqjbod1VJUOKBFdqqNCJHP+TJ91Zndhl/++rHY?=
 =?us-ascii?Q?PTDGWL+8C2wxHCDIRzLXb5SkQuWUIdr+ruUX3sx7PkWJ6UOBm+krL1fdG2om?=
 =?us-ascii?Q?jH415ryMJqXakbXKqvW88J/HipsvNNXU5iYvhkOuyHaB8eEYSt3CCJcpC8L9?=
 =?us-ascii?Q?9PRFau2mrnfrmk8JY0A+jGJ/C1KD5UufkO0owOkkFKVClkKLttJo8AFWDQex?=
 =?us-ascii?Q?umnC+K/klHiMpkUKXmYTgjlOp3ywWW7MyOkYJX1ZnQQLVb/bceG5E7MrhqzI?=
 =?us-ascii?Q?fhPnVcLR+2Bg7pyfd1udKOb/zPC/og/kSdTsXZ/VWnY17axFR9Wubr2pvBIl?=
 =?us-ascii?Q?aLX8LtCpJcwQWWzMflzRfn7jd8vkBXrKgnDko24/ijOI6cg2Di6GihupjdvV?=
 =?us-ascii?Q?AvXTpBeE3KgQ472GG/0s9QBuGrB35KAc/D6qblwtWkad8LH3qoHkOOGJC8ly?=
 =?us-ascii?Q?UNrMQabX8GhfMYWcilQRutrNd0xqFRKiN5wsNbt/M1c4u6KnAdDXDcHyTXZ3?=
 =?us-ascii?Q?1yr2DqILafhVc8IDn/g9d3CpDzJQLUbUmIbi1JcDe1hPY/NE7zTUzcQ/ghen?=
 =?us-ascii?Q?LXAhWovpP38B7TtxA3m3Yrzu1WUpM5p9GdCMxJpGkBAFWu0wW+0KxESaCOvr?=
 =?us-ascii?Q?prWPc23Kbdp6pj+z/jc05zSBNguvBdaRlw4Rc56svLLdxFMMEj82pp5g3cVr?=
 =?us-ascii?Q?qM4JukKFcJcQWB3DhDbs8o86csJY8rMxzMlB3Lu8hzISwAb8vQJJ3Nf8djnG?=
 =?us-ascii?Q?AsCwAYYWR4D+0TYLVk83UAiuCE/H5iP70DC/86L1l/ozp9QW3C6851g2M9SW?=
 =?us-ascii?Q?rYbCS/o+Br0+CouRrbY8m4EoZwjXEzZSZyrI0w1D5yvwAdcT4tGrRumXyfQf?=
 =?us-ascii?Q?C5RqhMzhgO5BHTNmFRFCG9G7aSxSPAUpUflvbN458LI025FMrmGJKi8fXUQR?=
 =?us-ascii?Q?OZkJCQGCyIFDCcOaMF74s+anwLhcdwlQOYm+u6/n9+4gaJ1gv+buLGVqrM5A?=
 =?us-ascii?Q?RqlGn4K42nTzgdXYrMU9UI4qtXsc52QnWsdt1WQxr21CFpFGKP+KW+yZT84T?=
 =?us-ascii?Q?3gbZmfxIR5iB7rDT8O/XKCuondq+n6f9UvSjPqZiPx6Lf00upt/pDJsWc85/?=
 =?us-ascii?Q?7zf24BZidSWeAclYC0lUwmGA6+03TAQb8+FH+NAZ5hK9wqms4oMQpMokbjjU?=
 =?us-ascii?Q?T53nZrN6GVeL8ffBVULpNkIQxHgmBbIgeToxZ6imu8CNQt4kQ2S1hsvuwGlz?=
 =?us-ascii?Q?TZ/p/MH8pxQXzxk/9+wLWCiCdvfFTjSU66930/7jn6ALwhkGyNM/Rfl+FQl/?=
 =?us-ascii?Q?PUjnABkyhso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yU87QGwu6xdjeS1W/QzQGoLFWFxgCy4FcvhNCuIOkcrn2j0mR0Xv9Lo4hN31?=
 =?us-ascii?Q?12zvxxlAi937ozDwWHSIgFsinu6llqFbc2H6jo6vB+jAPF5xfJeQ7Hlpw8lw?=
 =?us-ascii?Q?P4skzi04NdgyCVLE6t3nKsgA40RaB6hSBQx07wT53Ac4dmo0rLAHXcpw5nRS?=
 =?us-ascii?Q?3pwxi2S0ij8jVMAJGjPNkz9snUdWI7LdzRAwPWb7L0ER0Ai+yoqkJV//TFTS?=
 =?us-ascii?Q?e4VtLxB+hNduLeDj2aoDCinJ7EvauQGEbqvX9KJR6f1eg+T/QyaI+0Ezkj8s?=
 =?us-ascii?Q?xG5FtvlXhCbOQfCt8qWBMGyFgv+KAyZy5GzyD8tPbNEH9ofeknpBY9x9L0bQ?=
 =?us-ascii?Q?4gzKXcc/VyBDC4vv7gj7/OSaoCS62xBFOe1A+tq7/aRKjoB6ZeCjGTYSZhxU?=
 =?us-ascii?Q?1BiBjBoc+NSHJ6rA5eI0XPvLAd35sDaXwz5J7XqBsc2O4sbw4QJ7YEfq5nae?=
 =?us-ascii?Q?Pl7UHBYfj+mpXsGAQDCNdjp306vpp1XZxqBE2ESzGT7cAyd7bABOj1aDjapk?=
 =?us-ascii?Q?EWoFgnIJmDB5VYbuS7niOXnVDY9qMdnZzacPpV+x/VfRLGonQZjkIB77AqAB?=
 =?us-ascii?Q?APIhSg7OEqmgmP7acPDMo0Xjlwk9EhR+qolaprgk+MiAI6SWLnhYNkMX4eGD?=
 =?us-ascii?Q?NTG8iGMvLU2Xb7a/8uEaeqwOg6+3+4A99FNvMCrgqHHexEdjeila1pNtEmz9?=
 =?us-ascii?Q?knW/H2x5SIELazujkD9KqdG8YMdY2tTAREFcSZAPCNFFa5HMcW0iaUUruxUR?=
 =?us-ascii?Q?Bysl5+GlTEOv/ybkKYblvDW9ynzALSgb1TBsn8cUXAFjZ6ZZ6+euzvj1RVxr?=
 =?us-ascii?Q?ehLeIeureYPILBOUgnBUqZTsOP8P9qfybFe2ZYgxDDqH4IG3WuPV2iw0ykEl?=
 =?us-ascii?Q?hyEFqh77LKlrSX7qwn1HhtmyJV6/zKffHq7hc9G4oDj11tmjv5K8rVdE5rZ9?=
 =?us-ascii?Q?OOM2Sw6ksOi2eUlj+1d88dLmyp6aPxRfexeoDzu5nJXWKUujD+OqwQ1XbsVs?=
 =?us-ascii?Q?gblQc1WHGoq7GUC2QC2UrQVe8p+7U8TCfjmeq8VvicsYr8MLKl5rO1PHbz9G?=
 =?us-ascii?Q?V8NIRAJwclh3+UMZyjIISoYv5OVlkHgUqKb/PtqxcDN4w335K3RiM1dYUHeA?=
 =?us-ascii?Q?2Vc9Y87dlmFIK/syIrI7FehOdNSTS3IbWb29NCUU1+6/PUEgGvgSHlbt0Sp6?=
 =?us-ascii?Q?M3EFvDgGk4OrpumRjrE3+IbVodl3f7VVCenS+4gBe+Ps5Wh9gKcx6W6lMLbw?=
 =?us-ascii?Q?yPMkZN7piDwBtjC3QkgH1kxPfAiTK152UJB369hJBes7S0vhXCNcfgJD0gkt?=
 =?us-ascii?Q?P37HdXk4LUdErB9wSrYrViRaKhNO+wMWCi8eLk0KHB7aFxZQ093xXdWBNJgX?=
 =?us-ascii?Q?FOhPOf3G+cJ/kySQMYPzCnTpoU+a9CnlPh6vmQ92CBCpWCNcn0PZzWf5wJkj?=
 =?us-ascii?Q?ozh96dFgW0AMUOPp8DrVwIwIQ/332tNdIJul8q26bDgu8OH885JXUxeEDtCv?=
 =?us-ascii?Q?qQir16RFTfz5Mz9QNmBBiECT/tRTrOdOHgjyH+Jrs9yo+8HS4qFzfmdXHIJe?=
 =?us-ascii?Q?7NFRHQSSFn1dzhmjeYshl+cNyvOSJkprtCYfVgcC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4FaE+f1LqLH2emcgTJlvbhXoVOjgSJmZ8GzwLwFPnapgx1YGpiqCIKZtatPeKCBiI2dgj5ASO5fssePvobxVaf0LnofXzfB7RAK26ZfD06UCVd4q1WJTRHuZ80kmozhnN41mcMGd6XOGk9oR/4RtUmxPPocpmcJyaxRDc838YwUcmuQcDd3DdNBZJKvOgMbrrASPkXg00EHpRIN6tNg8JxeoyFoWv/Tg/j9+VGH0KCeP1jyL4dYc4/mLbRGanDLZEERkaQaH8TrSdJdTTg5+stin0z1CBgJjO3ROKNLKxZh3DE85O3A2xnaBQH2+D9jynW9Eq0ehxwjcJbvGO67iJsRzWI70VqXmd0FkTlqXSRuR56Bf8GDHME9ggY0n0kEcPf3sUTDQSNZU9EcyGaVyHdRLuzlkt/fNLvu2p5hmknsdmDQ+volEWICuZK3HUBOOuvird0vOHAcG3EfZI7v5Tl/d9lU1G5DZ3KbSnsbazR6IDJRux3ftWj2rlSGGmODi2GHor+Wie8m6hOow0g5FxIB871cR02CWaEjOxDAFYXEL6Qgju6xOALGKSJyfdDlLOHex9HmJIDLXCO8Z7W2Tt+W1xFWMFyzprOVdq8fOkC0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb32b5d9-cbee-47c1-cb7b-08ddeed4d757
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 12:40:07.2567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmG4AK6hQIq2mwKWEoMuHCWa3H0d9bBxBr+wnFCmmyg7L2dXDs2BiHKmdSGTHPI+c7MPeNyOPCpPtWZbzDeszg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509080127
X-Proofpoint-ORIG-GUID: X_crGRkQffqY1M395uDFBEaY-BBtwvQ5
X-Proofpoint-GUID: X_crGRkQffqY1M395uDFBEaY-BBtwvQ5
X-Authority-Analysis: v=2.4 cv=K7MiHzWI c=1 sm=1 tr=0 ts=68beceb1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8
 a=tA7aZXjiAAAA:8 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8
 a=Z4Rwk6OoAAAA:8 a=o7gT1H_IBfpwrv_jtfcA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22 a=kIIFJ0VLUOy1gFZzwZHL:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyNCBTYWx0ZWRfXwTOBiCPmNSBW
 D0ng3IovV1DMP5tf9UU0z6WQDojE8ry8A06iE35ivEzwrv+JfPHHW23NmcHuGVOnAV6hFroxZdh
 Th/oLkq5dwmMXZYj7dVloZG/E92aY5yu7FbkAjhY8a9Q5s4XCEbc1pG6iBrssrSpjEA8HrcobpY
 6UV5K+tUDEKSats6+JHILiZxcjzcXbP0YaQ+9cez8kGPQ27+64yj1TIEUUuujM43r/5sR6Vsq9K
 3l6sd6i6lw7GA4p/9XhThRTxcwBpfRpTYCiJfWCwFcZ4qPnPTbwfEEIzi2hcftAw+Z7BjKhQCTG
 BSGw3zlts09/ikFcp5OmofdWzetAbDHjxj8ugyVpfXqxuXV5vqvzCDshotLA8jUXrxsTHA0zMGF
 Y04kP1Rl

Please don't apply this, I made a mistake while backporting.
(Thanks to Pedro for catching it!)

I'll resend the backport for v6.12, v6.6, v6.1, and v5.15 tomorrow.

Leaving an inline comment below on what I got wrong below...

On Mon, Sep 08, 2025 at 10:09:31AM +0900, Harry Yoo wrote:
> Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> populating PGD and P4D entries for the kernel address space.  These
> helpers ensure proper synchronization of page tables when updating the
> kernel portion of top-level page tables.
> 
> Until now, the kernel has relied on each architecture to handle
> synchronization of top-level page tables in an ad-hoc manner.  For
> example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for direct
> mapping and vmemmap mapping changes").
> 
> However, this approach has proven fragile for following reasons:
> 
>   1) It is easy to forget to perform the necessary page table
>      synchronization when introducing new changes.
>      For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
>      savings for compound devmaps") overlooked the need to synchronize
>      page tables for the vmemmap area.
> 
>   2) It is also easy to overlook that the vmemmap and direct mapping areas
>      must not be accessed before explicit page table synchronization.
>      For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
>      sub-pmd ranges")) caused crashes by accessing the vmemmap area
>      before calling sync_global_pgds().
> 
> To address this, as suggested by Dave Hansen, introduce _kernel() variants
> of the page table population helpers, which invoke architecture-specific
> hooks to properly synchronize page tables.  These are introduced in a new
> header file, include/linux/pgalloc.h, so they can be called from common
> code.
> 
> They reuse existing infrastructure for vmalloc and ioremap.
> Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> and the actual synchronization is performed by
> arch_sync_kernel_mappings().
> 
> This change currently targets only x86_64, so only PGD and P4D level
> helpers are introduced.  Currently, these helpers are no-ops since no
> architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
> 
> In theory, PUD and PMD level helpers can be added later if needed by other
> architectures.  For now, 32-bit architectures (x86-32 and arm) only handle
> PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect them unless
> we introduce a PMD level helper.
> 
> [harry.yoo@oracle.com: fix KASAN build error due to p*d_populate_kernel()]
>   Link: https://lkml.kernel.org/r/20250822020727.202749-1-harry.yoo@oracle.com
> Link: https://lkml.kernel.org/r/20250818020206.4517-3-harry.yoo@oracle.com
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: bibo mao <maobibo@loongson.cn>
> Cc: Borislav Betkov <bp@alien8.de>
> Cc: Christoph Lameter (Ampere) <cl@gentwo.org>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Dmitriy Vyukov <dvyukov@google.com>
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Gleinxer <tglx@linutronix.de>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
>  include/linux/pgtable.h | 26 ++++++++++++++++++++++----
>  mm/kasan/init.c         | 12 ++++++------
>  mm/percpu.c             |  6 +++---
>  mm/sparse-vmemmap.c     |  6 +++---
>  5 files changed, 63 insertions(+), 16 deletions(-)
>  create mode 100644 include/linux/pgalloc.h
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 1ba6e32909f8..e7d5c02ac0fb 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1343,6 +1343,23 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  	__ptep_modify_prot_commit(vma, addr, ptep, pte);
>  }
>  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
> +
> +/*
> + * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> + * and let generic vmalloc, ioremap and page table update code know when
> + * arch_sync_kernel_mappings() needs to be called.
> + */
> +#ifndef ARCH_PAGE_TABLE_SYNC_MASK
> +#define ARCH_PAGE_TABLE_SYNC_MASK 0
> +#endif
> +
> +/*
> + * There is no default implementation for arch_sync_kernel_mappings(). It is
> + * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
> + * is 0.
> + */
> +void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
> +
>  #endif /* CONFIG_MMU */

This is already present in include/linux/pgtable.h (due to "mm: move page
table sync declarations to linux/pgtable.h"), and my backport mistakenly
duplicated this hunk.

-- 
Cheers,
Harry / Hyeonggon

