Return-Path: <stable+bounces-154355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683ECADD989
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE42B4A2DE8
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE82FA655;
	Tue, 17 Jun 2025 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b="gzzFt/4N"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022127.outbound.protection.outlook.com [40.93.195.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B62FA650;
	Tue, 17 Jun 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178931; cv=fail; b=ZB32Fe9RnxnIVp+1uqQBQ+NkS/RJQRjFSeDBu8vmnZXowL+bBKvMr0s9vLzYaK46/8y67l7gjhl2lQXfrY7jV7sP65hnEIGrYNy465Agr+EP7dKXvCIG94CkWYORLBqB+u5HzRyXDPNr1PjiNvRFgzi5wDj63IxxywPjNsuQc+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178931; c=relaxed/simple;
	bh=qSq1Rw86G6OKgk92QBYq9VmCVK4ej+wcqqbvv8OKZvY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T7tFiG7QtHI4EA2hiryDJG4viwriKtFsMjvIHf3q8qsPVDmSgjFciRzbPOjIEzSEcqKdpH+4EHIXBKBqIFmPkNiCokAJJjR5bEJ1AI4khDTCIu3JvwuBnRM2vnTvvcOfuxvtpDigA8dRnh3+sDPpX/nmq2wYUbHReVUYkmaU4g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com; spf=pass smtp.mailfrom=tektelic.com; dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b=gzzFt/4N; arc=fail smtp.client-ip=40.93.195.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tektelic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pi9hSeSDkcSve47qvwEy1h2jjznB4V1r2blubPQAJsdQ8a2g+L4XJpcCYbenLTR2WXpdlIbYscvBHJIvagQyh3jLeCPxKbxANojp8OOKO6tcvgMnXxm4//mn48d4C36YICvfBk0vPRVPdYFlXdbJVscemQR29NyboiSiGASY3DnnnMXjx+YQ+xr4GNiOB1/ozXEJTdzajqC/9mQeUPAQ9mYazxNfknVnP4ziO+CS64Wonc6Or/MIUVPYUq2dad5s4i3HjwnTaLvTVEEkz9DkPAaSp3Pfow7OKT7x7l0oawSFCpXsINsw6wcrF1H0x6hMncAUleauZ7oDXkRkUjKJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnREvnrzRa1a71IJj6tQF2kH0MBcSEDuVcWeDWY0xfs=;
 b=EoUku5yMNqhQqg85EpEiJdAZ5ErZo/yqUVPZfK/XUdG2H6ktMYkqLzuP5qHPQFAONa90UXaJY/JowpCcd8xLrGHS3KC/82TAGBP3a7OKSNjWdSgaKnDCSwc6NXb6ZJ55vYjal0yidlr3Hp3Rpv0F9sn3rzk9+pETx4y3iZc1oUbaQ1kf7o6n5Tim7t+rk/mSsgryT3H8VcLK1bp2/kz3ft4sIQ94dEPPfF9J5yWcrzq/FyTKNSIRUpPWT5mFhK6pqfF7AheWiq7PISjt9xpiJFUj2b58dpzvm0jk/ctWZpZDsS5oTFQQ9g28hlp+A598OAjMzOkNpN4RBK10wAN9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tektelic.com; dmarc=pass action=none header.from=tektelic.com;
 dkim=pass header.d=tektelic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Tektelic.onmicrosoft.com; s=selector2-Tektelic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnREvnrzRa1a71IJj6tQF2kH0MBcSEDuVcWeDWY0xfs=;
 b=gzzFt/4NNxHnmVcchKilt/ngwPbA3MzCWDiPLtxbaycVUe6XSQxYepYfsC0VjSCaJFvaqTyVm7U9xjh1neM/X9M7z+w91gW3LEydJgIspcySseBEfuqe1w0et0aOoNiIx+p3lb+3w4Z6pGvEl6U7vtxfCgBQ4Y141HKhV1+lhhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tektelic.com;
Received: from DM6PR05MB4923.namprd05.prod.outlook.com (2603:10b6:5:f9::28) by
 MW4PR05MB8747.namprd05.prod.outlook.com (2603:10b6:303:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Tue, 17 Jun
 2025 16:48:45 +0000
Received: from DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc]) by DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 16:48:45 +0000
From: Aidan Stewart <astewart@tektelic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: tony@atomide.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aidan Stewart <astewart@tektelic.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: core: restore of_node information in sysfs
Date: Tue, 17 Jun 2025 10:48:19 -0600
Message-ID: <20250617164819.13912-1-astewart@tektelic.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:303:8f::24) To DM6PR05MB4923.namprd05.prod.outlook.com
 (2603:10b6:5:f9::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR05MB4923:EE_|MW4PR05MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 09548a00-0cbf-49a5-cd6f-08ddadbed2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tBjOjFU4yM9fvFPOOKMctqJujjdNFgEinOS16+49Os9aL7YMJexgsX4iAM71?=
 =?us-ascii?Q?yL48DKEdIfmj9lde04G5Ch+bJwww7BZSE7Ks4JtwFYaC3YCQ8Rqbn2pVAFjV?=
 =?us-ascii?Q?u0+KFTwRC/5cg7p4PeJvyqnSZA6uwuBZxlebE19HFxe+jbpfu1vl/uD/7bb9?=
 =?us-ascii?Q?/N8Spc+YI5d52mjhswujPYmfIze1blZaq7oNk/BsaLofsdOu0r2NGSA/rVwa?=
 =?us-ascii?Q?tCnqYl4U4ECkLTjE8Lm6oG2jqwX1dxR4ECpVL75fK1UIm/loOtfvslPt59Ra?=
 =?us-ascii?Q?+Jh2DsWLOMjp1GwP4WqHcmzWddi3X1gm0miXzwGUeTNZ3edyeHwv0apZLqZw?=
 =?us-ascii?Q?BrMFOPWTckeKNvEV1mPkMUqSnCMHUvDDkMcf2a4ZZFmFZD3T8P7YovsWfcD8?=
 =?us-ascii?Q?DV957NauzOPDN4/vkR6YuzYWGXytPn3zJ/dXiZKZpBeAkte13uaJB+Sy+9mY?=
 =?us-ascii?Q?7QqxkV+a4eOhXqjIdeouTMs05wfz779vEski9YjsmgfRPn4XUpadTrQDh2ga?=
 =?us-ascii?Q?7bf2gu+3vRjDx4iZmd+UVlN36ZKzFwbgRegVFU7gF4HCeRecB3RPN06h0/e1?=
 =?us-ascii?Q?3l1+y+DLMdqhFyL7wOyrqOGXUnxZry1GmGtTNi8S8VlQO97D/YXxDS4BV4Qy?=
 =?us-ascii?Q?2/MVDZmpljzEUKNsIWAygh5T6RrEJWXoZbM9UfoeJXVNwFsnUkeo7yrigHax?=
 =?us-ascii?Q?T2UX4Llgji8CKEOsvkjA6Y5nlcrK1hzHFMQQAkZjCLoR57ezqVGp+S6fMAUL?=
 =?us-ascii?Q?IovgbVRA7hneZSySO9bm5wachDLVaKIaDXzjgbgnlT0mye6/VFM7P/+et0sR?=
 =?us-ascii?Q?A9VjDWS14ZqbxshVLa/GRZZFMegJ+R9Gj1utV8vAj1pGshxzsJfoINFQvT1O?=
 =?us-ascii?Q?Y2cD9+RAyVL9LJfGiAAxZdRblMQON7UIBF6DBHRhMTGIibxwt2EBq5iI5R6m?=
 =?us-ascii?Q?SXeariNiisVqPAWUgAOjMt6+t0r1/FUozKH3ho7fhNFDDcM61+fHNCN1azqI?=
 =?us-ascii?Q?95Ais8hRIQwyKUH9Ij71RkZ/A0LBb6FrL3pMpjDZK09hV5pla5Nd97aomPcf?=
 =?us-ascii?Q?ED0zOXFygI00LCPiVT9DAD76yZ3YsCUKqLsp2OIYt0sJ3F7Xsym4qWM8Fd6o?=
 =?us-ascii?Q?BUKHEOmckSbA3hvUre/GOx1i9gZmkaR62G4bA5aBkS4r6UBWqNkpZmP67jGS?=
 =?us-ascii?Q?rZIajXnVTLrf8KOR3MVVAIV01snVv/wB7pvWipK6EaEUFZ++S9AZ+iKFfOfb?=
 =?us-ascii?Q?/VLWdmMofefGneLK4P0RDlNxwBsU0/WGt+cVQwBj3nL3n8aq2tQRFJLh3G2K?=
 =?us-ascii?Q?EbFZZivdf/Nr1YspKXxxPmw9YC/f1I/k8lxaZfr++PCc5q1m9eA5b+Tf6MkL?=
 =?us-ascii?Q?9rFCtZRL71qR+Iyb32QGAgTlVtMyrPIJdMcbTyXhTJPeksbZjrn9Y/HhbJQc?=
 =?us-ascii?Q?7t7wFhFfUQ9XbE90RltaY5KRtkoNtPuQdV0Ua6CVOMUaeCc+MRdcfdRsruDU?=
 =?us-ascii?Q?v29TZd4jS5O3kIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4923.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ddMDX8ddpKh+sWU1aLvJmbmZ87NVePgLcooXanSHfjQIShMEfh/WQW29k7+7?=
 =?us-ascii?Q?CqFX1BcVlozDYnXjVO7l5B0hZTZmu57aECsQYRp05GAjHjp/FC+i/BMMEzZQ?=
 =?us-ascii?Q?p+cu4rnizKOVXI4NbVuFK+rMTUk4RY0f59Rns4rDGtazt6FI7u58o4A6HMXH?=
 =?us-ascii?Q?RZ0KLSQqqE+t4uZEB3vwtil1SeTubTsYmpIJoOqr+X79q4/hAL6Gr+a5z5YX?=
 =?us-ascii?Q?80UD2OMfZWB6JtvxUAp2CFD9glXWK0bzHqFHgmHqmQm3nlKNJZiVkNTEQsLm?=
 =?us-ascii?Q?p+h90eFlpXy87UfkBkbhPeOvnpzwn07fLVI6JeGemlHT1OmlEIvH4XiscQov?=
 =?us-ascii?Q?nWp9nhEJDCDPIw4XePD8CCXCiyv/tIQd4RWvhy9h756pEqJ7V0gwqtX2mNNY?=
 =?us-ascii?Q?eic1K0EB3n5wOlGG/2xww3+HURWsbcecId4sBoYYRKb8k0lHYn3jGN6WEfnv?=
 =?us-ascii?Q?3LdosvR8xsElno4NFKqPHvSUaxN0oC5G1Dlm+zrXRW5JvkiUhRiF3cF+ZjD3?=
 =?us-ascii?Q?HUkvZTs5Ya4QyZcTQdKhRZGzOsHd59p1OYEi9E9Ffqz6OrgbAhruklEHKHPD?=
 =?us-ascii?Q?jQRsIUC2HjoxLlsoZsq+pJTs1OeEnziFXjA32vZdnxBqNmHWcTPvmx+72yQz?=
 =?us-ascii?Q?AmNwX49S0M2L2qu5vTBLhbSBazPVD5V5WeL0MQP9rUTeeejONz5F3qHmtfPo?=
 =?us-ascii?Q?2BYsacNGy/AEAJyb183/OgiKjjYoYiD7SvGuAkvgnxgQ5tX1pmSaDAJfVm1F?=
 =?us-ascii?Q?zBbpI4s52ELWzoosqaLpwWkJXvgaqj1ojIh4A5pHsaVL+Lk11SG19IEsXqRv?=
 =?us-ascii?Q?e+wRuBxtAn3pA6OyOgllLjzzXnYTFV2F5BvN5USs8l/nkmVLIadrjZ53GRkK?=
 =?us-ascii?Q?ePIFct0Lh0kRojf+dcGrS3wPFVpxB7+jKbRJHFfh27J6YvLWXt671LoLAy2N?=
 =?us-ascii?Q?bmcl8jJiuj+x8DXoXsFspXUZQ2uY/FJkckou9210PblJxAr1GYc05GvWOgY3?=
 =?us-ascii?Q?AGvaVxAyX0W78Ho3owzNcurE5vD7iCJf2WYSK7KMSUZE+DaFLfy5ik12gtWC?=
 =?us-ascii?Q?Pi0TdiMy0QWRDy40hNY0GiVAWEtBC8x9arFfDz9/WabbFDz7N/p7vNfQsH1w?=
 =?us-ascii?Q?2dfX2fkhGpmT3M4RJncrd6u2OIMhPt9AaDp6OVj5QYr/z3eZWqy0DB3zLBiA?=
 =?us-ascii?Q?obzsOTEIXkOuCdrCg7OqvS5dLWE064sFz9vRLjbwwm88Emxd0bjJzSYOcD/n?=
 =?us-ascii?Q?IqgRou6AUMWFKlkz9Oq+DOp416lesEkf1Z3/TpR41b3ZrPMxwkWeIq2hu3XP?=
 =?us-ascii?Q?wAr9iMUWlLLa0niVXciJmF6kuow/+85ifCalcHXJWvkBmeCNa29CjvZVqfgq?=
 =?us-ascii?Q?epsbv7NytoIRuN446HLdA322j9nh5pyArhW4CKFri1vZheBdSeYEd6Th55qk?=
 =?us-ascii?Q?2I9lfBk4WqXoRHuywpCVbvqcUM6rxm5S2WEa0U8D26GuNZv0hMDiF3c/hlCF?=
 =?us-ascii?Q?rEUQD/IQAPst2LlPsa3ZsA7u/qfI8vYC03DoRpoD0D2FRSl5Z9oR0VO4Kodo?=
 =?us-ascii?Q?TU34BDkCFyVpCJqG35rhiXKfSPeNTEGW1vZk5aRG?=
X-OriginatorOrg: tektelic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09548a00-0cbf-49a5-cd6f-08ddadbed2de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB4923.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:48:45.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 852583a0-3638-4a6d-8abc-0bf61d273218
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPqguBsA2TWrCp90g3GpCEHw8r2r5xrCqLwTYAgZ9U8bhZxPNiRjCDDyV288T2ZEt2sl084K6+sCJ1YXIF/EiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8747

Since in v6.8-rc1, the of_node symlink under tty devices is
missing. This breaks any udev rules relying on this information.

Link the of_node information in the serial controller device with the
parent defined in the device tree. This will also apply to the serial
device which takes the serial controller as a parent device.

Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
Cc: stable@vger.kernel.org
Signed-off-by: Aidan Stewart <astewart@tektelic.com>
---
v1 -> v2:
 - v1: https://lore.kernel.org/linux-serial/20250616162154.9057-1-astewart@tektelic.com
 - Remove IS_ENABLED(CONFIG_OF) check.
---
 drivers/tty/serial/serial_base_bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 5d1677f1b651..cb3b127b06b6 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -72,6 +72,7 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
+	device_set_of_node_from_dev(dev, parent_dev);
 
 	if (!serial_base_initialized) {
 		dev_dbg(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
-- 
2.49.0


