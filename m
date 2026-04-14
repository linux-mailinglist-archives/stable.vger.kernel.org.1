Return-Path: <stable+bounces-237902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP1mLKxa3mmLCAAAu9opvQ
	(envelope-from <stable+bounces-237902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:18:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5973FB9F0
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E44CC3042242
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3023D3D8135;
	Tue, 14 Apr 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oRkx1kvg"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1622A4EE;
	Tue, 14 Apr 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179788; cv=fail; b=KyJxH04TfK5HSnVWVQtQIfvBVmzuA8TCkljG7YLnHXBPtRNgWUQFFrWUy/MWmiDfJmA98QlNVMFPfKLnGyX6p3iUla9gHbf0h87R6QuWIwW2z81d2cB1McMdC4AzYsGqiaTBrDJ8IuZy/u9TiqEK0zjfk8KDFXdML2/GckyvHVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179788; c=relaxed/simple;
	bh=dpJgUPGbnRTrytg8+yBGOgIozqCkzoxkl4EZgR8A7Fc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kckuitefq12bSZbA+0BeruryJiunVCBXhUC+oGJHUBgLeQOv01SVDbgbhUvadONHRYdfbHZva/caccw7OjZF34R/7dzK2Dvr5h15m1Pn9Oe3QXCo19NSIvjUkBXlX6Jtn/fsl5xAsQMHGsUZHWguwcnxqu4HNqZ7ILwoHoURE9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oRkx1kvg; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNuLJ6JW+8GFnT/XCGGrsY/ADIDgBF/D6+EBgz6980w+G+3V3cTL3ogEL4NGEt7OGECpmvhArno9lL5ztOlZ8iWd5QOHj23X1/Nzl8RPwYDYqYXIZZibI4Kde9YDy8/204nmQrELmoiy4k7czC0WtIOAuBEaRNho6BEQZwEXz7gxy8560/q+q0N0xm0eSZuWtRpni2IgKa2hV6CEbHbgsVNc25cMuDxQlJNu7q2vbw00OxlXIjpXNUQ4hgi0IS+++TEHFpuzYO+psWMNR1HVzvcw4UsGP4AfRXy1Fl9YGMX+pjElRtwr8O6Qy8OupI6ufGy07YnWXEvlrDbW6pt1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssJI1Bew2Gz5JdZ+/vZjphiUKmoewN/yghsYXbjx9wk=;
 b=B6yyH5FjP8XhM8oLGXPNzg9y87xKp3ijxk/Z2eB+k+Udd9dmBsTpXlAACxGiWkNkjyxgdzmPrDRhiT2ZjEbGslWN5ZO/8KPjTN0O9JboUqf19BNQgXciBJHx84D4HhRFBZpJXCDoqHM0CLza3akQzWlgJPxqYrp4CtC0SF8WEedozNHKadRmlgcBS0mbJLtS4iifZ6rHrDP0bVtnzHsK1YtoB8bikadGMzI/KT+21FOR04OAhJFeTCNwcW8tgLQGmBkJAIB8+KIVUqKCZ3nFYmE6tDYMbNfRXo3go3XiJmwQ2Flbm4Q6Etk8OckFiXi4L6VDHwDJN8FpwQyCp4vtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssJI1Bew2Gz5JdZ+/vZjphiUKmoewN/yghsYXbjx9wk=;
 b=oRkx1kvgomaGO8vpb9K39HHcKAhfM9b7PpDAfCVuATH/czQMaLgYDFFTIpEM4l0ZGygV+2Xb/OGrT+z6gAfEmCivorQf+CXyR3KpuwWK01PDyAXMAj+fnhVnd3bcFMeUapGMRwbw5CeTKu+LsC/Xfx+4Owli2C8WDbuYybL8hoB5+TYuFqV5OK8RxI9+ftuJ8uQxz1qxPOP+KptsdMYtd45bztDRsE25p8kPdsraREpEk+I3C5k3dg1LDhaaYWqy5jsOvAj5RGoG0/M+IS8BUmZQZUOxShr3F4l2KUmeSyn3KIWWPCUNxLDmCM5lH+w7vjexqiwlP8K00k/2nBH1mA==
Received: from SA9PR13CA0054.namprd13.prod.outlook.com (2603:10b6:806:22::29)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 15:16:23 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::1e) by SA9PR13CA0054.outlook.office365.com
 (2603:10b6:806:22::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 15:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 15:16:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 08:16:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Apr 2026 08:16:03 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Apr 2026 08:16:03 -0700
Date: Tue, 14 Apr 2026 08:16:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jamien@nvidia.com"
	<jamien@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com"
	<praan@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"smostafa@google.com" <smostafa@google.com>, "miko.lenczewski@arm.com"
	<miko.lenczewski@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH rc v1 3/4] iommu/arm-smmu-v3: Retain SMMUEN during kdump
 device reset
