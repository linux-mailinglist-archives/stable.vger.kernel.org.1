Return-Path: <stable+bounces-58165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890279291FA
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 10:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6E01F21E25
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB342A85;
	Sat,  6 Jul 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="h7Ju7wpm"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2110.outbound.protection.outlook.com [40.107.20.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EC1CA9E;
	Sat,  6 Jul 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720255096; cv=fail; b=QkWjD2SK+Y1XIrUVJkVIrLO5iKlQ4ccRUvut/5c66H2GUNGmiHD/zlVTYC9oLc/5tCSAwDx+EeFpHg8UHsKuYGHMFAbXfbxQ2dH/wtjA0I4juTSayLFbhT0yxoND+dJKecGel9iarJngXEuMTxu9IFr1bCHQ5dQRDHbfXNKUojA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720255096; c=relaxed/simple;
	bh=/+Pa35YX+0tD0flNh7XNS5+zvG1QPDClTpNTfW+/sx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDRMheRyRNP1V2s61Dw9vm7JpvwA3pIlCtRh0o3AYFK71PTPwvwLkx0NUueoSPKG4uBUP/k46tsbDt8dqGhxngtnns3Th5SeOo59dCHhXwa8vq7bBCYi3yF3wvgqy5nqyRDgqTFcr1lX2ou5Kds9Uu0q8C7S2GCvzSaw3cUCaS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com; spf=pass smtp.mailfrom=raritan.com; dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b=h7Ju7wpm; arc=fail smtp.client-ip=40.107.20.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raritan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulk74dVaesyn2iYM2hRfACjpLDL/+rmnfOcHgYosjw+/PMMXgmjdJYyac+WzkQostvpZ7YoSYTdF22z2Y3ru8hzmBfFExp6FtOQ4mtoqGqrdfHV40CcP5Bb7NVo24wdoH8UL7vj3M5hf44cXRBCbXtkcyrCfKB0pMuo0vE1p4QB5G6NT/6DzFmbCueBtA1dASfJAEcCHzcJU3bC3YkJ4TRsmE8oW9s3ZAO4L+CQ1x89FwE0Hj16qVDqWxJrqOIXBMZglmTSCev9J8X0WJKI+Kg9Rj+tBGsTZejKoSiEVo1OMKShOARZeocrekkDh2shl0etCc35puJAn2uXbIyIDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tzaekIIrExzaXKCY4xqTgWMpVC8uliDDnF3w/f3cHc=;
 b=WbYKUIAxddDozFSHxlB9tdVaWGKNtFcVheYFjSnQ7YnzjQBwd3H2i+CW/a8d+ub/eM+Gu5ohzuSIBHJUen3CCUK+DPfxeHmOPzbUung/BgkHjPzxjFqEJ8lKe6nc3RqFKnR4JUY+KuRCEqEPjkjpv/GHpd6u0mdnktCRrV+LWhH0Iyfl3QkcY8n8tYMhXVx8FEhOw/h+X1Sdj6oyqWfb+PeRCQSxAIJhnZlZrcrXVfsRVkiSM1lPPUBOoxk0lWkTPIX1p95EkfJsDWKe01You7MYN8BTxBMq3rN1Prfjm7H2ooL6xN0L+da7uejCoUQ870aH+0iwo6vaprte/gF4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tzaekIIrExzaXKCY4xqTgWMpVC8uliDDnF3w/f3cHc=;
 b=h7Ju7wpmWArkvloHKoBOpuCyP1LWkXdaf4DA52fN1xF7ine+rzpYgb5b7jzdv+wunOolEkX7xyVdRFLTr4M4E6Rz0hW0nZ9KcdkwVA2wJuHqFeMyOLGyfBOWo8lFdvjw4Rs0vUNb63Vh8HEJNYl3X6Qgrl6cQIMiomf74ELjtSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com (2603:10a6:20b:1c6::15)
 by VI1PR06MB6750.eurprd06.prod.outlook.com (2603:10a6:800:179::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Sat, 6 Jul
 2024 08:38:10 +0000
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36]) by AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36%5]) with mapi id 15.20.7741.030; Sat, 6 Jul 2024
 08:38:10 +0000
