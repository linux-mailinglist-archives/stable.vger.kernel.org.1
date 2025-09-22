Return-Path: <stable+bounces-180888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A7B8F24C
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 08:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A81897A90
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BE7C2E0;
	Mon, 22 Sep 2025 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HazJb9cy"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890714C83
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522624; cv=fail; b=Z+h/XMFeCd/bFbunUtb8/uMrcKtKpGaa7iaoB7EC48v22PDwqq/shZywzuWVVyzrPFjQwb7BPp2RlDLBqpI5CT+Z6lLOXSopH3KROdDQvZbRMo2aoCvvwbQAOhMKUFQyF3y7jCp0etVYYovghWCwvwaBLUc2LDZlQrCvxa5vWlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522624; c=relaxed/simple;
	bh=DAcPJMnSvrC2EoY6TZkSBvnvK2JtKCz146kTvLGCuho=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XYd4O8isF6F/n0rrONuo7NFI3qS4JnR0bn3YCQpiLvHFAV8cpeFUGSKsrxEw8AnCYUSJfPkhT2xwyVSjCHSWc40l7cUZ5WjIE4Ytht/OQxfYRTZc7op0vBOT8i7WIA8nJGYhXckBjJHw1rYSb0bJG1mk0rvLIA6Rm20JhoB/mkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HazJb9cy; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoU/SfuVa5Cya700YcA2YGyx1sKhEzldindLnOj9AxmkaNU3+vTDROWaN/Mmr/WdZYEfv94Bucuj2BgbDj6Ql9SpTpXrY9ckf8sGcBrpVbdtq/EBdb+pywcyifpJdG/WO4V+gfoM9rztXxGkVA9qSWDFquA1qUEMBeXk/fMOwbmxwVq7jav1xUjhUQByVmlTMBxDUnU5sDwQLU8WI+a3JJ39CRHnjdjFwoFd++uSbgqhpgPFqcmqTp6lZz0ksXR5uYU85i7n60jpW0OwgCtMWwZFyHG+6RiR+Ul/NBLDjEe2y4KUFMg6wwEtSP0a7/0An+FUQZFZhla73N4OjCbVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7km6DalXCxGCd/vLdzzq3tSsI0M3qxlenVlNlgMa/o=;
 b=ot36UtJ94WFAOP5iHNFA0JNuycrfhd1uueksJx+vfMYMBqawBQminYQUqClEop2Lmnm+nG+asqCxiNXKHpz92DstJ+NXTUqY8IgJ5p4kE02vypVJ25egqdpivYPPFe32cPBlKj7iFfg4zMkjvg2uAIKhSKttGOI2RLSys62eu4oIKihR3cG7joFwhYC+MIJ+mubqAntoINNBSrSnXxEGlGgsx1BpF/a222FCPpMy1+u+9Zsk/iou+rjzkEFh39W7Mr+BTbMvfrWVwaL61GFeV+BvmA/2yVr+sQUHPjzfHvKkRpPlQIrHwAZLId4OcDJXcQBHyN0T8EHJukAxHszz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7km6DalXCxGCd/vLdzzq3tSsI0M3qxlenVlNlgMa/o=;
 b=HazJb9cyEhA1BSwj/wC7Kh7PZDOQk+qzMX1oRM1i9W0uSqev/B5YpIOMrl8572vgXdIPSHEVxNi78jwJ1PsAa3mYrdGKu7zM5zZTfuwRnjH2kwjf+NkYeftdbpALsS6ypqTVf0f/5Okh75f9fPahhokgk97Q8i4KI0PzV4e1v+w=
