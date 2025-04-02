Return-Path: <stable+bounces-127380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C7A78803
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8103AF500
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 06:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15420C482;
	Wed,  2 Apr 2025 06:17:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C019049B
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574627; cv=fail; b=HomSd4zmmlkhe3lMlDGYuX5woGAHCt0BvDX8s13nK3WpCBfCU7jMJHirkdtTQSmGLLozxQd2v10uOhMhVH8wuIH8GeVb/kiU1GVGgAifDuCQC/y52q39wzVxOzkcZ/xcf+GCT3o/r3erkwkOUlIxTYVpJIghOucXZq6rYZx2OpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574627; c=relaxed/simple;
	bh=K/VKGjraczIO7h1w3uR2WoqI2k0QBLzkQZ0J12+DDpE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sYFZlrHIVPW+ee8y4JdoU8tzZgNawjSUBgYH5IU+bMV20hvCmR4mfpGW/9HioCnVr1yztZmEzoXv9p+d13XTip2U7odADRrXn6gjJGuZMlVHQbQ5/WLj8wslXp2rzdqroNzYhKQ/y80upoUg1nFG/YPsv6L8+P7DL/ddjyOM66w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53269D3A010566;
	Tue, 1 Apr 2025 23:17:01 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtc9rb0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 23:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNdG1xMn5GA4GiTxQ+VqCfK6P+/WYpaPFnNxdDDIEhWoVmZlNY7c/P0Hb40KJ5eV+VwQTKXv10MQqk+x/Pu+59uU5uYv1jvy0CjWviZ8R58IEDrrnOhmZN4/+cYjAV877yDQSvy8CKWnEK9P/q1seMzjzK5SUFZ+3YahaSmTmlUUfY85GWOvVuNc8XSxsNGCaQjeM+QdIB84R1Bxuo7qfRoyspYy2C5Q6uWUggYjHcBKHHJwnQ6wE/6ox/CroNqd5koPGaHV0YDJ7m95olbgtwHMItQZED3YJuVJbpJPpeR/GxklDehzYe11JUS6/s4iENRkgmVXXK6X77s8LlL5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1U1Qodi9IuyRqdYSmxg2xlpFyX3qOe9B50sjvAae20=;
 b=EHJXp0ogVVl5JDwKHX1BP1GHG2CrURcdGwuct7EG1P1M04rGy7N5nCkLeFWyHcTxSee4uz7Qd8rODFwpIDdvDpBnvlBLH0GbvtMmr5K1vxdBJWJ26O1f7YCN5QgCT5S+P9hMoDb93i6i9Ao7MUZ/XSaTtToTK8Lvhx0FPfe9O3oaNgGPwL1cpr/GjorlYuC/7jVpnh72EeKd9i6KH7cbrR9Evjzx2UPjP1a2EmgSndvXY2msTJ52VAF5G1ZkLkpShiRojd2pAzXkKhGsbr9nLz4mQCI0AQKZ+uu3aXVK3ZQHqbq+ap7XgCBuzsBAH/8JcLaL+FBljxG/Io3/WvnM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 06:16:57 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%4]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 06:16:56 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: andriy.shevchenko@linux.intel.com, wsa@kernel.org, Feng.Liu3@windriver.com,
        Zhe.He@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] i2c: dev: check return value when calling dev_set_name()
