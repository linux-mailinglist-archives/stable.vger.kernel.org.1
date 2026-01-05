Return-Path: <stable+bounces-204948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C3CF5BA4
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60F64300C36A
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E8B31197A;
	Mon,  5 Jan 2026 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nw9SOhUQ"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2C31196F;
	Mon,  5 Jan 2026 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650103; cv=fail; b=Kvam77dNF8ZLx5+whQu9jpPA73SUiSj3OqensWXtmVjG9x7AsZf5H3wf2Uayyg+11rEiiAamuJ6acHgenlxqjyUqGg9db782Y6dxtRgytxCgYd3fu0tUp4Y7sn2ryDsT+ef7PBKLcrBGiWaWPKFGUye5a/tbDsVxP1f5p5ZCoLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650103; c=relaxed/simple;
	bh=Ynsn4uUYgMH/VOCMLlweaqn4M5tUTAUaHtvnd7tJJEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nN95s0HMGswxc3fNaRnSZrQuM5u9Mjip8A3GEB6IbOXD0UL3tR3OPn1ug7PwRx7O3FfXqb9qp60zlipl/GLfCckLhUY9If64lbzep59P+i119/hoPOSI8dlOw6QqxYo6ya+iJb1f2Prlnqc0recjUtYd6uCcRkq+anwb7ymkYmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nw9SOhUQ; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2BHZ4Udg0bUrcgnw5qS8VVggs0q92rGnyvUVZVv2AXPsAVFMGRpOLRI+cMS5keqKanELGauskwz3lwHxmozICRmr2j7HvWq84LYlmt2kbWMWwmSg8xRDipXqBv/2dYSVf8BgfuK9iVehs6qpjK/L6vXy/Moc2U6gRzZLRNj0/2u5S7QMKE/gJecuOKymgb1IMJqdLW0GeyvykqY3I6PBIls4Do8helVUS1KBYm74Nq2jye+IaRx+9GOKxqlzGyxkOUoegnlKsbhtT5UUTTct+ajr8r+QbDgdguhf5n3y1ShALTYwi/T/Mpv56mv1TRh9z2evDICOk1/ST7jEmMhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC3VV165M8Fz/EwV7stgKcy9K7tD+Nj1YaNELiMwWiY=;
 b=TUSmO9PxoN/lFVX3/ezOyD7WH14rO1sSrifoZFaVUSzHVz9X+e11skiAUyIWdO9Tbnwvr1BFNBVRFQ6bsjStqY/eMXUxqky3aKH14NB029SylB2kIE69furWrA9GzI55klpyptxHZMMboT0XGT5PwzhgR9mg0aRzm1dTCm6HsWfNIWnjC7SVAOTL36JTkW7EtJ8Dk/t8MeuvCpARCrfNZuPvlTo6qf3Zz8rP1Mium90Qcq141R+UxcEP80IB0uk9CUWqw6EDLeL7Q6COCEcnvxc8StKvDyNUfMzSmJKbRalxFS/z7CoXw3xrcb1Z2ZhCKV4jzgk17LWVrR54Ldt5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC3VV165M8Fz/EwV7stgKcy9K7tD+Nj1YaNELiMwWiY=;
 b=nw9SOhUQlZsGvqKKX4gL71c5XnNj9vnuN94OCW3DIz6qa7zDLuF8qtRrlo55EUOD3FyGWHoj45eXb2F4XKgP9/YPMWJUWvo5b1A9Xg9nk5Ksyq7qWi3+ooJK7K2tPE2/lSekomSkxlEDmYUb2qC0xtrZoOed+xEiz8Mkly11AqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 21:54:58 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 21:54:58 +0000
