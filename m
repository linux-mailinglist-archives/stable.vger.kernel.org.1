Return-Path: <stable+bounces-93487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122339CDA97
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61996B23541
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054E5189F56;
	Fri, 15 Nov 2024 08:33:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368ED142E86
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659635; cv=fail; b=GtFqnB2foqP7cW/CVnlr6o4go2hORM3B2vn/0MCUOlxycXR+D1mLPl7XHWC4Ze0r/cx88XimR88Doq+0jhvhbcFxX2nuYg70GpEYjnszRg1E2j4wpy4tmzH7Hl8bQ6K1FeKfG7YN82FG/dyJEiTMDCtzpZAKz6ggcDbk0D+QANI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659635; c=relaxed/simple;
	bh=za2i6ycSObk6zX7FP/yvNyJgk3A/gztEPe9dCZNZV+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRMRGi3sqirDkDA5XzTHq+OEgQksdjI7K3OGMhpV7z6B0lp57lwwLy16zcr4HLqN774k7pusCKSWhXRr2F+025Ln0CODubkynAcy1HXSa47a2l5uC8gDOUGO87St4GvzcfMstQlRG1VF3XAm+pGA2ve3kLRwiIdF+cE1Gk780QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF5e2ct014859;
	Fri, 15 Nov 2024 08:33:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwv4cw70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 08:33:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3ftgFLd8o/pwQxVD6m1B26c5tzzgayBlW8gqRbZ03rNEQRXU60FgKyx9qk23ePwWXkb4bsgZ4UKoyLYq7qYYX9ce4EUsHJ/ha2IOGUt4a2DNoERtLXCuIgsKajOKSooV/sDAnUJWPRmTeNNqMc3ulQphYg1VbT5k+auwuMki4aGscAYxH8fDP9RQw6uX7fDQXWmQHRq1288ZGu04rqYcVubvkwFStjGid6K6Y6qh80SQrePOEsjXhU8878xw2OEtb/f3qKVQXSLU9i5x767p4SIhLCZzG3Z3Vzu6DgB3hKrf+xoA1TG9WICHVDCzqi/ZvVfvO15PEK8FzEEXjjWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xaS/CaIuVsHtziZg8ThKBsdVnyDdlBwJXKI+P0Z1lY=;
 b=eozNqayRHrnt4a/frFEW2ZgRXF2Kd7xE2/0LJhNibX69pr2GHGI3xJlSqH6KoVOK6D+F7qEjbr0+3+VGcXmStyeon0kLt/eOGrlcrYdmyqbPSmtm8CdLBneXYq6ndLxCZdN5LMyAiIGK8FFtBQmrxUNbKo6sYp8hrafK//zjoR2lBLyLUx6qmKjtgiGlpQalz4aniXp9WDw6KuvoSvnwm3GG8MtA/hFoXfWNBE9OGtWsi/hGYnyRGty8Xhw4mvPY8C/PzrJmbdLhybkrbVskPwR/FWQl0BXcNdo4Pp8zpyFUUSH++zNnq6hqXc7doeBRENiO2qmx706+urm3usZeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS7PR11MB6221.namprd11.prod.outlook.com (2603:10b6:8:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 08:33:33 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 08:33:33 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: abelova@astralinux.ru, perry.yuan@amd.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.6] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Fri, 15 Nov 2024 16:33:38 +0800
