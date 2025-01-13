Return-Path: <stable+bounces-108459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD7A0BBE4
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6C9188260F
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBCD1C5D4A;
	Mon, 13 Jan 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="gZ1XgoKO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7A240242
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782094; cv=fail; b=IXdjGSiJV37k11/mRQGOpyCDRG/DGQKF4WQszUM/Muueyik9lNtnhdpytD90H0MeoSpsZToAqhlzNn1AvDwHidgYzQokJIxgROOzpnt09iz9XiJ5u8daQoCw9HiA0oMUAMmu5a00JY4h6yNHuWBUL+tAbpf8EJ9KkIEiVZrxJ9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782094; c=relaxed/simple;
	bh=9EyNB1lHcVMqvZOZdAVpDu47SlbNctQZ4E4oyH5zutE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AjSSTWGmPsDvg/B1Jk/s5Jwbq6QqEtQDuyjSY8MEf2Xy9VG91DkZdtTvG07Mm3C9HAoMa2zgrCiL218L60fgQVhzhsi3NoRYP9elQGrelRFpm4G7SwmfspBj6Cg18CDxPf7WG4pEdmEG713ERuWu+PJuG2Q0TQHa/srb0aKmokM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=gZ1XgoKO; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D0TfuN011935;
	Mon, 13 Jan 2025 15:28:07 GMT