Date: Wed,  2 Apr 2025 14:16:45 +0800
Message-Id: <20250402061645.1194002-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::9) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|DM4PR11MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2b9c19-74a6-43e0-21a3-08dd71adf859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7UG9Hz6yw1GI00387iGedKqKQ94/sC7qa7dwPWJOJUU8/5NuvtlrW83EqI9?=
 =?us-ascii?Q?zu6Y8g7LuFMLEyJcCQ1c1SjvJ4l6B3JQQrz4qC40mFRywvy90BKSoDwvdCg4?=
 =?us-ascii?Q?51L3ll0uKOSxpHYplzIB0DoyUA+h45w/Ug3VwTT3AYy2CrRFq5RRJslNHKAx?=
 =?us-ascii?Q?qX1SZjZWBIDTmnzRzJFu5EzIVDWnP8ogn0DvKR9n1R8n9tFm/WJuIHcdVdVr?=
 =?us-ascii?Q?cwR1p53IAsFuI+8jhKQ6sePi0YyJAEFAbVD5bVYJnG39wwdyB+j/0Rsz4O/Q?=
 =?us-ascii?Q?nOdY+w2qCwrNgcsVYOxEMlz13dzKdCHGcN0mQIweNiqqDfjyp7EC1NSbVC4q?=
 =?us-ascii?Q?h4zZG0OEADyduiXNPhMpMVifkak+fh0GiOkxOhtrk1jQntMcIX4RgxQbjsf8?=
 =?us-ascii?Q?/IVkUqFxUoRx0hXXYqxInQ4/zLsgJkfxiczE5mn1alEsA8MdVDlFgPu5XVtn?=
 =?us-ascii?Q?RCW9o8MEwVNzWsg529Oo6YfgubopMBWnHaKJc+BQuizm+5YjTYceBF6c/ECw?=
 =?us-ascii?Q?lh+KTwYga2lWJlmDeoWhkxagaReamZq0ditYIEWv1pa+v0qZxikenTEVrSKT?=
 =?us-ascii?Q?+ppLPFp3Zg55Gvdl8atmerE3ywbS0OcSMVxi7HVO/XZFgUWgl82lj9cp9Lxv?=
 =?us-ascii?Q?gOSyIDjG8cDQEMTbmCOHcTmwCvHoLvcCIXuX66xugQRF//IX0LxJyhm6aWua?=
 =?us-ascii?Q?1fJpBCvQPvlgjAjvHFb7teDDXRM1v8zOfiQpJkpt98wxa4ExDOfBvyI3vGXZ?=
 =?us-ascii?Q?VwWeOKNwEEUWHxfU178uRNcUv5W8/XHW5y/erOoTuyQYT6NqBKDY3Ql2ggfX?=
 =?us-ascii?Q?XEARwpS9Rt9K0psdONziNf73QoL5zFBtYeXxQ7O2s86DENQPhtob7Id/H8cQ?=
 =?us-ascii?Q?zPnG2zTriqvdIjIzMMtkGHKIOqiDnHsYhsL3RImkqwNJYvSi/5YMiztOHwgK?=
 =?us-ascii?Q?GYog/uMoW0eiN/JXPB6PolDRoPJ2cD8RDdxuDBRXWKzTFCn6Ysnp4kiNIAPY?=
 =?us-ascii?Q?DL+nsTDu8zHeygj6k/KvskKAejz106krQyTLpgFH3pCrbM6f8d53sddmLX6P?=
 =?us-ascii?Q?m0Pfkub/u34xA1haDf32N9SpffbJRQSthPu1jtfUgjBmVNjupTOD2LqrQbmy?=
 =?us-ascii?Q?T8OHkBzEuRCtKxhlzEFct6Usf/7RMI97YN4/SQi38hXHlka6wUjlsS+ky3cN?=
 =?us-ascii?Q?0h/keWK1cXZ4PXpnvHhUqf7jq3cIOB+89vWKoe9L1hkPjJshZeW2gtRcZ/du?=
 =?us-ascii?Q?BZmelNx4+n3RWRwzMwVbJpBg9x0YpqMwYMg31Hw4xgSGDKxHfCxTQUxW+U99?=
 =?us-ascii?Q?JN1tqzrWpo3KPTVMqNTECKZpl3fxFE6lzbV3l6L1hDu5f8LZ7nDjMqwPTDQ0?=
 =?us-ascii?Q?krwHkud2MjwLu9GJ/kA8rk1MW3ts8j84ANzF9XTRgXj+CNdnkpxmC7qNm593?=
 =?us-ascii?Q?55sjYhngJC2oKDc4p8uw3P0bUoLz+npR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ueHrV/M3+jd9ye2gs/4EjS7qxl6PTBE5mPZsOzdxzv+g01zAcxz4P6LBEVMH?=
 =?us-ascii?Q?Z7lsldWlQRHRlCLYSUr1PnyZXHE5fPIP16y342e5tkUT/oBvj8UM5dTEnSxH?=
 =?us-ascii?Q?ZKpq35gDq5dJF4yATO3Z55t7X3wQwSlQbShd5LRa73B2FXDDRMGiaETUS0cc?=
 =?us-ascii?Q?FqqbHmG43TcKsOgLu6W89JKKmhegg91DyUNdGTVsy+Z6RIZtmxp5/Wwjq878?=
 =?us-ascii?Q?+Lzr32/BL/5yRGPTuACLwXL7BOCdjjNNaP8Z3Hj6tAj6IU3O3jx28fy2ZhRl?=
 =?us-ascii?Q?HlGj3MnG4iU/CeOKsk0P7wfiQwkwrNWBEywrKI8VGnb4kL85/uFty0mkGFzw?=
 =?us-ascii?Q?HxklUI8VoASHa9jep9DixdOCTz+p3+NFsvi7hr7jvySFI18FzAWt47r6lZyn?=
 =?us-ascii?Q?ywSTOORa6Y6R3S8pO3YNIAwGmf+uynJjTiMYNIQhhw2rehlRMDVvC6l/jjJ2?=
 =?us-ascii?Q?mPsizD+kPR/GGXNAcytN5FLX/P1Hb98Y0KxcRg0DqiRzLTI6Qz/BzfeMWYyU?=
 =?us-ascii?Q?cMwAkTPKzY9MqwRpQS4jaQPQTQOCAmA+I1qgBv9O/aWnuj0SOspAjSueN86O?=
 =?us-ascii?Q?t98HHGSWajIwzDBoDaxvqVAbM5pKPUj/VXGOp9VKbKDmlq0HDK5YQ4vmvj7T?=
 =?us-ascii?Q?BGfEOjuALdd1LhC0ICU3wqHs2AD0vbR+f8tLwdbHgGut1hr/7KQXLsIfTIzu?=
 =?us-ascii?Q?ZbXiolCVpo4gHZtlgeCzQQH6cmlzE0hnBA1IQcHuKZD3UHRWEo4BTiZxzCWg?=
 =?us-ascii?Q?B3W7Kza/bP+SwR+gHPsQD35/yxGivxgaiUjr41qdXL9c3c6TRPoD3+Qh0Fpk?=
 =?us-ascii?Q?/hZIr4z3QsdOilOt33JTneALnngryPCFBc8I/GzOBERSOgdtGzDPToILuZZp?=
 =?us-ascii?Q?g1LyDe97YWpUTbeN7llgBUm3+2WkRuLoRi4IqfeUNiRL6ixXpsqDyDAjXKA7?=
 =?us-ascii?Q?4ifK+JDUxBR9pTa0HQXjQVrjaP6kNtvkQMxFdLM1a2oKlIJwiJhXpCVdQG2F?=
 =?us-ascii?Q?pK2aET8aeBDsOALMxR6Ftghn/s7mVWjyyaXFYXasGq/kM7O+mc0QXG+4ICo+?=
 =?us-ascii?Q?CdCJgkRQswg/EJXdgZy0keupN5b0I66UbxhL/DSOx9uMn4Hmzr0NcH5mHr5k?=
 =?us-ascii?Q?DwHuTgikQNvCNSYpd1Zd0vjwF+ZDkZLASGdhaDPk4IC7mRPKwx4aSC1SWY28?=
 =?us-ascii?Q?x44FGLrofLPdkfDG9n29WHEhMuuih70ooz764uPeYog4rs1cFoyvYYMe1ao0?=
 =?us-ascii?Q?YvoC0F1RR9Si+VM1ceYB6l1AzTPld934pjYJhOw6WAr0FikWrJXwsUJBkNts?=
 =?us-ascii?Q?/bhv2/IFuAxL0I97DfvWzkQSqi+zsWwXFYy4VdV2r2IxnuY5Ch+CXAvvgvDE?=
 =?us-ascii?Q?oQgmTQftjjs5dqtHJ1ikUkVbPJG6Y3SZrTTB/BOWb6sveValunwVu5SmJAbv?=
 =?us-ascii?Q?Tyz9AePYaPWaDkJVEzA/ug5cOhGAhe00OzDVKwohzurSYwfyWUA8tsqDH4f8?=
 =?us-ascii?Q?/rGq6+8EQXWjTD9Rnw4hNSjJsglqF7ZOmMgKuO2ML8RHpdR3lpiGmmwkJ7pI?=
 =?us-ascii?Q?esNK9BGiPb4fuJMCCrs5DxHuqswcVAo/z8pXRNh6gYlWFrtzKyiaRhlnVapL?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2b9c19-74a6-43e0-21a3-08dd71adf859
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 06:16:56.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QINPCRCnxmBWLT02+qsSrFXCelxFdDnyd7kuplbqH+vuxPsy5BOWk0FnwV01l6vJAWl+flxuBXmtC3SXz6Riiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-Proofpoint-ORIG-GUID: EOEBs0ZqRLyvLyQMS47SgZSjbAtge_ZH
X-Authority-Analysis: v=2.4 cv=Tb2WtQQh c=1 sm=1 tr=0 ts=67ecd65d cx=c_pps a=AVVanhwSUc+LQPSikfBlbg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=ZrR-pmgSSjD3dgL6ZSwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: EOEBs0ZqRLyvLyQMS47SgZSjbAtge_ZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_02,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020038

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 993eb48fa199b5f476df8204e652eff63dd19361 ]

