Return-Path: <stable+bounces-160174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DD6AF90B8
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 12:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807DA6E0EFD
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570CE24A066;
	Fri,  4 Jul 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q893ojsz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nGBS8SoL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA62F2C6E
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625090; cv=fail; b=byOsjc7SItDKcCGCco5jSDergUMiDKyOwOXWx5TW6Fb+YrkhM6vKikW7R3rjbPXyCaDWvo5gaP25AA0PsQoOqzXeVzhpNBsJQPMexZZNNlCwAbvIDoYIPMcFq7WdgQ+b22eUN+2AjeCrtktcHKErGzVGsjefRGbgs77qhgZTC5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625090; c=relaxed/simple;
	bh=W8Icd7xNwrLrQwvwXfTh272EiaOCTizqfUTNnXsvdhw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oDVslEIAg89PsSl66C0lgL39b4DngL0Om8EArIc4Nc7TeIUme5/GGADKfCWodItJ5HRD+Yde4KCFMazNmCytuIbGGuuC6kGoW+dSSvzJkHU+PYhdoKUCBi/an5SXLZb/iN2ojXO6MdHn9qu7UofvwyYCvzZyDu67zfQ8Jzdmnw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q893ojsz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nGBS8SoL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649YuxJ028305;
	Fri, 4 Jul 2025 10:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=NzDSBALcp4tFt+C0
	vpkWpLBZjnVqnHMMAutB8vOW/9c=; b=q893ojsz8njX1Ab2MRuK2NFEIU2pVLkV
	HIuyovWUoee/byCm2eW862efQbopIqLoIRyohc8urbAFT0CY7CzWUsIGqlaPRKvM
	+7b5kFz+8r9BtkGu7MecjyJaLuCI8g8KyQosJqpjA783a9luXCu9GSkcbq9sfZMO
	hD5wdWTg48JK6LSS+PMny0s5zc0NC/Rz9EgANuwzxEy1N667Akb8KNnf+WqHnCJm
	Vmk7bNFE3k2wOz1MwQihErf6po80tAY7Sdmutu3jweaHwR9Vs/u20QJrYxXx5QSQ
	DXcadcKy5b12N3o/SqKwCL3E7nW28kSbE0XZBBprPlbZEPl70+shaQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum81uaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 10:31:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5649r62I015130;
	Fri, 4 Jul 2025 10:31:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6udensr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 10:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSFHcSeNq4Q/p9FCjCdNGGUaDukM+QNRn7cFWmPHURmviVL2+MbkBGuCbJ2Tm0qtofoBt1RbpnMDLY6WsvnL3+TzeUNh8pSGBTmcqZf8TDqwj2xWjLvTRqJBpn4f/47ADv4yo0l2cvprR2FPmcUwSOJg5T9UHncvf+ITq/9Z+v/uGtHTXpKmishm8Gn+fnu09HJKaZo1AJuIj6M3p2PRXMyg20mLv5hY/E6NusBFdMeV7uIbPVwL1PcDw4hFsFKKxAKiyL0/hyvoJ6csKYtoBesDLRb1vOXR7sZWQvaPXYmHgTXA9EDycs2nve5gn+ILkpu/E1xOpJKAqdRsAj4Zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzDSBALcp4tFt+C0vpkWpLBZjnVqnHMMAutB8vOW/9c=;
 b=m3yqcCZGzhCfUd813J0PiBc6EYu2afeDE/ke1xZmHqyPbUxYIyOCHaj0+XaVecDKyDTFq3m/B+KJ1+LBojxJNQR7OqVttEUHVZl5tnrRDHgZlG7LJm/hzx6/FKKOiICHuRWz0kV3MWqb3G0tWwC6UjvWk05teoUtjNnXbLQnGW6jYo3qPg2fmhDeEwxOuLWxlWLDDIcHg/znRQTuGeWwZuMu/uyNB6kimjuv010lm3BznnDthNJXQDeBWlPv27acpMEZT8s0AhSo17jADAz89ZhaVMv9THk/T7Q7eV8EzZSS60xfg4zZR5xFxLt0DSZJ8kWRmhL3tnVstThztrOjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzDSBALcp4tFt+C0vpkWpLBZjnVqnHMMAutB8vOW/9c=;
 b=nGBS8SoLbJp4AL1olHNdOz6kHOwBan0mWZy6hG/VMSbLjiqUaBmboehs1XlOh0U7bbAUk+BHaJPkTPSsPZ1hKMGYJzORCS3RLZ6fq4OXWSTZ89jPTFkDiDBLydPmN2CII5meMfAz7sTKN5Y8JA1dnKi5fWKnLSqJyD0i6MEjY7w=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB7184.namprd10.prod.outlook.com (2603:10b6:208:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Fri, 4 Jul
 2025 10:31:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 10:31:14 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Harry Yoo <harry.yoo@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v1 mm-hotfixes] mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n
