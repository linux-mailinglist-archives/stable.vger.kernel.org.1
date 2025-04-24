Return-Path: <stable+bounces-136564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983FA9AB7F
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14C616C198
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2378E1F152C;
	Thu, 24 Apr 2025 11:15:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE2433A8
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493322; cv=fail; b=WwPhJcrZIKK+XQH8JMmKVROb7OEesTVug/9GXJGtfL/Zv5YJmfgVOWd/DIXjWWIHwgODkWvJ7qtw2QuyF/q0EyhQsDZyxjEXRxxo9hCpqrVrNIHzvr4M2c7NfZKSAND18yCwhgvvR386d13TNp1MOufKxIJi7myXtfL2fwDA5Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493322; c=relaxed/simple;
	bh=T25wczaBzBK3Nm7eR6ThWnefjroyvC2X5eFerQ0rTX0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q3ckomSCqSu47qBgJQ540WOTrOqO39VHm4biHa0aFAYxsRPIUq7grFhfEEGSaS5PCF+HIQxsNvnoNCoh3SQrY9MHGGvyjZhXPco1iUt2EZMdSymwXPjY1ES30DMHlOd8Ws38Z5RkqdaH7+dL37VG4YinFS76rrBO5Ma2TEgUCTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7vnbv014623;
	Thu, 24 Apr 2025 04:15:17 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhat5sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 04:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxnhAj47u51bNs5lDNUoNOeMYovY2zh/7o8vwg1nrVV1BRGPNZt2CkSMkAcypU3zkdw2jm5lUW8fyrpiYlrn7Wo8Vl+BTOUeQKCZfcrbrzo2IX3lf3uEA8bCVeIdXAtKkgb+YkZHkEhjQWMRtMrkspAauLDKLbuDKU9oUosduOCxKti+C5L2XHhhQ0smjNyceq3WHMtbUShe40zIyzwFFs2onwQV/fpzz+Zd0+gK/qRIkP02B/zPEVk6IH9/HeIYDQ6RG6sU/K6ASKPJm9ycQ5J8d7goMlaCeHrlZR2Qkze71cmCzHct8efVgMTKMcbt5ds2UoHyIYen4yCFKBokDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utTRu2zBCuZj3VAsEDTSxmXtGlAGU40nuSu1qH+q/EA=;
 b=ev43KGyqMie0OSrQWw9B0fbJ+G3mCXHQ6ZCLcCyIsfTb9I5XHM5gXdlmBD17bpOCEQJ0mfVqfbO1sMUyC1+AvZLL6ebnILSK16RSid5BMN+9LpDidWMCyWQunRWS59tOvG7YqncxcS8tdCl8qW3VwQnIz7erxOH3c5pOQqz6alm3t23HYVv4YCq3hf3EP0wGfOF+vJzt/jWlusWgy5EBWFfxyTA74to/gtA7xkWgh0+3hEbVScWfntLBLpuDfp+EvPhKLUxs22uBd5J6B4ne2CBXPAcLLOArL8jr166Y2meE5TM4m7V/VkoyOeZVJdTjFEYGvl/L2XdXKp2p+LBUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 11:15:12 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 11:15:12 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: tim.huang@amd.com, rodrigo.siqueira@amd.com, roman.li@amd.com,
        daniel.wheeler@amd.com, alexander.deucher@amd.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.15.y] drm/amd/display: fix double free issue during amdgpu module unload
