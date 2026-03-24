Return-Path: <stable+bounces-230098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG6tCUVewml5cAQAu9opvQ
	(envelope-from <stable+bounces-230098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:49:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A530305E65
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C6AE300E1B5
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FD3C870B;
	Tue, 24 Mar 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZoXKIVSH"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012011.outbound.protection.outlook.com [52.103.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB6318EDF;
	Tue, 24 Mar 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345226; cv=fail; b=VmOHL2D++3Y1ZmFbGwtuRaTno3khqZZFayfFMLMKCykqcG039k4KPNb06Qj9ZfNqv67aqJ6FQp96nD25AQsStH94oea8YXWxed13p6smPqezpsfwSLVZTNfXt7Qe1y9jJBHAZC0thScfmTTuNXzRnKcSuZbOkcYmAyTiZYxR2HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345226; c=relaxed/simple;
	bh=7BrqyfK2x4Teu3ltKzGHSlI1NLYJmUjpgjNife1M18s=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=BQR7w2XwQCCuNPowWPgWXZRtg1wkhvdf3z63wN7Jq7W4KfQ36sOMR/WXDQUXq99HRvfak9al/unqG5Xo7IZjLcQgodZYIjuVWv2UQ6CmLjY+EXHhe42N22HSNH0K5bQEoEVtVg4o9fSHYwwjGy/8MhmONunFKmA3BdlW4eVQAdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZoXKIVSH; arc=fail smtp.client-ip=52.103.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZBuBLmMYblbU5e7JOMGbzXp6GvG8pW/WjYhVcg+sIOE+mJO7+Fi6LAZNvN01E9Fvwvj66YTgEK9hxrmG3D5avgHI2kOx+jgj5hIPRTChAgLNiOA+ovYxpzkgCUc2g2y6QhM+FmxPIpk7mjEIiuCepdzOg5PgZ1xvyeDd/ZNvdDIsKswxkiiK9YjwV1VpQrg9yGAD1K5sTtjwFmwTi+cI8SEtnBRO5JaGQPc21pC57lfhX5gvFBmQRQ3yj9vTN4GjDXMJZsgb6+/teSxy4mmyhM7P7IMx7Fw4XE8jEpLEHHUlWDHhr29M3QqL6yXLxc/qCWQIom4FE2fh1nRKidKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Soj7WaLUBkqT6s8gc76FX7TN72ERv3y6yJFYJSpLpx0=;
 b=OaHmEgmPd6C09PryagOWOBi4xNIoqi3Oc/uaXH1S8Lrwga0mfsQeZ5XZ+VTIh6/dw6+O4i9n2awbu/9RMLqS4U5LrfuF05SjumnGeXA3Rtu4y7NZCn/+mgzJ2Y//HYM2tFJakveDSTzBnab3IiCgK4+1fQRThvVulNQIlysYcvHHtLo8Xl7Eg+Vm/zvWFE12HT8ofQux7Ok4173qhiQeTS8b/rZImmBy8f3yvak18TcAyCO+TussVm0xlzfAxWdCBioVMho+O6rkGMn7yHk1HabakIguH2+kJoMfmWb1FOZYNbOJuFWu6ZCceZLfhCuJUu9heu8yPUH7UtjibanzEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Soj7WaLUBkqT6s8gc76FX7TN72ERv3y6yJFYJSpLpx0=;
 b=ZoXKIVSHiPCPv+ObUMAkGtoOOWOdPiPFSYVwKDS4C5vTccGbKEdMUx+4G+JSheu78tzEo2nzs2oJF/NSi4mcA1Sr37LIUoMFDMYC3nhpem8qkQaGXOTDWCj/UQQDFJXzFni2UxW0AmxAad4QIDb6ep1Rdj9AHjwxYHCZZofy0DCS8pgJITUfKLqJ03bIgC/26cKMqkM0PE0BvxkoWk6HCkfKqprjVCdPikt+YOyk3D3u5h//3kfFAMs5g4+5qWBM3j15vIdFqIpnYd7UJwjv1PlNEdcxRvvqGTJaQ6Z41w2faq8UJzBloLWF92DKjQ1x+QM7IbiokTib3L6EI2WOUA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY7PR01MB10183.ausprd01.prod.outlook.com (2603:10c6:10:2ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 09:40:20 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9723.022; Tue, 24 Mar 2026
 09:40:20 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 24 Mar 2026 17:39:02 +0800
Subject: [PATCH] drm/amdgpu: validate doorbell_offset in user queue
 creation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78816FAF00EC3DADFA588E0CAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMT3bTMitRiXcvUVLPkxCTzpGQTcyWg2oKiVLAEUGl0bG0tAHHDj3p
 XAAAA
X-Change-ID: 20260324-fixes-9ee6cab7bc47
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=7BrqyfK2x4Teu3ltKzGHSlI1NLYJmUjpgjNife1M18s=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhsxD0Vt7jpfwCXNYmzjcCfmfbvKpasoBm51/6+b5H8g4L
 5dc97Oko5SFQYyLQVZMkeV4waVvFr5bdLf4bEmGmcPKBDKEgYtTACYiUcPIsChr/l0eTu+fp1vu
 5C/mWu18IOBKuPz0l/FJSpM4bRbOY2L4H5558wanrmZcY+2i1vpNndJPGzvsJt+rTNpSz/i1t+U
 8LwA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4P286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::14) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260324-fixes-v1-1-89a71cf075d8@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY7PR01MB10183:EE_
