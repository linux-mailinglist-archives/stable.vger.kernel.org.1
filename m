Return-Path: <stable+bounces-100823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834849EDDCB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 04:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8D018851F8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E57E765;
	Thu, 12 Dec 2024 03:00:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB67DA6D
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733972410; cv=fail; b=LLyKJKEcxSyPpi8g/+Llmgi95n6i2DOfAteO5u05A4J2Rmty3PLqtvCL1aiKX1AaTrGD0aQ40Y2DuIpltxAj7+mqYUUyu+nXdEc/lUsgAsCQ6lR3rPiUSthpdQXw0dnh8iH6cA9cR8gCrKV847gM1UDAACOK0gnr0llra1frGRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733972410; c=relaxed/simple;
	bh=SXtcBsqX+8qkX+Xkxj+7eqDCiMfGU6oGM5jxfLIfwx4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QVhHV/SAyE1/YjHpYnc3xcWP/TSVHKH9H1MJZi4dx7UDNZVfl6jysOdb7H2KR2PnTfLROjGf5dC6npV37qCjpB6fjpBGJVDiHAARkAgcfS03krjIDfPRIAiAWIUVnPHHLQz+iEDSw0EO4/ObmN/qsqy7+ZtPFqqq80Rdy8teJCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC2jKaj021534;
	Thu, 12 Dec 2024 02:59:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xd128-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 02:59:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le/dHyEn6n8b8P85nGPgl/v5Py7TG2k25yol45ip9EYFv/z0Wn4A8pP4DSdDPs0zz6pGRHUHMN1pGfvHQ2IPb8CiLBxR7t+sEtyOy2+vjW1i7tPoFdLOeQfFdlqKEwfEt/NVRTYtEvRjqRVbaT6wYWktm7/X1E3lUOw1UUojQQ4yyAgIUgkvorA8we6+LA61OSAiuJcoPB3ymCEnWBfIXpH70mcd52G0e/rISRpiRcssLv8ufo/lx1ReCgz1crM2T+UixJ0NLnUG1tEQ1HbOIE9tjEFk8N2gosvRFGu2y7blAMbu5r7z9ydzad7ESbIURtAnpmp/ZIazm9EH/cbgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc6VtzEIidUOQxUElztDOFkaKs/RpUUzlObvsiSNlbo=;
 b=WriIbkCQkFJctL8K6+o8aHBaoOBj5zYum4BqzTyNb9QoU8ZTF3skdm6ro4hHhDC4+2E/5fApZr9vjcSfy+Z2QuOo69vC955PKt+L6nEfpycmOtVM5u38maPTjNeH+0P7I8xqvJPhaKWoADm0Z3hZzWucHEQbM+giaN3uvSq0UF8QTnqcYAIvrzquffEmQJvBieJAZBUNuMxIVEvFHwK7AZxLRAG6j2ewiF7XXhOBRiqRe6+6QH6HdzlB89jiT9r5KFbA/22n14mMq6cBWBo0u0gn26cqSsZ2UccyCAOy6xUvtH3QNIwQT0OSgFYdW02pBZNQBupB2gMIRogPd5WKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA3PR11MB7656.namprd11.prod.outlook.com (2603:10b6:806:320::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 02:59:43 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 02:59:43 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, daniel@iogearbox.net
Cc: andrii@kernel.org, shung-hsi.yu@suse.com
Subject: [PATCH 6.1] bpf: Fix helper writes to read-only maps
Date: Thu, 12 Dec 2024 10:59:50 +0800
Message-ID: <20241212025950.2920009-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA3PR11MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ded2b4-b651-4e5f-c83c-08dd1a590743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hDR+dthdrTBqDRWua8pr5e19/mP0zuPGAHj4MNCjI2bYWvunhgarFqRCHCnC?=
 =?us-ascii?Q?o1dLoBcojQxE29cQt2L3oIxgjuDX5C8BOKJ6kQ6IyuowMafv367guX5Pxnc4?=
 =?us-ascii?Q?wu7B6qtktPJDBcz90ILHoLw7vl9aLXZmxXiIRrHPnAmjsnIj3wxN2egx3Ogb?=
 =?us-ascii?Q?aKEcoe/d8mTCnOJrfT/xQhYU4C3rbArtNTZplWyakXbcvgo9rFpkep9RLisD?=
 =?us-ascii?Q?GG4zHT58jeBjtEKJ1BaKALUYO1IoDR9ozdKZYiO7TUZXF+Zu1Qrtn3JO/Q3f?=
 =?us-ascii?Q?OXdDsegvNK6YfdAwLBn1d/29SQ5OXEe8MdArU1dXZwkhmOX1Y27vTIVoLse/?=
 =?us-ascii?Q?TMLD8eRBZdpqGVhqq9jS4wZMWT0rVncZX614VhIquYkM/3ZFw03mWeoGTSBc?=
 =?us-ascii?Q?gOKunJJRlEwiCvtpP8y5Xts03ol4g7evW7DXtY0FUP7+P1aikxtOsfYdI1ta?=
 =?us-ascii?Q?3jtqbBCJp1fUGtHIfhTAyHSPv7nn/aQJxH7VNVvLqOFfLF0CJWKHG37RXumK?=
 =?us-ascii?Q?2fYZEf2HHoSTh3KzbxASoE6AaBIz+gVEuJKyb3gKYDCyXlqXLQE+6YVhq4Ax?=
 =?us-ascii?Q?UNzlhKJg8Z+dwUPKjnecqB4jvQdZD0fDOZJ/gYfwDytkFm+NZ4U7BMjxoDRy?=
 =?us-ascii?Q?qK469a6QblWCKTi36WJ0f9dMyStigT3jUqWNg6qf+42/Z4qzai1OMM19Wt+z?=
 =?us-ascii?Q?cXXgtksnLPhGF4dHDtuT6qQKknWzmGIj5CUPft0poypPoNZXbDSzitNPXFpx?=
 =?us-ascii?Q?Pudw9mnHwBJx2ZtA9LyNSZv2SUvZ49WP8tNfrdCYGsUDZ8SHBPFEzepTlTnG?=
 =?us-ascii?Q?QWRhYA0TBAOJagRTlPUXkVM7smntV4HF7Bcq0tbdqQKR/HJcuBHhuxuJgxre?=
 =?us-ascii?Q?AyELxCbc0SSs/HGrKqudyXBRa07CK3DBh7NrLCNC0lydK7bpkw5ZIWvCaivs?=
 =?us-ascii?Q?503n8N60cluashWNbbWzg75dGyjgPsPdteq+5VkkDbePTRNk3t8xuKI+Vxxj?=
 =?us-ascii?Q?UOtvElJ5SpXXPr45ZX0mqWwHLRfC8HyxWPTkLpwLGCgUnk0F9VMZMCf1ahdl?=
 =?us-ascii?Q?wtb2bnUoRSxnuP1DfTmHV5v/b4c68cMvutjsxJQgm+oRxo3i+ZE7THnrHF0c?=
 =?us-ascii?Q?WBNojfzXAylFevRvIcvpjkgJb5yLGBwX7xVWEHcbwLPWk0VS5e5Wd2jZOPCp?=
 =?us-ascii?Q?32W+LeWSiAzYcYnWsGXXlHR/yWUlvOZwK/hmwH3yvsyRl+V9BsxQauzdmrkt?=
 =?us-ascii?Q?VGtEUmaEWqYq10QQdmuV26Ohj3qcLFJPiB5tEuG2Sx8rgCA/QObDWIaKBHqm?=
 =?us-ascii?Q?c89ZEW9o2XrteJUtmcA+MxCv1gw1cdvCREjBmptJom3kYxuPwdqo9vpoYBjz?=
 =?us-ascii?Q?4XEqJUH5HkZVi9jaz6mrU5RuBSI8jxuf/dengg3EwGCJWr2cgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?czRoqFIoM46CPYeiRfX3fQy9kiab+sXPGdmkzKJ1jTY2cFVaVSgWIy32HHyi?=
 =?us-ascii?Q?mgYBcSCVG6RufgmlDgPj3EHcOiZBF0+SHdeMbmTZmD2h2w6iTYQekfw9whbG?=
 =?us-ascii?Q?CzZ73yS4BAsF6aG9fdKIf3M/DGt6rav6lHlZW0xoUPheE0nQnfHH3QdICvVm?=
 =?us-ascii?Q?cDgOqpwhJLInHNURKkcYUeSEgjU9A3a1++u5siY+E9vtiHLns3WCOogLsJ9A?=
 =?us-ascii?Q?iy5thMD+2Hqx0ZDbRjPBPQ6aPvyH43hK/jxadZmaivCUAvP2jY845mWeAuHV?=
 =?us-ascii?Q?s/edwlNFPuKt/jcc9yo9eVOw7iRSURav67LgtivNc5L5aWZkWN4+rDV9Ul0y?=
 =?us-ascii?Q?MzjVLltGo0La2N4gSAdrKQOby1hbg+l4c3RdkpqAf2etVFbRtenQBRwhW4Yg?=
 =?us-ascii?Q?9LVILwfyYZulW+uhlRxFrqXT9P797LvZr/UYglrHXA543a/1Ay8DTQ+xRHKl?=
 =?us-ascii?Q?ija6JmmvXXW/S9vUrZpbY8TgLEyN3g9MgWPO2ykoUC7WW0CFd67bJ3S5A6v2?=
 =?us-ascii?Q?lC0R3PTBfXYKVVBqmL13S6JNas8f+Nf3mxG3C5uLTg2neRB8Y/0hXOSMGzA4?=
 =?us-ascii?Q?yZucDWew7v28h+up/3cLk1wJcltTp4o7JEhEWUAz2uzCP23omQWnCEn9ntV7?=
 =?us-ascii?Q?JBfwohgBeBnbqw6xU0LfLcI791SxC4bqJ+E0EU+oHqOAViz6XFY+161uoqNL?=
 =?us-ascii?Q?xEllguFdOzHo9MmjHTkTr/Q93ByFt5hmfy1OAYxtKD64aSb45ek1UeCVA5rR?=
 =?us-ascii?Q?YmGyE6UWs+S/K9CGK+C3iYuS+4cmnGXR6OfO0uEQ1PD+s5DBhRvTx5j/Jbw0?=
 =?us-ascii?Q?BzCPvFDM/gsBD7f/DnQ7eG/L44ejb9yB3eO5BbfzG2MQBnox4u09geZJfkvI?=
 =?us-ascii?Q?0aaAjC9fSk7LvKqKYHW5VEGdTLT0xCCGYhVblvPStoWRy2N2CmJedYRpYZUV?=
 =?us-ascii?Q?tZv5YqTxgPvpPwHEFPrxrNLUIn1Go3Qz437Rc3TW/RSfNDw/RL0ONzTILHtU?=
 =?us-ascii?Q?45zWk2xKlobg30zJyra7+XnjRWjgSyrZGJc2LFN8WGlR6x651ebJ9NvnxKTK?=
 =?us-ascii?Q?ofZXqqsJqZsTYgdevXNTSdOtVy1ekb0Zvxca/M/Faeq2QXDWnMLM2tYU7IT3?=
 =?us-ascii?Q?YDKlsY6dGt3fXgXQmDEAH5WtNPaQi4B1Jz6yFObu35282g1ZyLkU6dzWSbP6?=
 =?us-ascii?Q?VYlKxwSFaKfaM20SJHN+vmkOoHXZw/WiPk0G9nkQg+h9+WEopqvde7jaCkM1?=
 =?us-ascii?Q?CgWaTrAGS86qohwrNAP3PlzBdty8w3BxDwA/OkqVPv1MkIxirTl9BkEDjJy2?=
 =?us-ascii?Q?rMt7ZfiR7/tfUEmvrHtzFzfGNNszv5xyq0nVxeLLBDorD9hiG8LPemKB4emL?=
 =?us-ascii?Q?uNG6lvj+j7VQ6kSyYgP1kPH7QMkOVZmJrG7nm6qFmgtPvLBxnrnkatW0yp94?=
 =?us-ascii?Q?LLmDxoSvUq/fwFLg86QVzGFTR/aTGv6u45rAR+azhPSoofV/+G9BLEYZgZlk?=
 =?us-ascii?Q?CfJNTT2A0Giy0zxzfj6FVA8KYmqnXwO1fEvMzuZSEtpS1rRChi+ksjVwIAL/?=
 =?us-ascii?Q?0VBU3nGS/RDiOFSThm09oIfgj3xgYTPX7JMdLcBrB3+TjW+2JuICWIDnsMv+?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ded2b4-b651-4e5f-c83c-08dd1a590743
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 02:59:43.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoPTJoZheUljQpURAexlZVEYw2gMs3LOXdL/OEBunM8kje8UdZ4GlTNlQnzn1BVXSP/EUHVmpkPd2eflDIsGGILqv4mSsVqVM4kBga5GkhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7656
X-Proofpoint-GUID: Za1zZbQT_YJ7Yj28B8oY-_19FUA3riQF
X-Proofpoint-ORIG-GUID: Za1zZbQT_YJ7Yj28B8oY-_19FUA3riQF
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=675a51a4 cx=c_pps a=O5U4z+bWMBJw47+h9fOlNw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=hWMQpYRtAAAA:8 a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=DepBThhoQWDgoPJ_W-kA:9 a=KCsI-UfzjElwHeZNREa_:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_13,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412120021

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 32556ce93bc45c730829083cb60f95a2728ea48b ]