Date: Thu, 24 Apr 2025 19:15:02 +0800
Message-Id: <20250424111502.991982-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0233.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::19) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CO1PR11MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: 009cf4c7-3d1a-4016-7aec-08dd83214817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wp0nuUkZ3Q+sIxXsLGOxQpu2Jn4/f20bdOkOIwTcwfeeMc8/Bq8jDQBxd765?=
 =?us-ascii?Q?NdoEwUFXJf0uy9ZexEvZDfttXSh7NjatNTKxknC7zGdIjAZ0KhxC0ahgI1aL?=
 =?us-ascii?Q?6rxdJAavyuJIh1xptbnWHEs1QdkGloal3TK+4NGQoD+CG8FZg93E8vC5Cg0E?=
 =?us-ascii?Q?so3A36uT1TmW0TqKIAQZf3NasqHdE5eJLpYwWnlviy788+rRgLoyQebVu8fT?=
 =?us-ascii?Q?trxkVDNm0Rk5A7juY0A53erH23h59y5BW9KVALDauGSD9QH3tiCE4BF4Fyzc?=
 =?us-ascii?Q?NuxPK0fhrHBs+/P9NENEsT/k8YmieZA4g0bdHs77Zh7WucpmI2bZhaCU5eVU?=
 =?us-ascii?Q?FyPdws/Nrv+N8fOfhKojP1jb/371wkX2Tmthmj+SMwBJ64S//kEK5V4ogU5K?=
 =?us-ascii?Q?RLJ3b/7+BSz0kzsrsEwEwSE3XCqMDmWIMMyNCOEEMjGFGer7PMcIx1yK5CC5?=
 =?us-ascii?Q?etcflpYt/jrGsuSWGpT8ed9mzxefUvNo3QjT2zONSjx0EXCnGWA5IpJZ5VXd?=
 =?us-ascii?Q?6XhV0KCvScGPNycaz6I6hNUmAOdrV7F+K09fx2Guf0jH11HL/lj97CsB1BRv?=
 =?us-ascii?Q?tbYpc3/p8qIamJeEwJ6Oi5oRgkmeDArpUNjBbQawmKTMc9ZVouvasKJ35W9Y?=
 =?us-ascii?Q?qJ8ekQf9KFRPJkV03OBs90rVePXH8T0GnIE1PbKEM2W70lbbtK5zT0sSLHsQ?=
 =?us-ascii?Q?JxDz+JywTWq2eboCd8pzaXsMR73fGMJI8by6+VQfF+K0W7paRTe1ng9k9Yx+?=
 =?us-ascii?Q?xu6OD/ZBknbZ5W3lXeEs6x3W9KKdTP6V3chs73NkcmtkEaW6UKzqj8IfcAIG?=
 =?us-ascii?Q?HanYh7/XDolnaymr6d2XxmdbMg1FDpySPyEiQovNMz7EGn5udz8JqdRNe4uS?=
 =?us-ascii?Q?qzry/v0O6TA1nOhGhB0VwMGmeb/0tnIi6VAU5eItpOVTsm5wDDJrBniIxRhm?=
 =?us-ascii?Q?gTjVFoRailSqrbAxLaBZhkAs5+P63bsUxhQR2i/1xsiY3Nsvp5GKtvoywSNJ?=
 =?us-ascii?Q?kCW5fHmfK8V37xatVJ2PgZNU7xAGzTM9PGZFCeSwziKFPA15gNCL5OxjAaHJ?=
 =?us-ascii?Q?OERvB2LPPCPaTte6j2UjtDTqlPeaHHyByb79mLduBncZP6mdeR1w1zaEMGOE?=
 =?us-ascii?Q?NJyMYcGvZ5lVZD97Gferjh6153FWqM8HgFWnxxWQG7zh75yX13zIMrKnzlI3?=
 =?us-ascii?Q?jdcBsL/ZP8OvjzNTMWu0ScpIQhXGOkh7dpKR6BrGL1lGPU9K9S3lI3PJAsmq?=
 =?us-ascii?Q?LQdXlWn4YyojlRLNLMk3Lh7YiM4Xtpg8Py9fE705mNmGhpHxcUAGj1iXR0b6?=
 =?us-ascii?Q?eQYiEtpVb83IvA9hr1rP1pctevA0Q0OcUfGRL1MQDwiH8rQp1xq0ZGjhdkIQ?=
 =?us-ascii?Q?VLYhbueLcqHh3eptxxwd/1oHsWfDG8Fkrsigr0WvspSO8KVslbVwohZXUyTD?=
 =?us-ascii?Q?NdqEV7xsCvNUvBr9W27McUqiHuxDc3FzJX1I5jHXg2OMTokp3wZX3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UprDD4ruxu3+o2pKB5hXgcZsyVJQeg1WzAZYLKHgBe8W+r8RJLwHdgYsMt1B?=
 =?us-ascii?Q?GyX5NEGrW4jiB0AMEBfb13e0DkSk1uBbGQ6f5Pv4nlwGGnd5QHcLTdgKCg3b?=
 =?us-ascii?Q?q5rXvkRJY2s1vSJH0MYmP1h85Tojuap7TYUiMYlcbOAml2EvVsD1S5gORnDt?=
 =?us-ascii?Q?V9yq6QXrW6Qcd4nDJKEn34d5eBDl5Tc2KA0MvZCZCQMHq1Ym2TtrCOn2j5eI?=
 =?us-ascii?Q?WshgSigwDThQBx2/zPEzF5lFxtIyG+pDsXbLx8SZbOrYf9ITwMvBUj3ie2rG?=
 =?us-ascii?Q?EFeythPgiP6G2r8Gd6Pdz7spF13HUHRKwtC5djiekPY/03ZIDJSwoeiYPQRj?=
 =?us-ascii?Q?woFI+vTMqW8cvqVOehEwfWBBQPL/l3Mfj57+pDMQLXj9xAYC9C304KCbzqwp?=
 =?us-ascii?Q?4gGDgRfnZzwimX/LGW5GTzrMQt5WKeCcMOB7VIj2L4jzAtw6wM93hur5Ickb?=
 =?us-ascii?Q?lTkfMcw6KlButHPWvC0iiTgaHjUGLwSb0Gi8b10NLR5/BQLPlmVWWoqJ68Qv?=
 =?us-ascii?Q?HB3u40aC5+P5oXQ3gsLQp3/Iu8x3lAC/OpYWVmedxg/ZGBt7T79YJ0yYDxm4?=
 =?us-ascii?Q?Zc7H25ques0n9FVFGIfdV7yMCPZ1JygO7rVzu6paDR1KnHveZNKo57jhbNo+?=
 =?us-ascii?Q?dEhzb0yU60SZCdSzZPttmdw5gu30ye+7AxqzHgYW0fo2mfWQW5Wk0ruyIHBW?=
 =?us-ascii?Q?fuTCTclYK8goaNRG3jqN4LgCFY6WIDIQDEh3S8WKDqOqlZtfaFlltDgbe/lp?=
 =?us-ascii?Q?q2Ff9GtZaZhZxHoJnDC+l9Z6djGhiMHocWtpvHZG4BysB/e+MZ1hMrkp4STG?=
 =?us-ascii?Q?s4fW1pyNO5FMkhJF6BOmG+cPM7m1Kx+gk+HU/7TphrJcFcvosuPi5tBgOs3P?=
 =?us-ascii?Q?wuebfhO+7kADCbimK6FIC7+ttcEtT9W6mIHeHauXZt927UmlZir4Zqy/VoOC?=
 =?us-ascii?Q?R6Um0rFDY+OrOjJhSPC38K5HE9BYpM1lq5b4qV5CLohq6eaDiqdXkTxukLNm?=
 =?us-ascii?Q?8n/QnRzjgcBE4jRN1VOtZik9Nm9D7oTitRCZmsX3OX8BXGJx+z8hyKPSvD51?=
 =?us-ascii?Q?YMl49oFBTS+hjGpXy0rY6zouoS2+icqJ8ywhC6yHFZD2O8vxmnocmt8lP8GY?=
 =?us-ascii?Q?7F73BmIE/IhH22nvDj92pQO2pPnro2imCaTNnArYfrRTBv2b6WPJiCRJT3a8?=
 =?us-ascii?Q?Akccrt+DUbgOkPM4o6YJmWaCNJfbX33x4NbBDoUHDuwMbODysUHh720jImah?=
 =?us-ascii?Q?cNO/5ruaIihfJAnTK6fVWrpkb8IsQDdn3eLHVOIPzirZ9tMZaBwUhiCV/M+N?=
 =?us-ascii?Q?mPvkeqQM73LrFpY3K9L4SPE0a/PdWlnx60hXKFCv4Q/NWwRXIFklcI2wPOTZ?=
 =?us-ascii?Q?AtDtlQnpMqsP9z3wRLbLwmZQOFAUnemBjIpFvddupRvZvpPtHOaS0jX/qmTN?=
 =?us-ascii?Q?snRByN+J+O76xREFdlguIzaynf3+XwZbgTiN0VRE5NSIGKRaTfIAbMNtv4oS?=
 =?us-ascii?Q?hhy1czxI+bNPZkrt1lG+Y7+EkEldZ25QbvtOs0hhByRbwfN86wmKFQa+dhzH?=
 =?us-ascii?Q?HP8DMueyDgnr5FsKDMcFpjR4HD1pe7eoFz7VFM3MHT5X4H3RIB8RIihZ4SUN?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009cf4c7-3d1a-4016-7aec-08dd83214817
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:15:12.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zA2PA5sk9k0hdO4/B3ybkcuC7NvglRiYeka3HBVwsKQhawtxdG1w6Vp3STG4x1d+tqhwRIntq6anZ/lqjbkEMBfHwk3atJsiQ2wC2v6rOo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-Proofpoint-GUID: ZWUuo723MvAXFY0_PjwfobC0h3809YWt
X-Proofpoint-ORIG-GUID: ZWUuo723MvAXFY0_PjwfobC0h3809YWt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3NSBTYWx0ZWRfXxjO/PHAV+ZS9 3mCcRIZmPK0WcZ43j+3Mul6brKVnbeR90D4NDJbgKJQB6N5wCZnTH0gfFNGuxlw/UR1wbM6lZ0H BZDLG/4RwYt6nqx2eh02+Q1MUB42cPmlfkSEcEWKY6Z4TsiSemS3qZQCrRdjmwmV6s5zZa8yBN/
 lKd+VN1C6PQRQ+zhCcuz9LpvlcDvD+8kz+wkqSzYjbZjbPcOrlzHfEQhT5saLdtRbxO5UHmCohB AFW2WP2sSXKvSHix72luKRjW+7xNb3b1cozgwgvv3VA01q1vLHXbBK/RbWGapFdJrMlCS/phLQE v0xIVFa4wGDgDL94hhIJ+vLz6Uh5Jd2q/Cba+GirUoXDnMWsb8O0Iz0WmTbwcHPBroaC/PtYqiM
 +8huLeUkpEbPSdnAvukmjrQnfxJuJU2MM3U3TM+nRPaQFBP5qu+pu8wVVhxGcutr/FNTZ3FX
