Return-Path: <stable+bounces-40397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3198AD34F
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 19:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12001F21FB0
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE5153BCF;
	Mon, 22 Apr 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvBMnpIh"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527B15218D
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807091; cv=fail; b=bSsno6+s4Izd7xQJm2vVY8YJS1WTN+0N0haRFSp3p44WMhOBDMxsAo+fdhkpbULWFxojEjz0IFg0jmWRZocrQymNAokqU/h2XtpsYqAtJyvHkv6ZMw2fnQpn9loLaNcvhIsRM/moAlaAdf/YT2oHbFdzUMbRJ5XnibSmMiCz6h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807091; c=relaxed/simple;
	bh=vKdnRtCTYRm7f2iOhkUIj1sxDSHhfjWfl/1V526Ip5o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fcucLpI9R8+SdB8SZroFBA93mqvGRT4BBFxpFQ8aLq22oP8X9Yxqvur0/Dxyg+pkKxJAIjANILefAa4nWarxFfn2kyKMmvhCm1d2nnxrTTzZVDbdm+eMsmTWoZwk8Ec8cT6fydFf6oTTSe+dDfMzT9+abBRgZbrbGr6oz6sc+cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nvBMnpIh; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKBMXofEqq0PntvQ888vSupxS50iML569NH3rBugdHRNnwBN4lTZZyqZlN+zlplMZZAwf82e7EGcjbiklw1Yvh+OVsCfL1ueOpnquO01h5rBz2nChN6gqOFjW9kqtdaEfizbXkeWwOMGrAwxhn/ePz3rYbgcv33aFMRHeVJLLQm4D0vbiWYrSmFRhc4c/Elanmy6UxK0xH+J0Cu3FJTuzjUGuLfUXdIMKSo3KviMQJaQBkJf1XRmdCHuuDRq9nW9Ig93Uc0Rqs06zO9P+DSH6gv6OwgoxUD+CnGreUU87PLfJNf2CD6e+13xihtHGaDalVmdsHDUGzLYdYPxvxTc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKdnRtCTYRm7f2iOhkUIj1sxDSHhfjWfl/1V526Ip5o=;
 b=gvPXkmcZdd9tNYTrEb/LximbmEszMknP7JuRURHVQ+BNVOqFYfg4BGb0Q1ApIUfhL/mIJznTuS16evh4gf4K8x7eX9uJSrsS1mfhUEwnPIlFHVRGPAbIqaYVZJS3oUuEyRWttCUna9mS9rQ2PG3TwSWkuhZswO8RtzZWGoaKDF55cN4iMavILpioKTuJDSe3UVEifnWtOsb4vWXn1OSdPKvpJdJsGlJKyqAKEo0kTPDU5oLcFi4GTIqs04BmLVinVmmg6d5SPfJ2TJYc82+Xwqp+T0GwB5/vBbsoMcRqbpEjMeW+JAjYU8Ouw473uzvl1vvWd/BT+0eDZOQQU8keCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKdnRtCTYRm7f2iOhkUIj1sxDSHhfjWfl/1V526Ip5o=;
 b=nvBMnpIhkIkgVH+1dQ44FhRvA0/lOleZXdLmohsRns1Sj9+FKgBliAeVJ5SEMyfHfumDayZUcNSeUD696KhTBY5FohGFNzsQJeKXKTuHWtENKowRehJsrkpN108eXfkhzgwNppwR53Rm7YBdz8FffKOI08WHdLZBwMI6nmaJy0RB5TKJFzO07h8fVok97B1y9PTJgxaHNsWPfYaFCAoYAIlEJ5avrAQxuToF5vP9GCzsWahullWDqtjad5AGTyKuQM8IzcMwvQWOSrD1xsBDQuFMNVIgLBsNVv2hjn5i7XY6EEMoFMdZfjLLxOAL4ecG965gYesFoq8qeq/t9mIsjA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 17:31:26 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 17:31:25 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shay Drori <shayd@nvidia.com>, "Anatoli.Chechelnickiy@m.interpipe.biz"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, Saeed Mahameed <saeedm@nvidia.com>,
	"oxana@cloudflare.com" <oxana@cloudflare.com>, "leon@kernel.org"
	<leon@kernel.org>
