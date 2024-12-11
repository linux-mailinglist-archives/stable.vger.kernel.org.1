Return-Path: <stable+bounces-100563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455569EC716
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853962868BE
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4ED1D90DC;
	Wed, 11 Dec 2024 08:25:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA291D9587
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905558; cv=fail; b=SKUuHgIbYhgJUTLPYDQY7yyfSuXz7IaeCBYdBv55tuE3G5fHB7w7/IP3PCEWINAyThEIO7ekjuiYly493jIQ5q2FrslG+06UykJUhQQqnrv0FhZUxAAEvodXAPivHB/IXe7qy6pNGowmLMCbo/lYNucg8GwtsVKOSiaswFAvvkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905558; c=relaxed/simple;
	bh=26qhsQRJ1oMK2GRXAHOQ8w0X7SJPZ0eV7I93G0qXqSM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qzSrUe/C49VA1SH7YXELIDaA82y8zecgbOic9fBNxuKDtVSUeNXdvgvZQdi0n18m4onPPDijcYEmGLXa27TjgNcNoJUnooR44xvW2Oa8upd6IdZzk1p4DLnLQI8kyaP0ADTFFkAZkTt9GwNkdFviR3looXHH0Dgic8CL30D7Bi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB6o26B010580;
	Wed, 11 Dec 2024 00:20:14 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1uxhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 00:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBArjFlticyuX8TDsmPTGS+CnPiazMBLZw3WveW67wWBRjht+qH7G24VIoHM1/JZ8OLW7EDDvuyFqEnSQkpcr9BRSJlbWy1HiJPdA+9lK1m/nF8jo0JoK3fn0QalZxvmHagPA+xmkZefi7r1Zvoa4Rr/869ZF7aE+XsuLYxy5rZDAfA2cEvsb9LRQNsGIonjeIFp7wpB0EgfkUzvwk1PfRGqZ2ikC04gKw9DLiYRW86t4X/zynw1zYtceUhocVccQSRcNQdBE2RStKILgDuW/5zHBf6y047BPX+96MyWySyPerNCPxxyk/4t2htI1Z9/5TNCjvauU+nU6i2t6q0MbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTn37iAvEn7fcKzCTDSgkM7iS6BogedQWHqeaIT0Knw=;
 b=rGflZ7Z1DCWh5N5Z5fiX2F4Y7HVC0npiq3aSaeIhuUBo3G16lREsCSIHj/9+/yLUfcunMHPM+EUh0kFhbpVhRnTgQivx1J64A9u436WgESAVqerCZfK40kuHT8BnWPAfnVI/YygCkIdr4w/pR4DZGSsnX0dDkktG0qETayLpKvr70kfs7yhqQayKTIhKM3hgpXpE99JJPAO++l2MOHGNg/DtLDJpyjynwpkI3+DAswuNu3zEDpHCxbMtMmiFSI/3IyF8FiNlnCSRUhX6zk6lw5DPuDxrTnlMNHWSfPz4Q669fMGb1Oqjegr3b6Oogaky4LENPpZCigtMCOGfd4WU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Wed, 11 Dec
 2024 08:20:11 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:20:11 +0000
