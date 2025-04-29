Return-Path: <stable+bounces-137001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79AAA041B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 09:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FB37A2C22
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90AB2741DD;
	Tue, 29 Apr 2025 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tOZmOc34"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F38F49;
	Tue, 29 Apr 2025 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910531; cv=fail; b=SM9HuEzTQoP7apxbigN5unPGBOkp/tAsvDY9Yo2w/DQYxSRdRNdxSRXsv+MHQ2jP0UXnl5mbyiTZbAwkD1MxpCzle36i/ckAfgk/CAs+LO6VTJkTKKug+pXLYQk2BCe8TtZNlHlAQEayR0iSNUsaCAfyH8PSSKaX2Bj7rTvvhro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910531; c=relaxed/simple;
	bh=DZls6/1DiYn/u8y2Ef2Z/d+g6FgxjaHE9BRiDEM1u8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CV1qVhV1mob8f4GVNZM716/3XKAP5Siw2FBXJyfmMuYUyQCAjYxOSmCfHM6+3yjc9IveP0prl/OXcq7lrihjt/fFDIOAvE+CGUwPDKs0P/OB+fMZnJ5xgQyjOx7IxBckvzz3al9CfwNflmev+UCZ+njGTZVRjlNcuAnqKfguu0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tOZmOc34; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuvEvtfLTylzpSRYK6FEU4jEzEqR3do14HfJSzAMloSOZamgSlL7RmwZS4bE1DzggHW7DOOzfklx+ogMdPhvPhjoSqg/Q5CMZJjk9RgRuG5uWDAIdbSXgQcBVZzojE2VWaB9rQ26VfCA1rGO2iZNRzynSPeigZLqMWTIgiLngajoqxSlE+UQ1oOXw+4aXDvZmYnkX2NPRFpcjRh5v6NHHgYrLnsr8b48+LQRwp+sADik9gJuO2jFdDOQIkgWOGpxtcOw1OFg2LQBjmOEO9eJX/uuJHqJoSLMwset+WxDvn2d6Eotu1fcU9NlQd6AS/LWNo4UWvFYcNUEdRm3i39Ejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvxUYx8P4k4MMvuPDAC2OjGj0uNvF31HiDmPLKyfsxs=;
 b=ZE4Lg7LkpHFWQm7evd+0wC5g2e6wP42npR6hMRUHK9omUenAjWEerFa9DWTETo7Ijonul6sgtH1nvtMM94nXrJodWv9srGlIambHI+ITPlZIJ72Hbsq6ezk1edLVY+wIibfrI4Ffh4dB6tK72yzQ8edNRVFqEZ32IyQoNcOHc8uS7EmVENwPLQw1gZTvglreC8H4r81wObstAvUimsI8bqZ+1a+9COOY3710zDdCUP4Wx3j4zicrZmIKKlTNhMIrNzDQ5PdmShZDZshMZWse9WQNm2fF5pdOA2aW5MTK8CvDc/MCxwMqcRPowVKOFL+OBj+KNBEtBS9Z1pFM3qSd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvxUYx8P4k4MMvuPDAC2OjGj0uNvF31HiDmPLKyfsxs=;
 b=tOZmOc347pldvPOQHV+Of2ixv6EroKT6oHfdCvP5jVAiptAwuA5dFM09YkYccd74FjG8JPSjMOJzJcnqL4OjIxtoAbUbiBKAlQ7ONEDLd6X8dxNCSYAkKKsIgsWld1q/58Du08on3n9Y2vMbvKpbdPSG2xj01d8Uk1cIxdiysbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 07:08:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 07:08:45 +0000
Message-ID: <c0935cc5-b187-4214-84e3-8d391c0a9b77@amd.com>
Date: Tue, 29 Apr 2025 09:08:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "drm/amdgpu: Remove amdgpu_device arg from free_sgt api
 (v2)" has been added to the 5.10-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Ramesh.Errabolu@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
