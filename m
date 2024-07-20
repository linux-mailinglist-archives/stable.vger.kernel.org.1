Return-Path: <stable+bounces-60629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B920593819A
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 16:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE2B1F217E5
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5012F385;
	Sat, 20 Jul 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="XzmtDhg1"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023077.outbound.protection.outlook.com [52.101.67.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D01803D;
	Sat, 20 Jul 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721485174; cv=fail; b=Sh4zN8Qh/EL5I8G9wjeeUfm27Js2xC82cJ7ynR8LMiCLyOk1WKNJAZUxwZUCuCxCWKlLeDgtg6VkAuyGDucX6P4KK3JZFHLH2k3T4siuQ3A3Mp6BaAvV6LpSSXXjfg0eesE1HmcgN0+iaZqxgEuIGS+4cPHoDUvEAMJCSveJtDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721485174; c=relaxed/simple;
	bh=XZdndDHDzq/As6q9toqoV4n9FkGScScmGxcqu1cBJyg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sMhNO9VUpe6jARV6bI5TvgT5+ygWD2gOMk4JrSlgAE6N6x6bw9aZsBCJTnf0H7j3/8poUQlhL1Nxpz7M3F5DQg3ZK0vBkaTIZRWYqPwHdCcsK2nh6GcfHh8scGc1/jppn9q6n/1mR2Zp+OCP7I6MrUofWXvLXZFbKT8udTw+KPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=XzmtDhg1; arc=fail smtp.client-ip=52.101.67.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3bG6K7zWJVdC6R2qMLppTTqHXSAQ9KTrwsNAs7d82FEIOgn5ladIKUyBNZ+UKRYU9QOveQQkWWu5U+/PAFeocXBpoYyYLJWIMF2HQnvaruMsqC/gTLaCdjrxJFH2XQYncPNgub4bUSmkVEylgtvCIPtnvDOudp9fGbYPrMpLM8SlTVqfwNYSjWhEpQRsTXC2gpOcLXkMGuQCp58rU72phuDGDSbCp4kQvrgJ9VrZyqFwj3RZWmKLTxFgbqDbsKWK/X1RbXfOpzU7k8BYRWw9gVrH/c4vJzJJI7kn0f+eiqqAUMAh2dDvm7UxG9wgpNag6+i8c9B9FaHmWYhWnUtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haOQ9eX2IGmqrbmsNASMkYcuVCR1PTJY35Vv7Z8TEq4=;
 b=ECBAaN2nvzVEzrPle/un/iQExSaIVeh2iTnoJB0P175pWPLNAuuU+XItaUbl65En7ON6fpzfegfx1HcEwJoBEv4/uvgnjUrCcN8OYymHVTFrnub1vt36TWrfSqCDXcNUVzI+NSwkvKGB+bxsQb3XicWunredaVA1rka0zZ8X3NcwZqb4TxHV1t6vaiRJDzqlu5mnNI8Wg/739uW8IbuRai5w1i+xtQNTEabea09wqc1aAJr444jmS4mxCiWqmMWUZWYZEHoylZwPwoUj9ohJFHexofGKeftwrWhkqqy9uYqhl2LthNC8ASO0BedhntygWxg4jlPK6jPbgyFeVTqHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haOQ9eX2IGmqrbmsNASMkYcuVCR1PTJY35Vv7Z8TEq4=;
 b=XzmtDhg10Dmk9hrMRrVMiL3r6XpjIRKWxgxmi3bBzvNEcO0Q2dM8Fhttxgm7TW/svTFpncEpqnZIzCVl0V7EGgbCpQTyxJXWGK/UeVfvKgGjXn3ONoFl3jF7ui8yqQ1rnbTYgIMopA3MmAJ01uH5wqQrFCvXubfVtAIsTp+lZCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI0PR04MB10299.eurprd04.prod.outlook.com (2603:10a6:800:238::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 14:19:27 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Sat, 20 Jul 2024
 14:19:27 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH RFC v3 0/6] phy: mvebu-cp110-utmi: add support for
 armada-380 utmi phys
Date: Sat, 20 Jul 2024 16:19:17 +0200
Message-Id: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXHm2YC/3XNTQrCMBAF4KuUWRtJE9MfV4LgAdyKi5BObMA2J
 WlDS+ndjVlJweWbx3xvBY/OoIdztoLDYLyxfQz8kIFqZf9CYpqYgVF2omUuiOTVTKaxM2RoF0I
 ZVlTUUiMXEH8Gh9rMyXvA/XaFZzy2xo/WLWkj5Kn6w4WcUNKIkgmqBVeaXbx9m4a4qT8q2yUts
 F+h2AvsK0jkslaFkhz3wrZtH7haH7n1AAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Konstantin Porotchkin <kostap@marvell.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI0PR04MB10299:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3a6f59-9c7f-4407-8923-08dca8c6f68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0dpcGZqOGh5YjBYdm1oZzFPNVd6WTM3S1lVYnE0ZjdzQllKZm1yNFNoL3lZ?=
 =?utf-8?B?QkllOEp2dTBkcEJFSUo5L1ZTd0hCcGZaL3BVVnQ5bTZrSFAyeFA0elVHQk95?=
 =?utf-8?B?R2NJWjF3aUdhaUttTU9IbXBEeVllSk10ZU9EdWdaQ2lNZVBJYVdIdUwreEhm?=
 =?utf-8?B?ZzE2QzhrQmUxRUlXMFlNZEdJazZ5bmNqRjNneGJIcU01SXAybHU2UDRSdDdj?=
 =?utf-8?B?aXhNM09KSXR5WnAzNkJmYlc2MEZYL1pyd0duQThUYkcxeGNhUFpYODBBa0FO?=
 =?utf-8?B?cVJwZjJla1hxYTJSTStIMkY1b2M3Znk4UEFSYmx2WjB4ZHNuYUpTS21IdWk5?=
 =?utf-8?B?bkVvU2FIckd4UVR4UXZQaGdwUnlTQ2tnSHhhMkxmU2VROG5ZUEZNdEhGTDhR?=
 =?utf-8?B?L1Q3dGtSbDFqbFJ0ZWJIVEZIdnVxTVNhQ2RNZDlsTUR2VXZ6T3gyNEVMbkg0?=
 =?utf-8?B?blpOenhtZUdGcXZBdWNaakE3azJVWW1BaExqWFRrN1UrTExQclU4aWpERmJr?=
 =?utf-8?B?UXdoUERxakp6ZDVMZEdVWnhvNjV1TG5KS3NxQVEyNFhuaFpvbkZ5RHl5QVR5?=
 =?utf-8?B?OVl0RXJ0aUsxcE9LYm5UYjZNR2hvR3BqMDZCeXJYMnZ5STBjTmpucVBNRnZI?=
 =?utf-8?B?aTMyd2Y4Q2Fvd1VhVEo4d1NCd1dra0ZwYTBDNktCOElJL29XaTBXV1Q3Q2o3?=
 =?utf-8?B?WFZwTjRVNnArQmJLdk5ibysrOHlESW9PN2s4K3hFRThSUTVtYTNhM3BhZWhV?=
 =?utf-8?B?azhobVFrVTdwWWlNSVNITzZEbFJhTGxuV3BycWx6TXphU3BxVlo5dmVHMXpW?=
 =?utf-8?B?Q2lISStuYUlLWjBGd1pQTXZOYmlEZ1F5VGZPUTVVaFhqb0RhakpiMGR6OEVs?=
 =?utf-8?B?aWxhaXNpVkQybTNyU0I5NjdEOStqSU85WUN3ZGZCQmQxV21IcnpBMmh0Z2ZI?=
 =?utf-8?B?dC9GUkRpeVlTVzljNTlNTjZ2Zk9FV3dNdmYySm5qM1BaMTZTUFRsZ1ZPcHpJ?=
 =?utf-8?B?dndOSUlnR1VOczRlRTRZQ3NTaUFGSUZhTWlJYVYyYkZZQ3U4QkVhZjhFVGhG?=
 =?utf-8?B?aWNEemIzSzRCcWh1ZEdJakRDMWFvdnVySFFsbFo5UDFIRmYrZkVuTkprT1N1?=
 =?utf-8?B?cE40ZzlSVXFPd0x3VUV2T3JaUkVYd3diQnA3dW1HaVRjRDdaZTFYRUQ0cldq?=
 =?utf-8?B?aWpkUW1zd2VEVzRta0xjMzJGMkRTeFRZNTdJajN2S1paRFI4K1B6bFhMRE05?=
 =?utf-8?B?OUlyL21RU21mbHVscFdqb3FTc0ZhVWpYTklIR2g2bDlRRVBtRnBKTjhpc0NJ?=
 =?utf-8?B?TENTSWd2dlJyNm85eExEZHlxc2RiYVA3ZlQ5NXNmWGErNXFZbVVkQ2tiOTlV?=
 =?utf-8?B?YnJnSlZFSG1yTUlxY2t4L2tPR2duMmYrcWlTM2RXaGZ2RzVlcnVmTmJ3RGpu?=
 =?utf-8?B?ZWNTb25CejhwU2FOa0FueDVLNDhWVWE4VzYzSktncWorOGx2S3pYWHVseDlT?=
 =?utf-8?B?a0gxblpEVEV5YkwwOTRkdTRmRERuUk9Pa012ejEwMitOS1U3NE9pYzN5QkNu?=
 =?utf-8?B?U1ZHeWgrVmhTOENVTWJkZUVlQmZuZ25mL0F5N255Smo1ODYyTEJ2ZXNKa3BJ?=
 =?utf-8?B?TjIzTURYK2JYRFkyZCtadm43MVhnZHk4UXgzTE91Y2M4VTA3SHBNWFVRK251?=
 =?utf-8?B?TmJuUFRzNEUzS0FveG5JdDNHV3U3ZEZ4UDU3R0RkOUx4Z2lubGNCbXc5cUZG?=
 =?utf-8?B?SjNHMjV4aUVvME1oOWdQaTRsaTlaeTRobGZOQ3NTaWpQRTRGdUtHQTR3UXdF?=
 =?utf-8?B?aVBWOHBOSXNjSjh5TmpHcGhwQUdWdi9sbE40SUdGYmlVZmtzT1liN1RITzNi?=
 =?utf-8?Q?Kb8pLvhz657G1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEsxMDdiWXRsYWpvQlpmZDhDMzJ1Q2RwM1JFTFVRa1hrRElmNnMxQWdyQ0JK?=
 =?utf-8?B?NU1BajlSRVp5dENjdlFDMW1VMDdUWmxBb2pjQWdqNjdTakhFVlRzVG1SN1Ez?=
 =?utf-8?B?MWZmSnllV0tISlY2dzdPMVVuWjNGOCsvTUltUk5GbXZQUU4rd2VDekd6V0dJ?=
 =?utf-8?B?QmM5MDZ1emZka3BpaEdTTjk0aHZOQjJ5bEM1SEY4WHhRV2N5dVlJWVVvUlVP?=
 =?utf-8?B?QXk0RUJ5bnVCaUF5bTdNSVRJa1dZNTZXM0VNOHhiUENqS2U1RjN0elQraWZK?=
 =?utf-8?B?M2UvZkk4Tyt5NkhhMjFUdzRKeXFHdzJrY014bmt4WEtQT0dnUkdKcU4vd3pp?=
 =?utf-8?B?bTlxZnVtZ1FqL0ZqYk9ueWxPbjhTNHVhb0RtQ2xyZkl3M3hhYkEzVWx4ajdP?=
 =?utf-8?B?cFV0bnZCTzR5M280Y2t5MHViWkJDVmV6L2FzaGlUbnRHYm1QYmxrS0Q5VVkx?=
 =?utf-8?B?THFSZU91VXcyYlpRUk9rc3hjL3c2QW5nRGRWREtrTnJTdCt6RWtZcmtiSlk1?=
 =?utf-8?B?akpLaVVjMExQU2JxVUJ0OStkRVU2cTZnM1lWU29HY0h5V09MN3RYR2hSaWRn?=
 =?utf-8?B?dzZqTE1TSkU4VDdJNnJ3bzJ6elZuQzNoOTFQWHNVblpNOUJVTmNkaXlPZkZU?=
 =?utf-8?B?YzU0US9PTW9BTDNSVXBHdjVOajRta3REQWtZNFd6MWswdnU0OWxIT2lRcEJr?=
 =?utf-8?B?VWdjWll1dEMzb2NDSFNDQm5abGd0ZWJYelZQWFFQeEJvZnhKS1dTRVBMb0R5?=
 =?utf-8?B?cXYxN09kMTZUdi9Bd0k1RCthLzF4MTh2MmZYSUZYV0w1TU5FakgvNkNLMkRP?=
 =?utf-8?B?S29FclY4THV6eGV0NUkzKzIvZ0c4aVRNRlQ5VS9mZGlvK0Q1Rkw2S2hMcElU?=
 =?utf-8?B?N0ZaQ0c2cDdWTmVoUDJpWVhGbVdaN0FSamFCMStFaS8xSERINjRRcGloaUZh?=
 =?utf-8?B?eWovdkRvTHBPSDlsS1lnbStQRHd4Z2hlR0Jnelp4S1d6OW9JVzhNNzQyRy9m?=
 =?utf-8?B?U3pGVkU5SXhiaUM5cU1xNGJ3cUI2alk4QzhHMS9mTmpIdFV0VTBTZ3pHM0M0?=
 =?utf-8?B?aXZEalRJaEsvMUY1Q0pJVDNqSkJ6ZDRLTzZvbXNBSXVkMlRaSUtmdXZGelIv?=
 =?utf-8?B?em45TVdrR1B4cFBuOXRCYmRhRHhtbGM3dkVFcUxqaGo0VGxoU1NsaVFHeTZa?=
 =?utf-8?B?NHgrODJ5L2lReThnQ1BadjJtK05rVW45U25QRGVtSTdid0Q0NXhPbno5TUVP?=
 =?utf-8?B?ZVFCamkveHMrRTRhaG53bDhCY2VvdnZVVmQycm5KWXVrQXhuSFZMd3J4L3lr?=
 =?utf-8?B?OEh0Qk1Xb2hyRmFDeGRINTBhZkZQcnJDenNXODFacGtDa0xDS1o1V3lTR3Ro?=
 =?utf-8?B?dXZERUVlaXBjZjBkWVJUbXJnMTY4amltQTJVT3VWREtKcUI1QWFYZGR0YnhQ?=
 =?utf-8?B?YUpSb3hZSUQyREk2eG02Y0djQ3ZOZmk4Ykg3Q2VwbUJZTnFUSmNWNitWbEFU?=
 =?utf-8?B?UjdOMlNpUkE3TW9lYTlFdXZOTDdFeGRoZkw2NFl3L09QTHBHbDBhR21COWdN?=
 =?utf-8?B?SG5rK29Ca1g1S3NRNGVvdUxucGhEN1hUQ240d2xhbjY5OG5TTTR4SEUrOTVM?=
 =?utf-8?B?dWtqR3NvaFZRTXBBVEVkVmpEcE1JUnFuMnR1bVhpR0J1TjZpQjdTNDQ3U1Yx?=
 =?utf-8?B?M1lmOXZScDlDK1ZNV3ZYSlA5UE52YllEb2ZzaTFZUEc2dnovU1A2Rk9wdnNP?=
 =?utf-8?B?M3VJSHd2MHk3SG1NOWxTR2locFpBM2E5M21la0p3cHRWTWxYamRpbnVQd1F3?=
 =?utf-8?B?K1lZV3dXbXlWVXd4WDR5RG55dk5uVGpCT1JvU2NHamw2azdNU1hKRFg4NDZL?=
 =?utf-8?B?andFdU5oNkR3T2FvL2N1QlhpcTBqUW1EbFRkeDVFLzJFcnl4UTF6KzZnbERa?=
 =?utf-8?B?OXVRTXdveVJYa3c3UEl3M2hzQlc4ZERnZVRzYUg0eDBvdlhpQThBaE11OVdB?=
 =?utf-8?B?VVlLVW0yWEVJMXJMU1NGblFGaFZvSWFtQ0F5U0M5VFNmYlpLOW1DVitvbW1T?=
 =?utf-8?B?aWVvaExzekg5Mk1ncnlOVC9ETUVSMnF4QzVRUTZMclRlTFcwSG93OEpjaklU?=
 =?utf-8?Q?9xoV2kozirU/XPuaRE/d1Gm3d?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3a6f59-9c7f-4407-8923-08dca8c6f68a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 14:19:27.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r12q2YvZNrvQ0LDYhZL6fchOVth2OtkholcktqIHqqwfs7hJ+vE5nDisknQXWf8iFz/Q6mP9R27f/5O7A7Nwag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10299

Armada 380 has smilar USB-2.0 PHYs as CP-110 (Armada 8K).
    
Add support for Armada 380 to cp110 utmi phy driver, and enable it for
armada-388-clearfog boards.

Additionally add a small bugfix for armada-388 clearfog:
Enable Clearfog Base M.2 connector for cellular modems with USB-2.0/3.0
interface.
This is not separated out to avoid future merge conflicts.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v3:
- updated bindings with additional comments, tested with dtbs_check:
  used anyOf for the newly-added optional regs
- added fix for clearfog base m.2 connector / enable third usb
- dropped unnecessary syscon node using invalid compatible
  (Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
- Link to v2: https://lore.kernel.org/r/20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com

Changes in v2:
- add support for optional regs / make syscon use optional
- add device-tree changes for armada-388-clearfog
- attempted to fix warning reported by krobot (untested)
- tested on actual hardware
- drafted dt-bindings
- Link to v1: https://lore.kernel.org/r/20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com

---
Josua Mayer (6):
      arm: dts: marvell: armada-388-clearfog: enable third usb on m.2/mpcie
      arm: dts: marvell: armada-388-clearfog-base: add rfkill for m.2
      dt-bindings: phy: cp110-utmi-phy: add compatible string for armada-38x
      arm: dts: marvell: armada-38x: add description for usb phys
      phy: mvebu-cp110-utmi: add support for armada-380 utmi phys
      arm: dts: marvell: armada-388-clearfog: add description for usb phys

 .../phy/marvell,armada-cp110-utmi-phy.yaml         |  34 +++-
 .../boot/dts/marvell/armada-388-clearfog-base.dts  |  41 ++++
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |   8 +
 arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi |  30 ++-
 arch/arm/boot/dts/marvell/armada-38x.dtsi          |  24 +++
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c         | 209 ++++++++++++++++-----
 6 files changed, 288 insertions(+), 58 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240715-a38x-utmi-phy-02e8059afe35

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


