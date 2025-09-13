Return-Path: <stable+bounces-179416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA83CB55EEA
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 08:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A757B4F86
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 06:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A972E7624;
	Sat, 13 Sep 2025 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3B2CPSAS"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5D2E718F
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744309; cv=fail; b=OVKMf/NVaP80ENvGlvoHIEt8WffcV6GYI6JVJXu/4O88b+GRu4BRDu+Yoy7II6OxnTaSUtVnR2Wzexz+r9qBUq35FXp+yb2Er9OYq3WDF/WucOSkHbDBQmptPbrgrdzSyKcs1R/HlS6sGFckQPuFE9omyInwG3mAg7u90Huw9NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744309; c=relaxed/simple;
	bh=Yp0Rqf2C8RUS8FYzwbhwP8ZeLu157amT2m6f2S7SUzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b5JFLViaIZd3deNNmL/MULYIebE/5nPkYTbwKpSCG0N9N5/l5P391mbIWBWNcQEP1E/k7fxs+emZReQGliSBOIcMIuDOAKIosRkVOFr3my2HP3h3AZnD8+rrpsgMDQzAAW9uthPUj//ClfEmHv5t3hAoiPOT3UKks8rSN7K9Kw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3B2CPSAS; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvl+IW0bo2SFt3T8Jw+TCx7v0ysCFep81BvKiMqN7tpT8lDX6VhwOEIbDUw4Kzgu4CQpS589kAFZeax9OAAobB9nqA9v+KefsGtFhp5Vby+glc4tXtjFOPFhaBJE/PL+4ASASbdHRpoPGxwidw/bR1GiiNfwv28QH4elj7CAbpC9McEVqPM/srwo6CeiOjlqfewmljT9dNXS5NJWCldgbcoKvMKVJDHnnGSX1z07C34gbXIwZu5TyttiV1vJyHW52D5g2lI16cLPx3A49nL8x/bZgYI2pKC6hP2j6SJHrY7zvHvqaNDm4u5/Oj3Na9BwsdLtf6UdRS2vwhdsG01j0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpwdY0NhDqDzBOrKplWQdpm+VhMJVfGhUX9wujlXHOM=;
 b=u+GwdDV62XNXeLSdyV0NIiHB7ZvXzf7hH/wGkxQy7S7aug2AuiIhI9FGVPu2zWEZhrMtC/sM90sNjMPVCaAQmvapJIxPGvd7e7yp1Y7JpwCVKnTNIMdAkUkzFgH6HTh2K6cHhqM36fAxkA30+BE793hkXb4v0v8uQoR5iMCfqWu1bMkmsjaax+msGRWrd/W7wlwFM486OPVEarEf6iCeS783+W/+0yf89ffVBouWDq+IeArWZMIQPBEZ4i9gWdZIr3HNrnKMl3O+yioq8EdNyxRZcHus/1+mLBqxVKoLAASZv44NXbQLyB4h0fxte4MXD7gHIcwRoi4vaaB/+Rs/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpwdY0NhDqDzBOrKplWQdpm+VhMJVfGhUX9wujlXHOM=;
 b=3B2CPSASfaZW90iUoOuHPWRdRBwTRlEy81dPXwXVb0skWtGTg/m92UwS17vSiEovzaOvvHiC02nIicGs1NvORCRRHDzwdcnkeftM3Q++hRE0qoD3SSTA25KA4hzuag0HPttBsXpA9lodLhdAi2TFhVeTSA+iYm+sKlL+kFuRB1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 06:18:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 06:18:22 +0000
Message-ID: <b167aa9e-efa3-4e3c-9fbc-13353737ef7c@amd.com>
Date: Sat, 13 Sep 2025 11:48:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page
 table level
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, stable@vger.kernel.org,
 Joao Martins <joao.m.martins@oracle.com>
