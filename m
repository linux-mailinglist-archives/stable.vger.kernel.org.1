Return-Path: <stable+bounces-213069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI0kMWyugGmiAQMAu9opvQ
	(envelope-from <stable+bounces-213069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 15:02:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FAFCD124
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 15:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBF3A3016D38
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19D836A013;
	Mon,  2 Feb 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="DIvAry6Y"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14335EDC9;
	Mon,  2 Feb 2026 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040936; cv=fail; b=NUO3Uwe0JQPmJaesgJ77g+8Ws59aqxrJwSB8Thi3yNoS1RITmjrPGZh3RvynPwgF+YTgc5GFDDhdKWS/5mD5qkxMxDhUEqY3cihyw0rpziK+4jVdJkxnVI+x2nMAdql2ShT5wmUqMW+m0em0lcSaNXSDpl9ntvYQOYffkJabE1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040936; c=relaxed/simple;
	bh=uFTS/tG1kvfEBx9d1dGVWr0GWFN4Gd3XUnjV1NZETSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OzBfdX1+89BEQQmUnLWBFei7Izi0Pso0X3rVOcEyBJq8YFRPOBFtbMzjBSKUUXVX3VteIZD7HFduoCR0o/sYBhc4qsLXlac3p6C1f1fQFV+CXHAg2/tJP1RqBRtFOAQTj5/wHpF9rC2XwdRQ/PTOskUXRMUV4wuOB6N4iVGtyK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=DIvAry6Y; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgCoaW4GXn8IeeoCEs7hS/PwxM5yIE16WvmBzZNJK0+g+kgYbHMf50/mKQ4slW8URreATNeFjztNrCbtxA4h9y5RIcrJ1B99SBrxc70/yOioNpnjhAr+QeNXOmPf41FhjeZBrwLKnjOJxy34jhyUwCtjUjZo0AX6veo0cB68l2GjjZDHev/85LKwELmf1jZXgw5NZvehakPXBqqZZ2sZSMmDsRd7Ezh9iwGB6IdsLjaPs/PRVLHQ6lTS3BVhE2iojvNPQQBhB0OiRIdkuWAJJ+LMwfMrZOrooPCwP3lGCeIL039bLQN0EyBfp2Vg5tiGmhvUTyrcs/6nb38car2U1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGKWVHKmJeTHKDdK6FooVhqQ5lOyrUX5SxwzNYntQ00=;
 b=OFumGKijaO2Ir6Q0uYnre+i1o1tNodktI6TxnzeHrjjNEeINh4bjmyavJarCQ6LrzshO9teU6aBF7vQOM24YqyGIFWIf91q0SuhEsZHevHa35mDtPW0x9wWhw231xKZPAR4Ll9fHP95ERdKDMxiAglYGXwIBY6pN3f2SkkososQT2aWI2ZQgHsiyJ/RJnUk7DZ01QkKskreYeERCPwjq4e7G1D3/Bg15IyPcqZJOsfHvU7lHY7t6FJt3RpCN6oiBgDciz/6f6noTNp8QTsURMC2Ve1ms5BODt4oR4jiraTjaJ08VzzyvX1KtEyEa33HdoaC8gYPjrVlLkqz388tlPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGKWVHKmJeTHKDdK6FooVhqQ5lOyrUX5SxwzNYntQ00=;
 b=DIvAry6YdTZy5DSg8gqiBT6pHzJgz9hYx55Rh+qPD/I2sW5U1twXDS8C+Xo+BgR7MlaPL3c5h+HiZAADkljx3eHAANZaRAvXBZsSkZvHejKlQvzsQOKvXQQySha8ctrFJR4pR2plhJxmtWZgR0Q2o08kYIsS52hVaZ22KRRZIqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB11598.eurprd04.prod.outlook.com (2603:10a6:10:60f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:02:10 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:02:10 +0000
Message-ID: <567d6404-2a71-43ad-8ba7-5053fe1576bd@cherry.de>
Date: Mon, 2 Feb 2026 15:02:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: fix Ethernet PHY not found on
 PX30 Cobra
To: Andrew Lunn <andrew@lunn.ch>, Quentin Schulz <foss+kernel@0leil.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260202-px30-eth-phy-v1-0-ef365be64922@cherry.de>
 <20260202-px30-eth-phy-v1-1-ef365be64922@cherry.de>
 <33d3bdd5-0fed-41f6-8b8c-9690e7665346@lunn.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <33d3bdd5-0fed-41f6-8b8c-9690e7665346@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB11598:EE_
X-MS-Office365-Filtering-Correlation-Id: 10398916-5ae5-4b3a-8647-08de6263a85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3BvNnhzSXBuZm5PYmlQWGxoU3ZSaW9qS0x6bVZMRnBiUjVvN2VoRElZUWlr?=
 =?utf-8?B?STk3SlhKbmEzb2QxVkRWNi9aT3NWOXo3YjM5SUVocUNmbHVUL21BU1lIQ3FO?=
 =?utf-8?B?N0grbEc5RHV1eUxGUnhtK3hnUFpRd01FYmJBSkFad0RMbHdmSHFwbWVJT25a?=
 =?utf-8?B?OFZ3Rk4vc2NPRTlHajNHR1dySXJHTlZXOWxNTDRNZjNEMExXL1N1djBtclhJ?=
 =?utf-8?B?enVCcjREdXU4ajkxMjBndXFUTklSUXRyZVllR09ra3pWSWF4N1o5aVluTW1s?=
 =?utf-8?B?VHpQQXNCNWYvT3dPUlQ1UzJFRlRtNy9FL2s1aFM2dG1qMXR5TjVhZmZ6a0lL?=
 =?utf-8?B?ZjVuUXRzRE1nV2lVN2g5RkxFYlVyekU3WWxaVTFvbmhZR0N5UVJ4M2xSNHpY?=
 =?utf-8?B?K3FWam5tZFNEdlZmaG90cEFYQ0VXc2g3K043MVRhbzNRK04xaWJEOEl0akRv?=
 =?utf-8?B?NGZ5dGN1TWpCVHdCSXY1RW5EbmtOY2dnTVdSZTFaQ3lKNSsyaVV2cTUwMkhN?=
 =?utf-8?B?SHhndWZFL1dVdEVML3pXbzlSTlVmUlBHMDVPZE5mS0U1dExVUW5uaFJLZGtn?=
 =?utf-8?B?VFF0eFVQVUVNbGcxQzh3U3M1RHByUkMra0tOOGVaVEF3K25ZWHN2WkpSTjBR?=
 =?utf-8?B?cU9NWnNXZHJ1MDJpbUZLUVVPTk03UGowQ05CMjZIWjQ5SS9tMFI3SFRsZEh0?=
 =?utf-8?B?clhZOGUxK3UvRit4Vm0xTnRhQmdRd3E2OXBPOXlVTGF2YlNpL3hDbnhSVHdj?=
 =?utf-8?B?aXpqQkJlQ2xXY0NwR3dFaGZNcitXVkh5T21IWEw0TjVjVmNWQWtCcm0wbDd6?=
 =?utf-8?B?RGV2TnU0SzQrTzNORGxiT201aElZZGdGQ3QvUmpwNkxZNVNKVExkbi8wc1dX?=
 =?utf-8?B?dWRBeEJOaHJxRkRab3FINlkwQVJSTkl5ZEI3YWFvaDloTmNMVTdnTzBqRUwz?=
 =?utf-8?B?RHB6WVU3OFJVRDJJRFk0MVQ0KzNGQUkxSlJsQWc1U1FOcnZhS0J4TUx4RG43?=
 =?utf-8?B?U3pIMTZJOTE5L0s3V3pydVpoQkJMQ2JpeTRwdmdROEUvOUVZYkwyRjl3eFBV?=
 =?utf-8?B?Nkg5RXpWMUVGTmxoMHNidzRXVmRKUlhkMXlCNjJjRk5EcUs0UjNpV0ZqMWli?=
 =?utf-8?B?QlFXOURybFVCNDJKNSs2SnlWUXFxRTY0THJlTkhPREV1Z3A0c0R4YlF2ek4y?=
 =?utf-8?B?cXRIbG1KOFozbDB1cTFrZmNuSm5mWjVOVTFLVCsrUUVhOGViR2RLYUlFQlFY?=
 =?utf-8?B?UUdJTEVJSC9hVHVIRUl4R0R1MzdyR0dPd09oYnorNzhLelM3ZEF2Zmp4c3R0?=
 =?utf-8?B?cnN4OWk4SGZ5UDVYUW56RUhtVmRUdDJiOHdRMzdmMmhzYnNJREJhTDJxN2JU?=
 =?utf-8?B?L1A1b1hCMXlBTGE2cjlneHJDa3h4L25LbVFpVGFtNTNyeGpoWEpQVzhZSVg1?=
 =?utf-8?B?Rk12QW1oSlphZUJUdHN3QUJMc1QvTTBKU2g4MUJyNWg4MEdZeDNwRHl1Skk5?=
 =?utf-8?B?UjNDeFR4NlR4SVpyVG1JWjArTWpnYlZaRm9vN05pc1pmRzZMb1ZTUmMwMU1p?=
 =?utf-8?B?dUJwTjZFOWlkVlEwcUkvQ2lnTTE3cklCcTQ0NlZORjFjTUpEUm54N3RKSVhF?=
 =?utf-8?B?R1ZNNFJGRzhKWGdBRFhITk00RXd4Yit3L1F5NzNDbnppUmUwbkI1d1lLZEJI?=
 =?utf-8?B?NlIvcWNjSWZhak1BeU5kYkV5a0VVZXg3dkgvUkxJOGp5akQvNW9EaWVMeDhT?=
 =?utf-8?B?ZndqMHNCN1lDTGhtZXlwTmJyNFNDWTJQdldKNCttc3dPMkw4RmxMbkZtZkU5?=
 =?utf-8?B?ZWtiZlBGeWpJNzZkOEFxNjltR2lvMk9qTFpEYjVXd3krOU1mVmRvZ3dXeExY?=
 =?utf-8?B?UUtuS0dkRUxiVVhGYU1oTnRUTlkyc3Mwb0pLdjRGamZ0UVBLRnlsMVk2bFF0?=
 =?utf-8?B?NHJoamQ2Qk5HaVFKRkhoeExZamdVOXphcFd3clB1cjh6L0kzWEtiQUVVVm82?=
 =?utf-8?B?ZVlRbkpSZm8yT2E4OFdQYWVtZWxyem41L1gxdFIxNTBSb0lPMjU1b3FNV21J?=
 =?utf-8?B?WFoxZnVhV3IzU2VmeGU5ekRROHc0NzFBQlo1dVk1blY4NHhXQlBRQU5HNW0z?=
 =?utf-8?Q?E6is=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1VpNWJ2bGROaHZhQ1JKN3FqRVB4aFI5eDI4Zk5BN1hIdjdTdWJqUnNtT1FU?=
 =?utf-8?B?b2krektHK0prT1RpK3VWY2VZcFoySGw5aGpKTFFZRW1Wb256dzBQZ1JYS0Vk?=
 =?utf-8?B?VGVKTHlZSHg0bDFGOXM0UEMvQmE3cUdEZUxZazRrbThEUFZPazBvTUZaazM4?=
 =?utf-8?B?UW55OGl3R0VkbGVpbWMxY1lSN2trQjhzbkNoL1VtbGc1YmlXeUVzbUJ3Umht?=
 =?utf-8?B?bW01V2NGcVlBQWgrb21UbHNWaGxKaTZDNDFVT2xVaUdhRXAwSkc3U1BqMmNP?=
 =?utf-8?B?dWkyTDJmdE5DNmkyS25hTVhEYk1rNXRXZm1DOEMySWpnYyt1VlFBN2ZneWNo?=
 =?utf-8?B?TlU4SW1SQlBWdFJqVW9ueTZ1NzdQT1UweHpuYVNsWEU2MTgyd3BpSzZKNmJL?=
 =?utf-8?B?NStDTUVZYVNtS1BKOTFSbW1id3l5ei81YWZZODNKUUZIZ0hPb09WRU12RW1v?=
 =?utf-8?B?LzMvUzFoY1Vtd1AxcklQV2VMcWR6VkdRY21XVUhSazhuaGV3dGpjL1lLT2Nt?=
 =?utf-8?B?RlJmMGk0L3ZMVUo0WVh0NTNUTlROTkEvbGFvOVRBUzJ0ODJ6RTlQSTZBQnJ0?=
 =?utf-8?B?cURBWXN5NkxDeFNKS2ROK25EWEFRcFptV2YrTFpRdWVrazB5WHVvRElSblZP?=
 =?utf-8?B?bmxuVElQdU55VkIyZXRLNkdKZit1VlBVbkU5RmJCSmlhQ0NkOXNZRjBROFI4?=
 =?utf-8?B?QXRyZ1VJL2NvL1dMTEZiL05aNU81b3NrTXlDMXlMRzNRV3NZaUdSVUtBamM1?=
 =?utf-8?B?Rmh2TG1FSGtITUFiWm1GdGpXT0F3OVF6VnBTRENUNDVaN1lsY3I4V2NhNGU0?=
 =?utf-8?B?RVd5M2h5MGJwaTEzbk8veVNub0pCYVJuSUN3ZTZCU0lUOVZ3dEZmYm8xanFD?=
 =?utf-8?B?WEV4OTlPdk5MM20yRnA4MGxUYmE0dlNUOC9SeFJEM0RhMTVLSERvT0ZZbHlx?=
 =?utf-8?B?OEp2NXNWUUlHbG5aNWhwYzdZSk9HTVRRSTBqQ2dtdW41a0ZtZTlCMklXb3hV?=
 =?utf-8?B?Ny9BYjhrTE14cCtKSisxN05qNk1tTGRYRllSbmozVFVsNVcwb05tdFdhSlc2?=
 =?utf-8?B?dStGbDJGUEFaTzlZdzlGYldmRDZ5MElINmZ3Z0tVU1R3MlZaYUNUd2VoU2lu?=
 =?utf-8?B?RUtubFZmSmpVL2NDejN5aHRQenUzd2xvc0NSamQ2TnlpdkppdHFyMTJhUVAx?=
 =?utf-8?B?ZEpjVWpxZkcxQVpEVThreEpETGpDRWdyR2VMZ2xPM0M4cXFWMnc4dVNqbmd2?=
 =?utf-8?B?MURMOWlxZGNxRW1HeGVZeENwMWk5VGNGeHRzSUFuQUhhRC85R2E3K1QwdWNH?=
 =?utf-8?B?NFZvb0RZN1JDdmhTSkZwV0VKZmlxczlSMkhEblpLaE01Yy9JVlYrbWhvcjFY?=
 =?utf-8?B?VUgzWjNod2dNMWxva3IzUnF3RGNIVTBHaUdqbVVYUVVqUXJwdUxwZHgyemRY?=
 =?utf-8?B?b3d6OWxXbnFEOGxYbXZnRFd2WUs2VnNEN094Tk9pM3RIV1Y1RWh4eHpRRklG?=
 =?utf-8?B?ZnVnYWJacU5GRkpDRUc3aGJRaDVoWFpQSlR4Q2ZyMEZrdm5VeGx4cUhNNEFx?=
 =?utf-8?B?RnZvcForR3Z3TXhUM2NEWGhkY1o5d3FMKzVqdmxnSUVaRDlCWDR1S2FVYS9L?=
 =?utf-8?B?bWhIeVcrOU0zUFQyRXVvbHlYSTZZSHIrSWVwQ0s5U3N1cHV2WHF2U282YndL?=
 =?utf-8?B?QXc5K1RGUUd1WmJ1cWhEaFVzRUhzbldmQ0NENjdzUTEwaW05OXVaNnVJb1Ir?=
 =?utf-8?B?ZkE2enoyRkE4MVgyemVXNHp0Z080YzNUMWdmS3l0dm0xUTlYbDJQVmM5bWVL?=
 =?utf-8?B?d3JMUkZZMk5ZQXZvVDQ2TnpOUS9SQXEwZFBlM2RMVzIwcTFxNDlnYlZURVdm?=
 =?utf-8?B?RTUxZHZOWDN5eTRNSnR2Rkp5V1MrZDc0WVdsVHlDUHVKV25LZWd1bWNFeVNH?=
 =?utf-8?B?cm1pYjEyc1hiNVdCSGtNeG9uVmFlT0M5QlFZN2RSdlpEcVBncWVCN2ZKK2Zq?=
 =?utf-8?B?dkQxTGh1UlJPRVdFSlVqY29sNDFXUlJBUlFHOE10YkJTdk9VL0Q5YytXVzEx?=
 =?utf-8?B?ekEwanNTOU1sNmNsNmhUcHJXUG1SVC80NjhmM2xvNjN2eXZMcVN1UXJSSHZD?=
 =?utf-8?B?aEEwOC9XK1RBeW5lcXQybnlnaWhhazl6NDVlM092OUlnNThNeE15QWFqWVdj?=
 =?utf-8?B?QjBRelRpdkdyNkVlYTNQeTdITzdlbTMxWjhiTm05RU1MNXZPV2hId1U3YTBw?=
 =?utf-8?B?cWJzMkZaV3VKNTR4MDdkSW9RTW5Xb2hmSDl5cmFxK0VCcmVCbGx3eDN3RzhS?=
 =?utf-8?B?bVd5KzFRWTNSOXJSV1NFYWVSbG85NlovZ3NlNVBXTHVrVEJYS0RQZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 10398916-5ae5-4b3a-8647-08de6263a85f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:02:10.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOZZO8IkpV4YGiqzGa0wjxU/gMln9hKhrVid7vz+Mdwq02kE6P0rDpWnB3n5NXygFv6VYjkXltA/CjbinBhgc33Lple1fa9Szgaeauaa/2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11598
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cherry.de,quarantine];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-213069-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cherry.de:email,cherry.de:dkim,cherry.de:mid]
X-Rspamd-Queue-Id: 02FAFCD124
X-Rspamd-Action: no action

Hi Andrew,

On 2/2/26 2:52 PM, Andrew Lunn wrote:
> On Mon, Feb 02, 2026 at 11:27:25AM +0100, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> When not passing the PHY ID with an ethernet-phy-idX.Y compatible
>> property, the MDIO bus will attempt to auto-detect the PHY by reading
>> its registers and then probing the appropriate driver. For this to work,
>> the PHY needs to be in a working state.
>>
>> Unfortunately, the net subsystem doesn't control the PHY reset GPIO when
>> attempting to auto-detect the PHY. This means the PHY needs to be in a
>> working state when entering the Linux kernel. This historically has been
>> the case for this device, but only because the bootloader was taking
>> care of initializing the Ethernet controller even when not using it.
>> We're attempting to support the removal of the network stack in the
>> bootloader, which means the Linux kernel will be entered with the PHY
>> still in reset and now Ethernet doesn't work anymore.
>>
>> The devices in the field only ever had a TI DP83825, so let's simply
>> bypass the auto-detection mechanism entirely by passing the appropriate
>> PHY IDs via the compatible.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> What is the justification for stable?
> 

Bootloader without network stack = no network in Linux.

Cheers,
Quentin

