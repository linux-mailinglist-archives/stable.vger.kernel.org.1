Return-Path: <stable+bounces-50303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A089058FA
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02B7283B34
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB94D18132D;
	Wed, 12 Jun 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VDxxaSYB"
X-Original-To: stable@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2068.outbound.protection.outlook.com [40.92.98.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3803181312;
	Wed, 12 Jun 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210488; cv=fail; b=sDEsFjhEeXhMRptwQnllI9N36x5zj0T7XHhwtlnHUXLbAzC8x9uIwmqVehfRKPVEQnK6BQqoII2Aev+PNJ5dYKJBk47uuP6Z9lK8/WGWY3QQUnZHirOCOuCgjWjcvdV3sDnCVqAo33ln3i6RkBuXgRwiKSsOJMi1ROCXA9P6JiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210488; c=relaxed/simple;
	bh=BaeVf/EjCxHnfKLq7TcP2l35WqpVvppjxzOjsHZRYQM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rH8wkT/LZ42UyiU26YGUWEKn+OuDS9ke1JspyJWN4cnZtrEmTn+O0g2euKi8rhrvw6kpzoBr2lDPByuwXQnLdpEWA1EZ9NRjyuptfML0KLsx26Af1OJ7yIwlZXhP9sc8Zu4EBlvef98YXWG92BDsy0ERtnf6nx/YQnMCIdLeww8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VDxxaSYB; arc=fail smtp.client-ip=40.92.98.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRoSI41CKOlO/Q/Cf0jJliWcBaCHTc33xcTZ3+LJ5QyhzoiDAgdrrjoWn7rkB6DfFak+uT5thCxDc6/y/SYf4Vga1lutU8z78onOWmmwZvTRGCLglJBceeiJDU0NnfeSmrTNJGqzKmXP8B6+F0xDxoBQFdzhqaaUnMfuQ9+xGm9aiF78WE2udBmK9cm6kOQYRxcuorWrIQqB50UfhiWUydMu4ipy+mvor6JaWNnNePoEeofB0TsnhujZ2iIfSKJvW94tvW3Q7cpo6O1hnWFm04D0J2e0md/QtEjMDTFrlr9VfVfF2H1zOty/DCeUR3+URa8qpzqOSUHt4iEqCvdUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaeVf/EjCxHnfKLq7TcP2l35WqpVvppjxzOjsHZRYQM=;
 b=muFNhmMfOG8jkC68qwasXNE86wme1dUJAZMAeaue7JlvaAjb5rngAQ3aV2aSMzvmAVpcwXfQQ4Vx2AvzZwBiSRGz5YC9jleQqg9hpLiTsKUOsL0Prj++KJWjUbEhXB43TwANBrR+5MI5JPz9CvwRzqBxGmoXeBJSG6ZQjs9TN/dgdM8OKB7tBPSs4B2axQ8dRfZRQuXFnVG/pFtO8MUuOu1YXUe35RDb95BsiwImqYQiFp3PO03UF6fH6ytVFH/QO7H1sXxie7Z/lc9e1ci2yuGxc7XheLWFQrTf8iq49XEzRPPC/XpQ5yNEgCQjr8jC+Vp966SGcR6ZkZr9NLo5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaeVf/EjCxHnfKLq7TcP2l35WqpVvppjxzOjsHZRYQM=;
 b=VDxxaSYBEPJ7YoYk/FZ/tF5coSq32kQ3McTKpuwnW5PltDHIv/Bko39pl+nStxGwa/C+c9pdwTTHxWt7z2Q08AaWaDkH1Z1ke8GP1hAthlRTfEO42DvHOkSwQFHpWPEWueJRHStX3f76wrvovmJ/5eSGu3yUICN0UF6XPz5YYH7X+Jaq5+fqsxHcvTETs/dp+BO7hT7VtJ2TKxnG5Ns3r67eF03EHPH6oncOVVOC7OS4MmJevOcqPYcCRpDHmf2lBnSI2+qgVRiIzeqwWc8OsXpkcRy92RRJ43outUnmayZW9wbDGjjPrSRKGqUWEv0vJSKtWWLATEL4lDZFSfN/+A==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB3076.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:303::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 16:41:22 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%5]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 16:41:22 +0000
