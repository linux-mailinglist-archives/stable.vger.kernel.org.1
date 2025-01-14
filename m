Return-Path: <stable+bounces-108627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D2A10CCD
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 17:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B31886C40
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953561D54E2;
	Tue, 14 Jan 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Di/Wboe6"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963131D54FE;
	Tue, 14 Jan 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873704; cv=fail; b=pXHVCYBMjiU6V/NskV++n1lhXkFGm8/EG/f2l1q6MgX8CA3qCo+D8AJswMcoWf2yBVMS7Gf9dd2luOcLRc30Kpur8yPtdA0mY+n+COCqD8Gc1iL3ueg90Vg7/1HhqH5jA/B37iYgsdGtezQ6RylykYiAgMQrnDP1Aozq5UWgwAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873704; c=relaxed/simple;
	bh=TA7q/3wAfZ1DY3lL/jcphjvLx3MUop3oa/gX7gzZoMo=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=uac4E/X338AJMm7t69VSHj/ysNxD/zmVbMqJJTSRwIjlLmt6kpRPP7Ryt0ALZnz7Z+7HlIj/RoVi+G33Y/7/HFjcHAcGP1g+1qw8rOLFHmfKWky34clasULHMauHLlHSJIt24zNDq5jbDY5F+PhTrmJ/8FFlwWZgwkFMGKDcuP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Di/Wboe6; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOTnj8JYlJ1t/3asLyw6WA9ISWb7hNuMR/hkDubl0AZodLjeoPmHWTj2jNWW5zj+QRJTgNsAm/eBlDRf2CGoLi9L3s6JygFpYT9KD6u6SiAWkHaqkQ/SNTK8MEEVfFndQoE/oIviPfTAlFjCcl8tMTv9lClHJfwyf0/CO+dHCBCSO79LbzzrooJiK3FVnCJsX/IgXdHcahE/BHbGrv6k9NU8PdCyyC1xlbnv6NmbNMdey2DmxJIoeAeWmIEtk6z0hP6PiZGakiDyYTK+x/zunXT4OecZ0wmSdQj6NHUDI/QettHR8GipqRkShj1CpB9AxPBEJnUzc10rp+UF8oDvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAmMv73ifLveKrdhR68wLYsTc5hAw3qavuYYVdtH1/M=;
 b=Zdmp2JGlKAsxI9nBuJTKUZMdA1IKSd3tlVt8TwZmTv/PBR8ntZggps7ZjZmV6XbfCQuFsXlNduAo5GJklH34uFdOVNNILhk8zZu01GP5w/ja4hdudvhSXCbxM9RJ0Y/rwx2DbJdJMZ0Fo77duNfy0tMGKnsNypq32Uj8s8n502cCDq8W2AXyJ25BEz4tkHI91f8KcmWaVsIDDb0bDYvuyNwJHhcOcJ7aHTbhRvuD5gdvuA5DKof+3DMSrizrBATLUTfRqufGGhgVhSIp0Auyk97AzQZh9qxIxNSEltNeYodQ++v08NQGAMmZB1B6dO3ngS5cPbet5CHni0ljbx2qmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAmMv73ifLveKrdhR68wLYsTc5hAw3qavuYYVdtH1/M=;
 b=Di/Wboe6TToesZasOUZUWx1cjHl9wnZG2BQcLzadl5IvhTsQBpVBNFuCMujiwZzJNMvbuK7uFUKJPmH9Nk1dsbgBYQ5pbFw3G7+V3Z/D0GYKt+Dsrk1RBBTGndVJfzA7QHIRj2w+en+W1cWyNAUK5GqmTGcktho4o66GT6b+Xxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 16:55:00 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 16:55:00 +0000
