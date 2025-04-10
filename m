Return-Path: <stable+bounces-132081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90C2A8412C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 12:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F9246242C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 10:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8C9267F7E;
	Thu, 10 Apr 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5dF/jMhb"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B11BE251;
	Thu, 10 Apr 2025 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282117; cv=fail; b=cLKSauroWLFHi8qYvWjTw7xdXG9qR2G+JS3t+Gmjc2Y5EW9LkirjO2ZrvBPA25kohOdF6N5KUsoJl1zkBRIW4LSr801abJvgfqEzKZvEvgl6i/hj9WxFZc3Tm/gOWbZL11806ZjfAcDX3hMcE234lB6CHH9OHDyXZELftEkk9xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282117; c=relaxed/simple;
	bh=145F9OisA2/cVoxEbOjKKUIvuoajLhpuDQH4yIUIENo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7/53TV5OybeQy0+AZKZrsaUSHpUF8FtvcSFSzl/fSaidLTQMnwCmATvW5mYRMNAoIxfQ10E8TyQVGTt7e/qOYhKh8HcXUh4IVK6AndQIDp6pzLBgNso0kXG3hXmZLwBVwGSpQPE3vV3ROvRlqYegeaRyGG5H7Qv/09reE5lVrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5dF/jMhb; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzKLp5iPK8NuNl/XAc3qufa1PC+2C7LTTDDH8sPGncPWUD9c9sMUUsoDKsjJasYnpnxWe0NtEwogWWP3i5tOiNeEUazGc1V39uaEJdeO/uC/a7YlkcOxljMzi/v8JEh4bT0J86q3YQ932PZpdAVeF+1S1JtgQSZHGrpCLQrAG4wFqLUpeyl3WQfgKMdpB6RZ+p8wYy0EaLoeoj/zYIA7um+hySM1+qgfBkWyY6EzRCwft5NUVr8anndV5+23V+sUSgWIuHK0rPsbW0MzvMKCwgSEc9HJvvWDJFXkvJAHGRI+GI3oblWfwbYon5nnXzwp+XU5/VocpwhWhniRnzeVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvKfnt27iN0knQFqzvLRIxtxnr2ckh+Ps13MT/cqzTo=;
 b=k2vyz+/HA55geMRqERzp6w5rbnLipsL2FXJfv8WiIc2Q2OKL/WFZ5Q5CL+A+bGq9TLwgbbd1Ml+Vas6DPoQNS2F8TYbIeDkNuyY5pMTu4nMsceRu3Rh29xu1H7c/7tAdqclQOqJXbmRw3TWjIBOZvTvDkMAR+wbs9ntrUCVhTTKshkRbY2zlWeagsYOTwjPLBfAVkRASPPgiWIvw+LIi8rQg9/d9+JAWVcofUED66PjkvvoKv5m40v6+1h5xrxagFsVZ4QO2d3lCRQzOjnJE43ONVWkdH6Wi/xiJxNP9wzniUD9AT9rW1wmFGajV/0lwOTZp5heI4T2mVCwA5vmkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvKfnt27iN0knQFqzvLRIxtxnr2ckh+Ps13MT/cqzTo=;
 b=5dF/jMhbiLEB5uca4M/Yahr3NFrrhfqhdTw1cAghNleUjbhYvy3OcY7ciz9wEM+9uxSWMRhZXGdabzSyz659nMUBGbZtVIjZG6vEZBAvmpCUumQ5eYnm2gBvGBZrw/htmAyazHEACqFYgB82fgbHV3ey4QCAUHUNcRUbD6EagDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 10:48:32 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%4]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 10:48:32 +0000
Message-ID: <2d1e2122-0308-4b13-b87c-54b64c4f1901@amd.com>
Date: Thu, 10 Apr 2025 16:18:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Brendan Jackman <jackmanb@google.com>,
 Mel Gorman <mgorman@techsingularity.net>, Carlos Song <carlos.song@nxp.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
