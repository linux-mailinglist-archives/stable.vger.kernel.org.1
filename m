Return-Path: <stable+bounces-87831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4A9ACB3D
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 15:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7641C214BF
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F741AED3F;
	Wed, 23 Oct 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NoSI79B8"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781D1B4F3A
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690195; cv=fail; b=JwDJ5Et/eFgkyELLYPW0EnUYPNJ8I9xXr0+Vl37qekRhiK1toXu5zNr1psYRJS1/hyDJgVOBTAyaNAiy8OvBuB050wUGO0mOzh1qjDLVZCPx9mp4IPXC1DnK8gip8k2C/1bTi6k9xwL1w7cPsgg9XVACYEWWQfeKF+HtbNlm8ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690195; c=relaxed/simple;
	bh=HIjee7OxQYTqOrhWBawAxjL9ztkJ/VRAYEK2YgxOEHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZM5R0Ned+k0iOO/MlAd1nFvNr5gkzjIEuXqU279CU1d8CoawWDPOnO4j2hHzkGE8n1nz/Og0Z3qoMEBm7XfaBK6nLO67AvlK1aM/Y+lKCEfNAfDX92JJmJ/36jEmeIjV4Bs7cWxa5clI/QPRNsRvhelJsTckAHYZzy+7vL7AIV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NoSI79B8; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDP5JxY+oZgR9hr/LvwDRNwUzKFOR8o3WIckcsBdzC0qyNpiM4mrmrAPnmaJ24EX/UUKMSuAjrdPzq4dFL2AuANPNaq2vys1Mukvz27kW1Q1tD0EwIxu1jmyTorHDFa62GvF5IW0sMt41BnVkJg5Ev8+RhgyJlz3MaZ0ZO5NdEqCqQb5KSVTI3xnvGO4Y3o3FrxFOyXPSCCXQF2tjSKfkJRO8103nKqq83gdkFC1uzs9mKms2Su8O8bVzZILhSul9ubXsgb5ZIe0huKGzqd4YiYyqeZVaJIImrulGDIUK+ESnmaCj20ZRctwVYiFfs/sdP10FsUdECq3/cWUVjcvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw5k1E2GoDacqFHBSs628/qH2xEonSh5D3aIJH1E2Q8=;
 b=EvkxsMZconuFvTY/DRgrG2dqJDELwmgzBSo1uaqA5wa2gPjIZ1FSdytzZQVyV1sefePezl4wuFe7v+Rny93GcgG2gFCOB4h8QQ7JfeR8KnbGRP0OcljfL21XK9drVXN8EfPZISDYwk5fb03clldjcnS5SmnsNBG1qKVA7n8Y740RmYHe/fRY9QVYZD0dyff3NfwRPSfr6hIPiilCCXP0EWbAm36LI6gvXMyu46vWgN63wG4WxHBA1T7rEgMC/ie2/sZf56D9Aifw5fJQlHvu4hvQnDMzdqQbLTeQs15l7+9rg4jan9yOWk2AQEYfFrvrZZCE4uvQN/axBRBOmdpMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw5k1E2GoDacqFHBSs628/qH2xEonSh5D3aIJH1E2Q8=;
 b=NoSI79B86eCD1pV9S0IHCfM8cSZ/e+SNCX9w5gzUSIx4snXVmcW/8qMP20vusLwtCpI0nzxJx/guUVxkoWxdwG0F6qbqagaJy9wMi4quc1LmOlX91qIlqDto/J1Bx4cVt7Nu730mUWwJPE4esn1dqV/Z0baPoY1GfcYb5ZSHWCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:29:49 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:29:48 +0000