Message-ID: <ff8daeb1-4839-b070-dd94-a7692ac94008@amd.com>
Date: Tue, 14 Jan 2025 10:54:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv3 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:806:d2::19) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4e36ef-cf90-4c2a-e242-08dd34bc2e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ayt0T2NRZHRuYVpESnc4RHh5ZENCdU5sWHZEUmp1L2JVSDdDMW1WdlQyL3ll?=
 =?utf-8?B?U2hKdk16UXZFSE8wREV5R1dwT09IVWp6dmFOaXZQVDB4ZnV3SDAwbG5YVkNy?=
 =?utf-8?B?SitHOHZ1OUp1L3d4R0tRbml3WFA5RmNTZDlLNVAvd2h3eFo3SGNwQWZJOVNK?=
 =?utf-8?B?eDc0SGRoL0lCMTFUVTFFMnJNMU9KemxwN0RrcDFjbHp6cE50aWV1b1ZnbTlk?=
 =?utf-8?B?dWFvN1NEZkIxK2NzLzhJZjkwaHVFKzZ5dWhINTlUMm9yT0IyajhGdU9yQXpo?=
 =?utf-8?B?d2o5Nk9wYjhkNUFGblU2djNwZkpadTB2UVBNOVlNTEdKSStSMzF2L1VWTGxZ?=
 =?utf-8?B?bENxTysrTkd6RXo3Ny9IVTByUUR1cEZtalBueVJ4TUlQS0VNaWVpZjNnUmgr?=
 =?utf-8?B?SE1EbzdsTEM1WWE0bGo2TzM2dkxVbCthbUpQQVo0UGlJSWd5cWFvM01KcG4r?=
 =?utf-8?B?UDd4T1dqOEl2SDY0RmtoYUJHazVDb2JMNTJHbGZsWGpFOTROZFQzdnRSK1pl?=
 =?utf-8?B?YmFQYkhLcmNGaTdaMFVBOGRPcDBydyt0WGpraDBKSisrazM0U0VFbGhibEVB?=
 =?utf-8?B?OTFQZStuTFQxRmlod1BMa3FuSlo4RThhcDBLV3lNeE5aSFpUTmErOUxoNWpK?=
 =?utf-8?B?UXZOVitwblVkTWpKcmNxd2w5UHVXYXVQa1VwWFUxMy9tTGxETzAwK0pjZ2tZ?=
 =?utf-8?B?Q1pzd0NKTmd2UHJjTitFNklIZVZyTjR1Ly9oT3ZUSzE4V0xBL01OdmNxS3lz?=
 =?utf-8?B?WmxmNmRTVE5HYk9GZUdWWGMvRGZmcVUvMXY3TzlTaC9Dc3lGejBrYkE5YnF4?=
 =?utf-8?B?QWl3NGdUamJTT2UrYWtNbkVnYTdFRWphTnZVR1RibTRmQWQyYi9QWnhVL1ZL?=
 =?utf-8?B?YWk1Y2s3VGtHTGVLSHZ1TnpvZHEwYklUUHV1QzBkbEZlb0FFL3VMdlJuYTFE?=
 =?utf-8?B?eTM3Z2hBYndTZDRPS1MyVW9kZjdmYUlRNVRMTHVXMXFQeUFKWTR3NGFmWE9E?=
 =?utf-8?B?eEdsYVdtT2E1OFFqUXN1Titpb3FabW44eG96NFpRc0xzUk4zN0NlVDhHUlEw?=
 =?utf-8?B?NmpVMHUrOGd3eFZ6OWRxV2M3Y0psQ25pVXg5RXBONmh6Mk9hQjlsZStOSzht?=
 =?utf-8?B?Y2Q5S29vWjluTEVOanhTMVZOV0xRMUwzWG90STJNN01jK3pZSzZIQy9rMUp2?=
 =?utf-8?B?Zk0vRW9qZVZ2U09GUFFuU1k5alorNE56VldPanYrbVEvck1ncnVKcElEc0l6?=
 =?utf-8?B?NklOaE9UUzkrMWY2WE1jMzhFTkFGY00vKzE1S0tGK3B6NnFhS2g5VHpvckh6?=
 =?utf-8?B?REE2WTI5QWtHRUFMUWY0eG1JL01IWFJKSTNWb2hzck5qSnZZUTRFNUF6Yis4?=
 =?utf-8?B?Mm1MMWFhZ1JMVkg2Y2txNFAvOEZBUGFKczRJazg4eVR0Qm1oYlRYdzdlMHBW?=
 =?utf-8?B?NTM3WDc3Wmt1c1p2L3NzeTdTRW1zU040Q2RDTHowVjViL1RlVkUvbnM1M1M4?=
 =?utf-8?B?TGRDZ3Q0T3EvMU5MYUJGQkc0Y0RqQldPN2FJazhoRlRsYzEyLzJMQzdhUG9H?=
 =?utf-8?B?UnQvKzFmcnQ1bVpiZXNkckxBZnFzNTMyNjlQdXRwb1ZCNnYvV3JZR0NyQVIz?=
 =?utf-8?B?VGh5MEhCNjVFNVlIamlERS9lVi9LYlJjQmRqOE1hNE16SmxRTUtlM1FCNTlM?=
 =?utf-8?B?Q2tvRURVSVNCVHBBQmtWVjJDeENsZ2Y5ODhwUjlZSkNQbGE0cENTQk5GMEVl?=
 =?utf-8?B?aFVLWXRyQUtmNTlyS25PVmJJLzd0YlhrT3BueTVaYTIzNHRSMFdiTnlRNDFm?=
 =?utf-8?B?WS9JbkM3eTZIRkZZMk82SVpQNkhqcTFkMkpWY0VrTmdoWFVVUXE3K3AxV2Mz?=
 =?utf-8?Q?TvMMLJhh9bBjk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUhqYWdLRTdITFpjN0REeFpSMExRTGV6WnVHRUc0UmVYcktCRTRMRlh0TGs1?=
 =?utf-8?B?NERnNnk4LzhYVFRMaytBR1A1c3Y3UW5rTWxoV2xNeTBVNTM4VmJRODNWLzBT?=
 =?utf-8?B?cTZFS3YyZDNCY0l6eHRPdFJrT1c2NFJRZEh2Q3RVY2FOSWdvRTRVeDJ5VHk0?=
 =?utf-8?B?dnpKY0JqRmduQVFFL29XNHJ5QW42dzdSNWNtWE9QZCtMS1NzVFR5YnF4REwy?=
 =?utf-8?B?VC92Ym5DalRleWhGVGF3S2FqelM1NWxwYm1xOEFGUWxSaGxpVkRqMCtkcXpU?=
 =?utf-8?B?R0hsRE9TUGE0ckhlYXJSUnE0clR2UG9CUmJpa0NpSHVWaWhlMitwWlBZNFQy?=
 =?utf-8?B?L0VzK1N2ay9ZTStWZjZpWjcwV1h1UHgrbFRVc2dJQlFGQ0FuN09URVVnS2Fl?=
 =?utf-8?B?VHlyZXNHUGFUUUdmVHBNS3pKRXlITTBuZTFFQS9lVFMxTnNUQUMrOEkxWjFV?=
 =?utf-8?B?cm5yNllhS2FwZk82c3FUd1J5NzFPdWNJZEpaQkdjMzlPQmo4Smc3ZnU0NUFl?=
 =?utf-8?B?ZkVnSGs3aU90SjBmT0lxeWFJUTVEVnJJWGJyWllaNjRIemFPaXR6SjlpbGo5?=
 =?utf-8?B?NUlVemMvU1FueDFXY1FUU0pveis0aldsSnJtOHdOTjdIZmpjM1Z5bUpORm9i?=
 =?utf-8?B?bTI2b2N4QXJqQlUrcHIwd3BGekdZQ05KMFdqbld0UGVEYkpibE1PNG9nQVpX?=
 =?utf-8?B?MCtGZlhPd2VhdW1Ycm9pSVFyRElpd3hlNC9sWWpnZUxUZHp4eWd3YzZMQ285?=
 =?utf-8?B?WmsyY3pSMHc4aEVzMnhaTzhxbkowOTJkN095OEQwUDNWTDYvQWpySk5ld1Fu?=
 =?utf-8?B?aUgreVpkT3EyTWZ3TGZlQXBLTTFmQVJWYjhmcXByaGhhL1oxeUlJT3R0RlRh?=
 =?utf-8?B?ZWI5M21kYkhNQ204eHNmb20zcXg4ZlhxRlNpc3J3Tm53ZWJPRmdMQ2tNUnJI?=
 =?utf-8?B?OVV1VWxoR0Myb283c0trS3VodGd6WnZUUHF0RDFKQU9RZnAyQVlxK0xKY0RN?=
 =?utf-8?B?ZDFtZHhBUTBYQzNVbXNjNmRvNFAyZWhCQTc2R3JyaFFsR09QT0s5MEFkQWJn?=
 =?utf-8?B?WG5mbUJWV2t4NURSQlBFWU1EUlFORUdaYTNXNm5xU29DaysrMUkyS0tBRnk2?=
 =?utf-8?B?TlNISmNoUW05eThFYm1LeWFRY2FmSzcrT0dxS0FPUjRCdlBnU005MHdsd2l1?=
 =?utf-8?B?elpsanpvQVE3M200Z09LTysvUXZydjE5RDVzWGlkdHhndWFRckRYckhZZTdt?=
 =?utf-8?B?TDh0NmgzU1UzMW1wZ2hnaTYwdW1LSFdCZUNNbk9rWnNVVElWRGdJL2MwRFla?=
 =?utf-8?B?SFJEbGg5N2c5RGJYNDFoamJiTVk3YzRoT3pVTHR3QTdUZ0gwblM3aFZOa0V3?=
 =?utf-8?B?bzZJV1dQK3lMbHpUVWVaK05MTlhsYlVrZ2FwV2hrVEVObWtJTlF4VXZYck8x?=
 =?utf-8?B?VUxPSDk4ZmZKQ1Zya3NtSWo3TWcyUCtnWDNyVFdFdXY3czhMMDhMV2JnQkp5?=
 =?utf-8?B?MDdlWjNSd1lqWitINWZmS24vMXhaWjFTSWpHUml2VWxJMzlIaVhXdlUrcnFW?=
 =?utf-8?B?SmJjajdlYXprZk55ejNZUzFiSm40YkxyYWNJd0lweFFXeEo0QnFSU3JJL3R3?=
 =?utf-8?B?N3NhazJ6d2twWmg3Ky9oelpxN0Y1cUJDMVFHRWRnK1JMaytWTVVCcGJQVTlR?=
 =?utf-8?B?OTZLeC9ERCtPYWhwZ00xaWg5YkZsYVg5MlJzU1k3UkxXR0tWOXpWQm9mWFVO?=
 =?utf-8?B?OFlZZFh5dU5KUmN1anQvbkMrd3B2TE9ZQXdQVDFkTDhlNXFsZkI4eWxBZnY0?=
 =?utf-8?B?cloyRGhnK2EzanJmOWN1QkhkZ3RIUUVManZBL3ZLVUFlS1Nib3UwSUVrc09G?=
 =?utf-8?B?NVFOWDNNdGtnd3ZIR0UzK3lQd1dtajlxR21mQ2dMN0pHbG0yMDE4TGlOR05Y?=
 =?utf-8?B?UTkzRnhKT0NyWk9FU2VMWFVMTnVqZk9ieHdJOGJkeWhqQ25Zd0ZmdU1pZDk1?=
 =?utf-8?B?TWRFTnI3YUVwb3dCcjRacTk4VGF4OFlyd29kRlFIbzlkQTh2U0VsWU5ucTRS?=
 =?utf-8?B?MGRGL0ZtK3haL2NibkwyRFNEWC9jaWl5MTJoVHVwL3pjM1l0bnZmOUZicUs3?=
 =?utf-8?Q?fvw0K495ZKiRKPN+YmfjCsFMt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4e36ef-cf90-4c2a-e242-08dd34bc2e70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:55:00.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhiU7/DP4JTb1OizpJzdM3deUFaFwM74pEPlk0+dytOZmZfu6PUFdYlp5z6cdZE5QkFOvsEvX1r8pAHyMkErmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

