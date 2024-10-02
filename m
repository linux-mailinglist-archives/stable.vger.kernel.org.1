Return-Path: <stable+bounces-80569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F8598DF1C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C86B2BE02
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD01D1516;
	Wed,  2 Oct 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cDB/z2QL"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FB1D0B84
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882198; cv=fail; b=d6+oHePowMq26qaM8lXDmNTJmLr6OF6VbxbgBIR0t6giQWcxeopfqcbxO2svSLvDrYmnPGcPf/0NqqmmQ2XVHkMPZE+MAoDP2MGntCMjqCfGhqzz3Um34zQBVsy1dRHD4SkPMqc0kjo4LnxJWENaM9rNYB0EJKD/fUNAhYq7z/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882198; c=relaxed/simple;
	bh=/IFKXSmccZ4wYsFxjl1UYEdPdymjM4o0slvkDxoqSBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AYelRJ8SKMTjrdr/BtA/kKYeuINSMcHBCyFcLmGE8kl+A8vpF280mG2g9Z2puf21O0HXUiA/Gr9eeQWag3UVikZ24MIaW4oyCqo9yphaEbe4Ec5gS6bgzaZ6eEJxTw69FlavVpiJKqQYdmQsZUmC9wVpz26eTQ5EGPx2Nu/+hNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cDB/z2QL; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTlIrReMSEkAImAa2cW9ksLjKn9izHHkYsY0Q2DVB8sq4+N9+iN5+IP38R4sUeNKqSDkRC0v6nic47SAS5ZvTfLbJaBh97Mz8zdzmUqEooA520cdXrvox9vFy3PY3aCuB8URhXMfcNPwoNganwlf33OqJZT7hDoYOuGa9u7MUj5ICOZkkqLGFVkhq9wgsRW75Gt2iIUyzs+Ljp9NMOoYq33GLvRUCeUQ4vGglu9e56KrEH714Yk4i3Rn3qs39Ib82IecLj70XljkXwbepZudRbf60vs/IgM3xjv2LlJj2xWh1TEjx9PSJnwKhYZ3PoFiEIbWP8zq/tfnyaXciOvBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSK/do2CPyUNwOFGqwJMbd5H0x5r0oruFpVJOh0W9xY=;
 b=Dbvf++DFQ+SRfNlh7wTA7L4to2YZxSN105OBcU1uruBs5v0A6NxKmdZunoSZafur0D8BByo9Wi/9GQCjSmqisaBoYSDL5pXiZ2PPn4EyM3oNF6qf3FbBNQtJSCiDwQaf+ZiqC49bKO3yL4izSx/7X9+VUdOK3Iq9kg1cZD99YkQe+2HLboy8duOWuqd2tJJafpxvT8HUFqMQQmHMdMDIscLg5Qjg4JF2ZY2FeKKyS+zxWs5109lcN+gKCH05i4Xfaz6K/cApLJmYfHAJSDuPe0l7DdAs80KmxDlNl2FJzGqpiGZIbWTHP4QL0RQS7mERNsZySgevltx+YoyS63kOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSK/do2CPyUNwOFGqwJMbd5H0x5r0oruFpVJOh0W9xY=;
 b=cDB/z2QLRnZtsXpRgciPlnwXt3uJZkZDOStIe9YSK7yuL8F5WmxV9ZqkSUO1pTLcw2QHARFYMcqE5uC3JPtSeaNgiNhYPcKC7SJuEEw3016qhtF+C9tYouf7ZwZEOPEN6z1x3cIpqWsStZNSJ9yY9bOBD6Y41o0MumTFdSAK3yV40k3SYQPuD0ArQ7h0lefeoVsQcTnsNk6YR+Q0icgyNP4bKadj1uhek6XBgCwyZqY7GZM/Sqtlr4Eq1v3gPthItKRwDWo4bN4PsdcktDNectcjJlGo4WcApERvcM76NMOcNwpPjXi+CdnJZ1Xa8JNdupv7H6Y2o8Ov4DLbnA8q5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 2 Oct
 2024 15:16:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 15:16:29 +0000
