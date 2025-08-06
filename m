Return-Path: <stable+bounces-166716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542CCB1C955
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604E87ABA49
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139354764;
	Wed,  6 Aug 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CrRab2TM"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6F292B3F;
	Wed,  6 Aug 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495548; cv=fail; b=DzmUf61hjrA4RmWCw4UhWh89XXMqM2LmmIf874pG/uKWkcsXWpNuqhYczyhhUC1QLjStJOp0bt842iykCMP5NeEvuyizt3RB2Wb4YMBQ69jSEDUmfeopc0cl0sGsvBeUy4RHqqMSSzpLgkck/2P/R0VoqGgtVbTBNPz82A4YaFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495548; c=relaxed/simple;
	bh=QCpUCoeDqhWvM9faoDtyUA+e8obPS+jsNBJ7qiYU5ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o5eIq93Mwi17EvL+MyBvWAx6UZuYfnLE0/Y6qe4oCjG/bXW3MtN7iTJHUjUs1etRjX+pkH090rmkV0IPGkhZr9wEsb8uYRFqPrjVvI3bTsWk1n2raLUPZX8DiiEgYiXhU4VPQicRIE+Y+AwGmVmOSJu6Pa8nyKSqHLxwUGU51D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CrRab2TM; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSqrkqs8Uxg/sg6EFYBRxl08y0YidFQkP4w1y2t3fUfq1nbRtzjlnQbSW1myccFZYMnWDUaXJyC8NLOYfa5Hedtt4UIFiRiDEOCA23UqhL+7sF1Ab2mPB9xcPPHiaiYm0bldC4M8GS6D4mPqSqPueLyLoZitfNOa13mHr1cBRlK3H6aUI86hhIIh5LoZiHC0Il8aPk36aPk97fwHWRqrBeLQIoIeO5BPsHvqrTY7vWAdH4pEhvcagKje4LOEgEIcsvxiHv+yFa/8+cOYXdHUqUpK2k9iJk2tpCHbsMTv4Nwaw8XsuNjuUMdmkQoI8co2XUawy1sxLDRh44N8x9UI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwPNkjNseaNko3a8qGFTjz0lxgQsuxVdynTmceeykDg=;
 b=JcLuqrdOtVAXvgMFpSfCXQEv4srK1pmm9ZZMWXvwjrAwxOSCpnygcjx9yJpqlqBEk0iMOvQFVlLKdM9FvZN/TE178Q8WU7AYDOU0dyZ2u7muK5ERmFzeVA4zRaIfxLmIlxCzv94b53NmL8yZQSyUEitwuEzA8U/8B17xA3O3eHwHujJb83Kz0o0ZSDFaXoNfZk4yIqvYaNxXHzJII1xjeJUuRolnxRdtlUPih94gRjb0xpvfVPvQLDT6RSKFH9dtwp+OVeDO5GR+Q7J4hDAQpMrXLJ7Vf7z1EFklwUYTdL3DEJcMJo9PuAWenT4eW7Tpbt11ZSGJoGIcA/Onpeh9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwPNkjNseaNko3a8qGFTjz0lxgQsuxVdynTmceeykDg=;
 b=CrRab2TMWUL2dZYg/OEm5ylYKIx6Do+q2QQzGf4vB8zsJ9ZcOzDG40OqWvy/68KjcAGUdQxZ/pliNRCEkfh9zLP9wiXshpWr7Eh1VfxdA8QEP0/7Uo9q2tsm9MzE4k8wZtQAqs4zVCNrw3bRmWJkrxWUR5XerNroMgSLm4hNJCnX8krY6OyKwUZPY4UKqNu3ohjHcPU/0yzdDLsKpTqxrkfuyi3N/Tk4HvR0nNBhT75nrI+a+jPOy4ssQBVht5Z+BYA4PQP7Ifhk0sMtMfbSOL77fqdEPBHL8usMGyV6aCNNBINHfFJvR3VeRI/8ErL7pIDIUCJ+c0SRdUP+sNhwNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 15:52:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 15:52:24 +0000
