Return-Path: <stable+bounces-100515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32EF9EC293
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 03:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E273162C77
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D51FCF57;
	Wed, 11 Dec 2024 02:55:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470621FC7F5
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885716; cv=fail; b=diW21a27k+GFMBnhTbpllvyOi95weagjOHtoAVi0ZXjc7n0zqa8HcDxZa93JnJ1Vbrbp63bJdBeeqfH1QCJGw3hr2qVUObDZTwUGhhcaMQKdH2wpkfSwAkHc9rg4jOaHGB4Cz9nhAXNkfRDVI5MxEGakRq6qXaNgDab/qeFZGSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885716; c=relaxed/simple;
	bh=26qhsQRJ1oMK2GRXAHOQ8w0X7SJPZ0eV7I93G0qXqSM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ErkKGwmDRoq7c8L/2moT74xDc2U9IZl8qzi0EXnkUsDxBfMCFcXZkVdP2/7GZDs7rCyq7UtBXz/yroku+sk0Qm/dTvAwAgTw2zyV40kCdnAq/JbhWD3HoGcXjvZmP4RdDM0to/QS9Tha1qFbgXDUUmWip9TPw35xFFqlK7kVX5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB2H0RW009334
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 02:55:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3knrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 02:55:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7IAHVD3LT/q1k1ZZzdv609zuNo5adjInQ1x233YB/nc1JKW0gwsKfDivAlqLzwm50gIZV5TM6gP3iLCMt4gpdIpoEtgfwSZmLBfmeWZvz0TolY+4fEgOoEpm8mmzke8YeEA+dyITmZSOZFsqQ47bAsc2AtXKW7gJvqOeKFAINELOyIOOsxkxxR1Kg4wpo+OZaGu2iilrfIzfmaxNEG3uJSbAPAH3HdTvX5YyaBiNYV8jDvnyY8gHWmwnmYiHep9k9nG2AjSb7wbADQixJcelt0HaEfjb/pTKxs2rWTikhte8cYUZPA65aTBBdYdO1hNkn1OV74PF8pyFI5JigoUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTn37iAvEn7fcKzCTDSgkM7iS6BogedQWHqeaIT0Knw=;
 b=tIh6ds28N33fKMAoaXO25HbjaXG1lgbQ9w6syf1T4OIPz9zhZ/ydpZGvNKBGDvKUjClMrS0ehi+q7XFDAubWyVPm5lRcZmy0E1vtjOsiPgZeZxP6VMU+RKG+53DZLgvf1qN6SGRP8LtMqd/ZRH10FgSuxYtiT3o3XAX6UHeA/9r8tPfz6RwM8Lg57zfUFZCX/N/i8kVYuX9Ev/GPsUogcX7tcRPxnTtkpY7m+4v7jEqlAJuBcf0Dm8OOwR4dgz3zmzMliv9dRdfdwnW0RuCaQoc3Yl01J691e5zPZnHgXr/R2NsV74Jgd5NMra0V4h/1A+9GPGEBan9zPL+0Xt79Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Wed, 11 Dec
 2024 02:55:07 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 02:55:06 +0000
