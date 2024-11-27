Return-Path: <stable+bounces-95579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B3D9DA0FC
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 04:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A013287672
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 03:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719DC3BBEA;
	Wed, 27 Nov 2024 03:00:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A41BC20
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676454; cv=fail; b=mf+xCKr1dNd8WL/tWJKeVmjy80KFqtlLYGyksfeNLN7LiljcFW2QW12HodKG/xwmAWF0wSmlAay4C53PSei2MI0qXVoM3O/h6wrsoFYjpSAy7Jxtkz10B7sEHNx2jvYXnVirAIX8KJZryw94XN8dfX+vKvsW2LJ+yIvWIJpNRHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676454; c=relaxed/simple;
	bh=k6WBPJNlTg4rDBAb/RyrgtGGCCEjoM0RXjThBHrITr0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HoIisBGYLMMFv4RlJw6m9OsPMV7D3QoUyNGucOgI1oYzthI5RrjSCx6sOPwqBIvOn4xOt7+EpqKV5tGPXvEli4p6eKmZp4GNSja+FsLqvzVSI+6+gTuobWIytEpxMnZVm4hpyZviOZNIdgWXQBVAb7eeBd1AEIheF19f+DEwCss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR2FEHC009331;
	Wed, 27 Nov 2024 03:00:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433618c13n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 03:00:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv17g1oFCW74kKIbnjVaQS697Rh+q7eKi55KMjbfdaAb8Za3ltUbpn+KwW48nL6TsLLps7qL7cJ5uswP0aH3qclXQjpc43b10GgHHsa3J3imnEHowrMHT2ggSjBmqonvsxdw7LkE0vYfpSZAJU/1od8fSP4rPbp3BmBuv+VydnSvLuxQN1pTuq2KB6tpPTCiGVGnHY5WgG9Gy5Hw/95425xtjj7Xhcsp9WWm3NgH9uxXovMb4cEw/7O7ci9HJTeleye6vsjkbQrE1qPMyx5jNDbomrHvmh8NcsF+hCtLA15mkwE5oPAa/nBoLbAE9+Y/SdE99aNnYp8YY0drwHfmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqAWQUf8tm9Nl9/qE75GFXAFLL4PWBe70JgcEKqMERk=;
 b=egJ2XaKV5K23p2OWHU9fZeFwu155AgrrXNodXORC/eVv5dBFM+KogQwvtf8SZdZE8foMAGL4EpTP6dQcwZ3W7VrXja1r7HrT5HGv8VxEjTAqOHyWZm0pqHmpJJgLH5Pj8HZEFifrYSugouVIGTrqk9kiV22d7DM/uZhBN53dNJTGYU8HBBEIPj4HyT5PwpNTE/QnvxTL0UW09MbyZh9uNXeguGs9Ye1xOxnWHvpTVl1tDWh+sUx5xVsi3j9OpiGp5eGMPCYo8CX7lhySmA80h0njr8uo9zHOoLFlPm9qVyyUjcJUO5DGirmyL/nqP+5NQT8JWRgB7jGus9y0rsG5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 03:00:42 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 03:00:42 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: srinivasan.shanmugam@amd.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y/6.1.y] drm/amd/display: Add NULL check for function pointer in dcn20_set_output_transfer_func
