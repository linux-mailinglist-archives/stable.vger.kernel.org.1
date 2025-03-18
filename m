Return-Path: <stable+bounces-124774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04434A66F77
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 10:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCAE189112A
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B89205AD6;
	Tue, 18 Mar 2025 09:13:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3D205517
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289231; cv=fail; b=ib5fua7U9C1ADDaEDKGifKSBJdR88VVEdek2LkCOhqjynlX8yxbTG1VSTh0SE0dN5VHjg45fOzSIJZ/INROigDm71tQtNwfs4Cc8T5VoE9ECLup9S3/lN05b+yGffqJr0av+YlTaE3OHMXG/zEf2loJ2d8s6SgcS042Ago6DSx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289231; c=relaxed/simple;
	bh=aT9a1aH6Tq5lOYkTDf2CFXOYYIgO3u9DpXMz5oFK+Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g2QSACccrOCm1xLBkyy2EY9ABxzlT+JTousIzK44NJl/PyVVabwv76Lazp6PzA/w/IVP00J8Azk8DPeqbbUuymaXKZ2crYDf44OLSFWWRg+aqYtxmPrJhZsyJf/n8sM79/kJ/vWBe62H3Bw2dFCT0JIERrriVH8kPwRMwPCXD10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I4AQ0h000507;
	Tue, 18 Mar 2025 09:13:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45cxs0u6bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:13:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmJHSrtUJLCHghVrbvh8Ufa6qYhFESleAuTUxMvWI3E7HEKBZ4sg7jkWw2PmIcjIe0tkweUqGPXpR5CC8oukNK1W8z5FA1IOf1M+rJB8Iq0xkR94tE42M8m5Zv322Lu9PK65YuB8uJ064PfBvMpCjJXROfwNBiJQ/cEvaZv5k4ctfN/H0dyYC7IEFBD0y4sM7Fqvy8ZjAcjO9UEo2sRwIijaqvOKv/6nGQLcUc/Hlq7oWKdzCSpjh3zjxtbjkFzNxtZ5OfCu/do/lW3cMpFnSxOOmsi9ImToKel0vqQ/V1TiF2ZCLYSH5+OOOGs8sB3qfE4jmVUKI73uUnQbeFZdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUe/9Vke8QZc3l2lqSq0ahWViSPq7JAnVjFzsaoFq2I=;
 b=lkqSdHXJOuL5vnAqXrZd2zlV8oOMngjj061Rapr6O6wpua1Qv12Ft68+mtjwUS79l6zQLYRhFTxvsWNvTRPy7CbjosIyVWT1cENsWZdKR8B1Z/8OHJiwNE0qHxJAjd1qlglOXfBPKftnvunmIAaiRpOaMfZJtZaPrpTIXeIKO5ANFME546UX7MNryUyaGh1kK9sNOlUHvOXpMMBnWJnENU66/AmfbphO0xCH1X9G4CMErnuqaKDWMD3NVDQvoS/RciqQ9TquLHqjltLqgCjCPUnsFGFSXukhCu+1UwF50LAvl5lWNKmmpiBzBpbehuvCntfM3Se+zjTGCg/ZRXf7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:13:24 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:13:23 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: pjakobsson@suse.de, harry.wentland@amd.com, alexander.deucher@amd.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.10] drm/amdgpu: Fix even more out of bound writes from debugfs
