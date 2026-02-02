Return-Path: <stable+bounces-213083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MKHCPDSgGlBBwMAu9opvQ
	(envelope-from <stable+bounces-213083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:38:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D07DDCF0DE
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E1F13047BF2
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9037E30C;
	Mon,  2 Feb 2026 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="d8nEfFFs"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F02BD013;
	Mon,  2 Feb 2026 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049930; cv=fail; b=qh5t+X+U1tWFgRhZq17ek4DHBhr78MfAAAtNC21u6XTa7hJuyFpoKgd1RC6xm1hiqDK3FxLw0Mg8DqgYNLcfpMivV/F4wwXqIGJPf1ByHTiHmj5i6u6iBiX5UP5eWUx0LNkSqb3X9DhmN4UWt3DkHMSwHriNHw7idwksQ/h3Sjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049930; c=relaxed/simple;
	bh=e6zER4gfR6/Z2EJlZiBm9QiCASOmypjS1ot3IdGQAUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WjRFeqH2Woer8v4GQ3328XxnYBC04O7EbO8wCuAv/OGIuseg7r3yDbLeOhG7ZvxsAT2+5zHRR1e0MpRUtrxsoq1tP/BkGVmsvvd4TH7JWjHoBMEdnE4WY3D+QkSd/XKMsZEi4ftCpyGSyc0Mcfl9Kc8MDxwPpxheGOai3NfZULM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=d8nEfFFs; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZl4DRbfeGIrSWGmpxyENJiEZ0KzmRUojtQ2ocDC5rAc2odmGmWJa4E9lBzFI8AQQihONK+Ou6TYN7icOLX3Cm2HagNbQM+7cH8t+/J6k3wMsoMg2ZtLQwrxQBdwcVsw/M6i96ovHYfkr/weiJj5wgw3JIB/7vDE/Vu3DdQ4joCPBs/9JCB4Sw8JMCd099HmfOmwJnaNFD5d2S25T4xwBauDvfq1ZAmLvNc+VUJWvLn02l3Qsrk1dZ/FYE9M3wBQWer3k3Pb8m553LfZDWV4ma1LnTqZqLTq7FxdBDl9WaC32jEeugSatMkKsf6Czm6TtDqz0rrNBJYzv2Cv6eQhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKErp/jPqQ/LTAD5fzT/Xc+TBOyhMK0LpM0Qa+ZxWIE=;
 b=zQ9NPFQ0h5d57zTqywCNJ+7G9CEnA1KvtERW8zFiIqs7VVk4jibYhiXWtMTpIlVH/epKZAJYPDBc2S/dRhju0e37ZvqVtnobjGnDzFkGtGtPkWPY9BFuzBA5d4FrUIDX+yqEjfkkpAnQxfPgx7FBrcvGiqk5VkJBaIVNx26CWZbB9kWve9irfSQE74ONHL6mvp5j6nB+ILFP4E/qBrU5vPW6g5fNiV00nrLWTk1Ftd5pjJecECrhff79YDBS26I73tk2O3G4gTZBoF9X+b+CARFOsU65sAWb+b5WfOQhwyMSCdreqWW937ILH5betXnbkjAtvcHPgFgEWai621E39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKErp/jPqQ/LTAD5fzT/Xc+TBOyhMK0LpM0Qa+ZxWIE=;
 b=d8nEfFFsnTFKssg3XGyQfNt/RdMOCdj2GNuiKh4e0JKZ1REJmAN7cG5NlTTRS9ONnwrfsV+D+8luz+MtHp7Cbq3k9+JOGA1eB+Ut4RzJ3aiUvjI27ZaiBMOODaRQ1sruJimHOHvXwUkbStml2t0KU8hhDDGrWn2GH7f81LiQvR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB11937.eurprd04.prod.outlook.com (2603:10a6:800:307::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:32:00 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:32:00 +0000
Message-ID: <b2f12140-ee3d-45bc-864e-d51317c83b8d@cherry.de>
Date: Mon, 2 Feb 2026 17:31:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: fix Ethernet PHY not found on
 PX30 Cobra
To: Andrew Lunn <andrew@lunn.ch>
Cc: Quentin Schulz <foss+kernel@0leil.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260202-px30-eth-phy-v1-0-ef365be64922@cherry.de>
 <20260202-px30-eth-phy-v1-1-ef365be64922@cherry.de>
 <33d3bdd5-0fed-41f6-8b8c-9690e7665346@lunn.ch>
 <567d6404-2a71-43ad-8ba7-5053fe1576bd@cherry.de>
 <38452338-6e65-47ad-a696-b90c02ac42f0@lunn.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <38452338-6e65-47ad-a696-b90c02ac42f0@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB11937:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbd1873-98b2-408e-d963-08de627896ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDd0SXlCTUZmTEZZcnlsUmJIOUU0STRZenlqNHJMVEQ2NEFuMjJLbGNvWnl1?=
 =?utf-8?B?SXBUazFwMDI0TlZQZ0dRU2p4Z2FBWUlndnJmRFdGZHVUU3h4VlpoRUpPMnlm?=
 =?utf-8?B?ZEgwUlRPejRJUmlnbWczWWtOUk1OZGMraS9kL25qVXF5Q0pLa0ZMeXZiWm1x?=
 =?utf-8?B?bzF3QWNDMmRURmpya2d4VmVpcnVsU29YUVJiTm1SZFdsQXNPWTRrK0FycWMx?=
 =?utf-8?B?ZHNSelZnZXIxVVVFUlpyT0FuV1FncGQxTzVuQzhRTlJ3ZjA2dXNhOGtaaFNV?=
 =?utf-8?B?eGx4emNJNmN0MVc5aFZHM09VQnB4Z3g0SmNYQ2hyNDA5dmdvVFZSUnFlb0Q3?=
 =?utf-8?B?TEllTCtDaTlzWk9DZDRrNUhQN2J4TmVGOWlva3d4aUhvbE5GdDRMWmI1blBh?=
 =?utf-8?B?N2xIZlprbnpXVUV0VkZSLzBTamZ6RFB4MkRvSEFHMzcyUXdVdTJyQUFYNzhJ?=
 =?utf-8?B?YzM2bFlIL3ZJdS9jZkhOSTd0V3E5U1BXRlIzU1pUUHhhUWE2MTlkWGZid3E1?=
 =?utf-8?B?UlRzb1R2TmJwbmsvSlBETGtUL1FDRzBxaGZUM1BrNTJrcnZRNEVFL3EvZFZy?=
 =?utf-8?B?elNSRk5RY3I3dmRRc1pzVHFqUzR2SDFyemx4cndXME9yRkxHZnpvNENHZEVP?=
 =?utf-8?B?Smo4RTExWVdDenFYdFJvb2xFYWYyekliYXhKK3VWRVFiOVcxa2pNRFBrd3I4?=
 =?utf-8?B?RVY0bEdtK1k1ek93T05ZQUlEYjEvTE1YODJ3aDBGZ3VmNWVKMXRWNnFiQzU1?=
 =?utf-8?B?RGMyL3dMVU9NckNoeXFpWTUxVlE3Wk1XdjNVdGozU0VoNDdmclZlM1FpNHR0?=
 =?utf-8?B?VDg3VWNENTNqdG5abXZxMHc2OHk5MVpIL2VaTk56NlVoektmaC9Dbi9teVRU?=
 =?utf-8?B?dDFueHV0a3VUSFZCanRtUTNRU2RDaXY2dEd0WUJFUGtSV2pldUJydzM1ZnFn?=
 =?utf-8?B?bnk0VU5aZmNLNmpkc0FubVdyWXV5aVhLNWIxa0RocnBqR3JOcWNuY0x2Nmha?=
 =?utf-8?B?dFFVNmZvbFlLZ2EzZU96VWhLeEZYQ09LOExPYVVEUUVQMGZlK21HdG9Ic015?=
 =?utf-8?B?aTVlZFQ2MHgrN2pvdmY4RU1zVFU0ZE1HQVBhbWsxamI0NFg2VGc5MEZ2ckZw?=
 =?utf-8?B?bDM5cnFVWGJYaDNKYXd5eThHakJiZVozSXgyWDYvMUhFR2duUVNGMzFOVS9F?=
 =?utf-8?B?YXgrVG9BZ1JJNGJ1UmpkYzQ2L2VsZTE2QStlQ21lZWhHbkRTdThFK3Y3MkR6?=
 =?utf-8?B?TFZJUTZQc3FYRVdJWkloZDZadEhzYXV4SVlUS0lhQUtvRCtFQUZRMFVicWVa?=
 =?utf-8?B?RWhkK1FvUUpIWmFpRGtrWVlXZ3oveFJJRU9FY1hZU0JYNWpwdElSOHZ4bFFz?=
 =?utf-8?B?Q2ZQenFUSXpNMHcrUlpzM1NsVWRTdytBSnlRbkh4MkRxVTVJOVE5bDZhK0kv?=
 =?utf-8?B?eGV1dnRSOUJtQjQ5U3E3ZzhFSytCQnA3NzcyajZlVUR6M2JaQmNlWlFMTzUr?=
 =?utf-8?B?UGhtVDFXVTk3Tk9MOXZsMWVPUzJvMWpCcFNac2RpQVpMTnM1M2RPL0luM0tH?=
 =?utf-8?B?RHFxZWR2NTd0REZMcWFkL0ZUSzk5RldtQ2V5eWZSTmdoR2k1UElTaVVIRzUz?=
 =?utf-8?B?K3hLcFJTV3k4TUZzS2dkK0tDVlMySEJaamM3ZERISVJEL0NTQnlJWnAxekJZ?=
 =?utf-8?B?SVRhS3FrekNwd2JPa1dLeTh1UFc2QUFkU3F2NTZJbUR2OUFrc0t6MysrcXZX?=
 =?utf-8?B?eHFQcXJQQVRNS01kZy91V3Q0bHlCV1U5NlEyWGNaUXMzRkVqTGtlU0xXZHFM?=
 =?utf-8?B?emlyLzB4ek5iVUtkM2NvR2QzT0ppcSt3Z1Uvd1JYUUtSSmlvMHNmNTZpL0Nm?=
 =?utf-8?B?c0NIZWp2NUZ0bXdHWGZOdGNXb0hHWUgrcjlJdkNwNkhCczVKOVVVRVByZ1ph?=
 =?utf-8?B?c2UxT2RQdEpva3R1dHAzbGJHenV4bjF5bzJSWDJPcUNsNGJ3UGhNbzZkTnQ3?=
 =?utf-8?B?OFBNaENSVDBuSVpMVjBRQmxZRCtFNnZMekNsczQ1andKL1EzNEpGazN6cjBu?=
 =?utf-8?B?clBETzVGT2thcDRxWkI2OG1yWlJWR3d6NWdZNlJvN0tnc1RuSUlOaldUUXcw?=
 =?utf-8?Q?oDaU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V05SVVhVSG9lbFpZS21ISUFPcUY4RUk4SXdWcmEvTExrVytvRlhOYkpVZngy?=
 =?utf-8?B?bGhFME80eks3N1VuYlVYQitjSXl6Vm5vNDVoaE91a0dEK2Z3bVFqSXJqSEZu?=
 =?utf-8?B?OTkwYTRnUHY2VXU1KzdKdkt4ZG9ST09nUDRzUkxBSTlFVHdiME1aOGd4bmVw?=
 =?utf-8?B?TWFjRW9BL3REb1AwN3RwRy9DMGVwTWhYc2JpTVdRZDRQZnVXOE1UUy9mYm5P?=
 =?utf-8?B?eWFZd2pTUzFjMHNQU0FxTVQ5Y2pWQ1YxMjllald5bi9YaHExMDlCd0pmWTRh?=
 =?utf-8?B?dEJJcjEyZXR5VkM3YjlhVkdSUURFNXBRU2xNeHZYdmszSHNIQm1WQitZTTd3?=
 =?utf-8?B?MDE1VHN2aGI2MVNNOC9SWS8zYjVkWGd2WFIrRklVMGsvTEFZQzIyQldBYjk4?=
 =?utf-8?B?ZmU1Y2dqWnNBRWU5dEdlZnpKOS9hY2UvVUJXc0hjL1BLQVVVVnE3MjlzVllS?=
 =?utf-8?B?cm5LUC9UVWxFZVllUldwTVlscTQrNERHN1R5UHVBaG1ZZzNsK1hDV3RoQnA3?=
 =?utf-8?B?UjhrZGtwdmhJN0VPOTBWOVM1WnFDYzVvbXVia0JOSWlmUEVyMmZ3MTJ5SnVm?=
 =?utf-8?B?S3g5elczUkVJVEpPZ3dGakRFMW4zeWZxSU5sMGlsVWdVMTJyNk9ELzN5WktY?=
 =?utf-8?B?b0QrbGQxeVlNeXR4US9FRW9PenM1NnFRRmZBZWtRZHdxR1ZCZ0VVc3ZJUlUx?=
 =?utf-8?B?YUlsWnB4YzhPaGNkOXhWcmx4WGUySkhLazY0ODI1VXlTS0lHVGVmV01VOFAr?=
 =?utf-8?B?cFlEcUMwTkVRdzJwMFE2NmYrdTMyTFBiYUlkM3dLcjlVTy8wQXhlOHhudnRx?=
 =?utf-8?B?K040eTQrRWdzSmFybnJ3NkU4ZVNaWFNUMWZVM1ZiMVZqVGNtL0RPM2xNNnV2?=
 =?utf-8?B?UlloczBocTYxZzRNREtCcmlqM0dVYzFDWk01d01UTGpLR2pYK3o1WEZWaTFX?=
 =?utf-8?B?NjlJcVZleTAyWlc4VjlTTHdldEtzZklUNkNuc1VoMnZZK1pSSldMbGZ3dmtr?=
 =?utf-8?B?WWd1SUVDNzVzQXdCdXQ2SVRrOG1ZQytuaFRVdnBQUWxtZGNFdzVhT05LditR?=
 =?utf-8?B?anhaVDdBSytnK2Y0eE5rZGNSK2JGMXdUV2FOREFBNzVuL3RpNVNuTmZGejBQ?=
 =?utf-8?B?U3dHQ3hUMnJCaE1zRjBqTFpwUjZVUUtxVHVxUFJFZXBhdll1ci9mNkRZSVoz?=
 =?utf-8?B?Z1E4ZFlONkoxQWUrZXpiN2VXYmplUE5IcFM1M1phOWt2cGJrM3FBYXcwT09F?=
 =?utf-8?B?dlN1Y1U3SWZsUVM4WHlxSmlBUEVDVFJoMFRCKzFhT2ozbVlOc2F4RVZFcDg2?=
 =?utf-8?B?SmFNNjc2c29SL3JhTnBNZnpneTE3L1NUaUZFbUhtSVBzd292N0kzOW9uZXlI?=
 =?utf-8?B?clhKMVZ4bnZnamJ5cUtmUmlHaGpPTkE1dDRQN010S0NLcnhwYSswSnVTRS9M?=
 =?utf-8?B?R3FsVTdyQ1V3TmsxeVZ6bFlsRlREM0hycmNXOVlzTzdITW1PSkFQcXNDVUI4?=
 =?utf-8?B?TkQvYk9pYUlKNUZFeVpGWWc0YkdMUGllM3FGNUVTMXUvRmJuVkdjS1lqK1Iv?=
 =?utf-8?B?K2NjU3REMjJhTThrWGFDa001TEUxQUIydGs2b3RkR2wva0c0WmJyYWNOZGRn?=
 =?utf-8?B?T3oyMVIxVGxLTFRDY1kxcFZFM2NkbTZGQzFCclAzOEhaYWhtanlKRDFpNnYw?=
 =?utf-8?B?QzVoblh4WkwzaU0vbkFHZEdhY3ZQdm0wd0NpT1FEVkg1dmVFRm5KRUF6T2x4?=
 =?utf-8?B?ZDhUYXZHWWh1bGVKNC9jd2d1RjFqMFdNQmlDemZFV0tJbm8ySUxaS2JZL1Zw?=
 =?utf-8?B?VWtJa0t3aXJTc3RSdWczcEQwYVorQzR4NHkyZExNSmc5V09OOXUzTmMyZ1BD?=
 =?utf-8?B?VWtIeEwvNm1HOEtlMHJEdUk5dTFJcGxDZEVYU00zYWdHSXJCZlgzK0RQNHRS?=
 =?utf-8?B?Z2NTbVRTeFFBOTEyYTYvNkdSallUdHBZUExHd1RycFA2NVhiZHNqL0dtVmJM?=
 =?utf-8?B?TlI3OUVMT1JESDJZRldOaGF4NjJ6MzNReUwyQy9oc3pjMEd6OVk5NTRsaXl0?=
 =?utf-8?B?blJsanMzSXRVZDI2QlZ1U01sTEY3YXdtWllka0FwTGtMdDZGM3dEeXJ2TUVK?=
 =?utf-8?B?ZkJNUFhlOVhKdloxc2YyS05wUnlKY3huamxrVnVGYjlFbDczakJ5eWJYUUhv?=
 =?utf-8?B?aVEySVNOelIwdUN2MXZhV003bzZ3Wkg5cmFJRE1TbkR5cU1iRG1nVE9CQ0NV?=
 =?utf-8?B?OTUxS3k1OXJtc1p6dDAydW45OGdqQUpHUFJmS0pRb2traTJ1RWFXcExseHAz?=
 =?utf-8?B?eWpzTUlFb3hYdVo5TXhFampXQ1FuMFlkbFJNbElIR3ZFUG5iR2FYQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbd1873-98b2-408e-d963-08de627896ba
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:31:59.8680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAnISWFIAa/N5nM1ZjratNGRbxFJEngrpjAF1Y9tCl6zoGovfPSkbiUYMjcSXj9PBmb8DuhdZDSYY5KtA5IyxVYal72bJMto0XpfZ5CspZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11937
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cherry.de,quarantine];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-213083-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quentin.schulz@cherry.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[cherry.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,kernel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D07DDCF0DE
X-Rspamd-Action: no action

On 2/2/26 3:55 PM, Andrew Lunn wrote:
> On Mon, Feb 02, 2026 at 03:02:08PM +0100, Quentin Schulz wrote:
>> Hi Andrew,
>>
>> On 2/2/26 2:52 PM, Andrew Lunn wrote:
>>> On Mon, Feb 02, 2026 at 11:27:25AM +0100, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> When not passing the PHY ID with an ethernet-phy-idX.Y compatible
>>>> property, the MDIO bus will attempt to auto-detect the PHY by reading
>>>> its registers and then probing the appropriate driver. For this to work,
>>>> the PHY needs to be in a working state.
>>>>
>>>> Unfortunately, the net subsystem doesn't control the PHY reset GPIO when
>>>> attempting to auto-detect the PHY. This means the PHY needs to be in a
>>>> working state when entering the Linux kernel. This historically has been
>>>> the case for this device, but only because the bootloader was taking
>>>> care of initializing the Ethernet controller even when not using it.
>>>> We're attempting to support the removal of the network stack in the
>>>> bootloader, which means the Linux kernel will be entered with the PHY
>>>> still in reset and now Ethernet doesn't work anymore.
>>>>
>>>> The devices in the field only ever had a TI DP83825, so let's simply
>>>> bypass the auto-detection mechanism entirely by passing the appropriate
>>>> PHY IDs via the compatible.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> What is the justification for stable?
>>>
>>
>> Bootloader without network stack = no network in Linux.
> 
> I can see this multiple ways....
> 
> Changing the bootloader introduces a regression. Hence you cannot
> change the bootloader.
> 

Ringneck is a SoM (system-on-module), I don't control what the user 
wants to do with it. So they may never have the networking stack enabled 
in the first place (I provide a U-Boot defconfig to use with the devkit, 
but I don't control what they do with it; it's also supported upstream 
so if they want to use that, they can).

> I personally also don't like boot loaders with basic functionality
> missing. Why cripple the bootloader by removing the network stack?
> 

The answer is pretty simple here, no network stack, no bug to exploit 
there, smaller binary, faster boot. On finished products with secure 
boot, a crippled bootloader is fine (and desired). It does what it's 
supposed to do, nothing else. I also don't control what our clients will 
do with our SoM in their product (and I don't necessarily have feedback 
either).

> But i also don't like Linux being dependent on the bootloader. Because

That's my main concern and only reason for marking this a stable 
candidate. We shouldn't have to rely on the bootloader doing something.

> some vendors ship boards with crippled bootloaders and you need to
> replace the bootloader. And then hidden vendor initialization is not
> in the mainline version of the bootloader, and something breaks in
> Linux.  Making Linux more robust is generally ongoing development, not
> a bug fix.
> 
> However, it bootloader developers decide to break the contract between
> the bootloader and the kernel, regressions have been reported, then it
> would make sense to backport the fix to work around the bootloader
> breakage.
> 

This issue is not related to an API between the bootloader and kernel, 
so there's no explicit contract.

> I don't know the internal of uboot too well. Can you remove the IP
> stack, but leave the drivers? Get the driver to probe and setup the

There would be no reason for U-Boot to support having networking drivers 
compiled in when there's no network stack so I would even go as far as 
saying if that's the case, it's a bug. If I were to enable a MAC 
controller and Ethernet PHY drivers with menuconfig, I'd expect them to 
be working in U-Boot.

In any case, I'm not interested in doing that if that even is possible. 
Audit companies and certification authorities may look into what's 
compiled in and ask questions about those drivers or stacks. Not 
compiled in, don't need to argue about them (I have had to do this for 
every CVE in the kernel in the past, so it's not a theoretical).

> PHY, so you keep the agreed contract with Linux, but you also get the
> crippled bootloader you want.
> 

If I wanted to go this route, I can simply toggle the PHY reset GPIO in 
U-Boot and be done with it. I still cannot control whether our Ringneck 
users had the network stack enabled in their bootloader and cannot force 
them to patch it to either add the network stack or this PHY reset 
toggling. I want a clean solution if I can have one.

Cobra support was upstreamed with this issue, so I could see this as not 
being a candidate for stable but an improvement according to the 
standard you stated.

Ringneck on the other hand used to work without a network stack in 
U-Boot before 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e463625af7f92c4a9f097f7fb87f6baaad6e762a, 
so I think this is a regression (I don't control the bootloader of the 
final user, only the default one on our devkit but even then, I don't 
control what they flash on their setups).

Also just to be clear, Theobroma (theobroma-systems.com domain name for 
mails, "tsd," prefix in compatibles) was acquired by CHERRY (cherry.de 
domain name for mails) in 2021, we're the manufacturer, vendor and 
developer of the boards in this patch series. (Not sure if it helps, but 
I can imagine some confusion with my mail address and the original name 
of the device manufacturer).

> For the commit message, i would like to see a reasoned argument, based
> on
> 
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> why this should be in stable.
> 

Since you haven't answered on patch 2, I'm assuming that

"""
Note that this is only an issue since commit e463625af7f9 ("arm64: dts:
rockchip: move reset to dedicated eth-phy node on ringneck") as before
that commit the reset was done by the MAC controller before starting the
MDIO auto-detection mechanism, via the snps,reset-* properties.
"""

is a reasoned argument for making that patch a stable candidate.

I don't care too much about stable releases for Cobra as no third party 
is or will be involved in BSP development so I know for sure which 
version we're using and that it is appropriately patched (until we 
migrate to a newer kernel with this patch merged). Also, we're the only 
one able to change anything on that device due to secure boot so no need 
to care about hypothetical flashing. So Heiko, if you agree with Andrew 
here you can either drop the trailer when applying this patch or I can 
send a v2 dropping the Cc: stable trailer for the Cobra patch.

For what it's worth, I agree with what you've said Andrew. I sympathize 
with the dilemma.

Quentin

