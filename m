Return-Path: <stable+bounces-189034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8FBFE17F
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 21:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 827D84EB251
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48052F0C79;
	Wed, 22 Oct 2025 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hHK5M+y/"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC0270EBC;
	Wed, 22 Oct 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162661; cv=fail; b=J4CSfxBUIltolN5Y2q4F9ik5xgxO6rJpeRhmqbsmJHYuCZcpxKOyFNLE6qBn/fKs2HubeR1qsuTqBdTBHP1AYPVYZALhUb9T2AKGPGVoYor4Ix/oyPHeDlQLE6RpKi8nvYnSi8AbOjhRULy8njBops24JvLirPQ8T35BCmVO07Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162661; c=relaxed/simple;
	bh=MWEBZfrCS9AGLnb50eNk+yW+wqfUP+1rupOukU/2/YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J2VqFRqh52NLqHMWmHC9IUbxluKtizgrZA3/+SJrRPiofcy036KHWV7o6WgABkfmyHh0EnrOy39fVCjr+GcPGxpsVEX+e3KeJUaJVuqk6azb70Bjf0jDOmjZudY8lg/5kmpZSzIDqi6aLb3FHBAYv7BNPvMgwz37STvYBpxBGGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hHK5M+y/; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMCit7FX7H41rih19OERjBkjGvh95EweWU6LFEkaM+cKkSnzy3WkpD3OZQD159GPxJ7sBRLhIA/3wd9XvpzAjYbsb2wIkuM5MOHuPU9biQ8yYy6JZXEXVavoQgGgmW1azicNlrkDHpUwm5fcB+b/JK/ADxdSd20cGZi1LJbPCCfz03O+FmoQjAhQzz0819HXm+QD+n84EyTX1IQaf0R+H2nNsqadz9iqCaeJv6bGOPPWk8TWI+5QuiaaeVChaofCN2250VjyVqxgN1S4hMSn9GKXSyJHvxG9Inlem0TAFIGIAxwzPRXRS/yoTUoLVXPM6NeJi8tG4ZhpROTxtntQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIzOnANczyqezrt429reqHU52rfSbWVCBV4PAEVXiaU=;
 b=wgywd+DTTjj3hZJFG6txySPvGhD2pUXXiqq4oZFeo8d9kCdnOzPr27ehDpFLlaXHhlt2K2NDT6Z1kp8Q9PdhwZACK8lQXVPEaqIKERMXxocez+Lwy6uAB+ZNC9zomLOWchLBpCuEbFprxL52nFAJMxhFFPhZ73wBO3K4u7VcKNbOeMXgfi91gaC3O5iaFNtJSysjZCNNflNHjUFHwlc6kfCRy35EZqTEEY8xHOC8zDFBtaQoYOdCjptnmGnPYgcxAM15I0HAT4N8BOgx+1ISgS6xFVju2GITXMtBMNGohvKneL3YGtmUfjc5XET9BHJw626kmSJvjySd7pNfLSK1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIzOnANczyqezrt429reqHU52rfSbWVCBV4PAEVXiaU=;
 b=hHK5M+y/jRd7hsLHXQiCXPQVUgfv/l96BG26zCMLg0eNL8Snk/yowi6N0d2i9trSOkh7y1E8ko2vkgeFrSdQwtulHKOXdgVqiNgPtdA1vGJU9oZpScbBA9uAmAhceVEHHEKmLvB4GFB1qj0WAXZ281FLj+x/PvjedKWpUW7rKzBC1GiYdZA/AyIF6qAobvhShW6R3Atc+kNLQqgACkT6qqWlisHvR19OW/jKB20prSkyBJOLRHZ6DV914KwcmsGPewY2ogVlr8wpZOXo6J9aRoNxfQidSPqvSx7Y6aNxV/totAMKh6XUeRnAYsXQe6qLUwj8TceatmYgfM6YIq0p5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 19:50:54 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 19:50:54 +0000
