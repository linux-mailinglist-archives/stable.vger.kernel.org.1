Return-Path: <stable+bounces-206261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3ED04142
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C3034AED23
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6AD35FF5D;
	Thu,  8 Jan 2026 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FIXd5Nse"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62035FF66;
	Thu,  8 Jan 2026 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858118; cv=fail; b=iDXXKmnjblRJoZdxx+p20h1hL/vXaqPHTo8qzMRJH+y9mP05suJo8sV1AzVBZ42mn5js4aS/lIllVS1+9+YMynfsqnrZ/ik+lzCtv/fUioB4NFyCwuPUhIGn5+pdwkyrpPDgR9AsGqeZMjjonhu/fVlGzqqq3xE/umw/yE7ZZuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858118; c=relaxed/simple;
	bh=4HrS/OjZKZWsnLP/VuBdtXAsjAE+0iI6ilQicJYn4Fs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LfAZjaUY3CsaBkW9KEXYuW51iHL6g3B7uiZ81NUUYN0sVznA3/CGR2QyommaN2RjnJ0hNsMUYsVAVt6dxxcfTLl+TiJXUTNDXc7sGN4xpEq7uhMEx1Me+X51FLU8Ox0BkZ0r00XIG1eZ1OuWb0Dub2caxMSJ61+aMToXMvuioLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FIXd5Nse; arc=fail smtp.client-ip=40.107.130.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mA1EETA6dB6HoVFgGNJ/Sex4yr115LwdteYUOkvbrt/aI0hlMiyIds6x2kiWzZ7B1OYq0iCQcVhcfZZz6j3z0jXoFfqhbHe85Xz+d7/KGDOz0YS/u8b2Q+umLJwplkN5zzhX4yd0YETJx+1iwYWOHCtj0p+QBADzNzxCM0IxfD2Ku91xOLF1JUX6KZRdyT2RNXaOR6io7sr1vYtRoquZofOTFK7ptvy08ynoKiUlybnzySfaoMNSRu8XaE0OesXhDVW1CWh7d34zcIOIwnou7npDdhIrFYcH0VDR7avfa/AMqCpeypuDp0XOD/KuZ6ldCenMJTGyUBZnt3l9iR6gYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xrZ6kkJJ9nQPlyVMgxWzaBrOMhZX5IHXf1B6eYjLNo=;
 b=M/F8DeBX8OBjgzYCpgHkcd292kiAzvUcpoa107slolj1zZ8s8bdxkf9s5cMd+5S/e9CbFykH773cAk/ZoHjBAZ6ObRb9jRU7pLqCM34IIhf2jcphzTy5COfz06PmH8BeC6fOMsGDPdAOrEhZQkKvoJg5KTh6WEczKv5TSL1ZnuhLA1pt+d5HC3W6MM1Nq/Pb066oA9WazFzYgEAECB32YpHSMcdCc7uifMpPf0q23u0WE9LWuHdjxx1wrfzk1oTumrx8+OdySmp7YiQR85/H+LAX+pPBmiyYzvUdMYq7oGZZGDD4y8ExiN2Ajifs+Z8h8/T3blonr+ys5eSTKNfI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xrZ6kkJJ9nQPlyVMgxWzaBrOMhZX5IHXf1B6eYjLNo=;
 b=FIXd5NseMKygiv76tRAsx+UrydHew5B9aRWx7Om7UekaChodC7vtMXDrgJpQLvFEBT1+m/QfdVm73rO+YwCMgo6jdZ8st9p4w5DyKoa4xCFF7OWBUgxg6qdfjnlua2K8qMVIFdlaJ7CpOENOm5y3zbMngG1XDvMv1c/mslmJqkOU+XGs9Km3HV8wiQoJLglh4VExlvFa/7T230ey5MHFyNLPo++kDDCimaco2ogXMxoDH6/NABjo99r6Ksh0FOKeZeXKFmeTdP+wU0oLGtTE3E6TuPxBUG57bzOMIVCw6a5b8Qdj8ZBlC2jNl4bOZOxfQZ044ZptRgXeiCz8kI/zQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 07:41:48 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 07:41:48 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Thu, 08 Jan 2026 15:43:02 +0800
