Return-Path: <stable+bounces-195459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A7767C773FF
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 05:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A2CF35EDAD
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 04:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B082D248C;
	Fri, 21 Nov 2025 04:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EiMuAzcx"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764222EC090;
	Fri, 21 Nov 2025 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763699761; cv=fail; b=OoPrTM40V/qFlg8+NiSixYOQF5YZaNmFztMyGGChseXRzYWEiU2bo79YjSBLYtJ7NbD7Z9gdq3/RXoSvq/I+vXFPT0IwwyuS7ctqRZiR0rTiraVQQflNAXszMA1cF6UyGTJxHcgkXOmV7lsyMg+k16W4qZmyJJx9+TeInAVS4jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763699761; c=relaxed/simple;
	bh=sWtJIpa6SGvIDOY1TBwInid289QdE1aO95OpFVunYRY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpennpEfOaOQ/tShj9H3TPA50knjme+k/ZfpmAhU9dfYyjucb++FC5MsEvXigbyiNZWexp6J2ucAxNLL3AvbPK0ZqwfFlkNt+9gbc4rqtrOdZX1FSi2krAe9vf84rSCsVo9P5X+PJNd7TwOFOGDrAFh2UfrFa2upyOFNjaNiL2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EiMuAzcx; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFnIwTsFVcHtk6/Emnzsw3jsEctr2HlQF7Lzpq8aUGjqFQmfM6Qz5es1/so+uWlgeKbYlTSMKTeplZwPSifayNfV8xKzkjVXedPr+C3lMXlqNiMGVzHzhR1U5aSfeY2E6jDjVH5QjrAfpnYMblCRXx0L83MrJwYCm6sOHglom2Fgfw8DgsLu1B95MOs9mpVoy7tm1pNkLIK4+oy+lINXGYG24uhuM4XtQyi/HgyOWx5nqJz6HJnIIUGb/ILJibCG4vqORiW4eaC6YzbVCJHZcUl99nW0NeXQZTb+Op80Nt7s+bQZ5DnVWHMqWaRl+WNRmrO1F7RnaLJ9xSbWaam9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDzXYUGUsU5rWnPMpM3fuWoX0fHNdEZlaC5dqxNzdDc=;
 b=ybGqYv7vb5jJzQZXFgNPhC3mRdzqS03WlOxBnAWfa4tApTkVmT/G0GLcbTWg44LUZXs9O2gfHbryH6DmqT5XxjpZOiH9BVADAhiHczMGmA+2wAxGqmrr2f9jiHe/nEEj40PoJM2MUb2iD4pME7cZ1IyIujb5KgQO259MADpxdsEj1wnZnpuRO710HDIui1bSNJPsFAHNIW6hNPZfvDQobQ4uPXek5xlys9l55d8rSrhVi7BRuWGbfQt6Ra6CyYJTjPJOJc+5K8qZ1rlityvuRBTtm0h1Eae9U3Yl80F1LPIUIUrtQo2SZZqHLQxLlLF1N5WWY14dO+CYGLW0JHiEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDzXYUGUsU5rWnPMpM3fuWoX0fHNdEZlaC5dqxNzdDc=;
 b=EiMuAzcx8MTKSaFWfen/JCXSS+zFte0vfq6OPF5SsfHgI5jDBl1/S1MPm0NpsXWin3IwwcGqGlxo4uxrtb/D3OzJ6WSKX0wM0+P4FnFmP0lJaHawkOveNEwZ8AfyHibX/sibMWBGr5jDoEtzN9toHD6hShA+RGfh2gsel8Tpr/k=
