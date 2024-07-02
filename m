Return-Path: <stable+bounces-56350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63A923EC7
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00B4B26110
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BBA1B372F;
	Tue,  2 Jul 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PmcASkDD"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E531B4C45
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926453; cv=fail; b=kga9WWK3A4Y9XHlxHEoMd4MQLY18CHzfuMS0btFUtQobdzPk7r9iNf3/uSm0wEoqqkmQoLFQFThUNIJkR3vib/1/lo4QWKdAO4o6WaBxdVUWrD1D8CG37azfMDLpNfBT0aph5+9IE4dx2IJ+Xc+MoNOuR8tUhcT1V7jLPNqQOQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926453; c=relaxed/simple;
	bh=S8tc18/S8ScRL5VLJ6mpaMQGzAK/T2HtdG33IvRzXSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfXgOhu2HeQqiRmvLC///+Enfuue/74kMFpfGJ065AvYxzrIaJ+HkADfc3b3UkfohmGFTwCCcqNBkGd/cEgpDmd33MkNbc2qcL0j2IMUwSZJDN28wdLwuE9+zCt5nFuUW+rDP6SmqLQM+LqVHsr+h+aWhLr7UbkBJJ4vhphdW8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PmcASkDD; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg4Uj+UXNeOBbbHL59StdYf7lUj9DgdwgmmmKDWgTqG5zwE2FmcyBbtK17jM4WcesUjxCGcrqOHfDOclPUbZBiA7mP7dN4TkT17JdlfJ3Jv3Qvv5g/XuNmf9hKmdsINgkMcs2VlKoju392rAOA7i0/oGqbb1XMekRJqb2RWfAsXNPCHzaWIY6UnKFbyCaMk85UFs2vklMnL3XqxQ5XN1QWq62P11dKo3vPb2eghl8Fvo2OH4Q8fvF6MtJ99tbEQFI/cSxBg/Kbxz3DLH+xnWNoQov2c6G/tfeMTw2J17Zi0E8JYZlStOjgAgrvN05j5p1CGBckhTU54DogQNFIHq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o2xnQBJEy9si8XIEPJNx6GDxoCjjIGSH10LuDuMSWo=;
 b=A1m9p2/bFGA6G0ZDsHmfGVWefGMBY7E5c/FTUAA0m3hUIzoA0JnE1GsTCbjAyx4doWGn4v8twRQ2IVPsN1Ct2jjGANkvSELYQndi5rOJZvcQZOBcrc2PEQqd2eVnV5lHXdxodTOAhTB4U+1rtt9ufVdf3FXyRC9ZyrklHqEltrqUrjMRIgdaveIIUzpBwYj3qHuXyrl/qhPPApoZl7HkxtfBieFOsgPcntj0blWvTDh+B+nBda1gOz0lcmFUjg9y6Qx2rVM2mDnpQMa+0ol3gDo0TWpA4YV91BEbI3JLboUabam2OM8cvtm7n3Seaj+jfDK5odb+QoyfTZ4/9zxfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o2xnQBJEy9si8XIEPJNx6GDxoCjjIGSH10LuDuMSWo=;
 b=PmcASkDDVqTXsKkpTBdvgfwG9ZI4a8OA5qPt20NJrnUCOJ5KHEPTGPnt1dnBYe0WbJk/TDYzm0CpkfYw/hXPJqUGaIaSB2jHbFBovR4mwzSGa9JVIsSdtlLZU92gsU77iXV/9lg82zMWWSEpSn0WwUr22ehTfkymat1XweYd4Fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 13:20:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 13:20:48 +0000
