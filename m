Return-Path: <stable+bounces-210354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F7D3AB2E
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9679B31211C0
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09136E46E;
	Mon, 19 Jan 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="lK7hJmYE"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B822DE6FC;
	Mon, 19 Jan 2026 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831098; cv=fail; b=T2oNKorwoftu1JZe5WUcjXx46kyqvfbpj0xeH8uEVkZrL0SUS77JeA7nOsrmryBAFRiGF9iH8oI6KKZyPKoUfzZbZly2KmOM36WRlvOB+FJ+8YAOkvG8FAIaSxBb054N7xjTJ93C3LZ8IlaLJ8uhhZuUoiK177QU9vYLVhF2HCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831098; c=relaxed/simple;
	bh=lhDAViuP4rUnCrlnJd1dyUqRmcMGS1PaPVxSvNPLPKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KTuuvSfS1tgcCjwXuqaBhwFaNV78T1au7dfNjeClkUaYf2IlpzKtR1bySXv17Ik25bau1yAyyphJ9k0br8sOjAKXq/NXnNv1971whubJlNSHl9OnH5nzhQxlGl/JD3GAOMdKnYHvsagMmDJtOuZevTreprWW1hnmng08iSkxzfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=lK7hJmYE; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7PWacB1Bktd8wokohqS+FU845DKmaGkLjCf3Waap6YJp2iIIU8XWJUY0SgHPm0gfgUwTKQl1/pM+VGyT5RolyqGSC+t8wXs4dXYQu39KoCGQF56NLEUoebuAFKYNIamReNVYVGOmTi1XU8T7UjFfZrwQB5LWWy4Kd33JN8Oz93FaSfX8k1oSgmNeTlrk2bGVT0vqi7NkcY+gDrhYWbTtXQKPR/i9ofVidxSlh2O7KKZIwhbLvQrEaZD4xq7xABZSvnjSDHFW82VkgVbDuofCL6iQpZoxc8K2h0JBNeGzjopYaaBxZOcBfd/zD6QgQAwiRvnAkW3e6Mj5vCj9FUauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De6LBtIsarjhgHznQrdcHqKCZGf90DApGv2dI9tJjEE=;
 b=wFUMNJwViNU6aecWcHwvKe0o3CU4memK9G74vgIiHsgLpXILtn7FXcG/LH3ee021XA5SplYlizDx1RBY8ZKyE3n2S/qfTIw5vkJFamaxlOf/R10NbBSzn6roASY5vfPH5fsfbfEyxIgP/+XRB3X+T0Qm7dFR68GWOosELkyezl9HI84EeXXGW5bgYM4hUWJT+A+QA7Bz7sKUgFjm0o/35ceXammlp0s0ZP3GO2bXYlBPmuy9I6MK2AhUgl0XbQS1Uf+pV+uFWYo3nnSo7W63elYTM2VSena45lENRMVEUHGXCk3L8kIKZa2aRx7U5GJBrVtw7fjtWhBEqZEzvvIR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De6LBtIsarjhgHznQrdcHqKCZGf90DApGv2dI9tJjEE=;
 b=lK7hJmYEopsDMo0wj+8UBFvbwOwvdeu3NnAe6aOfYsIXQeiAriSBmx4mcpFrMOz4uwYkixNk/bKEbC8e4BmyeV7xRwrM94fTMwFSbx79JW3QNyOGYXr5YLcoes71I/4JAhfLYRscTFuna8HRhAHa7MVHAAmLNSzQ0NiiRecDpsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB9207.eurprd04.prod.outlook.com (2603:10a6:20b:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 13:58:09 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 13:58:09 +0000
Message-ID: <d3b5f622-36ec-42ea-90da-3c056e1b6461@cherry.de>
Date: Mon, 19 Jan 2026 14:58:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on
 RK3576
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Manivannan Sadhasivam
 <mani@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com>
 <b0904cb5-3659-41cc-8395-79eec9e82f01@cherry.de>
 <CABjd4YzJud4ZZQ_GrOOSnfEVG7wgHmPSf9w8oQhLVSx6WXgN5A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABjd4YzJud4ZZQ_GrOOSnfEVG7wgHmPSf9w8oQhLVSx6WXgN5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 859bac44-93e8-46bf-7608-08de5762c72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVg0MFRmNWhVY3d5b2FNdWVjS3hLVjI4MnlodGVRemZHRWNvL2N5ME94V0dB?=
 =?utf-8?B?YXVFbVVnU2QvcXJKMFNDbEhteXIwMEhrWnYwaWhKc3FzaDhhWjlzbm41RnlI?=
 =?utf-8?B?cENUMEJJaHdEeDdDb2I1eVh5THVZZTN6VVdHdHZGS3doY2huK09UamxBc0g3?=
 =?utf-8?B?bGUrNUNEVDQ0RThBL0dHNE9BbjAxbkxmbGpNS0VKUEJXV2hJWktDNjYvUFVM?=
 =?utf-8?B?N3JWaUp0eXlxd1BiVVRFRTcya20yeTQwUlhUd1V6TnBySDNzbmdvcE5RMVV3?=
 =?utf-8?B?OUc4OGsyY21DamNiWjBQSWMvV1FDWDVORzliSmNrM2pZaS9FQXNpWWtqQTNi?=
 =?utf-8?B?a1JlVVR4YjlUM3U2dFhqeWs0bG9sYjFBa200SUxQa0JHQjAvNFdsMmQrRDZ6?=
 =?utf-8?B?RUdSdHhvcUljZ0xJUzZNc29sSUJpQVNEbC84QWZxRmlFaTQvR0RWU3RDTFk1?=
 =?utf-8?B?UW9lRnBWWVRDZitEdnUxLzlUQkxSSVZoaW1YbGRUWUdLTWpvSldZNWVrOUhp?=
 =?utf-8?B?YkdnVFBHNVZGVFpncUZCYVJrcE16SldNV216TkhkR05FWDRjSWdOT2FWbmpC?=
 =?utf-8?B?OEhNekJLQndlM0NYa2Y3aitTV3lNSElLbU5sS3NJcmZOVEJPNDYxRDhSYWlX?=
 =?utf-8?B?RlBFUjFSWVJiQS9oRVQwN1RPMldLOTd1ZXUraXRvaTgyVlhMQ1VQdlZRUVZn?=
 =?utf-8?B?Z1BJTk41c1BGOWtjc2kyZHFDcTBFNTZkTEtHOTVERFQrUDJNQ2RtS0FXM3RN?=
 =?utf-8?B?L0F2b2QzSVg0QTJ1WjE1U0JnOGhvSWtDd1NKSjV0MFkvcHgwZzc4VVAzRTJR?=
 =?utf-8?B?UElSQm92Y1NwTWkwUURpdlQ3M090R0JWNjRtaEE0VG1GQlJKa0J6UEY3czJD?=
 =?utf-8?B?VlZQQmplNWUrNm9PdlAzTHVaTmxiUnRmUm5naGlZazRVbExHM2RkcG9aY3NL?=
 =?utf-8?B?UnpZQXFmN0psL3RjbG5VenZFcjU1MzI3M0g5cG41TnA5c3diemsvM1Z4a1hI?=
 =?utf-8?B?TThYeGxsQXZiS1RqRE44aEtjOCtjckJ4dnA3bXZ1bGloTjlpamNYNFlmRnVU?=
 =?utf-8?B?ditraVZ5MmFQc255Yis4YVUwNGc3QmJSZUQweFpxZFUzV1U4TVI1RzVuaHkz?=
 =?utf-8?B?TzA0eGtpZUFFTDFBRXl2MTVBalVya1NFMkJHbVVMMGhRYmdYMzNSRE9iWkpU?=
 =?utf-8?B?K0VsQzN0ZGh6QzJxSHBOMW5rV1NwcElQQ1YzZFZiWXJoR3BnMHJjTEo4aWlS?=
 =?utf-8?B?WmJLbFJmTmxVeFR2K2M5YzM4eGs2Y0FOWEVsdW9NNHFRQ3JPaXRFSy9iM0Uz?=
 =?utf-8?B?MmxhUEdkWGJlbVJic2R2dWRlYUVWMXpsS3JVZHc2ZktnNCtySmZpV0s5WnFK?=
 =?utf-8?B?L3ZZUm5qQVRDNzBKVFhZYXRnZmJ5QmNZa0N6d0xGWmNDazNEWTFpaSszUWRL?=
 =?utf-8?B?aVM0NHZFcFBYS0JxNElRNkJ1TGpDRmpudDArWUtsOHVGeEExcDJFV3hHWUho?=
 =?utf-8?B?dVBETml3empPZGZKbllLbGVSVXp6SWxKbWZKYTRidXlWTW1wSHQyZkRGYVhK?=
 =?utf-8?B?RUpXRnhvTGlmZ0JmdytLcXVISmx6ekFjNHQ3RUdOeStIaFJIOXJuU2xwbGFZ?=
 =?utf-8?B?SkFqWUIxZ3FCVStyM3ljQThQQVJPb01yVlNEMHU3VStsTkpUanZpZHZNLy9x?=
 =?utf-8?B?Sm0xN1hndGNVZFFQOW0yM3dqTFVBUWgrMjVHZW5zYUx0ZTBFTWFqbVhNWU5V?=
 =?utf-8?B?emMrL25FM0dBbjk1SHVkSTRNeTREYjZjTGMzN1F6SGpSL0NPOWkvZ25jS1RI?=
 =?utf-8?B?cTd0QWpxaUlhTkJPdENwWGowalRHUHEwYnhET0FBdktPTU5OdVA2ZFBYZTJL?=
 =?utf-8?B?NGFkYVpIQWNlQ2dMRkx3Uk1aZHd0UHR1QUJRZDhUQ2g5UVJzZFlUMkpUTlM4?=
 =?utf-8?B?ZS9wblBvdG9WdnVJOEdoeHVTTHg5NTlMekJnR1dSdmYwQXVoN0wvSHdvemhC?=
 =?utf-8?B?UzlKd0tETm53bTlNR3hsT2JqRHRpYVcwV0g4SytDQ3pqc1QzL0M5bUdTdE5t?=
 =?utf-8?B?OGtaM3Q4SnBETDIyZFJOenA1eFFiYTFIaHBLeng2YU85d0krd0tOYzJPcGZ0?=
 =?utf-8?Q?eZnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SERtTkJzekl2OE9BWjVkQklmTXA1d0dRZk1vOCtjcTBydVB5a1J3N2trRC8r?=
 =?utf-8?B?RVZ1dVhQb1B1Y0RqMzcwcHJiZmtBQTdWYW56N2lDTHlKZ3lUOE5heUkwSGtQ?=
 =?utf-8?B?eUpxWllzRW1ENG1XWjRWTlh0dUpFdUZ3WGdZaXZTWkRJYnRzU2lxdE9rNUVh?=
 =?utf-8?B?QmdOdWt2NkprMitHN2d3dENjdGQ3VnUrbUluTWRhaWZ0L29rVXNHMFZnZElK?=
 =?utf-8?B?bXRUWGoyRGl1dWZ3b0xSSzdpV0M4MU1IRWJDREtEdDkyODhNelBpSTNsV2Ji?=
 =?utf-8?B?K1BoYjErU3R0ZTdoV0JOZHpXL3lSWUlLbGsxcXBLTkcvdzNEYThobGpkZFo5?=
 =?utf-8?B?U1NlMGNZRVkvRElyVnhlVWxaNGxrOHNFcnFLMno4RVZ6cGdocldaZjEvRDRZ?=
 =?utf-8?B?UzMxRXdZc2FLaTdodFo2U2NVTDIydUE2MWhOMnFIRXBMRlFJVStlL0trTmpy?=
 =?utf-8?B?d3BzbHp5WGRWVWVyVXBFcDBTN3c2bEZCM2hSTkpkcUlKbE53ZXB6NjZsZlNB?=
 =?utf-8?B?cEdnYnFyaEpjMVdEQmh3elR5cm13c0RoTTV1ZnEzOTBpTElicmIrQktCejMx?=
 =?utf-8?B?N1NtcSsxMEhRNHo1bnZOUkxqMzJGQzh5R1JXWmlFcFdQZFRpQ2I2alBabXlZ?=
 =?utf-8?B?V0dNQXRQUnpRTUw5cUJWMldOQWhiUXNDMkZIKzB1dTZTeVh5Q3ppT3VaUVVT?=
 =?utf-8?B?OUZ5WTNtczBKQjE2bXc4T2djaWVIRlM0bW1vSjY4T0RWWUY1WjdqUUU2UDdL?=
 =?utf-8?B?TjQ0ck1xazMxd3VaV3g0N0VySEJjRkZ4K0hNYUE3c2FZS3UvdVZIeG04bE5s?=
 =?utf-8?B?KzlFbG1pSTJhblUxRlRFM1I1NE12ZFVBZFR3eDRJQXN3WWR0ZnFLT1JMdE95?=
 =?utf-8?B?cU5mZkFkWTBUU0YySmdDTlFSbERQdU9sSzZiWVNHSGlzYnRLeEJINGZiZXo3?=
 =?utf-8?B?Z1JjNURpaUVqTmtaRDhqQ0t1MktVTTIvQ1FOeWVpSXJlMjc2VkozQVV5L0FU?=
 =?utf-8?B?VGxaZklWWEFwc0twWDZZWDhXWmJYZEQzblloK1NJR3d0QTFac0hzUjIzaVZK?=
 =?utf-8?B?UXFVQzdaQWwvZzFvRXE4RnpERk1GNXphbzM5THU0WGdOSjEwRGp3VzdhY2gz?=
 =?utf-8?B?Qk5lUHZ6Y0ZDMXpMTW1NcllRdGtRUzhaN0NVTGEzSzhOMVRNelpsc1BFYjdn?=
 =?utf-8?B?bmg3M0gyK2diWDYrY0I4T09DMllKOXFxdFYxZmVYMW05eEJwSFFpNHhUa0d4?=
 =?utf-8?B?Qlh3Nmh4ZVpOaXVZNTBFbHBWeUVScTVhZU53QUlWQ3o4OXhERnhvRm1hS29m?=
 =?utf-8?B?Zm4wanNDUDEyT1NINDRZUm5QbGRtUGJZb1M1VXEwcFp6M3kxdVdrTlB0bUs4?=
 =?utf-8?B?VGgwS2JPaGZDZEpXNWVjRnV6ZGY3cExHdHBZS1lreDFsUnNzVEc0Nis2QXBY?=
 =?utf-8?B?MzFHcnNnbi9TamZvN1RUUThFdW5JNk9VWUpuSGlNRDV1SGh4ZzRKaEVIMkNU?=
 =?utf-8?B?b214dWwrSWp5aWVqOEQzQlYzaVJvSHFMU2w0SC80Zjc1MzlIZFNJcWhWTHht?=
 =?utf-8?B?RFU3UXUzUEt6Q29kMDBneDRuRE1pVjU2eWV0eXpPVGJtMHZHbmMzd2lMZ2N1?=
 =?utf-8?B?c1AyOGdMNk9wS3F5dW4wemVPYzUxSDdGRWtmOTZYL1FLbWVMRHFiSXNzUVF2?=
 =?utf-8?B?UDc5bU1OSldjVzRHR2xOaWN5ZnB6WVJ6a1ZEMk5GNmZWK3hNTjkzcG1sSXdH?=
 =?utf-8?B?Nmh0MU00WndwWjZ2NmZIMCtrQTMvVEVHQ2M2VFllaE9iRnc3MUc2cEZxcXRn?=
 =?utf-8?B?TFY4a1VPNk5OSFJpMFptSG93ZXE5UlZCZWQxRVJmazFDNGJHRVoycy8xY29h?=
 =?utf-8?B?SUpnSU4xSEdhS09xdFMybGZqcml5N2V1ZGhRNi9nZW1kaUNhUjdRTkhyN3Ru?=
 =?utf-8?B?WUJZUThwZnlyMVQ0VUF2Tzc0MkxvVlBNVEk3WWJ5VzZ0NlNWQVk1QVRZNXQ5?=
 =?utf-8?B?NHpCUUdzekhrT3BZVWNNd29xZ3E3cUNMOTlKbjlWUWViK1JHZERscXIzN3lz?=
 =?utf-8?B?VU9OamsvUGg2Tms5cUM5NHZwY0duMXB3TElNZ2wwU3gzWmQ1SE9vQmc5RGVr?=
 =?utf-8?B?cjJSMnlLa3A4aXBvcGtCSUFvamtCTnIvaXluMktZcElkOWgzY1ZxejFIbmFY?=
 =?utf-8?B?ajl6cmlFbk1VT2F0eVBlYk5TMGs4Yk5qNlpZNGJFTGoyQ0hUT1U0WCtPQVRt?=
 =?utf-8?B?d0dlZU9iWmI5c3NreTNqVGFueHRJTVJnZlI2SCtZd0FQdldXNDlFdjg5VXlE?=
 =?utf-8?B?bUdOWUd6elNXVjVNQlNNOCt3UEEva0lGc2U2eGluRWZJMHFpV3FubGxvUHhE?=
 =?utf-8?Q?H1I3SGaMD4qo00iBFqJB2dK0NQyszbaQn4Ob1?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 859bac44-93e8-46bf-7608-08de5762c72e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 13:58:09.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfzrleJXCQH6prjU1qElrpxXR1s/1uKHGyhfpKqeDGAUQldR2jVLuirFWa+t58i5DiItc9ClU/05C2BScdEcJ+l9nAr3kvWhrhbtyGBV1Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9207

Hi Alexey,

On 1/19/26 2:43 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Mon, Jan 19, 2026 at 3:08 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 1/19/26 10:22 AM, Alexey Charkov wrote:
>>> Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
>>> UFS device, which can operate either in a hardware controlled mode or as a
>>> GPIO pin.
>>>
>>> Power-on default is GPIO mode, but the boot ROM reconfigures it to a
>>> hardware controlled mode if it uses UFS to load the next boot stage.
>>>
>>> Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
>>> device reset, request the required pin config explicitly.
>>>
>>> This doesn't appear to affect Linux, but it does affect U-boot:
>>>
>>> Before:
>>> => md.l 0x2604b398
>>> 2604b398: 00000011 00000000 00000000 00000000  ................
>>> < ... snip ... >
>>> => ufs init
>>> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
>>> => md.l 0x2604b398
>>> 2604b398: 00000011 00000000 00000000 00000000  ................
>>>
>>> After:
>>> => md.l 0x2604b398
>>> 2604b398: 00000011 00000000 00000000 00000000  ................
>>> < ... snip ...>
>>> => ufs init
>>> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
>>> => md.l 0x2604b398
>>> 2604b398: 00000010 00000000 00000000 00000000  ................
>>>
>>> (0x2604b398 is the respective pin mux register, with its BIT0 driving the
>>> mode of UFS_RST: unset = GPIO, set = hardware controlled UFS_RST)
>>>
>>> This helps ensure that GPIO-driven device reset actually fires when the
>>> system requests it, not when whatever black box magic inside the UFSHC
>>> decides to reset the flash chip.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for RK3576 SoC")
>>> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>>> ---
>>> This has originally surfaced during the review of UFS patches for U-boot
>>> at [1], where it was found that the UFS reset line is not requested to be
>>> configured as GPIO but used as such. This leads in some cases to the UFS
>>> driver appearing to control device resets, while in fact it is the
>>> internal controller logic that drives the reset line (perhaps in
>>> unexpected ways).
>>>
>>> Thanks Quentin Schulz for spotting this issue.
>>>
>>> [1] https://lore.kernel.org/u-boot/259fc358-f72b-4a24-9a71-ad90f2081335@cherry.de/
>>> ---
>>>    arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
>>>    arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
>>>    2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
>>> index 0b0851a7e4ea..20cfd3393a75 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
>>> @@ -5228,6 +5228,13 @@ ufs_rst: ufs-rst {
>>>                                /* ufs_rstn */
>>>                                <4 RK_PD0 1 &pcfg_pull_none>;
>>>                };
>>> +
>>> +             /omit-if-no-ref/
>>> +             ufs_rst_gpio: ufs-rst-gpio {
>>> +                     rockchip,pins =
>>> +                             /* ufs_rstn */
>>> +                             <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
>>
>> The SoC default is pull-down according to the TRM. Can you check please?
>> For example, the Rock 4D doesn't seem to have a hardware pull-up or
>> pull-down on the line and the UFS module only seems to have a debouncer
>> (capacitor between the line and ground). So except if the chip itself
>> has a PU/PD, this may be an issue?
> 
> The SoC default is indeed pull-down (as stated both in the TRM and in
> the reference schematic from RK3576 EVB1). Which I believe means that
> the attached device should be held in a reset state until the driver
> takes over the control of the GPIO line (which, in turn, is consistent
> with the observed behavior when reset handling is not enabled in the
> driver but the reset pin is in GPIO mode).
> 
> Are you concerned that the chip might unintentionally go in or out of
> reset between the moment the pinctrl subsystem claims the pin and the
> moment the driver starts outputting a state it desires? This hasn't

Exactly that.

Imagine for some reason the driver EPROBE_DEFER, there can be a lot of 
time between the original pinconf/pinmux and the time the GPIO is 
actually driven.

At the same time.. I guess it may not matter much if the UFS chip gets 
out of reset temporarily as (I assume) when the UFS controller probes 
properly, it'll do a full reset of the UFS chip via the reset GPIO. 
Don't know anything about UFS, so maybe there could be damage if the UFS 
chip gets out of reset if its supplies or IO lines are in an illegal state?

> caused any observable issues in my testing, but I guess we could
> explicitly set it to &pcfg_pull_down for more predictable behavior in
> line with what's printed on the schematic.
> 

s/schematics/TRM/

I'll let Heiko decide but I would personally go for a PD to match the 
default state of the SoC according to the TRM.

Cheers,
Quentin

