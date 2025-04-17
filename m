Return-Path: <stable+bounces-132927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EDCA9167B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66D3190797B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27209215063;
	Thu, 17 Apr 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OYV/apCy"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5033FD;
	Thu, 17 Apr 2025 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878772; cv=fail; b=bvN7/J9tq7Rx2y8tvQHL5M5uMeIK3Azw+M2nxMbIkRmzRgdXRVrZ5HEj931Y0k7f6nheAB4niRtci1y14bcvZTJ83ESVk0u/9tFSUxJZoN7Zb4qvaQElvqKY7SCnjOmWVTTGpbAU+aD+8Cb8ugfPnupDk5GJqmwY95hUkDhg6MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878772; c=relaxed/simple;
	bh=cQNsedbntn0NiOM4Tpc5dvvD8jHi2errfshDEtdJawg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H56Di23SzExU4dZ1iW4WB6nUyeBPqeVmQagqa8qEa+SaHTxD4wS6EkqO2Qr6/njBEn7d4CDJVmMxdWdyWAQJ31Q/umwhRDs91vUbQt8Z3oJS+AICaZAZnB3bCU7c5ZMWP7bJEnNAr4z1UsdSkOsT/+33vPIm346ySvCVE8CU7PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OYV/apCy; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaSLlexJ+w9AisrlCaiN70+cwWnTv0QQ+J1gLjX16FC9UeTQNXdpeY35hTVkfg68RN5vEk1xh3epoI1R0HDzxxd+DTb6msYlaDv/2fCXKRo8fIfoEwJWCNvK5hwLPZJs6MrQuI+HoGSPvN+kCxPFK5ug8ewURgUfp6FCEFsHj4XrEvkzzwinOJywzomdXNJfSJXgIsLKth8XNJQn2qmaduzo+pgASToNF+ksF8s0wqesAKmLjqPzHJSdMCb2j2PcJekkFS1N28wR6yqr0ewjMqOFdzyv9Tq7sdu6+zGtGRB73vRd+xHDz1acGD4AuFIfdcIfKfr4PW0Es9R3xQJDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeZBslf/tYLW8QMtgUvw7y06J8b6jGGbAznqp6J/kWo=;
 b=qYplFAkTQF/8t1MMSD0A2rFjgvnEcG9ZPlha/hz9X5WvsEcRvRUWE0YdzK/T/jJuxD6KisuYSHSDDRbXy3cJrtU593YT6tyo6lLCYTrTQ8Bx9gn6ynRfG+x/zIJ/ZyE5r+52FMhy27mM0oe7SiMFTpK7U7lhK9Re/mh5P+E31k9EZPfbBh7u5tNIWoeyWW+fK3gPTRZBPXyrLFx6lKg8NNsI30hIWOO00yrWr9xbzxi/6i2mrfRAuPQ/l/hdpFBE2+6KHi3vJ75LmJ3ulwWIEUpRNxPCH0XvAOB8C2upNZjHZgyD6AKwueZ5tP33mNSCd2IOr7WI734NQm6870L71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeZBslf/tYLW8QMtgUvw7y06J8b6jGGbAznqp6J/kWo=;
 b=OYV/apCy7gXJuuWeipZ3GLpDYAjPKWlQo46ghkUPULYjCxDoFjyGsACIZKms8vEcxNYQZdl6l4W77Xo5wQwc+y5QZCKFjyEcPYfjbK4jb20vyrC7ZAOCg67JxprAZ6YoPqLJRyGsKp+If7aI9YE0RNwN4+gYy171C9iZ2IPpXCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 08:32:46 +0000
