Return-Path: <stable+bounces-165732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED32B18175
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 14:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB44E1794D0
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92312367B0;
	Fri,  1 Aug 2025 12:05:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF521D3C0
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049902; cv=fail; b=qXFBu/XJ7n+opY3/46xO6f3GusY4kFkLZiW3eirO0QsxwkBoNnbKK+JZlPfR/tze+EJbEUXfg0pht+EL9ceevRFX0MqR8axSumzipvX3M/g3uAZzyGziD7KacGP1ShkhkueyRRrzGf3f4TZZfVcqpWW44BTM+Z0grX7kjz8oZE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049902; c=relaxed/simple;
	bh=Q4P/P7GYS7gfYR9PM43HCux497/jbaslHVldsZjhJlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CLVLuDxACg5dn5yd+wNk4yC4o5zr06XZGd7n419eqbs8q379obB0CYb92UzgEU9zU0u6B5h3Mz4EJZLNv+6XASldtw0m2hEu7XRDOmQ3r4iWJ7tRXIHi4/RGPqW1nPJhyVc4frZ9OYvER4+IJskTvkj/jtEUoY6zWv4v36Lq/zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 571BsgJQ3714998;
	Fri, 1 Aug 2025 05:04:56 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 484ta1xcp5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 05:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCB6uisFfm73tSuIWlX/jCzwM4rU6NXDUBnDA31d9Pew2yZvRb91YMeK51P/egVFNrwGLl2N7dGAL6jXXDg6swcdQ/I7mDI7ImtAjk+seX4kRGhTf7OJL4J0Z7RZXfpGb9pCQ+VP0dg8ivATLGLzvZ4KyVWhH4UIpFKkclqUCLNiDMSI/AGUFE4H6OcpAumd9khlsTG07witwK360Ex5aHqzmIxVWCC8iWTBBEw1EBCbR5Vrs2Bq4yISu4fQg4155I6Xe+I7e7D5i623d/fEvGZYT7Ys3LhzRfvotEDEnWzsZ5yvywlmwO4xxMdFcYgZljjp5cjsbtgqR8QpOu1jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4P/P7GYS7gfYR9PM43HCux497/jbaslHVldsZjhJlE=;
 b=QBzYS8vkIXYHxeu5wJZ8cLXBv+DzA/1FNHBNfBzlHVrnAsqvJ6ZxiABK/GUMQM9AeELi9l7CfWgqr7mOvVv3kQSjVdSETgePIqOtapZO18iB28NBU3X6RqKsPhQFP1ndelDPCJhzNA2Ce5rg0oOC6O6Na98lfHa4w6Uj+4lSPQbvNPS74P5ZkuvL3OROMuVjBttGU2tWbmvGkyfmLVir6u/GgOTTlWzo5BXYplZoUMQBqPe1en0YKflitqmvT7+dbmL93v0dYSf7GvaCg1Z3qSjv3y4i4OMbCvxKLsKpg8viP0fXWCNMdADgnf1midSdhA5McN4xXYATJhPKAievWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) by
 MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Fri, 1 Aug
 2025 12:04:54 +0000
