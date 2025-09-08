Return-Path: <stable+bounces-178852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7AB484EF
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 09:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDEF3BEAA4
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADF02E426B;
	Mon,  8 Sep 2025 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jn8F/yVq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U6Yln2/5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0F13B2A4
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315931; cv=fail; b=g0S7yDSufUgptak0pMuPc9weqBxhvhwQUX6tN7Wr8abtc2iHq1DhZ3bGBah1pIswcU29gIgTVQvvzFjtc7UQVFuWvBB+CregCRLIHdVuxsaGtj52gt8/MH1hJf/Q3KFYPmAjI7giXwEjSKzwYaOrqjtWqIdlKritOYDulw0pBAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315931; c=relaxed/simple;
	bh=k+eMddOBVDM/iYG3YD50WseIE0/CbK+YBtXPZLIUx3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVEUDuMV/3DVMJohF0MeeLd0yUjMr217DFMOGOV3hpLXfPMiqEZpHXZYa4BMM8bnXWPFDpdw8Zy3n7Zqid17q5wpJcd1Ozm7czL+BvmuQejx5VNG/Q1dvUuFVlgOM/Z6k9PoHL/FS9QrRuVEJ5OTULCYdywU5SfoqE1N7XQabcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jn8F/yVq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U6Yln2/5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5886tvDM025320;
	Mon, 8 Sep 2025 07:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hw8Y4ZP4OqjNkNpn854Pgh5cf7P0aCNS6s77dUI7LZY=; b=
	Jn8F/yVq8QhhYVIcH55yhp76Mr/34YaRjMI8Q/jpJ+vySSTs6C7M2QRfpypuIRtA
	niJfoJk1oCqtBfEyoGo1035LmeI0oy01uwGb8MZZu0lSv88pkXVUPbbCC2SlE7bu
	cvxz42/HtWJTH9qFtUYVPUpNxqHvUKQ/Oeghf+gEbZZDe5nsqrgLKKY3m57O9GCI
	cbcRo7f99YJ76tCtKSMzxQ6cAMsfFSKWAJw8/ZMz1LGGiCLHjP5l6jvsbtnJN/ge
	k/9A2Qx2ZHOkZSOeF4bHgsTkSJNH+Jk4A/MTN5ytsLmayvKscYg1fei5twRrxqGn
	hg1E7TA31YBGgYJ019RT7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491t9pg1yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 07:17:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58868KCR038759;
	Mon, 8 Sep 2025 07:17:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd7tdmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 07:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWBYdIjVUOMtNI9zlZCHzEW79eTURFXZqjeBrao8/mjl6VSSboR3kZtwUhJ7sdXX8zYBNghAvZC+svfIw2Mp1v7Gvy11mkP2xf7yBRE+Yq/Bc6AKwLRVJ6K1ga5BSm162vZyKzVujru/mlk+4KkWz/3hEOdV+2aApq/2QHQ1zMxS2lIEBeQB8jh0w8RoKNHaasXnZDiesAyYGm+x2Kc/wCWyuelQwYxIqeI9/HMpDCCB7nP3rjqfEqsuGmrj1WHyhaToR6tw53zaHPtY/rzEj6ERI2wi8cdsg/Kk0LYRv8QkHI7WjeWQIyHXFoKmp8NTGqhMe40IApy0A2EkXbnidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw8Y4ZP4OqjNkNpn854Pgh5cf7P0aCNS6s77dUI7LZY=;
 b=itSrWfSIxU699XQwkZIYYCd7G8W9ySI0164bV8BdFTghlX2+cw7uH7NMKpmDzsxInbWCQEPUWmzzYHcReJOXn/dw51DRvnp2Ji6padp7bLAbbFSq2xseYbyKWupDf61K5suvmRLa1HwFNcx/Hjixn3oZUPQtmwLKpbOczDVrNxxJE5/kth6NVqPT5h2A4VE4SwsktxyG11YqwgfVgQr+5YcYWdqR+jx/BUaT8GxZLZKZwlbrg+N4luFDPD+XBkXxvaAbZsEYupf2znCsKW4T56Yh+tD3pFkMpXRzJy5vA5Kw0tzmLMkajF/1pkw/fVX0HRcvG2MdnqzKbu1hModrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw8Y4ZP4OqjNkNpn854Pgh5cf7P0aCNS6s77dUI7LZY=;
 b=U6Yln2/5kuIXgsUUrY4Jw/lR+V+vPVcA+dlf604y1uYAv7IFISKnjOiB2WKnNVu1hzQ+5NvJISx1kNYgDVQ2lL43dhhnJ/V/yrLPx7weGhV1ULt6GE0vE+SJJtTmfOFFrxQEXDXSkZ6oGyqQoXXKH9G2zMn7LL07lvlScrU1V0s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4626.namprd10.prod.outlook.com (2603:10b6:303:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:17:37 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 07:17:37 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
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
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Mon,  8 Sep 2025 16:17:24 +0900
Message-ID: <20250908071724.102571-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090606-overthrow-bagginess-c68f@gregkh>
References: <2025090606-overthrow-bagginess-c68f@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0122.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4626:EE_
X-MS-Office365-Filtering-Correlation-Id: a7229cc7-bda0-4a3c-ed89-08ddeea7c9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ip1cZF48lfSMASGFMjjz5sRg+Tc3CQKAX+Thczau0GgE4Vrl5eUZfmAcLHtW?=
 =?us-ascii?Q?5TAKam6oR1yCJPJRMlTV+BBy/Jt2PyjjNPOKqgPet3Rk3BJF/SEJXmlP7/Rt?=
 =?us-ascii?Q?zVsf9MQqBFhdS4DJ9SoqW2I0gZurVxwqo4bmza7w1+gf1hGSOMmwJDExv9Yb?=
 =?us-ascii?Q?tJGXT0JM3XQKjAZYQWCC6pJjFce0zJym5GnZ635DGcpoGIv8pG4OrytZrWM3?=
 =?us-ascii?Q?5sWeQd0o1fIVKM3RMMIxrawm6pb4jeCoaK2I0Tr+TDRXHL1f+YFYLSJGTLi5?=
 =?us-ascii?Q?a+hi+9x56xXKskgeE6U4h9X8l2mdhJ/c1D/9b1CBX4dyQQV3AkN3bLxf8uST?=
 =?us-ascii?Q?WMFbkdMrTrMF1K5vgb1pj+r+cnHtpXjgDMVD3jgiu1lHi6U0rdTZQzL4U2Yj?=
 =?us-ascii?Q?aDJMh0bVTiw6GD0lC41da3y3cKlqgLDRQeAjFqC6xAfUZsuPAg+jlKn7Bbvq?=
 =?us-ascii?Q?BNO+LnwQHFVIoPPu4zv/li0+X6+dAOP8HMJrPs4PdCtq25d1XHOfX4e8shAo?=
 =?us-ascii?Q?QHSjQDHwczDQjlZ3shchpicTRfOG0AwAX4aMVuc1Jy8vUNe1NDOJjJLjMdGY?=
 =?us-ascii?Q?6+REKRxxQtJFA3zlSdk3XLo1HqcVIf5ciAtBB1OaOSv8b/efqQsJ/zJplEwm?=
 =?us-ascii?Q?JM1MFPLtErFwA9CvzqYuee5lZ8NgAvqiKEJnpNsFNOHvLJkjHFpTE9nr2kH8?=
 =?us-ascii?Q?AP23T+lpmle9RkUsRH2EKpyr4FENpH/B5lgosUVHBltO4HEWAzDifc7lm2As?=
 =?us-ascii?Q?HG8fvdZqCk19Fe1T0y8ovhe/BrwBlawtC2UQS1zONzIARoq+yEvWwlHqxhf1?=
 =?us-ascii?Q?vkIr/vFbl7G4cPt4KbOwdyMTzqHOdGO5AGG0pDcrSyGT0LgPVqiLVcA9Qsh3?=
 =?us-ascii?Q?OdVW99q5f85Gmer7nohob3Dy0+lG9VYRK1bqoKLNcgu99sNltBIHrLnOrXaK?=
 =?us-ascii?Q?9j57UFCk5uXQzu87J/hr2Tnjx64FI/7IePmo4Onh38aG6JAtWUQzC33ATO/e?=
 =?us-ascii?Q?PVf8uQVx7PeH1owdnrliCR4t8UV/v5fGc1Cqvby7Zs4C3TG2YAQCI8icLCdk?=
 =?us-ascii?Q?wrwYlPycl1Ab0eOh+tfzsc0E6ATZS5C+WJAneeteyE6zQMgvRWLAhJ7fz+Ee?=
 =?us-ascii?Q?fkG03mUw9rgPCmdK2P/J1sZT8xLzOUF2zUY8cGvp41Scegc1cibWskMeBceB?=
 =?us-ascii?Q?ynQGqB06iSRoTasF1AttGRP0yAQdbSHnhXPKk/zoZqFQVhbfxHfApUYdA90d?=
 =?us-ascii?Q?Oub0EFiKUcA8KfKWiEsmpykZLSCZzde6T6LzvkfWTqp4riNKD6NTPRwxlSHr?=
 =?us-ascii?Q?pw9nh2gOUrVpwgoq4suPsLuUxwniNcFU1uy8Xi6CPSSg4qLuCTKaMyZjGnF2?=
 =?us-ascii?Q?d3ZyqMHeMPFTpioV8F/fjZnuZV4hJ4dJW+kOuTSbSfMcx46Ku1Z1OErEcCuo?=
 =?us-ascii?Q?rWmYTf/2afI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6I0Ys9J/3UP17Fz6werXYDIftPGUCParPqdFzFCD8B7S13TCrtG5Si5fVj38?=
 =?us-ascii?Q?6Uwic6IaT1rE/ISvwEEEA3Gh3O/B7XXE5yVEuE9EyKkPbYVVQfeHx7GBhJvX?=
 =?us-ascii?Q?+ZfM0mnLl7OQP/Vh/e+deVsp2m1p1L4xjXe12uPjoOVkcSeqWs1yG6upuL9Q?=
 =?us-ascii?Q?5DFpKNSW3FS6/niYQHbs2m4qV7BiXe28m4LCsNX9G1OLDZfyCcgZKohdvP/H?=
 =?us-ascii?Q?MI1GxZmAE36X512Jq4RxGliN/AEwQZmytyVyGLLX8A9Xii9fyQ2B93y1+WFa?=
 =?us-ascii?Q?LVoJLtA+ZmYOI0V28w5JFEOZg40qDBphcfvoDDcwOR25PyPurfEbDTbxU3UO?=
 =?us-ascii?Q?iD6umMj0+bLSjji5Kz+O8UurJIovFrmgXJq9UdfhuLt37zuaTWd1Bt5DYpu/?=
 =?us-ascii?Q?58nlViBHNVxf0ydo973s0rhafeNvv/EO78GoEMungZCO4DzDj1/BK2LUxtxI?=
 =?us-ascii?Q?1NqrrovpjZHSIxujC2oatYOI+8rFvLVJUaBLkdqnHk/RStulb08s1D62LNNy?=
 =?us-ascii?Q?jz2sYftIkhzKNlL+gSGtFdpwFLbiwDgC8aDVuwGFJSG1F7lBxQiin4iNCWpr?=
 =?us-ascii?Q?HXxzR46PapZhZqPByUQJt2IncpYMGGi5s1aGc3vvHyZ/Q9eIndDCBvoko/nG?=
 =?us-ascii?Q?P4WLGc/o0dLhUMEBmDIJvrpx9B+v6QXyyVW8ta1JCt/6mEFOM518HoXUevW2?=
 =?us-ascii?Q?v+urmNmpi3Zz1E44fhDb5dWLVzcYwprWTnyva5sI+hb5HATpvIanQRi/2E3c?=
 =?us-ascii?Q?j2Dr5i1C8u2xocxvDiUnTWYqzgUwtVVMm7qKrAtvkMn8bGYR/aQdCQ0utE/m?=
 =?us-ascii?Q?tw0L/vpe4asFgB3JKUp2ae4EvR64QrugCl+tZMI1L43am0klV73Zgqm7z9QO?=
 =?us-ascii?Q?LU7MxCl0QcAJzuFx5WdqCiRUVLP8co0FeyI/0F+2Rar666qgtvurhO89X+XH?=
 =?us-ascii?Q?6K9bxkJZoadGfZ9MWh4c+dASsG/9V7kPSJyiuRwfcB4Z+b2fqmm2EpSbHK45?=
 =?us-ascii?Q?bD+yF4OdF9YB2nKAxoWe5AKLrY6SZhuwvsczlA5brnSf8BaiTnyFZkKAvsTd?=
 =?us-ascii?Q?VFQy3NyeLhPDBkxbBDuNYqe8gcXqUIj6qHjvX0moTJA/I2gogJTpqIA64+Bw?=
 =?us-ascii?Q?b+FKjGB5EiXCcW5V5bXs/nlUhNTYKM2d6D7229odGmyjWVzRO+dbcDM/Ou3K?=
 =?us-ascii?Q?RnAo0LKcCk6v4bu3He4WrZOcalCzPhIvCu4Y+Mi3MkFhzxUhNIhcc5o40wMo?=
 =?us-ascii?Q?Ys7eQQAs1A+ovHv4Ouy7HDtyj0FvUNZlFfYO4JzhFPAB/XHs7kcgLoa5p7Vz?=
 =?us-ascii?Q?ulum4EUGI2pcG1sj+RKjYoCXnfvEpCE/GUgqTUuMf20Q34at42CIq6PB2yyz?=
 =?us-ascii?Q?61XXxYSjwGp7Ytzxm57pHWXLSAaSctGYHeQbNi2Ih9frg3Z+6NeSN2zAY8m8?=
 =?us-ascii?Q?DmAh0298wlwShVAwqUwxIEUPqauoLxuInhTWKfBDI7/79qiEC+6s2knUt1c/?=
 =?us-ascii?Q?fDJ/dBWJYeY5Py9esAVnNncDg2lP+jTXechk1i+pDF5P9STP4inCVNf/ONqr?=
 =?us-ascii?Q?4sLgUxi1Z5OJ/IQJTUOKA2yC8y0K0FsA3kDp04ua?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	13f9U44FE349V45pXDPieE8s9+7kSGApKpejsyhy356B1AYj91JbQ29cBVH5JZkzHM1GnjJJBuD7U0r//0/k1mF9MMse3EzzZSq1X7iLWOP47d/oWfurEVB+II/oQPrv/s841QO8SkKjXDkCayE5lCjhhzMyQ7LFrXKtqpkQSrgdFP47FrFSytDtw4abem1EElrz/OJt+RxAngn3kph6m2zFbJr/uIBVu/zMh80AQLDhbygTAUjWIkFPa4EzD09w6T33c/7MkKinnFYiybWTLQR0gAETZgTF/jabbRpYPO/3hu6wiXyefTtxXQqwXSnr5qyZ9jgXrCtq03G8BOKWnMdg2L4V/SFmmputt+vJFz66q25egRvA+p3K7n8TeGGE8F7S8c7meW9A43r+X9q1Z5lubkzEED9k5tOWnjzOdlGBxa+eF4NLgzmIGi+rTiLr0Vay+fK3cD+hFylF/yBPo7jdDs2tFjGkrtDia26QlXBjzhVnFn4vTrKd0uAGr8WyR8DH3ckZPAYIplUlxo2nmXT1XWBrtixP0t9K/m7h/s7alREzHsR7dtMr6X3zUCnCPOijFjIrpgxdkpZZzeKFZg2JX7J/p432LGhpG0U5Fw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7229cc7-bda0-4a3c-ed89-08ddeea7c9c6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:17:37.1884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9IbTawzF653OaIcFvrmg7kLabF/sqooAgMgguDq/CE3Hrq5ZvuYle/LSVSCcsj5i2L67M5YW7QjJ5qI5rMg1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080072
X-Proofpoint-ORIG-GUID: tNJ_nnByrwIPlPr3jS2LGgPQPaquzWsU
X-Proofpoint-GUID: tNJ_nnByrwIPlPr3jS2LGgPQPaquzWsU
X-Authority-Analysis: v=2.4 cv=E8nNpbdl c=1 sm=1 tr=0 ts=68be8316 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=tA7aZXjiAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8
 a=Mq-BUGaGdN0al8lYWrQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2OSBTYWx0ZWRfXw73M6dfKQxvG
 ZtG5X2DE+/Wt5A7qeCC1FzxR+Ru3L8VATCQ518cg84/EvffX56wRYoraxjDZNnyQnak4QqvJVCZ
 RhTqIzmh+IwgjK4R8AvbMYnmGwzuJVA8oItY3a1lBGNPfhJG0PDVBKLeYTrt41l5n6xrSTxTXVy
 5soV+VU1RuoiudZPkOm7RoY1r3zRJx9bay7tQa7MZzHFbC/7IChHCim/OXaOIW4oyB+f0SybfAn
 NHv22xYOHOtCOpdkaJQEophamcvneqc5KFp2DTN0IbcaCqQilhd+DGbIuFOsXECZ2MMrg2Hjazk
 PvyaIi8bNLvVwjM8zS2Hl44OWwyGmGYCnrGx1W/wlDsxQV7PifD3Bj/IDLpRCYyrVRZbMz0dElB
 Fzjtl0mDAH9L2Mw72MyPWGRKB7A4eQ==

Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
populating PGD and P4D entries for the kernel address space.  These
helpers ensure proper synchronization of page tables when updating the
kernel portion of top-level page tables.

Until now, the kernel has relied on each architecture to handle
synchronization of top-level page tables in an ad-hoc manner.  For
example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for direct
mapping and vmemmap mapping changes").

However, this approach has proven fragile for following reasons:

  1) It is easy to forget to perform the necessary page table
     synchronization when introducing new changes.
     For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
     savings for compound devmaps") overlooked the need to synchronize
     page tables for the vmemmap area.

  2) It is also easy to overlook that the vmemmap and direct mapping areas
     must not be accessed before explicit page table synchronization.
     For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
     sub-pmd ranges")) caused crashes by accessing the vmemmap area
     before calling sync_global_pgds().