Received: from os0p286cu011.outbound.protection.outlook.com (mail-japanwestazlp17010005.outbound.protection.outlook.com [40.93.130.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443hq4hbrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 15:28:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQSfU2yG/h+xmTU6v0YlTgNS5QHFKmseM8N9qm/a3YrE1EVbkoXh6VtROrOvaEyN/X+2Mu9cTHXoQHlvdYkNRv/dO3BmSItRGBV+RsOUar7t574sj1TwP3tdtDgU89Hf86CWACzOcvNvbGtSJBtJN2MFam/8xmx6xvcwkSLYBQJp8zHK/2Ukgatk9j6Og938/kokV9W64fv6iKTd4hCbEBj/yHKUOWJVUU23iVy3+j5GAKIXiq1gU9PIJOFeBT7w+r6hq9YcTXTihnVt6MnnB1sDDDFqgHaCk5G05SwkkjQCwD6tQNc8uIgfCuDAYvYjtt64NbPwYSFfLjvKRmAUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BschlfoNoYHXvHplOZOHHN/7BqXnb5cUS4mJNG3QAQ=;
 b=JNAU5IMAji9ZlYOn2Z/QM9TzGcEdf6fPcghgHR36C1O/dO6Gswp2o8ZBn0F/4sum5f/IISTV8KnVfDFJD8C/jtdNbzX2ivjxRgu4hEEcwXDJEB3ARapXgSgH6q0qptisSqKe9laVkrKHOhuq/kFb/sJcVa5p5OsYOewBvqT2iyOiPFd2HVhto4rGYmWhDGatkh7oUHZUlV6nHbz8fjs4T2fEPk2HocuthwX8tuAZ9K8plkGQh9/WL//AVybvGAXdUn15KKhRHaswd66/bdKzfkQEw7E/AEM6i9qp9nL65tjPZqTwU/5DxEI/1sdBMF3a6wGgO3CLmqkRB3KISXNF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BschlfoNoYHXvHplOZOHHN/7BqXnb5cUS4mJNG3QAQ=;
 b=gZ1XgoKObyT8JMCz3Mj7nwSM8k+xK94C9yc1cpNM8qVhd7pUWUN3tfzF8Yw2xIsUs9i7RN0vb1MppMCtRLuQ8od49F+oL7VEvuq62M8SAt3iBWE2jaznqOdcSV44loKMF9aXy2cj3J+XWx4ZQkbfOdDx9iPvU+L3Vm5KsDjWwxncBNgWNpEVGiaH5MXctxqBn9RLlzYecm8FySR8BAJPebF6LkrSpiZb4USTkTrDekWhF6hVVQk8t91owgaWg4wnOPEFR+tR2L9AxHDwc8SCEzfKATP/oOA/k2ZXS5cRudRrasKeIQoVNmfHmqMcto7s9mA2r3/TE/Fbl0lCFY1CKQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB1988.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:157::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:27:59 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 15:27:58 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1.y] iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
Date: Mon, 13 Jan 2025 15:27:46 +0000
Message-Id: <20250113152746.728135-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011305-consuming-reptilian-2133@gregkh>
References: <2025011305-consuming-reptilian-2133@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0106.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::21) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB1988:EE_
X-MS-Office365-Filtering-Correlation-Id: 95403767-4b0b-4f96-164a-08dd33e6db48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7053199007|3613699012|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ppXMUM/572jZW1YbjkZ82q93KBcJ++jODL2BeoAMcbsjF3GLDNHOQNHPthX0?=
 =?us-ascii?Q?7Dd3c2QuuhekuI3CtMd01Ql3uFun7+7SyVmYIi6ax+IckhD1miDYA2S/rbc/?=
 =?us-ascii?Q?HCFnfxX5HnaXhPLC+Up5YrYYrHTfHUtWdHur+oxfw0rUK4y0V5VhS7SEMtmE?=
 =?us-ascii?Q?iQtuMpB5w+NDsjIy6QTq056TEBgrHaYtXmxW1Q9hPJTln/6f2d4SWy/uupp+?=
 =?us-ascii?Q?QYBoA60wHqL09yg1xmeWwky+5QlXpseRQzNMpBO/ywpXrDS0s4arV+hDIq73?=
 =?us-ascii?Q?dCnNtdeGmiAoK0k+za3F6q0/RK54AL8P681ao1GtszS4mrwQzMVhI51GzHa4?=
 =?us-ascii?Q?x7TmcgxFT5M5CyFjAHHZ6C4zO14/AoU6p9gmu1HOUoyQr4fO2U5uhiSU/Cu7?=
 =?us-ascii?Q?15KNwME7sYXuiadoKrGyBlQ8hT8gwEOQTvQSEI17N7iQIfZXKTz5LizkKH3U?=
 =?us-ascii?Q?+zPu7fa6p1x6TS7JU0m9z6TgeNfXty+wyizGOUw0zGU79pmn+/VvZa3TwQaR?=
 =?us-ascii?Q?dQ09gsqTyZ1kdDIBNG2BYDkP+NPQjlKUPLel+uNKizTBlh5xXsH0oG6W57jD?=
 =?us-ascii?Q?hVt9gk+dDOVbDySxPRKX+ySp7cnyXPI7AfdR/CmYGuhXnUjggNOiLAr/arnT?=
 =?us-ascii?Q?myXSOtcv4ejAYb0hJT+H/5XZj9XppA/Sp4MrMVpcJpWDOwj2SK35rloUWx7F?=
 =?us-ascii?Q?A5wvjOwiZp11ZHZzjlhYmRVtvTKikJnRrcsAITwC/lrCtmwBalXBvTnoBz/m?=
 =?us-ascii?Q?NJOPpHlttYkD+F4HoJoZHWlchLWMFmSuZ94F0XBYImyGRnJyZ0gqRPBTluWL?=
 =?us-ascii?Q?M52kwvbDI3GQeoTq3YZ4uUrpn1XBuXTIWaDpotviECvWFDnw3rilkHY6pGGC?=
 =?us-ascii?Q?zlMBSwqSntfgYk6MSTpDw5GrjhwQAODmcFjpX0V6Nx6JbGdp3qdleuYt/pK3?=
 =?us-ascii?Q?3afQrTtQGMrMRHVKXK8+V1UvghMhx1lrEzcBqKscLSEA0kC2jUNuhqqj96qt?=
 =?us-ascii?Q?LgrQ730Zt7c4/HawOOezm1/mEUvJiOGoVoS2LSsCkw8xJaHgHoc8vlKediQ+?=
 =?us-ascii?Q?YVJG7oI9qza8vZmOHh8fMcJaQi1incn2mMUOg5y9t0+iB+dQ1fLV13O/ZJob?=
 =?us-ascii?Q?DfF3OujaQeTgne8Ws9Wwze6LLYsvJ9vA8XozjTow2Sn7GwOY8kN+2AAtMoQC?=
 =?us-ascii?Q?repV3MnsSEuLS2nNC7gr+HVEYzTSXiP6sJmo/s5NXp4mUBeQXPsQZU9qjbQ5?=
 =?us-ascii?Q?vG8PWI5L0TE5E/ybiRJsjWQLKxVffzB1orMlhI95emVwpH9HlHBKB2CDwaQm?=
 =?us-ascii?Q?0QwAEBUDQXIKbcnklOn9Q9F+xzfTLrBmBdQlL3f6rvOumkBn5rzxdOp4gGAk?=
 =?us-ascii?Q?2x6X/b71cJcG6LhWfwgBMDpcpXGhxXg9+bEuPSLFxqpINpAF7NYjzS4/vZGS?=
 =?us-ascii?Q?d8jxyX2frBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(3613699012)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RwyR091+KzZRwEKaWkSuStmfuPDYnLtNhk7zLJBPLk2EoGLVwWTYab0jRm3f?=
 =?us-ascii?Q?crYti0Po1iqDVzsCGxZHjYGFkFHcO8ZeT20akRk/pIf/k0zApBQNrSnCsMev?=
 =?us-ascii?Q?I/orAjME21lAtdVmcKjloi8dZW5frtNeuAC/2nzF/3jONqatpys+dCNHbkGZ?=
 =?us-ascii?Q?naaEdSoZ30KEh4X08pajv5YNuQHq+EJKDSmMC+4J9jY00lErgZ+HyRnpUzZS?=
 =?us-ascii?Q?4DIK8rtYyvPahS3OjwwsxeDBwo7Mf6o824JZpOcxFIInfzBeSOyVJjSZqDCM?=
 =?us-ascii?Q?DgN6SCvV+CINc/ghfTkCihoZ0hYb8Aw8sBPou/w2/T9NK+kpm1dPRbUdk3Dl?=
 =?us-ascii?Q?JK0X799XakmIEwWbFFlI4A02LG3E4vJg+1tsTRYiHOKxWswn5x+oaJv7OTXS?=
 =?us-ascii?Q?pe3cYMCSbgO3GOl5H8k5Hb5TooNvgKtG2NOYKpjEnR+LenvMr+wqxaOT47M0?=
 =?us-ascii?Q?vcWb6/7GZOf0Jb34sgLEAwzMtULRALjQJZoL7nytzFB4yRA6Xeu43fAcoL0U?=
 =?us-ascii?Q?39PsvLrkrd5tJMo+icxdlUa3BpCAbE8hAElq5it8AliKRG+nrxco0t2OyKru?=
 =?us-ascii?Q?EjrDeoCz7PZTjQXwHdgSv461UYW0DndRnuG1/4JMwE3PigzqnQoxM6vzVEg9?=
 =?us-ascii?Q?cVdNCHMWBVIBctwydnlH5Z1BTGkf2ZTwYr32UXyphMqhdbgKJ7Jjf1nB+r2s?=
 =?us-ascii?Q?jiui7aF0QPpwVUWejNxjh9y75AfcljLXixVktzr3YgjFplz9iRYELWq53M+m?=
 =?us-ascii?Q?2XVPu+z2wOyZkqkBtp8EWB4aXAKjnBMf92paqd6Psi6CFtKLI45OloKTAOT/?=
 =?us-ascii?Q?wgIWuLzaKOpq2Xz5KzsvYVmdzRpS8O7OHvDNsB3m+cCr55+aXLePLKMpK3eH?=
 =?us-ascii?Q?w/cPf0cZvajz3NHYYT+Lwh2RBDqS66Gk03DARX09VMYE8mLMjaHoTb0THIWn?=
 =?us-ascii?Q?vJVR1qx5uTuxSZIaaho1smhpKaLMtWQuwXpPIXhm4sOb/PpZK1afcAyGZ1Ln?=
 =?us-ascii?Q?qIPGdoTuP0HXg2zAUPMva6mAbw53MYxCGNfR3xiWC6TTnpPMkLkR3EoYrpew?=
 =?us-ascii?Q?TQNJvPpov+ZE/fEv5iTGRJsZunugEy2hImm7W0zhoEdOhsoINSgGD30E1sZf?=
 =?us-ascii?Q?x/BMAWgy4b3vR4Imf1GGQGlt9GI8iLCxQXc5+jM6m6MUpUg48873KUtbzrdr?=
 =?us-ascii?Q?mmFqiwDLl/sLC3thtzBay9zXmnW89Xj80TsKdGRfZDhlJesikiB1kolorb9Y?=
 =?us-ascii?Q?p0LyRhKelPg6X0YaKtjSWLfiYOuqpRTzDduEnEo5zHR6X8jqANRFMEnmdGiC?=
 =?us-ascii?Q?REtkXhJK0uwRqjHKmrE2Btl2DMd27OsqXR4wrL1y457X2sxkJsnPm3roGtbJ?=
 =?us-ascii?Q?rC01JC6UrXIbpidB8WXY3zkVmGlnmmenQPG8521yCmo21/Dhe7wuk5EWoypA?=
 =?us-ascii?Q?qmCBabsGfRu829n9znFNpoiphBWWrbfvqbTGq8M24hz3Ky86C2tuLcSxgVjB?=
 =?us-ascii?Q?wK3o1RPNVbSNKTmCS5gUWzMh5Em+BWdguMC0n8+MJQ0LnbdpGKZe6Orev4YX?=
 =?us-ascii?Q?46DyneoquOvAoAYMkX5dUwU7iewQPNABeDILzfBr?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95403767-4b0b-4f96-164a-08dd33e6db48
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:27:57.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WB3T9Umi7sO7/s7WCe3bU5TqrcqEhzriA8RctU/kyLoc1zOwSGl6FXe0w/yDUgF5YPIYnmWtGjcHbr7b/MSyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1988
X-Proofpoint-GUID: e1w6yBTITrrDsyqNphMJXBls_2cts8cF
X-Proofpoint-ORIG-GUID: e1w6yBTITrrDsyqNphMJXBls_2cts8cF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=940 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130129

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Currently suspending while sensors are one will result in timestamping
continuing without gap at resume. It can work with monotonic clock but
not with other clocks. Fix that by resetting timestamping.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241113-inv_icm42600-fix-timestamps-after-suspend-v1-1-dfc77c394173@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit 65a60a590142c54a3f3be11ff162db2d5b0e1e06)
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index ca85fccc9839..6ffb67f6fb7b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -709,6 +709,8 @@ static int __maybe_unused inv_icm42600_suspend(struct device *dev)
 static int __maybe_unused inv_icm42600_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	struct inv_icm42600_timestamp *gyro_ts = iio_priv(st->indio_gyro);
+	struct inv_icm42600_timestamp *accel_ts = iio_priv(st->indio_accel);
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -729,9 +731,12 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 		goto out_unlock;
 
 	/* restore FIFO data streaming */
-	if (st->fifo.on)
+	if (st->fifo.on) {
+		inv_icm42600_timestamp_reset(gyro_ts);
+		inv_icm42600_timestamp_reset(accel_ts);
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
+	}
 
 out_unlock:
 	mutex_unlock(&st->lock);
-- 
2.25.1


