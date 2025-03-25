Return-Path: <stable+bounces-126038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E96A6F65B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25BC16AE06
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB20256C73;
	Tue, 25 Mar 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RRhBMNTd"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E31A317A
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903104; cv=fail; b=tb2E4G7jn16xxLjTJnXKRlNz9SddNgGO8hU0YjJrxrrVUQwAbbYIuaCuPMz4wAMe5UCYZ60DC0sVCbdDpBQ7K+1kGNPLC1kPkaEn3O52iP7UhWGz+5M/s0460uSZNu9+NxL/99whUaK0yRfC3P2oHCrbm1uQyssGrI42hBFrRe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903104; c=relaxed/simple;
	bh=Nx2hoEfAUyA4vYnxSFh/8ubxvwLHW/62uCKSKgmiNXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJWj64Q9ZCdUDwtjUE4nxlrBeQYPkGk36wEKp0BIyT+JpaFNEsCDXbv7NL3eHXEXaAtPk2PdgwIapnqoAU4CwPupaLPGwLn6k5+CIRvvBUoeup/tSASZNtyN04ecWMN4c8vohs1aMQ3n/huagyzwqEzwvJb6t+CHry6f2i+c8EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RRhBMNTd; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb9fCMta1lUk4AetOgGhcgrCKb9BobX6eo3dYpvMKw79ltpJhAaJrLU4yP69OyJSD+JgQUD6f2NoxAxnLGfGy71fxMX17sw8F3EGWOI6VXy38FwmxWC+m4ssOc+ufqbTz6dMF6G1eVEHhgxQrvKAc4XBumd2BofLIrifW2CGQJCMuddK2ICB4fDcOD08iTkvFhaT9l0RWcTGnTHHCvLMlnuh7+Br9sSJjxJT/ZDmHdSpeFqf4x7EqhK+n4PNFu5XgXKSdV7fE7SHFaVoJsnLEaolq27Suhw9C1WjC9T7SbV5OFR39Fj3M8hi5LYjTHE5070UfQxSz4+GF2yorFvdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smAe/eAvTQfyhBvAEhQgzHoTeveJcFJTpKSj/6Gchic=;
 b=BOdm0ETwyvpe/hN5QS0lRQmmEl/tyZdSXacB1GMkmPhp6SSj070ZqqnTLE5WG3LNFRSvb9hIPgX1DRiMav3l6NTJabFJAGNMLH6Z1OZVCI/wmgxD+d5QsCbr2z7sDAcVJLHr8ZH0i4WNZc350F9LdzqLUxbxokfaPG/NP8kPyn9wBBbG7ZMJl7Ev/ond7b424TqfpvkoF0mjQkrAbETNs2tIfZJS29CcwaJhTywKh5o6K4m4iA/ao6c12uUY3jCcIVMivEmjhrgZPq0nn+O9Tm6o/c5eCxkqV6BIFkd4Md5M3D+kkGkWCATfNYVqaR1YN2lF8RNgztk17r5XDNTLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smAe/eAvTQfyhBvAEhQgzHoTeveJcFJTpKSj/6Gchic=;
 b=RRhBMNTdXuA0+aHcopkxiDtOtCCxEVOS/Iej2j5EDF+Uah/8P++LurNPtBmWQH4uP4oCvV9K9lSVUBdR2kDNkChZ+okughyix9xSzLuHcbzaCyiPITzHXTcf/ztcRr9o03oHclE6KZ2XW0Mx8SShlgFElLW8rGbh5+8tZKoJfJ4XmJDyi7BwlCZTJgrWSdHoffdKV0PkCKRaaPu7LO7uILXoVv4WjQnOZ06QVW1+LKOjtxZO84szjCnxNVDbGVgcfyAqExnZZvHQ5+NqW4X/RSPibRc00upHaPoqm4XCuWiy8JsLO6pgseODIdmFojd6uwU9AbOhniffxWukrQK2CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 11:45:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 11:44:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] mm/migrate: fix shmem xarray update during
 migration