X-Authority-Analysis: v=2.4 cv=Sa33duRu c=1 sm=1 tr=0 ts=680a1d44 cx=c_pps a=p6j+uggflNHdUAyuNTtjyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=zd2uoN0lAAAA:8 a=t7CeM3EgAAAA:8 a=JxPi-bCyOoQ5dT1i81YA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504240075

From: Tim Huang <tim.huang@amd.com>

[ Upstream commit 20b5a8f9f4670a8503aa9fa95ca632e77c6bf55d ]

Flexible endpoints use DIGs from available inflexible endpoints,
so only the encoders of inflexible links need to be freed.
Otherwise, a double free issue may occur when unloading the
amdgpu module.

[  279.190523] RIP: 0010:__slab_free+0x152/0x2f0
[  279.190577] Call Trace:
[  279.190580]  <TASK>
[  279.190582]  ? show_regs+0x69/0x80
[  279.190590]  ? die+0x3b/0x90
[  279.190595]  ? do_trap+0xc8/0xe0
[  279.190601]  ? do_error_trap+0x73/0xa0
[  279.190605]  ? __slab_free+0x152/0x2f0
[  279.190609]  ? exc_invalid_op+0x56/0x70
[  279.190616]  ? __slab_free+0x152/0x2f0
[  279.190642]  ? asm_exc_invalid_op+0x1f/0x30
[  279.190648]  ? dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191096]  ? __slab_free+0x152/0x2f0
[  279.191102]  ? dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191469]  kfree+0x260/0x2b0
[  279.191474]  dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191821]  link_destroy+0xd7/0x130 [amdgpu]
[  279.192248]  dc_destruct+0x90/0x270 [amdgpu]
[  279.192666]  dc_destroy+0x19/0x40 [amdgpu]
[  279.193020]  amdgpu_dm_fini+0x16e/0x200 [amdgpu]
[  279.193432]  dm_hw_fini+0x26/0x40 [amdgpu]
[  279.193795]  amdgpu_device_fini_hw+0x24c/0x400 [amdgpu]
[  279.194108]  amdgpu_driver_unload_kms+0x4f/0x70 [amdgpu]
[  279.194436]  amdgpu_pci_remove+0x40/0x80 [amdgpu]
[  279.194632]  pci_device_remove+0x3a/0xa0
[  279.194638]  device_remove+0x40/0x70
[  279.194642]  device_release_driver_internal+0x1ad/0x210
[  279.194647]  driver_detach+0x4e/0xa0
[  279.194650]  bus_remove_driver+0x6f/0xf0
[  279.194653]  driver_unregister+0x33/0x60
[  279.194657]  pci_unregister_driver+0x44/0x90
[  279.194662]  amdgpu_exit+0x19/0x1f0 [amdgpu]
[  279.194939]  __do_sys_delete_module.isra.0+0x198/0x2f0
[  279.194946]  __x64_sys_delete_module+0x16/0x20
[  279.194950]  do_syscall_64+0x58/0x120
[  279.194954]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  279.194980]  </TASK>

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ dc_link_destruct() moved from core/dc_link.c to link/link_factory.c since
commit: 54618888d1ea ("drm/amd/display: break down dc_link.c"), so modified
the path to apply on 5.15.y ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified on the build test
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b727bd7e039d..6696372b82f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -79,7 +79,7 @@ static void dc_link_destruct(struct dc_link *link)
 	if (link->panel_cntl)
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
-	if (link->link_enc) {
+	if (link->link_enc && !link->is_dig_mapping_flexible) {
 		/* Update link encoder resource tracking variables. These are used for
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
-- 
2.34.1


