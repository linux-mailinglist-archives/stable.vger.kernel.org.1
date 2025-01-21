Return-Path: <stable+bounces-109621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99161A17F80
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F397A420B
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243238DD3;
	Tue, 21 Jan 2025 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="XGCI5K2w"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2104.outbound.protection.outlook.com [40.107.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B51F12FF
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468934; cv=fail; b=c/ih5wIwPjSCjYd7Q8BVl6xuPVKW9aX7YzOtRwGene9FMO3GlklcVPqtL58CIIibj9i7+zy4vFz5HP7/3jfm25TvufPMuX6gELY95G/7zIF7eX9spGaDlDJS6PWyi25wGU7C+pEZhhJFBihjAswemwXqwxMO7Hw8A343RsPeDww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468934; c=relaxed/simple;
	bh=qBMvoEiq8JyseVR+pQk8Qpw/Cz6AvRozmshnX+L38Og=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dRv22rzWaiQRFsHzfr1ZDRsxJqBdLP2x2Y13twj2drFGaHilDVxWO/J1TALSla1ASZ/47nbJp9NI02WSSHA5r931dP4VvqB/2IbTg6qmmu266eL7/i5JSqU9MS+6c6tqFrpUDCsLEcZ2fiH9luU8PJ/xA0R3tqnYyHxOqjeYtSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=XGCI5K2w; arc=fail smtp.client-ip=40.107.22.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9h8duWGc8MyLsCUGRRcLWJf/AvmZB6MiQ4DVVG5OHM6jV6db3OouzxHM56N9EdiBhmtFkchIlG0hmlprjgAbN2EAWw81HJX12SdJ0sF3bMaJnZb45tcIRUsYlPzPvnZEPQRCd6jZkjeuz3Qzbn59BGBQqJUECYE664CkRIw5LeeH/NFI2b+37zdvR6Z42DWq7pdM1YcmIPjTOgKX1vWBlxOFxcNmMMBIyfm5il4obaP0R53aHGmNZbWaHgr5Ym3+MDm3jUxESkpEcBv1qMgEK7vf95GFvH2qI96kjB43WktcghwT4EK6tNSUbH5my6SKPbXA1qY7LX8ow+CmzwJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPDOJWoeqp5RpAMe66Hy13AGrDTnuhzedAb3tpjIAWk=;
 b=gWGIc2gTGvzCDFx3a8NhLfNNoOyXVpD9EURCuNW4oMiL2OGC4XNea4gCILFApTaoBODK4TLeFYkQyaVyTsFNaIzS5QAqe2emRvMhIcKDzcaV32SDC3WPopF7MjDcHXQhofQanqLzb9cfMJniVd56ZfQEsKhkliJjq4rrw72DW8Fp4XRZ1UEYW3XsOaY2qwBAGm4kpUfW3/9qwlkw3gBZR+ABek/bRoXZulkXlyMqhpT3wKOae++e+hpIBokMtnTd4eKZYJE05QZpZ78uyFYRtyzx6sAjqkcLfCbziPfOXodEfItof2zCIv2tkU5u4XMtmIr8ZWXzqQz0FTkAG9eZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPDOJWoeqp5RpAMe66Hy13AGrDTnuhzedAb3tpjIAWk=;
 b=XGCI5K2w303GsCYoaPzk7KO9E24zy1pM9IzSafPNWf5FwNULnVeXq+dfviB9QAZh/J0uYbMyqRob29bruAmKZLauoAippgwqI8n8xpp99i+/3Gvsm29KnJDD5lGkEkO0pmO3wkqHLukctazjRO/UmH7NskttHHZokgGu6HDGuaRZvjqkscxNye/QxoOybAUuXqyYQlaeMiNLYFpBWaki0VmFEdsWcQvY8D9dzJglE6S4JJRW9tGFHpvwfYIZZNzY31AZITSNwLP5WuAEwbUOcx49obgwE0Do/oxES5AJXanGjuQv1w95Gr4JxHvwnbXYOZ3CLjqj6PpcjrJ7ODa4IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DU0P192MB1452.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 14:15:26 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%7]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 14:15:26 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Suraj Sonawane <surajsonawane0215@gmail.com>,
	syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	BRUNO VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v6.1-v5.4] scsi: sg: Fix slab-use-after-free read in sg_release()
