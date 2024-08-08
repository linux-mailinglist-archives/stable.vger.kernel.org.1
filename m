Return-Path: <stable+bounces-66045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873B694BF7A
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6391C25A35
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B418FDAB;
	Thu,  8 Aug 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nrp8HGB0"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010518FDA2;
	Thu,  8 Aug 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126423; cv=fail; b=jvS1RQAOqKcLVKRrGx5nMP/VlyJjim7i/gUvmXhhGXyIP91MCC+IAftCgkPo+CuDwCIvqW2qvXAtfe4wuN2mqXpESEbjoRzZZ1k++fh7rNwdUYDQ/XCHnNUUPvGsdI7BnHDAXwfw2DX+VX7XCxjdb1VQjQuyd2k2JCmE6LpWsdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126423; c=relaxed/simple;
	bh=9jAWP7F1on424OI8fDrib+AB5IMfgn6g2Y2LCLltlqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YJzcQyOIjUbugcmzFv2j5817wb7o1tMIsuyXCbtiFE2aqSzdk6wT+AAcR87VRQva66mMQAtTKphBlISnpw00CrSyZioVSWVLZTtapAuSSCFzf9egeHYALN0V1a8UolNuv32EeSreWUncvrCAxaCNwcenN0cev9T6od5DSJiA0Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nrp8HGB0; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWs74urF6bZi6oJ0OzxF4f+0hosE2PfDs2S/OnF9H3y2FO2uPjeGgZVINlZ7iKSG5n1C6a2M90mUEf9kk8DLdiehiWxF8jvt/C7LubjPnP1mhYVJCt6IXMZah72IIVjCGLP/guA95zOiKqpreNmdtw012P7R7VD1OYcQn1JEKZZP8d2FSA5/U4fe6q3F6MGGJc60q3i9UDN0zgkNshrVSLo3aTCL0GDMbpf/MPJjZU6zTjcdeyPqQPFzSUlyFwycJHzev3Oz+tqv7ue8E6wAgz6DmnhyFlc3TycWNVZ+P3mHGuc0j8RGlJgmOyD5VYiCAKGTViDs1yhGkhNPIlzKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwIrj4TmF6mbSTe1cDEgpjbTMAkvO8TZAVVHdfGTDmU=;
 b=yVwBKqSoLAopmZln6bw9Jo68bqKs/nrRGTBzCjtJFXJ+8o/aYuIORMD8WJenF02knJnTZkxv8+fbycKHwrbt3EFUdktVmUDWR/TJVlkx1soHdGGYna9JSJ2PeeqYPxKWUQJ/bnnusUaufxvERwnP50FrnAmxhyLLUkDF8rt7QCGg6ICceuJy0x+67yf7hhkhAZLMbHGSOH0DWrvn4Ql9C7iaBpbGVC7ReaauzcEqC1lUJBINCG+ruzx6ZcR7wJMmhUOp9I+lx/ZNSWjE/wlYzs1aZpcptojppM8RDs/HnodDcg76jtp7AOzVbVxtxPjQggOMOziIhDkyOGll78MDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwIrj4TmF6mbSTe1cDEgpjbTMAkvO8TZAVVHdfGTDmU=;
 b=Nrp8HGB0aUeg1ZrVjEBU8tAJ470xuvdwD9z9cNLJ+OjrnPDcPkNZNZ3NxzderrdM1xPoMz2JJ32iP0lWcGxkbA7h8oE7FqZ+XYxlXhmmFleksBaEMDQkWmCsfSvBSWu9kK5V7+tVOSMLcXiSr+T7pPpEc+KcjsumdNG3cwm0BZa0qs5krz7dOMcyxYMUQWaCmJv8tyAfvToxWDapGFGvLAIGDr3QGIFGhF2h8uHX3c1cO4/v0BhT89WWpxt39lCfiqc5wjvW+9G5ZfGjeK1lUMY70dM8GmUMysCLd2p07xa+k3z+rDGpPhIPjR9mp+2cqOgLpJGMExMLQidf+B1jVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 14:13:37 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 14:13:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 "Huang, Ying" <ying.huang@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