If dev_set_name() fails, the dev_name() is null, check the return
value of dev_set_name() to avoid the null-ptr-deref.

Fixes: 1413ef638aba ("i2c: dev: Fix the race between the release of i2c_dev and cdev")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>

---
Verified the build test.
---
 drivers/i2c/i2c-dev.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index dafad891998e..f0bd4ae19df6 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -669,17 +669,22 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 	i2c_dev->dev.class = i2c_dev_class;
 	i2c_dev->dev.parent = &adap->dev;
 	i2c_dev->dev.release = i2cdev_dev_release;
-	dev_set_name(&i2c_dev->dev, "i2c-%d", adap->nr);
+
+	res = dev_set_name(&i2c_dev->dev, "i2c-%d", adap->nr);
+	if (res)
+		goto err_put_i2c_dev;
 
 	res = cdev_device_add(&i2c_dev->cdev, &i2c_dev->dev);
-	if (res) {
-		put_i2c_dev(i2c_dev, false);
-		return res;
-	}
+	if (res)
+		goto err_put_i2c_dev;
 
 	pr_debug("i2c-dev: adapter [%s] registered as minor %d\n",
 		 adap->name, adap->nr);
 	return 0;
+
+err_put_i2c_dev:
+	put_i2c_dev(i2c_dev, false);
+	return res;
 }
 
 static int i2cdev_detach_adapter(struct device *dev, void *dummy)
-- 
2.34.1


