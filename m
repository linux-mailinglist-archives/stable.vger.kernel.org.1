Return-Path: <stable+bounces-127307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16BDA777E2
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F333A392E
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ADA1EEA27;
	Tue,  1 Apr 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XhWuSIZR"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1B18DF9D;
	Tue,  1 Apr 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500359; cv=fail; b=ie2UL9Xc3a1InWBV58lsvdJu/x7hvugbN1NJml2uF6Az8kJ6d6uvEX27eVno2rs0mb3iiSC60Kz5fGjmgTvT6eQ9RypqBJD++2L7mpwUzt7RtrT+JkG4DsQOWRkenqIhQH2/EROJIZB5//bKc8EBLq4omsqE+sQeMqCrPvKsa1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500359; c=relaxed/simple;
	bh=iqCC6ESbqXqGYqKfxZDb4OlH9nAhhiKUOSIr3bfpA0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ekJqxe/u2X/Djn3rd+q/tGe3MjgMyoIzxXfnJUcfDM8LfWJYv4IKRcaIIufyzdpJxpl3LKH0vQgdMLZ19uciO+71vpHuz9gbb7ttLQwXhWtdpYjLS4R3xhO+hxgJq9Gf1CL8HnNF3A5taxuWOeF+KG6DXrdHh9dTxz4JCf2ZlQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XhWuSIZR; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRbtIXZ+FUi53LFZ4P+gqne3ki9IZwZ0Qn1ZkN+UBRJg8j7GvcHO7TxVJEBay5cwO8WFzK/XBPB3WKqD5rU0Cn+JwZ2ooeYwXVAa6Y9hkH0sxtpavfGYvjf5X5sadknTpdYrGPxJMuC+P1CFv+oteJGr3qp48gVduMhv8Ri8tjvdshUxQQE6f4o7fHVU9lD9GtYH2aB6YcZxUrX4F4QgVRNhgXz9FDjf2954yJ8eEpUhdJ/eEqiuqIFJeaBxO0QHMpVeapV5OvdAjP5kCzWBjicVc0K16ivF0sbKccx0UtqYfwo6yO90e9IPa0KUmDNGUvcFg5sl0mkpsmzb2dXuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87H01Q7nCNYyfjZhlmlnyp2OrwQxYwD9n9QkrdGzEuw=;
 b=AoZ3pMUML3wFXdYBgAOjjTglX5tI6fNu0m8poqDNnXKhn73VVOiArbU2H7Yw/87inHWri4/nXcGBycIdPi5WPIgOY2CyJaWiXkm98HcOEsz1FRZAhe/HmKxGOlR88fD82MZw95ccX3Je6R2yU/lE+l6FaZaTzWyGP8gStW4BPSGW8odfgsEnW/ez/v4PeeX5LH1EZh/W+Y6mTFHDaWoxaZRMeTjkmWCahDGz6PaHdOa/vTxNLwCc+BW0nJjI+eU3vvs1szdHLiFRhmsy82e4B3vpOfKwxUL7FkfhXxqsZ3j3Gu+VbXWedCcQffjsBmzdmtnR8EotsVeCtLMnI4CVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87H01Q7nCNYyfjZhlmlnyp2OrwQxYwD9n9QkrdGzEuw=;
 b=XhWuSIZRWsDF1GBFcu+3YFxPPnFJTuJgEGj2uIl4p/BUPhChDyHyAtnz0XU3nvFbzyiilTnIFYSFO/C+B+kfyPfpuWOiQv1jd4DeBBTfigxL5HYIdq7x+w2JsGHK3hKvXRd1wnjNzkVqfWZPUc27+dqi8rFFaxsyZFveruSH6rkTYm08LnmF1J/W1oR0NNF2KeyGO9XlVFJY4bFuedAcKCOj5w05HLhybemodQTlR8zPZsd7XBdleyhFEbeUpoCBXpCx3ZeHhkn2+FLeyi7jtgsSW5QYk8eN8Ps0VSmX+thCovhcYxI/P0TFVXTVINPHD4OzNhPT65CToU+Oir9DLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 09:39:13 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 09:39:12 +0000
