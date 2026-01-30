Return-Path: <stable+bounces-212833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPKFESklfGnsKgIAu9opvQ
	(envelope-from <stable+bounces-212833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 04:27:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9537B6D3F
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 04:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C881300DF54
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 03:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8012FE060;
	Fri, 30 Jan 2026 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nnZ1uzaP"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEB2DCF6C;
	Fri, 30 Jan 2026 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769743639; cv=fail; b=czaDZNvAt50Tg8zoFCSslHy++gc/jMnj5vOJjim0IRAGmroX7T2sJCp2bnXy0CPhS8mKqmujgvei5UR5Sh7pxeVGsOBXv/Aopb8ZhRiYImfP/sd3EO7DrQNPo5CG5LIvurHm46lc9ScssaAuZuKjz/AJ+8h/qp1hkDaPwLzKjbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769743639; c=relaxed/simple;
	bh=XrsZ/naqpGykIwYrN8eQfg24TW48Yb9NlVDt1038vz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gDOpvzUBi8MnJ6sA/M8w48cL3KdWgFERFY6VAFwiRCgnStCFBgQeHbFbZtx9NqS77hKomaviu08+Sce3T0KMxjsgJwL4k2BhTMGo3KRumS7Bgq4YUTYXjAJxsjKCHfzG0/QOD2n7NTFo9RGPTgi08HK2DTSV46zhYIb6CH9TiYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nnZ1uzaP; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqpfHvDegZVEbZR/6CxZ9+CNI16XppqWupKgwu+mJG2Ylutwh/LqsBEgKn98mqpbjeRM4deOFyBd735oiDg3owcIa5sf0a0c6+w7sbKuH9PZ5TljP5qJty5Rhz085yfpDjFOPSzHFUVCKq9bot+WNebQCWbHrUuN7ZB9xfanX0kHvM003CDpODAAjOVwE+/xbU4V7W/1c9Fv/vLoDKYUPQp79ByI9Q6GY86xRTv3Ko787YkkOavt75EWEW2hzgImpBfdMNUduBOs5gCai7p0lfgA8vHWzZxl1Nyix7x76DbpwcyaNd72WNz/H/d7uhWGr3tPm/YbIPvekDq6aRKqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4j5m/qvj0AHvhBi/UUFxtS7QDkIpObv+eg5LRScufw=;
 b=ZV7QcZmOW9rZIU2T3EscxgL+ihv2+J91aN6GaLvoKE5UArP8H2zXoQV6EuAPZt3CvbnF9mwjLdgJT9E7s30f++q1V2zugGVbEiKzknDpPWTMLZl+tFCxBarPq/AFxCvHEh9fWSa7wOc1gAqkJXGp1Lt7hqDKR93rou7P9xW809H9sMAuAD022siqCcrFTiWwOZsLQ41dG5ZWW+CZqc40s3bE1/Sw1sgPql/9kGd9uIWqEIgdQQ4xI8jdENmpoxJsL3bhR7cjp0JT4f09RVXixlZeIjDM0K0TYgXJVPl+Cp8tGq8g+8nZ6TaBlcCvwe+zikSFQ/MrcZMeu8arSzxFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4j5m/qvj0AHvhBi/UUFxtS7QDkIpObv+eg5LRScufw=;
 b=nnZ1uzaPiYqlapca1Vy/XTJUocTcJAGGr24al3amzCULqBOcJvox4aIrFK2Bf+T9v0pEfbzz9qCjMNzRLDZF1NIGgEKJyZTfd0IbZvjJq/YrbDvzvN283sZS6wpM56kBqa+Ec4SDCVZroL4wOWnbd1L3w/hAvdRPDTfd2YVXnnKGBHggqja4XBTBNlsJ+gZplN97dmOBYtjGtHe/EChTi7KFO+TspBtTyx5wtvdk3szPLKLS7Oq18j+sDujevWnGrcsqsQK+2BsBNwFyY3/X2e88bX2DZ1Cq+ahM+gQ2OeW12gbqRqnDNhE337ZmSupbYsVmFPEvR5T+WQHqAc9fzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by MRWPR04MB11496.eurprd04.prod.outlook.com (2603:10a6:501:75::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 03:27:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 03:27:14 +0000
Date: Fri, 30 Jan 2026 11:27:08 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] remoteproc: imx: Fix invalid loaded resource table
 detection
Message-ID: <aXwlA8OnT5mqeaiC@shlinux89>
References: <20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com>
 <CAEnQRZA-nMai9-CEdMqnr2drqBRXXPOKE3a+_3j4S_=x-bM0pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEnQRZA-nMai9-CEdMqnr2drqBRXXPOKE3a+_3j4S_=x-bM0pQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|MRWPR04MB11496:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea1800c-3ef0-4fc2-84a7-08de5faf7676
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUNYVFJxd2dJbnZBWnNFNEthaFcybnZSNmlkL3FnRTZMdzY1Mnk0amo2T1BF?=
 =?utf-8?B?MGUwd1B5UTBsYm1UVXU1TCtscGE4USt1dDdDanBxL0c3d2o4UDBVTmV3eU40?=
 =?utf-8?B?d1cwaUZDSU8vN3RuZGNrNXg5elB4eGVPZmE5TlpMajA4dHFtK3NFU0JBVzVn?=
 =?utf-8?B?WTN1cmFLaVlnenNYU1NjeCtFeDBRenVad3FBK09LY3VxdUx4dlNJeGJSd21m?=
 =?utf-8?B?TmNoR0ZJcmlZd1owUUo0ajJrZXhZMXdWc1k0S2g4a053SGRKTWpzWGZUdm5z?=
 =?utf-8?B?cElMVmNoWWFKbHNETFFjUytCcGtsbEZpWWkzYmRybGVJZnJlaHdHaUhhU1FJ?=
 =?utf-8?B?UlVWc3hFRktHZ3hqbUlWYkZ1czBVZlVuK3ZrdG4yMUc0WUJwMW1TTEZ2dUJJ?=
 =?utf-8?B?RkF1K2lndy9LY1FUbjBGM2dJcXlsL1hGSWFtSytpZThCZHVtR2dlc2hhbU5R?=
 =?utf-8?B?aXU0eVJseDdGOVhJdDZvR2pJWmVuS0c3bEZuT2ZXQWpVOHJ1QVhIZDZvVzBx?=
 =?utf-8?B?b1lEOHplSUxvMHZqUUl1WkpBK1R1dWcxcXhqTUdWUjRucGVpKy8wV2xHbFdz?=
 =?utf-8?B?SkQ0MnEreXd1ODVIdGJpa0lqSTJ1SEVpemRENnQxWnZCTVQyVEd2a0NCb1ZO?=
 =?utf-8?B?eU43NGJvcTJqYXcvN0c2U2l5UmVQcFp3aXp5YU9MOGY4djluMFdDYXBCR0M5?=
 =?utf-8?B?ckxvR3o3U0V6TkJWVStuTG9EMVBNaXczSTNncGp6anZyOEo4K2QvZW9UeGNm?=
 =?utf-8?B?dFM3dnQ5RU9QZFVlZTNZeS9RSmRpU0V2RGRJbmtxc0xIb0tkL3MvU2R0SGpj?=
 =?utf-8?B?a09GZm5KcERUaFRKWnNMemhDWWJUVjlWdCtkQjF1MG9qUEwwMDZRVTQ5a3ps?=
 =?utf-8?B?dWQwb0NxYmlRdmhCQlkzZWdPVXNQcDJuSHhkZ3pWZ29NMzh2Q1h1NS9wZFFx?=
 =?utf-8?B?QmlpWUsvSnZ4STlsMElTcHp2NGh3aGlBSUxNUGd6NElnU1JMY2ExNk0xMHhv?=
 =?utf-8?B?Z2JPcW8vYkt5QUtkU0tPZmx2NWxmT1A1YW15M2IrNlplbWVRditUVG5XWFky?=
 =?utf-8?B?S2h5bFlQamtqZ1FBbVFQbnpYMVlveWFxSk80YmcyWWh5dWdneUgxWnlGUnRX?=
 =?utf-8?B?Y2hpMkN5d3hXRzhPTnpZMFV4ZVdxVS9KMVpNNkl0RzdNN2RDdzBXcUt3eGhY?=
 =?utf-8?B?TjE0eHJMK0VaUi9OYjVzVk94b0ZHbTBYL21zVVBiS0JoWTBzd1NXWVEvckph?=
 =?utf-8?B?KzVQY0xYbHNKMWwzaTJ2SXEwUGhVYkNxNmVXbDdSaTJXV293M3M0YnVVdDkr?=
 =?utf-8?B?MTlrbWMrdU45SWg2QjlGaGpLVnlGRUNRYzYvQWxWclZzYzVzMlkrY3MzVUU4?=
 =?utf-8?B?QjZ2SzloTzhFNHE0aDFMblJZSHBrMThPbUdIZk9MQllOcTZjdThNeTNoY2Jq?=
 =?utf-8?B?TG02M3ZIL0U1NDVIVzV0cHB6d1J3ZTk0dXFTNVlnRE5ONjVwNkc4RkR4MlRJ?=
 =?utf-8?B?aWgvZmVzRkl5ZXVKdU01U2JoNDF2T0d6RXhQSHhza0JpeVJhbk1PY3pFV1VO?=
 =?utf-8?B?TDNWbXFqdWorQ2NZZVNJZGhWOVh5ZTZWcjRBVGFVQXBrK1ZJcWNHN29mK0hX?=
 =?utf-8?B?OVJtcUhXcjg1akxCcTJac2tSV1dPdGFSNllCUVR2dlkxYlkvang3YnBheFhU?=
 =?utf-8?B?RmpraWJuSE1GMkVkYStOc2hrdm1pdVovd21scXpjbEgySStnN0RqZjFYWkd6?=
 =?utf-8?B?TzJNajQ0MFNoWTNPK0hvei9uMkI2Z2x3Nmc1ZnY4ZXp4b1VlZ0U5RWVFSFdX?=
 =?utf-8?B?a3lNdmtqQUhjWDJjZ1RmcW5yUlczdUEyTkFsTHgyUlZuY0N0VWVVTkhBWk1W?=
 =?utf-8?B?T1dsUi9YeHJsU1IxU2Zzakk5NkNzV0FpalJKU1ZFRjdFUi9aVFhtTU4wVWJI?=
 =?utf-8?B?V081bWtGc2R6ZmJib2tuYi82R01qUzI4RDhOYUFCL2htOEtaRmhaWnJJSGxF?=
 =?utf-8?B?dFVBVkhPd2h1MFQ2UWo1Q0JzRys5REtqYXpoZHVTdW5oNlBLVjlKN3ZtY0VP?=
 =?utf-8?B?STN1Nk0vMi9mMjRPdlpUQTJuTU5WY3pUQ2FJQkZudUFuaXZpYm1LR080UEEw?=
 =?utf-8?B?SU90Sk41V21FV3QrM2gyK3lOY1B6TUhvRlZabERycEpXWVIzSTlIZXZyQXVQ?=
 =?utf-8?Q?Zu1EMNx1XLdLgRVnDEnAgso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGswd0dUdjJCNStOdHU2b0I4bnozdWMvaklPZEFhSGZhbjJKdDh0RURIaTNS?=
 =?utf-8?B?VXN0eWE2ZzRxZWNvMVRpRXpUaXd4dHF5M2V4TUR3ODNLbDBvYWFwMUh3Y0Np?=
 =?utf-8?B?NnJuTTI0OW9IdHl4WUFyYkVxdnZGUEt0RkNXMjhYSmpqOUovTlhWTGgrcFFR?=
 =?utf-8?B?WnBBOFp1Tm1IZVh0ZHJvM1hSQ25ML2xBcEh3UWs4am4vVFRXRlNpSFhFSkwx?=
 =?utf-8?B?N1l3UlpiQTZrRnpZeFMrbC9aNzkwTkgzN1JSR2RiZFdTTDZSR1dYdlpFUUNh?=
 =?utf-8?B?d1ZVSHVyMHk2MEVEZnZzcWt2TWw4aG0rdkIwejhQYW95Vmt0WFBXZW5kRndP?=
 =?utf-8?B?bnZFbEpDRWl1OElRb2IrZHl2VzRkU0IyeEoyNi81VXpCb1BTWWRwZVNFN1Er?=
 =?utf-8?B?RStqUWM1SFRqVER0N3ZpV2Y1bE9EU2VYbXNCR0NCS0FXSmhRWndpRS9PRmZK?=
 =?utf-8?B?VndFQjZpbnVUYnp3RjlLUXVnS05ISkM4OGV2blZ5L0xGcEpKU0wwSWZHa0FC?=
 =?utf-8?B?a1E0QTNWUHFMZ1hwZElqbC9xdWlZb2VRbjh0cUE4RWU4ZW1WUUdwN0tYb2Yy?=
 =?utf-8?B?clkvdzU0bzltQ2MvaXN4THB0SU8yZ2J6bTBBV09zNnRjc3NNR0k5cHRNZzd0?=
 =?utf-8?B?Zi9Ud3FpM3VGaHJNRng4eDRkMmw1d0RuZzRYWm9aaDh2TkRFWkcyMDVwbDJL?=
 =?utf-8?B?QXErTEd2QmwrcGtQMTRZUFBTOUNUVlBKT1BPd1MzeWpQc2ExL1BnNlVTdnV3?=
 =?utf-8?B?aHg4RjZxTTNWSDRrUm05Y2hJbVllSjVBSFNuMExuVU5EUWc3cWh0eXNQaC9J?=
 =?utf-8?B?TUpyUlI0LzFwNGlTclhrbWRFV0thbTduaWhkM3NmUk9rZGFRdkVrSVYzVFlH?=
 =?utf-8?B?QnVpcEU4RnBlQm1IT2FjeklPTFVZQjZmMXV4Y2xsWjlyZ2tJSWVvSVZmck5y?=
 =?utf-8?B?YXRUNGx6S1AxS2FDOTgrcnlCcUhtNWFYTnY3U3Jzem5rNktBY0VlZG52WFNG?=
 =?utf-8?B?R1N5dHFPeDlocU9kYmpjRVNEdHF6M0FSdm94cEI0ZEZoNHdWQTJBNnFSQVEr?=
 =?utf-8?B?aGloT3JWNmZQenZWYUtEREp6Ni9VVFVpNzNlZWRlWkRQM3N4VzU4MjdZaWVm?=
 =?utf-8?B?dnkzWTc1M3o2cFJ1VE9wNk10RDR0NmNVV1F4Wndzb3hOaHFtOTVlbWcwU1Av?=
 =?utf-8?B?QmJZOXNDWE1iWjVkbkdGeWYzbFZ0T0dJRzA0UFVVOEZhQ3VJZ0tUNWVuRlRw?=
 =?utf-8?B?VlhUUWZHSDJ6ck9tcjBTa0JONHBPVGkzcWo3UWE1UWtsVFN5eXpMNXFoeEcw?=
 =?utf-8?B?dUhVQzFnTGJqUEROeWwwN0FOOFcyTkgxVkN4Y0FyTWw3M3l2MmJ5Tm50UURv?=
 =?utf-8?B?ajIwNk0rdTcwTlltUER2eG9HOHBsWEsrN0x3TmRIYnZaSllFOHIrVUdlL1FR?=
 =?utf-8?B?aC9IaUJXUEZnZkRCaURmNjYrM05ydzErdVR5NkQyWi9oRjZNSFFZdVVVbG9Z?=
 =?utf-8?B?ODhaZG1EVU01UmlZbnVIMSt0V2hIamJNUUpURWFlMDEvajM1alFycHBoOGww?=
 =?utf-8?B?MVlQWjVOWmtlSUlkVkVZbUxkRHJka0NkeGxGVnpVUDUvSzNQckxlMmlEYnp1?=
 =?utf-8?B?T0tUSVRPWlFnQTN5YkpuSVlodk9MOUUrNUZ4UUgxTzBaRkdhbXEvYmRPS2Ns?=
 =?utf-8?B?aWtyTTZZWGZobGs1SE4wMHRhdFhsZ3R2T1RNQW5GS1c4azlVaGJjb3FMWk1M?=
 =?utf-8?B?Q2xHWWo3aEYxZ3BzRHFjeUdSekg5SzIxdWQ0VG4yVmN2MGZsazFPaTl6WXZz?=
 =?utf-8?B?Qk94Y3NISEhWd255OVhHOXd1VHA5YkdqK1dRZ2w2dk4vNVphaGV2cG9XVHdw?=
 =?utf-8?B?TVM3SElIajM5dldDV2NYRHgzd3UrYm9QTEt3M3FxdkRYWkd3S3JYUzRRNHFi?=
 =?utf-8?B?Qnd0dlJFcWFFc0RsRGZjTkZ0a21iZkdTbC9IN0kxOTJSb1dyK0Nxa1pwSUZZ?=
 =?utf-8?B?WGZldUUyK2h4aUpxcERNMHZacGNLeXRlaXluZGxGWGN4OSs5bWFiVnduZkVW?=
 =?utf-8?B?R0lXTFB1dVZHWjVFUlNnT2l2TjZWSWlTd2xZZWVZY1VxOTZmcHRNb0ZDTTc5?=
 =?utf-8?B?eXAzY1pyc2tKeTkxM0VnNWttbEFMMWxVb1lJZEp6Q0ZneXZjQUwxQzJjbWp0?=
 =?utf-8?B?UWlrL0pPYys5OS9CN0E4MjkwQi9wR0s1SlZadkJiNGxsaWNxOTZhencrekVG?=
 =?utf-8?B?UmZ0SVpsWkd0aGpmRnZGZXZNcnVDVWRncE5tM0hQWVNIenBheUxxTEVLVDZX?=
 =?utf-8?B?ZVJucTQzSjhjRXY5K1VxdDJORVZFOXlIV3p6ZVVRaHQ5WDk2Tlo2QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea1800c-3ef0-4fc2-84a7-08de5faf7676
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 03:27:14.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM2hQvuON+vbGRNdxamwpY68vgN1/vYgaJ3MUGyObZ9nlIz9PXpOmxCv52eyepBEEUMRIp8WsqPY64PxVREf9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11496
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212833-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: D9537B6D3F
X-Rspamd-Action: no action

Hi Daniel,

On Thu, Jan 29, 2026 at 06:02:21PM +0200, Daniel Baluta wrote:
>On Thu, Jan 29, 2026 at 3:45 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
>> resource table even when the current firmware does not provide one.
>>
>> When the device tree contains a "rsc-table" entry, priv->rsc_table is
>> non-NULL and denotes where a resource table would be located if one is
>> present in memory. However, when the current firmware has no resource
>> table, rproc->table_ptr is NULL. The function still returns
>> priv->rsc_table, and the remoteproc core interprets this as a valid loaded
>> resource table.
>>
>> Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
>> there is no resource table for the current firmware (i.e. when
>> rproc->table_ptr is NULL). This aligns the function's semantics with the
>> remoteproc core: a loaded resource table is only reported when a valid
>> table_ptr exists.
>>
>> With this change, starting firmware without a resource table no longer
>> triggers a crash.
>>
>> Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
>Changes looks good to  me >
>
>> --- a/drivers/remoteproc/imx_rproc.c
>> +++ b/drivers/remoteproc/imx_rproc.c
>> @@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
>>  {
>>         struct imx_rproc *priv = rproc->priv;
>>
>> +       /* No resource table in the firmware */
>> +       if (!rproc->table_ptr)
>> +               return NULL;
>
>I wonder if we can make this change generic because it should happen
>on other platforms also.
>
>Maybe something like this:
>
>remoteproc: core: Only copy loaded table when valid
>
>Copy resource table in memory only when:
>* the current loaded firmware provides one
>AND
>* there is an explicit request to have the rsc table copied in memory
>via rsc-table
>
>--- a/drivers/remoteproc/remoteproc_core.c
>+++ b/drivers/remoteproc/remoteproc_core.c
>@@ -1281,7 +1281,7 @@ static int rproc_start(struct rproc *rproc,
>const struct firmware *fw)
>         * that any subsequent changes will be applied to the loaded version.
>         */
>        loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
>-       if (loaded_table) {
>+       if (rproc->cached_table && loaded_table) {
>                memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
>                rproc->table_ptr = loaded_table;
>        }

This change looks fine to me; however, it should not be treated as a bug fix
for imx_rproc. Since we need a proper Fixes tag for backporting, I would still
prefer using the changes in my original patch to ensure it can be applied to
older releases.

As for the modification you introduced, I think it can serve as a guard to
prevent potential issues on other platforms. You could submit it separately as
a formal patch to the mailing list.

Thanks,
Peng

