Return-Path: <stable+bounces-47859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612048D808F
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 13:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF2A1F23D44
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2123084D0F;
	Mon,  3 Jun 2024 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uV3jA9Da"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926980039;
	Mon,  3 Jun 2024 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412825; cv=fail; b=CwcBi0UxIV4YYAN/8ZrN8RK0bbGyQXPdBvQywWixcYKoFe8ui+7CMY5Eq0WUblBhAmhKTeyjgpIjEt2GHJbpEDPnjpZo4NDBR0JfPyQj5eA127pMXeqs+mr7Ak2jazbvGXqY5o4SZg7EPdvUIYnZ2GbR0Ils7aAruePENiIkXeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412825; c=relaxed/simple;
	bh=Zr+bw3lnitAt2f7xiVFQNxyCzd6h6CrFb3FDJWlx+T8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZayNZcTP2l6s9TvXJd1EuYdhPlPUUBGjCvHP31GTro782jD4MmVXs0sDsXNnU1LXI2LQdJ2+Og4KJ8pLA7EH7lnFYXmwQ/nSi65Ul1of9pXqNL490tEDuYvqgQABlKiwlGZ4DDZrEn3TAxexJ49QeoKkPF6PySD2cyp1/hp0hKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uV3jA9Da; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4gAG5mzcDuF26vOFa2ENe/iEFTUQWBTOQm8Zm+dcLeGJeRFahDY9uW87yE7vrqHGZEge0kw+NZELZg0z9oZ+jViDOcJtnVZPKs3gPEd/8iDv1iGG1mVNWchFSiM2JGOYHw62YGYpsUry4AjM3H3WhYidCqpeI0myE7/aTAd1hs1Nx5/8UCnZdVnM4AqtST1ioMJXxc/Z7DjUDwu604f/DhdoEEuEeaKpbEw8ZC1QcbJ8yNvxSlQzDi7etP4OdjaXjn/GoxhPnilpZLBbrm0wRBnwTQlGsuZ9tuzFUFq8iGldKFaKH3EiKsFAZVSVC8LnB4OKSZXVvswKR7Yojb1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sOXC2frC3IMWD4he3mrA03Xndrx9JYoJLpX+Ot7TdY=;
 b=Lr2F6OxtRbu9wxOfCwNlL72BSu/yuT/2KzBU2qbRJSBFKkokvciT6NLYNOZqmoqylr4Va+jSsw0EXThgXCliJzFkhNW/1XAj4KteEGZm5vhXZuFc56GWQDWQ2tjLMCXYZtd2YktE1XyjUXlhjeUJuflqD76Zcbv9esJK3bMReAvajL1UmnQ8SssU9KAnZCnh5eFpStJY8WIZmwZ1KBixe54rE1W7le63rh4dgC/qpW75C3iycWxxDEaaj1jYdC6ahDSNhiPSA+XUwc/xYAdtfpf58OIp9UOsGgQ7zHSQdlwmRshlPlbOrTQjTpQjs9sQsiE4yUC9fUz4IGA+ug1/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sOXC2frC3IMWD4he3mrA03Xndrx9JYoJLpX+Ot7TdY=;
 b=uV3jA9Dac17HzsGJJOAhWWN4xApB4A9d4/Gnhf+Z8197lL9H/LeQ3JaSzUMi+mTveZNvbg1TzR3djBEHRrPYoQS/omYI71IfmlzQmy42Hzq/YrjLBqFNLBNjsdK+20bIrm8rx4YUcjMPvC9NOoR5p5kfEBXwB+UW61rBFRjtATk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 11:07:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 3 Jun 2024
 11:07:01 +0000
Message-ID: <31b120c7-c9d6-4b1e-92c6-e024727a7597@amd.com>
Date: Mon, 3 Jun 2024 13:06:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: soc: xilinx: check return status of
 get_api_version()