Lonial found an issue that despite user- and BPF-side frozen BPF map
(like in case of .rodata), it was still possible to write into it from
a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT}
as arguments.

In check_func_arg() when the argument is as mentioned, the meta->raw_mode
is never set. Later, check_helper_mem_access(), under the case of
PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
subsequent call to check_map_access_type() and given the BPF map is
read-only it succeeds.

The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM_UNINIT
when results are written into them as opposed to read out of them. The
latter indicates that it's okay to pass a pointer to uninitialized memory
as the memory is written to anyway.

However, ARG_PTR_TO_{LONG,INT} is a special case of ARG_PTR_TO_FIXED_SIZE_MEM
just with additional alignment requirement. So it is better to just get
rid of the ARG_PTR_TO_{LONG,INT} special cases altogether and reuse the
fixed size memory types. For this, add MEM_ALIGNED to additionally ensure
alignment given these helpers write directly into the args via *<ptr> = val.
The .arg*_size has been initialized reflecting the actual sizeof(*<ptr>).

MEM_ALIGNED can only be used in combination with MEM_FIXED_SIZE annotated
argument types, since in !MEM_FIXED_SIZE cases the verifier does not know
the buffer size a priori and therefore cannot blindly write *<ptr> = val.

Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20240913191754.13290-3-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Resolve merge conflict in include/linux/bpf.h and merge conflict in
  kernel/bpf/verifier.c.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 include/linux/bpf.h      |  7 +++++--
 kernel/bpf/helpers.c     |  6 ++++--
 kernel/bpf/syscall.c     |  3 ++-
 kernel/bpf/verifier.c    | 41 +++++-----------------------------------
 kernel/trace/bpf_trace.c |  6 ++++--
 net/core/filter.c        |  6 ++++--
 6 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6b18b8da025f..7f4ce183dcb0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -475,6 +475,11 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* Memory must be aligned on some architectures, used in combination with
