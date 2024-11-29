Return-Path: <stable+bounces-95773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DE19DBF35
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 06:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1163B20F80
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 05:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203314D70B;
	Fri, 29 Nov 2024 05:40:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BAA33C5
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732858807; cv=fail; b=YjD3YsHScYXSdVV4MGL4DXqlD0FgKqmu/Pof9N3RNZGyblPx7Gz4+kOvKtxMxGiJXuYdJi7ocbeH/RkycjPL+FZe9huHxp4SJmGjuzCdK6GUvrVkQ8lpuUs0V2v0bWgpBB+qWSWMpzTg8GCe1HXdYbqCdXsGjyt124ihfitQYNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732858807; c=relaxed/simple;
	bh=ReUAS0aa8Ry7SOZX8kkp3aYMf3NHpnUSeA5+5jcPE2Q=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uHMW5CJ5RNnQJAU6+Tmk/ZlbHOPqnsUjAtnthPTPwylJPOwQFNyUjfcM8TdxFJl9lx9mB0Zd8gkggeAxn8nNZJIIVRFc1En2PDAL8fdSQaZYhFRaswuGbTnRlhoAuIreULbt9yLLGpp4d40TqU5GzkttGLiIcbkwkgBDAVFs01w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT5VgTw010425;
	Thu, 28 Nov 2024 21:40:02 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 436719sq37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 21:40:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asnFdAaEyAW6GBKij1LfvlvoUA1iVHlgyzERbgow9ioXyDKJ7wlarUenEXytXdK8t51GF8CVfXCFaD+Pn6YGuNN3xuoEyP+ZZTvA87Qy5LBDPhAg0aFITgRNRtkYPHdVMV37oGA4eNy4P05xQgKqFXlniSwr+CAT5zDNnr/jG+gX0BWdKF3enmYsS4oC+5JI+sJ5+Xcj4CL1qrg2NlXz1liXG6LEsnMfZLz6jcyVc9z5fKhL046Cfteursb+o/stLMO3Lyf3BY/pRHzMohidjABJRoorlI8TbfuL/FBHf/6Z4LszOyWLMPVP20Td01T/sMzBw9wJVWWSGsM3dSV0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ0/yUe6oWSoKR+h+X4DEaO9r5JVMd+/9vExs6AAH7I=;
 b=gqqcYUuiqxDGl6dEA46/1AC1znagxe2iDgBotBBvOTy8G2uW7bnFuCUMbuo1TTYe0Arjsh6wi4oYtGZPQCssQIJN5RyrSOriAbqdonBHuSQkWbMNIAeQmfitTHpyMHIiK3fHolItpgrM9uc5zZGVp4Ei7gByZOBERq2R/j4SJHcEdVMkdMPF2L1YVeOsmhA64cckJ1GByuePBDJ/ieXCfNQrJjukD/+joyw7k8U1W6iO9ZyE5Z+DkAhms1SX5dRd/9jn7ffR0USSebpp3L4QqktRQ+8UwaSagv3lmFXQVc4g7axFYtJ8snvUk5is6BwJQU2TbmnrC1s4zypa3FwkmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 05:39:58 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 05:39:58 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, hersenxs.wu@amd.com
