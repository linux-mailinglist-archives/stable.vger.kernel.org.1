Return-Path: <stable+bounces-45442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E48C9E4D
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A75B21FD9
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85445026;
	Mon, 20 May 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z12bAm7K"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78C1E87C;
	Mon, 20 May 2024 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716212612; cv=fail; b=YKWY6h2hm8N78bp9Tn8OjyAV7eqcsu9l7A3eC4GIoYeoUWzSDBBlMSHlp0qnw29o1pLfhhlR6ZDHtTmBrm5InOuMM4LQXb3rTqlHGIt0gGrSpUmcvsxKVKt63XoieQAXO32jq00QyCa+qL1pBKlmoAUMvBUdZnBmuZKHw5N8Pls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716212612; c=relaxed/simple;
	bh=nZEKZAIDOmZF8tb7ad5LCN8x8WO0Z6Mm9iqQZ0V2Spk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oe7bu8uPJpjxzWybppPFqO+CV6UuywgSqpHBvq0XE0+OIqYcruBoYbpm3soq2pkJLRU2zBOMSkSTuddvaGDFyDP2p4UXz4OnWj097ksoHD+y1PJ+rz4Ov2lSg85nFKzJKRfhU4W0k99MgluNFZRHkEsiLazUpGhrtEPQTxUugP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z12bAm7K; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNRTsCxmuxuyVC2I3J1o7VUQR2xy5tO7m3ol6nTK1uXGtm4MzM9QfMuGJaXHUI573xj1nbffFEM/hyCmjXMKPSdW4Sj9wT3bVZ0LnSMNnzvarwzrvnV855ihiCHfdk/JbidNh7IWoSQ33Xzz01G2sg8pGw1uuHoYRGPlPjBXADcQE/gQoZcmT2Y/2272Av2tZ5SMEg7tCsgP7GcuZmzohf7z9RnjfdkxDUQIakawuZ/vbZWvY+5M3Gwlz+WfRQ/lNzrVtOwzOKLLhyEqMJ5fEjag693sPpSbY0UW7r6HtVCa0JdIfcb2AD4vFEu+GkwYclrNz8WheT7yEJr5OiNE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KExpjFiX8x5OAFGEEJh2XmCH7fsYlMVuow9qzAUZjIw=;
 b=jjJ5LNcDg9Mnn1fD9POI1j7sRxlndZgUf0LBMJ2g5LaXfhkNHf9z7Zq51mm+YS9/RM8gCveug1byqD6Tu3oLIXmht0leo7MKuj4mzd/yopCm67VCuAq7VlbvVmCfNwhMyuiPk+tY3RuoF88XDx4ZaKRJVGCrOPAw/D6sj15Q2c48dO8Y1hDuAv4rTaZgu/dqSBVeX2FiVGUsSHoV8hVv/n3pKu3ZsbnyUVjQA6BuR3CjpRKyyek0WgOANfOb8Gq8cEqpPkimJtWLGZ2cOdCzbcEUJXjz2Sc8sN5JGejt2Q/S55KplGoN5qxg0N+oG/fPNMy/70ybvHqt23fFGbc1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KExpjFiX8x5OAFGEEJh2XmCH7fsYlMVuow9qzAUZjIw=;
 b=Z12bAm7KJIDIuHMZ+ibE1SfXvP1fc3DDUzfeMkWMMLilWA9A+hpl38ELQANkQFfLoE/5bBU1y9HsTCsZWOJrGdvcDKVFhwMFY39NLEJWyD+Il8Ap0b0TIBAVnIWazLblJCzvDI/76Wl/IJyKyRMYaPCvoRIygIoNUq/dyzJG5EM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Mon, 20 May
 2024 13:43:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 13:43:28 +0000
Message-ID: <9659dd5d-af8d-4100-8fc1-ceca42223827@amd.com>
Date: Mon, 20 May 2024 08:43:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Thunderbolt Host Reset Change Causes eGPU
 Disconnection from 6.8.7=>6.8.8
