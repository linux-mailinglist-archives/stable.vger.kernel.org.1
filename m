Return-Path: <stable+bounces-108608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86513A10A50
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1719F18818E2
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AEB14F11E;
	Tue, 14 Jan 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UN4dG1hQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE323244D;
	Tue, 14 Jan 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867203; cv=fail; b=hCP2ywybQh4pBV4k4KK0zaacrbkf9x4+QGz4KqLVsfuQfywIwZWcArAFqPvDGZzbHnMSjuQY1F2+enUZ39GK5WdLNlmL/RcZ6ri1bhe1VAy/GQArPQ14FSuUXASx/vVFQGcMtkut1IhaI8oxU08wuDELZFUv5Zlrxn5DTMC9s2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867203; c=relaxed/simple;
	bh=lRPKmFPIGzWCrWUSCOED19VnqIr3FMcSRCGU26rb4yM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YIQV8UKtwXAALX4X1kHM5JoHZ8j0eAe+X06dI7r6r4dCwnMXkBe01XkNkyYGAGBth0Db6QMzo8IWQat7wpoRu3xzxn5hI1l4vjA5vnEqmkaD/XHFQq5wN6PWoJr6xGQm2CFPwQYZpUVp6jZ0ryBgnuOPcs1WwWAr3rj93AqboH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UN4dG1hQ; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB985tCf+rWMnMugjTPfHAaURtibFX2eMjEojbyVlT1RzccXgD8ZFFIUeRpKoeIXF8sNAHQgy/J11cFSToHPMkkB+/tDHh7MxFn2QJSSuR0zlannKY8aWEB0yLkEgzafO9CV+TBO3C2NhYl2YZgepu68pA5dTty53HX6TXTAFTQ6gmQ9tcAElpxiqqSOK2u37xsM6AwwrPuBZQ0V5LNYtRfxU9S+C9pR8zfaRqqYxRamQP91Ai6l3Lw6PbLvVzoZBeXSYFNetS+OuY0CEfE9UxFxsfqEQ1Pz8THnXceQm1qomala4vfCDYhJDcT9jReBJT6WBONBrg/z61VmPLqYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcSIlUHab7EiPNlqUScqRMax0+EdpkwGiUs3JT9+UqA=;
 b=f0/LFd1V8aaFCJL7PLrraCEqYWFmug8Gt64875XgRWddj8oH9DERsI5e/I4FvWi15UQNxerkWYb3n3qv6Qjn636S55uc++MqNVyz2dqt6PiGoRzNismjZQJCcWAm1MpfZJfGY6TSKlLmjwZ9MMVg3yf4M+NosxrjpDJibOFcdDTa6BLJPzM5Do+Xnfb5sNOdgFaobOExUq3j5gRBk3ERLoqam8dkxcVWcAQyHoGlH1N8ClVoJmM6dBUUISsMfJ87M9UN6x9GBKc8Bzdknc9S3xNNsHQIPlo29aEmwepLwxUX4G/1x0slZa9xlUH3774mt2rK7wHeuZ1TXS1z5smfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcSIlUHab7EiPNlqUScqRMax0+EdpkwGiUs3JT9+UqA=;
 b=UN4dG1hQO8c/za/RhIRGPoXk9KcqXpuap6OJftq54e3X7piPyzCGQ/jrhGcO+UUxMpu7UXtgReUFbiRS+WQpYIrPQsUxLOsmEWLeK9oFO44LRH8PKhv1Ph3Ht+Krxf5aSjvlu8nzWlHlYsKi73eU3SVeotqc++2ve19Anx0mgf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 15:06:39 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 15:06:39 +0000
