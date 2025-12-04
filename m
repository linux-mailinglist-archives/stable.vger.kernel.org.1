Return-Path: <stable+bounces-200056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB88CA49D8
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 17:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942EF315146F
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8A3093CB;
	Thu,  4 Dec 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H1EwFDAw"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93133093B2;
	Thu,  4 Dec 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866742; cv=fail; b=rE0Fi28vcX2JyBFoelyEiXNtzmiVyTNH4xlORaDZHNBWX8kPpq3/X6UmsQEL24ph1UEY+r+ZCWBLphM/gZP1s/vLLhK5rGzgg6W15C3sNVVWM7KJzB7h6I7ontZu8dW52aYeejTsDY3Ijf/M4RSeIyQ0G6fVawKBCecppoAqeUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866742; c=relaxed/simple;
	bh=atbxKeM4b1TD3BonBgK5W/3sxZc16uPQUCrSpwBx4IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bMjDW4otycawwqMrVavvT2NfQbb9ZsJVigTJeicrbvpQ13ypS+V5JJhFuIFlQ4uoahUVYSfr4wmt52XN9GIkSXAGk37mZvPKbVmXDhpGtmetm3CnEA5JgosAzUwVSkinSlSfDRlpINNkXmSX+CuGwjc7SO4Ed0v7rX5kqCl3grI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H1EwFDAw; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9KmeE1isTrGvT8HSFO+rQFsvtT57Kt4AbAFSAlKczQg9ptlSEHchtltxI0fJ9cdS+E1sGBZfl+KQSaUW6Q2vscu8LWmEmD1WP8AL/E6nzYn3l24JuJzMEJpl+QGIo9qGBG+QJIIpTaDspT193BpHutwqse/ws6QpeLgSOXZaAU61/PQEMgJBSsnOryPDPZocVr9BZ0+lz1lzfyd/BrKZVSMuCwEJmiiJZgZUW8K1zq8sU5u4HY1+IgHHpV0/fHtB1/2qILn225ezm1K/Ob1CfSSz62PS1gGcDHUNOvu3rSRR7ezj/I+iriQUGkDarag70HzC9WgKnRlB5tjLHKhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZhg6El9ux01IkfjHOyXnkrsgDz8guDKlJ6Ee3Pno48=;
 b=SLwGW1tsEN/Tns1e5WWn+WTrVUuFWB5zoJnYToySoSGPbdnjGneBCiD3lWSHeXg2gW3hLmEql4mq/ODDQ7kBdZfgZJ65TdZognR0Ojli9P/SREai3EAzlPh14nvOnMojpwGPTeRyFfuk5YDXGO7y5Y8WKxExWP6Du3fhbSZWxOAryrdXqWGI/zDFweQ7fcK/pZZjFg/IsECyXI2mMddKqGfHChe8eymXTZIfNTevcI6I4p+F09wnSuRt0kR0B7kg0pxgS2ooyhruAARkVGv3TqFAkhqWhx9GmwnOgFWWHaoMx80UrgeLaXEld2JV2fSD33Krs3y8HMr3dySZBpB8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZhg6El9ux01IkfjHOyXnkrsgDz8guDKlJ6Ee3Pno48=;
 b=H1EwFDAwPjUPZiPIlIFnFvDb1dHoISApUC0nOeQaWdX46VyB4J+KEn53udcck2cn7nKBLuUXyV2MfnoBMsfu+1PLxUoKCjvMyZDQ4+fqFWCgDplgacew6KuoubA6A57MQjDYZ9km5haYc0l1pvRWKT606XUcm5HohEdcuvAvD64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 16:45:37 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 16:45:37 +0000
Date: Thu, 4 Dec 2025 11:45:33 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Steven Noonan <steven@uplinklabs.net>, linux-kernel@vger.kernel.org,
	Ariadne Conill <ariadne@ariadne.space>, x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/amd_node: fix integer divide by zero during init