Message-ID: <bbb300d1-ccdc-4a4b-8110-1e2d27367620@amd.com>
Date: Mon, 5 Jan 2026 13:55:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atm: Fix dma_free_coherent() size
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Chas Williams <3chas3@gmail.com>,
 chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
 "David S. Miller" <davem@davemloft.net>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260105211913.24049-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260105211913.24049-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 32009206-2ee1-4f4d-dfce-08de4ca5117e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTBsMXRvZEtOejJwL2pEZ2RSMjJYTlFTTUs2TU5ZYnVBZXJ4TzA4NHlGOXRG?=
 =?utf-8?B?dHI1SWIxRGt3Sld4M0g2cFphMDZxYktUYXRvNVJoZ2FEUm1ESDNvbHRzL2Ux?=
 =?utf-8?B?c1ZGQ1JBVWIrcU52TDI0cFRGdHlXOWl0Y0VxZUFmNTRtN2FTbmN6TGZZRTZ4?=
 =?utf-8?B?dlhmYzZxVnpUek1MU1Z1SVFqKzQ5MzNOVUFKRDBmSW4rZUhYNUpLakxkZ0dy?=
 =?utf-8?B?RWlqdmZYeFV0clJtR3lwdzhsck5xY2pkTVl3R0VjZGI0b2F5K0pRSSs2TkFD?=
 =?utf-8?B?VHJibzczUk90SmV2b3NIY3J0QTNTSmxTemZxREp3bnJ0S3gvNU1GMGV1dVRu?=
 =?utf-8?B?bDRZNVRaQmpjcWdSRnJqWXVuMVc5endLQnplc0s2cmdFRE13ZWJ4RUVKbXh1?=
 =?utf-8?B?Y0xTZVNKbkpxbXNveCtoTkg1NHZiTjRKeXdaU2hqTWFNN1JUOXV2VGt5UlUw?=
 =?utf-8?B?OXllcUM3dWVycEpFc0VGNkF6SEZ2RThxM2pkVVF1TkYxcUsvbFJnOGppMG9h?=
 =?utf-8?B?V0MxSXZMVjVDLzFOaGw5dzk4YjljUVorbE5NMU1JTmlhaU9qTlowb0hPQVp6?=
 =?utf-8?B?MGY0RHBod0hURGdrOHU1VFBTQndVU0lQbkNkbHprc2lBTmk0dTlsYnQ1L1Ri?=
 =?utf-8?B?dTEyODBUa09iZ1gvLzM3U2tpaW96VU01aWhOWE5ZQndjN1M2dkZnM0lBb3h4?=
 =?utf-8?B?SnZSSlpNSFc4OWJzYk9UQjJzSGM5WHNiWkRKUC8ydUFLbjhHamluODNsb0dJ?=
 =?utf-8?B?N2VNS0d0aDBzSGhJNWdUc2ZTNThIbHhwMDZxRTJEbUhlNDJLa09BVkZwdTM5?=
 =?utf-8?B?NXM2d1k2Q1VEdmFrdTlnSnBIeHh6UzFhelh0ZEtYQ3AvWEN6VnFvelZ4US9k?=
 =?utf-8?B?aTBGcnQ1SVJ2SnlpMHZwTnZidlZxZkpYNHpEVlEzakpncDhpWlB3bG9tUXJO?=
 =?utf-8?B?UlVDaUlkdEtKczJaR2ZHODB1OE9LM01La1BMWnRNQ2pGMWJGdVZXVGFiL01B?=
 =?utf-8?B?QW5Sa3ZldGVBRVZORmZkUTRVSnhSY1JnV1QyV1JPeFo4c3F3cXZEZU1sVktH?=
 =?utf-8?B?N2RtWWJOSmYyTjZqNTROVEpHaWkzcy93NXdPQmdvZjlPUEpzalpCbElPdlBo?=
 =?utf-8?B?WmY0eVJXTnNRaWp2Q0Y3OWRDbXZWdzEzZHNaUDhJM2Ria0VMS2FRbHpEcGh3?=
 =?utf-8?B?N3V6Uzdrb09GYUQ5RlA5TGo2VzAzMmVOSG9kK2RFM1hiRVhiM2NZWndhVUFP?=
 =?utf-8?B?b2xsSCtuOEUyajJ4YWVqVVduZkNWR1hnSmRHbTlPM050ZEo3M3FWQzZjT2Fk?=
 =?utf-8?B?b25aejdzVk53RkRSbklhWExSMXlvU1RqQjZOeWpCSWpLYlRSelpPZElwTlBG?=
 =?utf-8?B?RDhqTEpGSXUvbmZWOEg0NUZZSUJlNllSamgwaVpLYldrcU9WUHZBcVZ4LzVZ?=
 =?utf-8?B?N1ZlUmlBdE1CMVgrd1ZGVmxzZm1pSzdMVEVWN2NuLy9NUFVlM1YwUzRmTHF2?=
 =?utf-8?B?dmllSHUyMlpVQTNQbzBHZTBMaGovNG9sOG9GMHBMSXpjWUo0ZEZrams0NW54?=
 =?utf-8?B?aW1nRzgrejRSS0VzZ0E2UGNqa1NuWHF4Y3Zma0d5bzA2UkNtUzNKZDhFUzRh?=
 =?utf-8?B?VE5WYTBtKzA5QVR0NDhmYk5saWQ4aWlRM1A4U1hJaTIwSWFPRGk1VnlIQVN2?=
 =?utf-8?B?ZmFoMERUL2h0aG8rd21kR1lOQUlRRGxVczFUdWJmQXhmVVdMUUNqOC9vbjNI?=
 =?utf-8?B?aGZHTWJDZDh1Tmt2TW4yT1VNMmlDa1o0OFpDblVONkhaVDY3TXdyVUpzNmxr?=
 =?utf-8?B?ZVpFL3I5WDJTeGVDQ3UzWTBGeS83VjNpVjVLR2JwZGpEMjFYL1pQOTU4a3lu?=
 =?utf-8?B?NFFIQ1VoczgyNzNjbEY4emxMM3lKU2tLYzYvU2dqdVZEZSs2UWdKclpRT05x?=
 =?utf-8?Q?MxqHOvD0iL+Bc4DQW93icZfOPQ1hS/pG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3hGTllwUDVwM1ZnRElKOVc5am9PdElpSTVYdnp1S25yK3ZBS25qMWFpNHc5?=
 =?utf-8?B?S2JuK0MwUXM1SzRRUDE5RFpTMi9BSVpGeWxWRnkwZ0w5RmNIc1V2WXpkTlly?=
 =?utf-8?B?Y2xqT1FlRDRaT1NmeGN3UGVhSFozaldIdDJVMlNwNitIWGkzR1BvbW1seVBJ?=
 =?utf-8?B?VGNTL2dtUGpHS1Zvb0NVQ1JWMEE5S0dTeFA2Y0RJKzY1OE5qdnJCc0g4ODVz?=
 =?utf-8?B?SDhRbUtkREJ2UmgxSjdPY2RESVQ1YUczYWV4MXVFY1RQc3AxUEJ2WVVRY2E2?=
 =?utf-8?B?SW8zRlpWaEpYZFlBVmVVcTIvVHQ3cTJzaThmMGJhNWtYUXU0V0kzN2I5QTI3?=
 =?utf-8?B?d0x0M0FwVWZjQVZBbHMrYjAzejNsM1FZbm95S09zRXJjSmpnVTkra3ROa2d2?=
 =?utf-8?B?bkRDUGcyZWU2OGFOdEs0eDVteVk2TitJNE5rZ3Z5OW9ZY0VBRG1tL0JXZVFx?=
 =?utf-8?B?dllrOEV3WUxWVjJ2NW1FQ2I0NHRPM2RrWnRZZ1FvQktzL3p6NDRYakdnM0o0?=
 =?utf-8?B?eXdvUzZ1a3hFbTkxUEFXVm5MSnBEUWRTTEV6UGVnSFVCaCt1V0FYTmFvSXRB?=
 =?utf-8?B?V0cxclFXcmhSemx3Yzd3QlYrNyt0ankrQk14YkR5UTU1SFZrSVRkbUw3endX?=
 =?utf-8?B?VUdvdzFBelpqdTAvcXpWK0Q1dUFOSkNBREhid2NxUUF3WTdYMlJiM0RxNTkw?=
 =?utf-8?B?Ulp2K2tYZms5cHo3dnJPQU9Nci83ekdkSWpJSG9sNTBFL1JBdkNnVWpCUytH?=
 =?utf-8?B?Uy9yYkpuVkViT1cvaVFPaFBtQ3ZpY2ZvZm5XdTlqK2ViQVJxODk2emdCMVBl?=
 =?utf-8?B?b0pOaDRweFdpK3pqNCs5akIrc0RVY3dwbDFTU0p4MklkenBjbEhqa2NuSFRK?=
 =?utf-8?B?VmUwZzd0SUdtd1IvWlZLRm5PK2dDWTdkVUN3d1BNaGZiMEVNQXF6RS9oeEl5?=
 =?utf-8?B?cDZWQWhNWHFDVUJCMGQ5NWFkQnZVb09IWEg2UVA5R1VsMXVSNGlxaVI2eTVt?=
 =?utf-8?B?a2ovRU9LaGRQZFI1Y2VFMSs5K1ViblVEampUMmlXN3FxYWdHam5lZlJla3VM?=
 =?utf-8?B?UkJNTzFUTFNGQjNsVHhqUTUvM0dWOGF5eXpQbWVGakVzWlZock1DZHU1K0JH?=
 =?utf-8?B?bXpFUEUxY2NMWXN6TW4wRStERklNS2lZcGx6TmhpNEswZFJiYWtCUTExZDlj?=
 =?utf-8?B?NmVzalJ1UW1LN25kKzlJK2lDVjg4YTVrRmxQdTltTTZKRElBVklDVVc0U05F?=
 =?utf-8?B?aWtwaXlHbEIwNm9kOXlTTVpzZDg5SWNiRHdGV3pKdXp6VW1Yak5ySGw4RDJt?=
 =?utf-8?B?alNNbzBPRmxndEVCdWVaRlgzRURKbWROZnRDREVISGRoM2xvZHVEUlNjYldP?=
 =?utf-8?B?Q2FkZ0d1QjUwWHI5ZWZEam5XUWsySjF1WEZIWGViemJ6MXZidW9KbWRQcXVL?=
 =?utf-8?B?SWZFSWIyNDh3V1ZyZ1lpUTl0T3ZwZEd4YlZVNXdLRHY0aGk4SEd2QmFyWHFp?=
 =?utf-8?B?OU1VM1VrNy9wMUZqUlpTdjFpRTlwenBIWkFHOTBLYnNMczkySFlmTDcwRmdM?=
 =?utf-8?B?OVdWVkpSUzFKV3YvakJXbUV0ZWc4ZTBKVXQwMk1lL09ZRGYxVEgwVmt1WE52?=
 =?utf-8?B?bUFtZnp1Sk1qb05EcGpTWUNJSkRwaE5yZ3VoMGgzZW1aNHlMVVFkTkZmVjBh?=
 =?utf-8?B?aURxYmNneXRCSkhZektmcjdCQ0c5WUREdElTNnA4bUF5RVFRcm1abUJXNlpn?=
 =?utf-8?B?Q2lxamp5QTExWUY5N21GeDRFTTIra3FCa1lKbFVhSU1sZHQrUFlCY3hzc0pk?=
 =?utf-8?B?elY0UjRWa3NKdTBOOGs3VjV1cnl3M3I0MW9mcGoya0dEQWlhQXU0NnlRd0tE?=
 =?utf-8?B?czA4Z1gvUDIzOU1ZNUpFZmcxc0FGT2ltdkpUS0o3djRPblQ5SDlxbXpXUjM4?=
 =?utf-8?B?THQ3VkVWWlcrQkt2UjVMMVAzY3VlZjVROFBUVDJLS0gxWVREZnl6QjZVamdK?=
 =?utf-8?B?SEVIcFE4V0hHRGs2V0ZqVWFGejV3ZExEd0dsM1o0aDVDLzBWeHRSdDB5SzFy?=
 =?utf-8?B?eC93bDhNN2tRb2ZxWkZqc0F4ZWpIb2VCQWFFb0phc0ZJNkZHN1BxWVAvQU5Q?=
 =?utf-8?B?MkpXSVdNNEUza3QzRUdZc29UYktWczFNVGx6NkRjM0hCQnJnbFdCVGFpWUZV?=
 =?utf-8?B?ZjN3My9JR09peXVtVjJPQk9NdTIxaXJsUGpZQlRpa2JjMWVkVlVvTml4bll1?=
 =?utf-8?B?OHlsNHpBdFdWRVVhWUNCRi9JTXIxTDJJN1YyU2ZxY2MwQ3JXSjZPTnU5MTZr?=
 =?utf-8?B?TlZnSHkwL1RmVk5DcCsyaUhud1JBZXFVK3k1b1RWOTBtOThYUFJxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32009206-2ee1-4f4d-dfce-08de4ca5117e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 21:54:58.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKxGXJYFymtK7rsijLaa/6jSI/RrivB9BSJxmHXD5xJu/mIOxi7Qe9RVfyIYTh4kylFVhHL0HopW2vkgqExcow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057



On 1/5/2026 1:19 PM, Thomas Fourier wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> The size of the buffer is not the same when alloc'd with
> dma_alloc_coherent() in he_init_tpdrq() and freed.
>
> Fixes: ede58ef28e10 ("atm: remove deprecated use of pci api")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>   drivers/atm/he.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/atm/he.c b/drivers/atm/he.c
> index ad91cc6a34fc..92a041d5387b 100644
> --- a/drivers/atm/he.c
> +++ b/drivers/atm/he.c
> @@ -1587,7 +1587,8 @@ he_stop(struct he_dev *he_dev)
>                                    he_dev->tbrq_base, he_dev->tbrq_phys);
>
>          if (he_dev->tpdrq_base)
> -               dma_free_coherent(&he_dev->pci_dev->dev, CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq),
> +               dma_free_coherent(&he_dev->pci_dev->dev,
> +                                 CONFIG_TPDRQ_SIZE * sizeof(struct he_tpdrq),

Sizes seem to align now. LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>                                    he_dev->tpdrq_base, he_dev->tpdrq_phys);
>
>          dma_pool_destroy(he_dev->tpd_pool);
> --
> 2.43.0
>
>