To address this, as suggested by Dave Hansen, introduce _kernel() variants
of the page table population helpers, which invoke architecture-specific
hooks to properly synchronize page tables.  These are introduced in a new
header file, include/linux/pgalloc.h, so they can be called from common
code.

They reuse existing infrastructure for vmalloc and ioremap.
Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
and the actual synchronization is performed by
arch_sync_kernel_mappings().

This change currently targets only x86_64, so only PGD and P4D level
helpers are introduced.  Currently, these helpers are no-ops since no
architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.

In theory, PUD and PMD level helpers can be added later if needed by other
architectures.  For now, 32-bit architectures (x86-32 and arm) only handle
PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect them unless
we introduce a PMD level helper.

[harry.yoo@oracle.com: fix KASAN build error due to p*d_populate_kernel()]

Link: https://lkml.kernel.org/r/20250822020727.202749-1-harry.yoo@oracle.com
Link: https://lkml.kernel.org/r/20250818020206.4517-3-harry.yoo@oracle.com
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: bibo mao <maobibo@loongson.cn>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Christoph Lameter (Ampere) <cl@gentwo.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
 include/linux/pgtable.h | 26 ++++++++++++++++++++++----
 mm/kasan/init.c         | 12 ++++++------
 mm/percpu.c             |  6 +++---
 mm/sparse-vmemmap.c     |  6 +++---
 5 files changed, 63 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/pgalloc.h

diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
new file mode 100644
index 000000000000..9174fa59bbc5
--- /dev/null
+++ b/include/linux/pgalloc.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGALLOC_H
+#define _LINUX_PGALLOC_H
+
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+/*
+ * {pgd,p4d}_populate_kernel() are defined as macros to allow
+ * compile-time optimization based on the configured page table levels.
+ * Without this, linking may fail because callers (e.g., KASAN) may rely
+ * on calls to these functions being optimized away when passing symbols
+ * that exist only for certain page table levels.
+ */
+#define pgd_populate_kernel(addr, pgd, p4d)				\
+	do {								\
+		pgd_populate(&init_mm, pgd, p4d);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#define p4d_populate_kernel(addr, p4d, pud)				\
+	do {								\
+		p4d_populate(&init_mm, p4d, pud);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#endif /* _LINUX_PGALLOC_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b8dd98edca99..467878e922da 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -968,6 +968,23 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
+
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 #endif /* CONFIG_MMU */
 
 /*
@@ -1608,10 +1625,11 @@ static inline bool arch_has_pfn_modify_check(void)
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
- * These are used by the p?d_alloc_track*() set of functions an in the generic
- * vmalloc/ioremap code to track at which page-table levels entries have been
- * modified. Based on that the code can better decide when vmalloc and ioremap
- * mapping changes need to be synchronized to other page-tables in the system.
+ * These are used by the p?d_alloc_track*() and p*d_populate_kernel()
+ * functions in the generic vmalloc, ioremap and page table update code
+ * to track at which page-table levels entries have been modified.
+ * Based on that the code can better decide when page table changes need
+ * to be synchronized to other page-tables in the system.
  */
 #define		__PGTBL_PGD_MODIFIED	0
 #define		__PGTBL_P4D_MODIFIED	1
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index cc64ed6858c6..2c17bc77382f 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -13,9 +13,9 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/slab.h>
+#include <linux/pgalloc.h>
 
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 #include "kasan.h"
 
@@ -188,7 +188,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -207,7 +207,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				p4d_populate(&init_mm, p4d,
+				p4d_populate_kernel(addr, p4d,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
@@ -247,10 +247,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -269,7 +269,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/percpu.c b/mm/percpu.c
index 27697b2429c2..39e645dfd46c 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3172,7 +3172,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 #endif /* BUILD_EMBED_FIRST_CHUNK */
 
 #ifdef BUILD_PAGE_FIRST_CHUNK
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 
 #ifndef P4D_TABLE_SIZE
 #define P4D_TABLE_SIZE PAGE_SIZE
@@ -3202,7 +3202,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		new = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
 		if (!new)
 			goto err_alloc;
-		pgd_populate(&init_mm, pgd, new);
+		pgd_populate_kernel(addr, pgd, new);
 	}
 
 	p4d = p4d_offset(pgd, addr);
@@ -3212,7 +3212,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		new = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
 		if (!new)
 			goto err_alloc;
-		p4d_populate(&init_mm, p4d, new);
+		p4d_populate_kernel(addr, p4d, new);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 46ae542118c0..f89dbaa05eef 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -27,9 +27,9 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/pgalloc.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
@@ -215,7 +215,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -227,7 +227,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
-- 
2.43.0


