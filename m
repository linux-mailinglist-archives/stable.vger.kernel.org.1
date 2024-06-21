Return-Path: <stable+bounces-54847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64931912FC9
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 23:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1BF281B49
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7617BB31;
	Fri, 21 Jun 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WyAO06/v"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0A5664
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007024; cv=fail; b=MlFwbcblon+/k9FRdwC12RiMKRqD6uJ0j2vwlz4TxhXH7wKPo90fiuS1/0tYygMbImqTghQcf7MEUsFsJLNZOiK26fFjv4kR+fElULgEHUpKLRMHadVNVP0pJb7EABL71eEJhMVzsbFhiY5mENFrE7cfbwpKEmaZ+tzbU6+q4G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007024; c=relaxed/simple;
	bh=IyNx9gYuR5A+gcY5EJv+w0VV0JNERxci9rnl3YACHNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CT2CL88YIeAh74yOFh+tUT1YK1pOm6u9/lcxV2MsZIJrTw/QEkjRetaO8ihC1Ym8flyvQNIQPe1nM4tHjzx7DROuCDkRdA6nfcDxWQfX+LVaaT1AzdYzwbNSgKkdnEmrX2M9IasOYdKSaOdzTPVorQlxqELQBB/887XM51Lww2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WyAO06/v; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3vmZkY6b1d98HWElFEBfyRg8g4j9npZ+DL/lSmMFMhuBzlE7DEYuAM3NSFI1UoWil+gypXpN5x0plxLnHS1YsXm3QhlWjb06/72Oz+mCEYpItRROZiCNt3ztMGsSPHTzTgT/C8034VuJvZNTs6DYn6C6K1P2V++FakUuvH3mBi1lChCyXdEuBPNb9gkLdzi0mjIZHVuRyEmn7a5+iJma53/If8d6fXngiWpkzI53buME+/SUscGtAIw4f7h2XX5txxadpndJSNQg/xMvFOscEugVSg7D72rQJOSjHDwO5x2EB6rShygpWYGVuaLzbvdDO7UyHReCsYXGK5PoHKRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjR3ETN7gh+4w5XAd/QJqv3KrrsxjeG3HXcHUUGdTiU=;
 b=B5Q5T6NntI7YngYdC2aH8SNapL93RYJ/37uG5ArwHtWmY2gsjoxxAn199mGeO39+JY+fh13UHrg1yrHgo2wcDR79hljd8QM6Ni0FBKBq303UpcdCpyLhfWjpBQKf9Xz62ZP/QhMqEWQcDUmhL/rDy0QaikVEKo9xPT6O9NKiziqlw84m8evbXXGHcbfXI2gJwYBhLaUQsG/pxwz4pdpGo3kFb6MxjS2jABr0hAIWAj0QDNN/hcq6lD0hePGeGtjMy+BqcHdKeX/yDFuAxIwR7iRIrJ4TV8RVWXfhz10UioXQJjXafisCgD1VN1Y23nW3Oq3oRrfdbYqaoYJHcAoAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjR3ETN7gh+4w5XAd/QJqv3KrrsxjeG3HXcHUUGdTiU=;
 b=WyAO06/vtiEyZWSbtK4fQQdIpHD/sMwRUQb0Wsbi3Jl4t//sSaoarZurLclvxFyEZ38gQVy8VdRMxVYp/VOqKIjrlHvK1R3XkuoKnlZkkp8hbMtmNLCn9kmDMCL2rJceK6joA+udXkApsk1/ikuiWPZ9pB3/hcqciqmlMZEgnO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 21:56:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 21:56:59 +0000
Date: Fri, 21 Jun 2024 17:56:56 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Andreas Radke <andreas.radke@mailbox.org>, Mario.Limonciello@amd.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [regression] x86/amd_nb  in 6.9.6/6.6.35/6.1.95
Message-ID: <20240621215656.GA20274@yaz-khff2.amd.com>
References: <2024062120-quilt-qualified-d0dd@gregkh>
 <20240621232911.01b144f3@workstation64.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621232911.01b144f3@workstation64.local>
