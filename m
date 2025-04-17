Return-Path: <stable+bounces-133125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE86A91E43
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433B45A77DC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CFB24C07C;
	Thu, 17 Apr 2025 13:41:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1024C06F
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897265; cv=fail; b=EqADZZOwUQd02MiIEsb8gimjNKdcAhOqkr5f2tKWcqSKqcBbdNq0JIWH7Se9ymVBPqvWOIBcfXxG7+LXySmXZdp5mBZoSR0afpp5v5l4GYQvD7EA3JcSLg8MYLfjWgWKa0KiHcmaFVNaRovo0TwFaWGN55o2vbf9S1qV4jn+G+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897265; c=relaxed/simple;
	bh=xhG6/CbA1Si8UG1+W35TGxdzI8ykKtRFLsTJ6hukq3s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IumROWYNGV7/sRlr8ZeIKmaU0SQydmqAk3RuhB12nbAOGkAr1Edpokl77BfoDQh0r2gPGS8FLVpR9aqxbcI4IVbMcL1xl6JSppMqq7BxeWQOjuzig7p5GyAxZAiHXcroTHB0bEnyHTJz1fD+GlXoEoDo3d1fm3DzaOoDlvTjr58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5SikF018541;
	Thu, 17 Apr 2025 13:40:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1pbcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:40:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlOAbKnWqft+yN5JNtuYsoNdcNrjGPtbX7oqc7wSTakq1STo5kHNvILUr+2VuYrNupjpncuXUleYqu8KMTy7pbyvnTDeFuzyukCnxkvI6h1A1UA4gN22N8O+847HmliSsg6Gry/CD9aUTe8zLL76TNT4lRXy+ci3ivKmBWLAO69SNrkbmtEDsW+ocDM5/94JDslV5Wi6QL6RnzEXp0tyXIkULCspZ4P0Ip4Aw+8JvpBJSE248jP6dJ9SdnR0pPc5Brrt7gfNwGDgzIGDWjAWPhoYSfP/ZFzR2YdQcECoB9NOQ2+8qBZA9QyVAKXPxUn6CrHQNCMek1awNrhrAMSzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISPpwc1FMD9C2Gv69vPOcv9RPRGH7km5DvHDzU9ykxk=;
 b=BmbmGHsxoywpnvSv4XXtCV77Mc3/+DDOSktBz46i6Wf43SfVhZ/iu0yIDRtDPVNRA/1XRx9VdwUzo6cV9CO9N5Mvflg7gOnK2dWl9XI6gsyOj3ES/VL9/OgGDH9cKexh9rEyJ2wVFLsU1tT6FAXIhrah5nIUUIQs7sgg0fdxifh6CUrIHXpapohu1SP5Maomtym2TzyBnqAIpmNtq6jSWCn36a3QEFSP0ur55fpF/kLxED+3w+G4BiwfcRRiTQdvGCmIH4/WZUj8dhepUceZbJCYZgC/XVSAoXU2/hEwFVED69u2ZnCS6itJ6K9LCoHaJkFVDZkpYcU/7DlHixheZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by DM4PR11MB5246.namprd11.prod.outlook.com (2603:10b6:5:389::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 13:40:57 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 13:40:57 +0000
From: He Zhe <zhe.he@windriver.com>
To: cve@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH vulns v2] scripts: Correct kernel tree variable name
Date: Thu, 17 Apr 2025 21:40:41 +0800
Message-Id: <20250417134041.376134-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|DM4PR11MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 31902f90-947c-40a8-9722-08dd7db57b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?idci5YcvW6StgvfajxfoasQYoWUVpgEIL0RVFEddRK3mCQiWYtyNrmfTU+9p?=
 =?us-ascii?Q?HFUvUHGcKiX/4/W73CWopwaa+BLADD8JLH0t8uMBLc2bhtztFdiXkqqlqLnh?=
 =?us-ascii?Q?pDg9t5kailq6ABKO9Sq9m0rpg9gKaQLshUDg9V6zr+nOoi24yQ8AgtyB//Tl?=
 =?us-ascii?Q?9swwueCbhEhvEmO4kdXaaZ1eTKyNY/5F2/v46jDmE+6CrC7jMHQSZpwVAtER?=
 =?us-ascii?Q?PaVvgy28tI7s6EJF1g44l5GpSeQRl3Z/Fw50bW0WSHkmt6eZR7ExLwlJygcK?=
 =?us-ascii?Q?BZxYoVR2I9lBkYTsmhbynKsAJ+q4kovZej1YCDeUMzRLjnyq2yLfOmfVyzdx?=
 =?us-ascii?Q?9Ox92Z4oIWrLgbfdHenj6qtdFClIDan7dZypv7oWHHE4Dn9arVk645vWfFpT?=
 =?us-ascii?Q?HVAxfi1wBSrWnV4IMLivAzymYnAk0Csb8BnXwnmIqWEppePkUPdKOgLqES/r?=
 =?us-ascii?Q?UZyhLoxFn8iazkhZOoVhnf0/H5ULdbRPev+kn0rQvEqKHNFGk8hdTD4jb8Tq?=
 =?us-ascii?Q?HYiFT1hdpmkh3eKuPLscoJTH30FlKaFvWBuI1jMHY7uYvRSUYECXCdeXJqyf?=
 =?us-ascii?Q?ONElLl0CePXnlmyEvg+YLXpb2iSoNQccm94iDIee8HaQI3tCI+UveI2QMJUg?=
 =?us-ascii?Q?RgqonFHaRNeKaIOQeqT2z7gwxDaf8GZZk3LBW/TPoK2IgFrOPGAHmkTxJ8Yc?=
 =?us-ascii?Q?J7rAnF/nC3GSUudhWiIQj8KdOuhUmt6QAPAT8P3Vq5KlTDzzPNRRzdZXKNT5?=
 =?us-ascii?Q?/42AasomRctg/UdFcnElyhHDbvUgX7TONcDCYCUOZf3WvMf4vYgGGPlx5i2T?=
 =?us-ascii?Q?RbXaVLWBE1TMMS7Crd3e7YWR1JiaUaASwKw9SUGYG94SwZUnKQVhfPZlcU65?=
 =?us-ascii?Q?k/5xwtkjOj7b29DAogkAeTHUlTWOZ73Od7U9tV9YNBWWHqPR5QgJz47sGcIA?=
 =?us-ascii?Q?154i6oSPA052Amdz6dZzRUdjeggDVahYNnarq0M/z/LW0o77430EioWZT/lo?=
 =?us-ascii?Q?wIt6Y/ascqIb418lpI+rTVTVDii/WZdChVb3fum3NWkj4KsqSFkyBegQsZHm?=
 =?us-ascii?Q?h731exhKR2zPfyBAkCAOtu0Ut+3eb2WK2yDsjqBjbkVIWqdqdc7873RgDd1b?=
 =?us-ascii?Q?ZDdWXEhA7AfOWw1xMdwPmoQAeaTHjnH5PVIpWdzIOsB4qCcYUk9xH8Ojeirw?=
 =?us-ascii?Q?4cl3jY6ckx5zL3wKCn6JcKXVJVSfyGSgIChmgZ5nYFKH1WF22iSfBgEZCsF9?=
 =?us-ascii?Q?RsTM1ljBzgKe/eQkZE6E+T4ONwH3aizPojNvkFnxAxbCt2OYThl0tgqTZsKs?=
 =?us-ascii?Q?vSYAVHEM1kwwkE9kaf3gAC+B2A2mdKfpCMIKoOnn1+pnnE0vLPXRCR8Gw+EP?=
 =?us-ascii?Q?Q8JeKF9yshoB2eBhn+0Gw/N4b5q/kmCMJ31IuixY7y/v2dQ+Tl9vrHO5YmJN?=
 =?us-ascii?Q?OlK4PtcIx1y+KEQoqKBg1TnwizwJxMR6P1V8UnwA/UIkXkjBHwvmvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OdG3YnWGaNv3WcyBtJNBXltlHeF31cIB1bMxjPc/eSYlJyJq7fTwq12ZhVRA?=
 =?us-ascii?Q?nlumDWjg3GDnRJvvb/EeT1yeAitZdbf+Zd0TvcBBxHTzM8IjGHBmqkrFyqO5?=
 =?us-ascii?Q?kmswhabzqgUr9/7jABVdq6a6O2BpNGr4Ev8CKOQe8/3bx06rRvQ8yzQXVNSW?=
 =?us-ascii?Q?oqr6JTAhmVx0OY/FVKZy1gL6quRhuAKcZPU1ciCbbK2GFKnYkd3KwjwvGHfg?=
 =?us-ascii?Q?AnC3jr6HBv9QZWpk3/tZxcV/yMWTWQeyqJyykstM1bv6tncUlpYEIkOnNI9c?=
 =?us-ascii?Q?6f4vEZQZMLJ8zHHAjkgdpbQ6L6zJD30V2dyafWqTRZOYWpaQbtdLkVCM8Fr4?=
 =?us-ascii?Q?emKbyUErb71cjJkYpmM+j/5KZNjrpW39I4K/zdAIZeDX0cOizTIM52b/Rsrl?=
 =?us-ascii?Q?mlHYNFc2HG6xDLG5Oqad/ZtSlvWa0dJdlsso1sB5AFbY/WCRIMDJrAyaQ6yN?=
 =?us-ascii?Q?9OGKEq+fc77TZ4G3sCPbupeKT99pmPBA/XVrUBOXvckg36yXxtO/YCQ0AfPi?=
 =?us-ascii?Q?lp+UeJbufEuA76IZoiOekj+tayE9Qq/aZ9ekdxdYwCgcBxwx4gNmipx7ulJj?=
 =?us-ascii?Q?PXxyVwOxn3vLrysDO5829/oaDKb+2Y/+6UKd05LRMFellOL4ACimiqjs5R14?=
 =?us-ascii?Q?M8KrplWuKQYAIlTSLqbFFcZdAaLOKGVtyOt2o5gJh/AYZUtHX9gT+Sy0TJ5j?=
 =?us-ascii?Q?/M3q4Ub0MAfQ0pWrR1uXaonuv3m7OyPpd7HwKOt+mC7ZeUJ0gXx4iqqTk5tV?=
 =?us-ascii?Q?gG6N7K8zemgXm9yU189W+Qcwhp6UAFEz8Ue9drWpCkCnaS1PZtOAH6zpSogY?=
 =?us-ascii?Q?ROUf4tezAPLkwbmOaeMzMNHd3seYWS6ur6nZZuq9Jr9XjJRF1LEWJgN82IUf?=
 =?us-ascii?Q?M1s6FE86EB8lnScmRYMfHhcy2xJ4jqOL/XHWp6PKaVazcPvFyDl/Wc/gfShy?=
 =?us-ascii?Q?Ql5HfUCreWy8dMReUnW5uuU+BtZxwsfXL6THRrnAMpVJmzi5YZq05gm5VByu?=
 =?us-ascii?Q?LtA5ZxRTjPLfRpoPw6rXmWtpOl+WJyoHArR6Mg9cr/OdApBvZHxUAwtLEPuC?=
 =?us-ascii?Q?i1HaIYvfw+jd23tVrFpHnMKndNI5aHBLnasKewp3JQzepiKza3suf7DRjBcH?=
 =?us-ascii?Q?o1VzENipelG/T9V04kCvd51uy0kXaNZc1iGr1wt0xx1/wVUjefUcVVyCTp+l?=
 =?us-ascii?Q?qlHpb8dahdNUSXaUq2aqJk4Xrzl1aNRN7SLUMqr7EA5iw2arpcjMmHEFBlfv?=
 =?us-ascii?Q?cboY1Xdfp6lpx4uw1bE3mYWlzR05T8bRn4wWFAwMGsqBRI6ttLDS8sznmd7c?=
 =?us-ascii?Q?2Id1pVs+8SSg4jBzg6+TFDBcUtbkFpblnppqr6rxwGu1Pm8SffnRdHQEZkk7?=
 =?us-ascii?Q?m7pvDRB4mE45Wdz41VjGLv9eNm04mnzQ5mWTEx/tM+iYky9++qTJU3zu4cEb?=
 =?us-ascii?Q?5QI56CmjcnEc9pxmao2B2x3o9GXQzTsZDD/ic89F4t9PqE+fuveUaZNxZF5R?=
 =?us-ascii?Q?5E5y4m6RLYNFVVXiJgWbUxZ56v3Uuc7AfsRhz9moAwhvJvWLuGiYE71yd+Bz?=
 =?us-ascii?Q?lSdDC2VZufYQi6TztFdkYdyylREgjLQDHsU+Cuev?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31902f90-947c-40a8-9722-08dd7db57b52
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:40:57.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuoeagjMowXf4Xer1ePoUdrOH2GPFSTKRtXSXMagboPxKIf+XPR35c8YaQJW3hy+8xStkXGeiCsCA3CSgNKMfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5246
X-Proofpoint-ORIG-GUID: nAxScW4XgQsRRgUoSgA65ZcUdbG6ySui
X-Proofpoint-GUID: nAxScW4XgQsRRgUoSgA65ZcUdbG6ySui
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=680104eb cx=c_pps a=DnJuoDeutjy/DnsrngHDCQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=t7CeM3EgAAAA:8 a=c2xvYnwsvFRH1byQ0s8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=805 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170102

