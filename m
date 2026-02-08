Return-Path: <stable+bounces-214868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKs2HU/UiGmhwwQAu9opvQ
	(envelope-from <stable+bounces-214868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 19:22:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7E7109DE8
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74B3C300A8FA
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8202F6179;
	Sun,  8 Feb 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bs6shak9"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC281D7E5C;
	Sun,  8 Feb 2026 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574920; cv=fail; b=LHcDp/ttbP65xbi2Mg0s65TcFQR40Pl+GLBpRt+j+5kL+AzcAv2l75qPw7FLJ5HwSrHUx/M/k0rP+8y+bvk6Pk82fSWuY1SyNYucZpw3UbgbLojooI3Fb3/4VPMUpZpJmlh6xUnnPTtzkJMCuRUkzfTLJwGRAzMxOFuwsTIJiEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574920; c=relaxed/simple;
	bh=WJUZZxrysHkZ9hxJQZzSx83V+Qr5Sy1hikErs+1MhiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tfZ1elZATu1KHJdpUhM2CfPlk5dGrfQo+pn7nHo06sxgYQfQy4mZ6TDMkQCda4ZHhmciU4Smzv5JmQDcpWfcoqMBeXVz7DAkKyrOCrtwJIYaQa8qgHgSB5IN2XyIgapzb2HFlIbRZiJ6nYFxE46qPI32EV6xtVkHVU0ffwAtmW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bs6shak9; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGv/9IIbr0T1gLFqvSkfDmU6o/sW96SwMinuuHBWEgiLb2OH2MNTM1brqO+yZAa8nbXg2aiqqkabK/EDULfo0AOxOIEExg9zt97M3VfghP+DLkj2tKsJ7n9XV04jKUEx6PA/y0M+RBg44e/d63EIu6h5x37u49IO7+GQImqPVafo32gASdHRiHJO4/6gXG5UsYklPNnPzWlEa8SBBZw6Lm4EG4Mdym/9Wn3TEurkYHq5suVVovo66ZB+2fDPNo8WHygthhZ6TRVzlOa8nwHIZLtMVyyL9sIfizonqDd0wZmMXP0QAwrhx7LwtD9JOKUA/3IfnWQYRh7YoKcCD1rn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJWzFgcRg0KDDW//oavdTUluo7kdAE1wjDfyOhYWaqg=;
 b=AAga4ej+owD08eEJSV9i9n+Rkop+oKhofVE9heX4KWncZgoNio9CkzkeiGSiyO0zHooNEs7yyVxn3Za+nY/O/v0SagwFisNXIGtyQEX4wB2LachkKEnjE40Eg8syLSAjhqat/HP7IdgqmlVSgiy6SKnsHzSz/BOJlBC7BLUZb+elcxhklpoUf4UgYfr3NtkcK7Q8BrZ+ZminywzrcR5XI+KlDapVs+tto5CMjD6sc4P3wpqVQMOpAFGKXyW+Z5sYxccpIYpVXR9WJDkiIBtcbDH7ug9FRPXBBZ/6vHd1yE9lN3Upov/c4IIlt/8A26Zp/E3P1qFxtex2QpgV6U2Xxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJWzFgcRg0KDDW//oavdTUluo7kdAE1wjDfyOhYWaqg=;
 b=bs6shak9Xy7ZUFKDomJGYhLCCEI1N7/xhksYuJvqiZhBA0x89EA1v4zme92DsRG1/kymv0HaUWRn8aETUf8Pff0Q+fJjz4sWTRTyANN0mSrzWnO/3KUIle9X8/5GhXkRLTdYPe8jtE2lbPSZH5HxRZh4KwWK6tmN9Y1TXYw1JW7h0A1U+fqEqjl4GdKH37g6JB1m20wgRA0U9oxwjRK39SkSGnu0fmT+u4/amJ5ytNvIZo+ur5WvPOsNV08CQ0Sl1zCo7jSEi951TDY7WH5wNEqMq1JUHf7rJZFQSSeGUuLLJEm1aFUQ/7iKCtO8i8VvmOXi8InBCNIjSmRO6nKNCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Sun, 8 Feb
 2026 18:21:56 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9587.017; Sun, 8 Feb 2026
 18:21:56 +0000
Message-ID: <9a99ed36-7213-4851-bd17-d61a155a3e17@nvidia.com>
Date: Sun, 8 Feb 2026 23:51:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: tegra194: Reset BARs when running in PCIe
 endpoint mode
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-7-cassel@kernel.org>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20250922140822.519796-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::19) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: e9303402-deb4-407b-f851-08de673ef107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emtpQU1BZXQ2NlRNSmRTb1JFTGI2UDFPdXBBVGN1SDh5QzdndzU0QW9FaDZ6?=
 =?utf-8?B?YmRXaGlBZWkyeXF0UEttekp2R3hyaWZ1Q0ZXKzJlU2t0SnBLRVpLWWl0OW92?=
 =?utf-8?B?M0F6dTFRS0NMeXg2b1p1TExzSFpPSzVCWC8zVlJlUjRJVy9SNi9WVlNmQ09r?=
 =?utf-8?B?T0diMnN4V1V6M3NvcllYcjVVN3dtTllxYUUxNm13dTh2QnVKQlFEMlhKOTJz?=
 =?utf-8?B?cEd6dmRPYjIwOWV3d08ranpPdmMrSm9MNk1JM1BpTTdONFdrQ2RPVzcyb3Vm?=
 =?utf-8?B?eFZQNmFaUHNRekt2YXUycEplcGlSU3hwQ3J3bWlhejgwYmpKZkpCUHE0MllK?=
 =?utf-8?B?dExFZi9DWTZBaU9iQWU1c1lkcXlIdWtVSzR3RXhXcTNSTmNNMlhlYzFuNFNX?=
 =?utf-8?B?VllLUGZuKzl6OXlhS3ZYWUlUdDVCYjNsUGRNWXNjVGhSVVNQcmtrd3dOTHY0?=
 =?utf-8?B?SW10SVZGMDVFTTlxOU90K2NNOGJYejY0NGY1M3NwVXhWTUJncDlXWUw4YjJi?=
 =?utf-8?B?UHpPQjdtaWlRSExQbExrMUN4QTFReXZ3c1N2T0pCbjNGN3M0NHpNaFpkR29B?=
 =?utf-8?B?T0drUWVXYWJLTFU3TVpUOU9WTGhkc2g4QXFabnpPTENTZlRKUDJQek03ZFNo?=
 =?utf-8?B?SVFzdE1HNEhKMnpiT1dJRHpYbWZFUFFoaVEycGJYUGV2TVUzM1JFaCtVZzha?=
 =?utf-8?B?dzR4aExobEZRZ241NTlmR2d2Y3dqSUFaYmRRUzFuZFV3NlhWMTlVQ0xsT21E?=
 =?utf-8?B?UDFOR0NzK051bHRJTXFYSzZQdGVRdjgvMWxvZ09CVmRJUHUwSE9UTVdJQ0xa?=
 =?utf-8?B?MGo4c2VFT3MvMFJpKzNwNUZEVmNqdHQrTm45TktQRVZaM2NUNWNibGVpUGRm?=
 =?utf-8?B?WnhqdWZxcDkwY0RXQ05KQU1HeDkrVVVOdDBOWjM3RjhZRHVvNUxzMmN1dyto?=
 =?utf-8?B?VHlmZnpjNE90RnpuTDRjZ1U4Zk1JSjByKzhoNDg1N2ZwdGZOUFV3MFZtKzRt?=
 =?utf-8?B?N3Y0bEtCVXk5c3F5eHdURVF4TU16b0FTWUNnckhxT3Z1WmxJK1hVOTNkVW5E?=
 =?utf-8?B?UnRjUzlpakwzKzJIVTVyMVVlWXdBVGxNYTBwcG81ME0xRmFteXlwaGRFYkJm?=
 =?utf-8?B?RXNMU0RxM3JvbnRXSk1kMTBEV3F0RzVMbmNzMGVncXA0dmdXSXpsM3YyTkV1?=
 =?utf-8?B?V0FCV2FyMUZQeWY2bHRkcDAzNWE1clozeEVFL0VUZGd3azNTa3h3NlhTdzB4?=
 =?utf-8?B?eDhUWjZVYitvR0loS1BseHVxN1VBTXl3NWd5Mm52emVxcmdQeExQUWR4Y2xy?=
 =?utf-8?B?OUszajdTcnFMcG5CNGxMM1JvM2I2Y0d0QThsZXQ4dkYrYTVqMWdjZUhLbmpT?=
 =?utf-8?B?SW1Rd1VUVlZBWi9PbXg3Sm1vWllxZFNpVnZRY1JwTEo4RUFITXp0cFhoeVVC?=
 =?utf-8?B?WjR6cWg0UzNhZ1F1eVM0MVhoNW9tZmpSb0R6OWQyR3BTek5VL3JPT0tWVW9G?=
 =?utf-8?B?eTlHaVZwUEFwT0ZKdmE3c3UxbysrSWF5UDk1TVNVenVEblNUVVBwT2JiWW0y?=
 =?utf-8?B?WkNvc2dzRkQ3eXoyYy96MHRSaTIyNnM3VXNNcFVGbDEvUCs5am85ZitLOVpx?=
 =?utf-8?B?WnkvaTlOTDRLRmFNQUtTdXc4MzBPQk9EK2UyRTk4WnBVNEJvREphb2RUT0lL?=
 =?utf-8?B?eCtCUERocG1ReTBEcjVRWDdqYU54c1JWSmJzM3VlSnBSeW9WTHhmNWhGSmpn?=
 =?utf-8?B?N2FZQndCWXZKSmp6N1cyb1d6emdNUWdRWmZ0a0d0WWtKemV5K1M1Qmp5N045?=
 =?utf-8?B?bTR2eGlrWUhMSkliY3Z1cUpRQ0dlK0dXL1k1YTNyajJCSmxwanMxNUNDNVZY?=
 =?utf-8?B?TmtVdXR6cVpldTBOb0cwL2k2cUJNN1kydW1JSE1nNU1ZZVNuZ2UreUdvL0th?=
 =?utf-8?B?WkRZd3hWOGxNZi9RTE1GTnhOb0doVkZhRnJPZUNMZGdRdFFwOWV6T1ZqM0lZ?=
 =?utf-8?B?TXRoUTNPMnVhRG5pYkR1ZHFtamN5M2JEcHRRSHhLRlNWaG9OOFYvUFZzOEdR?=
 =?utf-8?B?c2dYWHhTUWJXRlcxYjFoSEFxMkYyeWE2aFFEMCtIVC96dVhUWjdNQk5zMnNS?=
 =?utf-8?Q?cZ4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LysrUXdxcnpTNWtBY2lOVFRUT0VDN044R0RXd2dUMGlWQTM3NG9rRDNXcDFk?=
 =?utf-8?B?MXk3bm85Q2hwUnM3Q1kzdWpDM1lGV2U0SzNQblZvekVrUUU0UXk2dTdVRmpZ?=
 =?utf-8?B?eG1KVGs0Z1RUb1BRWXdqL25rbFdJN2hRdWhtVTdaZGpSWjhGTlFTK1ppekNV?=
 =?utf-8?B?OGtuRW01ZlZ6aisza3VhRE1zMlRvUUlhbmVIai8vbHVmQjZPd3l3MTJoQk5L?=
 =?utf-8?B?T2tncWdha2t5ZFZCTUFSVmZzeWFHWi85NWlDa3MzN3hrbkJLcG1VT29QMW14?=
 =?utf-8?B?Rk9UaHR4YUUvalpaNjlnTG5BMWhpMkd3d2RIWHJWWnFZd1JZbDkvTmk1UGpt?=
 =?utf-8?B?Y0FBc3pKR3VXZHpRdVFZbGM0bnlQazc5eW56czUvcDY4UVlWOGlJQlZ5eFB4?=
 =?utf-8?B?Mmw5L014UUxDZmdEYStvZjJmY1JCQ2RmQ1BXNWlYU1FURGlYUlUybDNiaGJk?=
 =?utf-8?B?Sm0vN2puOUgvOHd4bU5xUVFUdEtOcDhPWnp2MmR1WWtjTmtrZ3NINVgwbGl0?=
 =?utf-8?B?eWxTSlRrL3Q2L1lGQzNhNGpoT3hlMFRJdDBkTE9SczBFdHdwVC8rMHlLUW5m?=
 =?utf-8?B?Vk9GSW16RDU3ZmJSdXlsdDlYbHJLd0JlVGZUY0FTNFlPbm4yODN5ZW1sbVVh?=
 =?utf-8?B?a3MvMUgwWXRUVUp2V2lINjNPSFNWTEFTNHN3a253dU9kRDY2T0d3ZFJvQkNN?=
 =?utf-8?B?TmNBbVIwNXRDT3ZOa0RsM0hEZGQyQkZKWUZ2WXZNU3NnQzdabjcwWlBsTzlq?=
 =?utf-8?B?a1N3bUFIc1dlSjlBbTBaeE95TFJjRXdNcmZVVnp2ZFlPOVA0YlowcmdvOHFr?=
 =?utf-8?B?VS8yT0R0RS9LK29CeWV4cjZYWGhzNjFjL0FpcWJiZmNOaktUSjZMMFpkSGxJ?=
 =?utf-8?B?NWt4STVHQXc5eG8rWXNaWVVWaStOQTdlbFlvY1FUcDM2QjhmcTluQ1VBQ3Zj?=
 =?utf-8?B?UCt1RXluR0lKQjBiYm9oSmRSNHZFTzZUWlQxb1oxUC9kMkUyV1FGaTRtcnVn?=
 =?utf-8?B?clN3UlFjUVgralhvWHUrZjYyZFdZNVhVamh5aXY4eXlJRnZCUjMzSDl2Mzg5?=
 =?utf-8?B?bFA3emZOZWxnZ2liMWZJTytPcXdPQThKOStjQjB0bk1xV2Npb3ZZZm5lT0Q1?=
 =?utf-8?B?dWRGTDd5WVJFR0JQb09PSUV4TERDTDNNbEpwb1ZxYXUrVGtYVVJrZy9ObEUx?=
 =?utf-8?B?emYxSDVJQ3hla3pDS2hUTVJ6Q3pjWjlzVW5mcVphL01tb3dBQ2lDTHVKVkNj?=
 =?utf-8?B?aUF6TFpCZTZoSUE2R1BUTDRPUStFdmR1OVYvQ1N6Z2J6enlRQXVRT055MGwy?=
 =?utf-8?B?NHFYWTJZZmExZW92ejNzMk9CQlFxYkVYYmxiZllTVnQ1VStpZXlEMmNLSUt3?=
 =?utf-8?B?djUwWlZ0akE2K1ZQUlZkZHhOSTlxczg1NFAvZnBObDV5cXIyN3VyMUN0K2tD?=
 =?utf-8?B?YXZpZVdXWjB1TmduWUJ3VTZDQlhmK2NCR29ab0llVG9Va1B4ekdDWTY1Wi9P?=
 =?utf-8?B?cUREQjNKZmFqaHNlVmJqUk1iWFVJK1RzeGcxVTFDZWtHVXliUzJ4RWlqUXFG?=
 =?utf-8?B?RGpuZzBGQTFBTHVZMUtNeHdRanljZnFLVFNKWkFqVzgwNnU3MXI0dmdNU1M1?=
 =?utf-8?B?SkNUN1h1K0UwSnBYTDVhUFVzMkhhcWtjQXZBcWJ4UTFxMWJoRW1CVncxdWNP?=
 =?utf-8?B?MGh5bjM0amNDZDVzZFlHRTlFYkthK2FQeExZZEZ3dWV0OW1XMGZraVNWbURR?=
 =?utf-8?B?dkROTFA4djR6dm1PdlFoVmhqcHFaOWJIeTJ1T1RvanhPZmVCUzI2bkdUUDNV?=
 =?utf-8?B?bGE3TFlNSzIwWHNMZWFha1R4bjd1NDF1OFpoeThQaDNmY05qbEUyenNOdDlT?=
 =?utf-8?B?V0gvOXZGVS83SXE0QzQ5dml0UTh5R2JWMEFOOVpQVFVTLzBnRzVLaWNlaGZh?=
 =?utf-8?B?eDZWWTRWc1kzT0FRWXEzOTRaQ0dBNGdGa2NFSUM3WEk0VWVaek5KSExrdkhu?=
 =?utf-8?B?OStrbGRkUGd3VlVhbGt1ZnVPY1pkS1hST3AxSmlLVWVRdFRWMzZ6TXpUL05q?=
 =?utf-8?B?SDZtWEp1ZjZBRVNyVlRTQlAzelFaYkt0SW5GK0J4aGRTS2svdkwzZW1BYmc4?=
 =?utf-8?B?WHJ5ZjNJMnRuOE9qbEtwL3NlaHJZNFQvelhBamNaSTJsakxqNmhoZFNKM1o1?=
 =?utf-8?B?M2dNOXVxNHdaWGRVL2N0bmpsb1laSXI2cGVxQ2dUbFd2b3hRVVZhT1pIYVdi?=
 =?utf-8?B?QWxtSVo1UENuWHpsMWVEeXM2dTVkL0tBcjQ3MHBRbmNYR05DdGpWVHhOSGov?=
 =?utf-8?B?Y3RhSWFiTHZ1UXA0SXAzbDBBOXU3UmNuZ2d3RW9BVlk4RmxwWTl6UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9303402-deb4-407b-f851-08de673ef107
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:21:56.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvTq83yMDcDvXsRCyXIGw1LhUXMLcLx4oHPoVu1tSRE1A8YOgqTX3tLbn2IQxF1ZkJrLJwuGNdRx/VxkL5ndVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214868-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,gmail.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaddireddy@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1E7E7109DE8
X-Rspamd-Action: no action