Message-ID: <a713c180-60fa-43f5-9ffa-5c348c8d538f@nvidia.com>
Date: Tue, 1 Apr 2025 10:39:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power
 state tracking
To: Wayne Chang <waynec@nvidia.com>, thierry.reding@gmail.com,
 jckuo@nvidia.com, vkoul@kernel.org, kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250401091143.2621353-1-waynec@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250401091143.2621353-1-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0119.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd39b89-333e-4402-d1f1-08dd71010f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TStaQmh2NWhQYnFCRmNrQTV1aDBDWnhLeld6YnU3cmV4N1JHekhLdW9HNlFV?=
 =?utf-8?B?QnFMZVA4WmpCOXVCUzl0bUtJY1g1ckFiYnJwdkdCcEZISEI4bktmaWRWYzJv?=
 =?utf-8?B?NUQxRzhydUJjNEx0TUVWaXJMcnFKazdGc2Nscmtwc1gyR1gzeXF0dmhqWFhP?=
 =?utf-8?B?RlVWNUFqRS95VVl1bzJ1RTNha3JtTFB4TnpqclNTMkhaWktSTUtFVEQ0S2NL?=
 =?utf-8?B?TXlkc1VVOUtnazNXYTRaZ2dCVjZNeG5zUTdDK2o2TWZSNmZOSURaeFZDaUk4?=
 =?utf-8?B?SmsvM1Z0MytzU2FnVjVhNHhxbkxxVE9IcW5NcmxqQlJ0QjlnS0U0SDRPQzVY?=
 =?utf-8?B?ZDcrMlVOMFVrSzRWbzlyMTZXNHAydEQ1SHFCMHorNWRUSkF4UjJic2Zrckti?=
 =?utf-8?B?aFR0bGZXY29DUXBrU2RLR29ZQVZwWHkra2Nmb1RQbFVEbVdIMTVJZi9vS0VN?=
 =?utf-8?B?OXpCd2NiVUFmdEVWa1l3R0R3Qnh5eElURW93VHdVc1lVeTNmbVg3M29GTWQw?=
 =?utf-8?B?Z2k4NENDWHpiQzJlcDJ1MkFGTjZDTmNwbThoQjV2d3J4VUltNTlyay9QMkRq?=
 =?utf-8?B?SFNDaCtXWDhJb1pzRTFtYnZtRE8reWtuN25jLzd1MWJlaUNPRkhWTVllSE1N?=
 =?utf-8?B?ZjNPNTBueHFzNlFSVUxudDJvSExwRFNaV0tJSmRQTTlXRm1UdUZuRC9lbHk1?=
 =?utf-8?B?dkwzK3UrUlZ2L2pydmNDVE5aM0JPNEhqNk80bFdXZGlvOUIreE5Ucm1hTmsw?=
 =?utf-8?B?NkhibmFIUFZIQjNBdThZSkV6a2xoclhEY0RiaHRtTFdRK0JWYVloK3dOakh6?=
 =?utf-8?B?SmE3ei9zR3orSHN4dVAwc1JnbkVTMUYwTi9sVFhTc09OZ1gxcmV0VU9KcTFL?=
 =?utf-8?B?Skg5VDRJNmtJT3hsVVkrWEVlQ2ZBeEJJNlBsWjBwZ0ttdnFIbVFaQkZiVzhN?=
 =?utf-8?B?VFV4TVhoaWpOTVFrVXJpenRnT0ZOeUo0VjJBREkxeGkrTU85a0VHWFAvNDRq?=
 =?utf-8?B?K3kxNlp2UC9EN0FzN2cyK1dRVWVyVnFoNWJtYnJiWXdUQzlHVTI0eENhUGI2?=
 =?utf-8?B?UExDVk1CQzlDRGdrL0tScnBoL25jSXplV1UwUUNjbHc0YjM1WXFhN3pVT21X?=
 =?utf-8?B?V2oyNnJkZkF5RzgxM21scEZqU1VLS04xUTJ0WGF2WCtvZmkyc29kb3lIbklx?=
 =?utf-8?B?MFR6cytBaEtuclpzZmwzemdoQWRFM1FHQnZ6RjJzRDk2YlR0dFRsclM0RHVC?=
 =?utf-8?B?SlY0VjRMZTQ4MGZTUDJHOFN5cENVSVFvSGZvc2lwVWlLZEtPeWJKcUJKUFJ2?=
 =?utf-8?B?anVRY1RzLy9lR0pZaVorRS90Y1luUzJORjhJakF2MnRMVXErUGV4TEpVQm1k?=
 =?utf-8?B?ckJqenhqYWl3UXozZnEzRTgrUzlRelkvTUR5YWx5bW1FWmxHeEFoQktiZXFM?=
 =?utf-8?B?Z25VenE3aW1COTRwR3Zxc21MbXZPb3hTYVJSZFVuVkJJcG1PWHJaek1oUkRF?=
 =?utf-8?B?Znc3VU9ENG5xNWxEMTBaOXJGZ1E1aDFFSFJzeW5MSGRlU2NJaHRYT3JEd3ph?=
 =?utf-8?B?ZVRJTGlwQmRCL3U1RURuS3BabmxNcS8zd1d4dDcvMXBUNWJ4MG1IaXFqeUpI?=
 =?utf-8?B?NW5vcWZGVE1udHBEcG4venBYM0xyRzNSWWhnSW1LOFlkS2RadTdoUDh1YzRE?=
 =?utf-8?B?UU82bnE0TFA0aVdVcmc3Qk5nczZ1dnJac0JlVmhaRmVNQ1djTzQ4dXF2bGRo?=
 =?utf-8?B?U2dwRS9TZG00QU1xL2dTSFdvWlB2dTBCN0ZjY2dLcTFhMEFoVUVjQkh0b2JK?=
 =?utf-8?B?Nm1uZzAySlU0S3F4aUNBakNRY2p6R3dSd0lBbWVxYnA3V25yUTU4QnRqU0s5?=
 =?utf-8?Q?AonzpO5ZqlMxd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3JwOFpJKytScW1waU1td3BCMXF3cjJxeXRaUEtlemNlNW5lTTJUYlQ4Yy84?=
 =?utf-8?B?eXRCeElNNi9OQ3lFRFpMWEJCMkRDeHRTb3NIMjAyUHNucWp0eGlUcU9aNHF0?=
 =?utf-8?B?bGRheUpNME5uelFORExKVzhmRWg3RDNxZHp6SXNpdkJZVWVESm51RkZYbFN0?=
 =?utf-8?B?dzFUUW0xYmFtUnRmdGUzanZNcGpGNjMxUHRUMDFuaVFGaGlDcXgvZDF3OXhj?=
 =?utf-8?B?dVdtQXVSMEdEeUoyS2lSOHVSd3dkemFlVmxNakJ1VXdpUkhDSTZ0N29JdlZx?=
 =?utf-8?B?eWJaQTErdjhBenZnWlFNUFY0Z3AyQkl2TG9Qc1Z2dG9lQjR0N1I1VXp0MEoy?=
 =?utf-8?B?NjZKWkdLcHl3L0FFaGpnNmU4LzA5d2ZMQ3Y5cWRZY20xaUQ0eUYvMTU0R0lr?=
 =?utf-8?B?NXUwaFBFZ2habm9pRjRDN0lMekJTTndZdmpmYmNFYzVBZzhlRXpEbHdBZmRt?=
 =?utf-8?B?QkF4S1BUZGRoOHN1R0lyV29SdG10S3BuV08wb3VqREhjQUNhMFJMcUptZTJR?=
 =?utf-8?B?dGMvczJXTjNqZC84eTVQQ0hhYzYrN09MWHpvWUFRL2E3Witjb2lnRTFGV1Ir?=
 =?utf-8?B?bmJvWXUwNmYyN0VGeFlPdERJL1d3VGVmMFNCOEIyYjA4RDVuVXdxQTBNSlBs?=
 =?utf-8?B?NU5jNFZINlYxdUR6L0dkZEJ2WFdHVFF6ZEltaGhjYUJ6QmozeCtGSFlwQUpJ?=
 =?utf-8?B?emw0NjZOWDVXOUVjQnd6MW9kUWhUZjROVTI4cUxVWklNTW5XVWJrV284eUkw?=
 =?utf-8?B?TGRrb2kxTnJaTWtlQThtMk1FYVVERFJkSk1MWlF5MjBBbWdMVHpHUm1EdXJo?=
 =?utf-8?B?VDg5ZE5tY0dVaWtUVXlCdjM1YmhmLzRQY3VFRzlDb2djb2d6RFRMdEFDQkhL?=
 =?utf-8?B?ZEx5cDFQRDhDcVgvMzVVaythRXRpcDJTM0xia3Y1cFA0MHlVeDNKNnlmMncw?=
 =?utf-8?B?M1Q5cnZiaXBPYkxrT0Q5T1hlTXU0Q29FZjJWeW94ZEl5ZWttem05SHdDdXZm?=
 =?utf-8?B?Mjd4WVM2cS8yM2ZSZGZSb1Q3c254WjhMWlFxY1VVTHhwQnVSbDRVTUU3dGZT?=
 =?utf-8?B?QTMzVUNPSjRxVm44dG90cWtDMjFuczltbThuU3A2SUV2V2xsN1pVZk52cXE5?=
 =?utf-8?B?S3h2eTF6UjF4UUM3ZEk0WVE1UFIveFA0R3FrSHV0eCtVdGVzUkRoWjJMY1ow?=
 =?utf-8?B?bEJZV0E4cXZJZHpCR3ZXVzFmTFpOcE95dXFOMWNYVHBGSFRidnBNQzJiNXRu?=
 =?utf-8?B?dFZRODQ2RVNXVjFWdXFveUYvQlpXb1lvdWZsUjlxMXF4emRnSXppWkJpUVdw?=
 =?utf-8?B?M0szamEya3NzRUlhMmtHeVVkenVpM1BJdDloelZFaE8ySURKZU01bEdDQkc0?=
 =?utf-8?B?OTlOSmluVjhrYWxmWjg1Um9NMUZGK3Y0OHAvdHZhSDBxa1RpTVA4ZTJGZHhz?=
 =?utf-8?B?bXUxR25abHVjemhUYXU5VjhVTzVIZnM2bU1tS053TWdNMm1xYXdGNC9GdVgv?=
 =?utf-8?B?QmxnVWFjNUxjYmlCTHVuQUZ1YVBVdWFONjd1S3RuWGFpYzdMempkYjFBSUpM?=
 =?utf-8?B?TjJONTVETWllU2xna05qbnBOcEVGSEtsdkNZL0Zza0RwVlMzazlxTS9mdFQ0?=
 =?utf-8?B?SVdxcUtCMzJNbGF4UTNxMXk5RUhtaTlGVGtSRUVMRzAxMTRkeWpRZGFhb3Qr?=
 =?utf-8?B?MVliUkROOEphTXNCSW8wMjRLZURkdVFUWHJhb090SzZQazRsY3hDdHN5YUgr?=
 =?utf-8?B?eFRPR0VFdXd5UG12LzkrNTJmUU44NUxpNG45NnlyUC8xVzJEem9tL0txRFdF?=
 =?utf-8?B?RHlwRDF5OVJzTk01SG54U0VVdU4vSlJJY2tWNEdkT1NGd3NuOHg1NG9QTSto?=
 =?utf-8?B?RkNlVU9HcFVPOENIa0k5M0dlSUJ1Rlh0cUhCSlZuRFM5a0h6N1NBaXJtV01P?=
 =?utf-8?B?L0RrbTMra3I5c05idFM2R3l0WldWMGthZGJpVmR1V0NjcUZmK0pVTExkb2FL?=
 =?utf-8?B?VURiTW1CMnZiaFhOV1lESC9aYVhMY0pEL0RGa1FNcEl1V2YrREdTTjZXdUFO?=
 =?utf-8?B?bGREamgzV1BHMVkvRHI5dU4zMi9lbGV1djNYQ0t2K0ZLK3o1eGk4WFdHdWFk?=
 =?utf-8?B?bDNaSCtUa3dtUHpzY29ZKzJLQldXSnZIK2EzYXFUSjQxdlJPeWJuWC9BMVkz?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd39b89-333e-4402-d1f1-08dd71010f9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 09:39:12.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4utR35UptXxtFcT7Lr/J7oRw1/cJSn8feqfLc0e8ACkf6aC/+nb3PxwWaVzYFLZ1oW+of4WvIxcvQ+WDq1nLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619