To give corrent hint if users haven't set up stable tree directory.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v2: Add commit log

 scripts/cve_create       | 2 +-
 scripts/cve_create_batch | 2 +-
 scripts/cve_search       | 2 +-
 scripts/cvelistV5_check  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/cve_create b/scripts/cve_create
index dee842d43..eed7b45b2 100755
--- a/scripts/cve_create
+++ b/scripts/cve_create
@@ -24,7 +24,7 @@
 KERNEL_TREE=${CVEKERNELTREE}
 
 if [ ! -d ${KERNEL_TREE} ]; then
-       echo "CVEERNELTREE needs setting to the stable repo directory"
+       echo "CVEKERNELTREE needs setting to the stable repo directory"
        echo "Either manually export it or add it to your .bashrc/.zshrc et al."
        echo "See HOWTO in the root of this repo"
        exit 1
diff --git a/scripts/cve_create_batch b/scripts/cve_create_batch
index 00c7e89f8..28e98b836 100755
--- a/scripts/cve_create_batch
+++ b/scripts/cve_create_batch
@@ -27,7 +27,7 @@ fi
 
 KERNEL_TREE=${CVEKERNELTREE}
 if [ ! -d ${KERNEL_TREE} ]; then
-       echo "CVEERNELTREE needs setting to the stable repo directory"
+       echo "CVEKERNELTREE needs setting to the stable repo directory"
        echo "Either manually export it or add it to your .bashrc/.zshrc et al."
        echo "See HOWTO in the root of this repo"
        exit 1