To: Gia <giacomo.gio@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, kernel@micha.zone
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <CAHe5sWYnbJAjGp66Q4H0W_yk9uYTcERmW=sPvJSWTsqbFZFCVg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAHe5sWYnbJAjGp66Q4H0W_yk9uYTcERmW=sPvJSWTsqbFZFCVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0117.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a52ad10-1efe-4584-d549-08dc78d2d42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVN6MjREMDFlYkQ2M2NxVWV6R0Fna2wvdEFOb3o1OHc1T0t1Zys1ajJIcnFZ?=
 =?utf-8?B?ZllvTXducjRCa2dTSGFtN0JkWGJuK0hrbWFPT3RrRUJRSlVQaHNRVEhJcUxt?=
 =?utf-8?B?bnJieFAzc0Vzc2JvRVpFc1grNWFXY0RuM2hHU21VVXVZK3ozUElYUHJISGdE?=
 =?utf-8?B?WkNPUms1QlFBNU9JbTlmY3JoMHFXczlCTmNmR2hwa0VBZDlZRVZRU2ZBRVNi?=
 =?utf-8?B?MU9LWUFuQnljYjVRYitURDRsUGJmZkdxdThHMFdnV3NoQmswRlB1b000a2pF?=
 =?utf-8?B?djJha3pEcEpRa1pyY0VvOENqMjcyLzVEcmpFUXJKTXBCUXFKWXl0alV6ZTds?=
 =?utf-8?B?NmcwUWpSenhwTThUM1lnZFpUNFhvSGhJSVZXSG01dHBqZHBXZVRsNXAyaWZ4?=
 =?utf-8?B?YjE4anRHY29SZXFEcm5DVlZDWitNTUJNWkVkRlRpMmY0VjF2ajFjbTBKTDlx?=
 =?utf-8?B?VlJNTTdhc1JnRUpLcmloWU83WGRmam00OVY5M1FOTXUvWXBCTVJ5cFk5Rk1o?=
 =?utf-8?B?Q1o4d0M4b0UrNzc2TFVyaUt5ZUZrd0d1OGw0S0hNVzZvTHFJbjJXSUp1c1VC?=
 =?utf-8?B?M0xYcWxSdnBSVmpQakF5cGRZWC82MVkzR05PZnRCOVNrdDFKQXlISjhSMlNk?=
 =?utf-8?B?S2ltaTJqWUVENjU5S2c3NFN1T3JkQ2FmOGYyMjBZckRpUkRpSllYQllUVGZ1?=
 =?utf-8?B?NWpsakc4WmZqeS9oVkpqVk56VkZwY21EalhIU2hlcmdMcE56bFhDRTFnTkR0?=
 =?utf-8?B?VmlrRnpuYzA0YnFyZWZQUitQcUUxdWRiRGpvMlRMeGpqdTJTS0RkeUpEWmRG?=
 =?utf-8?B?eFVEcXdoQ1c0Nm9rQUV5L3NiWmVmb2FPV1RadmRqbko0MmhRbmo0TWJGMXdL?=
 =?utf-8?B?elZVR04zMXBvTDJqQW8rejRrb1FkazNNQW9HZXBGQm1ZRnlhWWh3VzFzR2ZB?=
 =?utf-8?B?aUtJUk0yWlA0TFJ2ZDlKTno5RUo1T2ZkcEFKUjVTUDhHaHdDSmxXU2tOTWkw?=
 =?utf-8?B?NkJ0Qnc3dVh1eXdWTU1KNlo1UnBoSEpBWTFKcVh6NEhmNFVEYUJkZG0rV3NQ?=
 =?utf-8?B?S2E2RXRhZDdTN3BQRTFRMnh6K1ViVFdWZEZqeTFzamhRKytTN0FzS21oeTg3?=
 =?utf-8?B?NVdxTFo5U1FySUF2MHlQbHJEVXcrTmxDZTlKZktDaEFGL2JFU3lrNlZOR0F3?=
 =?utf-8?B?NFZCSjl2TktYK0NFV0RWdU1pdXVtVmtIdVdqcWFkWnZTeGkycEgxNEprREEz?=
 =?utf-8?B?MGVHbkptMGV0dGd5N1gzOGw5VFdISVRZNzZSZnFYUU8ybUFmK25hOWpVZDg0?=
 =?utf-8?B?SWsxdVMwTmhGZ2hldGJtM21INURHdVNpY3lHMmUxNEtmMDFmdWMvZTNnRFJx?=
 =?utf-8?B?azMxbEZlcGNiaSt5RGFZL3l2WVdMSnhnM09FMExldDlIQ05FMjlRQ3VJeVIr?=
 =?utf-8?B?RUxlMHJxMFdoU1lnTEZBdnU5K0NGUzFtVDFVU3V6czZlVHhvZlRNbzkvMWJK?=
 =?utf-8?B?MFEzem5veDRPa2xBdW5Jblhxay9iOUtWUFZyb2QrT2ZmVmZtcUF6M0RYRFJr?=
 =?utf-8?B?ckgvaWlOY0JIWW1udEcrYnltZ3FRbmc0S0w1RnJNc3UvMjgxUHdta1BXc3VT?=
 =?utf-8?Q?OCKlr4vMWl4djoWOYpCWD68qeKy+kUmWWHoWMoSrOe6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3paaEE1TWRIY1ErK0x6UEZubi82TzkzbEhGMFVEdW9CeHI5VHdHZldnZzUy?=
 =?utf-8?B?cmF3OGMyT1VSbjJGZ2Myb1llR2ZsMk9lanpkY1dMUzJhNU5DSXhrOHBHU1J1?=
 =?utf-8?B?OHNaeXVUSjFRR3E1Wkg4OEprdUM5bVU0NTdqVEFKdS80emNyblUzUFA4ODNz?=
 =?utf-8?B?OHArRmZZamFHcmNpd0U4WkcrdWN3MytBWDFQSnpJZ3h4TVIvYnpxMFRVZ0d4?=
 =?utf-8?B?SFdrMWpGblg1aHBVcWlXNlkwVnh2WWQ3NGFjbGM2YzU1alU2WUp3TElaTUNK?=
 =?utf-8?B?UXRORVZKdnYrZ29WcmhWd1NPZVB6eGRlS0cxNC9zQ3Y3UlA4OFg5dHZzWktU?=
 =?utf-8?B?Nkx2UlpPWU4veFIwbUN4MER6VDg4Tm5SRksxN01PaS9MU0lQMlNiMUJOR3Jp?=
 =?utf-8?B?YW1sZXBmdFZpOUlObjR6WmEzVHg0QkZ3R0Jhc00rNnNZeFA1MU9QR0wvZkw2?=
 =?utf-8?B?bEtnNjVrekFRNGUzZjBzaytzeXhEb0pZTVZiZFFjVmg0dm4wbUxqbWVEUGsv?=
 =?utf-8?B?YU5UR3E5S3U3RjhRejFQQ1VCMkRNQ0U0SHRYU3dvN3M2YUx4RGRiampoTDJS?=
 =?utf-8?B?cHgvUG1EL2IvQ2QzR0MyZm10MlBsUkg5d2Qxa0VQemczaXlHS083Vk56dzJB?=
 =?utf-8?B?TVRmQm9Db0w0UkU3YTlwVE5aRGVkSTdKcWhubmluOXByOCtMQTVOeFR1dUtF?=
 =?utf-8?B?emdxQ0ViSXBiOFYyMS9keGFNRXVFY3F3RzdDQTFqdDVjOWRxY3FsVDhaM1Br?=
 =?utf-8?B?SXZPR044RWNiSDFPOTNvdFNXanR3YlVqRjhKb25qUTE0Nlo4ZEJObVkra0dE?=
 =?utf-8?B?eGlFbjllNFNVSCtTZlZlM1FORlRMZW1yMTdReEt3OGh1RFMxTEZ1VWxvbXFV?=
 =?utf-8?B?c3BJZUI2UGwrK2dhQnJPUlc2akY0akk1ak5Rc0Z2TmNobGtNRGlZbmJXMWhO?=
 =?utf-8?B?U2g3TWxkcExIdXFFcW8rQVkxSVRxbGZGS1k0RHdIVlJBQWJOb1JGcElwVGo5?=
 =?utf-8?B?NnVHZSt6cFY3K0t4SGZTaG1pVWJaV2tmblZlT1VtU3FETjlWRG5hZXh5WVVF?=
 =?utf-8?B?YU5kSTlsdzI5KzVjVUsvL04zZmIrRWQ5bExBSncrQnNrWmxXMCtEVk1Oa2h5?=
 =?utf-8?B?N2g4RWcrRFV2MWdhQkJndHpGTU5wMkJrMVJKMW9MT0hkdk9oWHBUYURsUE9R?=
 =?utf-8?B?b3QzVCtnWGRUMUl1cUV3L3E1YXhjaU1WNEgwWTBLQjdEWHBoMnVzRExmTUlU?=
 =?utf-8?B?UXIxeTBQamVYSkxOT05lbjBxbERpZWlKdGd2dXRCcXlhWnF5aHNQNjV3Y2Mw?=
 =?utf-8?B?bFBLMFB6Tno1SFpWMzIycTJ3ZFpBMzZoUGlQZHBoOVc5NEwvb0dwVHc4MDdo?=
 =?utf-8?B?ZmQrWXZKdmwraUwzWWR1WStBL0VkLzh6SCtXUVlZUUlKbmlqSmg3Rk9LQ0Ex?=
 =?utf-8?B?N0dLVkdCK1M3U2xKaytsNE8vR1F5RzNNU2FNKyszTUlkRllpV20wV2NiU0Mz?=
 =?utf-8?B?cE5VTXVReXljUW1pSWlWcHRLUmpoVFlVLzNOcG5WZ2JheWYzYzR5eDNpWFFr?=
 =?utf-8?B?VGh6YkVUdTNTYjAwVHRDVGdOQytWZ25McFo4bHRBMENlOUhxWk5oT2x0VUYw?=
 =?utf-8?B?M1pYQ3pXTGxuencrUU5xTXhhcnlXN0JnZDdLUEkrYzZyYmFsN0w3UytqQW4z?=
 =?utf-8?B?NE9PYkdrd2c1Y25CblNUTDNPYWpZdFpscnBoZ1k3dFl3a1R5bENGa1JjNURy?=
 =?utf-8?B?REQvNVBQd056aXJpb2NaQS9RMVAvcmtoRFFtS2I5ckw5K0psVi9OMHJndnJD?=
 =?utf-8?B?VmFMcHJrOFF6VG5obWZIcUJvLzNJcGtMNVA4SmdSS0tZVmZHRm5RSFRWY2NU?=
 =?utf-8?B?WkUycXA4ZDgrUWtDNjJJbzZOaXl5aUl6WFlaYXFkWTU2QlJMd0ljbUMvQlA3?=
 =?utf-8?B?ZU9TWlU4ek5ncVNZWld0R3VNS3diNmRSMlRqYmcxSkp5OXo3TEJrVDVvOHBy?=
 =?utf-8?B?OVBqaUd5R0hpT0FTKzdQRnBDT2phVUpBKzF3a05XY0w5aEY1YjA4MkQ0TjZX?=
 =?utf-8?B?OGxWNXFHK1h6aFN6dE93ZTh2RmhtVGpWYTEzWnFPako0T2pZQjJVczd0VlhK?=
 =?utf-8?Q?DWo1Y+q2dA0P/+TESJeqZrWhD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a52ad10-1efe-4584-d549-08dc78d2d42e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 13:43:28.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/ZJHstFwCN9xBB3kPscHY/qwu9L91fJc+g9Epyn00mkqdnJKPEDSFU5QxnSvSpRjfoqMVklpygJUiYVoRLLeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

