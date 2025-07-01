Return-Path: <stable+bounces-159174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4817BAF0716
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 01:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44441C06626
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 23:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CB302078;
	Tue,  1 Jul 2025 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z/28YBsv"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F5271456;
	Tue,  1 Jul 2025 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751413960; cv=fail; b=LDSSUJSfq44/G11qQdZ4zTF0oooyAuznPpxSQ0BpXXBewDNVriWAkYtY0qGP0CE1SpbhmOQCgR2gtDrqPGKLZd4qM0VjvVzz/HTLoE+pro69g26+0arGm5TcitNA9KTqeNfBT/WGm5lEISo88VUL0ORWH//qrmqY9YA4bsi/5SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751413960; c=relaxed/simple;
	bh=zaZ4cuXFWzYbpFYmJr2zyPf0uDksiLzokTQXakwEX2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QUQR5RqX5/45h4xQuFSgWAPygVVjfRyfmnLvZBA1/lyih3HbX5cUAmKLVQQKlGHmR8b4f/xkwNsGGFlqo6EfJh/3iKcA+hA1wlMnHi5jN3vxjLpKOw9FcuvbZOVX4JsX/r8GAxzbSbaNGJ735+StXIe6a07+fjxytA6DaOWvtLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z/28YBsv; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuzHjZ186zepETRMFnt1G3V6cFzLhcoG6dhi5/zR2yZ4zm/DO/ZPBujaZxR6FRoDsOPYmd9RprtTeZkTnQeaYiISfBNZiOH9M8T0alcmY0yiLd3ITgWCfvJYywcprwNghGSztK3lkOdUtuz6a9KlXGwqnmdG3SJWUorPB/LvthIx+kWUrnijawDxaG6O4QMbfsD2gabqfmNbeKvrXkSUbP8Fw57zjDUBdbcLzgR2iRg44kxaV9ydawPYyXbmZSoEY7vru1MZmTXt+JXdfu9fmh3rZ8GE4u/PK0yw2A8XrWnZjLBGIbQhVZmTDt67VvSE2yVCZlr+lu8vyGvpZnQ/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLquz5kfLmRz5jL8K0delPQcirn5GTSlbsOgPMNGK44=;
 b=JTedAsigKKfvkttQNtNwTagqc+eG+mhuVwWVwTzek5wVCx7aO8/SWyffomJrIz5Stwd6dGJqoklH+wblV9iinDUPweWznTFPBCiH4lNZS/d/v/BsQdmF0LvQeiJfIP9ZCukd49AV5aOId0flTOhZSosqBIOX9XT5PYL9h4K5zShTGewPOoMO8Knhp56mZoTlYKPT6UfP11qh/+sJwvkt8LvnmLZA+yiGwaHd5BWNvF6EDYnMwZAzHlcbNDelqSCfgbxKL2fbNYewW9RpdjGobkxmqCpiBVSC49jIIoc1uOtbEfn2E/WrdAWsZ3f3JebAXSkip0bnGt+qKgAsG/KN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLquz5kfLmRz5jL8K0delPQcirn5GTSlbsOgPMNGK44=;
 b=Z/28YBsvKu2bF25Q55QbA/fPuZl4mTAls+XLoi2TApHHqdw3F9Q+lgNBfTRG47+qkexXbV+3seDyAilKs3mZinOfLmIRLO3ucdezTraIH7gPdjwq8PnBOM24KuruNn15NCYgUxzvHn14txV82k/raGVocH53zpJYj1my0VHGG+Qt7TIHV4KnpzAD3hy34EtuUEEptG+0H6DplHOeeZdnM2uA1dfK0fNV50bqD5LLVm210bhWFzXndx8/1M8C2mkQIc5K58MkC6q6pfjP4l0Bovi1HTw1kjQNPnnyTwIIaATPwe0Ga5G+jF4iWQMOuhwA3hI81SLckWk3i3hKxK/vYg==
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
 by MA0PR01MB6693.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:79::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 1 Jul
 2025 23:52:29 +0000
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c]) by PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c%7]) with mapi id 15.20.8835.018; Tue, 1 Jul 2025
 23:52:29 +0000
