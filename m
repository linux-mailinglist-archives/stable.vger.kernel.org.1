Return-Path: <stable+bounces-125595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D9A69639
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B934F170E03
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674181F4C88;
	Wed, 19 Mar 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vchJFcvb"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D21E9912;
	Wed, 19 Mar 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404802; cv=fail; b=RcTW+5IPMUWjMpg/AFj2581W7x0Ajdn4KDgbvkWmrs4ENDS+f4RCSNZJW+UuP+792qiZ5Sy+GiWxAy/eb467m/xIWNQGmnXAoWBZAQ1xW/r1ypyvvpIu/MbYiEpeNcnBNo5Q9Oq2DpHr7bvZqz9/jjWvSyiYvQ+zPriAJlrf+Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404802; c=relaxed/simple;
	bh=UuHTLZA8SD1DgZN0L44LydZbOtJT7FxCf36hHiEf4Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D6r7v4bmVe+qi49rcuM4NpMmt2pwTGAbFUIjz93kwpcBROMeEvu7+djS5A9yqSS37hFo2qMA7Em73GKdCAgs/KDWb6t3ORKyoLX7SgIjjyDoFOQXdGHzVBYMHMZv0P3LnODibSCxi0eot+aZeHnoJGECSIq3QmGiQgrfQ/GO+Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vchJFcvb; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+FZWBkrC6Y+vmKrIkv2k6NZ9gR5DMsmGff6IBfWaDtXx2iCCNXcQH8FfAue5FcCprFCMzTeZa4nQEwtnG14yl0t7fPAW548WPm0Yl6X+bKakTKCwQC970wQ1YfVXY9oJWC5FW+zfuAOESfYUB7g1Dj21Nc6NyrftQsd2RIl/H4yPEIauam6nkn6e2ljE2ctyxw19S1WyCyyGaASMQdmTg9xfVuHNQZkP3ST/YXWjViTDm5WqeVDTHnEXGbJayrs7cxmnG/zgwJVRhqdwz3i5x+xQlQGAzbMXaBB+kEKwW8xvX2Zd36nSnpGXT+dLL1Id9M4iESjpYPDt39a3eviRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuHTLZA8SD1DgZN0L44LydZbOtJT7FxCf36hHiEf4Sg=;
 b=Ct9gupVjpZf0orKmEw/AYHluIWS1viqF0lPb0zlhcYmJu2FJaTzweuxj5u5NOutFHdEsLpIbuLHURNtyS7+YpBV0VPnyNz/bre1upz0gOhHY0CkxgzyD4jeYGIe1n9jFI22kh2PjQtlUnaL0SaVNroQFSAzqlx0t50XAfCsJPmTtIkRCyvDpGg6pWRe8QFOhSxavpQepUibo3B9IvCVmYiVRVYRvneM6oVIQ9AuFqFg5NV7YiCVNaCJPnJ/yE6wA2ntXAOCUui0PCE0ID2PHkXS3Ueury4re4mfEFYEql3pJgKrwK82mN1L5II7MomH9XdTm5SoQ1LrgPQYQp7HCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuHTLZA8SD1DgZN0L44LydZbOtJT7FxCf36hHiEf4Sg=;
 b=vchJFcvb6np/8I3ZjEsOgptHhKzPfGy4mJNrQGKAovn4cN+BOLN1xLEiRCY7Mu7K3Sk/Ec1AKTN3wdDf1kiZoKbWHxtQ82e3E4BsVZn0N65lt/0SJ03BwVNLBRfMRdpKW6G2oV3n23nkv6I6A93HxfbOwz8pTdZp2bsCWA+Rmg7Np5rhD3MzYSQjVlX+cdLh5cnn1bmM2xkt/tuevRw415bwGXINHyd4nbMJX8kxUUoAkuOfmjfdVV36zKhsOfTpSNlotpkjfVQsmKm62cEPwWE7CW/gD2RFDtYtXa3cLAXzlmX7TSKc8TQ/LOaUFPwFAaDbTJKSyE0zCGD47Z2J2Q==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB4PR10MB6989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:19:56 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 17:19:55 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "jm@ti.com" <jm@ti.com>,
	"josua@solid-run.com" <josua@solid-run.com>
