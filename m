Return-Path: <stable+bounces-59383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A128931F04
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 04:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAA61C2115D
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 02:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4505B67F;
	Tue, 16 Jul 2024 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RXiDht0H"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63510A14;
	Tue, 16 Jul 2024 02:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098355; cv=fail; b=HBod/a0Ymhvqnt9HOttuopptaZoAnF8nKTJPoC7SplbD7vR6dHRCAyeqsXX+Lq+/Kd0+IZ+5clbXxjBfS/RlunpOR/eFiiGAykp/UvYc/jLo1ni5LNHEj1jMUkEEQaI/HTZ8HqbGevV+YGaVQS0f2qHHdP1pXrS1iE2MSTMRGrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098355; c=relaxed/simple;
	bh=f072JXNXMbEIYmEoGuh4O/ti0z1Fy01Dxi8kES8/b9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WCW+GhK6Ra3N7FKm9MSzv7kMmDWkfNhvJ7YCqxHThmSCFAoCXZDfmE5MM08YeCTJznbktnt+/hOL/Z0PrVR2pdpomSowQnNqjPgOxjZBsXSJzJ7b6bawgY4fIYXmOBffpsgsucyoszBwxphuOT0TF/uZRGMWkahb30bicSM2G3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RXiDht0H; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMCGpLa9NvH8+Pm8KuxdjjqAL3dB/BRA0Tnc/H0W+bfaMQjR10A3gE2ItEffNKnoCxE+YU4mSmzMAQX9UGZ5WA3LkcNHZy9W0RTLCa0ssWCVwdphEELN6uCuSDTbvH2YU8F95tF7k6mQTrOL8aVumYIvVaVZPyK1nMAoSWq+Ye+zHinMif3hLx44KA1tjR2EpqxjoZ5j6K3H15SGr81bdLeQT5dpAMygruAUFUEo8xFybDetzMbmfkr79GDpLI/25SMpGdAj8SImvTQ96yHRA8Jw5p+e5SCaxk71QgmYHdVBRizrfXUSz2HTHFVNbpcoYo9CQeLQxn2g3mtsDN+OWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f072JXNXMbEIYmEoGuh4O/ti0z1Fy01Dxi8kES8/b9k=;
 b=weBgOKELW1IFbOCl5UnMhuegN2slWCfYp9Wunoj/y4yVqtOS/7cQu0g5JcFTcD3TpMslVy0hKgFqzgdz9N+s4n3Xus8rWUw0JZId9+ie+D1c2/TVdfAy3UZTvlS58/VOOS+Tbtk8b35xN6DIWAHCK6maP5YgC3JTPrhUj/BxMBq6sEFgTbFEEf5IsL7aDWWnc3yvbskG5ypD7X4ZZbHw3VzUs2fQE5xWfZ2jME+A76TOvdzuG382JmBzwnRyIH8DDmj5lrD8hvLTi5EzHgROMI9f0W643tpBaH8W2+NleHVG2TB7Ej30UmGn+8rHfp/4HDAEEEy9a5Gnrv21XlPF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f072JXNXMbEIYmEoGuh4O/ti0z1Fy01Dxi8kES8/b9k=;
 b=RXiDht0H/Maokd4kw0MMGETIBgOtEoAhhpp1wKS9tZZuY8bfsBZby6wEbWYxTNroh+/wEnTTvDya2WbJtmEcjJaJYOXASvPRAcGm+itjUBKOC/ssE2atmIrAD731vmQJF6TPHitCIRTA5K9Kxwa1h57+Dck/Q1giBDIn4Z6ybo4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI0PR04MB10952.eurprd04.prod.outlook.com (2603:10a6:800:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 02:52:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 02:52:29 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
Thread-Topic: [PATCH v2 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
Thread-Index: AQHa1lxv3hLkiVwOuUGxAAfKD1Bq/bH4WFSAgABNQTA=
Date: Tue, 16 Jul 2024 02:52:29 +0000
Message-ID:
 <AS8PR04MB8676A952ED9ADB85DEE810118CA22@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721008436-24288-1-git-send-email-hongxing.zhu@nxp.com>
 <1721008436-24288-4-git-send-email-hongxing.zhu@nxp.com>
 <96d89d2f-0ecf-4c15-9a8a-146aa587d246@kernel.org>
In-Reply-To: <96d89d2f-0ecf-4c15-9a8a-146aa587d246@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI0PR04MB10952:EE_
x-ms-office365-filtering-correlation-id: 48164d6a-3081-4d60-8aa4-08dca542551a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3RmUUhldXBnRWUyOG0zQVVOUHZreFFQTWptYVFaancxZjVsNDRGZjYySVlq?=
 =?utf-8?B?Sm9HeUVvUkNPUW9LWTlOY2tEV1NsQ2FLV3BjdDFCMVFyRXROYmZoRk5WWFAw?=
 =?utf-8?B?VGp3U1ZWWlMxQjJhTFRuT29EQUkyM3YrUENxWmRySjluUnlUbzdYNk44SVY2?=
 =?utf-8?B?VlBFbDJzMW9ZWStvOVBnN3ZDK3F0cHJnR0FWZG1tN3lPRWRsOThNZEpxNGQ1?=
 =?utf-8?B?ZUJBRG9Va2hKZjdYdHgyV2UxUEhiYzZjOFhsdmJkcU9pT0UvTVo5WUtnOFUv?=
 =?utf-8?B?ZWNWSjAyaVR6OHFmbUNLdmZlK1B4KzFsSVBVWE1RazVKRThzZ3ZoaEpDUnU1?=
 =?utf-8?B?eXU2VERXenJWSjRuSUhQYzBoVUZzckxQR2N5TEM4MkV6ZnBkM0dVM1g4cjRO?=
 =?utf-8?B?TVNzTEw1d250UDdUOXhINnBLMmtoa0R4b0xCZUcwNm0yU08rSnVsOEF2bHh6?=
 =?utf-8?B?aU9pQ05Fb2U0ejFONkpPczNtVjEvVm1DNWIrWmxHSFBUbnJLa25wV09EUzlz?=
 =?utf-8?B?Yk0rOC8vV1lMK1J0bS9IVkJWQlo0T1cxRFllVE9oOFl2aW1sNXNrZVJXWjN3?=
 =?utf-8?B?MW1SYmVtQUlqKzZ4b0NSU2Q4bVZsdW5SeENBTVpxb25iZkZiWkZhQjJVSGFK?=
 =?utf-8?B?UTd4WjJoM0xlZWpYMzVlekRsekRsdE5KT2x0a1lCSEhSblVlRmQwQzlTdUFx?=
 =?utf-8?B?eXZManpub0orVTV3cUxkYzBPMmZHbnY5Y0JtTE9rMVltMXBWYXRrTWozWkVq?=
 =?utf-8?B?YXk3Wk16dVpvNm9paVVQYzhDY1VTd0dCaTB5akpwZFU2bktWVVdvT0ZyRnNv?=
 =?utf-8?B?dkhXcDN0OVY4aW9GY3k1akd2T1VHbzFzVlROWFBDRk5JSHNab0k1M3Zzc295?=
 =?utf-8?B?MGVHUUlHazBGUzMzTmxhUmRkbVRLYXdaN1lCZGhEZ1VsWnU1SFE1ZDNndWNs?=
 =?utf-8?B?am40b1pZdHlzVDFZRWV0VnJESHFmOGJBYnhSbWkwb0lzZGxPT2Z0M2EwWGZv?=
 =?utf-8?B?L29tREJ3K2g4UzNJRUFlbFhwM0x5S1Ivb3V6TzE1aXFOL09oOGx3a0Z5N3Na?=
 =?utf-8?B?VU9vd0JJMGFGcjRpL3JpZ2crVlRDK2VDbmw0d2hoMEVwYm1RVllieE81eHZi?=
 =?utf-8?B?bzhmbHRGRlhOT2tyTjMrL1RmMStjbCtSUVZQRmxRdXhRVlQ2Yi9sVmZyUm11?=
 =?utf-8?B?eVBPa2Z2T1lmQVEzK1NhS1VCMDdzRFB4NkJkRHFUdWpZZDJlREVyb05seVEr?=
 =?utf-8?B?dFp4NmMxUlNja2ZuVFNFc21DU1JDTXY0SnJITER6KzVrK1hSRFY2MndVVldU?=
 =?utf-8?B?NStnNmU0d3A5WUw4c3lYcm5vbitDbjEzY0xJc1pBRTVPR0tEdDZGWFBOUFpG?=
 =?utf-8?B?T04zck91dTFpeXJOMTNuT0JTbVdST05YcWJ4eVBtOXd5VmZuR3BxQ29HazFv?=
 =?utf-8?B?UGJrNGF6RnFCdDM3NHh5N2lWZXNkL2xMUzhvcXlOMGVRVE9KSHM2dlJhbjNQ?=
 =?utf-8?B?U0l6elhRUjh2WTRUUXhVa1FMdWR6YmVSVmdWVjJPek1reStVSTM4dU13ZkRH?=
 =?utf-8?B?Uitad0U1V3duMHlqVHFJYzNDVmRpemdCV3loMW1VNWd3MzBxendzYWVkOE5l?=
 =?utf-8?B?SjRXKzNKOEpWUWdheWJiTG5FajY3Mk5DeHNDZW96SEwvOUJpOUJVV3FNdU1w?=
 =?utf-8?B?TjhLNmJPd3NzSm81OGFjYnJ2c3pmNitpajZWcGRqckk5Tmp5VDlvYWsyRHFU?=
 =?utf-8?B?S3VjS25wK3lHaitMQ1lUSTVnVGt3VHlUZi9FZmgzRXJlN0NGOEpzVXdHUEJt?=
 =?utf-8?B?eEJMNDZsS1AxVDREK0l6OUJKK2ZObXpTNi9mUzdWRmVJbjliSnIxeU5yNEM4?=
 =?utf-8?B?WXJSNmVLWnlNK3pxNmdKWjdRa3ZNMkcvWlR2OWFIVVJxVkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVNuZGRRNG1iakRlZXlrLzZsVlhTbU9rS2F3L2FNTE5pVmIveHNBeTFXRkV6?=
 =?utf-8?B?TmJUVHIzaWQ1TWtqS1FyOGJVMHRUNmVTVkx2MUh5bjEyS2xhdy9SY0R6aFh4?=
 =?utf-8?B?UldxSGs1Mk5MMWxURHlVSG0zbm91YWF5bHVRTSt4dnh5UmRHYW5aWVNvYWo1?=
 =?utf-8?B?TE1IVWlDRDJzTGgvNDkzMjQ5ZmpOcElxMGFEUHVxMllCN1JXN2lvZ1FiL0k1?=
 =?utf-8?B?N3pDOXFvcENIVUM5SWlVY1o0eCs5Z1hNbWJ0anF1eEZEL293U3ZsclhKNWNV?=
 =?utf-8?B?UWdhLzZVRmtmZXVlNjJJMEVoUXRYSmVPUmhOZ0tGcVIrNlRhdjd3MkZ5d2Vl?=
 =?utf-8?B?L3lpOVVKZ1NzSGhGbkUzSEN2MklhWFM0VGFQVGpMS1UyUmtYQm1UWG1tdVpY?=
 =?utf-8?B?Q0tuWnBoZE9pUEZyc29WblNVdEphMXpldFRMTUNpZ0hkQUt0MHlMTFVXZDVh?=
 =?utf-8?B?TnJxai9LdkVuT1o3b2lGZFNyYUZXL1RGaXNqcmU3OFZiVnNBczYwdzlNUVhX?=
 =?utf-8?B?QXAyUEVZZW13Q2ZGSjNzN0l6ekhjVXBQT2hBNmJuS1BsKzlNeWdCWHJQTmFM?=
 =?utf-8?B?LzAxTE9jOTBFWXhHNy9ZV283M2xDVWpMZGo3TUxBVlFybUpDckw1WXhtWCs3?=
 =?utf-8?B?bnNNRzdFS1JKSG5QOXp5cGszaFBpTFd5cElPU2xwWitnVUZzbTJaNW9jRTcv?=
 =?utf-8?B?NzBJRlRkbUdjRzcwcEd0clV1bi9VblhzWHZhajVuOVRaNi8zRmRYN05WY1JB?=
 =?utf-8?B?bExCcjlaNmgyUHNJbTZQM0VoaktrSE9EY1luNC9TdnVaWDZnMXVzOW5QTElw?=
 =?utf-8?B?dlVlY0hXTmpwZW9IbE10aGtyNVlicVU1VVYzK1haT21DRDVnN0U2dUxscTR1?=
 =?utf-8?B?aFM5alQvSTN2QzZRM25ybEtpMUFvRWlRWE5IS2JpSVNrMWExcTZaQmxLU1kr?=
 =?utf-8?B?NVUxQWpSaEZ3bmFxQ1NoV2VJRDg3SU92a1BmT01LMW8xQVpnS0VzblZBLzlm?=
 =?utf-8?B?R2JUbEtiMHZHTVVhblVRWm5Lay9DYTM5ZzZxbU9PZFZhSmluc1VhTjl0a1dP?=
 =?utf-8?B?RGhzNmVFTVk2c1NocmFrWGNHNlh2RkRnZUd0RTluaE8wMEJrdlVPRUljaldk?=
 =?utf-8?B?MnRXNngyUlFPU0xZNXR0MzF4K2lFaVdoWGM0TWFpU0dlV25SbDJ5Z2JXRTd6?=
 =?utf-8?B?aFhPQ0ZCSS95eHozV1Q2Rk5sZy9pYjdBTndiVHJFY1NVNDM0YVByZGhCaEdO?=
 =?utf-8?B?VG1GRDhRWDJHdDdnMHdINjFNUEs3YXVwY2h0ZndVaUhQSnE3eWszN044SFp3?=
 =?utf-8?B?TzR5ZkNqRlF5MENEa0RsUzc1b1JQVGIxcWZEams5Q0ROSkRBRlowMkdmcThO?=
 =?utf-8?B?ZmN6WEFudnVRRStWN3dBTjRvaTUrZU52d2tLM2N3b0dEdjdzczlWTjI3VXlh?=
 =?utf-8?B?bjQvc3N5NSs0c0V5aHBSQzd0WFBXQStXTWNMcE0vTDVwd3IzTWRhYURPczRo?=
 =?utf-8?B?ZlIvc2RFRW1VVm9pSWdDaCthWURGSW80NEs4RXdyTXllcW5iNDVwQlhCOGJ3?=
 =?utf-8?B?eDdPS3lDaUNCa0twa3d1TXFqUk1UMTlBcnUwNXhYYlRtd00xR1Jkb3M2Mzd1?=
 =?utf-8?B?bzFyVEptQW5ET3FIS0gycTRyZjdCbVBHMzZ5SXpMdSthWVVOdVgvUHorV3Vl?=
 =?utf-8?B?Q2ZGU3VjYXo0YzBZZExUdDdCSkhnOTZiMXp6dmE5SEx1Q2t5REdpVDRONkIv?=
 =?utf-8?B?ZXl6SER3MmtYOVBDTzJmVXM4ZnROZ200RlNqdnJVOTRHZnNVMzNyS0J2eUNq?=
 =?utf-8?B?N0dNVTArV1pvSFljVnpxSWxueDMyUU9IMGxxQVd6bUlUQ2RBQkZtc3ZCU3lo?=
 =?utf-8?B?bTI4WUNvRFZaeEJHWVo3dktqNGJYSXF1SXJYalYzNXNJME0vbHIzSlF5cURj?=
 =?utf-8?B?aHc4dGFFTjJwdS9rUko0d0dRZHQ0b2pUWXV2VlViT2luejJDeGRPWnVzdm0v?=
 =?utf-8?B?YjVZYUp3UVBpT0NVeDRXcjBoUDlPTEFSdUV6aEJaZmdNWHF3anVUNWpxQTFQ?=
 =?utf-8?B?VG5uRGZMQVZ1emJWSzJrYU1LZTU4VTRoOVZvdXgyQUtyb2xVQVg5dzMwdWNx?=
 =?utf-8?Q?P1fPT6plwmSFwmXL+9Uw6mNyT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48164d6a-3081-4d60-8aa4-08dca542551a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 02:52:29.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXFKBTy+FI0mYF+zuo3KFBo24BkF7E7//RjYWZs/kQ+E/gT+ksKh4sSeiky6fF9CXaicq2/Q5isBkRdmc/aYpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10952

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW1pZW4gTGUgTW9hbCA8ZGxl
bW9hbEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI05bm0N+aciDE25pelIDY6MDENCj4gVG86IEhv
bmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyB0akBrZXJuZWwub3JnOyBjYXNzZWxA
a2VybmVsLm9yZzsNCj4gcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9y
K2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogbGludXgtaWRlQHZnZXIua2VybmVsLm9y
Zzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4ga2VybmVsQHBlbmd1dHJvbml4
LmRlDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy80XSBhdGE6IGFoY2lfaW14OiBFbmxhcmdl
IFJYIHdhdGVyIG1hcmsgZm9yIGkuTVg4UU0NCj4gU0FUQQ0KPiANCj4gT24gNy8xNS8yNCAxMDo1
MywgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gVGhlIFJYV00oUnhXYXRlck1hcmspIHNldHMgdGhl
IG1pbmltdW0gbnVtYmVyIG9mIGZyZWUgbG9jYXRpb24gd2l0aGluDQo+ID4gdGhlIFJYIEZJRk8g
YmVmb3JlIHRoZSB3YXRlcm1hcmsgaXMgZXhjZWVkZWQgd2hpY2ggaW4gdHVybiB3aWxsIGNhdXNl
DQo+ID4gdGhlIFRyYW5zcG9ydCBMYXllciB0byBpbnN0cnVjdCB0aGUgTGluayBMYXllciB0byB0
cmFuc21pdCBIT0xEUyB0bw0KPiA+IHRoZSB0cmFuc21pdHRpbmcgZW5kLg0KPiA+DQo+ID4gQmFz
ZWQgb24gdGhlIGRlZmF1bHQgUlhXTSB2YWx1ZSAweDIwLCBSWCBGSUZPIG92ZXJmbG93IG1pZ2h0
IGJlDQo+ID4gb2JzZXJ2ZWQgb24gaS5NWDhRTSBNRUsgYm9hcmQsIHdoZW4gc29tZSBHZW4zIFNB
VEEgZGlza3MgYXJlIHVzZWQuDQo+ID4NCj4gPiBUaGUgRklGTyBvdmVyZmxvdyB3aWxsIHJlc3Vs
dCBpbiBDUkMgZXJyb3IsIGludGVybmFsIGVycm9yIGFuZA0KPiA+IHByb3RvY29sIGVycm9yLCB0
aGVuIHRoZSBTQVRBIGxpbmsgaXMgbm90IHN0YWJsZSBhbnltb3JlLg0KPiA+DQo+ID4gVG8gZml4
IHRoaXMgaXNzdWUsIGVubGFyZ2UgUlggd2F0ZXIgbWFyayBzZXR0aW5nIGZyb20gMHgyMCB0byAw
eDI5Lg0KPiA+DQo+ID4gRml4ZXM6IDAyN2ZhNGRlZTkzNSAoImFoY2k6IGlteDogYWRkIHRoZSBp
bXg4cW0gYWhjaSBzYXRhIHN1cHBvcnQiKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2F0YS9haGNpX2lteC5jIHwgMTAgKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYXRhL2FoY2lfaW14LmMgYi9kcml2ZXJzL2F0YS9haGNpX2lteC5jIGluZGV4DQo+
ID4gZTk0YzBmZGVhMjI2MC4uMTJkNjlhNjQyOWI2YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2F0YS9haGNpX2lteC5jDQo+ID4gKysrIGIvZHJpdmVycy9hdGEvYWhjaV9pbXguYw0KPiA+IEBA
IC00NSw2ICs0NSwxMCBAQCBlbnVtIHsNCj4gPiAgCS8qIENsb2NrIFJlc2V0IFJlZ2lzdGVyICov
DQo+ID4gIAlJTVhfQ0xPQ0tfUkVTRVQJCQkJPSAweDdmM2YsDQo+ID4gIAlJTVhfQ0xPQ0tfUkVT
RVRfUkVTRVQJCQk9IDEgPDwgMCwNCj4gPiArCS8qIElNWDhRTSBTQVRBIHNwZWNpZmljIGNvbnRy
b2wgcmVnaXN0ZXJzICovDQo+ID4gKwlJTVg4UU1fU0FUQV9BSENJX1ZFTkRfUFRDCQk9IDB4Yzgs
DQo+ID4gKwlJTVg4UU1fU0FUQV9BSENJX1ZFTkRfUFRDX1JYV01fTUFTSwk9IDB4N2YsDQo+IA0K
PiBQbGVhc2UgdXNlIEdFTk1BU0soKSBtYWNybyB0byBkZWZpbmUgdGhpcy4NClRoYW5rcyBmb3Ig
eW91ciBjb21tZW50cy4NCk9rYXkuDQo+IA0KPiA+ICsJSU1YOFFNX1NBVEFfQUhDSV9WRU5EX1BU
Q19ORVdSWFdNCT0gMHgyOSwNCj4gDQo+IEhlcmUgdG9vLiBBbmQgSSBkbyBub3Qgc2VlIHRoZSBw
b2ludCBvZiB0aGUgIk5FVyIgaW4gdGhlIG1hY3JvIG5hbWUuDQo+IA0KT2theSwgIk5FVyIgd291
bGQgYmUgcmVtb3ZlZC4NCj4gQWxzbywgd2hhdCBpcyAiX1ZFTkRfIiBzdXBwb3NlZCB0byBtZWFu
IGluIHRoZSBtYWNybyBuYW1lcyA/ICJWZW5kb3IiID8NCj4gSWYgdGhhdCBpcyB0aGUgY2FzZSwg
cmVtb3ZlIHRoYXQgdG9vLCB3aGljaCB3aWxsIGdpdmUgeW91IHNob3J0ZXIgbWFjcm8gbmFtZXMu
DQo+IElmIG5vdCwgdGhlbiBzcGVsbCBpdCBvdXQgYmVjYXVzZSB0aGF0IGlzIG5vdCBjbGVhci4N
ClllcywgeW91J3JlIHJpZ2h0Lg0KIl9WRU5EXyIgbWVhbnMgIlZlbmRvciIuIEkgd291bGQgcmVt
b3ZlIHRoZW0gbGF0ZXIuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiANCj4gPiAg
fTsNCj4gPg0KPiA+ICBlbnVtIGFoY2lfaW14X3R5cGUgew0KPiA+IEBAIC00NjYsNiArNDcwLDEy
IEBAIHN0YXRpYyBpbnQgaW14OF9zYXRhX2VuYWJsZShzdHJ1Y3QgYWhjaV9ob3N0X3ByaXYNCj4g
Kmhwcml2KQ0KPiA+ICAJcGh5X3Bvd2VyX29mZihpbXhwcml2LT5jYWxpX3BoeTApOw0KPiA+ICAJ
cGh5X2V4aXQoaW14cHJpdi0+Y2FsaV9waHkwKTsNCj4gPg0KPiA+ICsJLyogUnhXYXRlck1hcmsg
c2V0dGluZyAqLw0KPiA+ICsJdmFsID0gcmVhZGwoaHByaXYtPm1taW8gKyBJTVg4UU1fU0FUQV9B
SENJX1ZFTkRfUFRDKTsNCj4gPiArCXZhbCAmPSB+SU1YOFFNX1NBVEFfQUhDSV9WRU5EX1BUQ19S
WFdNX01BU0s7DQo+ID4gKwl2YWwgfD0gSU1YOFFNX1NBVEFfQUhDSV9WRU5EX1BUQ19ORVdSWFdN
Ow0KPiA+ICsJd3JpdGVsKHZhbCwgaHByaXYtPm1taW8gKyBJTVg4UU1fU0FUQV9BSENJX1ZFTkRf
UFRDKTsNCj4gPiArDQo+ID4gIAlyZXR1cm4gMDsNCj4gPg0KPiA+ICBlcnJfc2F0YV9waHlfZXhp
dDoNCj4gDQo+IC0tDQo+IERhbWllbiBMZSBNb2FsDQo+IFdlc3Rlcm4gRGlnaXRhbCBSZXNlYXJj
aA0KDQo=

