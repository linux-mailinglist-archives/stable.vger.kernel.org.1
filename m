Return-Path: <stable+bounces-217552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EnQGgUxmGkzCQMAu9opvQ
	(envelope-from <stable+bounces-217552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:01:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FFA166964
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA50305541A
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE6D2D77FF;
	Fri, 20 Feb 2026 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="utIL8817"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9E336EE7;
	Fri, 20 Feb 2026 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581654; cv=fail; b=sTuEg7knqPEytr8jPbVR7J1oeYPzYmEZzbLDIxFF2ly49EmtwpljBUZEp6nGpVEkesGy0xiM0j73KeB/gGeiHwxwYLcgFWbzGHxxBYMr47eZ7b/UVz5xwDP2EIp7y4m82HzUXCBNo9Q2gzMXCQuC4sU18ygji8ShlfOQpOIDONI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581654; c=relaxed/simple;
	bh=l6/9N1yqr6NMN6d2tqi40wkBat3JyIhoiw6mOhQUiDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hPnVlF42FfPMoa9vks+WV7K1VSNBsAAe79yRFHAbcY+o+i8GQc4PiqPw1pRJnEh9/7Mnj5cHsS6blsJSu8qHZDe8p0ZEdZXbKCe8Me41eOVehcejuAsneqdeDDW6Gysa8Fd5ONViktVA3Wq+O8Ofj1RADKGxtl/znGDHXeOLASc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=utIL8817; arc=fail smtp.client-ip=52.101.62.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeNNGNFig6uKQPv5+wyIvydRuoPcMt7KUy2J9zv8V30VIoAtQfOcmWDk2O57dA1QSV6dA0FfPSo7wsNIP2hB1ak9L3MBAbk2Sm7ogTb55jm0hAcyR55mwvEO3BZuCfhgX0ZjMaYdJNAIgmTvUVNLqLREgMYygQ8pr5DJds1WERLIB+Jh0E3ytMcR6P9PK4Os0/g0VobppB+IQLiEXDKuCjfXAbs8rhlVIlOaSeebeKugGG2Syc00q14wbnxPl6qPXH4pRDoPJtvG4NR5kjkFB2khO03N20x8CAXH4OQPJJGMlEkfRxHYVO1hDTcTCfSEhr97BSNIvHUlo2fW0Go2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NYypAElBKiD2K1QyDN3v+VzeoXB/cDdnPRyYZgIgvk=;
 b=V4dpd0kwXrXkHbFYZ2nqgIvLYCPvL4cSJm0QaRU5bGU9XU33SoKjNtge4emgHb10doiYsZbdbMiD3guM4DBqxzlZOwS4xyFLaOdQVBxaz6+y8jx4x0CVknknMi4kmxZs564yqdDL+KB2nfh7tusD7sGN4BVX5dNptXKp+E2DugRL5DbvOhmM3E2hX62N4tmHs9XLd8sPZusow/Q7GgKDNPt67anrrsl8eyPpyaJeZ/QkDU0qQKdoVjkcuwlIvLioyQA7+1HeZyzrGj61W2JZpsgGv+K9PAXzRitsUxEOFsc5nYSj2FtPPsUYYABpzDCrBnae0CIHgrhyD4t9PerBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NYypAElBKiD2K1QyDN3v+VzeoXB/cDdnPRyYZgIgvk=;
 b=utIL8817RKKeOLIcXu7qUDQT4I2mgkbFlWz9zfqpe7WJ78j8PcVaDo7PJ4j7d6XHLriOqJ3D9AjoWMNKtDpJu3WujzhYGPX2vszkTmnYSC9sRDTH78BGntzBqGSr8UFXwcM/+XvC18tNfZsS+9yMC0c2zYcpnqQTPeX4Ts4kvxo=
Received: from MN0P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::15)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 10:00:49 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:531:cafe::23) by MN0P222CA0007.outlook.office365.com
 (2603:10b6:208:531::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.17 via Frontend Transport; Fri,
 20 Feb 2026 10:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 20 Feb 2026 10:00:48 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 04:00:41 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 04:00:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 04:00:40 -0600
Received: from [10.249.132.38] ([10.249.132.38])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61KA0YF53678030;
	Fri, 20 Feb 2026 04:00:35 -0600
Message-ID: <074a89cf-fb28-4f05-9203-f530aba582c9@ti.com>
Date: Fri, 20 Feb 2026 15:30:34 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] Fix Unbalanced IRQ Enable for CPSW and ICSSG
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
	<horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
	<vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
	<vigneshr@ti.com>, <jacob.e.keller@intel.com>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20260220041431.372610-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a343b7-517c-4c4a-9b2d-08de7066ec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzlTYjdUbUp1VDhZRHd2Qi95R2h0N2t3eVlWWHd2bkpsc2dTd2F4MDZLRDNG?=
 =?utf-8?B?WmkyekhGQXRYVStnT3VneFhvdml1MnRTZytXdUtTTDYwMko5OXdNNWVVRHpT?=
 =?utf-8?B?K0lnRGdDWEJlYUZRVVQyWUlwVTRCR0ZaMFFSM1BPZXFlQlo3OGhxYmpBK21F?=
 =?utf-8?B?L0RkVHNoSEdYQjhEQklUU2NVUVJEUGtoOFRjZ3FPNFR1YlNmR1FsZUgydFV2?=
 =?utf-8?B?Z2I5WTBIK1RMdFZwc2NSc0JtK2F3NTRDWjRCbjhTclRtbEc4RU5BZlByalRu?=
 =?utf-8?B?aUV4aFNPZkE1MGZsbGZhczU5TUFsK0tHNjBQdWRBelBocGNjWmExeDNjM2JE?=
 =?utf-8?B?NXVpNkRycmNhNzhZMTloOFp4aUVUczl0ZC9MWFVsczRVUC9sOU93ZDdXQnNj?=
 =?utf-8?B?ODZJMmhtWGlIeGU0NjBIMThJYWtHZ3hXRFplbEdCTFFEaDFGaHJ6dFAydGdO?=
 =?utf-8?B?NkFFaWhTMzh3cW5jTGpOUCtVemUvQkpxZEtVTjBWZjZUNkFFRFJFb1FFdDlS?=
 =?utf-8?B?eGQ1TUxBVDlodXprRmFqUTJpWmgzY3hUZHVRZThWWnArUTVqV2x3NmtwWUZ2?=
 =?utf-8?B?VmI1bEo1RmVrclgxMTBnaU9ocXlvWG9vNllFY3hVbkZDMHRhWXRFTS9XRWR0?=
 =?utf-8?B?bkpFWXQ3NHUybXhISXRka2VXNjFvTWpxOFVjeEJYQkl5di9XSDhFRmEvVVV2?=
 =?utf-8?B?NTNmWUlleXE0cnFNMU5INDAvUXd1UmNmU2QwMGZZVWFKaGlvSFAvZVNOeFRH?=
 =?utf-8?B?QXRvRjdnS1ptWHVaZ2ZzTlY4M2VuWXFKWUlsdzVnbEtyK1l0MUlGUWZtZW0y?=
 =?utf-8?B?L3hYR1hxOGYyVlpiMlR4Z3BLaHV6bmFSZVI5ZUV1QUtuVnB0VTdMaTZiWERJ?=
 =?utf-8?B?Rnp2LzN4WHp6OUtJVGo5M2RuanRsTm9vRlpKVk84aUM0azE3a3ZMbVNZZkJB?=
 =?utf-8?B?WWIyMDFHaXI1d2ZOb21BUVF2UDNaY2NqdUhvMnNjQ1ovMnduVVlHVUZ5Mklz?=
 =?utf-8?B?SFV1cE5VdzRCWXgveldwRWthSjZBa2F5ZFVWc2o0R0tjUjcyVmxHSi9IN0Q5?=
 =?utf-8?B?SlMxQk0xNW5Vd3k5RGxNajRQSThlY1l2c2oxdDFreFcwWElVbDZEWjFXaEpu?=
 =?utf-8?B?NUJyQ3RnaS8yZHEzOSs3c3JYUm1NTlVpb29qYmdieXRpQkVzdTJmZUZCNjVl?=
 =?utf-8?B?OVJpeWUvMU9uN1dQaXZJT1d1My90Ym9xS3lRVko0RHpLRU9raEhOWWdjM0JK?=
 =?utf-8?B?SS94c0FOWU84UEd1SnpZUFNLMEVVSVlvRzRIUHVTbmZaV2JZeXBhYVpubFIr?=
 =?utf-8?B?YWljWSsyTGdXUkZybEp1R3F0L20wMGgrZGtLeTRXWXNxTVBQUmFlRWJvbDRu?=
 =?utf-8?B?TDRzRE94cU9SQ1N1Z3E0aTBLOWo5NFZXQUlrc3BLS2VwN3RURjlaUGxCWHFX?=
 =?utf-8?B?b252RFVpZ2pSUEFlRXMyMFpTOWZDN2JxT29JdGJpVDVXNTVXN3RGVFFvSWlZ?=
 =?utf-8?B?M0JidkZldVlTNzdEckI1SXVtRHFTcDlLN20wa1dyOThwOUNyUUwrYzNSMFYv?=
 =?utf-8?B?MkVvdHB6bEhYbkxWQlJKZ200RFQ0eDQzZzJ1UXI5aGQxejdyTnFrci81eEsw?=
 =?utf-8?B?TzNqeVVqVjUzV1JudTQ2TFQwMEFPUDA1WlY5YXlqTDRKOUVZYnpoRjlKdUxM?=
 =?utf-8?B?d3JTaGJKYW1FL1p3VDdBWHVMUGpaUlFKcE1ETjJsZ0o0RG1rODc3TkhIeGIy?=
 =?utf-8?B?cjB2SlZ4QTdqOThSNTMzdFZnc1JwRnZNUSs1N1RNbFFiQUdOckRsYy93MzFh?=
 =?utf-8?B?RlRENmwrQVVFV1hoZzdzMlkzbnZodXd0dENBMFBkMU5aQlp4YWNMZzNIai9K?=
 =?utf-8?B?SW9KaGZNOUtMU2FwSHZaTkdHNTdJZ2RHdWNVbERMZExtTkRKQzd4Sk9NejhG?=
 =?utf-8?B?blBUeVhnc09WN1ljMmhkMURSQXNyVldEZkhZaUtlNjlkQWpCcW9MSVRkeEY2?=
 =?utf-8?B?N0l1QWNCL3NnOXd6S0NBTTF4MGlmWGNKNWpJc1plemU2aWVQWWlHKy9rZ0RQ?=
 =?utf-8?B?S3N2bkFhbDdXUldhU0FKZEdybHAyNzdYdlpWdGFHbUs2dm1ZL2RxelYvQ3lW?=
 =?utf-8?B?djBDZEZ2MXVxSm95bnpuUVdvU0h5WE1CN2NwZ3VLQTV0WkFQcy9ZM3FHY1JT?=
 =?utf-8?B?WjFodGR6WllSL3VHZHg5c3pNSzZkcjIzVitsUEFsYk9VMGY2QWxVcjRCTUJW?=
 =?utf-8?Q?TBgcNnj2JDaMfQFjXRQ/NSQVmodlmWTnkhQvjD4EQY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ejo4CSxmmXz78UTP/tKZWYf7EerG7NE/JhHI/yrp+R6Q+YYzMY9VYWjQNXz+BPldnBW/pAZoxxT5QCbyU2RSN/SgcL9bGqzLpyKUOoeiJPcwtVIIo6muqY+GLT75t5eJwP4SWFZolVa6XDDer/nDqPSFOS7oo3NYPUgVUi1M8cxvru4UZcXE5Of+GRZO7Vp/oPifWOxjJ9RBX+UfHx8acmYNnKlOO3hWHsG2wrE8hXKejMXchZVRGTTLBMuIboK1WmWOfprNepeUniIevqNNOadvEvp9nAhnszjKxwlULY/w0bHjng7TqeWAzm9tnrh8GU4O4BT+D79Cwwo8Im9e9EWb1KHB9YcwTYL79+rECFPL3k/HPjtEg7zKcvm5pnKYqdOKNFXk8JBzLhzPQDGmXdxEe2xeLv6AwGAIIHBfE8WbX/TmLqDlWUGPWy54BMdl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 10:00:48.1822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a343b7-517c-4c4a-9b2d-08de7066ec15
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-217552-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B9FFA166964
X-Rspamd-Action: no action