Received: from BN0PR02CA0058.namprd02.prod.outlook.com (2603:10b6:408:e5::33)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 22 Sep
 2025 06:30:17 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::9a) by BN0PR02CA0058.outlook.office365.com
 (2603:10b6:408:e5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 06:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 06:30:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 23:30:16 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 23:30:15 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 21 Sep 2025 23:30:12 -0700
Message-ID: <32ad856f-1078-4133-b2f7-89c5eb2d271d@amd.com>
Date: Mon, 22 Sep 2025 12:00:08 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] x86/cpu/amd: Always try detect_extended_topology()
 on AMD processors
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Naveen N Rao <naveen@kernel.org>
References: <2025091431-craftily-size-46c6@gregkh>
 <20250915051825.1793-1-kprateek.nayak@amd.com>
 <2025092105-pager-plethora-13be@gregkh>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <2025092105-pager-plethora-13be@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f5dd83-a362-4382-ba7a-08ddf9a17e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1JJV3dXRllkRExTUFQrTXFxUkhUSERMSjM5a2FJOGkzcWo5OHBxcU4vMHRl?=
 =?utf-8?B?RnoxQVp5U0oyc3BsMDh0UFVIczJycDdFNzdVOUh5cVVsdnhzQUl2eEcrOHZO?=
 =?utf-8?B?SnVaUThMTmVtWmRUZElEZk1QeW5kdzhPUzZvRUlsVU9CdWcxU2pNVUdjUDBZ?=
 =?utf-8?B?alBUeUc3Qk1HWjA3ZTZhaXFxRXpSQ1FabGY0SkZvL0d1M0g3K3JnZGV3amRF?=
 =?utf-8?B?dk5ZZk82OUY0aG1KYjA1OE9veEZqUWFXQUl3T1I0WjlFalYxWExrbk1hYS9j?=
 =?utf-8?B?SXF2a2ZDVkVtY0F1RVNPTDk4NndHOU9kZFhkcjZTVHh2SjRHRW9IeVlSU0RH?=
 =?utf-8?B?a0hqU1ZseXdXRFA0Y1J4QTFVRVJFQ215SkFweWJQdUgzVXMyQU90UXBxa3Zp?=
 =?utf-8?B?NDdZUmlRRml4NTR3TlZSNWp4YWkrQWpBMVZzU3hEVStsWXdFdHpHRDhnd3pm?=
 =?utf-8?B?T0JyVk15ZnNPUjRXRE9QT1FBVi95VWFYSCtEenZvVGcrWS94RmFlSFJRbUxE?=
 =?utf-8?B?Z2p1RVBkMDk1dFVCMjNVQjlpOGwranovd1h0M3U1MkZCeU55MlNRaHpzbXZx?=
 =?utf-8?B?OWI5ZUQ1Z2htWnJsOEJJL09uRmpGRVZTYUdmaVg0VVdTZVVBZ21OaWx3QnJ6?=
 =?utf-8?B?QS9QQXUvSFhDL0htQVhZQnA5WnUrTWI3R21RUk1rb0g2VTA0aXNrdVJ3Yk9t?=
 =?utf-8?B?L1k0eGFsWFFkWU1pT2FFdWlGamlKUzdiTWVHNG5odkpLVkh4RTh1K2hTSlU4?=
 =?utf-8?B?Z3YvY3M2Y0FlMC85U3poREIxT0hJdEF0dFNDZGlVWno4ZVZneXFNMzVzbFpB?=
 =?utf-8?B?K1BmZlhGYzJqT1lIZDRtNjJOTXhlSHVGUk1SSUJtQlArK3pmM0I5SnE5by9w?=
 =?utf-8?B?TVcrRE8vQXZYSFQxTUw3TmVGZTBENzh5bEludEJRckQzQzQwK3EwMlgwSFFS?=
 =?utf-8?B?bUFaWWF5bTZEWlExNzNMcVp5SERoc3RLbHF4L0x6T3JHRkhRTXA1K3ZxNnQw?=
 =?utf-8?B?K3luYnd2aGhjb3VYMlFjM3g1d3oyTGQvejg3Q2lmSEtVWUxLaSs4RHdSN2Fp?=
 =?utf-8?B?Nk5HRE9Ya2FycTU0SGtOUU0yMWVZNDZrWUxlSElWTnBQV09PRG53ZklZR0Zs?=
 =?utf-8?B?aVgyV1hueWd6WTA2RkZvQXhXRHp5dGxtanlxa2VTRi84VTJVbkx2S1dmSkVD?=
 =?utf-8?B?SFpyd3YwQS9yaW9BRW5aU25ta3l3VzZ6TVVaeWVhR3lEcHpDTENuQ1pEaTZ6?=
 =?utf-8?B?bWRVT05DUFVNZFgxV3ZwWVJteE5MNE4xN1V4R1BobFE0cUJXMFRETSsxUUg3?=
 =?utf-8?B?Uzd6VjViRCt5cWk2VFZlb3hLNXJRQ2RLQnpkVUtGbUxqUjlhRnpKTGdPRkVZ?=
 =?utf-8?B?aElUQzRXSlNQMmNWVTljL1lBTUdNbGdGU3E4cTFYZlpoRUdJSnNYVzNqSkJx?=
 =?utf-8?B?cUtYWVJoQzZrMzlad0RSVW5DM2FmUkVsV2l2TTJFdVY4TGNnd0swMDM2ODhL?=
 =?utf-8?B?dGpya1kwUTlTTExXY0Q4STU5MmF0YkFLR0tQSWFGU2VvT3pEQk1yNkM5VUxZ?=
 =?utf-8?B?b1NtSy9kekFqZEQxM2p0eVhzL3pLZlFTWkRuM0grTEdlVTdGN1ZzRkxhQUNj?=
 =?utf-8?B?SUdwdit0ZkRFRVBydzU4eThUU29kZGtsSGJTQUwzYzN2UWVnV053d2dCVXY1?=
 =?utf-8?B?WDZqNlNMQzNYSlpGZWZvYnliQlFIVWJNYkwybU03bmVHVXV3TitPY3ZxY3Nk?=
 =?utf-8?B?U3hjc2Y0MkNRMUQ3cGk3dDB0NEhuMllRVFlzSXQ0M3FpbVRjajQ0UGc0RTBl?=
 =?utf-8?B?eFFIbXNYWTdqZUdjbTZ3blBNUFo1R2piRG5rWHRMaE92b0hjWTduemJjSnVP?=
 =?utf-8?B?cmx4anJQRlh4YnZ4K2ZlNWRpSk1scnJFR0FWdEJHaFhVSFdyNUViRjhieXRD?=
 =?utf-8?B?SGowYUtMdmpkYWZ2dk9vVGpaNUQ4UzJwY1ZzRXBNamRlWUJlTVZGUk5rallo?=
 =?utf-8?Q?EsubyKwd0bdMJnHVHIVGgstEH6TUR4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 06:30:16.4399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f5dd83-a362-4382-ba7a-08ddf9a17e8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

