Return-Path: <stable+bounces-152726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC755ADB6BD
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 18:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2773A37CC
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0912877D9;
	Mon, 16 Jun 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b="fhPl+bSO"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022130.outbound.protection.outlook.com [52.101.43.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F528751C;
	Mon, 16 Jun 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090947; cv=fail; b=Z66tYdlYG54j4bvri4VQSrBwj4Ht/UFRVGdVRScKyZPxtPlDiUtcUxGMb5tQEKGVW/zsvyjhuvhnOa/Il/Lu80I+Wpys/TEyxpBM6wlw92l7CejvWdhD9Ax6U9o2CZM6rm6XM9OyT15PWY4JL2d4C3VydrJkbKuQ4LvfNS2ajvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090947; c=relaxed/simple;
	bh=QrNwALWiVIgOA5j4WZ6AeKYzsf6xhGZuYGrBbebsASQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PRGnSOzc78rrLilpCiMz4VX8y/V5f4v9xH51FU6RdL82mOvZJA9dw3HcedZTek9dmNRKLK6gP2Uz5lOO2aoQKCbWPb7EWZCCAYi03H/Zia+qEZAFQkWfJzKmxoX2TVwGr7u+TVV/IsZWjMvSZodAbw7uhyNXi0iGE/wx0m0uwsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com; spf=pass smtp.mailfrom=tektelic.com; dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b=fhPl+bSO; arc=fail smtp.client-ip=52.101.43.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tektelic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2YBWdU9ES0DTYLWYh69iurA8kX4W2Kauk+4rOSqi26yx5iRIj2rRnhmTWtVxln/XQGHFF1IYG3ftkbWOM6XKO7mfSjldA4yJNC3K+GyurWmMql5pZmAAQd6YcrcAfkBQDWIwuFTqaE1C9YrYK+ZuITmj9WcAEmfcj8JWtj1xG8Pu9TcvGCE4mWXxVxPdrKm5g2eyP7ba5+KhFpZh0hIm199inWWlj0qr9IJ4t7xg4b7oHhrcjvEz8qjjRnmrdoEbvO42BPFzpnd+RJej3dP6WKVTQWPJ7pisq7bKywVuk9Jiw84oPSu4pf44GKyALAbeyLsuWG4QY3He1367jOPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6d52r1/0xuWewma9Z46gd66zBAiFKVxIv3OZ2V2kAk=;
 b=Uea8V1poACixHEzcqEbESAnsFBBQ1Ae4BfNUIzo+Ri1/tYj3+vT2w7WxOWLo0kQVcWqop7zRlnbRqSwhrEmaxxRJjVH1QMvMaval+P2YY0kpwqAfNvd+W5bTgjSnMg813iJQw9CPwnnEWQ3hdpEsJvnMdjbDGJBeJl8/zdpCXMkCAmrXrAJ1enFwO34CP6kyItVZaIIPnf1in2Y8X8sEj4FIa9DtZ1Lvi4iI6lATi+ZskFukuPlG4tsZGMXRsg/nE3RKjViFN6H8B9HTg5tpjxb/0MgIs3Bcjp7xPKnkns0hGGnO1RGiNGT4wzJWnpnCoA5+lLs/QMi1rdjeWAjljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tektelic.com; dmarc=pass action=none header.from=tektelic.com;
 dkim=pass header.d=tektelic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Tektelic.onmicrosoft.com; s=selector2-Tektelic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6d52r1/0xuWewma9Z46gd66zBAiFKVxIv3OZ2V2kAk=;
 b=fhPl+bSOXPrT0APgiKAg4zsl7RtK/yxG1xjTrbIMnCcZUoFieMELQCYRxSTl8Nw3C/oD1GcAKWjIyAuxR1B+14wD8cd/RJryDwDYqescqU0viqyn0rwioEOU94QG4jiQyFKCmK9NRISE+lZARZ34MRXNUJzmZ9bRx8iszfBTyYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tektelic.com;
Received: from DM6PR05MB4923.namprd05.prod.outlook.com (2603:10b6:5:f9::28) by
 CH3PR05MB10002.namprd05.prod.outlook.com (2603:10b6:610:122::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 16 Jun
 2025 16:22:22 +0000
Received: from DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc]) by DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 16:22:21 +0000
From: Aidan Stewart <astewart@tektelic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: tony@atomide.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aidan Stewart <astewart@tektelic.com>,
	stable@vger.kernel.org
