Return-Path: <stable+bounces-200176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F87CA83DB
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BEE4302D653
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22D32FA12;
	Fri,  5 Dec 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sjOkqU3i"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59432EA169;
	Fri,  5 Dec 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764949093; cv=fail; b=GOwG8w6DKiNrd/HWFq3YshyXvtU5c0pb/gDPnMtjH+kZxAV2J4neI4uBvbHDyEM858F7lpqM4XjLH2T2446vsQv8CFGvxC99fKjP02My/MIrjKGYuQYiYbyRAoxZpiEwP1YowdOdbdywMcFrud3qwv7PN3fVsQk+SoKwe2x2/dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764949093; c=relaxed/simple;
	bh=j53+YmnR0BbnF8cMmqIc5DH0ztIZT2hrhJznaqO65MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OxNOJWtHKnAGfVm87EayXtsGE/kmHDoFYBSPhvBGmHFfPumHfWhCkLrONacbNHK5CYSIHtsZsIY08t8Tum/dyyLZam5u5c8FXE9NIu6+U2pq7NtMmjt8UdptSb1iR27WWNK6pbwsZFygAY+YGn2AUpBkHJQYAcKpEQLMrmdhc84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sjOkqU3i; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpKoveWHoAOcXnm/T9x9RG57ABiwiHG6Kz8dV8q81ffeGkVkqmjhuZcaHXitcfFqzQMRTSAD8+lZQMAOJPUnamf8IGjzehKmxTyHH4MgoCClfNqdMDY0YDQDPXROd3nV8hwwhdYnTZlRY07cVWdXULDHzx9goVA4HXNLafcsXiU/j8SzfupRZfgDmcyhTZRO6Cevr8sl/9qH/uPNe1QdQ/TAi4s1XjNlbsCrl9sGbh5hm9qttkQwKrYVgfV4107QfWUcsUjO3kkivUoeq6BQIq/bo4cAUNX50LRQrtkO8qR5hxqgQ00MJk4A7ECAgSRngdn3RUbg908Hx0l0UCMx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iITOH6Ewa1mc5pfd5p1NY52QhHGoTd/ig9gSbscZzQ4=;
 b=CI+khcAiHnMxDdgF8SqgBxhxAAP/+LfkDDW8APwB0wRWZydVQHiAq25Lic5meeMSkCX542osH89A3YAgTB8xU7FToyzm+vImnzo8Cc4LBThwndSuiUYIYfPP02QXjU7vIyKdacEjsq8pB++mcQTHWJDZTlGo1tkq/K1SruN0PS3oqwV9vgA/RRUsL+wBIjpderySCAbjFXdjfDOWH3IU+soUyGCFk00lUqnBvvorPSFu9YZHxy48diBiFJo4No6YGS8lizcW5ilkTC/+8mZVREnbg68NHZmQcjKaK2T9w77FwUJdeA+ncLtxPGSMbNKWGtuD8I0rLE0jtB41FV83sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iITOH6Ewa1mc5pfd5p1NY52QhHGoTd/ig9gSbscZzQ4=;
 b=sjOkqU3ifIfUDFejoS2EuK/PSBRJJyNMq6llD//Y+K4RyXItgO+mnz5ZM33KTwqSkc1B7iY9xzcoALfOsgCqZF2w6ZomMFvND5xcvcp7E2YnHwWUhCXc1gZG+oihMJ7BCOqwSgTdivLhSFwbNmvACBtyKiHmS5+uJ5TdcwxbNKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 15:37:58 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 15:37:58 +0000
Date: Fri, 5 Dec 2025 10:37:49 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Steven Noonan <steven@uplinklabs.net>
Cc: linux-kernel@vger.kernel.org, Ariadne Conill <ariadne@ariadne.space>,
	x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/amd_node: fix integer divide by zero during init
Message-ID: <20251205153749.GA1170798@yaz-khff2.amd.com>
References: <20251114195730.1503879-1-steven@uplinklabs.net>
 <20251203204519.GA741246@yaz-khff2.amd.com>
 <77LRvZMtvNz9KxSX1LGsh_VparNGAmJL2gYXBH7oY_3de_ka2avlfbuHE_BL3OgtGHyVMU34Ln2TSLrT1l1rTpBvUUtI9QUTH1je0jFFlkM=@uplinklabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77LRvZMtvNz9KxSX1LGsh_VparNGAmJL2gYXBH7oY_3de_ka2avlfbuHE_BL3OgtGHyVMU34Ln2TSLrT1l1rTpBvUUtI9QUTH1je0jFFlkM=@uplinklabs.net>