Date: Thu, 08 Aug 2024 10:13:33 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
In-Reply-To: <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_98537D1C-E86D-44B1-B397-722D5E66F119_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:408:e4::10) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa28198-e3aa-46c3-c566-08dcb7b44b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RisyTkRyNGoxM1pYenVTZkJXWURkcks4NjZINzlNM3dwT2pQZGVYMDZQZmRo?=
 =?utf-8?B?QzVPaVJpR1d0Lzd5SEErQWJrS3VIRHQvOWhKVHNNb0JSWldOWFg3V2Job2Yw?=
 =?utf-8?B?RktaNEdpRk9teHVvbzZ2YVZ5dGJibGVoUW5pcFp6MFAxaHo2T2JKWHlNeDdF?=
 =?utf-8?B?RjJJQ2wzajgyUGZlS0lKQ2p1d1VERUFQWWtQREJRZFJBQjRRTWFYUC9YMXJQ?=
 =?utf-8?B?V1hwd3FVTmZTREkvYm5IMU56ajluKzF5eW54WFVINy9ndUJXeE5wSkRzZkFs?=
 =?utf-8?B?elg4KzV3eEcxLy95U2tIVjZ5TklyS0ZadFZIQXp1aFJzV0QzQXMzQUVBNnVX?=
 =?utf-8?B?bzB5ZGxkTm9NQklaS2VzTExvenpDOE41ZlVpQmtDRkdoalJ6ODl0RzZhVHlY?=
 =?utf-8?B?V3RiTWlJS0dUdTJ6Ri9qVXFWV3R3Wk84WmRsY0YxVXQwakpzNEpDbng3TUs1?=
 =?utf-8?B?MEpxN2hXSVh1cDJCbitYZHZuUEF4OVdIU2FUUjA1eTlDcTUzTTMvTzRHQXAv?=
 =?utf-8?B?dmtvSjFBR0NIQUNoR3RlS1IwQ1hvb1JzSmFqbGZITXBwOVJOQzJsUm01OWJI?=
 =?utf-8?B?d0thVGpLLzdGeng0Sm4rSSt0UDRseGhYODlhTWN2TDh0NXI3UnRnc2ErYTNF?=
 =?utf-8?B?aUo0M3FWS1RhLzRhd1AxelpkK3JRVXBmcFJOYWdqWnpzd2VnazlzQmZLSGFZ?=
 =?utf-8?B?M0I0eUU1ZExXWno5aHh3ditCeXhFa3ZxbVQyZy9jYWZROEJjOTd6NXFrR1R0?=
 =?utf-8?B?YXg5emRyUDEvanRTaEVlbnZjL3MxdENNRzlxTTJzOXFPbCtoYysrMkxRaVNH?=
 =?utf-8?B?ZXlrYldYMmswY1kvSWRTZzRjMjZwME1tRURGcjk2WklHRU0yREtNZm5BVURs?=
 =?utf-8?B?a1hLd0pZMnExK3E3aWlvRlRBdHBveXBSQlBIbFhSZzJYazdGdEt6U3h1RzA0?=
 =?utf-8?B?akh0MG1EVE95Kzc4R1ZaQmIyZjRDU0RZR0tvbmtKYmphOU1sNjYrL1hBanYr?=
 =?utf-8?B?dEZSYlpkV1NtNTBpdTdmV0VWVUlnVXhxZ0c3Q0diVGQ5N1BrV2o2WnB3ZmJR?=
 =?utf-8?B?Rk9IYmQveW0wa0dzaFdPMWZXWnVCYTVIUkZEWGVVZThwQmVOREx4VDZJUnRH?=
 =?utf-8?B?SmxtbWY4TEFyUmdYMDU3Y2NPZGxFa21DVzRHNHk5c1pVQ3JhcmN3aUx2Ylpo?=
 =?utf-8?B?MjFQTXRKWlhIUk9pRndldWQ5SGJIbk9TKzV6QlpINzJmN0JhMENvNFNvMG01?=
 =?utf-8?B?NFZzeW03NWh5V1VOL0RUTVRucG40ZGphUGM5SGVwNktJa1dUV3liSU1YWDRi?=
 =?utf-8?B?L3M1ckNUdUZYcm00MWtjZDRoSldqVWgvWkVicm1hZXBLcmQ5YUV1SUorMTI2?=
 =?utf-8?B?RUdOSDQ1TTI2MGlwM2hMWGUwU2RsUHJnMHVoV0xUeEVBMGt2TzYybzhyRURD?=
 =?utf-8?B?REZwYUMrdFRGdkZMTTRWdHY1aHRnR1pPYnB5N0JQVzlIdW1SQzBycUR3T3h3?=
 =?utf-8?B?NlYvRjY3OVpyaUo5UlFJN3N5c2FMdmVub0J6S1FWMHpiQVpNYkF2b3pMUUR6?=
 =?utf-8?B?SEphV3VqMGR0RU1mRmxTekJ6L1VsYW9qN2trVDRlb3orbTlSNjhSQTcxL0sx?=
 =?utf-8?B?SW9ZakJ2Qmk0cjNyK2taTys4anU4ZkZnMEhMK0NyZGdLL3hWRTN4M0VXNCt5?=
 =?utf-8?B?UnhtRzdaUXhoeFJ2NlF3WGgrcjZXSWZXZHhlN21aVVBrQkRzTXd2eFltS1li?=
 =?utf-8?B?amVXUDVmZmtKL3JFM3dWbzU5SXRMaGRIU2d0TzVOa1pIZDhDZVFMVjJTZG5s?=
 =?utf-8?B?K3M4R2RzQkwvdkhJTlhmdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cis1ODFZUStFZ2JnQkR4dWNyY0h1QTBiWjg2aTQxWjJBdXBqTGw0akQ2SHZ0?=
 =?utf-8?B?cXRoTmJyOUlpQUlrbTFJL0VDelpYZ1JZTmxjNkx0N3JEa2x4WEcrWVdBb05V?=
 =?utf-8?B?UVJrcWlMVVc2VUswOWlyN3JDaGpmYUs1YWpQU1pjdmd4RXVXNlB1eGtVWW5z?=
 =?utf-8?B?Q3JrdEJESzRLOWpDRVF4MUY1a2pVMy9kMXk4d2ZuT2FORkVSQXAxMnR1aWtV?=
 =?utf-8?B?di9kSmxXZW9QQnF5RkNqbFg0SXFFQmNHbGxBeGpEeTkxSUVYUjdCTTFCTXA5?=
 =?utf-8?B?NHI1VHBDaW5oRlBtelJubTgzaWk5NVZYdXFic1g1WlNGTGxWcnBBbmExSmJi?=
 =?utf-8?B?WW1zemRHTzErL093OEs3dGl2enIwbGNqMVlJajQxMXlHaVZRSDZkeDZrSWdn?=
 =?utf-8?B?djVEVDRjeitLV1h5Y2FPdkxyVG0waHRmTGJlWEM2Q1J5U1FoTTFQb3crUjho?=
 =?utf-8?B?RW5ydmRVUjgvM2M2MXF3TXcwTUJnRG5rZ2FwOVY5YXA3S1U5WEhjSVN3dk12?=
 =?utf-8?B?UTg3VzZhcEdwaTVldDNJbXVRQTNsYXprNk9JdFl2aXdacnVXempIYXdWdzRn?=
 =?utf-8?B?aGNvVCtia1NzWmhXTHVVWVN2NHBldC81TWYzdjFXUmN5MTFTK3FIQkpERExr?=
 =?utf-8?B?WnZzTWNkdmZGSUhxUUdYQU55Yi9jZjdsRW1ENGo0V2pZamQvZ3dDaHZXekRF?=
 =?utf-8?B?MUdxeGRaNW05eURtRklGMldNaDVSdlpYVm1pNE5aQ2pqY21qTVpvRVBVcmpM?=
 =?utf-8?B?eUpEVzBVblp4Yjl0T1B0T1F5cVVIRm1TdzRXQ21pYU9sZlB4bkdDa0RRbnJQ?=
 =?utf-8?B?SU5xQzN6VXpuSEl2WXlBSTFiRXczS0tWRG4vSDExODBhbmJWNFh5L05lZGNE?=
 =?utf-8?B?MENOWTZBMUZKZTFTTTBDWCtUbmxFeGJhQVpWSDgrVlZJdjFLSzhoWklpU3hy?=
 =?utf-8?B?WEhWQkt2Tld4Qi9uZmMxMWF6eDErRDg4VldFUUk0UnNCd0pPSUVCb3FiaHhh?=
 =?utf-8?B?Q205bGhmNER1dFQwODVaZ3NMcEZ4MDdOU0hFYlFzaVZwWUdSWEo1VUNicHNP?=
 =?utf-8?B?ZThRZmYyZmVmVElZTFM5Q1k0RUMzalVMR0YrT2tIY2Z2YmNaNDNjSDhMVSs5?=
 =?utf-8?B?UTNOT25jdWpPV2ZwRUdhSEJzcTk3QUNhZXZjaE5ZeFFHZEgvTXIzMHJ1WWQr?=
 =?utf-8?B?eVB0K1J1dXBHazlhTjJaaXpPdzgyZ2lFMDJvUWJlak84dFhkUlFKUnl6R0Q0?=
 =?utf-8?B?YllBNjlUQnlYS2YrSGJkZ2NTb011UGdJV2VieFl3cU5sM0prMGl1eEF4Z1Uz?=
 =?utf-8?B?d2ZVV0xWbmx6QzJDRUJ1eHlqbFpQaGxRRTFnRjloUXp0azY2RG9qZ0pBNGxC?=
 =?utf-8?B?dGgrdE1zZi9OdlNMTWpvNHFhK2hkcU9MSzYyY2FRVzB6MVp3YnV4WmRSeEhX?=
 =?utf-8?B?WTNRL1BwTktITWdtQ2I1czlZZEdabkM1VytRUUpkZ01RRS96dmhRRFFIM2Jr?=
 =?utf-8?B?VHJ6Y09RVU1PVXhIM0tWZ056YS9LaGVrNk1BakdQWWxOYWxXTEdhMFN6Y05p?=
 =?utf-8?B?ZmpXZmZ3ZjdHb1FJc3hJNnRNejFKSFFWOVp1N0xoR3ZQTmord091REJmQVg1?=
 =?utf-8?B?VVdXY0FUd05jRjVweldTSjloZW5BbVo3OXhtQ1Y0Njgrbk9ub3VoMnZXRFEv?=
 =?utf-8?B?VlRNaEw4bnhEUnFsczhkNk41K244SmpzS09lbzQ5Sm85RjBDbHE5R0UzMW55?=
 =?utf-8?B?MFlEWDE2UDRkdk93N09jQ1hWMy9jUE1zS3JGVXoyeW9qc1hicjVRSTN1d3pj?=
 =?utf-8?B?amc3UlpkbHFBTHp0dEFMWFhVcVpRemdZTUNuOWNtUloybHRkTjl6QmZBdWJq?=
 =?utf-8?B?aXF0UHFRMEpzOVVjQUNxbWxSNm11MnVpRWVKVEFPZmZHNGd5cEpxTGFqY2Z5?=
 =?utf-8?B?MnNPWms1SG02NnZtbytzZ0ZxSDJ6ZXBTSWx4bFhvbndvL2xlMVo4Q3RIdmRm?=
 =?utf-8?B?UVgyTGhTemlPTTJqMVNXSkNWbFA1MUIvY0xMNGNVekRPanVTNGNscTBzcnVY?=
 =?utf-8?B?aFBNWElFQ1hEVWdZQURxb3pVaEcrbStIYWRUMW53L3ZaRzErQk1nc2I2WW5j?=
 =?utf-8?Q?CJlGv/xqD+k9ZSJq+RF0tHpzc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa28198-e3aa-46c3-c566-08dcb7b44b81
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:13:36.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvGHp6G2fKZ9Y+JX1APNSLoT5iI8Pw12cfQMD5iCwSlbFtT8hlG5VHZdF91z8JZe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

