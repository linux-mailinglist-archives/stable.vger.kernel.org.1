Return-Path: <stable+bounces-142014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F0AADB98
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEDDE7AD3F9
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435020012B;
	Wed,  7 May 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nVSOpvfj"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F961FECDF;
	Wed,  7 May 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610786; cv=fail; b=dSrftUzVC6yf4mMiINttXxLR4Yg3t0O/YQYaXjiuHs1bOEQFRDtgIb/hIAI0/8ZlKv2FsujxtBKxhM0YXqNU+XY5FlSm/d2T/tR2dOqzaBw7APQqSRraqRSuLeCM7dQWqyA+HTUu7F+zxQCgPLF7wXJhZtVXSrwC5Gb31YxjwhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610786; c=relaxed/simple;
	bh=xEHDTO+9Euji6ge0YSamfT2+7VHY9xP3YeBBXHPM4fg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L3snuc4CMMl8O/ogHitxjzM0OjpHInEtzgvgtrJlxkyYYqAXYavZLSaNjwQacFmd59SgqWieZyHpIsSioxv6nJScmL6rjpsGNN/+p0JbazvVlLZs+1HwJACu/6UqdbYTjQMHgk0BMtU4R02pk9w/G0qHpOr92OVeKM5YjBJC5fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nVSOpvfj; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKHhdCudHbsQmic1Zf2C2kXnEjkrkqNf10MQVvAoWPMkCYgLq93Fmr5YjhejWT51+avSGQMtEO+FpLPGN14ZQUgRG9Ll2yQ6XaKYj2nHAMCSluzmVCRvmwRLpEgVjbjpMoAYlP/h448Hztk8OtyoOOpnRYbPcgnrAaDcUwW2jDVTMtWJXDcqqBmi6TwCUjxOOgNvIPdP30ZONGarH94/Iu+wTnbcLQ4fi7sn44u1WrsRTgFdHptcfxF/KdgrJDClas6IsvRrqpSXZTf6D/W5o+MoezTr2YqPuxxE7z64l2Eg2YH38LqI5kRRsBKyNoH0ozXxpuCTeSDzGq31H266pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrSpDQA3FWuwXAKOfo+qOtzvE0ptLlTeu0M2+BcyA88=;
 b=n5yrMPdL/0Qcj6iAeVLI3Ubsv0PQOQiysfDcNY4zcJAzxlOhGso4bGo/6Wa2afxcx3IJCXBTRmk6m5J1fVHf4tnauHftjYO/w7Wkfyh4flzSLUDSMWGkNJsUFt8sH3pHroPLchvQV5cMJgVoM/wdvn6Ac5C2MMQ+y6Is3xhQofTW7MSqJCbQNtoR1HcIIGtISfbq0ggaQ/2NWyynegeNaTk+kK4wX2bnxQpD4aiBeKBJY4ZJQyDba642CwYA4qvq4JIPkcTfynXcRCKYdopoa62YaAyEg1bgifNG7qNebVSeV+QH8rpYNegXYPR8Qnc5ChIW/4k7XLbkFTA0wAd+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrSpDQA3FWuwXAKOfo+qOtzvE0ptLlTeu0M2+BcyA88=;
 b=nVSOpvfjO0Ff+VyIgY2jOntLjK3LIA5rMGuTKHrIGW8wwNPZlNzTaOmvLPiHEUTtt773J52Kt6ByikQINlXCrtcIS2J6xT0F700/A1fGgDHwcLXZiUQ5bwKSpcI8adOvVnXst5PmlKj8sXTi5y1ssFDJU++oRIjXfbG09XjBuqVNlOVe/3R0jlwYHRBKQ/OSdaY20mctZQ5QoFq5jcQfWrt66Cn6P+VJ/dngpSQVB4MKWOziDX2JgFEz3H9KtiCFOYPBTbDD9py4wSJG3Q7aEN7NR8Aah6wjjT4ab6WCakpAUpAB+sNttyfEFOOyUO3iBy4xvQxy4PG+MfiVGQI+KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 09:39:41 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 09:39:41 +0000
Message-ID: <7666d6e3-9fd5-45aa-9a29-144514ab3533@nvidia.com>
Date: Wed, 7 May 2025 10:39:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] phy: tegra: xusb: Decouple
 CYA_TRK_CODE_UPDATE_ON_IDLE from trk_hw_mode
