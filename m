Return-Path: <stable+bounces-135262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B7BA98865
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB0E3BA3B4
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0E426D4FD;
	Wed, 23 Apr 2025 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="XPbB/n/N"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021082.outbound.protection.outlook.com [40.107.130.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE91AA1D9;
	Wed, 23 Apr 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407363; cv=fail; b=qm8pYqT83IdcR2CgWLSAr/tC08ETl5p0dYjfy8xirirr0KKk4/Yky4Cl2u/1wwZzTtqCzG8MM/UaZOs/Yvc7mpJ/b10vIXov4D7OlbgFopsXFX2Owlt84OVQ556OFpaGS+ips36WpleUJEtCfUGuMbaJ68z9etWek8gmlI4UVCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407363; c=relaxed/simple;
	bh=QPWHxYBxFQxZkXo5fu4ctA6q1x0+yuJPnhrcWi/J1wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ufau9MLEYZ1OXCVsdh7tUHPqME76whHNjzf1oMcJCg//Pdb2IOlxNqLYg/YXlM8w1bZveAiGjNbtGk/mDN1i3gnFqHWec/dNnbQeD4/NRjtQjt0m5v49s9ITQbhmd08s1F1fLXY+enXMq8UAC8wNJW2ZXdK6TYVnRErRBFk9+yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=XPbB/n/N; arc=fail smtp.client-ip=40.107.130.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibGOG8ZYgRdTFtSZMUSymV7L6zZyTccGrL4nOt1XXFWsEZJWqwCB+15ghwg87yDuzBHkAlgEYiHgtuK4af3Y6mC0DTIX9kLfCuUuEVxkJyImV2KnLCKjauPkE3365a6kks9tpLOhFfoaSomHYe+tavOmPr3haWPfX7kbCqnC5HMTC/SKFImmtXbl1pLbryRfW8v6F/V6ywE/YDxC7lqGoqc4G0b/sBJ+I11X2czQLKcVthxEYIQk+d/ddlKBobHMS1xcjVYa5lxHauwqY4NtsAn2uzSpW2TR3sDe5ce4zb7K5SOQ9BxgVD7cF7KKU8zttf80OBIqwSRMY5ZwYRuFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKL+GdMq85EbMm402UBsUaKfvSoLa1fn2clP/zZaRwA=;
 b=Xssq9kNbVLj6dOxT9idB75Rq/9dsVOvs/M/6bfg/VxQ9X6SnJ/4DjRLDjAwmBwyzTGGRH14wSGNaLPle0VvPIEKHY9N7MLQbjsdUbI5MiorOZ8mfsfdxmKl4W1UAz872HiEzQXPRo7yseejvvtUfXGnYLgZFdPBEMjIjcu+W7d0YDNhTORnGq0bdidmznKSh6SGbx9PNm46mAZ+8p1afJWyXBRFTvnsLIOGsCqaxne4k65azusgeuE9Vp4XdI5pJMvEGaJ48ERa1QqTOjJ01CRWlczq+O0QCP4+w+r+9ti36mdveeeqOqw+pmiZnjaW3PkJdC36LkO+TnSExSotLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKL+GdMq85EbMm402UBsUaKfvSoLa1fn2clP/zZaRwA=;
 b=XPbB/n/NGmyYvh+gp5DRPMI9zWMIn1wtS8DGKyBwvzSuMoZbuK/ebBbINFbUJ9rqeJsznmwDVEWNZh9VjdEfJGYDnqZPDEmMmwNTsTuhbY83z0fHO5QpbIymLPPNGN9V6W/vcW2fplwP7OSJNUSKWcefM1flUPbWon8p1/08N+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DUZPR10MB8071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 11:22:37 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 11:22:36 +0000
Message-ID: <ce378faf-8446-448f-97cf-f40bc5c4581d@kontron.de>
Date: Wed, 23 Apr 2025 13:22:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Philippe Schenker <philippe.schenker@impulsing.ch>, stable@vger.kernel.org
References: <20250422124619.713235-1-Wojciech.Dubowik@mt.com>
 <522decdf-faa0-433b-8b92-760f8fd04388@kontron.de>
 <20250423070807.GB4811@francesco-nb>
 <17ec22a0-b68b-4ac5-b2bc-986837639a37@kontron.de>
 <20250423102651.GC4811@francesco-nb>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250423102651.GC4811@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DUZPR10MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: c78c6861-902d-410d-c877-08dd8259269b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHc0UzVNVnRab3NlY1FOblYrZDZuV3JKSTlZTkN1dnFpa3FJeVJoMEJSSXp3?=
 =?utf-8?B?ZmNNWU1PK3FRYXZ6aTlIUG1vbGptOFZVZFNtSDFyM3RuOHNsTmxXSmM2Zklm?=
 =?utf-8?B?YVp3blRLNExoTlRxL1dpMVFrTGdwWWJZWFB6T2szV3NPL2dwbTNtQnpVM0cy?=
 =?utf-8?B?dExYbStobkMyTERZNTJpK1RtNDR1VGlhZnBCR2VLV1k5elZRRnlLQXdaWC9w?=
 =?utf-8?B?dDJYL2RKcUNjQTZNQ1VJcUZDQldoenN3alZGQ1RiSFFrMURld1pqaS8rN1ND?=
 =?utf-8?B?UEg5RGE1dmd1QTFIaUQrVUl2b3J3M0pmWlZEeWJwZkJZQVBEL245SkQzZnZw?=
 =?utf-8?B?VXRUaHB2bXBQcDFyMTRMRTl6MXlOWWFlYlB4WWdUM3gwaGxGL3FKek1LZEVN?=
 =?utf-8?B?NnFWUTM2czNvaGFnQU01aWhTNXJVSGVydkRka1h4Myt4S1ZDeVI1bG9maDZp?=
 =?utf-8?B?MmxVUm1hU0lFcVdwNWMxK3JRUnlLaXhFTy9jTXlIZGhxRGVzd0ZKQ3lEeTIy?=
 =?utf-8?B?a3FJSVdST2dpQlBuekEyWjhNcVZKanl6MjlSeUFod2RaaXNMdTEvUFVoSmVV?=
 =?utf-8?B?cmlKcFR3bFNOMlMwZFVLQjFZVWdZRFBoa21tZG5YbFZpWElNaFRTVG9tQ09W?=
 =?utf-8?B?SStwb0ZTM3RoME1uajNueDJxeW8rUTF1NFNITlJPUGVKUzBiWDBzUEk5U1d0?=
 =?utf-8?B?bXh5MnRuSVRhcFhocTRHRVRQbTVnampWYkZqSlZ3MnBDSTZuTmpOZ1cvYVV6?=
 =?utf-8?B?VUcxZXpsTkUwb1NrSVNLRGNPMEJkL1NYTUoxZXJJOU85bVBiRHBQMHJoaS8x?=
 =?utf-8?B?eDhnVGVtcEF3cWhzN1JRZ2xLbW80RVc3NGEveGRYcHFXUXlUQU1abHQxSHpu?=
 =?utf-8?B?Nlh4dmRjV1dMem5sRXh2T2V1NHBWU2p4dFF4Um5pTWNVcmpXQTJJSGsyMTR2?=
 =?utf-8?B?bVBMYnFISDFNdmIyVnQyeW5WejlDa2ptZDk2QUlSU3N0L1hWT0FUOE1Cd1Ro?=
 =?utf-8?B?S3lUYmZHMDgvZnkxUEpxVGVWRzJ1ZGVXeTFXVmJnUW1zMlErbUlCd3VmQkR3?=
 =?utf-8?B?cWxuTG16dkpZM2FmNFNYQUNTenJ6Znp6dGhBYXdXSWZ3QnYwY1VkbFJBVzdK?=
 =?utf-8?B?SGNUbVNpOXVBN052cG15dXZOYU02VlhJM0VCVko4OEdRL21ETHp5OGI0aERm?=
 =?utf-8?B?OTFDMTBPcnNPV1EvK0tObFRJcmNnb3Jzbnp5NjU2b1ZUZElMU2NybUw4NjRl?=
 =?utf-8?B?K3JXdnN6UHJEMnBMbERidk9RZmhPMVBweXJqaWV5SWZjSWplRzJuNGFTbjJu?=
 =?utf-8?B?dkdEdktRcHJyTjlNUVlmRjlxR2txditZRVVCVC92RVJMNWI1MHNTZ1BOQWpy?=
 =?utf-8?B?VHlSeEpReitWTXRWbjZ4WDYyVm9zOU8zdFQzdHRRTVd2NmZOTDNhcm04YVNT?=
 =?utf-8?B?YzI2TG9qdTFKNzhQT211NStGYkpWemZLS1dxekVPZ3NlYVg3UUsxWC90V1Jr?=
 =?utf-8?B?bWVxS1FmS2gxQ3NQT01YUjFOVzRieVpXc0hockI0b3A1aVNCVjloVHM1emRp?=
 =?utf-8?B?TGJGbVZ2eGpvamZGaE16WFlqandTRDFMWkRYU2h5ZmdhOU51eHVzUXlDR3Fa?=
 =?utf-8?B?UTBJQTk0Y0o4T1o0c1B5ekJhN1p0TUZRSEpvUlRYeGN6d0JzL1dhUSswQ3FR?=
 =?utf-8?B?N2NOOXJmYVFFc1hUVkwwZkc1ckhtNGE2SGxCVU5tZUVBVGIrWXlNVWhBRjhW?=
 =?utf-8?B?YzA4ek1HdkNOTnM1eW5nd3JVSER1NkpUb081clF2QlJnR0RCZHNkRmM4REhI?=
 =?utf-8?B?WlAvZi9OMWE5bjhMeXdtSHo2cFVVa3ZKK3hnOUJ0aHVuWGhtWVUzdURsSVlY?=
 =?utf-8?B?bXo1dFRCbXJac1M4bGRlcjY5c2s1MGxIYkFHNk1ZWHdWMXdoRW9lWFFFeTZl?=
 =?utf-8?Q?pCnnXHTV80s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0FMUU4yNm5SQlV4N2NmLytHcEZuSTVTZEhQcFE0SkpTejNTRWw2QzB6S21O?=
 =?utf-8?B?ZGJWUTExcEQvVXdhMEZ5bDdqNFN6MXZSVldTT3RZaUptV3lYWHBLa1NJQ2lW?=
 =?utf-8?B?TGJSOEhuWEdiQVFyanlzc0kvNG95cnB4bFhBQzRxK2JXaWc3amM1M3ErbzA4?=
 =?utf-8?B?Rjl2Q2lNQ1ZOMHNHcVNCQUJ1ZHk0V1NSRVFlU1RmTGU2TU5hTEs5NTMvUXhu?=
 =?utf-8?B?VjdmMHY1OWdZOEhramIwUmdUa3pTNCtrNitBeHBRMjhhOXNqYmh3TndjeGFV?=
 =?utf-8?B?Nm1MaHBob0NieXlZaVZKUnBZLzNCVkhDSXhWQ1JIR2dVVXZGOWdwbW9jUXg3?=
 =?utf-8?B?a09sOTFnQ1NkNHBETE44ZEo4Umdma2FmWnlZV2M3am9nMVR5Y3l6RXloOVhG?=
 =?utf-8?B?SUZ1bENFYUJEa3pWY3h2Y2g0ZndtbHZzTk9ENUtrdktMYytpOGF2Z1VKS1VU?=
 =?utf-8?B?RDUyb3ozcmZXaFMzUGtsRm1VZHUwVmZJMHpqcm9IQldPVytMdTk5aWdoV2J3?=
 =?utf-8?B?ZUhZZUVOTElPT0FJZWkxYmVYZkVIblVDNklka2N0WWZkdFNwaVhwUDBrU0xI?=
 =?utf-8?B?b2UvNnExVzJZTXpjMXhRK1FEMithUTFDaFpZeDVIU1FFN0hDTXBvVzQraVlU?=
 =?utf-8?B?VXF1RER2dElCUTlNKzJGYk1tc2lac3NRcGFjZFBaQk5WUDVjSTJUR0FFajNu?=
 =?utf-8?B?UmFxQzFDNVRnYjVIWUl4eEtVc1RrR0dGVE1PUWF2K2c4RnhFNVFTbXpmdzlv?=
 =?utf-8?B?b3M3dzU0M094RDRKNzZvZTl2OU1yMDRCbVNMeGU2NVUyS0IxV0JFa3A3ZS9h?=
 =?utf-8?B?UEJtV1FGcnhsVnJUTWlWLytma2xVMDhCdTl6VEJPN29pcVVmcVY3NW93TmM5?=
 =?utf-8?B?NVBFTGFvcU9VenA1WHJKTTNSSXVlazhKZ056SlVaZDFIOEo4VzVWSmtaYUoz?=
 =?utf-8?B?KzJ5aFhYUHp1YTR2V1A5Wlg0U29iQnNLei9XVUlERVA5amhnTXppdFFleUdV?=
 =?utf-8?B?enViS1Ywb2N6RFNiZ0FibEhzenJmM1l2K0F3Q1RDcnp4NFlUV2RodkZpTHpX?=
 =?utf-8?B?S3htUk5jTFdGTGw1UmZyemw5R1BTNWNzZVFLRXoyM2tOSklHZG12NW5OdDZ4?=
 =?utf-8?B?NFNlakVsOVdtKzZTdGR5anJXQXpiaUh3ZWROU2RVY3puUFNZSnNPU3hEZXAy?=
 =?utf-8?B?YStyNjBKOXhGd0lDMnJ1b0g3TzRoZUtwRER6Y2VvR2xLWitqTEJlNVZneVVx?=
 =?utf-8?B?aXUvbnZ2d3pTSnV6RkRIMXFPcnYwczFYa1k4akRVaHIwWUZrVmwzNndjVHJO?=
 =?utf-8?B?dE1pSFdXdEpkNkJBN1lWWFFKWExRTmNrNmJDS2ZrVlZGNnROY1k4YnNZS2Yv?=
 =?utf-8?B?cExpZEdzbXozZlZYSkk3ZjlNdEttNzVXTW1NelFwbHBtdlNhYjNaVG14VlN5?=
 =?utf-8?B?WEl0dDR1eFYvRDNHWTVFNUtiZTgyZU1kbFNZcTdzWXZ1citrWU4vMGxPNTFP?=
 =?utf-8?B?d0F3cnpDZ3V4aEFKUEFBY2ZUOXMyWDk3VW9FMGxhRjl0Z2hpYWxPZmJiWWxR?=
 =?utf-8?B?NDE3dzJ0VXlFUXhTZTZGYTV4SytvamlOZzYvV0hCMGM4NVJWQi92b1hEdDBn?=
 =?utf-8?B?YjYvY3JRS0RZWm00NVY3Z09EUWxxSVQ2L0FXa256ejhqaXFRdDFKVGFYYVRo?=
 =?utf-8?B?alJTQWRZbzM2USt6VnhMMmpSWmZFQjFuT3hBQkQrczBEQUFaSkFCNGRDZUcz?=
 =?utf-8?B?ZUlqUjdkb0NXdHZuZWNhZEpZTjdRbmgrSFY4MWhtTlp6VGNHcjFZaUdJMjFr?=
 =?utf-8?B?Q0JOd29YSjVyY3lMellYODBXSnB6NlNUS0VvakZvTVJNNXNXdW4xWjJnS21L?=
 =?utf-8?B?d1FvWXZuSjh3MFpaUlh1dlJaVHA5U3dyMjhQQlVWaDZ5Mk91M2p5aG9ZejJU?=
 =?utf-8?B?R2dvRDlvZ0g0UFJDTFFBa05zdUNiOGc4S0NBWW0rY1dvSjN0K0w3cnpadlp1?=
 =?utf-8?B?QlR3UUF0em5OblFkR09TNk5PNjUyMXhrQ0RCaFF6S0JTbUNiVEt3c1ZYK2lK?=
 =?utf-8?B?cWl5UXRvTUF6WUpieFJ3MUpjenIzNys2ZDZMSmplYzNMaDkyTHVJeE5DZVlP?=
 =?utf-8?B?NTd0ZTZkeExRU3FJREpQa2N3ZzIrcGsvOC9SMHA3WFVSY255ekFXYWhicGYw?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c78c6861-902d-410d-c877-08dd8259269b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 11:22:36.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqQdHFJRuse0tcxTJwZkniS/ycQonXiSMpcGkSMHWVmE8dEtMW888GH02B5m04D1OGJRbc6+hwjV8VU2/7/IGjyh2p/CxtoDNP9FnO+8xyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8071

Am 23.04.25 um 12:26 schrieb Francesco Dolcini:
> On Wed, Apr 23, 2025 at 10:00:22AM +0200, Frieder Schrempf wrote:
>> Am 23.04.25 um 09:08 schrieb Francesco Dolcini:
>>> On Wed, Apr 23, 2025 at 08:50:54AM +0200, Frieder Schrempf wrote:
>>>> Am 22.04.25 um 14:46 schrieb Wojciech Dubowik:
>>>>>
>>>>> Define vqmmc regulator-gpio for usdhc2 with vin-supply
>>>>> coming from LDO5.
>>>>>
>>>>> Without this definition LDO5 will be powered down, disabling
>>>>> SD card after bootup. This has been introduced in commit
>>>>> f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
>>>>>
>>>>> Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> 
> ...
> 
>>> With this solution (that I proposed), the sdcard driver just use the
>>> GPIO to select the right voltage and that's it, simple, no un-needed i2c
>>> communication with the PMIC, and the DT clearly describe the way the HW
>>> is designed.
>>
>> Yes, but your solution relies on the fact that the LDO5 registers
>> actually have the correct values for 1v8 and 3v3 setup. The bootloader
>> might have changed these values. I would prefer it if we could have a
>> solution that puts the LDO5 in a defined state, that is independent from
>> any external conditions.
> 
> I do not think this is a real concern, the PMIC is programmed during
> manufacturing, if the PMIC programming is not correct we have way more
> issues ...

My point is not about the PMIC having wrong values as factory defaults.
My point is about different bootloaders that have PMIC drivers which
also use a mix of the SD_VSEL IO and the configuration registers for
setting the voltage. We don't know how the bootloader will leave the
register values behind.

An example would be that the bootloader uses SD_VSEL in a different way
and the PMIC driver in the bootloader writes 1v8 to the LDO5CTRL_L
register. Linux will then use the wrong voltage and the SD card will not
work.

So with your approach it would be good if the PMIC driver would also
reset the LDO5 registers to their factory defaults at probe time.

Also the logic for the LDO5 is purely embedded in the PMIC chip, so it
feels kind of wrong to have another regulator for SD_VSEL on the board
level.

If someone wants to check the output voltage of LDO5, they will query
the sysfs path for LDO5 and get back the wrong voltage. It will be hard
to find out that you need to read the voltage of the additional GPIO
regulator.

I don't think your approach is bad and of course you are free to move on
and use it. I'm just trying to find out what would be the best way for
everyone. It would be good to use the same approach on all i.MX8M
boards. Currently we have a mix of (at least):

1. MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT without sd-vsel-gpios readback
(everyone)
2. MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT with sd-vsel-gpios readback
(Kontron)
3. MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4 with additional GPIO regulator
(Toradex)

