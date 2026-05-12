Return-Path: <stable+bounces-245438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNqOFxEGA2plzwEAu9opvQ
	(envelope-from <stable+bounces-245438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:50:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA73651EDDE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B7A303FF20
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6523839B1;
	Tue, 12 May 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="cfyioWb3"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF274395AE4;
	Tue, 12 May 2026 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582866; cv=fail; b=Mn9ZFjD+IScPAmT1PgrNoGdH3kDzs/ZIJqZrc7P85VReynJCDJVuvp5gvviULO+I3yykmfJHIwh+bySFKmz8h9zdHP7itSc+03Q9/MfLxnDeEsOc8536O3n9hHdHRu93Ree4J0e1SO2LP0+BLhY6AN5sYu4zlNIHHFquuC2fytI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582866; c=relaxed/simple;
	bh=4ODLVRZ6/5gPTc/f9V//HFneugLFNBDQjyEZVWdXDp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ncBUcSqZXJtXxFjpe2od6vikKabKbZAyXDdcYsC8v8gLdlyFJ4vwHLH4t1aLiVFzXkktIxxGhszrzrBFpjQkh8UFmzp5U+/13Y213HMhvSlBbwm3dcZjL2EWnVLIWtWzeXkcdpO6GNiDZ1F8jhdD2gDkQxqy1gHgyAdn9++M914=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=cfyioWb3; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cjfn3+zEMr5w3vvsQNdgzHmnTP0XanLl4NCGvcziZZfmoYhhc6vx7TEpxIab629CDQLfYKm8XajpHXG3CvgIbXFsMWdoqaIRnwVUp1iUrovBQsmyL29pgH5qxJrvlh001pcDuqNkty275Ud2NMUVX3tIODdQR5OpLlLsg6IKvuIGABDG1juSjHMK7NqbacjyOjAnKjYdhgg7ILYNJTX4hKIeF0DA8VOCnGukP1rQFDJLH7hlU4fIaY79xG+POAZVaGFPpBfb7PGPOolAvSei2/wHCV5vH1OzaNgALt51Itpq5nyihfYM0B5/QpdXt6Qc0sfRF64uhWNpQy3a7Hd4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fFc3HmM+8K7Ro4krbyzTVK6ehTDtwfQ40ef9FajRd0=;
 b=dsVEMrpHt+nUcpFi2hcVE8gwEdB4XuAnf5RKfzM1fRk0GVBmTeVib5EQJb51Z573ogO7Ko4pzLBNZB85CHxMprRxUtfBqvKTVCQpjeDUV3ZlGzZR9c5osB3/VJ7H8Hr4aTg4b4ciymNl+C83TrxIWgFPz4Bm3phkRQ0ZVo3pRl3yxjRsErF22IoDU0Nnz7ZSa3xvaTYdX0C7tMlxNQWUn54KWUnI01qvvZowSnGXEiJtEP6k8lHWPhurvQuPBamAMPHTscWPNrRq1mBbvd5m85N9JYBwSRIDXrWSQ24JIjv9JTCpS1CEtDPf6XJI4aLiG615ktG7K/t3pg/4BU9CCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fFc3HmM+8K7Ro4krbyzTVK6ehTDtwfQ40ef9FajRd0=;
 b=cfyioWb3CEjuycFItc5cp6nEPhClMGB2m6pY2T9Y3ykmwglK+zOVySox0qichCWoy8K1eExhbGtUepj2RNlNS5paFSpWiM6Cl40xV5Ia7jfGG1p/SjkuAP71skM4Y7HSQ8DyKQYbyiIZ6/kKHJjkDwcx0iM4lM2iaD/BBIpNz/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 10:47:37 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 10:47:37 +0000
Message-ID: <464e428e-308e-43a0-b60c-2a01213a9e68@cherry.de>
Date: Tue, 12 May 2026 12:47:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: fix emmc reset polarity on
 px30-cobra
To: Jakob Unterwurzacher <jakobunt@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Cc: stable@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260512092225.34835-1-jakob.unterwurzacher@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260512092225.34835-1-jakob.unterwurzacher@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0271.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::44) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: eddec8df-cc0a-4ec7-8060-08deb013e1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|56012099003|22082099003|18002099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	cdk0g4x9WsVXY0yYglaPV5l/18ImDi2hr9acIVZcU7ujjhspt+sydHR7MPd/bOBSM7YlUzcHunPcKdIAhURMRN15LtoGOho/RHaxhn2vBVVw4lk2iM3apjfYPsaCs/HJv6c52iZuc5FYS+K+Y2KgoULLbQbh3dUMDS/WXwNf4QuGYQUaouYA1cR8oIsrxiNyu3bFCzN3g7QUAUDK1nTW5GF0IXvf9qW9SKJLM4KUSjMXhrxtifLVFqp/xu1Ev1Qrf+C3w4qwMSR3F4lBIkf1KrtaQVFuWlWDg/6JN4QRLMQG8Ngq+flIU3j3KHEwTFLSaEQc00A3QYbR8fAlqhicWKWSxUIo+DnnipRpVGuhAgkyl5w9c9YJIe6I2j+msK9qMaWICwBi9BeRN90twmDH/mRBsBDFnlCpbJFhs+AC1+/cBtGQGFC9U159CmQ5XEXDhLCNyLdCjQPBSSjiqVdKExMO7IyWRQStKxy6D5e8EMa0py62minMANqowr4bm0ARFY8VHrzetktffOgjmhhGFtamrrH7V9dvDA5Y0G6lDzv1lQ3JFrbRH04noBAYhQTj7EJWrk4GLpERKFRgFFiQrgP0/lHK7aE+VDHPci9RO0l3hPaOn/6yleM/mo1KgRZC4XrCNNjOE7lFRff/5e8M+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(56012099003)(22082099003)(18002099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUw1a01xTDRlVFRqL0RNRjh5UENYWUt0MUZvQjlUaE8wb3NzSTJOR1Rxd3FK?=
 =?utf-8?B?Vm9MMW4wOTkvREpjWkRXNThOdkdhTlBlS3hVSWQ3ZHBWcGZYa0FucCtQMmJO?=
 =?utf-8?B?VjdwTU1iUVN6MjdzaDJ5T210VTE0VHVsSS9OSWVWdTBCMERwWWFkTEdMOHEw?=
 =?utf-8?B?eHVMaWwyRlFRRzVwamh4UFBSa2daeEF5MUJtRUUxSGlCak1TMmpqNWxOSCsv?=
 =?utf-8?B?YmZoblk4VGw3OTNISTJPSmsyTTVqUzhGTjIzUG94aXFHNUVXOTZoaG4xTkZk?=
 =?utf-8?B?Y1VXQkE1NTZQU0NDSG1HR3d1bWtQRTZiN2pJWG9MTmRKWWtmcjUxQnJGY1Vl?=
 =?utf-8?B?TVYzRFE1djV4Q0Y1Zzc3ajlmd3dCeHQwajVFdnkvWDl0OTN2NTdsWUFRaExr?=
 =?utf-8?B?TmMyYVN5RjFWWTBzRDhJR282M1E0Sktqc01nVDBLWGpRZFVISnRIYmxRMm54?=
 =?utf-8?B?TmcrOGUyWUdEbmE5Z3ZFZVh4aHRnZUNLTFA1bHA2UnNHSnl0RnkzeE5XNmdp?=
 =?utf-8?B?Nk45QU1xVVM1SW5TVkR1WE4vdkJZWDVjVmZlUjRPWXhaU2hCeEVlYURrd1BK?=
 =?utf-8?B?Ym5LR1dUeFNpb2VOTUVZTGxJQUxEcGFVeE1sYkJEdTZ4ZC9qMEdSZ3pmTG93?=
 =?utf-8?B?RGVleVFsRmlkckV5Tk9BcjlRdXZ1R28wbXlXVWdqNjV1ZjVad2wwSklPQWdZ?=
 =?utf-8?B?VWhxRkdTR3UyRWFDSHlnZnoyNmJUWFlXa2xERURraldwK215eEtFVFVadHZD?=
 =?utf-8?B?azdMcVpLUHhmTFgwbGVuTWRWV3ErSDlqNVUwZFBSbzV0bXkzWVJTL1RiemIw?=
 =?utf-8?B?OE0rczZSM3BJeHQvTU16NENGRGZ4aFphbkdCM2tHZUs4dm56R0RqZEI2ckE5?=
 =?utf-8?B?OHh6NUJPdnVZRVprTi9iK3QydFYwSFNnRWVNNUtwMlBGMDlod1UxTHNoZXZn?=
 =?utf-8?B?YXUxd3NLUGR4bUYrY2k5a1dWRjhjTVA4Q1phVTRoVmQya2xXVVdiL2JTL294?=
 =?utf-8?B?N3YrSUc1VmR3OVhPREFQckFGODNBdTNEeUxoMWJ2cXVBUXJJK0R0cnViVHZK?=
 =?utf-8?B?QXFJeE1VZmZId09vTTVYNElZZVBxSjBLRkJjSmJtMmVxajQ1d2NZbDcydlpG?=
 =?utf-8?B?QjlBM1NleEFscTN6RXk1SjlMZUd2QVBQakhhUjkvWHRFK3lxWWpUZzUzRlp0?=
 =?utf-8?B?bFZrOUNnVnZMZ3BrcnJ4TG5rZjRRNVhXUVBiQ1QzWlEzZC9PUWtmOEQ1YUYv?=
 =?utf-8?B?bEhJa3d3UzBqTElnVzJ6MSszOE82RUVVRlBudkRjV2puTW9UWE1JaHpxK3Qx?=
 =?utf-8?B?M2Zpa2p1d3MwSkdPMGNqVXBZL0p0YjZRdDJwZ0o5Sld5MEtobmhHVzVocERm?=
 =?utf-8?B?bzlDL0s3RnhnMmRRNUI2ZWNYTGpPU3lHZzR2MzJ3SjVZckxBWTl1Z3BrcSt3?=
 =?utf-8?B?S3VLTk5WVGRwQ3l4YnhhVWptVDFTVG9zK09IZVo0QndSSlppTGJTcHFKbUNF?=
 =?utf-8?B?SjE5Q0RCNm94QzNVYzRhdlMxOUNJaXdGQkZINkhjYURialF6c1lnMkRlZjlQ?=
 =?utf-8?B?YzR3dG1QaFgvVDg2N1gxZ3RiYmdOa01wdnl1Wm14YTIrMUtDaUtiZGh1Mkpu?=
 =?utf-8?B?eXJCSWFqUFZSeXpuOUErQ0FQZmhjVVc5bEVva1VQUjNSNlNUY0RkajRIcEMw?=
 =?utf-8?B?dW9FUUxldVF3MXVFNXJTY1pQTEpTQXlOeVRPVXo4eEJObW5OY0hKNGRUNFBN?=
 =?utf-8?B?OUdWektwR081VmpUaUJ3RFh3R2I5emtHWmVXNThRUGlPcjFHTHIvOXVUK21x?=
 =?utf-8?B?WnE2K2x3WUJSc0tlT3ZuUk9zWnpWUkRhWEQ4TEFCQmR0aUVBUFB0ZXZBU0xV?=
 =?utf-8?B?emhFTjRKYmhVVXkxU0hrdnIxVjRTUUFKMEZHTElLYmRESWRtRjk5ZzhkbitE?=
 =?utf-8?B?bTN6anhyR1JRZTNQWi9mVFNOQXEwOGIwRjBHK1J6STBTRDRQVmhIc0RkcW1o?=
 =?utf-8?B?RmxBMWJucmlLVTVhbkY0Wk9QT3dXODVnbTljTU14ZTQ0M083dklMT2xNSHN1?=
 =?utf-8?B?VHprNmJnVWVYV1laRS9LOGY1UktoTVZad1llWnpDWWZibGlOcW5BcEZjNHdH?=
 =?utf-8?B?aHIrN1NnUGhaeWZuVVZJVEhwYnVQQmQrVnQ3MTliLzdTZDFHWXB5VDJtTUEx?=
 =?utf-8?B?Z2ZuOWVGbHdyY1g3VkF4Zm1oTjFhS09QWGtoVHFaQmJxWXBBNmhYQUV5ZEhn?=
 =?utf-8?B?M2Y5S3JxTjBFZzNiVkVIUWlZOFowUWlhejJhT1RmTWN4Szh3RlZ1TXR0d3Vq?=
 =?utf-8?B?RWl2RUFMTHdtL3VsTnBPeThwMHc5bDdNVHkzUUZjVkF5cmM5N2RIU1ZoYnVt?=
 =?utf-8?Q?jk9JWvdnA8J/VQ5K8cU9EkapW4sOFFIh6CZlUJQO/SBkK?=
X-MS-Exchange-AntiSpam-MessageData-1: si2cdwivMXlzq3XKkQRfVLYoeERJtcsqxWY=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eddec8df-cc0a-4ec7-8060-08deb013e1d8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:47:37.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBVVHQRE2b0dq/V4GvNWF4tcqqJplph/vJRqKz9Rpc1q9GMD2AAzC1tRwHlS7oR+cK1lGZcrf/zba4DisHV8vaJHea/yeq7Fdw0V7YuQHYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120
X-Rspamd-Queue-Id: DA73651EDDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cherry.de,quarantine];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245438-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,sntech.de,cherry.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quentin.schulz@cherry.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[cherry.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,cherry.de:email,cherry.de:mid,cherry.de:dkim]
X-Rspamd-Action: no action