X-ClientProxiedBy: BN9PR03CA0448.namprd03.prod.outlook.com
 (2603:10b6:408:113::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a06962b-3adf-401c-0793-08dc923d1337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9+R6p6XPpIq+SCA7I1hC0QZuMlqpkQEmll4Gj5MzaY65ovHCuNtnnXT1rW7N?=
 =?us-ascii?Q?2JDgrQwySs+ksQCiy30i6mKI12zA7n7zLGqxEKEAutu/LrgJ0aQ5ytcIprPu?=
 =?us-ascii?Q?pkQepKr/rl29yR73y7hNC941+WxHgVDGh2kr40i8UPRD3uE059UT8C4eI/XS?=
 =?us-ascii?Q?EhTQg0DquOzGGTUBRP9izo7z/b6f4O/GtTB+peZdDZSFWrYQDNn06rg72yQx?=
 =?us-ascii?Q?71v7jAqJbHTdgiAJERGeuQl+CYdI2dIMTq9fKDb1EbYq8s9G5qIvPfpPSU+w?=
 =?us-ascii?Q?K5eqJPzT5kcyWy8qhL3dBOfEtLD1YKopBpYW7KhaIDZPt5r/tVKXBZVgmvM6?=
 =?us-ascii?Q?k0z/LJHeddJuTJKC6L9fR7/wvPIS4/TOtj/hCL2lfVtveprDMGdgQ6vlx5mU?=
 =?us-ascii?Q?TOXypVngaaGkuic6+1Twhjz2fMlpXkgC3hdfJUmChGeC3K3Sw2+riPS7a4nM?=
 =?us-ascii?Q?yJw+ZAAPPZMsvZbUrdCTP1tHIqgI97jExFGTz/sAWxP363olRPxYKJFh5c+5?=
 =?us-ascii?Q?Dd8igDauU0PwSvWGTijdur9fpC7v5SMKxxx3nNtqH0u2D6Uq7e8LOIFeCfbz?=
 =?us-ascii?Q?3ezGp55csPGIxy416dgXy+m8tlpSJ1zUz+m+CwDKftL9DFVGh79bFi5twNZk?=
 =?us-ascii?Q?yDY7Qyvf+4jGJAyqq7nUbJtL7HNrFEaRhBqwxAuStvc8BPAwLNhtL7EN4qlq?=
 =?us-ascii?Q?KzUlB3jZ1N133/yEmy6AXmoZssQDqnhiNBVhjH2GRYwQV17NMu9VBz6ouSh6?=
 =?us-ascii?Q?HOdM749PrKuHsRbRAI6k0aqZaQjIwChSLFKdwU0r0ligzSq2/gZWdZDz5j8T?=
 =?us-ascii?Q?cEjTmHcony/GYcuyT1rabXj2hM+IyzfcmdUTanpbSCpJdGkffbg7lEaQqVsq?=
 =?us-ascii?Q?UTFIlN3EgFH5nO5iFqnZESa1nZ1LLdHDMwM8PODkcWeDkUBna2TzHeiuuqpf?=
 =?us-ascii?Q?z5ITboIgA4SWPuicYWwH3dtiadHK12tDavPLDIx29BDLBrLV2aNmbMqHFFdd?=
 =?us-ascii?Q?GawhQnTPqCOcZkVtgTfKLSvRq/j7CEmu/iyDOSk6oUUL9GzMMMtx4U1pK7oc?=
 =?us-ascii?Q?pzlz6DEPxcbfayS5swVhQALY/PUxdOR421RJlGAzmBJPYxCks5rgDPjuAUAP?=
 =?us-ascii?Q?RRvm5UWKEXvz7F43H4dbFWcBzEPhkSfCE/Eqv1j0/Sq+TOqpMxhli+R9dHgM?=
 =?us-ascii?Q?/jjPjKEcGwb//9W1H8G+KX+xUEVuihE84ZAe+8+tV7p0UpFHYpsOhxFeJ/fE?=
 =?us-ascii?Q?mFr2nZRW4qIc516UhuCvwM44ZnEbcmRyDX5g+MwCjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?baoDFj0a7Q2ym+cP6vamGkpzwfPHSnSlBj61HYZ92yQDICzChuE4ZFH82gFo?=
 =?us-ascii?Q?+vIhhOR8C/Px3wwpPzghFYhyAscOdtyEedvsHpZe97jrVlsa0L4SieGYPfpw?=
 =?us-ascii?Q?XNbOVYrxmTYcnQeSCg0j545NRzLfTwYAUgD7YZHofd1jKU1JzsbiMkTKKxzp?=
 =?us-ascii?Q?hyaFj1WTzFEgYsKjtUOGZyB88LGxkcF8XhmtKaXlDvKVJpj/tPtetbOC9MpJ?=
 =?us-ascii?Q?nUYauhBGLT3w7k6F11nla9cM6AOD4khuSiUKSyfVMmV03tpGqxyeAjVSW+md?=
 =?us-ascii?Q?8GCLtx6YSlWkf+meLrJJntqPA6ZpyIr6hnDUcPqIc6yH3Sj0T+rS1b4kkk4b?=
 =?us-ascii?Q?FFUqMtsPPP+MljTKQRYq6VRkECei2qT+k2GkuWJ7bGpSkz5/HK2MoifPJkrZ?=
 =?us-ascii?Q?pXjmz4j/c8UfBfJ40Zw83n/+y7nKzDla9V9xqhuaj3PFX02WG/krhLjYcUXV?=
 =?us-ascii?Q?HpNOBnu49inocAVppJrna3xX0GYeAU1x4icfOCjYPC7LbX9YZ7kIyj309zD9?=
 =?us-ascii?Q?SZhLNc5NWmQErCi94kFHsYIINO5TkTwa0JJSYvnmToPcmLG0C7I/qDAoLDNa?=
 =?us-ascii?Q?5IzKFQMWaELkbye8yl69/A3zEnSz2wmiqFyiD47dfDBCPypPtSQYOcins1Ek?=
 =?us-ascii?Q?umKuK9yyUHF2UJ+Fx1GtHJJc/Ti1IKHPdHD+Tt3fofrwB0uRM5+HR5FIopIK?=
 =?us-ascii?Q?7jNMzIXyeQ7VPP1rHHpXvjBBIGFJzzpOU0pMNGJ0Mvo+7FK/dVQNQd0jwLZJ?=
 =?us-ascii?Q?NIT6GGDXFz2Q8NTaVEmwM2aFsd3KjJhLRz6srLHxGOI7BrWdheUDh+eoSatx?=
 =?us-ascii?Q?9Hbf0wuBMGT0ZOo9d0rC0KIlVe5ixP9O/G9h06pt9xaAdWMQKeisgSPDDNn1?=
 =?us-ascii?Q?rX40PVg+6iEkZnynifY8Ucm2zsMEORpxion/2Y32T2vPyq6W9/zOOVDmkGlK?=
 =?us-ascii?Q?kzguVDiAB6ffzL+Hx0n1et/rm6Wrei72HV9TrqVwGdP3YpdTAjKjJhPcn7sl?=
 =?us-ascii?Q?SZaKmAsEHKBOJb0UqKIAbs+JyLQ3OejwYvq5O3rdYQRhZxFe/qMfA26YdyVO?=
 =?us-ascii?Q?LGLezOYeWe8/qhj0WdTmg7cb9wa8Ne0Mopi04f8qWUl8HWNlsd7dYGLU7SAT?=
 =?us-ascii?Q?MibS0iaU4i3/11xooiD9O6NjcA5/3l98vx0mip8zg8m8Xlp9tvWLOAy5Woew?=
 =?us-ascii?Q?rjIByr2Pzi3Uu3xuQ7BDKC4532ELbmmH2Tx3j6Gc7W8f+rf/qkDZLpN8YNHr?=
 =?us-ascii?Q?/DB/saDv7xZ4qAoE5M5JcFZa51uPLTCnH7YlJ5D2YINC/NhRY9LFvlIwk0mf?=
 =?us-ascii?Q?EtXymXpC9sFy+0+JgOt1MPV/KShZwIk9bUNt/4mqDTf+97lsxoW6QyJjRqzd?=
 =?us-ascii?Q?ZzRoUbN0sMSoojk5LkMUJnqAcm1QXBbfvos/SRuQVcNjNua9LozUWgrxtQ8Y?=
 =?us-ascii?Q?1Ef0BDx3H7vlGVpNvT8hWFUrOAz8YCgcKb/qNLb8zMbPMxHWh1P2XNI2Xk5i?=
 =?us-ascii?Q?yZzBYWKlzoQ4KxFVcIDEW0s2uR7pgv/JPV03MLShtpJiDhnd2VgKVxgD26TH?=
 =?us-ascii?Q?oF+avDY3bAsq0pgEPUVAKg6vAU+/JW239A8ga3Wv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a06962b-3adf-401c-0793-08dc923d1337
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 21:56:59.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fc+UDyHgveSCaUvrJoWn7wQm2smPAhu8xEXBlwJj4dGORpiH5JxTdfsG8x3YngZBx2odzTkKhWcNFw29Kg0VaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

On Fri, Jun 21, 2024 at 11:29:11PM +0200, Andreas Radke wrote:
> Am Fri, 21 Jun 2024 14:59:20 +0200
> schrieb Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> 
> > I'm announcing the release of the 6.9.6 kernel.
> > 
> > All users of the 6.9 kernel series must upgrade.
> > 
> > The updated 6.9.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> > linux-6.9.y and can be browsed at the normal kernel.org git web
> > browser: https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> 
> Subject: x86/amd_nb: Check for invalid SMN reads
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/?id=348008f0043cd5ba915cfde44027c59bdb8a6791
> 
> This commit is breaking lid close system suspend
> and opening won't bring the laptop back and no input is possible anymore
> here. I have to hard reboot the laptop. It's a Lenovo Thinkpad T14 Gen1.
> There's nothing in the journal.
> 
> Reverting this commit on top of 6.6.35 allows proper suspend/resume
> again.
> 

Thanks Andy for the report.

Mario,
Any ideas? Maybe something with the platform drivers?

Thanks,
Yazen