Date: Tue, 18 Mar 2025 17:13:10 +0800
Message-Id: <20250318091310.815185-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|PH7PR11MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: b40f8a40-6afa-45b6-bdb7-08dd65fd2281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g4LASKXawy0a2hzNyiQ33VTHy2iydNmoHQbVn0jjfXFa88HkxQ4EVwG884B5?=
 =?us-ascii?Q?vz1E6bqsd1dHFgUp5CM0tPrQ8LdO5v6eZnh13tLMtyT7G1B4VBGDv+pCjY3R?=
 =?us-ascii?Q?pqxWIxNS9WbIBWS0HYE0eirwTWWALiHBmsOwnNlLVKxUgy9Hk9ovR92m+krv?=
 =?us-ascii?Q?fEkKG/4yk8HSg7L8higrhjLAySeQbMOocKqhcs0Et/0lH/s020rIOCuwUOut?=
 =?us-ascii?Q?8tCFDbPd6ohiJXzPi6df87uWuh/AmbfNeMoCAF08E0MHL3gATBCqXd0jVybK?=
 =?us-ascii?Q?dkRu+9fTgQWFKMuDDqpR4K2NfKprMNp0QxO9A3s6chWT+NTh7eO46kljjr5v?=
 =?us-ascii?Q?xS3n4mlfTBkfUZN4KITMd2TJR6yMYnyHZ/2u299gI6afPHT4sdz4kiFi0Wb9?=
 =?us-ascii?Q?DLVSfSvTs6hTnL+YPacmeuk9j0wa2xsu2zefegt5tmiPzeoEWuLB2wgeYdGk?=
 =?us-ascii?Q?g7y93k9QEX3JUm8eI+ojeZBpjBwSptQm/aFy1lxSHRL+xs5Ea6u++LN73Gph?=
 =?us-ascii?Q?0eLJ2NjS5gfxAP/97YijU/5jOyg85f3kPPiVVginh5rBfzrA0tRv38KEIE14?=
 =?us-ascii?Q?r6HmJMUy7DYScFfYyzbuaIDPuwSyPlsFkq1kzWCU6od6OD3w5C4Tke9QW8DY?=
 =?us-ascii?Q?rCLQvVwfB2MTupM5I4A4MZqer5vdep+SwQae68mVLiv/vShrYpsYGT0Bk36I?=
 =?us-ascii?Q?RVMJ9wfEWr2+1A5JqcbFACEvJ/F97iLoFId1EOwr8WHt5hVcC8zZ6YcV+J85?=
 =?us-ascii?Q?Raba9hthiiGElu3Hdl4vKGT5Unqs3Hfy/Zg0U9Ipefr5PO3KL1ge/EE6bjmG?=
 =?us-ascii?Q?wKkHlutXRQrZc+z1lcO8/dRl4mITsI4J/VAPJBApUW+6EFGUx2to2xLpAi5s?=
 =?us-ascii?Q?S7hFQ6fleqC5cb14lgL+aLbTrugz6IJcVBHfUj7m/A/DsnElYvpg2Kl/F1Jb?=
 =?us-ascii?Q?OIwxpkZeJkJEoSbACmfzdlBAYAEUMzIFCQ/VWBKptjjnW8NSgAEZz6HuArvf?=
 =?us-ascii?Q?ZVxgnz3VoF2b//Bl2FcZDtIxXsJrKJkUCKypWaJf839mWj1zgbAuX1/7LX1+?=
 =?us-ascii?Q?c7rpw+70kkSvT/AU56Vxwq8e4kOX6E2luzw8mt9LQbPh5IgGY8IIKgxnBF0b?=
 =?us-ascii?Q?x6IlJkocYykC3o9kf/PM0sqj1LyHFqSfpjTtok8kgfXKdbcew8SwYfMkO0Fw?=
 =?us-ascii?Q?CAdGq2FiqysxoDQ2nKHeMRD/RBmndcCEGc/2Zj/rs6lIOu2cBoXPth8C/EN1?=
 =?us-ascii?Q?iRwcPH8q5pgFtcOJQz0+YYYB6cMtgs19umWtLHj4rirnLEEIchNPhuNFXjwh?=
 =?us-ascii?Q?JjsQRWum+OFLSjw0dMzQnuJLhH0RhdytO5yAuNQuZRtTnFUCVBgfkDSBwTDl?=
 =?us-ascii?Q?PxcUvrLlZdthvNkmefsz59NVb/eJ8qeYqXc9YSEemSOetxI1nTHhxXamOxxb?=
 =?us-ascii?Q?PLAeXqNV4syzPnlhlFTpM/RfIQrsConU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nfntqRhE6VW05FUrRXHwJe3TbMKQCojLpUiLOyQitOem8mypikBgBIf/u5gX?=
 =?us-ascii?Q?GEyHrZpbAi6+0BREQR+P367b1r22+sOzB2YmBXz/4DeB3YqJeMdje8lO1hob?=
 =?us-ascii?Q?RGvQwpWST3Dtgm77OxmMR+kzSxPLjZqpLpOeI54vyiNFYjUWH65aa8FYj6/Y?=
 =?us-ascii?Q?hPT3gGUM0Aw5xiiBZf1D5wHYe38rmPteUtbNRcBs/gBmOSfBz5pwiYhSq8oi?=
 =?us-ascii?Q?zPWgTdWdc4PnYTwL4v+le/3huuBD6BA7fn56bLpeZfZ2eWNWILfpGb5GVH/P?=
 =?us-ascii?Q?Oy8YRZfvnaeZslNIBfdM05nWAb5tmTi/U4DAYQLpUynPEp9U0y/0rqobZI1q?=
 =?us-ascii?Q?xVrJgMH4zTuE9Ldtz4R9woDQswnrdYkcNLKbkRWihH1eMqlsRILUu7f5zt3T?=
 =?us-ascii?Q?At7u571XAQ11fAB0GhKAeMZCW5RIeAuexEHcsV17DcL/ADOdnSVLGPvOvrtK?=
 =?us-ascii?Q?vRqQrPaczpR27nzzx5gNZoo5V7NsY3IBHNeyeDMwtavgJi+EaEmCgh4Rbbk8?=
 =?us-ascii?Q?oSp0rivbBMEUZ+jPh4/byVv6fQOequSPXshQoAISzyajggGdvqu8ZBnBaEM9?=
 =?us-ascii?Q?/IzUBGPTxSvo3H60uVY4eo4Cam08SIT2NOcelguBLV8eREGTWzz3Dd+Iswbh?=
 =?us-ascii?Q?FI8lR98JiYK4+xL16WxeCpPb0O4ZwqoniyjV3yb4kxCXFAtKe2rM0KLuzrVh?=
 =?us-ascii?Q?n4n1/AOJRn7xEckLo1rMPT8YOhibgy1RFIUtBth4tRdFn/Xom0MmXGFk29cY?=
 =?us-ascii?Q?zYAoHzrA+j1Ax/ALTJRiPcsTe1bCuSrurdVAhhLBuzGof2BbJWjCosgkW0dY?=
 =?us-ascii?Q?ipmdrGTiBNOdRtyhmY5sbpRJD7loi+5O0YXA3ecw4lYZf5eHTihwhYA1k1zy?=
 =?us-ascii?Q?12sjBzb1YGv4onPwnLn+UjswyzlJwFHlW2AB4yv+myJUp8FMIUc12JokJzQm?=
 =?us-ascii?Q?k/TU8WAAY5ze/OwGA63ocYsx+HVYTYgGwCNK65hQrbhk2ZZ7ecC5EI4vEh66?=
 =?us-ascii?Q?8O/b6Y4mpM/F6eTPlGPqxlvT4IrssY6Y9eMrTZzpUyqQOVQ3wxWzvn9+hYCt?=
 =?us-ascii?Q?FAOWeBh1X+c3C1F0wFSE1/esGk0/fW8e5n/h1D1ErNl9m1eNCE+d73KxCnTH?=
 =?us-ascii?Q?X0DH/BlchLPj6Ws9SuaCEwSFHY+PmdR7NQfulA2c2ygECLr8cRENNDUsDpyr?=
 =?us-ascii?Q?D8f43D23hKglB65i/FlhhV8U/NXsJA/xptxL49ANiZGCZcSTcdjaKZR+iUxQ?=
 =?us-ascii?Q?t2YfdFUoSvspvOQaxgbX3Hz45lzlaReid5k1n43rg0t44qriyrS/BN0gk5rd?=
 =?us-ascii?Q?oJdpqH5KrkJ//+DohnyLvNNNiCuQ2/MXKj4ghQxjlNEuCE9nJ6+EDUj7HxnI?=
 =?us-ascii?Q?jxfnJU+u24hsvG+uUIUao0b47kCLMsny8H2+44VaM70YcEYnMOZE81qVBaeK?=
 =?us-ascii?Q?cRQBbfYRrcEGpgzMwDIJLUvnHNYH7MDTuoMKamTm+YkFZfhv0+kB3wZiHJB0?=
 =?us-ascii?Q?/7D0s5o99na7OysRDjI3BJwB9zZHeGY6gIBvrMFOqFV0NmiOrp/H8zVxTRLR?=
 =?us-ascii?Q?SVut3Y9dQj1aW2ebhUgGueg8vy64PwkOsRqvxd6cQj0f6atMSZ4KhKReJ8qe?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40f8a40-6afa-45b6-bdb7-08dd65fd2281
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:13:23.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdQCQ7h3lYsKPcDpUmGDEmk9FhilykBghy2djYbhNrZDUyKtWzAkdoa7P0GpEHjJ+Oy7/4g/lUe5RhGQPc3Tn0ma1YUdOgI6u6B1AHxBlQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-Proofpoint-ORIG-GUID: XIH7y2G4VUOEpu6T1fzfzcbmUi8JJ1tm
X-Proofpoint-GUID: XIH7y2G4VUOEpu6T1fzfzcbmUi8JJ1tm
X-Authority-Analysis: v=2.4 cv=NY/m13D4 c=1 sm=1 tr=0 ts=67d93938 cx=c_pps a=VzeH2YOhhDlPZ0WtbyP6yA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=pGLkceISAAAA:8 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=x66MrctR87kESpvpykMA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503180066

