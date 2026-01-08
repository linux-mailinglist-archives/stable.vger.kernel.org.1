Return-Path: <stable+bounces-206382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4CD04496
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 479FD305464C
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BEF24DD09;
	Thu,  8 Jan 2026 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sr4nM87K"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790F23370F;
	Thu,  8 Jan 2026 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888796; cv=fail; b=rh5/n3xW7EZ4/olqQQ8Hebggw/LFol6KLBXhStYuOWQpLDEktskt0SYMJtjFvnbJ3xly8Ix0Zc2lC6LEHtpkR9o7l6MNbWvI15CrP0gYCUTdvXc3daA7kZ7nDu+ig5aI2Go79hfo0vB4JbZlBYoLl4lxDpmnIZxTXZ3AA5EHlR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888796; c=relaxed/simple;
	bh=qVx1Pmb9HLkNG7ClGLxQqKnyvErGfcGgXlwYJqfn76g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VOjb9OJp3uQMLm2uapTkHh9a+1ZCE0ws19dQwr3ZD+DPFiOKMTf9yiUxKrJz4vJD6m0sorJspksNQaKU+2SdE6/W+DJuoOFOUmr4Qma4n+fUtt7+6hanzGJIYa/WBFd+R4WFwevHHxLwiPjvgiAJZsZr1ZgIkXr0N3+waJp3Szw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sr4nM87K; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPLY0aGLbBNYQBfJPDpEp6lAhch/8IZAdT7EYB1KwolX0SoynBzuywPWyS5er7+IKabLvXOt1UiRj65bBv4mAtXw19qkowZELNKIUzJNvfb2JLJG5VzK9JRPjc6ch4KUvlAnvXhCaAQeOgtsS+2zjBp9aOaBZV2R5Fp1tT9JaigUgK0964qEdNRGCqKsKgKT8o61hVJRcFHq3Wxc4ivQ1qQYCOY5DE2Lo4eH+QZGmF6mQhM4LIer87u4AlLuSg1/rnQL/rb+P5VjIPXbTRUi7Hp2KhevJhJx3NNcBk6km5xPngmimXagJYIFrRuLurX+Bm328l5jQMynz5a083Wk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVx1Pmb9HLkNG7ClGLxQqKnyvErGfcGgXlwYJqfn76g=;
 b=ZRDbtZmA2gXrfFMA6xXWwNBPzS/jq0+PDAymxL1yLeCda74Hb8VuAN1p53jQSiggjf61RRcXx4ukUG8SAxel8lkNpW9xvRHhP477EedAOmM/oJ16P31BjsWWvdrztLfFtRfWJ0IZXCwmZnQEyEWIUzos2a3kJ6wn03DEOg+yTt8Hix+WhfDCXvNjAhw8v0ph6zatRkvyK3y8NyFjCI6vXVJurahKfl+KXREGpxqGOn+1Jw18YHazekMI3W1kUojVUSNIoFxOdQbkyE819pcBtv9Gz4Qmfpul5kyhiMXdnaY3stfdFnrtHOvAnH5LeHkvV+grWpt91Rv5f+NPFdR7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVx1Pmb9HLkNG7ClGLxQqKnyvErGfcGgXlwYJqfn76g=;
 b=Sr4nM87KtHPSTyRcwQdfNPPxEGg1QVp8kFHC2yOaeWB9Ek8CtIltO7UVY1KI3UukixdmlseN0I1U/X/qMQ9hX9mGe8bjD2eo8fv6YCz55qvIXSjPYMpwqr3poF93pX4NOZjunFrBaGRLo3GEP4n135r5RNwGHruade8qOMv3ksA4kxvXl9S8UdoIocl3E2uyinBa0b4AysOsG+ySU92/+KMvjecVici/p+Oerydu1X16sY/zO7RQJn6X657fb2VLBrNIOFrzJemB2gaR3RYov1VIg80DGSP1P3eREv8FbU6ScMJbP5Z/6sqtAuEORBX8a4dHLVghDVrvRDBFoQkTXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 16:13:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:13:11 +0000
Date: Thu, 8 Jan 2026 12:13:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
	Lucas Wei <lucaswei@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, sjadavani@google.com,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	smostafa@google.com
Subject: Re: [PATCH v2] arm64: errata: Workaround for SI L1 downstream
 coherency issue
