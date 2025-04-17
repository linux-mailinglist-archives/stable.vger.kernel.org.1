Return-Path: <stable+bounces-132917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9568A9155C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F05319E0C82
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA0F1A2642;
	Thu, 17 Apr 2025 07:34:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB721D517E
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875269; cv=fail; b=Y0W8a6SazWEgYNTpRSwQlpT/OaI/AG9PxeNzIY/HCMe7ItvB/MpSc3lDQt+xQqIFgXbPMNc9KysB+r27SRI/SPrQ2OEMbTtqWFmUkIj0g1aI8qLW71yXLMV1MWgY6vym7l+VKXTcy6+VXoQgL0n6JPk3STqcfOGkhxEy1cJbf/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875269; c=relaxed/simple;
	bh=yYqYVrT/mviq44XoKWEX3IdlLoQIRIiAG11jjnAUmW8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AETGbnBjsNteAdtxQXecPW1r/8Cs6wf1CMzzqVzVoDf/2roF7P0CHjjvvRz99/lEj6U8Po6EFY8JRtg4+9kJ4CU7Ypy4djfrTb3aSWiIKajQLBHZCDVEu950nuqFZ34x5dNEJbIs9Auo6pG9bZtrODhwEshUDj3mcbMr1da0n4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H6A2nv001881;
	Thu, 17 Apr 2025 00:34:13 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ykf3ntt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 00:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeZcj3g0KZzuQGKgAdpcLqbZ+AzSYtXdL2YxkurJ8Kef6+jD2WBPhqC+PCsrZ5Bw+1PdhP7nJfN/LbzaRLJ2kGWVr57gCbfkzx96fG/0Cle2B11y3HIbHi4bqhIoWqb9HfMmhvtO8stvmrZxmVFiGMZVLcExQ99TS/JXco4Z3K0VpupBDdnH3sSpGU9XE3iaQ+PfrtZsMqkX+rzX3czi1ef/Ox2KQpnJhC+4A3B3fEwODW14J/4/NGnRiQ/vYT/V+sv41/zpHU9WSk7rXcHUIgIdeLReUH3wMCCv513WGH15YHrvsvQ9U6EltQhOq1BDPIWwDwh1FXRu8ubdBaItGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tDNxgFSIyp0iX0Aw214UA9OjI3yROFVp4WNuCnM9zg=;
 b=KINJPfVsC0sntsuixI9sXUhg9wVCfgaaIu5sZlFTt1rESW6uaradsAnxJGZUwQf/NPeAdNkXqaTjlTyfINUEXzZCL1TIS1/+SEj7Mf4NTHJcqqYpAl1lm8XRgXGjqOTBpRuj+kDIfrvJ4lh+0mzRL5ToxiY5W4KLjfCrwfEazTys5q4SjA1L6HaEX4H2f1K7ErR9lX4NZ8vbkETMLviKyMW+LvetkLJoAxC7Cj9U4Kuth66lKhUM3hbAwXW8dSgJNKtCd5nq/kp9xaR21ox3u2QavYBqhS5AFat6YIVXlXWDjA9wzbOPdxjquuwlM9xtVCxnTcy53fuE/MkSyVe/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 07:34:11 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 07:34:11 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: hch@lst.de, yukuai3@huawei.com, tj@kernel.org, bin.lan.cn@windriver.com,
        axboe@kernel.dk