Date: Wed, 22 Oct 2025 16:50:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 1/8] iommu: Disable SVA when CONFIG_X86 is set
Message-ID: <20251022195052.GA262900@nvidia.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
 <20251022082635.2462433-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022082635.2462433-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: YT1PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: ff747ea2-1cfc-4341-11fe-08de11a44f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ekDqMvcDSR5PpLGth5zAFA8s8xcT79sDcX92YzG03VPZvjhqYOUo3eYyLmh?=
 =?us-ascii?Q?ygUyWpP5qfEBoIgEYol1hRCm0dLt/0oBXK3Xf+vdDlo8Usymd3ako/KkbodY?=
 =?us-ascii?Q?vhPTMG7dTIpVMxNhUY+3whzaUOzApKGZlKfPOEQJqGrdx5pBMpY0xiIiKprg?=
 =?us-ascii?Q?K5hFNCLMdUFDGyb9Wga6+HQMJOKX16nJym8jJiXAXtGg5o0MUTNv/WX0mGLm?=
 =?us-ascii?Q?y22/nnoi5JY7m8gC+P3nxmno+99T3op0T0DWP2oJ9bhkteGKfmWRCQ8yX5VS?=
 =?us-ascii?Q?kQpx3dbBH/cwtIZ3Gh+D9r4s9mSlFe8oVUUVyCS8AmhG5/FckyYpfjHIYFZO?=
 =?us-ascii?Q?HJ+/4yZIgkHANa2sp0tR/2KYrPyKIInxEaNxcfZNsUXMF1RCUyw6gSaJU1be?=
 =?us-ascii?Q?iKiFopgSeA8nIulo5QKT3Tfwe6dCWauj4JdUdGFnHB+rekU93p1URJkU328A?=
 =?us-ascii?Q?Iv1nxK5ZVesrT60nhsW1cMm30CnfAgANCoIZVxg22kmGkRLAz9ePhJ+HlxmN?=
 =?us-ascii?Q?VgSLZKd1TlBMEa/5sbIkR8O8rr/sqh0fpDW+PQWV3SKbQ8xCAqr4dgb3Iis5?=
 =?us-ascii?Q?Samy7LeFdlvDvpmMeZ2VrKKkcHvaS/sUqCeef2Q3ccL94PI1EERROLsPBhNc?=
 =?us-ascii?Q?WVjkepeGwONXv9TZcVNbwaFKfyrNRW7iLfLj+cV0FgsK452cWHKgS8fG4cAI?=
 =?us-ascii?Q?i3gX9dy86+G/pEZ73N8ws/LEmNXNF3UTsxlinzIX75cY3ioaduT4ACZsJqEF?=
 =?us-ascii?Q?VHVaiWMIToRF+Duz9HV8B3X3iL5iHsjLJ2bd7nIvrUelcnR43+bkfPST82F8?=
 =?us-ascii?Q?opCXXzVDlsPeWiswOhLW2CZos1BaMJ5j63Gc5iGV+jcpyk2cCMdpLY5xijFD?=
 =?us-ascii?Q?qL10T9DaD2puuW598hY7o9p13DF0zmTVtKfz5OPMrBJ57Il9U7WW9xJxCUjU?=
 =?us-ascii?Q?YXlpfjygECMP21rFuqIcsgjN9IEjf6tD387VNEzIHrPbccDUBVKT2NGrpEiv?=
 =?us-ascii?Q?UEYjCEV5m4jKt2uOxwpGPqp7TFykUGkq50T/YGsGbODeT/1Pee+SPW251nlu?=
 =?us-ascii?Q?B3n8Xf2SeUrci1oG8FA2nBgGReN0hSuwjbEsSj34B5DoOG8+MW2fgWCme4yq?=
 =?us-ascii?Q?u3KTrobS7Dp39Lu35+3wOaJasHb8qMlTjHGdoi3XM/UDpeyMb3P3Ak37NnR1?=
 =?us-ascii?Q?bsYMCPCeG2F4030b7h4LS4i+dSMfees61OVDLoBunn40vFP/+tljg4Wq9lyF?=
 =?us-ascii?Q?6xhnYXOp1if2ByzHSXenlcHJB0kSug1qEjfcBX22BUWNJ6E2xIlfVv0kECCe?=
 =?us-ascii?Q?vlkGoMe2WDwNVUnCBGwB6Dn/bQKBFPYxoAEYuFqTjeN7VxV66OrAkubah3x0?=
 =?us-ascii?Q?EUfs80Prh2Dng0wRVyE3O0loY5BC+7qTscMEgcEZdmhmCntS1gXo5v+qc+Ej?=
 =?us-ascii?Q?iqSAJhjJxqHFZg0craQzD+m2oxXCUvbI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fbugoZ7C3a8d56hP39k/F11E3dfiSBQ2wpIzl9GZQeDbJE6nZ98xzd/5KRrf?=
 =?us-ascii?Q?RXwoSTKU5J0hLww4xk2japa6Vozn/uY5v+kDh1/ymDs02Om4j9HlBggR04E3?=
 =?us-ascii?Q?QlwsRGfyHTwEAATxFqn3M/3IZ7sUaOqhZWj52Qna/e+ZxTlKqqqaXCyrL0bJ?=
 =?us-ascii?Q?IE3E0p5BiAP2tNeHeIDSCWSaxDDZCEgf+1acfChIX1GddiyupEocBRXy+y4T?=
 =?us-ascii?Q?a1949zQc9AnefikuKSUjLhrSCacegtGeq08OnjcVcN+MhJ3TCbIhPLQw0gMz?=
 =?us-ascii?Q?JdY+J702SD/E8hGxsVxLVGkl9I2wjFpMvR4ni56ApM2hFEJthBqfLaXkCjQ0?=
 =?us-ascii?Q?nVNJN9Q5pHSGU0ULRCJ3Qm6Jsxk0ehjwa2cUZpAEu3btCReefTnADlNMnHgc?=
 =?us-ascii?Q?AwhLqsZAlEjH3pqADpePGy0KjIGbLcMdFBCM+pGIzNdF4rx0yIh4+X6ZwcRD?=
 =?us-ascii?Q?QevLffJD9JVdA8kYLA1jfKYXtPjjgwOBtAFKmJdGOEf6kQ7YYzBbEpINhkcJ?=
 =?us-ascii?Q?nIDVvjhQLd2tdaA2wzMPIYQtOCT/TLju2DBMe1DYquBwu39W9cpJmhYtvJzn?=
 =?us-ascii?Q?J39/JYzoyUYcn8WhmQ/DBRcmYRX7WGZCHKOh2Z5ung+S9mtUwx+sjLhRxlcJ?=
 =?us-ascii?Q?/KKLky6QrhrAZxKINrNVDTOeIEJT0IoxRx8Lji+0YTpVgqLrnChcWHyvvwvu?=
 =?us-ascii?Q?eXpy4UpIPr2gbXLxOUBGc17RyzuKvM67UG8A5pLFsoRvQfHB5dj8WHCZWvBN?=
 =?us-ascii?Q?LC6bUuvSKBFxC5REmT3uyOyQauJaldowBWf4mOAEZL41DUApmwLYEDs67c4D?=
 =?us-ascii?Q?kSfgO+rhH8RrsX0jHt28xyyjwsqJ9zDPyOxX2z8hzJvAnN5d0TKqDWUMbRhA?=
 =?us-ascii?Q?094L5zj6QRktL/q89EDQIQx7dGqrFstFn+qsXkd7WWCFLYEgS0unAz9FV+Vv?=
 =?us-ascii?Q?hzmksly4guga3jW9wWfXOejlImX4MQaNQMbC7KZLSoch7tg1S1SlEovG88j1?=
 =?us-ascii?Q?tFvDJVONjOdmvyvDR2LqNDfXvyyBUFK9xDjwoSRwWYBf/1dyu/QmggxEpdfs?=
 =?us-ascii?Q?+sxqui8GPCbmT0GNE9uwjbRAcUKGzzOzKtKziFioxgjd1MOFerOECz1tVA7H?=
 =?us-ascii?Q?87BEGYHYqzqHoRoHalChapQDYHaMS/REfyBwt5PRCjVrKEmpErHDneOdGI/b?=
 =?us-ascii?Q?3Czk0u5L3IcaNktSESUU4VjZG0ML81svaRh0NuZZwK8/EuJvIWnti3ow6ieE?=
 =?us-ascii?Q?COQ6Kn6K5j77wZY1IFCtKb8u6Abt2z6UlUIEwkYJgSVxBXn4EMszq6KAkH5n?=
 =?us-ascii?Q?VaXYhd9p7AEZgPkqKr2th32nehPcNfTrJ5rdnZcB8TwrMuDION9suAmk7FaG?=
 =?us-ascii?Q?aU3TmLHSe5yIsagor36p9D5dnwTgxkI4wkzBk+KJ1KJR9DutaGxp8OHlpAfy?=
 =?us-ascii?Q?PW1rAMO6CKToeNDAB88uGGwlzlspFKkvz0WIeuFzm1mNfzpI5OjmdO49lUNH?=
 =?us-ascii?Q?2ZKso0oiSQmV+szgblZEiYiKjs03vZTHAUfdBYX/9knZOBB4evpppqa5sooP?=
 =?us-ascii?Q?SEIvKkToEfjDMBbDPWs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff747ea2-1cfc-4341-11fe-08de11a44f89
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 19:50:54.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBFr1oET4FYUqCUgKUUA6/ID+6hiIxDzfrNNnqtbxhsHQ6O7oJhd0Bub5Rep7ZW+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948