References: <20250407180154.63348-1-hannes@cmpxchg.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250407180154.63348-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::19) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bf1f2a-1f59-49c7-602c-08dd781d3c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWhOMVZYVHVrMG10cVBtZWt1d04zN3JqWTJKdE80VWZNSHQ2Vlk0V2Nxb0FK?=
 =?utf-8?B?R1JlZUhva2FMUVU4UVNsaW5Tb2R1c0ZLdDdMckEwbGQwYTQwNitVM1dKYjJn?=
 =?utf-8?B?ajhIbDJ1cTZrK0pFRzR6bXVGL0hRbjdWTloyQnorejRlbmlwQU9uSWhEcHIy?=
 =?utf-8?B?NXBGaEV3cWxLbitOVDBnMWpIUU1hdkRHQmtETUZnajlSay9PZjhsNTRiVjNz?=
 =?utf-8?B?VUVqZEp6VUlnYk5lamdpWXc1cmhkN09iL2lKbHF2N2JKK29HeGZ5aUJTV3cv?=
 =?utf-8?B?dVQrUXNCL1lHL0FLUVUxNUZocnprZFFTYThRcFpZNEpXQm4zZ0xTQjB5eUZu?=
 =?utf-8?B?cWFoVlNnWHQwV3hzZ0kyR1NKSjAzcHVoZjdLNW1JakdzbGp6UHlnSGpkWndK?=
 =?utf-8?B?aEM3UjhCSjJZQ1JURHZtODB0ZUlIQ2F3bnZZbGVQclNzMDlIM2lxRGd5QzdB?=
 =?utf-8?B?a0RmMWFPcW5QRnpEN0xmVmdVaHBYbVpMa3MxV2JIaUpLNWt0enM2SHVOSEpt?=
 =?utf-8?B?WXRjQ0kvMllaY1JROHRXZGE0N3hwb0RMMUk3ZWVBTVJ6U01tYVBTTFlWdlkx?=
 =?utf-8?B?Ui84dmM0ZW5wZkgyY1ZUNEdvVUZBTUQ2NkRKT2oxbTdObDF2SXJXeUc0Rnc3?=
 =?utf-8?B?bUxadE1vUXNZc3AwdVRJWDQ2ZjhCc3lhTlliTnd2R3NySGM1bUdnaVordEN4?=
 =?utf-8?B?bFEzZk93b2hlUVRscXRkZ3hYZUdHaURXUGxrSEpseEZENmVoQmgvajZJUjd6?=
 =?utf-8?B?VzVGcHQ1SnhNb0VTaEJ5dTBNZ1Q2VkRiVHc5M0F3M1J1TFF5b09JYTVaUUNO?=
 =?utf-8?B?eGs2ZTZYeit3SU4wM3QvKy9DVzgyWEtPa1plTElQVzRmUzlDQTI2Mlh0ekZ5?=
 =?utf-8?B?THE0OE9mSGVNL0plZTBaQ240OTR1RjB1ak9SellERVluNS9lWHcvQk42OWNa?=
 =?utf-8?B?RmlqRStxbUtobndWMUc1eG84WjYwRlZjaFJuaFRCMHpDNHNKU0dCQjlTRWV2?=
 =?utf-8?B?YkJSRlN4SXUxaUJpaERPYlVxS003V2x1ckVUSDh2bFZtRVFrSnV4N1hJLzRV?=
 =?utf-8?B?aWl5ZEtnTHZGNG1lbVdrdVNxS2hMeExlcU9iMXk1UlpqSE9KbU85V1N1UlV3?=
 =?utf-8?B?QTR6b09wNklSVE9ZbUZjd1NEWGtuS3pPT2lQMGhjQnFUTk9vMjJDL3JkU1d2?=
 =?utf-8?B?Zi9DQVZhSmZrdFFvTFpNalZ0SzRrL3JrZ0pnZndZcC9SZmoxazkzQVpWQnF6?=
 =?utf-8?B?R1AzN0p4SzF3TWI2VktLTjhsNkZnTEVudjJ5cit4dEtxaVpFc3YwSVQwWDM0?=
 =?utf-8?B?Nmc0VEp3QlFWVE9CYkRleFQ0Q3gzNnBSUlg1NzVreVN3U21uem9oL3lZZFhu?=
 =?utf-8?B?dmV3UnVVT0hvNllPSTdjaDZOQ3lXWGoxVzNzcWxoRUE3dVZVRlJjYjJLT1Fw?=
 =?utf-8?B?SHNnUjV6TTJBQ2s1Mk5MUWRoTndxWnliaW9OTHhMa3g4T0kvNE0vY0wvaVJT?=
 =?utf-8?B?OFZOMFh2ZVhxS2c3dUkrdkZrTE5nWXVhcUZqSG1vNVV6WElJNnBSdGVIUWxa?=
 =?utf-8?B?ZVZ1dHBGanFOU1hHbm15NjdQTmRhMHp1L3RXemJ2WWVKd1Zwd2tEYkxpYkJ3?=
 =?utf-8?B?VUR6cVpsYUhQS2dKTXp5S054NW1QWFNlNjRDdjllVmZmakRuRmsvakJSQksz?=
 =?utf-8?B?NEYvYjZ3YXFLVmlIMytoeFdyamV0V2VBa1Y2WE1OeUVqbmVSSTBuQVd1Zm9q?=
 =?utf-8?B?SG9BQUh5VU55TVFkSlhwMHN4YWxiWVF6V2NRU1NnNCt3ZVZOSzBFeWhUTmFK?=
 =?utf-8?B?OW5sY3JDVzFwUVZ4Qm1lelI4L1NjcVZsTmhkUHR3TE9MdnZUTGVoZURnTjBm?=
 =?utf-8?Q?DoDTyGnPSx6OZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tzc0NENoRjNWT08vRjA3ZFZlcUpXVFJXNU1LSGJrS21mM0MyMVB6SGZzbVRh?=
 =?utf-8?B?V2VGYU94N3F6NXRvek9lWld0dElDVENLb3FwVTQvSFlBdWYxS2l0bjE5Wk1L?=
 =?utf-8?B?L043akU0cjZja1N1S2tQRWRyM09lbEdiYjlxeG5qa3ZMTUtEck9CbkNKYmFD?=
 =?utf-8?B?bHRDVkFGTC96MXQ4a05HWjY3QjZXaUI0aTlGd0NOcDU5clQ4ak1CUnp2TW50?=
 =?utf-8?B?NHFBY2JldE5nMEQ0ZjZyQzBhZUYwNDRkeXdSemg1bGM4NkErOFVhYk9FbnBO?=
 =?utf-8?B?R0h2U2VQZDc3UWxtK09aZmgvc2NscWVBbkJpdWN6Nmc3enlKTWFDVmNoTFlv?=
 =?utf-8?B?L0NrdHFzVlVDaE1rVTZQNkVkTHAvdHgyTU81bTRvVjhNTzhIdjZwdnQvdDRr?=
 =?utf-8?B?TWJjMFphL2pZb2ZrYUphUUVGODlBZXZJSTNhaWZucC8wbFNqMjA0U2dwRmJN?=
 =?utf-8?B?QjExR3U2TDJBdERMd3FZWkdrcHNPRHhPZHVFR1ZJN2VVMDZ2Mi85WHV1RDZh?=
 =?utf-8?B?YVdVODFDa3Q0YlZlT1U2a2lBcVVVaTRQNHVSRlhHblY0dmpqL1pRaUZqRlhG?=
 =?utf-8?B?SjhscC9uclVqUXYzM0JKVjZGNDc3elNnb1ZsQzBPMi9tendvZVJkY254d0pH?=
 =?utf-8?B?Y1N1OVpRS2VYaWVZK28ySTF0Q2FCSTIxMVBTdDlCWExUNU1lQ2NiNThqUTAy?=
 =?utf-8?B?VlFtUUxTaENrd1BreHAvTTIwV2lrTDlSVTI1allCMXNhYndTZlhIRlNwcXNS?=
 =?utf-8?B?TFpoRm9qUlVpVVpsRmdMOXJLVGF1bHFzTjIxUmxLVVVNdWhhWkIvVXRFSWNI?=
 =?utf-8?B?cjRRQWdVeUZuUjgvZC84YWd4b2tQcjBxZWRjSVZxVndCSWE5RHA2T1plTklD?=
 =?utf-8?B?blB2Q2NWSnliNjE3cDZIb2VkV1RsNkxnY3YwRDBVSFpBMml1UXJkNXRvOHR5?=
 =?utf-8?B?N2JlV0JaN0VGRUZqcWtpd1BhSDEyc0pTSFFENTY0eHFRd0hiUFllNytHM0JX?=
 =?utf-8?B?eW96TytubGQ0SFlDS2c0eTNCdFY1bGpWOG5xOTE5cGJTV0t1L0E3Q1ZtaDBm?=
 =?utf-8?B?ajFXL3NwZlFFdXVOYWk5cEZPcUIvdjlCQkQyNnRORlZ3dDVIalFKV3UzWnpH?=
 =?utf-8?B?TzdnRmd1SW8rTyt3eGZ5Z0RRcUtKc0U1cDBjNFJiTlc0K0EyK29tcVp5by8w?=
 =?utf-8?B?dkQvYmg5RlNqM0dzTGlEV2lGb0pMSnV5d3pQbndoSTZ5QVBMN01TYjhhblNR?=
 =?utf-8?B?a2l2WXYzVDBEb3ZLUjEvbG9FS0RIbnVpdEMzMExRQ2VyMVl0Q3RYUysvaUg5?=
 =?utf-8?B?b212Z0VpRXlIeHRscnYwMTFiM0VzWm13NTg2ajR6dGNDbTFweHdYK0JhZHRh?=
 =?utf-8?B?My9QUHhjTjVCaHAyQ1puc1hJVHUvYWhKczlLL2hIblBTQmFrdWUxQTQrd0c1?=
 =?utf-8?B?UXNROVlYVlZHU1JoZEhjY2gwZ3ZnVm5sdk54ZUlLYjJPOVU5aksySFlzOWR0?=
 =?utf-8?B?WWt0c2psK1hwUUg2Z3hFWFNGM3RwQkFGRDViWTQ5RjRWVU84KzBCQUZYNHZw?=
 =?utf-8?B?SDNtWEZ4RE5CRkhxT1oyUmN5Sy9qS0luRW5aQ01tVDZFQllYVEZ5RFZJQW9m?=
 =?utf-8?B?ckJDQUNHcVJpcjF1WjAyRk9QVDdSa0dHOEJkM3FnaER5MW9QTmg1M2FrNEZz?=
 =?utf-8?B?ZVkzOEh4Zk5HTTdycjRGN0R4ZGJDbEhvZ29qTXNQUWJCS09EbHhRODVVZnpV?=
 =?utf-8?B?NWZ4d3ZBUXVIQXIrSW5ieTlGUUlVTkZrOVlWN3F5d2wrMG5uZi9OYXFMcXpC?=
 =?utf-8?B?dUJUUmVPenNJbHJLMEJSc1krck4ybVZZcGVCNXoxeFVGTHFNc000czZWbEho?=
 =?utf-8?B?U2poakZIK0tBUEwzYWMrYjZpbjZwRGFJSEQwS2FMb2U0bkZDNUZGeS9YSWtM?=
 =?utf-8?B?dURTM0x5eVY1Ukhnci9qMWJETS8zR09FeHBDVWd4ZjR2Tm53VjlMNGtwUXMr?=
 =?utf-8?B?WGRRbEJScW1FUzRsTVZjbXBhUWk5d2xhaEdzeWdHQ3RIV01tV0ZUUW82TGpt?=
 =?utf-8?B?R3oySEVUVUx4Y0xoOVF0dTBjRXBwSVR5ZkluQXMwd3I0SkxLZFVRMTNXcVM2?=
 =?utf-8?Q?+RTsYAT5mGbGUvusaNgU46R5e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bf1f2a-1f59-49c7-602c-08dd781d3c6d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 10:48:32.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CS1v0bVk2zHGHa7C8Qf01QqLQITCMMDvwoXiU/V5HrahAW1wxMN4lvU2P21HwMJbEDa4nh1E/6aY6aE6GZzyHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460