Message-ID: <229dd4f4-b556-41ef-bea9-9fafe07180c5@amd.com>
Date: Wed, 23 Oct 2024 08:29:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, Steve Wahl <steve.wahl@hpe.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Pavin Joseph <me@pavinjoseph.com>,
 Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
 Eric Hagberg <ehagberg@gmail.com>, dave.hansen@linux.intel.com,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
 <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
 <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
 <af634055643bd814e2204f61132610778d5ef5e5.camel@infradead.org>
 <Zxgh-hBK2FfhHJ9R@swahl-home.5wahls.com>
 <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
 <1f6feded-066d-4207-9645-f2bbed5ebfee@amd.com>
 <e4cc1e0cfca0d954ca22d850ac771c4bf7406902.camel@infradead.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <e4cc1e0cfca0d954ca22d850ac771c4bf7406902.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::20) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c1767e-8b4f-4897-a413-08dcf366c442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnpvZUxFamF2cGVJMkNPTURqbENrcmJ3WXNOTVF4dDZQNDdOMCt3R3pmUyt6?=
 =?utf-8?B?aXdCUDV2dDVhQi9KYVYzVW5PWFFzQUFlT2NwWUx5VDY3QmM2ZXdDR01MOVJk?=
 =?utf-8?B?dUk4S29qT1NGWmhNTERsQzRLUzZQM0ZLaVBBTXBNRldFdVpkaUZsVDhZSG1W?=
 =?utf-8?B?U3lXTU9iWnN6OHpnZDFjcUZOVlUxZTJvNzZ2ZFhDOXdIcjlNS1hOWkRadkMv?=
 =?utf-8?B?TjRLQ1lIcHNGU0U4WE55elFHcEtoY1dkMHZudldYZWFlMTdYQ1hUeHMrZU5n?=
 =?utf-8?B?RmhCUEtKWFM4dXpZelFOdDBIU2k2Uy9aOXAzQXg5cXRiZFhya0ZxRmUzMGhT?=
 =?utf-8?B?UG9jTW5OUXVwZHlYbWNWOXFxWnBIVVVJczY1MHFxVlVDUFF4OWx1WFBmaEw1?=
 =?utf-8?B?ZXM0elJqL2FYM0tmR2FCUThKVDBSTjMzbnAwL2dNM3RISGs0bEtabzRLWE1Q?=
 =?utf-8?B?S0pBblloeUZEcElSTkU0SEtRcks2aVhING5aQUtucHk2OVJQTTR5K3dsTTYv?=
 =?utf-8?B?dEdjL2dOZ1ZLK3lTQnBKUU5XUWtYcm11R2pHbjI0cGluM2YyN0hXb3ZBTHAw?=
 =?utf-8?B?VVBlOFBIc3F2dWFkalZjWVU5V0ZKakpuNkVEb01sbVZsVVhNaDE3eEt1Y1hJ?=
 =?utf-8?B?clJaZFFmcUlIeEViU2kzOXR1S2phOGhBbDY5YlM0WkFQTWxqcUJ1UzlyTERF?=
 =?utf-8?B?ZXVmZzFOYkFIc0EyK1pCOHkxSHgzMG55VkZkYVdKMTNQYWQ2dEEzQjRlUFNm?=
 =?utf-8?B?WmV0RlQrS3FJQUZVOXlQWkNsbFI0Y2pzN25IRE4wQjJTQ25SWVM5MTlyQUpK?=
 =?utf-8?B?ekNJVWxodFZlUGZnbkNCRHRGVDBXUFNpeDNjYTdkVEdabi9HVlpGb3dPcDYy?=
 =?utf-8?B?TytzbTYvQ3l4SjRBT1FrUklSNURVcEgrNlZ3WktRTEVjeVRSSkdnT3ZTTjUw?=
 =?utf-8?B?dDVoY0FSbWVJSjljMVIrK055TEhnQUhwb2VxY2grbmN6a280cXBZUEd1WG1B?=
 =?utf-8?B?bHlxV1k2Y0pGYmZiTEVudkpCMzRtczBEcXZqbUZPazc5UndpNC9rTTJkMlVY?=
 =?utf-8?B?OXc1MThXaXNETXUra2tUMUpmU3c3TlpKd2UxT25kNGpRbE4wMzBrREtVb29T?=
 =?utf-8?B?djU1bTE5R0p2ajVzZi9JTE52WnpLbXRXODhhODFWSUhNenNDUnVQSjI4dy9a?=
 =?utf-8?B?RXNmVDZCbkJTY2xUQ05YTHY1ZldWRGI5a1hibGo2dENUdWxtSHF6MDRwRldi?=
 =?utf-8?B?Q0p4V09MWGFwSXVxTS9ySWxCeUdNK0c2UmR0WnlaUU5pU05ndnVyVEVuZVNS?=
 =?utf-8?B?NXpMaXB5Z3htMnErcFNWM0k4SGJLODBiQU11eEEwTk9udENOWTFuYURrZVlY?=
 =?utf-8?B?bmYzZkxKYWw2ekpqSzkxbmdZVThlUXVmdGJicjl5ZWp1MUpzNjZKcG9OOWVZ?=
 =?utf-8?B?T29sMG9Xb3ROSkJ5UGhYTkRabUpacGlTd21CS21tWDJlSFNvTThBZlYzaXg2?=
 =?utf-8?B?T0NtOCtqZkc4bEZrR0ZmTkNNN0pManBlVHZlMStmNHlvdHJaS1V4bDZMdEI5?=
 =?utf-8?B?QzRKcnJ5R0s5enJNbHRteFU1RHpMRkpmQjByVzMwR2ptUW93anZJbEY3aTls?=
 =?utf-8?B?eCtDa3h0Q2pvQ1BVNEdPWENiU1YzTnlqdlZMSXVVQnR5bFJZT2s2U0xNVTcv?=
 =?utf-8?B?dzlmamRJRmJtaVpTZmpsb2VqNEEyYTVyb1RLK0RpV095TUYxenNyb0trdWk2?=
 =?utf-8?Q?bj5aKk6tEJ0Lzxyu1DMNdK4dKIQD5yAOaGZmI5e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUw2RTBMZ1E1eThaNXY5MU5idFJuUThCUnNpc3VqV1c5VHZvMWg5bGJnbEZu?=
 =?utf-8?B?K2YydFR5Q05EdFBrTlpoeGovYmhobU1WaUg4T3RldnNPSUVwVVdueWhLV2g3?=
 =?utf-8?B?Q3kycUNPUEwvVVVCVHZURlVud2o2OXVpT2RqRFVzTHBDaTB4Vy84SjJrYkhQ?=
 =?utf-8?B?MFFQdnRyVTZVZzlSUGE1NW9aUEVOUEVUUDJDOTJlclZ5MGlYUTlHejJFbGhN?=
 =?utf-8?B?aGpNMDVHN2orZVpYcm1HdG9oYzY1WFYyZHFzRlZuSnpudnFPdENiRGtqbFM1?=
 =?utf-8?B?TDFoakNZQUNGaTF5SVRnUHBXYTVyQzJGRUFEN1ZQUmhuYXFtNnUzNExPQjVv?=
 =?utf-8?B?YnVxM2srRG1Ob2ZmUEl1UW1DVlVGSlhVaUJTR2g3VGNuTGRuQ0tDWE5tc0la?=
 =?utf-8?B?WS9SemNIN1EwREpDcGRFYWJ0ajVGY0FuRysvSlJvdUxqRmtVYXo5WGs0S2VJ?=
 =?utf-8?B?U0IrVlBMQ1NDNHFScDB1blNsNEFpSkhCUStQSmNzQ0RVMEREb016RnVtS1lY?=
 =?utf-8?B?UXhBRVFUUTh4bjRRUzV0SzZ4U3JFRllmdlRpck1ORGlBRW5RWUxKdDZ4VldZ?=
 =?utf-8?B?dm9NU2lLb1VnWklBWFZwNXBXTytaeXMzd2ZTV1I0T29yRk41UmFFRnZ2Rnl1?=
 =?utf-8?B?N09ud2U2L053MzVEK1NsTzFhTDJ5MzlUcnJrNlhVUUVRczNOMmd3T1IxTzFo?=
 =?utf-8?B?SDJveVpHTzRTbk15a2p6NUR0UEIwam1tYnZSTjl6UTB1VU1pL2RzSUNuV3F1?=
 =?utf-8?B?ZDNwdjZLYzRvMnpNRjkvWjYvR1hscDRxUWM3ZGNacnRLS3JaYnBlQWltZm8y?=
 =?utf-8?B?SmlybzN3ZnRRRVZ4S3ptalJydkxnTlhtOEMvK0pPb3k1QmZqdkJ3b2FWRnFK?=
 =?utf-8?B?Vm5EVGx3N1lGb2dFdUZMdHIvNTlDaWVJZ1pqejZFZW9JcUZrVC9YcDVXeDNh?=
 =?utf-8?B?a3U5RWRISW1QSURjcEUrMEtCallBRk5hK3Zrejd1T1NQQ2lwbHVWWlM5SEMw?=
 =?utf-8?B?L0ZkOHlLeFZsMVVHY3RzY2FVbE5MaFhndXlpUW9BRlpROXNpcDZiZjgwYkMv?=
 =?utf-8?B?a0dsOFF4aGVjSEJlSkZnd09QL0gyOGR0UUszZzd4YTc4L25GdENqVzZ4dXJK?=
 =?utf-8?B?M2FrdDVweWJkRGVsU2ZWRVRmRmhQYmxXdXNiMVM1WkpEWk5aQjdKNzVhWk9M?=
 =?utf-8?B?V003emNiWGxmRFkybGwra01TYXpGUFc4aXR0SVNrdzU1V083aStuUWJvM3Rp?=
 =?utf-8?B?cDE4c3k3bCtoV2pSbENmVGMwdzRjT21ubUlQdWVGK3ZsQ2lrdnVRZVNKQW5T?=
 =?utf-8?B?RDdhRDZKenhrbEdoeHF2U09sRkJZTWFKZXZ3ZXcxL1V5a3VqTGE2alVqSjRz?=
 =?utf-8?B?VGdRVVdFMEhaQlltVHN6ZXRFcUozSXg3eEVlNW5CcS9ENU5Cczg2aDc1SkJI?=
 =?utf-8?B?cmtKZi9COG9qWkpKQWdLQkxqVDdLWmd5Z2hJeW9WaC9WSnd1NWxhQXd0cHUy?=
 =?utf-8?B?aUVWRkNRWEVxMUU2emV1VjlMT2dBQklOSHRQeng5NmRoUk01emFZNVFNYkIr?=
 =?utf-8?B?NWFUSmtYM0tUdnJBaW5OcUg4ajBxNkcxMXFtd0JnbTlnOVgxL1hnbHpaZ0VG?=
 =?utf-8?B?VGhZVEc3dVFFaDZLTUxlcDV5U2lrNklTdUk3MEg3UGdIanlneFNlT3g1d0RQ?=
 =?utf-8?B?cmk3TUYyclpKREZGc3llTG0zK2ZyYnBFajEvTWdYTTdoUXFrcHp2WnFQenNF?=
 =?utf-8?B?UnFzdFRtNUdpQUhZQVNJNVpxOTcwbnY2bzFaanNnM1VOWUNCdmVwdkt3UmZ5?=
 =?utf-8?B?eHhlSEJnN0lTc3dkUjlBV2JjbFhQa094UmJlSUZvS3hSdkhBL2JIbW1ZZGdk?=
 =?utf-8?B?d2Z0Qk1KcXdYVU02SnRBa1FKMVlSVEhMNVJ4emxtTHprSTVjeHN4am00eUx4?=
 =?utf-8?B?QlFMWDNVZ3M3U3pMcy9Wci9ZT0FUZk01bmkweUNmRllBaDJxdGVQNGYvVlV0?=
 =?utf-8?B?MDhnVkgzZFYrTWlLNTAwWnBnVTNjd2dHMmp0ZURBMjBCTXRCbDNtcm92OHRp?=
 =?utf-8?B?Y0xHNlhRV0VBdU9JTkdsVlpVSDNtVnJzRDBDd01XcFlnckV3UHBKR2tkTzJ3?=
 =?utf-8?Q?MVVuT/nRARq5A1rvEUyOD2btu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c1767e-8b4f-4897-a413-08dcf366c442
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:29:48.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZuC+e14GGAqukI8KY2W5TDei/q5GeNQqq2RwgUul+6F+rTzkRTrl7Dp22HztYW6Sg8gZUnJw4vf6RKY6J7PcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829