Message-ID:
 <TY3P286MB2611CD8A6D480D1893BA833898C02@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Thu, 13 Jun 2024 00:41:17 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, kernel@esmil.dk, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, william.qiu@starfivetech.com,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: starfive: Set EMMC vqmmc maximum voltage
 to 3.3V on JH7110 boards
To: Conor Dooley <conor@kernel.org>
References: <TY3P286MB261189B5D946BDE69398EE3A98C02@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20240612-various-verbose-8c1a5db7d25a@spud>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20240612-various-verbose-8c1a5db7d25a@spud>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NY0hP6svSCZjyxbeRqrZ608F"
X-TMN: [C/F5PWKOuLXC2zdAJtoX/30jaiug8rnP+dZn/4JMlpI=]
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <5ded7345-3a47-42c2-bfc0-43977af81bed@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3076:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9b2b42-f44f-4181-a39e-08dc8afe7e45
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6092099006|461199022|3412199019|440099022|1710799020;
X-Microsoft-Antispam-Message-Info:
	EggV1i396Sye6ZfxULFzSbEB+McqUs5wLvB6SV2/tKWmDviGjECbR6QpDs+WNqyXJooVOMLICJUVo5ZXe/dNJVoZ0nBA+nWNy5xQP3yS7WEjfZFUgW6AH5TpPyXF0T8Evn0P9lnQ75nlXOlMujUxCO23PE7aAft7I2HcmrAgHIdUzKSkY4e8lJuwdVQvW3qC/brJHzTFYWj2hDOi+NKTc/20jgSn9JumCef2tEICx3WSPHw9KAJqP6OQsao8g5ZBEmr6rJiYv1l+Lp4OGJXQTu8KzPI647C9saOOlBKHrpq9V9F1chsyVqHy8NJMrGaJakPyaJV1l39QJI2pUXDgpKMEXog8qdQl/8rh0EPOiCsD1l1VFZ8uMlwazP6Ve82zC/n9zhldTZvAB9m1KAeI9DOcQ8c1yzJ4Tu8PZV0jtkMOeVkocpk09FVRJiSr7LY/OAvkAIMzqWKbqW1oNf/Z7QcIE36pdhuaJOx9pZXxmm/owVm6TbzMZwIow75vii1dYqxn2Ti+/U3AJVEWEgU75t7jWuDHpgg2fufyGS/IE6XKOrciQ66oJVNRDlFkC8gKgZm/T3IV8nO8UhzeAImVdMWYWN2+vHyuIZZFzp66bxdLzjDMpIKC7csjGxQRS7sMBy6V1aL6PLaOYSy+DQRCuQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE9QZ2JXWmNoUTlqQ1lKVDR2ODc2R0hLWVBsWWo5NkJleHJPUnJwWEc0NlIy?=
 =?utf-8?B?NlFVdnFYaWcrUGsyNmtLdEJTS1VlWVI4ak9NSUowc0I3SThCSWlRa216cllS?=
 =?utf-8?B?ZEFndVU0ZlFSV1NrZDFHT2ZHdnBscnNYRStWMFZka2x6cklnemVRUXJLOCsy?=
 =?utf-8?B?TTM1SkY1a1h5ZHl0QW96VVpOS1d4UFZmcnpMU0Y1U1FQM2pRMDZoOUN0aWNZ?=
 =?utf-8?B?bWZ2MlhKdkVmMWhHYkFsN01rU2tEdnFKK1Zvc0Rkd0dYMDRxb0NMenZCdmsy?=
 =?utf-8?B?K3Fqd3lTZFJzUnB3Yit2cjMrWEFmUWFKVUdiWUlFUHdKcFdxTk96MmQvUnEw?=
 =?utf-8?B?Sy95enlIeVk5cDdiU3Vld00vc0tYdllKLzl5NlZjd3BCL3ptcUcxRGZrSHVO?=
 =?utf-8?B?U0VnWUo5OHYyd0U3M0ZhUTZyZm8ybzZKRVFkSVVndkFIVUEzZkJjeHIvUW5t?=
 =?utf-8?B?Y3dGdXZsVit5VGorTko5VFNvRHh3bHlBMFhPdGszck1yOFlvVW5LUklRUk1Y?=
 =?utf-8?B?dTFJWmU5aGQvWXFVYkdPeEozb0RPNExEbW9lOFZLZWx0WlNHRFNQM2J1N09W?=
 =?utf-8?B?ZWFBOU1DOGdKQkxDQkF2VzE5UVhUbXE5bWlFNi9ldUlYZUxncmU3VjlHQXpj?=
 =?utf-8?B?cDkzVHBodTRTdmhVZ3E0ekdzZmJ1MFVYWHFOOUthMm04WndNdU1ReWdKUGZX?=
 =?utf-8?B?U1NFMEQ3UjAzeVRkZzBNb1hUWXlFQ0w0NkNablNraEkwV1dobnpoN1VnaFpz?=
 =?utf-8?B?RWU5U0xhcVFGQ1JYcmlMQ2FrT2RrODJoVG9lUWRLUzdhVVB2MlNveW0xRDdV?=
 =?utf-8?B?QWI1ZVVHQXFObVdIOTZCRmpzOEhXM1Q5ZHJUNUJFdFlVVkRReHRIWUtUdkk4?=
 =?utf-8?B?VWIrVmF6Vm5wS3NadTNnSkNncnRsRm12c3FxOFJuZU8rcGFPOE5KK3pUUEsv?=
 =?utf-8?B?eWxTTDVjWlZEc003WTJHaE1pSDByUWVjamYxRDNJRHlnZ1pxOEtSdS9zd0JT?=
 =?utf-8?B?SFBZeUdTbDZkSUE0SXVweHdkVDdFNU5vUVYvMU9SK3lDRDBwbU8vMUlqZHNB?=
 =?utf-8?B?UEtKenhNWTY0d28rUGJBcnJMVS9mQzBsQ0JKVlVHS1dvZURmOGY0UFJRTjV5?=
 =?utf-8?B?Y2JwMDNpMms4ZDFCWTN4Qk8rQ1BTVSszWm1xbnlOQ3lpTEt5ZGtqT1BwdWc2?=
 =?utf-8?B?TUNSWE1LaThxTDhmT2VRaVFUK1FVZUN6UWhnNEtkUFhYV2pjVDM1ejBhZDBQ?=
 =?utf-8?B?amdSUG1zaWFyeGJCYnFFVGhBRnN2OU1MTFB5VHJuaXlzMHhucWl4QnJ1MkF4?=
 =?utf-8?B?TW84VHpuU2pFOXZEUkxpT1dxcVUyYjVmdmtuZ2kxUEV2dE8yb2ZIVzI5dmNF?=
 =?utf-8?B?b0I1V1MxSUh3Zy80OXdIQmZ5Nks1Wm9STHF1Z0R5VnQ5YjlRcGFEekdOaXFY?=
 =?utf-8?B?UGJpRWZIalZQY3JtcVRRS2FyaFNWbEhsU09BM29pK0NZeE9peXVrZVpXY2Z4?=
 =?utf-8?B?RzczeDR2VmpnUGF2QkhnTmdnRWw3TTdYcFFTVGxiTnd6Syt3YlZlbWhING0v?=
 =?utf-8?B?YTIxWldzcW1pUHB1QWRabEJYQjNlQTRlWkR4S1hhUnV0UHo4ZnpSeTNXdXls?=
 =?utf-8?Q?boomGxGlY59EeEhwcZHZqIeUZ/uxO6ZTlXegzCruJMh0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9b2b42-f44f-4181-a39e-08dc8afe7e45
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 16:41:22.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3076

