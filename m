Return-Path: <stable+bounces-166728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FF7B1C9E4
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C254C3BD625
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DA299AB5;
	Wed,  6 Aug 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQBR5mmv"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A284BA34;
	Wed,  6 Aug 2025 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498561; cv=fail; b=VU0FheGuQkJyCwUrPTHwgMwzJUXCHvxOf8EnWO3yYuzPI4TY9+KpYp2v/s+T1CAjmurJt7n/aSiqgbFjjYcIfZDG6pvUeKBD65egGXwwd41Qub5KsfY8PNzOWSN4r1RQ8KyFcMUEHN/D62yg/v3ah8XXeWcqWCAKus3lk2xzpuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498561; c=relaxed/simple;
	bh=tHWrF/L+7oWpptByGdMN0pawumHXzM+76bD9La3sOns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IKMjeNtAePAjqHXBpqyOSqFkuJnvuI2bEpzvD/U6GYoFCnTpmJe3TDlxvN+RMbMjuEzIDuEQ+mDr1VwGtkmD+hrVQLtrVpDXlnp9+zzGhg6yAUsZMQh7iIal9nDGR29s60cXwWfBA6sCg4sInGj5BmGWjb1qLnrhMUli9JJ4cxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQBR5mmv; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAiIIzh8sqoM3Auw8+Lw/hS2c9EvMH8AJphAj41fQanVOAFa47jYdm87QMJOA+Ot9v2+x+t8h8/aJBI7359UTICNfV3e63VVw+BIJuDGpm+dFgWudPzW/+D3Degl099nWL0NJW0Sz9VInAdPJn/dL9iw0RWmknlUtQKjzUuquGAK+RTtThT3Dv5QaRaK7K8m1aha/mGoagSX6ofFsuzVWwQYtY06sEdhyRhpNBY+nZM0MIJejIoGxtX9X58nejAp8c1KjSbbMKK60/hCZ1rXGroKrvvUyRRXF2hATzdo0UGUxlaZgzRA/hEg+nAEwSs8lE37X6RI1OkGjyM7tdW/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u01+tCJ1HWCJDAg53MmnFJaugYd+uqCCynzAROisvSE=;
 b=C3SMRWR1PFmNhUWQm1NMyvQP4j1bzIhCto6KqxKPrBj7YSmk/jELr0x/tkn/Sfxm+QZ9Ct5THlStLfR+GjVYeWchdgPnzAhb3+NUFDdqy97tqSXlUH1AweEy5d+qq83yMznhEYBbURZamB2qMm8Cah0I0QlE2e8ZcxEevyDZppyRnAnMqWbWrNxr5f7uF3wNNa1LUKwXWnU/RrxgDehdHjwCU5QhGN58lxBDzZ/tBT3N3sbjH5XLvHgXRcmakf9mm+BKKeu7i+7opXDnzXSZI+gtfqUpnKI/GbRblNmDYNUkQXunMvzUE0Xemlb/Ka5fmErLF1C+hkLZ51E9aCUjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u01+tCJ1HWCJDAg53MmnFJaugYd+uqCCynzAROisvSE=;
 b=PQBR5mmvzqgF9POEksjMR+O8OBN1zudaHUghOk2xabK7DPyeFYlQVkc0khN4YsH2bBvLnB7Hvj0yPVTJtNlzK5HQCI8DbaXVHBOmlsj0ZKUyfwK0/eB7COSUKY60/XPqbjB1/ZhdNSn1hBfk+2ImzwlN6+Cp5ZlrIJLt4Q+8GJIOMEJ0TW70KP5nXVhR97epK7fBRzrIMi2v2TiaEfL38uHDBRAusCIA+XBl7MoSczAbk5kMapLtxZXe29WKyOnqtCUln2NCmxnsvGVgKVuyss7SFbRgwGZmLz6FIbBvlJBsYV1riL/qET7Ae0qe2WftpzPHx58PXQCUUszUNKG2GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 16:42:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 16:42:36 +0000
