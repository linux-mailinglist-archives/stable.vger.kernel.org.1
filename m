Return-Path: <stable+bounces-134655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71360A93EF5
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 22:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C25172714
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7544A211A21;
	Fri, 18 Apr 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KnhdasYV"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052615442A
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008364; cv=fail; b=IMhp/8mzW7CG7dGJ6vXpsDldbRdjb0q5qzkW+fwuZwVm/vBtvgDM5vtC+qFdJ9L6xAbmn38fz7YpOM3ZS1ujYOqQaWCmjnZ0tpnriFJUKgm7UDq8wGTCUdXfclrf5snPd4prkQorKWKeAqRFbMCczLilCFNDZeMBevGhzQtcldE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008364; c=relaxed/simple;
	bh=Z4rrffH3qgPiVe8np63phLqcWcmWEUsIHsYBppAroRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hBOnqBz4PEaF0Z7Ph01oPkmy2mlX5vP9LVgHSyDhO1JNKDF8b8MX8gHxxa8ycGK+mJqiHBnGaSjowiFeg3sfZTMexXaXERoY5GPH9GwPH5GrEEdTBC7ZsjHpo6N9zhFL71PfUUgK4QR55KIKdJBPWBxo1+OpDvotkHV68D+YoG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KnhdasYV; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrcPzBJHRMaLqYu3JO1CSc5FBHyTsYjg0WhJ4+10xPQvC9KiRqEw7XmBq0lIOGU7OiZQ3pWVyDTKhhuvyi/Pnu+AMy7/m0wlMtW5546qu+s2GEYgt3Hz8EaGsMGq/b0HOVyxFHaQLTE7US3nJc09GS9J8XO3j8R+/MlUVrHz4k6qBTQczsqOK4psmGOlDti8HH+MVnwPZKZmyataBNUX+rB5G6Hs16K5FWYpACmGyJsPSj5EPzGRNEaCWEKxoR4ZwTJVHXHHiY2XbVCySPPS0yJaJ6wfDff9nXytLWM28RZ/YeabtWHKVPXnxGAOvRqYK09bGrLj283goaeJg2HoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ11hPY0/22m88jeig2tCGrSmIsMLJ2dLnDdFshLvIM=;
 b=m/V5E4QLeG50zIvP+K3RggN+7Tyk/es2F+w99CI2cVdP003BkR8iVRhuiyKwLcQxG/Y2UEDScTKTWT2Hws/GliuUJVCA+Y1hY88IWTv/UhYSsSl6Cf23lWpyHFYt5sk0Tj3evxD7179lqdpkImp5zp0wPFlKyEK8/FJQtnbb5anJsdAyppLj8O3Zlpc9TbGBL35l3SbazQxYceHhPUJCxtGE0QYGT14GiqdTyAbRBG60SBnX8hBy/gWrg9dboKGePfj10uPypELyKcSJBHiiY0+Db6PCdcQ6LTEAhRc2WktzY4gM6U46rurxNjtt4uVw8ZuzA+ypCSYqbig1r0oXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ11hPY0/22m88jeig2tCGrSmIsMLJ2dLnDdFshLvIM=;
 b=KnhdasYVP9V51sZQPXFqK/Ox0qr3sXuUpG+E4rZMz+xwhN92Z5H17mDcOBmiYpWlU9rFqCi021Gn1vUI2I2//OooXB585SGzUTkAFcwHxDd2HldeKL+An5iIwV9/EjuLNv8YtBQp02MTJEdRF57y1g5ipk0JwBt2dyw9dTa75HI=