CC: "rabeeh@solid-run.com" <rabeeh@solid-run.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jon@solid-run.com" <jon@solid-run.com>
Subject: Re: [PATCH v2] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Thread-Topic: [PATCH v2] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Thread-Index: AQHbmLjihaETI62MZU2zGRTv5Js1gbN6pboAgAAPF4A=
Date: Wed, 19 Mar 2025 17:19:55 +0000
Message-ID: <a99d2927cc385aaed018b7e5cbf2a0db709918cf.camel@siemens.com>
References: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
	 <93d7e958-be62-45b3-ba8f-d3e4cf2839bf@ti.com>
	 <5c6e447ad9633f969cad7ed6641c8f6cfcc51237.camel@siemens.com>
	 <3be2f0a1-65f9-4aa7-9c0b-1f4fe626be17@ti.com>
In-Reply-To: <3be2f0a1-65f9-4aa7-9c0b-1f4fe626be17@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB4PR10MB6989:EE_
x-ms-office365-filtering-correlation-id: 59b96469-cc1d-4bd0-c11a-08dd670a44d8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUxaTzRkakI3SlY1WEJteVZMN05EMU1JdjhZV1RFcXhHdkZXc3B3bUMwek1H?=
 =?utf-8?B?dkdHbFZFWDlZWTArQnhKcU1PVWV0NjlGdGhlbmZCUVJSVEZnT1NodHE3dEE4?=
 =?utf-8?B?RFRhNzBkSEt5MEJkdmlvTTBjSmZhTDlRTUZ3SWhnT1dSL0tQVVI3NzNOMXNj?=
 =?utf-8?B?Q1gySmNZeXFjYnE0S09aOXhnMk1wWjZHeFgwOTNyeEtPd3ZvWDlRZTYrTC9Q?=
 =?utf-8?B?ZTJPcEdHQnVCbW5lWGhuYW1EN2ZqOUovWmZYYXlvYXR5Qk90UWhodUNXdytw?=
 =?utf-8?B?Y0UzSEdRM0g4T1kvMkpZSE1GdlNSYnFUZUEvRHZCSHBpNW5oTUkwL1ZyUHZS?=
 =?utf-8?B?TUVRdnZmRlhlVkViUmY2dlBZQXk3b3BySklZNnJVS3B2ZTdaOE1rOC9VcXcy?=
 =?utf-8?B?VFd6RnpTcGJlU1BRRUVTZlIzSFY0ODhaWkY4bDdCeEdONmFvWmUwTWxzL29v?=
 =?utf-8?B?Sk0walkrY0lwOWo3bHFQTnlYa2dyMXd2SWlkcmdnTkFaRk1FdDZHaTlQb0Fj?=
 =?utf-8?B?eVNHd3U4UUMzOXd6NzM3SFhvN05VQ3VXMFJtcVI5U0JPVVU5MEtDZXR1cDRo?=
 =?utf-8?B?cEc2ZUZOdkFPUnJBTU9TOElMclZDemZmd1lyM3J5U2ZqQVVtWlRJcTVqZkty?=
 =?utf-8?B?MW1GbzdKZUdMYktVSG5qVkl4MVF6SFZKR2d1dTZENGN6TzBqMjBvVTlKNW1Q?=
 =?utf-8?B?OEF2bTNrWFZTZ1paZFljWlZrU01JaXFtTXVsY1dyRDZnVnBlcUxqZ2ducmtK?=
 =?utf-8?B?V3V0YWFDSE5TOC8xUnlXa3hwVEFIUjQ3MDltd1hrTm5zNGs4ZWY4Mkl2U0cz?=
 =?utf-8?B?Qmw5OC91T2Y3Z3ZMUjhXZWRVeGJPMWV4aThiRmU5d2dTeTdvenN4YTEyYzEw?=
 =?utf-8?B?T2tCaUg0V3JRbEIzcE0zVEI5cFlWTC9Nd0V4b3NoczNKR0RIR1FXZXBNNHpv?=
 =?utf-8?B?OWJCelJORkVHWWhKQzk0dGN6ekZDYmhGMWVLSTE1RE9tbkY4RmFEMzZjb2dq?=
 =?utf-8?B?VU4xdUpWT3oxRUoxNFRyWUgrNXlyNlZuKytrVmtLK1FOU3FCR2xMS2pUdkY3?=
 =?utf-8?B?L3hPSitpNHkzSEJSOGorN0tOS1JlaEhmcjZiLzV6cjVSRkNyVStTZ0l3S01P?=
 =?utf-8?B?S0gxdTBLZU5OTzVNZFl2bS9IeHNiTjREdUh4bkZIZ282dXNheTRJczJQdDVJ?=
 =?utf-8?B?ZVlUc3d0QkVWdjdoRlpCYVNJNHU1L3lwWUIwQktEbzlhYysyVnpyWVdIdkZk?=
 =?utf-8?B?NjRwOFA1cWlWbXl1QnJDeDdwUHJ2MVVBdStpYkpKMWZpWXIvK0gzSm53V0Yy?=
 =?utf-8?B?bWN5TERkaEJqYlZEamRlT2Z3VS9sTU9vQ1F4NHN2MXJaMlJ0cmsrZHRNUGxE?=
 =?utf-8?B?WjdnSUtwVFFnU3g5c2dkSmFwUUY3SlFTMjRPbUNQVFV6VzlSekZvaExVcTc4?=
 =?utf-8?B?dkxndEJ0RndrTmluZ2hGdVpuQmltMnlyNGdkeWNXZmQrdUlEbU9uTlM5OS9o?=
 =?utf-8?B?T3BIcXl0UC9EdzFOYnNRWVBxKzBzSXZUMWNBV1NZd2lSalhDVFJiamwzZm1D?=
 =?utf-8?B?QWpGMnpiQTQ1c05QQjlJR0t1OUxBTmRSN3hySGlKRmFTL0g3K25EdkZPbEVh?=
 =?utf-8?B?TnNxdTBJYWt5QkorWHlyUldFUVcrVnNMOCt2UmNlQVFvbXZLbU5YRlcweEJ1?=
 =?utf-8?B?cUI2cTRPdnZXb1gvby9ML2FyNnVWc0lnTDVIMTBJYmNLZWNhVWZEN1FJbWRW?=
 =?utf-8?B?VkcrQzhsWmg4MUNpaGdhVUNNMUpIbXMvNGpIanpYaUpLMUloZWVraDBTM1pX?=
 =?utf-8?B?K3BSSFpvU0tIRVZDOHBDb0l3QkErMndmR1JMQnV1OGlaNVY0eTBYczFLb0hD?=
 =?utf-8?B?b0d6bTUwWGRBV1RZUUtvbGRiMk8wRmJ6bnhtd3VHSWNHMVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm1LTC9tUFIyL2l0UkdGdGI1V0JhNE1iMTJHelpwSExabEtRWXFTb1FXT3lD?=
 =?utf-8?B?aTgvZkhtcWxqOHJmempLN0N3VWNGZUlEa2ZkajY0MklCd1lPRGczSUx3VFRt?=
 =?utf-8?B?dzl0SDlkU0xCS0F2TnNMN3JPNVE1bzNkRk9HeVlWRDZ0L043VTVkaXJSVjZh?=
 =?utf-8?B?RGJRYWNIaXB1NVF6K0xTN3V1UDRqVzdRaTVLWVdsUS9LNkVBNnpRR1F1OVc1?=
 =?utf-8?B?Y3k0b2FHMDhXT1k4MGs0QXExVGtoaWFyUnpBQVJHTnlBV0E3ZHNSQ25KV1VJ?=
 =?utf-8?B?NGNOZ3dmVGdNZmdDYkxFZk03cTFmQ2NZNlRVZTQ5VHJpa1k4Y2U1V2JKWWxS?=
 =?utf-8?B?cmM0Y0pxWG0vS0lJYTlCTXJ3dTFza0VaeFczdFF6NHBLR2cxejY5TE5oY0RH?=
 =?utf-8?B?THZ0ZXljbFQwNzhxRCtiWWhEMi8xOGNQZHZTTXdQL2k5WUh1WUFCNzY3WVhI?=
 =?utf-8?B?MGduVGF5cHFOVWJZOVUzZ3J5OE5Jb1MrMEhpRWhWdmVaS21vT3JqTVo2RXBw?=
 =?utf-8?B?NzlqUXEvZ0pjdktTNzcrVzFlRGVRYTkraThpUkEwSURHLzVBVnI1dkZNN3lP?=
 =?utf-8?B?SURkOHZwNm5aYzJYZUdzTDB3YkFMdCtrYmc1UDIweCtJRWJqMTRid3JIZC9Z?=
 =?utf-8?B?NVUvbUJ3blI1YjNZNXN1Zit0SHMzWFFWeGMxcklEOS9XRGY1dnFOMGNKTG1j?=
 =?utf-8?B?WXkzQlRJNGo1VmZGTm5lckVKOU1ZQ3B4NUx5akFoUzNTb1crVHZJZmcyNFhz?=
 =?utf-8?B?WklKWlhaeEhjTlc3VGZWY1BFc3AvdDRKU0pLK1orOE90cHdTWm9LNSs2SHZO?=
 =?utf-8?B?UUxQVWMvN25DeTVVM3k5YlpDV2ROVnY2SzRtMzNVblErUWlHYjJDM3hDblFl?=
 =?utf-8?B?UEpOK1hSOCtTZjVINHFld2c0dGZNWHVCVlRnSkpmSlRYMWxFNTdmM1NQLzg1?=
 =?utf-8?B?a1hXWkMvWTFGYlQxRHhxVnB0dk81WlFjaFZpOUVZKy9uTjdpM3pTVTBFOXBw?=
 =?utf-8?B?M3RCZ3h6YjE4eXllMGl1TzdkNXcwSWVsTnh3VzZTYnpUZlRrUEhISmtPdU8w?=
 =?utf-8?B?TkZKNERUOXhCWVQ4Ukxpc2kyaXROUHF5dUVhU3RsN3Ara3loMWRuWSs2dWIz?=
 =?utf-8?B?ZGZNdVBsWmpjMjNRemkrRzZ4TTJjcGhQMFZ6RDlGeFJyV0Z3cmNjNjJWM0hS?=
 =?utf-8?B?Smo5dWtMaXl3RURUK0tjeU5TbGdxZUNVM0JsbDZ1MCtON3pydkJNMTM2UW5h?=
 =?utf-8?B?dENLTHlTWFFqVWJLaDBvdjVxWFBjdEEzVnE1VmxGRlNMZitzNVlZVkYxOVdy?=
 =?utf-8?B?M1dhZWZmbDFTUFlQTnA4MlJXVWp5OUc2Y1o5NWxIelVSdWJsd3crN2prM2Jh?=
 =?utf-8?B?SVJxMDQ0M25KOVA2VHFxV0ZRcmlCZ1pzQTkwZDBvd2dPS2hYcGFjb2lLVEg3?=
 =?utf-8?B?ZmV2NHE5MDE3ZjJoV3VtTFE5Zk1ObUlTS0UxVWZnWjN0UFJMNE9mR1VUQmky?=
 =?utf-8?B?RDl6cGpTL2dua3RDcllQbTBnZE1CZnZNMGJobHowNCtHdHdPK29OejRJMDds?=
 =?utf-8?B?WHdqSElsSDNvc3M3UnplVGdnc1lNakVFZ1FzNHJNNG94SVV6dG1oKy82azBL?=
 =?utf-8?B?MjdkVEhDV2FnK29sQytpMnAvR0VsM0pMV09Jc3JzQTF5UXlJamFLblh1dEFN?=
 =?utf-8?B?ME9yeVFmOERXeHQ3OE96QVRLZklZZjFWSXNmdnRuWDNlcmNvL1l2c2FST2dU?=
 =?utf-8?B?eWdSSDNCVkJhMktWRU5WbUpLWjM2MWk4YWFxQSt2RHYvbUNRZzJqVWF2cXN6?=
 =?utf-8?B?VXUxUmtLVWRrYkNiY1VkeTc1TllQS25xWDJHOTc5YndlZXV1YkxDRCs0eFdL?=
 =?utf-8?B?SnBINjRFVUdhc3RoK2dXbjlZbW1YUmVCN2l2QVVQcWx1aTl4UUd1RzY4Sm4z?=
 =?utf-8?B?bnNBK0NYamdPQndqM0U1UWJ5K1E2NC9LdEVDYmQrdHVReTNXSVdaRVBqRVU2?=
 =?utf-8?B?aXM0dFpQNmZTRno0VnFIVmwwd01JczJyY1FqTHByMWxsSDNoMFFXMEZEYTVP?=
 =?utf-8?B?M3pjZ1IvMExSV2F5L203dUpBakFoRmwrcTRDdDdYWVR3ZkFmeVZnYUg1WWxV?=
 =?utf-8?B?eFk5bUllb1N6MW0zdTBOTGdocVJZYzRiSllrdDRtOFBOR1pWSXV5cHV1ZjVQ?=
 =?utf-8?Q?50E2ptm76mNHPMjmLnrAaNM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CB9B5B92D07C048A567AC246023ED56@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b96469-cc1d-4bd0-c11a-08dd670a44d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 17:19:55.8407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2BDgvAWfqMhK0a2xh9xVUcUNMcNTNLrkwZBzs9IEWIj67ZHxCG6GRvL0iHD5jM8MVL5Kbybj4l2G8qxFGX9+tC4QusnV2i5dTJZu/kloaFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6989

