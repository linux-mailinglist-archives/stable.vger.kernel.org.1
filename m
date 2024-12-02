Return-Path: <stable+bounces-96126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 743C49E0A95
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2BCBC735B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708919E970;
	Mon,  2 Dec 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vt3vIgxc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0701DD0F6
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157351; cv=fail; b=rk0JTCuMQOTI3KIEsy8jutxW5xiu9v9ywk9OhiMDJrIw+qGYKG87kweI+93eiuYISaDVuWf9Tg5vDhSvtYIHhxGgx/EGP7v6ouKQI+z13KV9dt12trWd6vU77nrQj5sN9Z+94T87bO5wzRoAkNNoi8HQ7n70kb7EE/HE83zFOXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157351; c=relaxed/simple;
	bh=tr/ugYiqJnYITPr+oSeMTFudp+SMiS0Vr/3tKFDWJL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ODcM6W8/4H9+PGVk2UmDMKEmXr03q4D3xFUnFeV2WNxLQmO3CeT5HwqCxqx9tNnY9QgosuhN4u0vd+I+xzq6AUFl2QPNwS9Pit3Z7hv8Fi8qU4JBvMBbyj4t31nUOy6owJYrdw80nReBCoKCBK/29yzUC8kkz85zpQPH2MALxpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vt3vIgxc; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733157349; x=1764693349;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tr/ugYiqJnYITPr+oSeMTFudp+SMiS0Vr/3tKFDWJL4=;
  b=Vt3vIgxcN61XMx9aUtG7FYcQwObfSh5bPMkzmaVUnUOAA2H/hMyyivnc
   AePAravyaQ3w41YzCy24Fh4BDl6TmbBQxE7cqG5l9fM0nTo+3QtYlvsFv
   p/lwEGVmT5QCCkKX7ZndI8H+eeSIzgTNB9qbxkMJ4f0/MzUcUc+KHMlZr
   /UUUVMsCv0lWbK6Uob/AhZj0USojyN5uvSEQL1McguxFc1Ge4h1LPNBDc
   c0aO9vPgFx/lFIv05E9C0esv+IpyelAYtMKuwOaNQFig7tGv28d1WPU7V
   hu32B2tmpdYl+KHxTxhB6pm5ZFeu0832SJpWXGR+2VlCMi5ay9rmCb9qK
   Q==;