Date: Wed, 27 Nov 2024 11:00:58 +0800
Message-ID: <20241127030058.1179777-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::31) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|MN0PR11MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 29eb2697-75fb-4fa4-9ab1-08dd0e8fae77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r8gFi8zc3WKknpcACJmVdeV5jkKdJjT0ULP7QMuEQGyf0ZamMnMLk7aj21uG?=
 =?us-ascii?Q?Df69BdHKCaClnXgL2PCKcZ3DUdUkb3SZl0sto+7cHhFAAEyIA8cXMK8pwFx1?=
 =?us-ascii?Q?bL/zXu86estKMGBQv52bV/VYQiE1SOrP35kVpnPDCbR/H7lKedv1/HMTzMTO?=
 =?us-ascii?Q?fAotfyjlgGhnrUFFXHfQFdMkqPhzH0NlPpW4OnrF9ratY2lijHcZrh8N4L0+?=
 =?us-ascii?Q?TQFPUtOeXAU4v2BRx0TMqMKBgj9CTN8aUk/zY+gbj1LG3iLMcMUpLmdbuQ06?=
 =?us-ascii?Q?jszuJiz7K43ovCcxaP9LKSeb2DaBztuippFJpK/wgrDypnYQiT2K8M/onef/?=
 =?us-ascii?Q?I6FseCfwfhSCoXCxwpzHEcg8a0DY9NeYF9yrgy8kdIg2OLlcgA07HIiMnUvf?=
 =?us-ascii?Q?rwgDLnN3JLlfxZUYdXojuHxMw8QN5cS2xP8EJiTwuQUy0NqFst5Yj7L6h8av?=
 =?us-ascii?Q?cXVtZGltBpQpTSoDxq+k/6WKHf3iaXXfX8iEFmMXIclk05ZQvYtP9TZNgySQ?=
 =?us-ascii?Q?hYX9ddtDcWW6QStFQmKESZ3Rcrc58JthahD5WJKn+goZL03/RLrtmiGV8Kzl?=
 =?us-ascii?Q?BsmnpZxNd9oKm+WO6nhC0Nkn+qeD7ysXhahMHeBbeIpphE5Sk/AGFmPMUx02?=
 =?us-ascii?Q?jaB4s2xkZwCWByZi2dTgZpkoPLQk45xHTtL3h1H96EGE4q//dNtUREgowjX6?=
 =?us-ascii?Q?1WcS3Oz/I6hQxbJsS5FNx96AQaNUNUxj7Afj4X74cZphTwWRSmGKQGKg+OXZ?=
 =?us-ascii?Q?U6Wvmetu99TOHkWwelEQJhgyHKbGl6cEMarE/DUzoErr5lTxawUCpKPLpV2M?=
 =?us-ascii?Q?11zLn1fp0kcDfpDkFnR9QaPaqI3CBX7Ekxb4winXoJUOgzWSkTGsduBXlIIr?=
 =?us-ascii?Q?IqrFSRDPOzD/pv8bpSts2ba85w+A43PEoVpcni8Rcg/MvxoB4mRkuLGsvLpn?=
 =?us-ascii?Q?K+0S+FyZx900tffXvegWRBVGUUXCmrG1VF1rBnIoIdm+rbaKWQrodalxAPKb?=
 =?us-ascii?Q?hxgx06BXMZHPwatunaDYDkji3uvILzF1X/DHSJIcl1+VZQTF5G9tmLVi/R06?=
 =?us-ascii?Q?inGCLZTSRWWGPzS8pS87vnYlPOpsmOtpMAnwXhgpXyGQhRGOnsmmo0Tt5NTz?=
 =?us-ascii?Q?sknLsYm1CvZ/HhCo4HTNChAHegXhz59APftfuQ6V0Qh77MSzKCV62DN/E2bx?=
 =?us-ascii?Q?eEfvrsgadr393AJ/5Vl8Gam7c6LxqMnDE+jecL3UYWpzT5mkO1SopcypVZbo?=
 =?us-ascii?Q?wfPQlna2fizaDGhPaWfbrVBiFol4fT/WTfoVn10de/VJQ3fqLcmnxwEqme9u?=
 =?us-ascii?Q?Zd5mEcJITOn9sJryQ5MyN6UepYObctEcihZ+5oz20k/2OG49W30PulHwtULC?=
 =?us-ascii?Q?l0Jf895b8TgDyOon2xF0UxzSTaKBWJ+KoqbvIH6PaEokp9W2dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EOrLg42EejzFLhKfnRjrOHuucaH7nyNCe4mYkR1weQ49a5S3CxYymX7iW6gU?=
 =?us-ascii?Q?wzVnDOYsEEZdg2vVFDJML04D6Plz167ZpzBqVe2D6haD6ToVZBFmBJ7g6P9e?=
 =?us-ascii?Q?57u18ot2273LwVWOtsHurnrTksHxyJG1LlhS61B1048eb+XTaz1BiQoeOoy1?=
 =?us-ascii?Q?M55KGdvOYvXGi1jKWH2MlE2OkBH2isyNH3Z5a9E8ccCSpne0WVghfwk6QEYL?=
 =?us-ascii?Q?HdIEqZKhR2ObCCfmj0FnTJ4sM9r8prcWFD7QMoSKRQlMAGGA6Hnc9V0lA7Za?=
 =?us-ascii?Q?BDmr+sgBiBs4MEDHg7OadChAEeZW0btKq5bjk1bu4iJhYGL+86Noq1OX6oUZ?=
 =?us-ascii?Q?dJU4dO6MNLXZ3bpqXRpZdEo49cIhTmeGxISnxwtbRSu4K/oWRENzy4R6knR/?=
 =?us-ascii?Q?tC5SHjdsx34RanYLzbk+DPtba4cdCOyZTI1Rf5Kpsm1YoZgWuvpc48Wf5DR8?=
 =?us-ascii?Q?atQ6YKdZ91rv4inIz2TMsIGaUJ9eu4Qd4MUu1r2bwV/Qziwl0p8QvrlReOlt?=
 =?us-ascii?Q?ZSXbBIcu+4Fn+YFvA2zWjdkvYcnPco8OsGg4m1ltsasIsEqEZfeHKLPijPrp?=
 =?us-ascii?Q?8Ax/3MjYDYibZ2hdbZ89zbzB/K1/4vI+YtLfP4GkVaRuouA76bYZ1PQbcPxv?=
 =?us-ascii?Q?RERoMJC8p9Ea+m/FHjHTlFtfwKCU/5NRY4GRdsWZxl1hxRuvktFokhu/q2SX?=
 =?us-ascii?Q?UP1xCa7WVdHpR+iTN0m6FN1GlKeKdhyflTs6wUQENeZz2/zqZuYGmVgUq/VD?=
 =?us-ascii?Q?ejO7cd2O6T2H2OmpU0HzV/zrCRx2lPHURSKTSy8hM7ng+7JTyxaw96wny6TI?=
 =?us-ascii?Q?dGCCnqWkGaY5Czx9sLaf4ffYeHG3CeuLPFqmDXFBjHfpDoVUY+lntM46Njtu?=
 =?us-ascii?Q?hyloPzOrgJgcdKMvhE2GmFbQ7Aa342mkOqnZ5JZPdgtZj1Ug/tqjhSDRX4dx?=
 =?us-ascii?Q?TVZVkq9Q2BPUUapeAP35cyGB64a8J6UKLd/yUihDTyTHdZpWuPaIlsRa3qYR?=
 =?us-ascii?Q?tfu9vxeFl3dfTv6ACjgBEAYCoa5RDmMmu84KiE0oMm/AAq051JkM1RdAOpfk?=
 =?us-ascii?Q?eJyaE+S+m6XvyATA8qv4P6ojLKDmHF/t4L3K08yviLz4iyz5MTaUkBAGCevp?=
 =?us-ascii?Q?pxn3dkl9FDlHl3RwXZKzZ9SlLArsfdlHX/RzK6OYupDgVOjU8dlbqZ4mi/uz?=
 =?us-ascii?Q?zEieeBb9EKvoft39s66jY0OudFT/bmDZU0q0F/nBJ/0/oM75vnFYRehTLnyy?=
 =?us-ascii?Q?LZdw46QxUnt1+VrfPu9lqlOXbnj3RZQdZVH1akIxhXX6elEtKV3a0XKxvqUJ?=
 =?us-ascii?Q?UzxL+TTKKmevmTbaCsP4G2fum3uO5ONIgiZD3gVJr1rNgq4mOYKKV97z8PaW?=
 =?us-ascii?Q?3Ty6C2u3JJ/fvZWoejY7c2+TEIzsMtrHgDJXI+jD+Hd487rjzGcvL6Pzxd3G?=
 =?us-ascii?Q?9AUcCal00FKWSrweGziktUixTBsH+RaPsOzWfzuvfsc1l4cXMTaL4NPm9I/5?=
 =?us-ascii?Q?5dEC2BkOhwCUfDLcaFnAxaB76OwhHgxL56Aw7/a8rq+mmelbsydFe4+cmXao?=
 =?us-ascii?Q?Dzd4tdXspJ4ZMuEWVrC8QnMDutB7OYc3EQMf5TAp/ONWlE6dzf3Uquo6BI6v?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29eb2697-75fb-4fa4-9ab1-08dd0e8fae77
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 03:00:42.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wod2Mvuin//YspgBnPRwt5+d2cOCTp4PRvu6enz5Vd26Srmta2RWbf3QZPe9HHpYef4XkGqH2ekY8BfuQBSbZ6wGXOi5QD6RSs0EliHLBDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
X-Proofpoint-ORIG-GUID: L7f1QH0Nd-06I-oCEGySNnsiE4Cj8Ne2
X-Proofpoint-GUID: L7f1QH0Nd-06I-oCEGySNnsiE4Cj8Ne2
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=67468b5d cx=c_pps a=LxkDbUgDkQmSfly3BTNqMw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=cO0flX6-6AK8fcMv6_AA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_16,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411270024

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 62ed6f0f198da04e884062264df308277628004f ]

This commit adds a null check for the set_output_gamma function pointer
in the dcn20_set_output_transfer_func function. Previously,
set_output_gamma was being checked for null at line 1030, but then it
was being dereferenced without any null check at line 1048. This could
potentially lead to a null pointer dereference error if set_output_gamma
is null.

To fix this, we now ensure that set_output_gamma is not null before
dereferencing it. We do this by adding a null check for set_output_gamma
before the call to set_output_gamma at line 1048.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 9bd6a5716cdc..81b1ab55338a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -856,7 +856,8 @@ bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	/*
 	 * if above if is not executed then 'params' equal to 0 and set in bypass
 	 */
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
 
 	return true;
 }
-- 
2.43.0