Message-ID: <20260108161310.GE23056@nvidia.com>
References: <20251229033621.996546-1-lucaswei@google.com>
 <87o6ndduye.wl-maz@kernel.org>
 <aV6K7QnUa7jDpKw-@willie-the-truck>
 <7cd7b4f0-7aa5-4ca0-adc6-44d968c1ed48@arm.com>
 <aV_KqiaDf9-2NcxH@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV_KqiaDf9-2NcxH@willie-the-truck>
X-ClientProxiedBy: MN2PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:208:fc::40) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 46214563-5815-4497-8009-08de4ed0d1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAz+vUgxY8nc/vcDn7HKQ8Qssl6P/UnyeUzwld/XGDrxfRObTGwLmyoFQSjv?=
 =?us-ascii?Q?uANQpFHI2xFK4Y7tgNjKeRPhKe+eVZWuMBBdvFmku1Ory0lZru7rcA5GEwhO?=
 =?us-ascii?Q?AmIXqm6zD/E1XZ/obJfBWkPFP0/JEXax1nJjXOo2Y6aD4wib4A8G5YuJyqri?=
 =?us-ascii?Q?74OzdEPuZfTmw20viNtjDTUm0nb2iBMQDoRVa/9tgzm7x/anZNavV0SYPwt3?=
 =?us-ascii?Q?9dwPmnDH7HeecjIisQxxG0PteihptBh784C7VlPiyTUOpa4sU2TvWyELvSAy?=
 =?us-ascii?Q?0ZqIjgo0dPWj0+XlJOJocLchevuGhNP5Thimve3vOx+62fyI9iBG+g50fPLW?=
 =?us-ascii?Q?nk2QCCpizyOLr+zHJjE2HUVB0V31hKlzN9VN8Un04/hlPKUulH5NX77m/Wo8?=
 =?us-ascii?Q?iAfJ1buFcCzivMTeABeG673fma87JPl72gjJhgLhCtERA8yS7igeT5afzGGk?=
 =?us-ascii?Q?xA4IFYQqXh+pDo37dmzE4nocg98DhF9EgVQKodo0fX0tp+RAb6eCW6VK/a6V?=
 =?us-ascii?Q?Zu5ZSdPrqNon/Eai3GOIBfikqNx+JCL6qzxIRsyEmFt8BGyPjxaclCNwSQi8?=
 =?us-ascii?Q?4cgjRKmikie+N7Cq/f6ZlYH3P0xkYeX9TTfnGfSU0rhPSi0RtfSyPSZfacro?=
 =?us-ascii?Q?ky0JXoA4Og1S1qkAupHYddVQrQfNZLv1rvUYcZkqrU3ai+8+Y87+gAKxDppB?=
 =?us-ascii?Q?IL7Zb+iQZcs7bCCk75AXCD23hbMhuQfJTIXaZjVd6u+udb9TAByjbx5wK1Fd?=
 =?us-ascii?Q?6OLThvhXtl4VpCc3gbUcslIJYtCyTQfpc/qsVd0xbffw+vwHb/2p66foqA/N?=
 =?us-ascii?Q?1YYZgaSp+BQzFd3+ShVGBL2WEjISgXACtAhyIx0udyNfJWq5QTeToXq3DhfZ?=
 =?us-ascii?Q?21hbbVR/AcV+c/FFwlodGQKhDsVF2tGjMrZRuOj3woDcc/PQwIs+jXM5Orff?=
 =?us-ascii?Q?6cAWsb5Emfai2dSSw2MoR6xOeGv58wfg8MDSChKP3jSWeHf0SXtblaX2imqM?=
 =?us-ascii?Q?KIicYeEFL2qqcO15JqkiDFlnUGO7v92SWnpkmRDcGkZ/EdaJ7yZJpG0LiDaC?=
 =?us-ascii?Q?yRtQI1xp4m1UHHXDyORDyQH9IUUvkHzHEYuVZBBMT3DVdSyguXqBqR6N16uR?=
 =?us-ascii?Q?/UB4eFjSiIpRoK8NdZ9m9TZw25SJ6GURdBlQ1AOoB3krY1MgGu8tPb1yXTYL?=
 =?us-ascii?Q?l0crTD4G60o6WIAyXTNEqIeQ0Qw3v7xWXJGDmuxItKp/vU5XkZByDGPUZ6ET?=
 =?us-ascii?Q?TmgYB6kUy6LyDA1zkX4FgEbmySs0yXkP8UKY7E+4bk9DQ/kPPeDdGY7ZbFGo?=
 =?us-ascii?Q?kcj9b7S/Dn3JBgn4NbEMkn1n7gKnHJ5s5TgTw25KX9SymW/JNhCiSmO4gsqh?=
 =?us-ascii?Q?qj9nSmnWhNdn62XVpgtKfJZkvF+t8GGiPvLCsD0G43Mb+JRxTysSl4rRdlcf?=
 =?us-ascii?Q?WOUjU+JsHiFLw6n7zqmFPz2ZgAKN5AZu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vq9mvy1NTi4YRkKBRIXHV4X6XoZbXuuQuevu2ec8wDQj1UGxEAVI3f6XgdSn?=
 =?us-ascii?Q?LzO6L0aq7keJL245+CWEQVKVVKksXFAhZWJS2pkFc0sNAdfJqnLUbZQ54EjX?=
 =?us-ascii?Q?Bu3qMBvugKBnUuZq7j9tC2pfN/JBctWERETHbcnH4vYrEB9bmZeRB1WUc2Sa?=
 =?us-ascii?Q?9YlVzhk5PULJ3xsqADhON6knq5nvhFW6y8+xKaL+LI/G1FZF1l901rSK+lxh?=
 =?us-ascii?Q?EBA3AfR6Ottbj9R9uj8bF/Ac+cd4m77FNh9JRbXM8bpKN9u8/muihD5KAwhI?=
 =?us-ascii?Q?SWeSh7IhQIv2cZKuTPVarLRLs3YwNWdvC3tP+FyyA/delcH+xwp98NhGHs8l?=
 =?us-ascii?Q?g8E9+atSMvObNZglo/KtgL5SHOEOIz+wh1sxaYiPus6JYzv3SSJJBj8tvy1t?=
 =?us-ascii?Q?6jeCgy8somh82oyfvgWc6/qiQVziM0xmRVxw/71xyieI49abk8gMeSV4DjXl?=
 =?us-ascii?Q?IrAh2jKWeGYsVSR8IWT9dfh0anknowt/Jl8xEy6hr2eTjxYYw1SrnuJPd1k+?=
 =?us-ascii?Q?445Ds7uuEAkMr+502CwTpTpu50c0WH6emqWvL18lNuuZXn/oWy82v4/5vWVj?=
 =?us-ascii?Q?BqBzfJ/Pt9vILLfQUzlo2T9oceV9224dnVZ9mNR3l3JS75g1REYtr2cDNUDg?=
 =?us-ascii?Q?AaFpqzMJkQ9gactlb7BWyUZXKpRqo9FLMDrYHvWZzD6QSBQEBAaNA/HBVcyr?=
 =?us-ascii?Q?gIdE3OdmOWT396UACpTKm3q8fXb+YuT+luPR5PKh4NTtEq1Oz+F+SiqyhJge?=
 =?us-ascii?Q?F4o87xCjRBbWTaW5mSx+cVtqY8r16CuKuNClxKURPJTVCSUyqGQ31sX9fQey?=
 =?us-ascii?Q?IPmzFyWgen9Q6B+kqd/+7gETqF3e/gSYL6DuWPZ9pecQNp22CS7jGidew238?=
 =?us-ascii?Q?nUtwsOcXKEkKAhGfk2KpqU/Ooky7eufLa8xzgKtJWDI7pisYkuV+AcLDcz9U?=
 =?us-ascii?Q?eQTbJi5WNIZ3rcykLLBv7vVFOJJTqQk4RXimJZpcMsxJ8s0dCtaaQr6Cm45Z?=
 =?us-ascii?Q?nlLFjed8ccla6Nsghl9cRpFZWEqSFG1JhY1I64R7rplhTixcgQLUnUi1TwXS?=
 =?us-ascii?Q?QwljW4a+E37iHyVcT6S6jdhIC8j8UX/hILBJCIkC+GGZpq5+hAZLz4piq6qq?=
 =?us-ascii?Q?ygGKiAGnGichWxWW9E+84MHQHuE2nXOQ4NFc8rY34apTVTeduiwYgeGpeqbS?=
 =?us-ascii?Q?6UrIAL4qsoR/COqV2okJdbsnr1zp/YpPrPBX5Uv8btZPCjBo6n3mMfjuuB0X?=
 =?us-ascii?Q?qoey0Im5ANvKKwt7dW4quTWHoowTI62/1yGek2o0FYnkXEkNTq6c+U+1d8jq?=
 =?us-ascii?Q?rYxcC3a32qRvPYPGmAP0M/ajdEvh+PmsNrwBEbKJNdOlA7Rh+hwCyQ0lbGyR?=
 =?us-ascii?Q?4WJzYjga3NI4ueOEhuIJsTd63e8RLM6QSnDzu5r9V418Cz2Cuj860AI0oF2J?=
 =?us-ascii?Q?Z+dj4KFSlHdIzqL9iff1fXn6G4dAFB1hWPi2GOTWHiv7VI+PwKA+OGeBej5H?=
 =?us-ascii?Q?Nm96n9CykeJAIO/VtWlT2O+UxjdQoAVOph9umpqknIWKnq6vggQO7h9vnekz?=
 =?us-ascii?Q?uZNspEP8jsuos2Wyjqgv45JcuYUPcwJLCtIhhNIbrwy9NnR1l2NRmsgc3wyQ?=
 =?us-ascii?Q?MAmVUB05mYQ6fp8CJaBBzJ4RyLuhw5nMun0r25zQOB8owSAMjb1Q9sgMcQK+?=
 =?us-ascii?Q?Hp9AHKgMUe0RBK36bjjT+8O4Jh1hyyihrmZehCOAGQyL6tOgkQxRj4WqV4lz?=
 =?us-ascii?Q?BUVp0GwpmA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46214563-5815-4497-8009-08de4ed0d1d6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:13:11.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFZEjb4pHRR06BgXHkdisiuI49wgUoSNbZMxIzp3KQfrndsdG8UqjyjH7dBMdTju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