Message-ID: <20251204164533.GB983706@yaz-khff2.amd.com>
References: <20251114195730.1503879-1-steven@uplinklabs.net>
 <20251203211813.GAaTCpFeDir7jXkEPf@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203211813.GAaTCpFeDir7jXkEPf@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:408:fd::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 3731ef82-d157-4f4e-5c64-08de33548d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EtPColQ1sqZHJpmfi1Mf3lLBvnaATv2DcO2Q/wjDbuc7D8IrU9q4RmEQBybX?=
 =?us-ascii?Q?6cRRGqBg8RwTg3NoC+xw+XtgJ4+AMypTEfZiumE32rTdhgGMs9xdI2f/DL1s?=
 =?us-ascii?Q?WYYInUJAXQSAr6JGBAKAE/8/z4oQs8rp/ioKATZR9UeLIIA2JrnHIswxmjLp?=
 =?us-ascii?Q?/o2RiHUGDdDItbRcDQl2ejpnsFJY/ipZfak20oTralb9AHX/K4w0dsoxjWVg?=
 =?us-ascii?Q?5+TS1lZR8LkoUoFYDdZPCb+WypRXDyOSX4U2DTHhhqjzTJzmrMmvoc9Sg+vg?=
 =?us-ascii?Q?Gtg/k+FEnvSJne38f6fYGOVnhKsxrgrgbVMYBTDw3Man5AXmcN3YS9Puybs7?=
 =?us-ascii?Q?+/GNi1aEPRRHmQcKhHj7H6sNrUnSe6wNomcG3kbwm9n1U+D2qABLdmoqGzFk?=
 =?us-ascii?Q?rRDYXm1Gj41Tw23yBlFqzw56dav2klJ4uyuLWKIGbZcm5jB3x2oewVZTRoof?=
 =?us-ascii?Q?mMzl0ecTd6H3V4ScvsqaIGlnVaWNkqlyfqNbwQwDBFSn2NPfwuET+EbIM6wH?=
 =?us-ascii?Q?Brn7ZPt0T/ODEl41mNxUICAbUf8u6Bm50yLtycXN8zFBjfKUq6cCYw/Zkpat?=
 =?us-ascii?Q?eVlX2d3gobqckcwXHQ2a91eRu+UorLfkQCOqdBvJ4/4HpcDDL5UnYAFxhVY2?=
 =?us-ascii?Q?Grst/sJRFmQ8RKG/05Fytq0BVpOCrUcyXY91sKziCGI6WbUjD8mwtLcgb+Qm?=
 =?us-ascii?Q?LHdVJ+e2UPE+k3qsA79u92Xr8cRiQ0h+/o+x+MtxmLjjHYVAfkFNv6jwfMFW?=
 =?us-ascii?Q?IHZuETU4jSCaXRP8/SfVS8iNOZKL+6Zys/tP6QdmDooCE/2UjxpULABJzgxE?=
 =?us-ascii?Q?7ucy3t5RWHL5jVkZaDeqJf1LuOGsb0ryzTd5R8wTWzcXbt/vzpjCrI5eohAd?=
 =?us-ascii?Q?EVmAOaN8uTK2RUFSLP+dr2dWHPjnhaOiS2ywT7DXBJOT90aUac3e5IsP7g/W?=
 =?us-ascii?Q?1U72t1gQ2eQ0ojtzMiha+Tn1xcutLTZYTpySNd3EahQ9AKbNN8klsZCdfOAH?=
 =?us-ascii?Q?0eEKsRK3TEJSZSkxVNV2jn6ZBLYp+HE4MNL8I3NCLKJKcZJW7+KimDlzXvG5?=
 =?us-ascii?Q?oUnoaPQANc+zfsRTBNKM1IBmsb+PhceAGkfZ961EDPL8rmxL0EGn4uEgyeBE?=
 =?us-ascii?Q?nDprUaEP36W5+YyUlphmD2HL+1D3X4xU4YzNefECK3eR/BQEorCHCs3/y+mR?=
 =?us-ascii?Q?6zF+PRtpfBzfpH6BjCHIRnL5c4wTJIQ0kV9NM62JLXD6tJcrLiTHQxkgBNRR?=
 =?us-ascii?Q?l1asjp1p8JcBjm1djA8fRkEnzm049rnq4o3ZWWFZaocjmAiibQOEmyEkgzV9?=
 =?us-ascii?Q?Qg/8bay1IXWReHQj2T4GASUSy1LNO30mjWTaVHluet6uQagn9LtIKxYGvGD3?=
 =?us-ascii?Q?pr9dvsIVdaHXknrS0K614GaV3LTVbeX+wmvR6KnproHHpaXs+vc+Nvy4+J7r?=
 =?us-ascii?Q?Oaoh0KtdB7YdjA9hhSZbpJkJ+Pat/DOo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uXXPQ01rFYvsv+pFnjYxT952nRI38YaMBO3IUOFz4BQ4Xx9ryxKuFfOPYGha?=
 =?us-ascii?Q?zV5LQ1nGW157v00khiUkCogoLX2mF8B7ZD3A5MwTfmNu9/20+hS/IL0li+XF?=
 =?us-ascii?Q?tD7t6t3SNgUW55i/RIp7hZEcSwkRb15aOgMk2BKRv8jiRAajqFp6Z1na7ysc?=
 =?us-ascii?Q?5TLTlWfH4lBI7QfL01mIS8tcxur8eXEUfcAyIiYRzIHPzUX4K+bwFN1dlfLC?=
 =?us-ascii?Q?B5X+8ccmz2mk04xOlntB6fxTHRcc0xSpBDZKr11/PTDdEaIPyz9fcB6+Y6N2?=
 =?us-ascii?Q?42xqeJwcUbIPxJRMUIbjt9Vxl4ZnSAn94GGnGb1HMg0n/MPB36me00c+h98X?=
 =?us-ascii?Q?FaoHtK+oD2EYaWKmN9jXLyHjzBvOdEyVBJFrp9h2WKyOU7HtqKURNM+WMKLN?=
 =?us-ascii?Q?+erVywhizu+blc5pudHnJPNkUqkCS4Xgdc4aCSqNq5rPJ1swG6DBuJk5+SmR?=
 =?us-ascii?Q?QhWlDSBf+VvfE+fbRa23cshMzcBw3/uG7dLUhxAzfDICiC+mr9wlySdvpMmE?=
 =?us-ascii?Q?9oEe5QhFWBEs5eV9R2vNOwYh+Qt0ssZ7njSR+nioWHilhDRksrZUjX4Emny2?=
 =?us-ascii?Q?MRqlFmadXckXvYPYG+aiLpyqSXOuZSG/2dkW8Zyp2UkFnZHOZmDXG6dj8Hf3?=
 =?us-ascii?Q?TwHeKzHWt9d4wlvgcKVYKWIKhx9mcsdlpsFxvhoWf+ph+kP7fTexZdhXJVGm?=
 =?us-ascii?Q?DEhIB7wgIKG+NLbx6ldjAcE+GA2wGOnPZ9qYWSYyhi5Ol9Kk2sXLVo8af4kh?=
 =?us-ascii?Q?1uBwVkUeitImf+Owuz3sIgnyakpboevigr55oNywMq2V38xjgFGtxGhwXMwy?=
 =?us-ascii?Q?kFy2y0PVxbkr04IVVvvClsQMLI/Dec4gQXgAG4+fPQ5rMMioebzPctniyK9E?=
 =?us-ascii?Q?99VisHNkufWIkYSUehxKl9xBw4gcG+8WqZD43O9UFFIYaPl76SNi8+j3RGAK?=
 =?us-ascii?Q?qggCaaH56J3i61bwKi8anluE8Tp6mHg7qkztUUCqAspTZ6fCBN8X0cVW7QE6?=
 =?us-ascii?Q?k7A6okoKWY2ncwuxjIIQY2zXdvoEO8hippEmk9vZyU0xgF/7kSE4eLPE8ril?=
 =?us-ascii?Q?XCGL6agyw4HVjH4YwtWG57gotSObcIaY6JD/5u8+foM+XBr3KnEQ9rZtOz+q?=
 =?us-ascii?Q?UZepzRlP/+oulEta9r/ZPAZNhPihavr92DXcNSdJ4tuIJkTgTiUbY7HFXhJt?=
 =?us-ascii?Q?yvP4qQ4AAKRjIgQM+sjV9NS/o5urHJ0iXnz04mp9cAlEDhLqH82FgSvAQtLl?=
 =?us-ascii?Q?qJ74iCCo1cboWhZ39JST+lyZ8w9XBrzGBT2dRlJzgw+NCZP2bgNqf12ljTZH?=
 =?us-ascii?Q?bZxOfOTMtck3Q5OePDBm5DInWsTBjYmfih5TxVly7+4FOsIwLGgtMK7GH1XQ?=
 =?us-ascii?Q?L9HhWC2e2rDQ2ywMgYNCmzehGcew2SiSUhHURunIwbzsuKAm66I+Jc9fglTT?=
 =?us-ascii?Q?M0CVJw9JDEGZBSwTmEZ76cUxVMj55NAK6i94A1P70ZK2myNvnEBnXhUM2Y62?=
 =?us-ascii?Q?qWAtIxRqGSpkltqDAyEMK0Skf2NNAFAgvXzQ+7Xi0cFq9yijCexnYyBKt+8w?=
 =?us-ascii?Q?Rru2U2OUDYkpqr8aQ3wiosCftpM09N9OLn9u2wjF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3731ef82-d157-4f4e-5c64-08de33548d25
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 16:45:37.3262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9OY2gb7z/aUG2u+W2lt6ipMYYQYe+wdqm31OWnLliS3Li6q8VCHeqvbq97j6f3kbhZSg2iNCmmbsnGIVVm+Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517

