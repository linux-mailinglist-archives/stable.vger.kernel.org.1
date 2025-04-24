Return-Path: <stable+bounces-136520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81814A9A295
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176B93B1907
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D21E0E0C;
	Thu, 24 Apr 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zZxaSO0V"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B11EBFF0;
	Thu, 24 Apr 2025 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477377; cv=fail; b=CVbHI2dlRRYMOchouArwgUpzSKUsMJr/ZZ6VlB57ny7/qGuunsZFBMsI7aO0CKOwyNaocxpBhplIr6S3I3hAkhEDVal0Dz7afZs6RtC831rHlfp7yeeIiURy5fz05i0dDAIAEsJswwCoGQgHvBLABcxHTP8Z6DErGsVqVZAy4po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477377; c=relaxed/simple;
	bh=Jk1XV7ViWFbgMdTwitjidIY4+glLpUpMs/Er8nAQotQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j3TDVh+PV/Z9JhOx8ZniYudCvxzoxEsNZva99crVBJn0cgw3shzfZDo408IC2fRLfMR5X4kxvWto/E4pRlGdtTUuyeWUHyhokEzthpOKKRLrkejMywWHdZ7c8TZyHmOqVE8SD4zi+/1WHxKKkADHV+VwcBHz0CJh02JjPzlI5HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zZxaSO0V; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3zi/X6KGOuHUfpldc/FCRNUG2AFl5YLTFR9EEeGkVQkqTakrMDdFtvKHHmVo0tfD9Iz3nVc7gSIWQ8XdDQ+YL+HKVHQjf7liL3DbwfQt2vh5Y6CfH22UFagSXjtb/OM46DSeMUG+a2C+Jz5uSFoNN6+w367Tx/o8XrzdGbfo4vOtt4R9HDQQJpzLg1NAJpmDaqtrz8tt9jV1oxj9kuKkJPTNqY9OBlbRtoIQf+uq+7I7smD8irpk5yPpn18doUVMnqP+gFpyqqA45QXcQ7/K/YJnC2d44eFSA01WXTfVUM0yz2fsBDQ702IM0ITYWND7s6BS+tfwtc/YYqMEE58RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMxTloL/Ev0sbhg7hPWYXMbxDxsigLMr1jg21E/lzWQ=;
 b=JhowLRXIKyMp9sKXJwLfNjqu0EXZn4Wb6qjV5dx9nRfh+2ZRYlCdvDE65EnjEpHBxA6cWeRIteZO1Xj89Wd75wbTXdWDvJ0fUz8nuBCONBjuyNNtNC+uiSZIOTmrS6Iw1W0Pi3Zpd25mdbLmr21N28erPTsBKX+0voO4JalaoN/K3RsOv0PL9aqOBdMxi74rXecO2BhuuHdcQp/FHUenRjmlMbO40UpElF3e99q9LZYx0NywCtbxHZmJfLU82mSjC5cDzlu3FwEEJr/JJGG6drNj20+U+ke5nSyBKq2q2uGkmmT8oLERm/4yQYfOsINnrcKJUYtGG4N49ECMLWaovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMxTloL/Ev0sbhg7hPWYXMbxDxsigLMr1jg21E/lzWQ=;
 b=zZxaSO0V1tX5Tl7iuxJnB1ZG/V2pzygCR54gR4ayyCsF/JKr368NmFxtFAHPX/yRyAnsFM6TRl6pDG+ApKfp8c4roobdkgTaj1VAUQDNDjlCUKiSyaaoveOlZ3lNqQRB/9VtfGQkKaGuXF+gnsXOUn/0BwQ7/ogMuNUlxVu33WE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:49:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:49:32 +0000