X-CSE-ConnectionGUID: CKnkUPlQQgWugoBrA5ZuRA==
X-CSE-MsgGUID: g3ysFUjuRRCYh9A3kZ9XZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32691156"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="32691156"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 08:35:48 -0800
X-CSE-ConnectionGUID: 6BLCEPw0Su2ZFnaiyNmZmw==
X-CSE-MsgGUID: TT/HRY1oQbaCnkeQKnL5OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="123996811"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 08:35:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 08:35:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 08:35:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 08:35:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7mAeecX8wT+VquihJezfH3izOGGXV5wyN116Mg3zpYR2o4H6ZPMWNtmSWC19OgNZcQ6O3HgEmva+5GLFp4S8YkoZSRUFe+sxmsFFvmyEt4IcV0oSbTWXXwwkyvGqBYsb3GVIim+qctqBXNgrb6Dhd85Cqy8zS64sraby3qk1JYL4X0CC2Uav3fodEwS0TjwoDMPhmyGUJlg3OUHQJFaAsH90E5KhJSseOIWT2hxbl1B6UzO2n2xTtCF3SqBFjZNkBlTXHnea8DVDTWU2GlEIDiON8Dnq3dJDWF/lanxNHYKkb8q0q/zTy7VuK9FeFb/nrxMS8BVlunc7e55o8Ivlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+zUzF5GtEgaEN4tUEv7+PXPljs6J/hknAKcUH9Jfao=;
 b=x/IX1xdcFticiZWDQHVBAlWuOiLnEex6U6i10IokI5pVp/irGA9xwdeP/6TZe7haK9R8vZmPgBUOuz35kiBfAid5JYfnaesY9R6pJmMfkg2pSi5nxPmZW9kWr/baIiCfkBGTEjHTnaNPnJcOOea45c+FjAykMFHXuXSCPco8SSFP5/Z6PJhcWfI0cQt1+GrzRmp8qZATep2eFOAfFk6hZbvkSwrVmkaNtF+tVIbj3697AcEWR8q29ohDhFyCX7dKmflKJYdOeZn9SUkM7ICqsVp190Pevt2lsR/i00On5KqQMBC2h+ZbclEd4MFyEDeTDdVKVgyEz5LIpNoZIj7rwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by MW3PR11MB4636.namprd11.prod.outlook.com (2603:10b6:303:5a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 16:35:43 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 16:35:43 +0000
Date: Mon, 2 Dec 2024 11:35:38 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: Greg KH <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, "Suraj
 Kandpal" <suraj.kandpal@intel.com>
Subject: Re: [PATCH 6.11 27/31] drm/xe/display: Do not suspend resume dp mst
 during runtime
Message-ID: <Z03h2spZMoHD1mHG@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
 <20241122210719.213373-28-lucas.demarchi@intel.com>
 <2024120222-mammal-quizzical-087f@gregkh>
 <i5j7pmrgftg7tiqnmffpwzpgshix3km5syndcnqylenylylrki@wuh7zdqc5kse>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <i5j7pmrgftg7tiqnmffpwzpgshix3km5syndcnqylenylylrki@wuh7zdqc5kse>
X-ClientProxiedBy: MW2PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:302:1::38) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|MW3PR11MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f9bf71-0437-4651-5154-08dd12ef5d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oJICo3KEyz27uhC1dh5n11sxW4SeA+wpVEaMlno3MdSK51c/36Nv7MZpV2Am?=
 =?us-ascii?Q?ZkpR7JpTc7R2i/CDl9UIHAapAce4lKNmM+aXlGFTmfNa+4H6hBMtFFtrFLra?=
 =?us-ascii?Q?ybegG2iIVSauJSVFq81Zs4hz+g4x7VsCz4SC0jbCdqwehdQ5QLQ913F/NlaZ?=
 =?us-ascii?Q?EouAxnlwy1YoCu84L07AEG9FEsxGQR8ffhryiP5Qb9ufZpapEC7V+j9sGKXW?=
 =?us-ascii?Q?jmode/80/gq2vZAGSaviaUr3LLyDzlLGy5e//ng4a8SoSKg7tXhKcmfKxLdD?=
 =?us-ascii?Q?DM7jwDQfnhZ9voPHokDr6wlgT21uUQKBowybmLPxtlM25O9+XbmSEGETZku4?=
 =?us-ascii?Q?ABRV/4EJnJpdPFhn7213DIgdTFxHGeHmhK/exJo084nkgAhxsW52MscecEZ+?=
 =?us-ascii?Q?UJizAgWisL0JmHgHVXbUsSjKb+6TL/Nk72fuoyqgufM7qYI4rXMRm6aGP8oz?=
 =?us-ascii?Q?LaGMwLMwyiHmvFgvXpgMlZyQigOZ8RUoiiAj3BLW45OZiT6Xo7OD0UHczAGR?=
 =?us-ascii?Q?ZFAa5lWEYc23IUhE7O4TIZUKIq3Bcse3wRJ91wFpC8XPdtG1kvp3WhdZ3Q9T?=
 =?us-ascii?Q?8/cnnWcv150nQ2QthpKUzu9hziHGkl1AlaXPLfaTvt7eslldGrejSUauDor/?=
 =?us-ascii?Q?bBu2VcDosVY/yiRskLq8tfJrr2IcgNf69BRO06aQOU4TPbFdq7U3gf1eGBcc?=
 =?us-ascii?Q?FLI3Sing9wQPbhBpj5mXh6WZq/boxXzIP0gkstThw1aKaADdtQ19+ekAyIX1?=
 =?us-ascii?Q?okIQH5jujM6yc/B7HH8+JTLTSf+uG32qNIxrg1fe+UP6ty6rrvlbECZPx+Fs?=
 =?us-ascii?Q?ca3D2Lv3IaAgF+/8HD5T5qG9wRkKNU6Qhdkn/1LC+3zAnJtlNOncF4KTBrkf?=
 =?us-ascii?Q?J9iXbilCurngXSY/2ASdxZYqCW7zFOsEVvDpMAsfbKlS+/AoVfVbnXsowTZA?=
 =?us-ascii?Q?OuOcl+ahQLKHrBLGUh6AuVRBmNypPSFdVm/Q+xu6/1+d6JDP09bALZWQ06i9?=
 =?us-ascii?Q?X0g3emEACoR/mBhDs2e6fDJqo84HBv3dlAU35ZZKXxYgysWlm+Xt8+f9mnLG?=
 =?us-ascii?Q?yHcqrQiRLpJeztWYyi015BX10wXlOeLuoyGlhSWnJRq7r+ncYIU7fAi6ywdb?=
 =?us-ascii?Q?q72uS5XwT51cLn96LPFrdae9mpOHnNV9ADx1Ig5WJZ50blx28C5n5VkYxSJH?=
 =?us-ascii?Q?HObOeN+2DhQoP2MxR1d+RQW19tgvO/hyN35wZjIVsfZVN3to1iAGtRMAUKu8?=
 =?us-ascii?Q?kursiIHau2CyQfy5j+HqyrkJwcoOztic2S++yjSEn96ask6c9Ulrynj67myp?=
 =?us-ascii?Q?W/rIdKAhCKZ8yi52W0Yj8XQ/Bf5TZUNWI2FL5OExK8mH0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g9C8gMte+YPf73ltwMAtGM518DA2T+9famhXPZwedh5zVhyz0Jz8YdhAcgjM?=
 =?us-ascii?Q?TysNqElp3xbqOnLJkZcg8fhZOLWpO+s4iRmdSAIKBMnLBv9ZDKpuChogLMla?=
 =?us-ascii?Q?i7q4uApgxHzXlfSrolX4bgKWas7c+ZXrVm8VetmPFFjnBRG3NU4StZgTkSIb?=
 =?us-ascii?Q?ufzuy6J23hc+L1/GN+pwPhPP6xAvO/0gZ5SmkwVi9NJfROK674CyMybmf5Mk?=
 =?us-ascii?Q?S913i08OPCENeY3T4POQfT1kBespqjUhkM20ZvvnDYLom9uNSlLyBUqGpB/f?=
 =?us-ascii?Q?tab2Xyv5YjcZ7EHV9u7u7zMTj4KWHHadrl1Ct5u7R2aD6tTpxXw0+MS0eeu5?=
 =?us-ascii?Q?Sd1tQMxAt6eezykQNBn0NM/pEcREker+m0ng4/vQWg29rz/z6e6xBqOsLVzg?=
 =?us-ascii?Q?phqLEnxG9/eGKBFiB0i/atMEq+eJThcAlhvnBy15U93hjOu5KT+zWuGQzeWt?=
 =?us-ascii?Q?J5uYhnn3jKw8KvO1NiyzwByWHxlR5kkcQqUBGjYEKrwyKgnt4g+a62bsVf7I?=
 =?us-ascii?Q?U2qB+ULbbHJzCgCFs0LQBUyBELWgd6XFFxtop+UwY1Cg/iBL/OO1y6noX5Vv?=
 =?us-ascii?Q?XZtfXXBzDrykUVJFzXgFNHAWDeHAG4FtODfUwtPpZaE5NHBigZaavWOSgTBh?=
 =?us-ascii?Q?o80p3uGCrinlDdL3Ly49t+APKSCbYhJN4+xk4WmWNJ25srQ7WHq/O6H5vx72?=
 =?us-ascii?Q?IBwOAKc51TOFJsa2H6G/yd5Sf5JblWOADMChmS/8bxX4kLaprg0+/tWr6ENi?=
 =?us-ascii?Q?DIs+FlpCFua47tcRw9oq9gDhrq2Qhvf2FGGcw/olyoleiGA641w2pOKFhwCd?=
 =?us-ascii?Q?/FeYbeeoaL3FYlnzyTDDxEC3GqSiTQBvGlSHYgrlM4eT5Yrkjq8H8lDdP2mp?=
 =?us-ascii?Q?LviE78Jqfor1jU80a2oa1SVh7v4rT7n41nru0w0nlUh6GucSrQPfMiKYkfKW?=
 =?us-ascii?Q?g4vPg5iztK3QOLkX8ldtvhcwTza5C5ThcKgN3xxXihI5fU51rnVhEZmsmhE8?=
 =?us-ascii?Q?MnzGcjPjxbypi2nRcbQM9nWj6N5O2Ags8hLEuJS/3bj2zzTQSOkfZ7OSJ0pK?=
 =?us-ascii?Q?GO4aSCvRfL8v87bEUake1yanD7MMvfzpfw19JMJFJfa9cM0d7P7bA6mThJQg?=
 =?us-ascii?Q?wjMYI/F7PkoA0vWTmIuLPjVe1e1nKiGYeVsT2HY2B63G6vhjCA0F5z/NveK3?=
 =?us-ascii?Q?z4A5wwIpm87NUM1K6sT1RJUpp88us8AVIxcsqfhYzfIpwzm3AfbonBppHqHH?=
 =?us-ascii?Q?7v+YeNYqp0ZZIlzuiQQPOwtGibtT2kxfVVbSpUi+x6mMKPEUHLVgwdaoxj7S?=
 =?us-ascii?Q?GGgxrBXp4ROuZoYbs/2S89YL0W5UIhLgJpfTnSBtFvXXuaq9X/biAPt2bmVk?=
 =?us-ascii?Q?04NJPJqC/X1K2aLgCMwEbnz9o6B0nk9RBdVyk0kaK112lPr/Hf/efXbZAFRf?=
 =?us-ascii?Q?LxcugB6h0r2oQQNlF9D0OQx8R87ZbVaVJ33yav93du0B28+SYi3FYAgDNQ+G?=
 =?us-ascii?Q?ozPUXoBiduPEbK3/B1cPPMcoksZG2hBmvpAPMBdVaWoDAQhhAeT/P+d8qR+v?=
 =?us-ascii?Q?QwIxZUMtsFdHbI4fVFMoj2b1pOavOI1znQQ1jTR6zgWIU/2BtMeJVxVdBP8m?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f9bf71-0437-4651-5154-08dd12ef5d85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 16:35:43.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Mwqa2XzkAJwpJGR2JBfaCKxJMV2ReqJg5+LfPbwkyl8GsCQS6JoZdBVnTkIAi6sn8PUkCYP6fPTRACkaRMdEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4636