References: <20250911121416.633216-1-vasant.hegde@amd.com>
 <sizw3br3mzal4o5vej7njvnjxsd5ego37zw6ejsh5fufxdr36n@ubrpt7sxsn3d>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <sizw3br3mzal4o5vej7njvnjxsd5ego37zw6ejsh5fufxdr36n@ubrpt7sxsn3d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: dd38bb8d-70cf-4cb6-248d-08ddf28d5769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTJSWGZINGZnM2ZiQ3lkZURvTk8vZE9BVW9FK2RwdVIwR0pNUnQ3SkRNaUcz?=
 =?utf-8?B?dFBBUmt1UWlwb2kwaGlMYUsxaHlMcDFhZFlXQlU1ZFdleWlVQkE3eDdpaUNt?=
 =?utf-8?B?U3JweW5LOHlVV1RqZXRGSGR5cXBPbG9NRmQrY3ErQmttbk94dVRneFlVcWFN?=
 =?utf-8?B?WHpMVk9Xak5RWXU4a1lGVisxR3l4dTRYTHhibE8yZEh6dEFua2Z3SC9lVDhw?=
 =?utf-8?B?d2MyMTQxbGdwRVE0T01Ud0lHUWNtcytxUmQ3VlRBM01RODlNTFVlZjVndEw3?=
 =?utf-8?B?Rnc1allIa2piaEtGWE0remhlZGlsdjhTVkdBOVphL1Q4clEvdk9ySWgyZEtm?=
 =?utf-8?B?ZFlQMEl3dS9HYlIzcU1wcjUxT3Y4cCtKRXdDY0UxMU8xczAyTnkwV0hDUEVY?=
 =?utf-8?B?TzdWeHk5VXhVQUVDckRWajB6UnNicW1jYjlOaTNwN1h0cGkxYU5KL3haSjFS?=
 =?utf-8?B?UjJ4czJXY0UxdEo5QzJkcmVJRks2U01iMWdDZHFFWE9rZnpsSkRWU0xzaDIz?=
 =?utf-8?B?MlZGK2ZjOGx4YUJUZStCdFEwc29CRHViZndVVWNiVXlWVkUvM0s4blZkdlcv?=
 =?utf-8?B?RGQ0WlZLeFhTY3czc3NzVThqZk5MempkQXhRS0twLy9JeVBWalRxb2swTmhV?=
 =?utf-8?B?ZHNHeEFibmRBSC9zREJ5UFk0bWJhTzFjVVdTTXhLT0R4Nm03V1hSWGgxdXhY?=
 =?utf-8?B?ZXc4dEozbTVkOE1PR0g1ei9yRWhXSDUybk9KKzMrMVFkd0FHeUp3bTVaME5w?=
 =?utf-8?B?L21uK0VkanBGR0I5TTJQVmUrY3AvQnFyUnN2MVZyMXR4ZDM5V3JvekE5WE1I?=
 =?utf-8?B?TzJPdGViS0xvL0kvNDNOSlVjdGxoV2U2MG5KMmtIdWswZis2WXFXS3ZyR3Vq?=
 =?utf-8?B?eTd6b1k3TUlTSXIwYk9wM2FVYUVPZWRHa2lKUTNqR1dmajFOT2VJdVUwL3Q3?=
 =?utf-8?B?OFF4eW1hNkNuWDNod29wbXlDcUxWWmdnSU5PaDRZZGVNT05IdWdlYm1mTmRL?=
 =?utf-8?B?Yko2VFVOTDllNHZLZm9nWk1xLzA0Q1Nvbk0zMzRBdUE4M1ZkOHBkaWVxbExH?=
 =?utf-8?B?U3RISFVSMjM0alc3M0hxOFk2OUEyQUlhUDZCVUFTaHMxUlNaSWVlK0pmN2Rl?=
 =?utf-8?B?Znc2L0E5cHlsWlpaMWdZejdMZTA5UDQxeXg3QWNkQVhvQXZlU2FRSUl5Qnh1?=
 =?utf-8?B?cUlweUFvZ1VhSjFmVnpKT3A5a3RQRDQ3eDNaeTNBNDZKOXZRUG52K0NPY2N3?=
 =?utf-8?B?YjNyeEs0RUIrYUtQL3lWdG4yVGN2WmJFQUpsU0VzVWl3OVRCdHF2NzUzZjBL?=
 =?utf-8?B?dG5hd3JqeXZjalBKOTJmZzY0N1RZRFlPdktsYSs4NE9QbUplVlBoRk9GcUR2?=
 =?utf-8?B?VEZySG90cHNQd0JVVml5azcrVW1BaXNkYVRIY1BFL0hYaTIvSlp0cFFjamtE?=
 =?utf-8?B?bS84NzRHMjhPZGRyVURxKy9ScHZKTThqd0JoV2xoQ09Tc1lPQnV5eHFIb1F4?=
 =?utf-8?B?YU5pOTNNTWcxL3BLUlBwdWZkeFJMSjV1S1Rmank4ajcyTEY4RGxPR213RVFm?=
 =?utf-8?B?emJpSkswa2dxSVI0RUo1QTBZWEpIdVFDZ01ZVXI4d3luYUR5MVdCc3FhelJV?=
 =?utf-8?B?c2ZKTW04TXZiTDFUb0c5K1BWS1JwSWdEdWZkdDFiMHUyMWFtSUVjMnVya01N?=
 =?utf-8?B?YWxLNVRnSkM5OVhrMVBqRTZicWdHS0V1Rjl5SnArMElBQ1Vtd1FRQ2xlK0lX?=
 =?utf-8?B?aGhJdUJqQktiRnlXL2FHNURGRFE3Z25HajVIU2ROQklrQVlQQi9XR0pHenBW?=
 =?utf-8?B?UnhUYks4bytrWUFvMjVHNTdMOE14cldZdVdZTGlnVGkwcGY2WlF1dFhucldT?=
 =?utf-8?B?T0gwMzJEdlQ2VndQRTJDRW5mS0VqekUzTkNVZ2h6alFtN0NWd2VnUDNWd1hl?=
 =?utf-8?Q?GsLSchAHNKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnVBdDdSVFcxT24yNTVUQ2FnS0hzdGMycGdpbGhuYmdyUThqSDhMcUY0R3Ey?=
 =?utf-8?B?UlhpNGt3NXlHaUxtNFJkYmRWYkhKakkxbTZPeGpKTVYrUVd3TFp6RjdzeXY2?=
 =?utf-8?B?dTZaWTNkd2lKa1dKcUV4WkF2eDFDTkh0aHJmanIvK1doM2ViRmw0bTJLOE05?=
 =?utf-8?B?NVhpK0dTaThhS0gxSG5OSlVWOWc1ZnpKWWhUaWcrYUFlMSs5UTZiU2pXQ3BP?=
 =?utf-8?B?T1V6QUxlOGJBQXlseVBDNmcxQ1FMcTNSaWlNZWRUbWRQcFpRYS9KYlNkRjRB?=
 =?utf-8?B?UHVhbFl4ZzlYbWNnQzQyeG9OVGhSbHRaK2JJd3p2c1F2NUk5b0dQYTZpeWhY?=
 =?utf-8?B?dzJubUdjUkdXQjFXRi9semE0RUZJa0NDbVFpWmN1WWVVNkRuVVVvWUpmbkVz?=
 =?utf-8?B?RVlyalJUQ0QwZUZ6NlRrUjEycVUrQTgvSUFrMFFmeVB1MnlnbUxkdHRWUE5N?=
 =?utf-8?B?WjlBVjk1cm5WSThMcWIzd3lxV3oybmcrNE5ZU1kwQjNnVk1vYUMxbjlWSzRT?=
 =?utf-8?B?NFllRjdIL0hJTkd2cjY1cmt6MlhJZWk2T2dQS1VQQlNHeUNvM2toRnJOaE4z?=
 =?utf-8?B?ZHBFUmZ3TjNvc0pnSWcwdURUZ3FGQXhINUV3SFJQZkVOcklSc0IramozaGU3?=
 =?utf-8?B?SlRYRjNIWnRSME93WlU5eGp6bVFCYUlpWnBsWEFOQi9OTVlBU2hTOENIendY?=
 =?utf-8?B?Zjc5cFhUVnNrdktaS2NualhyTGVXeS9nUGtYMVdJRHhKb2R0TERDME9HVTA4?=
 =?utf-8?B?Wi93TG82eCtEYVovTkJYMFdQOUpWcS92bWdwTWtxMTVuVkovTitCbklUSG93?=
 =?utf-8?B?aFZVdmZ5ekNXSEZwMVp0SzQ4VzJYQm1PT3l5SGJBNGpwc3ZoS0U0Qm9XRFc3?=
 =?utf-8?B?bk9BK0VWVU1mNER4L2NMc3orb0hRVGxTOEFkSnRYY0VpbVd1eXFZbW51elBL?=
 =?utf-8?B?bnU2L2pQS0pxYWtTbzdyeERyNHFoYzROSVhQeVY0dDRDdFhPajE1YVRXMWZl?=
 =?utf-8?B?TzQrSjhEcXBGcUNwaU8vYzd0WlpFSDUrVm1zY1VyQTk5ZDZwQUw1TmRGQmtF?=
 =?utf-8?B?RzBRSlNaR2ZjNUJScHZkbzhtQnRUVDJ0NmpDSzlDRTBZTGhNc2tnby9ZVlVh?=
 =?utf-8?B?ZUdUWmJKM2xsRXVPQkhQZVBlcE5Jc2FlOGVmb3lTRU1lbFJLa1ZLamV2Smhv?=
 =?utf-8?B?T0J2QUtRTTNKNGVyeXR0YWFUQW1wMGgyYm5FQUQ1WGUxRk1KWVFTbm12M1hj?=
 =?utf-8?B?RU5UQ3EyT2ZrKzVFRlBsbE9mUElwU3ZTYkQ3eXQ5d2cvbWJXVEJTcUZhNWth?=
 =?utf-8?B?QndLSmlCODFOc3JKSGVGcTh0M3FDanBNSFY0bDFHM0JFM2FFcHdRTjlDcEIw?=
 =?utf-8?B?NUY0ZDlUU0FrTXRKM2F3MkdTMHpyb2xyaHdmZmlVaTJWVFA3S0hoL1hZOXBB?=
 =?utf-8?B?T3RaVWREZDUxaVFpU1RVdk9QSytjcHg3QlhvNDRHa0VOUWdQMVlPdmd2RGI3?=
 =?utf-8?B?eXRNOGl6Qm94T3JUbnNiVW5UN0FuUlZsSlMzRlhrYkxvUCs0bWZIcC9YVTh1?=
 =?utf-8?B?YjhXWHlxUlkwaXFJLzVDV1dDdFBsNHFFM3prL28yZVg5KzdPVzlJNnUwckMw?=
 =?utf-8?B?eldLR1Zaa3Vad3B5ZXZ6T2gwOUczZW11WkVWNGNyYlJ2Y3p6ZzFweURSVExm?=
 =?utf-8?B?T0hBYlQ5bm8yUjgzTUJsNVZCa05GNEZmalBGTENVY2lkdysyekcxSUhISktp?=
 =?utf-8?B?RTMyb3dnazN6UGN5RmVLYXBzQ09tb01DZktVc1ZXQlFzSXQ3U0xoU1BnN1ZD?=
 =?utf-8?B?TlRERVZzSGl5KzN0UWxpUHREUVJJV01RZG1kblZBNkZIVEhZVFM2QVRadWR5?=
 =?utf-8?B?eU9RSGt5eHE2MVZaeHg0bEo0Ylp6THdJdlM3cENBR3hxSnRIc0svZ0FwZjY2?=
 =?utf-8?B?NDdMZnpPSmRUdEh4TDdHV0ZFWkE5eEYydU54MUZCM2lwdGRTQjBDSWp0ZGZT?=
 =?utf-8?B?S1V6RlBEbHFTeVp1QmUxR2ZKQ3c4M1JSODdGNkp3STZvSnNCVCtzZXh4YUQw?=
 =?utf-8?B?T3VydUVKdFhwV2o1elJ4UWREN1djV0w5Z1JZSUl3Ym4wY0k1and6cWNUMWVJ?=
 =?utf-8?Q?P6jDKB8k/lgaBD3JrgQZZqtCu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd38bb8d-70cf-4cb6-248d-08ddf28d5769
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 06:18:22.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qG3H+8O3HADQPqRebbbdbEwVKSRdD/rmqAjn15hwIfUwFRt1NxuDzv/+rwmqFdqX1W2/KSRh1gfeR3ZefI4cSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296

Joerg,

On 9/13/2025 11:40 AM, Jörg Rödel wrote:
> Hey Vasant,
> 
> On Thu, Sep 11, 2025 at 12:14:15PM +0000, Vasant Hegde wrote:
>> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> Cc: stable@vger.kernel.org
>> Cc: Joao Martins <joao.m.martins@oracle.com>
>> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> Can you please send again with a Fixes tag?

I was not sure which commit I should pick for "Fixes" tag as this issue probably
exists since we introduce increase_address_space() but lot of things changed. So
I just Cced stable.

Looking into the git history, I think below commit is more appropriate. I will
update and resend the patch.

commit 754265bcab78a9014f0f99cd35e0d610fcd7dfa7
Author: Joerg Roedel <jroedel@suse.de>
Date:   Fri Sep 6 10:39:54 2019 +0200

    iommu/amd: Fix race in increase_address_space()

-Vasant