Hi Niklas,

Tegra PCIe controller exposes only DMA registers over BAR4, iATU is never

exposed over BAR. So, this bug is not applicable for Tegra PCIe.

However, because of this change, BAR2 & BAR4 is never enabled and

I don't see BAR2 and BAR4 when host enumerates the Endpoint controller.

I think we should revert this patch, let me know your opinion on this.


Thanks,

Manikanta

On 22/09/25 7:38 pm, Niklas Cassel wrote:
> Tegra already defines all BARs expect for BAR0 as BAR_RESERVED.
> This is sufficient for pci-epf-test to not allocate backing memory and to
> not call set_bar() for those BARs. However, marking a BAR as BAR_RESERVED
> does not mean that the BAR get disabled.
>
> The host side driver, pci_endpoint_test, simply does an ioremap for all
> enabled BARs, and will run tests against all enabled BARs. (I.e. it will
> run tests also against the BARs marked as BAR_RESERVED.)
>
> After running the BARs tests (which will write to all enabled BARs), the
> inbound address translation is broken.
> This is because the tegra controller exposes the ATU Port Logic Structure
> in BAR4. So when BAR4 is written, the inbound address translation settings
> get overwritten.
>
> To avoid this, implement the dw_pcie_ep_ops .init() callback and start off
> by disabling all BARs (pci-epf-test will later enable/configure BARs that
> are not defined as BAR_RESERVED).
>
> This matches the behavior of other PCIe endpoint drivers:
> dra7xx, imx6, layerscape-ep, artpec6, dw-rockchip, qcom-ep, rcar-gen4, and
> uniphier-ep.
>
> With this, the PCI endpoint kselftest test case CONSECUTIVE_BAR_TEST
> (which was specifically made to detect address translation issues) passes.
>
> Cc: stable@vger.kernel.org
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 63d310e5335f4..7eb48cc13648e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1955,6 +1955,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
>   	return IRQ_HANDLED;
>   }
>   
> +static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +};
> +
>   static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
>   {
>   	/* Tegra194 supports only INTA */
> @@ -2030,6 +2039,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
>   }
>   
>   static const struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.init = tegra_pcie_ep_init,
>   	.raise_irq = tegra_pcie_ep_raise_irq,
>   	.get_features = tegra_pcie_ep_get_features,
>   };

