Return-Path: <stable+bounces-89306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFBE9B5D29
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 08:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8030D1F2421A
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890911B86E9;
	Wed, 30 Oct 2024 07:45:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017B33E1
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730274359; cv=fail; b=h5i15eQDI7DBrBtoUjtqDLXCB45r40NXf9TX+41D+nmvFuZntaiT/RTfBF0qtZfN+g7Q+YLiPaOWhZvA5XiiUR1lmIVgHKbZ9gwWQbABua8QyeMOAkSsmG5id+PGsdth2oDCFxVnFvtdASHrvPpANvdXci8QcVTBtrsYXz21QN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730274359; c=relaxed/simple;
	bh=CH+SWm2Lx0pvujyViBx39Mqw+InUkwww/VvRRdfujoI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UI0bsR904nytGSK4PLGmOGTAcAXnamXCa2epAyCrymTBMRDi/5/+FmGHh1uJ1skyNUoJnDe11b5kf11MHQa/6UEV6TCwbNF12haP31TkJCRc/TI6fqP5SVGBkswnBxfxGRq7Q0AulnrOi4FrDKDqyRFpNbr1YOBRvzC/Dks+FBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U69vgj006840;
	Wed, 30 Oct 2024 07:45:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42gqd8mnd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:45:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSzECbezKFt4cRXKloxoS2+xOSF6SDajmGNKnIumd/Mc6S9ykpwdK/6N+GvA8ExK8uvQaSX3cOO5s0Ly+P923VRHzG7SIVoBupdTftshdp/4F2IBUugsOYAgo6EiiJiUTreXN1u9ADHHuCBDUef7gSx4FQvB/dwkmTiCQfae2Ls/DeNdaVY+M+1SmYyM2xXWjB+QVH46+q7Nx1AB3QayPoYXp7iqPuuWWkGTOi0Xf4YHNBI1kHM+WvqE0NAhMMLWallNnQbDpHgIlx8rrzc7Pm4XlgWMe43HWpeTqT5OnszgBrUTUrkdk1CEFY3upR0YlTCIuHxaLl9oF7rVcBpQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4de/8pAIFE8z219nL8qjbwOQVfXb0qSuW0mbdtrHvw=;
 b=WvhyauoGlzgV66X44DnO793+ZOATDeTSitM/dzWxrCfCp2hXgT076aM57o0pNMsrqhCIBITirLHgG+4aCEaxR6NnIpCryoxgIpV+z1den8aDvtxp5VAWd0rJyzyCeXV4QBPTKN0p+CfLQDU9mV42AofKzrY1cQNcv9AgbVwvbL9dEr1yw/W/UJjKNhbKIxGAJtRrgdARWNG4sU2tdD1F7kJx8RuOB9vw3Xg2sCerdyD/R8SAIzIQVNKe8GFOGtcY8wbYnih8DZ5AcJWO/80jxeSrFl6GXZdNqBDNdstx+g+BMBhKn5Naq457l0XW5HUI+YSb2H5qv7/EzhgUw8xSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:45:45 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 07:45:45 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org, srinivasan.shanmugam@amd.com,
        alexander.deucher@amd.com, gregkh@linuxfoundation.org
