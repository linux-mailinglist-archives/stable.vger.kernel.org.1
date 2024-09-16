Return-Path: <stable+bounces-76495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADFC97A31D
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E016B1C21CA3
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834715665C;
	Mon, 16 Sep 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="ffErRc6z"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2120.outbound.protection.outlook.com [40.107.247.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006B132122
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494914; cv=fail; b=nSa/HztWhRZEIP9umMlPqkzak36pT+orjwFUav88+TcE6hGZcMc6O4AR/W8bEWveUjZvjFAfHGpLrokGT/lGA/JwbnZdVqMVjoVWd/54gP4hxTbY3jkMZ8ATs4vCZcsJDNSBC5jeX5dK7WjLmPsxAVBO0CdkVoa+LkeKxc6bD0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494914; c=relaxed/simple;
	bh=Z40ctHiDCXNQQLwpSGFGg9j/OZdIbYyYlI/4rnvJ/44=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FNTjsxJ6fBmyx/YhdxVX1YkuCSGDbLlu5ex2agVtzcu9rNhgka2TM+0+yabePkdz09BwtDIbf03DnOkLIbmoZRBi/jO8wayz1b6EQzdF2FGL5lm0iyyPxKzyfG1fN5flFOGayBVARtB/yeYY9AUJEpTzQZ941exATjjewomoIh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=ffErRc6z; arc=fail smtp.client-ip=40.107.247.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDoHxWuQ+UITIVUENcOQqgXRuLYxcX6ZuL/cIQSSsZiCF6w0AIuk+ph6r8NNU9HpXcZG4k/ggSYXAhaHXutbFWpXXA2ka9NB4DY+pALLq4DHetEZYzRaRpEp+KkptmUtSISzg4VrTAwxLu4vkjb9z9AXtXYbWHso+GnSDAdxIP26y3+s67vZgMWeO1WtQ13cdua9PZwPpyZX9d1lBeSUuUPeQAqiAArn4gpybWQJEfGxFj5CTpPbMrXqLNtLL+48P2JGgLQwvOYBNf1xRjcKeOiyRJfNdRQcADRjNNW3W3rXwNEwxUOQUBl6zILcDafsF2iXWasBkyKaavBfOqGxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2mRKmc/cE1at0khLENF7A0e5CFdqVqm6S9ITar6HPM=;
 b=Mvu53nKiXI6mCWozZX2iATDuDmnVGI8n3hl+UI9qUrHqYyP4TeyumTgLHEUmBp/WOw/p6svdy3swQ723hV6nSvhSWF1EtDgja451uxcaDi0zQPrIi/QycxfbZi/6lqwTPuXC+LxjNWuKlifHRPIJezXBe8UzpQIALS1i374ZhjH7XP5DmKEh1fNlee75Yfvy/ZfK7mdv/6reyeikB9IrRdMTObv0nNEeASpmNn1qZ0hOaLbZ9izAlBF2G33+gc4qCDNNeEc0bWMcqlb3Kn+IKhE0utnUKGHn7g9FWAhihYpu/gnOOecXTYSQi50a8hPxVO+qHK4CHl9ql1k2QWH3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2mRKmc/cE1at0khLENF7A0e5CFdqVqm6S9ITar6HPM=;
 b=ffErRc6z2opO/lTzsuz/o7yiWn34auPwRRk3eZ/BJW4p28Gfzz5E6MGmnVeEcR1fg3RPRGtgBKL9n7TTEucNr4PhRTmDn0GZ/wFZ2dSRrP0tIno4mF6LLDE/bGqjvy61VT9GpCBYAbn4V8YBhJ4zmZfWmWT/cXIz9pKGuUgSzYozw8C/wEqI9wuHfqw/GRMyzTLz683mYV1vlcKiSpPURgELyKos5t0PFG4W6cTTzQAUb6Uvhh0uHiTIAB93sv2NErBKtNnTezw0skH7VH1Eu6OW8ttrtI8WObfvZqx8MFE5/CrwMzMdHquLQlGzIpBzHraQ/S8nf8XS7c8U9MmEKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DBAP192MB0938.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 13:55:07 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 13:55:07 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v6.1-v5.10] gpio: prevent potential speculation leaks in gpio_device_get_desc()
