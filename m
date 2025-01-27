Return-Path: <stable+bounces-110866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC0A1D6EC
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 14:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A94B1886B9B
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF71FF7D5;
	Mon, 27 Jan 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="gWidrWci"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2128.outbound.protection.outlook.com [40.107.20.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0B1FDA84;
	Mon, 27 Jan 2025 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984942; cv=fail; b=dfajotVU8zf8SB/e3YgHPB7T+swd9akVTCDqCpqKnTRC0je7fR/sYZ6is9jI85rxoadK3m5oNi2BSyxegZuML5WHDWoD4UuwxyniUaC8lS/0ykbJo+VDJ05/iAC84eZC0Zf3kQgVoKlZ6u+ozBzpyzXbjjOzQ34ZM+mCFOleqV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984942; c=relaxed/simple;
	bh=CIZuFnehYOqChR1IgJvy1xH8BLYRKGRvpgEMzBrF3bI=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=p9pIjIIm81NZ6+4F0toM8DrnbFpb6Qn6iL/iL/pSUJj4MONpN9yHqOJCoVl2hu/QnY+xZrSxFXN09Nl1BoMVwWZzKMAi/uZ4P7mstP7EpYi5jk7H0xnHgqQy9ja9V0r142RL1InCYtjVY1qFt+eGEZXMwgRov5AMUJD5rLPXKck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=gWidrWci; arc=fail smtp.client-ip=40.107.20.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anF/ywKce+rqF+Vxnw3NUgJw1oelnq3llU8o1f+DlPb2xkfCW5ZQeLCs4JQcqhDPFlwFnjxd/EoAyLkITetZFgYKrkwryt87nHgHIjm2TRHszmrDJcqQrzMKi2cTEAvW5NKAFGCI2QtwBNCrnhBfOFZwmT4OKUcC3rL/U/ZfZFnnWhCuo6EtxALe5SRQGBE2AU0PrB2iT+sSGqeX7syrLcJDFaASJfGmXD2CflujImdOMiW6zBVrINrsA9SfEaq0VBDFB52DYgSBk8+dU3C19fLyPmWKFYBVoLQweD3q5iEF9ZLwsUNbhQtmkSKMfDR4DJySxxcDMmXau9Pz6HWfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK8zG9Iy+mjMl8ATqSS0KTgG4fe98TzKZddkEyXt9FM=;
 b=hbcOFBmf2AZdKTVvz/cameVOkc3TuYwCRQznpABor9ViKNQNFPElhlC1JKpmS8uWB9me4fySTdsLu+q4vjyM2imjOWSw8wHREpZtKy3TEOwKnYXuiuxbAzU+NXZlASJHGdXxiWmLnv7u6EJ8lDS2Xrr0lmIbC5K+LTlrMVEnhX5h+qyB34IEcQIu5GELPoNNntKP6WUsFSgcAKl1Q3RbmGoTNmc0zbsibzcycIB5AwZdigkYpA6k7FG4U4MReXw24+DdZJavIKFI9dpJOofWxXJYX3vBMX1kszQFtnFVQXnEuzsekT2H7KshrJnqwrIyhyUhKTroCJE5KMImQlrNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK8zG9Iy+mjMl8ATqSS0KTgG4fe98TzKZddkEyXt9FM=;
 b=gWidrWcibDdKFkTFvaS0WHCJWA6XXr4x5vJ6zv5+xflPaHcNVOnKn+wUgB8Ojodp9IS/sgvxwhdOOknzRqeW+PknNTrsDJY1BNtnM8yzGz+QTHaauXLgrI6mprShl6uyig58ccSR9rBYe01b9bUKF1gKZxfmlOu+C5AN6ULLEOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PR3PR04MB7385.eurprd04.prod.outlook.com (2603:10a6:102:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Mon, 27 Jan
 2025 13:35:37 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 13:35:37 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 27 Jan 2025 14:35:29 +0100
Subject: [PATCH] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAKGLl2cC/x3MPQqAMAxA4atIZgMabP25ijhITTVDVVIQoXh3q
 +MbvpcgsgpHGIoEypdEOfYcdVmA2+Z9ZZQlN1BFpqqpxTlY02AIDpVX5fgB5IW63ne9bR1Bpqe
 yl/vfjtPzvPD86ktmAAAA
X-Change-ID: 20250127-am654-mmc-regression-ed289f8967c2
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rabeeh@solid-run.com, jon@solid-run.com, stable@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PR3PR04MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: fa043044-ffc2-48ea-a9b0-08dd3ed77b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmNxL21mKzdYckZBd3pJc0x4bWdoWndVcVFudUdHdVFwd2pLWkFZRUUrN0Nw?=
 =?utf-8?B?YndIZFhiZU1GL0pkVDBVeFUzendxcmNHcDdJN2VZR29LV283ZitCQ1VNQnQz?=
 =?utf-8?B?VVUwMmNVWmJNNHlmQ0FZMHhOYy8zNWk3N3A4NkVGeTdod0x3cGxBM0FENjdl?=
 =?utf-8?B?S2FtNzA1anpOUmlITzgveVh1SndhVUtkZGpLRU41MHNTQ3NLV1JHcEtsYkpv?=
 =?utf-8?B?VCtXQlRSS3cyU0wrQ1N5REJleHdJNGpYWit0dmpzZGRzdXZFQmJPdDJrdjNN?=
 =?utf-8?B?Z3huZlBsQVRxdXA3TlVhM1h6Y1h3eEM5UDJYMCtLRmJDK1lMZXgvNnBkVUcz?=
 =?utf-8?B?MUdlYXBuWWIzamEwZENFa3JEUnFUUi84Z3hzdVRObXluYjJNemdmNHpqZzZU?=
 =?utf-8?B?eXR2UWVUTlZRYkJJKzdxb2pWMHJySWpqdGRoVVMweFFlWUZ2ZlVUZW9ldm1t?=
 =?utf-8?B?eEQrUWtXUFdadjFObk5rVHRrWTlEYVVsalVWWVozbTVLSkxaRHdyQTNGd0V1?=
 =?utf-8?B?YnVXZDdFTENOdUhHS1BxOURTakpTY0pNb1BwZkJ0dHhQTk9hODZkaXJaaFpi?=
 =?utf-8?B?UzlnWnpKRFRINU5CaWpWRlhNSUdUbUVZYUVLY2Mwd3A2TitGOXdURlEyei9l?=
 =?utf-8?B?dzhCcWZjckMybFVDWFNnWnI5Z0xRRjl1M3pLRGRxQ3Y4WEs1YTI3VFZTNjhz?=
 =?utf-8?B?cXc4Zk9kR2FqS3ZMbktjZlF2cWZMT0xGQmZwNUxTSWxhdVhha25WaHdXU0U4?=
 =?utf-8?B?KzVvclZ3NzVFUnFjRVFUYUloaUdQWjNCRHR5NDhIbkR3ejBLL1lQSFp2QzBW?=
 =?utf-8?B?clIwaXREbG1xZml4SEFvTWlyL0ZZL1RQR1F4YXhJZzNzdkZ4MDkzREZXSmFi?=
 =?utf-8?B?Q0VuQlJUVTdGWW4veGVsbndMdHdNdnRtV24vKysrdEtldHdXeW1INGUyNjlQ?=
 =?utf-8?B?YnQ0NTYrRlM0Y2Q3U1pGMFhhejNqbEhHcHhIMU9EVFFzVzlJN244V2RacWgv?=
 =?utf-8?B?c21XeE9ITFBwQVlFQTlERnJNc2c3b2k5OEc3aGMvT25xdkM1ZUlNdGJvZ3VW?=
 =?utf-8?B?dUlTeDJIUmJoaExKZFBYSGEvU2V4bU9lSjg3MFZCV2cxdDlOM2ZMVExBRFp5?=
 =?utf-8?B?L05iOXNCYUFrcUpWQVJBelZieTZYQ3F5ZXV4bVlnOCtGVDBRWnI4eVZ3eUt3?=
 =?utf-8?B?dzFxMGxuc296UlFMckhPaDlTNlp4Vkx0L0g5Mmx0ZjhHSGRlK2J2ZUtHVHp5?=
 =?utf-8?B?UmpmQ1lxZTNxdXp5Mi84bml2cUp4MXNWSkV0cXV6RlBmMlE0WmxHaXpkQTQw?=
 =?utf-8?B?eE1QUFI4dm5kNG1RS0Uxd0ZreTdveXNIaTJ4SU5PajhCZVBoVVRQT2F6Y3VR?=
 =?utf-8?B?MTgrVisvc200RE1CMG9CY0xhcmg5NFZraVB5QjBJUFhFSExBQm9FeFJaLzdm?=
 =?utf-8?B?L3AyVEFnd3BxOGxSTzk3WDczejJQM3NPcnZhOE9PaFBQenYzVWRIb0VDUkFp?=
 =?utf-8?B?S1Voc3k0SG43allSdlFRVGpBbHdCUm41clRMWkcxbnppeFBBamUyYUF4bWNw?=
 =?utf-8?B?QWErL25EWis5NXd5SjA1eG9oOEJVOGpSa3RHMXVhbXd2MkJJMUR4a3dsL1hq?=
 =?utf-8?B?bHl4SWdHNUZpbk5mMGRtOXJuZTFvTzl2VDJZT1d5ZTlsOUJqdFVZQW1KUHB1?=
 =?utf-8?B?ZjdWT3VhWmFOQWdwb1FOV1pIcXdZZG5SdnhFaWRhWGp0T2ZwUXlsTkdJWnZL?=
 =?utf-8?B?UFk0OFp3U202R2cwdHZqc1NyTG03TlArTkVRMTUvVWN6TlQvM3dPalBlbjN0?=
 =?utf-8?B?U0xYdVJaK1FPTStmbEFRSWtYRzhueWUzRWJhdWpsOGVvaW5SclBBbGlHK0tt?=
 =?utf-8?B?ckZvcDFsc3UwVU5wcnlvRjdqZGpqbHF0L2ovbDJJcUZ5NFo5QW1oUzEzbFdE?=
 =?utf-8?Q?iMILm+uOuwSQdpQ0OKqPrIxH/vYAFUQk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck1FVVB6eVFBM3NkR24zaVN5RWlZZTRKQTIxM1laK3lsUnM0azlrdkhTdWN6?=
 =?utf-8?B?WVlkdGhncmlmKytqaXVzdmpsTlJ2YUp4U1EwM0k1WlQrd2tsMXYxSWUxaW5N?=
 =?utf-8?B?UFFyYzFDTW9GT3VaT2h2dXdhQmhMelZrZ1lJNlFOSGlHS0NFaHpzWGxOWWVS?=
 =?utf-8?B?dURPcnZoU1RYYVVXTzZxcis5WktOWEtqQnRsNXJRcitQVXZNMU5ER1VaRE04?=
 =?utf-8?B?dGxNaW5mNlVOakIwQVVxbFdWVVlTVEFrM3BNYTZ5clJqT0lqemdJdXZESG15?=
 =?utf-8?B?OVl6MVoyQjlvbENqbTRNZ1NkREZYbTRjeWhWYkNpVjExNEplZ2tYL0dvYWQz?=
 =?utf-8?B?TWlCOFlsVGRsZUpQVkdzZ3FKNkFXcS9qenIrbFZqZ3N0OTluVWlyZ1dtTmpP?=
 =?utf-8?B?VEpsT25wWTQxREttOWF1NFI0YkZ3VVhSbWs0ZTVaSDdNL0I0dE50V01mTENy?=
 =?utf-8?B?cWJXWU5aZXRVdDJRbzY5Y2RreDBjemloY3ZLNURpVGtBZDBWQXd3MFFDaFQv?=
 =?utf-8?B?Q25kK2xwSUJTSVd6MS9hTHQ2c3JRQ1pYbGtGY0RvWFJ6eTNOR1VMZklBclhs?=
 =?utf-8?B?b3NTZlFrcDJkWGVYYTAwWHVZd1dCc2VCODRicjFlZVAzRmREK2FNTXliN2I5?=
 =?utf-8?B?WnZFeVA2TDhZaHhVSnhYVUVnTGdXUWN2bjBxQ1QvRmJ1T3cxZUJsbHdXOTVo?=
 =?utf-8?B?aGM0YzgyQjVDdjdmK0N4aXdxalFRY1pKQ2dYaVF4WVBjcDFpNHVUVEdkNzZP?=
 =?utf-8?B?dW5iOGtFTHZkMTlwM2UzcFVSOUR2UFJsUzhNWUFwWEg4RlBsQ2FVeFdIMVc3?=
 =?utf-8?B?Vlh4ekl0TUdDLzZURnZMZkcvdUd3bDRraFhrRW54MlEydUVxYXFlQWZNd3ho?=
 =?utf-8?B?VjcrZTBXVkw5aE5rc1lXazVqQ1NBWDNBemttODVFN2N3TWh3WHFLQ1gzbEtp?=
 =?utf-8?B?QjVnTzVQYXR1WEMvRTYyR2gxK1BQekRoT0xNcFhieXJKVnc0R1ZaL1NQK3oy?=
 =?utf-8?B?WG5TOTlVbmhJZUxYV09obnVlbExXVGJwN0MxemljUTFVZzB3VkpJL24xaVhz?=
 =?utf-8?B?Y0Z3eUIrL1ZkR3BMMk9BcHlJTGFvZ05lNHRTSzJzSXFDL252bWV2aWl6VG5P?=
 =?utf-8?B?ZGtjMEhCUUZRSmloMTU3bXdZTG5ySEZlcEl0cFhlL1JHWmZEbk9XK1RUeTdj?=
 =?utf-8?B?QlJ5WGZZVkxyV3JpeTRuK3R4TFRoeGJ0RHAwZk9od0EzZ2ZIK0Z5MEZ3cGdC?=
 =?utf-8?B?blN3L0FaRU1jOEdNZzc5OEhLaXY2K1dRYWRuaE9FUVVWZC9pdnJNeWJyQVkv?=
 =?utf-8?B?MWdCYVNFc0JORmx4QWtPVExNeEhnM2FzSlVaMjJOKzkrL2N1ek5sSWYyRkF6?=
 =?utf-8?B?K3JXOFpuY0drYlpjdzR3Mkt6dmFxTjdMTUt2V1dQNXE4bjZPUW8vS09BSkl5?=
 =?utf-8?B?ckdmTzBwNkVGN1pCSk1iOWVHQTJUQkUrVFB6MGViYmNZTDBmZGtLQnV6WVhr?=
 =?utf-8?B?UTR4Z2Z2eU5EVFk1VmttUFoxd3FGa0tmMTNRSXNSMFFURThJLzE1VkxsNldz?=
 =?utf-8?B?a2VPV2c5MUJVZlVXTkhDQTZWb1M2OFFvMko0MW9mYXZOb284S211L1U3bVU4?=
 =?utf-8?B?WXVpOTkxTGRsOHUzSU9XeldpNVg5bHQrcEJLRlNrRmNYZXJKYTFIa0tmc1Ey?=
 =?utf-8?B?MEI2bEs3b2UyNkxLTFhxd3hibG4xOEwwNkRNa2lGd0oyVEtFRGZEUmNacHVj?=
 =?utf-8?B?cW13OWFBalltRE4zbEVVaG5lVGlYalF5WFRxMHBjSldad2pCM1hQSVhHSTJC?=
 =?utf-8?B?dXNjVDlEMnVwYWdqNVN0VncyTlRZSWVwdW5KRFZ3RDlUU0pJSGtEMU8yQWxS?=
 =?utf-8?B?Y2FSSHJmQUdvb2R4d1I2WnlKTGZaYUVGV09GOTEzN2hhZFJZYUxVQmpDNmpm?=
 =?utf-8?B?S21mRGtEZ2IvKzJ3UzhLaGYrelhXVWp6Q2xqcWZJZHArZ0s2c3kyZDJBMmd4?=
 =?utf-8?B?aElsWmRoNlNUeVF3OXR2bG9qc2lwL3hBajhYREJ1Q0xoRzhIMEcwQ2JVREtH?=
 =?utf-8?B?WDBZeE5vTGg4UXdyN01PZGJCdm5BV25haCtMYkM0Z3lzTGpDR3Zadkw0Wito?=
 =?utf-8?Q?knzfjPkC07zzxGKONdWeJZ0iX?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa043044-ffc2-48ea-a9b0-08dd3ed77b9b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 13:35:37.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9s7l/kvCrYWAVVQvmwrSmeCBqMx4xtzGISjhnly7xePnlyORUz0dcgcwoAsuxXpc2+WKwLLDfHDzzGE+ArLzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7385

This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.

This commit uses presence of device-tree properties vmmc-supply and
vqmmc-supply for deciding whether to enable a quirk affecting timing of
clock and data.
The intention was to address issues observed with eMMC and SD on AM62
platforms.

This new quirk is however also enabled for AM64 breaking microSD access
on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
causing a regression. During boot microSD initialization now fails with
the error below:

[    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
[    2.115348] mmc1: error -110 whilst initialising SD card

The heuristics for enabling the quirk are clearly not correct as they
break at least one but potentially many existing boards.

Revert the change and restore original behaviour until a more
appropriate method of selecting the quirk is derived.

Fixes: <941a7abd4666> ("mtd: spi-nor: core: replace dummy buswidth from addr to data")
Closes: https://lore.kernel.org/linux-mmc/a70fc9fc-186f-4165-a652-3de50733763a@solid-run.com/
Cc: stable@vger.kernel.org # 6.13
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mmc/host/sdhci_am654.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index b73f673db92bbc042392995e715815e15ace6005..f75c31815ab00d17b5757063521f56ba5643babe 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -155,7 +155,6 @@ struct sdhci_am654_data {
 	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
-#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
 };
 
 struct window {
@@ -357,29 +356,6 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	sdhci_set_clock(host, clock);
 }
 
-static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
-{
-	struct sdhci_host *host = mmc_priv(mmc);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
-	int ret;
-
-	if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
-	    ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
-		if (!IS_ERR(mmc->supply.vqmmc)) {
-			ret = mmc_regulator_set_vqmmc(mmc, ios);
-			if (ret < 0) {
-				pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
-				       mmc_hostname(mmc));
-				return -EIO;
-			}
-		}
-		return 0;
-	}
-
-	return sdhci_start_signal_voltage_switch(mmc, ios);
-}
-
 static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
 {
 	writeb(val, host->ioaddr + reg);
@@ -868,11 +844,6 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
 		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
 
-	/* Suppress v1p8 ena for eMMC and SD with vqmmc supply */
-	if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
-	    !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
-		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
-
 	sdhci_get_of_property(pdev);
 
 	return 0;
@@ -969,7 +940,6 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
-	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250127-am654-mmc-regression-ed289f8967c2

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