From: libo.chen.cn@windriver.com
To: stable@vger.kernel.org
Subject: [PATCH] crypto: hisilicon/qm - inject error before stopping queue
Date: Wed, 11 Dec 2024 10:54:42 +0800
Message-Id: <20241211025442.3926281-1-libo.chen.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::7) To BN9PR11MB5354.namprd11.prod.outlook.com
 (2603:10b6:408:11b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5354:EE_|DM4PR11MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: c893608b-59da-46ee-8740-08dd198f3802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B7SoPzylAyqVHElGctiIA+4U8XPGwlO9E1Lv+n9EDnCXiVey7088S5npBYVr?=
 =?us-ascii?Q?2fKNu/bDUhSmt+SjFMonbli1kQZd3RItw6IEUoEQjl8sSbRWo+tAxfYUjWjL?=
 =?us-ascii?Q?Yqk0lOTa93ChYZCI/Ag312f0Yrbkr8d3eYN5VpgyRqNyIWKv2RwQhqKdbYd9?=
 =?us-ascii?Q?VVipfX9o5jrG6hww+nfu2zQ2hAQmH2Q2vNTpt43NFIy9fg0Jq1b94CpUgMEc?=
 =?us-ascii?Q?G7zVqlLhmk+HShIeZmZGGjPWuiPBjFIiANtf2qO4W5CqE3sOH5eVJzX3dEmS?=
 =?us-ascii?Q?4DktFcojU0d6Woe7WMZ9ZWNDRcvvpb6xb+sO6FHotTu/0/lzsf5iqqnHKi+n?=
 =?us-ascii?Q?pK6k4USLUBTzkbG7KFLUul1Lcxh98FI6ZVx41ps/SCqjCIjlGe6slWFHb2IP?=
 =?us-ascii?Q?OsFj7yQtqoHwuHkKbJTbicwGBXB56TLBLUfLp36F+x5goWove1k4NrSG2Ahv?=
 =?us-ascii?Q?ROA41UgOpp0GjorqD003+aZ4c7ahQX4LrrGpyp43ONebyHxgNzxPnKhHZ/IO?=
 =?us-ascii?Q?noHeFfLlH6L1en3kHck5H3vKD7l0gQv43K68/ZSYBvlFUHvVY7YeDWUqb7hb?=
 =?us-ascii?Q?2l1gKT1Yw+xz+BVTeTTRICMBC98x7x2liqTMNHKSxRdkqk12tivaSnftoyrJ?=
 =?us-ascii?Q?XOR4HqaEhYVG6eqt2O5tCK9iHTJnCbaBXgKTiCHoTObSV6avNKQeh/6xyBKI?=
 =?us-ascii?Q?xwNQw4bRFkZZrMXonzWJ0MT6hg8Bi1wxvo+bCujFrum3C2HlhELAVE8sQ6dW?=
 =?us-ascii?Q?LDVyxii5WbwIwGjg3MmYDEwiK8TbYH2D/MXbVc2Yom9wF14qTXfafBwtgg4B?=
 =?us-ascii?Q?JDEKDimxvg1vjKGCkt/Ah7VTOFTqGjnDeK8BTetx92GxEfdnVMFhTG935RpZ?=
 =?us-ascii?Q?pmbIbhgAHrvSZgWMVLg2FFmOPO+koG3AkHnHIIrmD513bRdyzF98s1htxaxF?=
 =?us-ascii?Q?RXoTJhO0YkPbBnTylB1xUNsrMiTdih86x5ewUBIKdfQKtLFF7Cttyau1mWNK?=
 =?us-ascii?Q?Yk6vh5e/PJKwH6nhOEshtKQmD1X8nmer+s70bHBXqdCGgg2h5zozfOYN+uG4?=
 =?us-ascii?Q?ofSS8T0qwB7H1xiRnGd8tB/XnQkKmKZHCq5Wcz+fpZqxPkSUw/+bp9IVfutu?=
 =?us-ascii?Q?Dr9/WFDS1iiNMTsXb7pOuAan4BvTRH84KpLTeedNN9ZKfdrk6jJt5d4Kaa2y?=
 =?us-ascii?Q?2No7qev6jcmiJGDN8ahpmaZ816q2tu60SCiwmODfi09FPeSK0lESpPJZqdtV?=
 =?us-ascii?Q?3IeeTT00jMwBKnF+Bt+vNEmzI1PZVcNdJ5pChEmLUNYpwwGVn/Zp5gz27wjQ?=
 =?us-ascii?Q?f36Xl6nndI5uGgj6zhCU7G6JwiKOm+PuhlAC+S4sSJLQ4fk7lyGAfeEDzdI9?=
 =?us-ascii?Q?COGLvakuMFeck1ZvCy1QsCRoIntcGIMMRL51iF91vOxcF0O0Dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cmzo+B2UWKp7T1l6kAC/3zet7k8PnJoHjhM8LYpmEo1z6i7IhatTCJsNqrSY?=
 =?us-ascii?Q?5NP8FNvsDoOSxtGuBHXSE3OHDD1b2aWGj+Dkq4rtgN3AHl3/zQwTt98n1GBF?=
 =?us-ascii?Q?0RjwUaEtEvtAaUmTapIGdPunqWlr5h9kJpgowTSUZ0FjjkFr/WFdkFVL7r7z?=
 =?us-ascii?Q?BXIRP8iqjQTwSlZTgVxWZ5SEjW5Oce2AEusJU0aaDLOtLIkTm5n5T59lVhr3?=
 =?us-ascii?Q?0zMh1SM4DYVlaPxnO51U+zecMF9qqDaa4NndwdKVEYnNIKUcraRw+Twg+Fbv?=
 =?us-ascii?Q?Z34tpI7aUOxG5Zvf3UdU7KSsgWXGRm1D+xnUiZsuW0XeGbzNqpXlAW0VBmN4?=
 =?us-ascii?Q?EbON+P5G7nKzZSq8vE7SyI6oc2dx8H+1FCv9degf8Jmx8QOeMYtVEA4vuwfF?=
 =?us-ascii?Q?tCnYnK3kim/A0Qrailb9FCb/+ZjiWDWxMXVMd1FLSRgSP0pRLm9ic5KFcSC/?=
 =?us-ascii?Q?ozBfOkg/BZPKp3cR+5lzcSLYFkpG8ZLO1e1kjviQ0uHbV1Y7OYPnl1zqxxKx?=
 =?us-ascii?Q?ABL98wmLKtYLHkO5rEJEzqBexW686NMP4QUh8pxp9wxdXY433M2OZ7KHId3J?=
 =?us-ascii?Q?J2w9PKGwb3tGUWUOQRy9/GVaf/AQk/oQsvEO8hMU4SAQoRzVHhfg7Abk/tck?=
 =?us-ascii?Q?de64YzHi0Ue5+kiJLiXgvazYo+KyVhMHg9yfpOrx602LdaazkHpMVcNNeGEu?=
 =?us-ascii?Q?CinKTDoGhFXLrAmyYTeW1vbxfL/Q+Y89CLtQZUSrzBxJ+NaslOWi1CdU/rQY?=
 =?us-ascii?Q?6ZugSnP3x/3Z2i+N3LM+e8zE+UxjzfKY5Em0YMaaE02lqX8az+YM95/Czdhh?=
 =?us-ascii?Q?kOB6eoP5u9T4Nq6kL4nLrCDcIYd7CqFHLheIW0ssVrHR2ihLYDKK3S7A0cX+?=
 =?us-ascii?Q?4NobHgFbZoZMuz7aymHSj6cah0/z5kRfEhxZHCI4VDofZlv8DJKQ0vghPvsb?=
 =?us-ascii?Q?F+Qh7075NabDPPtcRO9vCpXGbp1pv/9QUzY0HMKrNCBn7J65yfnxD2w0QEP5?=
 =?us-ascii?Q?LZplYh+8Rs9Jje7M/sM6Vv/9aF0fTBFtPX/MgkZI5wNRzV8DB3cXVti+WBSy?=
 =?us-ascii?Q?M+Kpz6WukgYS7+J6O4vEpPvJ67Tn+nMJT83hIajDvCr+zoSwNKIGCQl6NPsU?=
 =?us-ascii?Q?KafoZctEQzAHZza/aGlgVti8Md5XcTx4gyb74f73tNXfBWqbRJTUe6R1x3+7?=
 =?us-ascii?Q?P34LHn9YXCc5V6wLK7yngjiMj8h+PQkUyma/84CJ60RrWkdBIwEEavdubNAp?=
 =?us-ascii?Q?c0ZAs418aqLR+DKydbWHjdd7rxha6T1lv5rifz/Z99NZWtbsvqnJ38y9R4Ga?=
 =?us-ascii?Q?sQ3o27UDI2ln51N0pUVJ8hBrEA/8XXZ++3fz3C12iFm+5DEqLDpmUkWi/MTF?=
 =?us-ascii?Q?4CXjcXNI5e9HTJ+Be4wm1cvk+HaEVCIiD/XmdzLXbDr2bRCYPypl2TMnLTTZ?=
 =?us-ascii?Q?NmkscpDgG2qyzCs+x++pLHW9/f/IpRQ09rCLqgsyVuwFUhoVc1rz2AZae/ol?=
 =?us-ascii?Q?rViDx0vbX/tGwlL5erMrWK5ZBR4AW1XXjeyxvb3eQeRQjqIS55tNCf/MDHKY?=
 =?us-ascii?Q?BsGKR5+YO7tQtx2t/9LiWc6Rpa8FPwge/sRvfPaQIMLAfXrOUQ6pY/Sp1hka?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c893608b-59da-46ee-8740-08dd198f3802
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 02:55:06.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCfVlAeVLPh4I+aU1agg0WhdT+RyhdaeaNf+D3LuuA1pu24IXZNXzrXOQIMJGr3KEbO5ANM3AXnzK9+Er3/5Zs/qr0HPLU/HgRaNva5VqYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-Proofpoint-GUID: tqNvPUeoTEJhApSrHOgDuR1a14fqjpy6
X-Proofpoint-ORIG-GUID: tqNvPUeoTEJhApSrHOgDuR1a14fqjpy6
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=6758ff10 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=i0EeH86SAAAA:8
 a=FNyBlpCuAAAA:8 a=t7CeM3EgAAAA:8 a=mzVGTZs34JFsiwU4K9gA:9 a=RlW-AWeGUCXs_Nkyno-6:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_02,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110022

From: Weili Qian <qianweili@huawei.com>

[ Upstream commit b04f06fc0243600665b3b50253869533b7938468 ]

The master ooo cannot be completely closed when the
accelerator core reports memory error. Therefore, the driver
needs to inject the qm error to close the master ooo. Currently,
the qm error is injected after stopping queue, memory may be
released immediately after stopping queue, causing the device to
access the released memory. Therefore, error is injected to close master
ooo before stopping queue to ensure that the device does not access
the released memory.

Fixes: 6c6dd5802c2d ("crypto: hisilicon/qm - add controller reset interface")
Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
---
 drivers/crypto/hisilicon/qm.c | 51 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index fd89918abd19..58e995db3783 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4638,6 +4638,28 @@ static int qm_set_vf_mse(struct hisi_qm *qm, bool set)
 	return -ETIMEDOUT;
 }
 