--=_MailMate_98537D1C-E86D-44B1-B397-722D5E66F119_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8 Aug 2024, at 4:22, David Hildenbrand wrote:

> On 08.08.24 05:19, Baolin Wang wrote:
>>
>>
>> On 2024/8/8 02:47, Zi Yan wrote:
>>> When handling a numa page fault, task_numa_fault() should be called b=
y a
>>> process that restores the page table of the faulted folio to avoid
>>> duplicated stats counting. Commit b99a342d4f11 ("NUMA balancing: redu=
ce
>>> TLB flush via delaying mapping on hint page fault") restructured
>>> do_numa_page() and do_huge_pmd_numa_page() and did not avoid
>>> task_numa_fault() call in the second page table check after a numa
>>> migration failure. Fix it by making all !pte_same()/!pmd_same() retur=
n
>>> immediately.
>>>
>>> This issue can cause task_numa_fault() being called more than necessa=
ry
>>> and lead to unexpected numa balancing results (It is hard to tell whe=
ther
>>> the issue will cause positive or negative performance impact due to
>>> duplicated numa fault counting).
>>>
>>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>>> Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2=
=2Eccr.corp.intel.com/
>>> Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying m=
apping on hint page fault")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>
>> The fix looks reasonable to me. Feel free to add:
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> (Nit: These goto labels are a bit confusing and might need some cleanu=
p
>> in the future.)
>
> Agreed, maybe we should simply handle that right away and replace the "=
goto out;" users by "return 0;".
>
> Then, just copy the 3 LOC.
>
> For mm/memory.c that would be:
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 67496dc5064f..410ba50ca746 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *v=
mf)
>          if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> -               goto out;
> +               return 0;
>         }
>          pte =3D pte_modify(old_pte, vma->vm_page_prot);
> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_fault =
*vmf)
>                 vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>                                                vmf->address, &vmf->ptl)=
;
>                 if (unlikely(!vmf->pte))
> -                       goto out;
> +                       return 0;
>                 if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pt=
e))) {
>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
> -                       goto out;
> +                       return 0;
>                 }
>                 goto out_map;
>         }
>  -out:
>         if (nid !=3D NUMA_NO_NODE)
>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>         return 0;
> @@ -5552,7 +5551,9 @@ static vm_fault_t do_numa_page(struct vm_fault *v=
mf)
>                 numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf=
->pte,
>                                             writable);
>         pte_unmap_unlock(vmf->pte, vmf->ptl);
> -       goto out;
> +       if (nid !=3D NUMA_NO_NODE)
> +               task_numa_fault(last_cpupid, nid, nr_pages, flags);
> +       return 0;
>  }