Message-ID: <557ecd25-039d-777d-c4ee-f2e83ed8d2dc@amd.com>
Date: Tue, 14 Jan 2025 09:06:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv3 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Andrea Parri <parri.andrea@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Chan <ericchancf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Huang <kai.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Russell King <linux@armlinux.org.uk>,
 Samuel Holland <samuel.holland@sifive.com>,
 Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, stable@vger.kernel.org,
 Ashish Kalra <ashish.kalra@amd.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20250113131459.2008123-1-kirill.shutemov@linux.intel.com>
 <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
 <1532becb-f2be-4458-5d34-77070f2c5e2d@amd.com>
 <vuj7mlvkvazuz5noupusqt2bk42vjkr5lkgivnrub2nby4ma6y@7ezpclbirwcs>
 <9981e3f5-1414-dd82-c6ad-379289575b07@amd.com>
 <2nc5silj5wbj6kz5tcsutgcjx6wviobhem4z24x4ya2r4q4ra5@5rixeg2wo7c3>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <2nc5silj5wbj6kz5tcsutgcjx6wviobhem4z24x4ya2r4q4ra5@5rixeg2wo7c3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:806:28::28) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: a1043996-eb82-4d72-8c86-08dd34ad0bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTN3SDdXMEhOVU1rZnFxcEJIUUhlSlZqOEJ6V3RlOWl6WWRYaFdUVHRjSXVD?=
 =?utf-8?B?ZVdIS1NOL3ozK3JNTlBUSzczeGdWdGFxZGltdE45bEs3TWpjL1pCUnROdnRm?=
 =?utf-8?B?QjkrVmRDNTZsTTg1dERQS2N1UVFTQUQ3OTA4MkdmWEtXaEZBdzFla1pyQ3lT?=
 =?utf-8?B?SzB1Vi83cE1sYlpCOTJXSmN0Y0w3RlNqYmVWOWJSM1NUU0RxNjgzMVdMWVBl?=
 =?utf-8?B?UjVDMVdYcEJwSDBsUTJzclVwd2dDOW5pdEEzVTIxR3VpZDZGN3F5TzA4M0Ix?=
 =?utf-8?B?OU9qTXdoazNxWmxjamhKclRpaHI0Yjk5Wi9UbkQwamljbHNUQ1NhbXVpTll4?=
 =?utf-8?B?SHUwWFQ4SzV6QjZHekVlTG9KOXhvbzAzaWJVNVgzSWc5L3IwcmpjVHFkWWRz?=
 =?utf-8?B?Q1c5MzZodGtkcmpjSXpidXB2Tnd2YytObWJJOEVWTlUrTTBDY0s3SXo1UFRW?=
 =?utf-8?B?b282QVZ4YmRaNWNWMTNmNk10MlExc0ttTFFoK3NTRnA0WWtTWlJlRm1XSktZ?=
 =?utf-8?B?dVhxQ2ZnM0NLMXhIdUhXdTBuc3F1NEtMQ01BdG1aMHh3eDE4U2RoVm5lN1Nw?=
 =?utf-8?B?NHMyOTBFb2tvU2RWMXhHajdoVjhoVXN1bkFIUFgwRWd5eGI4T0NaeW1NK3Q3?=
 =?utf-8?B?aGJNRWF6bFBOaU5uQ0l2RVhLQTJmcXhnMkhjV3NCZFpxWGIwNHZESUlhWS90?=
 =?utf-8?B?VFZIcVpzMGJCejlWVlFleGEzcE8rVmZjUURud0I5Y1ZTbU9Ha3R6anpDbGQv?=
 =?utf-8?B?VE4yT2dpMVBwUG9STW5WRSsvcDZ2VHVJaEdsV09hVXNmbDV4akZoZktibEdC?=
 =?utf-8?B?Tk1ReEVmWDZlWEJJTXozbTdPZWtBQ1c0SzhkaTltbDRCMCt0dE55TFFNOFJn?=
 =?utf-8?B?T0dMRWd0OE9GN3FRbTlUUjJTa1g2RlFxZFh6dEhTUjFYMXFKNkFyZjNjNHIz?=
 =?utf-8?B?RXJNdEpFdUU0cjJlY1lZSzNPUVVQV3czUVc5cllNRE83amdlOW1nTm45NDFG?=
 =?utf-8?B?M3pDRHdKd1N5ZlFuVENnOTRPUldoUnNhSkJ4bndhWURSY1NINk1kSDAwTnd4?=
 =?utf-8?B?ZzNMSHdkZmVuNkU4VkpyMFNBenRoU2taWjNIa3V3Yy93Qzc1cGFkMDNwRlZ5?=
 =?utf-8?B?OWUvb1pnMVJGaHhhcDRVL0luWWxOYWF1YXE4RHhQN2F0Tk1Yb3JaQnhCelhh?=
 =?utf-8?B?Q291VGk4WjNER2NoT0R2Z3MxRGhSZnZyZWM4Y3Q4ZFc0OHhGZUs3QytOUHA0?=
 =?utf-8?B?NTB2M1NFRjk1ZXRIT0l6S0NCTmxzY2xTalJyR1R6NnBBUW9zaG1DMnZiRHdN?=
 =?utf-8?B?bmJRQzA2aDdXY1JKN0J1TktIQVVucGZpd2N1SG5meDRHdUorNkxHVWpoSzJN?=
 =?utf-8?B?MGJ2TG1GdE5Gc2J5MlFIaU9OZVNpbnZBYi96QWwrdTBOMVI5MmpmVWovMTRQ?=
 =?utf-8?B?TWNVZnhra0t1aXJlclhOdHc5aDFSa05rK1VNQ2g1WGZUN0xtNmQxWmU2cXZa?=
 =?utf-8?B?bm9qMndWY3A2VXNxd1JJMGw4L2c0dHFVL20vKzJ6dGtPRVlwSzZ3eFJ5WlJ0?=
 =?utf-8?B?NksrSmVuWjl3c0hueEZYbGFhNkk0TkdtMTQvVFh4NXpUV211MXJraC9jMTlE?=
 =?utf-8?B?N1M3RmRXZ3RJbHNVRE9JL1lIMnNqcDZkdGovaFNtMjFPZmhPRDB0Vno4MGdi?=
 =?utf-8?B?U2dNWGlGWXZQRTVMdkZtK0FjMUcrLzI0cjhLcFRRdTR6b0J6VlFBTi96Y0JL?=
 =?utf-8?B?bnZjQjlwbGIrVGp0am5oaE1pOCtMWmsxL0FKRUdEZ3B1N3FHVzR6WHlaQ0wz?=
 =?utf-8?B?SmdXUUhGZUNBSURRZnoyRElqSWdRdUExSVVJRXFQUGlWdmMwTURxVEp3WDEz?=
 =?utf-8?Q?ccjh4xqG/JYY6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGlxL0d3c0RUN3NHYzdoUUJJajNSWFB4Z0gwVzVpUUdMMEVlSkMwOE43ZGQ1?=
 =?utf-8?B?T2pRaVBZVXZhMlZCekFPczhTaTBZNk1ISnV6MWdFMU5rb3hrdmM1NEhPMGkr?=
 =?utf-8?B?bi9YbkNoSDVvQUZxMCtHYjNBand3N1M4bGIveFJoeENaVXU3L0hSZzZYOWQ4?=
 =?utf-8?B?ZTN5NGpzMlhDOVBMalpnMXk3R1NpRzRjeWFjZk9vTDdLNU1LbWEwRGlud2dh?=
 =?utf-8?B?ZXRnbXdnemZ4bmlJU0trc3I4Z3ZVdkZHZU12NGxFSEJUajhnN2lqS25zSDhE?=
 =?utf-8?B?QnJabGVoWS9BNzluTm1IK0NINTlDUWhGbkd0dU9nNEtFeXpXRmpxTkJVd1Rp?=
 =?utf-8?B?T21hMzhCQUJOR05yZ21IZlJYOEx0WGE1MEdaNVF2b1NVK3ZQNjNwbGtWRlQ2?=
 =?utf-8?B?eTJpbVEwOG96NDhPUzQxM0N6YldwWjNtcURTVEtoUEowb1pHTFNldngrRmlG?=
 =?utf-8?B?aWpSeEYwZWVXblQ4VU4zOVdsN1JNYk9oeGRlNTdPR1FJR1dERCt4d2ZPTklF?=
 =?utf-8?B?Q2hhVmhQTkpHaTBtM1grRWJwSzBwSkdXazFpR2VhMStNT05iOW0xOTBnS01R?=
 =?utf-8?B?TmU3R0pDY1pTZTBYcUVCalBJVzMzaVlJQnc4am1BSTBEYTdqak1vL294R09W?=
 =?utf-8?B?QzFtK05KSElkYkRaTlgvdS9hMTNvK2o4OEpZcyszUksyNU1kZWtxSVhUMSsz?=
 =?utf-8?B?MWlHSTNFSVVLSHo5V1RQVDg2YkFsa21DT1RIelVkemFPT2dOam9yZEJuSUdO?=
 =?utf-8?B?NGF6Zk51cEFtcTdyNGd0eWJ1aXFVWXcwZVpvczJMVUY0VnNBa240MERNZW45?=
 =?utf-8?B?c1N0YmswSVNORWhQMkh1dHg0WlJWSVIyMlcveDV4QlRXN1BZOFRHL3g0YURX?=
 =?utf-8?B?OVVBV0R5R2x2SmNTanViNlQyZ1ZUV3EzU1prUVkrMDBoc1dhNjRjQm1USUxa?=
 =?utf-8?B?V0JVSnlTdDN4MkhUWEJ3SEZKSEdZTlVHdDM5SXZMQk8xOVlETTY0Z3RHVHB6?=
 =?utf-8?B?TFVFN3A5dVhiTnVndXIvSVpyUzZwUGxaS2VNVEV1RTk4UUFDRnE4WGFkb3JD?=
 =?utf-8?B?VGlSNm5taHd1STZSaHd6akRGSUc3TUNLL2w3OWI3SEFqSkJ3bG9odjNpV0l0?=
 =?utf-8?B?d1VJcnBoRlYvTS9KdGdtTTNJUTNtV3gvV1lkTCtHaXZsQ1ZzVXlBSVdhMXFU?=
 =?utf-8?B?a0JNUTdpN2UrQmh3b01teFdzZ2o3ZDVMQmhrdGVwY2srZ3ljT2h5RzBKaVE1?=
 =?utf-8?B?THVZd1VQLzM2NklVR0dGOUpISEg3RHh6Z3hYSVdqa293dE85cnliZjZOY0o1?=
 =?utf-8?B?Nng2TVg4VVJ5ZWx1c0RvdSt6QUlNUFpXVXBTTGNwZk5aVmxoaEo3QTZLa2dy?=
 =?utf-8?B?bWNmclhpS0FhOVpLSnJPN2liMDRwWXJzcHhMUktuY0J0NTJhZWNzak5pbnlv?=
 =?utf-8?B?ZVErcExCR3ZxSi82OWY1UUF4TlovZTJ2YkZnR2wwQ1NzNUEzNWFEZGdqaEIr?=
 =?utf-8?B?UEUzN25ENDVpNC9oTWRDUEczRkhxUXYyR2dXMnl5UnZ6YTFmVUJ5N0pCQytO?=
 =?utf-8?B?WWdRY1lrYnozZXRQbTBOS3dFT1hYczdqWko2eWR6cGFPdEw2NmNnMFhXb2pt?=
 =?utf-8?B?NDdVeENRZ0dvRFMyV3llYndyMzdGdjZ1N29RTzdoS2ZLZGlrU0NKeS83R2Ju?=
 =?utf-8?B?aURWZ3NDbXJqSzdoTjRkMTVQNHgvTGQ2OWJzN1RMbkZrSGRYMlMrVkc4bFRo?=
 =?utf-8?B?N094QmNmRDl4YzR0YlNNQkJESVNndC9xTlV0NG5OY0psR0x1NUF2UFZjd1dz?=
 =?utf-8?B?QjFzMVRBejRUREFMYXZERzk1TGtRbGJoOGRzL1lDSVd6V3FPVm40RllXUkZE?=
 =?utf-8?B?M3RET2FPZmZ2SW9BTmdIbUdFanhXb3JEL3NUSWU2MXdIN3JWWlpOOVN3Yzhu?=
 =?utf-8?B?K1hnK3ZPemJzcVExVnVUQ0N5b0NySlo0UXV5TDBRM2YzUTNZajRBS09oUjZI?=
 =?utf-8?B?S01DSmFlQmg2djdjU2w3dndxMDhRbkVEZDdXWXMwZWpXYXlxeU5TQVZFelNT?=
 =?utf-8?B?ZFlkK1ZkSXVFeUx3STFQUlBkSXJtLzRBN0FCb3IzYld0WFNCdzNoZkp3RHVF?=
 =?utf-8?Q?ICVShvdNONTL6bMDoX5gE+ryl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1043996-eb82-4d72-8c86-08dd34ad0bf9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 15:06:39.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8g+dwk2QkRhBvsdKcd5MXiWvQZR38INUoIQ2vLHs2XgMprIm0cdufetphPuizdVpQCNMrRc+AoM/rtxFm0jioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

