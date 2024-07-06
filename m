Return-Path: <stable+bounces-58168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7B9929232
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A26282E84
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03E04AED7;
	Sat,  6 Jul 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="fmJ+O8Nt"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2116.outbound.protection.outlook.com [40.107.20.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345804437F;
	Sat,  6 Jul 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720257739; cv=fail; b=sjLb/T1Ywab7ILTypHVCVoWSY4q296WchWyWplJ3kVeuYqfoNj8Zspw3NmZsmLb7ZYMGJDou2G06SNLfEfiLOEN5ZJkNEsPTxbHFXgdR5MKUB3ln8KXm+hMsy3b2zbjfB/GncE0MJXgX/e/d7nOdbCnYbLgk/lHvcnQ1vFaKTK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720257739; c=relaxed/simple;
	bh=JDcexsFoloLvCJvasDBMcKFFCkKsd5a1uvOCGVu9aM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eyktWi1V94EoCNyzThzZXSn02v/gy0Mssyk9jMCATsQqAu1FYz0x8+kAnJIMJh8ZLcIJBFw3IiG6wMtm7glPHzNTcYz3wT1bQlnM3DTNqe1eTI18pxH3B7eApWCkqxr7cxgEBxLjXu3IA4Y1tsB9A+fbaxs1k/jj7C7B6do6l44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com; spf=pass smtp.mailfrom=raritan.com; dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b=fmJ+O8Nt; arc=fail smtp.client-ip=40.107.20.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raritan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMv7clQJg0qpbB0cUzNPMUCd+xyV/uCqFVYqwcn8+4Q8BDd+lroWB74gXvaiYLrktiuPT94b+p6PuegsEawrwSCzQDA1zq2qOwfau8sBE6k/x49rJ3mHqes/aGAGaXfYVWMlRgka0rCl8UdBFecmncjtXYmGJIG/hAtndQIirgI2E3ENbNVJVGVJpwPDTJDaWe5ecbXKA3VMyWf1qTDd1VcDdhDp/T4zsQZWbHZwOsHEyDmAvrzF1EbTbZMh0ziy3d2sYgPsvjjATob2wAgHtjFxsC2UsyeArYC29UQxlzLiQNC7E+/pHOUDoDD8sjgPBsSG3wmLuNTmbBnVJyUEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTDShe8ca+EQL1+AGwFbodAhQI1RD28jBP4joOXf/wo=;
 b=hmgfqj8ZZGq3uH0Qt48e/cyA7V9oyz74P+4L9KKYWVwzif2cA25eOZIY+WG0Mrb2pm7QdkMYTjqwFm5f3jF2ck3aTgPpJr1/YXGHlb1hMqOe3tuZfp1yDr4DscIHB+3hnTaroP2m+fljfnyjpmDP/csn4pmnoAL1JY+YC76DXDZPY7tIiFOR5eWgYBPHpmcHTScDgjnJeWVF4MMQ3PF/ngOMOXuLzfKwfNZS7Ce/uy6Q+QxcvZ/1oQVxd2Lh2wkQeAoE1wi7vBtSQUa8yZAwEs+SokjaVv8WbkxjN9F9mT0Bsrk7E3mk8tDYA/jXk2pjoze4XYd8hZKgpdbuSogxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTDShe8ca+EQL1+AGwFbodAhQI1RD28jBP4joOXf/wo=;
 b=fmJ+O8NtBSMsH/ZKJIX0mHinXTW+kVUgC3atKUUFVhZsH8T/UTpNiieTFpzrNwPiBAnWoUUXHLpHq0ZlHa5kSgTiCugAvRj1INYe0En0F7VBgnOpOu6YUfezGk1zeDbvwEa7+MaIYm3nJb6wo9svHCmFEH89bOZBv1bW4USuMhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com (2603:10a6:20b:1c6::15)
 by AS1PR06MB8514.eurprd06.prod.outlook.com (2603:10a6:20b:4de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Sat, 6 Jul
 2024 09:22:13 +0000
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36]) by AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36%5]) with mapi id 15.20.7741.030; Sat, 6 Jul 2024
 09:22:13 +0000