Subject: [PATCH] serial: core: restore of_node information in sysfs
Date: Mon, 16 Jun 2025 10:21:54 -0600
Message-ID: <20250616162154.9057-1-astewart@tektelic.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17)
 To DM6PR05MB4923.namprd05.prod.outlook.com (2603:10b6:5:f9::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR05MB4923:EE_|CH3PR05MB10002:EE_
X-MS-Office365-Filtering-Correlation-Id: 093276e7-ea6c-4f9b-73cd-08ddacf1f895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M90rwLk64jtA4sAxEPXo0Gkl14ZtkvnNDnq2O8+XxoM/4aOJArKpmvMtYn2A?=
 =?us-ascii?Q?daIbEharrj7jKKyaFSBXojHBbGF249YRQRVzbv0DLNYeu9Z20bBKPIdsLAnE?=
 =?us-ascii?Q?Qq+XbrAI52q0zi0q0cty0si9bLlVGgmm5GuWPVToATEx/8unEB7d7YJWa2pr?=
 =?us-ascii?Q?kT6cmQuVgDsG96+S37AARF1YXjQyo97aqn8qs+G1VJw5V8oswhcLFvWth4n9?=
 =?us-ascii?Q?1yCJYVNHPQTcTFyiCUg2yCYMMqdAAVFTI366EgXm60KcXAkLKx8I2f9qaSqB?=
 =?us-ascii?Q?mXsaJu3YaoLp5BZk2I0ABX+6kzZpQcuhBVPotlXUmZMxg7c5jm/Pj40h95TI?=
 =?us-ascii?Q?DeXv+M6iRz26A1f8LufvdLjOcVL9JuFr/Kjw3So77t7D1pEPD9J2oYVFxNUV?=
 =?us-ascii?Q?6DJP0oi43g1Ss8wrQ5NoHN7MXDRmLj3kO892XBgBDFTd/dzSg2xIkiF8pY5e?=
 =?us-ascii?Q?a2BwrSKcmD9bjtZl7QpM2XOL3kGxIgv7C38NZsMCaKEaFbOzwsjZP1e8lgs5?=
 =?us-ascii?Q?Gn25OiY+C2jVjxv7CsfVFSRhtas5j+hpa4yZzFWmoC1mv49UsdJhlehgcsSi?=
 =?us-ascii?Q?XoRXrZBawRfM9kfHtP24M9WBlIvNK++I9QCxHGDJVUQFaB2W9hr0wTqcJIYe?=
 =?us-ascii?Q?9ww/bo7LnsAxkofe/2mAfjWL/rpVlLYiAXHIcwZ2QyKYOGI/czd0q4gnDct0?=
 =?us-ascii?Q?1vU2r8XYB40CCGE1uEgyjM78ucjPN0AfqGqF7w23UMi+6g1W72r2liOvzrf6?=
 =?us-ascii?Q?1jMJCyNuwG5VzD/IlUklIPy/Bx8wKK3SQBuVFYkqcaSsLcj/6vC/fR1Xeniw?=
 =?us-ascii?Q?cbfiw9vF4aPOrFT4XPJyczVHgRsE6TOQnZ79ZnHpQYumSmSGY/mnPvAFF1GG?=
 =?us-ascii?Q?D5soqU+4CBs7MSi3Ues5swlbukYZmkRpqX3GgC3wjdTtzOkO5np8j2KonlrV?=
 =?us-ascii?Q?8CyVpXgmzYpQYhJAdPrJim9Jy8LGWFd6zqBacO8h4qVgzIWPbT2zKiJlEL32?=
 =?us-ascii?Q?T+TH/rJotbBIgIpe2lffrTYvJdeTLdTFDxSE4l3Wg8spf//NrNWod6ABDs94?=
 =?us-ascii?Q?qHrT6w9f4V5k98RI8/bpZ5tt/kkghl3TUfpAxZgTSsB+F4qf/1IDn1i9/z46?=
 =?us-ascii?Q?5FDsCgjMLrQvTTuiJ3YVw+itgHL+bIkx15CmiL/jxobhP2NR0f7ehxi7wwoI?=
 =?us-ascii?Q?dSfaaQsZO/GTupxSbd6gScQx9JbXHM9eL8A27mx3ddbBy0nnh1myXCKGGWOu?=
 =?us-ascii?Q?1bUs0Es6Yx27DrOZxYKkdXJ7twP0t0E8K7QDDNCfcC6Yhg9ZDp30nhPHI/hp?=
 =?us-ascii?Q?JFI2GNbJRrjy3dUR3Dmd25M7aGj6DWkEnOQnTlStunUasLXJWavXqPDhACBe?=
 =?us-ascii?Q?Vbq7n4Lhpfl6x36j+jVAUc/Wilby7XvQdcyhA4m0HdGL9aJCyTF4kGsLk5z3?=
 =?us-ascii?Q?N8nsrTdMfAHmC2NLsElqADqfBojikSIbsB57SzGFDkCigwW4Kxu7jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4923.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDKAytRCzwyVMNXpienEx2q6LpQxyMNc5nbs94AYYdPiJ7hzgA5rLTDxWnSK?=
 =?us-ascii?Q?AgJWqXD8eMI03QZebJ56MhQzbNbdzSAlgFjS5/MVt5imixVdOJegysZCR7lL?=
 =?us-ascii?Q?8ZoKZtvfW6sjFJL5lBBS3erfw0EWQwvnefHo6nHm/77HnL9aLNmMR9Ec8629?=
 =?us-ascii?Q?bsyZErEvHYWLQ7QcZwDWNJxnS7l00D0pfolgX3IOXOF3zGJrjUqTzCL+tV/u?=
 =?us-ascii?Q?GInfta5QRVnLuQxlYEVCXUJlrleNbGsbQMSKsSBqlS7IC7vWG4tVTOf09unJ?=
 =?us-ascii?Q?HnLDg+mdrA6aVkJjmek0sDl6xrkCs65LaErmGaCHsFm3vJRVgfFDOH7G2QCw?=
 =?us-ascii?Q?dU+dSrsmQDYbDXnuNorAQ5i/4vC7wDqqpinYMUaB1tW0wHztQ6jBZL0riui/?=
 =?us-ascii?Q?qeNwE5s7cbQGNsb9q+l7XL/ujezRfKa4cSgsvRBFa7nSDKupg8DWbzhdyOM4?=
 =?us-ascii?Q?qg5GsRfSEm88+BnqrQidrLLD73aBuahfOVy3IFYP737s5vG6EflyQwGPirvB?=
 =?us-ascii?Q?Q5FL8yhZeWR1Wd/Xt0vav+xGqZ7YyobeFXDbM/R3CXXj3bvsyLgpTJefG589?=
 =?us-ascii?Q?gYmWw5i3QMWI348P3XbNRVjBEmoxUqbgo3HdkawOt+inJpmbV+vyGPywqww6?=
 =?us-ascii?Q?a4dwQzpRTqnJWySTzWTLGyL35Cu1jfgTw/FeuR2Q0nSjkXANOIgGWQGzaj7f?=
 =?us-ascii?Q?eoenJbQHPFmSYQSnljaWJ8i54Z9XiynxosshhRXJ94MTpjTF1QXf/+J2Dy2c?=
 =?us-ascii?Q?QLdtanlole8h8TO3qGA6gU1SH6q9vvPORyFrzaQiux1Kzh3H4uanKbvi551V?=
 =?us-ascii?Q?e76x83+qOMoUCkkRr3PkMSEgjl4rvMzStYc0nlW1AW76sGQzny2zOdxNRUie?=
 =?us-ascii?Q?dFaNboqdklYYCAizdvL8vVWJ8Fit/RPGzoIX8MjWCWpuVG55yK5JaeUnLSxK?=
 =?us-ascii?Q?4aiiuA9Xg05o6tkPDDjeJTnwRNZSsziUDXMVmLFUbAvvrZHzpwGQJ7DbtgmG?=
 =?us-ascii?Q?e151ApDoM4CAXQZKCD5qqDhMdCgmgPBa6AMMkHic0inRuyRytx2AJ4Kp6280?=
 =?us-ascii?Q?NCJoFamD6zYMjTTqkp+pCvpqnI8PgW1vv8yZqCqHXgrKmXcgF2qWOfpxk7W/?=
 =?us-ascii?Q?+ZzOWvWJVXb1+ce9vyaJwfFzBMsprr05JK3womOfz4XXpxVpuBMthkl+VWqI?=
 =?us-ascii?Q?iSQlHD0hwcEFnhatp7kcPZOKf8YUnMPtdD/aK/mO7KNmiY3OKPSdlidfyAZU?=
 =?us-ascii?Q?s7LI1UfhqRGwH1FP4l4yeF/WO/LKWkVVgUXYvKyQpuKxAumqaqwce/d4J+X5?=
 =?us-ascii?Q?FCElYYzEJ9S59iaCG0exGu/Srie7vc3Nz1f6nMsT6uvCcRT5aMd/ZyEOFt4d?=
 =?us-ascii?Q?zBxnFBxp9bHNJgTX9QnjfZeNMtuJWfKE2HkiP8kTmp9R5UmPAObeLkqd5Tn3?=
 =?us-ascii?Q?qSf8VXVVCHiq38KyPNfUPBdOfq2YeqI69oJHHax57bje3xlEjpkz2PJntG4x?=
 =?us-ascii?Q?lBt3t+76Zz3E4S/+hEEsdOs89TTVutpdf+otLKIsBpbbNV0d0amsq8EEpA22?=
 =?us-ascii?Q?3d3PSo6qHfnvNKUpW9QIdecC0D4nqFzQmasgftXI?=
X-OriginatorOrg: tektelic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093276e7-ea6c-4f9b-73cd-08ddacf1f895
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB4923.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:22:21.6280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 852583a0-3638-4a6d-8abc-0bf61d273218
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9+aZ7sdZCIDgfCDTnH0YVHprV/LytBPZ+2sHqY6NFGm09LQIqlj27foQDRnBXhMsAVRYEdQMitBvo1bgEg1OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB10002

Since in v6.8-rc1, the of_node symlink under tty devices is
missing. This breaks any udev rules relying on this information.

Link the of_node information in the serial controller device with the
parent defined in the device tree. This will also apply to the serial
device which takes the serial controller as a parent device.

Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
Cc: stable@vger.kernel.org
Signed-off-by: Aidan Stewart <astewart@tektelic.com>
---
 drivers/tty/serial/serial_base_bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 5d1677f1b651..0e4bf7a3e775 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -73,6 +73,10 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		device_set_of_node_from_dev(dev, parent_dev);
+	}
+
 	if (!serial_base_initialized) {
 		dev_dbg(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
 		return -EPROBE_DEFER;
-- 
2.49.0