From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

[ Upstream commit 3f4e54bd312d3dafb59daf2b97ffa08abebe60f5 ]

CVE-2021-42327 was fixed by:

commit f23750b5b3d98653b31d4469592935ef6364ad67
Author: Thelford Williams <tdwilliamsiv@gmail.com>
Date:   Wed Oct 13 16:04:13 2021 -0400

    drm/amdgpu: fix out of bounds write

but amdgpu_dm_debugfs.c contains more of the same issue so fix the
remaining ones.

v2:
	* Add missing fix in dp_max_bpc_write (Harry Wentland)

Fixes: 918698d5c2b5 ("drm/amd/display: Return the number of bytes parsed than allocated")
Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
[ Cherry-pick the fix and drop the following functions which were introduced since 5.13 or later: 
dp_max_bpc_write() was introduced in commit cca912e0a6b4 ("drm/amd/display: Add max bpc debugfs")
dp_dsc_passthrough_set() was introduced in commit fcd1e484c8ae 
("drm/amd/display: Add debugfs entry for dsc passthrough").]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 32dbd2a27088..6914738f0275 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -424,7 +424,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -576,7 +576,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	if (!wr_buf)
 		return -ENOSPC;
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
@@ -1091,7 +1091,7 @@ static ssize_t dp_trigger_hotplug(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 						(long *)param, buf,
 						max_param_num,
 						&param_nums)) {
@@ -1272,7 +1272,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1426,7 +1426,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1580,7 +1580,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
@@ -1727,7 +1727,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					    (long *)param, buf,
 					    max_param_num,
 					    &param_nums)) {
-- 
2.25.1