Message-ID: <4e4fad0c-c7bf-4b64-a30f-489c5dc4875c@raritan.com>
Date: Sat, 6 Jul 2024 11:22:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ks8851: Fix deadlock with the SPI chip variant
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Ronald Wahl <rwahl@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20240704174756.1225995-1-rwahl@gmx.de>
 <20240705173931.28e8b858@kernel.org>
 <2f3c0444-c02a-4fff-8648-d053a0cb21a2@raritan.com>
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <2f3c0444-c02a-4fff-8648-d053a0cb21a2@raritan.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To AM8PR06MB7012.eurprd06.prod.outlook.com
 (2603:10a6:20b:1c6::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR06MB7012:EE_|AS1PR06MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 047b86ea-7196-483c-3570-08dc9d9d1ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1lkanFxbU5wL2JCcUdYVUZvZ1RuZ3QvcWFGQ1N5R1J3VmNoTVB3T0o3SEY4?=
 =?utf-8?B?RXE1cVVTbUpXTTk5MEozMkVrcW1OUUdiZEVSQldFaGdZUVlIbE5Vby9QTkJn?=
 =?utf-8?B?VGlNRENUTnYwalMwMXBvQ3p2S0l3WWhSRDZYZmVHQ3VwZjZmOTlCc0hZWHB3?=
 =?utf-8?B?cElza1gwM1VBTVVjMWNSejVJWlJSWFhhMGdaaStjYnp2UWpIT2Y5N0NSNlJu?=
 =?utf-8?B?SjRFREhPUkYwa0NidStoc3F1WXlQZUllenJFV1pOMHU3ckRodGxKN3JNMFZ0?=
 =?utf-8?B?bi9CaXlnOG5SbkJ2SnFRZFdodUdKNWxRbzlaYllpYnQxRDZ4SUdSb1Zzdnln?=
 =?utf-8?B?NDFpZHFqdEVPK1Q0WnVwU1ozc2dJM3lOUXI5SkdJME5KS3N6OFNCZnZjODc4?=
 =?utf-8?B?TUYxcnE2Ky9ZMExmeVdlSW1QSE82MUM5YzY5NEN5L0NFMEdQMzN6aDY1WDJj?=
 =?utf-8?B?NHR0bjFtYU8zWTFsZnFqM2hGN1VUWlhYd3R3UGxvdFo0WTVNUzUvL2sySFVr?=
 =?utf-8?B?YVY2ME9ISURxOVM5aEZMZ25IeEtpOHpQeVUvT3phdzdPSFNybDBNZG01R0Vw?=
 =?utf-8?B?T2dIYU8zWG14MlhzOFhKUHJQUnZnekFLbGR3QWJ0UGdIZXI1QS9uT0J0VXhn?=
 =?utf-8?B?bWZmUExJTlBPL2k0Zy9hSTR5bkFTSWR0UllWU09XUTlKcVFyTjdNaDVzZ29Y?=
 =?utf-8?B?dzcxZjJDU3dXamhDa3NtZFdUVTkvNGZsWEVQekF0VDhjQk9FeUpFLzkyR0NM?=
 =?utf-8?B?NmRaUGpwOGJEMDRQdEUxQkx0eDhKWVo3VWNpanZKRzBKVU0ySmlwTURHdktE?=
 =?utf-8?B?SmRCRUVvcXBvckZvRWlCcnYzQjYyaGhMVWh3d2hGRXBVVVhtS0ZqdGRVOVRG?=
 =?utf-8?B?MVpnMWV4RTRZTm1obWtsbmYwNFBEVzMrczhQb3hIby9Ldi9xR1RnOVBBMkI3?=
 =?utf-8?B?L3JRSk40WXpWVzJwVXVIbFZLNmFRdTVUbCtnaEJqQi9IVXVWcyt6UlVQNE41?=
 =?utf-8?B?TkM4dGVVeWo4akRIRmxpRGZkMWVCUUNwRHlYZHN1TFVDTlBEQStkbmxvU0RE?=
 =?utf-8?B?L3MzQmhSTkZDT1ZWV1crdEdtSmo0dk1HejJycE9vOXlFYkpSMlEvbGZkRjlr?=
 =?utf-8?B?R2ZDYnUwMlZ1SGFqV25MVm8xRlBLVCs1d3gwUW9RdVJ4OGlLdmE1TDBCRENj?=
 =?utf-8?B?bm4zNVdWajhBQXVCMkJwZllkamRSbURVK0czNVZMTU45SjhFaFFBbytEWVA4?=
 =?utf-8?B?L0s5RzY1RXh5QzdpSTJxeEdmKzFzY2ttVUwzR2kvWnV5c0VUbTI3cmV4QlZO?=
 =?utf-8?B?ODIvY0ZKYkhjd2hydk15VXZvWmptQ1hnSE1kUHFRSjJxWnlZeXNpa2piWDc0?=
 =?utf-8?B?TXlUWGZvakZVZEJ6VXhTdWUzbmFLalpCd1QxQXdiVDZNQmNRSUsxZkJmVVVU?=
 =?utf-8?B?ckUzc1dTZC94ZmkraDlZZXRUdkkweitDR2lUd3JSRWgzSnEvWHhXM3BEUXFL?=
 =?utf-8?B?QnovMUN4WlNhTGpRNU9xZ3BaUXppZFpEMHllYVZhc2xpck1QZzJXZWlORTZj?=
 =?utf-8?B?MU5wbjVsZy91Nk0xRTB1bUN6bXdmZjJ1RXJ2eFRRaitLQjdYWGRJb3dTTzNo?=
 =?utf-8?B?NU4xb1BNSWNsZ1NiOUFxc3E3ZG9NZjlmUVJlR05RSWJMMVAyU05nZ2Ewc3pK?=
 =?utf-8?B?MGEvV21ac21CZU04UlBhcm1uNFBnSkdQazFxVk04K0hpRXBTaUxrN1RvaVNM?=
 =?utf-8?B?VUcrVUlsc0RlL2p0QTRSUnRHeUEvdjIwamdWRmxMNk1La01vVDZVM3ROcWRF?=
 =?utf-8?B?cUpYMzFSVG5XdS9NeStBQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7012.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXg0b0tpZFMwQTZoQkZxa3VxWHBOZE90amRsQyt2aW9yUUIzRWF3aWhEQTFT?=
 =?utf-8?B?Ky8xZ2xTTDNmdGR1ZnlYY1kzcXNObUo1bmdpazNRVWJnUERRaWFoM1JsLzIr?=
 =?utf-8?B?RXFDMFdEWUFVRkVIS3p2Nzh3NTdtUzVUSFhOWm10YzVCTmtZK2lER3J2VXYv?=
 =?utf-8?B?Zno0Nmtxamlod3J5RFB4d2FoK1FuNVRmcUZHeW1pY3YrVTZ2QnpEWHlrTHlD?=
 =?utf-8?B?a2RPK3BSU0RxdjZzbHZjN2dBdTlRV1g0UFN0Z1kzNjIwWFJvbUhNbGYvbkxz?=
 =?utf-8?B?eE1lMFZoNjF0Um9NeWFDSHFsc2VRWWRmc2xhVXRtZDEvejBNTERaMktSZWhh?=
 =?utf-8?B?T2NPenF4Y0VCS2dhY2JPSm45aWdnbDBJK0xsTTliUHhBRDRaYzNYQmptNml6?=
 =?utf-8?B?S2dTVERzY0h4SW42YkZ0eVMwRTd2WGZFMkppRDhuVEozWG04eFVwc1RIeXk5?=
 =?utf-8?B?UTdFVEExekdzR2kxUEs3S0RPYSt2M1NnSkRMU2ZiRmk0NERMa1I1V0psTUF5?=
 =?utf-8?B?Y1ppTWN1Z2dXQTA3cThCRVZsc212VFdUWk4wR2c0NEhESW03dWdlbFFpMVh4?=
 =?utf-8?B?eVlsdkhuQUpNSkhNMDgxK3lDK2F0MVR5SnorajlMaVpQTjFFelptNWhyZUp6?=
 =?utf-8?B?dXlHK3V4TmdtRWtmWlN1SjNHbGtmbjhEZXpYK3lrdTR1M2pYbHhqUWFCc0Ur?=
 =?utf-8?B?amhFRGtRVGZndzBVVGsyWm9jbm85eGtpYVQrSmlCb0FNZ1NmWlBoTlhEMmla?=
 =?utf-8?B?OWo3bXozVnBpTlF5TnRna01ZQVFObk5OTkNRcVZCdzFxUUc2Q3dub1Vja3lD?=
 =?utf-8?B?RTNqZ0dSS2VzWWFRTGtPZVZOU2RVcGtqckdRVVAwWVNUbEFPYTdOWGZsTnlQ?=
 =?utf-8?B?ZGVmb3lNbTA1UFpHbW5zbFdkQjRjcEpNWTdzNTVrSzlEa29qME1zYUx2YjFE?=
 =?utf-8?B?NVRTZ2NLc0Q5WG9oT09GUVliNmNhYU9pRlRBUm5RWlNPazN0anRNM3Z4UGN3?=
 =?utf-8?B?Z08rSkxYNlU1dkIyVHp6TTNZOG5HM2FHT3p0U0dycHo5N1RBZGtiWiswa291?=
 =?utf-8?B?Q1ltUDBBTVdCUXp4NFNud3A0dUJYL0tPNUJuamFkbFIxVDl6dXd6b2FHcVRX?=
 =?utf-8?B?Z3dzSEhvZm53NTM0OXZrb1pTMUlvSVovQ1d3bjhqZU5ER1FESm9sTXE3c0Zp?=
 =?utf-8?B?VGhuS212ZnFUZXJSdThjRmw0Wit3OFdCbUh6TzFaZ0g0aHNpdDFBWmlMbmwx?=
 =?utf-8?B?LysrekRWeTBZQ21SWlhoVEpMWlphUjlxTTFtcXFGa0YwQlo2RTFMYmxURFZF?=
 =?utf-8?B?WndnRUpnRDc4aXNScENuRHVZTityQ0plck1wM0FwWk5xQmZFS2t2WktPZzJw?=
 =?utf-8?B?bXg4ak1hWndwcHMxYzlMM1hQU0doam5XbEgvN3ZqdHVFRVUxZ0ZWZHB4OGh5?=
 =?utf-8?B?OU92alUrb2lLb0dLcXpQcmNOL1dhR24rUDV0eVc1QkVoVGxvM1NvYkdyUWVR?=
 =?utf-8?B?RXRvek8rM0NHNzBicUErSWtEYVJzQmpZcG5oUThjY3p2NFAxdmpsYWUzZHl0?=
 =?utf-8?B?NzBNeHlyRkJ3bHNyWGlXYytGcjdXRTlnRmFPTVY0UUJ1RjNmNy9QVk10cVl1?=
 =?utf-8?B?Z2dBUWplcUVWYTFVcjBYSmQ2d1dxOGtQQWl4U1FEUXRlcnlDMnQwb1MraVNi?=
 =?utf-8?B?NzhmT2NnZ05WQzR0K2JDOEo2ZFFOOW9jYnVHendPblhWM0tnWDBMOXNLTG53?=
 =?utf-8?B?ZEtjaTVFWlY5c25iYituelRYeGFGT1JORUNGN01zbFB0TEgvWVJtQUdOTjg5?=
 =?utf-8?B?MkhYanh3bTgrZHhaNzEvWXpZeG9WeUlkYUovdFloTkJPdUpVWloyUzQ0Tnkv?=
 =?utf-8?B?VFRpVUZPbGd4c2dOWll4QlY1YjgxWFlIclhKTWZ3ZjVNYm54NHg0OTl4Vm15?=
 =?utf-8?B?MzdyN1pQc1lHSGlLTTRnd3ZBOGJTbXdpWE5tcTZGdytXb0l4MURPYm9MbXQy?=
 =?utf-8?B?bjZLUWh1RDFGVG1wYkVXUUFESGEybTAxVHhFL0FJZlBpd3dhTFBFVUtJZkdI?=
 =?utf-8?B?MjU3cVkyVFcranlXR3c5UUNPU1VXTjk5cEJ0U1pwQXVCNnM3YmRjenJjblpE?=
 =?utf-8?B?eVJnY2dKRHNneHZwY3ZsdmxaR0w1SUNOV3FqaUk1S05lTklxMU9JeEtJZWtw?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047b86ea-7196-483c-3570-08dc9d9d1ee2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7012.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2024 09:22:13.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awbFCdhsClYXF8IRVP4yED3BTsvgc4ksmIrUsl8vXfN+XpF1CvsE7WmqeCkPl86ph9B95C/0WNvpAVBdoVORmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR06MB8514



On 06.07.24 10:38, Ronald Wahl wrote:
> On 06.07.24 02:39, Jakub Kicinski wrote:
>> On Thu,  4 Jul 2024 19:47:56 +0200 Ronald Wahl wrote:
>>> --- a/drivers/net/ethernet/micrel/ks8851_spi.c
>>> +++ b/drivers/net/ethernet/micrel/ks8851_spi.c
>>> @@ -385,7 +385,7 @@ static netdev_tx_t ks8851_start_xmit_spi(struct
>>> sk_buff *skb,
>>>       netif_dbg(ks, tx_queued, ks->netdev,
>>>             "%s: skb %p, %d@%p\n", __func__, skb, skb->len, skb->data);
>>>
>>> -    spin_lock(&ks->statelock);
>>> +    spin_lock_bh(&ks->statelock);
>>>
>>>       if (ks->queued_len + needed > ks->tx_space) {
>>>           netif_stop_queue(dev);
>>> @@ -395,7 +395,7 @@ static netdev_tx_t ks8851_start_xmit_spi(struct
>>> sk_buff *skb,
>>>           skb_queue_tail(&ks->txq, skb);
>>>       }
>>>
>>> -    spin_unlock(&ks->statelock);
>>> +    spin_unlock_bh(&ks->statelock);
>>
>> this one probably can stay as spin_lock() since networking stack only
>> calls xmit in BH context.
>
> I already suspected this it was more a mental hint here. I will remove it=
.
>
>> But I see 2 other spin_lock(statelock) in the
>> driver which I'm not as sure about. Any taking of this lock has to be
>> _bh() unless you're sure the caller is already in BH.
>
> The other two instances are not in BH context as far as I know but also
> do not interfere with BH. The one in ks8861_tx_work protects only
> variable assignments used only inside the driver and the one in
> ks8851_set_rx_mode also only does some driver local variable stuff and a
> schedule_work which as far as I know has nothing to do with BH because
> workqueues are running in process context. Am I wrong here?

I guess I found a misunderstanding on my side: I was assuming that a
softirq cannot asynchronously interrupt a spin lock protected section. Mayb=
e
this is wrong. In the one place where I'm waking the queue again the
spin_lock_bh avoids synchronously triggering the BH processing while still
holding a spinlock.

I will use the _bh variants on the two other places.
  - ron

________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