Message-ID: <e2d1414f-db6d-4d83-89ea-1b0fbe305ecb@amd.com>
Date: Tue, 2 Jul 2024 08:20:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: linux-6.6.y: Regression in amd-pstate cpufreq driver since 6.6.34
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lars Wendler <wendler.lars@web.de>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)"
 <Li.Meng@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240701112944.14de816f@chagall.paradoxon.rec>
 <SJ2PR12MB8690E3E2477CA9F558849835ECD32@SJ2PR12MB8690.namprd12.prod.outlook.com>
 <7f1aaa11-2c08-4f33-b531-331e50bd578e@amd.com>
 <20240701174539.4d479d56@chagall.paradoxon.rec>
 <fd892ad7-7bf9-4135-ba59-6b70e593df4e@amd.com>
 <20240701181349.5e8e76b8@chagall.paradoxon.rec>
 <18882bfe-4ca5-495c-ace5-b9bcab796ae5@amd.com>
 <2024070251-victory-evacuate-1b56@gregkh>
 <2024070258-popper-unheard-3592@gregkh>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2024070258-popper-unheard-3592@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:806:28::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e92f43a-95b2-4f15-74f6-08dc9a99c9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzg4MVZDeU5DSU5JOFJNVjdsWWliTmM5MHRvN1hWakN2ZHlVbHkxTGVkdWcw?=
 =?utf-8?B?NXMzTUt5VkNTSFhlSDhIZzIyZGFJTi9rdzJMcGZLQnh6TjRUMlRyME9CMlhj?=
 =?utf-8?B?aVBPK2FRTDBFT0ZCR1ZzeHpGMjl5TkVOVXh3V0I4T055dGJPaGo3L2hybTBZ?=
 =?utf-8?B?SDBKNVpIWGNyYk54TkM5Wk1VQ0N5dkpuVXlkL1J6UHVOQXYvc2NKMzkvMXQz?=
 =?utf-8?B?eG4vUHg0Q1lDMzdoSXBNMVpqQk0zQjVvakkyOTFOWWZOQ2JqQ2JHZVBhUlFk?=
 =?utf-8?B?dEZBRisrZ2FkQzM1cW1SenJUVEVlcjh1WElOa0hDL0pPMmYyK3dGUGxBY051?=
 =?utf-8?B?WWhWOEJpcVZURTlHREdoOFZPdGozeWZqYThIcGVDUVZ1S1BlSEhxblBKY1px?=
 =?utf-8?B?LzgrVlAzQ20weUFlRzltUjRBNWFKSlBzSFdPOVByVWdvMUJwaHVZUjNUQU1y?=
 =?utf-8?B?QnJ6RFB5amRsTjdCRE1DM1BYRGdCWjZuQjRhSTFienRLOHVFbDVhSlVDcWpF?=
 =?utf-8?B?NjN1Z1BjL1lqUnhkVkNVMVJrRDJZaGN4dUFVME82MDFoRElCbGFjWmMrKzg3?=
 =?utf-8?B?aldyekVwR3E2ZEUzNXBoZzJhdTNTaDdERzNiejVXY2s2TEVuL1lxTVRZYWZL?=
 =?utf-8?B?MElnSWNTcUw1RWM3dW8yM3NBaWNBSVBVeFdtS2xNdUVWSi9FOFA2NU5tSytH?=
 =?utf-8?B?dW8wN013bDEvb3BweEJoY3JiejNZRm5heGxYSkNiKzJoMXV2bEFocUliVXoy?=
 =?utf-8?B?L0xjQ1A4amxKdEJKdHNUcTBSMFFvN1lWYlhwekhBdm9oMEpxZExkZWZVempx?=
 =?utf-8?B?a3AyR2ZHT3o1RExrd2RLQ2V0d0V6SXY2VDNGUW9uVzJCeHMrUTZRSW00bUdq?=
 =?utf-8?B?SHpoVnJ3UlQ5Y1FadjJ4SzdMMHBsVndQdGMwaDhreUM1TGRJSjF4NG50NzRv?=
 =?utf-8?B?TjlSUjJXYkRHUzRETnBmekRvNUJtVDRjSlZNeDhCanlMeUVheUlJSTBqUWhU?=
 =?utf-8?B?TWVrcUdEWkMvVjFGc1BWemRLRm1RMTRoUENSV3Nob3k5Uk55Tmd3YVBmdW9W?=
 =?utf-8?B?YVQ1d3c0eHAxT29MY0FXNm9sYVRvSEM1UW1HUU1uU0pQcTBYb2p5MEVvM3Uw?=
 =?utf-8?B?ejgxb2tUcjQyV3l0TnZZV3dwdVF6d2tiSmJmRHU3TUZmaDdmSU9WNmN3eDBH?=
 =?utf-8?B?b1pmcE9DcDFQS2lWQ20zY2FBOWRsei9relpJWFZWckZIajF2Qk9ua2hrdTda?=
 =?utf-8?B?alZTS2FPTjM3UmVVcXlMelBoRHI5aUFyejI0RUdiVTQza0xqZTh3bXE2Tmtl?=
 =?utf-8?B?dWlNS0RXMGlEN0lHMEcwenJkYmxvVjQyZ2dpam5FZ2JpbjBZZ0dQRTFJZVNq?=
 =?utf-8?B?MEVwakJNcU5WT05MMEtIeFpFcS84TlRBcnBPaG43b3gwcW9yTWc0MzM3Q1Iv?=
 =?utf-8?B?VEVUVDZYemNHUGF1M1hndEw4dWNCTmpGM0FJQkdlejVOalVRLzZwaTZKRkJm?=
 =?utf-8?B?OVJhZW0xZVp3MFhQOXNOcitqLzY3L3Q0SzlJdkpUZUJZK3I0U1pOOGtiNmRr?=
 =?utf-8?B?VEplY0NjZ28xNzc1RkRuOUFxbm45ai96QlBqU3JscWkwYzFKcjc2ZHRQODFP?=
 =?utf-8?B?QzFmYmdKM1dGZ3I0djJENEtucTNCUVFsMFhrWEdVMUo3ZEl2S2hmOUV6T3pm?=
 =?utf-8?B?UkpRUk54TXRxRnRRdmJpRnBzeXdjdHhGQmxUSFhoOEtwK3hGR05lMlRINDgy?=
 =?utf-8?Q?02Be2FpS/+YTSmCmq8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGxCUlBvVHNOM3NleWNxY3IwYUZMcGtNQTFKREtxSGJ6cE9QOFlYL2orSXA0?=
 =?utf-8?B?Y2puZ1JUVS9vZVA5bWNzL0tYdDR6N0FMV0luS0JBSTEvcHhVTzV6SFNHWUNL?=
 =?utf-8?B?NytRTlFyalRsWFJZYmpJQXB0TFhxS2kzWVppQ2s4U0JmQ3hhNXlCejdlYkF0?=
 =?utf-8?B?bGtQM1IxSGljcFRBUDgrMTltNkNiazZCQTRsWW96SHpVSXQvWjR4MGFlRzJZ?=
 =?utf-8?B?c1ZtREYyVG1FSVhnSjFnNC9FZytaMkd0UkJHU0krd0d1aHhoamZKam1RQ1N5?=
 =?utf-8?B?cGJUdGpDWVBKWkZQOVd4c2VBNllndG9Fci8rYVFjN0todmNEcmM2RXVVMUJL?=
 =?utf-8?B?RjN0TzFiK1JPQ0FKWmJGaFJ0V0Q2UGtRNXpCSE16a1ROWm9ma0l6MDdGbllD?=
 =?utf-8?B?UXVMYUdRZTkvWm1XVGdNMUh5UWp3Z0VYYktOenYwMUNFNEV4SnlXK1RTZzN1?=
 =?utf-8?B?eWVVRFVQRDFmQnpuRlhoYldhTVZBc2FLajlkdm5uMzJnSm5WWFZVZitQME9o?=
 =?utf-8?B?bldRVEVRdkNKZFpFZG51NTUyVVhnM1hseDJIU0JQWnJDeHdmcWZMYTFzNlla?=
 =?utf-8?B?NkZZWFhkM0ZqbjVaUjl4V2l1NHdHY1RVYnhtaks1TEhoOTJBTVE2ZnZ6RG1U?=
 =?utf-8?B?TG1jRVJBM1UxTEtFL2NyNk9XS1lHbC9BMHQ1TEtnKy8yVTZZdTF6MzJVcmFa?=
 =?utf-8?B?d0Z1NVYzUjQwOThMdFBLQnA5bFFkc2tTdjlaT0YzV0wwUjl2Rm5ZVzdORCsz?=
 =?utf-8?B?UGNDM2RtRDQ4SElIR3pKL0dwNXM1by9wQ1hEbzI3UHdwRVI3VnlxTnNseVBF?=
 =?utf-8?B?QjdxejlvL2d5L0lueUowSm5RcFhEaThTQ0lkblVVNUtuSjlXRzFocmtNby9V?=
 =?utf-8?B?TXpBSmVoa05sUGtrTUQwS3hVUHdETWZudjhaZml5M1dmcklHZkFGaUtDM2tM?=
 =?utf-8?B?SVg2Ui9KdHBncmZOWVBreFlHOUl5ajd2TjE2VXdzK2FpSm51NEhMVnhNTTR5?=
 =?utf-8?B?RGJzSmxBc1BCZDM2T0F1REJTN3U5RUFBVHBzNFlIdlJ1cTZXWEdEOUVneHF4?=
 =?utf-8?B?dms2MzNQRmJHdjlYSVpCUUt4UnFtWUNUbFRZY1NCM2ZEaUNheVhOWFdNTTBQ?=
 =?utf-8?B?L01td2RNK2lOdkRHNHpJYzZJcTRTdFlTSldvemd2KzVZb2E5dkF4akhUTDF1?=
 =?utf-8?B?RjVWOE44WFJMdkpoQzU1VDdDOFkrczZPRkhNWFZrOXhmREZxR0pVL0ZKS2RX?=
 =?utf-8?B?UVBjekxkWE1PTFU2TUg1VHZkd1FvdHNkc0hCdDRYZFhjZE5ta0YvUVBpRk41?=
 =?utf-8?B?YjdSUWtKTnJiT0ZhZEVLWmx3TVFDWVJLTnMyVnN0TGZNdFBBTTMxc3Y4Wk1p?=
 =?utf-8?B?aGhTa3B1ZXZrM2ZnNXptUDJBZ2ZmVjh0ZTBzN2ovK3BmUzNqMTk3b1pSdE5p?=
 =?utf-8?B?M0lmZi9lN1g0QkVNcHliSEpWdnFyVURhSXhCOExvVndmdW05VG5WWVZFZWNK?=
 =?utf-8?B?bFBqd3EyRHdDeFp4UlZmVlB5ZE5WODZ5cEdCS2NtVUVmMmhad2JlcVFQRGFw?=
 =?utf-8?B?SzdCeXR0RzA1cTlsRndzYmhnZytFS2JvMkJ4MnlaRVFoOG90cUV2V0E4MGZ1?=
 =?utf-8?B?M1UrUXJnZHlhM2RIVm1xWnJTbFJhTkZUUkhaL3dvM1FMOTdmazhjQ3BGbnJH?=
 =?utf-8?B?TEFHRzBhVDhRL0d0QlVpMzVWM2VvVVRpY3R0MDVBRVZJdTZTSkxML0FYUVQz?=
 =?utf-8?B?TnFEaXBKTXNpSmFZdkZaYjExTmJaSmVIT0tzUVVLOFFTVHBwOHNFZEVMbEIx?=
 =?utf-8?B?bTh6SW9ibGNla3orVktHYXlwbno3bVR1SXJiaFlocHJMY2ZkUEZIa0FuNHo1?=
 =?utf-8?B?amN3UWNESDN4aDNoR3BFcFJ5cTVvc3R4dks2RjNhM0hWUFFGRUM4T3lpS1V5?=
 =?utf-8?B?UGJqS2JMRTVmOTQ0a0RBaU9NbUdDZElZQW1zN2laWDF6S0ZLWktEWDBTcU9u?=
 =?utf-8?B?eG4zRGFMaWRxb0xocU1MRnE4NkI3ajVXU1ZjOHYrb2Zzb1FYWnEvOHFKbEtt?=
 =?utf-8?B?ZXpnK3VZalZlQkZ5RWdyNTV6WTVoQ0hxZlI5Yy9iRWpNaWJlNHFZLzhuMXBY?=
 =?utf-8?Q?9hdtQLGVXTvqNwrRoUWs7jTNq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e92f43a-95b2-4f15-74f6-08dc9a99c9c5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:20:48.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OBm418KAvqrZreRBNfd9nqEdV72Rwj9TLdam6W14i2qzitr9R8mUAmXjhxSfOKMMT4/MHmmaGYVL3ZWxFZBgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077