Date: Tue, 25 Mar 2025 07:44:57 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <D37260CA-F91D-4293-963F-C9863B47FDCA@nvidia.com>
In-Reply-To: <20250324210259-4c1c4c7f7c182ab8@stable.kernel.org>
References: <20250324210259-4c1c4c7f7c182ab8@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ad9512-36dc-4408-ca3f-08dd6b927915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHFsTVhnc3h4RjlvTkZxREYvRUZWYjJzL0tBNE01Rko2MGR5bWI4eStWQlhv?=
 =?utf-8?B?NTZYKzlLL3A5RVpHbUY5eENmYlhLdDVCRGlha3NXVFhIWUoxc3dtR09NUGlp?=
 =?utf-8?B?N1Vrc0ExcGczcmxmZXEwM1gxL1NPdzFwZEloN3RsK0tqaTJVU0dEUVZMMCty?=
 =?utf-8?B?OUVHL1kvcGt2SzVoMmw5VDhiL1RkQUVraVpqOUExT3dyT1NCVkhTa2pPTFc3?=
 =?utf-8?B?d1RWSDdPbThKMEk5b0oySWZndkZQQU5NRG04L1FVeUw3QWI1N3pmOFRhT0t5?=
 =?utf-8?B?VkFYUHJmU2grZ1A4SXVIc2pvb1h5dk8raG1idExURDlpMmNzZTFsOVRMMVpE?=
 =?utf-8?B?elN6ei9LNVpIMFkyZE5mSmxxNE0yekxEWGxlLzNPNWdSbDBzTThGdHJnSWRo?=
 =?utf-8?B?ME1CT2hNS09iekRQaVVrV2pwUG9KcDJtWXVLcmRodmRxRUFzUEJ0RWluQThl?=
 =?utf-8?B?aWhaaDFGL2hDNDlrWUdWZlEzNzRjQUNBWVY2NEYzeWJvRyt6ZzRvSTRJeXRv?=
 =?utf-8?B?bUNBRm1vTEpsTVUva1ptcGdlTTUzQ1RDdU5qSEZsZ0lTU2dCV041dEhFQkZW?=
 =?utf-8?B?VXRrR3A3OTA1L3RlU3ROM3J2OHRRYkdqYXgzOG42emVYeHVUWncrYXViNWwv?=
 =?utf-8?B?djl4bGNhVjZmdkVFN1ArWkhUTU93U2QzYkVyTUtzaUdpRFF0TUxTY1IyZWNI?=
 =?utf-8?B?eUQ2WmtyYW1kbE1YdUhBSXlhN0cvaUc3bmd3S1dnNDFWbWk4eHFaWnJyL0p2?=
 =?utf-8?B?K3QzOXo0ZmJvUjVaUUFreTYxbGJURW9xODFhOVZlWXFScUROMWxiYjZZRTJw?=
 =?utf-8?B?bUdBak1LUUFEbytRWDRSU3B6dklmMVpnRXloL3pIcVFsclAxMFc5S1hMTjJo?=
 =?utf-8?B?YStYOWpRbGZ5VHBLK3I0MXRaSVRUSDNpNFJxS2htcE12bjVDUGloNlQ0ZWJC?=
 =?utf-8?B?RFlDWktBMUQrUG1KMlBwWWE2NUdXOEQ4aUZWTDBQSHhDa284UjAwblIvOHVD?=
 =?utf-8?B?SFY1NXlDa1pLU0hrOEVDNGNSMXdIN0xBNyt1U2g0MFBHbFg2ODhmdGsxVXlz?=
 =?utf-8?B?dnVyWXd5RzU5a0cyVTdQaVo3ODU5TU9sT2tMVy9qQ05RT3o0RlNhajA5RkZ5?=
 =?utf-8?B?M2V5VzlyWWpXVXVHa096Mm5TVitpSFdsdHcxVjdQWTQ2TGVOYVJlYlRLRTVB?=
 =?utf-8?B?dmViZTVSSm83bVlMN1ZZK1NueVIzemwzdU1OUTF2cEdaK2hWcGxreGJTYUJR?=
 =?utf-8?B?RmtmU3BsUzVqVytka0ZHQVBPL29oeXpSRUtsSDVwWVNYREFBSmFFSVAraTBU?=
 =?utf-8?B?VUJTdlhYcjNlUjFoV1V4Yy91ZzMyWGtCTmJoNXlWdk1XR3UrV0tBYjlGL3Rx?=
 =?utf-8?B?bHRLQXN6NzQyTHBXUEVGamtWbE5oVFoxbFVTTjVDSFdKUTVvUjNmMG9DQXds?=
 =?utf-8?B?ZUNrZnNzbGFmZmZlWDEvZG5rcDBuNWlaZDhCTFJLTXN1dzBsbTVFYWlRN2I2?=
 =?utf-8?B?eUJTY2lPS0ROOWJ0N09rWURVZUp5eS9ZYzE0ZXo0QWVwTFpJM0ZRcEQrbmI4?=
 =?utf-8?B?eGIxSTI1Q29IcGQxQTUzUGRiOUc5Q29MYmdpN2ZGYmFaNjNyZEU1N0pMNm5G?=
 =?utf-8?B?c3VieWVFbHR4S3h2TkJPbGcyQnUzU0oxakNqODBYUjhmdHRBMW9hTE4vSkZu?=
 =?utf-8?B?ejdzZmg0Y2tvcmlQdnJmdUYwdTBxSDJ0Q0UzQzF3K2Z1aWJJRzhwQWtqV0tv?=
 =?utf-8?B?eGF0bXJuQ3NrdWlzSGZrZTRJR1ZsSGFtVEdxd2Q2UEdvOTgyb2RveFVZSXJJ?=
 =?utf-8?B?NWlabWxwZlY3Zmh6NGZQRHJiTFJJRHo5MVJ3Yk5vK2M3a3I2a09HaVMxelEz?=
 =?utf-8?Q?4TkthI9xd7jqI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFpMM09JY25XRWc0a2J2YlNteDkwN3VJeHp3K3VGVys0VjB4L0ZUc044UHgz?=
 =?utf-8?B?bjNsWGh2VTViN0p3djBWOHp4emNyWWR5WWQ4VHcrMjRKZzc4UEtwd1RGdHc1?=
 =?utf-8?B?eWlNQThxQTk3R2lBTVVOOFBNMVErNnFMZlZsMXlUUmgvZTZFa2NXbFZaelp6?=
 =?utf-8?B?WFRPSlNZM3NkL1VIWGlrUVVaaE5aYi9hUks3Q2YxZ2Z2MllHR1ptcXUvcFRN?=
 =?utf-8?B?VjRHM2lTMWo0Z2V0Z2gxTllkRS9OcHRXbGZ1MW03dk9xdTNsejg1bFdpS0Vp?=
 =?utf-8?B?ZUhpMzdyKzY4UFBOdkNVUU1TL3l1TGc3OE1EYm02SlUrNGVTbmxGcGhhV1lC?=
 =?utf-8?B?aXY3Z2dKUVZmejczOVZnUHF3S3ZWMmh3UGp6WnNnQkFtUUQvRGFISHRlVkhX?=
 =?utf-8?B?eDEwMkF3aUk0M3ZaM0crL0twNEFQRy9XeWtvYUdQNHlFUDBzTHVTYUM0S1pr?=
 =?utf-8?B?dExjUnlLUHNmZlN4YkJxL2Flb2JFTGcrb1hGM09IVjRLb2pseEs1MHZhdWdO?=
 =?utf-8?B?WDhObjBydlg5a0hKTUJWWU4wZEVwNVdvV3Y5czUrMENYYW9wM1Z3eDhaY2ZL?=
 =?utf-8?B?ZVAvOTRROW9KSm5CdktvaFVlYWMzT0xyTVpza0dPeEZzTk9DQWdkL1R4aCtT?=
 =?utf-8?B?YzFUcEU3RDFzd051elFCcXlFaHFiNkloQ1ViWjRSa2R1UW5WRDZpSTRhcmUx?=
 =?utf-8?B?VG9KTFlIUERMVjloTzZkdkZ5c0F5WXYyUlpQc1cwcEowb3l0N0F5R1E4aEFv?=
 =?utf-8?B?L2pKd2QrOWpWc3o1eVdwTWJFSXh2NDdLTXlDWDVNYXZ6aUkzeFZOb0F1S2N1?=
 =?utf-8?B?eGx3Ui9tMVdMMzR6NDhNT3FrTlB0eDRJUlRBVklGS1RQc3JtRGFpbDhvZ05v?=
 =?utf-8?B?L2NKdHFZL0RyRUJyUTlFVGdKb1hVY1ZpM3ZpWFM3aVRQZGhhRVRucUExbDZG?=
 =?utf-8?B?RHZFd0o0RjJFWDNzQ0MyTFgwTGxndVlZeWk1R3lmOEk2ajZxQzBVV29vVzFt?=
 =?utf-8?B?UHMySkxMclRpd0g0SDFiMmZSc05HbGlTdXVFamdaYlFWZEJrSVYwL2VIeGQw?=
 =?utf-8?B?NlRwVHd6a015SDdyR1BtYVNscUpCMGs2OWFWZ3NzUUVGY2FibXNJeWlXMVpV?=
 =?utf-8?B?QjZCTDgxY0ZDTTZNeEpYaThPUXFQcUZPOEcvTS91NlZxbStEcjNkUHNWNVhj?=
 =?utf-8?B?MDFHOVR0UFhmUHY2YVViWFFKMGExY1Q1NmwxTHA2OFE4SSt2dU92bk5ScWpl?=
 =?utf-8?B?ZkhNS3VvLzRsRDA2ZG5IaUdGMHRtU0pRTWMwaHVUZUxiTTNiQlR6UGpnczNT?=
 =?utf-8?B?dkdlU2Z4U2pzNVY4MVo0VW5ZWHpXYTdQeld2R2VyOVBoNytldkx5QmMyZEM1?=
 =?utf-8?B?UkptUWwrdVZYUWxwZzFqK3hwVW84cGFhMDB3c0FuTCtncnNUR1JRc2tWb2w0?=
 =?utf-8?B?RlV5cDl2d09DUU95dmNPQWhBYkQwbmlxMWJJeDNZbmlFRitwR2c3S3hpV0sv?=
 =?utf-8?B?anVWQ3N6bmY3OXdBQ2pJTVlGdGZJNjF2NkFnYzJmd3loL0wyeXNrU2E3R1dh?=
 =?utf-8?B?SWJtSjFuZ2JvT0h4UGx3VXIrYUoxUWExaWtBVUlZd0JhWkZYQ1o5RXBUYjVE?=
 =?utf-8?B?QVlsb0lWNENQaG9ES2tkZUNSYVp2RHc5ZEIxNE9ST1RFYjUwQ0F2elNWbUpU?=
 =?utf-8?B?TnczSHA0VkFyYzl1Skpyd3NDWEw0eGlMMWNJWmFEUkZNcTV5MFhBbmJtTnRs?=
 =?utf-8?B?RGF4Ym9jUHhUM2ZySW5iTjJzS0FrSXd1NWxZbFlYbkllVTFBaU80NStRRGVR?=
 =?utf-8?B?MTVZTGprRWVEcGRUUHg1SUkvbnBJN2pBcFg4cUgzNVFRMmhYM2FmTkhVNUwy?=
 =?utf-8?B?NmI5MjR1SnljSndRNS9mU3ovSExqZ2ljdEs5cU1VM2lxV0NIV05oZGlsYmwx?=
 =?utf-8?B?WU5BU2pZSWozMm5CV2xncjAxQlJ4Z2ZYRWI0TUxEVHJqeUp3M1FHcWxyZGRP?=
 =?utf-8?B?NllWbVdVL0tMajdpbVVFMUtVMWovZUJUYjVXdnNpclZzdXNwM3FodGRtYS9x?=
 =?utf-8?B?TG4zYzg5WmdLbTR5YkViL051WWg3YmQ2ZE5yYW14VDVMS28xMTRQZ1hWWjFy?=
 =?utf-8?Q?KSD0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ad9512-36dc-4408-ca3f-08dd6b927915
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 11:44:59.8578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqMYX+OMy2NVcwty537YDaY35pXBARQRDmc+5p2tBiYEd0NMypGSPhCND5QsTcqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069

Hi Sasha,

On 25 Mar 2025, at 7:33, Sasha Levin wrote:

> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> ⚠️ Found matching upstream commit but patch is missing proper reference to it
>

What is the proper way of referring to the original upstream commit? I see
“(cherry picked from commit 60cf233b585cdf1f3c5e52d1225606b86acd08b0)” was
added in the git log.

I was following the command in[1] to resubmit after I resolved the conflicts.

Thanks.

[1] https://lore.kernel.org/all/2025032403-craziness-tactics-91af@gregkh/

> Found matching upstream commit: 60cf233b585cdf1f3c5e52d1225606b86acd08b0
>
> Status in newer kernel trees:
> 6.13.y | Not found
> 6.12.y | Not found
> 6.6.y | Not found
>
> Note: The patch differs from the upstream commit:
> ---
> 1:  60cf233b585cd < -:  ------------- mm/migrate: fix shmem xarray update during migration
> -:  ------------- > 1:  05f98b99ab8a9 mm/migrate: fix shmem xarray update during migration
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.1.y        |  Success    |  Success   |


Best Regards,
Yan, Zi

