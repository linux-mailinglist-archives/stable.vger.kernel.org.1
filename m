Return-Path: <stable+bounces-200440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380ACAF1E4
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 08:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 245CE300DA45
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8860F23A9B0;
	Tue,  9 Dec 2025 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="G0YFrxwq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93982221554;
	Tue,  9 Dec 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264939; cv=fail; b=LCoG1K4yzcB6sV/u9K7OzqBXtcspPaWN9WKB17OQYU1fl/g//kJGdR18f60Yjjc53Vinv3RXTN2Dh7Uh2tuYIAe2Bk110KF0sXOAE7Bzy0RkFK1GKmu+IdigGMD5v9W7Z6jODGYRhjbpVFpRJ0b4vNw8F6wJM00n1bRms7Sfy2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264939; c=relaxed/simple;
	bh=tlorY8dMicBXiG338/xzkLsPiQtoybaRSqC/CkARD2o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pHnY5aq0VJ2oReJdh/MGcJcfhjBP1oM0YeN3Rg/XGPag6S/mj73GKvk6H3bGTei/PXPJtQxfbv2HEFKiJXuirfdTPXjZHIatVr6hu+ZdbtjYxQHOhY1s0Wt90DPw3hSrxJDtX8+MzqT/0kXv4noHPo7a3JngrdkE0MSw12ZwQgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=G0YFrxwq; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B93kqdV2980322;
	Mon, 8 Dec 2025 23:21:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=VC9TMto7i
	GSeaVWGsTAY9jsz2Jn2ohL8qOA1CgbxshY=; b=G0YFrxwqePEXt2xv1fwChqIsV
	f6q35xSMu2EFPS6Z4CP8i9kIn4yYGFktasWFSNszc2U+IjxAHXQ9FZLd1I6VLZDF
	NsdNNIcd1zRgL8mFukGg8NyYy1dk+i5ygmx1xumhOR8JlyWBwP3D6PkcbkZERwPc
	n8h1HTuy7xDZSxwDt8qfjAVXjt4wMRK0YIx0zTMacSomAS5+Td+qSzNmo+JOkODS
	kVTPr5dlkkU+6NuCiN2bDuC568Szd7Aw9HIqimUcwIt4hpowqobKqT7xQCarn6dk
	+DpjDBit3GQV80P3j0UJjznZP4ABkXg//qzFCWHqA6FZCJOa215S48Bp6FXwg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4avmvhad8j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 23:21:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+jX+vvnxH3q1WxQqcNpyhDBAUhZ5OgJpGUZzFzAUDv1j7Qq98CtNfPDZjK0h/feM59fQQNKxanGfKivHUXqutOLswJ1ypUiqzfzq0lok8BMl6O2zJI80jSxxJRHPsp2gDAnIXZuk5BgWhJb5aHEb1/vXwGWfnU0+ZNw0nqVkNVERXqRvjvky9cA78Gd4r1E8sqGHH/NisbBo0ohUTwkKLC7lgQ0REECTU5R+h4JaqX1kww1iAfBEi484l5f3oej4R/DyoVjUOA8W7Z9YoszfIOHvRC8CVeNjjosIkAtF0+I2gsRv/x0zLYWjRotcaKLlt9UCrPdGLN8PYTmUMRxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC9TMto7iGSeaVWGsTAY9jsz2Jn2ohL8qOA1CgbxshY=;
 b=mjiI4uJ9AoHwppNbsyF3ViXGa/3+SVUci/uOuEf80GZDQVN+3dP4vkYyDHx1JYdvHAvldzW0vcR1IbHV6fFN8uwzfH7RMBHp5lVRqC4akLtAZKAFmLbEupm333cdza80pPQbD5omx3IIDTHgEn55mbtOvCzQD0IoW7NTllrrS/l2t4SgR+xbxu/UWiwgQ5TI1v8j4PyiJYzJzMcsJhZaF9/uH7c5lOODfZMe0nYYIWzacRwYy+FGgYNzgtOWmlxoktDoxgMRvA3eut2PlomWgLpZfPmoz/9688Pg10I69RjLcC5Vv7zbtTtSiWyGKXRkLtL5iONZpzGd7ZdPraW+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Tue, 9 Dec 2025 07:21:50 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 07:21:50 +0000
From: yongxin.liu@windriver.com
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, vigbalas@amd.com,
        stable@vger.kernel.org