X-ClientProxiedBy: BL0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:91::26) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7618bb-7f0e-4f9a-7ee8-08de34144422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SqzFKNjWJTzXHPiapM+sSRx2SAvxyWzsDta/Ff1dyoMJdei53vgPEgGlFrSW?=
 =?us-ascii?Q?50OR964wT4wIItfujTIZNc+gPsrZ9IALYyVPURyfWWNhE6SBxRfU8hZibA4D?=
 =?us-ascii?Q?TDTKIo7ZfYnBscIzZUZWcCCyGq//ZuDlWU1u0/jUG8dsBeQTgZKJhDJvtlHq?=
 =?us-ascii?Q?DkqW23uHkY/x9ZRuP5gJ8U4gHOREHw38S9rUzsiPXU8APFRSs2xBygnR7OMB?=
 =?us-ascii?Q?vi9D2HNjGC5qXQKV0aU3UWGMr9yz7HpqH06SCtsyguTc0wlieVEvnoaAq74Y?=
 =?us-ascii?Q?o3ziGb8emu6bZQYoR8uTS+jagN8xD/SiuBsG/XKrkmQqlvywX6Or6IL2F6E3?=
 =?us-ascii?Q?RA0eUVM21Y9GUgmanzy1KIvUioJDzkBexq2aTg0qKj0VdQW/glxT8mjVzKoc?=
 =?us-ascii?Q?TRegUQpQCkGEYDG0PSZ02kf9IvbHr1BEIh+7IxKKAohl7y0xrKSsRT9Gme8A?=
 =?us-ascii?Q?inPeYpmeuZCkPfLqSB6s65zXNrJi0VTp2yqSQWzYxmLzCHB8QFDlRAAL5tPh?=
 =?us-ascii?Q?mgwrtyfvobGhrcK10Y8WD4/Tnh7AD5VY4YbMOBYk3Ak4/hcVD1tVTALxD6HL?=
 =?us-ascii?Q?RqgQvMfqNlKKjw4d5bZ+fNDXD0hs2AcL3loHHyx5DHf5/wt1N7G5wX3a6qUs?=
 =?us-ascii?Q?b/lxemsuaqiNERB5AJ/fy0jyI7NsawPKOQqOfuZLu+qWWdowVw58wwQLqnBd?=
 =?us-ascii?Q?UpkdQtmfQM6Ze/F0IFq8h7i2i3MmMOp5zXI3ok60EP21EFliBcNV2JHdstLI?=
 =?us-ascii?Q?1oNKSSlpDVRWFc9Jutg4eg6tW4dp01Mdowu1V15AFRKDBBqftUHOxa51C0Wk?=
 =?us-ascii?Q?/vceikpPo43uCxC+lAkhBJ3zFuJyOKUB+Hmvq5U6aQ7w6k/4v6z8o2XKlohS?=
 =?us-ascii?Q?yJUrIftopE/tCOakqFfFt+DuWB8B51MUW8qRzOYbLk0JmGbsx+HDPkRvvc+V?=
 =?us-ascii?Q?x2dh8nfb2W9lGkbg4oyfOeOrnzgBVBw0GnCJ7vji3Wrzhhxa4nfKpZvfMliL?=
 =?us-ascii?Q?ADbGHJkRh8zOUaEncGYzYUDEP2LUaXvYBiBe2vMhlFVzDEgOQmzfKHsbuJgp?=
 =?us-ascii?Q?AW3zkTRNsULm5T5TC+QVNRcFww8gnXtZpUCItxq8oCZckSubRtbDYdYgKHoR?=
 =?us-ascii?Q?4ow17a+g93hTQvQEc8dA8iuwfYrZiTjtg1Ip/8DQNzJya35h13CdMQfjQKQ5?=
 =?us-ascii?Q?wxFxrtIR6J68XtO2coNyOAIaHiZ9GapOIjXb7vMBaZfkjHoMz+rEYT2wRHjv?=
 =?us-ascii?Q?FTgzNUl/B6iLF7OWEqS3HdLo5bukKcm2J5p5rvSv5mPoamtK19OImjtp01ws?=
 =?us-ascii?Q?RXg/gA0PxqyhwJlAh5IAFZrzEPkUfsxR4shPUk4Okz+CZKX6wFHIB8wg5PPW?=
 =?us-ascii?Q?Hwj1NUaV/iLMv3T0HnSBJ8+xBvwnlFRGAP++pF3ZXQ5eZbntJZMHOxeWB5Aa?=
 =?us-ascii?Q?VEqSLnEHX9YJWhF66UuRcZKY761kUvWw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eRvsvzo0fymEi4f+vHWIa+X75UpgNlfGVF5Ycvp6MQysxVDukmoKJzyMct8m?=
 =?us-ascii?Q?lNrjaozi1qwt/P44WOl3ln8XRT/lJ+Z2jRCnfrVDbp5Ul5vAZs+svVqrXZ79?=
 =?us-ascii?Q?62GoMXaIExlVvmevt7BFDhDpZ9A2SgF1r8Fa+tQXD9oCVHFcNniA9i3AXgKo?=
 =?us-ascii?Q?cswZ/K0Urz+SnsaMkWkwVm81O9ahbBn6oC11zIhBfzhdkwkM7CyocPmZVMr0?=
 =?us-ascii?Q?w94rZF+HRuXMQJnt2sTBw8wyL+gMMXazi43lBVkV9e0WCzZOWoGadepvVYxN?=
 =?us-ascii?Q?A+AixMxGqVL1pPt3nPQmspmx8gpdJaSJPeHJ6fdaoHAOXdmTTrR91Gv8a9vV?=
 =?us-ascii?Q?F0zfSEJF0V3UHBVnGjG2HEgHizwq27V+b0x8Sfv5uWgtKPtRy74QXDUPNuTW?=
 =?us-ascii?Q?JqS84ddq56IWVunrzaAnRcmd+GLaQqfTjbpGnOXTn9KGaot8hzCG+F1fcJ1N?=
 =?us-ascii?Q?zDdImxUOa8k2OTa63geLT95ZOq/xh+csfcVGnKyzWfPqksUv80/B2oQKT3YE?=
 =?us-ascii?Q?zpWJNsWS8pn3/ZMh2ZEYGXrVuKeIJXAxrvXFfB8A0g5x6hoM9EfxczYFzdaB?=
 =?us-ascii?Q?ob4iEe//NclvMygCkGDNt2DIriyKQV6bGdYICek+3UaU9KPPu1QC4U23z9fY?=
 =?us-ascii?Q?M7tjM7WvcOXNqrvmybf1QI8+PEkh3/3+SbS5xe7gP2ayzfH8aIq/uwTGbHf2?=
 =?us-ascii?Q?7v+polYsAqcMj3ArZ9WBcGJlv3nY6D/1xsv7FvosgRvy7YQEA6d3V0I9gaZ8?=
 =?us-ascii?Q?fhwtS3aTpf2+zKEqw5pRgEu0ADcMDUR9U72oQcvfsvgWqU6PbE8SSoaehmgn?=
 =?us-ascii?Q?rbPpJrYQPH4VgJJqLSH0mYfckWg/WRiITiLFce9H9okHKG/7UdA22EaRgJRa?=
 =?us-ascii?Q?3I7cxnYvTAmB//XPI+OwXtkhr/rFQzELIFqz3HClaZUc9e4EypDyX+fFEaCe?=
 =?us-ascii?Q?pJD1sqXrjPsrNtxbkug2KeCdIu1jLW1oGSLVt3AQ7wx6KmBr4gltMBVmdjQz?=
 =?us-ascii?Q?sDj1uqvqw0px8S+SPNVrp1V+jnTliYzJ+4tFv/G7g9cvvVr00dzQ9/ImnDGj?=
 =?us-ascii?Q?w6JWpJVtwxNLFG/XVR26ZSdPCaG8IPK7jydAGhIS/NS13WsQv/JPO2muQ0+C?=
 =?us-ascii?Q?Fa7D7H6Rg5govXwRdoqCpDNAPGXjuD1K5Ms28aK1fS9AaZboaITKoBzzjmqJ?=
 =?us-ascii?Q?zmwFq6Xuye3PIdHQ3a2bO5yInEVTOs8WbuMZzQZ+jjAKD9ZwVtUpXsd4mZZh?=
 =?us-ascii?Q?TZKL3QY2R0t8YYEhKSK4daGK1HWKgRnPqW59Gwemt/t8ENwZlzIYL3wFmpzF?=
 =?us-ascii?Q?VOf/Ctw86AjKuKj3vyZkIPrz82L6FUT61IPf5sFIa7jQCqLtKEVpGlMoxtHb?=
 =?us-ascii?Q?bPSe/7jGDvylYXYY6iH8o/uXv5RVrglduJCG9yauw3w1MlsvMP0S3O8G8lIM?=
 =?us-ascii?Q?GXBCGxMUIULecduq59MtX2do2kCd4RzRyUuaT7lspy/IChFTS3YcOGN2C6kl?=
 =?us-ascii?Q?7KzIVCa4Wo+5nvFOhBsdwQLuCwhPAJBTC7AumaVuJ3sLXNZ12FGUO++xDwjY?=
 =?us-ascii?Q?d0VE6lz4zbLGcjcuczGf0hiDCpxTD/JVNUsR/h5j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7618bb-7f0e-4f9a-7ee8-08de34144422
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:37:58.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWeWLE6w8+0rckUhhC0ax7fH5SSvTwNtCN7wnCOqPrZIEN5DDkbvIZ2Vqm0CGkD5iIhWDOnC3C33xRcfdtZ8xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454