X-MS-Office365-Filtering-Correlation-Id: 828dffa0-b803-443b-2208-08de89895d16
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|24121999003|22091999003|461199028|15080799012|8060799015|5062599005|5072599009|6090799003|51005399006|19110799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFVpY0xoZE94YXBMbllsSE56cnNBR2JqZk5KSUhPOXJTcVlHUkREa1RzajZI?=
 =?utf-8?B?Ykg3VkFKVHNvdTMyS3V6Z09LMnk5clFEMTFxa0QyTm9QZHVUV2Y1S2xJOVJR?=
 =?utf-8?B?dzBGVVNQbVFzRXgrWWRlOHRWZ2pXTnM0Uzdrb3Q3S2ppaEZtdVZBWkdkS2RR?=
 =?utf-8?B?cEVMVGJDOWlrcmpRQTlNSWVJSXlMaHdpZFZKK1FoRFNuSTZ0VlZkbXJ1SWQv?=
 =?utf-8?B?SWtmTlRwU2xVdjRCUjl6c3JyQTVyakh0YVZGbkJqVGxQbGNMeUZTVDdjY3Br?=
 =?utf-8?B?M04wWUdaRWtwMHVrcU9Wbm82UEdpNUlrbmJnb0Rxay9tU29CT25SbU50aWNk?=
 =?utf-8?B?ZHUrVjhFS1RiTllyOEd6QUY1ZGNvM0FzT3NZcFhxYlVhZ1FSbEFvOVUyQVFP?=
 =?utf-8?B?WjhXSWxLaHhVVEV3Mzd3alViRGppODQwZjlIN29TRU5jNVdWRWdEZ0xZNVJ2?=
 =?utf-8?B?dGdCWlNjOFZ2WmlncWY0RkxrZnVCQVVSakYxbHFUTDNZUmlVM1pDRXhPak9S?=
 =?utf-8?B?bkZDbTBBM1Y4dlBKQVAxK2h5VXI0ZG13b09hVllxS25vTmlELzNTTDhsZ1l4?=
 =?utf-8?B?N1lVNTN1Zjlkc09na1MyNUtRMnRXd042Sy8zSm45R1c4cmdsaTJOVkVyTXJ4?=
 =?utf-8?B?bGJqZ1A2V0d4Z0wwWWpFbU5iSStwek1aOERralp6WkxGSjBCSEhETEJxSFpv?=
 =?utf-8?B?eCtxTTltWUVsWGlPQkxEcVEyUXBOMDNjc0tZcGNBTkIrT3A4eXAzTEthNkxN?=
 =?utf-8?B?eWF0ZXBybFkxTXV1NE5MVDE0WkJvZVJ1dkdMSWNvSk4yVDg1WVhWZUF4azk2?=
 =?utf-8?B?S2U3ckJKVWpZMGJnSmU5dEwraVljUG1VditiY3NSWGZPM0VodjNjTXNBZFVM?=
 =?utf-8?B?MEk2Q2w0ZkVRMW9lQmN4VTFXMkl2b3lrcGcrM0QzTUFOWDF1eDVFUHF3Tk1l?=
 =?utf-8?B?RElYMFVKZnVZRzMyc0F2RTExNkI3Q3RBSFk5RVY2NFZMSkNjUVZ4UUlDTm0z?=
 =?utf-8?B?bVNOMkdVOWhZdTZmWXpEUDhxRU15VDdEaDQ4c3BQN3o3Yi9oV3dORlhnUEdS?=
 =?utf-8?B?U2ZRM0UvK21DWjZWUi9DaGRzaG5RMGR2M0hiQmErRDVRVkRudDE5ZHBDdVdp?=
 =?utf-8?B?YUtWT25ETE5xODF0aXA2czVsZXZZb29JM0xvZlhFQ3ovN1hlekZKTkZqdzhw?=
 =?utf-8?B?bURabUp2cHRKNHIybTRlV1RBYzRlR2Iwd0xSUkdsYUNBVU5HczNXMnlNV2o3?=
 =?utf-8?B?ZnBKUnhUcjU3NmhpRXNkc0V0UW42NGFSNU5PWXBEZnRIK216OU5QMUxwR0FJ?=
 =?utf-8?B?S2doemhHMHFnZGJBSTB4dFliRlZiU3NzQjRPcXRwa2tSbU9qRDNZQzdvM0V2?=
 =?utf-8?B?Tnlzd3hjbHh2WVFKVXhYcDZIUlh5VE1tZDFxbFgzY1M0dkFKUjRxN25kbTRl?=
 =?utf-8?Q?9WBafKh7?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDhJeTB6T0pOUXVHbnUxZE8rNDNkbmtYYklWenpQMUM3eU02NGpVVnAzRVRy?=
 =?utf-8?B?WGdzVGR0U211WS85QURWS3RQMGVjY2lGU0Z6NUFpL2ViUmY3Z1NUMlZoRjVX?=
 =?utf-8?B?STFBaDh0MDl4SEUwcFA4SXd4bFFxNmh2L0FhOVlKV2swUHNiMWIwQ1pKYVNM?=
 =?utf-8?B?eitodklDbHVmYWkzM21vMUVTN2pjY1JlWFhoWFJESGQzVEt3RDVWWkxpZ21a?=
 =?utf-8?B?NFZVcmM0NUhtUk5xVk1KRUxIdVRnRThibTZwOVVUbmtiUTB2ZVJNNmNQbUww?=
 =?utf-8?B?VnNucU14MDRVUTZVUWk2Z0NPYVpSWVVZTVFyNHM1dGtDclZDMSs4Q0dySk1E?=
 =?utf-8?B?bVVDWG9VbU92bjUzd3VYQmRFNDdQRGZ2blBlMTNNcGpRKzl4LzBCWkovd251?=
 =?utf-8?B?Z2N2VnIzRGRQdy8xUW1wcmZIcjcyNEx5ZUQ0ZVRKYVB5TUI2UE1GaU4vTVBQ?=
 =?utf-8?B?dU8yMUk4U09SNTFBR3R6cGVnL1hnYXVHSDkxMW1PRFJXb2l0QjVzR2d6LzUw?=
 =?utf-8?B?TGhaMDNEWFdubldMV2xNWHVEOEhIaTNsVENYNEZiWVZqdFJFSHV3RHlKRWd4?=
 =?utf-8?B?a0N0ZWs4NFR6c3JaU0VId1NRS2R1RGJKK2RNMlU2SFdXZnBNSnpTUmozaW9W?=
 =?utf-8?B?TE1EbUoyU3VmbHNLYTFhTGVaYW0vVzFFTHJ0alRodEJHQzZlNldWc3JBRE5m?=
 =?utf-8?B?LzUxMmx4TnJDTFhEcjU2aG1Pb2VYNlRZK2FhVVQyR3AxUGtaaHNtbm1HaXJK?=
 =?utf-8?B?eXFvK3dDb3dJeHFXV3RFSWcwVk5YS0N4QW1QeFpITHB1N1NXSVR5M0tRb3RX?=
 =?utf-8?B?TVRlT0lOSHJHRmo0aXdPem5hMzE2MlF1NGIrTHpvTmZzM1NvV3F4UDhDQUR5?=
 =?utf-8?B?U0lETzk4dmh6QUNVUll1KzNoVzBiQnR3Y3g1WEZvbDgwT0NHWUFBcjlWb2dH?=
 =?utf-8?B?aWd6clVPa3djTCtSUWtzNDFYTmxpMjZjdDFKK2UvRWMwTHVVMHNpaDRPVk9K?=
 =?utf-8?B?YXRrMUZlM2ZmVlJoY0g0S3RWSDloRmFpTmNjZ1dnRzBubHlLS1NiS2lVRm9Y?=
 =?utf-8?B?UFFIY1VUZFlwNDBZbncyS3FNMjhvclFqaDRpSTRjY3pYVmhuYjBycGpyRys0?=
 =?utf-8?B?VlRoYzRmbmR5VmpMWGg0NjZVY1VKenBmN1pwNmJXRGhlRTVTRDVaQUQybHBE?=
 =?utf-8?B?VE5XWDFHNUFmKzBISkN1Tnp2N0hoM1JNdngvZ1Nzb0NLOFBqaU8vN3MyN2J0?=
 =?utf-8?B?MkQvL1F2djdScmg4ZEdxaHRwMVhIQlNVYW94ZlBiT0tWZ2JzZ29CSVNVdS9a?=
 =?utf-8?B?aVltcmFmM2JuVmpYTmlKTk9tRzVYRDBDUTd3eDlxSG8xMUlPckNwRytxb1NO?=
 =?utf-8?B?U2w3L0FpMDN0UUtpZEtkV0x6Qlk5cGlvcEttakVVOWl5MjZWL3lMMmp5OUE4?=
 =?utf-8?B?eER0bWxUbHBhdjZwMmgvMjNqcVd2RE9VTzJpdmVMeHFQai9kbU9KZzVicGk5?=
 =?utf-8?B?KzdXc0JoMkNIT0xJUG9ybTlPcy9QUmsvcmpYYVRid3NVbEVIOEdxRVJQMmVD?=
 =?utf-8?B?aVRCMFVtcW5CMjlFVXU5K21XMkhtdi85aTBKSU03c3lLWGJoQitMajdtNjZD?=
 =?utf-8?B?NmZ6YnU1QkpjTDh3NE9rT1hwc3RPQitkVmZXZFUzck94UjRPNGs3QkZORDJR?=
 =?utf-8?B?NWEyWFUwWDd0SWFIcUpWd1orREZWMHY4dzJsa3BobmxqdDF1ak9RcTFlaEph?=
 =?utf-8?B?RTdBT1hQWnBqTjc0amhaVlRmNmd1cHpaRmZYak0rTWF3Z2dOK0lXaW9ndlp2?=
 =?utf-8?B?NzZuRFVvSlRMZjBlbjZRcURHM0phZktXeDBESmltOWFnNU0rRWU2SS9KVmVO?=
 =?utf-8?B?NEZiRlJ1elJPSURKQXlxUUFONU4rM28yZWxNYzBnZFFJZ1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828dffa0-b803-443b-2208-08de89895d16
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:40:20.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB10183
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230098-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com,outlook.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,SYBPR01MB7881.ausprd01.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 2A530305E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

amdgpu_userq_get_doorbell_index() passes the user-provided
doorbell_offset to amdgpu_doorbell_index_on_bar() without bounds
checking. An arbitrarily large doorbell_offset can cause the
calculated doorbell index to fall outside the allocated doorbell BO,
potentially corrupting kernel doorbell space.

Validate that doorbell_offset falls within the doorbell BO before
computing the BAR index, using u64 arithmetic to prevent overflow.

Fixes: f09c1e6077ab ("drm/amdgpu: generate doorbell index for userqueue")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7c450350847d..0a1b93259887 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -600,6 +600,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 		goto unpin_bo;
 	}
 
+	/* Validate doorbell_offset is within the doorbell BO */
+	if ((u64)db_info->doorbell_offset * db_size + db_size >
+	    amdgpu_bo_size(db_obj->obj)) {
+		r = -EINVAL;
+		goto unpin_bo;
+	}
+
 	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
 					     db_info->doorbell_offset, db_size);
 	drm_dbg_driver(adev_to_drm(uq_mgr->adev),

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260324-fixes-9ee6cab7bc47

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