Subject: [PATCH] x86/elf: Fix core dump truncation on CPUs with no extended xfeatures
Date: Tue,  9 Dec 2025 15:21:24 +0800
Message-ID: <20251209072124.3119466-1-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:d10:31::7) To SJ0PR11MB5072.namprd11.prod.outlook.com
 (2603:10b6:a03:2db::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5072:EE_|DS0PR11MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1b4e73-0626-4b0e-16e9-08de36f39e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pazwqTTkKHBn/sOsLGnItcTEkrgTBEkv3MHPfrJyEgFN3jHz1zBs0EF46/cK?=
 =?us-ascii?Q?w5Kf2C7PJlFDviSqa7V94aNyIhdh3aUEUxpc0df0IWE6NswJIfRcXo6wRSgl?=
 =?us-ascii?Q?r9LXEeCPHcgEvhW/ponleWtoBwA7YxmS+UlkzrkftsqvYgDrSrMos5ZgldEZ?=
 =?us-ascii?Q?PvwnF+n4hp4QqrYm0SXpof801JY0VEy5mRt86Q0GOrPyNGLreEKF/zPwYFSS?=
 =?us-ascii?Q?Jt0Nbiry3Yxm/Tf1STiNZDZXoBErDPYN8MmEjum5awmz4Di27pVmWC5pO7JD?=
 =?us-ascii?Q?LaWGmLngiRd398ClReq5jcHDokWsmiX7NacQasyGVjaxvh+8KWkHpEXClu7v?=
 =?us-ascii?Q?f9g7hpT0ZCe5CtHXV5eTr3rr25wj3sbFP468n4/c0XHg7l6nWGdFZ38b7zUf?=
 =?us-ascii?Q?LhZiY2IljcNR8HcNKoactOByIh3JKqWSjsCPF5/51vUenQhickGIta2JQYvl?=
 =?us-ascii?Q?BnlaYO0kXHusxeEJpSpysT1pt3qhu26Mlpgmcs84bOS0mvBmMtPX4tPMquMf?=
 =?us-ascii?Q?Xm9xrOsLldXzJEpD1/ATbx9516EsuOipg2vvcgZwWI/5W+BY6coR2BEJiPBb?=
 =?us-ascii?Q?fB2gjdlUFVwmcODdKNyB85A2BfSn4lv6Y/FpWUHkdnmeWeRMPaHGtjgke4OI?=
 =?us-ascii?Q?Bwxf+xCP7x40f8O8L+8O65YjP32KYvsGHCQ/O7NWGbQWry4m2N9VSyuF9u1c?=
 =?us-ascii?Q?MRN+Bxn0j8OD3wiCHGzid/+oacXbXtYNRhb+NPLIwLFbKlbRG0G7tbgsvJXX?=
 =?us-ascii?Q?utuUXp355W/7fYILcxBRffCH8U4dyH3ivef0JqGyzpdFAxOUQPonLdBrKoKh?=
 =?us-ascii?Q?Bb2+wH/waOCeQ3aqzPivB4MKzl8NtOS5JgVQJNbLLuF574YylOqWHY9dGVFK?=
 =?us-ascii?Q?p6YSWfHGQtGjhitQEZP5Ls4aoqrXRF4mPzfUhvg50oltFFfwK3K0b+y/IroA?=
 =?us-ascii?Q?3XbP07w67HqGLr+1GynuZo0jbeln88Wxr52EhAxR1uhb4TFp9pIGxuoI4Sl+?=
 =?us-ascii?Q?H7Ye2DgmvDQisT3sJr+u7GHl8GS6vGGmKafyIWCsxOrhWQaBHpMTrAyp9yw2?=
 =?us-ascii?Q?VDwb/EXYfK+j3FJV4NQ6M5Ubc0X25oIys/lUHTgZgwD8QzMIZGo9OEHVJlXP?=
 =?us-ascii?Q?2BriqHFx58KC0d7WeeYd7edTxGW0TpSgTNQrtdRUWyBTYP3gQSSFQjQYBFde?=
 =?us-ascii?Q?TJF9+1LtncWVEQtkng5TJKxtdxBkcp8siKehsDElN1yz8jEqiuj7RiPzOyks?=
 =?us-ascii?Q?cN/t5yiX7rtJG9zHOXnzdcunkNvCiWqwWn8k+K+WYRN/IUfNWYZkDiV/NtlG?=
 =?us-ascii?Q?5PiGNX+tAAg2uhnzcaVFwNczBaufsD8m7aNJrrXA7Xw9XYnVwLUC7iEAlGHg?=
 =?us-ascii?Q?Nc9SspdhfnO1K61COTHIfrU5vefyz+oXcv/KKVaMOjtNZDcmISKP1MGpGZ6V?=
 =?us-ascii?Q?TqFackUDU4mnAyAnJZLO1Q/Oo4BZQ0WkeUdtsznc/pX90SK/aQN7tV360+9Y?=
 =?us-ascii?Q?I5IwQiHdYsvl7Rmog7QG+d1lH7FKPiawvGah?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/4yeHWt0lhkfU7Z3HWqIuwCchGC0UEskYBO7EBtSBwmnHlYB47xqwYH6kgc?=
 =?us-ascii?Q?+qfmhdmJ886vDx8HisWoUwzuopfTTEfrblnKX0w408vEIvDeFnQDamqlZtQY?=
 =?us-ascii?Q?yAgvwib+ZrIf+RJ69cDOaaGOdZgN/2oOQ9CEN2OuwCrZl9o2eRPA5XoUvftI?=
 =?us-ascii?Q?B1nYeNpZtakGKJ9c8TN6xlOtqnyK3ob+LzldwdkAzsmdaFOlbaMA5qEGnGGW?=
 =?us-ascii?Q?GK5GfjXhk+4MD+GaABBG5TFHqo6GCBBgOuEGe3jvIMJUkJqs1vsDFcNqoHoM?=
 =?us-ascii?Q?kn3YawILxsx4+avoEfcqYJqRkm678bOBNfQui9dhWtmawchzJ41E8x9yT88M?=
 =?us-ascii?Q?fn+Jri1z5jmciq+nWaIIU6nUvGdteM1/vhpAA3bWM0F/Es3P62mD76/c2NcG?=
 =?us-ascii?Q?fAVnB5LkgsKfPzo3MsEl89x2sf/5qbAUCHHwj3Ef8WVl2yBnl3eBof/lcUf6?=
 =?us-ascii?Q?vISTMDLvXDkHcnX+ihuVLAgXQ9Uam04yxYmw3R9LEBpFwnYr4qxAxT52qdG/?=
 =?us-ascii?Q?iiGha5B453VgwWCe7ePDCdUo3OtQJFaVbnepJIAnyh4c8m17J5l67Ticcivw?=
 =?us-ascii?Q?DvJ4k4c5QozXQ2DSzgn6gC8XYWV8ozGdxWVRorY4BkX6UqX94LUAD9vFLFXO?=
 =?us-ascii?Q?UgdJMD8aatoXhAzsLZzfuFaLlqbUvbNKyzCqd9kKZQQpssArXNFMJqilO1/d?=
 =?us-ascii?Q?GGp8x/95xvuTZNYewmBGKwlPdGX9LAOj3G7WCr5zsl2sU33fhuKMaKCXlrNh?=
 =?us-ascii?Q?hMX52FkNYLR7hJT8wC8ViwP5OTBgopbtlqeQO1zXKn31HTX6AF5yvZ6+gS19?=
 =?us-ascii?Q?x6CArEcW1AukNCBVIjWZvyPJMCtnLjeMFuRlRLjW2l2CgKOz42zXua4dGM99?=
 =?us-ascii?Q?FvsJS96Bp53WLjKptb9OIJ81FgU6T/8LojX9gH5wuVHqgCCrZHDDuITdZueJ?=
 =?us-ascii?Q?xkOF/8C5Bk2i7bXyrEXhh7bkok/2w1rl2rjvQ/59GVm2Js6XvmdacoY9CLCh?=
 =?us-ascii?Q?9Vyc3Z4DHT0x+rc1cCxGq8RU6ymI73YZuzKr0mE4/ZT9zns7R+rftVVWWi1U?=
 =?us-ascii?Q?IV+kVrpuZNLiZWzyCUhHwHtKjoZa4dn5tJSAMRdkuDEDca47zf6QjpwY1gZn?=
 =?us-ascii?Q?7EdnkWbZjj7/FDpU/JTVsBz+Ys37EBwsmwRiuNT4snupjj44dixjFLVVa9gF?=
 =?us-ascii?Q?jdZ3Fp5mvmBBHz8JlQxBhsN8js7wWo7YWNJEp9VQTFq0JLYktZHCkQbp5fVU?=
 =?us-ascii?Q?XMGtg+B2va2yb209Hc6CfqMBfVz7HfeFxFhKI/JV3rc2A5dd9GTXn6mHCgA9?=
 =?us-ascii?Q?ajkeWIKTImMgc3abdhBKuJXguAGaGxPZysDa0nutMT0M8tHElYRjSGRWqOQi?=
 =?us-ascii?Q?Z4bvMn0z/yuvF1k6mYv0m0yy17g2T9Z6xhS9JYnLrWAIwTBcKUB1tdFrjKsj?=
 =?us-ascii?Q?VNHaoIPt8hk3KC3RNRlimoLAwQ5ShTsUrc0SUtXLh7B0nERBO8OfZZ1++BAF?=
 =?us-ascii?Q?67IEz8WP4XmmH4f69MNaEmFkpJIPLAE+Qlpj7p8EOO0osZMi0lDWW+jRiQLt?=
 =?us-ascii?Q?bCeauXi133jpoHrxCUysGEJHfDuDt6hj1spvUJf6n35hnJ1g8A/+BpOlCk/9?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1b4e73-0626-4b0e-16e9-08de36f39e78
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 07:21:49.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKszuaabuTYRfw3/xA7HrCWvmdsudaaRshDl7s7cXVJns0vkONsC2jjz1k+EecRdKPZ2JDI39GC5vKGujaf7gHzBJn5WtgzaOJcLCd+0cd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-Proofpoint-ORIG-GUID: 8G_97HQEzU2ZnOj-ZZl-ptsBE20w_eXX
X-Authority-Analysis: v=2.4 cv=be9mkePB c=1 sm=1 tr=0 ts=6937ce10 cx=c_pps
 a=THEAVZb93WkyejmpPpFvRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=a2toLocDUCzNOhGrn8gA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 8G_97HQEzU2ZnOj-ZZl-ptsBE20w_eXX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA1NCBTYWx0ZWRfX6PRMCoF2Sqni
 yum2zUkr5BJHolcJG6GpSPBUsDfMORfNkk3n+auANPBp5K99/VgzPzdjwzBVsUlDBY900CAZomG
 DwrQTFCH/V8yompvNE4O4L5tKCEZF9biC7JNkVN4LY49F2BK6l8jXHQTZi6COoZnBhO52IEthJf
 /mgmVg+fiWBISk3b0sz03+9v7F6JvIHf211PXC10m15jkkOpkqIaPWrZWcgR752G9bGqAKOOrEM
 pWwlPFmGNu2KXrF407EFYkbSj5Vi5ngR5+Msp9v8lZitOpKEg96OAdLz7CjEt//3IMdBb3XB6Nd
 d1jFcYmLO9SQM3QzA8M5PB6lYak9uRgc+gcWB3twVntsXsiw14ESJjnFnXfTURaiQ1YLe3Y6yw4
 +yMXemprY1B/3Qd9Ys/z80/oYx51qA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090054

From: Yongxin Liu <yongxin.liu@windriver.com>

Zero can be a valid value of num_records. For example, on Intel Atom x6425RE,
only x87 and SSE are supported (features 0, 1), and fpu_user_cfg.max_features
is 3. The for_each_extended_xfeature() loop only iterates feature 2, which is
not enabled, so num_records = 0. This is valid and should not cause core dump
failure.

The size check already validates consistency: if num_records = 0, then
en.n_descsz = 0, so the check passes.

Cc: stable@vger.kernel.org
Fixes: ba386777a30b ("x86/elf: Add a new FPU buffer layout info to x86 core files")
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
 arch/x86/kernel/fpu/xstate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 48113c5193aa..b1dd30eb21a8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1984,8 +1984,6 @@ int elf_coredump_extra_notes_write(struct coredump_params *cprm)
 		return 1;
 
 	num_records = dump_xsave_layout_desc(cprm);
-	if (!num_records)
-		return 1;
 
 	/* Total size should be equal to the number of records */
 	if ((sizeof(struct x86_xfeat_component) * num_records) != en.n_descsz)
-- 
2.46.2