Subject: [PATCH 6.1/6.6] drm/amd/display: Add null checks for 'stream' and 'plane' before dereferencing
Date: Wed, 30 Oct 2024 15:45:26 +0800
Message-ID: <20241030074526.1509106-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::17) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CH3PR11MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: c77370a8-5662-4132-a0dd-08dcf8b6dcbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i07FvHpu2upJPtm0IELWZ6bgwFhaYEI5UYSsKDYXO8Ev2W6rZoFhHOOrWRau?=
 =?us-ascii?Q?9cRgzCysql2SCR47FK2ziTmzani1VX31/Bybvl4/QLtN6LRMMUPvrC++ojk8?=
 =?us-ascii?Q?1QOLIa73b6p+/HSSqwyDeVHFV6bIyE1kiYcTBzZls9hmaP4zruAG9OH8+qPB?=
 =?us-ascii?Q?qz3CE0koj6U4UzjbSCQp2Qqp3IQbYacl+uB6dUSCulpMDl0z9n6M0MwbHWbL?=
 =?us-ascii?Q?+T0t1QHu82+d3fbyrnt0GQbdXzIyWzbPBzwU4GHY9bSIpI4x+25UgkFWtI4r?=
 =?us-ascii?Q?2LzNBwnsLTGimelKSujpAFaZkQ0Xq+kxJuCQRA16WCeyWf3vPXyZgOkFXHuC?=
 =?us-ascii?Q?a3srkQ64C3fp6ue40Ouv5kiCwYV2WXiVioI8UAAtkdu5Mak2rBtRgYCw0uAy?=
 =?us-ascii?Q?hmAP90mwKAIVIb+Rxrwje28BTDuFBBN3ksmnd5+YtV88DpnB+DAqeTjWQycb?=
 =?us-ascii?Q?q8bGX/qmu9mIAK3gELLmNMlbqHA+ugGxzNQyQ8m9sSTyBdk/bCKPyhWH6rLY?=
 =?us-ascii?Q?X2xVOkInTJA2KcVcQq5D534e+jDbcdcEvs44r7nVseYBJsGpiSxrwPQ8B7VU?=
 =?us-ascii?Q?dNfZRi4oQPesP98m08evFmFjDJNireAkAD//zxby5We3bsaH+xuFwaB1F2Xa?=
 =?us-ascii?Q?XgaHsGoROLF6c9WDVen2DH7L2LkXyO5FNQvPWbiht6efAgOeXd6aiins/UFi?=
 =?us-ascii?Q?8T7Gd6kY9vn80Zoe8Kv2RnECZzmFiJ4M0TDLXUBrInLBDnIVGqrrJBqgBekR?=
 =?us-ascii?Q?QO81OMpOZF0CP2RbT+nGnjVV9XzjqNHp+ByypOWYW26io+aRZl3TBtBD0l3s?=
 =?us-ascii?Q?0VXfm256dAg7tBgA2IwM6XMn57TqWeAyQgbKUvF+QtHYHjyKt7f+Cj63Qvb6?=
 =?us-ascii?Q?CuLHXNdZ/uIjQOJ00AMnfyIOweRIqAqCXgS9W5EJdLLIRm3VfVZMSy8OwyMI?=
 =?us-ascii?Q?47TPPlFI5ObVryvg5z/HFQ7kGZaMfS1b5S+21otD2Eej8gTyGoEwV7X2+DvA?=
 =?us-ascii?Q?yxSDscaSOswlLxU2J0sBMuONwhcT2eI2KAfEHP7gbRAvSqLSKwhK+HQytT2Q?=
 =?us-ascii?Q?TBQIcZUgd4oRbBdmvKeKlMwyA64lLQJRfTF0rLZ+4CwK8kVUW2wOEONytyl+?=
 =?us-ascii?Q?HEyWM/oX7D4Vz3sQoota4ByXAnEWrrQnULLuYMEwhs9HA4Uz8jOULu1svTKV?=
 =?us-ascii?Q?NipUlWCzFSCs5Ite12lce0ZSBOfwm/N1uj2RVYmPbL+awIRqjQ1jojheTDeS?=
 =?us-ascii?Q?RbS4i5oAn1Eao7K30f1LqD5RdfGuxJSOtHuJAH4wsNeuILFfLxwNi9LIrol5?=
 =?us-ascii?Q?UFCLBgQ8wwVwd1qFwnRAUiVDoXsyQDlwmt0UDZoduKr0ZMXMDFqKi/mJroEV?=
 =?us-ascii?Q?quLGVns=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWMmmDPEGqaERVts+SCgyioXJIO3c4v3DYmN3byAGKwCsRqmYkDVX2KFe/IM?=
 =?us-ascii?Q?68N8+JZDznDPdMukUydf+oCw0zBteOQ1uAmtAgF88WVUyPaAAlktZA2ffnFp?=
 =?us-ascii?Q?SZaLaAXgGOD4gYBm9zthmsdaz7B2o5SF7cZ+I2h6JzJGgxIG+jx7nEOdKDQ9?=
 =?us-ascii?Q?yxE0mlP95CqMiOZD/RFeuuaGSvqwe/Na29j+V6bAZX3Dtu0noKAQwbmV4aUq?=
 =?us-ascii?Q?QGXSCojsb8UhmcWZdrGPIz48G5li+csZGwDJ6itkDsQqxokbQ9tPXTEoZx1Z?=
 =?us-ascii?Q?q8JZpJgdmRuXK32Ys9UuGbiAAymlHw3ajb7tG4NQlBUxffPMSLg0YEoUGH3K?=
 =?us-ascii?Q?Qb1F2Ffejv2jCXmL3MhmdHIttpdvgnveQp78Sh0/kYvGAloOuKs90vZxDn8c?=
 =?us-ascii?Q?fqtSL6lApu5Ui+DgBWIZ7E58kvHpyzi+ffun8FhovfCAvBt4GyyvdlFs21AN?=
 =?us-ascii?Q?puHyqjaCzFTYQ33uASApSBfrBFqSCQLJpUN783LHdyk8ZqCsrezN3YLwhPfa?=
 =?us-ascii?Q?2ZsEpZ9AhlAnKYBP/3WDndUsn5BqKEjW6mU6I+VB5IypoUtWWr7ehgEYt3Mx?=
 =?us-ascii?Q?YC2n3ufyxp6APKndDUQsKxLdbQ1pm6Hm2lNRZWieRRUFwGYtAipwqNdrWIP+?=
 =?us-ascii?Q?vfUqU7Fw8z79OCNk4I+DNyfu1WoG5Zevn7YBOzf5c0zyc22zYaZ+K5OuIG1A?=
 =?us-ascii?Q?7Y9aR9sQR8BStYG4jOwSTpxGLYxXwLRrksB2J0bpctmhxr2JWP1BWu219f8z?=
 =?us-ascii?Q?pj4pk62kzTIoG7LBE/d5n9s2ezuqJNuKB3VEYR47bwj0latHQij+dtsVCLv4?=
 =?us-ascii?Q?9de0ycx7fH/UQz60Ph7R+L6ZWGePef6tSZwwFwxXOkstdEwKctm5gcb7G0jE?=
 =?us-ascii?Q?c8Qmmp1zv9wPoiIB005yW7fSqh4t3OiWZw38ZSrrP7japyTbId4G/DKQZtQ/?=
 =?us-ascii?Q?H6NH4rR/7CIBIAfKXfgn1p7sEZgH54mLJgFlEpkG1Ljwn6vT5xLp16q9oLZc?=
 =?us-ascii?Q?CViPcD0SI4glpS6TVlq2PDcScf3JmaQXRBd6goBRGwPuqVrZic//UlXw3dDy?=
 =?us-ascii?Q?2F2yWa1vgnU97JgKWZSJ5ERKklx5o0kWdnX0x9coEVkh6vHfHhrwgLwzWHCN?=
 =?us-ascii?Q?EeJ+JVxkFWW6LZZNIZUDrbnDar4jed2Do3PLETuc6skAi5yV0YPQZi4eECZF?=
 =?us-ascii?Q?Q/F2XfKCYqcmAVdpmYLifkvr82MXC5Yn4wmZQVipHgixpepoAVux/87k8L9f?=
 =?us-ascii?Q?hxa0K+X5xkqbeHUHcp8hM2/Of513/w5zA1TiYayd3+C3GsGkwPI+OKFEQaRC?=
 =?us-ascii?Q?uGyjpabdKMYXT/L21qEbUgwP8AgT15uZlDCeVsuGQMoOMwrGNbxpboYtjRS6?=
 =?us-ascii?Q?K6wJ+PyBHMEKRPGUBfvXVmYnbuQjjLSoOFnx58dXUIO2zriTTMXIDE5hBgFc?=
 =?us-ascii?Q?XJ3YLdhf/czi5WhNDI+O/Men3y+5evgZGYFITHnPtsOxSdhbjIySf14ySGQg?=
 =?us-ascii?Q?mrPNKLn9XEyBaKJtZVVCkcf30S2dHPZJs3aNxpchRSDoTB2BbCkuf4IZn9Xe?=
 =?us-ascii?Q?UgWm0K8msFhdBkM6gr+a3NlHmzgOcdID3tQq4Y6T4WsPcrrM0ea/ZRXBJ9mS?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77370a8-5662-4132-a0dd-08dcf8b6dcbb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 07:45:45.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4hNm0u7lKziiC+Ea44N3VUp72W1Pjw3dNR1a00Fyl8UNKuD4wS4x0hD2itQ3VB4AtknxbBerYlJ8oJ9aza7NZYWeFv1g+2Kkgc9ll8JYFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8775
