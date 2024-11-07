Return-Path: <stable+bounces-91788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9AA9C03E5
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C991F230F4
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849C1F4FAC;
	Thu,  7 Nov 2024 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="snFTMa6H"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE21F4FB9;
	Thu,  7 Nov 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978813; cv=fail; b=SeB66DT87FysVSfYBcUFaltGGKG4lT9TA8FfBTF4yDZb7mVqi9hVDPOLzUZLggPqdM3rUm+9caWJwQo+41Ni74nhkHoN9bwUr0gIoVUaG/KkP5/Pi6VbB7SkFJj4gtatyuyHafV89dFac2+8Da9u9EP8cJJJu2APgN9vjUeAyJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978813; c=relaxed/simple;
	bh=zaq0OB61PlACb+AECHgeM+1g9kDoByB+0T/negeiVds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ImFFwZsodpLY05haysdFT/jIDhyfyBlI7dM5JvjwQLy2gKeKTL3iioFYNU1Afs+LbQWVGT+lO7d8N0lbBopbPVgOxwdzinpwYHP2ZBjEdh6pQZmFTOtb6gAOarb4uqF9A2N18I5jVpFDkgx2i3Cwb6b98UzJuVWS4HwQYYttyxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=snFTMa6H; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/PHsBdHVxgywGI68XehXROzMwln0sVt+qt+ExtoNdehb4uUrYpwSjwNnuilxB7LbLYW0LZIlLV5K/jQC2OvwxFZuqKrtZLf99Xp4LwFRJCW4WW8dJgSk+omcEnNQ2B8a6Pj7W760vbHHCXjgu412NvW20IaHPEi/srbeYSke6U4fO7+k25PemjzlyVkQN4uZCLdlMWqw6IG6CgVjzNh7YVj8mNfIzPlUPSUNw2qajF2Mlh7fyqg35oTbYLGf/06ChSd2d7U1ZeIOv/85IhuYD6M8g5m3YwIDvMISwqOexBIiyMtOX1z+mvsUHu8u4QEnASF5a7ytauYRvSUJVASFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieceYnKo9T2rK0hev3RHMVIg757lhaJQg4IXodHCP+k=;
 b=ceGO0dsqZo2ODynDIUF5pORYqPKCKGd8abzpgSYx5aZDZykfshQRdzPE34A6sjeUMLP9+BS5vN/Pjz6jyuC3256E61e5ykr2r4VaStrbHmEFm4zG8hHbNPTnCiKgDb4yyFZYdNisNA4Wi3eA71n9WKHr3gwe0Klt3/sFVlA2l3lQQTje7eKeRSllwcnmLrW0WDdo2LY/g0gaH9W5sqf0gRek/+cJImaem/Q1c0lXBErSTGDuYkgdSn6YoDPp/zZHgAJMfhw+N5owu6ChOck9aVkCqbbKsWE4544m9voStEroy1mZtfpDsO9vq7FuogLVbFInHyrbNWGMYBQcS6J+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieceYnKo9T2rK0hev3RHMVIg757lhaJQg4IXodHCP+k=;
 b=snFTMa6HYuWcsjWJnchgcgFRGt66x00kyLsmOXtw6dUz9+AVrpPN7CtpYejxJOSFTK/+fwW8erDnLtVvNZuoZotcvHyErmfBLKzyMdjt71AUmpLU9GyBHdoDc7mRkhkV4QroNAOnwcEq0Kv19WvSnlkVsdspn6j1JEYaaTxC6kU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 11:26:49 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8114.031; Thu, 7 Nov 2024
 11:26:49 +0000