Date: Tue, 21 Jan 2025 15:15:09 +0100
Message-ID: <20250121141509.201877-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0238.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::11) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DU0P192MB1452:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cf355c-165c-4efa-edf8-08dd3a260d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OAupwZFDWf6XYDTbWduoP0p14vI61H9eN0QXvFnsS/FuiZPil2TFYDNyP/L+?=
 =?us-ascii?Q?iWU/zPduQRlV0kAN7SWqrVMagnk/8ztHcskj4nqnZf8dhydhxsSW00RHPSA9?=
 =?us-ascii?Q?/qyKFD2UFJ5xC4wMsW1giQSq7yO4ed84ddCbgUJdqPAK6zjyGyRliCeE027e?=
 =?us-ascii?Q?4l/eg3oEQN3wFqATqlSJRUMv4I3qwHiwoCsREz1xQmXjTLU4eP5qoVvJLoQ0?=
 =?us-ascii?Q?SKbTWCzR9+Rfo7K6I5tL5ubZ0U+JBvMMZlfmAUFi1kZ+1lxj821uSg60qZ7f?=
 =?us-ascii?Q?kxfHgdy6NVuerLJBehYnQmVdhqyFjb4L/H9iFMdnOuwUTFvu8PSSMYQ18dgh?=
 =?us-ascii?Q?rx0JHdkQn/OiN/UtMQeYHUJ/XD5QPOG18lEPmC40TCyXw0MNwiaL8NGWPnfN?=
 =?us-ascii?Q?2rJL39Xo1p7d7LFDVo76il2sXBasZSRn7wpIvU6ZR3gb29uxnLOfvEtPrNt0?=
 =?us-ascii?Q?sLKX9AzH/bplDGK5F6nM+FsW4Av+YZH0jZ46oYH15Z02SXeluyzs0TxLBbn9?=
 =?us-ascii?Q?4kGUG7y/tB3pweIPxbgimU4ibXg1HQeRQvsQUUYt4gg0LhEoIF7h2Wgxlq/p?=
 =?us-ascii?Q?yxjvY9nUSiv4nxAyuW+tXGncstP0dxY0slCVsgBmxMSJhIVU5zf7JIBfOwZs?=
 =?us-ascii?Q?s7lIQyoO4CG/89hBEgbaMAB801lySD2y0UX6BVXrgCTNJG8Pzhhym/qZ7w6t?=
 =?us-ascii?Q?HteSLEU5FVfDiFdV6l9u1YxHD5qfQbu6yEtWNdZPOhujAjT5SDyKaumE9gnM?=
 =?us-ascii?Q?VrtnkvMtDQq6mWm/nQudl/WX2iSpMBXZ8N8gmqvM/bAQW0/D6lX3MSH4fosv?=
 =?us-ascii?Q?RnepkahNjjN1tbhVsc/sGDK08TrRm/QboCFvg0t3oNcpsLYgPB+5B8s129Ey?=
 =?us-ascii?Q?CcSsusjgsWSpEaKPN1iF2vo5Uvzq9kQunwGY6FH6jd4Z6IqkpYxndpJYWR+6?=
 =?us-ascii?Q?McH1V2C7lQpwCcUhX3xiejNVPYIR/GS84lPV40w/9+aanqD/DFu924Vmu4TU?=
 =?us-ascii?Q?s98jAbPydguSa6iIeXZIJ7PepREREOacfEekqjw+SCYGI3UOwuP+hNHauYpv?=
 =?us-ascii?Q?y5jED2daFaXdO0CwvdcZdw1hLqmPhMOR+VQgXscKVdUKlirjkcgW94/9ZTyR?=
 =?us-ascii?Q?GAksK4nKza/UwobcH62bMVPv2Mgz9lj7pjrpu5jZUh/pRkRTk8zuNUzxbLPL?=
 =?us-ascii?Q?DRD8TlIw3kM0eai8EM2m2Kin5RRF9KgKcSh1jQXvwyOEgA8vI0x/RCuvlfHx?=
 =?us-ascii?Q?29rnxCVwsuxkz23rjgp1km6e+A2IZvV6l7s6sWyRQ+OqZAIzQoazkADUjZFu?=
 =?us-ascii?Q?BFNyg1iWB6TmPdkzvk5RIjV4gHz9It1AYiaGiNsIxJa+l5TFV932Nhr/bK7P?=
 =?us-ascii?Q?eH5LYDHI72Mrzk8ffMnR3YH1U/vu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IpmACkg++Rddy0wMMe1PFM+6b0/6N2hqe8oF9ihBDhG7L9HsLfmURuJhlHJD?=
 =?us-ascii?Q?Uk7086VYhZ7uRIyUpr1nE3ZNUTMA5r4UsyuePSzlTkmCPVw8UsB6gkwu54wF?=
 =?us-ascii?Q?6O0dp2Bq53MjcAMUkPEW32jKLV9OMAlhgqFazMSc1R+XGF8bV7NNoKEqGIZr?=
 =?us-ascii?Q?wLAe5kPYTVl9g0kYQQqlr4FQB22Chz87YNrGB5qJdCllV9CAOeuhYS7+eBLy?=
 =?us-ascii?Q?ZHjYb4StqhMjCZItsHfAb7ydIOCwwGYP48AhdmXMUe54c6v8P9/Ds0JWrXxd?=
 =?us-ascii?Q?HA4B3hUX4b77II0P+LRBjsDrNFTlV5afGKoH/QepcJQHUeJ09HZcj/Zz5T2W?=
 =?us-ascii?Q?y3twvIuRyCSXwUAnLwuqDQJifz5pQS7JL1k+1IW6ibKCx16mRso3+4j/tc91?=
 =?us-ascii?Q?ZZj5xEPwb4WyblAbVfpVWRk1m8irAx6EbsJP3sRNZ9ihpGCYtdlHcsZh5Pus?=
 =?us-ascii?Q?9yWF9b35HCLAnXHjEyEn7/P61hOl5GYTSw6Fv1WKztfv9C+4rpq8vk7S8O6P?=
 =?us-ascii?Q?tLDP5qGpWvk+bdeCWUt8WygeUR48yFsR5g1PN18wCoHLqPHFMRViAoKEcbPj?=
 =?us-ascii?Q?YZyQjZKoU6sGmP4f+Pt0qYeqbKgGUYY25sfXb97oxZHNdpwyiGyxXzNCXMDd?=
 =?us-ascii?Q?+Mt2E2KEaS6UBr30UH41s9c+aLZKvkBtXcD297YJunuNmbVE6KqGz96U4QXM?=
 =?us-ascii?Q?7ljtawUc6W/Z+FJxNtUROY3Ov+4+6TuFW4Iyx6WOUjVvU0A6cIKSuXY29wMW?=
 =?us-ascii?Q?b4rSQppBN3WVirl2TKJOW1ENtfiFcgJgD9I+080MejSiqip0puJZ1SKq2CNe?=
 =?us-ascii?Q?IVka7q5K+gNqiowK1LTxQcKxCiLRbdHi5XzRX4mrb3EqcYiqNumcIxUcRiuj?=
 =?us-ascii?Q?YPjOq2F06h646EYhQsuICf91C+JMm+k5U4zoUFVBwUS3RPzGuZv3Sirtxhbv?=
 =?us-ascii?Q?4cGYncKoYOm25IDuwdyI04xYS4YjhoqRj8VazElW3vYsFmoiPZnjr9oxSWgG?=
 =?us-ascii?Q?MfN0bU153z7CQNsu/RjYHIonDKz7nahTbzvk6zX1ltQrsf7czOTVjFI0QeGL?=
 =?us-ascii?Q?rxCotYRQnDRnN1n7qznjSAAlSrmCfnlqlfXMBc+3lMAVAy/+2LATbwdKknZM?=
 =?us-ascii?Q?p3rqA+Oq+S/0GrlpcrZ6xVJQJV61IoQ/ysQhjEgd58TI0SwHyWV50dxV8mJE?=
 =?us-ascii?Q?VCvv2aVjXyT2BWoXKJanmZQG4X5nwugMKineYFAldTA3G6mHPesSDP1WOfKn?=
 =?us-ascii?Q?jrd5DCHTHnF8bc+NmMI7eOrLW0ViOPzX80B9Rh+toS6dmTyfSI80f7SUn6nW?=
 =?us-ascii?Q?yWwRxugVLc2V9Pmz2lIwKTin3DCC/iHgTveK8pdTM/UIyB11u4nOwE09hABh?=
 =?us-ascii?Q?R+c71KcTS2SqwkG8i0t7BpdArSYXolAeRDQsH/tk8wtyjc1u5sN+ZTzUeVmk?=
 =?us-ascii?Q?EzX4XZ4WqZq6pY6xOvRIhFgcLTVWpzaCwn7b0a6Idb6G9rkGokg96g4y4uGv?=
 =?us-ascii?Q?3LgXJF/yNB/yX5D/+C0/WEOA2BP4D0iDF8WGwaICo3G256TsTZk1XRvmKgWj?=
 =?us-ascii?Q?yZNE5Bg/yyjfmkqtxmpfR/6UV4vuhfeppWgkGkbR?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cf355c-165c-4efa-edf8-08dd3a260d4e
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 14:15:26.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+t6n/adI/Vo9n6qP6L77oJ4yFmHpw0NNmtAV3OGSzzTxwQ8bFtJTptFIX57r8mTvb+yFnilXSI+u15qBQf7uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1452