X-Proofpoint-ORIG-GUID: YxDbgo3dnycOlI5lHn1aQm0Drr4Mk8ib
X-Authority-Analysis: v=2.4 cv=dKj0m/Zb c=1 sm=1 tr=0 ts=6721e431 cx=c_pps a=O5U4z+bWMBJw47+h9fOlNw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8 a=zd2uoN0lAAAA:8 a=fmkVBTeLr2XkT1_ESlIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: YxDbgo3dnycOlI5lHn1aQm0Drr4Mk8ib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_03,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=937
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2410300059

From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>

[ Upstream commit 15c2990e0f0108b9c3752d7072a97d45d4283aea ]

This commit adds null checks for the 'stream' and 'plane' variables in
the dcn30_apply_idle_power_optimizations function. These variables were
previously assumed to be null at line 922, but they were used later in
the code without checking if they were null. This could potentially lead
to a null pointer dereference, which would cause a crash.

The null checks ensure that 'stream' and 'plane' are not null before
they are used, preventing potential crashes.

Fixes the below static smatch checker:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:938 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream' could be null (see line 922)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:940 dcn30_apply_idle_power_optimizations() error: we previously assumed 'plane' could be null (see line 922)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[Xiangyu: Modified file path to backport this commit]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 407f7889e8fd..7a643690fdc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -762,6 +762,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			stream = dc->current_state->streams[0];
 			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
 
+			if (!stream || !plane)
+				return false;
+
 			if (stream && plane) {
 				cursor_cache_enable = stream->cursor_position.enable &&
 						plane->address.grph.cursor_cache_addr.quad_part;
-- 
2.43.0


