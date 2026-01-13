Return-Path: <stable+bounces-208258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC1D17D01
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C858304B05F
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419034BA56;
	Tue, 13 Jan 2026 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PwABNjTI"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119C3168E4;
	Tue, 13 Jan 2026 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298030; cv=fail; b=WB1qhES69av0w1bD5JcDsYl1quY+PGbDb6G/40LhGiBucHOMfvRI6dxbHSkn58Mvm6ZQ6nVGtJmW0MaoQ/0F9D50YKHi67Gg5KCL7hPo6Mv3OQubUpjCsvmZrTBXRRHIT7eJmKYa/8fXleF2/0cXElgHH3s7Zs2QteZyMSPZO/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298030; c=relaxed/simple;
	bh=/cvDuOqraUmTX1IF+Mi9AlpDpOmNp21Krck73UwK1S0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YTYbvPbpWO+78cMQ7U24+Hcc9kzVKqC5JJdrBNDIU1M1y8ftRQ/KoeGN/4QqBZ2hKb9U4vvYrzF+844hEpAn9JTYhk13jDT+5XIBYlnSoPboApBduQJXygdFHL75E1V7zJpM1qJQ9Zx8SAg5vhEqx+xTiDda1QHxq5Ug3lNW10Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PwABNjTI; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFlPdE3WsIA8pWABHQO7WzhvItYRuIv9tYgbYoXv6jefnNszHMm37o7BIYO6jtjlzQYVNngidVUf/ByyC2PKIlz73Dj96cDC+yP49UC61LPIhdP4w6/HMgExqwXabhnxoUfGLb/KV29YhhKQTwbCRYTey3XcFN1Us+jyEZichD1z0/iwM4gNP0WW5ZuJKi+Z1Hx8/sJ82u0fWFUGz32KHdxzCaWAV/hboJPRX+atpeiNXQSP9hKH4NUkCcrETDORXYyvFP0g58knpcMClvhj1xRDdX7X5Tc0F07lcK/4psobD0VSUFry9qLS3S9xdhf+okdNx0yRma92qpNrAQZ3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXhB+5CHpyAtvOK6kcfqqvq4ZuuW+6X3kbKp1s2oRzw=;
 b=I8/Yc1NPlusjuoGe1R8sV5qJcukgbq9Iab/BVbY20EQN7kDf4l1OfYiOqqW5jXV/tR7XbtjlWoZukZo4KtPBdikZEtroSoRDoWduxYQeay4kKMwtI+MatqwXRfIXe11xPgnHGylaLn+12YlO2hzYq5rGlftLCUNXBmZ9pGHd0voRhcNrLqzOAH/HmVNesivO0+RvjE21/N6et338+N8qR2jN+ef8WapZT5q2XC4ajGaBPgPAw2Qh9+zIWUVlpBEhDkU1w5jxJD5eSjXRIew0yjUOYf4vzx0JSTz+yESYYrmCl/E4yZjuJlue/uhyvhf1sOM3qRLLDwz8g+7vqcr02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXhB+5CHpyAtvOK6kcfqqvq4ZuuW+6X3kbKp1s2oRzw=;
 b=PwABNjTIfSGmkx4zrj2QNzXCW1RwFqrKCMU/EsFnJqHZJ77z5oKd8GUh48Cc7ogpK+liBpQ4E9nP02SVVljWTw8OUytlCMPZlrVQrquW3G8G9Z9rsmUXzJ77TVIhPBjb7ApjAtWTk6nEHZuarFcv+ghq0gRj3QrfJGcI8mogg3wbxG+AChRSCQWzYKaaZrqV4wAZIV0F1ujmIJHS+wQASWHXfs8YI34wJpuv385cKdSj45fR/+01hRG170MXIdDA60PJ8s2wxt27gZdlvPmgx8TL8/YpM6UjTRRu5z8xmr73GgCq1VqulqU9dCaD137Hd1xSk9AL9nstiCAb5Svg/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 09:53:44 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9478.004; Tue, 13 Jan 2026
 09:53:44 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Tue, 13 Jan 2026 17:53:08 +0800