From: Suraj Sonawane <surajsonawane0215@gmail.com>

[ Upstream commit f10593ad9bc36921f623361c9e3dd96bd52d85ee ]

Fix a use-after-free bug in sg_release(), detected by syzbot with KASAN:

BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30
kernel/locking/lockdep.c:5838
__mutex_unlock_slowpath+0xe2/0x750 kernel/locking/mutex.c:912
sg_release+0x1f4/0x2e0 drivers/scsi/sg.c:407

In sg_release(), the function kref_put(&sfp->f_ref, sg_remove_sfp) is
called before releasing the open_rel_lock mutex. The kref_put() call may
decrement the reference count of sfp to zero, triggering its cleanup
through sg_remove_sfp(). This cleanup includes scheduling deferred work
via sg_remove_sfp_usercontext(), which ultimately frees sfp.

After kref_put(), sg_release() continues to unlock open_rel_lock and may
reference sfp or sdp. If sfp has already been freed, this results in a
slab-use-after-free error.

Move the kref_put(&sfp->f_ref, sg_remove_sfp) call after unlocking the
open_rel_lock mutex. This ensures:

 - No references to sfp or sdp occur after the reference count is
   decremented.

 - Cleanup functions such as sg_remove_sfp() and
   sg_remove_sfp_usercontext() can safely execute without impacting the
   mutex handling in sg_release().

The fix has been tested and validated by syzbot. This patch closes the
bug reported at the following syzkaller link and ensures proper
sequencing of resource cleanup and mutex operations, eliminating the
risk of use-after-free errors in sg_release().

Reported-by: syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7efb5850a17ba6ce098b
Tested-by: syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com
Fixes: cc833acbee9d ("sg: O_EXCL and other lock handling")
Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
Link: https://lore.kernel.org/r/20241120125944.88095-1-surajsonawane0215@gmail.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 12344be14232..1946cc96c172 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -390,7 +390,6 @@ sg_release(struct inode *inode, struct file *filp)
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
-	kref_put(&sfp->f_ref, sg_remove_sfp);
 	sdp->open_cnt--;
 
 	/* possibly many open()s waiting on exlude clearing, start many;
@@ -402,6 +401,7 @@ sg_release(struct inode *inode, struct file *filp)
 		wake_up_interruptible(&sdp->open_wait);
 	}
 	mutex_unlock(&sdp->open_rel_lock);
+	kref_put(&sfp->f_ref, sg_remove_sfp);
 	return 0;
 }
 
-- 
2.43.0