Date: Fri,  4 Jul 2025 19:30:53 +0900
Message-ID: <20250704103053.6913-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0190.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ebce3e-2038-40af-369f-08ddbae5e6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ABJ2y8stWH8Om7ZAJ4C/x/DIjNQ/gmgV9T0ZuBWwqniHn5cXjZY72NXZi/o?=
 =?us-ascii?Q?mj/9lYRNZJ6pit1FwTMbV0E9Eg7xv6U0p0mGXJM3IBC9MGkccSg+kBvir93a?=
 =?us-ascii?Q?kOPnwY8UrePnmS79NXUoz3kp8rEaW5NbbxZ5VUfW18ES2wZYnZlo1oyfyXPs?=
 =?us-ascii?Q?cG91S0At6KDewdpQPrCPuzifkKuKHd65Tjkh8RfROKjSzU2VulhTnUeZc2V5?=
 =?us-ascii?Q?26TwwmsAhyKCRH8Nni7pEdf+vneXe/Bq7yXxKV41jWNI/yfSncGF0Gud6jyw?=
 =?us-ascii?Q?A1rx/ZELC7CH2e/xLF216eft7sfnMudMT8i0p07yufoYfpO88Rpbs3934vrm?=
 =?us-ascii?Q?lpaZ/ZEGiP5XWefyDw78Q3chZpxQKik+4/kz7PFLOMSnqSzlYnaUUaYiVJQt?=
 =?us-ascii?Q?7IHkmICluGc9b6eju973B/rMK0b/7KmfqkGoneeEw8bkuDsKGOFxKIZx9qUJ?=
 =?us-ascii?Q?e34vv/UN9ag4DZI70Kau2wrEC1fzA6d0Vsr+FHDDeJP5c7m35tK73q2OTrJb?=
 =?us-ascii?Q?vVY9uSKUivMXpPAuB1918H/piB81HxF2Hf9B9Xv4uySs58dseQlCIGeKDZVH?=
 =?us-ascii?Q?0rss2yXga1pIT0uOugzqd2aDJkbmL+WSE6YjBBJ6iSdnasNXUOQJIa5Um777?=
 =?us-ascii?Q?2GAzT1b+vf2T0rNaW/e4SjCp8U+T7IupdaTyv0MRwyDsY0vZmuWFBXV1ne4g?=
 =?us-ascii?Q?OutD5bG/Q+Q7KKV9ImyL0J2B5meTN2iJg1bf89iMmGOKXR26fmmaPiX3Lfgg?=
 =?us-ascii?Q?ZJ7qhJU5LTH9KhshxS31oMRlkTRccC4A0Qi/2DQu3QrpQygXuCN2Acv/hkEg?=
 =?us-ascii?Q?PCZPDmza0hniFTpUZSnTF6NjBawcfX/EyAUPv66UFrpBnM6Auvx2NJf+/6Pz?=
 =?us-ascii?Q?plMytX7BcX037o6no8LkjKZZ0cx69BdRH5u+ffty9OXI11GKkuQ3IWwK4v9K?=
 =?us-ascii?Q?AFB56cBviBk7sP0q0pv1WY8irbiX9fc/jbe3hwxMgot2aaWSf/SssBI5MnyA?=
 =?us-ascii?Q?6jV1krw/pA1jDxq0fPYltAaTfPfaw0pZ9oCouncfKxRST2NpC4+2JeTS6/Rh?=
 =?us-ascii?Q?Q4XQ5g3nsdDKqEfvLVdTL/RZeanovnfhHQpA92dkIBu+YQ4uAJJfmnFLaJlj?=
 =?us-ascii?Q?n/BXpYYiJSEdQ8ebXt446yrJ9FpY1G7K6z16NpK2GvUidfOb2FnKO+GTlfyc?=
 =?us-ascii?Q?RaxHXeIzka1MJD/+drRPwAHkr0RGk+McHcS1foDR3fd0u3ooUh63qMumgAUx?=
 =?us-ascii?Q?jz46JFvVpI0Hj9XVUjwXhAkpxufOJSOGvrXoGb7efqslCOSdcmMbnxeMPzZK?=
 =?us-ascii?Q?UeR/VReMXrHg12RGnfr1v2X+kNMYXqj+wNmTSfwVyawQLYcqjSiaBjoIgJKs?=
 =?us-ascii?Q?6Lt4mznJ315qrkVvNel9cTU1leGzi9pwVewz3UQapOEDNe4R9vkQkaghT9VR?=
 =?us-ascii?Q?xTcg/zzhqoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DGV+rjAs0SLZwsNNfuJ6/m1+JrB/cApW8F6VB46hes+gCPGxrY983ip6L8hu?=
 =?us-ascii?Q?mMuyyw24xLWTacI9POpRYaq04uayf5OesNDauV1hVj4v0Yaqaql+y3KE4xXx?=
 =?us-ascii?Q?r13sGyn8obmxqXysp0E1bL8FZFddzeQAvCGyZ+bYTRomJO6200Ae1kh02www?=
 =?us-ascii?Q?ffWBjkXJUVjt34tHkjIO/eBxPW18Ke3a3AP9ZMouteaKT4PcRlvXzTzQm8n9?=
 =?us-ascii?Q?YzOXX6mJNmevgnU65jaJYmxIbDCJh1rN90RIDTI0ohAt0RkM1XDw0hhDmR/V?=
 =?us-ascii?Q?c6eK+93RynSTAInhFXOjliCVCUQj5hb6Y+XwychyLyl123UiOxxq/ivYVqsx?=
 =?us-ascii?Q?uMqcxKaiPIuvi3bIIzNIlrWqnKNFKypULFNGn2xtlxtZAUtg1fFVKfPVk1Pt?=
 =?us-ascii?Q?HIttMlC6eK+KAQxVzjFIrpGn0mfl2RIV2WfWhkpn/rL1Por/S9Kh5msTLypY?=
 =?us-ascii?Q?s4yWIbeHIhpQ/wwSx361yXHgSFIf57UNAQkiI/h+wCkaICiuMqE27RmuYayL?=
 =?us-ascii?Q?09WJUQpEAHbZ0rl8ftC3qgMybqqrCG4mIQBMN3iNIzJGdO3DfFRrkVOtESBY?=
 =?us-ascii?Q?hNeHy8Ui7WyhsOfWmO5xdbLwnobzUrhuUjSRWiEoUJtXqhgmiDtnjRUKoYJL?=
 =?us-ascii?Q?koGNmRyrcoypWQar1tKJlcSXbJSmN1KZP2M9JvHuLhlpY6e0Sac252RHBybM?=
 =?us-ascii?Q?RlN8Fa50jg5JCLnWD06yxbm3XC3Y6l48cXAQ8ZDehzbOIDBUrZEOxgLpkTgd?=
 =?us-ascii?Q?QY+WGSBH/oiwisDGbT5fnHOABa90UVoY+d0BcP7WLBkgDLNRPCf/VJiNJaSE?=
 =?us-ascii?Q?DSIPgoYBLEjPsfj6uvDybD9/lkJWI2XCL1nsP4VElPPGQLqGhexmk46cdRkV?=
 =?us-ascii?Q?mHbOPcJHklWxYWeC6Nh56Qm1DqnlZuroHvEERopc7JtOvjTYqUC04ASYcadp?=
 =?us-ascii?Q?44QDVJ14muSI4Zg6IVcNaCUTvoG+HTtSgl/ChSIsjznYCBQXu5MhLIdu+MBJ?=
 =?us-ascii?Q?7rxAvk/Ldekc5JYQJ9GmicubqZxAy2Holfe8irKQX1zCvBTvorI7sa0fmgmw?=
 =?us-ascii?Q?ac4O+W1UGst9FA2A3GDcW6bcOcwxyIQmB/UHuXZZSgpJM1+rRJUq8OtWg9Eq?=
 =?us-ascii?Q?Ow00sx38T3Zy3LPWf3w3ylPWTa/+3j6VGUvE9Mv7EQbEniIJIKEeqqwoRnum?=
 =?us-ascii?Q?2cVfiBw80rwaFan0I6hynOca39zBibBkRCW/ZPxhfW85SFEdjCDUPrEgx3Qg?=
 =?us-ascii?Q?ga+zOCNl+aH0OE44CRCwxzLw0ypq+BDgP20XPCAWvinUldC5G7F6+VppyIDF?=
 =?us-ascii?Q?83J7CQRDwJSO2Q3O47jcaiEfrS02evt3IOooZT9NTzXoSOsOSykAYCaTr4UH?=
 =?us-ascii?Q?B+RmPOY1zcZPW2tPrTZ420vWfrCn8oJIvYnFLMiBisHTn6wE1hQ6HyfhUPmJ?=
 =?us-ascii?Q?nEzXEXJzqSKSpYEZr1eQe+xtQMN1xzfWSRmk+ruY27s/EwYbYx6MNZw/jQXd?=
 =?us-ascii?Q?SN53IbMSb6i84k9aOykFQ+jsqkV3zxUALHixLISziRPlKXjplnUZb3bJAbSK?=
 =?us-ascii?Q?5QQAehxj4stNfA8Jsx4oEZHB+RIvBCnWtM84gK9Y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BBQj5DJln7Nb2xG15Quxu++BrtxKDubVWZbkS+DIHTtiXbp2yh12z2DaZdJrWR9Nhm34WSaQzevEGdcTG+kBMdnwqolWDNSX/+qQzhMp/f96/atAUPeNp5vYpQXEK80i7E9D7eDIfyDr70FbFI/I5C4+nPD6Fnj3pYav2RG096y5sMXYQSMC0fxbWK9ELULmYwGeP8aWGtcmkRnqtuXdOlCAQGs1gVdEmsX/G+8TYKxMbd4xubssg0bYqpus7O4OE2XMV6VyY8dne3QbXfL7wJQ0NuGQB5qAyQjzXuFE4jBFs8h2lgLNVaC0ma+9C4jVyFEzG/592EQociwjn7QfscLzr8h1p4gPnnvKDaHqS05YN+CykPrlAhjFjuOjEF2fhz36H5BiFGBfo+Jjo9VQ9o4sV+2ScEAUp6NnW68tYsaEVtH8lqUOiZAm4wuynCXazBKY5UJPCSQS5ump9lU7jEGOeVGXaKuJy5oGtSgbvE8BnX4Sv3IReaU/wOGKsTE7V7CHvwla1ttAHgAySU/HmTFzJV/o/XOn/eM44Hi6DVyWDrz3Rv5n6kgb2ujUEmNOd441Oxl+Bm7Ik40JfSi24wKLg5JKZD7siJFjSnWKb5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ebce3e-2038-40af-369f-08ddbae5e6b2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:31:13.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaedlZ8tfNWTIsOZTP9EYsytTvfQIGsa7a54Iwz4H/QYzSpyNRBBA3E5NpeVzBHEyqgnwtvcxqvYuc3WNbOpCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507040080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA4MCBTYWx0ZWRfX6Z1xwLo2Nh32 9utnueN0KFN00rWlggjsJSfZy5/m8G9I6aZwY6jc0TkB7fi1PDzSZvD6hPvssdkbB4ZqkGxEZX/ SQ5ihslVjwu6+OLYb2GnCCM/O8OkEbUEYtjHUpFGKcrUhgzRUmIXx5CRUj37c0virsIdlTgTwLi
 rmwSsgP/bn0qa+bmIMJET7o96kL5Va9vtfrCjd/WUc19xs1u+SITSgBDhP82UKHgeiR9e1jXCTw dCxak/ylh8rst20vLpAkeeikDIgUJOZtp/TUZQT+vhj8puXST8lFkSel0W9IEY0RErDd+cffbRC bZ3r2wO2/HerulGcD6XRO8KGqcHwjQ3GniZ+L8lizmWM07WEO9M9UuxE0IUfRc6WpzDqf4EpeDw
 1+EYiVlh9XxjgK9EtQk1LgdxAvVvkwzTcLn/syUFxh6OXwG1s6GG4ZwaGCEEsNKxF6FBxVyc
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6867ad75 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Q1BWfwYOwipsV7-Dq7YA:9
X-Proofpoint-ORIG-GUID: 2EC78-aABkx0vJiU6P5VawSTykoRm3xp
X-Proofpoint-GUID: 2EC78-aABkx0vJiU6P5VawSTykoRm3xp

Commit 48b4800a1c6a ("zsmalloc: page migration support") added support
for migrating zsmalloc pages using the movable_operations migration
framework. However, the commit did not take into account that zsmalloc
supports migration only when CONFIG_COMPACTION is enabled.
Tracing shows that zsmalloc was still passing the __GFP_MOVABLE flag
even when compaction is not supported.

This can result in unmovable pages being allocated from movable page
blocks (even without stealing page blocks), ZONE_MOVABLE and CMA area.

Clear the __GFP_MOVABLE flag when !IS_ENABLED(CONFIG_COMPACTION).

Cc: stable@vger.kernel.org
Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/zsmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 999b513c7fdf..f3e2215f95eb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1043,6 +1043,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!zspage)
 		return NULL;
 
+	if (!IS_ENABLED(CONFIG_COMPACTION))
+		gfp &= ~__GFP_MOVABLE;
+
 	zspage->magic = ZSPAGE_MAGIC;
 	zspage->pool = pool;
 	zspage->class = class->index;
-- 
2.43.0