On Thu, Dec 04, 2025 at 08:16:36PM +0000, Steven Noonan wrote:
> (I apologize in advance if my email comes out formatted strangely, I haven't used ProtonMail for LKML before. I don't think it is line-wrapping properly.)
> 
> On Wednesday, December 3rd, 2025 at 12:45 PM, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> > On Fri, Nov 14, 2025 at 07:57:35PM +0000, Steven Noonan wrote:
> > 
> 
> > Thanks Steven for the patch.
> > 
> 
> > > On a Xen dom0 boot, this feature does not behave, and we end up
> > > calculating:
> > > 
> 
> > > num_roots = 1
> > > num_nodes = 2
> > > roots_per_node = 0
> > > 
> 
> > > This causes a divide-by-zero in the modulus inside the loop.
> > 
> 
> > 
> 
> > Can you please share more details of the system topology?
> > 
> 
> > I think the list of PCI devices is a good start.
> 
> Sure, but it's running as the paravirtual control domain for Xen. The `lspci` topology output won't differ between bare-metal and dom0, but dom0's accesses to certain MSRs and PCI registers may be masked and manipulated, which is probably why this is breaking.
> 
> I've attached `lspci -nn` and a CPUID dump from CPU0 -- both of these are while running under Xen.

There is only one "Root Complex [1022:1480]" in the lspci output. And
there is only one "Data Fabric: Device 18h;", so that's good.