On 10/23/2024 6:39 AM, David Woodhouse wrote:
> On Wed, 2024-10-23 at 06:07 -0500, Kalra, Ashish wrote:
>>
>> As mentioned above, about the same 2MB page containing the end portion of the RMP table and a page allocated for kexec and 
>> looking at the e820 memory map dump here: 
>>
>>>>> [    0.000000] BIOS-e820: [mem 0x000000bfbe000000-0x000000c1420fffff] reserved
>>>>> [    0.000000] BIOS-e820: [mem 0x000000c142100000-0x000000fc7fffffff] usable
>>
>> As seen here in the e820 memory map, the end range of the RMP table is not
>> aligned to 2MB and not reserved but it is usable as RAM.
>>
>> Subsequently, kexec-ed kernel could try to allocate from within that chunk
>> which then causes a fatal RMP fault.
> 
> Well, allocating within that chunk would be just fine. It *is* usable
> as RAM, as the e820 table says. It works fine most of the time.
> 
> You've missed a step out of the story. The problem is that for kexec we
> map it with an "overreaching" 2MiB PTE which also covers the reserved
> regions, and *that* is what causes the RMP violation fault.
> 

Actually, the RMP entry covering the end range of the RMP table will be a 2MB/large entry 
which means that the whole 2MB including the usable 1MB memory range here will also be marked
as reserved in the RMP table and hence any host writes into this memory range will trigger
the RMP violation.

