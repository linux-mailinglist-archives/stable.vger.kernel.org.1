Return-Path: <stable+bounces-95612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009BC9DA593
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 11:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DDB2843A7
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402B0197A9E;
	Wed, 27 Nov 2024 10:17:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC5197A8F
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702626; cv=fail; b=IGrL4kvlPte4Kbvbv0UlioS5VmHj2fFUDwbUrPEbAf1aXsyz13Wgpfbt65wrbyDQ0Ol0HK9KDXX51FhJFW0v4PjnrhwqyWWPii4kx3LOV3MVSIClSdMGjIeN4m9mBMmuJnbbcBVgbFOa3m3AYCbyTcoBZePNM5PEx7p/h33DRGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702626; c=relaxed/simple;
	bh=QI1DsjpWCw6c/Kzfs6ermpXs/hHuTHdKCigMJLtAhDY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FKPe5DFicQysqQC9cdJeAWg8Nhq8xamGc2mESA4GfgwXoTbw6AYQM7A+3c72YoLjjHx+dTDLen753MwGiDx/kSBCkf04ZJOFR/eFCqXSekahkmfyc9ONlItjQiJIY3hywWDuDHVqA0CyxFqGa58Iv21T9L6iGsajYssmjpqdG84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR5QbFR006567;
	Wed, 27 Nov 2024 10:17:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491cejh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 10:16:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyGTRTc9etJ/wkFBhVHj3XURnAfnC8zGR08DpddKCiF+Sbr7XHJS2KywaIgjcT3IxcpNyUZ5T0LrhLY1jhSHRYvorKNZRo97LP5YcflI4i7A7dLb+xFepT36Aop74FDNLkB1NopB/a1YJmwiuPFqrzgWe+1aw0FejUNDDFFyrcQUti+QXdUUB+ArE3h4k3mxFqYtorxNjvxfJ6bnJ9VM8cHCnDppkXUI5jcLivokIQiHYTX/Hjhnj3RcRgz3ARfTqYKPHjPvH64FmWhB8JZUsWL0834gNd7igCjdije2zFg4kmxMIg9Aaaxa8nORR3r08KsL8el23CfCnCrEruvb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQkZjwvf37FASuMdFlIID2hJL/g2VC3zThVxXXZMD1k=;
 b=B8vkjWuaWg37KQIpBiH4jjkIR4t/4xy3nz9MPhl7POm1N30ZNIx/PcV//TKNi4HqAYc6Iqf//x6q5Bn5OPTy2UXAakEH7wz0i/6vmSct71rLIJis6CKugw2f8pXqxaHrMhUPsAsCGvDNsHc3LA31gToOddSk76Z32/qw/VgDp/ip/p+YHRR+r15h3SxP6pcFZW6QV3uRHSfkH5D7Ci5qk2qcBX+JcIrzal28yzvS67FJxA8vowZ+3UC6vwg6jAfBJ2g0V/YVqG3B803ShPgfwolWAoQPEJ+aVp93kO9c0C0pgMf+xA8w32JmvEE25IiOv4IlzE8airTq4Z0zamtoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 27 Nov
 2024 10:16:55 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 10:16:55 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: srinivasan.shanmugam@amd.com, chiahsuan.chung@amd.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1/6.6] drm/amd/display: Add NULL check for clk_mgr and clk_mgr->funcs in dcn30_init_hw