Subject: [PATCH v2 2/4] usb: gadget: uvc: fix interval_duration calculation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-uvc-gadget-fix-patch-v2-2-62950ef5bcb5@nxp.com>
References: <20260113-uvc-gadget-fix-patch-v2-0-62950ef5bcb5@nxp.com>
In-Reply-To: <20260113-uvc-gadget-fix-patch-v2-0-62950ef5bcb5@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: jun.li@nxp.com, imx@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, 
 stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768298011; l=2438;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=/cvDuOqraUmTX1IF+Mi9AlpDpOmNp21Krck73UwK1S0=;
 b=sQ6FnHsD2Mzzj7bAxvHJEnNletHh8tR/T+pP+jySmgvgAebAmPZexFa8tD66t7ayj+d7DaA96
 QokVYcWGgSqA2dZsVIabVpyqew5h3TF+Xra7k2sGeupTXIB+o8sv3HX
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d90f3c-7717-4ded-3177-08de5289a37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGtDNDJlblQrMnhKSGJ0bFZISzhGNTFkSHIzdnFab0xFb2lYd01MMkd4cC9J?=
 =?utf-8?B?dWIyMmw3TVpXQUcrb2JPM09GQjVESHFqM0M4am43Zm1YYWtSbDJUUE9nSEkr?=
 =?utf-8?B?NnowMVF3a1VobVZub2I0YU9QcnBSemZUS2NYRTVzdFdzcVNVNkZtb0JJV0ZI?=
 =?utf-8?B?RWVvUitTL0x0N2k2dlVkVi95ZWY2MEpYQ0xzcVpIczR5SUx1ay9RZk5DNWNI?=
 =?utf-8?B?Y3p6UEhhZW5DRmE1bzhyWk1pS3BBN3JaUjRVOFVQVlROeGlJMkV2RkJ4WThV?=
 =?utf-8?B?KzV5TFYvZTdtU0FuVTVkM3NoT21IeHVidGJ3b2hEUGM0U0J1dU8rZ09RNU1Q?=
 =?utf-8?B?aXdLbkNJZkdsc3FjcCtCSW45MTdKZmNvUmREOUZmSVVUZDRlZXIzNW1jYisz?=
 =?utf-8?B?Ym9KaXVHcXlLOVI0K2M1SlpYS2ROZmVsb29zOUVoaUM5NmZLeWlpMFV6L2tK?=
 =?utf-8?B?enZSQWx2QTlGb0hrejFYWTNwY0REbE5KNUxMZWNta1BnZUVxQ2RRRFVkUERi?=
 =?utf-8?B?enMxMk01VXE0eC9VQXpYdGJGOTlNVkdkZXhrWEppSmI1MVNoMjg2d1EzTG1y?=
 =?utf-8?B?a2VIbFE2VXRLYTJ1OFJFVStKYlZxU1NDWm1KNHpBOUpvQWpCQS9JVFRJa3NU?=
 =?utf-8?B?OFRVL1YvL0VURnB4UGhnY1ZGcWFEcU1ZZmFZT3lETW01elUxZWEwS2ZqTUJZ?=
 =?utf-8?B?MDcyRC9HV2kzdVNjRkc0YmFrNWkvcmhxMEtqZjJ4ZHNNdUt0eGtvamd0U1Vr?=
 =?utf-8?B?WTVjMmJ0Sml0cWpUTlR5WVNEUUNXaUdsSWplN3B2Y0tVc0NtdUtZbVhsdUwr?=
 =?utf-8?B?akttdVBtWjREZ21LWkZJV0hxV1dsdnJicDRucWs5bkNSOHlqcklHdWRuSmtK?=
 =?utf-8?B?R095M2paOVN6enhoRXhLcHFuYmhPTlZXUndoSFAwakNrcFVhQXB0d00wZTlX?=
 =?utf-8?B?VTZNS0hPRTdZUUhXSGpseWpMWVhtZTAveXVWUnZxMTl0Zk5GMDhNalhLY0Jq?=
 =?utf-8?B?SEFkRFc3Mm55a09rVXNpTVZGaDNQWWhDTHljVmZRS2pNMWVoZTF1eVBBaVAx?=
 =?utf-8?B?eDRXMDFUQzdHSklLem0rbjI5V1pOcHhVMFIyRG0vTDFabjlRRnU1STRKNGtO?=
 =?utf-8?B?bmJpTkVwRCthOXZTMUMycGJ0MHMvcERGNCtYMC8vZERIdnZIanhrYUs4R2Y2?=
 =?utf-8?B?VlNmUTJ1ejh5Q0tWWUx3LzFiZG5DOGpqRzI1WDh1WEs5MFBpbVZCcFI2aDZo?=
 =?utf-8?B?ZWVjUjJncWtQaXNiUGZDbEtrSFltZWFCc1hHSVRLZzZXbllXV290NDhib3Z2?=
 =?utf-8?B?Y2RESGRob0hYUXp0WTJXQmg3SS8vZE9aN3I3SEwzSCtPWExBc2VLUXBNNjI1?=
 =?utf-8?B?UFRQVXJSTmRKZk81dm16UE1GUTUyeUxYSnA5QWVrT1RnQ2lFcVV5eUhkNmJM?=
 =?utf-8?B?c045R0k4QVBSTkZVYldHYXY4VUtUQlNLQVVnem9DUmxheHBJcThHQzkwVjB6?=
 =?utf-8?B?cVlHMjNVYnJNNGtWSS9DcjJFY1I3RGZVY2Z3WTRnTXlieE5iWU4wRTM2aFN2?=
 =?utf-8?B?K3Fpb0NTSXpVZXI0b09VelU4SHV5bDdHc3kwVjEycWZnbzN6OVlrd3FpNnlX?=
 =?utf-8?B?SS8rYkpxNkNkRkQ3SDNsVFo3TXg4SmZGL3NiWGNHM01acEMrSG52dTBXRTls?=
 =?utf-8?B?MjBMRmxjRkJLL2FnZXdtQmI2YXozOExlSngralRGTzZkVzNya0N3aklkSjEy?=
 =?utf-8?B?ck81ZFdtbHc2enZja00vbjA0cGcvYlNqRFBZTER6RjNzT0IxNUtMdGF6SExu?=
 =?utf-8?B?TkZoMkNyUHNGejhmbThjTnFsY1dJbUtlQ21sbmt2eFRsMm1VemgyRDg3cndC?=
 =?utf-8?B?NGhaYnRFU240YmRLZElMb3JiVEp3YmZyMTdFZjNXa3dScWRoTW9ZdEhETll6?=
 =?utf-8?B?aWZmdmFDZnYyVFN2RWVlT3lzMnVsbkhPdWg3bXhHN0dvUjQwbER6bzJWcGg3?=
 =?utf-8?B?bnhVODRUYVdJSHJXRzg1SkZuOU1vaGZyQzFyZWJlTTg1MGtPZE5lbkFaN3N4?=
 =?utf-8?Q?zLnCrZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVJKemlVWE5lRHhkSHBEL2RrZS84bWlDUkxlUFJQTmNITnh5ZG52VmdacVNi?=
 =?utf-8?B?Qi9oTFhVTnEvOHl2RWxXRUhPb1BDT0NZdDZBV3BTbGVOZHJZV3FaTGxLNVJn?=
 =?utf-8?B?Sjc3a0orWEhWdlhTMVRhNm9YdHNqVTZ4dFBjSDBwdFVYMlZxdEFGN0VmTU9C?=
 =?utf-8?B?KzFEb0M1MDg1cy9QRWZNdjM2U2JwVUFmSC85VzZMOHo2RFFvbXNZVDEzYWFU?=
 =?utf-8?B?K0R4NjZuK3M4RUFsYnVwRU1CNTlkckdPa2xEeGg5RE90T1dGaXhxYU9UZ2pp?=
 =?utf-8?B?NmthT0lDRHUyaU5rbnpUVUV6bjl5WVJJTnBzcDlyZVNHSkNlZExoMFpwSmdi?=
 =?utf-8?B?NWNPK1Q1Rk1DbUZuUUN3ZTBYSGY2U2ZrZ2k2QzFJK0N1aEYxTkdVMmpTR2Rm?=
 =?utf-8?B?dTBaeW4vU1NHcUMzVS9uTThWSDEvVDZia1VpMzNOUTV4VXQxZndCU3JaR29B?=
 =?utf-8?B?VDZCYTlIZk42RmZpa1RsK1dXWXNLdXg2WkF1cjJFT1ZsbXpsRHhaR1ZEZi93?=
 =?utf-8?B?dlFnU1JtclhHS3pMQitQQmhGaUpmQUtsbnlIR2wvcjBUejRybHAwbTBWSEth?=
 =?utf-8?B?NGI3Q3FUQ3JTSzFYTFN0dHpHUXF6UzBHNUp6UCs3UERaSlV2a3EyTnZSWExU?=
 =?utf-8?B?SWl2VkFwQTI5Qkk0MGRIUTNSbTNrNDI3OXJZM1A2MGdYRGQweTlJODVmbnBw?=
 =?utf-8?B?YXFUNGdFa0NraUNsR3RGT0NwTzlYaFRwMGd4dDY3b2orRWlDa0g5MDFPNW55?=
 =?utf-8?B?Z3JCci9PM3ozYW9qQlpNT3NiUUtYUnhZNzVodnJYZXN1b2VtMUdaV2poRVho?=
 =?utf-8?B?U3pKanhEeTdBSXVWQzNiSEt4R2NSeEdrNkZ3UnE1ZEdwbThNZmlKdHNrWkN6?=
 =?utf-8?B?TnM2Sk8wbStSUlh3ZFdNNHdLUDd5ZHRnVTB6WWVES1dvelFmK3VydDBYR0Vt?=
 =?utf-8?B?WnNiWFVpNlR0dmlrVTdoampXWmIvSU11aHlway85bmUrcS94anE4SjFXWnI0?=
 =?utf-8?B?Njgxam5XWk9VR3lTVmh5bVpjYVVZY3Y4cXMySnNhVGNlWXNhMGxrOUc1Snds?=
 =?utf-8?B?bjYrSEUwblBLWDl4UTU1bm1ERDE3N1pwb2ZsQ014SzJiVndud0Y5QXExaHRF?=
 =?utf-8?B?S1YvcG1TblN5VFZHaTk5VDUyaHhzcEMwVUxDWi9zM2FWd0wzMXFYSlhqR0Mr?=
 =?utf-8?B?R1h0dGpwRzkvRm9NbU9DS0dZTXNBeitidFFFcG9qS1lRaTRQZ290cXJLeXJH?=
 =?utf-8?B?ZXNGWURrYzdvbGt5ZHIrak55RUpIY0RvbDgwaU5EaVdEZ1U0K0xUSWpuNXZj?=
 =?utf-8?B?d01MVENJYUxnTXY4dnkzcjFYaGVTem9UNnVGczFlVXRGY2d0T3grZVk5L1pm?=
 =?utf-8?B?SkhQa0trVkliSk1tRGVVYm1ZQ0lZZHQrSGJWYmNPS2ZwanRrYnpzWnRzMzNq?=
 =?utf-8?B?MSs5OXJseWhBbGhXbUNmZk53elhvbXF5VGdjQlJwTk5OMisydXhKRE02N2FW?=
 =?utf-8?B?bHhNVkpGNkFZQ0dOUENTYkhybHRrZW1pTjBWa1VCUlhGK0IyYWZSOUNGWUhz?=
 =?utf-8?B?WjgzcXp1ZVFJRktqcmdiV1NRMUJnNGxieEMvdlVES280eTdzbUpaUmF0Tlp4?=
 =?utf-8?B?TlJWY3BadGRIM1hQYVBRNjljMmo0anM2ekpTMU5Sa0tnRXRIQUFxeGRvTEZI?=
 =?utf-8?B?MmkrTTNoa2NaMFlCOHA1czZRVzl2c0U2aTdXQnJBY3Q3UjBPbjYxTGhhTjNV?=
 =?utf-8?B?UDVwemgwQjRoUmF0Zy9KVWsxT2hBUEd4ZXp1N2k2UXFadTk0bUVDa0MzUUF3?=
 =?utf-8?B?MkdyN3hYdUVTMmttRHRUUElLTlgzZkZFNHZwVXB0UU5McWtoRHlWVDRhZ2pI?=
 =?utf-8?B?cmdKTkUzTXhjeUwxcXp1ZTh5SmVENG9uWXpXN1JyS1MwenlFUjdiOGxNWXha?=
 =?utf-8?B?TDBVOS9VUk1adUhEczJsZEdjREV3S0lCVXQ2UEppY2ZvOWRvem1QSmloWGJj?=
 =?utf-8?B?VExzaXVDczdxMU5RUm9EanVmSVErY0VTS0RTSC8zWWZpR3JLRWNkZ0lETERk?=
 =?utf-8?B?aVo1UUEvY3FjVDhWMFp2V0Q0Y2dIVi9HMHh6Mm5pWnY0aGp3TFBEVG03Skp5?=
 =?utf-8?B?ZlZCa241U3hHVzFVR0VrZ1dmWXlFbytYamZKcCtlNC9mTXBMeGFXZkNmOU52?=
 =?utf-8?B?T2drQlQ0QjN3TDN6TW5rekJOSXdJVWVCZU9lYXZXQmtxckFWRSs4MCsxaEY2?=
 =?utf-8?B?S28vVS90bUYrV3hKcVV6ZVVZbDc4Lys4dFJxV3FVV0ZDcUFDNDh5d2U2MUNy?=
 =?utf-8?B?UU0ycjlHNUEwMndJUEhhTkhJaFMycXRIZG5SWHEwYkRrOXc3aVJIUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d90f3c-7717-4ded-3177-08de5289a37c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:53:44.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gW0WrvKL4JwZDvQKsz71+W7yPCpD2OIQyx5vVFaeTmAFMEezYZgIIfXbNdTxIg76JtpOy8b+xJ/4+OQCkdJBmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798

