Return-Path: <stable+bounces-105245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6149F703B
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 23:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD035168261
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DB01FC10E;
	Wed, 18 Dec 2024 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hpcN14Bf"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAE35948;
	Wed, 18 Dec 2024 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734561737; cv=fail; b=na+dKN/WZ6dwxsl4iSNUtabkGQYceV2HBySp+kMZc8ARcci2jpNmCI7LVbQb9Z9J69hTWTaRXonbdviUJjgXJGr6HzNhLu5IGmlb5LVfKRcgaSbUYMxPHIpK/IAzmT3jc0II3Cts2yq81h+Ck8TQv1KonLFu5E5xpJ4omq3nkQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734561737; c=relaxed/simple;
	bh=FNj/jJb1c2TZ2USv6x88aXRDkwFwd8UEHfWUzAPQROk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=axAJTjxNSQQIoAjzJax+vOA1zMZu+Yi3y3p3+H9IiIUfhlRAMsETGaAa6BAu9zCMVJkqg7eWJbYhNPWre6yyEM+X//+Vv9914WBYW3eDzgwrBg6gLaIc6yYYMBr+TcA1nzhAtJLt7ahkQ1v2h/ZKZRyqE3w+PeJWBS4PUsK4n9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hpcN14Bf; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJI1L+X5LpUnkGR4xsC28Ftmexos0pcD5o1hwcQs7Xdtk7W29oAi8WVmUv8R20UJeMSN2Sp3MRT7lDiZISzH30IVi5eTxaj41ugY4WLZflQJENIAz2SpP3WEM83BEmeDNapRpC9eddVGLXaXGKJhqBuMAE+tGGBOSJDu/Pziw/jelKrK8nJw59zh8ARTrn2rf+1q//Wv7OCExUkpfXQ85HWy3eo1pg3+1AoAV914YUTZrCEIQk7dEoo2ODumkp4oSaah3UXGtb68IkXq6xVRPCBv/cksjjSpJhlMHgys4vuwcoJqvc71P+TPEBP/xNx+8nnd6f6ba+zItwWX6rpiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd9rF7DoikbsxmQXlm5oCCBCDpSbnX8UmzCEy/cW+Rs=;
 b=cZRSg4pFQDOcrQfeTlf6vGU6Vg0rGn9Tna036lRFqhOfl/WKWInlsXPUXjc+J2q5Cf7PiVOuPhMxVDvRpfS11vILPjdaCTyVgKNg78NiVj9k+dCfXfiH6vEIeyDppkHq8BaErJOixY19OaNTozNNV0eaaN3SI+yQiyab3lRqRzhoTiX6mOytZA0MTXXoOmsPCn99DmYbxjwYuHJvO43Lw/iOXHqiBJwV8U3AW9pQglPWF6uYWrZbgF1354n+46h0t5oEQRznxQKf95JCf8lxJEwkeW5Bz/DyO0wHI9Ya9txCCNlIHx34Qe5fkgAOc5mXeuouozvRo0X9Iwg42RUdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rd9rF7DoikbsxmQXlm5oCCBCDpSbnX8UmzCEy/cW+Rs=;
 b=hpcN14BfAsD2A33J3VIWF5zm+6Tf/DfWx48wfBE9CRLwAdcHXqqzWE86snrM4X2+ydqZ3nc9Z3OWUT2WDxYpXMAkT5htxTiHhsPCgMjU+vf7PQ1paYZw2E4c5Thkrwds00LxdT1r6NBvVE5kMdUQ929/SDE1qaNLPCDZyAZXE4vr6CAcAuOJuo6XIB4l1L159ZsPo6XSKUXMkYgLlz2rAok47DKwzZ00Nigy0i19FzyKvztPA5FlC9uZZNvt8ayupKUs6WV1dzeIrWDIqHg5cyEVfV6YJjyrdpgZK0UmZ3aYsjMPEkzGFaCbrcDwGd9lxX29rRWoKqsS5yUHu9SbzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) by
 DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Wed, 18 Dec 2024 22:42:12 +0000
