Return-Path: <stable+bounces-135240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15750A97FDC
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 08:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C547AD191
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466EA2750ED;
	Wed, 23 Apr 2025 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="FTMi5N9O"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2111.outbound.protection.outlook.com [40.107.105.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09622676F6;
	Wed, 23 Apr 2025 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391063; cv=fail; b=F7vfYi5wocE8q1qzY8MetN8IDbUWA+O6Q3iKJqM37DcK/B5EvWQS6RS1lspYW8LkUcx4PRKobR9ph9DxNkA8OJM4u2TV5Uau6HcRD0fNz/KpLDDwjO5wiU7ojjCNeFvPPQHEt6baEj5CRYs+KBBWRWTkX3pU251BXmaMunQ7OFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391063; c=relaxed/simple;
	bh=9OKSJ3kB1xBX44bYKSgphcg4HUaNV4In9J4sDmm6Pqo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s4lUESSN5K/Wqk35r90QvmY7WXJMO9lnXR6cPqMr7V269WEL6MpUkaf3x51k9sgOE/MqezVl49YcVnM9/6/QtEIMZd+7wkmHwlh/pqJHQTKlpgbwXqKwj8879uHAeWNJGvQGY7L5NPgwxPhm6CzE9Sn+dxhXmRO8LOuP4ev62m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=FTMi5N9O; arc=fail smtp.client-ip=40.107.105.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlR1e3o7C4h6mkkdMiLejT3WN5L/nGaPxFTlUEVCCImsEwRlBRfyuyN0z/gadJBls2TELUK7OHyxzIMKaFLiSW44q1brqwHg4QO88vqAgLPB57CWSP6nnlmttkzU1mfq19cL3VGkSx1iN8qtuDZaQ64sv6wIU5F8xtvWjlNAoD+lBmOJj4gnCf5JQBFJmis8iiOoEgZFvf8gVHE7KAsyAQCLuCUakfH0dshEaZws45Af86IU/mjdNV6JpEMmcww0zjFAov7zCuWWMsSZnjiBvVAmRN9jjpYRvhf2CFqNpd5rcE1G7+FKdsZyRbWg6FLBGITraP3NtjhHZvPl4DzjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql4P9a+VO1L0L++Br3RxYja9ExqsJGy8bAol47rvhYA=;
 b=mmTj0R6EuLywwgpFCDR7GBbeT64oOR0v/BKcCArJSQ6CWsb/a9cF8SfMUy7gKe/2mK8xH6KUG7L1ib2GmeaPI7kgnMDLQjzAyf+JZelB0gmA0Qdy/vtpjeVRttIbkgb7do5UrJGVhin5pK5TZ28GL0FnNLpWvCpnqrkBCX52pgemR8y2b232E+2Jb5qLAb10UpqqOIJFLW9/I/sjTc0yJYK/oPuaij1alcvJhcFUu8OjS6MJRBPGpEpv7R/X3Xk6RufHL4781nLSmXmsDe5IuxtKUy/glsbxEJ/BsKhyQlKD9rlV9clqC/x7kavKImVLHwDBjHJzY/rMoKi9Xte4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql4P9a+VO1L0L++Br3RxYja9ExqsJGy8bAol47rvhYA=;
 b=FTMi5N9OH8xFiTXC8aO5DiW6M4mPJ33vlX3IzhpWt4NLCF8ZP2kHHDa4Hbk8o0VLFMwlxV4Q3BrCSJNYkVoR1HcTIJUoywu9Jm/oKVxTAfTIk099ySe+1DTtKfr8PP7t3jIz5UCWQhMvp92rg7kCVVaeZMQqO3lP8aI/AsXnfXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA1PR10MB8626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 06:50:57 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 06:50:56 +0000
Message-ID: <522decdf-faa0-433b-8b92-760f8fd04388@kontron.de>
Date: Wed, 23 Apr 2025 08:50:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Francesco Dolcini <francesco@dolcini.it>,
 Philippe Schenker <philippe.schenker@impulsing.ch>, stable@vger.kernel.org
References: <20250422124619.713235-1-Wojciech.Dubowik@mt.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250422124619.713235-1-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA1PR10MB8626:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad0f911-52cd-4835-a06f-08dd823332bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0MzYnlOWmo1dHgrNGF6eXFEYVNGRy80L2dETXpyVDdCTW9EdnpHV2hSamJO?=
 =?utf-8?B?Y1h3YnE1cmtNR3QwZUY2cUVhN3NVVTdtUTIxUGF3RVdTY1JhUDBBbEovZEJN?=
 =?utf-8?B?b1JVM1JjT0hTdmF0SmQxV2UxOWpyZXN2MXd1U2pWUldzZ2x1ZXJVYlV3Y3pO?=
 =?utf-8?B?Y0NrY08rL0plaHFuTlI4elh1L296NGZmY2IwaXEwVS81NVhBaXREUU1lWEpm?=
 =?utf-8?B?SE9Gb09RR2JCZ1VwV1d0dFl4UlBpanRKVytHTS9UZ3d5aExyenByMDJyZ3JJ?=
 =?utf-8?B?d0RQQmdpcStOb01ETFB4ZnBXSnZ6OGR0RjhkWGczK1F6eTJCejh3TExxZHo1?=
 =?utf-8?B?Qk1UZFFoWThyK0ZjeUpTTTFtYytTNlY2c1VMVXQxY0ZNcE9QbXp3d1Vwcmlp?=
 =?utf-8?B?Z0JPcXZ1a243REFXcTBZVVVweWtWMWdhZlh5SGJEaGdTODJvNTJOVGVzQjFR?=
 =?utf-8?B?M002cGJ4SWRrLzM5Qmg4OWp2dmJRalJ1Tzl2VkhRVVcwSGNFcDFSK0Z1Zm9i?=
 =?utf-8?B?cjdiNlpIbVpyQW9DY0dMS2dpTjlvWCt3eVZ1REZqQk1qVEVWMDltUmdpem9Z?=
 =?utf-8?B?R240U0FJSENlaG4rTnEySkxzVGNuRThuakFZTnRmY3FTMnBtaHBQTHU4MVJS?=
 =?utf-8?B?NUdkVUw5bEdERGVUazE1dXY2dVJqMG5rSUc5VzVPZFo2UTR6cm9haW9vbFdt?=
 =?utf-8?B?S2VEb0tISGtoMm9Rd3pWTzhIc1pYVlVwNHhLamFCd1EyYTNPZGYwbmlnNlFD?=
 =?utf-8?B?NkFTNlhPay84N1liVVBORjFFUEJjV3lOSGw1blZqbi9qcHdxU0RRdWtJazRt?=
 =?utf-8?B?bWxNc2h6RXFNeWlxQk5tTHd3Wk00Ujh5MkZJbHNBdm5UY2Y1UFZ3RHpYZE5P?=
 =?utf-8?B?YkhsTy9CbEx0aGFNT1JuWGZ3WTVldUVyakhpcVc5V3pTYmVkSGk2cDdMZktm?=
 =?utf-8?B?dC9SUUFvcHNsOTZkamhRMWVJRmd2NXBUMFFnWWdGT3ZMNW14MWg2MTY3eTlo?=
 =?utf-8?B?bjhjUkRoczdxYzQvMVg4QXcrd0lieCtuY05aZ3A0Tzk0U2RLVHoyQjR6WFZO?=
 =?utf-8?B?UHRDWkxTc2s0OHVUWmVlSGpSZlZoWjY4K0NYWVlGLzdUS1hsRU5VMUkyMWpk?=
 =?utf-8?B?NEFrOUpUMkQyK2hRWXZqMlI0Vjd4eWdhT2N3WFBYSUppbnBkdE5PMkJjK0xv?=
 =?utf-8?B?N3NGNzgyeElOcnlUU3ZoUVd2VWVObDk1S2lQUFc2VW5aWlBZOHl5TnFGZUFl?=
 =?utf-8?B?dXBWUG85MFdtT3l1V1RjRGlZN2Y2NUpoVnFQSVBpSjVqWDF4aVAxcDQrY0d0?=
 =?utf-8?B?VWhLWGxsZW03NDkyRDlMUUk3ZmZPVTEyRVgrZGJWak1xaE94SWtGbTBkVUo2?=
 =?utf-8?B?bHZiNW01ZUpTS3lhY0ZlZ1JDOGFwdFpKTHh2MTNYd0t6N3N4L2FHdlI5Q1ZB?=
 =?utf-8?B?cm51YVNUOXBOMW5NUXd0QzZYUXk5L2FxZkJXaE1xZ3Q5dlZVWW1KTU9TOHRm?=
 =?utf-8?B?TEFLREhLUVlpK0d2WDZYV2JFajRYV3VOODZBbWxSL0tHRUlENnB6dnpkaUVz?=
 =?utf-8?B?MFlHSmlrcG5wcWRXZVdKT0d3cUU2WlY2QTBxWGFCREJhbStFTU5LQjdodEVB?=
 =?utf-8?B?RElSYkNXQVFyRi9KQzhNTFZVNk9sN2RTaTlOVTZ4UktHRkc1bE0veTBIZlZy?=
 =?utf-8?B?NE1KblZhcHhTLzBHNGtLN3g4Z2d1L0JBaFVkV1dBazZ4c2NwQTlRaEFnOExJ?=
 =?utf-8?B?WkdvL3p4T0krV2wySmtTU0lJc3VYVkxtNnpMZHB4U0dZTzY0ZVlkZ01mOG05?=
 =?utf-8?B?RUtOZU9oREJVbEJnM3NIckRxQkFHWDZjb2loUCt0dllxUEZESHM4MVgwbzI1?=
 =?utf-8?B?dGZXV21Ga2cyZ2FxY1Izc2lhbDVyckUybTdZbjI5emt1WnNQRHhieXRwa2hT?=
 =?utf-8?Q?xmOVzAXZ2Jo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUloMnNOWmNnQjR3WXBmajVTK21BOWRrM1hrWE5EeWJKZlp5RmROVVJ4NXNS?=
 =?utf-8?B?b1FMRXhOWU9mN1A0RThzUW9uc0x5N2hpdUVQY2VHeFdDZjNDbnViaTVJUm5Q?=
 =?utf-8?B?ZndWZEszV1lvNUhNK0NEK2xKSUQ3Y2orOWZZcUpnc0FBSWhMY3hkMEd3OExv?=
 =?utf-8?B?V2lQdDBySzR6Ty9TZDY3M0hlWklxSEgrWC9Uc2toaE1IUHZaZGkvekNCOFJ5?=
 =?utf-8?B?SmgzSVNHUWw2WkpJdHdTOUk4UHpzQi8rRmN6eTgxOU1CSFNRU0x6TThtOEhj?=
 =?utf-8?B?S09CV0xuOHMxQk10M3RnYTJvZEtmSmJvYjFNeXpJcXdWcStVd2Q0T2RsWUMr?=
 =?utf-8?B?eVk1M0NDMENVSTQyOHVYV1ZxcTNjUU9USHNqUVYxYlBCT0hYUys2KzJnanFO?=
 =?utf-8?B?alNUWllvR09DZUpFeFpHZ3FiK1RNbExGK3RQaUsyRVE5Q2pTMW5qd0hLOGJO?=
 =?utf-8?B?L3loUld1WU5YVWFHb0V1L1JGaGFCdC8zRVdKbVRrZTRLRzYwZlpxbjk3Vnpl?=
 =?utf-8?B?cmhMTXlMbnY5U0JBTjI5RHJ5VjFiMWlWRlRMb1dobnVERVZQZ1h5U25Nc092?=
 =?utf-8?B?MGdhemFSbmwzWHp4N3h1VmtaWHdrZ3RoMXhkQktMblFLK202YThROWdLcGVM?=
 =?utf-8?B?alNtN3NtYjhXTXF1VVFVUFU1MEhrMFNvdlB2dmQxbkhkbmQxWUJUSy95cS9E?=
 =?utf-8?B?RlZNREZTb01UV09ndDZGTDBMR0NISTdDV0o5T1JCMjg4UDVCSjUzbWVpNUtK?=
 =?utf-8?B?Zm5DNzltTkpnTlpydlZPUWs5Z1hvcXBGbHhTWHRKZVcrVjRMM2dYUHNsZ25W?=
 =?utf-8?B?bUhDS2g4L2xkdm83MlphSmZlRjc3NnJVaFVJM3g2N05CK3pBc3VXUW1xa0c0?=
 =?utf-8?B?b0xBKzI4aHZCaE04V3hIa2x4NEZlUTdQa1FZRmw1ZWJ3dFhyLzJZR1c2L2hE?=
 =?utf-8?B?cnlOUTduV3U4OUthZWlhcmdqaDUzbUZkQktSRk1FSlpDc3BjNUJBUWNiUzQv?=
 =?utf-8?B?ZmVRYTZKOCtVNWJDMTg4ZGUwRXlhUEhyeGZNeGozc2ozYmloakJONE93eVZO?=
 =?utf-8?B?WU9lWmsvQnZVMFFxWG1uUzVRZ0xxTDBLUk5JSUlyN01VZCtBR2l5RHdoUTkx?=
 =?utf-8?B?bkpWZ0JUZGl2enNlVHVWeHZ5OXBiSEZiNGJnSkI5V3R0NldPeEZ6UTg4NDlW?=
 =?utf-8?B?TWhpOHduZGZkQk8rTU8vYWlVbzVTSS9BNVM2ckxGOVdlV1R6cHg0bUwzcFU4?=
 =?utf-8?B?a3M3UHRYdjNXcHcyZ2RjeDE3eXNISUVtZjNnOGhiMTNLZ2tqbW9vdEtZNmZh?=
 =?utf-8?B?akk4THdQRGs4N3lyWlloRFh4WlNSTUhESll3akZNcHBoWUFWOUxJNXN2RFlj?=
 =?utf-8?B?TWg4bFlESmxZK0piQkRzVkdlV0hMT0RobFhWU04za0o3TjUzZzJzNDR2ODZq?=
 =?utf-8?B?MTJKaHoxbTF5K2VDZVA3WkdqejRtNjd0OTZYNmFzZkFmbTJxdkJpRWRPM2Vr?=
 =?utf-8?B?QjdOZUEyc0d4R1NpTkQ2U2t0Q1NrR2VOMW53MDRVSHMzWGtNUFhObGZzaVFX?=
 =?utf-8?B?YUkwakZOQTNxa0FtSWM1Ykl4OXZ6VXMzek1lYjhnUUE5dGh0SDhyZ1h0SURt?=
 =?utf-8?B?L3B1eHd2T21lbllkbmhIRDFBV00rUm5YNDJzZ0dvK2phWWZHZnZYajhHMzJr?=
 =?utf-8?B?c2tVQ1BxRGpVRmsyeThiTnNjOFZoT3l5dnlReG1RQVJyUWdGQUIzYWlXTmk3?=
 =?utf-8?B?dHVLMC9WUU43QjVsMEkzN2M2MW5IN3EySmJHbmxZeGdmT1ZKT2NmRjZYWFVx?=
 =?utf-8?B?WGtDTUNoSkFRREdQYkowd1ZBandMREVMZlY5OS9ibDFsaXp4OHNuamNMMmVG?=
 =?utf-8?B?V2JyVzU0NVBDb0kzK2I3dWZrZXZ0VFErNDgvN2diTmpSeVNYc056Z0l2eXM4?=
 =?utf-8?B?cmVvcy9ZRjF6S1NSdkdoNmlUOUxMendPNTBmTDMvQUp0RmdHeEJmaEQ3dUhm?=
 =?utf-8?B?WS9oeXhrMUtOazluWnJDVDk4TjQ3dWFUVENMaERRVWxJZXNOcHBOWmFmL0Vq?=
 =?utf-8?B?R2F5NVNjU2FrSVpKMGQrYy9UdUpHQVVwZUJRbnJySS9ZRk1Jb1ZNRkRXNkFx?=
 =?utf-8?B?eDhZOFBSY1dNc29tdmZ6UkQ0U21lbFdvMFI3dDJvNWxvb2dFZ1dZZXBhYmpq?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad0f911-52cd-4835-a06f-08dd823332bb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:50:56.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6pF6o/2rd1vomGeQxuc2o7Tf5/ipe49nLCaW7ZRNsAXTpM2CX+zE1uJAdW2tKaPuOBhFA731h4rUyc8+C8sAJx4rggZaqJyUzHcmjkYBBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8626

Hi Wojciech,

Am 22.04.25 um 14:46 schrieb Wojciech Dubowik:
> [Sie erhalten nicht häufig E-Mails von wojciech.dubowik@mt.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Define vqmmc regulator-gpio for usdhc2 with vin-supply
> coming from LDO5.
> 
> Without this definition LDO5 will be powered down, disabling
> SD card after bootup. This has been introduced in commit
> f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
> 
> Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> v1 -> v2: https://lore.kernel.org/all/20250417112012.785420-1-Wojciech.Dubowik@mt.com/
>  - define gpio regulator for LDO5 vin controlled by vselect signal
> ---
>  .../boot/dts/freescale/imx8mm-verdin.dtsi     | 23 +++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index 7251ad3a0017..9b56a36c5f77 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -144,6 +144,19 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>                 startup-delay-us = <20000>;
>         };
> 
> +       reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
> +               compatible = "regulator-gpio";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_usdhc2_vsel>;
> +               gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-min-microvolt = <1800000>;
> +               states = <1800000 0x1>,
> +                        <3300000 0x0>;
> +               regulator-name = "PMIC_USDHC_VSELECT";
> +               vin-supply = <&reg_nvcc_sd>;
> +       };