diff --git a/scripts/cve_search b/scripts/cve_search
index cd90a1599..cb0730c63 100755
--- a/scripts/cve_search
+++ b/scripts/cve_search
@@ -18,7 +18,7 @@
 KERNEL_TREE=${CVEKERNELTREE}
 
 if [ ! -d "${KERNEL_TREE}" ]; then
-       echo "CVEERNELTREE needs setting to the stable repo directory"
+       echo "CVEKERNELTREE needs setting to the stable repo directory"
        echo "Either manually export it or add it to your .bashrc/.zshrc et al."
        echo "See HOWTO in the root of this repo"
        exit 1
diff --git a/scripts/cvelistV5_check b/scripts/cvelistV5_check
index 5eb41cea1..8a3bd71d3 100755
--- a/scripts/cvelistV5_check
+++ b/scripts/cvelistV5_check
@@ -45,7 +45,7 @@ fi
 
 KERNEL_TREE=${CVEKERNELTREE}
 if [ ! -d ${KERNEL_TREE} ]; then
-	echo "CVEERNELTREE needs setting to the stable repo directory"
+	echo "CVEKERNELTREE needs setting to the stable repo directory"
 	echo "Either manually export it or add it to your .bashrc/.zshrc et al."
 	echo "See HOWTO in the root of this repo"
 	exit 1
-- 
2.34.1