Message-ID: <3e11939b-d62a-caf3-e51c-f67651c8cb6a@amd.com>
Date: Thu, 7 Nov 2024 16:56:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] usb: xhci: quirk for data loss in ISOC transfers
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241105091850.3094-1-Raju.Rangoju@amd.com>
 <2024110557-trusting-dismount-1e27@gregkh>
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <2024110557-trusting-dismount-1e27@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: a5675bac-e9d8-4b56-4b63-08dcff1f11e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVkxUDRKUW9KanNkcWVOOThvaUVsZlh4bGtkZElWeHVWdmxJcVRuR28yaVYz?=
 =?utf-8?B?cmluUU4xRXF1bVpVNTJTa3B5cmhQbnFEeVQ1bjFCaCtxajQ1WW5YeFNtQjNI?=
 =?utf-8?B?eE9DVlovWHM2YzFNdExFUjdmTVJjL2JrQXhHZmtJZzdZYjFwZnJtZnFyY0VN?=
 =?utf-8?B?bG42Z0VIV0svMXdkeXdkVWlnVnJudU5wbjF2T0VWSmpnQ1VyaHh1OUMyd0Mw?=
 =?utf-8?B?L0lIcENTcEx3cllQcitiSVZ1dDJHblNNd0ZOTFpDekJmVjhxdjVCUXlWK0JR?=
 =?utf-8?B?TDhUbi9ycUJWclVMSlprMUZQZG4xQS9heEUzdzZZZDF2WjBrYVFocUluM2U3?=
 =?utf-8?B?V1BXT1QwV0prYk5sakZNWWUwQTBOSzVOandBaW1ZNEozRUtjNXVIZ1hxdExs?=
 =?utf-8?B?N24vM0FXaGFLeHgvZ25IYUpkak40cGUreUJCT3B3cHphMTMrWVBBME50R1hn?=
 =?utf-8?B?YWNhTzJvbGk4ajR3ME5pcXFZNFd3YkpoYm9TV2FTMDVtYU81clZrUHQ3M2Z0?=
 =?utf-8?B?S0FSVXVvazd5aHR1YnRsWWdCalRzRlBpL3N6Zy9ZWC8yVVgxRUpYV2x0YjVs?=
 =?utf-8?B?TlVYZGpmNjN2UFhuWG1TWXRPMkZqbU1KaFloQkxaMFV5L0FBbmh0SkMwTm1V?=
 =?utf-8?B?L3Qvb2JXbGsyMExZdDBZV1Ewa2F5VkVCZGZNdW5QVDlOQVZ6dW5lOWhKMFpV?=
 =?utf-8?B?UzZ4OEVLN0N1R1BDN3YyU1dscTBFdWVrY3ZpVWNuZVYwNGx0dk1VM05ZT2Q2?=
 =?utf-8?B?QW1ORzU0amFFUS9MVGE5bFB2WDZMblR5WFpyY3ljOFFabXdNYTNtLzI3VHlJ?=
 =?utf-8?B?Mm9ERGpHWGVpNmdjbnpqVXdqa0RQV0ZuSENiaXFPNDJsWGFoLzZEei9Lcno2?=
 =?utf-8?B?Nks4T0NhemdONDZtRlhlb0NBNkhxMGMvbW9ZNjUxamFlTnhOdWZzczhqT0ZX?=
 =?utf-8?B?Q2NJQjc3WlBsQndleVE2RVkvUmp0T0pSNXVYamtNczRKU3NlbXhOWERKNmJJ?=
 =?utf-8?B?VlVCU0txNnJrZkI4MEJFbWVtY3oxMlRPRFFXcWpCNjd1NEZiK1U1WkJUN1Jr?=
 =?utf-8?B?ZVRVbG9GdzlndFFORzdlNm56SDNXKys4N3lPbXFNKzRuS2hnbmt5bm9iWTI3?=
 =?utf-8?B?aS9zdXJIN2NJVGRvazRMUy9kYUlXaUF3OFNTYkhzcmNIMFRHQVJpb2NETFFw?=
 =?utf-8?B?bytrQ1Joc0Y4WVF1SVlpc0lzcFpCdVFMSExGL2JGeXo3dWhIY2lFcXRYMjVR?=
 =?utf-8?B?eXlkdUJBSmM3RisyQWtpWUdHcGZiTGFTWERKQnBROHpOQm5oNEtBTVg5REVG?=
 =?utf-8?B?ejl0R1ZsdHRzQys2MnNiS256NWxRTDE5NXFpODY2TmJ4eWJ3Um05TkowUk1x?=
 =?utf-8?B?bnNTaURMT2llL0dGMXgwS0h0MGx3RFFXOGQvc1lxVjEzbW1Pa1R1Yk5KZ0tz?=
 =?utf-8?B?VWd4clVkOXkvWk42MXp3d2dsOUhFNHJGVWwzRU5UR0Vid1NuVENiOWJmaXR0?=
 =?utf-8?B?WHJlalkySnh4dWppQnF2RWROQWNPWTlaOFNYRzczK0JiOFhoT3gwOFNaQm11?=
 =?utf-8?B?TW9Ibks3RDlJVm5yYmh5Zi90amxoOE0ra00xd2Z2aG02TnkxaE15L1RwTWNq?=
 =?utf-8?B?c2dMSVB6MEpqeExVdXFvbFdGZmNuMWI4NUxaUjllaVFwbVZqU2pVbmpOc2V4?=
 =?utf-8?B?UFlTSk1NcFRXcHk1WENYUVIwNWZGeUtXWDRON0dOWGpjbnMyaW1oUlduSHlC?=
 =?utf-8?Q?fiUjahlxyJkZ9qRZ9yT9xE1rb6kwRsibHCX4KNO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alZkQytUUlEyak1aNmE2TCtlOFFpOVBrOTAzMmUwbFB3T3ErSUJ6QkdsSjFQ?=
 =?utf-8?B?RzJBRWxMSFhxWXlqVkhaRDI4OWxJUzQ1TUdGV2k2ZW9wUldKZDZrT2pkWm5G?=
 =?utf-8?B?aVh1Q3lIWjMva004OG02LzhZbXhyUWRpMVlnazlEOUtsWEVUVzkwb2drNEE5?=
 =?utf-8?B?bzdvTGc4RXd4TUQrL2hCKzVxN0lJQXkxWjJoUWNNSVh6cGFuS2U4WjFxcFdR?=
 =?utf-8?B?MGM4SE0zZ2NaNzNyZm13UHBteG5GUEl5czhwRUdnaUNRZjFvb2hqRFpuQ25W?=
 =?utf-8?B?WmMwSlk1UVJ3bEtJRFZvdmlEZHk3N1F6WGhOSVJhZWwzdzZERkkvZnBzZHpT?=
 =?utf-8?B?aWhmZURSQ3JIcEhmOHdBaHZNUlkvSjJHRmxSUTRqUUtDT1ozNVo4ZkVZRWpz?=
 =?utf-8?B?Y3c5V3pqZWcrSjI0NXJTRFF5QlE1b1pxNGVkM2pwRnRIVUNkcStGcnhhbGgv?=
 =?utf-8?B?MlRQK2c5REhBK3pIdWlwYVppNGRhdkpubXR1NVE0Y2VZMVM4ZHV0Q3l4MEY3?=
 =?utf-8?B?VlhjT1JpeGIxcVdXN0VoYWlZVDJWWTRJN0MraWhvM3M0d1dsTmlGK2dlRHFv?=
 =?utf-8?B?dHRnNDdyV3ppc2FQS1lxdktXY3VFK3BnSXZhSFFTZVpvSmJrbVN1NUVOWTkv?=
 =?utf-8?B?bmhvbElqeVVBUkZmWG4xaktmZ1JRS1lwbWxzS3NXck8rNkt3dDk2TjVnenBo?=
 =?utf-8?B?SHk0b0JRa1drSjBJVjJlVWlSV094NENQaDZwWXBZQStPSUVVc3lLQ3dSamhi?=
 =?utf-8?B?ZlN4VFpoRkxxK1Z6S2FQLzFqc0NnZzEycE53a3VHYVlWVEs2NFNqZGlKbHN3?=
 =?utf-8?B?M3pyaFVqbW0zQ3RNVHN1Tk51K01iWU5IOWIyRzR5TldTbnA1ZVVNdmdUWmdr?=
 =?utf-8?B?QXdMSjNzUE1GTi9ybTBBM3VFV0NsWWFsV3hZdHBRWG5tWWg1Y1A3cDM1YzRj?=
 =?utf-8?B?aER2VEVQNEtBbjFLQlo5eGtURjZ3NW4zWEdQMUE5K2J1Q2xYcW1Kb0dhTHJD?=
 =?utf-8?B?bUFoOGZSb1pERlFEem9JOXFESHFXZ2laYWRLbUhGK0tEMUVTL05ZL1JNZHRK?=
 =?utf-8?B?bzlXdmhvaU5yZVZCWWVYV283SXFEcENiV1dTc1BuL2IvU0VhYmhhd0lpS0ht?=
 =?utf-8?B?dmVlRFNZSkYrNGdsNU5Pd2lqb1NOV1NCVUZkb0ZXUDZ5NVlGcVRpMyswcmVs?=
 =?utf-8?B?OURhZ0FnTHVERUF3OTlIcERmS3QvdHYrWWpySTFNRStyRkZRbGZiRWlGNjVJ?=
 =?utf-8?B?czRjc1hGYTVCRytTOWJpbG1lSVozbWNBYzgxRUI1aU9uRExRUUJ0WmFSVTZP?=
 =?utf-8?B?UzRobmFqaC9iZHJsMTV5NHlqclh5N05HMXFmbUFhdHRtS0kxNDZ6ZTVPN3dV?=
 =?utf-8?B?dGwybkNWL0hJeFlLRWNpQVV6dVUwbUMyQUVabVJQSFF0SzBGRTArUURTK0Vs?=
 =?utf-8?B?R2pmcnlCTW5NUHdzL3J5VnlFaWRiOW5WSGdEVVIveFpOWFNwNi9MQWpWaStG?=
 =?utf-8?B?WHRsQ0FIc0I3T1BxNmIwejA0Skx2cnR3WCtJcGk4YS8yTGtmcXBMdDlWY2NW?=
 =?utf-8?B?aXNXYWN3bFQrRno5MVRwajdMVktKTmltOE1pNnBoZ2NHZnB2bk53N2NKU0kx?=
 =?utf-8?B?c2MxWUVianNqUVhRUVlNS2RyWGJxak9HTXBvdFZnOVJVckd4QkhRTnh3QTV4?=
 =?utf-8?B?THI3dUQ4S3Jpekc5dzhnOEpMLzZoeXByZWV3cjFkeGJnVmxmNnpadFVWeWtz?=
 =?utf-8?B?ZlZSdjdPRW9wUnRVdWQ5N04wTzVYcmQrMkxZTlJxTjRSTTlsRHVjYjh6bm5D?=
 =?utf-8?B?RUIrdFRPMkd1WW1UOHN6aFp0aTR5UHdQNnVmR09qRWxVZXk1dTNKalJrbHlm?=
 =?utf-8?B?YTRvbElpenJvMVZyUVNZbEt1bUJGd3E1MWFOcXBMYStST2xFUjNCdkxhSnlo?=
 =?utf-8?B?QmxHRTI1UzlDbEVrbm9sWW5WSkwxYnFDQkpFbGkwZUJGY1ZYUTh5OUxLZjlR?=
 =?utf-8?B?VUR4NVhOd0pTWCtqSzRiV3UrY1Jqb21GTU1EbXBLbVhqOTNvMGErMHNOd1hk?=
 =?utf-8?B?K1g4N2diRSs1VGZTdGtKVnhMdU10M3poUktqWXBXVEhtS3kvSUI4S3NIamxv?=
 =?utf-8?Q?ZkXQvn5gzncoKRtwjDjykmhD/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5675bac-e9d8-4b56-4b63-08dcff1f11e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:26:48.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqohLVFaS464QTpqfySIhabrcp2PFt1UTtcAt5q3GvNh/w0Gp+TQ7VtLAr2tsQCf3xrwIhaM1M1sgxFwNMczrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070



