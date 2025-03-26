Return-Path: <stable+bounces-126691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06EA7146E
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 11:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8887F1688B6
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF7F1B21B4;
	Wed, 26 Mar 2025 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="EyKTZQZQ"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603E1ADFE4;
	Wed, 26 Mar 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983676; cv=fail; b=RsYfdQ60ReJOOIpwyBf9k3kuqs/bfEtKa6yxMtTIn0zeErjqgwKAUDa5DQAcXUIwRB3vA8viDJMEUxDrUoC4gmZo2d606QN/bKj5w1rHuZPkjvsmqqRzc62Tr118ucT7ugiaBOEfZUa5rlS5TjI/JDZuafbSOHjdjjQdxSPAfJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983676; c=relaxed/simple;
	bh=PfGc57GCessjc7RCul66IMha7AmLRsRWQsYw6AH+Qcg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J7fT10SzMmca2oJPzyF3N4KROvplKD2MTVEbMLhzo/zPLnT4CeR0PlzWsmj9GJ5PYbuuxqrow653H2/qefzOxiSLBnwnQ5Rp39yk042Nl85k45Z+CLSz/ujD11JFY5MJ3nMkweIYb2wxPLAGHq7mkmSaMTcYsyJ5TDgbiYZ7Tlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=EyKTZQZQ; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7vmuVhwo5WdO/JUbTsD1/Vy0+4NiTGJjPWtMxEWXQN0oRxb2fD3JSuEBL5rHpdt6+d3N2t9y/W1HSDQPTgzQYZTAm1+7etg/5f70ZYTm3/G7WOo+nYZ8N4033w50zMioa7WX98Gf9K8cUAoK8ISjKfVbVlLI1qRBS0X/Wn13ltd4lIOjphnpJm4NkR42lIjRdz+gH6C3YCmmUA+PK8juMpBM3En1fXKeRvzNKt1Ha6aQysu6I/dghdiEIiASCpi1WWLKgw8/UvVfwRsWnGPAlet0zTA/+3bttPfxywl28ySWIQDK3rtie0Bp8LBrMnqUqjVLPFms3Sd8niKO1Wsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CftGM7F50bgJ5vj1z5Mh9VxqneGieh04XpjTw8sGDzU=;
 b=kijME9jPR+W73mY9vOiPnrC+SrUTV2rnqoXoTiJoDsCogIFQLPF/bkG43/vFpE3hqC7RtPGXkYhbAXWlegotsavnJt4+dvXNixzWZmkU2hXeWNCDXV9owSiBvXDh2jIpYV/4QQNkRR5rMnKB/x2MBMsW79C64Bh0cdRmCmDkQjO4H1P780oJ1a7H+pHTIIvpXjBR2h4NnuRtABQOSkzGG3RLg9JdJ0C2QshseZJRa+ZkRxqXDnY0bGjLBF5DMbF4ijCv18nzOzpe1RBsKd7vsHsYjD651TcKJOq71bIhc8R2aK1wE95TXUp37V4qiq1klPiSOMEQ3UHgAyUDXZBxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CftGM7F50bgJ5vj1z5Mh9VxqneGieh04XpjTw8sGDzU=;
 b=EyKTZQZQfUIwVSdyz7Yk0F/P/bri1iI+6qnsf/RVF7EQCbuF7kRKU3069UYJrYAxejQ+qLBX93141qOf6jaeGGlg9+MIl2eX8xlccKfhrG+FNXnvNsMC1PEincxy4DaQjnbLEGLE68308l00bPd3mJI4qcNqHHxO/7G9e2SfRFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 10:07:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 10:07:48 +0000
Message-ID: <f73743cb-fdea-4b53-9665-4cc303498171@cherry.de>
Date: Wed, 26 Mar 2025 11:07:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Remove overdrive-mode OPPs from
 RK3588J SoC dtsi