--------------NY0hP6svSCZjyxbeRqrZ608F
Content-Type: multipart/mixed; boundary="------------mOfvGx0Ovjh4AfM8MJeUhREg";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Conor Dooley <conor@kernel.org>
Cc: wiagn233@outlook.com, kernel@esmil.dk, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, william.qiu@starfivetech.com,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 stable@vger.kernel.org
Message-ID: <5ded7345-3a47-42c2-bfc0-43977af81bed@outlook.com>
Subject: Re: [PATCH v2] riscv: dts: starfive: Set EMMC vqmmc maximum voltage
 to 3.3V on JH7110 boards
References: <TY3P286MB261189B5D946BDE69398EE3A98C02@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20240612-various-verbose-8c1a5db7d25a@spud>
In-Reply-To: <20240612-various-verbose-8c1a5db7d25a@spud>

--------------mOfvGx0Ovjh4AfM8MJeUhREg
Content-Type: multipart/mixed; boundary="------------HojCupgeq5WGeaGa3R2e16MZ"

--------------HojCupgeq5WGeaGa3R2e16MZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQ29ub3IsDQoNCiBGcm9tIHN0YXI2NCdzIHNjaGVtYXRpYywgSSBkaWRuJ3Qgc2VlIGFu
eSBkaWZmZXJlbmNlIGJldHdlZW4gc3RhcjY0IGFuZA0KdmYyJ3MgZW1tYyB2cW1tYyBzb3Vy
Y2UgZGVzaWduIGFuZCBhbGRvNCBpcyBub3Qgc2hhcmVkIHdpdGggb3RoZXINCnBlcmlwaGVy
YWwgYXQgYWxsLiBBbmQgdGhpcyBwYXRjaCBpcyB0ZXN0ZWQgb24gbXkgdmYyIHdpdGggbm8g
cHJvYmxlbSBhdA0KYWxsLiBTbyBJIHRoaW5rIGl0IGlzIHN1cHBvcnRlZC4NCg0KQmVzdCBy
ZWdhcmRzLA0KU2hlbmd5dQ0KDQrlnKggMjAyNC82LzEzIDA6MTgsIENvbm9yIERvb2xleSDl
hpnpgZM6DQo+IE9uIFdlZCwgSnVuIDEyLCAyMDI0IGF0IDA2OjMzOjMxUE0gKzA4MDAsIFNo
ZW5neXUgUXUgd3JvdGU6DQo+PiBDdXJyZW50bHksIGZvciBKSDcxMTAgYm9hcmRzIHdpdGgg
RU1NQyBzbG90LCB2cW1tYyB2b2x0YWdlIGZvciBFTU1DIGlzDQo+PiBmaXhlZCB0byAxLjhW
LCB3aGlsZSB0aGUgc3BlYyBuZWVkcyBpdCB0byBiZSAzLjNWIG9uIGxvdyBzcGVlZCBtb2Rl
IGFuZA0KPj4gc2hvdWxkIHN1cHBvcnQgc3dpdGNoaW5nIHRvIDEuOFYgd2hlbiB1c2luZyBo
aWdoZXIgc3BlZWQgbW9kZS4gU2luY2UNCj4+IHRoZXJlIGFyZSBubyBvdGhlciBwZXJpcGhl
cmFscyB1c2luZyB0aGUgc2FtZSB2b2x0YWdlIHNvdXJjZSBvZiBFTU1DJ3MNCj4+IHZxbW1j
KEFMRE80KSBvbiBldmVyeSBib2FyZCBjdXJyZW50bHkgc3VwcG9ydGVkIGJ5IG1haW5saW5l
IGtlcm5lbCwNCj4gDQo+IEkgc2hvdWxkJ3ZlIGFza2VkIGxhc3QgdGltZSBhcm91bmQsIGRv
ZXMgdGhlIHN0YXI2NCBhbHNvIHN1cHBvcnQgMy4zDQo+IHZvbHRzPw0KPiANCj4+IHJlZ3Vs
YXRvci1tYXgtbWljcm92b2x0IG9mIEFMRE80IHNob3VsZCBiZSBzZXQgdG8gMy4zVi4NCj4+
DQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogU2hl
bmd5dSBRdSA8d2lhZ24yMzNAb3V0bG9vay5jb20+DQo+PiBGaXhlczogN2RhZmNmYTc5Y2M5
ICgicmlzY3Y6IGR0czogc3RhcmZpdmU6IGVuYWJsZSBEQ0RDMSZBTERPNCBub2RlIGluIGF4
cDE1MDYwIikNCj4+IC0tLQ0KPj4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2po
NzExMC1jb21tb24uZHRzaSB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
Ym9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLWNvbW1vbi5kdHNpIGIvYXJjaC9yaXNjdi9ib290
L2R0cy9zdGFyZml2ZS9qaDcxMTAtY29tbW9uLmR0c2kNCj4+IGluZGV4IDM3YjRjMjk0ZmZj
Yy4uYzdhNTQ5ZWM3NDUyIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9z
dGFyZml2ZS9qaDcxMTAtY29tbW9uLmR0c2kNCj4+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9k
dHMvc3RhcmZpdmUvamg3MTEwLWNvbW1vbi5kdHNpDQo+PiBAQCAtMjQ0LDcgKzI0NCw3IEBA
IGVtbWNfdmRkOiBhbGRvNCB7DQo+PiAgIAkJCQlyZWd1bGF0b3ItYm9vdC1vbjsNCj4+ICAg
CQkJCXJlZ3VsYXRvci1hbHdheXMtb247DQo+PiAgIAkJCQlyZWd1bGF0b3ItbWluLW1pY3Jv
dm9sdCA9IDwxODAwMDAwPjsNCj4+IC0JCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8
MTgwMDAwMD47DQo+PiArCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+
Ow0KPj4gICAJCQkJcmVndWxhdG9yLW5hbWUgPSAiZW1tY192ZGQiOw0KPj4gICAJCQl9Ow0K
Pj4gICAJCX07DQo+PiAtLSANCj4+IDIuMzkuMg0KPj4NCg==
--------------HojCupgeq5WGeaGa3R2e16MZ
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------HojCupgeq5WGeaGa3R2e16MZ--