Date: Wed, 6 Aug 2025 13:42:35 -0300
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
Message-ID: <20250806164235.GY184255@nvidia.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
X-ClientProxiedBy: YT4PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 2098955c-dc5a-4b1f-0017-08ddd5083fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AM0YJjrpJUlBzq96RaqgKQ5Dnka0lIMOLo7pdEh7PPJI3Z+BiJPBKYbmZJ1s?=
 =?us-ascii?Q?FQNk/sGc20ohVyy5bf/wl4gSFJX1YekguZg09Wx+F3gBFpWr1DZ6nJkOO2bK?=
 =?us-ascii?Q?HIjn/ZluKFZC2ereUDZxS0XjqQLdOl1wsLdEkB8HyD+YT/OqjDb5nVGGnOzO?=
 =?us-ascii?Q?X0M0/gnn2DilZecCXTFB18LI0/oWCkxsAkWvRqRmMzovXspcBAgeuuRJppd9?=
 =?us-ascii?Q?kRd2Jmavlnf9cQzjU/g3FwYRWirO11h/ayhITxxTBbKWgJlefqylhlzI2FLM?=
 =?us-ascii?Q?5BtJAZaYalAp0/vTfEORUBAtLYlHkdKfBPU+yywapCD3LYfdxw5iqi/3bA6R?=
 =?us-ascii?Q?U1D6PqmC+UofbMyTHWDBEO/a1ZoXUrclKczVOC3IW+D6mTuaunYcnqCgulIQ?=
 =?us-ascii?Q?PaV+CAKXtPHDPJItwtq7EZMGwsGYEj0hDB0aNRCa94S5Z6lQ7EBokWLo2yxq?=
 =?us-ascii?Q?zx80DgZCUiUYGPg4ZBlpKP4RCGXxHcLmntQLJyt7ZC1nRSXvMeaogtYXrYFt?=
 =?us-ascii?Q?+PrmZyHPGbtx9jzkG2qx5m/iLWhT9anPIsAOtNLlJIDH+UoAfKj3UMuJDmnk?=
 =?us-ascii?Q?Y843Zshzi5z2PqiIm0FvvPWcnlVU+DpeFtyx1TfdkF8cM59viq5O1Ac9uCAg?=
 =?us-ascii?Q?J9UyT6knumPvnQBJOsmwGStNLBc3x/OQ0F57JKRbxDVuCwIFqrg2stOCX1zH?=
 =?us-ascii?Q?DCEik5u2WC6CWDP7emXe/R6oQnHb1AIZKYeR3horhRoqtxhi0zPXT0HYbz8h?=
 =?us-ascii?Q?xPa48lvNAINahfv6qZFwcBAiNygKGSwnXXbtVQVUQKru4/EdUWrxCLguAhEz?=
 =?us-ascii?Q?XiFPIpTyjKg5QCO/z09COLZWvxHPEIojeMWGobHgXoZt8YS/F2y3+7rjGce+?=
 =?us-ascii?Q?eqC185ms4Zue7bAxQuJhwj9uu4Pf659zf6MAKL9yLWp5SsCZy1Tp6x1uJNrV?=
 =?us-ascii?Q?JJ0B38/+DJr+tf+DGNZb0BH1JZumpwQoetAUygKf0flV1RnKbmidHK5aJ+u2?=
 =?us-ascii?Q?xrEO4ohPZPhIUT6KpJD7ywo3mpbg6OAG5tlEbjHPQWUcxcXhilyVfDTjUQa/?=
 =?us-ascii?Q?Q/Sya0T9r9yeaaA+ix93+g/CbpwOmkLJTVg+FYwBAd+J4/qonwWSGJ98vS1j?=
 =?us-ascii?Q?ePRLzKS/42dkCfX5UR/Z0quouHUhU+3I9gScDhONUiD63OLqTVHWcICIURIf?=
 =?us-ascii?Q?zRQ8b1TdrPqKN5z5/91NwcpbSvZ0X1Rf/pd6YvVediMBTDkQdWCXiM9Jz5QD?=
 =?us-ascii?Q?MLJYCGUDAQ5FcuDgSGmZ9E3imLpiekEak5fs6Fcdm9crXIz5JAvcMvhFEf3j?=
 =?us-ascii?Q?3avyumbDrDH0xRwCXKgSNx75VHGgEpiESkt7Gi3RYj8Qa3xZkr/p76y0nXNW?=
 =?us-ascii?Q?EVPCmzYAW5Meg5nN8e0xPLB191Nfn4WnT0w28AepiWUyZ5Ckzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zbenT9cVEqyvkg21QMIfTFCczZSXIwgvLg3NCaAOmqgJ8zzoB8iSmouYdZ+B?=
 =?us-ascii?Q?CmqHktcKp+SxI4wxX3R7rVrilUG5RujpfsukNw6vcVS596N92HwrJvi+VZ6V?=
 =?us-ascii?Q?6ESJE3lN3eb1m/w8H/0GPT++fDaYdhJDto19HzdQAp4D94MpPmrRYYf36IL4?=
 =?us-ascii?Q?E3bP1BxhFhF6ZjDa4vaSwEysS9HTsqyjnMK6mZYPM4hRvJWiQRbGHRZbbTu/?=
 =?us-ascii?Q?oZvD63redgKzAWdqOf74dMzNXcz6F+mf6qI5/909TWxw7uf6xFYpYc4XPBnX?=
 =?us-ascii?Q?6LRic3Jisd1TiZqCs+9E893e9oywjyK85g2uVhUh9I5LvAm81E4w9LBrFMtR?=
 =?us-ascii?Q?72Q2jyvYWcJs3YNIDsMGDFUWmQirzewXf58h11ZmHeKGB+VCv7gyXXZZ34k9?=
 =?us-ascii?Q?wjicv4B8SaAkgTIj84zsvth3ltbFpNIaTMvv3gJUpcm6EmZQoB0X5PQCcKQa?=
 =?us-ascii?Q?iJTXDxED1svwpqmnu0N+K81RvDnVE3iimQa0c1VsxauM7CehhMQVPEMKzWVk?=
 =?us-ascii?Q?I7CvYNObYZ+W/OsueVz8PWJWXiB3//YeZfL2302CeiNYyy69ry/vyLwp1Hk3?=
 =?us-ascii?Q?DgsNJSqE7Fij4u+jADkF52ayk6jlrx8vOIgMIxykeARi5HJVKC+bQxx1w7pW?=
 =?us-ascii?Q?y88vPr2/g8KksVYXOBk077qf4Yqjs5/xM/fBv6dtOf07zYBWTVlzilmzjeez?=
 =?us-ascii?Q?Up/16bCWaBSbFpChBHz82dyNOpVe7i3neWiBFNXEraq2Kj+Yz2gsnOvZIxcc?=
 =?us-ascii?Q?bttPRxTHmH9EAfu+8TfD8MtHxiPEImok3d/pZ4PolrQP/XSwqykm2j3yaXFE?=
 =?us-ascii?Q?DZfjHyf0juATuvabDewjUsbVakZmOxERXs8BKCV0a26d7L6x1CZJD+vFYi/I?=
 =?us-ascii?Q?HKzRxSR5+8/7++cclvYrustoUvGV7mknx+z5l7bO7YD6LWR1yEuYA5635odb?=
 =?us-ascii?Q?/HDM9NTgp+1HZbddQ2A9Zl5GzvsZjWIVuXMfQGNLWdH3NdDbQSmZZb5LuLNo?=
 =?us-ascii?Q?K1Z4Bil9AC1Vjs2bcS2blWe159zslKraG7925ELnpx5Gjmp7GHATE0XyK4tH?=
 =?us-ascii?Q?ZZ0aJX+kFmmCe+Y1gKbDS5hwl1c0b9rBWeq2H+wTz/Vy2qbBnOJhp8D/ytBP?=
 =?us-ascii?Q?e4rXzGE+pAMG6KIqN2o7ojBdvhY+xYrVBD3Do0IQOW/yf1+x1K0x8mpy++2Y?=
 =?us-ascii?Q?Ozh9OFrzKB7ywoKogtyPYzlqNkzIdGV02oFJ91+g3kypbB0yXuIj2aRXrOGc?=
 =?us-ascii?Q?x5UNG10GZgt4l6QodgkL3YKNMFQgnS/YkcGGfuwSRSn7C5ISaBDECn7+hgBO?=
 =?us-ascii?Q?E96RxEi4Uvjraos5r9w5XjjTosn3Dze1whQEB1yHHDu3AxbCJpu0sc7izzFS?=
 =?us-ascii?Q?gdLwBbijNPT2bAn2oKgS8CTnnRuZYbPMpwSme6cmUl5Hg4/10REQKq+FxQsp?=
 =?us-ascii?Q?4AhTQJlGY+vmroGJUDx7t7llAcadUhuggZZS8UQw41RVHWlFTY4siL5oGojV?=
 =?us-ascii?Q?q22PRiUw60w9cnZUug+Q5dcrbJ+E5UdAUbY6erylW83SVyYrcqoIWbWVueKU?=
 =?us-ascii?Q?4tUqrpAK7JMgGuxPa9E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2098955c-dc5a-4b1f-0017-08ddd5083fd9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 16:42:36.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfTyZbKCJq9tquQzh7hqbXHcjf+hFF2mgyq1cMtfxhjmVN9pQJKg3VNDEeJh5rhw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196

On Wed, Aug 06, 2025 at 09:34:12AM -0700, Dave Hansen wrote:
> struct kernel_pgtable_work
> {
> 	struct list_head list;
> 	spinlock_t lock;
> 	struct work_struct work;
> } kernel_pte_work;
> 
> pte_free_kernel()
> {
> 	struct page *page = ptdesc_magic();
> 
> 	guard(spinlock)(&kernel_pte_work.lock);
> 	
> 	list_add(&page->list, &kernel_pte_work.list);
> 	schedule_work(&kernel_pte_work.work);
> }

Oh, OK, yeah this can work

> The only wrinkle is that pte_free_kernel() itself still has a pte and
> 'ptdesc', not a 'struct page'. But there is ptdesc->pt_list, which
> should be unused at this point, especially for non-pgd pages on x86.

It should all be ptdesc, so lets avoid a struct page here and use the
pt_list instead..

Jason


