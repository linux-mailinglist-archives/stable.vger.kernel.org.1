Return-Path: <stable+bounces-95618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A319DA6CF
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 12:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21ABB28187E
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27EC1F6677;
	Wed, 27 Nov 2024 11:23:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4D1F6664
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706614; cv=fail; b=AWGYSOwSf6rpHJZaFT8tnK+/hxgJP50aurMukIs28nJp5FK5jmgluzRR1IOjvhFGKQqgBJ3sycM1Z1b4V/yN1+DANGEV4SS0rvvDAQ71S/nYyw3HiL5X7Mhplf8HDlbgTZt2dHIWuHIxE10kQ1/4sIvv/He8ViWfQyF262uorts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706614; c=relaxed/simple;
	bh=Q8vlFQjdsTyLlUkDYdD4Mo2K1hz79iGJwPFijqSx05o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=vC/jfZUkoAbb+K3dcLHoMrpo+fVcql5F25IDH0owJqLlV8SqZbxl5fMPiFrv96TvOUm18MIR61sunGQEpexkXfT8QAu2NdMz79EqqK36kf/Urw2XRT2yIuVCHgw5acQI19NXxSqImKa5I5P6peqyOQBPVVAumfgTnyPhtz5ULJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR8TkaW012300;
	Wed, 27 Nov 2024 03:23:23 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433feq42d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 03:23:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgtxL8cpS49OON7+ZD8/kAIn+KrO+CEu5elArTCeZA27xdObuY4sjBYGvdV94yGwSy3jjgkSwRMzPBcBU6EkwI8eYT7dRv8aQ7P4Ic28dGCT+hYHXJFw2D6JByhjoeURFn5EXC0ch35amK4Ha7WJv/7nUGfDid7BbU+iJ8fQAmbES1V8Gx+JCu3hrsjO42un0CYGWjfGBGTpYJsq/KDafmk1Fbcsgmdm8N6JPT/RO2D+tEhfc917nUhRNkXXeUAdUVr005liIz6Zti/7lrnIs/NmqsHlcn0tJDl8vHNC9FHdiaAvnuDvO3RFPPJt9t5BKCxRqaCQv5MYb5e505eIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laXDpqvGUMSpnXVn5wWcjhgN/v42soaqeXSUceQZdpk=;
 b=xZb/ymvgl2OjjljjnBxdBZv41rVVNWWh5PHR8dhDyfx7KeFJjANcneb+COCStMmyNu60y5Y1uGYFoNdLeME/ljrbRepDqjEpxSTSSDdpitQYc/rkdJl9nFGvvcMF30rU5/DE7+t0M/LgOZi+kXpTqOxwUEkNlqFSzz0LH5tZWlRH1uzit5tPG+Pxi8xL9AovmCRLR9TfC0pzDrjYGOWRTjetAQ/18MQvF1+uSg61Fx6zKD59iKJFUOAVOQ80E3oF0QyglLyJs6tZ+nJiSKOJazEk/+OXlwXn83bpz+goNUG1wR7SbJk07aqRFzkqRpvKCB+qFpnGElpoUHjU5zEUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17)
 by SA0PR11MB4592.namprd11.prod.outlook.com (2603:10b6:806:98::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:23:18 +0000
Received: from PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e]) by PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 11:23:18 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6] drm/amd/display: Check null pointer before try to access it
Date: Wed, 27 Nov 2024 20:20:56 +0800
Message-Id: <20241127122056.1889195-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0231.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::27) To PH7PR11MB5820.namprd11.prod.outlook.com
 (2603:10b6:510:133::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5820:EE_|SA0PR11MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5afe8b-c560-49f5-ea97-08dd0ed5e4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5HvkLdZAOEpme+bPL15C9/LkdPzWSsb9YsfVQd/OTEJeueJOi/XyO5ItBxU?=
 =?us-ascii?Q?wTZdx7cNktq2gxIRNaMj9yGSuN+uRKTbkPrpVNxV2otKGZ4pbsUun9QkdyGf?=
 =?us-ascii?Q?H32UDFSI0UBwW8JvQzclAr8RTpo7gQqTAEiQZ3t6GjNroLRkZIGS932CkOPx?=
 =?us-ascii?Q?PBs5FUnP+a3ESirYnnB4KtVxjgXie1T40U1z7D6If1hznf9JD9Q6BsapLz9J?=
 =?us-ascii?Q?9VcZ8ZJLMVN5ANMyGCzyTcBaTgS5tT62YxS11xZ7LR8jDpsjObyA+a4J2hHa?=
 =?us-ascii?Q?R2Z++GLE5o508NNi9zVJlXlU3fm8auwUZH8EaQhrjYOt5aPpVCoxUV1DbI/I?=
 =?us-ascii?Q?uzYA4xCmQKYGLFKMNxBbYvOjuyqlYno7opVhgnZGmRFtcVX3YS06QIp8zUsb?=
 =?us-ascii?Q?E90eUulX7QUGvsL4LtwdMIzBxVkTW1GUkqOD1HbVNL5P1bHfVLamp0f/Rdxl?=
 =?us-ascii?Q?dMMwPiOXy/vmemGzDMmyu800GiOSEqPzOwXzhiLoKpmiAFOgzlTBrk4EB5x/?=
 =?us-ascii?Q?hACzOSgkcdhAiLIP0ezuz3T8H8cb16z5M5RW1Wes+GIpaG0RG6cv63qzWHZ2?=
 =?us-ascii?Q?zwd1bf+OwwknmRsAv9K9Gu7aMjWtQwmvImpDtv3YzCtp8QE39+OVYTDZ+qRq?=
 =?us-ascii?Q?FMUWQPxlkHuC1jfkZ9TLXe8jWEqODc6UJrcbSdO8GOlK4dhct/wI/7mFD9l0?=
 =?us-ascii?Q?72lxekSUOq6xl6w8sa15ExpFR3WXORi0yTVVTlVnagG+7N+bO7Q4eM1RnK7n?=
 =?us-ascii?Q?/q7570/Wg6nirOKK90Rmo+ek9JtCYxJOOtV9rCyyadJwDFIMsocZPK+PU/ot?=
 =?us-ascii?Q?ryQcQB7CJgHHCig6djicNLW0OgVcLvhpIuLNoreNSghDs0+Alwt19LMRbozH?=
 =?us-ascii?Q?DSf3kOl0mGx6BlSzJIV2jsPUIeISAnRGJsvGauw1EjOwMaPUkzqf7MUyKPEv?=
 =?us-ascii?Q?uo8CPA77Jy5DWiGz8hijzVhsAo+8bAqdGy0nMeV6mdwIXb+A46sbJjM0+0ER?=
 =?us-ascii?Q?3gTeDMDnT0Bvx1JAxYQ+RKOC4LGUWUzXkfVVZyFRP5WsZXEtCWO0UXIdchO0?=
 =?us-ascii?Q?AfVJ6J+D1NpKc57sIE9HG1JsliGnFRZVrhRFS3Y3yz0f1802JepF9RFWeFD8?=
 =?us-ascii?Q?/rXYr7qgPzTi7oRQY8bs24EUHy0sXRc06jeQhNQd8HfsosLhM0ZkZxWV/TpH?=
 =?us-ascii?Q?TFzTnyf5nizzi6eN3sRcivcHKV7G5ghkW3A4N4Q7S01oi/q/cUmn2vno/E/G?=
 =?us-ascii?Q?iqwLWFZMKn+UKyZK6rbEniWkrpD4rCf5aBUxaLqxDAuIkHnK+vizwgaYgIMd?=
 =?us-ascii?Q?W0+zk1wFyVIRM5kbK2dmgvyiWZ63el5mKcvD3KhEM8FjhQ823dCWOwWZpCgB?=
 =?us-ascii?Q?wirkc4NlGFb6fvfDSTM7ZN2EXpsLkIXeSrHSY0sUJyRbNvx/XA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFY1ylfTdcsqBalkQxNc+pGCw4DYQyY1qg1KpKsvm1R1eBmHzghmUalrqUKU?=
 =?us-ascii?Q?Kqau78hMBaPeS7V10tZ5xoTTv1EoxuN27lbaTKkBFglXSb7eLQ6wAtwcASiT?=
 =?us-ascii?Q?t8JjGJgHR9rlLH2KGNhgFqanLTdBPDCcm8JJGJeRhSZoWaXAV428n0M8MYCC?=
 =?us-ascii?Q?5D/5qi5l/zAO6qT1hK4tY7eIWnNk6lct9k8RLcfgvQ+1ypbz4/f1IU8Cr5bY?=
 =?us-ascii?Q?3sKbSEl0IaQkXxpT6MQk3zSpO2wBOV5Yo1oiStvdzO5fKov9iq1hX7WSVN+2?=
 =?us-ascii?Q?eCZPppdM/L4OQCRC0XM4cv8pScR4wvNlkmTWYLKQPAXwBZhM3Xs6aATWaM+k?=
 =?us-ascii?Q?tYADsMVNKkcLz++pi17lPAHsbwDqSz194qc+rWIoT2HqWBSd377G+z7r01wh?=
 =?us-ascii?Q?vXzo8Xi1m6q5z6PmlOuUHDzAJU6fR0JNa5mT/vuitbiYcmyWckg3H9azI9LS?=
 =?us-ascii?Q?W8Wcjf6n0w8OTNjWpZ+bX7Mf8vDciiB8ZQQF2tyH6GPTTFNqZhWHwT1npdFs?=
 =?us-ascii?Q?3ilRdw7fx93ngnEv8gsSijdAJfwufQeud4P6sjmLjub9La7kDHzk2VEOi8PQ?=
 =?us-ascii?Q?ezcPEDz8x0fx3U4kT3JNzP7o/EFldlVXNqccV1m1odX8n42bWS9fS4QhWSAS?=
 =?us-ascii?Q?inEIYQFlub0lHbWCDYp+j9gEN3DkfiZDZPFrus5sobo0mT2JEk136kvtRnkL?=
 =?us-ascii?Q?UVdwf8GTJcPIVlhdyPUYmEWVRH6K80BCYbJGIsLcyPZ9orB2m1SQny7aXZup?=
 =?us-ascii?Q?K1t4biaHKNxX0TvjHTCWAuy3zWibcS9UYsbNJ3XfP4F5kKdHJB13csiQK4P3?=
 =?us-ascii?Q?RzZCr9FJdypcl78vG0SeI0HNJVcMVM2gg19p4l9CF+6lv3QC/PbIPkXNFnrf?=
 =?us-ascii?Q?kaOlNtEbQj5qbqnjOPOeVlRYiAECayIoetIhxl47KvKZ+EMNKQjFCS3oHwjU?=
 =?us-ascii?Q?S5DpLfvrcpcgxTPagRNK18IaxZ9rm3GYP6cqi5q6iSRl9FnSp9WZoHzOQwdM?=
 =?us-ascii?Q?E4siUQaJVAWyGgQVW442unMwBxSAMLMl/R+Cg5gYDlWC2f9Gu0qWvVPQY/ea?=
 =?us-ascii?Q?gRQKPpzoJtyH1Aq0YmCweLJTm4fQ4uqJ3ibMw+1oT48GzlMxGXAaLhysfSn1?=
 =?us-ascii?Q?rCQfiXQ8OjTDSc5PDZYMz+XL8geMNFiKrVzSFquBPMVoQ6GpmIVjm1nABkPS?=
 =?us-ascii?Q?/XmLafxx8B1kqus7zY67Hqk4n6/FfZSSXXOvTUhH61diQVmD0m51Y37tUaka?=
 =?us-ascii?Q?DDoTdyEuoluekRRIi6sid9T2ToElyl+jymYlkJwzFPDzJYDnAcbchVS4udtl?=
 =?us-ascii?Q?p9j7Xe8LBsFsKDs1gsERa/exT87xUI730ZXH7Mi496L87FMW8QBWAuvvnDM7?=
 =?us-ascii?Q?VcoHOPZbGD0CDH9izbV3k3VYxjjSWNA8hIX1UQfQTzMCrAOH6+ia4uHUBO9q?=
 =?us-ascii?Q?usGERA5zabk2aSxAXZPd1/yNJ60mBbPpkkB6PdRoumS5NJGvMY8rlI7uXOiR?=
 =?us-ascii?Q?Ngd4TL967CmHuHUKd9o+8c2w6ogFwB+ZUVgD59eue7/u2BeNMa4jQ1nqcUoM?=
 =?us-ascii?Q?l1Ao5UcdLzapHJKWj0pDCWCXSSqjG1hMp/15509qUmKi3udYZ+XMELHSfEia?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5afe8b-c560-49f5-ea97-08dd0ed5e4ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:23:18.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85jNN+0gWkdWDrz/fdJbixj5fUVNTidWfV2WsFuzFjp8PHLyyh7R5koBrLIxUa379+rhdsgfHkFte40SvbQzabUTpx/m9CvuL/tBrZTduI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4592
X-Authority-Analysis: v=2.4 cv=c+L5Qg9l c=1 sm=1 tr=0 ts=6747012a cx=c_pps a=E4Q64eWPmlOcdHW0GAz4hQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=t7CeM3EgAAAA:8 a=VjnBaFWeVVMStSkNDRsA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: e8Z0sSB3J7U0IPzc662DJZNIbB8qja5u
X-Proofpoint-GUID: e8Z0sSB3J7U0IPzc662DJZNIbB8qja5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411270093

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[ Upstream commit 1b686053c06ffb9f4524b288110cf2a831ff7a25 ]

[why & how]
Change the order of the pipe_ctx->plane_state check to ensure that
plane_state is not null before accessing it.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[Xiangyu: BP to fix CVE: CVE-2024-49906, modified the source path]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 2861268ccd23..a825fd6c7fa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1742,13 +1742,17 @@ static void dcn20_program_pipe(
 	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult))
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
-	if (pipe_ctx->update_flags.bits.enable ||
-	    (pipe_ctx->plane_state &&
+	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult) ||
+	    pipe_ctx->update_flags.bits.enable)
+		hws->funcs.set_hdr_multiplier(pipe_ctx);
+
+	if ((pipe_ctx->plane_state &&
 	     pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change) ||
 	    (pipe_ctx->plane_state &&
 	     pipe_ctx->plane_state->update_flags.bits.gamma_change) ||
 	    (pipe_ctx->plane_state &&
-	     pipe_ctx->plane_state->update_flags.bits.lut_3d))
+	     pipe_ctx->plane_state->update_flags.bits.lut_3d) ||
+	     pipe_ctx->update_flags.bits.enable)
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
-- 
2.25.1