Message-ID: <2f3c0444-c02a-4fff-8648-d053a0cb21a2@raritan.com>
Date: Sat, 6 Jul 2024 10:38:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ks8851: Fix deadlock with the SPI chip variant
To: Jakub Kicinski <kuba@kernel.org>, Ronald Wahl <rwahl@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20240704174756.1225995-1-rwahl@gmx.de>
 <20240705173931.28e8b858@kernel.org>
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20240705173931.28e8b858@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To AM8PR06MB7012.eurprd06.prod.outlook.com
 (2603:10a6:20b:1c6::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR06MB7012:EE_|VI1PR06MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 69497285-b569-4f44-f358-08dc9d96f762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak1sT0JUczJVOCs3RGtSRUl6Z3NvNzI5TUhyVzJKUk40cEpjTnYyb09kckNn?=
 =?utf-8?B?V2pTWThSelRWa21vMlpGZDNNUCtjck1TUktNNllZUzFOL24xNzQ4bmJwS2FD?=
 =?utf-8?B?WjB2T29Gc05vRUFNUzZhS0Q5RW9tN1BGdGZBTUtsTjlwLzE1VkJzNjRnM3dk?=
 =?utf-8?B?Z0xnV3pNTkRyWE0zUGswMVZmU1IyaEtwblF2MUNKYXRLMHpHNWlpY0lxNWJy?=
 =?utf-8?B?cjYwWlI2WWd0ckFiVDlRbGo5Nlo5NEVrYTNwWXNkblhMTURCN3haRUFrNk9T?=
 =?utf-8?B?MFBOWGlDQ3NGMUxJcFZ5ZFRTcEV6ZS9kalFpemlZVWV6UjdaMkxUbkc2TjF1?=
 =?utf-8?B?bVhIOFIzL3JCTFJsd3dqa1hFVWFPamhsYnNNa21jV1ZtZ2dMQ0lIVEpOZVRG?=
 =?utf-8?B?MVg5dUhhMEpFYm12QXJKeFdtcGhVWVh0RkJ0Vnl5cXFyWXpjaGhlZm1TdUsr?=
 =?utf-8?B?dXh6NnI5MVRoMTc5VkhySEFPZ1I3cFozWGc3YXk0VVl2dFBib0srK3RzVDVH?=
 =?utf-8?B?UEYwcEdvTDkyTWhhZzBwZi9vT2lxeWR4VzdFWkpCZW8yb1RRS2h3TXNDQ1Uz?=
 =?utf-8?B?SkYrRmJjMXBNMjVwT2t1V04vOVdnU01YS0RDRFNEeVRzOGE2RS9weUF2T0RB?=
 =?utf-8?B?M0FIaW8yRVhDZ044ZzBGdUpHUGF2d21KL2YybzNxWFloS0p1MTVNRGdQK3NH?=
 =?utf-8?B?MlZWWlVKMjR0ZWhxMXpGRWV5VlNzdzViY3lIZFUrcG1leDJ6ZjF6aEdtNURM?=
 =?utf-8?B?SDlUQUhRcVlOUlJISTN4anJrbTBJcjVidzRjQlFuUld2SkVZeko2bnl2R0xm?=
 =?utf-8?B?bDQvT3dEelZnQWpFY0laSTcvY09LaE5CNGt6RHd5cWcrUW1ENjhzeHIveHhN?=
 =?utf-8?B?RnR1R3Y0SXNDRnNCMDlWNHRIU2M1ekVCeE5QTUdUSUVyK1JxS2dCUWRQNTNJ?=
 =?utf-8?B?dGFNSGlKRzV1MU5tV0UwVnFpY0w3eUYzVk5XVmkvL1pSSzNxT2ttbloyOXhw?=
 =?utf-8?B?MmFOdjJsMFJCenhtZzkrdmpoYktOd3FFUlRrYm5SNVpJOGNXS0kvQlhRY0tj?=
 =?utf-8?B?TityVG9sVVJlMTBmSkZLeEppc1AvODNLWEhJaVI5OXZnTlRnRTZ1dFlLeVFV?=
 =?utf-8?B?NEcybVNxNm5OMEkzalFQdzNSdERKaDJvMkdXRHFNMGgwNFc2cHFmQjFFY3Qz?=
 =?utf-8?B?eTZGaU5Zanl5eE0zaTRoZHYxNmdZNGJoRDFNejd3M09UT2lGSDZjSU5nK3hX?=
 =?utf-8?B?SytoaXBLaGozejI5dFJ1REhnbGNVL082cmhUeG56RWd2Z1B4OGkzSERESDI2?=
 =?utf-8?B?ZTJ1R0F1S3JxT3VFOVcxTG9Tcm5QSzRuZFFpY29yeWtKOXBLSzJpNk5HcFcx?=
 =?utf-8?B?SCtISlBSaUVXWEJSL3pMN1pOYnN6U09BeEl3VGV4bkRjU2JuUWdjOFJ3ZVJv?=
 =?utf-8?B?cmNuQ1o4cXNDVXJTeXI2dzNKWk82VWIxaTVsZ2FxNDI4NUo4Vm95WXFJTXZx?=
 =?utf-8?B?SDNodzM2aHU3ZTlLOFZUZS9yNGh6Q09JeTRBa09saEpGMkFyZXRxZUt6VEJq?=
 =?utf-8?B?YTdPeTlUbi9CU3RWS0RiTGRvRk14a1d1MWRzaVRmcjMyTitKWEJ5aWNlWUlV?=
 =?utf-8?B?Uml5Z0Y1VDAwZnhyWGpIanFOYmMyWW4wbVJQV0F0N2V3cWFpZ3NLaHNUYmpn?=
 =?utf-8?B?V2hkOFg0dE5sR0l1ZnE2TGwwRlMrWG12V01NMkdJYzRocEVOLzJhbGptRk5E?=
 =?utf-8?B?RzljNWxTUTg4SFpMdHZCV2FnRDZvMGExMzB3V1h0N1R1QkkwTFA2TXFBaFd6?=
 =?utf-8?B?cVVpdFRyQnhrd0JIVXI5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7012.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2twOHAyR3d2bGx1c0ZSWHd4aklNWTlzcHJ6MWdid21kSEtibVE3ajV4L1FM?=
 =?utf-8?B?OC91bTNIdXh4N1NXVHFxajJaL0h1TkdWTWd3R2RDM251NjUwUDdsV2Y0YVhX?=
 =?utf-8?B?M3pxR2VCY0hvMTN1eHhlOHRTRFRRTVI2VWgyUVpSUWhkRmJCaERYU0JXY0E0?=
 =?utf-8?B?T2hxUW0vc2x2amRXTHZ4UFlUbUgwSTZ4cE91UGlBUU05c3dKOEZnM2VlZlJN?=
 =?utf-8?B?aVNRM09tMEFmeDZDWERNbGJiL1ZXQnl5RTEvbFFOMThWY0JjVEk1Z2xPS096?=
 =?utf-8?B?MFZPdVRoL3VBUnplSEZSNklkVUVjakR2UUo4SXhHYW9sL000UmgxVUhTYmNu?=
 =?utf-8?B?U2Q2VjhCbVVnUEhrSEQzK05lM3FjaE8vVjVmV0M0bnZYaTFDMU1id1U3cXJG?=
 =?utf-8?B?WldaY1haMEtpRnhGS2JvclpTZGVSRldiRHgyWGNIaDdqMlBuZ013M2xQbzlC?=
 =?utf-8?B?TWdrMG1obTNYS1dZQVRFcy9hdVBWaS9JRFhrQ1lpSkFrdUVoQTE4SHluSVJj?=
 =?utf-8?B?d0JjN1VxSXlmd29HTHV4WDN5TVkrTFZISjlLYy8wY3lDdlJ2TklnTGRYS0wy?=
 =?utf-8?B?dWJPQmkvWDlyQ0VTY2tFeGxrTmNMa0o0KzFrUG9ZNjNBVzhocXhodFVab0ll?=
 =?utf-8?B?QXo3UnZZd0VsQkdoZFBKRlhuaHlLV3haSjBYWFkzQzhaN0k0MEFYZHc3MTBU?=
 =?utf-8?B?Q3N4Zml3TlgwY0t1aTNzZHJpTzQweXFBTmFDajhCcHc4TStwUWhnWjFkdHEw?=
 =?utf-8?B?R3I5akQwWVduT3h2cWV0aVJKQVRaK1BmU25oUEtpRVAwNXVkVXdDcW1ISTBW?=
 =?utf-8?B?Mk5PNmVrNmxrbGJGZENvd3J4dExTdHdycHR1RExIWC9YUXEzT293UDVFVEty?=
 =?utf-8?B?QnNUWm5RSDljSmtha0k0ZnpReGY2Y2FkaDR6YWdtMDR5aFJ5RGJySHoxRW9V?=
 =?utf-8?B?SE4vc2ZVUWhvRExkWk1ZbnJaR3VqWDArQkxvWUg1UERSOTltSzJnT201MWs1?=
 =?utf-8?B?UlB3OHNMcDR3THdIM2ZNcnhSd0I1RmIrOXAxOGFJQStCblc4QW1pOWRWQXlK?=
 =?utf-8?B?a2dIRGFZRWRUSVFaVTQxbDZVNjdmTkJ4amViSXkyMHBrTDZoUEdnMzdMenBn?=
 =?utf-8?B?dXlYdXkrQjdjOVFhSFZOOStpd3hnT1ZQbXFxMTNOZDA2STg0dnk4S29idWJN?=
 =?utf-8?B?L2g5a0g1bklnY200eUYzbkFXZHhodHBwQTMzQ2xCQlZpUndwdHZoZkRDNzRE?=
 =?utf-8?B?ZnNMRGdRM0RJcS8zaVhwcVM5WHFNeUMzZFhPRzJwU3pjR04vUXJHYlJ5bktr?=
 =?utf-8?B?NVJGbDdDeVFHNFJmUFYwcjV6T2RSbTdQNVJieW9iQTIzbGFnNHJsR3UvOWQ4?=
 =?utf-8?B?eFVQMnFtRTI2Y29jVHJ2bU1kWGpTRE5PUitnWVNydDNHdFBKSzJFWkhGdUVD?=
 =?utf-8?B?dmpJakJFemRSc05KdTl6RXIydXhNZk1UR0sxUnN4dUNMbU5TblpXTWM5bEpZ?=
 =?utf-8?B?dU1SV1NKS003TC93NjlnZ1ZwRWNwczdQTTNsRHhXYTVWWHlHdkFvRUZkcmo3?=
 =?utf-8?B?N3R2WU96dlp4akZ6N2JDV0NZcGczd1JMQmVTYzZrajVmK3lDOFNka05oUnJS?=
 =?utf-8?B?bE5JL1pubnZvTkxaOUNvc1drMkhiZENKRGE4TEtCY2pVaW5hRDd2TTRIZllK?=
 =?utf-8?B?bFdNY0kyWjFqUk8wSytaMFdWaVkvWVM4aDgzL2hOaFN1NXU1N1RaR0M0TTVj?=
 =?utf-8?B?dmFFUUYwaDc2UURqOUtkc1kzS0R5TFVLYnpUMW9pTE96NDFGMlZNaGlHZ3px?=
 =?utf-8?B?dm1jQ29wYUdkamdjcm9yT1FGS0NnWTFLNnJYOXZIc3lMVS9FWjlCNzZmdXZo?=
 =?utf-8?B?MHJDUVFPTHdXNEM0UElGS083N2xUVG0xa3hJUGZ3Qm5Tazc5Y0lIaVlTZlpD?=
 =?utf-8?B?cEpYQW50VTNvVUFmREdWeDR4b2dCTGtnZWtvWHB0QmNTeThmVEs2MjVJanBF?=
 =?utf-8?B?bEFMNXpqOURUdnRJK044WWQvYTJTa3IybzdrRVo5b3NFYjdpU0NtYWpwRlFF?=
 =?utf-8?B?TVBXc214RlFjeXdOaW4zTk1VcWpuM2NrVFFTZnEzMlFGUHBPV2VsUWlub2d6?=
 =?utf-8?B?VDZyWDZ6cFlPcW5rRlRIR2ZmdGE2bis3SGJvaUFIZ0VkWXhZMloyVWxQSHNx?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69497285-b569-4f44-f358-08dc9d96f762
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7012.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2024 08:38:10.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkUq6EqNy4J+TMiotJLOECes5u6znEqWuo2s99pg0kxTQsv/fFMmckrqT+h6WeKS6wKyhoKpDLWum6mdvDrB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6750

On 06.07.24 02:39, Jakub Kicinski wrote:
> On Thu,  4 Jul 2024 19:47:56 +0200 Ronald Wahl wrote:
>> --- a/drivers/net/ethernet/micrel/ks8851_spi.c
>> +++ b/drivers/net/ethernet/micrel/ks8851_spi.c
>> @@ -385,7 +385,7 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_b=
uff *skb,
>>      netif_dbg(ks, tx_queued, ks->netdev,
>>                "%s: skb %p, %d@%p\n", __func__, skb, skb->len, skb->data=
);
>>
>> -    spin_lock(&ks->statelock);
>> +    spin_lock_bh(&ks->statelock);
>>
>>      if (ks->queued_len + needed > ks->tx_space) {
>>              netif_stop_queue(dev);
>> @@ -395,7 +395,7 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_b=
uff *skb,
>>              skb_queue_tail(&ks->txq, skb);
>>      }
>>
>> -    spin_unlock(&ks->statelock);
>> +    spin_unlock_bh(&ks->statelock);
>
> this one probably can stay as spin_lock() since networking stack only
> calls xmit in BH context.

I already suspected this it was more a mental hint here. I will remove it.

> But I see 2 other spin_lock(statelock) in the
> driver which I'm not as sure about. Any taking of this lock has to be
> _bh() unless you're sure the caller is already in BH.

The other two instances are not in BH context as far as I know but also
do not interfere with BH. The one in ks8861_tx_work protects only
variable assignments used only inside the driver and the one in
ks8851_set_rx_mode also only does some driver local variable stuff and a
schedule_work which as far as I know has nothing to do with BH because
workqueues are running in process context. Am I wrong here?

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