Date: Mon, 16 Sep 2024 15:54:42 +0200
Message-ID: <20240916135442.628720-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0022.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::34)
 To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DBAP192MB0938:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e559a23-193e-45ee-4b36-08dcd657289d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Ug3/R/EgkqWBhna+c4Dd/blqTZycVAEm+Xz0vVpGY/1VhRutCYaOqInvMIJ?=
 =?us-ascii?Q?dgzBpBlSb4Yl2/H/6hqxJmVbkYU602Qfcx1OoizrQHd1+nUw9MHaQGXU+0eE?=
 =?us-ascii?Q?pXebHxFdCmnTjyhmOgq40kbSZ5MZcxT8Rc2WaCH3QIxf8JXADeTppcCJW6RM?=
 =?us-ascii?Q?RF1u1vTGjvCv4Q+7Gg/8mgfebzXQoEeHJCoe96IzHfmhiqDBKS6XH2MK86AH?=
 =?us-ascii?Q?I/Un4s/tTjGNrR2AfN3PKnpemue8itPkNSQt49m7S41Vuty4hMYBHmyGRxvg?=
 =?us-ascii?Q?j5iRe2gCjCdpAa0NdRpeeWW+J71L1Z+ieCnTjAwKNWdMJZqghbDO2MEmO5bH?=
 =?us-ascii?Q?EQu7HiNoFtKHDQRDEMhwfafASXSGofu+epNcMarmfpY/B19mAT1ZVabDqeX7?=
 =?us-ascii?Q?2s6T3gIp8NgECOALMtxTLsgZphO1qh6cOR38gHW4MCpEwrbV9o/9zU1fYric?=
 =?us-ascii?Q?DX6hjgw4HcCYD1UT3ev2IMxLIWbYwvmVfopGky/+mfetEplQC4UoNmDz3g4q?=
 =?us-ascii?Q?4jNUTA5kI3f1Mp1boW9d5AQDfWE4xIO0oNNvpSpnEb4lBAT1kIbnNb9xABZu?=
 =?us-ascii?Q?317vwntyPsTuDNxkTd0DCNfxxw2jVqrWjKTH4QEfexJh2icaPKGsmclWJUrB?=
 =?us-ascii?Q?6Cet4nzlZFmOgLs+WDthr+A0siclJ+ljzpxaD7vesXO05Hu8s2r/c0Aj2Mqn?=
 =?us-ascii?Q?u7LCkdzWRsmGD9YldHI6cA0I/h44ranJBCk7OevNs3WDUBSkQmZPlmoFlAsM?=
 =?us-ascii?Q?N0QiCtBzwGd325kPeTqTTSXmDdMpke1Ncfkpo4/bjUCtDLpNHqdtnXMx9z3P?=
 =?us-ascii?Q?snzJR5sVmUMLPhQ2Ax3zyjRazOho5D9dA/zXM/0ngbEt5dXlWR80ZMVjWwaZ?=
 =?us-ascii?Q?BnllGPuu+GnxVUuTRUAUZ+1HQ5r72SRPVM7bHB97gU+YdKhVU+9MwmS5g/TB?=
 =?us-ascii?Q?3ZoOo+kr3w13Ct5XF8yAozpM6x50TRy8DSb0CJo4byeAXAwHh3OGtSexkO+M?=
 =?us-ascii?Q?XnnoWidOKDAixaIofCWkKiPSkZyqT88rWL/uENBZUMNKmxMaEbH+p7IRTnTx?=
 =?us-ascii?Q?8Tut9uRjEfGy1GGB2HFuYX1kHzeFgetScsZo2NryGc6zE856GkQUI7bj3lFH?=
 =?us-ascii?Q?J4WKie+DmLSAbf4kRxGqPk+ek1ezCnCrqhEukMMg0gVkTGXDWLgKmwAsanwx?=
 =?us-ascii?Q?z+TnGQ7KLcHH1JtVwEqCortUwAAFKRh65HwA6n0U7NsGd5hCom+WmFePORfk?=
 =?us-ascii?Q?0k9eijSWNzaenfSpE3ODrjHNBkf6F4hr9JJ+9L7Foo1D30Coyxjju3TzPXQA?=
 =?us-ascii?Q?Sz1tZ1hUsTVwgcFVqyBVO8H20GcTdJ8LhdBlp13ByCQxJS1RJtJjUwALSKz3?=
 =?us-ascii?Q?kHIwJE/VdEFG9mTldGy50T+YAbh6KGWazHxZNmUZMHgBR+dYXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?csv7UT562EoYcZPuNQhACzqCF1E+i337ZmPuW6oXkLpLRo7PfmHUK3UXiY0w?=
 =?us-ascii?Q?KPUaf8Sl3+CJ1hE2arqH2oLpkkwmj+bvcSTFjAjZ2EVYBPUgd25/07Ks8q+5?=
 =?us-ascii?Q?q79VsD2YSIa3dokbTT5Co8mj1m/wKgnm5JPobU44CJyLz/KX81GsAwA4FGLc?=
 =?us-ascii?Q?dJx8rXirM9bvm9XjNycyZaTX8FG4nMkDtdafeUR4VO4d7v0lXWL0yjc4Eb/8?=
 =?us-ascii?Q?6QpWXPwltskvNZNyzTDyOqipW+yXHjUwxlmJt+ImK/UR4zpBXWiY1BDMLTbS?=
 =?us-ascii?Q?73ZwrSbnUL+Seg2hUjJugnrDy25pvnYiZaft/C/r4Y+xdjnBS/sqgFhyWmdQ?=
 =?us-ascii?Q?JPB9HSOsTZLGSVcL1FbWJlodJEN5ObZ+BrtIPNUm1RSdtyxjS4MfqRLyfkx3?=
 =?us-ascii?Q?fHrcXObQpcu3s8hTjH/bzjRwdySmqU+LUKxGOHcuJinQStsGe062cvmQvYzM?=
 =?us-ascii?Q?Wy/+jOaFk2FLXvy47bw+AAZPua3wmQ9IiOiTsCJ+daQz0REZwi+5vETsJyJr?=
 =?us-ascii?Q?ExPmghBn+NOZEk01mFtmotiW16DbW3CJaFMsRWs0aDa69OZ4kH5fG0VF2TdT?=
 =?us-ascii?Q?K1o4LmO551sEVUqgj6XaQez9n0F0vAZuRm26imDeCAXXDgrjSrlXRuPBX4fq?=
 =?us-ascii?Q?janvw2EaZT08wd+zGHM8KYw37j7uh8pIO2TH2LvbBFMmNPKtnvElmXwIdQux?=
 =?us-ascii?Q?Qtug5phir+/F4A6L6yuCrK/BMi4vEDE8F9Qq2LEtVcRNzFO/1JpV2Mq6DW9H?=
 =?us-ascii?Q?wOcKCXGpYkaPk5zyAbub876oHcFyrzEDIjfjjMCtrqZfGT99gwVjx2Lhf4Sg?=
 =?us-ascii?Q?gwZx8p49jaH/ZQK3Updq5gEKC0Dx4Boy/QFKz6MAYqVnW2Ua8OPnn0MddIcR?=
 =?us-ascii?Q?OYkgeo9V2CCrvurBX5K1XxaqpnT20vHD1/u6I/8++al6yzMB4EnWpcPzAx/V?=
 =?us-ascii?Q?wb3F9HKuTcYK/QKa0xX6Hpbcg7g/dJTdLN3vqOO3YlsTIaF09OY79w3yFDDT?=
 =?us-ascii?Q?qx578CVjeK0xj8M/TjZEh5IYEbW6CzryPA2lqJGukQei7d3Xnqp/I3i3nxEV?=
 =?us-ascii?Q?Isxv/Kpx516/kQekFiNCxP+W9rX734net1VUGc/C+DplFZNcI9PyGSPTPo3f?=
 =?us-ascii?Q?dflr7wbPjULxLiBwqwkNs+T8/Q72pe7YD9x77cJZesBCYOJ2omQVNaUJnSaE?=
 =?us-ascii?Q?kE1+usUBFEVkuglo6lD7KU25M4Mg+vYAdg+hAFSnblA699IrwX2v70g6IqZx?=
 =?us-ascii?Q?fIBLdJAaRl7cIxauuMf+GqaN8ARychAZcwQEWLTyPnwzLU2POdJQNO6RRzd9?=
 =?us-ascii?Q?UsRYxSmlZoX05yD/Z2W7Y3AKMlMu0WAXF/ODC6g/EMLEtew82SnXm2XlLACl?=
 =?us-ascii?Q?r1O7AVqryJpIJq03EfJ66Itf29uUUmXKclJAEBztEZtxR1P5pkfjkWdNPK4X?=
 =?us-ascii?Q?ZAZPmruzDLl+2yI2uomfmWA8mH05W4+SQkIYoUG/T4SwnX7OuGACl3FWlWbc?=
 =?us-ascii?Q?s2TP8mEdnB9JXaP+MXzFPRL5qlQ4RtVeGnhKIuMttlOq35Gb0UX+z8yjknjA?=
 =?us-ascii?Q?RSM9iYLA0e9wGiVA6u88Szrugjiz1kgnooc6vKor?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e559a23-193e-45ee-4b36-08dcd657289d
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 13:55:07.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaB3uVtXuSJg7Tcl4XohllJ3YRQWRxaAnAzrBrWy7PUp3pZVhMhTR12B3XdlR7j0F8K/cHjzPU0Jxe2mcgKnjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB0938

From: Hagar Hemdan <hagarhem@amazon.com>

commit d795848ecce24a75dfd46481aee066ae6fe39775 upstream.

Userspace may trigger a speculative read of an address outside the gpio
descriptor array.
Users can do that by calling gpio_ioctl() with an offset out of range.
Offset is copied from user and then used as an array index to get
the gpio descriptor without sanitization in gpio_device_get_desc().

This change ensures that the offset is sanitized by using
array_index_nospec() to mitigate any possibility of speculative
information leaks.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Link: https://lore.kernel.org/r/20240523085332.1801-1-hagarhem@amazon.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/gpio/gpiolib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9d8c78312403..a0c1dabd2939 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/nospec.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/device.h>
@@ -146,7 +147,7 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc,
 	if (hwnum >= gdev->ngpio)
 		return ERR_PTR(-EINVAL);
 
-	return &gdev->descs[hwnum];
+	return &gdev->descs[array_index_nospec(hwnum, gdev->ngpio)];
 }
 EXPORT_SYMBOL_GPL(gpiochip_get_desc);
 
-- 
2.43.0