Message-ID:
 <PNYPR01MB11171E0C90DE8A30FEF50A9F5FE41A@PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 2 Jul 2025 07:52:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dt-bindings: net: sophgo,sg2044-dwmac: Drop status
 from the example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250701063621.23808-2-krzysztof.kozlowski@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250701063621.23808-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
X-Microsoft-Original-Message-ID:
 <a2b4e3dd-fdf1-4bd3-b308-aca7ab1d6e71@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB11171:EE_|MA0PR01MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 311e2fe1-9374-4498-1830-08ddb8fa5655
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799009|15080799009|7092599006|19110799006|6090799003|5072599009|440099028|13041999003|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkV5NmRIU1kxeC9JcVcxWUZ1QjNueFlsNC9Ic1kwYWthK0NDVUFyK28wU1JF?=
 =?utf-8?B?VFd6dUk3bHBQdnUvL051bGNoYmtEV0FYVlp3UzU5ck8vYXJZcjlyM05aR3dz?=
 =?utf-8?B?QitCYWlFTkI1cHdOUm01bXVTNWZHN2ZEWFFuQ1I1a1FnN2NEV0RoM0JxME93?=
 =?utf-8?B?VzZNSVBDQVVYN3E0MjdZenROWlluMzFibW5XQi90QXJPNmRYZDNVb0wyT1Jt?=
 =?utf-8?B?bXJFaVZTUDM2eEZHcXdSem5PYk82enZVVVp1YnVhRHA1TThWVDFuY09iQnBJ?=
 =?utf-8?B?clJOcDlwMXdJQlQ4ZW1hQTR5TXRuRGF6aUJIK2lISm80ZVlRanp1VTZVTVpI?=
 =?utf-8?B?czBoT1ljVEVmZFJXVzMzSVJoOFRlUU5TcFFhQjgwQ2sxalFNQnR3K2F4d0Ri?=
 =?utf-8?B?VEtUdGhEdlBNdlUxVXlLUncwcFVKa0MvNDZCVS8rWVprMjZTcHNMOGxoeEtl?=
 =?utf-8?B?S1c4NWdwT3BGUnJiRnpTRkxJM2tVc2ZEalJ0VmJPV3UyQzk0YnkzcXI3R01M?=
 =?utf-8?B?RkpHL0RaRHVSaG5qbWI5VGdaaUtqY3AzTzd6bDBqWDNuYUJQdUMwbFU0bWZn?=
 =?utf-8?B?dDkrZGU0RnZBV0dMSWJyVWE1STZiclN0YUdXZ3hGTk1qREg2NUlBS0ZPcWZP?=
 =?utf-8?B?MEtQOGxyUGVZNUw3SXdCTjVuSm1pRVZWOTAxMWUwZUxZU3laV2RvL1hqNzJm?=
 =?utf-8?B?R2JqeFd2dWMybFY3dmt3UHpKb2Y5Yk43RnRheW9kMDJhaDJCemNFQUpJaW5l?=
 =?utf-8?B?VFVqNFBUU2lFdTNabzJDZ3FPR2d2MExLcXgrUVVGL1ZmME9DSGlhWGkwcVdn?=
 =?utf-8?B?VVE5SzUwUE1qbzFJR2xrZFN3Q3FOVzZiOUQra1dLdVA1YnlONXo3QU9lMTg4?=
 =?utf-8?B?ZDZmY1EwVDVQSzFnQlpMMllPdzhrYlNsTkg3YnROWW9nM0RlV29BLzZkVSt2?=
 =?utf-8?B?ZlZhcWI0WGJEZ1hFVVdFb1owc1NQdHp1c3N2NDJoa096WXVsS1A0MFdkZHVz?=
 =?utf-8?B?NHhPTHliK0ZIc3ZBdTdsazdvQVVPUXVXNVdVYkhLblgxWFhia09vdmtIeDU2?=
 =?utf-8?B?NExWTHJnODIwSVFpckkxT3Buc2J3b0NFVlhSNE1YazZtMmFUVzZaRTYvZXY3?=
 =?utf-8?B?R2hEd2ZMTjhrYTdsaytCZmF1UmpmbGVxbVNUL1htT2RUTER0SW53WWh3L3VB?=
 =?utf-8?B?cmJZN0prQ3dFNWVwdFVFVlcvamtPKy9zWnV2OWNLWThCRS9hRDEyckU2TDBB?=
 =?utf-8?B?SWY5VGZ2R0hiR2dnNlU4SElzOGo5bGt0NkVuQ3B3SFZKNVhiL1FLcGhReFI4?=
 =?utf-8?B?QW04cnk0SUVXT0UzYWxZQkFrMTFJRTFMRHBiSTVJVm5pSjFCOXBGZUoycDVK?=
 =?utf-8?B?V0dpR1VaTzR2UVF5Q040c2owc3JIYituTlpDU0NqSnhEUmw5YVFDNkJaRy9s?=
 =?utf-8?B?MHVVZ2Z1U1hUdnFHNzBqUXY3TFYzdTh5SGR3anFKcE1CT2JjeXZTeEFqUDMr?=
 =?utf-8?B?YTcxUEZjK2lwMG9wVHduZnNWdzNObzdRbWplMU5MZ1VyL1ptTXZUYWZJM1da?=
 =?utf-8?B?Rk4rMXdoSlhkTUdRSFFRbHlCWkN0MDV2WjQ5TGtBSWplUHlqTU1uSHNsQlVC?=
 =?utf-8?B?T0NJLzVLYmxkNDNHZ215dktjMlFhekE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFdNVk9zNElhR3RLRlNhcFZpNk4zWWdvUG92ZC81V2kzS2JmbjVKMjVPeVlB?=
 =?utf-8?B?YWFHTi9nOGVkdlRBS2QzR2VLZTc4MlJleHU1RHozZWxpWlE2MFBONENya2xn?=
 =?utf-8?B?N1RCWmY0NG9yRitINVJXZzNoNVBUZm1Mc1Nkd29nM0J3MUoyRyt1Q0ZSV01V?=
 =?utf-8?B?cFNMMUpQbkxXcTd2czVJcXZxSmFxdHdPVHRqRkdEV2NteVI0Sk9GNm5SRlpD?=
 =?utf-8?B?WTFFNzJDZDRJV2JwcjFzUzVUM1Zqc3JLMUVqY3YrSGZhb0diNy9uZ0JhSUlv?=
 =?utf-8?B?NjVUL3NBejR2eGZyNzNvWUxqVUZBTHpERWtjWW1HcG9UcVNVRUNGQ2g4amIw?=
 =?utf-8?B?NGNYY0pldUcwQXlHM2lrcWVVcWVEWjZJNWszQTNLL3N3bEwxd25tZjdmeWdV?=
 =?utf-8?B?WnNBUGNkemV0bEtway9GZXZpdlJiTlpUMzJYRkN4UnVoZmdtd0xIajBwclFF?=
 =?utf-8?B?MVAxaWNVRWJvWHhHTS9LSG9MNkswTVVoaXU5WnZwRDEyQklTODhGRVhuRWpK?=
 =?utf-8?B?TDc5QVlYa2FLRWk5TkJYQU5GQmtrU2ovRlNzdFJCOW9BclBacENpSFordXV1?=
 =?utf-8?B?Wnk3VnNUaVIrVDJGaHNlV2FoREp5Z1Qzd25rUU14SjVDQTNZNGV3b1NPN3ha?=
 =?utf-8?B?OWZLRWxFRVpsTDJWdHdEUU02RytYV0pyYjhvV0ZzMmJCK05KbmZjbjRSank1?=
 =?utf-8?B?VjMraEMzSmZxbTJ3YmdSL3Z1N1JNNEh0dHB6N1hIb251b3BWV3BxdlBYbTRw?=
 =?utf-8?B?S3hoQUk5bkQwQUFud005cHhiSGxVRU1lT2duZWR4WDhjM2hiOW1MZnhpRVNy?=
 =?utf-8?B?ZGZocHlzRVF0Ujc4eG9DZUt6RWRnM1VsYXdqbGp3d2d2U21kbDBWR2FGZzl4?=
 =?utf-8?B?RFV0eGRmb0VPdUt6eXRWL1p2UlBHNWNHcGdRUWZ2ejdRZHU5bXIyUk50d3Zx?=
 =?utf-8?B?bXMvZERPU2RpL1dPdDJmNjRFdkJPSE5mYU43SDZOQzJNMTNXb09uKzFoZjBQ?=
 =?utf-8?B?NXR4bDNHaENOYnlCWjZwcFdZZHNCUWRUQjNTcU5xRWl5YWhHQWRYaE5VbVVx?=
 =?utf-8?B?cnN6bDVsWmd0UU5oQitqeW9reXVaRDBFa0grdnYxWDNQVjZlWUJZWWFNYldT?=
 =?utf-8?B?WDBWTCs4aTMvYjBDU2x3VmM1Q0dFRWlXdlkydERERlBZelc1NWs0N2lnSjFq?=
 =?utf-8?B?NlMwZy9QcENKWEZDVGdWbk9SNzRMQjZwWko5d0svMFNSVVZUajFaWmZ3SnA3?=
 =?utf-8?B?dVBZZHZiUVAzNUx2ZmhNZ1hmemNFcTNHM3Y1cjFzaFZ1enlRWEhzV3hVSUZ0?=
 =?utf-8?B?NUcwaDZaT0xMaUtORTd6anBNTFQ4Q3ZxZ3dQMGVVSnBWUkozME44QUZaYlhC?=
 =?utf-8?B?dHM3d0JRdGQxaEttc0IvWU1DUVJueS8zQlFyd25kTUFhOEp5dEIwR2d1RVA2?=
 =?utf-8?B?OWpXSXhnRWZBd1B4THFFRi81QzlXeS9MZFdYY1pwNVhicWp5ZUhCKyt2ay9S?=
 =?utf-8?B?Nm1IaWg3dzFydk1rRkM2L1dOZGVxVjdFeFNScXpwRzY1TTlIdUdQdVNMRGcy?=
 =?utf-8?B?a0lNWi9EeXJGcHV2MGttY2YzaHdMblpUanhXbEhNMGJqblIxWTBDSHVodTdr?=
 =?utf-8?B?am1KYkZSSE90MXNZNTdYejc5dnNiZno5aW9jSFNiRU9TdEhSYVdHMGlldFRa?=
 =?utf-8?B?bGo0ZlRRMFBPSldMTStNcVFrOVdFamY4UmE2dFg0VE4zSWU5ODMzcUZSc09v?=
 =?utf-8?Q?Bw1xyk79DRDUDh+M0+CpCwKNh0Wxi/0zzcUoH6b?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311e2fe1-9374-4498-1830-08ddb8fa5655
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 23:52:28.9265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6693


On 2025/7/1 14:36, Krzysztof Kozlowski wrote:
> Examples should be complete and should not have a 'status' property,
> especially a disabled one because this disables the dt_binding_check of
> the example against the schema.  Dropping 'status' property shows
> missing other properties - phy-mode and phy-handle.
>
> Fixes: 114508a89ddc ("dt-bindings: net: Add support for Sophgo SG2044 dwmac")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>


> ---
>   Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> index 4dd2dc9c678b..8afbd9ebd73f 100644
> --- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> @@ -80,6 +80,8 @@ examples:
>         interrupt-parent = <&intc>;
>         interrupts = <296 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-names = "macirq";
> +      phy-handle = <&phy0>;
> +      phy-mode = "rgmii-id";
>         resets = <&rst 30>;
>         reset-names = "stmmaceth";
>         snps,multicast-filter-bins = <0>;
> @@ -91,7 +93,6 @@ examples:
>         snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
>         snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
>         snps,axi-config = <&gmac0_stmmac_axi_setup>;
> -      status = "disabled";
>   
>         gmac0_mtl_rx_setup: rx-queues-config {
>           snps,rx-queues-to-use = <8>;