To: Wayne Chang <waynec@nvidia.com>, jckuo@nvidia.com, vkoul@kernel.org,
 kishon@kernel.org, thierry.reding@gmail.com
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250507024820.1648733-1-waynec@nvidia.com>
 <20250507024820.1648733-2-waynec@nvidia.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20250507024820.1648733-2-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c6d64c-739a-4d04-e3e7-08dd8d4b1769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0ZFN1VQbFlUTHY3OStwdm5MUWJKZTdvd3daRDdhWWNSc1ZJMHQ4VGwrVDd3?=
 =?utf-8?B?KzAvVjR0VW5jbmFvZVhIbVJ2bHpFaXd3b0JwRDNhOWxXZ1FjZWlPb0hrNEFB?=
 =?utf-8?B?cU1WQ0xRV0lFWEdKcFk4NkhZSmFVRmVsN3BrRCtKUEhGQ2FSVzRlM3ZUcGdp?=
 =?utf-8?B?T0dXR3NBdXlkektqZHg5K2l5QjFGT1hPYW9wT1YyY1kya2VUcUc4YzZLcDVp?=
 =?utf-8?B?bnBUVFBWQkpFeFFEK1RkVFlLUy83RmxvTTNiOXlpcWdUNWF4Nno0U292b203?=
 =?utf-8?B?SWRzbEdxbmFJeDh2emJENWpOMmZsNmJnQ212Q2ZGbWFWRkY4YXNvcUJqNFND?=
 =?utf-8?B?eEtKRE5sSnpiTnR2ZFA5WG14Q2tNSTE2dFI5L2NVTzFNeXlGRWpOQnFsempN?=
 =?utf-8?B?czZHRklnWURvSHJkUVhnYnF5ajJRaDkrTVRIRGlQK0pwUy9COW9neXBzSU80?=
 =?utf-8?B?enhvWWV5eGVYS1ZtYng4NHE0bE5GM2xESndvNTN2V2w1MTl5Z3g0bVFnOE5q?=
 =?utf-8?B?RWNYRFI1M0tuT2ZCZzIxZmpoWEkvc2E1OFdlNnphMDRFZ2VaT01WQWxSOWl2?=
 =?utf-8?B?Zmk4T3IydFF1b1FhY3R1ZHFDTEExeitEK2pwaXYzcFF6VE1jN0c1YkVoVnEv?=
 =?utf-8?B?ME9EQ1hyNHg2aytVZFFQZS9JbG81ODhxOS93aUlmVSt2NFRlWlMyUkR1b3oz?=
 =?utf-8?B?SHBJRUlQTUlzZEN6VmNURmE5Y1dyRWRyZmNnSVBpSmdqOXdQdFo1NUtzZGhm?=
 =?utf-8?B?VVcxZk5XRTlGTmVQMkJLMXo2STFDd0hkNld5SEw5Y3o0VGJPOXpHdzdDYmRp?=
 =?utf-8?B?MjBSSGxmaWpmYWN6c08yTXYvRFMvUko1OFcxUFNpeXVIREdVZCtoN3hiMUo4?=
 =?utf-8?B?VXhoaHpIVXJ5MFptV0diaWhsZ3UvSng0dHhSc3FwRlVWQlNHWUt6UjBzOUVj?=
 =?utf-8?B?UWg1QUs1cVlGNURFZDhmZE9YUExsVHNudmRYS2IvUzc1V2JVaFFvZEJaRE1J?=
 =?utf-8?B?c0ozdmR6aHZRNVc3ckJMK09SQ3pIeEMzMlBzaysvVGVJTkRQekdYbTFENlRm?=
 =?utf-8?B?MmRqbVZ2TGRFdGk0dm13MG5vWWRjOTQzVDRoNzgrUHVwd0JlMnRicnRqbFd5?=
 =?utf-8?B?NmtFZUR5SlpEVUNyWWNDTU1kYk8vZnlrVTBFM1pUR0tDK1NVMzFxZHR5L0pr?=
 =?utf-8?B?UFhTT3k5a3JvMVRmMVZhdlBscjhDTlV4QzZUdlhJZlFRRE1ockpQUEVOVXdv?=
 =?utf-8?B?MFFYMkdmR2hJNml3MGlYT2VWMSszbzRFOXVqZ3pwZXdVZHFsTlAvZDR4V3po?=
 =?utf-8?B?MHBiVlE2NDdZSG5raEYwZHFMMkp6bXhOMUhya0dzdThUUnpqOWhBbVFndlNr?=
 =?utf-8?B?UmlNc1RGRnpiOUNEY3lsMkdQZXEwczNwRGVyZy9KbTZjOCtrRHpHS3JyUG4y?=
 =?utf-8?B?U0taK0NRVVowOEdUd1Y2NUY3VnFIU2hzTTZYNUdNTTNTMmdTeWRsQW5NMXFu?=
 =?utf-8?B?WTB0d1k5dThnQWxxdDFOcklhUHdGT0lKQkRIeFF3RDZreEx2Y2VCZ1p3ZE1h?=
 =?utf-8?B?TkpnNWZKMUFxOENBUWt5eC9aRW4vZTdQMEgwbDIwbVhZNEx2Ynk1MVVvS3oy?=
 =?utf-8?B?WUFuRTlzR2ZWRnQwcVBPWDhmaFplWjVqaGJnSUduTEJlYW9HS0ViYmUrYWkz?=
 =?utf-8?B?N3IyTUovRStRZVlsZjBJUkdGSUxVaXZ4Y2VjRmI4cmR4MEtNS09lSEthOXZk?=
 =?utf-8?B?VVNxak1XMUh3eklncDFWSXd5dVVaR0VWRmlia083RzBnWm5nV2ZQNnFmU3Ju?=
 =?utf-8?B?c2Y2T3dHYVVudVFiZjJpT2tXNno1K3ljT1V2QnVLVlNVOFhyd1VDaEpFMlA5?=
 =?utf-8?B?TGdjOTkzeFlHRHRNU2hMWlhtWDhpK3FXcFBaWThSYTlGVHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHNFNEtxd3NSTjFzWTFKdi84Y2l4Z2tmSGFwTXZlZWQrbkwzWDNKQmdTSGFJ?=
 =?utf-8?B?OVhZSCtzWW5rS3hGTG1qVEQxTG9UUkpTRDRIM0dONEJWUlYwdmhweVRTeUJZ?=
 =?utf-8?B?Tk9aQVhPbFZDVjhUaHVzSVZSVHpsR0l5RjRzM1ltdno0RDNjWVUzRHM3Q1c5?=
 =?utf-8?B?THRGMGp1S3hwWHVvYnM0Q1B6Q0toMVVTMFZ1ZWVxUEtGZ0NjU3JWc2JISVgw?=
 =?utf-8?B?ckRWOE5OdUxZRzFpUnY1NmFZV01jZ2tZMG1xMTZ2Qk9TTnpFWkswS3BwemUz?=
 =?utf-8?B?K3M0OHdleHJ6bjBwSVJ2dWtTdzZ1TGZoVEc0c3FpQS9HVFd3bFIrakYyc0ZG?=
 =?utf-8?B?VTJkOXd2d2NzUitpcDFtU2NwUzc5bDJzcFJsMGRRbEhOQ3lBTDZLQUl4eWZo?=
 =?utf-8?B?YWxHSkg3MFRjazlXcVYyUHpmaXNiMG9TNmY3TTFGcWdXcVhzQVo3OEJPR3dw?=
 =?utf-8?B?Wk94SjBCZHFwVFhkZkJjWjE5ZFJTZnpuaFdOMGZNQTRxdHVJT2ZaTEFmdERK?=
 =?utf-8?B?SFZBMk1NNG1VSXJJeWsxU1pZdkZSYWlQRmxTd0RkcmZxdnByeTgxR085c3Zn?=
 =?utf-8?B?RlNqMFpqZS9JNWh4aEhVZTkvU2J2eWxPWThJa0dMLzJiNDdXTCtHNlAvWkFt?=
 =?utf-8?B?SkRvT1I0a1FnZFJ6L1NYRHpyWjVwTlByY0RYLzIzbzZmWDloeDBSZEZTUWVC?=
 =?utf-8?B?N2NMYjh6WjNJMW5vSWJmNDFOeDBGUnlmOTdMTE50RmhCWGE1dzNCb3JCZ1hu?=
 =?utf-8?B?MjdiSkg1TCsxS1FCanhaSld3SUxvNzRQZlJqSnIvSzhPS2pJTExVZk94bHk2?=
 =?utf-8?B?U09OTEt4aGpQMnZPdVQycHRodk0xcTZrVHdtRG1HN0hXU0VFbXkxOHhtQ2Y3?=
 =?utf-8?B?TlkvN0JGMWJEVUJqa05BNWJxZXd4MlRoT2M3Q3hJZU1rVW1HVEZGVC91OVhF?=
 =?utf-8?B?bnVZNk56REZrVVhQdnE2M0NXOU9zZkZ6TU83NGpFeWhPM0JYL0tISzhqTm9L?=
 =?utf-8?B?d0FlLzZFaXcrc3pwbS8xSVRtaVBKWlFEOFFVamJnYzg0bmtHYlZLNmVTTXND?=
 =?utf-8?B?Ulc0TGJtVlJKc0JCOUZRbFJDTThndHBNL2M4dXpuR2U5eGp2aEhiL2kyR25U?=
 =?utf-8?B?WE9uNzhQRFFXcCtKamR1eXA5YlVsbGVWcFNLQmZIbndBYmJtOG5WVnBMYU1y?=
 =?utf-8?B?bmpGRlpVQVlIdHg3MUlmV2xYREZ5MkZ2SGw5dWtTTnVFU2ZMbkZ5aDdEMjlv?=
 =?utf-8?B?Si9EVktIR1Z5ekRyVFdHWnNyUy9MaVhSRzhoSmxIQWFiRlVCU3pzVSsyR2Fx?=
 =?utf-8?B?YVBpT291OUx5MXd3ejZ6MktpQnZrYkVwcTVWQks4Z01pb1ZwWkw3L2d2SStT?=
 =?utf-8?B?bldDNWJKaGRBbDVCYVZXM3AvdzBQU09Db3lPb0JnZ0xyTzRRRlhJVmtoM0pB?=
 =?utf-8?B?MExFdjJKcFdFWUtZQjBJOTg5NWtFY2pXWDdMQjVJaDViSW9aRjFXdTUraGc1?=
 =?utf-8?B?cGtjUUw2aWRxZWZhdGRoOVpXbnRGbEtjcnlXU1pFdGxsczJqRWpyNnhrT2Z4?=
 =?utf-8?B?N1dWbjdSNXRibEVuOEk2MmZ3UFFZS09jWHd3N0RwM2E4YXVYOUwwYXBjTEcw?=
 =?utf-8?B?UlJ4cVFqY091K08wRDFCMXRDMUZjV0RWRmNPWk5qTkxEVFVOV1oveCtpWGJm?=
 =?utf-8?B?akV0Z0xHVCs2SkM5NGNnVUdyQldRenBiWVJlMHlnOXVhSDRhRHpIdStpSG5F?=
 =?utf-8?B?U2p3azhlZzBrbExSQS9TWGZ2SVdqVUExU3E5Q2pnOEtnb0dEN0xydGlUZlV3?=
 =?utf-8?B?QVBrOEVoeC9PZW4vTFRiSzBmNFBxQzNDdUU1VDVTWlFVSmp5d2FyWG4zMVVT?=
 =?utf-8?B?R3lCQkRlTno5OWs2ZDl3SzVVSjBqQ1VyOWhXeFdMMEwySklpU2lYZS81cUNB?=
 =?utf-8?B?cHh0Z2Z3cDlWNFNtZmtENHJIcFBxblNMNnNKNm1PL2Z0RXRLQVlaM0xwK1dm?=
 =?utf-8?B?aHhGU2UwWG5sZW9rYW1aT3FSWEdVcWkxVDU3M2J2TzE3aGJpYWpqTFJ3LzNl?=
 =?utf-8?B?ZldtMVUzMHdsTlFzbTROb202bVd5dmhrUzZnalo1Y2FJb0hhVEZybGoxZkJI?=
 =?utf-8?B?d3pUS1dCNEZyd3dFN2RHYW5mNVkrU1BLeDVkN1paem1JeWp0eSs5d1N3ZzRF?=
 =?utf-8?Q?VJN/dVzDeQ8JBM7wU+8fqxRZyEIMbpWj2mSxmvdqG2hQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c6d64c-739a-4d04-e3e7-08dd8d4b1769
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:39:41.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3MJW4FqtRzgJO+nXyojKS3xP0AWeAMCeBOTjdC3Dy4PBrze2lEkDgKJZPh7oPSY2VaUwHUu0Bb/L7xsO1iqeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352

