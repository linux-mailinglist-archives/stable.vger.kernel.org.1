Return-Path: <stable+bounces-47828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4448D7166
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 19:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583651C20BE5
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F31EA74;
	Sat,  1 Jun 2024 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="pF+55ceR"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F3AD48;
	Sat,  1 Jun 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717263984; cv=fail; b=SNjVCyNUMmSFIA1kA/Ba5hPrZv9h+Nhc4J5Xn5CD02Gz78IqSlTqkP71GIg1OIBkdJM9cFXPpaN/wQI3jqq2GbiaYni8HF5tcdG38CRmFWu7HkoxLNqy9ZzAeL7igZ9muuiPZ5dkdbLy9calJzEmGOmJcxzKahrsDuUhBsBxglY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717263984; c=relaxed/simple;
	bh=sjz8eDdYoxTlrIHAAbFhd0UbZ6jgqDQan9DLgwcL6dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=taCwFzDJT96oiLNyZzSs2sejXrXWxOz8mxOfR6hbg7dJS8q39MRfnTfVg5+eV1/iu43qlSk/DcaAnMuJqhV/M8mht8vT45wsBhQq4rjGCl2GieschRCkYQl2TbFgtJdqXkKyEsEiOD5/Ip9s07f+mj803eU5Yt49kqiNwhV6wwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=pF+55ceR; arc=fail smtp.client-ip=40.107.117.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYQ3ezeHe91vGcan1D9tC+nYO7kX8KHS4D1oV0+9c6djWU7SrWftOIAD17eUsEFP6T1LHEWNI9b6b49/wDR5aaGwRmasAp1OqtOSYqGBuLrzrin5C3HYDJmudqSbSZylqKyBJVdzoE5tF+plZPpvp+C7UAfSDvDIHUGNCV3oIUnwTHLIcryfgtmBzGlrtqosb30BDwVPdVp4Q/Lf56Ha3ZDKU1iK2ik5mRzGok0lwVVYFTa1k+P2ptNck8nXF4dLBPq00TpKaf70N1bk1THmOw6PGpz6t8CIkcODIlaGp0qHgZCquWwJO70gNRVi6Nva5QujNvnWaGW/XHEumq0UUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjz8eDdYoxTlrIHAAbFhd0UbZ6jgqDQan9DLgwcL6dE=;
 b=SYKn/C4vwVs45cOk0Rf6v21cyIDdgV9IcLKWIMl/a+cmn9cd+BlVvzo+TL3Cc+rx/ocn0FNbn2pTEd363tHpeyLZ5Mfji1bMtVQX3juBzEZDKPE/W4SE/UnFOiEMZ0lqncR2HPMuAFpcn/58gM9q0fB7uVafIc82HONqJPfgYjA3K3j26hpBaEqeUyyBam0c8q3c5VJXzHRdRNnqVaXt5Xf8W8GNENFH+yiu3j+23EIulohIg2EnatvSUZl4tkanOR83eCNhqkclUMzIsvQjlr0jow0od3JHBtE9qyOM3My0kWEnSh0dbYDV5jpK7mO+2BM+0wOTUR87bdUkMmXIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjz8eDdYoxTlrIHAAbFhd0UbZ6jgqDQan9DLgwcL6dE=;
 b=pF+55ceR79nH/yfdNZhbAxivHHuXOr7eyjmRQJiml2I4AEjZmIh5YFvcjLEO3vE/By1b7ZAbuiafXEN/jIk2PhHA18Xrahyv7Xzj7d3uI/SqMtg4QsO7xNQfloaSXnaWfxyuHFxBTiXmWY/j+L8Ke2waE3MmK+TgomSMCAZMhqE=