To: Jay Buddhabhatti <jay.buddhabhatti@amd.com>, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240515112345.24673-1-jay.buddhabhatti@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240515112345.24673-1-jay.buddhabhatti@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0189.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: aa20eaed-6d94-43ad-ed09-08dc83bd4b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk44b2FXL3BLNENnaFIxN295SkU4R0ZXdS81aEFQVVB3U20wcWdteHZFcG5P?=
 =?utf-8?B?WC9yNnpFbERCWnBwNHNKcSt3MTJ1MTZyMENpMHhhYzFlSTNBMHpaWFpBOXdk?=
 =?utf-8?B?S2tVNy9aQjZNWS9GaWx6YWEzdERxUGRxaWZqUitveGZ3azlWelBaS2RvWjdm?=
 =?utf-8?B?WDFnLzJSSzF2WlN6ZktuZ0VVS1ArdXNBdWJPdTY2NEh5Z0E3N0xyYjQwWFJS?=
 =?utf-8?B?ZkcyQWw2WEVLc3BEWk15NVE4WHkxWlBaTHBLVE90aXRtSzR0Uzg2M3JYRWdy?=
 =?utf-8?B?WWg4SGNOTThkSDhvcFkzVUg5SGJXZkh5V0lacitqMjgybDB2aTRvQ3FvQ2dh?=
 =?utf-8?B?Y1A5MDhwazJGTWQ1bU8xKzl0cS82NndYb1llREEzeFR4T0F4NTVxODluaFFS?=
 =?utf-8?B?TjhuWFgyUXhyTVdVSTNZS0pPdVFuVGV3QkFmYVlMRDY2SThObnVFY0x4Qnhs?=
 =?utf-8?B?ZFZrREdRMlprTGUyU1ZKZ1BBS2M2RDBzY1U1QjBaQWowNjA4QjQ4b3ZaUVM3?=
 =?utf-8?B?TXN3VHFHNzdVMWs1c2k4TUd0cHBOQUw0SjFBVXNFejBFRFhQK0hXd0RuNmoz?=
 =?utf-8?B?eDZxeEx1emZ4M1NJVlArTUMwVUdNNXROdU9EVzRrVVVQS1hCeGwzRXZxalRV?=
 =?utf-8?B?b1Z1VzZEUlBYRXV0UEg3ZmR3WlNHeGE5NTM5SmNudWh2cGgyWDV1TzhtdUo4?=
 =?utf-8?B?aThOZnVGT1crSnEvdkFDaXNKL2ZuRDgvRUNjVzFQL0hKSTR1QWlnWUI2UE1p?=
 =?utf-8?B?Q0xxWC9TZndNdDk4b2cwZ1ZuMkVvRVNlUlV0WHBFUUlXNTJicVhNa3dPdzM3?=
 =?utf-8?B?WTBDS0w1Q283SW9JRU1rZ2RvT3hGU0JHZVVqREVHVitoSkhWQnR0ZWxPeGt3?=
 =?utf-8?B?VXhhRmM1alIyS3pCLyszNTdWNEIwLzlOSUNPQThlWkF5MEtLYVJZMXViaVNX?=
 =?utf-8?B?dEdNM01YVEcyeE9BL1dGRVRGZmNOeVhndDlQVXQxdDcveEhGeG9wRGllOTdJ?=
 =?utf-8?B?cjRXSlUrRkhxa0trMkU1Y21JZXk2RGdOWCs3eUttR25uQ0RxSnlOSVFobUpz?=
 =?utf-8?B?VlJSNUNqSklLUzJ1OTNtKzQ3disrTnRBZkY2N2dvNEx5WG1BVkxLZWpYY21l?=
 =?utf-8?B?L2RQNWdMRG9QaHhWOGNJbjdYV1A3STBUaG55Q1V0N0R3VkV5ci9haU1zNzUw?=
 =?utf-8?B?MkdlTktGcHpSenE0ZEpLRzk3TjFFNWQrVTNvRzVMWURzT3llTm5RUzZuSGtR?=
 =?utf-8?B?QlQrSTBocTZtUzFvd2laVDk2UG53Z0k4Y2ErQkV2clBNcUVGVlJYcWd4Y1pW?=
 =?utf-8?B?bFBFVkE2aHBUOWJvOXZ4cHZxOFFVbFAvU3VMUXFsSHpxTmN3RllLQUR1S1RF?=
 =?utf-8?B?YmxKSm1ocXVuVDNEaHVoQjcvd1RQZ0pvdFV5TDY0RkczUUVwa0l0V01IanNj?=
 =?utf-8?B?dDZVdjR0NStWcnpyNCsxMGlvK2JZZTBGQ2pOS0RERGtUcUkxS2dLTWMxT1oy?=
 =?utf-8?B?WGNqVDNZd2xja1lCTUFpcHE1Q0g3NHljUHFaM2FDS0lTRzV6MFN4VUxXYTVZ?=
 =?utf-8?B?MFJsSXd0RG9ZcTNSTk9xL2ZndmJGL0RQWGNyUzNDMzg3L25IWTk5ZEs1endn?=
 =?utf-8?B?eUxBc1pqdW1LbUhPQjcreTRBZ2wzdXVOU2xMa2RIc25LWGR2VldRWTI0NlV3?=
 =?utf-8?B?S01oQVBweWxwV1BiSHd6QlRLZWRvL0NLcWVzVy9DZHE3b0k0RzMzT3JFWnMx?=
 =?utf-8?Q?A2UA5B+2DueO8Gehk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmkxL0xpWFVGZW43YnBkK2FzNzJWRGgrWHpQUVJ4azB0TXRBSkxVSU9Xcnhz?=
 =?utf-8?B?SHRKTklWNUtYYm1sM1Evd3dEeXhFa0l0cmZMZ2VKYmUwaVZnT1I2T2RCeUFt?=
 =?utf-8?B?M0xrNG1lSEkySkVwa2tKK3RNaFFyeVJ3ZW1zSnk1L2xnY3d3a1YzSDV4Ylp3?=
 =?utf-8?B?c3FPSHNKRWR5S3VLTHNxNUlGVFVlNW9qSk16amlua3pwY2VNZlo2LzlSSFlr?=
 =?utf-8?B?bkwzd1NNMVN4dXgyc2RxZHBYTXVqckxLaWVyY09KZGIycUx5MmpqQWJtR2xQ?=
 =?utf-8?B?dnh0SmNTazRmWGJjazA5Ym5VWml1N3NUaUU5VlYxckFVK3p4RzloNktUN3Ev?=
 =?utf-8?B?cmFpSWgzT0hnbXlCQ1o3NW0rRU1IVXI4ZllwTDlGSW41dGY3TERRYkN0b2p1?=
 =?utf-8?B?M0VLeUNNTWdSNkRPTmw0b0ZqOXJIQmprakFqbXJva1BWekx4MlBkREhXUmRh?=
 =?utf-8?B?b0hFTVp3OVVkTVhRS0JCTmVvNS9GL0FWZnlpUHhNQmZ0dE1jSzc4TDdnRnFJ?=
 =?utf-8?B?OWtWcm93bHkwZTZpYlJBUXJLcTJsS2JBMVk1TjhWdzhEOWVVMG5ua1pxZ0Nr?=
 =?utf-8?B?UkVFSjdCUUtUTUFvQ2ZKcS9ETnlSVUsyK3FhcTFzRHY5OUxuTkhNWitrV0Jt?=
 =?utf-8?B?YWZDTUtCZ011ODNtZit0MzJvc25vOU1SQkkyN2hwOWJNYmJtRXpaRnlYUWt5?=
 =?utf-8?B?R1g4TG9tcG1YMUduOEVOMkxiVVdwWTUxRktWYzJILzlSbVdDSGhienYzUHVl?=
 =?utf-8?B?aElHcHl0ZjlkMmcwNldzRXFVNWcxTHpXRWdFWGx5clNGUWlNTitnS29ZM3E4?=
 =?utf-8?B?Mitsc1NXcjFEMzAwTzdmaXhCVityb1U3L1BSaDByWERiOXRSdGwrRXlwVkFR?=
 =?utf-8?B?UkpQZis5RnVCR1dqZm1RUDMvSVFZWGZRL2l5bEdFaFN5OC96aDlIZ0xWV3Vu?=
 =?utf-8?B?R0JuV1JUYTljUmhIc2N2VnY2MjdrU2JsWW1NQVZIN0ZDR0xJWWgyZ2tOc0R4?=
 =?utf-8?B?Zk4wVTFHVEVyTURoemVraXpET0dpTzJRdllucnEvVytLVmk2V2N2VzBFMml2?=
 =?utf-8?B?T1JNU3ZEb3VMZHh1Wm1IeitZeHMxM2YvS1VKYThJZXBzT3U4RG9rNksrVTlm?=
 =?utf-8?B?SjUxUzB6UUJubzgxdFl1K2ZMb0JNZFNrTTduQUZYaXBIT3M1VkFHWGdzOUZr?=
 =?utf-8?B?WTk5TnBDeEM5QlAwUC9tS1lldnRjQW92WWVIQXdKYnc3RzdNcEcrYlR6M2RD?=
 =?utf-8?B?NzRielhOY2grOUxMb1NYZGVyYzl0Zk9HVkppdmtGMldzK0RiZEJocXZSazNF?=
 =?utf-8?B?VHowVlFrM1VNVS96K3lEbFRQS3l3RXRVaTk0SkJSUnFrbFNnUlpwKzdJQ3VI?=
 =?utf-8?B?Z1Fvb2N4bjNtNktzRUtXVzJsdkJmdzlIYjhUQ2FKOGloUmxPOGF4NnRuMDlS?=
 =?utf-8?B?a05vYXhHdGxkNmljNkI5dzVEUXdtVUdOMmFmTTBOdVl4UWVUSmpQL2YrbkZ3?=
 =?utf-8?B?eEx4MmZrMXFnajgybFNONGRPNm4wSWdMK2FPT05vMjlyQnEvOHZ6WGNCVW16?=
 =?utf-8?B?TmJVVDYzVFhOaW5nQkU4SWVvVHAraWdnVkJsd3c1WTJjZ0tCU2w2ZlZ5SzhQ?=
 =?utf-8?B?MUhOclJyeFhQTnluNjhZS0tVbVpnYlpNcUtBemRxdzRSNzBtVHBmZGVkVnFp?=
 =?utf-8?B?djFHbkM5a2k3bGROLzhhSXBvTDY2TGNDZ1BUbjZsKy9JWWVKRVByNHRzVEhV?=
 =?utf-8?B?M24zdHNtL1BjRVRJNUZLT3c5UzJLa1U0SGRpdlN2SFM3L1cxQkw3MDNwTUVN?=
 =?utf-8?B?Z3hxTUpCRGU0VTVFZDQyaTMxRy9iTTQ2NGs2OTc3Q2VZc3pHQ1psREVaS0xJ?=
 =?utf-8?B?WmEvSHpXOXFVSU1TS0Z1UktJdkI5d25DTTdSdmwydk05dTBIaFpLa1dqV1kz?=
 =?utf-8?B?K2FiOXFnQUViVXFaQ0JKTWZLQ3RMYnZtamxZL1BzUzc0ckJtVER3bE50b2JK?=
 =?utf-8?B?Szk3TUs2OUZKYmFYQlZrZzdjZHR3aXV2RDNNZDRNWVk4clVnc0FnMWI5akRP?=
 =?utf-8?B?bW9nUmgvVExNdWFNNkhYb25xYjQrUTJPZzEyME5CVTdidFhMMWMvdzdpbEJ5?=
 =?utf-8?Q?11veLzKf2mLrkt6/Fd82Hyf08?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa20eaed-6d94-43ad-ed09-08dc83bd4b02
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:07:01.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMcWreHWAhTTcthEkDKuHeyHrMQF263HdDGymIEL1sGBIwqgBZiVWsyvodxZWZhy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231