+	 * MEM_FIXED_SIZE.
+	 */
+	MEM_ALIGNED		= BIT(17 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -510,8 +515,6 @@ enum bpf_arg_type {
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
-	ARG_PTR_TO_INT,		/* pointer to int */
-	ARG_PTR_TO_LONG,	/* pointer to long */
 	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
 	ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
 	ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a3fc4e2e8256..14ad6856257c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -531,7 +531,8 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(s64),
 };
 
 BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
@@ -560,7 +561,8 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(u64),
 };
 
 BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 42f5b37a74c6..f9906e5ad2e5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5260,7 +5260,8 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(u64),
 };
 
 static const struct bpf_func_proto *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index da90f565317d..b68572c41e96 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5818,16 +5818,6 @@ static bool arg_type_is_dynptr(enum bpf_arg_type type)
 	return base_type(type) == ARG_PTR_TO_DYNPTR;
 }
 
-static int int_ptr_type_to_size(enum bpf_arg_type type)
-{
-	if (type == ARG_PTR_TO_INT)
-		return sizeof(u32);
-	else if (type == ARG_PTR_TO_LONG)
-		return sizeof(u64);
-
-	return -EINVAL;
-}
-
 static int resolve_map_arg_type(struct bpf_verifier_env *env,
 				 const struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type)