Date: Wed, 2 Oct 2024 12:16:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	pavel@denx.de, cengiz.can@canonical.com, mheyne@amazon.de,
	mngyadam@amazon.com, kuntal.nayak@broadcom.com,
	ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
	shivani.agarwal@broadcom.com, Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH RFC 6.6.y 09/15] iommufd: Fix protection fault in
 iommufd_test_syz_conv_iova
Message-ID: <20241002151628.GS1365916@nvidia.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <20241002150606.11385-10-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002150606.11385-10-vegard.nossum@oracle.com>
X-ClientProxiedBy: BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 6176d0b3-b0e7-4529-d604-08dce2f530fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SFb/6ZtoAM1pDIqZDzzwt/BBi8A9SsCuvLufd9X1GnwfvOewxbDyBsUNZrQ2?=
 =?us-ascii?Q?JjvB19JCzKjOS/IzHVp0tNjMqogCMdn20JqpIj0eBCdW7bLTaxVL+gElqxAL?=
 =?us-ascii?Q?cKlzguuQ3eDNwQpn1PkNps/RVC6lRHJOZw/eLEtJSwZ+Z1tnp0asNnHajwlC?=
 =?us-ascii?Q?4/bOi4P04nbVk+QIOqgGYt6o4BLbaWw2kSgOWVVgILMIkVd8KCjDOcQ1uXQA?=
 =?us-ascii?Q?AlQxIYtDi/SOlWF++6CVabdMXv7EmJccPVZBAd5QbiJUnt7vLm6f0F/C6Qbp?=
 =?us-ascii?Q?hfX/t5is7DoB5ERaIUB9wPk4l8yITuOrGNyfjOiYtqEBSGyGHUdoqPdF7Dpm?=
 =?us-ascii?Q?tqbkgh3aYCv3bFU+RNT3OxaarUOhKCbZrh4NnKIl+0kZNqdIXWktpoqJMvMB?=
 =?us-ascii?Q?TsZJCyg6VH2m78lni3yFBBHN5C+tuuIb59aYXWWRhs6eKsYek2Nh1qWjarvC?=
 =?us-ascii?Q?kgTLU+xo6AgG9pBoY9V6Ooqjs5pSUsrCpx1Rjai31Xzw4fmDH+B36SVVjhiJ?=
 =?us-ascii?Q?CziGvWRyPoKycqu3/+1FGvQmERjQCtCeke/4rT0NB23KiNowVqsm/3T/LyjH?=
 =?us-ascii?Q?6ntcz+66picuBUugdRgcl8nWu60ceJk1zGxJii2QXrbIUhpE7qJcoEnwck5v?=
 =?us-ascii?Q?AJw0pWlzTZC9INbJL0wPsbVSVK6ZpdEPhvwig5I/LGqsWfUTqSw/k/8By0RT?=
 =?us-ascii?Q?wMP5p1L2aP0MbD5pjWnxrjtDZ4xxGTbnNQ9mKH8pBKdxfP5e/A39L3ERGDIk?=
 =?us-ascii?Q?m1C0S8GuqsIrnN7OUCcgTnzmIIrHZrCl/NIamh1EIMa3ImK1uw6SOXNueN1T?=
 =?us-ascii?Q?xkqF2BUMAymAutuME8UqfRLhTwhyRdfTCNMQtG4tnnqOQzI0KFKYNwN/RBo9?=
 =?us-ascii?Q?5nojaPKK8NjZgNxUyWVAZ4bMdy8QcGzgSDut1btnw8IFupzxyUUULpYGeu8L?=
 =?us-ascii?Q?ETdS3DQPqM0gtkun6l3CBisAqABMDrDwGdoZD1rjWtZxwWpbNRlxQgzqWihI?=
 =?us-ascii?Q?MOrXkdW0SXOQ9Mt5XprNxiIrlV0XAwCvS4ofo3pE8vqN6hiK2aOjY6rjhTvv?=
 =?us-ascii?Q?o3JCiepvkJpsWXw194aADAl8Ve0dX9gjkzNGCyoNLyUIiTiiNkiHtkSXmGPt?=
 =?us-ascii?Q?VdEfTDf8Qt7LezXIbQSy4nA7HksXEyMh4jrQCBffeOajLkqNhtXsOGiSaN6/?=
 =?us-ascii?Q?RjDgN3fzM3v0Yz7L8doeoz6OTj4YhCU1piKay2fZ9rcfeIqEVs22qvug6yC6?=
 =?us-ascii?Q?qnXTLJra8da+PWaGaNEQ9SeibMsoGFpPWnUzE/zRDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3FK3Np4PyaF2B6a3DSgommpZ5XSwyLizqlHgXPBUbruYfWR042S+tzxg0J4V?=
 =?us-ascii?Q?vJbqAp6rceI8dotC08zxuemXlCGpj4DSwmykIIATB8rC1qXCQ4AmOwhVLyVN?=
 =?us-ascii?Q?Ukw4MqKPcsBob6SdWtcCVT/EnAo2UJKjdUZ7Q/NM5DympsweA4AnifKRQgVD?=
 =?us-ascii?Q?aXvZk9JDjwUXz+DdpJzEF7qzjudGnEh6ff9hLevtu8YUyy5vyIPHO8ns39nF?=
 =?us-ascii?Q?6ZB0/s5hIaB5huQeKL7yde+nhuFdXfLHGWh/08pLQcfctZeBmjERKflM/qT9?=
 =?us-ascii?Q?ZXvQiAfnaFtV9tbfylALePfpnvbl9zpZelB+BqQGjnvEOq/AL6PftFRDz9WY?=
 =?us-ascii?Q?T04wnaqn9KFdqEU/GMJDhQ3sx5dBROEVncxNPdxN1W5QvljNRLCSjgF09e6Z?=
 =?us-ascii?Q?swjtWgFy5u5byKTnMTUjuhB8ql4Sku5b1De2weuwEKsWbmS62wKIQbCtHPBB?=
 =?us-ascii?Q?Eru3WcUkorK8F1/pPe7bkmaRdGyHa8lUvg2Xrxy/iXizgawjaTNhTQthfBp6?=
 =?us-ascii?Q?xpXZ2+tSSg/Dj4H/hvwo3dserT7PUVZ9vaArr0YsMniPTgCgZ3mF0CqflhnI?=
 =?us-ascii?Q?jJ8XFlJZiCMl3f1is8at0prx71u3pd2v6dcoJzrds1IDkOGyt/Ls5qni+vQH?=
 =?us-ascii?Q?iYSic7dDNz/YE8/QAwgccBf5XLzcgT2hkM3hn5CqOUW1IVdzc9fWcQI+nQ1f?=
 =?us-ascii?Q?g+km08Nn3L0qMAkApq1RUWAj+T8RNmyVpgMx7O/xLhGRUdYb4dHNkwyWmSJ0?=
 =?us-ascii?Q?Bi+PbwrVZVqZo82U0pue2SBq9Rid0xJyFw765Qa05f3eYGIXF88OnszSQG5a?=
 =?us-ascii?Q?2sFlWtuoCniL6rQTDB//bdy19P+0zJnr1ltwehN8WZqnwlNMTrK793SoIWkz?=
 =?us-ascii?Q?IvhN18HgYSvDQuUMcdVfKpcD5r54gHH7dnHNPTSGoOFU6tNHnljmwNh8E+md?=
 =?us-ascii?Q?v3AM464VoY5kP5/9UJMvZDc4qKNkOtCNYBYiPUgjYM/HYro9AI6FUayheEZ3?=
 =?us-ascii?Q?q15ktQra7M8E4QgtvhEVv3YtwP4/gsgHHqFpTPyKloZWYFXDf0jzKfd2K8mh?=
 =?us-ascii?Q?jdl/icJtp2ZmTwLkenY8uUPolGvCPko35QKdw3nvVVPKN8Zz9oY+LbggoRBh?=
 =?us-ascii?Q?bTfmE2gllrKyb3X0Dy5Esg9kpZznp48Wkmlqp+IGRYQuVO5EpXAY1I3+/cKN?=
 =?us-ascii?Q?44TX/GApGvPXI52HU7kVO+4iPRGsaDfjb+fMKTG5oSWLMOZbk5sDsiPjt3jq?=
 =?us-ascii?Q?fPVTm8NZz6VaOVO+SFjMrXSvA0PAilUw8XlEWD4ngo0MGdY6RGpCoMz2cNHs?=
 =?us-ascii?Q?zWJ6RVBRzrknk0MMYsK2ZIMQH8OAe7BQ0P+hUF/foZhx9ddPUt7iXerdN3LO?=
 =?us-ascii?Q?cdvzH0DJRYyzHO93jVWReI6QAXazFLavYbstj4E5pz3/FuIjrAP6ehCkGZZw?=
 =?us-ascii?Q?HHQBZE39Kr1LrRPSyJYdUvyjNvAmHXttBYW+7buJd52tqa6LR1iW01Dm4BVD?=
 =?us-ascii?Q?VoEmClU+Zu21rFYW4rqg9YKx7VrmyXamdwXIBqX5vguZDSrJ/dVs3dsj4PnS?=
 =?us-ascii?Q?XywKPEdVHs+v/jyjmro=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6176d0b3-b0e7-4529-d604-08dce2f530fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 15:16:29.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1H3uxEvtzkbULMmgSk0iEPV4HEmd1tHaCk7IgAnN8JmW9R//c4IuSnxo24wIOBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449

