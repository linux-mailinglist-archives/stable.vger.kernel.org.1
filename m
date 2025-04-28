Return-Path: <stable+bounces-136973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B333A9FD45
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 00:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759F95A61FB
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AFE13C9C4;
	Mon, 28 Apr 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2qwRiWK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472D20B7FD;
	Mon, 28 Apr 2025 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745880546; cv=fail; b=EohfwAvvCyk6Nn9n8Y72Jmi1uzewdPAwblY7RRV9dVTYzEwcesLt/pxOyQv3Jpy0dvRBRoSnPuKBqDYDrhQWgWVw56mHVHTPu71IuEkHLH4qRBetmS9vFiKtUqznFbCZnBTbSK2UNr9nV1B6SdA9LMJbpuVF0soDhip5tWZAuig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745880546; c=relaxed/simple;
	bh=XVVX0MxPE87aizcCg7B4xvnxOYTs+TenXkax22fwNSo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VfJYtTN+C1b+lH8cLSP0qfxiFbRrGwmEz93/vhdothor0FyoOiA4WzDcLZx1R2tE0UHjANv71/5xoCzTJW3fdIYrGR40K1fDWIRfTXwJN94OZ0iABfQ0R5OMAGI+BlpyIQqu7Bb3tu0ec7WZ7Qm41TGk+LUj7KNXwLKKbQ4cB94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2qwRiWK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745880543; x=1777416543;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XVVX0MxPE87aizcCg7B4xvnxOYTs+TenXkax22fwNSo=;
  b=j2qwRiWKct9XgALpqL0fNkUf+6AE3PDIPn9ZVBjFHndzSqbJv7t7uVMx
   gtmLhTWSo7Avf4s1K9RVc9UwET7Dd5euaTUodjLw2veNYfSPkJd3nEUfN
   CBn3ifuetOjR3jr9wCMSFVZlRHeXXVsF9uCqNp+swdX3aOtGD9Zs58ptr
   4wj8+4EZP7MDdfW/l5XyVSnZM+AFHOVXd3+y13Jlk34A9BnG4fXo1HDxL
   cJdshlybXinwI3L171KuT/HVnY1Ds/B1nThSfZHoApZ3qD/Jydp4A4MJu
   tsKNjtx3FRVvuLKwio2PQVsNOi772vxLPaim1bY6X34neOdu+qkjjd1Ck
   g==;