Can we please get some kernel logs for these two cases on the command line?

thunderbolt.dyndbg=+p
thunderbolt.dyndbg=+p thunderbolt.host_reset=false

Also what is the value for:

$ cat /sys/bus/thunderbolt/devices/domain0/iommu_dma_protection

That won't change in the two cases, but it will be really helpful to 
understand this issue.

On 5/20/2024 04:19, Gia wrote:
> Hi Thorsten,
> 
> I'll try to provide a kernel log ASAP, it's not that easy because when
> I run into this issue my keyboard isn't working. The kernel parameter
> that Mario suggested, thunderbolt.host_reset=false, fixes the issue!
> 
> I can add that without the suggested kernel parameter the issue
> persists with the latest Archlinux kernel 6.9.1.
> 
> I also found another report of the issue on Archlinux forum:
> https://bbs.archlinux.org/viewtopic.php?id=295824
> 
> 
> On Mon, May 6, 2024 at 2:53 PM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> [CCing Mario, who asked for the two suspected commits to be backported]
>>
>> On 06.05.24 14:24, Gia wrote:
>>> Hello, from 6.8.7=>6.8.8 I run into a similar problem with my Caldigit
>>> TS3 Plus Thunderbolt 3 dock.
>>>
>>> After the update I see this message on boot "xHCI host controller not
>>> responding, assume dead" and the dock is not working anymore. Kernel
>>> 6.8.7 works great.
>>
>> Thx for the report. Could you make the kernel log (journalctl -k/dmesg)
>> accessible somewhere?
>>
>> And have you looked into the other stuff that Mario suggested in the
>> other thread? See the following mail and the reply to it for details:
>>
>> https://lore.kernel.org/all/1eb96465-0a81-4187-b8e7-607d85617d5f@gmail.com/T/#u
>>
>> Ciao, Thorsten
>>
>> P.S.: To be sure the issue doesn't fall through the cracks unnoticed,
>> I'm adding it to regzbot, the Linux kernel regression tracking bot:
>>
>> #regzbot ^introduced v6.8.7..v6.8.8
>> #regzbot title thunderbolt: TB3 dock problems, xHCI host controller not
>> responding, assume dead