Subject: [PATCH 6.6] drm/amd/display: Add NULL pointer check for kzalloc
Date: Fri, 29 Nov 2024 13:39:40 +0800
Message-Id: <20241129053940.3956690-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY8PR11MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: be9c0b54-4edb-456a-4194-08dd1038429f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g3BQHbnmz6CViTO7t/p1spax/eXvwXZ1Xt10msKjXKBrhYwgXvhndM7T5o/3?=
 =?us-ascii?Q?3B3GJHXEai/TRjbCw8FjPtmEwUkoZMQLDCy3/rCIdLIbRcySzvwFlIjPuecu?=
 =?us-ascii?Q?cAlkWOXHDlGGbXAz79zmPhL844Z20MICbbvZ7dnqgPlT//3/kPPxeoTPmt6N?=
 =?us-ascii?Q?G8n1tT9LfPSMkaFEArmHKuL6QvtxGc6RD/ZZcLIu3V9a1j4zs2ZvHoocRZBS?=
 =?us-ascii?Q?RrQKgu5ETLBf3vkDVbKduFgXCDiXzdz+kiGwOr9XQ5khu8wGLHjdCtAkrGHY?=
 =?us-ascii?Q?1TIy+Jsnat9LQvbvDa20GmhFF5Ke65AhOlAjziD7I5RgY64oeTV6cdMtTRGi?=
 =?us-ascii?Q?X7R3Na4l/C4z2aUQrynkCLuSCc1UVUews9weZgMNZTiQZ2Mh58vMUMS5ReDS?=
 =?us-ascii?Q?IAGlzXTT3+YKaPfxgQNgdtGYidMUw2xYmV8Fq3q2vNbBoXmOUdjPtIAkjxXA?=
 =?us-ascii?Q?NkhOQNQngdrpZaUemW0QPvO0zSG/QsOq01dRLaj6Ln34aYymAjt8bsXKGcCw?=
 =?us-ascii?Q?SIz6zIy/GMbTBNoT8vs+LsvDU4c67xaPp3488GyfnfeS43rFzpHVoMYv4pUY?=
 =?us-ascii?Q?rgiFAYV2w26KcdjVbiIBgMenSUZPe+VdlwflDmoqOahBq6dxhJgZV1+AB432?=
 =?us-ascii?Q?kkvfhUDf1cH7cKZeFnSsisFxPPRanUbY2XmlYhk2YUrKDwEfCY/BCrgMK322?=
 =?us-ascii?Q?efcDkblQ2ZQcEsfbbjESsHJh2Squemd6VTaVN9HrDt87nncxNOeXIgEnsQyv?=
 =?us-ascii?Q?9K/2p7WvUttMpOHpRUNCgGk6Ub/6Mn8NYGExarCo754P+71ZDzM2f4VDM/uq?=
 =?us-ascii?Q?Y/crsH34J1yAuQnQ4YRm65VyI/71qGOW5mWkipFQm2JCkF5uc31OU+H5K196?=
 =?us-ascii?Q?03y3JVhOBcHvel+Ahr6xKI85fgFk0+k7ncrvDz4TdnXF1eIC9olyfnyKQOdA?=
 =?us-ascii?Q?nCeYevrUqaBJBIkMjBL4At7Z3OU4Cf9Zs63Xf8gw3wNoCtVThaD27/i0g9ZN?=
 =?us-ascii?Q?dPU+8cajIH6ujIlkiha+FNObJOX5Y4i9Ajy0rwnTHfbWcK1sq+Cp/DQrIRUz?=
 =?us-ascii?Q?8rdimYkWnXt3+5DcMGgKnpvRbrJVi/Bfi67ft4HD1riksox2wT1wI/JKRe1H?=
 =?us-ascii?Q?n9yOVJDVNKkXbY8/gcnm6y+tP3j60LRR9F1cfh8bL1qds4SSdzSEo+75vF2A?=
 =?us-ascii?Q?gMOMeGLK2fhYX+H0c4iGAb07UbbJQ/S9VVmsW6XHVbErLVqYOHejrIEXLdk8?=
 =?us-ascii?Q?IIecH1DJ1FbDqCgn/peAw0rIfcZSiCgKhkvmy971LglTD2CF28aZ/9DN4kRf?=
 =?us-ascii?Q?/GzbOOsb60m3K+H5oNzTh9lv11PY8Us4W4/iadZkvinxWjOaGArlKIXKN1NE?=
 =?us-ascii?Q?X+lWdfBu7THOJK7kp+xbQ3ydIzqVXV8fDcahXPzr6e8UximYsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A6I5BTsKfhfp88Srwp1XnrM3f7GbjIs0bb5Ge5gLZhsPZeSWXZi8StbZh+Kj?=
 =?us-ascii?Q?t+SpmeZ1YD6cGj4D0fC7Rdah7ch8VVWnxLnSe27fdTIAg2Z8W/F9raxvLrZS?=
 =?us-ascii?Q?zqxGXIPpDLAmLj08O3r4pChvmAsZtb20DH2SY1SB4JW6/bFOhP5kR7AOmKZp?=
 =?us-ascii?Q?Q9E0CAet7PpVYrVnGvOTsRn9RyZitNaF9NPTU5KYxgaeOhLwBhQraGbPrJWM?=
 =?us-ascii?Q?jU/Mi6PV/5XBXkDyBDhYCuv5VGlWLqy5y+CvgSywZ69NM/Zvwxezk/nIDdMP?=
 =?us-ascii?Q?CLJTT37PTiKZxowvHTFOK9UmZ8TfeyB8eBH4dYDeYwUFwCQR6MIgn7ILOXmt?=
 =?us-ascii?Q?ymAGTYWxxfdxWkCWXE1Sxe+IdkC7yJi+FF0UH94kfZeomRi66BezUSbhcSI1?=
 =?us-ascii?Q?l9a/NXj8f1J09tFUr+I7CMDa+F+Q7wEnabE0bTNpL/W4PMfBwKbR8+HKdNCn?=
 =?us-ascii?Q?feasjZ7Gq/Y8mJ785psKPAa8O7pfjeY5F+/gxhvuqzsOnGMb1uet2gRrV5MW?=
 =?us-ascii?Q?eqmBiBsfUTWNycJT/OWgf96KLwTQvPj+ac7H33mLy0vqj3p7YCBWTE+0RP0k?=
 =?us-ascii?Q?bTXlvs7t0JVKEhKrd2EmESp3LRwoCzF5e9K6JFMyMk2co2MmPkqcGsj3qqcw?=
 =?us-ascii?Q?2uENCM202V3BUIbIZUgeH2zxir4lv4771tbxfUdixRoQRlGJO9jNCbG2pH5G?=
 =?us-ascii?Q?be3RVNAsLjPySQo/7n32uTYqg+HSonvIaVdnWzmsSn1x6HXcXNWGqOulUFU1?=
 =?us-ascii?Q?3jZH8LhCyAcBWeN6blpxoiR5oEqrP1buUhhbpaBHqzkDgEQCr3zuLJMEbi2a?=
 =?us-ascii?Q?G7zLZm2TpNWAWZeQ9RnK7vyshM741tEVidcQ2WO3RtWyTbJ0I98z1RK5qUl1?=
 =?us-ascii?Q?B8PZy8h1CGq3xuCFrunNBxbjwe3qtEquOxLFORjD0wB29QcXZ26NhS7C4IJD?=
 =?us-ascii?Q?y60Mq2nRBwb0XlD2HojjkMTXCT4PWD3xFr1Yotq9a3SI5gaSEYbAuKPQ5uLD?=
 =?us-ascii?Q?Ov/MoloY68izx3rdd8AwnbFmKIrtXN2boZtuQJtbVyLEzMozXFKVq51St47U?=
 =?us-ascii?Q?FWMiLMTZ7LE5gItHrYMe2JTp3lQOFAij+sQyTqsIeLlLNgVrv2tUgdIhCbdu?=
 =?us-ascii?Q?ZpTeefpOSjtHteQfAVY50WuP4z6g3t+A9nn6aZy/eUQNtaiEC7x9n76m+YsP?=
 =?us-ascii?Q?unYYe0Ixmx1xZ7WJLTy9USurji9UKrudfqqpOPJTn+QZKpVi8sJo1vboO2ew?=
 =?us-ascii?Q?DglckbIprrNCeFsA255Y5mWzjjA4escI/yjdrtRmvaD/0Go5NB7EUNLVabIK?=
 =?us-ascii?Q?mEX3NhluyeVclgtkhZCVqhsFg1sCd8gGuJ1wI9DRNAmZZXb/d3ux5CuE5ij9?=
 =?us-ascii?Q?Gnms6H2BgWEgMSmP7adVxq7tuRZ6fh8QJjjkUT8dGzg7oMiYGw1LJU0SVm5A?=
 =?us-ascii?Q?vXsvyFexs8/qx+xGS3gktRbEfSpL7ImytCYBSbGOw/hb30yLRIDPI55rd/Tr?=
 =?us-ascii?Q?b/Y86XJDbn0Hy5uqqun8sgqi8lJm2RrFVs691qdGoUpaKkbNabZvMJ8PrCa8?=
 =?us-ascii?Q?T5C6Q6MuWDGFttWv/TLA4p8wQ01x/DQCn2R95EowWWNLcd98LQ0Xph/3uka0?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9c0b54-4edb-456a-4194-08dd1038429f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 05:39:58.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqEA+qL2CAuJvNuCu0vqJLregV4FSky5jxxscMcjmdjlrCGL4o8/uJHqVUlUgPLJqfk1FTyQf6DQbuaWwV8gDkHk3qXgnmif9D5Z4honbh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
