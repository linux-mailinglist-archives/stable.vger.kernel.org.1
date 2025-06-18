Return-Path: <stable+bounces-154629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B61ADE368
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 08:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FFB189B6E9
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD441E9919;
	Wed, 18 Jun 2025 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="b7GrYv9G"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011037.outbound.protection.outlook.com [52.103.68.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849401E0E14
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226949; cv=fail; b=e/Cjw1RpjyIF8UB7LNdGp5TidQFSlq9qsMwntDxF2bNuklkxJLauExRjcdkQnJ3uzuEzvWa7uJ/7Q3dLJEKrdMaEpPsON25ooRTSgO6KeNXphOtanMOs0sI4zlgNcENHn6L44ZqSN0lUWD23t0xqWphpJ8WhCa/UFh35CJ3ojX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226949; c=relaxed/simple;
	bh=bAxNQWF1joMky7Tsp8l1Cs2wE9kbmfBUTV2ixEn07DM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CVq756X5wj+U/ZdH6OA/0FH0gCb+aE+EddQmBMjqQNcy0+7LKCJ+avh+S6UGlhyNP74p5yaKAwg4eII0ibI+QlgnxupXLHJG3KTDv/iohf1XbTdb/mXFq2mvroT9r0TpqA4yLeCiAUKx3XzT5K+W3xIn8ks2fd9x12SV1Uannls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=b7GrYv9G; arc=fail smtp.client-ip=52.103.68.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlrIshqY3u0cTbZj02Yw4jNlB3EveBDqM8ZOUf8DK3aonko4w3qduh0hcdrCyFhmzmK38HmUpx9txJTkgbUQ7lOFGBMj5G2m7yN6Wwa/nP5duiYHMROua0lAr0FfxN8r0tLXh97xSys3joC/b6RxdSJouckcVC/ZVwT8iQ0eZy26HEu/LDb2JjdrkBVnFVw/BzPpwileXXCqbuU/a8C6Dd4OmL2cuacmMaI4YLT7IYGbxLuYJZpTYiNoStrEBAuKhpkhH1Ec2KS46TCWokdm4/q/wtgrqSriG74xcOYC2l6+vyM6P8LsPSVkCPdSwwICAZbHlXPWPimViz9DRj2QDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s42FJxguDdH4EFz4zwMXM4/GpLOLuMxmFfwTkn85zVc=;
 b=wGd+roADJc8H3t62dSpPv4Tiyi/fN9uRzImOOJMOLA4u9rXd8jDiqnHR2igg+dZ3uL9AiKVMqt0/Ii/m2E7G2qZheWBE550GiNgsDUnqqbwP38qWaILTgRy9oy4DDqJv7ODYuBeP0JsVwFhszF7zTVlqowcTQRgDvzmQAWgMbYc0FA5KPtbDlOHcGy+KSnY03IGtWlEbMgRr0c8x/cocaVJmYtC/TmbJGmQnXjwD+H3Y0Kwt1xt9awF9q1mOQc8GtgXOodDt/KKUE8lwoIQNCdqAB8LTei/um7MDwSc0467gkl14UjsR1b0pq8kkhVDg2m0xx+9vdpOPC97UauLA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s42FJxguDdH4EFz4zwMXM4/GpLOLuMxmFfwTkn85zVc=;
 b=b7GrYv9GwQbcJHMbcO0WROVPnwojdEoNaislWz5NzXByzOPhphlZQX5qbo96xVnK8gwEH0Oz76/BeJN80rSD3ohx0lXr0359kl/zRZZu8dfTvvjGYk3CaxLJayDutEjpX2qa98cVD/XlnD6hTpyT8y+MHOuYNqD88n1NwapGQ04TASB6YUhPj/2R3EltFuQ0ewZf0bGZezJOHUBQp4P6juZ1srBAq7kheX2Ib5qvy0FHRKcd+xAi4exx5Lt/P7aOpriCHNgc1VBmTdc5uSnuLwahGSP5xw+/TT/hTlTeKY4jZjxixOCNJkTF7D5GBkd9EUwq0QqESoo+GnuFunflOw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB11154.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 18 Jun
 2025 06:09:03 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 06:09:03 +0000
Message-ID:
 <PN3PR01MB9597971B8EF7CDF0395B76FDB872A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 18 Jun 2025 11:38:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/appletbdrm: Make appletbdrm depend on X86
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>, stable@vger.kernel.org
References: <PN3PR01MB95974E38ACEDEB167BAA2BFBB872A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025061824-catcall-gestate-2279@gregkh>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <2025061824-catcall-gestate-2279@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <21cb172b-d462-4cb8-b5b7-91f1e311265f@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB11154:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b004444-43c5-4e5d-cb8e-08ddae2e9fdf
X-MS-Exchange-SLBlob-MailProps:
	P1EfU6pZOd/AyUUNw5T5n68c5veh4xoSuD5T2PBv8XvmEeVVAzzaGF6P5wlDlvrY+2m7RYeVzkRr54yX0TR0WSIado2ZEw9pVVuzZGItKFdXKl01ct0AEzRHaNjHwqdYhWTKNTPRMiyBz3jbAeefZ4HfwULxR6DVlZ+itYMJzJ2jTemCWxD13ywaQ1A5Uo7evVTmd/cGemuiPxW/sxQPDWm/kxWVYsX76BUAsMYk4/mB0luASPj9/ZagKAH/iz0dkUefds/ND3ECx2vWGsuJKTeQdr4UhUwPyUIOoCwGvbwLDwiqLOGrtu57ohinFVaINYdTD/8dFSCaJ1cHvz1c23zxP4feDJa5Bh5yJxfKl1TUnYqsIVtoaFBmcmeoZKpYaqw1FnpVrUAVXVeMkM5dw25S5MIdFylUggiqD+EUInvAM1iYQfnihrUTefQn8srdYId3uJstxMLCC4RJeGe9wtLeHtD/jxGdnEhWQUQwoYxLXfEzjTCG1nxjsIzEnotwJG+4Ar5/jTm8YaqFNaC+nmPtcsr86QswHN2OuLLRjUw2NLl+VAZFuEroHOMkXdmphQzE+4GIzgKtNr6kO7JSMl/X/guPFXiVvu/FQoa/WkX7Ns5XsVBoLOkdi4CqvpEnFtZhhC+nm1MX0FZZtFMued9balkE7RmeUhhbs2NMbQOWe3C2KOvxpiGKXogrYw9uVyBi1Aft3K7cBG2G03tJ0is9EGHNPjVriPQQRW22rXv0BiXjuiPhXnETBMJpS/qO2vHsyzHb6G+gy8IRwbcO0T7GRXi6BSNRhiw7jgpi1kVe0XuY69wr+A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|5072599009|8060799009|15080799009|6090799003|461199028|3412199025|4302099013|40105399003|440099028|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2t5b3EwUVRhenlSTzlzWTJRdW1qakg1T1o2c0x6c3JxSVdjTVdXMzd6YnhG?=
 =?utf-8?B?cFYvSWxITVZPNHhiN1BieHg5RHNqT1l4UUR3ZytHcW1HTzBFMG5FQW1NVEZJ?=
 =?utf-8?B?ZG8xMHQ2a3dYd0RxZ3hSUzRkTThxZGVqTU5kNE1QTm13ZnRFaGd2Wm5GeU5u?=
 =?utf-8?B?UUd1U0tiQ25aRFdwK1J5R0FZNGdvcGF3QXhYY0xaZ2t5Q3ZXWlRxRVh0bE9i?=
 =?utf-8?B?a2ZEZU5nRlhsTWkycEhndm54L1UxTXlWKy9WbWZIeTFwdE9QTlJRSGEraWk2?=
 =?utf-8?B?NDBreGg3V3NNWERmQnVoZHBQdi82YXBLMEpDY2hhUTVqazhFdmJUdDd3Vmxo?=
 =?utf-8?B?dzdFWlVPd25RVmRlandYa2QvdkdTdnJiWjUzZGhMU3BNdXF2bDRIR0pSYUM0?=
 =?utf-8?B?VEYybEFQdGFzdmp1NFBsSms2SkJ5ZkVHOFo5YllwYmJYQmYyOHRYVTgvSFpn?=
 =?utf-8?B?NENiajFwQ3FjeUpoSkFSYWNvNmdaK3NNMXZwcHdQSkhnRTZpZlZheHZQdXlP?=
 =?utf-8?B?dXNNaTJ2VjkwQ2RhK3dJRHN1emFIU0RTcDY1Tm5hbFFoSGxFRGJqZTNQRVJ5?=
 =?utf-8?B?eExtV1pLdHU4RjQwMUxsdVNOTjFCOW5FU1g1UVdzdGl1eE1yOVZqeFAwR3d3?=
 =?utf-8?B?VXhRRzlrVHRjZGRiTTBldGlNK0QrUnJUWWZTS1NPbXBUOFQ4b3kyUUdXZkcw?=
 =?utf-8?B?MmZIT1d5TnRZcWk2M2RDd2xaUTU1REN4NU9kV2xRK2hTYlZPcHl6elpTUGNE?=
 =?utf-8?B?YkNUM1Y4ekszK0JRRU01cTZxWUMwNFpXNXAyTFNOSEk1NHdiREVBK0h5dHNh?=
 =?utf-8?B?UmZjSXpoZGdHSktLTWF0SUtHUStGMmVBVUMzSjdIWWhZYis5bHNhT3VMRnU4?=
 =?utf-8?B?NW84Wk5YdXJhWWQ0RkMwaWlUdi82VVR0blgzUEtHSmRPN2RjblkrSUs0WFhM?=
 =?utf-8?B?dEVlaktuQzE3RGdlRHNWcDdtamVuVlZqdWczbGV0a2l5bk1penhWeEYvRW1s?=
 =?utf-8?B?a2t5eW5Md1pnK3RlZnlFb3UzNGQvT2pnR09MelhzL01ja0lnb1paWmtNbSsr?=
 =?utf-8?B?a3VwaUZPbTNhYkh0bEIzTzBnUDVCejNYTDJJMjc3bFhWRE9kdGYzQlY4V1Jm?=
 =?utf-8?B?Ly8vbGM2alVzYm9yOWNZVHQxb1Q1KzNJeGFvOEpRaXdUbUc3SHRpRlp6L0Zp?=
 =?utf-8?B?ODBtMWhML1RPdzdSSkZibkNOWk56aFViNittRjVYUVJjVjR2YmJtNER0YTJK?=
 =?utf-8?B?dHVpWGJ2WGNHR1djMVo0YmJwUHAxcEhIMGlXamhhaXJRMnRSMWxJcSt2TXZt?=
 =?utf-8?B?ODVNbk9aazA5a09KUEk2dWNuN1Z6Z1BRZmg4Y0VNS0tzdzI5WXdmZjc0a0pu?=
 =?utf-8?B?UDFMaHFVMHBQTVpxa0o2b3lja202RW9FU0pJcnhFVDhkNzhNN20yL1daYXl0?=
 =?utf-8?B?bEtySWFwUk5ibkp1MVFwRVZxWmJRQVhkUVlYODJVUEl3MFRlNC9zbldub3VU?=
 =?utf-8?B?ZjhWalhQbTNOZmk4a1hnUFZqNkM4OGl3YzZUc3lmai9zbnJiM1Zhb1NJdXZ4?=
 =?utf-8?B?OFU2NGpobWFCTlFyZnRFbktPV0tSNWpqRkRVZ2Z5SThBZks5UnNpNk8xeHV4?=
 =?utf-8?B?cG4wOVRzWG9hUTY5NURiaGUrSDNIcEN3a1FQQ1lyWkZaOXVKalVlUmxxWVcr?=
 =?utf-8?B?a2orcnBjaHB2T3UyM25vT1N4SjJsUmRrV2tab0ZqN3FMVFk0RCtPMm5ucStH?=
 =?utf-8?Q?tbakknJEqEMBH6jtFo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2hrbDROZHVPemFuOFhob0xrY1NWcDN4MnRoWXpPdWJxblZzTWx5MFN6VThl?=
 =?utf-8?B?NjlvNUJjUFVLSW9vVDlpSTlCTTMrbE92MnZJVGxEd3dOdVRiTEJ6NE1aVDVx?=
 =?utf-8?B?cVF4czczbGkrOVkrMU0wNStUaDNTMGZlSHFzNGtWMXNTaHhlcGkzWVJuYytm?=
 =?utf-8?B?SFhnc0NGODJ0MW0rQmVXdXBKdzFieXMzQmN2bjZJSzlFNkxraEl6YVBiYzJh?=
 =?utf-8?B?N0ZYOThhUWpFa0VwZ04xREdXdVlWN3NKUmo3NHI3TUhMR2d3RGxoOFNtcFhT?=
 =?utf-8?B?RDB5ZmE2VmhmcDQwUm8rcDdXcGc0WENMN2xpRjhXOFQ1VnhDOXlGdjczbUgw?=
 =?utf-8?B?RE5tQ2ZZVTRPaGhyR2liaytMMll6YjltVVdvYUpQYWhDeDRseDRFdzAxODJT?=
 =?utf-8?B?TGhhaW9TMzE1RXEzTjlVcG4vcVcyMWtDRVRienJ1R1lpWWVMN2RmTlVqYWZ0?=
 =?utf-8?B?eEdLTHJ1MWZERVFOTnd6azV4YVF6UUdRdTkxS0ZmY0Y1V3NVMEMvUnZqMDZZ?=
 =?utf-8?B?Q0lOeTF6c05taXdlK3hPUDk5enZpcld6THNjTzJPUGYxMkhGbXpxd3E2SC9p?=
 =?utf-8?B?bVM5ODFHQWlHUk1HbFBIcjY5UFJyU1Q1RFlpeFZsK0NaaTNtQUpIaEpiSFBq?=
 =?utf-8?B?OW9MNDI3Rld4MWRGcjBKQ3cwRlNicWVWZTgrQjBqU3VKSnE0cWdYblJqTWN6?=
 =?utf-8?B?Z04zUmU1ZDhXdFZacWRndjdOQWxBc0pQc3VFM2RmVndWYVVldGlwZVFjMmNr?=
 =?utf-8?B?WkRTdTBVRkpUMUxHbVdjeTNRMGpzZHFwdnVLalRxTENOV1FYT1JISWQ2RGdu?=
 =?utf-8?B?RGJ0c0RaeXN1bTdvcSswcFpPeFU3djBOVVlxTGtHbzlkbXZBeUxyYUVUYk9R?=
 =?utf-8?B?UXlrSXpCQmVNRDU4U1AxaDh2cjhLOGkyWHYvWVdLL25Nc2RuVGt4akNyRVI4?=
 =?utf-8?B?bXZIUkhEQ3NxTkJGQjlIY05rWGlOenUrQmpoM1hIN01UWG52K2JYWTIrdktS?=
 =?utf-8?B?S2xJYmxvbVdlMDhNejRQUnorRXV3eDBoZEhYVXpGWTBPaTlzUWVJTWJWSGVK?=
 =?utf-8?B?akZFMjZMc0N3UU5tcEl5c0dvbmJXakw3NUtXL3M1VU1XRHplWEJXYXhOY3o1?=
 =?utf-8?B?dkFVL3BvdStJSDVsUmdLdGpEYWdVaVRMVGhQOW1ETEJwQjRNQUp5dmlwL002?=
 =?utf-8?B?cEIrRUN4R2xUd3dvbDZsNDRuazZiQXRMLzFMajV5a1RvK3hocHIzRFJ0cHRo?=
 =?utf-8?B?anFlUURITTkwTGN2YWwvSkZzYnNiWkh6ZVZmTWFhWEo4aGNYRk1RRmtnL1ZU?=
 =?utf-8?B?MHBPalFKS0tJNThNeHUvVW9WMk1TeTlYYnRDYzRQNzhxblovR3VMS0RkUDVS?=
 =?utf-8?B?OXBZUjdOK0ZFa0dsS3BESVkzS2tZNVk1VjRUNHpLVnY0eUpOK2VXVFZKOUQ5?=
 =?utf-8?B?ajYyNEo0NXJmZ1cvTjg2S25mMzh0dTZQblZpSFJwcCtaN202eC9PVWc1dXJU?=
 =?utf-8?B?ZXY0a1Bnayt3RXFPSk5mWUJLVHBQSWxOR3dkcS9ZUUZPL2xVV0JSVERpTVFD?=
 =?utf-8?B?S1NQbnloYS8zeE9xcElCMC9taGlXaGhGSG1OYXltWDNXdGZ6alNvVHNvRitu?=
 =?utf-8?Q?2DtcU0vjn7jGtjYflRu/9OPQAV1RzXzquIB8Fg28omBY=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b004444-43c5-4e5d-cb8e-08ddae2e9fdf
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 06:09:03.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB11154



On 18-06-2025 11:35 am, Greg Kroah-Hartman wrote:
> On Wed, Jun 18, 2025 at 11:27:36AM +0530, Aditya Garg wrote:
>> commit de5fbbe1531f645c8b56098be8d1faf31e46f7f0 upstream
>>
>> The appletbdrm driver is exclusively for Touch Bars on x86 Intel Macs.
>> The M1 Macs have a separate driver. So, lets avoid compiling it for
>> other architectures.
>>
>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> Link: https://lore.kernel.org/r/PN3PR01MB95970778982F28E4A3751392B8B72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
>> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> ---
>> Sending this since https://lore.kernel.org/stable/20250617152509.019353397@linuxfoundation.org/
>> was also backported to 6.15
> 
> What stable tree(s) is this for?

Just 6.15