On 4/7/2025 11:31 PM, Johannes Weiner wrote:
> The test robot identified c2f6ea38fc1b ("mm: page_alloc: don't steal
> single pages from biggest buddy") as the root cause of a 56.4%
> regression in vm-scalability::lru-file-mmap-read.
> 
> Carlos reports an earlier patch, c0cd6f557b90 ("mm: page_alloc: fix
> freelist movement during block conversion"), as the root cause for a
> regression in worst-case zone->lock+irqoff hold times.
> 
> Both of these patches modify the page allocator's fallback path to be
> less greedy in an effort to stave off fragmentation. The flip side of
> this is that fallbacks are also less productive each time around,
> which means the fallback search can run much more frequently.
> 
> Carlos' traces point to rmqueue_bulk() specifically, which tries to
> refill the percpu cache by allocating a large batch of pages in a
> loop. It highlights how once the native freelists are exhausted, the
> fallback code first scans orders top-down for whole blocks to claim,
> then falls back to a bottom-up search for the smallest buddy to steal.
> For the next batch page, it goes through the same thing again.
> 
> This can be made more efficient. Since rmqueue_bulk() holds the
> zone->lock over the entire batch, the freelists are not subject to
> outside changes; when the search for a block to claim has already
> failed, there is no point in trying again for the next page.
> 
> Modify __rmqueue() to remember the last successful fallback mode, and
> restart directly from there on the next rmqueue_bulk() iteration.
> 
> Oliver confirms that this improves beyond the regression that the test
> robot reported against c2f6ea38fc1b:
> 
> commit:
>   f3b92176f4 ("tools/selftests: add guard region test for /proc/$pid/pagemap")
>   c2f6ea38fc ("mm: page_alloc: don't steal single pages from biggest buddy")
>   acc4d5ff0b ("Merge tag 'net-6.15-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
>   2c847f27c3 ("mm: page_alloc: speed up fallbacks in rmqueue_bulk()")   <--- your patch
> 
> f3b92176f4f7100f c2f6ea38fc1b640aa7a2e155cc1 acc4d5ff0b61eb1715c498b6536 2c847f27c37da65a93d23c237c5
> ---------------- --------------------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \          |                \
>   25525364 ±  3%     -56.4%   11135467           -57.8%   10779336           +31.6%   33581409        vm-scalability.throughput
> 
> Carlos confirms that worst-case times are almost fully recovered
> compared to before the earlier culprit patch:
> 
>   2dd482ba627d (before freelist hygiene):    1ms
>   c0cd6f557b90  (after freelist hygiene):   90ms
>  next-20250319    (steal smallest buddy):  280ms
>     this patch                          :    8ms
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Carlos Song <carlos.song@nxp.com>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block conversion")
> Fixes: c2f6ea38fc1b ("mm: page_alloc: don't steal single pages from biggest buddy")
> Closes: https://lore.kernel.org/oe-lkp/202503271547.fc08b188-lkp@intel.com
> Cc: stable@vger.kernel.org	# 6.10+
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---

Tested on AMD Zen 3 EPYC (2-socket and 1 NUMA node, 64 CPUs on each socket)
vm-scalability/300s-lru-file-mmap-read.

		Vanilla		Patched		Change
Throughput	32267451	36112127 	+11.9% improvement
Stddev% 	2477.36		2969.18		+19.8%
Free Time	0.144072	0.148774	+3.2%
Median		227967		249851		+9.6%

Tested-by: Shivank Garg <shivankg@amd.com>

Thanks,
Shivank