Looks good to me. Thanks.

Hi Andrew,

Should I resend this for an easy back porting? Or you want to fold David=E2=
=80=99s
changes in directly?

Best Regards,
Yan, Zi

--=_MailMate_98537D1C-E86D-44B1-B397-722D5E66F119_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma00o4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKlAsP/1suTNgxVAnxXTiq6PTK7rdHrxWRbndzezaI
ILau7kHA5Gw2u/iOXKW6jkNJL7oDDdqOEs1lhe65TVfnSyltgxRzQDsCfKGykMju
eATMZATXsG8rORtShLvb+9nhm/t9+2KKAqUu76J0peH7RX0JMITJgGXQw7I/8EqY
yrdOUjNdT8/mb/l7HeSpLr3UjfYKQKTca7k7hywvDPAy1H/YAWHBxjqztSK5Uo6u
NP1Ton0cbbsYS6EvdB/7PbHP8RSgGeKCAegsCSgFjwmXtGMSRms5cFO2p4BItvyh
sm/zPiQoMQf4aTCkxEixr0OBUiMgBl0BR9MrKcnXIzFtvJ8tKLVVZHckiY/VgzoY
9pfX2SbSzOip2mk1h0RkUegog5hWsg4U94ugB27kWM1WiT1sj6u6FSH1Qc/v0pUR
ccUCbiun8VeMtf0NmyXH53b3oCduuQw/muozC3bS1RMwu4XonQWBKsFhlXUO/b6q
ig9fs1XGaeD7yOxyDHMmlRwh1J29rSGtpOe502pBH8GjpjWOko7DLHzfjct5A9mF
tI3qWw0+xDLmA6MMRvoYr533d0JhDZ+4Qj01a332UtC3wiDVsOgZ2XwtJyilo6nA
wiStIle1ippm7nTel0Th2k5i0gca+n0gqOsUEFft5fNVwDS0aEKIGLVqHmWANq77
1T6Gfto8
=E/zP
-----END PGP SIGNATURE-----

--=_MailMate_98537D1C-E86D-44B1-B397-722D5E66F119_=--

