Return-Path: <stable+bounces-194549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F532C5019E
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 00:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D246C4E4A22
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 23:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB52E975F;
	Tue, 11 Nov 2025 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="URE1xg7L"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020098.outbound.protection.outlook.com [40.93.198.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE31F2B88;
	Tue, 11 Nov 2025 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905583; cv=fail; b=JJe+J+nQWxdy/oznQSiddjC8UiRo1G4sUexVCZgk+M9KGkZRATYHVheLL7ABg/fE/DpKwmaiKzlQdQqQmlYUVMtimkKyLCNeQfan4IqSracbNZNr1FIh22aBlUhrp+g2NrTZZGi1VptXdtxiNfuoahj8YweJlo+skO7ZPfPJS+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905583; c=relaxed/simple;
	bh=FG6AMJ/Iln9GSOHpU5wXNZbLwK/2p1yCgXZJTcF9W/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sVXrqrcL5oulM3i7K4pTZVF8e7+mzJ/cd1TkHFTFpMhgImMrkmr9CYegrn3L7oqcn2v1b77n5g3zAzezk8JAQBsMeJP6fjRKaFuFJbYzTVIr8gRn1IhMgur4k0Yb5Vy+NQ4zUJLe3FYgF/Ty/FwTl0z2lwNZZVvD2i0AKjpOQv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=URE1xg7L; arc=fail smtp.client-ip=40.93.198.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKKD+85D4/tfySxQHQADMOGgPT4gGTTgxNNG+qIY4rxPBqSqOh3P3yp3BPD3MWCJNRs5jdyxpSa8I8jYkkGRU5oeNOZiM8o3ZstwnnOCcVDxukZpBk1PJhaJtIxYEvbFbMDFeqN0GbsTBbe6wqXcCQk2o4K8QCa0S84SVlUrpSbIqM5w7NcAt7idEupYIpHtFvelHBcIHE5SDfy5VgQkjcTOPdnZQYFdS95nax/YUiR3uecoDA6GpY96PEE0c3zlC7Lsy/emmiqIl00wUU/lrTbCiREY4uq7RM0zgUT3e4IVkWaO6Jfm/LPRatQridobDYy5Dal1wog9B1JseMa36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O68ydBvE8ho/2KZyxjtJN+3WVyNKDoy9B/mM+zkid88=;
 b=FS9DEIxBHHLdPDMy1pEge4qYMfcN6K02FnGZPG6sFt4Ju9sMoEnO5Ut8qDJ9JDBX0JXzzCjZOdOKVkeOu6GuuvzethTxSZ0h/PMBoLUHGhowZeMyddcJRcFZT+xp7GldebXY95JTFaaTduAXwHTeyQwdz39fqG9K9pqIt1HuMMycsEQ9WD/ogIoUULWaUdsb2PCyFrI/GGpJWRAFlktQ3Iab1mTM6hYYp+YcZJEy3xM1UMtEDj3HopU8OTwMm96T4PHY44CiEE6Bced3pxR/oBcQRMEad4d5UcZKFkhTX/7U1eA9Z+Dr0Zct1IcrL6hfYLUzHbXeiCdrztRIdUSPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O68ydBvE8ho/2KZyxjtJN+3WVyNKDoy9B/mM+zkid88=;
 b=URE1xg7LrdGn7pxXz/OrYWHNzBvTirDKyxz6xIFcf3MIDEENRlKwjHSdfQv7ebMdRCKTwuInH6Y6SMdN9gugVTE+7xcWfeCrjUFRNf8tSSif9xgFGn3jC4BOp+HQufztVU437RTLMNiOpzLfJyj7hqRXu3UAreKw2xmCUBpFUDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MWHPR01MB8697.prod.exchangelabs.com (2603:10b6:303:28a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Tue, 11 Nov 2025 23:59:38 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 23:59:37 +0000
Message-ID: <ce02b369-008f-4abf-982d-379e8e6535ce@os.amperecomputing.com>
Date: Tue, 11 Nov 2025 15:59:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, rppt@kernel.org, shijie@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251103061306.82034-1-dev.jain@arm.com>
 <aQjHQt2rYL6av4qw@willie-the-truck>
 <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
 <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>
 <aQn4EwKar66UZ7rz@willie-the-truck>
 <586b8d19-a5d2-4248-869b-98f39b792acb@arm.com>
 <17eed751-e1c5-4ea5-af1d-e96da16d5e26@arm.com>
 <c1701ce9-c8b7-4ac8-8dd4-930af3dad7d2@os.amperecomputing.com>
 <938fc839-b27a-484f-a49c-6dc05b3e9983@arm.com>
 <94c91f8f-cd8f-4f51-961f-eb2904420ee4@os.amperecomputing.com>
 <47f0fe70-5359-4b98-8a23-c09ab20bd6d9@arm.com>
 <ca628d43-502a-42f1-be57-bcb37103ddf8@os.amperecomputing.com>
 <19def538-3fb6-48a1-ae8b-a82139b8bbb9@arm.com>
 <5d04c2e3-7662-4402-86d0-9dba3a93fce7@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <5d04c2e3-7662-4402-86d0-9dba3a93fce7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::30) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MWHPR01MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 44752345-80d9-4d18-994f-08de217e5ef5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXdiNFpKaFE5MVVUdCtUcTFPdkkzd2lLMDZldG9wdzFpK0dlNjV3T0k2aTlv?=
 =?utf-8?B?akg1aWlyR3dVdC9BV0JMcFZ6cWZjdG9qNWhyWi96cXhxb01NUStGNUY0SU9O?=
 =?utf-8?B?d1pHSzR3QUVuVk9CUmxZVExGSG9Ia1lDRmVuV1ZlV3JzRnBaVExHcndVbHJX?=
 =?utf-8?B?bnBqZnFiSE5YazVpejFDckhvVmEzWURpRjl2SlJaU09wTjJrMldEOEE0QldR?=
 =?utf-8?B?QVdxR0psSXd0TExmeXI1aWVodFRtQzZZZWJReXhidjJxcU5VaU8yZkpqWGJP?=
 =?utf-8?B?QXJ3YW9CYzhjbU9xZzRRc2FtMkhwM0p1Vk5YYUZmT0dMR0hFYThIbjNpWHFV?=
 =?utf-8?B?a216ZXF6VW1oRlJySVF6TEkwRHE5S3lNZHZJSjE4cXF6c3paaG1NTWR5N0cy?=
 =?utf-8?B?SnRNOFlPWGRpaXh1bEhvYzlGY2RuTTI3b0pwZ1NTTWROc09aZlMyZmx0UWhv?=
 =?utf-8?B?RnRiTHlYU05wWDlMdlJFZGtFR3BobktMSVhuSWlENGlQbVV3WC9HTDY5bm5l?=
 =?utf-8?B?ZkYrM0Qrd2FIQVpTZ3ZUS0Z2N1VtcVhkZjRUcTNiMFhpMGhLWU5pM3JCTDYx?=
 =?utf-8?B?U282S0VwT0hXMlZYenAxbVhEQW4yNlR2UWV4U0xDeVdvenNwbkZ2dHBNaHc1?=
 =?utf-8?B?K25ncnB6ZkNWME1JNmk4VU5UVisrTVRKTERCN2s4WCt0dzhkNmNTT3ZsMzh2?=
 =?utf-8?B?UGZJOVcwR3hoUmpKcjhGYjNUZEZvL2ZUcTlpN2RiTkxqV0g3WXIwTHV2SDBP?=
 =?utf-8?B?anJYZG81cXZCM1hROHI4Y0kwQjlFN3ZaVnprMDdrM0FxNmQ1bTBzeWd0L3Q3?=
 =?utf-8?B?OTNITUw3R1FyZjBNSlZLWXhOSTRWT2FsWVlsV2V4NjVPa3pwZ3lGbmJCMnRN?=
 =?utf-8?B?YkRZK05tdVoyLzBBZTNzcyt2TG8yc29UcWVpZzhSNnRtbTI2Zm1pOWtKUy9a?=
 =?utf-8?B?WHk4d3NSWHpQRUJ2UzZGY1Y5SVRWV2lhSVI5dWswM0FBVnU0ZVV2RFV0L2to?=
 =?utf-8?B?RTRKcldvVXBuTmZHRkNpSzdzWEJDNXNIUGRLbXBneWM2MUhHWkdpSXh4djRD?=
 =?utf-8?B?RkxTd3hkVEpEdk1mbkRWVXcybDZpRGZVZHpxSUszdjdYRFZmNXVHZzk1TEg2?=
 =?utf-8?B?QVd5YnlkV1RoOUsxMStSS2wvOVRaZjhXMlRxeFdkeW1mQU44eTdqdVVoR3VX?=
 =?utf-8?B?RkwrNm4rSkFzZk9GK2xkMkZ1L1hIQUZSd2NuSjFGM1dDTTN6aGNXQ0dDN1pY?=
 =?utf-8?B?eTRkRWlhOE9qWXl5V1ppVS9Da1dLMUs4QjJhcXR6TURrdGNrTkpUSnFxSGll?=
 =?utf-8?B?MkxDakVCVmYzVDJtRHRiYlBNRG80eVpXZzJwUmh0bTdKMFlYT05PdXkxcGFN?=
 =?utf-8?B?d2p1Y2RYRlRvLzI1anVsb0hSZW5RbmpzNzdSTTdLZ0VCRWZreGQ2Rzk2Umpa?=
 =?utf-8?B?TGcvZDFxbVJ5eUpidW9qbkRwUllBTjVuaWtWb0cvaUtIbTA4SWFIOSs1bW1h?=
 =?utf-8?B?QktoZmxkZWUxbFl6STFid3l3c05uNmtYVms2dSt1M1dyZHM5VUdjWTg3NEVW?=
 =?utf-8?B?Q0wxMzN5S3dXOWRiVTQzdjRZcExzaDErVnBYd1hIM2ZESVlGWUcvMVBsQXQz?=
 =?utf-8?B?VjR2dzdFMEViUFZsVXg1Sk1uTU9YL3hTeHRjTUZwdndmdUsyZjVHby81dU0v?=
 =?utf-8?B?MzFneEIxNkRES1pOZXdTcklKeGdlaFU1V2Y5cTFYQVVJS3M2Yk1lVzk2TVFH?=
 =?utf-8?B?Qm9EOVBEWkhMSzZoOTFxTm5FOEY1cjBxcUp3QzllY1JvMjJmckwvNzdSczA1?=
 =?utf-8?B?R2dmTm5BRlRjclJVcERqZTRZdWFnQW1xQ0pEQzN2dW5jVUVyUmZ0Q1NUcnBV?=
 =?utf-8?B?NmZMVDloNktxbjN2SFpjaHJZQmRtc2NJeFQxdG9uQWpKVEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blVXSlpTWDduNWgyZWlxWWJkVm1xdnpuQ3VENkNYS29PWlZSUWY0aEp0NzBi?=
 =?utf-8?B?d0JjQTdha1NvRnQ4MGxDUEQydDhxbG9FU1NzVlFoZFpnWWh5NmVjZWJPMEdC?=
 =?utf-8?B?S2g5bTFqdTB4cnpkRHNKNWozTlRIU2RybzUzMUxOaW1xK2V4RTlPcEZKNzd6?=
 =?utf-8?B?SFM5REZjYmxmeDJQRlRaVDNoSHZZOXVEMGtjVVNrWjA1R0pCRUorZVB3OXpT?=
 =?utf-8?B?a2psd2tvMlZhdVFjaWR4YkZFWmpkQS9ENmFGb1NzQjBrRFJJYStrMWJ3UkJt?=
 =?utf-8?B?eUJjN2d0TDJmR1RtRzMwbEU1SFc0SGc5d0V6cUJxeEJvTE9YSnlNbnA3NHVS?=
 =?utf-8?B?Y29CZzJ6MFVZb0RrK04zSXFETHoxa2JsNTQrdVVKYkUvT0dhaklUVGNKVE5o?=
 =?utf-8?B?eWNQazh0RTcwZVUrTm10VmlaOEtzVnNvYW5NQ3dicExpdnduVFNyenlIcnU4?=
 =?utf-8?B?eUZUR1NLRGVHRWRHcUxaa1RwdFI5SFV6eGxnVjNMZktCMERVY2drWWJSZ0RO?=
 =?utf-8?B?NEJzS01EZThyb1Fhd291Ny9JVnVSckNDdEF5UjFHd2FQeDFIL3FFRE9jYnVM?=
 =?utf-8?B?UGFpNWxJNWFPclZUTVJrMmdjOUhvS0RxSkhoTXJFOGhKcmprYlJVUlZ3U2g3?=
 =?utf-8?B?ZXBWOVU0ZmdNZklqRktRM1B2eXZYWGZoZHV2TGZMOXZmbFRvSzI4aVBvZlU2?=
 =?utf-8?B?dXFkREFNeTlkNlBsQ3ZJcFlKYVpSUFlCTnkvTG9Qai9ZaDB1OGFmbVNJK0VP?=
 =?utf-8?B?TFliQnlrcnh2QWpiY3BaMDhMa3NaMVRlY1d0emdLc3F1dzV5RjJnQnVSbTgr?=
 =?utf-8?B?UmlUZnJaUGM0YUx1OHNtTlBqcGFFaHNYMGVzT1NadlJ3L3BHZEsxbkFWRkVI?=
 =?utf-8?B?SVJpUElPV3ZLS3FFZnJRaFk0c0NYRDUwVG96WklvT3RUbGY3SVN6TXBwQTNv?=
 =?utf-8?B?U2c2bTVOWGJZd0RsRTBwRnpkTVA0MmxXV2duQzdOSEpleXNLWW5GbXF1Q1cz?=
 =?utf-8?B?MVRsdDU1dmRZOGRva3JvcHZ6akdFS3JKVWNOcDdVOVNnRFRyNFlobXhMQmlF?=
 =?utf-8?B?RU9DWjNoUEhneWNSZnhtUUMzTmtPamRRTzRHTXBOb3lLNVA3WFI4V3ZLT3d6?=
 =?utf-8?B?Y25haWliMzZQaTlJaFYySWhDQkdRU1BOV3A2eW5kdzNDK1Raa0FCUnJCd0I1?=
 =?utf-8?B?NEkxQzNlcG1Id2RRT3ZCSmdvYjZ0USt6cjBzR0NGSUw3NDg4T0cwZE9aWDE1?=
 =?utf-8?B?V1lKem4zeHJaN3lodXNZeUVFV2VGelpEZEY0cVFuZll2aC9MVXowaEluWFZQ?=
 =?utf-8?B?a0U0WVpSM3BJa2RxbE1SR0J6UEFnYXRwUTlBT1RiOTRpd0xINFJWQkd5UVU2?=
 =?utf-8?B?QXhqaURzM0l2ZlZSTmg1R1ZYUlFpRWdybHZWRjdKNFh6amQ0M2VueWRubnIz?=
 =?utf-8?B?YTFnTm9xbkllTHRTVmlLa1l3QmhVQlpXd0oybVdnUzlJTGNBVUJyZ3gweEY5?=
 =?utf-8?B?ZUh1M2pzdm9wS01qVk5MREpUVTNEQjhYYXFNYmd6ajQ1UmtINVErRU0xbkcz?=
 =?utf-8?B?UTI5Ty9DSlNSV2E1dXZhMGRUa2FndXZkWEVwRU1KWkw4Ry84M1g1cWFvS3Fs?=
 =?utf-8?B?aWNoUzZ2aDRsc2NoSjI4SVNTNXdKUnFMczIwbVdPVEFqb1BQN294TjVxUUs4?=
 =?utf-8?B?S0x6MFVMV3IrUUNlUmVPZ0Z0RVlib2JzZktmRWZkeUgxOGFpRHR1OVVRa2Nq?=
 =?utf-8?B?bzlIYkFidmF6NkRBYklmUEFkOHNxVm54NE5pRXh2WWRUZ1hqYTlyd2FyZElX?=
 =?utf-8?B?MHBFMCtkMTJxSG1md1BncUJVMC9mWHp4cmNxdGVwTkpiZkNsL2FWSWIrbTY2?=
 =?utf-8?B?Ti8ybWlRd0ZQN293alJRYmtRWXM0Zmx5cnRCQnBlcGhjSWU4UHhEQzVhQS9T?=
 =?utf-8?B?TzQ5SU9DNXlwUXpTVXRvOTdqdC9lK0p4QXpKUVhpL1dRWUFocFk0eWt5M1Zo?=
 =?utf-8?B?UXNyY2lSaWhscWZGMVd6T0g1WGljb3h3S1dmUmRjUGFuUnRBNVNlOW5sRnN0?=
 =?utf-8?B?V3puOUZhQll3Y1pNMmE3aEVCdERubHlKWEpOTUhtcnRFbmFjWG4rUFdldm81?=
 =?utf-8?B?OFk0VkJDM3lBS0hoaWNVTUs3ODh2VHNKYld1bm56RUYwUjlDdzc1OUpBamNW?=
 =?utf-8?Q?pWt8hYhKLj6NQNLFCy1vPMU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44752345-80d9-4d18-994f-08de217e5ef5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 23:59:37.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAb7WzKNdDtla/vZFQcboL5YoRR9kHi5V4PR+STlGgOhw7N/BN+OtJTelj3Svdsa8DysABOKFvVwMltwxZadffm/Z9fJX4e7Yz6sbgwnr6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB8697



On 11/11/25 9:52 AM, Ryan Roberts wrote:
> On 11/11/2025 05:12, Dev Jain wrote:
>> On 11/11/25 10:38 am, Yang Shi wrote:
>>>
>>> On 11/10/25 8:55 PM, Dev Jain wrote:
>>>> On 11/11/25 10:14 am, Yang Shi wrote:
>>>>>
>>>>> On 11/10/25 8:37 PM, Dev Jain wrote:
>>>>>> On 11/11/25 9:47 am, Yang Shi wrote:
>>>>>>>
>>>>>>> On 11/10/25 7:39 PM, Dev Jain wrote:
>>>>>>>> On 05/11/25 9:27 am, Dev Jain wrote:
>>>>>>>>> On 04/11/25 6:26 pm, Will Deacon wrote:
>>>>>>>>>> On Tue, Nov 04, 2025 at 09:06:12AM +0530, Dev Jain wrote:
>>>>>>>>>>> On 04/11/25 12:15 am, Yang Shi wrote:
>>>>>>>>>>>> On 11/3/25 7:16 AM, Will Deacon wrote:
>>>>>>>>>>>>> On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
>>>>>>>>>>>>>> Post a166563e7ec3 ("arm64: mm: support large block mapping when
>>>>>>>>>>>>>> rodata=full"),
>>>>>>>>>>>>>> __change_memory_common has a real chance of failing due to split
>>>>>>>>>>>>>> failure.
>>>>>>>>>>>>>> Before that commit, this line was introduced in c55191e96caa,
>>>>>>>>>>>>>> still having
>>>>>>>>>>>>>> a chance of failing if it needs to allocate pagetable memory in
>>>>>>>>>>>>>> apply_to_page_range, although that has never been observed to be true.
>>>>>>>>>>>>>> In general, we should always propagate the return value to the caller.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>>>>>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM
>>>>>>>>>>>>>> areas to its linear alias as well")
>>>>>>>>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>> Based on Linux 6.18-rc4.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>     arch/arm64/mm/pageattr.c | 5 ++++-
>>>>>>>>>>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>>>>>>>>>>>>> index 5135f2d66958..b4ea86cd3a71 100644
>>>>>>>>>>>>>> --- a/arch/arm64/mm/pageattr.c
>>>>>>>>>>>>>> +++ b/arch/arm64/mm/pageattr.c
>>>>>>>>>>>>>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned
>>>>>>>>>>>>>> long addr, int numpages,
>>>>>>>>>>>>>>         unsigned long size = PAGE_SIZE * numpages;
>>>>>>>>>>>>>>         unsigned long end = start + size;
>>>>>>>>>>>>>>         struct vm_struct *area;
>>>>>>>>>>>>>> +    int ret;
>>>>>>>>>>>>>>         int i;
>>>>>>>>>>>>>>           if (!PAGE_ALIGNED(addr)) {
>>>>>>>>>>>>>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned
>>>>>>>>>>>>>> long addr, int numpages,
>>>>>>>>>>>>>>         if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>>>>>>>>>>>>>                     pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>>>>>>>>>>>>             for (i = 0; i < area->nr_pages; i++) {
>>>>>>>>>>>>>> - __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>>>>>>> +            ret =
>>>>>>>>>>>>>> __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>>>>>>>                                PAGE_SIZE, set_mask, clear_mask);
>>>>>>>>>>>>>> +            if (ret)
>>>>>>>>>>>>>> +                return ret;
>>>>>>>>>>>>> Hmm, this means we can return failure half-way through the
>>>>>>>>>>>>> operation. Is
>>>>>>>>>>>>> that something callers are expecting to handle? If so, how can they
>>>>>>>>>>>>> tell
>>>>>>>>>>>>> how far we got?
>>>>>>>>>>>> IIUC the callers don't have to know whether it is half-way or not
>>>>>>>>>>>> because the callers will change the permission back (e.g. to RW) for the
>>>>>>>>>>>> whole range when freeing memory.
>>>>>>>>>>> Yes, it is the caller's responsibility to set VM_FLUSH_RESET_PERMS flag.
>>>>>>>>>>> Upon vfree(), it will change the direct map permissions back to RW.
>>>>>>>>>> Ok, but vfree() ends up using update_range_prot() to do that and if we
>>>>>>>>>> need to worry about that failing (as per your commit message), then
>>>>>>>>>> we're in trouble because the calls to set_area_direct_map() are unchecked.
>>>>>>>>>>
>>>>>>>>>> In other words, this patch is either not necessary or it is incomplete.
>>>>>>>>> Here is the relevant email, in the discussion between Ryan and Yang:
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/all/fe52a1d8-5211-4962-afc8-
>>>>>>>>> c3f9caf64119@os.amperecomputing.com/
>>>>>>>>>
>>>>>>>>> We had concluded that all callers of set_memory_ro() or set_memory_rox()
>>>>>>>>> (which require the
>>>>>>>>> linear map perm change back to default, upon vfree() ) will call it for
>>>>>>>>> the entire region (vm_struct).
>>>>>>>>> So, when we do the set_direct_map_invalid_noflush, it is guaranteed that
>>>>>>>>> the region has already
>>>>>>>>> been split. So this call cannot fail.
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/all/f8898c87-8f49-4ef2-86ae-
>>>>>>>>> b60bcf67658c@os.amperecomputing.com/
>>>>>>>>>
>>>>>>>>> This email notes that there is some code doing set_memory_rw() and
>>>>>>>>> unnecessarily setting the VM_FLUSH_RESET_PERMS
>>>>>>>>> flag, but in that case we don't care about the
>>>>>>>>> set_direct_map_invalid_noflush call failing because the protections
>>>>>>>>> are already RW.
>>>>>>>>>
>>>>>>>>> Although we had also observed that all of this is fragile and depends on
>>>>>>>>> the caller doing the
>>>>>>>>> correct thing. The real solution should be somehow getting rid of the
>>>>>>>>> BBM style invalidation.
>>>>>>>>> Ryan had proposed some methods in that email thread.
>>>>>>>>>
>>>>>>>>> One solution which I had thought of, is that, observe that we are doing
>>>>>>>>> an overkill by
>>>>>>>>> setting the linear map to invalid and then default, for the *entire*
>>>>>>>>> region. What we
>>>>>>>>> can do is iterate over the linear map alias of the vm_struct *area and
>>>>>>>>> only change permission
>>>>>>>>> back to RW for the pages which are *not* RW. And, those relevant
>>>>>>>>> mappings are guaranteed to
>>>>>>>>> be split because they were changed from RW to not RW.
>>>>>>>> @Yang and Ryan,
>>>>>>>>
>>>>>>>> I saw Yang's patch here:
>>>>>>>> https://lore.kernel.org/all/20251023204428.477531-1-
>>>>>>>> yang@os.amperecomputing.com/
>>>>>>>> and realized that currently we are splitting away the linear map alias of
>>>>>>>> the *entire* region.
>>>>>>>>
>>>>>>>> Shouldn't this then imply that set_direct_map_invalid_noflush will never
>>>>>>>> fail, since even
>>>>>>>>
>>>>>>>> a set_memory_rox() call on a single page will split the linear map for
>>>>>>>> the entire region,
>>>>>>>>
>>>>>>>> and thus there is no fragility here which we were discussing about? I may
>>>>>>>> be forgetting
>>>>>>>>
>>>>>>>> something, this linear map stuff is confusing enough already.
>>>>>>> It still may fail due to page table allocation failure when doing split.
>>>>>>> But it is still fine. We may run into 3 cases:
>>>>>>>
>>>>>>> 1. set_memory_rox succeed to split the whole range, then
>>>>>>> set_direct_map_invalid_noflush() will succeed too
>>>>>>> 2. set_memory_rox fails to split, for example, just change partial range
>>>>>>> permission due to page table allocation failure, then
>>>>>>> set_direct_map_invalid_noflush() may
>>>>>>>     a. successfully change the permission back to default till where
>>>>>>> set_memory_rox fails at since that range has been successfully split. It
>>>>>>> is ok since the remaining range is actually not changed to ro by
>>>>>>> set_memory_rox at all
>>>>>>>     b. successfully change the permission back to default for the whole
>>>>>>> range (for example, memory pressure is mitigated when
>>>>>>> set_direct_map_invalid_noflush() is called). It is definitely fine as well
>>>>>> Correct, what I mean to imply here is that, your patch will break this? If
>>>>>> set_memory_* is applied on x till y, your patch changes the linear map alias
>>>>>>
>>>>>> only from x till y - set_direct_map_invalid_noflush instead operates on 0
>>>>>> till size - 1, where 0 <=x <=y <= size - 1. So, it may encounter a -ENOMEM
>>>>>>
>>>>>> on [0, x) range while invalidating, and that is *not* okay because we must
>>>>>> reset back [0, x) to default?
>>>>> I see your point now. But I think the callers need to guarantee they call
>>>>> set_memory_rox and set_direct_map_invalid_noflush on the same range, right?
>>>>> Currently kernel just calls them on the whole area.
>>>> Nope. The fact that the kernel changes protections, and undoes the changed
>>>> protections, on the *entire* alias of the vm_struct region, protects us from
>>>> the fragility we were talking about earlier.
>>> This is what I meant "kernel just calls them on the whole area".
>>>
>>>> Suppose you have a range from 0 till size - 1, and you call set_memory_* on a
>>>> random point (page) p. The argument we discussed above is independent of p,
>>>> which lets us drop our
>>>>
>>>> previous erroneous conclusion that all of this works because no caller does a
>>>> partial set_memory_*.
>>> Sorry I don't follow you. What "erroneous conclusion" do you mean? You can
>>> call set_memory_* on a random point, but set_direct_map_invalid_noflush()
>>> should be called on the random point too. The current code of
>>> set_area_direct_map() doesn't consider this case because there is no such
>>> call. Is this what you meant?
>>
>> I was referring to the discussion in the linear map work - I think we had
>> concluded that we don't need to worry about the BBM style invalidation failing,
>> *because* no one does a partial set_memory_*.
>>
>> What I am saying - we don't care whether caller does a partial or a full
>> set_memory_*, we are still safe, because the linear map alias change on both
>> sides (set_memory_* -> __change_memory_common, and vm_reset_perms ->
>> set_area_direct_map() )
>>
>> operate on the entire region.
> I'm thoughoughly confused again. I thought we had concluded this was all safe
> when discussing in the context of the "block mapping the linear map" series. But
> now I'm a bit unclear on whether we have a bug. I think I'm hearing that we
> don't need this patch and Dev will submit an alternative which just adds some
> comments to explain why this is safe?

IIUC, it is still all safe. I think Dev's patch is right. We should 
check the return value of __change_memory_common() because page table 
split may fail. I had the return value check in my old patches which 
called page table split function outside __change_memory_common().

W/o this patch, the callers of set_memory_*() may continue to run with 
some memory in wrong permissions, for example, RW memory but they are 
supposed to be RO, instead of jumping to error handling path.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>
>>
>>>>
>>>> I would like to send a patch clearly documenting this behaviour, assuming no
>>>> one else finds a hole in this reasoning.
>>> Proper comment to explain the subtle behavior is definitely welcome.
>>>
>>> Thanks,
>>> Yang
>>>
>>>>
>>>>> Thanks,
>>>>> Yang
>>>>>
>>>>>>
>>>>>>> Hopefully I don't miss anything.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Yang
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>> Will


