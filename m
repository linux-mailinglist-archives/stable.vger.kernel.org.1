Return-Path: <stable+bounces-92898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E19C6B1E
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2381F24EB3
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A6C1BD9C9;
	Wed, 13 Nov 2024 09:02:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F621BD028
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488548; cv=fail; b=gqYSdy8LDqe4XJyTZclLbIYVOCUTZM1D17zxVLaBoiIsxNrQJp3cM60IHs2OOsG2FRlfU/F2AzEMbV8JTFeBNe1soa0pyJp49x17njmug+GYMkujV5uE51TI/1dZZxJPm5waygWBAIJMZ6sC6Xst8vTowTZmb9o/zM3zDeTYAIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488548; c=relaxed/simple;
	bh=8QScvadewxSInotDoWNjqPL6dgkjp5aL0a26f9aaCv4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iou2xGj0npRcRG0CAnfLr2twsXJegfza+MA/qN46go2WkUyHSjOW16PJb2z6+eTfJvmobY7C/lxO4sLqNE2S1S31Omv4kSeAAw0+0y18LFYk1ijxuR8leCKfTf2wb3oqL51Slg9sG864jmOxfHhWda73cMh8VJSdVMsobefDeao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD6G4Rn016295;
	Wed, 13 Nov 2024 01:02:22 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwpp9ta3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:02:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joM4F6Rp2DBFVeJ5V0hOqlfgnJS8h8KwJJOOmvUNqmJOIVXl9am+fsik4LxypH74I7ERGOdMYWtAFpk4b73aGZpb/JgSKY8fyyBw7Zs9ifPGCJnZ6qZQ0AxlbnAuFfMOnQbOjHk9NRJT6WFVKMHglvuNlKnCk5LX8bOY1J7J2rJvmAskgHRFzGyziRZwu1W/q7Gj2SAmdc40FBnKZ11RwHwvODCd4C6sGgm6pbB04XaDo1GahV1xUScouRL9Npx4iMz+P7k4i67O2O21wSkZu7iKzX9bdiPUgMbvUGyYt9SIbo083lvl9lLiZnOYFUbKTBU4N9g98ATsd/OSJWH3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKd0YVibhDyNlx0arBWlTpn5tHjHlPnvu9qJeKkqCcA=;
 b=KudWhDi9GeLo/UrTKOmm42Y7ODIqPWp3t7Es2wwTvkv41AkA5PoOoL4jtcEQXZ7T1+Na1LqxUM7som3khOoKXNDEtzSGNzq9TB4LuoNSbcHgLBoyVWxGQMSNulh7l+WfRFcCoQb9aS9kBDdrIC1p8smb7bHQwo0tegj+odI6GTM9NTeTmpm69KDVQWtYgOX7JSW+Ipz+2UdD/n+5AqsFhtbD7BpiGsWxZLvCmaMuEY6pnHt2U9FaTFdMRRS86jJWSMGqdtn2O6+3NKqNHO1T1NXyxzS0ZH3yXVM/fiT/RM0EcpfqtaT23+7K5943eobLjEXzY0v9DsSNIPJ6UB5EwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 09:02:19 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 09:02:18 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: hdegoede@redhat.com, stable@vger.kernel.org