Please do not describe the SD_VSEL of the PMIC as gpio-regulator. There
already is a regulator node reg_nvcc_sd for the LDO5 of the PMIC.

> +
>         reserved-memory {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
> @@ -785,6 +798,7 @@ &usdhc2 {
>         pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
>         pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
>         vmmc-supply = <&reg_usdhc2_vmmc>;
> +       vqmmc-supply = <&reg_usdhc2_vqmmc>;

You should reference the reg_nvcc_sd directly here and actually this
should be the only change you need to fix things, no?

>  };
> 
>  &wdog1 {
> @@ -1206,13 +1220,17 @@ pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
>                         <MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5                0x6>;   /* SODIMM 76 */
>         };
> 
> +       pinctrl_usdhc2_vsel: usdhc2vselgrp {
> +               fsl,pins =
> +                       <MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT 0x10>; /* PMIC_USDHC_VSELECT */
> +       };
> +
>         /*
>          * Note: Due to ERR050080 we use discrete external on-module resistors pulling-up to the
>          * on-module +V3.3_1.8_SD (LDO5) rail and explicitly disable the internal pull-ups here.
>          */
>         pinctrl_usdhc2: usdhc2grp {
>                 fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT         0x10>,

You should keep these pin definitions, but while at it make sure to
enable the SION bit so the PMIC driver can read back the status of the
SD_VSEL signal while the USDHC controller controls it in hardware.

Adding sd-vsel-gpios to the reg_nvcc_sd node makes this work. See [1]
for an example.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8472751c4d96b558d60d0f6aede6b24b64bcb3c9

Thanks
Frieder

>                         <MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                0x90>,  /* SODIMM 78 */
>                         <MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                0x90>,  /* SODIMM 74 */
>                         <MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0            0x90>,  /* SODIMM 80 */
> @@ -1223,7 +1241,6 @@ pinctrl_usdhc2: usdhc2grp {
> 
>         pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
>                 fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT         0x10>,
>                         <MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                0x94>,
>                         <MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                0x94>,
>                         <MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0            0x94>,
> @@ -1234,7 +1251,6 @@ pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> 
>         pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
>                 fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT         0x10>,
>                         <MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                0x96>,
>                         <MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                0x96>,
>                         <MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0            0x96>,
> @@ -1246,7 +1262,6 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
>         /* Avoid backfeeding with removed card power */
>         pinctrl_usdhc2_sleep: usdhc2slpgrp {
>                 fsl,pins =
> -                       <MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT         0x0>,
>                         <MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                0x0>,
>                         <MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                0x0>,
>                         <MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0            0x0>,
> --
> 2.47.2
> 
> 