--------------mOfvGx0Ovjh4AfM8MJeUhREg--

--------------NY0hP6svSCZjyxbeRqrZ608F
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmZpz64FAwAAAAAACgkQX75KBAfJsRnC
ehAAju1pS8gVSQvzu8G10o1LELQhEpOFv75mzDB3YPuuLT09J/oQFIKSfkrAfdboqe9jKsnavhU1
0NSeOMbkBAT7DSJmysFTGPcWcBQZyJ5G+kU27ovetxicHY/b68UcxgMR4PrHt6wMz8zI+3sROVbw
TeJvb8FddDe8+VdofLgBxs0kppZE/Mrjq6m/mTOv/qUfXHhykE7vBYSWdsAYRI/AF4FMFypyVOvY
liKfrLKgs43Bad+4E1DKAaSuBhxlpndTBJ4T6SB7aF/gFOd7GaVq4EaRblvBNf6bwXGgmvCbOhvM
Lql9pv3P2D8qhyMExMSrbcftPovG1bO24W5zxJLkSY1uDlqYRmmBulQCZUHmUZJ6IkNjCKEmbgf0
A3NPX9vhLNlwe8JbrrOgMkF6HfRSFvrEXph8Gl8Y5JzXJKIFPs0JaEZXvOLME57pLzlE9sbd1q02
MfdGUJ/xlSgrMZrC6ZAfxWooU5lFM28Ja5ArgrcUsYtmeOv7NOdIzs8dwdgRu8kxMLb/wsV7CL93
Ub67a7vbHYIgB7c8KMAQGxSx2ztYM0x0UTn4ZnnUTRJrWN2Xtd+J50X+u739xzCAHVcMR1wz3va+
fTct570iL9AB18xOGECTxN1/xdHA/ScIp9r9cm5PefefpXdOtq6smz46mvWz2jSuGriwWF0+U+gY
P98=
=lhbO
-----END PGP SIGNATURE-----

--------------NY0hP6svSCZjyxbeRqrZ608F--