Subject: [PATCH 1/4] usb: gadget: uvc: fix req_payload_size calculation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-uvc-gadget-fix-patch-v1-1-8b571e5033cc@nxp.com>
References: <20260108-uvc-gadget-fix-patch-v1-0-8b571e5033cc@nxp.com>
In-Reply-To: <20260108-uvc-gadget-fix-patch-v1-0-8b571e5033cc@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: jun.li@nxp.com, imx@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767858202; l=4520;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=4HrS/OjZKZWsnLP/VuBdtXAsjAE+0iI6ilQicJYn4Fs=;
 b=a4p2Z15ghZsszKphDTc1HwActGZAP3Lp38i7my+1gAhYTqVNFllvTXwe2Og7BaGp7HWSC5i0y
 HkiWb61kwbUAElsiB/d33Dbz8p6B3yuH8roUS28wxQuj6vXenoaws/a
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 44aea686-ecd2-4546-038d-08de4e89616c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWV1ZE9jUjN5S3NMY1FEUndUV2dTbUtsYk9FcHBGc1dtMzJHTElGWG9jSWZy?=
 =?utf-8?B?S0hwdy9uRmZLQ1pDTlBvT3R4QTBhc3dBZFQrakhEUkg3Z294ZWhwdVA4QlRT?=
 =?utf-8?B?RUxLalpMQUFiYS9wbTl2RktpbzZRUHViaDh1TlJyYlpyVWMySUZYOEdONi93?=
 =?utf-8?B?R05NR3BER2xCTTc1cVR3WWxJSWI5UlRUQ3J3SVBRcE1zUWNsVHhRbjl3VmpZ?=
 =?utf-8?B?L0JGL2U5SHI2TXEwSXBZcC9oeElCR2xXdC9qUHAxanQ5eXJlR2NvVzhhczVx?=
 =?utf-8?B?SXU1b2xlZ2pRaXpjekZRaUxvRFlSeDA4TjdXVU8wUHNkU0MyOGJKbFFtU0hr?=
 =?utf-8?B?YWtVT0JRSXVnSWMvMzlvRThxVll6ZWkxUnVteHdHYzVUWUtqSkh5K1Y0bURE?=
 =?utf-8?B?eVBXV1lxZk5xSGgyZ05GMEMzVDR1UXpJdUhYTjlEV3FhY3hIL0JNcHd5MCtN?=
 =?utf-8?B?SWhTcFkvcm9EMDB3N25GY0kyTzBObjhOdzRVS0pSSFIzaDgvN0p6SHJUUWpY?=
 =?utf-8?B?dllVNDI1ZWU0Qm14MjJyMmMvazJKZWM1RHJpbndHbnhBVkovd3FBUGswQlIv?=
 =?utf-8?B?Ri8rVDZvM2E2NSsydVMrSDhtemZXUjhNZmdkbXU4SGJlREpmUzhrTzU5L3B2?=
 =?utf-8?B?cjVrYnY3U3ZWb2FOeHYwZStnNytmMEd6aWk4R1lQSDlzZTlpSUdMSTk5N29h?=
 =?utf-8?B?VEhlc0wxRVZicEx4SVpkMm4wcGZDV3dISERLYVR6VlR3ekR5Ry9BL3N5d25B?=
 =?utf-8?B?YlBWUVd4UVZzM2diMkh1aURXTEhpRU1aYUI4aGg0N2VaY0N3Z1VqclhMSG16?=
 =?utf-8?B?czVDMm92eE45SytqcXVaS3dBOWRNR2RJQVFYd04xTERPdFhhMEppSkU5ZHda?=
 =?utf-8?B?R2JjMGFuZlVob0tpTU1OeFA4WDhIcE9nWHQ4SEE1ck9iNG9tTTJ4V3B6WkQv?=
 =?utf-8?B?bEx2Qno3NCtpYTJYdDMxdytMbEN2bGJkM09DQkJTREVYbG10NjFsMnczODFa?=
 =?utf-8?B?d0x5Zk1ZWDFpbjdpdUlNL1U2T2JQUlpraEtDbWhDVGxQSUMrdWg1Y3BPY3RI?=
 =?utf-8?B?UGZiN1NnMWVBaW9HRCtQSHg1blFMTDlYZVRPZVZmTnFCYnpxRWM3R09ZTUtB?=
 =?utf-8?B?QTZIN2czalJjUjZ1WUJnWWduM0tnT2Nrb2wveW83aDFhRWNhWkVDbGV0RzVH?=
 =?utf-8?B?c3lCbnEvL3hMQ25PNmVKZ0JYald6NDlXUmtlWEhGa3lsWVJ3U2ZMRjI1YURQ?=
 =?utf-8?B?N0U4TEVCNGt6OWdoWVlzVWEzc2llTGFmN3Y2RlZOc1hhMWUxaU5oUksxNHlV?=
 =?utf-8?B?QmxYSFYvenBhVjRnamVTb29iQk5tdlIvMy9oUHUzUU80bU11WGVEL1llZTBE?=
 =?utf-8?B?MGl6N1FrekZGZVNrNkpSbGVDc2lrR2VGVENiVEI4SHBYelBMbnlnRXZRdk1s?=
 =?utf-8?B?OXRSc1FkemR0Rm9uZFhIdDdUM0k4UXE4bXhCamoxejUxd3dvbzJkQ1FLQmhV?=
 =?utf-8?B?cjZkNnJ3dDJjNXpLN0pkM1MwbmYxTFdzT0pxQ0h2VUsvL0tDaW50elEwcVV3?=
 =?utf-8?B?ZnJabHQzOXFyaTJCSit3YlpubzZ0N1c3ZUhTeFUwRmJzaFdqWVZBZjQ0N0VR?=
 =?utf-8?B?TkNUeURHWWhaMjBmZ0JpcjRObkJ3V01XZHlIK2xRSm9yUFJRR0pvUDYxQ29Y?=
 =?utf-8?B?aTJ0TE41RENNb05iWHJGSm9WSFhGdWtHd1YxMWJWMEhYamNBSzlIQzZGNTRO?=
 =?utf-8?B?MmpzWWxZam1NYTEyR3hNZnlYZEh4KzM3S2p0YTFSZ2grcXZMRUVCeXFoUk81?=
 =?utf-8?B?V3lYRUtVT1N3SVVtV2c5M20xKzBySTdaT0p0bCtkSitrMjJrVk5qY1BwNnFl?=
 =?utf-8?B?WG9YenhiTWNDYjl0U1FsNmFzKzUweGN0MlBYK3B6a2lYcUpvS1VwZEJEY0pm?=
 =?utf-8?B?U1VEeDQ1R0huUGM2SFl1b2JPRWY2cHZ2cWlXUThSNVN5RmVEaTJBdGtmNlA1?=
 =?utf-8?B?eVlRQTlua3o4cCtmQlUvZEEyR3hEWTk5Wnh0UXN3RzN1VlhQNXpJWEpIVERN?=
 =?utf-8?Q?WpKAx3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejdVWDhHak1EazduTHRPK1dxYktLVmEzZElST1BjSFVKWU1MM0orQmhxaVVD?=
 =?utf-8?B?WUpxYWhDZnQza29CZC85bllhdlRPZEEwcStwVVpoOG5MVDJSWmYxbWVabUtn?=
 =?utf-8?B?Mk9idFhYTXFKcWhNNWRNekNrN2pkaCtSNjZOSXNycC9xb2hTY2hQWUxMNHpy?=
 =?utf-8?B?N3owREtNK2djRTBGcE0vR0hPRmxNTGJ4bmhGWmQ2dzBnb0pzTC9IQXJ1MEtk?=
 =?utf-8?B?eEdSRURWUDBJRGNKNERsRFJOQmxTMnc2TUczYUEwcW9XVDA5U0VyTFdZL2Zp?=
 =?utf-8?B?RVVFcE5ZMUVQUnlHR0o3LzFmdjB4dGV2ZmtOSFFUZ1VaWkg0VE9pMkVybG5i?=
 =?utf-8?B?UnNDcTBKVVpoSnFGendFb2syU1lSSG1FYUJvcDRObUR2M2hoQkpvdzhsZmVq?=
 =?utf-8?B?TU84NFFqMjlaMTJ2WWpQL1hYNGdEOXVZOC9VVThCTCsxSWJpYXhUTndydWNx?=
 =?utf-8?B?dWhGS2VEMlovczJ6QWhIUEhzdDl4bW4vdWQ5L05zTW9HMXBibFRNak5WUWJ4?=
 =?utf-8?B?QkY2K1dMMWVOYTg3RkswV01LOEoxbmtYVDlyNUhmbDFmSk95Sm1NeFhjR2lQ?=
 =?utf-8?B?K2lpaHhOSUllcnlOUmttYmszU3BuTk9XSjZYUW9aVlZJeHRkRVBJNU5pUkth?=
 =?utf-8?B?L2FYc1BmcEI4bXUyT0NWVWtWWHlOVjBiL2srdW1WQndZb3pQaU1FVFJpeExI?=
 =?utf-8?B?V3Z1elAwUUZnU1M2Y1lnVzRtaEw5aUtaRkZ0TjhQMSs2bUlBR25sa3FNQ0Vz?=
 =?utf-8?B?L0F3MzBsTlF3YjNjM29Lb0p6T3hOLzNEdzl3RStzK0VmWkY5TFhRbWtxUEN4?=
 =?utf-8?B?UFlla2VRT1NqZjBHSlJhRFMrb3llRzB2dy9LaUVEeEk4UjByaEJhenNyNG9O?=
 =?utf-8?B?SmxKZ2o3N2x3UkIySG5yYkJBdVpqWFVvVlVTK0FiejcvendTLzMyTkJvT2tD?=
 =?utf-8?B?RXAwZWl0WUE2L1BUa1JtVHc0SmFObU01cHV0UTQvbVhDVFdFcmF1clgxU0tY?=
 =?utf-8?B?WUhrOW9OdUU3TVQ3aVkvTld4b2I4MDNYZTdESmhTRkNkc2x6TWpuL29RVjVa?=
 =?utf-8?B?bERzWVJwSzRDTzF6MGI4dG9UY0E0NTZzcU4yRDkraCtTTktubWhNMGhPVU0v?=
 =?utf-8?B?aUZxTG4rMkZhZ28vcWhoSUxuVG5ZQm1SMEVRS2pOSmsxbXZmVitONnhsdW02?=
 =?utf-8?B?eTkvdXJtS2UvU0w4d1BBZFFaekhFMDhlZ1RYWi9JOUFEaWpXV2hTVktvZDFk?=
 =?utf-8?B?Ym13Rzd2a0Z1aG1jUksyWXRhL3RTR3dVQUNiY2g0QTJPNDM0dDBuaTh5dFNh?=
 =?utf-8?B?Rm5BWHJxN1hjWVA1WG9IaWQ1aE5FSU15UnM5dTN2bzlzYlUwSlh5UVdrN0k4?=
 =?utf-8?B?bEhQdlBrMUR6NC9ycWV2NytOSUxESC9NNVdLK0FhT0x2UU1INGtGZnltSjVW?=
 =?utf-8?B?eTN2M1VKd3FCdFdkMndhNkpaRkVJeEFzUnJ1STBaNEtycmNRc0hWa2NKejEx?=
 =?utf-8?B?RnpjdkZPZkhjOGttSmlVVzM2RnN3WHFKZGFaajVpWjdqSVlLK2lOeFJaYXlZ?=
 =?utf-8?B?UGdsWm50dmUvaFZsRDFQZE1hcU5XazFUTnQyOC9UcEJOMmIvK1VIRVVZaTNW?=
 =?utf-8?B?VktJSURZRmJUMmZsZXlZUWwzRGVEdVVDOWdnaWVXSEY5a0JZaEkwdGpyK0xK?=
 =?utf-8?B?bkM3ZWh0OTVGa2syQjlDUmEwYzhkQXlJTVdkc0lRdnRaY0hVNU1yR2pKTnVa?=
 =?utf-8?B?a2ZYTkFDVWlrQkphcDZDUnZMY0ZOUndyVnVVZWNHZjllcC9OZElmdkwva0Ji?=
 =?utf-8?B?cHJDYllvZE1VZHZ4VjdsaVdBUy9Td1JRZjdJQkppVkxQdExHSS8vQWF6STl3?=
 =?utf-8?B?MjJFd1l4a0JyVFZuK3dLdlRNNHVOMy9qRENxbFovQjNZY3VOelpzajltQTNl?=
 =?utf-8?B?VTY4a3VGTEc2Q3pGZGdVNXZKUEJFQ3BNelpzQy9Makk4b0txZEg5YWlBV25l?=
 =?utf-8?B?QWw1azZvR1FzQ0NkaVQ3ZFB2WUlnREIwTzZUL1pOQlU3cUg1YnltZ3NTQmxu?=
 =?utf-8?B?b0xTdE5XMldiM0xPN293MmVKZFNJRW9hSVptdWFOVlhxWis0UFZreDBqVWI3?=
 =?utf-8?B?TkY5SVI5emRUK2JqVEpLMGxoMWNxSVc1cldQTjh0R3V3SnZIcnUyMk05V1hZ?=
 =?utf-8?B?TUkrWUplSzlBQ3BlK2s5Vkt0dGdUcFdsRnV6RlBWRG5hR1VrdHFXWWtBT1l1?=
 =?utf-8?B?SGtwdm5mbjNzeUZYRkxhUVpHZHdkbVNQQ2xVc3pzcWhDdUtyeTVuQkhybE95?=
 =?utf-8?B?dHJlcC9qYlhqY2pSSld1UVp3N3Jpc0Z4ZS9BNjJpcXRtZDUxRFB3QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44aea686-ecd2-4546-038d-08de4e89616c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:41:48.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNd9b158mKnehZHBSU+8NxAAJJdD8B/PwByNyKqvc5ZgcxhAn2jtShewxHb5NIlriTMrX+8ijvM27I3KW7sp2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

