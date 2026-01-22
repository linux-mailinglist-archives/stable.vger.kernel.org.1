Return-Path: <stable+bounces-211189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDCUD9qYcWngJgAAu9opvQ
	(envelope-from <stable+bounces-211189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 04:26:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79068614CD
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 04:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EBFC5E8C1E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 03:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEE62ECEB9;
	Thu, 22 Jan 2026 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sYP1/ojW"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4B32AAA1;
	Thu, 22 Jan 2026 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052313; cv=fail; b=a/peReo9NtgV/7PiRh3EG9Vaoz/jd1SllYiUqY2/dkUKMmo62SakJIribqw/P8RoWG3PKzCgIeZ8IejzYhySYIquYW6bdMyugHToGXr295CjlWQUoKHzxXC2L1qN4E388FEJ+qiwHqePfapz7MllAKc9/+oMJ+zfmSUbzEo16GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052313; c=relaxed/simple;
	bh=puj4cm0qwQ/zjRGRBaAZ0jybKC85iyGEMZj1Id/xQQ8=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=RuMrmO0KIgmLQit1yr9vZ0etNsv+Qp0GnR/YUgMdbiT++5F0gyatKAhzvYN4mW8uqImhyHH75i4gQsjAdG5froRh3AFugcqHuYcgqjnBzjxOJHOCcevzul0COnqf6rqTZYCLhOUFCOMIimw1qYGutWFp5frLPH3RSrjr8HoCOL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sYP1/ojW; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gwn07FzguAIYTo3fk/xa4s4eO3HjbL3svWULDGqs1fE0gx+ZYJbblY556+2ii09EehaUARhgSma9Bf1Pj58fs7EX50xumqSOTo1BcBIp2RkWt0CWRQItpwrdimR48BxKbiAqfFsgv+FaWR/SIBtmxATBZOyvdumrGFfVZVdLAbIKcyKLj08JaDcSADWYW6aCHHc/WCTcKo+m8T1TMk7ThWYzsEIF7V03XfWXFWxqcx/tylgWKDLeOHUd9lG3jkJcA4jzCNkaUs/Ft3K9GRMVb82DWrs9SxJzHqrWWy2ZdWKar+VN16mPRAgZw1t3vog0mauGWQ6mwbA7Vs9jnoH4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP0kShK53ETIjGSh03CGvgZuP+zm9LFZ04CAJq47DBM=;
 b=CA8wZXpSnsHv6GicgYvLLG3KYie/aMxlnu5qp9YoYBFRoy+R8nSm3nP2WL3k7vrhHGt1yDlx1wmQLUyazUjm0CSQWXbSDCjp7+c/A/V46h3DZLSWS/oFRBF9xvOmdyVcDAShhYiX1SbECgvULKruTSldJ3IEXbHZMRfC7CNDIymgcR+VIBDico2+qde3RRrWu6DZoNAkcMZKAiJrCt124jVWeXHA5eV00Jp/neJFz/WEh82V2KlYAMyy0S8+fBkCEKuh0N4Bgm5GK67qfkEb63fS4VdsGmaPg539MiyCm+GHJpgbwudKis2j3a28ytvmrfPycPSD1VW36dl8myhhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP0kShK53ETIjGSh03CGvgZuP+zm9LFZ04CAJq47DBM=;
 b=sYP1/ojWFABdKYzrZeGoFSH5elGos7TYT7Ugv//LwxT6GgEXvg8//j0gy3LPH9y1gllGGUsoYMue4iynWcc6/XE/3e0J4YVwfUKG3bxMn3ENT+LPrcfD/L3XN+VPOYTA7OxIECLep871TAVCXyWYTt6EMdmrSVIRvJwDMFb11kmvMAWhMeZ/DaQKmLbkf7YKMC//pe9UW3CHEWl79KTRzTZ3fu+s3xsIVvKzoFZRPdy1tpZ9fJxMH/fe1Ak+uSi4wY7W9Lh2CbNUuJOeJX/VZO5E6X69xmoH4hD/VKAlp2ynhIYFYhR76KdUb0ZWu0ehvhNO7MgJCiHjREv6BD0h5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 03:25:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 03:25:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 11:24:43 +0800
Subject: [PATCH] remoteproc: imx_rproc: Not report loaded resource table
 when none
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-rproc-fix-v1-1-36cc64369a40@nxp.com>
X-B4-Tracking: v=1; b=H4sIAHqYcWkC/x2MQQqAIBAAvyJ7bsGW0Ogr0SFqrT2ksUII4d+Tj
 jMw80JmFc4wmReUH8mSYoO+M7CdazwYZW8MZMnZngjlKqi3pg2DFGSyLozsePAeWnMrN/3/5qX
 WD9/qLylfAAAA
X-Change-ID: 20260122-imx-rproc-fix-e206f8e6e477
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>
Cc: linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: d1af9ff2-326f-458c-b273-08de5965d62e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTNpdE9QVXN2dHBhWkdIb1oraS9IV01uWmhXS3hTVU43S0JBeGFJcERUYVM5?=
 =?utf-8?B?c2tLTmNnZVRyYnZIYU54ZmQwZ3J1ZFphSGRHVUJ2cDNnMHFTcUdUWWZ2YkxU?=
 =?utf-8?B?RXYrTWZlYkRLWWJWN1hKTHBiS2UwZzYxVTYrS2M0SUNrdm51YTlhRW9Nckl1?=
 =?utf-8?B?a2s3QkM0VXFxK2tWSTZ2cms5MUNlSzh0aWpoanN1aEM3MnQ1bjJZdjZWVkJP?=
 =?utf-8?B?cGZnazhXdjZ4VnN4NFRKVkY2UjA4MzQ2UEZtdFRZQmluNTg5SW9WL3drUWtJ?=
 =?utf-8?B?RDVCZEZEaVdLQ2FhY3hmbkhiU08vM1pjTzZSRW5OZDBuUjA4d3hHSW9PZlk2?=
 =?utf-8?B?S1pwajlmSC9CdlNJYmNpSy9EeFBuZnpoQnR3cnV2QWhHQlUwQ2Fua01EcHJY?=
 =?utf-8?B?bEV6eGNlZFBzT0xTYTVoQlY2cE0wNmd1S2lUTURHbytnWnBQSWdOa0g3V3hP?=
 =?utf-8?B?T3h4YXhDZkVkcG9TWDl0K3hPbXlza0oza1hBZlI4Mlp6S2ZFZ2kxVzFtdlBW?=
 =?utf-8?B?eExSa1dhZFFyREJ6ZFdmZCt4cEZ3cEhJcW1nSHUyNnpjRzFvbEhhNG5WSXFz?=
 =?utf-8?B?aUdQaUFyNXFMOGFjakVmY294Vy8yTnNHajMrVVBFempsT0NUV0VIdHhHZGR4?=
 =?utf-8?B?Q0ZiZWJQUHp3b25pYUk2MHRBR2Q3WmdCSmxjMEdSQzMwaCtXQlQ1R2tOL09S?=
 =?utf-8?B?NW5aWDJibUREVzI0bXdVejg5TUtVNFFGek5uVk5MUFVNUkFqYTUxRUVSaTlW?=
 =?utf-8?B?U094ckJaS0ZNbzk5MkVHL3VLUE5LdDZCUVJxeHh1Vzcvem9YNTYrM2N6dWVv?=
 =?utf-8?B?TjFrcEEzNlZzWFF0Nkp4SE9Hbk1POXRXM2RvUktXRzhPTk1vUnN1TXMwWS8y?=
 =?utf-8?B?NXY5ejIrc05iZ29EOVhLRFBSMEFNejhWK0hxVmxLV2hJQm5XVXpRU2h5ZG5v?=
 =?utf-8?B?dEFhTmlFcHRwREdZeGlCZC9pMGNoYW9VL3Y2N2J4YlRrVTVjZGY4d1lOYU8w?=
 =?utf-8?B?R2FiaFlCSEw4RG1Da1Q5MFhxdlZTQm95VzQ4UVpUVDdWVFh3QStEZjAzWndr?=
 =?utf-8?B?blZld0FrVGZObC85VnM5Wkhyd01ZdnpJN1QwcW1Lb2tNUnVZcmNGL2I5L3Zh?=
 =?utf-8?B?NW94TmpNaU8vUXBsZmpVZ2hCd0Vzc3ZjUk02aWRMN0ZRYi8wWEE4aGZsbTN0?=
 =?utf-8?B?ckRRem5Ib3pFZ2F3UnV2aWdWaVdLMVdIVGkyd2tkZDBXMlYycFFZMTNnNTl5?=
 =?utf-8?B?dGkxZFcwbS8zdzZ4U21KaFYzMzVYc1R1WVp5anRLcS9SOGpWWDNWcUtMSHU0?=
 =?utf-8?B?WFB6c09GYzIvZUtSMFQ0UTZTVW5NR1Bia2RMV09WK3dRVldSNkNiTW9Uc2lX?=
 =?utf-8?B?ZFhNczVTOHA5NE9ncmNld2tCekVKZXRSY05lUk5hay9NQWFYV3BkV3laZ2U0?=
 =?utf-8?B?amJoVklsWFFMMlRER1VEYXZnTmVHM00yL2p1cERkL09RUTVzVjRzdnhUTWV4?=
 =?utf-8?B?cElQdVpDUFBFMkpRd2x1bUpOcnNRTkJpSSt2L1ZkMWYyVGtPeEFhUXFTSjQ3?=
 =?utf-8?B?ODY4UnlXanMwSGk4TEdoWWZoQzJmVHBtZ3FjNk5pSS9SN296bnZSRitneFQ1?=
 =?utf-8?B?U0F4d29pREdvN09FTHZrcG5LZG9aYkhuekswMnhpRkcwYVFndk8xdmdvSUxY?=
 =?utf-8?B?RVlJVHJyQ0JWVU0ycUFWZGlFY0pJYkJ0Y2tZajlFSnN6MHdab1g1cWc4MVdB?=
 =?utf-8?B?Tk9Qb3pSVVl0eHo3MlA4MGUvN0JlOWpGMHBQdzZXTTd0OWNYVlM4T0tsOVMr?=
 =?utf-8?B?ZVlmb2ZJb2tVemc3YVNlNGJtTXZBTFp3WFRweVZlWlB2QXJNdURiR3pXOVc3?=
 =?utf-8?B?RndlclhtZ3U1SVN4ajZ6OGpFL2hqSWdkOGxUVUFGa3pycHI0c2c4UkdGQXdT?=
 =?utf-8?B?RFFGVVRZQy9RckdJY0ZPUEZZSjZqbWlWM2FJdFNaSTBsc1FPYmlqM01oa05X?=
 =?utf-8?B?K1p4bi9VYVVDY29TanI0RFVDanhXVmpTcXA0bTFseGZTQVJiMjJjczBkaWI2?=
 =?utf-8?B?bERjMFQ5b0tGYVBjb05VUVhTUzBkQUJDSGdpRGNRK21BcTJXWERhUFBYQUt3?=
 =?utf-8?B?elcxQzM5Z3BwRFQwY1FEUlc5SE5WejI4NE5YOEQwdkpxTEsyRkpJNDNoMkVI?=
 =?utf-8?Q?G4y/D22CkCmoBZ76pawpR/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1pPcTRmaUhNZjltZ3JRNTczeFE5bW5QUitaWTE0YXJ3L0dab3F0a2pscUps?=
 =?utf-8?B?d0lqVnRYNEJhOEYxZDJtV3lhSEk5S2hjakZhQmlZb0hmdWs5SUJ6eWZlNWJB?=
 =?utf-8?B?bDkvM3AydXB1ditiVWk5b3NiMlB2NlRUUzk3dGpvMGZuWUY2SGo0bHl5NVVK?=
 =?utf-8?B?Sndqemp2R004R1g2cGMxM2J3NmxxcWtGMHp2WUo3Nnk0SGRTb2VHa0s3Sldm?=
 =?utf-8?B?Tm5RUDdzcmNvaW9BMHZwY1k0MTlMc0ZSdWc2VjVUZXoxTDF2OE5CTS9QMHpY?=
 =?utf-8?B?RHFRNURXTTF0YVlHZHdNYTFZejEvZlY3ZGNiZ3docmU2RmF5WWRHOVdXUXI2?=
 =?utf-8?B?TkNDWXlCVzVydEp1NXB3bkdORVB6V0cwTll4RlcvK2l3R2ZwVWlyenVzZkMy?=
 =?utf-8?B?a2dnbzBqZXBtZVZNSnNzbXdpNmJFb3ZVemlJNmZnM2c2dDhkSWNaWVcxOEIy?=
 =?utf-8?B?dmtnVlhSMzIxYkJGcU5yc2NVdUxiRmR1OUVQeFVrV1JkV3VhdDRyaThGVGVX?=
 =?utf-8?B?SjhHWmcwMUtXZGoxWVNQeDVYNEFJbWlmY2E1NlIxZ2tnSGZSNUZjY1NoZkpa?=
 =?utf-8?B?UHd5cVVpZDRGeWZGN2RUQXBxUVFQbC85Z09OYjdtUHpzMURMTkdkWEZtZmRx?=
 =?utf-8?B?cTNvdzlKdnU0VlVtN3FycUVyMW5QTVZLWXowZGw3cEdDQjd3eUNNaWdxUEpT?=
 =?utf-8?B?Yzk1bGRRd1gvVkVaMS9IL3RrT3I5YnBQRFd5YlZuNjBhU3gyT2gwTWFja3lp?=
 =?utf-8?B?SVcrN2htVGtvSHYvYitEYkFpYmRkYW95TnVvYThBYmNmYWlKQzNWY0xBR1py?=
 =?utf-8?B?cFJXc0tnQWN0Nlo0QWtxS3JhZHVndVI3dzlNSUpQNWxlWUhHbTZQZko3TTd0?=
 =?utf-8?B?NlhTL2Y2SkpKQWMwNXpYWjhtMkRWSVgxUU5IZk44SlF2TDR3YXd3WVV6WGZ6?=
 =?utf-8?B?TndIR1pPQlgyNnk2bG5tRUdIc2xDa2JyTzVwY3ZYRHgyL01IZ052NnFMZHdv?=
 =?utf-8?B?UTJYYlcxZUdpOTBCUTd0NHorN2ZoMFZ1bDI1NW5BUlN5Q2xpd3VOdHlpc3Qy?=
 =?utf-8?B?bCtDb1N4U0FLbXNrTmtpV25aS0xtUlNqdkE3OGE4SmNFcGJXWWpZbGMxWVk2?=
 =?utf-8?B?d05QbnNJTXpHaWgySklZQnJjWVZRWG5yRkFNcmsvdk1NRXN1S1NxZWpYUHF4?=
 =?utf-8?B?M3h5SFdMUlVuS3Fhb1JaOXdFUnVrRUIrZUx0bHpMVHBNbDJ0ZHRPOHBkR2NB?=
 =?utf-8?B?WVZSV0M1anlrTmdGb01qWjlzODRwU3N2YlJkSU1VdnY0aDVlUWdYZC9mbUFR?=
 =?utf-8?B?YXhWYnd4c09wT0hHZnRVQThtbGxCd2tXS1RlMk1MK2xSWW9rTGJhMi9YOTJS?=
 =?utf-8?B?V1B0VGVia2VsbFoyZ2ltZDVLcjNHYXpBOERleFRYN3dMUE52b1kzNWJkWklK?=
 =?utf-8?B?b1hxNmpORnIxa2VnR3V2ajhubW5yY1paUnJ0VEtXTUsrZE1pMUwxM1BpTUdX?=
 =?utf-8?B?TjRYcGx2WDk3OTRTWExaL0dMb1d4SS9FWWFuV0N6QTFqK2dwdWxscXVJWWJH?=
 =?utf-8?B?VmFPck1IM3pSM0FZK29CRzBXRE01TW9LYkR5dC9XZS80WnJ6ditjMThHbVVU?=
 =?utf-8?B?a3U5cG5lbEFieWFNT29oOEpaZUs0YWhabnp1Q1cwMzltZEd2enVmVTUzV1BD?=
 =?utf-8?B?QWFEMW42c2ZBNk9yK0lWMHR5aFhscTNONFEzVmtmMXI0d0NOVWlueDQ5U1RE?=
 =?utf-8?B?ZUZqdFFsN3JteVJXcEN4TnRNSzlacmNPVFByZWNXRVl2NFN1WHdUc3ZHaHA3?=
 =?utf-8?B?OWVIM3RQMENsMVVvMHZBME5rbDFIZ1N5eDRyaHhDMUlGazV0QUcvOWIvc1Bh?=
 =?utf-8?B?S2o4YVdudE5KeEZXUmxETUI5K3F2RTQ1eUtWSHFyejBWUXh0ZzhWODh4dnE4?=
 =?utf-8?B?WXI0OWlsSzZyUzFYdmhlVkJYS2lYdjlrTTAwTFQ0OUloSi9CaVZXSlBHOFZR?=
 =?utf-8?B?WndWOUZieTVJOFp6K2tHcUxpWXRNU1prZ0RCb0VrcE96emU0SXFvUzNQckc0?=
 =?utf-8?B?cjFkUUN1d2E3ekU4Q2daN3V0RDlGRHdBNWZDanE0QWVkSTNoNWhwMVlET1cz?=
 =?utf-8?B?MWMyb2UyNGlMVHlVaTQ5QTRxamxZUE5pVWtjcCsrS0lZU0M5cGtzQ3hxRkVy?=
 =?utf-8?B?MjJEOEtoL3lOS3BYKzZRTHgwU0dSQXhpOUVhbGhiSEF4MFlhZWw0UGkyNVc0?=
 =?utf-8?B?aFdDb2k3bVF4VU5zVytHczZWOHY4MHZLUUlOSWdTa3dVUTBZZmVZQ0d3Q2Ur?=
 =?utf-8?B?Mk50eTA2OGRwK2V6bDBWanI3dE1xcUR3Y05VZytlN1I1dE1saDVldz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1af9ff2-326f-458c-b273-08de5965d62e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 03:25:05.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDYH3stN0haEBWki7BC/Vv5ou61zsPVdOCVI+krLdthfH79PUZarXT5/9FIYoENCK0enzal4j+e98/fuRM1rnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7207
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,pengutronix.de,gmail.com,nxp.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211189-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 79068614CD
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

When starting a firmware without a resource table after previously running
one that had a resource table, imx_rproc_elf_find_loaded_rsc_table() may
incorrectly return a valid device memory pointer (priv->rsc_table).

In this case rproc->cached_table is NULL because the current firmware does
not contain a resource table, but the remoteproc core still interprets the
non-NULL return value as a loaded resource table and attempts to memcpy()
from rproc->cached_table, leading to a NULL pointer dereference and kernel
panic.

Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
there is no cached resource table for the current firmware. This ensures
that a loaded resource table is only reported when a valid cached_table
exists, which matches the remoteproc core expectations.

This issue can be reproduced by:
  1) start a firmware with a resource table
  2) stop the remote processor
  3) start a firmware without a resource table

With this change, starting a firmware without a resource table no longer
causes kernel dump.

Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 375de79168a1c8d11b87ac1bd63774a3feac106d..cf044b385b58fe1e17d0fc440c243d76ecf020ae 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
 {
 	struct imx_rproc *priv = rproc->priv;
 
+	/* No resource table in the firmware */
+	if (!rproc->cached_table)
+		return NULL;
+
 	if (priv->rsc_table)
 		return (struct resource_table *)priv->rsc_table;
 

---
base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
change-id: 20260122-imx-rproc-fix-e206f8e6e477

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