Date: Wed, 27 Nov 2024 19:14:32 +0800
Message-Id: <20241127111432.1791356-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:405:2::13) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|PH8PR11MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: e8858f6f-769a-40c0-f372-08dd0ecc9e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m4OzvHkskD9PaikrYxDY6eOrc8r3/qDMwQErxEcQitXVcPp8m4ivTnRs5/kW?=
 =?us-ascii?Q?hzKWggDCRvfBDjEL+XU5gY0FSDHzDbfsYcmDbO71ks3wbXwi1UrL3dFUnT65?=
 =?us-ascii?Q?qwOGCjY6SkzzQwaMMRGGGaHN0ss8nb7Bq/crgda4pJczAsN6N3Fl/+IRwt/q?=
 =?us-ascii?Q?a5EBL5YX9jhYEQZanMZZ4Ul9P7lFQNew4NMPzpaEkZUqebvcmSk6CW9qUczz?=
 =?us-ascii?Q?8Fa+CkWE3Pm80mY1deTpz7PkCfDKKB8Jj1EwtvSpsPxnVpBQvBYLRDu3H8L6?=
 =?us-ascii?Q?85bVfP8lVhiyUth0fL8k1QudKEBjL3pBYfrChGTGuTP9ki8gQCpzYNIfjrky?=
 =?us-ascii?Q?C/99/iE8Us9O9VdLfwlXUjtcK+noTA7utKWRw7EBqo11xeBz2LlYMg8Xd0T9?=
 =?us-ascii?Q?OucoBPYkmtBsKZUVv6HnwvAxtTVAPBvTKDYka6Dg0U6I03JE2Azj26ZJ7e7l?=
 =?us-ascii?Q?Py8gDjoYiZqS1JxYE6oaNCjeBbGlA9Mxd5KhaZ9t2lDCIykddQI0n8bt2vQQ?=
 =?us-ascii?Q?Qis1q2cc1NvUkHg+HFoBrDhChtm1yrohK2yXtTAdnI0CJ86bAQ8ENN+K+HF4?=
 =?us-ascii?Q?M4I0IKWfyeXFWfN+csUQG8peDRzfsFvStKNcu2RYEaw8UWyZ+0Zhqemf55Sf?=
 =?us-ascii?Q?YIuv2xQ/XXYJ1TJAOyn71vclrvy1cZxaVGeaHD43yNvxjf3EnkzQRrmzdEXs?=
 =?us-ascii?Q?xj5anm47YPNaLmnLHANXCvF+5NJBdbPjj7+F7XrP3At0Vgpcg5Wj5uziKj2D?=
 =?us-ascii?Q?DMreUA33Nee2ihMM8XFegkYyMSiQNbXa8hTFvM1uILHHdHcBP9bjjelH0mWN?=
 =?us-ascii?Q?6i55QaJjo6n7O5Ec7O5JCn35j896wnewNKiPSbS+7Qluk9HWwUjvnoDmH30Z?=
 =?us-ascii?Q?btp/bH/R36DmsASsR5HjPwaPLEkt6clea6v349dFCmNzFy9CJCAYR+aRGl0S?=
 =?us-ascii?Q?cR5m6GsQL8R4oqm2NVh2iqQ8PgMW0xuxkxhth45rrAt4mJHtu6/VNK13/yQ1?=
 =?us-ascii?Q?7daoYzStqYyjIp8Yx0xkb2m5fuFtElQHjWV8Wa4wDqgRbBgkpT1Ke2SDdimJ?=
 =?us-ascii?Q?sjPqOFhcg5tJZ8QdLI/HXh+0YGVpbfBk1s3W3wDEzrx67h5ddJxovE22SuUB?=
 =?us-ascii?Q?RFWIMe8mRo9RtNQzLAru802agc/RF3tF4/z7i4l7SgtRWTiiBBi+mEXbW9HF?=
 =?us-ascii?Q?ldhPOT6nNN7ZIFBjDtoedq2jqklo5MnxwQiCFefoMXeZmW487FIwm09n0dex?=
 =?us-ascii?Q?JjBuITtvBDJiLahZO025CIHxkn40Bbttyl+knbICikS7lTUNtTHfHDKjkgHD?=
 =?us-ascii?Q?U4o5DYCktZZ3014BvP+SN/0G/H32rQBlDEChsSo1BR25rhBVpakjaGNqrwrf?=
 =?us-ascii?Q?zGuHd9/kV6qaV7zve1noTxPhKDuxrR3Ped45mJ0R+ManPNb20A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smDmOMY+Xvh5KFEegVoknDqVZs/YdgAKnRdZcT1VCFFcgbESGJ1rKLV4xfSP?=
 =?us-ascii?Q?fWTWS7aigcGldEmOr9Sa2u2t9PsX/SDN7psfikBVmxzFq77N0T33FIEV44zb?=
 =?us-ascii?Q?oWI1x3BQQMZWrgme+SRJTRdql5WxIZslzWpoKjmM/Sp+iO5AsGCLdTUYxi6G?=
 =?us-ascii?Q?CDOMxrjpygqgvhgnNG8G8ZeoYeEomt7qliyS5S2EE1FMPjw6OC6TW6JcS2ki?=
 =?us-ascii?Q?bxyYkiVLAEdWfmZ4umBT686CH+KWVljACt32COrwAoYI8OfEKKAKDykOhfmX?=
 =?us-ascii?Q?9AflxAFX9SMRwehg2pyTJ1kvIrH6g5S8nH0FNIpzh/HX9q6XuxZszatLMsvQ?=
 =?us-ascii?Q?7v5gFzC/hMpapdWhlCn3PTfMHClOBiom+c6p0EjJ+5Dr9W2D6s/sBkjH2I38?=
 =?us-ascii?Q?kcu31zPlKyCZvcyIfPIRWwa5JmvaoTC7XNASgn8zhLo99tWxpfkvpGd4tf/M?=
 =?us-ascii?Q?hQK47SI+UEsyLzVkZCO4a4B0Hz6mRtOuXGA86MLKQHVWBI9qe/7yW1AM45y0?=
 =?us-ascii?Q?quCjeyJMqUfjnSMALjaX7ibvfj724alJQK0wyZ1eEZa1aSvqRiwyDNShLnxc?=
 =?us-ascii?Q?i7vAymGi4JhOF/xuQjSRvT0822DXOmAlzuo75Z2/u//kctiDPJ21sWwLQmhh?=
 =?us-ascii?Q?TP7lSzIhbA7/PZa0HzHCXW9TaEWBWzxiISl3+lrLrrOdxUcGDxl0z5lxcQG1?=
 =?us-ascii?Q?ZCNPuq01L/AdrJiHJT7KJQ3MXVC8Kbkxt0Yh2MhOmkBjhgPLyqLLlFcjSnDX?=
 =?us-ascii?Q?M1Gu7PfnTGVLLFOlbILJjwC0AIX/e1YeYWRXzLgrLshrsor2lPpG66z2+qQd?=
 =?us-ascii?Q?Wwx18vlpn0ewqChA3ndxM+oubpr/J37t+CC1trDibS4CjBNdf8Z+Wiw8gTqc?=
 =?us-ascii?Q?+uA+M78+CP6IjR2K4w2F/ALc2FBcsYT7Rqz1Nihc4A9E4GSdFHY1kbZiAbYg?=
 =?us-ascii?Q?ws/nTXtFS6XV8mQoPqwtsU9i7h//x5xqfXdgJVjf2KaSYl2ueY3RbSJkeyeR?=
 =?us-ascii?Q?tYXRxHaQwYw64uKoX7ZmPiSeRXXXXxcSgqPKUtgd4xcHWbBEsKquN+nrcC7y?=
 =?us-ascii?Q?uGzLUcoduVyCJdx/mZqN9B6zWbJNaMejfCY5SAu2ZGxF1hutny4DftVjOUp+?=
 =?us-ascii?Q?gbNLxwestHphgOFjogHDBpU45XYQzMSAxmGcJCG8f/P37MZURsnWjlJwWMqT?=
 =?us-ascii?Q?j/TL1GOqKxCcuSShxpHTRW15uUEMJjC9CPOCu/M9aTrmJDlr2qr8Iu8geQdB?=
 =?us-ascii?Q?HwGMDjT4x9DAQhV8V5Cpebvy7ZYMx72fUCWP1XEdXhvNl0r1Ie4AD065k10M?=
 =?us-ascii?Q?wMs8uorhV5BY58HgcYxiWG4OxHRKjzLzZAL7PYZS/gGkFF95YBioMZ165XHt?=
 =?us-ascii?Q?xsPNkzHkBZFrFXdzWHUye7m8sdvUaWFmIsXUCIzkc6sEEA7u4IekzL+2eHLP?=
 =?us-ascii?Q?+uaChYsPIXQ7TcKptmp3pghyj3KWXXtKJUqeMjc7ew0HpynSC1G02a9XrC6O?=
 =?us-ascii?Q?VmRa0ASheaTvT6qxFIrFKZVJf+v8dzP4ymvhTxGyxXkm8+MOiqSxB8SBFAuZ?=
 =?us-ascii?Q?R6iahlPlZ2b4MIWUExKXIj3dwh2osj0WahLRjbaduDFiV2i3jGjpBNPiuTIm?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8858f6f-769a-40c0-f372-08dd0ecc9e55
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:16:55.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgipNpcYvBYAiCVuhIHC1wsGDu+owxyEWjZHVuKXCZnicT02p0XkcJSDbM2kCekj8MEJWs0spMbmtIwsfwmzuPTVxG641j8Nuu/asmuWqO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8013
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=6746f19b cx=c_pps a=p6j+uggflNHdUAyuNTtjyw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=He_AuWgUQVYDefyJ8LAA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: HNg2ZZzAEFmtUF1c3Z7WJvrn6kk2D8Y6
X-Proofpoint-ORIG-GUID: HNg2ZZzAEFmtUF1c3Z7WJvrn6kk2D8Y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411270085

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit cba7fec864172dadd953daefdd26e01742b71a6a ]

This commit addresses a potential null pointer dereference issue in the
`dcn30_init_hw` function. The issue could occur when `dc->clk_mgr` or
`dc->clk_mgr->funcs` is null.

The fix adds a check to ensure `dc->clk_mgr` and `dc->clk_mgr->funcs` is
not null before accessing its functions. This prevents a potential null
pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:789 dcn30_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 628)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: BP to fix CVE: CVE-2024-49917, modified the source path]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index ba4a1e7f196d..b8653bdfc40f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -440,7 +440,7 @@ void dcn30_init_hw(struct dc *dc)
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 	// Initialize the dccg
@@ -599,11 +599,12 @@ void dcn30_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
 	//if softmax is enabled then hardmax will be set by a different call
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.25.1