Current req_payload_size calculation has 2 issue:

(1) When the first time calculate req_payload_size for all the buffers,
    reqs_per_frame = 0 will be the divisor of DIV_ROUND_UP(). So
    the result is undefined.
    This happens because VIDIOC_STREAMON is always executed after
    VIDIOC_QBUF. So video->reqs_per_frame will be 0 until VIDIOC_STREAMON
    is run.

(2) The buf->req_payload_size may be bigger than max_req_size.

    Take YUYV pixel format as example:
    If bInterval = 1, video->interval = 666666, high-speed:
    video->reqs_per_frame = 666666 / 1250 = 534
     720p: buf->req_payload_size = 1843200 / 534 = 3452
    1080p: buf->req_payload_size = 4147200 / 534 = 7766

    Based on such req_payload_size, the controller can't run normally.

To fix above issue, assign max_req_size to buf->req_payload_size when
video->reqs_per_frame = 0. And limit buf->req_payload_size to
video->req_size if it's large than video->req_size. Since max_req_size
is used at many place, add it to struct uvc_video and set the value once
endpoint is enabled.

Fixes: 98ad03291560 ("usb: gadget: uvc: set req_length based on payload by nreqs instead of req_size")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/gadget/function/f_uvc.c     |  4 ++++
 drivers/usb/gadget/function/uvc.h       |  1 +
 drivers/usb/gadget/function/uvc_queue.c | 15 +++++++++++----
 drivers/usb/gadget/function/uvc_video.c |  4 +---
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index aa6ab666741a9518690995ccdc04e742b4359a0e..a96476507d2fdf4eb0817f3aac09b7ee08df593a 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -362,6 +362,10 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 			return ret;
 		usb_ep_enable(uvc->video.ep);
 