Message-ID: <20241115083338.3469784-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115083338.3469784-1-xiangyu.chen@eng.windriver.com>
References: <20241115083338.3469784-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::28) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS7PR11MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 156025e7-855e-484d-3cfc-08dd0550310c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vj9/j7kYEj9DO9OXaLy54eq93PQ0Z618ZGIkobacmvtx5lOk5saj1XDetK0f?=
 =?us-ascii?Q?X2RFLRBqJU6xGdesKI0dM42VWvZ9Q3/fGTMeBBgvl8ziRuNW411FifNbM+JU?=
 =?us-ascii?Q?7XRyW9SygX8w49J2rNP/RPuDZwJOADpU1nuZLR8u7cuXej1pSQubJnfcC4tZ?=
 =?us-ascii?Q?Y/aKpuF0Ey4gijEHqeSlLgRkN2bJeXcU1qOWCDP6iXtKIzYlaUFaHHlJWff4?=
 =?us-ascii?Q?KO5WE4gbOakBPi3bReeWC3kUd3y8hv3GHRGT107gVCduAHWZLS8jLfCs4TdM?=
 =?us-ascii?Q?oQC+IXZJJ5qNLYuL75ctAoXka9q+x7Bjq+anLkvcOO2yzRN57gLkdsI+rClJ?=
 =?us-ascii?Q?KXT1AO2SWCgXOKZ9fmQz7Hm8e9ay5uPaDJaCcqoO9hYY93fInmZjRQXmZW3l?=
 =?us-ascii?Q?p6divu1br43vvKKrf74T1eLrJ7yRf0wOhjsB1/0CSx/e2jK8XwDDulvUbogh?=
 =?us-ascii?Q?0qtKRbzOkqLMVjNKWQMxBNDzS0XnER3WH+csZo6hjRuThwZWQ+RSrbi4OtaV?=
 =?us-ascii?Q?UlKToymQST3BATCqlDP/wFeZ5VRhbyDt6/iXGjjWKgIAW2JkaSYegnOmWLd2?=
 =?us-ascii?Q?vsim5NHi5TvDvMFAtoCybpNINd0EXpZ5XYF+ajWqap3QFGHMFAdJcLtlsweZ?=
 =?us-ascii?Q?hw6FoH9GFdbrU2e6JLdW8qw6cfbJn9L6JtUiuX3yxUVo5YTOCaac1Sav9f06?=
 =?us-ascii?Q?cncFGtvlI5Xe+OBVtV0YXgO8cqyzxJuosu5y3tmgBGIWezN9DttaiiMgZhnY?=
 =?us-ascii?Q?zKv0WIDstgqn9IhKP/XK4zMfhhTKYc0ZmWIaJg1O/sHE7J7lw/cDGlhKu4iy?=
 =?us-ascii?Q?N2x7jvlrHJRSjPON35U59/YE9coWM9+MJIljmdbAmKxs7oxTarFlsmcC4x9l?=
 =?us-ascii?Q?GoYEyrp9nt4JyfgouEdlpuvbug0cF2EPzNrX93pZxGf/nwHOALih0vI0MiG0?=
 =?us-ascii?Q?BtnPU7NuOSaVtidL1FOQy3jBk1ce+J3zjm+IJxo/LpUmssZH/HVtnm97Zbjp?=
 =?us-ascii?Q?ljwEYg6uN+aAUw3i3syrhZKbfYaYYNzDPk6RuXZqB4kvn8/4D0bMryp6eZbf?=
 =?us-ascii?Q?ul/+fRSs625djG5aC6wuViTEpjvPsjcpWFNqIQtUinzQeRsR5H8e+ZF2ZgTF?=
 =?us-ascii?Q?3YVUobX939zB2NTGwp3jadK6jTLZcHZCrVA0RzRe3T+OiHNnWZafDXPePBXn?=
 =?us-ascii?Q?4pyWL2cRGP4o8ph6DGFXlQr5w0k/KiXRnfFR2Z9RegrJlRy0tex4FmGE7uCa?=
 =?us-ascii?Q?Catab2gaaoUNZw/uBnpXJIln+USIKoRHOz4lsSrOiF/iCSHMv+rZsgh24lY9?=
 =?us-ascii?Q?JqE1jVJGEKqlq1uvAhVX+zWQbG9l/OhnNXTDFiU5OFHaYlf9+c7mRYAxBRga?=
 =?us-ascii?Q?51ror9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X0+YWMcOrlMdLdVD4YwG4bLV5L6d8SzpXwja5T3+yAGgua0U//eAb8LiiPE9?=
 =?us-ascii?Q?OvdB90MQz+BIqyCMeV5bWIlHqFK7O/jx0SwcKzR+Ezg25COT3e+mgV26ABJP?=
 =?us-ascii?Q?RCT5E+fEqH33xi1HGOXkPetnUhPms20f1OgL2lExMgqaUfHbIKFylrvC5kcp?=
 =?us-ascii?Q?ACbJYPL/C9TymOuL3LwQEu3S4XQ8vfi9AhPq6xi0Oxv2pVYn3edmu0DJXWWK?=
 =?us-ascii?Q?+pjWoHanV/LXLdDLI1CH5O7dnj+rcs4fdGHUL9U67A/elkExZ5bV8yrIFyql?=
 =?us-ascii?Q?HG+ZpZr4zeqYWQsx7marrsmUDHOYxh+Ggq6avmLbxAkcJ2yUNYxzwchXnIUh?=
 =?us-ascii?Q?41NXoxKyvvuYfEiT8+WK+rFObuojqmyA+LmLCQ16DHnWSrP5VRqBrFQU1CQa?=
 =?us-ascii?Q?C0x1RJ7jn8dS3x+Puz7qnHF4Abj4QYvf+JVfjyPsQJJt2LaFuz1glPmebvmQ?=
 =?us-ascii?Q?a9GE3u7ZoRrmK86QWppeyup3YEQOKcZoqU0u/qcut7X1tXIZAB99mJkxblbN?=
 =?us-ascii?Q?BZ6lMhplHoHBZjy/hcHzDXcjfM9zJgValxwSg5ry+oznE352V8A602ZPG2et?=
 =?us-ascii?Q?0F0JUEONNncwkRm/YY3P9zyHpgakCZeA09REkKv6th0FGcKwbOT2c4wTrd1K?=
 =?us-ascii?Q?GnWQWSe1oKGOpRZHCYPro8Y2lIIGz4/oOkJMx6w2KWZwJ1AJtGKvmDNlyTyA?=
 =?us-ascii?Q?A5XARUT3BU1OZjP8M5Nj4+nSHaKvYu7viTwIPmXOxPtSRPySw+4PUEOn0bmT?=
 =?us-ascii?Q?bqqvcXpo74jFnftrkZnLaOVEHRBPfRSt4dARcD24VC/CTL/oXt5Y3sJRnoZS?=
 =?us-ascii?Q?OPY7MnKeSSHh9mnxS1t7i9GviurdLVbf9MYBP6eHbKHbLKEv6MhIR2ZH6VV8?=
 =?us-ascii?Q?mWFmcJmapwk9flAW6WmCZtXJR35hleKgWzIvCI139e3vmbrPANbuxsi0gtgm?=
 =?us-ascii?Q?ZV+fw5Z+TsC5Xkk8t4KiP8VdYIpQbTrjcud4wNPXIH9qtmQNKEuee4LjtRPe?=
 =?us-ascii?Q?U3hJ/v8Pw88cnS9oBWIvOGg7iyGsrxwiYXtRUZZOJ0hZDYAgQBWCeoyAE1Up?=
 =?us-ascii?Q?dpTgpek8FOhTGGq1SDao+9YLOM5NwY/W1NoQ6JDD67aHcoBRiyvJ5sSOfUB9?=
 =?us-ascii?Q?KVpR49yNtvgpyq4pA/tS1cZoV8xxRl8sRBjvQlOEUT6Xh/U+nxiuQuwolee5?=
 =?us-ascii?Q?zXs1w8t9IZAjW7o0UzLAXsKGXL0lz1qlzbNm4M+U5miztPWRCJzkoQY8DdGU?=
 =?us-ascii?Q?GDnPHGKzuRgRnUYUn7AuKaN7Fko58NVMnipS8nQB2zH1TD6WguN6Mw03yl0S?=
 =?us-ascii?Q?/KZ995qwZE07omEJeUuHNENXA6n0JW3TAwOuoOwRW3CKkBydK0iFChRkSis8?=
 =?us-ascii?Q?uH773j/5sunHSTUSENIbj8WIo6NC1d0NOtPA9I1mQzaUMOH+BeBbZNkV4vwu?=
 =?us-ascii?Q?FpKZehjfc8CRN3mQx3EWYEvvaTxcAAqUMPFHP/4HEGRmoPhvACWrg8xenD16?=
 =?us-ascii?Q?QCMNDHU+FEM+ipVMsvoQJrXJ+B35QKse7SY+z/lLZxNwGPEbgCWWkTxkVLhN?=
 =?us-ascii?Q?8GCfNBEB3BGB36MXEmjL3UEH0tkF3MD+LfYaO5wyxWT9tlPHIX53hrcHgmTQ?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156025e7-855e-484d-3cfc-08dd0550310c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:33:33.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxD8L2t/YCcXKE6MMm94y/kJ2xzKCXXI3ek5Oui1L2WRRdY4T7iED5mnXp3O15nIWXANKyqZA3XPoRIYscver2koWkY8cTbKyV2/zjwhTlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6221