Message-ID: <6cee67bd-1bef-4b8c-96bb-da358bc2d5c3@amd.com>
Date: Thu, 24 Apr 2025 12:19:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 shangsong2@lenovo.com, Dave Jiang <dave.jiang@intel.com>
Cc: jack.vogel@oracle.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0119.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c283e91-9370-4254-47ad-08dd82fc2aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTdBZlgydjhxRU9pVkxicjdueG1lZE9jdUJuNmJCUmpnSU9UZVNyaFFRK1B0?=
 =?utf-8?B?b0lmTXZpSGozcVZ5Z0l2ZlYvdVlzWEV3Y1pIeGZXNHFvTmd2Umc1WlppZVZS?=
 =?utf-8?B?cUU0eGZ0Nmpybm1tUDNTQ3FDS1YvanJyQmN1MzQrY08zSi9YNmVDVXRBK0F2?=
 =?utf-8?B?SVhUMzRCM0FFYjhXQmRIcTRXYThHUXY1WTRBVE1HS3VGTlR2aXE4MHZjQWp1?=
 =?utf-8?B?Q1h5OEdHZU81NUVka3pGWVd4S1FPMGlTM2lNcmhjUFdxaW55WXNsOUE5aU1Z?=
 =?utf-8?B?UGQzQnBkREQ5bWxvVUlYR2lJL0p1UWhpUVhYMmpUbnAvNmd3eHNMRittam1W?=
 =?utf-8?B?VDVvNXpLUVM3bkNhaUlIQ3FVVEtjRitOZ2NiVUxrL2NZMzQ1QUQ4YTVHRWRB?=
 =?utf-8?B?WUd4TzlHOEJJOXZnanFrTXE4L2ljVGQwWFpkckhxRXF1VEF4bXZPL05LMWhj?=
 =?utf-8?B?b21TTThGNHh0bVdhYXZROEE1UG1ocHpPMjY5b2pLVFdOSzh2MFAzS1ZoQkdn?=
 =?utf-8?B?dFhxT2ozWXJuT3hSdkRsMkJxOU5UbmZrNVhibDU1dHRlcTAycFBsSHBncjN1?=
 =?utf-8?B?djYrTFhSNXRiMEJDMENSeHdMNnk0cW5uaFhPY0RpVm50akVoSXhJSUg3ck9k?=
 =?utf-8?B?M0xDczRMQWZzcFhJc0RWVnpMWk1TUU80bTEvTW1KNzJGb1IrdzgxMUFEa2tC?=
 =?utf-8?B?TEM5S0ZRYVRjRnl3dWVPSGYwcDVtTEV4TTJlVEVsZFRNTmpsMHVCcVpLV0xp?=
 =?utf-8?B?TUQwR1pXNmVVTk9kUk1Tc2ROUUtkSmRBZzZobjRtQ0l2TzE5djRUbG9kYTh4?=
 =?utf-8?B?S3o0eVR0T3VKbTdBQ2laUWlrWFdpcE50QUZmTGxYS3Z0UmRBbDdTNDkyTEI1?=
 =?utf-8?B?elFydnFPdHB3YXVrWnVkdGtGMGRFVUh6NlVQaUlHSkM4VUljbFgxQUVZbWlh?=
 =?utf-8?B?SkRZRE9lTUpCRkFNaVQxSmRiYlByR1hyZFVJRHZudVFpeml2cnBhbTlIeGZu?=
 =?utf-8?B?UVNFdXcrc3l0aE5TaDV5cmcxekJIUUhnV20wT3JjM1ZCTDk1MlQ0L0FtRzhw?=
 =?utf-8?B?WE1SMUhsYkp2MFA2cFRNbXNQSkxpNFN2elFzdEVoVDF2UTRGNFVWeHd6ZGNN?=
 =?utf-8?B?VUJ4MFhLQzNBOUZYejhDeHRxWFczdi9ObURQM1NvUU5rVU5YL05KZVhmTnBG?=
 =?utf-8?B?VTBQY1hvc2cyMlpRREs0YVpteXNUUy9YKzlRNGpMUEdZcGxrdEQwUzgzUlhH?=
 =?utf-8?B?WkF5Q3R2emgzRHRkUVVkN3d5VC9LTklVQVJIU0xsZFJPdzZnWU5MTnl2YnA4?=
 =?utf-8?B?K09CU2VIRURGMzNCZWZ5Uk1OQjYySUZQU0FPRE1QWW80ckZWMFJldnNPWmVo?=
 =?utf-8?B?RmZkc2ZKNkovSE9NT2kyZExXdS9DdkcvUnllWnJKU3pUVTMzaDN6bmVhQUFt?=
 =?utf-8?B?c3NZZmFMR01Sd0ExTWs1anNVbUhMNitHTXBDczBOM2gwUlZtWHRwQzdwVTI2?=
 =?utf-8?B?djZzdFpDQmN3Qm42V3NJY3BMS2ZZUXhFSnR5V3VKSDJWaWtBbFhEZGU5NUJX?=
 =?utf-8?B?MDk5aTI3V1VpZmZLSGVjV0ZqQ3lKTjdxR1NBd0RrcVlBV2pEQzNQTGo5VG5K?=
 =?utf-8?B?Ris5WnFPUnhFVmhsTlVVR3JqYXVjbHErM1I3eUpJK29lQlQvMW9hc2ZXNkcy?=
 =?utf-8?B?Z1BCL2V5cmdHNFVudjE4MzYxSUkrSmEzSWxjR2owN2k0V2tiYW5qR0FaOGdu?=
 =?utf-8?B?aDUvdGl6UEZLekJjaWNDZEN0cjVWRisvRUVHYSthcHhINFRnb2NyT2hhdHhX?=
 =?utf-8?B?ZU1ISStTV1JqSHl4c2hjdDdOTThoTXNmWDdBZmN2c0JFUzkyb1pTTHlnNHc0?=
 =?utf-8?B?S0xnWGI2RzRVcHJ0UERCTEFCenZtY2dwMHRndDBaK2dKQVlxNXZTVEhUWjZp?=
 =?utf-8?Q?kvvoZ1vdYYg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjJBaUZjeEhza2VBRU02b1BSZnRodWNGQkRvTFIwb2lEb2NOVGNMSTg1TDlp?=
 =?utf-8?B?V056NmdLMncxMy9jaFJTNEl5YVc5cnorUnd5MjdWVXJ2Y0xNSFE1RzNDbFpt?=
 =?utf-8?B?blM1U1kyUnpib1hKOTZtZzExZ0ZpZW80QmxIQmg3cVQ2VHdRelFpdStDRy9E?=
 =?utf-8?B?UUZKVTFDYzJEVExKUUg2UmVFckZNNEhZVndkdUJjdFFLUG1uOEYwVlQwS1gx?=
 =?utf-8?B?QkhSVEk5Z2tCNXMyYnhVbklKZ0JwNVdOcG4xWFp1MFdkV0xwODRMN2dIN1hK?=
 =?utf-8?B?VHJOVXJRMzVESkxsMW9TOFlxWXYzNi9VV0RTbjN3QiswUTNqZmw2WUlEMFFx?=
 =?utf-8?B?OStCWldCdjZvbFN0aWFjZ1Y3K2FtUzZ5RFhIWjExQmFEcjl1YjE1UFd1MFlr?=
 =?utf-8?B?VGhRQ1BxcTcyNjEzVEJNcXhxOCtvT0dSMEZidzNWUDBCSmdMNEw0OENUQTN4?=
 =?utf-8?B?eldrajVKR0orWCtSN2pGM2xKRHppenFPc1ovRXRFUHdTUjh4UzhLQldENDVM?=
 =?utf-8?B?UU1mYm9JL2daTXY5WThIdjVWdi95R3ZUZHNFWjlxanFJekxWZ1FFVGtmOU5Z?=
 =?utf-8?B?SlRUd2hpbVhnQXd5aGU5eWIrd2QwamNuOTZxQ050NjI4MnE2MEpZenYwOVpI?=
 =?utf-8?B?OUtPaEc1S2lhV1VZWS9hb1hXK2x5eDVWSWgwZjlXZDJyZ0o3TUowclVRcXVV?=
 =?utf-8?B?Q2tQa0JhMldyOTRkUEU5OENmVUhOUHd4YjBWc3BSMXppdkVBdXErWkJJK2J1?=
 =?utf-8?B?NUwzUkZObjhZSHEwNW0xTSswbWVLWGdlMlBrZmJmYmpkWXJxNVZJQWN6WUh0?=
 =?utf-8?B?bG1Sek84RXBGeHJzamFJSEsyVUJSY1dpNVYyL3hVYTFCNjZiU3hvczl5QmZU?=
 =?utf-8?B?N2N4K1NFeXNkYVlPZDVGbEoyeEZuV01PQ1VtUFNRY2NTUSsxK1pNb2xhbEpw?=
 =?utf-8?B?RENCTHFGb2N2ZXBEY1ovT1JjWnh1RXVkeTRuRVNLMi9YWXlBQ1YrMEdpUk5r?=
 =?utf-8?B?RCtuMXRHNW8wOVcyM1hWdU1LY2RDa2Zzc1BRNW41UXIwK1VnUHdlRXlTWVA2?=
 =?utf-8?B?ZU9LdXhsRmRTZDMxd21xSDF5Z0Ryejd3dXVtdGJvandRU2tlRlJIWkpPOW1J?=
 =?utf-8?B?VXhVWldOcTEydC9jSmNUUUFFVFVMYUxVMnVreU5zT3BqcTU5SGpPNjFKdEhx?=
 =?utf-8?B?NVZuR0Evb2pKVVJKenlZdTN5bmFuS2wwTmljdTVaQlUxNHVzd0E4UVgvZUFX?=
 =?utf-8?B?Snk3V1FrSThWeFg0Mmp0VExwa2pnREhaRktqUFc4Rmc2RkdxOEwyN0Fnb2w5?=
 =?utf-8?B?cGJ3OWpVNVdNTER6dm9EQ0VPS05MOEJuQTA4dkhmdVpWdTdqakE3bDAvQnRU?=
 =?utf-8?B?bWRpMVplTmtCODhTZFlYYi8vUFV1SWRNU3l1OFRuUW9TK201cVZPMW1OZmhV?=
 =?utf-8?B?bXAwcGd2akphcDZoQ1RqU1lBaVJFcHNaZ3hnaGNLeWFpVlY0K2lURzJEb2F2?=
 =?utf-8?B?LzJTNlZlVk9LZTdNbjFRdkRvcmlVL3VLcG1FZzhnV0Z2M21VYUV6NUE1c28x?=
 =?utf-8?B?YW4vQWMwc2tIV1hORG93SUUzZkQxRFFJWmZCTmVEbDU0ZnpZSnFvUmVuZUp0?=
 =?utf-8?B?QSswUk01ZEhnZkE2aUVUWkYwQ01RQkQ4UHYwL3Byd1VJdStvVnlvdEM5ZVph?=
 =?utf-8?B?OE9OZ1NhdG5VbFFra2FiOEl1RTNtUkI0YWVRNll4TnY3QVRPa0M4bW5sbHFw?=
 =?utf-8?B?Qk9QS1NCdTlHTXBqWXBCeDBTblljSFE1YXp3Y3AwK1g4TjA3NXM1NmI5aVBZ?=
 =?utf-8?B?dlo3WlNWV1Q2WUt2TnZKd2R2YktCanBpL2xnbGFVZlluQWxDVlE1VDFTY2Qx?=
 =?utf-8?B?Q0R4OGdlTDlaYjA1MU9tMnVaRlNUOG5JM3hldEM1TjRmbjN5Rzh3T0ZHZWs1?=
 =?utf-8?B?K3N5RXZsWDZKbFNQeTdJSGJFRmVXTmZBOUVmTGpPQm1CcVJEdzl3TFJ2L0Q3?=
 =?utf-8?B?MG5aOFhpWk5uUytOY1dWamVYd1gxYzhMZ0ZmbmY5TXNNMnFZQmE4ZXEyMndu?=
 =?utf-8?B?MGRmUDl5M0RHZFBEOXphcjA1UnI0ZGh0QTZpVWcyWVUyUklseVhsREZ5Ti9N?=
 =?utf-8?Q?WNV46Wg4fTf11idmJ94SoS8sS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c283e91-9370-4254-47ad-08dd82fc2aad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:49:31.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIriHi3m9Vo3rUZhyqj67zXSzICLxDHZpN4KyWuJmoMAerN9kG0+9WqHehFpE6tMt2PGCGJSVUKMOXRI0u0EBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195