On Thu, Jan 08, 2026 at 03:18:02PM +0000, Will Deacon wrote:
> I think IOMMU_CAP_CACHE_COHERENCY is supposed to indicate whether or not
> the endpoint devices are coherent (i.e. whether IOMMU_CACHE makes
> sense)

Yes, that's broadly right.

VFIO/iommufd does not do any cache flushing for their own mappings, so
if the guest can use DMA to cause cache incoherence for those mappings
nothing will clean it up and you get the general problems that come
with that.

Broadly IOMMU_CACHE (which IOMMU_CAP_CACHE_COHERENCY says works), in
common non-hostile cases, prevents incoherence.

Since it is not complete against hostile guests, we also have
IOMMU_CAP_ENFORCE_CACHE_COHERENCY which is supposed to mean that if
VFIO sets IOMMU_CACHE then there is no way for the VM to bypass the
cache with DMA (including PCI no-snoop TLPs, incomming attributes and
so on).

There ARM story here is not great, but with admin care you can create VMs
that are safe, and CANWBS server HW is just completely safe. Like has
been said in this thread Linux just can't tell the safe/unsafe cases
apart in ARM land, so we are punting this on the admin to deal with.

eg a PCI device that never issues a no-snoop TLP is safe under weaker
IOMMU_CAP_CACHE_COHERENCY HW, but some integrated GPU masquerading as
a PCIe device is probably not.

> but it's true that, for the SMMU, we tie this to the coherency of the
> SMMU itself so it is a bit sketchy. There's an interesting thread between
> Mostafa and Jason about it:

I've tried a few times to inject the ACPI per-PCI device coherency
flags into the logic and failed every time ..

The stated purpose of VFIO is to not allow incoherent devices in VFIO,
so if an admin manages to do this through one of the holes we
don't/can't check then it is admin error :(

> But, that aside, FWB throws a pretty big spanner in the works if we want
> to assign non-coherent devices.

Yes, at least guest operating under FWB wouldn't have a working
dma_alloc_coherent() so the VM would be pretty broken. No VMM can set
the ACPI/DT to mark devices as non-coherent in the VM for this
reason..

I gather Mostafa is trying to make pkvm support non-coherent devices,
I assume he is giving up FWB and stuff as well to make it work.

Jason