Subject: [PATCH 5.15/5.10 1/2] blk-cgroup: support to track if policy is online
Date: Thu, 17 Apr 2025 15:33:51 +0800
Message-Id: <20250417073352.2675645-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ0PR11MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: d43ab718-019b-4d0b-6084-08dd7d823e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iTAgxw4RRfalb6ioyOLCUX76rX7EiaXQwF1ujDGoR7yOCkirOGutlB4h5KE4?=
 =?us-ascii?Q?4zfIE2mmla9xMB8uqlNNAFMgA+5F8gOxS02mfNSnZuJ7xtn9WZTKUSUNinM2?=
 =?us-ascii?Q?KgvyoXiInRUbUrZMlT1n6zKsPE24nr7R/vCGMbrgNsLs7O52ddghO2jaN1rK?=
 =?us-ascii?Q?kjUQUZAs2O7zt61jAuHbdXogki+JDScDrqFyEp1+Q1Q6iaAuH3aWtYOPb2x6?=
 =?us-ascii?Q?LzAyXhD/qJWHLhq49vMWAEOtnmoG2Xy+5rG41Itv74S7QykEX1xrkxCbo52w?=
 =?us-ascii?Q?6Z0C/sCyNuinmwC5VI975hD7qhrRfOC2y72n3GiE8Cv8MayFW6JorZbSEupL?=
 =?us-ascii?Q?HHfcRaa/B5QGXlvrEHZAi47Qan0iwCkWgLOQ1QCUNqFNPIO5CDtHvBvAYbfd?=
 =?us-ascii?Q?xWLIHOaFlQV+QBUQUeC89hNizgDTWIAIu71NaPnSw68Xvh1YQej+fg7W/fMk?=
 =?us-ascii?Q?KpSLUZv+uvNwpRE87HVoZDfTrUhrvn/jMKYIM6q5UIwWhea/YyvjnBcDW5XQ?=
 =?us-ascii?Q?L/UaozfwozlANBctzniw3nEvAeuMwqDAYoRCwpWlEbmL+BmOpNoYdBjj+sS1?=
 =?us-ascii?Q?uKD3O8CJwsZwWSszmtkD0ifgFxT6R75DSuQTG14WlwhUVXHTeEcexChnNbLo?=
 =?us-ascii?Q?WDAGeZftRTqrw4FCGtQm6PbsTxQjB7vZRpTuwNeW18KzxrCoe5ItgKD24zNv?=
 =?us-ascii?Q?VoIpHF8BVCczLIWplhk7G1k21CrtCW2Bq3qUYlB14nNzgGSt3s5DQafLbY9z?=
 =?us-ascii?Q?TSmY3mz356iuflROSIMkGx7Aos7kiGEr+oDg5et15osevJu+5lo0FrF7NdQ1?=
 =?us-ascii?Q?qH/LMOYJUxklU7KF5kZ5dEqecRd1XUy8DjKw3rqjFqlKKn14GTpsk4BSrct4?=
 =?us-ascii?Q?32/8T8v57kGx+bGV0wEdQIUzpThw3cV/T1jBrz4au5LCyJHHtNmaX7FqT6C1?=
 =?us-ascii?Q?tCbE0yK13ZrYpEqo94+j4E85EW/tzsWUbTApltb1YGcE0h4wbERJwcix61Q1?=
 =?us-ascii?Q?zH2LE2hV0fEc0eJvZGAinNAyDtDrUGw6TLs4msNOrHqsPZ2e1s6va4m77b3G?=
 =?us-ascii?Q?e7oI+K1J8XS8beneXFYD3sHe4sHcmvZwH3oOM1FX2ktISvKxxAFJlk6+fV4X?=
 =?us-ascii?Q?4rPh3Y+rFeoGEFzhEVVaebHsnz64FiMW3n8U6U0rZ6K70Vdyk+fQjGcPO4bp?=
 =?us-ascii?Q?HWkxYTgJUB34ytx6BGTzt+ShGXm8ZvdpM7KM7BcIVijRotqm9TCntFul72zs?=
 =?us-ascii?Q?J/BN1pfIXGmbMNbDHasyaHKqueF17tqph8SZblIFhr7wyF4uo0vkBVy01oXn?=
 =?us-ascii?Q?oklwxVa/3iFxIn7wA00g0eDLC8yNTb+3k21DkSE6h9HeGkkip3n07PM8IXvZ?=
 =?us-ascii?Q?maQaRZuGYznYWDpA4PTpKfQO8/n8ehCSrDU/JULUeE4lYJA/RUmlF8TVicv2?=
 =?us-ascii?Q?gf6dJ7KlaCg5KMaM568tjnfXYJwvPb2hMyrRbLOdGfdj9bWPcMGuNAdZfTUs?=
 =?us-ascii?Q?3rdBvuh2WaquGvc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?umAJhP02EmdSR1XeS4QPL7W14znPhxRZ7j5yptN017rBQRTeCvKvuYcKRyMj?=
 =?us-ascii?Q?PstlOsq8NTqkXqkTi/pMjnf3f9Q5P0Vy19rENadLntngWGnDslfBW+q/4PCW?=
 =?us-ascii?Q?ivXPnE5bGW89UICsmIdMfRCKXc9Sst15/Rfvgr7GwJbc8aGS38vcbd2iZPdW?=
 =?us-ascii?Q?lKjNUx71rN4jXfVAh/brfeZTGuaqCZWCJ6FJYK8gMeAzFMj6zlues6+5Jj5O?=
 =?us-ascii?Q?uu6eEpPJ2sqctjG5KZCdK3hBMdCT9vrBhD9dNd+TSpd7KgQIKUsBkFDfVsMJ?=
 =?us-ascii?Q?ADTDYRzcPnezXCdb9uyhHpXnPTeUJ9GU/BV0PenqA+JwGXRhtAtpVQtISeMl?=
 =?us-ascii?Q?n8hjzrl/U3P6Jp9mAkpgeDP5oC7Hokvkr5eowdu2a+ncZDCrDciKrvTxNdWq?=
 =?us-ascii?Q?z6ZSFAsj7BizlKziEAciagll5Pc4sXtFnAvQP80Wci3KnWScpqGgpzjzvxkB?=
 =?us-ascii?Q?4iJwF8nf+LUCiEbaoAQP1ojhO7RSVK3vgCpPPw4iEwq+HVFaHNQzHiZSfnpQ?=
 =?us-ascii?Q?2GWyBKOymYDZW6JzO9eE8dH93mwl4be80oVp49q0PQ+infzQDXZFnGZh4olT?=
 =?us-ascii?Q?0SasyR4HxOVETK5N4/tEUPWNo5TB2e6dV7RDFbH8xDIlhX9WtTTPJLoJQ+lo?=
 =?us-ascii?Q?hMPx7NiBUs2oSE3lgAM+5vV4lhz99E2GQCAM4t1vRxE2g6zoLvAxvU7x46ll?=
 =?us-ascii?Q?Ge/h9/m+rizoyfRrWmuT0c8oxEMRUVpMFTz5O2hE30TkSMqWc+TLz0hnpQwM?=
 =?us-ascii?Q?RjKg1ilij+KZ/0Xe8ZWr1Zmux4/09Amqt4Ihi17gRp2cJGocc0Fm9B300+Sb?=
 =?us-ascii?Q?pO+xRhhjHTQjlcfKX68/cdIKOIiBl8hU+c7lL1lxWjyqCQ9jRueCzVoT/5nN?=
 =?us-ascii?Q?PG1BGAchMj6SU1NE/s+QBhrJk4Pw6vAPM624yiNVXCMXxo2tOABQNuXBWqPQ?=
 =?us-ascii?Q?EZi3ecRAxl5htG1pkYw8taDVHa1OV748hEyjAcrvfOo5KVTGFZWNFJAaW2Ia?=
 =?us-ascii?Q?+6PPJOh96Q9gqsqat2yyrCR9KnqtMSLzNRaKONaUqQfPdvzUQsQ9cUfdycQH?=
 =?us-ascii?Q?I4FJ3Yz+iXruqwLPBrcukR0puLCGMgXGnSvOpQCdIr1AMFp6eWVbs2C9Dc8B?=
 =?us-ascii?Q?IOKc8gLotX98+izJGYRz0eT/qjm/whHc6FG5BZ7/SqTheS/Kdfe51p5uqwd0?=
 =?us-ascii?Q?BSCAyzdXrbKKgrz8zMB65wRApYuDQNwH7hW52TNmXWmgznkemSIWzpuQo4G2?=
 =?us-ascii?Q?TEFJ8IEv+BkJN1Z9CKiclHWRCmnJeioJUIhxJc9HyQ7SULQqvy8TRE9/FozB?=
 =?us-ascii?Q?QDBgdECWvRV8kwj1FxooDrDaHdc0J/pgkfwF6u7L6aK2vAz8PDroU8nIaxVb?=
 =?us-ascii?Q?XTcvafHjBjyTWJSkk1zq+cv2F4YcNaomtHhxlu/tEqHJBh/5V1MZzsPX3AY4?=
 =?us-ascii?Q?hh/ny6iUeF2aXbrcCwC9CyORApJWK+nDp3048Qiddh9bMUllqO0UQFRwi9vV?=
 =?us-ascii?Q?if4sUTe0qywY2zQak1H762kgai0A0qUoiu2wNerQUhIgsSaV7mTingLtxDYH?=
 =?us-ascii?Q?gFjUXgzu8DhB12exU1myRleUhUyZ7w0jLjNkIT739mC701225t/DhDBNL/US?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43ab718-019b-4d0b-6084-08dd7d823e8b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 07:34:10.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhOW7fN0bT3wfF6Sg1+tlbLhI0HXCD3y3xO7QBFLyIvMNp6G1Rfvnf9uAyy3TnvkhsrMmfYRQkPr4H3Q40EQ+L1AHh1nWb0eQwqWLz2J/ZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-Proofpoint-ORIG-GUID: 3rvAs9clcXE1BZBVEckspkLSjUrqbxvD