+		uvc->video.max_req_size = uvc->video.ep->maxpacket
+			* max_t(unsigned int, uvc->video.ep->maxburst, 1)
+			* (uvc->video.ep->mult);
+
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_STREAMON;
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 9e79cbe50715791a7f7ddd3bc20e9a28d221db61..b3f88670bff801a43d084646974602e5995bb192 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -117,6 +117,7 @@ struct uvc_video {
 	/* Requests */
 	bool is_enabled; /* tracks whether video stream is enabled */
 	unsigned int req_size;
+	unsigned int max_req_size;
 	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
 
 	/* USB requests that the video pump thread can encode into */
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 9a1bbd79ff5af945bdd5dcf0c1cb1b6dbdc12a9c..21d80322cb6148ed87eb77f453a1f1644e4923ae 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -86,10 +86,17 @@ static int uvc_buffer_prepare(struct vb2_buffer *vb)
 		buf->bytesused = 0;
 	} else {
 		buf->bytesused = vb2_get_plane_payload(vb, 0);
-		buf->req_payload_size =
-			  DIV_ROUND_UP(buf->bytesused +
-				       (video->reqs_per_frame * UVCG_REQUEST_HEADER_LEN),
-				       video->reqs_per_frame);
+
+		if (video->reqs_per_frame != 0)	{
+			buf->req_payload_size =
+				DIV_ROUND_UP(buf->bytesused +
+					(video->reqs_per_frame * UVCG_REQUEST_HEADER_LEN),
+					video->reqs_per_frame);
+			if (buf->req_payload_size > video->req_size)
+				buf->req_payload_size = video->req_size;
+		} else {
+			buf->req_payload_size = video->max_req_size;
+		}
 	}
 
 	return 0;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index fb77b0b21790178751d36a23f07d5b1efff5c25f..1c0672f707e4e5f29c937a1868f0400aad62e5cb 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -503,9 +503,7 @@ uvc_video_prep_requests(struct uvc_video *video)
 	unsigned int max_req_size, req_size, header_size;
 	unsigned int nreq;
 
-	max_req_size = video->ep->maxpacket
-		 * max_t(unsigned int, video->ep->maxburst, 1)
-		 * (video->ep->mult);
+	max_req_size = video->max_req_size;
 
 	if (!usb_endpoint_xfer_isoc(video->ep->desc)) {
 		video->req_size = max_req_size;

-- 
2.34.1