Received: from DM6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:5:14c::44)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 18 Apr
 2025 20:32:34 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::34) by DM6PR11CA0067.outlook.office365.com
 (2603:10b6:5:14c::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Fri,
 18 Apr 2025 20:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 20:32:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 15:32:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 15:32:33 -0500
Received: from [172.21.212.118] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Apr 2025 15:32:32 -0500
Message-ID: <bb347b9b-0dcc-4fe2-8deb-11661b3e2510@amd.com>
Date: Fri, 18 Apr 2025 16:32:35 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/pvh: Call C code via the kernel virtual mapping
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>
References: <20250411160833.12944-1-jason.andryuk@amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20250411160833.12944-1-jason.andryuk@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 531069b2-5902-4465-b0e7-08dd7eb82678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEtXazdQZXhOdmc3T3hCbGNobFpBeitTclFUZGhmUlovZGtua2tySzJwV1ZM?=
 =?utf-8?B?RWtaK2l4UFBRMHRhTXp5UXU3NE9qRU01RTdwMnFnc3Q4NzJISndrL1NmMWZP?=
 =?utf-8?B?d3Z5WmtUNlQ0ajJMbVdTL01OdHFqK3BIM3ZMWUNsVVRCRU1MYUsxbG45ay9L?=
 =?utf-8?B?YnRYNTM4eG12UUhyRWg5czNLdU0vR2xCbFlkTUpSZlRYVGU5VDhrNkhHckpP?=
 =?utf-8?B?b0ZwM1lTRER0bktlK1VtTHErenJBZk1TajY3bWpYT2IzcmhPRWNCRHNad2ZM?=
 =?utf-8?B?aE5QeWozcTMyclRZM2pNaWNBNnFFSEx4VXJZS1FYUWY2VTBMMFhMbG5leEcw?=
 =?utf-8?B?b0dIZmUwRlA5U2c0NUk4U2NPaVZoa1pLR2ZTQk1mcVBMTE54N2JpNCtoZGZw?=
 =?utf-8?B?VFVWOXk4cTQrUzdWdUs2Nm15UFlrbHp0QTltWVFlUmdBaWJESC9DTldiaDVw?=
 =?utf-8?B?RVJtaXlFbDRlZlcrQkVURTdCYncvRnZRdlRxUG9nbTg0TzJqVnV4YjdSZlow?=
 =?utf-8?B?akhRMzlvazhVU2NkT1d0bkU0VzJqOU4yNG1FWGViVVNGYWlsZThqUWREbUpt?=
 =?utf-8?B?cThxdEVUK1Q4cFJCUzM1SlJ4RW44UDRYc2kvV2hwb2tFYzd2K2wwaWJiRHo5?=
 =?utf-8?B?YTcwVjRaaTU5ZXB4ZkZJTzRkUWo3MElhaEsrbTJKMSttRkxza2VyekY3YnVI?=
 =?utf-8?B?ME1FSk05a2NuWHMybGowdytCYzJhSWVIQ0haY1FqOXhoUzhsV1hHZ1JiemR6?=
 =?utf-8?B?Z1l6dFBJRnE0eFpVWXpudmlMWk9NemxldkxXRkZoTUxDWFk1VVVEKzZxRkhK?=
 =?utf-8?B?Vlg5Y29rckVsbmZ2ZGhMQkxENWZVd2RrWitYNmdEa3FiUzBuTGFVb21uOGcy?=
 =?utf-8?B?bWh1dVh5cU0vRmZLdmJUU3lYV1RocFA3ZUtJeUkvTWUwYWpCUm4yTnlyOEcr?=
 =?utf-8?B?NUVFRXJDcXhVbmVja0lpa3FqNzhySmFzL1k2c0Z4bnlYS0ZlcXQ5cXZLeCtX?=
 =?utf-8?B?OTlDSXhwdGxNUWtjNXZleU1DVVB3NlpBZnE0UWM4VGluMnVQcjJJcENRMGEy?=
 =?utf-8?B?YmJBRmpDY3BRNGRBNnE1b0JuNlg5L3JFODdVV3B2cXpKT2hJMUkyZHJrOSs2?=
 =?utf-8?B?TExYSEdBUFFjRktVTGNHQmVUY2ZmTXlLTllTTWpEZDZiczBQbmtCTzJ1NVdn?=
 =?utf-8?B?d0ZMNHpWeXU4OVdHb0hJUEVCeW5YREYzWTRTL1UyR1l4Y0pzenE0YW90cUxr?=
 =?utf-8?B?eUF0WmZsSGN2Y2dLNitPcjVFOVgzaGREckg2NXdqdlN3VUI2cFN3SDROaXZt?=
 =?utf-8?B?RlY1cFV3U1VtSFJlR2dPeEhtMHBvUEI3MVBTVUkrV1MrL25JLzJYZy9DeVJ4?=
 =?utf-8?B?QSt6SmJDUkowYW1EL2ErVGg3dlZQK3RsbmxIVndrTHRLVG1Fb25xQ0Rsdnhz?=
 =?utf-8?B?UTRvQWt2M3psRWE0eDlsQXVuNVVkaEJzWVo4YUludnJwTWZyNkxxV1JHSHRW?=
 =?utf-8?B?YzJIbkVxZjJueGNTbDFiQ3FNaWhaQlRWMm9teFpMRXVIMFVYY2NUaG50czBE?=
 =?utf-8?B?T1JYVndYemFhQVZMYlJ2elJqZW11RE5lTFhBNXlSUUZtMDNjSUF2enJQMWtT?=
 =?utf-8?B?b2o4RVNmTjN6YTd2eWcvV0orajhoZjcrVjVKeWVFeHJEK3lKSCt1UGFkbUFU?=
 =?utf-8?B?Q3AyZzRTRWlCTnF2WVNodTQ5NFNyMDFZRDBnUys1dDM2MDQvTnRPQlc1aFQz?=
 =?utf-8?B?WlMxNTlDSUR4UFhTK2laVHFZRUxPeFRteGZLazAzVjNEWlRnTEJFS1VHTTBD?=
 =?utf-8?B?TS9GM3FXN011WDh4TUdnZmFzZUlUaVBiMHlRYVl5cEx4YjhsUWJENlJXWitq?=
 =?utf-8?B?cVZRODdGdkpSM2VHa2RHbFZiZzFIcGJacjd2aTAwa0wvRURNdDJlamVYeGsz?=
 =?utf-8?B?VytRVFFFQ2VwcW5NVnZ5cHdWUFJ5S1NZNVJiSGp5NXJsWVpFQU9ZaWJLWDRw?=
 =?utf-8?B?dWJURExRYm1ZMTZVa0xSbmlndGVkYUMwSVRzZ0dWcnhvRGVFR1JUSURHL3ov?=
 =?utf-8?Q?iyMz1Z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 20:32:33.9441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531069b2-5902-4465-b0e7-08dd7eb82678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429

Hi Greg and Sasha,

It's been a week, so I'm following up on the status of this.

Should I use a different tag than "PATCH" when sending a manual fixup?

Thanks,
Jason

On 2025-04-11 12:08, Jason Andryuk wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> [ Upstream commit e8fbc0d9cab6c1ee6403f42c0991b0c1d5dbc092 ]
> 
> Calling C code via a different mapping than it was linked at is
> problematic, because the compiler assumes that RIP-relative and absolute
> symbol references are interchangeable. GCC in particular may use
> RIP-relative per-CPU variable references even when not using -fpic.
> 
> So call xen_prepare_pvh() via its kernel virtual mapping on x86_64, so
> that those RIP-relative references produce the correct values. This
> matches the pre-existing behavior for i386, which also invokes
> xen_prepare_pvh() via the kernel virtual mapping before invoking
> startup_32 with paging disabled again.
> 
> Fixes: 7243b93345f7 ("xen/pvh: Bootstrap PVH guest")
> Tested-by: Jason Andryuk <jason.andryuk@amd.com>
> Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Message-ID: <20241009160438.3884381-8-ardb+git@google.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> [ Stable context update ]
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> Stable backport for 6.6 .. 5.10.
> 
> Direct cherry-pick needed context fixups, which are made here.  This
> upstream commit was previously included in stable, but with the pre-req
> of b464b461d27d ("x86/pvh: Set phys_base when calling
> xen_prepare_pvh()").  Both were subsequently reverted as b464b461d27d
> caused regressions.  This backport, e8fbc0d9cab6, in isolation is
> correct.
> 
> This fixes a regression introduced by the backport of upstream commit
> b4845bb6383821a9516ce30af3a27dc873e37fd4 ("x86/xen: add central
> hypercall functions")
> 
> b4845bb63838 adds a comparison between rip-relative xen_hypercall_amd()
> and kernel virtual address of xen_hypercall_amd() to determine whether
> to use the AMD or Intel variant.  When running from the identity mapped
> address, the comparison always fail.  The leads to calling
> xen_hypercall_intel(), even on AMD processors, which faults and halts
> boot.  This affects PVH dom0 - domU doesn't seem to be affected.
> 
> This patch performs the rip-relative mapping from the kernel virtual
> mapping, so the values can be properly compared.
> ---
>   arch/x86/platform/pvh/head.S | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index c4365a05ab83..fc46b4dfbd74 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -100,7 +100,12 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>   	xor %edx, %edx
>   	wrmsr
>   
> -	call xen_prepare_pvh
> +	/* Call xen_prepare_pvh() via the kernel virtual mapping */
> +	leaq xen_prepare_pvh(%rip), %rax
> +	subq phys_base(%rip), %rax
> +	addq $__START_KERNEL_map, %rax
> +	ANNOTATE_RETPOLINE_SAFE
> +	call *%rax
>   
>   	/* startup_64 expects boot_params in %rsi. */
>   	mov $_pa(pvh_bootparams), %rsi