X-Authority-Analysis: v=2.4 cv=Wd0Ma1hX c=1 sm=1 tr=0 ts=6800aef5 cx=c_pps a=vIBLTX18KUGM0ea88UIWow==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=t7CeM3EgAAAA:8 a=lGBpaaW1g1IRYbpJNncA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 3rvAs9clcXE1BZBVEckspkLSjUrqbxvD
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170057

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit dfd6200a095440b663099d8d42f1efb0175a1ce3 ]

A new field 'online' is added to blkg_policy_data to fix following
2 problem:

1) In blkcg_activate_policy(), if pd_alloc_fn() with 'GFP_NOWAIT'
   failed, 'queue_lock' will be dropped and pd_alloc_fn() will try again
   without 'GFP_NOWAIT'. In the meantime, remove cgroup can race with
   it, and pd_offline_fn() will be called without pd_init_fn() and
   pd_online_fn(). This way null-ptr-deference can be triggered.

2) In order to synchronize pd_free_fn() from blkg_free_workfn() and
   blkcg_deactivate_policy(), 'list_del_init(&blkg->q_node)' will be
   delayed to blkg_free_workfn(), hence pd_offline_fn() can be called
   first in blkg_destroy(), and then blkcg_deactivate_policy() will
   call it again, we must prevent it.