According to USB specification:

  For full-/high-speed isochronous endpoints, the bInterval value is
  used as the exponent for a 2^(bInterval-1) value.

To correctly convert bInterval as interval_duration:
  interval_duration = 2^(bInterval-1) * frame_interval

Because the unit of video->interval is 100ns, add a comment info to
make it clear.

Fixes: 48dbe731171e ("usb: gadget: uvc: set req_size and n_requests based on the frame interval")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
Changes in v2:
 - replace int_pow with left shift
 - add R-b tag
---
 drivers/usb/gadget/function/uvc.h       | 2 +-
 drivers/usb/gadget/function/uvc_video.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index b3f88670bff801a43d084646974602e5995bb192..676419a049762f9eb59e1ac68b19fa34f153b793 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -107,7 +107,7 @@ struct uvc_video {
 	unsigned int width;
 	unsigned int height;
 	unsigned int imagesize;
-	unsigned int interval;
+	unsigned int interval;	/* in 100ns units */
 	struct mutex mutex;	/* protects frame parameters */
 
 	unsigned int uvc_num_requests;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 1c0672f707e4e5f29c937a1868f0400aad62e5cb..9dc3af16e2f38957198bf579987f4324fc552c5d 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -499,7 +499,7 @@ uvc_video_prep_requests(struct uvc_video *video)
 {
 	struct uvc_device *uvc = container_of(video, struct uvc_device, video);
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;
-	unsigned int interval_duration = video->ep->desc->bInterval * 1250;
+	unsigned int interval_duration;
 	unsigned int max_req_size, req_size, header_size;
 	unsigned int nreq;
 
@@ -513,8 +513,11 @@ uvc_video_prep_requests(struct uvc_video *video)
 		return;
 	}
 
+	interval_duration = 2 << (video->ep->desc->bInterval - 1);
 	if (cdev->gadget->speed < USB_SPEED_HIGH)
-		interval_duration = video->ep->desc->bInterval * 10000;
+		interval_duration *= 10000;
+	else
+		interval_duration *= 1250;
 
 	nreq = DIV_ROUND_UP(video->interval, interval_duration);
 

-- 
2.34.1