Date: Wed, 6 Aug 2025 12:52:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250806155223.GV184255@nvidia.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
X-ClientProxiedBy: BL1PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:208:2be::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 469a7969-1f4c-488e-9428-08ddd5013c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v272fNyPLDvzkjYHJOjWGMxy/kGeyimN++ph6PKvo41Bev98gSrVaQDHMBX7?=
 =?us-ascii?Q?AyUo/Ax1zhDAbOD3T7Uhw0G4rEiCpfwSzS6IItyMbGqoUVMmEnmSFWtngo61?=
 =?us-ascii?Q?/7U53hgP49z8PQrfuBzpe05+VetdZOx2RBlPrjacaWa1/Cl71R+eSzEhpR8Z?=
 =?us-ascii?Q?/GUU/458VcjqrvJYfGQZxFoFirJX1zZXwlgbDy0lhC+HVZFuZz9kxkGrBKVJ?=
 =?us-ascii?Q?f87cGIvq2rxJ7J88vPwF8gRzuAuqpKjnRfBkSqJv0ynjv/GlmnkNzUj81dsD?=
 =?us-ascii?Q?1PVBCj3ddl8vp3j8HsV0374m8FJsRrkz6BBtFWU7za7WMTxj3h6xAaYeieVS?=
 =?us-ascii?Q?LWPC7eaAH9oyYKwZ1UZijdSM0KyW9sYclsS3q+53YPqluyy5bT6uXyiG829l?=
 =?us-ascii?Q?Zl4ZvKpt2MQR5FeYRSOtzGX6+y4+1dtHGCsTpogWpOqPr1A12+PAIAhDoU20?=
 =?us-ascii?Q?p36yUQfxJWrvr3uvNaj8RAofVQWfNEunO8I2A8lspoOz86zBR8wDw0OngXFU?=
 =?us-ascii?Q?/4rCm2dBLD+5QtrBRz4a+caiacHHbu1QNMGSlDqYkC8UQJHWkqedQZZ8n6hJ?=
 =?us-ascii?Q?AAmaKC8SY6+gv2WE9hydEeF6HhgEzgeYm+XCbbVYYzP7TVe7S5yQsMErgbH4?=
 =?us-ascii?Q?ZrUQt/VJK+3gklwdMde+XvG8/tuyN30sMbTD+UwzoAOYgMvhyDUU8YoEUXvx?=
 =?us-ascii?Q?4XYyCGNSxDwAupV8Eap/QgtANJQUB31y6a9R9iS6ks4sijyW/Q5LUteU+hnp?=
 =?us-ascii?Q?1+PT+h4qYwyQh5hLiGifuwHcaU9U3BvUFDK50MxZC9vQp9Ot01jaUbhACXz4?=
 =?us-ascii?Q?yYmk5n0rv7tTyLUv4G7aWANnPCtp8b8T6YXpL+qFvEQv0RnMy7Ng+ZW8ot1O?=
 =?us-ascii?Q?6zQ4k0XGGy7JboqShGHw4ZCtZcbvZvvhxz1tjAL6IPlOWE4u1HavtKx/4xTL?=
 =?us-ascii?Q?PoDajs1OMkZGk6awq9TyfTyY1lB2zieX56dUQzaolj2lagU0MmINXUyKIPYo?=
 =?us-ascii?Q?qZz6RHAk7b29EN9CYwT32YlWxdt9GRdy/S5qkTIsLQbMaH6tEAF5GDnpv40r?=
 =?us-ascii?Q?9r5Akd5p3uw7FVSoOFUMlsmvchwvRPfSqvsN7e3aLTal3Aw5AMDG+7/cbjy2?=
 =?us-ascii?Q?fU35hcqJP6HG4qLRoT6D8tHSTFVib0l8g+g8kDMovZxnN94RFZ47fYuf032x?=
 =?us-ascii?Q?OVJaVAB9PZ+QzWwcb9LL2ztMQ/8NcswmDeEN5Ds4VLjERYEQgSVaQo4aOxwr?=
 =?us-ascii?Q?7BW5Ii7xMVIhdm++zKqX2uRFEkVLVJyTHqRSw1UVvj/jXKqY4MqFD57S+rzl?=
 =?us-ascii?Q?BsLY8EQVuByGr9JV50rWOZo9nnLjQ/2nhj2g6xWgYiASBBmFwf3iy9McJhL8?=
 =?us-ascii?Q?X/CaKFT0YyukIcuU5hrv+OoP527ZNvOusmWalxGV5fDnE8T1SKOD0QRXG3Fk?=
 =?us-ascii?Q?OQyOtEZrO8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EQmlHDaCKC8I7JYciZqL5HZwz3ST6/Xpf7qcvgPhBAEs+hCRr1tOlcyTblY6?=
 =?us-ascii?Q?9EtP7OwIAv4UH1mrot9rL1TspdlpfsAz4RV2tIRid1oyrzGbW+eGXwxLhYbE?=
 =?us-ascii?Q?rbFjzO7jNNe7dHy5gMZ/9ke1MMKPpLvUut0hj1w2DcGJ0iLzCwknjNdoz4xo?=
 =?us-ascii?Q?I57iFlGko1PUW5T6YT+WLCE/aBIkCXfprpHC5+uU4EG4Q5GgY/lbBifN/yZx?=
 =?us-ascii?Q?bIEXLUPib2rr52X2Yk+1Gk4mMfIct9DQg8dhQVVI96qdk8ySF1+iVJTPhq/N?=
 =?us-ascii?Q?Bu8o7ZMBQoZiII+boO7RDK4TrVs0EFLPYZJ5CM70yTkQmtf1y6k5vRuBexS/?=
 =?us-ascii?Q?CF9FyRemh+y5THGlXs6vlMAF29PIGbnuGUL3YN3fD1k7jYKfTuoiEDeFsNTA?=
 =?us-ascii?Q?pA0Jet5LJoKJCrCzh+lCWTIQCtcIyCvFaoFeuNLaJMXtjZaVOPJUsJjZ0Jok?=
 =?us-ascii?Q?OTKZh4ZxIh/K01Nhh14qDCMQsQf6BFPWkkBPQmaXLbCaK4JNPDQSfgdVZko8?=
 =?us-ascii?Q?drW8T0cJrti7sQs7eGDtgx4WYQqJqQPRk9ojI2bnbbgY/8v18w8RslPNJfFc?=
 =?us-ascii?Q?cAv/+0Cf8YhYclRO4uDPmmdO99LCK16zHIZByGkjUa+X/e2NaeHWp9y52wyX?=
 =?us-ascii?Q?iw/JgxpD4XWfANWZDI9QsWVtXp3JBfF4ulhgomCoVylMuhLfYt8OEvFfj1fo?=
 =?us-ascii?Q?GL6g9V50RENCfvUaV8i7nBzihBPCX6ZQil2zsAcmMNohS9JZyRG/eFNHwj1E?=
 =?us-ascii?Q?wZxqppimqRgAQPs2MWqZ7m9ElkCn99da1XGQSHPG+jOkL0zKS4VHfXDiVobv?=
 =?us-ascii?Q?BIqGyryXw9kJB5NVhSqZbl3Jrd7stXju2BsJqvtY+DFzG2TSC7mETOSf+Cs5?=
 =?us-ascii?Q?umatA1ee4qxfSut2tvLYoo6pCkqGJ8LSKnkH+oDTO5kOljOk54eDcq+fU+Qx?=
 =?us-ascii?Q?6L6L1kTk4BWrFerbyjTcx7AGD3b00O92myAQud/jEhQY1EOO0n0f/GJ1JhZ8?=
 =?us-ascii?Q?3J0Y59fG2RvuC24KSCH0QPhwLMj/H4slUaRfPcOYGAW6+L9MBUuiPTmlb1pJ?=
 =?us-ascii?Q?cJmkMHMlNuhpPoz4qL+OlJVWbld9cjX54gii0n+nSepYSjbQdqaz8W4AnGOC?=
 =?us-ascii?Q?4wttjzYVNdZWqt0TrDW9zkBUSnrWN9Rs9L88JPBHOg2gJaFMYhYyHhn+9CKr?=
 =?us-ascii?Q?DXsEE/ypUGLtGZByFdQoFO+0fdvuMhrgOsIJ7zP2bkpR/rohcfk3SCpx21kk?=
 =?us-ascii?Q?MhLPRmb3TXh6VAXxvu/X58JY6BoH21EQVX1UpTkN2l7oWy078SaWbVMemQjW?=
 =?us-ascii?Q?9oVDwFF/atG59W4Z6LOdIqvowWv0/ipWHp3NNFBowlZBhskoodugu5w3kvQl?=
 =?us-ascii?Q?4Ho0xscuYtmKf+RQkAFZtoZJt3iWrIGzfnCpVB4J/hI8D5C5Q+NiwnzK8UQ4?=
 =?us-ascii?Q?jV70bKv33VvfDNX471ZbEBgS+/XHq6ur/LG7GY/EagcT1fdk9duXXGjBdIts?=
 =?us-ascii?Q?g4mW1L+9omK+X2WTvFvczJH7XtnyP9UM8qTozgku/KpG0Z8k/ZstS6LhXoBp?=
 =?us-ascii?Q?l90KbU/EJi7JtWYgaSI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469a7969-1f4c-488e-9428-08ddd5013c49
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:52:24.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceU57TWDPIJFxqwhTHdi/U3tEFODzBIKFoOR5oE1qiwPTWu+EUrDwkfquL02tqd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243

On Wed, Aug 06, 2025 at 08:03:42AM -0700, Dave Hansen wrote:
> Hold on a sec, though. the problematic caller of this looks something
> like this (logically):
> 
> 	pmd_free_pte_page()
> 	{
> 	        pte = pmd_page_vaddr(*pmd);
> 	        pmd_clear(pmd);
> 		flush_tlb_kernel_range(...); // does schedule_work()
> 		pte_free_kernel(pte);
> 	}
> 
> It _immediately_ frees the PTE page. The schedule_work() work will
> probably happen sometime after the page is freed.
> 
> Isn't that still a use-after-free? It's for some arbitrary amount of
> time and better than before but it's still a use-after-free.

Yes it is.

You can't do this approach without also pushing the pages to freed on
a list and defering the free till the work. This is broadly what the
normal mm user flow is doing..

Jason