+static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
+{
+	u32 nfe_enb = 0;
+
+	/* Kunpeng930 hardware automatically close master ooo when NFE occurs */
+	if (qm->ver >= QM_HW_V3)
+		return;
+
+	if (!qm->err_status.is_dev_ecc_mbit &&
+	    qm->err_status.is_qm_ecc_mbit &&
+	    qm->err_ini->close_axi_master_ooo) {
+		qm->err_ini->close_axi_master_ooo(qm);
+	} else if (qm->err_status.is_dev_ecc_mbit &&
+		   !qm->err_status.is_qm_ecc_mbit &&
+		   !qm->err_ini->close_axi_master_ooo) {
+		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
+		       qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SET);
+	}
+}
+
 static int qm_vf_reset_prepare(struct hisi_qm *qm,
 			       enum qm_stop_reason stop_reason)
 {
@@ -4742,6 +4764,8 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 		return ret;
 	}
 
+	qm_dev_ecc_mbit_handle(qm);
+
 	/* PF obtains the information of VF by querying the register. */
 	qm_cmd_uninit(qm);
 
@@ -4766,31 +4790,6 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 	return 0;
 }
 
-static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
-{
-	u32 nfe_enb = 0;
-
-	/* Kunpeng930 hardware automatically close master ooo when NFE occurs */
-	if (qm->ver >= QM_HW_V3)
-		return;
-
-	if (!qm->err_status.is_dev_ecc_mbit &&
-	    qm->err_status.is_qm_ecc_mbit &&
-	    qm->err_ini->close_axi_master_ooo) {
-
-		qm->err_ini->close_axi_master_ooo(qm);
-
-	} else if (qm->err_status.is_dev_ecc_mbit &&
-		   !qm->err_status.is_qm_ecc_mbit &&
-		   !qm->err_ini->close_axi_master_ooo) {
-
-		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
-		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
-		       qm->io_base + QM_RAS_NFE_ENABLE);
-		writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SET);
-	}
-}
-
 static int qm_soft_reset(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -4816,8 +4815,6 @@ static int qm_soft_reset(struct hisi_qm *qm)
 		return ret;
 	}
 
-	qm_dev_ecc_mbit_handle(qm);
-
 	/* OOO register set and check */
 	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
 	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
-- 
2.25.1