Received: from DS7PR12MB6237.namprd12.prod.outlook.com
 ([fe80::64de:5b39:d2ef:8db6]) by DS7PR12MB6237.namprd12.prod.outlook.com
 ([fe80::64de:5b39:d2ef:8db6%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 22:42:12 +0000
Message-ID: <c1177b6b-14c5-4f6d-bd14-0cb922a0db5a@nvidia.com>
Date: Wed, 18 Dec 2024 14:42:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: tegra: fix typo in Tegra234 dce-fabric
 compatible
To: Ivy Huang <yijuh@nvidia.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org
Cc: Sumit Gupta <sumitg@nvidia.com>, stable@vger.kernel.org
References: <20241218000737.1789569-1-yijuh@nvidia.com>
 <20241218000737.1789569-2-yijuh@nvidia.com>
Content-Language: en-US
From: Brad Griffis <bgriffis@nvidia.com>
In-Reply-To: <20241218000737.1789569-2-yijuh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::34) To DS7PR12MB6237.namprd12.prod.outlook.com
 (2603:10b6:8:97::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6237:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: d051942b-7e48-42ac-f127-08dd1fb536a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW1rc1dtRld5SkhtR3o5MFFzL3Nlb2FDTWhIUmxEMmtXbkx6NVRUcXBFNjVM?=
 =?utf-8?B?Sll5UTdaUk9SdTdaMXk0U2tOMzMwektNOXc4cUg2d2x1R2hzaFc5SFRMS0pO?=
 =?utf-8?B?bWJGTTlYQjlQMnVHNnRWcU0yUkdNTW1mcUYyY3g0NXY2TnNvdVIvQWlFSEYz?=
 =?utf-8?B?aThaYVVqOHRtcVUzWFVMbmNsMlBZNnZYeGN2ZFpHRmZ1UEFWdkFCaS9pYTQx?=
 =?utf-8?B?alVaOWZXaUprbytzd3N5ZWxGQ1ZTOFJ5aGtaUEtQOEZGelUrT1ByR004ZXZr?=
 =?utf-8?B?Q2hVNnYwTlZ6OXMvYUFVZWxIZVRUNzEwWTVUYWV1MlF2WmErbVdQYXNiVWZn?=
 =?utf-8?B?TEVsSVgvMTlPUnM1dTA1U2NKQjBqTE9WaVpGOHpDQS9HR1BqZUlSN2JwQy9y?=
 =?utf-8?B?RVNvOC9zZEcwMzFYWW1tMDBXZi82Nk92ODZiNTRqdkV1WGppZmxkdm1aZGZM?=
 =?utf-8?B?b0pBY0Z5SWFVZVRLNEVPTHp4RC91Rkp1R1o1ekN5S3J2bnFZVG1zNjhBbk42?=
 =?utf-8?B?bHZEY3Awcndiemw1aDZzZGhwdWtVbCtLTjNTUERjL1N5bXZuMzdwWTc0TGJl?=
 =?utf-8?B?WUg4aDlobFdYNCtMYWVZbGFNRnBGQnVlZlpUL0pObXJEMGgxb05kVmRZYTBX?=
 =?utf-8?B?YUthNzRueGhsK2lLNzNJQU9zdVZTcDdFQjRVaytIdDFtcEVZUDlCcTh1bUZ1?=
 =?utf-8?B?WHYvMVBhWittRUhrRmt3TFVzRTJqS05jNHN3c3N4K0orMkIyM0ZCbUlIK2ls?=
 =?utf-8?B?UW1yazV4em9WYXZvSUQ3VTN0YmRyRy94cklLdkJGRFl0UnJXQk9aZkV2dll3?=
 =?utf-8?B?NEZnUnpGY0svNGxMb0MrWmVUWHE5QjlNaXAxZkliR00vNG82dC9YNTYvMThU?=
 =?utf-8?B?N2lOWkNNL244NVpjbjZIUjBrWXZ4TmMzeWd2TFlGY2tJYzBpR1hkNDNFd2Q2?=
 =?utf-8?B?SGcyT0R1c241bSttSzcyaGxMM2RudkhIMUdablhKakpGMjB1MmpRU2tWOHpM?=
 =?utf-8?B?eUJCajF2Sk8rMHBHbGlSenpsUnVQbHhWVEhLdGQrbEgyZG5NSm5XeFc2blpa?=
 =?utf-8?B?YmVwcWx3U2xCbGIveXlYdGR6Wkx1QWhPcTYvUFA4VGUzVEFHYUo2RElPOEJ1?=
 =?utf-8?B?bER5NmdwUWx6WEowY1dTRHc0RStLekZyYncvcDNSVnM4NURNRlJEL0YvUkZB?=
 =?utf-8?B?SUkzM1JIZTJrYnV6N3JPSElLRGlLbVRHU1M4SGZtQlRrQXlMeGlQdVlya01r?=
 =?utf-8?B?dG9DOUVXdDVKWG5LQlZmOHdiVjljSVlPMkgwMUhFMDJrQmdWV1ZrNVBzeGt1?=
 =?utf-8?B?alQvREQ3WkIyVGFTdEptVW80dmxyOXoyMS94SkZhQzBtdTFlZGYxY2srVGFU?=
 =?utf-8?B?b1IzVU1OOXFqZ2lsdUs3bm9YVk8ySGY1d1VrYllPbHY3ZFB4Z05OTm9reXF2?=
 =?utf-8?B?VEZpeTRZOTNSN3BzWWRyUDRiOTd4YXdYeGlqK3llQnZOdXhESllkbThSMWI2?=
 =?utf-8?B?VTh4UzVMa1A2dHE2ZitGVE5kOUJWNVF2OVkrUHE1ZnZEQ3ZyVHFYNmRTbFBJ?=
 =?utf-8?B?VVFBU0Mvckl3ZnhrZ3JxZ29MOGpuUEFXYUdBS2hZdW1LMkQ4eldZaDNFVEhi?=
 =?utf-8?B?WEw1bFZ5S3F2Z0FNNUZyRDI3bzhXWVJzR2QrWXRURXVNYkR0WXU2R2paT3Vv?=
 =?utf-8?B?UExOZHB3Z0QrSHRJb2NkR3NRSXZKQkdqcFlmK1VlT3RWVEpKL3A1YXZZTTJY?=
 =?utf-8?B?ZWw3TldVV2JPakNGL1JHNDFhT3ZNalB0UW5vbWNnRXhEblB1cEdhd3htT0U4?=
 =?utf-8?B?dFVlMmxmWjl4NXJ2MTVhdzhTSzdqRzFKbjlnS0crNTFOVUtPb1RoM2s2SWdM?=
 =?utf-8?Q?/M4BZLR7KIQiI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6237.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWFDRGZKWTMvZy9GT2JNSHFMeWE5c28rbU16MUVpQkpqVEhBdHVVajFFRWJR?=
 =?utf-8?B?UUxlUUd5RDdhUmREWUN5SVQ3YVpUWTJRT1pNUjlvUEg3clJHVi9wWFJtVUIr?=
 =?utf-8?B?QWJEa2FFSGszMFdxSUt4bmFoUlFub2E2UmhuTXphUmNxV3dPTjl6NnliemE2?=
 =?utf-8?B?c3hGK1BBUjlOclVPWlBKQ05sZlJtVWgyOUY3Q1MrbC9vVVhteXZaSG1EaUZi?=
 =?utf-8?B?YU4vWXVEbUZLaEtyVW5MYklTZkNjMnNiSUZHVFl4c1pWWldML0F2eVRsTVo5?=
 =?utf-8?B?ZkIwd01OTHpLTk43bnE1bU5VR0JXLzhLeW1vN01abnRWeEI2aHY0K3JHRnpT?=
 =?utf-8?B?UzdVYzNtR1V6NldZcERmbWFacWVzeU1rMFdPWDlUZFVFQ1ZBM0g2OVdyTXJF?=
 =?utf-8?B?Nk84bVlScmZhYzN6blZTRysydEZDRnQ0ZmNMYWkxN3ZOcmNkZ3Q0d0RxWHQ3?=
 =?utf-8?B?ZTk0Um4yYW02QkJwS3M5V1FvRTNzR2xlOTVYamJ1amxwSThNbnNKV1VwamlX?=
 =?utf-8?B?a2FXUlRjaUhORVZvZTZhRkR3Y25kZkJUQ0JZUkt6K01BY29mN3huOUU0MmJJ?=
 =?utf-8?B?QXI1QkYzYTl5dWdKVi9ZMXVVczArZjc5dHdVck1wUzVUWG9tc3VaSzQ5YlNo?=
 =?utf-8?B?NmpKL0FibWk3MkxQRFQ5RlBUSnU1eUE1aUIxdEhjY1Uvam1WSWpzR0NzTUp3?=
 =?utf-8?B?QmhCWWxUSm1PbGJhWTFlZmMwK1lYS3RuY3FZS05xanh1c3VqWVpNT1Yrajk0?=
 =?utf-8?B?bFE5dVN2NVJnLy9VNks3UEVHT0lBcHBBSjduMENzSmFTQWYvQnJQLzFmRWx5?=
 =?utf-8?B?ZnlqOEZ6REhJamI4M3JzZ2p1dEdEYng5MVJXWExPNE8wbTVQb0xBUmRhNTRU?=
 =?utf-8?B?U241NjdjQklmdHo3TExnckdsZ1dETUIwbGg2cEQ5QitOMm56d2lTcEZ6eVU3?=
 =?utf-8?B?ak5jelhUMks0S3ZjZk4xRUJYcnVlNUdNNkl0c00vRm91Ui8xRzc0eWJ1SjVu?=
 =?utf-8?B?Ni9KTllwMWRER1ZNdDZCcWVibTh6dXNwbGRQdkZEVDN5SUtjdW9JbDY3RFZY?=
 =?utf-8?B?UUNaRXlHUmJNSWF6SDhuV1grbFk5N3NkRFBSOUNsVGg1Z0V0NnNaWTVPc3ZQ?=
 =?utf-8?B?RFVSak9KMXFVTEdDeXFnOEVkUjg4NVEwcTdBOXptZGVQYnYxazh5VDV2STYw?=
 =?utf-8?B?SERvb0VGaXJBRHhzL0NXeTdueHdPZU9LK1hLWk5xajNiWVVvYWFhRW5idXdH?=
 =?utf-8?B?anNOT2xYTjA4V2RsejJQcmhMWjVGQy8vRVhGa1l3NHU0RUJuN2d6bTJjam5X?=
 =?utf-8?B?eFFvMHQ4b2M0Z0lPTnBFTnRBc2swWGkxd0NCL1g3UURYMExKaTZCYUNxU3ZB?=
 =?utf-8?B?Wjd6cFJZaFFsMmlha2tTQmpKTWVyT01wSWI0dCt1QUpRZDFPM0E5TGZNREdJ?=
 =?utf-8?B?aFFDMFF6UmxKaEU4ZWhxRE15S2JKM0Faajlwc20zYVJHa3BHYnA2cDZXZXdN?=
 =?utf-8?B?MEdaQUt6UjlzYXlnSW8xWHlrVGR4dWNDZkhqaVYxSXRmMC92eE5UQkxPNDBx?=
 =?utf-8?B?dERLemU3eE5GNGhOajMrbm5CVkRIb1dTWkQrODZrNDZtTXBjZ0ZjMnF3TGJF?=
 =?utf-8?B?aXF2c3h2UUNEQXo1TUt0b0dpbUZrajlwYjRFMHdhczVoVzFXcGR0b0t1VEdW?=
 =?utf-8?B?ZEJ3bmx6WUFCa1FDaWxuZUtPUmJpbDNYVUVVUmRIYUM1YWEvYUhVWUUvajFm?=
 =?utf-8?B?elAycFVpQXVRVnpEanZrUE5TYkxJOVRweEVMb0pxaHpRNGdrTXhwU2NaajVV?=
 =?utf-8?B?Z3cvL3lJUjMvclNuYkZlcUE4SmhZbnhUNG5RckxycXFRUitqTnR6dGl5U3lD?=
 =?utf-8?B?ankrUUV3MDFKVTdIMzY1TDlVSk9DN3VmN05WZTh5R2pIVWNKRTlubGlPK3BQ?=
 =?utf-8?B?QzdKT2crZzJwOWVFTWQ0NmJWR3Q1cWlKbmw0d3dnSXMyRW1nRjNWL0V0QzYw?=
 =?utf-8?B?TDdjM2F0OFJ6K1BOQTU4UG9JMTY1Sit4WTk4eWpMcEdUM0ZnSEhZZFl3RnBJ?=
 =?utf-8?B?Z2NrcHB0TXIxWmNsS3psc2EvanlwL01YVGR2V2swU3UvNzFLVnJiUmRFb0E4?=
 =?utf-8?Q?TMNYBe1/2KiTip4v9f7x9CtE1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d051942b-7e48-42ac-f127-08dd1fb536a5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 22:42:12.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3BdDYoCgv5jlQ3J/BB5BXICphtalSlnqMnMhTJhOSfwTg5//TziP7cPxAJFtE29jBXClyBsnYxD8eCczkWzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

On 12/17/24 16:07, Ivy Huang wrote:
> From: Sumit Gupta <sumitg@nvidia.com>
> 
> The compatible string for the Tegra DCE fabric is currently defined as
> 'nvidia,tegra234-sce-fabric' but this is incorrect because this is the
> compatible string for SCE fabric. Update the compatible for the DCE
> fabric to correct the compatible string.
> 
> This compatible needs to be correct in order for the interconnect
> to catch things such as improper data accesses.
> 
> Cc: stable@vger.kernel.org
> Fixes: 302e154000ec ("arm64: tegra: Add node for CBB 2.0 on Tegra234")
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Ivy Huang <yijuh@nvidia.com>

Reviewed-by: Brad Griffis <bgriffis@nvidia.com>