Hi Jakob,

JFYI, the commit author will differ from the Signed-off-by (it's your 
gmail address that is going to appear as author).

Usually, when the mail From address is different from the commit author, 
there's a From: line as first line in the patch (which won't appear in 
the commit once merged). See 
https://lore.kernel.org/linux-rockchip/20260421-px30-eth-phy-v2-1-68c375b120fd@cherry.de/ 
for an example. Not sure what's happening with your setup :)

On 5/12/26 11:22 AM, Jakob Unterwurzacher wrote:
> Technically, the reset signal is active low - it's called RST_n after all.
> 
> But it is ignored completely unless RST_n_FUNCTION=1 (byte 162 in extcsd)
> is set in the emmc. It is 0 per default.
> 
> For emmcs that have RST_n_FUNCTION=1 we failed like this:
> 
> 	[    3.074480] mmc1: Failed to initialize a non-removable card
> 
> With this change they work normally.
> 
> Cc: stable@vger.kernel.org
> Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")

This also matches the Device Tree bindings for eMMC MMC pwrseq devices, 
c.f. 
https://elixir.bootlin.com/linux/v7.0.5/source/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml#L33

Looking at their respective schematics and Device Tree, I think we also 
have the same issue on our Jaguar, PP-1516, Ringneck and Tiger, would 
you be so kind and check I read the schematics properly and send patches 
for those as well?

@Heiko, I've checked and it seems like (in addition to Jaguar, PP-1516, 
Ringneck and Tiger):

arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi
arch/arm64/boot/dts/rockchip/rk3368-r88.dts
arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
arch/arm64/boot/dts/rockchip/px30-firefly-jd4-core.dtsi
arch/arm64/boot/dts/rockchip/px30-evb.dts

all have that wrong polarity (though, without access to the schematics, 
who knows if it's really supposed to be inverted polarity (e.g. because 
it's inverted via a transistor)).

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