Received: from CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216]) by CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216%6]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 08:32:46 +0000
Message-ID: <7f8adf40-af34-4140-a01f-caf255b51306@amd.com>
Date: Thu, 17 Apr 2025 14:02:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] amd-xgbe: Fix data loss when RX checksum
 offloading is disabled
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250414120228.182190-1-Vishal.Badole@amd.com>
 <20250414120228.182190-2-Vishal.Badole@amd.com>
 <22ddcfd9-d3b8-204b-6ada-7f519143a261@amd.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <22ddcfd9-d3b8-204b-6ada-7f519143a261@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::17) To CH3PR12MB7523.namprd12.prod.outlook.com
 (2603:10b6:610:148::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7523:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f0959c-579d-4237-d1ce-08dd7d8a6dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTVyQ3NPWmhSUVc2SzRoWlpOMGo1dmdrSEVncWRsT3RDWWtnSnR5b2NxRFR3?=
 =?utf-8?B?dVJOY0MxdFJROTZZQmNPQmx3TzBpeldWSlEvdTBoMWlHbThBLzhOWmZIZWJE?=
 =?utf-8?B?Qy94a3JxRFFMR2p1YUYrQXpzUHc3bERLQzl3dE01SHFqV3BnVFlac05sY2Q3?=
 =?utf-8?B?RFM1UnBpR08xUTlQa0p2ZEJ3YmFFbUgwcVBnajRsVUtHdjh5K0plSlRFRXp6?=
 =?utf-8?B?aWxwUDBBL0xDdHBhSzFzdzFzR25OSnpXMy9JOVBoZ1lQY0lRbVhocnFycWY2?=
 =?utf-8?B?L0NrOHR4WEtNRnFIb3FnZUpxUVkzSS9Nd25KdUtMLzNGbGg2OW1QV2JFbExV?=
 =?utf-8?B?YXd1K2VObHFWYkdOS2VvNWhuQXR1VHVSWGVJSTlaTWNTN1RkWDRWZC94T2dI?=
 =?utf-8?B?cmJxaVVIK05vVUY5citFWVZYMmRnbVBESHJNRWQ2N3VwakVpSEo4TmpIVFdX?=
 =?utf-8?B?ajVtc1V3SmVZYjJVUS9IbGgwYXhNTVZZNkNTNWVYaXpPdlgwTHhpWEt1UENV?=
 =?utf-8?B?WEhuN2VNdHZJR0pSYjVWTWJRUjlUMmp2TFpEcWw4VmJuemRNQUtLSFcrczRB?=
 =?utf-8?B?YzlHMlFEMDNtelExMWhVY0ltVy9JUzJSY2FWWUs2YythbERHN1dlZUZhUjBE?=
 =?utf-8?B?M0xRWXphcVI0eVV2dDY2TnVjZTNVR2J4SDRPSVJCYXgzUlVUQ0lDM0ZhMmVu?=
 =?utf-8?B?QTlSbTFPZHJyQS9tSWEvMnBmcWZLY2lYZXl6US9OaTJ5VFJZeXZOZTVqbXJM?=
 =?utf-8?B?VFRpb0t5ZE5BVFhWaE9pREllZUJTYmI0RUVad1EvY0tXbjlLcDl5N05uRzJk?=
 =?utf-8?B?VXQ1ODg2REk0SE1PRFV6SDB1MURsU094RUxhU1VHeWdFUWMzblVDR1lkNCtT?=
 =?utf-8?B?RG9ZOU9vMGZKclRCV0hqdWtjYWsxWXlyY2E2MHp2RnEwenNxQzBrNDRqNVBI?=
 =?utf-8?B?cWEzMVhKVjk1NHhOUW9NK3ZMYVNXdk54bHdtVEtOY3ZHQ0hINFhZRTNOM3l1?=
 =?utf-8?B?TUtXYmZkc2pNNlJqOWpuRGpXU2NCS0xZamk0Umd4L0tYaUhpTjUxY0JRMFl5?=
 =?utf-8?B?ZHJ3NjF2VEpDWUZ2OVpLTUV3V3Z1RzFYMmgzOXYzRW9aMHduNURPdmZpM0Fq?=
 =?utf-8?B?Yk50YjFhWEptajJISEtINFdNWm9LaHpjUFdXVEdOZU5DK3RkSEUwRDkrWmh3?=
 =?utf-8?B?VjdCZFZleFVYdWc1enU1dTVWRm5MNVRUSzZOTHBhTFE3M1NtN2pRVGdDVEhL?=
 =?utf-8?B?aWJzMGp5RHdsaGtRSmU3OVVEaWpzQ1NuT3Z1VmRXeTFqdUR0ZUFFc29rYjl5?=
 =?utf-8?B?c1R1RGFEeEZqWVJsd3FpT3R2ODdqZnlhVWNCY1A3czhNcmdlam9lRlpvQ1ha?=
 =?utf-8?B?TDB6Y2F0cVNPaFM2TVJtWnBpaFNZa1VzRklYTE0xcTZQYTRYaEtrVzhRQ3M5?=
 =?utf-8?B?Y0k2TVk3dzBmN0IvVWRKWjcwbUVQTXZtZFdmbWpyUUtMVTExdUM4QkdzTFVi?=
 =?utf-8?B?d2xBYW1WYkI3eUZ4WmRGczdsSlVZeklMMnExQ0NrQkdNMDlCeEIrWU8xam10?=
 =?utf-8?B?bXoyaGRrMVErS0dYL015RHV4Z2cydS9mWmNBbWx2WGY4K2hKM3hMWUd6aUUx?=
 =?utf-8?B?MWliUUJZaFMreG42WFJMN3hGWFRsMk01ellFR3dEcmdrdGJaUU9RdTdUeFFI?=
 =?utf-8?B?ak9IcmdDMmQwQ1lhSHFTbnNLa2tyZlFGQm1GOU9RK1lQdEZabStSZW5PdUpB?=
 =?utf-8?B?ZWNKVkswYjhWN1hWVCtjWmdNSk02UStabmF6aEFEanQyRy9jMFVpTGgrNkFw?=
 =?utf-8?B?YlM3M2cvL1lrTTJ4WVp4cWJNT2RaUmltdnU5S29ZTktIOWU1MlIzbkprd2Jk?=
 =?utf-8?B?WVMzR2tJTFVaeFpCeGFnTndHZG5BZkxqMVQ0bFFPbFFLaUVjNzZTVG5pUGd3?=
 =?utf-8?B?UHhaNmRLMmt3L2VMWTl6dGpBSGladmtHaVpMMWRoNlpQejRwSGVTMWZHZWIy?=
 =?utf-8?B?dm9kMVdvTmpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7523.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0ZCZk9KeGRoMng5cCttQmJ4SXZoc1VyRXo0Vk9vb01PakFyY3V0eWdyclFB?=
 =?utf-8?B?a25aeGwyVmlDZDlZYnFQYXNhRU1pV2x6cENXRERkQTYwMFFzMkppV0w3Tm5s?=
 =?utf-8?B?amc2VisxMG0xcDJZWGFJMHB4TkE4cmpmbVBhVVJHcVVoK3luSklPUUdIbXox?=
 =?utf-8?B?OVViRjlzL2tiTUZRZkdqVFNRWEVWVHIyUW4ydkIzWXJDTUxIaXpvaEFnekxx?=
 =?utf-8?B?SGFnektuR3VPcnFoN2ZpMXdQTGRac1ovWEZXaEpIbzBhRVFUaU11eDJoTVk0?=
 =?utf-8?B?cWl5eWU4QUVwUXpEazNhT09UaUZGOE80bVgxRzNZb1g3d3lYMGRHR25CNjJ5?=
 =?utf-8?B?OXVZaGRYby9WZXl0TFFwRXBSZ0tKNFFsWmFNanBnSGJoOUprWjBtRFZGM1M4?=
 =?utf-8?B?UUlNUEV4NVAwY2hKS3pyUjI5Vy82RHhVQTlJS1JoemVSWlJjWXNsc1NPWjlX?=
 =?utf-8?B?RExtRFBTRllQTTlwOGcxK1lqeExOWGhydGhyb3ZjUFlDY0ZqaUN0RHpFdUE5?=
 =?utf-8?B?Y0hNRVdxVDNodkduZS9KMjZSbUZmUTRpejBqRnY4R3VQOFp0elgxZFh4RDFr?=
 =?utf-8?B?ZkljRldmQXI4ZndsMU42V2kxeDZkRG1Gazh2cE0zSzdWUlhJcS9YSHdyWE5p?=
 =?utf-8?B?VFNiZ2pqeWZVbmMzRS9pUnh5bExDOXAzdWFOQkUwa2x4UUxhc1lwYWhJMGsr?=
 =?utf-8?B?WEVMSDN5NjdMZ3BSOHdQVy91VDB5QzYzRXFKTVRIT3d4bjUwU0lOc1E5eEFD?=
 =?utf-8?B?MW0zbWRYTEFHUkpMeUNML3pxQldwSGJTb1VrV05YejlnUEF0UHVCWlNWdVhP?=
 =?utf-8?B?amRFTGpmREd2NmN3Q1JiRkNKMjFxeExjSXA3NmgwWjZaalBuYWdyS0d2cVJz?=
 =?utf-8?B?cVVQZHFQTlI4NCt5TGlDWjdHQUczOXd2VjFmWGszSERQRW1qcFBxTUgvNWxQ?=
 =?utf-8?B?TDU3a2tvMFBXYWtpem54anVCWjVTVUx1ZEFVSmI2K1hBa2VONmlxNk4zRzVl?=
 =?utf-8?B?d2hIeGN4SVdSUWpHTHh1eTZkMHV0Y3VyWStmUnlvWVVUUGRObDkrMkpEKzBV?=
 =?utf-8?B?Q3ZYK0xmcUtmejNxQ0h1dXJjZ1BNeFJZUWE1LzZXcUt1RmhVZGs4eXdwRDVy?=
 =?utf-8?B?dHpGMDJNM0lhNkV3dW8vWmkyREdkOVg1Mkk1YWRjRG5FNWFHZnd6cjhiODho?=
 =?utf-8?B?anV4NVhHMkR1ZGN5eHVMdUxzeGRlUEsrVkZ5ZEFib2dtYmNQOTNXZnBjakF1?=
 =?utf-8?B?ejdiam1TQ3ZEdkY3UDdEMG8vLzVpRUpRemh4MEdoNCs1bDY1RlFITkdVY0tG?=
 =?utf-8?B?QmRzdnRRaUd5djVHdm4wT0lheXdzL1Y0RnRldFBhRFoxc0pEUjBlSVZRVmRG?=
 =?utf-8?B?SXNOdG5kbmNmR2ljUjN1a0lMcG5KTEFBbVI2MzQ1clZwajJLTklUbE0rcTZO?=
 =?utf-8?B?RFNMUFNMdEZ3My9UOExHVUNHVTl0TW5iRFdvTGRubVJGVkVXWGkwRHJwWEZ6?=
 =?utf-8?B?N2tkZTVsSE1CTVZVOXorYkxiMUVUa3BWcjhjTTFtb1RyMkl3RmpQeVJXU1Bl?=
 =?utf-8?B?UGFIbEVJUUhUbDY3Mmg5SHRkK0hwV2xRUnZsb1dVdFdxTkh1ZzhxNGlvdjlF?=
 =?utf-8?B?cnRNSlQ2TDJuZE9SYVRtajJ5RlZlc0syanpZeGdYd3o5KzhlMDhWa2tPNFJF?=
 =?utf-8?B?L2N0ZnhqV01lS09SUkorVzI0TEJwNUJZcTFPR3cvTlBta1c1aTVYdlZ3Smgy?=
 =?utf-8?B?NThjb3MvbSt3YSsvTldMc1dpLzBSZ083OHVXdUtaZHpsK3A4SGtta1dZNStz?=
 =?utf-8?B?SGJUTW82RlAxRC93UWpQU3Q3b1Q5ZnZVOTRwUDBHYm91aW5DcU5lWHcyb1R3?=
 =?utf-8?B?dDRzQ0ROdllscXNxblZ2ZlBEbFJNVHBpYnRFSFJpakh2aGJNLzRIMXNNcG5v?=
 =?utf-8?B?NW5QbHZ6UVRaMnZ5Y0grU00vamVvVHZxNTZXUGtDZTN1emg5OXVQRWFqR1hy?=
 =?utf-8?B?NWVJOFp4S3V5a1I2VkU0WU0vcEVQQWc2TjJheHFJZUp2UDhZOWNVYTNNMll0?=
 =?utf-8?B?dmpLVVZDb1l2WTEwM0RqRCtFYnNGdGt0VFhmakpoS2N6d2RYUVdIWWRrZEdV?=
 =?utf-8?Q?fq24NNgnbpG0+Dztgqf90+pQ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f0959c-579d-4237-d1ce-08dd7d8a6dcc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:32:46.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db/I1hHGRqgdEZZDwPw1USFJcmuDDV+eRaZ55fvJZjgR8P727dBtK7RU/8KYQT+jRo+l1yQG1W3/a2x5OW7SKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202



On 4/14/2025 8:04 PM, Lendacky, Thomas wrote:
> On 4/14/25 07:02, Vishal Badole wrote:
>> To properly disable checksum offloading, the split header mode must also
>> be disabled. When split header mode is disabled, the network device stores
>> received packets (with size <= 1536 bytes) entirely in buffer1, leaving
>> buffer2 empty. However, with the current DMA configuration, only 256 bytes
>> from buffer1 are copied from the network device to system memory,
>> resulting in the loss of the remaining packet data.
>>
>> Address the issue by programming the ARBS field to 256 bytes, which aligns
>> with the socket buffer size, and setting the SPH bit in the control
>> register to disable split header mode. With this configuration, the
>> network device stores the first 256 bytes of the received packet in
>> buffer1 and the remaining data in buffer2. The DMA is then able to
>> transfer the full packet from the network device to system memory without
>> any data loss.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
> 
> Arguably, this patch doesn't fix anything as all you've done is defined
> some routines that aren't called by anything yet. You can probably
> combine this with the actual fix in the next patch and make this a
> single patch.
> 
Sure, Thomas, we will combine these patches into a single patch and 
resend it with version V2.
> Split-header support wasn't added until commit 174fd2597b0b ("amd-xgbe:
> Implement split header receive support") and receive side scaling wasn't
> added until commit 5b9dfe299e55 ("amd-xgbe: Provide support for receive
> side scaling"), so you'll want to double check your Fixes: tag.
> 
Thank you for your observation. We will recheck the Fixes: tag and 
update it in the V2 patch version.
> Also, the ARBS field wasn't always present, so you might need to
> investigate that this is truly backwards compatible and earlier versions
> don't require a different fix.
We will update the patch and resend it with the necessary changes to 
support earlier versions of the hardware as well.
> 
> Thanks,
> Tom
> 
>> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-common.h |  2 ++
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 18 ++++++++++++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe.h        |  5 +++++
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
>> index bcb221f74875..d92453ee2505 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
>> @@ -232,6 +232,8 @@
>>   #define DMA_CH_IER_TIE_WIDTH		1
>>   #define DMA_CH_IER_TXSE_INDEX		1
>>   #define DMA_CH_IER_TXSE_WIDTH		1
>> +#define DMA_CH_RCR_ARBS_INDEX		28
>> +#define DMA_CH_RCR_ARBS_WIDTH		3
>>   #define DMA_CH_RCR_PBL_INDEX		16
>>   #define DMA_CH_RCR_PBL_WIDTH		6
>>   #define DMA_CH_RCR_RBSZ_INDEX		1
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> index 7a923b6e83df..429c5e1444d8 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -292,6 +292,8 @@ static void xgbe_config_rx_buffer_size(struct xgbe_prv_data *pdata)
>>   
>>   		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_RCR, RBSZ,
>>   				       pdata->rx_buf_size);
>> +		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_RCR, ARBS,
>> +				       XGBE_ARBS_SIZE);
>>   	}
>>   }
>>   
>> @@ -321,6 +323,18 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
>>   	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, HDSMS, XGBE_SPH_HDSMS_SIZE);
>>   }
>>   
>> +static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < pdata->channel_count; i++) {
>> +		if (!pdata->channel[i]->rx_ring)
>> +			break;
>> +
>> +		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_CR, SPH, 0);
>> +	}
>> +}
>> +
>>   static int xgbe_write_rss_reg(struct xgbe_prv_data *pdata, unsigned int type,
>>   			      unsigned int index, unsigned int val)
>>   {
>> @@ -3910,5 +3924,9 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
>>   	hw_if->disable_vxlan = xgbe_disable_vxlan;
>>   	hw_if->set_vxlan_id = xgbe_set_vxlan_id;
>>   
>> +	/* For Split Header*/
>> +	hw_if->enable_sph = xgbe_config_sph_mode;
>> +	hw_if->disable_sph = xgbe_disable_sph_mode;
>> +
>>   	DBGPR("<--xgbe_init_function_ptrs\n");
>>   }
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> index db73c8f8b139..1b9c679453fb 100755
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> @@ -166,6 +166,7 @@
>>   #define XGBE_RX_BUF_ALIGN	64
>>   #define XGBE_SKB_ALLOC_SIZE	256
>>   #define XGBE_SPH_HDSMS_SIZE	2	/* Keep in sync with SKB_ALLOC_SIZE */
>> +#define XGBE_ARBS_SIZE	        3
>>   
>>   #define XGBE_MAX_DMA_CHANNELS	16
>>   #define XGBE_MAX_QUEUES		16
>> @@ -902,6 +903,10 @@ struct xgbe_hw_if {
>>   	void (*enable_vxlan)(struct xgbe_prv_data *);
>>   	void (*disable_vxlan)(struct xgbe_prv_data *);
>>   	void (*set_vxlan_id)(struct xgbe_prv_data *);
>> +
>> +	/* For Split Header */
>> +	void (*enable_sph)(struct xgbe_prv_data *pdata);
>> +	void (*disable_sph)(struct xgbe_prv_data *pdata);
>>   };
>>   
>>   /* This structure represents implementation specific routines for an


