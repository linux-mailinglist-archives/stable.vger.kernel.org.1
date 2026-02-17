Return-Path: <stable+bounces-217188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UImuMfPjlGmjIgIAu9opvQ
	(envelope-from <stable+bounces-217188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:56:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D1C15132C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F7AC3061E0A
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D852FBDF0;
	Tue, 17 Feb 2026 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZVJame/g"
X-Original-To: stable@vger.kernel.org
Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazolkn19012054.outbound.protection.outlook.com [52.103.34.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEEB2D3EC1;
	Tue, 17 Feb 2026 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.34.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365038; cv=fail; b=UG/Rpk1fuqSI4e/MT0KtaRynv641wPy4fyez//ii6z5uT5QjkkD+rZ+aVXtkX46gzzyA2bW9Jkl3jmH51kTssG2CfuSlvfqTlM00QSZdYtQwGPR3TbejJeSHvEmWuUKs3Pp/rPyyku9aeXv/hMHwrPfBAFaVqy0/8H0STHi4KXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365038; c=relaxed/simple;
	bh=adPIXQ+o3HpQ+uBdQbmO7Sb63mIKhB1NTOS9p8inwKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TVf31iZPgcT2rZccqzs46y0OhRBI7EMhVwTqBJqSbs61yP30toTOE3Tq29GcAx4NpCemcalkh1rFFRsJt7e40kZ3VJnY2s1tnmpoZ9uRcR+j42otE3KSM+PIGix5tYqi+Ax9Oz//GS0WZaRp5LkllXBdO9+zDNm60IzrK4XU9Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZVJame/g; arc=fail smtp.client-ip=52.103.34.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/6ZUaGBCziu0QVzbt4IdQitDuhU27wwusEIXoQNF925/93R4F9HI21Vq+woEfC6TkNHuYDb4oQi1bXxp7WdLzM4Z9f+oR8zlRZwYjOf6JsAgSZ6ZT9FOiFvGtkyOyPXoYrgjpMpz/eyIG0z9MDi0fZhks+Sgs4X+XWpEOjzxeG5EarrC/N0JwlAnepQtxo6BrijNLQBzVL9iiFC8/s+dfZBOU7LkQ0UKJgTlV4NeKvcpU4yTZH/AY3yo0HpzI2DFcCUIItW2QeV2ZQPf3r9pvyZeDQ09EhFA4QJpOc8FMFlh1wWQHLJmBnZyIx6uV66EDDHGuZ/62UC3l1TvjJPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3NQ/WKTJkEBguk8arUeJS6WSVycDpjaSJ6vbpdE5jk=;
 b=ASELoJO5p1JbcFY79ygrFP+ajCzg8HnD/sWvf+EhRlPYNNgACOpslLFFkmNeEcP++TOexCN0OhcVd5BBUdjJ1DG7lvlMvXYQEFP2BZznJ8yzuXCDhTzlRUx8isD7LEC+Ye1BQG8+2vFS7SiAoIOoV41xv29RpfULYu67tjNkv4oCmxJl9R8JuxVTldwW6lFLYM4YtZwEDdqoMK+kDwqqq0ltCIyG1Nnrm3GKhE/fVA9TSLIauzvgmdhe0H04MfW2HnDyfY6H2bB8h+1lgYGI5+qwAItlhbObiO5Tlv44r9yNSkzYxyWjrA71TgBBTQvfTBL2492dZyTZHowYPz3yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3NQ/WKTJkEBguk8arUeJS6WSVycDpjaSJ6vbpdE5jk=;
 b=ZVJame/gQ3R7aoxFPKYuUxBlaSFlmkEBGfYSvKOCWazgsU3P2IWnxeJZc27D7kiDttPaz+qErC1EHUKTz1fFJ413BeroEkXtb1hnLITJa7KBkyJouQksHTVgsnP934B5plqivePi/1SLerOT/tBWlwaZ59y3nP2UYBNEC3y2vPIWA5lNEAemv0RkbtDH7q7CITSbHvKowWzBXs9hBqd7uAjTfB9+s5QLkpTB4spx7bVM320+LQU0aPWTwwqdENvCfSktg/Gn8W9cxdJO4vvM1GWr5fzXAnM8jNctG5w62DbinBfX4JnPB1T5ZgK10rc+zRTrNssOQSArNFHg/SBRSA==
Received: from GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f6::13)
 by GVZP280MB0901.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 21:50:32 +0000
Received: from GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM
 ([fe80::e96f:b4:bbfe:1f98]) by GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM
 ([fe80::e96f:b4:bbfe:1f98%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 21:50:32 +0000
Message-ID:
 <GVZP280MB1013A39E6B154E88E8CBB87EAF6DA@GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM>
Date: Tue, 17 Feb 2026 22:50:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: avoid OOM when allocating RX buffers
To: Andrew Lunn <andrew@lunn.ch>, Fabian Druschke <fabian@druschke.network>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260216185245.182450-1-fabian@druschke.network>
 <64b1a578-5325-4d51-9b10-2b54fcaa0a7f@lunn.ch>
Content-Language: en-US
From: Fabian Druschke <fdruschke@outlook.com>
In-Reply-To: <64b1a578-5325-4d51-9b10-2b54fcaa0a7f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::18) To GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f6::13)
X-Microsoft-Original-Message-ID:
 <30eb72a2-7a8c-4da8-8cf8-7796d184e6f0@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVZP280MB1013:EE_|GVZP280MB0901:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a164e5-e0bb-4343-d8b5-08de6e6e92b3
X-MS-Exchange-SLBlob-MailProps:
	LVbdfIC7uFAyHke/CE1Ui/FW7barhRQEAYyvRxtEL0yvLhg5aFAmg2wJ7RmaC6kG2VdlnD/4C5zA2PC3HGUkXJsIrvGBKZA0ys2dgLH0BdkGaxXbGI1liCnnA8CjfbiH7H/mXMJjmXuQJBvJ0DZobqu7amnH5D/dM9PmRImnZX6PZ+gJR2nQ3j5lQA3h7Gu9WDq1VZbBdohA3RXgfogzsurUWUzH7pWb0fjcKn1jZVLXPiIi8f/yWsylyQBAAjaVxBWd5WktptDnobRpW2O91hICzRvvqyCMz9AiWZ+DLWtwnqL+Gzq8l2Rg1/pzXoGg32X2eIL73uqDOe+1vJdEjYa9MKtbfiO+5nclsTr6nJYOhYqc0hhC+gnAa4S7Nv+H0sOCpVd1mViGq1RIIsMGppOtfPM+uSUz7v6SyBDz8p9Oahf8FxiQy1agSu9E5imNBzeonrlUGtp1Ys+K+pVNvNhBw0h9xlg8hKr4XSnC/3Pe1U3+3hr0qbcH4dQ/rUmjfocvoxRGCFJve8PmAsRiGgfAqbdGA7dC2cRmkuXoOq7lfcip8N5WoH9dy5hcrQgjyPqe+L59o7joAh+fAmHzvwPdy3F2uy0Utbs0B31DjMcGkEdg9DDL05VSONKgwK7iiYZKPITZDdxkIMkGkVmIKpwfuhsqVmGAaLUESPU0CAqKbM7nQzqoWuvWnW/he3PXZ0M+DhHsR4kRjQJtOCpSA7nowHj8yezrU00K9pWaWSrmqQ0NJlHqcw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|8060799015|15080799012|19110799012|12121999013|23021999003|39105399006|5072599009|6090799003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGpybm50ZkZDdDljc25PQ2RSanhXc1U2dFVJelMyZSt5RG44UmZwYTNqVitM?=
 =?utf-8?B?bHIvdnZHTEJ6VSsvcnhZbEJhazNkMTdEK09kdGp3UER6RStPVVp6Zkc1a2ZK?=
 =?utf-8?B?TGZ4bEk1SndJUXlHWFgwbDdyZWNKRU1pZE9YNXhLVmswWituM3pSb0o5SzNK?=
 =?utf-8?B?VWs5SEw3cU5Dd2JRUXliNGY4RU1ZbjE0TkhLMDEvVCsyMlBnNUwvaXNYRHVH?=
 =?utf-8?B?bm5vMGlTb2FDbEtYMjkxUE42a0svVlI1bndhZHRHUXFpMi8vZmxURXRETzZD?=
 =?utf-8?B?bEFqN2ppcy9PRDB4ZDdvWW5PR1NNME84bzVYUFU3SkRhWUM4dW05c1VkdEUx?=
 =?utf-8?B?MkxveXo0NW0xTHp6ZE8rSGl6WVU3ZklCeFFhbHBuTzgrY2hVR0xUMEthdXB3?=
 =?utf-8?B?d0N1c0w1M3dsb05URzYvVFBOQUY0RmtlU2RBVUtqNm5JR3NQWFBjUktQWFh6?=
 =?utf-8?B?clhpUzJSMnYzeWtrM3NkOEpFU2ZpRnVJU2ZKMW01K01SeTlheFd0cXdhU1Zr?=
 =?utf-8?B?VXZuZ1NzRko4V0dMZ0tyZ1pxYXpucURQaVE1ekpVbnUzU050aUN0M0ZQS2hL?=
 =?utf-8?B?dWs0aUg0MWUvMTV5S3gxR1IzMmtqYXRSb1dXR0R1M21IL0RXeWozMDczSU93?=
 =?utf-8?B?Ry9acDA5NUVDODJRcXh6REpEZHRZeXJ4bklUTVYxVjRhSVhDZTdJK2xjRmNY?=
 =?utf-8?B?VU55NFRzeUY4eFk2dnd0MUFlNFU1MDlqQWlPTFJOcDgrcjlGQTJNVkhXcFBV?=
 =?utf-8?B?NXNiTlFIancydEw2eFBGWWVDc3luWU15R3NkRllUbVEzaEtXRUYxQ0I4TXAy?=
 =?utf-8?B?VW5BNENuMGhrNlozRDBYT3lLVURlRHg5ckJ4WDl2MnFlMGgwcFZ2MTdtemxO?=
 =?utf-8?B?K0QxV2NNS2NHTzFSZUV3RzhSQU1pQjNxQk5DanlNbHRNNmZNVEQrbDhNRkZU?=
 =?utf-8?B?RXRRc25TQ2ZCZDBxRThEd3kwMXZNTncvMHE4TUVZWk1QaWE0ZkxWTmdLU1VH?=
 =?utf-8?B?bGUzSkx4Rm13Ny9ZcjlxamprZUxTS04zcUZ0a1F5R3FCdjF3QlRJNGhoNWZE?=
 =?utf-8?B?Nm9kUUE4OXplRytlRU5KLy9lZXJEQ3ZVTFpYR0I2Q1pvUlgrTDdoRzV0aGtr?=
 =?utf-8?B?SUpNWS9BUGQ0NGRKcnN6Mk5MbERoOXlKdm82Y0ZhTmFlMnF3ay96K1ZuVmhE?=
 =?utf-8?B?Z2l3SzhQTml0dy8xN0xuamVBdFp1Ukh1VFVreXhGNDM3a3Q2c3VaUkxQN245?=
 =?utf-8?B?ak52MndneXV0Zy8rdW9VWE5YYjZEUllwRDVRa1o4cHVnQWJWT3k2cmsyRkV6?=
 =?utf-8?B?S2FFc2FQc1ova1dOayt1bmRNN2NWQ1lWSlQyQkpRZjRZalZlM3ppRnkrclZ1?=
 =?utf-8?B?bHowaEZMZFdwbTdodkZFY3NrdlBESzJsRkxrY1haS2REVDFQUzFZOFp1M3ln?=
 =?utf-8?B?SjZsbVQrbWF6eHIrRVR5eGNFM3Yza3ZSbmNUb3ZZaHRoa1pTNjZ5NUxyZDc2?=
 =?utf-8?B?NnFkcFU2NkhETEJJOWtxS1lzYTVMb1l1R3o4amoxQm9kUHRyRTV5VzR4VFhy?=
 =?utf-8?B?bFY5K2NhUUpCUzFFQzBDMFRpaWRBVkY3RS9ZU1dlaWxvanVVN3pXNFVpUzFp?=
 =?utf-8?B?SnRiYUQreGZqazZHeXhZcG5uS3BmNU5nZEhrVncvL3VHYzRjUlQwdnVDN1RU?=
 =?utf-8?B?aDhCbW52aHNzeE5nWE9MQUIxU0JUUSs0RlFOU25lY25oV2p0ai93RzFRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1ZNTm9DMnhQRW1XVkdJdk96dDEvTmFiSHNnOFhKeWN0TGtrbEx0TkhEemU0?=
 =?utf-8?B?NzdaU25WN3RqTkx2TURZeFJiUkRIY3VQaFppdUczZ2diK2hCME9zTWtDMDc4?=
 =?utf-8?B?U29xYldkVkVnYzRkYStVVXhrdDlwdTNTbVdOYTNNcmxlT2c3ZlJaNTUwckN5?=
 =?utf-8?B?ZEdSMXk3TUkyL0hLZFFRWVVOTmxYZ0wyb2NHdWdVSmw0ZkNIaUpTaFJlU1JF?=
 =?utf-8?B?UW5JcGtYTjZzVVFMcHlUMnhhanNWeWVPaTZpOVpMa3ZIRDlnNDM2SVU2bi84?=
 =?utf-8?B?VlljUERQUHdqSTNINTV4RSt6cXdxd0hha2tGNHhxS3ExMjdKUHJ3Z1lwT0h0?=
 =?utf-8?B?cEJUandKbGlsVkdCU3Y1UzVTeTRjQ2RVWHVJTWNCdUZ1UzdqODd0R0k4a2Jr?=
 =?utf-8?B?QVdNN3Zzbktyc25rMlVLTmtGdmZNMlJOdTRNY3BqaUVJT1hGRjJhYVRlVVJR?=
 =?utf-8?B?V3FmWjkwQzRSMWVqSWJsUmt6NGIvUnpJNWdQSGlqRHNhOVV0U2g4aWFSM0dE?=
 =?utf-8?B?MzhtQnl1alRNa0xtczdIRjIreTZSREl6SnZJRVJIMkNHNjR0cHFLZDU0NGFF?=
 =?utf-8?B?WnVDV1dYcWRDcldEaVNvTlY5dktKaVRLa01PZktKdUR4c3Y1WGZtd2hRWnhT?=
 =?utf-8?B?SDF6YWplaGRoUjFBNHByRkJtSzRTb1hRQk80RHNSK29XaUxTWmluaHpCaTZ0?=
 =?utf-8?B?UXI5U3hzcysyMU1MOWYyTmZTd0Rsdlo5OUlhQnRDb0RIMkp5T3JwcVN4a2ph?=
 =?utf-8?B?amlkS2EvbzJNeUxCMUxBb3pyNzVIcEhXelhYK252Y0FEK0Y4RDF6c2JKZDBW?=
 =?utf-8?B?VzVRRkVqK3dBNk03ZlU3dEFjRXd4MldjRDQ1M2ZHNFlFa3dhKzlSaXE0WG9Q?=
 =?utf-8?B?NW5kNytrYW4yU3hpNkU3NzhFMUo3NjlZcjhIVGN3UVZyd2FONUpxL215dmxs?=
 =?utf-8?B?Zm9pRnlHT0NibC94ckt0a0l4N2gxMzU0MVY5R2g2WVltM0s1YWlCSkxHZzRU?=
 =?utf-8?B?M1VEWUZHRHZEakxlTnVwbU0vR1JXbmNQNGxuVEk4aHJWNEgxLzE0NnRCWnJn?=
 =?utf-8?B?S3lZQXZzQUtERHFud0NZWFVMTEs2OU9TcGpFSmUrN1NEeG52QWQ5OEovUnNo?=
 =?utf-8?B?S29lZURmNWMzQWtuUGpHVkFPQTF0WE1jOWNIbVk5Uk53MkhNVFZDK3RaYlph?=
 =?utf-8?B?eitiQjIwMTNKTk9FQ29xam83Ky9VZVIzYm1TVnd2Qm5TUE1DMUxHeEhJTXVZ?=
 =?utf-8?B?YmhUbHF0Qm5BQzlvYWVqTjk3K3NZV2RNUkVub0RqOUljV2Q0S01vM0Y1dW5U?=
 =?utf-8?B?SWx1blI1OUpudDkxWDBBSXZ6YjAvOER1TFJCVUR2WHAvVzZCa3lNWDNmZFV5?=
 =?utf-8?B?a3VXbU1xVDBCYmlXWlNhQ0ZrL1ZKUkhwdjhSaUxreUVTemF3R0FzU0c1M1NJ?=
 =?utf-8?B?MXAvWi9qSmJWZUdmelV0QUREaWdtbzB5ay91N2x5Skx6UTlXSzk5ZGl6cE1R?=
 =?utf-8?B?SGtFSVFzdFpSVTQ2TUkvTTNONVZWcm5JalBuU3FWWlljN1J3dThMaEhUaDRF?=
 =?utf-8?B?eFYwVFBLVmloSEhHR08rY2o3c1YvUWN4djZxV29DMjhmYjhRYWd5WFZiMlYv?=
 =?utf-8?B?N1RwU29JZDRkdkVxOXlxUXBiVFVQMTErVDFvNG04SmRjWno2cWxieWM2VERs?=
 =?utf-8?B?Rzd3Zys0Rjk2blBOWEZFV0U1MlYwMk9iRlNJL2orS1BxRnVvOWhGZVdGSlZj?=
 =?utf-8?B?S25IbklrdnZVdTlxcWhjV0oxVHQ1ZXRQeDJRRDhKdEphVUpYWTJzMlB3SkpQ?=
 =?utf-8?B?dlJrYUdxNkxaNjhocXBBNFpHQ1NjWEtHeTRGR1d3TGV2STBHTFM0NHEwblQr?=
 =?utf-8?B?bll4cWJCcWRaZnpjRjJKdG8wdWwrZTBPTkRvYldnRnhxTEdleUFYZ1VLbTYw?=
 =?utf-8?Q?f9d1TmncdNTaRU7oAHuPdrmh7CHavmEt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a164e5-e0bb-4343-d8b5-08de6e6e92b3
X-MS-Exchange-CrossTenant-AuthSource: GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 21:50:32.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB0901
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217188-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdruschke@outlook.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: F3D1C15132C
X-Rspamd-Action: no action

Ahoy! Thanks for clarification! Didn't know it was intended behaviour.

We've encountered this issue specifically with this Realtek NIC on 
ShredOS due to lack of mlx5, mlx4 etc.

For NICs like ixgbe we didn't encounter this issue so i was thinking 
about a bug.

Thanks though!


BR,


On 16/02/2026 21:13, Andrew Lunn wrote:
> On Mon, Feb 16, 2026 at 07:52:45PM +0100, Fabian Druschke wrote:
>> From: Fabian Druschke <fdruschke@outlook.com>
>>
>> r8169 allocates order-2 pages for RX buffers during rtl_open(). Under heavy
>> memory fragmentation this allocation may trigger the global OOM killer,
>> causing unrelated user processes to be killed.
>>
>> Use a GFP mask that avoids OOM killer invocation so the allocation can fail
>> gracefully and rtl_open() returns -ENOMEM instead.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Fabian Druschke <fdruschke@outlook.com>
>> ---
>>   drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 3507c2e28110..3525e889ec1c 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -3952,7 +3952,8 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>>   	dma_addr_t mapping;
>>   	struct page *data;
>>   
>> -	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
>> +	gfp_t gfp = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
>> +	data = alloc_pages_node(node, gfp, get_order(R8169_RX_BUF_SIZE));
>>   	if (!data)
>>   		return NULL;
> ~/linux/drivers/net$ grep -r alloc_pages_node
> ethernet/chelsio/cxgb4/cxgb4_main.c:		newpage = alloc_pages_node(node, __GFP_NOWARN | GFP_KERNEL |
> ethernet/chelsio/cxgb4/sge.c:		pg = alloc_pages_node(node, gfp | __GFP_COMP, s->fl_pg_order);
> ethernet/chelsio/cxgb4/sge.c:		pg = alloc_pages_node(node, gfp, 0);
> ethernet/amd/xgbe/xgbe-desc.c:		pages = alloc_pages_node(node, gfp, order);
> ethernet/fungible/funcore/fun_queue.c:		rqinfo->page = alloc_pages_node(node, GFP_KERNEL, 0);
> ethernet/fungible/funeth/funeth_rx.c:	p = __alloc_pages_node(node, gfp | __GFP_NOWARN, 0);
> ethernet/mellanox/mlx5/core/pagealloc.c:	page = alloc_pages_node(nid, GFP_HIGHUSER, 0);
> ethernet/mellanox/mlx5/core/en_main.c:		struct page *page = alloc_pages_node(node, GFP_KERNEL, 0);
> ethernet/mellanox/mlx4/icm.c:	page = alloc_pages_node(node, gfp_mask, order);
> ethernet/realtek/r8169_main.c:	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
> ethernet/google/gve/gve_main.c:	*page = alloc_pages_node(priv->numa_node, gfp_flags, 0);
> ethernet/google/gve/gve_rx.c:			struct page *page = alloc_pages_node(priv->numa_node,
> ethernet/google/gve/gve_rx_dqo.c:	struct page *page = alloc_pages_node(rx->gve->numa_node, GFP_ATOMIC, 0);
> ethernet/hisilicon/hns3/hns3_enet.c:	page = alloc_pages_node(dev_to_node(ring_to_dev(ring)),
>
> :~/linux/drivers/net$ grep -r __GFP_RETRY_MAYFAIL
> veth.c:			    GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>
> What makes the r8169 special?
>
>       Andrew