Subject: mlx5 driver fails to load in kernel 6.6.28
Thread-Topic: mlx5 driver fails to load in kernel 6.6.28
Thread-Index: AQHalNrmU668JcLN/EScjnKgVk7F/g==
Date: Mon, 22 Apr 2024 17:31:25 +0000
Message-ID: <ac75aa6b0f2485826bb530ffc7a78016881c7012.camel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SJ2PR12MB8953:EE_
x-ms-office365-filtering-correlation-id: 2d370310-6ca4-450c-0e21-08dc62f20959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3ZpVk0xemVnckIrTE50TTVEZzZrUzg2cFB1Sk8rOFBOYlM5RUxOcVRNb2pH?=
 =?utf-8?B?blhxdWk0aW9HTGw1MjMyT0tGeG1FSHpFWEUyYlhWdklMdVVoNHBLSHV5K3BF?=
 =?utf-8?B?bzBGVFd4ZDdyVCt0akI1R0FjUmxyNExaUWNsQ3VzMnF0Q2Z2ZmN4WWR1Y0dr?=
 =?utf-8?B?UTFVZXI1eFpwNVlMU2Zxc3pMWXNGY0NlUGlyRi9RZW45UHNldDhsZG1MdU5D?=
 =?utf-8?B?UnNhK3YvQk9QcUFUZU82UXRHWVFPcUpHY2JKSk8zS25PdTQrcHBKT3ZHWnFj?=
 =?utf-8?B?dzVLenVGV1FmQTlpekRRZmhpNWNUMXRONStXTXBNaTd6YlFmSTZrZTAvMDY2?=
 =?utf-8?B?MEM0MDhud1dWOVZiWDhJOG12b2drczZHVHVmSUl2amFoeDB5ZFRiSWcwTjha?=
 =?utf-8?B?cXJwMDJKZEM1cWlGYWFoOUVJVnJVT2ZOQzNMZEpKbmhvQ1p6UmRTVTlaaDlo?=
 =?utf-8?B?OE0vcHJsNk0xcFhaTUZ1UTRhejBpL2NwSjhQQWxhWUFiT2NXNEExZkdaSWdZ?=
 =?utf-8?B?ZGsvNlN3NmwxRGdmNk1VUEdaajVvMDdHMVlwd3VydVpGckt0Tkd2SFFoc3JM?=
 =?utf-8?B?WGprL0xsZmRRbFNvMFpnelRseTB3SFNJL2R1cjZOWnZrdTBZbVZPV2xJejFl?=
 =?utf-8?B?cjVIVWNNVzdUZHZockh4Rml2SEg4UjNSRGFFY3FieEkvOUVFamdqdGhBS1JB?=
 =?utf-8?B?TFRVd1NJWUpESnJCVlhudEdWYkxoSWlwSmt5N1poeUozTWdsclNjZkhaZ0pN?=
 =?utf-8?B?R0pDNnhxSXo5cHlCdk0wYnZVQ3BaNUxHVlRGcThkeUlmNmZodW5xb092L2c1?=
 =?utf-8?B?QXoyY013WkFuQVZ5OFQvcUhUOUFFUEo3LzkwSEhrSVE5SVhZei9LSEtWRS90?=
 =?utf-8?B?KzFvZDl5TVVzRVY4MEVuZ1RVenVmbjhJQzkzQ21jajBjOUc2eG5xcG5sRGpn?=
 =?utf-8?B?Vk9hY1Zub0RzWVRTY1hqK0h6S0RFY1ZhVWZzWnh4WGc3Y1dBYVhMQm0vaWFk?=
 =?utf-8?B?aEVDcHhySFA1TExiNXpmcFhRaUNwTUpJdGI1TDJOdU9PaFpTMnhEdUdHcFpJ?=
 =?utf-8?B?MWMvVnBFemdGYVhXb0QyNklkL0RIS21UMmdqZm56ckJDSjFwb3llR0loaHR3?=
 =?utf-8?B?eWhDMUFKajViRFhJbUJaOVVwb1k0aGtsa0JGb0prSUVia0Q5U2tVclJQYXZn?=
 =?utf-8?B?eDNKMmc5d2ZiUVZEWWQrNXFEYllkRDFoUFBrNzNTbzdKNWo5VjJaNDNRZU01?=
 =?utf-8?B?bStNMzJNZVRTVGI1b0g5bmVaNjJiSXBxcjFySnFadVNsM01xeFZLMENsaFNP?=
 =?utf-8?B?TmNWZjJSYzZFbnV4bFFsMDh1S3IvWlRvNXBlT1RzSG5ERS9NYmhhQlp5SHlK?=
 =?utf-8?B?TzZpdUFKbmI1ZWpsaHhrbUJXVTF0Q0JWNWtjMVYybnUzZ3R6NkxERW9ESzhR?=
 =?utf-8?B?aG93T0RqcUpaWko1RVdiSjA0U2JhTGVvYVpXS3NlbFNCZmpTRkdlZFgvOFZR?=
 =?utf-8?B?dHVqU2ZUcjhlaHhEVUVyUW5qczlJM2F3Z0NPdnl0NUhkcDJ6RklaTkJaREg3?=
 =?utf-8?B?WUpMazhLeVF5NFBrRElENnB5cExsNmNXbWdvL2JlNy9PZ2t2M2dnMUtZUTFo?=
 =?utf-8?B?RGIzRytIRHpWdnZzUHJUY3cxOW5Vck5yN2NZNW9FWkpCQ1kvTDZFSytPUzVM?=
 =?utf-8?B?YXNYbXVjdWVhcm9ucDNCanRtLzliNk11V0JqQmhjVkpCQW9uUTBONWY3TDZ3?=
 =?utf-8?B?NGk1UG42NWIycitvUXpzc05hYVN3bEE2cnp5bHoxV3laVDg3TnNBK0ZJaHV5?=
 =?utf-8?B?ZjFVeFZ0TVFWZHF3V29JUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1AyL3NhSTlkbld6K3dSQW5WKzZyZ2tsQVI5WTVubEx2QTVtdWVUeTdNUHM1?=
 =?utf-8?B?WWpSdGllaW1QK3BkVEVxRjNQNlBRZ3d4YjlEdWhFbFVTaEZoeVBJMGY5SG94?=
 =?utf-8?B?RU4veXFJWUtPQ3huRDdrbW03a1JaZXYrMTV5UERFRmJ6MGV0TVFzazBRZUc3?=
 =?utf-8?B?VjFzZ1dwWWF5ZjJGT3ljNSs2d2puYTR2dFJ2b1JFM3c5UWRQMWxLdWZLUXFp?=
 =?utf-8?B?WXlDS1c2YVJqbGRtMysrWkJRdUF4a29JZTJyUHR6Uk0yT0hYYkh6RWl1N2dp?=
 =?utf-8?B?UjdwUVNiYzZ4enJTR0wrVFowMkZ5ZDQ0Wm5WT21TWmthZTQzcjZES01YaS9n?=
 =?utf-8?B?QkZ1UjZOS1Y0VmFPK3pMc043QUJHU3VZdEdKRTBvK1dOSHE1T3dPTWgvRSsy?=
 =?utf-8?B?Qm1KcHFIWDZkMEZLTzZqWHlKdmRQd0VHSXVlUjZkVXFudHg0K2JxTldNV0ZL?=
 =?utf-8?B?bis5Y3ViRERFdzlIbFJmekREcXhKUmRPb1VIOXJEaGZQR0xhU0gyaUVLOFEw?=
 =?utf-8?B?Mmdic0NxbjN1RnhpSzFQYnJFUEt0U1BMazhxSVI3Y0JjWjRYdFBmRnF5cDl5?=
 =?utf-8?B?eU56azlFSjN4cUl4YzcvbkVIc0NBOHpNOWZ0cU1rR05vTndXV1dXUDlvWWVG?=
 =?utf-8?B?cUx6N3JNMk9BL2djZ3RtNzJLWFdvVVlsZzdYN3pJMnJ4OHd6OGZXclllWVUr?=
 =?utf-8?B?UnZjeGRpeGdOdU14aGkxSEcwTFVIck1zRnVETlp6b0RoRVZ0Y1ExRXVUOTE1?=
 =?utf-8?B?eUZTRC9KSjIyQWpQb3pKaG9hNGZib2t1VmFWTE9iRFhBOEp6QU41VDZDcExa?=
 =?utf-8?B?OTRUeTByWHFvelFobWQxVmxzbGxlTU9XNVByV2xjL0FHWFVvZk5IQ0JKOXgw?=
 =?utf-8?B?dTFSZkZNb1hkS0xDeWhDUExYcW55T1kvckV4S0ZvaXI3RmpkMllkdCtuRXpu?=
 =?utf-8?B?WDdSYVRrNmJ3OHBoSWcvVDliVzh0WmNabnEwRDNDaHVDcDBqSUtDYUFQVEE2?=
 =?utf-8?B?OFE4a01yN1pmUjY5ci9hQTZWN2t3U2RwdTU1ckxtR1c2ZVh3SFNFTGJrWlhW?=
 =?utf-8?B?RXhjcjdkOG40dUphUzFKa3lSWWVOQXpidGtxRlEwR20xMGJYajhmZXo2dWVN?=
 =?utf-8?B?RXBBTDhCc1ZzMFh2YjN3YTdYc1M5NnVCcmlkeUZhWDdlcUxwcEhhV1ZoWkkx?=
 =?utf-8?B?WjRSQ1RwS3FRTkpUeEdxQmNSaFBZSW0yOWFUOW5hNW56bVdWNHIvdS9iLzN2?=
 =?utf-8?B?SkVyTW5wcXV1R2tKa2wxNUJHakVFK1BMR2ZSUHd4anRJYUNOV1RtWE5zdXpN?=
 =?utf-8?B?aVg3U3NuaUo4WGVJVUV3dndSclZFWjc4VmVTVkhpNzVsZTVqZnFIbDJUSkF4?=
 =?utf-8?B?aG51R08yQXBVSnFBWUxWYllNbjRtOXZNejhXQ0lTVktwakdETUgzNzgzbXUy?=
 =?utf-8?B?RjhxUXppdXg2Nmt1MUZ0a09Uck5KRXAwSGljSVJBWkJpY1Z0aWxHVklJV2ZO?=
 =?utf-8?B?RW1vWWtFNEtxZHlzR2lENUtTN1RWUUowUTJmbjFwVHRqK2QwSmlYTCtRY1pM?=
 =?utf-8?B?LzIrQUwwWXhkeHVFSDN0UmpGUmNLTGNUczhteERsUEEyYjA2Y3E5VmtDanc2?=
 =?utf-8?B?VjRVZFpPSEcxZnJkRGQyMXlrcU5zR3pFMzZIWTFPazQxOGFLanNwcDhma1lB?=
 =?utf-8?B?RVFZNUpQOVM1K3NOcVROMERoWTNWT3JZcVB5S3l5TGJyNy9kNXI4MTNmTHo4?=
 =?utf-8?B?TEJWVzYzV2I1WC9CbGdRdVB5bzdHUk9JVXpsVVhVa1hLTllCbjNyRFN3dHZE?=
 =?utf-8?B?K3M3Y3l4d3habFZTWUErRmgvbVpLZUZoUHVzVU01eDZ3SkZsQzVmYUk5a1dO?=
 =?utf-8?B?MHdhTGdlOVluUitoTkF1WnMzblM0dHRFaUs5VVlDWWRoR3hNTEFlSnVKZm9M?=
 =?utf-8?B?VnAxaUpqVjBVOVZLR3RlclV0V3BRN3VPN1BzbGc4RVI2elJYVTVlZkFTNVZB?=
 =?utf-8?B?ZjUwVERKT1NlOXhqMVNJYS9iWWY4OGdqVnc0TkRqUUJOSlgvZGJoSDlCZ0xw?=
 =?utf-8?B?eXNHeEYvdFhUWlBGTEZVMVhVaGx3OW53elE4eXZIakRRY09yM2RZaVVFaHhO?=
 =?utf-8?B?LzRJbUcwdTFtYndpSWY3TUdsV095VlhZRWJMbUl5Y2dDeTBpL1ROcGZmNEFw?=
 =?utf-8?Q?MC2iqRLf5LPyS9GfXPZbM9AZrcvOWpXWPGPtd2hOyiHK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B86E76817A4BD49B559F6B93AC43AF5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d370310-6ca4-450c-0e21-08dc62f20959
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 17:31:25.7686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ullQzJahaX2ubrmfrIiu3hfb/09wl+auoSh+lQ8lA1BjNOPkPfWoBoZLtHDzEagJllVOD0elMzI6pqcsQjVHoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

SGksDQoNCiAgQmFzZWQgb24gdGhlIGlzc3VlIHJlcG9ydGVkIGhlcmUgWzBdLCBjb21taXQgMDU1
M2U3NTNlYTllICgibmV0L21seDU6IEUtDQpzd2l0Y2gsIHN0b3JlIGVzd2l0Y2ggcG9pbnRlciBi
ZWZvcmUgcmVnaXN0ZXJpbmcgZGV2bGlua19wYXJhbSIpIGlzIG1pc3NpbmcgZnJvbQ0Ka2VybmVs
IDYuNi54IGR1ZSB0byBhIG1pc3NpbmcgdGFnLiBDb3VsZCB5b3UgcGxlYXNlIGluY2x1ZGUgaXQg
aW4gNi42LnggYW5kDQo2LjgueD8NCg0KWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRl
di8yMDI0MDQyMjE3MDQyOC4zMjU3Ni0xLW94YW5hQGNsb3VkZmxhcmUuY29tLw0KDQpUaGFua3Ms
DQpEcmFnb3MNCg==