The new field 'online' will be set after pd_online_fn() and will be
cleared after pd_offline_fn(), in the meantime pd_offline_fn() will only
be called if 'online' is set.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230119110350.2287325-3-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 block/blk-cgroup.c         | 24 +++++++++++++++++-------
 include/linux/blk-cgroup.h |  1 +
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 6180c680136b..e372a3fc264e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -192,6 +192,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 		blkg->pd[i] = pd;
 		pd->blkg = blkg;
 		pd->plid = i;
+		pd->online = false;
 	}
 
 	return blkg;
@@ -289,8 +290,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
-			if (blkg->pd[i] && pol->pd_online_fn)
-				pol->pd_online_fn(blkg->pd[i]);
+			if (blkg->pd[i]) {
+				if (pol->pd_online_fn)
+					pol->pd_online_fn(blkg->pd[i]);
+				blkg->pd[i]->online = true;
+			}
 		}
 	}
 	blkg->online = true;
@@ -390,8 +394,11 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 
-		if (blkg->pd[i] && pol->pd_offline_fn)
-			pol->pd_offline_fn(blkg->pd[i]);
+		if (blkg->pd[i] && blkg->pd[i]->online) {
+			if (pol->pd_offline_fn)
+				pol->pd_offline_fn(blkg->pd[i]);
+			blkg->pd[i]->online = false;
+		}
 	}
 
 	blkg->online = false;
@@ -1367,6 +1374,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
+		pd->online = false;
 	}
 
 	/* all allocated, init in the same order */
@@ -1374,9 +1382,11 @@ int blkcg_activate_policy(struct request_queue *q,
 		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
 			pol->pd_init_fn(blkg->pd[pol->plid]);
 
-	if (pol->pd_online_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+		if (pol->pd_online_fn)
 			pol->pd_online_fn(blkg->pd[pol->plid]);
+		blkg->pd[pol->plid]->online = true;
+	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
@@ -1438,7 +1448,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 		spin_lock(&blkcg->lock);
 		if (blkg->pd[pol->plid]) {
-			if (pol->pd_offline_fn)
+			if (blkg->pd[pol->plid]->online && pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 27c363f6b281..c5eda86e4118 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -92,6 +92,7 @@ struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
+	bool				online;
 };
 
 /*
-- 
2.34.1