Message-ID: <ad5aMQprD85PkwOm@Asurada-Nvidia>
References: <cover.1775763475.git.nicolinc@nvidia.com>
 <c116eba01bcd88ba3b8ba47dc08132c4546e91f5.1775763475.git.nicolinc@nvidia.com>
 <BN9PR11MB527631CAE6281C630FB148B88C592@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527631CAE6281C630FB148B88C592@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb0e4d8-c218-47da-7ede-08de9a38c9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GaokBd6WAFyIR5hEecmBpKfqIH+5rgCbGQZ1wlqsWb/jMZd+Ge9Jhe1jgR5An7S49WrDmXhL1DjK/OP+uLAoPXXIutqTTVRwCfgW3CcRa9ib/o4K+5hG5mBbjg8KWivJ/r4RsUAnTbAOTVw3OhHiniY+v+CdZmq2bkJZds3ROz6phhv1h6TPJ+bl8AaYgI7uLrN6s00JFMFvIHZVVi/BGi65C4xLC1+uQvXNt4sEtNAt0stSaEvIjV08X3a38prGge3cmMuIrkxRMfh5dGO7dChAeo56Gw4H7NttNHBkcRUgfx1zyUs11JjhMpPlZXE9lSchOoKJOFlRsFPKgbQsNLrdO7/IkxpLTKdmxjbKEnXoZgjHDX8ENsSCpECujueAEAevCZ6uPVUGzvDbV/sEHK71yRWkQXbdYkxBi/A0bfdAzZjj5DLBCp7FnEOBE3ry1RmVY16wrVYUsF4UnPFhXGcBAhcQ+NRkz8DSrppmt7WQf3q3uPEJEOLMOpiDejWl9wP8MGYQM71tzh5nEGDqGmGSWZryj++eBgkQdFIfJldRl4GfbOoK51wz+Hrb836z3yh5Jau3v4DzobgJa1hSvQdPzjz4BZNZXT0p/+EEF22TrEqYuD+CzH4DZWXKCkpehnB0wQCRuHZoMZGlb8rq/ffiZZ6rAK1hL7ixObAk53QALXokII1Zrw1GdV/UIy28l/jAew5+yfc8vA+s+WtXz7DIbOjy3PUr69jLj2JxaS3iKc7ugN6Y49a/Y34CmiSwzB6fUhpkKKz7iJmByf/Q3w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ggApmVB4DNs9tmbpd0x3S1nBBhLFoLrTiBgrEDeGpomMWHC6mq2MXA/a3NNxrg3H1ViU8xDl3DaXCUSW6YGUWy4nRlABOEQrilOcfzvAR62iGqmAvn1xdeIe3IkGFPGl53Z+s/yorLNGcg7NxpXVrzsIeO6koSNF9pZdrIdU+ltUwmMH1tg4t8tiG64j9yANqi2q2kDDwDlqNdaxKLZCDMM7C649f0XVNrS7p4X/MPTgZAt5SZjtB2qPseNbTLlhe//njuVzRMoxYZUbaHotEAOAyNkNpOiLAvzqjUVfX73Ll8IGgEmpu/n2QULm3wWtJ04EdtBK9bLsyENvXFC5RhXjN2l1ZQYpshlxIHWH4koufSngPR+2M6WWDeiyni8mojLQVj2N1C58kymWN2dVrifspw6rm/yOCvQCaP1YMNYn5oActyEqccHVbG2PV3IN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:16:22.4014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb0e4d8-c218-47da-7ede-08de9a38c9a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237902-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4D5973FB9F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 06:21:43AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, April 10, 2026 3:47 AM
> > 
> >  	/* Clear CR0 and sync (disables SMMU and queue processing) */
> >  	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
> >  	if (reg & CR0_SMMUEN) {
> >  		dev_warn(smmu->dev, "SMMU currently enabled!
> > Resetting...\n");
> 
> move to after the check of kdump kernel
> 
> > @@ -5038,6 +5064,11 @@ static int arm_smmu_device_reset(struct
> > arm_smmu_device *smmu)
> >  		return ret;
> >  	}
> > 
> > +	/*
> > +	 * Disable EVTQ and PRIQ in kdump kernel. The old kernel's CDs and
> > page
> > +	 * tables may be corrupted, which could trigger event spamming.
> > PRIQ is
> > +	 * also useless since we cannot service page requests during kdump.
> > +	 */
> >  	if (is_kdump_kernel())
> >  		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
> > 
> 
> then just don't enable them in earlier lines?

I will incorporate these (and the other comments) into v2.

Thanks!
Nicolin