And this is a desktop Ryzen system, so this makes sense.

So this system should *not* have "num_nodes=2".

CPUID 0x80000008 ECX shows that there are 32 threads per package.
CPUID 0x8000001E ECX shows that here is 1 AMD node per package.

I suspect this is a known issue related to ACPI tables and topology.

Can you please try with this patch?
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/boot
845ed7e04d9a ("x86/acpi/boot: Correct acpi_is_processor_usable() check again")

Thanks,
Yazen

[...]

> CPU 0:
> CPUID 00000000:00 = 00000010 68747541 444d4163 69746e65 | ....AuthcAMDenti
> CPUID 00000001:00 = 00a20f12 00200800 fef83203 1789c3f5 | ...... ..2......
> CPUID 00000002:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 00000003:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 00000004:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 00000005:00 = 00000040 00000040 00000003 00000011 | @...@...........
> CPUID 00000006:00 = 00000004 00000000 00000001 00000000 | ................
> CPUID 00000007:00 = 00000000 218c0329 0040068c 00000010 | ....)..!..@.....
> CPUID 00000008:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 00000009:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 0000000a:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 0000000b:00 = 00000001 00000002 00000100 00000000 | ................
> CPUID 0000000b:01 = 00000005 00000020 00000201 00000000 | .... ...........
> CPUID 0000000c:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 0000000d:00 = 00000207 00000340 00000988 00000000 | ....@...........
> CPUID 0000000d:01 = 0000000f 00000340 00001800 00000000 | ....@...........
> CPUID 0000000d:02 = 00000100 00000240 00000000 00000000 | ....@...........
> CPUID 0000000e:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 0000000f:00 = 00000000 000000ff 00000000 00000002 | ................
> CPUID 0000000f:01 = 00000000 00000040 000000ff 00000007 | ....@...........
> CPUID 00000010:00 = 00000000 00000002 00000000 00000000 | ................
> CPUID 00000010:01 = 0000000f 00000000 00000004 0000000f | ................
> CPUID 40000000:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000000:00 = 80000023 68747541 444d4163 69746e65 | #...AuthcAMDenti
> CPUID 80000001:00 = 00a20f12 20000000 440001e3 2bd1cbf5 | ....... ...D...+
> CPUID 80000002:00 = 20444d41 657a7952 2039206e 30353935 | AMD Ryzen 9 5950
> CPUID 80000003:00 = 36312058 726f432d 72502065 7365636f | X 16-Core Proces
> CPUID 80000004:00 = 20726f73 20202020 20202020 00202020 | sor            .
> CPUID 80000005:00 = ff40ff40 ff40ff40 20080140 20080140 | @.@.@.@.@.. @.. 
> CPUID 80000006:00 = 48002200 68004200 02006140 02009140 | .".H.B.h@a..@...
> CPUID 80000007:00 = 00000000 0000003b 00000000 00006799 | ....;........g..
> CPUID 80000008:00 = 00003030 111ef657 0000501f 00010000 | 00..W....P......
> CPUID 80000009:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 8000000a:00 = 00000001 00008000 00000000 101bbcff | ................
> CPUID 8000000b:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 8000000c:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 8000000d:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 8000000e:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 8000000f:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000010:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000011:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000012:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000013:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000014:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000015:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000016:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000017:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000018:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000019:00 = f040f040 f0400000 00000000 00000000 | @.@...@.........
> CPUID 8000001a:00 = 00000006 00000000 00000000 00000000 | ................
> CPUID 8000001b:00 = 000003ff 00000000 00000000 00000000 | ................
> CPUID 8000001c:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000001:00 = 00004121 01c0003f 0000003f 00000000 | !A..?...?.......
> CPUID 8000001e:00 = 00000000 00000100 00000000 00000000 | ................
> CPUID 8000001f:00 = 0001780f 00000173 000001fd 00000001 | .x..s...........
> CPUID 80000020:00 = 00000000 00000002 00000000 00000000 | ................
> CPUID 80000020:01 = 0000000b 00000000 00000000 0000000f | ................
> CPUID 80000021:00 = 0000004d 00000000 00000000 00000000 | M...............
> CPUID 80000022:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80000023:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID 80860000:00 = 00000000 00000000 00000000 00000000 | ................
> CPUID c0000000:00 = 00000000 00000000 00000000 00000000 | ................

> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex [1022:1480]
> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU [1022:1481]
> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
> 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
> 00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
> 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
> 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
> 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
> 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
> 00:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
> 00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
> 00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 61)
> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer Data Fabric: Device 18h; Function 0 [1022:1440]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer Data Fabric: Device 18h; Function 1 [1022:1441]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer Data Fabric: Device 18h; Function 2 [1022:1442]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer Data Fabric: Device 18h; Function 3 [1022:1443]
> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer Data Fabric: Device 18h; Function 4 [1022:1444]
> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer Data Fabric: Device 18h; Function 5 [1022:1445]
> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer Data Fabric: Device 18h; Function 6 [1022:1446]
> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse/Vermeer Data Fabric: Device 18h; Function 7 [1022:1447]
> 01:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal] [144d:a80c]
> 20:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse Switch Upstream [1022:57ad]
> 21:02.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
> 21:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
> 21:05.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
> 21:06.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a3]
> 21:08.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Matisse PCIe GPP Bridge [1022:57a4]
> 24:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Controller X550 [8086:1563] (rev 01)
> 24:00.1 Ethernet controller [0200]: Intel Corporation Ethernet Controller X550 [8086:1563] (rev 01)
> 25:10.0 Ethernet controller [0200]: Intel Corporation X550 Virtual Function [8086:1565]
> 25:10.2 Ethernet controller [0200]: Intel Corporation X550 Virtual Function [8086:1565]
> 26:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
> 27:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
> 28:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 04)
> 29:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 41)
> 2a:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
> 2a:00.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
> 2a:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
> 2b:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU102 [GeForce RTX 2080 Ti Rev. A] [10de:1e07] (rev a1)
> 2b:00.1 Audio device [0403]: NVIDIA Corporation TU102 High Definition Audio Controller [10de:10f7] (rev a1)
> 2b:00.2 USB controller [0c03]: NVIDIA Corporation TU102 USB 3.1 Host Controller [10de:1ad6] (rev a1)
> 2b:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU102 USB Type-C UCSI Controller [10de:1ad7] (rev a1)
> 2c:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
> 2d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
> 2d:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
> 2d:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]