Cc: xiangyu.chen@aol.com
Subject: [PATCH 6.1] platform/x86: x86-android-tablets: Fix use after free on platform_device_register() errors
Date: Wed, 13 Nov 2024 17:02:27 +0800
Message-ID: <20241113090227.1854696-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:404:42::34) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|PH8PR11MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fdf757-a4e4-47f4-7ae9-08dd03c1dff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rQz6FTG9v27suJlRyn8bEugFrmVlfNegBiamZ/2XYhwkFK9oGvQACbVxFUwg?=
 =?us-ascii?Q?fXEojdZ+5GAvklo4upSv6Ii78SP3Vuf37gfrpdibWJkco0Oks00ogGRfGHGl?=
 =?us-ascii?Q?8jvFX1agb+HEyYi4Xl254+ksl688prZtTZmQhrTqwUliLNCGTc0SBQZaUsod?=
 =?us-ascii?Q?BrlGyt9/g9eJfoI+PLilKOGuLNTLczRd7xkHi0ND2DnwtTqD6zsHLjfucjSx?=
 =?us-ascii?Q?VE9R+o4FHF3y3oFiWcoy6LyyJWdNz4jx4hcnUlenpqDf3wjG+pmHN+fwXWc9?=
 =?us-ascii?Q?SXZy/AWnEMxv/r0mL92vY62xokvOUwc5N2531ZlbZauudjGTD2lijpHz6pUg?=
 =?us-ascii?Q?g0S6VlHDEuYVVb0rcOO5MGhc0bhCZ5K6rH8vpRpor0XJnxClhlFjnZ9rMblZ?=
 =?us-ascii?Q?UwGexwqgpAL2bwkPo30JosInFixzytYVyee6RMc4XfMMFikc0cvE9JX98H0T?=
 =?us-ascii?Q?oTfboOkwC2WGWNh+58NM9xhkfXTAZMXRsGiB0SOmxwMG1TYlTmRx8Y5kgzxW?=
 =?us-ascii?Q?yklEaq3+qHvU7j8Otw+soBC/WLEZTjim/5+t1m6Dy5t1janbRVntvgwrrekf?=
 =?us-ascii?Q?1pV3DidC1XWR8sONXg+tCgMnIeGZWMtA0Hk9RFWO8i+thfMzjUsjhuXoVmo4?=
 =?us-ascii?Q?Q2UnzurkNoI4fPiQgDumpXVOmlT7cCXl+d+eZD9LiXNIk6UMJg4E6CGESwLU?=
 =?us-ascii?Q?fDVy+2zjisi1AP7Ygv/oz0pWj/s6zBvlqkZsN0mh53fDJbOhP8vpUIl4Jg0B?=
 =?us-ascii?Q?HAqUJ6y/9nEmfWAs0o3S0UonNyJDeExYGk+fdzVcVGWwKobi+pEewFp/KjvB?=
 =?us-ascii?Q?LM7hpLXSzYCJBIUZPzM94J11bYdNwpMuc5TWcR2BRqnsT8KSwyj/jwTVCgNr?=
 =?us-ascii?Q?98nAxZxxbZ7lhdKTulf93y1sCaZhHB6oGoCn6xcSbfRAOyK1uBX4PJVlt7dU?=
 =?us-ascii?Q?kqL9lEyIYMU1vuAX3YtHcCJfxwFhIKcPlFUe3lvRmv4rkdH7Hrun1pPdp//O?=
 =?us-ascii?Q?onAGLoq2T4sK2Th0NEym0q6qZ830thqP5guKVJYaNkkOV9cyFitWrbjp3m+S?=
 =?us-ascii?Q?svR1NrVzl23K5kFvaJfpM60Irhdtk1+sYtttn2BcNmXHYUUxmCRAvNDFo3Fo?=
 =?us-ascii?Q?1yaRkx4cVOxwQTLtlYB4d1Y9M1RGnKYYi4rC3bunD8ryVOqod1ybk/J3a0qy?=
 =?us-ascii?Q?XuYWZNBpncJ7vDRqakImu2OoZ4D0d38upHm2vVtQWg6PgNMm1tXgDH0icNJN?=
 =?us-ascii?Q?7AfMHmka/3ZN9rWDXEknLq0StMXfqpykkcW7q0mPwUC9bya/UMeb8wT6PkBW?=
 =?us-ascii?Q?oRJFUzcdRGTnog4xqcdTEX61iMah95A9I7QZOJX4iN6ew9+0mnkdoUCv2bhJ?=
 =?us-ascii?Q?TZTVzZ3OMhU66BkpaiGVUGKHKxx9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O8/6h29jhgCtq2DkKPQh73wv/fyNQC+Q6nkBTkqCDgrxmEtMAKbxNRzcYMeO?=
 =?us-ascii?Q?7i4R1iZtO3vYAUT9tn7EVY98eYbkWpS6sXLTzvoSUNXH0A8Ae0xA5J7acNsZ?=
 =?us-ascii?Q?6JmsyzY8x51wvk7fEtGZKQtPyGyJCI1G8cRXPeT1g/iz9/9yRXSQSYzr8zu4?=
 =?us-ascii?Q?KVHwtCap9QIvrIoWyuo9OnMlGd+Yrpa1fsgHtjDyPyTkfPo9hKy4suSSGOJg?=
 =?us-ascii?Q?wic2etBbRUbz6t99tZ1WZfQNTWwAfH7RUWgM+wcQwxjBHx6xtJEVkGO5lD1H?=
 =?us-ascii?Q?iqQJy2fyLBjAQKSwvXbkbLTaWyUBJamb8aSXMQ4O8+oHnW5GaRLfXBYn0H0g?=
 =?us-ascii?Q?4ruRhveuF16L8+81iP2azZhF4l8GUgd3daoV/vANJNIq0is4Qn6Coy48GjVc?=
 =?us-ascii?Q?QeKSpiNYeNmK1KZXkOZzTMZFw8/JbA/7W8xfQ7I3gdswyjzZhd00O2/pLphA?=
 =?us-ascii?Q?XVgWVD71JJ5H+fqg578N4kjGMSYazGUDzSVpw/Qv2Viqg5VkbeAXpjPahHSP?=
 =?us-ascii?Q?hKJJBKQaLW3sKMMwZjBliEwe/II26Nnn4WsHhqyqHYKiiJqAdkrUA4mnhjdC?=
 =?us-ascii?Q?8y8VHxNZb/scrc6TFmRYXamtmz/pW0kv15wSvEnoolP7VFeY765KDDDgqbSF?=
 =?us-ascii?Q?5jKLJq2Fpgfx0p3x2Ytqg1VZ/aANloF0vkF6sn2yUH358hrAqVKMVCMY8OYm?=
 =?us-ascii?Q?dvb0MsLVyp+e0L9jIRJkYuhgbqoR7r0ZAw4hVPAil5oBeBUZKTNzGEiu7C5b?=
 =?us-ascii?Q?8uyWm00igEtzVF/8T7bKj7uETjo4gyxhxgVIlsngphe56JiDvRe2DSQGByTv?=
 =?us-ascii?Q?MOXDJFQtpoqCeb5TM3jzcXaScznTluRszTAyglihmehgXBG7kBEM8UkG5AFy?=
 =?us-ascii?Q?ji5fUp0bPaqnBPGdDk2TFvxlCW5sibNnM9m7n/1RfojjepbW76wBghzIxyvU?=
 =?us-ascii?Q?Olq8vb1ZyRzwhpnSO+cahJZAr2Zn9fNKg+KPlH5Ypod4Lr4s/No1iZ9QdLev?=
 =?us-ascii?Q?HFbKLka1GMTvdKZTEzM8q+pTzaPt92Ovu8LfGqLdNWyvexKxvGAKOarhdV1S?=
 =?us-ascii?Q?V4fka82nN/ECeeZusuypl8g7/ii2CA1lis1ip62/UQeOl0XE5W660WRqEHaj?=
 =?us-ascii?Q?j8z2r4cF6gnHUcguk6BmXwonJZTnALqgNP8yM+tdfvPck4UbM4D9dDRynq5N?=
 =?us-ascii?Q?6yGr8jR6lyFbO1vClb9ERnagPyjKMu0doPCdxsh4G051vYOq+M3Ot5LgrkuE?=
 =?us-ascii?Q?YGDfzbHgYll6tEHXfZNZg5ew9KjNBqf2TDAY4eq1EaYInkoymQO5Mu8lf1kT?=
 =?us-ascii?Q?H7szP0+XzQgihbAo5xtr4WbUwtlRbYrQOEKNALFoeJv0sux26ygcLN9SVe6l?=
 =?us-ascii?Q?GsszoXrdBCul55hntX5bdsmRXSyvCCT3H/f7biGxZtmjeOL3MwF5tLmwFiNB?=
 =?us-ascii?Q?5pTZd30Bz1qNE+r+Aic+RnoZxFho6OMiu991mO2NLi/DD3ZJr6Y+9GM5KTO6?=
 =?us-ascii?Q?ubCQc1RGYRqzQugs7OQGOd7644t0LjQB3jWlpuWpfveX01eILcdg93bSt6TT?=
 =?us-ascii?Q?rJSiyQeW9jwBiYMLuzy78V0hXYLZDh31WsiLqxuXwBR+Gc7DUnnqgbnm5irx?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fdf757-a4e4-47f4-7ae9-08dd03c1dff3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:02:17.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0EitP3SmnausH04HTLkTaMiLpMSi89C/3llw02Xq55kgkvxHakQRLSHWuSYyQrLzFRelB7Mza3BbhX2utG1/Z7LJCm4OWXwIHBLUfkrbhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-Proofpoint-ORIG-GUID: cAsGVQlo3M_z97kHuvAYoS-yiXnPyNyM