On 7/2/2024 4:23, Greg Kroah-Hartman wrote:
> On Tue, Jul 02, 2024 at 11:15:14AM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Jul 01, 2024 at 04:53:20PM -0500, Mario Limonciello wrote:
>>> On 7/1/2024 11:13, Lars Wendler wrote:
>>>> Hello Mario,
>>>>
>>>> Am Mon, 1 Jul 2024 10:58:17 -0500
>>>> schrieb Mario Limonciello <mario.limonciello@amd.com>:
>>>>
>>>>>> I've tested both, 6.9.7 and 6.10-rc6 and they both don't have that
>>>>>> issue. I can disable CPU boost with both kernel versions.
>>>>>
>>>>> Thanks for checking those.  That's good to hear it's only an issue in
>>>>> the LTS series.
>>>>>
>>>>> It means we have the option to either drop that patch from LTS kernel
>>>>> series or identify the other commit(s) that helped it.
>>>>>
>>>>> Can you see if adding this commit to 6.6.y helps you?
>>>>>
>>>>> https://git.kernel.org/superm1/c/8164f743326404fbe00a721a12efd86b2a8d74d2
>>>>
>>>> that commit does not fix the regression.
>>>>
>>>
>>> I think I might have found the issue.
>>>
>>> With that commit backported on 6.6.y in amd_pstate_set_boost() the policy
>>> max frequency is nominal  *1000 [1].
>>>
>>> However amd_get_nominal_freq() already returns nominal *1000 [2].
>>>
>>> If you compare on 6.9 get_nominal_freq() doesn't return * 1000 [3].
>>>
>>> So the patch only makes sense on 6.9 and later.
>>>
>>> We should revert it in 6.6.y.
>>>
>>>
>>>
>>> Greg,
>>>
>>>
>>> Can you please revert 8f893e52b9e0 ("cpufreq: amd-pstate: Fix the
>>> inconsistency in max frequency units") in 6.6.y?
>>
>> Sure, but why only 6.6.y?  What about 6.1.y, should it be reverted from
>> there as well?
> 
> And have now done so.

Thanks; totally agree with you.
I just didn't realize it was backported to 6.1 also.