On 1/14/25 08:44, Kirill A. Shutemov wrote:
> On Tue, Jan 14, 2025 at 08:33:39AM -0600, Tom Lendacky wrote:
>> On 1/14/25 01:27, Kirill A. Shutemov wrote:
>>> On Mon, Jan 13, 2025 at 02:47:56PM -0600, Tom Lendacky wrote:
>>>> On 1/13/25 07:14, Kirill A. Shutemov wrote:
>>>>> Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:
>>>>>
>>>>> memremap(MEMREMAP_WB)
>>>>>   arch_memremap_wb()
>>>>>     ioremap_cache()
>>>>>       __ioremap_caller(.encrytped = false)
>>>>>
>>>>> In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
>>>>> if the resulting mapping is encrypted or decrypted.
>>>>>
>>>>> Creating a decrypted mapping without explicit request from the caller is
>>>>> risky:
>>>>>
>>>>>   - It can inadvertently expose the guest's data and compromise the
>>>>>     guest.
>>>>>
>>>>>   - Accessing private memory via shared/decrypted mapping on TDX will
>>>>>     either trigger implicit conversion to shared or #VE (depending on
>>>>>     VMM implementation).
>>>>>
>>>>>     Implicit conversion is destructive: subsequent access to the same
>>>>>     memory via private mapping will trigger a hard-to-debug #VE crash.
>>>>>
>>>>> The kernel already provides a way to request decrypted mapping
>>>>> explicitly via the MEMREMAP_DEC flag.
>>>>>
>>>>> Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
>>>>> default unless MEMREMAP_DEC is specified.
>>>>>
>>>>> Fix the crash due to #VE on kexec in TDX guests if CONFIG_EISA is enabled.
>>>>
>>>> This patch causes my bare-metal system to crash during boot when using
>>>> mem_encrypt=on:
>>>>
>>>> [    2.392934] efi: memattr: Entry type should be RuntimeServiceCode/Data
>>>> [    2.393731] efi: memattr: ! 0x214c42f01f1162a-0xee70ac7bd1a9c629 [type=2028324321|attr=0x6590648fa4209879]
>>>
>>> Could you try if this helps?
>>>
>>> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
>>> index c38b1a335590..b5051dcb7c1d 100644
>>> --- a/drivers/firmware/efi/memattr.c
>>> +++ b/drivers/firmware/efi/memattr.c
>>> @@ -160,7 +160,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
>>>  	if (WARN_ON(!efi_enabled(EFI_MEMMAP)))
>>>  		return 0;
>>>  
>>> -	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB);
>>> +	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB | MEMREMAP_DEC);
>>
>> Well that would work for SME where EFI tables/data are not encrypted,
>> but will break for SEV where EFI tables/data are encrypted.
> 
> Hm. Why would it break for SEV? It brings the situation back to what it
> was before the patch.

Ah, true. I can try it and see how much further SME gets. Hopefully it
doesn't turn into a whack-a-mole thing.

Thanks,
Tom

> 
> Note that that __ioremap_caller() would still check io_desc.flags before
> mapping it as decrypted.
> 