Hi Wayne,

On 07/05/2025 03:48, Wayne Chang wrote:
> The logic that drives the pad calibration values resides in the
> controller reset domain and so the calibration values are only being
> captured when the controller is out of reset. However, by clearing the
> CYA_TRK_CODE_UPDATE_ON_IDLE bit, the calibration values can be set
> while the controller is in reset.
> 
> The CYA_TRK_CODE_UPDATE_ON_IDLE bit was previously cleared based on the
> trk_hw_mode flag, but this dependency is not necessary. Instead,
> introduce a new flag, trk_update_on_idle, to independently control this
> bit.
> 
> Fixes: d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>   drivers/phy/tegra/xusb-tegra186.c | 14 ++++++++------
>   drivers/phy/tegra/xusb.h          |  1 +
>   2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
> index fae6242aa730..dd0aaf305e90 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -650,14 +650,15 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
>   		udelay(100);
>   	}
>   
> -	if (padctl->soc->trk_hw_mode) {
> -		value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
> -		value |= USB2_TRK_HW_MODE;
> +	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
> +	if (padctl->soc->trk_update_on_idle)
>   		value &= ~CYA_TRK_CODE_UPDATE_ON_IDLE;
> -		padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
> -	} else {
> +	if (padctl->soc->trk_hw_mode)
> +		value |= USB2_TRK_HW_MODE;
> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
> +
> +	if (!padctl->soc->trk_hw_mode)
>   		clk_disable_unprepare(priv->usb2_trk_clk);
> -	}
>   
>   	mutex_unlock(&padctl->lock);


Can we rebase this on top of the fix 'phy: tegra: xusb: remove a stray 
unlock'? This does not apply on top of that patch.

Thanks
Jon
-- 
nvpublic