X-Proofpoint-GUID: cAsGVQlo3M_z97kHuvAYoS-yiXnPyNyM
X-Authority-Analysis: v=2.4 cv=J4f47xnS c=1 sm=1 tr=0 ts=67346b1d cx=c_pps a=kqCqMoaEgQjRYYKBKtAp1Q==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=he8YDqbjAAAA:8 a=20KFwNOVAAAA:8 a=SGGfupsqRvpnpx4TIqIA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=lRF3faHqDRKgy28aj_NN:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411130079

From: Xiangyu Chen <xiangyu.chen@windriver.com>

[ Upstream commit 2fae3129c0c08e72b1fe93e61fd8fd203252094a ]

x86_android_tablet_remove() frees the pdevs[] array, so it should not
be used after calling x86_android_tablet_remove().

When platform_device_register() fails, store the pdevs[x] PTR_ERR() value
into the local ret variable before calling x86_android_tablet_remove()
to avoid using pdevs[] after it has been freed.

Fixes: 5eba0141206e ("platform/x86: x86-android-tablets: Add support for instantiating platform-devs")
Fixes: e2200d3f26da ("platform/x86: x86-android-tablets: Add gpio_keys support to x86_android_tablet_init()")
Cc: stable@vger.kernel.org
Reported-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
Closes: https://lore.kernel.org/platform-driver-x86/20240917120458.7300-1-a.burakov@rosalinux.ru/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20241005130545.64136-1-hdegoede@redhat.com
[Xiangyu: Modified file path to backport this commit to fix CVE: CVE-2024-49986]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/platform/x86/x86-android-tablets.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index 9178076d9d7d..94710471d7dd 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -1853,8 +1853,9 @@ static __init int x86_android_tablet_init(void)
 	for (i = 0; i < pdev_count; i++) {
 		pdevs[i] = platform_device_register_full(&dev_info->pdev_info[i]);
 		if (IS_ERR(pdevs[i])) {
+			ret = PTR_ERR(pdevs[i]);
 			x86_android_tablet_cleanup();
-			return PTR_ERR(pdevs[i]);
+			return ret;
 		}
 	}
 
-- 
2.43.0