On 1/14/25 09:06, Tom Lendacky wrote:
> On 1/14/25 08:44, Kirill A. Shutemov wrote:
>> On Tue, Jan 14, 2025 at 08:33:39AM -0600, Tom Lendacky wrote:
>>> On 1/14/25 01:27, Kirill A. Shutemov wrote:
>>>> On Mon, Jan 13, 2025 at 02:47:56PM -0600, Tom Lendacky wrote:
>>>>> On 1/13/25 07:14, Kirill A. Shutemov wrote:
>>>>>> Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:
>>>>>>
>>>>>> memremap(MEMREMAP_WB)
>>>>>>   arch_memremap_wb()
>>>>>>     ioremap_cache()
>>>>>>       __ioremap_caller(.encrytped = false)
>>>>>>
>>>>>> In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
>>>>>> if the resulting mapping is encrypted or decrypted.
>>>>>>
>>>>>> Creating a decrypted mapping without explicit request from the caller is
>>>>>> risky:
>>>>>>
>>>>>>   - It can inadvertently expose the guest's data and compromise the
>>>>>>     guest.
>>>>>>
>>>>>>   - Accessing private memory via shared/decrypted mapping on TDX will
>>>>>>     either trigger implicit conversion to shared or #VE (depending on
>>>>>>     VMM implementation).
>>>>>>
>>>>>>     Implicit conversion is destructive: subsequent access to the same
>>>>>>     memory via private mapping will trigger a hard-to-debug #VE crash.
>>>>>>
>>>>>> The kernel already provides a way to request decrypted mapping
>>>>>> explicitly via the MEMREMAP_DEC flag.
>>>>>>
>>>>>> Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
>>>>>> default unless MEMREMAP_DEC is specified.
>>>>>>
>>>>>> Fix the crash due to #VE on kexec in TDX guests if CONFIG_EISA is enabled.
>>>>>
>>>>> This patch causes my bare-metal system to crash during boot when using
>>>>> mem_encrypt=on:
>>>>>
>>>>> [    2.392934] efi: memattr: Entry type should be RuntimeServiceCode/Data
>>>>> [    2.393731] efi: memattr: ! 0x214c42f01f1162a-0xee70ac7bd1a9c629 [type=2028324321|attr=0x6590648fa4209879]
>>>>
>>>> Could you try if this helps?
>>>>
>>>> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
>>>> index c38b1a335590..b5051dcb7c1d 100644
>>>> --- a/drivers/firmware/efi/memattr.c
>>>> +++ b/drivers/firmware/efi/memattr.c
>>>> @@ -160,7 +160,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
>>>>  	if (WARN_ON(!efi_enabled(EFI_MEMMAP)))
>>>>  		return 0;
>>>>  
>>>> -	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB);
>>>> +	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB | MEMREMAP_DEC);
>>>
>>> Well that would work for SME where EFI tables/data are not encrypted,
>>> but will break for SEV where EFI tables/data are encrypted.
>>
>> Hm. Why would it break for SEV? It brings the situation back to what it
>> was before the patch.
> 
> Ah, true. I can try it and see how much further SME gets. Hopefully it
> doesn't turn into a whack-a-mole thing.

Unfortunately, it is turning into a whack-a-mole thing.

But it looks the following works for SME:

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 3c36f3f5e688..ff3cd5fc8508 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -505,7 +505,7 @@ EXPORT_SYMBOL(iounmap);
 
 void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
 {
-	if (flags & MEMREMAP_DEC)
+	if (flags & MEMREMAP_DEC || cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return (void __force *)ioremap_cache(phys_addr, size);
 
 	return (void __force *)ioremap_encrypted(phys_addr, size);


I haven't had a chance to test the series on SEV, yet.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>> Note that that __ioremap_caller() would still check io_desc.flags before
>> mapping it as decrypted.
>>