Received: from SI2PR02CA0007.apcprd02.prod.outlook.com (2603:1096:4:194::23)
 by SG2PR02MB5975.apcprd02.prod.outlook.com (2603:1096:4:1df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Sat, 1 Jun
 2024 17:46:19 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::18) by SI2PR02CA0007.outlook.office365.com
 (2603:1096:4:194::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Sat, 1 Jun 2024 17:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Sat, 1 Jun 2024 17:46:18 +0000
Received: from [127.0.0.1] (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Jun
 2024 01:46:17 +0800
Message-ID: <830a2fbe-4533-4c10-a9e7-87b23738514c@oppo.com>
Date: Sun, 2 Jun 2024 01:46:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/vmalloc: fix corrupted list of vbq->free
To: <akpm@linux-foundation.org>
CC: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <guangye.yang@mediatek.com>, <zhaoyang.huang@unisoc.com>,
	<tglx@linutronix.de>, <stable@vger.kernel.org>, <bhe@redhat.com>
References: <20240601171328.9799-1-hailong.liu@oppo.com>
Content-Language: en-US
From: Hailong Liu <hailong.liu@oppo.com>
In-Reply-To: <20240601171328.9799-1-hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|SG2PR02MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 01393829-b1cc-4a1d-c96e-08dc8262be4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjBOWVhOR3ZLdUJuNTJ2Skx6cE1VNHpBZi9Jck5jL0h2T3lWSWI0Rm5PQmZU?=
 =?utf-8?B?TkxiUDV6WS8zTmFkMC9za1RFOW5VaE54MVIzc0ExY2h2OGxSOTZqTFBlU1Bs?=
 =?utf-8?B?QTdveENGd2tBdDlZZTlQWDNRN1hhaGFSVG10Q0lOUDBkQ1JScGdPdTZmNERi?=
 =?utf-8?B?L2ZSWWlzMjd0TGlUam92ZFpYekdvRDlNN1ZacUpHSzNVb3RlbEpqVzJvSzFC?=
 =?utf-8?B?eGVvRGtpYjRQb0pCVUhHeU1kU3FKRGxCYTVkOFFSV01YT2NaTjlVQVBqeVlq?=
 =?utf-8?B?Vm9JNGVDM1pNMzQzVFNKL0VtbzlHeElSekVNbGo2VlA2bU5HVVdkL2lpMU52?=
 =?utf-8?B?R3BFaHEwVDdndlNjdm0rU2daUDc2OVpEM2hlcUY4VzlyeFU0TENYbnVMckxr?=
 =?utf-8?B?WE5vM2s3ay9YcWp3ZVlMSlgxMHkyMXJEeTJpdlpCS0JyN21aTjhrbDBTNTlG?=
 =?utf-8?B?ZFN1bHJFSTIwZ05LM29NRnVTMFlYOFZPV3A3blNucTJRSjFlK0RZWGIwNWoz?=
 =?utf-8?B?cFU4VDlKekQ4eWVERXJ5MG4zeVB4K1ZmUGZtaXdKM3AxRkNoR3BaeHYxdnpW?=
 =?utf-8?B?bFBDRjVLSjkyd1VWSFRGOE5meVU5NTdTSC9pODFXZDdGQjM1RHpMZVFnaENE?=
 =?utf-8?B?UW10RXdzWWQxenZsOEhLbEhFNHpMeGlaZ29ORXlDZGlFbWVhUHowWU01OFZS?=
 =?utf-8?B?OHM0a2laTUl4bGN2aFkxa0Vmc0hKZjhyVXBNZHFObUZXcmx2cjZmRC9mT2o2?=
 =?utf-8?B?MEQxNXlva2RWcm43TVNyM2dwNHdzMkl2WXRYdnhjOXZnb3RCRnFFZUF1S1BB?=
 =?utf-8?B?UVJxNDdWbU9RZnkrM0tlbnRxREZNc3ZiZG1oU3NEbmxiZXM3OEt6cS9HaDN5?=
 =?utf-8?B?WTFiYU9YSHNQNm9xclJvcnllRjkrK3ZlSUk1UjVzQnJNaStPY1VPQ1cxb0V0?=
 =?utf-8?B?Y041LzhqWjdQNlpiNGpROENFa2lCY3EzbE1OMkc3Z0xSWHFybEt0QU10bWE3?=
 =?utf-8?B?eENDdnNIWG92RWIxSnFyN1h1d0NPaGJoWkFsMFBKSnU3cTgySDRJZHBNQnlH?=
 =?utf-8?B?di83RzdBWHZSRU9IS01zemYraUUwV1hLMUQyT0hoeVR6RVJQeXdvN2kzVmE1?=
 =?utf-8?B?ck5ud2I5SGFIV2pUMlhFaVpoZ1dISENtMUlyVEJtajFtYmlBaGpCazhWUkVO?=
 =?utf-8?B?NFBLbnlCYTZTNnIyQjYwNVlzWUFRQlIwTjNhRnR5a2lVelRRMm5Fa3BDc3I4?=
 =?utf-8?B?NnltdXFYZ21UYWpHRWJUcXhONk1MTjJhK3ZHZklyMXpraWluSUd1bk1KVlpF?=
 =?utf-8?B?R0x0bUhvSHB6LzFKM1dqYzVseXRyMjVScVB5aDdUbHVYN29wTThMSlNMSlVW?=
 =?utf-8?B?bGhNbG5ZVTZiV2tQdUlCdDlxZXFWcGQ1RzZIT1llNEFpK01BT1BpT0IwZU80?=
 =?utf-8?B?cUgxY3lwQVc1YngvVjBxYmtqNThxdjVlYUtPR0hrLzBHcTlPUzA2ekZ1OUZK?=
 =?utf-8?B?SUluSmdSSGdDYkkvL0kzWVpsVUZncENHVUJVRTQrNnQxYWw5RTV2elVESTFZ?=
 =?utf-8?B?TTBNb2dvSkN4SjNkMVNWN2d3OUpvYkJ3SEZYZjQwbkgzVjFqZ08zOGt3SlRr?=
 =?utf-8?B?VEZhSkxDOVlXL0RxUW1UNGhpZlEvS0JIMGluWFFwcWJLVXJFemlHYXZnajRz?=
 =?utf-8?B?MXptbUljUEprT3BFZDNHbXFReE5wUzdmUldBSVRiYm9sa3hkbE9TUlVPbDJ4?=
 =?utf-8?B?V25CUVB1aUMxZFk2dkhNa29HRnNBZ1djRnBhbHczRVV0Q2haVFlkMmlIaDlq?=
 =?utf-8?B?TnVpVDBtYUlpL0NpdkZUN2tyOTgzdEhGOHBzTVJleXhZTDF2bWxMT3IvbVd2?=
 =?utf-8?Q?j9GTaIwyHGZyQ?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 17:46:18.8195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01393829-b1cc-4a1d-c96e-08dc8262be4e
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5975

+Baoquan

--
Brs,
Hailong