SGkgSnVkaXRoLA0KDQpPbiBXZWQsIDIwMjUtMDMtMTkgYXQgMTE6MjUgLTA1MDAsIEp1ZGl0aCBN
ZW5kZXogd3JvdGU6DQo+ID4gPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgOTQxYTdhYmQ0NjY2OTEy
Yjg0YWIyMDkzOTZmZGI1NGIwZGFlNjg1ZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgY29tbWl0
IHVzZXMgcHJlc2VuY2Ugb2YgZGV2aWNlLXRyZWUgcHJvcGVydGllcyB2bW1jLXN1cHBseSBhbmQN
Cj4gPiA+ID4gdnFtbWMtc3VwcGx5IGZvciBkZWNpZGluZyB3aGV0aGVyIHRvIGVuYWJsZSBhIHF1
aXJrIGFmZmVjdGluZyB0aW1pbmcgb2YNCj4gPiA+ID4gY2xvY2sgYW5kIGRhdGEuDQo+ID4gPiA+
IFRoZSBpbnRlbnRpb24gd2FzIHRvIGFkZHJlc3MgaXNzdWVzIG9ic2VydmVkIHdpdGggZU1NQyBh
bmQgU0Qgb24gQU02Mg0KPiA+ID4gPiBwbGF0Zm9ybXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlz
IG5ldyBxdWlyayBpcyBob3dldmVyIGFsc28gZW5hYmxlZCBmb3IgQU02NCBicmVha2luZyBtaWNy
b1NEIGFjY2Vzcw0KPiA+ID4gPiBvbiB0aGUgU29saWRSdW4gSGltbWluZ0JvYXJkLVQgd2hpY2gg
aXMgc3VwcG9ydGVkIGluLXRyZWUgc2luY2UgdjYuMTEsDQo+ID4gPiA+IGNhdXNpbmcgYSByZWdy
ZXNzaW9uLiBEdXJpbmcgYm9vdCBtaWNyb1NEIGluaXRpYWxpemF0aW9uIG5vdyBmYWlscyB3aXRo
DQo+ID4gPiA+IHRoZSBlcnJvciBiZWxvdzoNCj4gPiA+ID4gDQo+ID4gPiA+IFvCoMKgwqAgMi4w
MDg1MjBdIG1tYzE6IFNESENJIGNvbnRyb2xsZXIgb24gZmEwMDAwMC5tbWMgW2ZhMDAwMDAubW1j
XSB1c2luZyBBRE1BIDY0LWJpdA0KPiA+ID4gPiBbwqDCoMKgIDIuMTE1MzQ4XSBtbWMxOiBlcnJv
ciAtMTEwIHdoaWxzdCBpbml0aWFsaXNpbmcgU0QgY2FyZA0KPiA+ID4gPiANCj4gPiA+ID4gVGhl
IGhldXJpc3RpY3MgZm9yIGVuYWJsaW5nIHRoZSBxdWlyayBhcmUgY2xlYXJseSBub3QgY29ycmVj
dCBhcyB0aGV5DQo+ID4gPiA+IGJyZWFrIGF0IGxlYXN0IG9uZSBidXQgcG90ZW50aWFsbHkgbWFu
eSBleGlzdGluZyBib2FyZHMuDQo+ID4gPiA+IA0KPiA+ID4gPiBSZXZlcnQgdGhlIGNoYW5nZSBh
bmQgcmVzdG9yZSBvcmlnaW5hbCBiZWhhdmlvdXIgdW50aWwgYSBtb3JlDQo+ID4gPiA+IGFwcHJv
cHJpYXRlIG1ldGhvZCBvZiBzZWxlY3RpbmcgdGhlIHF1aXJrIGlzIGRlcml2ZWQuDQo+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gU29tZWhvdyBJIG1pc3NlZCB0aGVzZSBlbWFpbHMsIGFwb2xvZ2llcy4N
Cj4gPiA+IA0KPiA+ID4gVGhhbmtzIGZvciByZXBvcnRpbmcgdGhpcyBpc3N1ZSBKb3N1YS4NCj4g
PiA+IA0KPiA+ID4gV2UgZG8gbmVlZCB0aGlzIHBhdGNoIGZvciBhbTYyeCBkZXZpY2VzIHNpbmNl
IGl0IGZpeGVzIHRpbWluZyBpc3N1ZXMNCj4gPiA+IHdpdGggYSB2YXJpZXR5IG9mIFNEIGNhcmRz
IG9uIHRob3NlIGJvYXJkcywgYnV0IGlmIHRoZXJlIGlzIGENCj4gPiA+IHJlZ3Jlc3Npb24sIHRv
byBiYWQsIHBhdGNoIGhhZCB0byBiZSByZXZlcnRlZC4NCj4gPiA+IA0KPiA+ID4gSSB3aWxsIGxv
b2sgYWdhaW4gaW50byBob3cgdG8gaW1wbGVtZW50IHRoaXMgcXVpcmssIEkgdGhpbmsgdXNpbmcg
dGhlDQo+ID4gPiB2b2x0YWdlIHJlZ3VsYXRvciBub2RlcyB0byBkaXNjb3ZlciBpZiB3ZSBuZWVk
IHRoaXMgcXVpcmsgbWlnaHQgbm90IGhhdmUNCj4gPiA+IGJlZW4gYSBnb29kIGlkZWEsIGJhc2Vk
IG9uIHlvdXIgZXhwbGFuYXRpb24uIEkgYmVsaWV2ZSBJIGRpZCB0ZXN0IHRoZQ0KPiA+ID4gcGF0
Y2ggb24gYW02NHggU0sgYW5kIGFtNjR4IEVWTSBib2FyZHMgYW5kIHNhdyBubyBib290IGlzc3Vl
IHRoZXJlLA0KPiA+ID4gc28gdGhlIGlzc3VlIHNlZW1zIHJlbGF0ZWQgdG8gdGhlIHZvbHRhZ2Ug
cmVndWxhdG9yIG5vZGVzIGV4aXN0aW5nIGluIERUDQo+ID4gPiAodGhlIGhldXJpc3RpY3MgZm9y
IGVuYWJsaW5nIHRoZSBxdWlyaykgYXMgeW91IGNhbGwgaXQuDQo+ID4gPiANCj4gPiA+IEFnYWlu
LCB0aGFua3MgZm9yIHJlcG9ydGluZywgd2lsbCBsb29rIGludG8gZml4aW5nIHRoaXMgaXNzdWUg
Zm9yIGFtNjJ4DQo+ID4gPiBhZ2FpbiBzb29uLg0KPiA+IA0KPiA+IGRvZXMgaXQgbWVhbiwgdGhh
dCAxNGFmZWYyMzMzYWYNCj4gPiAoImFybTY0OiBkdHM6IHRpOiBrMy1hbTYyLW1haW46IFVwZGF0
ZSBvdGFwL2l0YXAgdmFsdWVzIikgaGFzIHRvIGJlIHJldmVydGVkDQo+ID4gYXMgd2VsbCwgZm9y
IHRoZSB0aW1lIGJlaW5nPw0KPiANCj4gU28gc29ycnkgZm9yIHRoZSBkZWxheSBpbiByZXNwb25z
ZS4NCj4gDQo+IERvZXMgdGhpcyBmaXg6ICgiYXJtNjQ6IGR0czogdGk6IGszLWFtNjItbWFpbjog
VXBkYXRlIG90YXAvaXRhcCB2YWx1ZXMiKQ0KPiBjYXVzZSBhbnkgaXNzdWVzIGZvciB5b3U/DQo+
IA0KPiBUaGUgb3RhcC9pdGFwIGZpeCBpcyBhY3R1YWxseSBzZXR0aW5nIHRhcCBzZXR0aW5ncyBh
Y2NvcmRpbmcgdG8gdGhlDQo+IGRldmljZSBkYXRhc2hlZXQgc2luY2UgdGhleSB3ZXJlIHdyb25n
IGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gDQo+IFRoZSB2YWx1ZXMgaW4gdGhlIGRhdGFzaGVldCBh
cmUgdGhlIG9wdGltYWwgdGFwIHNldHRpbmdzIGZvciBvdXINCj4gYm9hcmRzIGJhc2VkIG9mZiBv
ZiBiZW5jaCBjaGFyYWN0ZXJpemF0aW9uIHJlc3VsdHMuIElmIHRoZXNlIHZhbHVlcw0KPiBwcm92
aWRlIGlzc3VlcyBmb3IgeW91LCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNCkkndmUganVzdCBub3Rp
Y2VkIHRoYXQgMTRhZmVmMjMzM2FmIG1lbnRpb25lZCB0aGUgcmV2ZXJ0ZWQgOTQxYTdhYmQ0NjY2
DQppbiBhIHdheSB0aGF0IG9uZSBtYXkgdGhpbmsgb2YgaXQgYXMgYSBkZXBlbmRlbmN5Og0KLS0t
DQogICAgTm93IHRoYXQgd2UgaGF2ZSBmaXhlZCB0aW1pbmcgaXNzdWVzIGZvciBhbTYyeCBbMV0s
IGxldHMNCiAgICBjaGFuZ2UgdGhlIG90YXAvaXRhcCB2YWx1ZXMgYmFjayBhY2NvcmRpbmcgdG8g
dGhlIGRldmljZQ0KICAgIGRhdGFzaGVldC4NCiAgICANCiAgICBbMV0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtbW1jLzIwMjQwOTEzMTg1NDAzLjEzMzkxMTUtMS1qbUB0aS5jb20vDQot
LS0NCg0KdGhhdCB3aHkgSSB3YW50ZWQgdG8gZG91YmxlIGNoZWNrIHdpdGggeW91LiBCdXQgaWYg
eW91IHNheSB0aGV5IGFyZSBhY3R1YWxseQ0KaW5kZXBlbmRlbnQsIHRoYXQncyBmaW5lIGZvciBt
ZSENCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNv
bQ0K