From: libo.chen.cn@eng.windriver.com
To: stable@vger.kernel.org
Cc: qianweili@huawei.com, herbert@gondor.apana.org.au
Subject: [PATCH 5.15] crypto: hisilicon/qm - inject error before stopping queue
Date: Wed, 11 Dec 2024 16:18:15 +0800
Message-Id: <20241211081815.209162-1-libo.chen.cn@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0156.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::20) To BN9PR11MB5354.namprd11.prod.outlook.com
 (2603:10b6:408:11b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5354:EE_|LV1PR11MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 42956862-68da-424d-2bcf-08dd19bca1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GbfFPCZWRF2GpD0IlA/j4vxD/XE+NHWjIMrZO41N+SH/Bz2SDMMKOVZtm+9q?=
 =?us-ascii?Q?zmx5agtVzmvtKV90jd5PWFDgSvitNH/8MhtqEvrSQDT8oNI8stig4MD0QV5W?=
 =?us-ascii?Q?5oVAXvSrr4K6MPIEwVs8xh+MH42utVnFFFzYqA3h5SFAe1uuemY2RF/SlV7V?=
 =?us-ascii?Q?AE0cYpSU5BaGWxkc9lBoi1nrpauFRyWca2gVBL2ZCFTrAChv3wuqXN4nrSjP?=
 =?us-ascii?Q?n+T3qLq6OTFE5KB2tCJPRdF9GKKBsyAureGxUrUqykvPAw+BP7aIxai0ZqwT?=
 =?us-ascii?Q?94apJ1KXqL1ig76YEoiupj09tRQNTnjkbYIBtjgNwmKE0hFvw5HNreWd1/yV?=
 =?us-ascii?Q?WsnNx9Yd0xesPVjELRatIKGzAGJShtKvSQB6+/Q8Hjt1ce7IXNkOTrlfbIUX?=
 =?us-ascii?Q?1WNkoHGrq6CHFd0PoYI8qrQcOM708rrWXhMdgTYmYP8LDxwl3tF9y3XgtQt3?=
 =?us-ascii?Q?pyctm9bmFuT9XrQkSSOemwp5Y36/Q6Ba8fL1xnGnmByQKIzvTW5WmoOJZRZU?=
 =?us-ascii?Q?49SfOYVpE1Z7tN1KTH1+7m+rVT5oNCd7/7WIaGrhNZlVBgaLw0QtYC2Qrvp4?=
 =?us-ascii?Q?Hks3HcmoJL5jKKzwC2pYMcA/6jpaf1rkqHYgsFY8Cwe0A3XIhNkNQW40W3O+?=
 =?us-ascii?Q?arSnh32imj12eE89RBZURCau1MQyJqKbH7YaESzw8DKzAWiDAL8bvfVtw/p8?=
 =?us-ascii?Q?FfyBskcYL6BTXs5ZVr1F199Q2+vrylCmrF1OE+hpkgjSModfcUf/feCDlBY9?=
 =?us-ascii?Q?z/LDkxFBJV5VbuACIyfFWfe5SsMYfkmiS44a5sirSV8Rh/rbflHXU65IITKz?=
 =?us-ascii?Q?bgm8Gj9Pbz15Ca3YJiEsKNTMKKXgWf7k3N/cWP5WDs6DovloNHMzDkA576wa?=
 =?us-ascii?Q?W44vcJOuBzs8Uub9bI9krABoOfZd3QxcpV8HNUihKGPee3MOqsn0pwesfixE?=
 =?us-ascii?Q?ymoewVHKXIwQgsGTAo9AWYgd3AJTQHSeywfdSAaCgANwmWtbWrWly2ha0W19?=
 =?us-ascii?Q?u1v60J2Rku8LFJA1RwiekRQD2SSeoIaCxWxW3UfdwcdpwP6hGz9zioXv9CL/?=
 =?us-ascii?Q?7MO1krPA2Cr9p/2JZ92PBjEoPdz1VH0pTFC2pVG7hx1qi0Kf+Az8pIdXMGcS?=
 =?us-ascii?Q?MS9D57+/oEziPRyhO0bkPDzOSfdXbV01G6q7q5yO5AjyyNAh7Hmq/FlBABhK?=
 =?us-ascii?Q?EFFSzTUps8BAq+hO+9U3pJgS4fmRp2axJAQc5+96gAT8BS83t4sPESz2K0cb?=
 =?us-ascii?Q?S92hu1DbbxYwyLDg1BG75xtx91s43duD9bkJF6lXrAq+VMuSVI7OEQm9tmhk?=
 =?us-ascii?Q?+aEJi+fQv62eyhoBv7nH5yVbFgUWJ2bqfnaZfrcnvoBy0gZw2WNFL0kTCo1x?=
 =?us-ascii?Q?aLuLgEqVWSyAZ0epblupeuAbEnbweCZHuQPPwMZ4Wmord0660Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EfELpUyGvhjs2U3FXGhEubaZGziqq7ZtHv+ayNrbXE6gpC1UtQCGosGRIqmN?=
 =?us-ascii?Q?BcXyUvVwjjbVn6H5pIWRePoqj03d5xgckQJP5Zq5GUCVZQJWaQV7l53OVCBk?=
 =?us-ascii?Q?UnDXE/xHzGXk3mtUzx678Xl5p4sX4JERvckH2AkD2EuhpYbKoCvKzlR4ccy2?=
 =?us-ascii?Q?lpAJiVsaxcv83/w3Utt8KBYfDtRs4jho+ibMMrGiimeO+QNllTFKvJZxBGZy?=
 =?us-ascii?Q?wOPwyv+WHoxuLAfnzHoY+SrmINT9yK405YOQtNUiukGcHRHdAe857k5QrtrW?=
 =?us-ascii?Q?3RKNQ/HK3li5A1uU3o8netb449dkLg7j4Xos5agiurOZJh+5XMIVluWpkRHo?=
 =?us-ascii?Q?QxO+HTuuHglVBiH9qdBt4GHC3FMwcUqwGoCnQxvYSbVxmd0wLkJACeH9MXmS?=
 =?us-ascii?Q?2W6tqqNwBPCw9k5r1qenEZEHEMi+R5DUBdnOfphGViT4RLLCLV8BQgB2U3Vp?=
 =?us-ascii?Q?4Xn2Yjz3TMXX2wfG0ve+FtYtruEU4nd3UY+GM0Q/pXSvm0UNki+p2yv/PxWu?=
 =?us-ascii?Q?t3LRZotBmgMt6VGx+uC5enjb/UG5Ypq/FZWO61nBuS1fIvw2bHMw0PMOpajQ?=
 =?us-ascii?Q?+4Z5Y8VwHsIWPoKosT0lzw0FTWllkIDY4oFZHWMG0rEJtvqBlVy84X0oOcbu?=
 =?us-ascii?Q?2DJkZLhNj6W9TQ8jvBAwn5zkbGIenljFp2kMdqh1FtrwUQmagrJ19N8QtbRz?=
 =?us-ascii?Q?rsB29p3DVfpQfv8Vb9E/BL3CAd2S5eG6mrgPd2UmJQcQe5Pv1GxwY567VYSP?=
 =?us-ascii?Q?6eFsv/1vMiBMQsaa2XDP4Z44hxl6d9HVkvLuSFkdUZUDGaxZCnEnsqCnCj8Q?=
 =?us-ascii?Q?dWIA1kwMMY9b5NKcawjR/IyX2TAkIRGn4/SaMYTrXlhJ+vjm6UFe6iJpHplr?=
 =?us-ascii?Q?3iDCgrJTau4NURtFICrgcC5aeVhUzpdRr0t/6jzd2Zxy5QmyRDzQCPwlwH61?=
 =?us-ascii?Q?Z5S1n3d+a1fL104ktFvbhPfdqdu+3K7lSsotoUukGYOyfaX7ZVYd0Xfg5reG?=
 =?us-ascii?Q?e+y0R3slvUoK2Qc0qjobUN2BeJNm1r+uAIo57yt983iByqg+2SORLOKF2c+n?=
 =?us-ascii?Q?CfMBx1uPXt5fA5M+tl99xhcs12zgn/inLwnSDy5t+m0n7MmqQnc141QUOcli?=
 =?us-ascii?Q?wgjMzp9i6wi3jFNC1lg2WV3dAYfv1QTbFG0W4HcxlE9dhDtEp0n9CaRqTquw?=
 =?us-ascii?Q?iCCiTC071YhWD2OmG1R4TFaYm0IZkFBSJDGRA0R3iOgfhC3Q+3diu2kWBtDp?=
 =?us-ascii?Q?qvH8/hsaeJiib1teSqK4AclOnw4Olkdx3VShxugccYPicRO3/GFoKXAQpp6l?=
 =?us-ascii?Q?9gaiFz96J3PovXWx5FoNc/0x2Ltxn1Ua0K37MANqrd+MNuX30c+radIah3B8?=
 =?us-ascii?Q?fG+je+e3aLu+EcVCGm2lxK6dQy2GFZ9qRPYpiBQvpKMFKmLWK209++ggdgWX?=
 =?us-ascii?Q?llLtI0OGNJRcAzYAkvkDA7CORy3pyNMG76lH2C3ew1eCGAYKn9f1jTYg2RRB?=
 =?us-ascii?Q?6xEYBQfbICp6rgTaa/A0FRiRY44U3u0Ow5ATfI2GEZkDm7qJEvLdqTc945ms?=
 =?us-ascii?Q?jCkXDK55AgLBmTIugQaPiOeo5R4XNslzuCWKqi4xaL5NFllZ/D1F37qI4X7K?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42956862-68da-424d-2bcf-08dd19bca1a2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:20:11.4939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SiZOys6FoXs+YIEwwXJ2FfscU+ofIruN85H5C4ZKumx7vzEBV0UbooepwcCpnfPx8GY0IFAfVPpO0RRDpwhQ1TAmdQikyfluTjE0yJ1lZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-Proofpoint-ORIG-GUID: cfiDbkkJrTKoI546TQhx0zTW_xBTctYi
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=67594b3e cx=c_pps a=Syk5hotmcjzKYaivvMT4gg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=i0EeH86SAAAA:8
 a=FNyBlpCuAAAA:8 a=t7CeM3EgAAAA:8 a=mzVGTZs34JFsiwU4K9gA:9 a=RlW-AWeGUCXs_Nkyno-6:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: cfiDbkkJrTKoI546TQhx0zTW_xBTctYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110062

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