X-CSE-ConnectionGUID: PlyNWUvzS6+603amJfWgpA==
X-CSE-MsgGUID: zuzN/Ac1Q3iAWxvTYdmONQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58140842"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58140842"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:48:59 -0700
X-CSE-ConnectionGUID: O9D/B1c/RUSpFACGbp12PA==
X-CSE-MsgGUID: bdtg9SytRVOs+fLA37Arzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133372930"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 15:48:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 15:48:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 15:48:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 15:48:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWrds9ovMMXwqh5FQ+dTqVFgHbibbG3IeUlHQcROjdNzZLCDklIghf0NuxKax19MhhbHpGY3FFtF5d8JJ6/4L4TcHHvm2cqMTzssMiVjPbBZhM5TAp25WQBxP+KSezoH3gdIG38AFYhzvEwh2RnDqur76HRFbDiwKTLclcIA60f6yA4scooVuU8PH2+e89MQZ/OLwDvEB/dsMxAqYMeOPWfTnYZVkgdLBcJbCn7xyJTTFEUHDUhcJ5Q3WGkTnyrsDKiOpV7oHmkgny3DTwWfXLBKTS04z5nF/c/JLcRqAPiZqlmf09qVOAXsft4Eo/DTXEx0hX0O8OHhd+UT3bbhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2kI1FD9HP4mN3cgWgSo+X9uHJarmx1cMBsTnzBcBL8=;
 b=wSL7J2PLb4vOm85sJHFRGqhF7scyx1kLAqrpB7Zg8+3YrZetNnx0DtGHe3K1gJuvOSszSKEor0/HfaVgCueJ4ZwuGddEPpzRzQwaiLGz8iarLekBZa50hJ/vL3HEDwPQE1mhvSSbR8THBxQtWTKEGH69J7IlnC9hatlZZ/o24fgJVGO9Yl+b22PAjoJfTsUzVNPhberFLVi6Ybmhsjl0QOPhQMWjruJDlb71tG2a0CzcjXy3Zy0fVqLvM5xkdQybD2zEnPuGbgGX2MaXiyUNpqo7AvYl3cBj1L79jX0lzHVWZzSmIK37H7KQxysse/0jzlxyM96KMZZrsbalo8EgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7000.namprd11.prod.outlook.com (2603:10b6:510:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 22:48:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 22:48:50 +0000
Date: Mon, 28 Apr 2025 15:48:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>
CC: Kirill Shutemov <kirill.shutemov@linux.intel.com>, Vishal Annapurve
	<vannapurve@google.com>, Kees Cook <kees@kernel.org>,
	<stable@vger.kernel.org>, <x86@kernel.org>, Nikolay Borisov
	<nik.borisov@suse.com>, Naveen N Rao <naveen@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <mpe@ellerman.id.au>,
	<suzuki.poulose@arm.com>
Subject: Re: [PATCH v3 0/2] Restrict devmem for confidential VMs
Message-ID: <681005cdd3631_1d522948e@dwillia2-xfh.jf.intel.com.notmuch>
References: <174491711228.1395340.3647010925173796093.stgit@dwillia2-xfh.jf.intel.com>
 <63bb3383-de43-4638-b229-28c33c1582be@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63bb3383-de43-4638-b229-28c33c1582be@intel.com>
X-ClientProxiedBy: MW4PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:303:dd::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f516e73-e5d2-4dee-7275-08dd86a6d7aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dmQQYloO1MZrWpCpVRf/GZe4CEMJnqoVjkq+sSScG6qPvu36HjdGyuYT/XiG?=
 =?us-ascii?Q?xaTC1jYTlbwY2KSV7Dgjikxag9nNPvPq/t59ulYGArzzhDG6xy//OSuKZMMh?=
 =?us-ascii?Q?p4bSgnQrVqFgU/cBSez63hA5CDamq8aoeeAkxpdZ/ZFNWDcoXEXJUY1xVQC9?=
 =?us-ascii?Q?X77wYIC4/1KbC7viI2uUHZ8dA548Cmaeqi4PI3DaexF8Kwj4UKcTarERJvgl?=
 =?us-ascii?Q?yPCVfRqYarm/51QGObR1izX5/2YP6TJgtwGlIwjQw+1D66Cp/kfhu7KdZq/a?=
 =?us-ascii?Q?fGHhPWuAP7gUQ3u48BUVfBDz80NBCqZcdxM92+LoqQ/i2NCWwRLfR9gFRbfK?=
 =?us-ascii?Q?YgLipfu6bPsNqK08FvKuARnfkhqcKofzbm3/1Bk1T+AYOs98LSEF+dDXcifB?=
 =?us-ascii?Q?Kv76usJSd4RNMOJtTQo1b01/97YFJv01nX5u+91KTf2RQfEQ0MTS+3j3SuGI?=
 =?us-ascii?Q?gU/v6/mH4WSX2XwEcIyv4iw7C3WvojrayPLMjISr2tqWyC8fo+zCHqj8RFMY?=
 =?us-ascii?Q?vZ+fvbL9qCr1WWXowP+W4qT4JV0NCd76ukY7QxCtcOBh6bOw0ESVwFEn8odJ?=
 =?us-ascii?Q?qtraHshNzgAsCFYFc3hRmup/Vcec7lNL5WNXJNCuPFRYxP0uBIaKgJJt1Qn4?=
 =?us-ascii?Q?6wWrRfBFqjxJfIjnh7KAm/yWrO9+yLXPs4wnFw791F+GVL9CHcCI4TQqFV0p?=
 =?us-ascii?Q?M3rBorSPasNZnVaRwbB75EFoNj8BWCfHt+hV6sEQ3ra/RBIqDz0Cb3HDc54O?=
 =?us-ascii?Q?IldeXgxhxM6BHx7JunW1Szg0zmlofPzFeB5vccZDfwEaguhFCngwQ9lCT3q5?=
 =?us-ascii?Q?nAg6UrxkY3iFJjapxeFRTDdN+V/z8HLwVjMZNgwj4RpAzrMiluJ3fLIWT2Lo?=
 =?us-ascii?Q?MJ5K5mziFvKOI59frduLDcbDFZuQHZKemF5xE/3cFrAipzVCwMd0Uh7hBk+L?=
 =?us-ascii?Q?T32Mn9vYINgGapJGOClCbnD5Ya8pS7YXq81RIQ/N+TU6JNZu3d0HE86w0lSu?=
 =?us-ascii?Q?K9I9sB8rngkAOQn2I9wdsYr0oDG3pS9zvJaLt8olzlfXasJth0UmCpfsKrXi?=
 =?us-ascii?Q?2s+5L9VsonsGKZYYbZPE37wTypYrfodMQchCxcjv13f9aHaTDGykuKmyuK23?=
 =?us-ascii?Q?ZZk1CQFJ5fHQvxPfDrhya8BI6f8MrNIC7CF/idMVE0N+Fl4we12++Nw7rHTo?=
 =?us-ascii?Q?wyWU//YtxQA9qM9WSxyMF564ewZG2niixXN0iHEW6IONQWQGKqNhTN5sZZiE?=
 =?us-ascii?Q?GMqrISB1+bblbGKQZZ4VfaEf9hCkNatI0FM1JlUNJjFOmrUS4OoUKnsa8lvp?=
 =?us-ascii?Q?qnY1W8CTNzqcyteTdZXgZVn8nSiEu3JeUKRCpxJyZIPv0aeZPbOWnWUOYKKR?=
 =?us-ascii?Q?Fa7r02EpwrMHpbuQ4JGv7WGqjDsh/jcPwIxF6Ga+bUJ1HsxJ1P5I1y3GLH1x?=
 =?us-ascii?Q?fw82g8A6VAQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cce0mdFcRW7YumI7OsAux4HZ0wWY13h7aMwZ0WTmqFwDjhBEcEmLuJ3r8ME?=
 =?us-ascii?Q?9b6GjQuqgW8x/6VJLuvaZmVraGk2OI+jkBvD8S/DXWd5Bu0dK6G/NcMK9bO5?=
 =?us-ascii?Q?1vqWcpAnGJUd4PgLeorFTFkuBrxLFz0/MnSTWEP5pSZghcPgWavjV5braFCM?=
 =?us-ascii?Q?fDypEfMeAkLAp8GgncYpMKqVHrIYxh+NpjA0TKW8pvDXFUNgIP+PBVx0xZ/B?=
 =?us-ascii?Q?TlVTVB0HzHI/799GtT+aXmBpCxyxf4jyOaMxcZS6xtcYjFXARmp+SeE4Lmlq?=
 =?us-ascii?Q?gEgdIwl4Z3zNJgy1MbfwSwOEQKDHMq3R8SpRXhXr/GWwvr+zD8TCTypIRTVz?=
 =?us-ascii?Q?RbSppH/ErheBwlDnQ9XscUYdgW2nPYjUzTPIOYOSmzykriPrRPiBCEx6Akzf?=
 =?us-ascii?Q?+FxxgX8EIQvN1jG+4fdz+EpMmBglfc4O+uZM2feaDm1rYH+b3HnZ7A1ER/ug?=
 =?us-ascii?Q?jw8olKZBl7vrCRpmEVPsy+aXPJp+W/Sb5/xGAdStlviqzcDSQGCXFXf2vQXA?=
 =?us-ascii?Q?ogeSc+5hicj9CjH1Ijj4ny/4/XO5E7VzlShW5wX45URxQhsMRD3x/z7GOaK/?=
 =?us-ascii?Q?NrmQtT0LRoxdV5+CcC854ZuWmmFwv2taMolN49e57eDKVPLAQMhBnyKRsgS1?=
 =?us-ascii?Q?bCKsZaLP6k/QZY2MPWdbPzM1zQ+vlXlRD1okT69HJmJsLPvbXKQFKxxlcW8p?=
 =?us-ascii?Q?pTMc1eRNlrLR4US67tSR/uPzwKzQ1JbN6Ur/0ncSiR8fC30QVj+JddioJThm?=
 =?us-ascii?Q?0axGCmAMZ5cBrJ5/USTZ86XGbwor2eMetMX2E7ied4vwbywUjxuNnEOs+J4F?=
 =?us-ascii?Q?U2YvEAx7rHDbPbkhHitbt1OLU/HFwQvXiJvzl7GGeRMc5P6ndapT4DdaPQuf?=
 =?us-ascii?Q?8Ws3oc3Tbly7QzOGiBF7V7Mrgg6/5sdWpX0SqQyRUGMd7irL74ykSgT9YFK/?=
 =?us-ascii?Q?+V3Hpv6zTo8qLI/kgBMtjZxbYMLega0ZRKKe24Yzp8On2RQJxP3m0eF9X50Q?=
 =?us-ascii?Q?5LUFRz5C3VqVZ0we4T77MKApf9W1EPDKvvdOSa3aho/qiOCkSTY0cVH2fNtH?=
 =?us-ascii?Q?1YF+3rATcuVcDKMAkK/YPs5cIRwZUinWbd5XTsSJ9Vb1odGn+xAXCYb+xJxV?=
 =?us-ascii?Q?1TaFRjwF60mn7qCenL/17Xzi56i6CXL73Snmoau1eVu7CmnykrqWtoxZD0Mz?=
 =?us-ascii?Q?o6ZSS+ACPXQ6nOEyMqoOtTxL4VFwQFQJFfPICosCsWSOb3LYadAlz72gfq5/?=
 =?us-ascii?Q?LstVnakW9Z/ke38Pt/N0QwBy/WPmAdncgNn0NFxVwTcbiXwhSqmsFhQsBFvw?=
 =?us-ascii?Q?hMaqiONIrM/Xv10cAPOtX+p7laWIId8GkvqsGzIq5aBMcG9eH0dJCoXazqxH?=
 =?us-ascii?Q?GlaAGYr3r5aiu7wUx/qGG/YJc0fsHL05Mgd3xnbG837D7hr3Iw8LV5t/u2dU?=
 =?us-ascii?Q?3MIUBZd0eHAMCfVy6VmKG4Onpo81CI+GBnb3BWZSOxrvkQxP1CXjtYxBfE+o?=
 =?us-ascii?Q?hp44JHVkF08tjduCEIQeclx0EusazHNtVX/jVZcfhOtlai/x069Cfq6BCdHH?=
 =?us-ascii?Q?xq3Pt+kzMoAUXUHAu9SQwwRROwYlBpwEQ0eUpfE+h1TaSjhrEXpjqYO4ZcE/?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f516e73-e5d2-4dee-7275-08dd86a6d7aa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 22:48:49.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jEL6f3j2zFT7FKG53EeTsNUUYOMAb6Sr/AUCkTrkZalI/QNw9MI3jc3MV3NnEv3r6IEI2UO+a0UbAcNm3O1q0P7UGWpp0bOMFSIokMKcyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7000
X-OriginatorOrg: intel.com

Dave Hansen wrote:
> On 4/17/25 12:11, Dan Williams wrote:
> >  arch/x86/Kconfig          |    4 ++++
> >  arch/x86/mm/pat/memtype.c |   31 ++++---------------------------
> >  drivers/char/mem.c        |   27 +++++++++------------------
> >  include/linux/io.h        |   21 +++++++++++++++++++++
> >  4 files changed, 38 insertions(+), 45 deletions(-)
> 
> This looks like a good idea on multiple levels. We can take it through
> tip, but one things that makes me nervous is that neither of the "CHAR
> and MISC DRIVERS" supporters are even on cc.
> 
> > Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS)

Good catch, just note that until this latest iteration the proposal was
entirely contained to x86 specific support functions like devmem_is_allowed().
So yes, an oversight as this moved to a more general devmem mechanism.

> I guess arm and powerpc have cc_platform_has() so it's not _completely_
> x86 only, either. Acks from those folks would also be appreciated since
> it's going to affect them most immediately.

I have added Suzuki and Michael for their awareness, but I would not say
acks are needed at this point since to date CC_ATTR_GUEST_MEM_ENCRYPT is
strictly an x86-ism.

For example, the PowerPC implementation of cc_platform_has() has not been
touched since Tom added it. 

Suzuki, Michael, at a minimum the question this patch poses to ARM64 and
PowerPC is whether they are going to allow CONFIG_STRICT_DEVMEM=n, or otherwise
understand that CONFIG_STRICT_DEVMEM=y == LOCKDOWN with
CC_ATTR_GUEST_MEM_ENCRYPT.

> Also, just to confirm, patch 2 can go to stable@ without _any_
> dependency on patch 1, right?

Correct. I will make them independent / unordered patches on the repost.

Next posting to fix the "select" instead of "depends on" dependency
management, h/t Naveen, and clarify the "'crash' vs 'SEPT violation'"
description.

