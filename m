Return-Path: <stable+bounces-179062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36C7B4AA40
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AA8163A27
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83431B806;
	Tue,  9 Sep 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DIns3iR/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TQaGGmOB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E62320CCA
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413040; cv=fail; b=B96U25EdkmpQ2jlHYu3ee49OCe3ClMma84zpKBq7IQsZeshbMjqpBT6Xn4smdp6/xQsr+qcV2lVhJHm8nY8xlZlLOr4hI/1W2zP7nn8D8jI5ltatFxFF95aNZHjvfHEeq/bqs9eFqM/vF0QEuBLcqh7ev3o57FFldWIMldAXSuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413040; c=relaxed/simple;
	bh=PszAtFELNAvfXVPDZ0mBWYcHB203W8eKwruAnsBvSQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gj8ZHMYkQgqOYlV4gQ9MC2Ce2SapeAuILT9DrBDJ+MSf4Wmj8robYXOod5F6baipPQKmFN0nuZDiJypSFU+YCgD/+C2IY+QQEOZbhRR3kI+3Ov4LZSF3HHQtNESJw8/Il3eKSkRzR+k37Aitmz8vkqI6ypiHa5O+rieWuM0g43U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DIns3iR/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TQaGGmOB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897g2dq021263;
	Tue, 9 Sep 2025 10:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4+7O5xWIhpnuhS0bR+Uyrt3ONq1tLmblEp0ig6xXy9M=; b=
	DIns3iR/Na2GEJqwZWxQAmC+wQUdNE+A8zoq8OWc+dvWRxaOwGdRVW47ZU3YZ/yw
	uj7wJXTwzYmbpV9VcuTchu28+Ca3WT9mu/NhX9noggDQr5CYQbGeLPSqXfy8fhZy
	+otV+7B5mRf3VBZxi/tJGR3sJ3xrdm/j4kFYt3WIQGsBtPVGvkYCmt3vSFPNbMG7
	o5lPgbhffXfbxfk4YFhPtcsR73bGjLxa9OEjAhpeQ40ggOjG7dmjj0O1tHBBGgir
	nJeebUXK0Lh2bq1dwxF54QHz8BuRNwYRG91k5m8jczT0I9ScNvf1hknN620YzYZx
	qN+zi4m7CAXJztvd31FwQw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pe9my1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 10:15:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5899MWVa038961;
	Tue, 9 Sep 2025 10:15:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9dmnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 10:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jURy5/lIkyS+r2MSSt88D1h6T5j1ZP+BEN3Z4Un11e93RppPm9alqOxaz+IoQKQK3SktqHh6/hbILsQHr610xx7vp+0bnyR+lmTuomKiyJmTFHSvjSAk5lhyxRbSw0VUricjAEhhmhjAYuxVsi7fFWHybZOnosjbYLzsCufKSV0XanW1TsMZ0xvwr4FQFYFcIc/eDLhMjB4JEQirwTzriTzUYt61l1uomYzHegepBZAYLZ+MEgO+BH/FvIvp30ccO2HAKREAMQrgJAIi+VHEeee/xNryGQ5sZj9e96pMQTIBh5S6PXmQm82HOFdTPB22s0l1RLXwKqtAQkGXN7Dh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+7O5xWIhpnuhS0bR+Uyrt3ONq1tLmblEp0ig6xXy9M=;
 b=f4M86OA/ZicRurgxXCHkBYU2D5wfSGW77loTuSH6PQ9tY9301i5PXjDjarpN39D28QEWE2L7Vzu22IG4Mh8PzW/XTPdaJBj1L+BRsDOL7wBuM27Yw3SKvd5kk4Ob718VpkfK+y4AhF1BVLXYNbumZUIVmCVffegwTd25E0/9M+zzbvdOEzO/s6TOzkWyMbG9z0lwlPCBjs8bviBCcsk6CbOq/Oi+8FRd22fPRFgoeuXY4JbFqRPUbEphs+ybdKLGxo2LId04IZ1hVcKsTINamnha+pO9Br+nPy++fFRSItWw6PpZkHEMHLEDdd9iWx9cY7Km+KFxZgXhO3+ruHYDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+7O5xWIhpnuhS0bR+Uyrt3ONq1tLmblEp0ig6xXy9M=;
 b=TQaGGmOBh9BqB6AlWTp4EDlKHPuxip3FzBy/JGWHhQN/WZENSy7VbHQVU6IGv/kJApKzWXnoU4Ku7JWEqCI2ytpdPd0Xgmys0j1AJNO/4w9tUbGzMMMZScl6WSu7sq4qGWhfiT84XLdFJvd9jDCHcoWX71p9CE4tK9vCiJKS4OE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7333.namprd10.prod.outlook.com (2603:10b6:208:3fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:15:47 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:15:47 +0000
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
        Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH V2 6.1.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Tue,  9 Sep 2025 19:15:36 +0900
Message-ID: <20250909101536.6888-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090606-overthrow-bagginess-c68f@gregkh>
References: <2025090606-overthrow-bagginess-c68f@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::24) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 62cdd958-0215-4b0e-7fe7-08ddef89d7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TN3lg7PW73Y5kNnX4qwGHuNTmayVDMJF++3YCtGBYfWTJ2onBGbtz+/AmRiI?=
 =?us-ascii?Q?SxolHQZE2ztOInaQu0V/3JrGZ0v67LDm8ioD5GVZsWeMqKS6hVp/NP19+a3N?=
 =?us-ascii?Q?p7rj1uLtBSwwwi0jhFQDiTzFI0n0hQN1fwWoasyk7pRHGC+GDNCKUYISwp2b?=
 =?us-ascii?Q?WrMVBNKU/rKekeXjJr2LNSPbi/yExjJ+I7W75w7YdRDrfyvcsAkGTcrxn2D8?=
 =?us-ascii?Q?vQAx+S1e+qI+5cD5SXkTqvfiBq3RMgnfybj8E2idK4+5SF7uqLMAvalcaHnk?=
 =?us-ascii?Q?u80MHsrqijRSTz1Y3oR8Om0nBsaCaU0iK1+B5YUUeLhWcDtxzoJzhS1GTTLb?=
 =?us-ascii?Q?Jlq05PFQuK4Sm267M9SMtu5+CU6jdiuMPhwT6eeflpe93tv+PPkcd7BQipt6?=
 =?us-ascii?Q?OYOYEsr207YMwNQIopcSdT66bptXthJbkWKM4DTBlREwxeAtiDqxSr4aic59?=
 =?us-ascii?Q?gFHEr+Nr9X6VzIEBct/Prfc1UiJUa/S3gXyzP8U28ihMLRbScwZJfKmdMgFG?=
 =?us-ascii?Q?kxQCLdxXZcu/015KAn8SklO9hxW82qxvC7XmslipX2qQJ6RJQRxdxixouKJe?=
 =?us-ascii?Q?ZL+P9+BeNbe9sXhoRfaMIHzN2ew6uSbKD38g5C9iYTMY74nGf/PAN8zTserB?=
 =?us-ascii?Q?GWCNkdS4A88pFyAY3gCpG4NngLPCNcQSFBI4uvl0nBVB/yJC49GgWZudjU8U?=
 =?us-ascii?Q?RxBZJSJWDreqBMncNx02fAauIgus+nusissP9hMKSePEQoPqlyNZTIS1qNU4?=
 =?us-ascii?Q?vSSVAmQYiSDLdRj6DiA6mLPaK60ODlNJLMnzddXiucpYFpWaK+cSsnYA1ZPI?=
 =?us-ascii?Q?//DrOZHk1GtXFR2VBsX2Qmo8/VaGigqJ+pB6KulwGsXOGuBtiWYN/EFAdWXs?=
 =?us-ascii?Q?Vl5EVuRwEKoYWlM6pMaOM+NlTJwUf+8kNNJSM4FO5yetzl/OR3F0ZuPANntv?=
 =?us-ascii?Q?c9z262SRnwWSdiX9zrZ8OD/hV8wfanael3DnZ26JmlPK3XnP6lFISGzuqZB3?=
 =?us-ascii?Q?87ixfeLfz9kkuV2vXrtH4QeUqNnIEJ0mDnSb3jMTBqfdKLYVOFdADg0XoWyK?=
 =?us-ascii?Q?dLRNW+DQhOqlArDSLFbvAReZ+4gw1H48jiUjKVqngS8X5oDQgnb7fLTuM63W?=
 =?us-ascii?Q?hHYWY65S/d7O1l9VE6SisnJccMOs5hcxqURB0ctJQ3UrDv1adPPBsgoo4mxW?=
 =?us-ascii?Q?s40w464g6QJjb2L3zvgwI+sLKcAm6EuaMDH2uhAniIWnuWY3wcSHSdMNk0me?=
 =?us-ascii?Q?lJoAGNlMFSrRrTOHhessn3aF264hDaOhsHXctwt2nGm5lRXx/QTM5jkDZ4eb?=
 =?us-ascii?Q?Q5WkN6UvV7dnRFuT7OVzzSPFdgvm8tBBb0f/A+saeepciNKzw6vMLFJy4L/U?=
 =?us-ascii?Q?ehR5GRxXKRgR+XDuqsp6ox0Puyrng0hHLW6V4HPVIQPOSNfw81vsBstzqjJE?=
 =?us-ascii?Q?jsBcEUL9KiEncQTH27CGCU/lMGlhVNB2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tnz+kogG62fsT9GcEZC5v7GyuYXoHVRyPyAc8JUkLpcPV9vqn46Ucs6BwYZU?=
 =?us-ascii?Q?onu6qNsu6Ga0lHgm6gwoePeSS82jPXtXswIAxJp+GP+NSGyhxAY3TFvVcOW/?=
 =?us-ascii?Q?Tjfa26ZrKSA4y5KZswOuoKd90TI54Dy5gtFvD1y3rAYL3LY8KaEEqa5UDBl5?=
 =?us-ascii?Q?lOhrUnGKEGx81kcNpZsdC8j+9Ws9pQ5m/BGCGjOOWFht7Y7t/Eu48M8IRCxo?=
 =?us-ascii?Q?VjBHZ4mUom7l0jgeyVJksdUtSUOOupoxLd+whwJ3Ka9z6qQO/wquQK6oeA0t?=
 =?us-ascii?Q?DPBqTeUwUl+4+mekB70GNoSaGpWJJZPvR/XcfonQeeKyGCw2CIt6LgiTOqR/?=
 =?us-ascii?Q?uBv8EFShyyEzn7gqKEhNo3RVWl4iGjOMtjCyR92VLcCZOo/G6HaRObg4kpJ2?=
 =?us-ascii?Q?V+PZbBgn+lcD0zSqvIOs5Be3XN5ITpjD1oJHDF0RuMoX0CDh741dLTd7OY0b?=
 =?us-ascii?Q?7U62lXYQIcvWkfISvCQweN6gUbxoNsvXe9yX9yf8T+qDxFl0FTLEA6u8ygz6?=
 =?us-ascii?Q?HTwJ9O+1ZhnTMXH9+AZ/eV1ar2RRYhr1g56C9NZm60d2MZqXbUdpAwZ3sfem?=
 =?us-ascii?Q?JyXLOayUlh0Xn/b/W94Jq+SEOTozwugUP+gdFg04sFWO6fAHl/v5XffJhiYq?=
 =?us-ascii?Q?65ChMUI9W5TxXZMCkfYaaecgwZmX1WkGR9kPwvynEj7qEYf60iBFrPC3H3db?=
 =?us-ascii?Q?FrlgbxWdfU187ZHl9RmTqh+vjy6YUQmypa/M8xDYLO+x6aDLiPO/YPNV1FeX?=
 =?us-ascii?Q?iuCyqZ8q3rHASFO7n2RymvYFnN5+XkDy5G+wyfv2T55HLoPpAAFMunlJWeZI?=
 =?us-ascii?Q?8MMH1f446EF2p8yHnpXbsJLQhCTRs0C+GAkgKHFBtxWUzcni2kXqjgqsIpCn?=
 =?us-ascii?Q?Y01mepTFyYge3mdMy5L5q76gy0tGbozO2o/i3p7FrE/jCGmS479rgYPAjP3+?=
 =?us-ascii?Q?4RLYNLAmYa0aAwEi2248GsV/dEm8cQQJkI9SRk7FAYp0nzOPzfsyMznuwq0/?=
 =?us-ascii?Q?XfY1G1vqzhO7Uoep/4YgThtXvy9XakPajKNNk5eaYu9BUpiVcArSJFBmieGh?=
 =?us-ascii?Q?+Qrdl43XPLwhve0vIoDDe6DeJOfzSJvmNjkcGfLnY8HL3QQ+q+s9q+Jwbwah?=
 =?us-ascii?Q?hz2ARAT5rla22njFWSnypO8p+a3BTVE9oB033nrtu4aHUWdl9yFMzqmjMF8y?=
 =?us-ascii?Q?Rx0ctWFM5bcVEFrjDAU0N4RmJIxzULVa/ApK6t+8p58IR9aIxOP33yfm5FPd?=
 =?us-ascii?Q?gnPvdp+uyGXf/cwvDriB9x2nGPkTNoWUrfnLa4E8fX1OpW9tml4JGa+z2i/g?=
 =?us-ascii?Q?KBKQzut3aV90gKE/SXsdbYl/+Dm2Ms8aBmvylrHeb15YUWFqACEBstIl4pFc?=
 =?us-ascii?Q?KCCNqT2ZEMm+iMfsa14bKwyX1iSB06MXIwUQ++/tMLk6q1qkNME4gfTqJdqH?=
 =?us-ascii?Q?crwzURSkImdsd8kRPWhfgsyHy41VQltfCK6ZdYTJr3iE24g9TP5oFowDQbh2?=
 =?us-ascii?Q?bhRMYhI7jhPr3Ussh+TFvUOpuSeH5ijFmVKWWWcYLYhV0FsSBPwD5Ze3mhla?=
 =?us-ascii?Q?siNm+0FqtaoVR4xwQwfsvi4AJAecO43hzTZrrYoX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3LBB0l2amZvM5ENofjxcME0iZrlldfeN2PD6Pvap9vUKMKRGSOfCm3HeoMFagRcn1MvlKnTx0EwJAODKt7/2mzuNWkKb1onEWfFfvrSNxTO8imqpN6H9z64LTinXy/f+5N8yqkfNaUOauAQuS6WBod8BJ4dPBgemhau3tntDbw6WnegqgbkWbYBQ0A7yUl85/85g9rz/947n2I7cFKYni9My6lX0IxJZOmu545UEQOb1+t6OBxXx4CkDFF2A3bkTHf7+sKhc1M9nq0uizIB1APbEFrGaEtYIDdohyPQJ6wp68N0QASTYbrluvHvR1HSk/NQHlXUErsUR71Z6uZtV1+Ksv9XIUFwEIEJiRcfqIIEAI7NT8AkRBLvqE6fz/obllbUlh1IPavGTnXXTMzBuZc1wybd6I55xyKi8ShfoEbJre6il+uBwCykpfPaPcQec7LwvzddmCxAkUIi0cKI9jr00fB+OvKPeRvdcvVlTS8XsQrzQQTR1eqr0IdXoZ/awIVgGIxto1SBbP+EZL5MNTqmLE0SZn0KYxaCmxlqjrK0AIsW78hSq3nMABkjy0q1zgfHUw4xS8cwhFvTT2y228CWPf4i2vbfukC2xTwhyrJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cdd958-0215-4b0e-7fe7-08ddef89d7bc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:15:46.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ai3s1nOaB/gnRPgyjIsyVdOlaNeSQQv0/UTxZFZy832D+iz6/W3voxSUBDHJyuKTdNFvj6TArrfiF/HbqEmUjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090101