> We could take two possible viewpoints here. I was taking the viewpoint
> that this is a kernel bug, that it *shouldn't* be setting up 2MiB pages
> which include a reserved region, and should break those down to 4KiB
> pages.
> 
> The alternative view would be to consider it a BIOS bug, and to say
> that the BIOS really *ought* to have reserved the whole 2MiB region to
> avoid the 'sharing'.  Since the hardware apparently already breaks down
> 1GiB pages to 2MiB TLB entries in order to avoid triggering the problem
> on 1GiB mappings.
> 
>> This issue has been fixed with the following patch: 
>> https://lore.kernel.org/lkml/171438476623.10875.16783275868264913579.tip-bot2@tip-bot2/
> 
> Thanks for pointing that patch out! Should it have been Cc:stable?
> 

This thing can happen after SNP host support got merged in 6.11 and SNP support is enabled, therefore
the patch does not mark it Cc:stable.

I am trying to understand the scenario here: you have SNP enabled in the BIOS and you also
have SNP support added in the host kernel, which means that the following logs are seen:
..
SEV-SNP: RMP table physical range [0x000000xxxxxxxxxx - 0x000000yyyyyyyyyy]
..

> It seems to be taking the latter of the above two viewpoints, that this
> is a BIOS bug and that the BIOS *should* have reserved the whole 2MiB.
> 
> In that case are fixed BIOSes available already? 

We have been of the view that it is easier to get it fixed in kernel, by fixing/aligning the e820 range
mapping the start and end of RMP table to 2MB boundaries, rather than trusting a BIOS to do it
correctly. 

Here is a link to a discussion on the same:
https://lore.kernel.org/all/2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com/

Thanks, 
Ashish

>This patch makes sense
> as a temporary workaround (we have ways to print warnings about BIOS
> bugs, btw), but I don't really like it as a longer-term "fix". What if
> the BIOS had put *other* things into that other 1MiB of address space?
> What if the bootloader had loaded something there? 
> 
> I'm still inclined to suggest that kexec *shouldn't* use over-reaching
> large pages which cover anything that isn't marked as usable RAM. 