X-OriginatorOrg: intel.com

On Mon, Dec 02, 2024 at 08:40:34AM -0600, Lucas De Marchi wrote:
> On Mon, Dec 02, 2024 at 10:50:14AM +0100, Greg KH wrote:
> > On Fri, Nov 22, 2024 at 01:07:15PM -0800, Lucas De Marchi wrote:
> > > From: Suraj Kandpal <suraj.kandpal@intel.com>
> > > 
> > > commit 47382485baa781b68622d94faa3473c9a235f23e upstream.
> > 
> > But this is not in 6.12, so why apply it only to 6.11?
> 
> oops, it should be in 6.12.
> 
> Rodrigo/Suraj why doesn't this patch have the proper Fixes trailer?

hmm, missed fixes tag indeed, sorry...

But it is already in v6.13-rc1, so it should be enough to get to 6.12
and 6.11, no?!

> 
> > 
> > We can't take patches for only one stable branch, so please fix this
> > series up for 6.12.y as well, and then we can consider it for 6.11.y.
> 
> all these patches should already be in 6.12... I will take a look again
> to make sure we aren't missing patches there.
> 
> > 
> > Also note that 6.11.y will only be alive for maybe one more week...
> 
> ok, then maybe the distros still using 6.11 will need to pick these
> downstream or move on.
> 
> Lucas De Marchi
> 
> > 
> > thanks,
> > 
> > greg k-h