On Wed, Oct 02, 2024 at 05:06:00PM +0200, Vegard Nossum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> [ Upstream commit cf7c2789822db8b5efa34f5ebcf1621bc0008d48 ]
> 
> Syzkaller reported the following bug:
> 
>   general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN
>   KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
>   Call Trace:
>    lock_acquire
>    lock_acquire+0x1ce/0x4f0
>    down_read+0x93/0x4a0
>    iommufd_test_syz_conv_iova+0x56/0x1f0
>    iommufd_test_access_rw.isra.0+0x2ec/0x390
>    iommufd_test+0x1058/0x1e30
>    iommufd_fops_ioctl+0x381/0x510
>    vfs_ioctl
>    __do_sys_ioctl
>    __se_sys_ioctl
>    __x64_sys_ioctl+0x170/0x1e0
>    do_syscall_x64
>    do_syscall_64+0x71/0x140
> 
> This is because the new iommufd_access_change_ioas() sets access->ioas to
> NULL during its process, so the lock might be gone in a concurrent racing
> context.
> 
> Fix this by doing the same access->ioas sanity as iommufd_access_rw() and
> iommufd_access_pin_pages() functions do.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9227da7816dd ("iommufd: Add iommufd_access_change_ioas(_id) helpers")
> Link: https://lore.kernel.org/r/3f1932acaf1dd494d404c04364d73ce8f57f3e5e.1708636627.git.nicolinc@nvidia.com
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> (cherry picked from commit cf7c2789822db8b5efa34f5ebcf1621bc0008d48)
> [Harshit: CVE-2024-26785; Resolve conflicts due to missing commit:
>  bd7a282650b8 ("iommufd: Add iommufd_ctx to iommufd_put_object()") in
>  6.6.y]
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

This is only fixing the test suite and does not effect a
production kernel where this code should not be compiled.

Jason