@@ -5908,16 +5898,6 @@ static const struct bpf_reg_types mem_types = {
 	},
 };
 
-static const struct bpf_reg_types int_ptr_types = {
-	.types = {
-		PTR_TO_STACK,
-		PTR_TO_PACKET,
-		PTR_TO_PACKET_META,
-		PTR_TO_MAP_KEY,
-		PTR_TO_MAP_VALUE,
-	},
-};
-
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
@@ -5955,8 +5935,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
-	[ARG_PTR_TO_INT]		= &int_ptr_types,
-	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
 	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
@@ -6303,9 +6281,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, regno,
-						      fn->arg_size[arg], false,
-						      meta);
+			err = check_helper_mem_access(env, regno, fn->arg_size[arg], false, meta);
+			if (err)
+				return err;
+			if (arg_type & MEM_ALIGNED)
+				err = check_ptr_alignment(env, reg, 0, fn->arg_size[arg], true);
 		}
 		break;
 	case ARG_CONST_SIZE:
@@ -6373,17 +6353,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (err)
 			return err;
 		break;
-	case ARG_PTR_TO_INT:
-	case ARG_PTR_TO_LONG:
-	{
-		int size = int_ptr_type_to_size(arg_type);
-
-		err = check_helper_mem_access(env, regno, size, false, meta);
-		if (err)
-			return err;
-		err = check_ptr_alignment(env, reg, 0, size, true);
-		break;
-	}
 	case ARG_PTR_TO_CONST_STR:
 	{
 		struct bpf_map *map = reg->map_ptr;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 583961a9e539..d8212fea1e99 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1192,7 +1192,8 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_LONG,
+	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u64),
 };
 
 BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
@@ -1208,7 +1209,8 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 	.func		= get_func_ret,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_LONG,
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg2_size	= sizeof(u64),
 };
 
 BPF_CALL_1(get_func_arg_cnt, void *, ctx)
diff --git a/net/core/filter.c b/net/core/filter.c
index 2f6fef5f5864..9a7899c986de 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6219,7 +6219,8 @@ static const struct bpf_func_proto bpf_skb_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -6230,7 +6231,8 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
-- 
2.43.0