On Wed, Dec 03, 2025 at 10:18:13PM +0100, Borislav Petkov wrote:
> On Fri, Nov 14, 2025 at 07:57:35PM +0000, Steven Noonan wrote:
> > On a Xen dom0 boot, this feature does not behave, and we end up
> > calculating:
> > 
> >     num_roots = 1
> >     num_nodes = 2
> >     roots_per_node = 0
> > 
> > This causes a divide-by-zero in the modulus inside the loop.
> > 
> > This change adds a couple of guards for invalid states where we might
> > get a divide-by-zero.
> > 
> > Signed-off-by: Steven Noonan <steven@uplinklabs.net>
> > Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> > CC: Yazen Ghannam <yazen.ghannam@amd.com>
> > CC: x86@vger.kernel.org
> > CC: stable@vger.kernel.org
> > ---
> >  arch/x86/kernel/amd_node.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> > index 3d0a4768d603c..cdc6ba224d4ad 100644
> > --- a/arch/x86/kernel/amd_node.c
> > +++ b/arch/x86/kernel/amd_node.c
> > @@ -282,6 +282,17 @@ static int __init amd_smn_init(void)
> 
> That better not be loading at all on a X86_FEATURE_HYPERVISOR configuration.
> 

Right, so we need a !hypervisor check.

I'm not familiar with the Xen implementation. Does it expect the dom0
guest to be effectively the same as bare metal? Basically, this would
act as the 'management' VM that touch hardware?

Thanks,
Yazen