Received: from SJ0PR05CA0201.namprd05.prod.outlook.com (2603:10b6:a03:330::26)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 04:35:53 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::f8) by SJ0PR05CA0201.outlook.office365.com
 (2603:10b6:a03:330::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.5 via Frontend Transport; Fri,
 21 Nov 2025 04:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 04:35:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 20:35:50 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 20:35:50 -0800
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 20 Nov 2025 20:35:48 -0800
Date: Fri, 21 Nov 2025 04:35:38 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Propagate the error code returned by
 __modify_irte_ga() in modify_irte_ga()
Message-ID: <ej73lrjkvqxifl57br24ml3vpswregvon6yqikidnxxyhezpu4@lthcodkjmvha>
References: <20251120154725.435-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120154725.435-1-guojinhui.liam@bytedance.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 006b8937-e02d-4942-4769-08de28b773c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H5lD5g9u5UsPew2En8FK2ns+kafcurpLD9dQtLwoYfwQ7OMBaEQy4J632R/h?=
 =?us-ascii?Q?ys0zo/cUWLsb6NDthShtpfKJJ7B8/a8qlOUIG1Nd8R2mEgA8PGGdv0Za5RMW?=
 =?us-ascii?Q?k1sBMTRwp2ubTpyXtRWHmY8epdj0jAxWhgFpEcXgKghhNswQnhL76hIRBkxj?=
 =?us-ascii?Q?Q496eTo83XLc7LSnt6LdnqMBL2bTQYXUjOKUZ3eTZG88HXp8z4+OJ0FNk4nm?=
 =?us-ascii?Q?Qj1J2SLYmgzIysCjobXwxpqBic3rN4svAk865UacPXk7aYlsF7z9IOVu9TGp?=
 =?us-ascii?Q?894XiVW5mSzu4MDP1bMAP/bzmrc3IQVr8r6B5BYhBmtfNi9Twthl/lc5+VM4?=
 =?us-ascii?Q?Cqd31ijcDlZyq7Y26Ho7055wMM7UEigJuMhK4+DWSGduDit/omqwmDx9ne+p?=
 =?us-ascii?Q?+4z0eAVFZIm+ZPrC/lCjeO34xB3p1UM/VVGFU4wESX9G/35QauIfZK7F460p?=
 =?us-ascii?Q?yQarv8bWe9kQwcPpY18HGxlNaYIx+A5ADSxULhhb3cipPst32xFI7f2+8tG4?=
 =?us-ascii?Q?t3QMBBNCbSq/5zB6zcPL+utwi612KioYfoBOiqmcoaLOj2Qr95Y65YXoJSHC?=
 =?us-ascii?Q?gaiZnRp6jp8PlbyG19o22/6YzlnKgf9CCqyqPqNh/sBaef96D5tpWzNBR3k4?=
 =?us-ascii?Q?dbB3yqSViWlAhmG22lIFz6zNGccCjN8w5QmOTfYrVyLRrBFxS0wSdcd3L55o?=
 =?us-ascii?Q?JODYZ2RGjXcfsjrVF078qKLnzYLfH9fQtfDkDLqisbyj1nI4D/ItMRoCDfyo?=
 =?us-ascii?Q?8RQG/32aRBDe6MLdjb++Un83a8byO3ztMNFVtvoNbmNH2Ahea6ia9TuoUId+?=
 =?us-ascii?Q?ycs/IxEZQKrNa0igc9BcpZwm4fLWJPj4egu+kN2UrY1LMiRJoUVh2CSpphoD?=
 =?us-ascii?Q?X2efTF/CboWM2N6k6xRlHcKot0OmPIaSCsZ+9445q6k+LH+/79tS4s3UISN0?=
 =?us-ascii?Q?SBejRhrVSHAeRGEDFzkUWkz1HHzEiMw4CVqNV83raf36tPOG6VbtsZie2mpU?=
 =?us-ascii?Q?um59O6vFaekz73o5W9K3Wv7/1/9LN6Sh4a9bdjusSrsZiMiZoQLyyFO9Sm7U?=
 =?us-ascii?Q?GgpADHmS0/O21Iv+4/O+o6gADHBZ3PDbjhpicAPvfXUL8K7r4g/wamlpVPLc?=
 =?us-ascii?Q?O0WDXCGDX8DvVb1hsu1Fdqd62cHfPj+Hf6Dc6wNfbrS5tGrqkQsaeGkgpDPy?=
 =?us-ascii?Q?5Ewy07eZmi4Dn6QsCgqwj1atOIJLg7kjKAhLATYWAKh/lvsEx8niUs8BHI+8?=
 =?us-ascii?Q?zNEFUi+UxaqbJx2JpWXkRNrwGzDSZkWxbCLvBt60bK+qDBoDQrrkvzosTF2U?=
 =?us-ascii?Q?pSqqYBtEgCl/FPt9VGVcNUK7iPU61L0gW5O5yGB+AL2WiI3qFwNpcFDHD09d?=
 =?us-ascii?Q?Vgz7BG+Q6+196xM7cT5joWcEC63D9JF4G7La15DayD8JVEqVzj7mXePbHLBY?=
 =?us-ascii?Q?BNY4cQklYYA6UbzEi3Q4SeyTK9JMGRdaa52kxg6ckxWDW4jfIjXuIRiAjNzP?=
 =?us-ascii?Q?5idIzpF3s/XKFKMNWJTt6p3BlcUqKLknsST6gPTfDD6vwdo7+k/DhnjbKC8d?=
 =?us-ascii?Q?QHYCtnXCjGomwhIjFCFFOfBtxFrIeqaUYKIYQHEU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 04:35:51.7164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006b8937-e02d-4942-4769-08de28b773c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901

On Thu, Nov 20, 2025 at 11:47:25PM +0800, Jinhui Guo wrote:
> The return type of __modify_irte_ga() is int, but modify_irte_ga()
> treats it as a bool. Casting the int to bool discards the error code.
> 
> To fix the issue, change the type of ret to int in modify_irte_ga().
> 
> Fixes: 57cdb720eaa5 ("iommu/amd: Do not flush IRTE when only updating isRun and destination fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---

Hi, 
Thanks for the patch. The subject line exceeds the recommended length.
can you please resend patch with concise subject line.

>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 2e1865daa1ce..a38304f1a8df 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3354,7 +3354,7 @@ static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  			  struct irte_ga *irte)
>  {
> -	bool ret;
> +	int ret;
>  
>  	ret = __modify_irte_ga(iommu, devid, index, irte);
>  	if (ret)
> -- 
> 2.20.1