On Wed, Oct 22, 2025 at 04:26:27PM +0800, Lu Baolu wrote:
> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
> shares and walks the CPU's page tables. The x86 architecture maps the
> kernel's virtual address space into the upper portion of every process's
> page table. Consequently, in an SVA context, the IOMMU hardware can walk
> and cache kernel page table entries.
> 
> The Linux kernel currently lacks a notification mechanism for kernel page
> table changes, specifically when page table pages are freed and reused.
> The IOMMU driver is only notified of changes to user virtual address
> mappings. This can cause the IOMMU's internal caches to retain stale
> entries for kernel VA.
> 
> Use-After-Free (UAF) and Write-After-Free (WAF) conditions arise when
> kernel page table pages are freed and later reallocated. The IOMMU could
> misinterpret the new data as valid page table entries. The IOMMU might
> then walk into attacker-controlled memory, leading to arbitrary physical
> memory DMA access or privilege escalation. This is also a Write-After-Free
> issue, as the IOMMU will potentially continue to write Accessed and Dirty
> bits to the freed memory while attempting to walk the stale page tables.
> 
> Currently, SVA contexts are unprivileged and cannot access kernel
> mappings. However, the IOMMU will still walk kernel-only page tables
> all the way down to the leaf entries, where it realizes the mapping
> is for the kernel and errors out. This means the IOMMU still caches
> these intermediate page table entries, making the described vulnerability
> a real concern.
> 
> Disable SVA on x86 architecture until the IOMMU can receive notification
> to flush the paging cache before freeing the CPU kernel page table pages.
> 
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