On 4/24/2025 9:11 AM, Lu Baolu wrote:
> The idxd driver attaches the default domain to a PASID of the device to
> perform kernel DMA using that PASID. The domain is attached to the
> device's PASID through iommu_attach_device_pasid(), which checks if the
> domain->owner matches the iommu_ops retrieved from the device. If they
> do not match, it returns a failure.
> 
>         if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>                 return -EINVAL;
> 
> The static identity domain implemented by the intel iommu driver doesn't
> specify the domain owner. Therefore, kernel DMA with PASID doesn't work
> for the idxd driver if the device translation mode is set to passthrough.
> 
> Generally the owner field of static domains are not set because they are
> already part of iommu ops. Add a helper domain_iommu_ops_compatible()
> that checks if a domain is compatible with the device's iommu ops. This
> helper explicitly allows the static blocked and identity domains associated
> with the device's iommu_ops to be considered compatible.
> 
> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>


Thanks! We have static identity domain in AMD driver as well. Some day we may
hit similar issue :-)

Patch looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

W/ this change may be I should fix AMD driver like below. (No need to respin
patch. I can send topup patch later).


diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index be8761bbef0f..247b8fcb3a92 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2626,7 +2626,6 @@ void amd_iommu_init_identity_domain(void)

 	domain->type = IOMMU_DOMAIN_IDENTITY;
 	domain->ops = &identity_domain_ops;
-	domain->owner = &amd_iommu_ops;

 	identity_domain.id = pdom_id_alloc();


-Vasant