Hello Greg,

On 9/21/2025 10:45 PM, Greg KH wrote:
> On Mon, Sep 15, 2025 at 05:18:25AM +0000, K Prateek Nayak wrote:
>> commit cba4262a19afae21665ee242b3404bcede5a94d7 upstream.

[..snip..]

>>
>>   [ prateek: Adapted the fix from the original commit to stable kernel
>>     which doesn't contain the x86 topology rewrite, renamed
>>     cpu_parse_topology_ext() with the erstwhile
>>     detect_extended_topology() function in commit message, dropped
>>     references to extended topology leaf 0x80000026 which the stable
>>     kernels aren't aware of, make a note of "cpu_die_id" parsing
>>     nuances in detect_extended_topology() and why AMD processors should
>>     still rely on TOPOEXT leaf for "cpu_die_id". ]
> 
> That's a lot of changes.  Why not just use a newer kernel for this new
> hardware?  Why backport this in such a different way?

We are mostly solving problems of virtualization with this one for
now.

QEMU can create a guest with more than 256vCPUs and tell the guest that
each CPU is an individual core leading to weird handling of the
CPUID 0x8000001e leaf when CoreId > 255
https://github.com/qemu/qemu/commit/35ac5dfbcaa4b.

QEMU expects the guest to discover the topology using 0xb leaf which,
the PPR says, is not dependent on the TOPOEXT feature.

> That is going to
> cause other changes in the future to be harder to backport in the
> future.

Thomas thinks this fix should be backported
(https://lore.kernel.org/all/87o6rirrvc.ffs@tglx/) and for any future
conflicts in this area, I'll be more than happy to help out resolve
them.

> 
> What's driving the requirement to run new hardware on old kernels?

Mostly large guests on an older platform running stable kernels is a
concern given QEMU allows a large number of vCPUs for a singe VM
currently.

If you think the maintenance burden outweighs the benefit, please
feel free to drop this fix out of older stable trees for now and we
can opt for a reactive approach if users are having trouble down
the line.

These users can be instructed to enable the topoext feature which
isn't enabled by default when using '-cpu host' cmdline on QEMU for
other historic reasons
https://bugzilla.redhat.com/show_bug.cgi?id=1613277.

-- 
Thanks and Regards,
Prateek