To: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org,
 Alexey Charkov <alchark@gmail.com>
References: <eeec0d30d79b019d111b3f0aa2456e69896b2caa.1742813866.git.dsimic@manjaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <eeec0d30d79b019d111b3f0aa2456e69896b2caa.1742813866.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b32f82b-c5eb-4a77-1ec4-08dd6c4e0fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkNUVy9FeXFXMTFZU1dmc0lyOHFmVGk0allOL1BnMlRlL0RPa2IrVDEyOGE0?=
 =?utf-8?B?cHdCL1RFSHJrWlhtY3lpYTY5ck1tVmlhSW80TUJkMTlyc2pOclVYQ0JTZXBm?=
 =?utf-8?B?ZEdsR1o5NE45SFd0T0lDS1I1WUxLTXlBeU42RTdXZkhGZHlZbG5iWXJncFBy?=
 =?utf-8?B?ZjlncnhPaDFWdW53SHpCU3VueWZadmVsM3JsS2ZmZ2dQYXkwWEU1cHJTMmNy?=
 =?utf-8?B?aVh3alNmOG5WU0l6a21JQ0ZJVkpLQmxWUTRxdkxFYWtuKy9JamgySHBJSThZ?=
 =?utf-8?B?eDZoTjJWV2t0NWE1SUQ3NVVoVUkzWHhsMTB1RXk5SEF0cmpSWGFPeVdaV09y?=
 =?utf-8?B?aE5YdGJDaXMzc3lSWStQbURwbkg4bVlKM0kza1Q0YldSSzhwQkc5T0pUVDVy?=
 =?utf-8?B?dkVTS21uNVM1UVBIUVJCeXhGQ093dmkycEFoUzJla3Y5VWpjNWpONm0rVzZD?=
 =?utf-8?B?Vm14QVJiZVYwZE4zRis2bURIS1NPaFBlRGp5dWtkTlhQTk85SmhlNnpkd0tG?=
 =?utf-8?B?V2hHM1o3UnZNcDhRZm94UWFWQ3BWb3lkV0tPWlYySy95MW9vcFNVLzYxVzMv?=
 =?utf-8?B?RXJUWmZTTWRhclVlYzBDYS9ackxQMW9ueXk3MUQ5NEN1b2pqbUxxV2h6am0z?=
 =?utf-8?B?aUJlR0h6U1FXZ0pUSG1MV09ZRUxHL3BuZXM0NVh5bGtZUXJqSHMzN0V6K0I2?=
 =?utf-8?B?dkxveVFpOWljYTdsWW9QSVpRT2IzVW9Tcy8rRms3K0xPbS9ZUjZ1aGh1WkRp?=
 =?utf-8?B?MWw4K1A5KzdMRlhEYUQ4Slh3eVBQcmtMYUxScGhuZXpYVThTSHdvZU0zOEVM?=
 =?utf-8?B?d2JFOFM0eE1VUkgwck1oRW5jTytqZUZ4TXBUY0dBMmYzc2QzZTVwMlBvak9U?=
 =?utf-8?B?U1JpNGgxRVM2L3NhM0QwQU5FMGRyaXc1MkZNZjFMRWlIWVFmZHJucXRyUlVR?=
 =?utf-8?B?QnVJdGJMNlVTZGloRDlZbFM2d0pzSzA2S05ORU50bGNwVThac3pTOFlaNGo4?=
 =?utf-8?B?YlhYc2pucnVNZSs1UHFkbXladDRQeTJRWTA4WXJianY4TkxEOG9SRERUampm?=
 =?utf-8?B?UUxxU29QV28vcDFHRkxheVhVVVNOMTAzVTBvMW0ranJ1Uzl3ZytHYzlYTG8z?=
 =?utf-8?B?UUlLSzlJWk1nNnE5TzlIUFN0VmFSSUxVcDJhZ2t6d0p0MW5GSU1OTy9LeTB0?=
 =?utf-8?B?SGhkMzY1SmNQbEJBSDZPc3VqSzMraVUrWUtmanFWb2I5UzRaMElRUmlBQTFz?=
 =?utf-8?B?Rk9qSzIvZXJLbDdxMXVVNFFQWmtQeklNc1c4TTI0TmV1NTA5K1Rtdml2TjdL?=
 =?utf-8?B?YUVENm44dDQ2c1A1bDJCMUVDWHY5WFBxOXh1WkNYNUJibVJPZDNNbnliZnJk?=
 =?utf-8?B?L0Y2d1RhdkRhcCtlY0dLYUZrL1d0Mi9XYnMvaEM0dThsbkxnVkRyT1pTdGtV?=
 =?utf-8?B?a2NVc3RBdHovRXoxMnV2M2VINkxZVnIvZEJObXVMRklFOTAwZ0pPMlBhTHEz?=
 =?utf-8?B?ai9vRW9WTGlxRjVwNmNxVm01UkZvcTdqall0TXlQMmw2Q0xNcVJ1VGtWK3pR?=
 =?utf-8?B?VzZJYmJDcTVoKzZYY3ZtSzlHWEZJMnpRTWRHTkprNWY3Z3F2MkdtQ3E3TWVQ?=
 =?utf-8?B?ell0WFdhMHRKY0l5Z2lseGdFRXBReWNSNzNXZWVTM2MyNU9KVkdSSEkxM3hj?=
 =?utf-8?B?dWR6bzVwazZKbktjd2V1R0E2b24rQm9QU2JDUGxSZEp3MmZrRUdsZzNldVRk?=
 =?utf-8?B?N3FyMmJzUDNGZld1TitGYlhmLzF0Y2lMZGloMnpHQUk0OFowVTR3WWNYZzVK?=
 =?utf-8?B?a0lnT3NieGJvTFk2MGd4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzFQMUk2YWdXZUFUckRwaEYwNlNEcFEzTkliTXlkY2RuWEJmODJLdEZOcGRE?=
 =?utf-8?B?cGFZY1A1cHJ1Tyt4eERIRkhoK01JMjN1aGVBY0ExS2FOakMva045OGtlYU5w?=
 =?utf-8?B?MXcreUlOL0swUkh0c0FibStvalVNMWFxUEZ5ZDBJWHFjQkFXWXVsZjdDZHlX?=
 =?utf-8?B?d2M5MjBSMmovaUtibXJXNFNiL2wyYmp5dEhPZVI0aTJQbGwxNDJXTWwyVGJk?=
 =?utf-8?B?K2RyUldWL0IyU3UrbytOajB6SXA4VlkzaFVqbjJFWG5uRmJiazVQUkNiZHFa?=
 =?utf-8?B?Rk1GWDFQZHBUckpQbFJYZzdBM0lLaWk5MnNXSGdsMGNweVZLVy8zaG94VWRW?=
 =?utf-8?B?ek9WRExqT29hcnFJcmdiWTZNZk1wcGdHOHNwRCtlV0lpTGpPTU9DOFd2enNC?=
 =?utf-8?B?VkVpNGV6VkMyQzVsUkhXZ043RlErOG5nZjRudytkRE15cnRSdlpDbXVUVFVK?=
 =?utf-8?B?d2dNa2d2bWM3bTdxdVlYa1FXV1JCUXNjV3E3TjVZa2x3bzc1aEFiN3NKRWV4?=
 =?utf-8?B?UmZieXE2ZXJVUitxZkZ2cXN3NUYyQmwyN3cyZE9pVno1UFc1QVlHTmJ1dkpW?=
 =?utf-8?B?UDRKc2NnRjV5QVJDOUt3blJjNmhscmJyQUdkYi9kajloaVBmMmxrUmhPK2hl?=
 =?utf-8?B?R095MnVpNlJwdjdTVlJaKzN1L1VBTytyNCswQnYyZjFZK3NVenVDYlpXSDRO?=
 =?utf-8?B?ZzEwM0hYTVFJVy9qWGh1cUZheUp4SGoyVjFTL2V2V1NHS043TFE2M2daWThL?=
 =?utf-8?B?OEpnVUhSRXRUSjYxRkZsVVRGNGx6S2RscW1TOXE5MU9QYzJjTjVGdGFkVm0y?=
 =?utf-8?B?RktwTWpac3pFd010dmFSeHdIWUcyaHlOZHVtT1JRelRYSkRZbEZtSzF4d0Q5?=
 =?utf-8?B?Rk9qQWsxMndXaVpBQXQ3Z0l2NXdQUVFZdEJJYVF2dWczY3MxNmt4MEZrMjQv?=
 =?utf-8?B?M3RBUHVwTHdkVm9mVTEzUithaW5JUERSYWVLaUF5VmE0blMvZDJkTzV3K1d3?=
 =?utf-8?B?NmNJeDBpaytDNU4wV2pJK01rL0J5VEJoY2dtU1FvYVdVM2hTa2c1T2Y5cTU2?=
 =?utf-8?B?Vk9mN2FDcXV1QkZUa3V6NVA4RzVYUzB5UjA0WnNxT0gxdXhhQ2FqUVQrWDQr?=
 =?utf-8?B?UGVMU281SzBMRDYrY3QyQkFQc09iQ0NlSGd0OEFseUlmc0QzeE4wUmZHeFJv?=
 =?utf-8?B?S01ySy9wQitZelYxQjdGVTBiaVgxNFpqcEF6bnc2OHBRZmxhUEpuYkNyUEdW?=
 =?utf-8?B?cnp6MjJsbU9NTnBNaml6djJRRUxieHVZU2s5Z1NkWUpxeExBVlR0TU0yTnNo?=
 =?utf-8?B?UVM2c2xsWkc0VW8zYzFzeUhxbWs0d2w1VjFrZFhsSVJSeUFNOWxZL0VqdTFU?=
 =?utf-8?B?ZkUrMjRubW4rZ2U0YzNhVWcvYkNYU0NBZjNHTWo0bWxrRDRqZjZtakI3Vy85?=
 =?utf-8?B?d0lxaE0wTUVoZXJjVEVRckRrcm5sWEMzMDgyNnNDZ2ZyMkVVbFBJRWlKZ3cw?=
 =?utf-8?B?UmlTVkY1VHdLYmJFSGQ2ZEF1RVUreGhjcjYrUzNndDJ3eVljUFdVUm1jaHVa?=
 =?utf-8?B?QTU4Mm1xb0tvUVVqeEd5NmY3TVFLRTFGSUR0Q3liN3QxLzV0Z2YrWjhibTBY?=
 =?utf-8?B?Zlh5Z2cyQmlpcU1HQ2U1R0dsK1pKSTlFanY1VDB6TTJWV2NNVWFLY0sxMk9v?=
 =?utf-8?B?cVgrUkNwY0RrVWV4NldXUFduL3BodjRBeXVUbHFaU2tvSXZGR05sR0ROeExv?=
 =?utf-8?B?TkNIckx5d1FiVzdYaExSeGg1TzJpdHJlSU4ySnYxV1JTeU1iWlAyRGYrQVl4?=
 =?utf-8?B?TkJwb3ZKQVJnSlRkVzF4a0l2OWw1V3ovbDdIYm9TWERyZk5Ba1BkLzBLV3hp?=
 =?utf-8?B?dUdRQVprK2VjbkFrOG9FVjV6KzdZbE8rZThQVUptYVhHVkIxd1BWQTV5L3cv?=
 =?utf-8?B?aU9TZFMwTkc3S01pOGpqZ28wSHRRbU9TR3BaQ3JwMDh0dGtGVXJDRGVPK0kr?=
 =?utf-8?B?MVJRMlF6b0pFa3RFSnZjcmtrVXVqN0lFYTNHakNkL1M0b0I4QVRYMjUrK2NW?=
 =?utf-8?B?WTRVZ2lEc2lXSGJIbkEwZWlSTnZMMEVTNE44anQzaUhnNVZiaXJDS3B2d1FK?=
 =?utf-8?B?VzVlYlhCZzR6MitJbjZXcmY3czd2RkZsS2VjTG9aWnZmajFlS0F5UVFkbDh3?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b32f82b-c5eb-4a77-1ec4-08dd6c4e0fa7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 10:07:48.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGNSpWui42q2Q/usNtZulgBR3vu+46iKdXBlkNph/TiBadpnpWzy0MU4J4I8IzzSuyGU52LPa9lKxXOqUBDoU64+sJRfazLpcRCy3q+dXTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661