Hi Wayne,

On 01/04/2025 10:11, Wayne Chang wrote:
> The current implementation uses bias_pad_enable as a reference count to
> manage the shared bias pad for all UTMI PHYs. However, during system
> suspension with connected USB devices, multiple power-down requests for
> the UTMI pad result in a mismatch in the reference count, which in turn
> produces warnings such as:
> 
> [  237.762967] WARNING: CPU: 10 PID: 1618 at tegra186_utmi_pad_power_down+0x160/0x170
> [  237.763103] Call trace:
> [  237.763104]  tegra186_utmi_pad_power_down+0x160/0x170
> [  237.763107]  tegra186_utmi_phy_power_off+0x10/0x30
> [  237.763110]  phy_power_off+0x48/0x100
> [  237.763113]  tegra_xusb_enter_elpg+0x204/0x500
> [  237.763119]  tegra_xusb_suspend+0x48/0x140
> [  237.763122]  platform_pm_suspend+0x2c/0xb0
> [  237.763125]  dpm_run_callback.isra.0+0x20/0xa0
> [  237.763127]  __device_suspend+0x118/0x330
> [  237.763129]  dpm_suspend+0x10c/0x1f0
> [  237.763130]  dpm_suspend_start+0x88/0xb0
> [  237.763132]  suspend_devices_and_enter+0x120/0x500
> [  237.763135]  pm_suspend+0x1ec/0x270
> 
> The root cause was traced back to the dynamic power-down changes
> introduced in commit a30951d31b25 ("xhci: tegra: USB2 pad power controls"),
> where the UTMI pad was being powered down without verifying its current
> state. This unbalanced behavior led to discrepancies in the reference
> count.
> 
> To rectify this issue, this patch replaces the single reference counter
> with a bitmask, renamed to utmi_pad_enabled. Each bit in the mask
> corresponds to one of the four USB2 PHYs, allowing us to track each pad's
> enablement status individually.
> 
> With this change:
>    - The bias pad is powered on only when the mask is clear.
>    - Each UTMI pad is powered on or down based on its corresponding bit
>      in the mask, preventing redundant operations.
>    - The overall power state of the shared bias pad is maintained
>      correctly during suspend/resume cycles.