Received: from DS0PR11MB7959.namprd11.prod.outlook.com
 ([fe80::a6d6:fbc:7f77:251b]) by DS0PR11MB7959.namprd11.prod.outlook.com
 ([fe80::a6d6:fbc:7f77:251b%4]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 12:04:54 +0000
From: "Hao, Qingfeng" <Qingfeng.Hao@windriver.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "He, Zhe" <Zhe.He@windriver.com>
Subject: RE: [PATCH vulns 0/1] change the sha1 for CVE-2024-26661
Thread-Topic: [PATCH vulns 0/1] change the sha1 for CVE-2024-26661
Thread-Index: AQHcApnIYcqTIYLCrUWMW9CZ28DNcrRNaiKAgABJSWA=
Date: Fri, 1 Aug 2025 12:04:54 +0000
Message-ID:
 <DS0PR11MB79597F9B511913D0EF4DDA458826A@DS0PR11MB7959.namprd11.prod.outlook.com>
References: <20250801040635.4190980-1-qingfeng.hao@windriver.com>
 <2025080132-landlady-stilt-e9f2@gregkh>
In-Reply-To: <2025080132-landlady-stilt-e9f2@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=b47fbd50-4f8b-468b-a8c7-decb2d2e8b11;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-08-01T12:03:36Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7959:EE_|MW4PR11MB6690:EE_
x-ms-office365-filtering-correlation-id: cd3a0e53-ce69-42a7-2370-08ddd0f3a069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QStzNWIyYnVQRmFwQzBnczhLU3pRSExsUE1OR2MrL25lWHMxVFNxb1l5R2dD?=
 =?gb2312?B?QW1BT1VuOThYdm9Jc0hwYVBGbFZ6S1FpK3czbEZqeFY2NjJBWVVtWXQzcFVB?=
 =?gb2312?B?cjByV2s1Mnhsd1RRODBMN1I0NHJsejdZVnNwNVJOTWNSTlJ0OWNZVUVIOWox?=
 =?gb2312?B?UllnNUZRTDVzbVVqNkVDNGVTOENFOWJBVUZualUwc0Rkb09KMVF2ZXNUNDFi?=
 =?gb2312?B?b1VWUStFU0s2dkJleHBzK0RLSEVNZldoNnkwUWtKZ2duOVZ5NVV4bVpTT0dZ?=
 =?gb2312?B?NnNUSzh4ZTV6MWMwODBxOW1PRjR2YS9xR0MydTVwcFQrbk1QOEZSdUNiR2hz?=
 =?gb2312?B?NmNLT3RZenl1V0lGcXZWbkRHd3hLUXBiNEhHYlFmdkZTSmtaQ0V1UlBBcEJt?=
 =?gb2312?B?TERkeFVoYUxyUC9VeXZaQ0lxTE5EeDAyWTI2VFBpYndMeS96ekc5VndiZENR?=
 =?gb2312?B?am0xUmhkUDhxZmc2Tm5hTmJGd1pSdkF6LzFYSlZDQVFjYWxFMzBOUFhucWty?=
 =?gb2312?B?T0JXSm4yY2YzcmIzWW4yY3lxeFoxWExmdk8vZ0kyWVJadjZaS3pzSlhJY0hN?=
 =?gb2312?B?V3ZydjNNbU93WUtacmo2a3VJMDZpdHZWWUFtMFFHSk56djU0YzRPTVNRUFFa?=
 =?gb2312?B?M2Y4NDYyelZ3UkM2ZmVQc1ZlK3RMTG14MGNha1dmNGd2aUpRdWVuOUpnTTJC?=
 =?gb2312?B?UStKWmVzZ1hwUzZkK3c2d2lQMnozZ2hHODc3R1QveS9ldEdicWgyUGhYTnpJ?=
 =?gb2312?B?d2w2Qk1QcGZ1NDl3b2xBQXRPOUNyaUwwSGtJbXVXNUExNTIwMWxsMHJXSFhH?=
 =?gb2312?B?VkxoSWt0ZG53TW9UMERnRHdzd2lHd1hxdXdvZjdYR2dNQ2toNlNpN0VKZGs4?=
 =?gb2312?B?R1Y4SzBud2JIcjBoS0VMS0FPelpkNmNhS2hUTE0wZnVuRjRrcnUyRFUvTVB0?=
 =?gb2312?B?bUpMcDloQjBLNkwzWHJXcWFXVHlvRWVDY1B0VmozRGxaOENzd1NnQ01zUzZs?=
 =?gb2312?B?QWRuOTljblVISkZCdVFWckJoNXRkOGFUemZWYTNZVDBPZys4MlZqVzZPNzVh?=
 =?gb2312?B?WGxxTDZ6ZFd6RjZ6MmpzOFlYZzVpeDYvQ2FiUThOTnN4SkYreVRKbWFuVW13?=
 =?gb2312?B?eVFDaEFENVcxNDBnVUQzMG5HYzZOajhVZFh1ckFOb2ZpYjRUckpjVUNoYVFV?=
 =?gb2312?B?aWZzL2FPOS9HV1UwTis3a1BqMlNTSi9qVnBxLzhiamJuVXBrbjU2VGpuRHJl?=
 =?gb2312?B?dGdnTUsvSCtRSnFPU3hrK0lZc2JyLzlwUzVmTDl3bGhsc2lOS1pMbGdPdmFD?=
 =?gb2312?B?L2hUcmU5bE5lckpEVlp5eWoyNU81UDZ6VlF2YUVMdlNvNUVqeXNpNnhWQ2ZI?=
 =?gb2312?B?ekRJbEE0SmRycmk4SDRWaG1UaUhXUDh2djhOc0lqTXVKS0laeGZ6WG5xQjI4?=
 =?gb2312?B?ZTV0NlYwNUtIbnY5Ulo2QWtQZmwvdmVJZUNCTjcwZUNUamJOc0ZjYTczK1lL?=
 =?gb2312?B?dXRpK096Z2p0SHBEZlREUno0UzRRZnpINUVzS2RpTzFLRmFTTndZLzUrbGs0?=
 =?gb2312?B?d2VKTEx3SDdIR0dHRFg5c3ZCbTVncytGcGhxWGpSM1dQNWo3VGZNWjVualFv?=
 =?gb2312?B?dlY2eUZXT04rQUIrQWhDbVVBaUt1Vm8rcU9lQ0pPbGxlRlpNdEhiSENCK092?=
 =?gb2312?B?YVE5bkJ3dTZaRzQ2ekdNcmV0V0VhTFZBV1AyMVhlV1VUWmlnRFlUcmZTb3NC?=
 =?gb2312?B?TlhmMEZpb0ZSSVVSQW9obmRLSTdYeGNsZmpYclBMbi9FUE5yNnJ5dW9LZ2pX?=
 =?gb2312?B?N3d2NkdtcDlreUhLN0dxUGYvUFVWazRxZFJneDRBNnZoSDRMdmdXelRiMmxw?=
 =?gb2312?B?RnUvelVXRVZSLzBESzBDYkplSnlNQTFDRTVZRnVPZXlQTWswSTFkVVZad29Y?=
 =?gb2312?B?WjRhYWtiWU4raFRCamQvWUlTWGdubU05TXpMaU9vSktWM2xqTlcvU2tWd1Qz?=
 =?gb2312?B?OEo4KzlXejFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7959.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QVB4Ly9NNzFvK1Y4bmFpUUdnaXBRY3haN1pzMURnZkcwKzM4K1ZEcmhCT09j?=
 =?gb2312?B?Sy9FTXBySjYwa1puOFJHWEJybzRoQ0VKUzlpYytRanY0Yk1tQVE5bXBEZ1Fa?=
 =?gb2312?B?L2xUQitINXUrdGVxclorZDdUYkF5NkRPaFdoU1FxdTVVVjlydE9SdklDZHVO?=
 =?gb2312?B?TnA3UFFvdzdCUzkzRUVrRUlKcU8xWWFHQi93elVRYVRrUmY1dDlZMi9hWlpW?=
 =?gb2312?B?VlBrRG5Wa1g5WEJHc29EUVBKL1YyaDNDcHFUOG83K2hSYjNLS29nOUVLTUxG?=
 =?gb2312?B?TmdHMk1URlpseGlWYS90bzd4dkZZYkhIRDh0VFhiSVJzdldoKzI1WjZ3TjBy?=
 =?gb2312?B?YytXVzRzY2JyN3UyRGt4akVCZzFLVGZSMWRlcklxNTh6UVFQdGM1NzR3ZDQx?=
 =?gb2312?B?NlNzWFFSd2NCTWRIeGcxUndvOW0vSkxpSUJ5SUF4SXRUUVp0SDNIN0wzRWJl?=
 =?gb2312?B?N3ZTNzgzU0hBS2I3dndBSjBITjBsdDhKVVg1TVNwcFc2VFc1emZCNDQvNUZF?=
 =?gb2312?B?RkN5OWxORVdIcjg2SlRYSXRrL29Pa3MvN0NqL1NjMUpwbTlwcUo2VDNCdFZY?=
 =?gb2312?B?MEVpdVNIeXNKaEwva05iS3dHY01BQjBsZWJlVlJVNHF0VnJiT24zNVYrOEZ6?=
 =?gb2312?B?SjVsWHFCSTNTcEI2cXhEQUpSbzd5eXp4M3poalNzTjg4OWx6OTJycmNYYVpi?=
 =?gb2312?B?L3M4UnY0L0dnVDNNV3VwZit5UE8wTExiNkJYYktjUUFYY3hqY0dvd29hL28w?=
 =?gb2312?B?VTd2ak5MVEV1bm0wQWdWM2VJajBIY3pEbHg5R1JJR0M0L0dpR04yeXFRWjNB?=
 =?gb2312?B?UzlHZENVZTJqOEpTTTFTMVd4L1ZQWmNZeHNmU2M3ckc0Uk9DK2VDOTc2YWhW?=
 =?gb2312?B?ZUZhSUxNb3FJVUVFdTZJcmF2WkRtajFpUmlvUzZTZmNVRWhTZVhTZHI4SEcz?=
 =?gb2312?B?WWIybUJtVmdGSzJMLzNjNW5SdUs3QVlmcjQvK0dnd0ZtVkhHZ3A0dHJGelhu?=
 =?gb2312?B?V0F1UUdtOVlrMis2dmhLbEFSUkZ0RXUrQ2drWWVSVW1MQllaMTArOXNGendV?=
 =?gb2312?B?bk5JZCtIaGd0TWNQaWcyRklrSmdscTNQWWxEK2U0S0o0Nm5xRG9PYktsRjVq?=
 =?gb2312?B?VEhhMXlXZTY1RjBjMlBqM05NRUtDeW9PSkUyT3hkMWFweGFRQVQ4YlJlbjI3?=
 =?gb2312?B?YVJaVklMbTBZdmVITU8xdUc3aHBVdFIvT0RxanFqTzRaODVwY09ONjZuc3Jp?=
 =?gb2312?B?RUpJOXhYTEo2dGd2cVlQVUloSEdQM1pjOUhyemVPTEFQOUhabHNKekIxWmxu?=
 =?gb2312?B?NkNHaDI1clJVQTJ6cmFRMEdBamUyVkdGVVJ0R1NlQytta0h4VXcrcXEyb3JF?=
 =?gb2312?B?R3BEeElhcUw2UGFWTEJOUVJSSlYxWWw1OU41cTRyNFZ6R2svSy92dURyTFRD?=
 =?gb2312?B?RnRDVTBoSlIyM3FMQUtiYXNoT1l2bXJ4d2MvYkZVUUpCMWI3ZG9BQTlxSWxI?=
 =?gb2312?B?U28rOFdvR3dnTWw2eFh0UGNNRFJMNjNyMnRGNnczNVplWnZQMkNOaHRxR0hP?=
 =?gb2312?B?VGtlUUYxQ05JMDNmUlkvRDF3Y1Q4T00xUHVnTjlsSERWNVJyVHdIampGenky?=
 =?gb2312?B?cXUrenlwZCsvTkRoVWx5Q0pneXdkdUtqeGgvMTZBZkVuc2p6eHg1VDkyVEVT?=
 =?gb2312?B?WmdiemVSUjRIM1JOYjBMQklyY1gyUnNsUGxVVENDNHhJMURyMmsxMnB0R0xq?=
 =?gb2312?B?YkdhNXFjOW1SRHJBM21kZnpncWxpYkhtbTZ2dE55TEx2UmdlTXFvT202ZStT?=
 =?gb2312?B?a2ZhUkJtTVVxV28rQ2NaN0NGUTNsemsxWU8rRkkrSThCWHJqNzlLSTd4eExz?=
 =?gb2312?B?Qkgra3daQ3EzS0FKbjhwd2N1ZW1XY3IzaWlhV3ZXOEtIeGxidnhPTDNUcXEz?=
 =?gb2312?B?WlNYOGE1dTQwNXVFaTNrS2Y0eWYzU1ovWk8yRmNSQmMwS1JBQ2FvM3ZseWNI?=
 =?gb2312?B?M1JWeWJuOUY0OTRKKzFKMXRia21BdXFaUUNhTHFQaDlETWJHM0dKYno1Nzk3?=
 =?gb2312?B?WnlsU3IzazRQN0Y2cU9EUlB1YWNwOW5YMVl6Y1FRanYrN01HbGlDVEhLTkpR?=
 =?gb2312?B?QXZPbm5BZHBjRTBobEJhbW1yOTRTclZLTkl0L0s0T2h0OGk3b3prT0NRVlhR?=
 =?gb2312?Q?WfqOFm1pnjpNuyxRQWBHPt41IWQes/9QkLkftl5W+EmY?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7959.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3a0e53-ce69-42a7-2370-08ddd0f3a069
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 12:04:54.2830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6X7jssfaO3JVrDLO0ppvgo1hyZGh8YPJ9LH1FRSJRue+/T99042Z8WtVowoKKED94bvwR7JCfbBxoFSR2kZVGflLV/NRCqUXXICy4Okvkm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-Proofpoint-ORIG-GUID: rmvnrbmi_K1-rom0D6JgnY52k_lMqi5s
X-Proofpoint-GUID: rmvnrbmi_K1-rom0D6JgnY52k_lMqi5s
X-Authority-Analysis: v=2.4 cv=OYOYDgTY c=1 sm=1 tr=0 ts=688cad68 cx=c_pps
 a=PnTai0mnnJZZ3plyKTpN7g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=_l4uJm6h9gAA:10
 a=2OwXVqhp2XgA:10 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8
 a=yj-aMKAYKbz0kkd27lYA:9 a=mFyHDrcPJccA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA5MCBTYWx0ZWRfX3FplFCV/J2E/
 xpknQg3ihgAxCpgQQ1RSJQTtuS8y7cEgBSvEhh260/fU2EF64HrneKlW7eu3GJvyHd68XAeBG72
 4ujrjAdDMyGlSkmkToVpCvACd8S0KyXTzZKIMwxp+clGHp64DDLqj6BJMHtgvluMcA1Uj4OCrim
 2iEHmHzxlkecBqsZVIst+q2XvExsSSJ8KhzBch5kYupSCEkHsCnxt+gE/HmRbbpr/LGtnKFCpEs
 PSpN2Ycc2lpiVdRcd0KBP7PGYGrs5QHVKmtfWynoo8Rm3X7zgXVxmQQrXvonBZfChP9lylJRXqD
 EXSNs0IzFpNXVdn7pNr71ZXgqk0fBPy4GHeC1EZTzkktRa2fK+objn9y5JM4jGHAlm97V0qMmf5
 DsGxZZ2/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507260059

SGkgR3JlZywNClRoYW5rcyBmb3IgeW91ciBjaGVjayBhbmQgY29tbWVudHMuIFNvcnJ5IHRoYXQg
SSBtaXN0YWtlbmx5IGNoYW5nZWQgDQp0aGUgZmlsZXMgb2YgLmR5YWQgYW5kIC5qc29uLiBJJ2xs
IHBheSBhdHRlbnRpb24gbmV4dCB0aW1lLiANClRoZSBvcmlnaW5hbCBmaXggNjY5NTFkOThkOWJm
ICgiZHJtL2FtZC9kaXNwbGF5OiBBZGQgTlVMTCB0ZXN0IGZvciAndGltaW5nIGdlbmVyYXRvcicg
aW4gJ2RjbjIxX3NldF9waXBlKCknIikgDQpvciBmYjVhM2QwMzcwODIgZm9yIENWRS0yMDI0LTI2
NjYxIGRpZG4ndCBmaXggdGhlIENWRSAob3IgZXZlbiBtYWRlIGl0IHdvcnNlKSBiZWNhdXNlIHRo
ZSBrZXkgY2hhbmdlIA0KaXMgdG8gY2hlY2sgaWYgobB0Z6GxIGlzIE5VTEwgYmVmb3JlIHJlZmVy
ZW5jaW5nIGl0LCBidXQgdGhlIGZpeCBkb2VzIE5PVCBkbyB0aGF0IGNvcnJlY3RseToNCisgICAg
ICAgaWYgKCFhYm0gJiYgIXRnICYmICFwYW5lbF9jbnRsKSANCisgICAgICAgICAgICAgICByZXR1
cm47IA0KSGVyZSAiJiYiIHNob3VsZCBoYXZlIGJlZW4gInx8Ii4NClRoZSBmb2xsb3ctdXAgY29t
bWl0IDE3YmE5Y2RlMTFjMiBmaXhlcyB0aGlzIGJ5Og0KLSAgICAgICBpZiAoIWFibSAmJiAhdGcg
JiYgIXBhbmVsX2NudGwpIA0KKyAgICAgICBpZiAoIWFibSB8fCAhdGcgfHwgIXBhbmVsX2NudGwp
IA0KICAgICAgICAgICAgICAgIHJldHVybjsgDQpTbyB3ZSBjb25zaWRlciB0aGF0IDY2OTUxZDk4
ZDliZiBpcyBub3QgYSBjb21wbGV0ZSBmaXguIEl0IGFjdHVhbGx5IG1hZGUgdGhpbmdzIHdvcnNl
Lg0KNjY5NTFkOThkOWJmIGFuZCAxN2JhOWNkZTExYzIgdG9nZXRoZXIgZml4IENWRS0yMDI0LTI2
NjYxLg0KVGhlIHNhbWUgcHJvYmxlbSBoYXBwZW5lZCB0byBDVkUtMjAyNC0yNjY2Mi4NCklmIHlv
dSBhZ3JlZSB3aXRoIHRoZSBhYm92ZSBhbmFseXNpcywgc2hvdWxkIEkgYXBwZW5kIDE3YmE5Y2Rl
MTFjMmJmZWJiZDcwODY3YjBhMmFjNGEyMmU1NzMzNzkgdG8gQ1ZFLTIwMjQtMjY2NjEuc2hhMSA/
IA0KDQpUaGFua3MhIA0KDQpRaW5nZmVuZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IA0KU2VudDogMjAyNcTq
ONTCMcjVIDE1OjQxDQpUbzogSGFvLCBRaW5nZmVuZyA8UWluZ2ZlbmcuSGFvQHdpbmRyaXZlci5j
b20+DQpDYzogY3ZlQGtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IEhlLCBaaGUg
PFpoZS5IZUB3aW5kcml2ZXIuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2dWxucyAwLzFdIGNo
YW5nZSB0aGUgc2hhMSBmb3IgQ1ZFLTIwMjQtMjY2NjENCg0KQ0FVVElPTjogVGhpcyBlbWFpbCBj
b21lcyBmcm9tIGEgbm9uIFdpbmQgUml2ZXIgZW1haWwgYWNjb3VudCENCkRvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIg
YW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KT24gRnJpLCBBdWcgMDEsIDIwMjUgYXQg
MTI6MDY6MzRQTSArMDgwMCwgUWluZ2ZlbmcgSGFvIHdyb3RlOg0KPiBUaGVyZSBpcyBhIGZpeCAx
N2JhOWNkZTExYzJiZmViYmQ3MDg2N2IwYTJhYzRhMjJlNTczMzc5DQo+IGludHJvZHVjZWQgaW4g
djYuOCB0byBmaXggdGhlIHByb2JsZW0gaW50cm9kdWNlZCBieSB0aGUgb3JpZ2luYWwgZml4IA0K
PiA2Njk1MWQ5OGQ5YmY0NWJhMjVhY2YzN2ZlMDc0NzI1M2ZhZmRmMjk4LA0KPiBhbmQgdGhleSB0
b2dldGhlciBmaXggdGhlIENWRS0yMDI0LTI2NjYxLg0KDQpUaG9zZSBhcmUgdHdvIGRpZmZlcmVu
dCB0aGluZ3MsIHNob3VsZG4ndCB0aGV5IGdldCBkaWZmZXJlbnQgQ1ZFIGlkcz8NCg0KPiBTaW5j
ZSB0aGlzIGlzIHRoZSBmaXJzdCB0aW1lIEkgc3VibWl0IHRoZSBjaGFuZ2VzIG9uIHZ1bG5zIHBy
b2plY3QsIA0KPiBub3Qgc3VyZSBpZiB0aGUgY2hhbmdlcyBpbiBteSBwYXRjaCBhcmUgZXhhY3Qs
IEBHcmVnLCBwbGVhc2UgcG9pbnQgb3V0IA0KPiB0aGUgcHJvYmxlbXMgaWYgdGhlcmUgYXJlIGFu
ZCBJIHdpbGwgZml4IHRoZW0uDQoNClRoZXJlJ3MgbmV2ZXIgYSBuZWVkIHRvIG1vZGlmeSB0aGUg
LmR5YWQgb3IgLmpzb24gZmlsZXMgKGhpbnQsIHlvdSBhbHNvIGRpZCBub3QgdG91Y2ggdGhlIC5t
Ym94IGZpbGUuKSAgdGhleSBhcmUgYWxsIGF1dG8tZ2VuZXJhdGVkIGZyb20gdGhlDQouc2hhMSBm
aWxlLg0KDQpCdXQgYWdhaW4sIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBjb3JyZWN0LCBlaXRoZXIg
dGhpcyBzcGVjaWZpYyBDVkUgaXMgbm90IGEgQ1ZFIChpLmUuIGl0IGRvZXNuJ3QgYWN0dWFsbHkg
Zml4IGFuIGlzc3VlKSwgb3Igd2UgbmVlZCB0byBhc3NpZ24gYW5vdGhlciBvbmUsIHJpZ2h0Pw0K
DQp0aGFua3MsDQoNCmdyZWcgay1oDQo=