On 11/5/2024 3:03 PM, Greg KH wrote:
> On Tue, Nov 05, 2024 at 02:48:50PM +0530, Raju Rangoju wrote:
>> During the High-Speed Isochronous Audio transfers, xHCI
>> controller on certain AMD platforms experiences momentary data
>> loss. This results in Missed Service Errors (MSE) being
>> generated by the xHCI.
>>
>> The root cause of the MSE is attributed to the ISOC OUT endpoint
>> being omitted from scheduling. This can happen either when an IN
>> endpoint with a 64ms service interval is pre-scheduled prior to
>> the ISOC OUT endpoint or when the interval of the ISOC OUT
>> endpoint is shorter than that of the IN endpoint. Consequently,
>> the OUT service is neglected when an IN endpoint with a service
>> interval exceeding 32ms is scheduled concurrently (every 64ms in
>> this scenario).
>>
>> This issue is particularly seen on certain older AMD platforms.
>> To mitigate this problem, it is recommended to adjust the service
>> interval of the IN endpoint to exceed 32ms (interval 8). This
>> adjustment ensures that the OUT endpoint will not be bypassed,
>> even if a smaller interval value is utilized.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/usb/host/xhci-mem.c |  5 +++++
>>   drivers/usb/host/xhci-pci.c | 14 ++++++++++++++
>>   drivers/usb/host/xhci.h     |  1 +
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>> index d2900197a49e..4892bb9afa6e 100644
>> --- a/drivers/usb/host/xhci-mem.c
>> +++ b/drivers/usb/host/xhci-mem.c
>> @@ -1426,6 +1426,11 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
>>   	/* Periodic endpoint bInterval limit quirk */
>>   	if (usb_endpoint_xfer_int(&ep->desc) ||
>>   	    usb_endpoint_xfer_isoc(&ep->desc)) {
>> +		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
>> +		    usb_endpoint_xfer_int(&ep->desc) &&
>> +		    interval >= 9) {
>> +			interval = 8;
>> +		}
>>   		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_7) &&
>>   		    udev->speed >= USB_SPEED_HIGH &&
>>   		    interval >= 7) {
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index cb07cee9ed0c..a078e2e5517d 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -284,6 +284,20 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>   	if (pdev->vendor == PCI_VENDOR_ID_NEC)
>>   		xhci->quirks |= XHCI_NEC_HOST;
>>   
>> +	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
>> +	    (pdev->device == 0x13ed ||
>> +	     pdev->device == 0x13ee ||
>> +	     pdev->device == 0x148c ||
>> +	     pdev->device == 0x15d4 ||
>> +	     pdev->device == 0x15d5 ||
>> +	     pdev->device == 0x15e0 ||
>> +	     pdev->device == 0x15e1 ||
>> +	     pdev->device == 0x15e5))
> 
> Any need/want to name these pci devices with something we can refer to
> other than a hex value?

Certainly, I'll try to see if device names can be used instead.

> 
> thanks,
> 
> greg k-h