X-Proofpoint-ORIG-GUID: RCFNoH_4BDyR-QTE6AnGExht_PS590XZ
X-Proofpoint-GUID: RCFNoH_4BDyR-QTE6AnGExht_PS590XZ
X-Authority-Analysis: v=2.4 cv=Z/8WHGRA c=1 sm=1 tr=0 ts=674953b1 cx=c_pps a=mEL9+5ifO1KfKUNINL6WGg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=t7CeM3EgAAAA:8 a=tS_AkcZMlHfw2UmO7cEA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_03,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2411290043

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 8e65a1b7118acf6af96449e1e66b7adbc9396912 ]

[Why & How]
Check return pointer of kzalloc before using it.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Resolve minor conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 8 ++++++++
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c     | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c     | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c   | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c     | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c   | 2 ++
 9 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 3271c8c7905d..4e036356b6a8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -560,11 +560,19 @@ void dcn3_clk_mgr_construct(
 	dce_clock_read_ss_info(clk_mgr);
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn3_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 2428a4763b85..1c5ae4d62e37 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -1022,11 +1022,19 @@ void dcn32_clk_mgr_construct(
 	clk_mgr->smu_present = false;
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+	if (!clk_mgr->base.bw_params) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 
 	/* need physical address of table to give to PMFW */
 	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
 			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
 			&clk_mgr->wm_range_table_addr);
+	if (!clk_mgr->wm_range_table) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
 }
 
 void dcn32_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 88c0b24a3249..de83acd12250 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2045,6 +2045,9 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 82de4fe2637f..84e3df49be2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1308,6 +1308,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1764,6 +1766,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 3e65e683db0a..6e52851bc031 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1381,6 +1381,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
@@ -1741,6 +1743,9 @@ bool dcn314_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	if (filter_modes_for_single_channel_workaround(dc, context))
 		goto validate_fail;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 127487ea3d7d..3f3b555b4523 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1308,6 +1308,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 5fe2c61527df..37b7973fc949 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1305,6 +1305,8 @@ static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
 					&hpo_dp_link_enc_regs[inst],
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index f9d601c8c721..4d4ff13a2af8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1299,6 +1299,8 @@ static struct hpo_dp_link_encoder *dcn32_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
@@ -1842,6 +1844,9 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
+	if (!pipes)
+		goto validate_fail;
+
 	DC_FP_START();
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
 	DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index aa4c64eec7b3..4289cd1643ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1285,6 +1285,8 @@ static struct hpo_dp_link_encoder *dcn321_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
-- 
2.34.1