X-Proofpoint-GUID: 17oAsIeivN8l9PDy3j5hoqRb_8L1ImMj
X-Proofpoint-ORIG-GUID: 17oAsIeivN8l9PDy3j5hoqRb_8L1ImMj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX0rc+glk43LbI
 68JaEHUlkSZ5WGvDU3HrN8ZyKsE9CD3aMPe+qOtw6CklSuhp5TW6BPSjyrwO4WMbMDNR8svr448
 9z4EJ1mrM2P9hhj5JlZSUumUzfdSNpHDS8EWl6o3PGfTuAKZPjWLRXrqMx95TEusRjtPj7vkfZS
 edJpcRtpGZOXRPiU/rY67FVi33bfGKhjwxpHJ7tBFumjrPSJmjD/QvtoiZqhexenuARWqLmGUV6
 H9T4XY/XDPr+byszhiXGpuDWVGCEDVcKluLkR5HF+3MaKO1mt4bCjAe2/xJXnjF/VWlc5v5Jcs2
 84G4ucIPZ0rwov19MxzYJ7/B9R87/dAbkXnOTcn7wIYHQ/RAIqHZNENrIRnWETuPRBJtFxBfVqR
 3MFA2hwY22uMpAmTeh9bd5VJP/ajNw==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68bffe58 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=tA7aZXjiAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8
 a=d2j_XgrXCP8SUPSpM9YA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12083

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
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
 include/linux/pgtable.h | 13 +++++++------
 mm/kasan/init.c         | 12 ++++++------
 mm/percpu.c             |  6 +++---
 mm/sparse-vmemmap.c     |  6 +++---
 5 files changed, 48 insertions(+), 18 deletions(-)
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
index b8dd98edca99..82d78cba79d6 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1474,8 +1474,8 @@ static inline int pmd_protnone(pmd_t pmd)
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
@@ -1608,10 +1608,11 @@ static inline bool arch_has_pfn_modify_check(void)
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