On 5/15/24 13:23, Jay Buddhabhatti wrote:
> Currently return status is not getting checked for get_api_version
> and because of that for x86 arch we are getting below smatch error.
> 
>      CC      drivers/soc/xilinx/zynqmp_power.o
> drivers/soc/xilinx/zynqmp_power.c: In function 'zynqmp_pm_probe':
> drivers/soc/xilinx/zynqmp_power.c:295:12: warning: 'pm_api_version' is
> used uninitialized [-Wuninitialized]
>      295 |         if (pm_api_version < ZYNQMP_PM_VERSION)
>          |            ^
>      CHECK   drivers/soc/xilinx/zynqmp_power.c
> drivers/soc/xilinx/zynqmp_power.c:295 zynqmp_pm_probe() error:
> uninitialized symbol 'pm_api_version'.
> 
> So, check return status of pm_get_api_version and return error in case
> of failure to avoid checking uninitialized pm_api_version variable.
> 
> Fixes: b9b3a8be28b3 ("firmware: xilinx: Remove eemi ops for get_api_version")
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> Cc: stable@vger.kernel.org
> ---
> V1: https://lore.kernel.org/lkml/20240424063118.23200-1-jay.buddhabhatti@amd.com/
> V2: https://lore.kernel.org/lkml/20240509045616.22338-1-jay.buddhabhatti@amd.com/
> V2->V3: Added stable tree email in cc
> V1->V2: Removed AMD copyright
> ---
>   drivers/soc/xilinx/zynqmp_power.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 965b1143936a..b82c01373f53 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -190,7 +190,9 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>   	u32 pm_api_version;
>   	struct mbox_client *client;
>   
> -	zynqmp_pm_get_api_version(&pm_api_version);
> +	ret = zynqmp_pm_get_api_version(&pm_api_version);
> +	if (ret)
> +		return ret;
>   
>   	/* Check PM API version number */
>   	if (pm_api_version < ZYNQMP_PM_VERSION)

Applied.
M