On 2/20/2026 9:41 AM, Siddharth Vadapalli wrote:
> Hello,
> 
> This series fixes the warning:
>      Unbalanced enable for IRQ ...
> for the CPSW and ICSSG drivers.
> 
> Under heavy traffic and in an SMP environment the warning shows up after
> a relatively long time. The issue occurs due to the order in which the
> variable 'irq_disabled' is set and the function disable_irq_nosync() is
> invoked.
> 
> I have examined other drivers and they follow the right order which is
> to invoke disable_irq_nosync() before setting 'irq_disabled' (or its
> equivalent variable).
> 
> The first patch is for the CPSW driver and it has two Fixes tags since
> the code change associated with the fix is for a recent commit while
> the incorrect order was first introduced by a much older commit.
> 
> The second and third patches are for the ICSSG driver. Although they
> are both for the same driver and could be squashed, I chose to split
> them since they fix different commits and need to be backported as
> Fixes for the respective commits.
> 
> Regards,
> Siddharth.
> 
> Siddharth Vadapalli (3):
>    net: ethernet: ti: am65-cpsw-nuss: set irq_disabled after disabling RX
>      IRQ
>    net: ethernet: ti: icssg_common: set irq_disabled after disabling TX
>      IRQ
>    net: ethernet: ti: icssg_common: set irq_disabled after disabling RX
>      IRQ
> 
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c     | 2 +-
>   drivers/net/ethernet/ti/icssg/icssg_common.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Meghana Malladi <m-malladi@ti.com>

-- 
Thanks,
Meghana Malladi