X-Proofpoint-GUID: KcznMQ_GAXsE8Yl6b0MYkYJW91Ek4IuG
X-Authority-Analysis: v=2.4 cv=Ke6AshYD c=1 sm=1 tr=0 ts=6737075f cx=c_pps a=mEL9+5ifO1KfKUNINL6WGg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=t7CeM3EgAAAA:8
 a=HH5vDtPzAAAA:8 a=KP9VF9y3AAAA:8 a=zd2uoN0lAAAA:8 a=KKAkSRfTAAAA:8 a=T-_msMMreK8bA51VSmQA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=4w0yzETBtB_scsjRCo-X:22 a=cvBusfyB2V15izCimMoJ:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: KcznMQ_GAXsE8Yl6b0MYkYJW91Ek4IuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411150072

From: Xiangyu Chen <xiangyu.chen@windriver.com>

[ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[Xiangyu:  Bp to fix CVE: CVE-2024-50009 resolved minor conflicts]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/cpufreq/amd-pstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8c16d67b98bf..0fc5495c935a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -579,9 +579,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	unsigned long max_perf, min_perf, des_perf,
 		      cap_perf, lowest_nonlinear_perf, max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
 	unsigned int target_freq;
 
+	if (!policy)
+		return;
+
+	cpudata = policy->driver_data;
+
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
 
-- 
2.43.0