Hi Dragan,

On 3/24/25 12:00 PM, Dragan Simic wrote:
> The differences in the vendor-approved CPU and GPU OPPs for the standard
> Rockchip RK3588 variant [1] and the industrial Rockchip RK3588J variant [2]
> come from the latter, presumably, supporting an extended temperature range
> that's usually associated with industrial applications, despite the two SoC
> variant datasheets specifying the same upper limit for the allowed ambient
> temperature for both variants.  However, the lower temperature limit is
> specified much lower for the RK3588J variant. [1][2]
> 
> To be on the safe side and to ensure maximum longevity of the RK3588J SoCs,
> only the CPU and GPU OPPs that are declared by the vendor to be always safe
> for this SoC variant may be provided.  As explained by the vendor [3] and
> according to the RK3588J datasheet, [2] higher-frequency/higher-voltage
> CPU and GPU OPPs can be used as well, but at the risk of reducing the SoC
> lifetime expectancy.  Presumably, using the higher OPPs may be safe only
> when not enjoying the assumed extended temperature range that the RK3588J,
> as an SoC variant targeted specifically at higher-temperature, industrial
> applications, is made (or binned) for.
> 
> Anyone able to keep their RK3588J-based board outside the above-presumed
> extended temperature range at all times, and willing to take the associated
> risk of possibly reducing the SoC lifetime expectancy, is free to apply
> a DT overlay that adds the higher CPU and GPU OPPs.
> 
> With all this and the downstream RK3588(J) DT definitions [4][5] in mind,
> let's delete the RK3588J CPU and GPU OPPs that are not considered belonging
> to the normal operation mode for this SoC variant.  To quote the RK3588J
> datasheet [2], "normal mode means the chipset works under safety voltage
> and frequency;  for the industrial environment, highly recommend to keep in

FYI, the answer from Rockchip support about what "industrial 
environment" means is:

"""
Industrial environments encompass a wide range of settings, from
manufacturing plants to chemical processing facilities. These
environments are characterized by the use of complex machinery,
stringent safety protocols, and the need for continuous operations.
"""

which is not really helping me understand when we should be able to use 
the overdrive mode.

Why would you buy an RK3588J variant if you don't plan on using them on 
the -40 - -20°C range that isn't supported by the RK3588 variant, which 
seems to me to be the only advertised difference?

It also seems like the RK3588M supports the same operating range as the 
RK3588J but at faster speeds? c.f. 
https://en.t-firefly.com/product/industry/aio3588mq#spec and 
https://download.t-firefly.com/%E4%BA%A7%E5%93%81%E8%A7%84%E6%A0%BC%E6%96%87%E6%A1%A3/%E6%A0%B8%E5%BF%83%E6%9D%BF/iCore-3588MQ%20-%20Automotive-Grade%20AI%20Core%20Board.pdf

Couldn't find a datasheet though.

Talk about confusing specs...

I'll stop caring from now about this very topic :)

Cheers,
Quentin

