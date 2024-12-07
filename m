Return-Path: <stable+bounces-100045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F99E7FB3
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 12:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB3F165DA8
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8385140E2E;
	Sat,  7 Dec 2024 11:20:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45C45005
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733570450; cv=fail; b=FpUCqkJHsSjmStls4VS5rVefgtOycVhaKdjZRaotC/VC18HxycM6nDyjNIgq0EWfEuG/AfNIwPm+SSqYdEinSGYMHm0a4om2rAra9GVV+zR2qqDEgAPiVrJ788wM9Ioov6AINBvbLKeLm/Ub4f9Ujhm9YNPJ7hOJeY2YtY0oPp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733570450; c=relaxed/simple;
	bh=dmEd3DDf4orExqBRvRq2beJ+B79jbJuW4J1cwEmm/jE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o/F80Dv4A1mjzvzvIyOS+0MkShBwBQZ60F1L64k3zeVSv+fWMNfu9/howdTjCEGfZ5qfO08W1zJtPh40EdY4tR88nLJRdaLtGfSxREP36MMZu4i7XkJP6tNNiPkvR5EZU6I/yXRI0OHd13ahtYOcCHryqERDpvukFQ0/DKrXKPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B7BF2ck006394;
	Sat, 7 Dec 2024 03:20:41 -0800
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cjh6037v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Dec 2024 03:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7WhlVaWsa4DJLtb8CApT9ulzJutAHIC3TayFEYsn6uQhqV9lkL8fig0j/U5rurViuhEwTTrLSfWnRR5cGA2Kq0Rmt/Sh0sSddWNY+1eUJEJO/SUIppM0vxaKTSwvJIajkPybpodRzROL0pCHe4MvjKGy1PZ6o3U//XdsuPz2fs0Ao5d4cRU0H/RsA8ylgyWveITZwfbehr0LzrrFjplsLy97ACHC5hJ4iTgowbjhiS5d/V7+LiKaKQo+eUdTEtYtLVFje3oK1Gayc8sBwIkpF0QcBKZhtK5DffuOPNoa7KVA4gJHRbqdTwco3/d/mtHurXb9Y+5WkF9N/sEDwFmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xh+pxfUcMnD4W6R1PjdmjNGGieNfqrN/ZvueYR0Z8Y=;
 b=xJaemLBJzIdXsuIb0Ib93xYAZ770Jrjiozi55opSpcvRbsibim7zze8+S8cglcrofwhq0/BtYAOVRU8Av+aZURyL5eRnGDO/M5UJzic0t0I4zZ8Xgk7Mbdu4gW2I7t8P70bdE9XHddIcLs1leQIk9JATlcBaIaFv5L6jaYfPrrE6skBKjlYDqW/o5p4ju4OcknQjIVC7W/5dJdQ9+8gBUCIWctkl/l/yk9hey23Xd3p5FJB1MsEIj9UeO3ulrP0m7sY7lvbn/89gZgiNjSwHLe4705Fxgt7l8512fvLlWeKBg9m2eQpdA9tpVxsiyV1YtcfJ8/kws58jXPrUdnjdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY8PR11MB7337.namprd11.prod.outlook.com (2603:10b6:930:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Sat, 7 Dec
 2024 11:20:36 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.017; Sat, 7 Dec 2024
 11:20:35 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, irui.wang@mediatek.com
Subject: [PATCH 6.1 v2] media: mediatek: vcodec: Handle invalid decoder vsi
Date: Sat,  7 Dec 2024 19:20:42 +0800
Message-ID: <20241207112042.748861-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0192.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::18) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY8PR11MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 0081706c-a3b5-410c-b248-08dd16b12b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZf3xyE8kQoX2JTCXwI5H8GDOGiLg04OSmnhqj+qBlsqWFOdDg3lbe3FiFDh?=
 =?us-ascii?Q?he2O20rdz9Jh9M1HIbflGDNuKhqw/6p7iWY+/xytFc3863vbht3Kv7lo1t1x?=
 =?us-ascii?Q?o2A1M0p6HgnHoTSasORV6Db3MlXLTL5UPKlMHPdSYxeYvGj0T8gsaPhQ91RE?=
 =?us-ascii?Q?6UKNd9jkQn6bUyV3ss+QgzjkgkKHzJ4M5/ILD7N1WgpNsqJMYN+uCbHAUoIR?=
 =?us-ascii?Q?zZ2bpuLF5fgss97bSlcDbWh032JPYIyDh8ukYjZv8XOZt0oY9L4wkbJl6fCF?=
 =?us-ascii?Q?A2L6HsgzpHFzqXqeibSQqH4s6QqX7B913d/IVNb9TIMb6625nHyBdV/WUEcB?=
 =?us-ascii?Q?ZXrNtIwkKd1nPcyewvH88GWyJHeALb2vZ7waJUxH7nRVmYgsAyXd1oT6fGDh?=
 =?us-ascii?Q?e5EYUJDwMYlVix2JjECCCBxhEuFcBUh/7UFcXsSJUsvEvMwP5ol7doiXAnJE?=
 =?us-ascii?Q?u5G4ep69mtGweVBt8fCYDRjYzUFcI/gzhF2XxLDIymtWUUdLSd+AMATF7TwO?=
 =?us-ascii?Q?/rtyg8/DVK1g6URDW7HeIVFrGgpR2rG/tfNPWLHnTi7IkMAdtGh652RtEk65?=
 =?us-ascii?Q?/JTU1Qwpaw8NRPZBPJURVEUj4hWHf/R5jBXL0GMvts86nzDJ0LEuZhV+APPn?=
 =?us-ascii?Q?eX9P9blweU312Nc8VWRzsh+f2cyPh9b8D5DMb4qRM4X3CnBnOaHHfRyQ//wk?=
 =?us-ascii?Q?PLsPyTFU7g2frx7fAGeKgL3PiPhV3fguA7t68wmYOrx6Q3BG6hRfoRwfySiR?=
 =?us-ascii?Q?QPC1Wg0OY65BgZtf78aT6upX956IGJNOSeLaM7UYOoWJbCWAuQdIgTSjvHf8?=
 =?us-ascii?Q?WKR+dcGDgJtitHx1DGeaMB5tSVfhPVQ9DUQbZWBo5Ddm7FVXwQkOJ7Wus0u2?=
 =?us-ascii?Q?e6pRWEA8xCStK90CfTAYF2c7ltx64zfL0eoDTHQl3kastXq2BMzhunL0imQ0?=
 =?us-ascii?Q?t2DORKLZ4tPPEn84UJImwOnNzSsOCJaHDKaTXbvkErnMZgCuqXGux5Iscr/R?=
 =?us-ascii?Q?BTd8ogF2Mwd1ooRD2Oz9qOPMckjkYOdPlnLRc60Yt7olLkSLCWVJB50fmNfD?=
 =?us-ascii?Q?dd1ivjVWmyIXpP6cMb37S318mkjfg4FM59Jps9HZU7VEho5T74oxJ8gTlgBw?=
 =?us-ascii?Q?aXRH8PF0LJH+LhG1TibxqXC1C44jJHJJRRXGtxvWOtdSv5fHAy9ETyHdDZI+?=
 =?us-ascii?Q?kOmguoOkjv9/qZhsrpopqcXCgNTQbzje8X9Verby+5B7tIlOCDvzQjPIHM7V?=
 =?us-ascii?Q?ypQWK2gkxjA0nm8yQEoTNIrD9CKs8sf+YT1xxDRFn9VT3r026c/mFNw99TYb?=
 =?us-ascii?Q?YLTo8/dbxCdRFCzKKoN4rsMG/aIJuMiNQctkMRnJ0udpz3GgfPxJW9P/0+vN?=
 =?us-ascii?Q?rLAs42wTNoQKsu9i67062x1JPrSzvecACbKjQQeCDiQ6/UgjKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JgrojM8/ywJ4CSPMWWt/C9UUwrVZNeKY3+P6diQN9lb2EmjFao97uChGAbIf?=
 =?us-ascii?Q?2lPnjJpGojvCaNjE7wCmk7j1CBI3yngW7wWuxKCqY7Bx9WTnPKneNyHC7AJi?=
 =?us-ascii?Q?hrdLz0Vtf9DaW57nYs8a8v4ZDzE4oNKuZj0QOqUA0eeyiujBvfPkzAMr7tL7?=
 =?us-ascii?Q?W23rfvKyZMssJuswijqiPoC0wvfK41QFAZbrleMusl7kQ/am8G8ZyVtqLT8F?=
 =?us-ascii?Q?ukt/FTchbS7Y1G7C/h8fZ2SH094MfvR5Zi/fWeYUJxHi2b2tsisaluCNz2iG?=
 =?us-ascii?Q?D3+xf2SCJEG3nJeLHxCPg/0fPO0HldJ1aLHYXyPsqKKiCnzmDiG2vdXVNYYJ?=
 =?us-ascii?Q?2hGU9JlhItxNkilpqwzpR1TBWHDf5COHkrChRM9zq2rh5Nt4nVJAjEMydq0q?=
 =?us-ascii?Q?wPG+IoYKv2os2gAw3Dgws7cvXvsEYYWDMopLgtFinuXhAL8qp5KiTsptcmpO?=
 =?us-ascii?Q?U5A5uCC/9IcFcQRmh6u7PLh84F4ahVD1RfeM54fRNABGADlqp9YsorJDmZTq?=
 =?us-ascii?Q?xNcyOm6fwtw7e9hYmu+hH950YzzNwkaK6PZ8a2g8tmRTayPUGKHoKsAP0kH1?=
 =?us-ascii?Q?p/ICRLcDVJEefGu65N8NkjNlqmWAtfmoL66TacrkGMjTXuvgrJ3uPpmr2aw6?=
 =?us-ascii?Q?NwUw1O4BAxD3+3LE7cm1GA2GwzrTP99viCNdo/nw8oAXETRUPZt+XOALzU2s?=
 =?us-ascii?Q?0I939yYWPUu7fp/Tbr2rhAXean1oVUYEr5YwWJGC5YISoHaha7pwsufKi68i?=
 =?us-ascii?Q?sY19xvHolAkD9ClflQqHVPlhiUSmvdjDlP3uP9h1RAlYvUU1hKRqAh7Nid7P?=
 =?us-ascii?Q?86vgwdigIhAiqep1SToCG/sRfQ58kPaZWsuQ2Rb8TRcDxn4xeLS4ObdTpmgs?=
 =?us-ascii?Q?/Dj5OtVcsvRXIh/XPPPnIIGsiqnwM8PUtpTaGRIutIzXHoGGGsSO+z5B2vwO?=
 =?us-ascii?Q?pHjSC7reVfs/LlF1WsW9eQoKn1zXNSIlr2NswMi+K8hSnByU6oCwYoQyxIIG?=
 =?us-ascii?Q?cJvqg2UBh5amsX1hvNOFjer12w2Cs3R3k10xPhDM59+44DA6ZkVPrcHvJFYK?=
 =?us-ascii?Q?po8H6+diua401k7xBUg3+aK52Gj9z8WdA+mpSxO4AJemj1SSqBHUNqgkTW3m?=
 =?us-ascii?Q?/Rzt0RFGkx1h16vbvTHCeB9AHV62f3pY6U45KGoYhH+JOM1Sn1Bw8h+5KrTu?=
 =?us-ascii?Q?7bVRUWmrWcFyi2NOBEYXmV4JVwkD0PlLzv7umcmjf4vuR3ikKLc/YVr2Jyk2?=
 =?us-ascii?Q?Q1j1GB+WvDalJurJ+fNUIHpjmnL/Iv4729p4Fi0AUfa92g7tZtDkqfs1bSAh?=
 =?us-ascii?Q?nhDEgcNm0KvV/vHJxqnnz7Tf1C4QRrj3hUePndS+2ADhmR9XvEqENoNl63B3?=
 =?us-ascii?Q?SVlGKRFil1T97D0phchdE69Y2JPKNM9ifUa4unpSUIO+D0yBtUm1Mlq3AM49?=
 =?us-ascii?Q?gde7L7MV38BKwckZfPJRk53QKrRYC4XL7QJHCfFidn37QixX3Pftul7yKSq7?=
 =?us-ascii?Q?jh4kpuh50/1Cmpdn0bHl6JZBSvyBZPvvqNhJCgxwSpZwkvaZ6Z5iqxefVuic?=
 =?us-ascii?Q?6HUPXwOj1R1K9kLRORBeLRzZtRVvobdh+xu4rIrFaw39o37Nm7YDHKgiwoFz?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0081706c-a3b5-410c-b248-08dd16b12b98
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 11:20:35.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfwi3v/kDa5sUOzrFc4B6fybNNVBZ1cjiwIbA0jLQlXXjyCbY3dhwEUw3TtqLOtJURsWDS/R9KmN02pkQ6AVsLE5VlDyNbpLtK5ouBOXw2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7337
X-Authority-Analysis: v=2.4 cv=Lpdoymdc c=1 sm=1 tr=0 ts=67542f89 cx=c_pps a=FmV7mXqD6UovpQmy5PTGeA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=mpaa-ttXAAAA:8
 a=QX4gbG5DAAAA:8 a=xOd6jRPJAAAA:8 a=t7CeM3EgAAAA:8 a=vig7P1nWIU10b8H2HRIA:9 a=AbAUZ8qAyYyZVLSsDulk:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: qw2aDsHTd4gmlh77PWRf8r54RLt2ZX2y
X-Proofpoint-GUID: qw2aDsHTd4gmlh77PWRf8r54RLt2ZX2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-07_02,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412070094

From: Irui Wang <irui.wang@mediatek.com>

[ Upstream commit 59d438f8e02ca641c58d77e1feffa000ff809e9f ]

Handle an invalid decoder vsi in vpu_dec_init to ensure the decoder vsi
is valid for future use.

Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[ Replace mtk_vdec_err with mtk_vcodec_err to make it work on 6.1 ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
index df309e8e9379..af3fc89b6cc5 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
@@ -213,6 +213,12 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
 	mtk_vcodec_debug(vpu, "vdec_inst=%p", vpu);
 
 	err = vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
+
+	if (IS_ERR_OR_NULL(vpu->vsi)) {
+		mtk_vcodec_err(vpu, "invalid vdec vsi, status=%d", err);
+		return -EINVAL;
+	}
+
 	mtk_vcodec_debug(vpu, "- ret=%d", err);
 	return err;
 }
-- 
2.43.0