References: <20250426134009.817330-1-sashal@kernel.org>
 <d5b5c2c8-4c44-4500-a56b-12888abda85b@amd.com>
 <2025042922-elliptic-impish-9c91@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2025042922-elliptic-impish-9c91@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 808f39ad-e511-47d5-b2c2-08dd86ecae3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3VIbC9UcW5qb09uQUgybkpZaDVqSlRSb1pxYk9ybTVpemVZWGJad0hNWXF6?=
 =?utf-8?B?ZVRiMGFJSjVDSFE1YmM0eHhYaExzYS83TG4zQ3hSSTk5NSsyZ3hWWXpJdHNL?=
 =?utf-8?B?R1g1NU5nZ05lTG9nRHpWQ0JJb0xkOWNSZXU1K3NuUkNEMjR5c01jR2svRzFx?=
 =?utf-8?B?ODY2S1JtV1BIZzRoNXN2VEU5ZEUrWVBGakJXNW9MV1FTeEpyNzNhYkE3czZn?=
 =?utf-8?B?UXBkNldrcFppTUlvMGhjMUtiQXZWQ3BQWFNXd1p4SytZc0lxbC9aTjNNR09P?=
 =?utf-8?B?ZjF3ZHQvWDdWZ2d0c3BMUEY3SWF0ei9KZkZtb253VTQ5b2JUZUtoaUhaTWc2?=
 =?utf-8?B?dUhwd2pZa1hmanJjamxNbW1FRDAzaVVlNWY5YTNLYWV2U25LYVJVa1p1L1Uv?=
 =?utf-8?B?QWI0MjRZb1R3czBvZ1E1WUs3djBCMWVNZFo2dkZVb1BDZHZYRDlBcUdVbGVy?=
 =?utf-8?B?WXdJYVhia0JQSng4ZURsOUQrSllxa0Rjcmh2STRXZmVIK0dRbUEvV0lyTktL?=
 =?utf-8?B?d3BLMVEzVHNXdWRwSnJSMFVNNkhLazlOY0g4bWhhWlJWRHNiTS80SDhsM0JU?=
 =?utf-8?B?NFBHQi9kTXZ1RGZNVktTSXY2SzNZcjdFZjBLbjYwWHh0YXVabnZuOGZlRUE5?=
 =?utf-8?B?Z1pRS01Ia3BHai9ZdUJMNEV5dkFnMGF5dSs1WjRRQXcxVGdhbE1wSmVQYmZU?=
 =?utf-8?B?RkFaUFBLSnZjN1FaWFFRZDdUQWVaNk9NOUk1bThwcStLcmNCZTZzSUo5R3d2?=
 =?utf-8?B?QUsyQzUzNDFZY3RRcHRCcGpSUVpqVjF0TVQ0VC8yQWFMbU1DNkpBbzBvb09O?=
 =?utf-8?B?bzFBM21nSncxcEM2eUhNYzUxOTBYMzdHRmRzRnBrWmNDNDlaTmpnRjBwZHBn?=
 =?utf-8?B?SzcyNGFBMzBhWmhCa2JUU3czQmNMVW5lZkc0Zm5rR1plOW5GMnZYSm91SEJk?=
 =?utf-8?B?K1QwUXhLWEpOQzlpRnYvS0k4Z0pOZFFCNW9SZ0lKeTRvbC9aQmtaQmlMekJ2?=
 =?utf-8?B?VVFPTVl2MzhWc1IzRHlrUk9ZVHFmQmsxM1JZekNCM2YweUMxM09JWGtwN0dv?=
 =?utf-8?B?Q3NvWEpBZjFlMmJYcVl0MXlXZW5vRzMvNGF4NjZjcjRVbkpkSUVnQm9LRWhK?=
 =?utf-8?B?ZFJtYXZJblc4T1U5aDc4bHYrSmxJODN4dzhaU1hKUk1uemRaMHAxTGdXNEdw?=
 =?utf-8?B?TXRzTE5aUlBua21zYnBTUkpDaEo5RDBVaUYzdk1GQXZiekpCekpwd1Blc1Fs?=
 =?utf-8?B?b1hhM1B3YWxJWEh1U2ZVVFJlaWtWU2Y1MWljNFFpQnovZnN4emgxVjBicHhh?=
 =?utf-8?B?N2RWQ1FCaWliOVRHVjhST0kyWDJuL3dsN1ZOMllTZWZRa3VZL053TkpwSTgw?=
 =?utf-8?B?dXJKWE16WVpQR2hLWnBFRkRDZElsZk1HUUh3NjhHa2FlbHBUODYvZ044RXQ4?=
 =?utf-8?B?cjkrdHdJTnN3UnZQZEpmSkZBRzRQVklVVTlWazN1VWdDWUJmRHF0cjJVUlFF?=
 =?utf-8?B?aUV2UStqN2gvdnJPRGM3MDVOcVVkNWlRYTNFV0Fvc1o3Zy96Zkw5cFVydmZp?=
 =?utf-8?B?aGNFQnBkN1l4a3ZiYmRVMGxpQ0pDUUtCMDAyS3BlR3B6QmZzaVFoeWdSS3Jw?=
 =?utf-8?B?VGxhZHNLNWZBL0dXMzlXSkNXd1MzZjVJYVhOQkpOSEQxWG4ycjBqa1hEc3VT?=
 =?utf-8?B?aENKVzVYT3VsMm5SK3BuMXg2bldzSGt2RUY1MmV2RWZyeU54cmY4YTAzdkIv?=
 =?utf-8?B?RVVsODdHcWZEWXVDV3VTTmFKTXhVQWR5ak1ldWFBSzk5Y0hDZWw4YktIRWlO?=
 =?utf-8?B?eVRQQ2FkVEJiNE5Jem4xY0RIbXZWVVZBRXlKT0VBZ2Q2NDBMT0hYdC9FV0h3?=
 =?utf-8?B?VWI3YVFFejBiaVc4ZXhzUmVtQ0V1TUVoRlh6dnZzc00zdkNqcHVSait0dThx?=
 =?utf-8?Q?Ol/tBRUFxI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUU3Nm5Qcnk5USszNEtENUdNVUtob1BGT295V0Z3R3FleDY5UUwyNWcycm9i?=
 =?utf-8?B?M0FKa1NtVk1qMmhXV0hJV0RhbStRd0FrNXdnRzNQSS82TmwrdVpqY0hsNDNp?=
 =?utf-8?B?RzNPaGJXRnQyWmh5MWhXMmlocVlhRUtXRHBUVzdadzlvbStaUEh0MHVHZjBN?=
 =?utf-8?B?bmMzYytlWFZFREQwZ3YzVk5RZDNOYlVVRkZiaEM0MG43WVVUTVdzKzdWaXBn?=
 =?utf-8?B?U041MkdWYjBVY3dtSTNkMkxqV3F1b3htdnQ5K0tjM3FabllGS2psbFVwa0Ft?=
 =?utf-8?B?a2tEc3pCQ0RBdWp5djcrQkxRVE9paGNTNS8wdHhoRmFiM1pPUTJ6V3FqeXVL?=
 =?utf-8?B?WVpsanQvaDd0NE1kM1pETy9CYlk2Mk9sYUtmdWNNdXRpWGpEOWNvTmNaUFAy?=
 =?utf-8?B?c3BaSnVtK3p1eTJQRElDTWU0UHAvZHp5WjBMV2c1TDJWS1RYQ1RlYnN4dG9N?=
 =?utf-8?B?eTc4WE0wN0xEcFh5bnJNb3o5eGNzU0ZMZUJFcnFKZStBRDBYNFVIUVdQR2lo?=
 =?utf-8?B?VDBWUUY3RTlZTS9GcjVDVzhHMDdnZEpOdjJDUGZINllyc1VLZ1FLQUdRZEtj?=
 =?utf-8?B?UzcydVpGTWRGT1UrYU1hRUxib3BPa1U3V3ZEZFZUaGQ0YzFkVlA3NzZWVXZW?=
 =?utf-8?B?cEh3ckJuTi82TjA2N1F6eHUwc3JwNCtHWUwrcFFFeE0yNlhGMVo4cVV2MmZC?=
 =?utf-8?B?ZUEzSlN1Vys5aDlRN1VaTVk4dkhVSXRhVTZWWk9aTTI5c2UzanFTNVpFZWpi?=
 =?utf-8?B?bm9NVkdnMG9IbmtNT05EZFdUeHVPUzIwRk1xWUcxV0xORDlabks2NVI4cjVa?=
 =?utf-8?B?KzFYUEZybEJEcmloVENIQW52SHNuay8yczlzRDhia1AxUmY5Y0NjdDJIZFEv?=
 =?utf-8?B?YlNtcS9ZVFN6NVhMVS9WK0R0TnU3a0ZnSlRlc3FWaTZuRk5EUnRueHpYT0pv?=
 =?utf-8?B?b2xPK1QwRDJEaHFmN1VEalUrdnIreGhHTU1jOTYxSGFzbjh0SHFDRnc4RVF4?=
 =?utf-8?B?VEFkYkJqZVNEdEoyLzliYnpNVDgwaGpXaHM4VmtaRVZvS0dNemxTUi96dGhQ?=
 =?utf-8?B?L1NzMTdMRmZ5SnYwUFRScWJNVlJZcTU1UXNIQyt6T04yWWFMNjd1NmNJc1kx?=
 =?utf-8?B?Ymk1c21HdFo4N2ZUZnJDczBmSGFlbXoxbXAvb2ZHQlhXVEJUMGErNXB1OXBj?=
 =?utf-8?B?R1BpUzZHakpCN0I3eDBnT0xqMVF4RlA3NFpxMWIxSVZ1WG1BRVkwWHEvLzZu?=
 =?utf-8?B?WEc0V082Q20vNU5RN1U1NWg5RUtaQXRSRzl1NysrL1AzQld1dk4xVnMyWjY0?=
 =?utf-8?B?L1Y4VEtNTk5Sam5vSkgzNlg4TmsvelJram44YlpqdGM3Z1VtUkVPQ0ZlR2tG?=
 =?utf-8?B?KyszVHlCcVBtR2RqdDNEMEU3N3ovSGZXMnV1aGhuckphTVlYK2lpQTRVWDBi?=
 =?utf-8?B?a2xqMTFVa0Q5TFBXRGRyaGxJenYwL0FWQVJSZXorUzFqUjhKOVg0US9tS09i?=
 =?utf-8?B?VHBFQ2pVd0lhRDlMZkZzZElib29UL1JzaGl4N1Nva0lXc0gvTVBmR0dsOWNh?=
 =?utf-8?B?NGx2c3Y4eHY1cDkwOTZwWnRIZTFPdEpaUUZUdVY0RHdyMkQ0SHBRVVpqSUl4?=
 =?utf-8?B?dW8veU5nY2RMeG13RjZsQ2hFdTExeWE0WXJvL2E4LzJwbGFLQ2s1WUpUMHZF?=
 =?utf-8?B?UW5HUXpsdUpiMHAraUJMVENSaTV5alZMc251NitjaHhEcGg4ZXVMVUpicG5X?=
 =?utf-8?B?dFdzWDNka3U4YW5JR2JNcEJ5UUZVajd6empHdnFLR3ZjemhlY2d3a3BZdEdH?=
 =?utf-8?B?ZkE1SVVibXlaQzh5Z3RiNlNjeW11czRSRUQ0YW93UFhSRVp1Vlc0aVluS0VJ?=
 =?utf-8?B?MldmQnpUa0pwcm5nb0c1MVgya2t4MFBTc0pvUjBGM09YVnB0MkRvWWcxdGhl?=
 =?utf-8?B?QzdNNlFhVXlSbmowOW10YzYvelErcWVrK3VCTzJJOFF4eDJjV2xDc2lqODh0?=
 =?utf-8?B?MS9MSm5LWnYzL0NWWVd3MGNmZ1ErdVlXQmZ6UzV4aUNSRzBlcWZEK0FXQWk5?=
 =?utf-8?B?R2FDU2plT2wrS2ZSLytZQngvMEZxYjBQQ1ltcmZZYlgwRWhuTEZSRkJYQ0Mw?=
 =?utf-8?Q?FfVC5j5m4BrNswvkrQN+ZQr+S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808f39ad-e511-47d5-b2c2-08dd86ecae3f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 07:08:45.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1onHPzQBMrPy7Z2CfeIVT9seqlSVSTqjdDgQbX/3MzziF7YuGoNJAyen9749r3f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845

On 4/29/25 07:24, Greg KH wrote:
> On Mon, Apr 28, 2025 at 08:20:02PM +0200, Christian König wrote:
>> On 4/26/25 15:40, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     drm/amdgpu: Remove amdgpu_device arg from free_sgt api (v2)
>>>
>>> to the 5.10-stable tree which can be found at:
>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>      drm-amdgpu-remove-amdgpu_device-arg-from-free_sgt-ap.patch
>>> and it can be found in the queue-5.10 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree,
>>> please let <stable@vger.kernel.org> know about it.
>>
>> Mhm, why has that patch been picked up for backporting? It's a cleanup and not a bug fix.
>>
>> When some other fix depends on it it's probably ok to backport it as well, but stand alone it would probably rather hurt than help,
> 
> That is exactly why it is needed, see below:
> 
>>>     Stable-dep-of: c0dd8a9253fa ("drm/amdgpu/dma_buf: fix page_link check")
> 
> Hope this helps, thanks!

Ah! Missed that.

Thanks,
Christian.


> 
> greg k-h