It might be worth mentioning here that ...

"- The mutex used to prevent races when the UTMI pads are enabled/
    disabled is moved from the tegra186_utmi_bias_pad_power_on/off
    functions to the parent functions tegra186_utmi_pad_power_on/down to
    ensure that are no races when updating the bitmask."

> 
> Cc: stable@vger.kernel.org
> Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
> V1 -> V2: holding the padctl->lock to protect shared bitmask

I see you mentioned it here, but the changelog should also indicate that 
this has changed.

>   drivers/phy/tegra/xusb-tegra186.c | 44 +++++++++++++++++++------------
>   1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
> index fae6242aa730..cc7b8a6a999f 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -237,6 +237,8 @@
>   #define   DATA0_VAL_PD				BIT(1)
>   #define   USE_XUSB_AO				BIT(4)
>   
> +#define TEGRA_UTMI_PAD_MAX 4
> +
>   #define TEGRA186_LANE(_name, _offset, _shift, _mask, _type)		\
>   	{								\
>   		.name = _name,						\
> @@ -269,7 +271,7 @@ struct tegra186_xusb_padctl {
>   
>   	/* UTMI bias and tracking */
>   	struct clk *usb2_trk_clk;
> -	unsigned int bias_pad_enable;
> +	DECLARE_BITMAP(utmi_pad_enabled, TEGRA_UTMI_PAD_MAX);
>   
>   	/* padctl context */
>   	struct tegra186_xusb_padctl_context context;
> @@ -603,12 +605,8 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
>   	u32 value;
>   	int err;
>   
> -	mutex_lock(&padctl->lock);
> -
> -	if (priv->bias_pad_enable++ > 0) {
> -		mutex_unlock(&padctl->lock);
> +	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX))
>   		return;
> -	}
>   
>   	err = clk_prepare_enable(priv->usb2_trk_clk);
>   	if (err < 0)
> @@ -667,17 +665,8 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
>   	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
>   	u32 value;
>   
> -	mutex_lock(&padctl->lock);
> -
> -	if (WARN_ON(priv->bias_pad_enable == 0)) {
> -		mutex_unlock(&padctl->lock);
> -		return;
> -	}
> -
> -	if (--priv->bias_pad_enable > 0) {
> -		mutex_unlock(&padctl->lock);
> +	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX))
>   		return;
> -	}
>   
>   	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
>   	value |= USB2_PD_TRK;
> @@ -690,13 +679,13 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
>   		clk_disable_unprepare(priv->usb2_trk_clk);
>   	}
>   
> -	mutex_unlock(&padctl->lock);
>   }
>   
>   static void tegra186_utmi_pad_power_on(struct phy *phy)
>   {
>   	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>   	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> +	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
>   	struct tegra_xusb_usb2_port *port;
>   	struct device *dev = padctl->dev;
>   	unsigned int index = lane->index;
> @@ -705,9 +694,16 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
>   	if (!phy)
>   		return;
>   
> +	mutex_lock(&padctl->lock);
> +	if (test_bit(index, priv->utmi_pad_enabled)) {
> +		mutex_unlock(&padctl->lock);
> +		return;
> +	}
> +
>   	port = tegra_xusb_find_usb2_port(padctl, index);
>   	if (!port) {
>   		dev_err(dev, "no port found for USB2 lane %u\n", index);
> +		mutex_unlock(&padctl->lock);
>   		return;
>   	}
>   
> @@ -724,18 +720,28 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
>   	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>   	value &= ~USB2_OTG_PD_DR;
>   	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> +
> +	set_bit(index, priv->utmi_pad_enabled);
> +	mutex_unlock(&padctl->lock);
>   }
>   
>   static void tegra186_utmi_pad_power_down(struct phy *phy)
>   {
>   	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>   	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> +	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
>   	unsigned int index = lane->index;
>   	u32 value;
>   
>   	if (!phy)
>   		return;
>   
> +	mutex_lock(&padctl->lock);
> +	if (!test_bit(index, priv->utmi_pad_enabled)) {
> +		mutex_unlock(&padctl->lock);
> +		return;
> +	}
> +
>   	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
>   
>   	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> @@ -748,7 +754,11 @@ static void tegra186_utmi_pad_power_down(struct phy *phy)
>   
>   	udelay(2);
>   
> +	clear_bit(index, priv->utmi_pad_enabled);
> +
>   	tegra186_utmi_bias_pad_power_off(padctl);
> +


It seems more natural to clear the bitmask after disabling the bias 
power. I guess this is protected by the mutex and so should not matter.

Jon

-- 
nvpublic


