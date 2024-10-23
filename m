Return-Path: <stable+bounces-87785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442A9ABA8A
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 02:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DC91F24348
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 00:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CEB12B73;
	Wed, 23 Oct 2024 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0d3JxNM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD14A24;
	Wed, 23 Oct 2024 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729643501; cv=fail; b=Rd+Lq0+kqfw89+60+jZ2vAGIfJNVtN+ncj/H7RPk+j5v20aCXvOS3LVVmEokhBwek2/35c3BvaRCOZ6ACwmRRZktnuuXpifx6CyhDE/KS9jRxF8unjl7CnL7h0AtvZjqHoCCDL6niOigwTJAXczgvwcrjYC/iSoS64cAfAgzHaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729643501; c=relaxed/simple;
	bh=7DC6JAlQFiYUgNTjnAn3M/OnJmk6C8YV4SHLYFK/ZMY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PYqVmpZWZyB7ZgSAM0Q1+QlUN/5kfPE3U8WZuXrlUXdEP6yxc5Uorz1O8Zk/F3DL2lHcei6qyYO9eQ5nBjbSaMCFNccJGIS1Jxd6adzrPWnNnX8T46Zr2Jcp/tYVb+GBp/G5yWfphDYm/cCjj//4KK1CNJJ5DuMGx/wBnfvp5N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0d3JxNM; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729643499; x=1761179499;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7DC6JAlQFiYUgNTjnAn3M/OnJmk6C8YV4SHLYFK/ZMY=;
  b=S0d3JxNMFFKIQYAj6NY/HsnyETLMO/xi5IkVDqnAnSprrpqOz7TdYyK0
   /UkeDWb6q1D7LKx3qqsmAcO0ZDUQMJHgAYYdDHebHXmhc/dAY31MYnGHy
   Sqx8lm0taq+4jbyUQsSzRKZjTkXFP0Nvq35cdZNm7vHg+14NcjILDaioU
   6RceD6/GnUX0YfWQbjuyet2aa2Tggv4iAOW6KBhJDQeasqpajzLkqGiA9
   yg+gl2y7JkMXEwh7Mbrjbax3A+uzB37PlpDpXbiF/85aksKRTh56WLkkS
   fGJ8a0a/WvOM3R0TAFp3ROw9xx4IuNURE1LCEw2EC43rWKiBJt5TlXWQx
   A==;
X-CSE-ConnectionGUID: +e+EE4OJQ6a8WLmNSNnQVw==
X-CSE-MsgGUID: feDfaKJMRRmXdXsdkW5eLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="33025301"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="33025301"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 17:31:39 -0700
X-CSE-ConnectionGUID: MyvdXhAjTtyIfT0Gcr+Elg==
X-CSE-MsgGUID: Ncw0YRiaQ2GbkbeJN6F05Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80449164"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 17:31:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 17:31:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 17:31:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 17:31:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+KihRsPRtYhPwTeI5qgbgw7st+IvYwAba4p9odQ0nMLiiRJWMG1fvTRlYgZvD0KYpcdRPt4DguHo4da9xsLrJ3hw//olpLGzVb6FZvd+EJfgf4kd5vyYJFHIVAAJcKBgLWfqHx+KptmxEIMFg5iPxXgeQ2CXQh3bTUOlMvJ/E+VKbFEQx+EzbZZiKIKnQpTW7pZzFB3NRpZy56lc/IO9u99QjXMzDXj75uLYFyC1o/8K8M9gZxg4uo/9Zloe0z81JrqKLd4tq2StAUd70fkoVcPlHk+qPvGf0vmIQ35CmSfhnTI6JYfG51m0eMm4XpBALFJC3w2r87LGGFDVNt29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re4x0pcny8bAedvuhft4WoR/YWga/GErb83ix1qT0GU=;
 b=Lp8TcFICotiEtDQ1aJ+dOiOYBnFm3B0/vjFEef3RNAyVhIapiyuyxfGkFNfJgd0OxKfJcPLBvBmI0gQqQp940e4l7GPSwsUCZGDFOt4C18YPAL8fmk+mSCYjMuwt9OT4L08Cy54YidJgbPedp9/dmyfgnK9jUvpPZQ71D+xI69cf/Gui4PCvSf3ZuZKCs5zfTa4zN36b9Y6UnSAWm/saCgG8FNK2ayaEGtvHTA+JImsEEAAnbaNCBJK57R22iH72sQtMyIajZTyfv8yYeZokEWlHbnkCmrFgmb4reRcv7DQTJ3a65WPAiwXwnLAn+9+nn71Qqb5JwuGx8RjLYJ8miA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 00:31:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 00:31:35 +0000
Date: Tue, 22 Oct 2024 17:31:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <ira.weiny@intel.com>, <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Zijun Hu
	<zijun_hu@icloud.com>, <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/port: Fix use-after-free, permit out-of-order
 decoder shutdown
Message-ID: <671843e481bff_4bc229495@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
 <20241015174743.0000180d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015174743.0000180d@Huawei.com>
X-ClientProxiedBy: MW2PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:302:1::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed3d8c4-70f7-4148-9ae5-08dcf2fa0cb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?umJVV7c5KQ5/dE78Yfl6MWbG6wddr5pDglAD8uoIqU3u0Y0x06+q67a09uQZ?=
 =?us-ascii?Q?gj4XLHyyWv/HS14y/5MsNTVGLYgBgHfxW14Pupz7ilBKHOCOYMUnkbXZv/pN?=
 =?us-ascii?Q?rm/NcmRgMwD2yGfb/L0lZxdMzVhoRDksL6CMqRWArY1tkNbkM8v+bIYt2He+?=
 =?us-ascii?Q?seJxWL5GMBfKp7C+WbPtdYz59xIqwUGoaEaHtKYiaybpwx1Dy/6D6eiAgUbL?=
 =?us-ascii?Q?sNxLIyQssDAFp9jXr4ou1cfEfw0ZOsMax9YcIN5bcHWppYERkLLp/FO2vt6S?=
 =?us-ascii?Q?Uyu42pbKjW+hQe5J3O2KxnKriLZDkWPhhZK4H4RVkfUZhUr+EjqTwbSbG+7/?=
 =?us-ascii?Q?Bb1co1wvalF22BOKxKYpvGofL3nNOfm1a+Tz1hkXx13ODjWYGM3K1Gn7pWb+?=
 =?us-ascii?Q?2sJBIElfaQ0lsyaTWO26qbnx5A+9FZACONExg+kVXmwnQZXknDzjidkRHPyD?=
 =?us-ascii?Q?BQrgdFNCZRcNJxYJECbzYuiLLYm1WzmAt3dhcKwIlcCp9HNB+f2cf4c+7JbQ?=
 =?us-ascii?Q?sq/eQfEGdRv7LBZ+QTRxqivLuXbi9kim9ciiDvCbIMS5o6XqUwpax6Pgymiw?=
 =?us-ascii?Q?q22cAtys+W8f7lxCxq9PaqlnMn7DqIvjLQt7FToVkjVvMHDqiXAh93gVFspG?=
 =?us-ascii?Q?i/gyXSlaOpa30qXiaz8UxRSXYcGsqANFDAxoSavRGfq6aY0Wv7u+1cYrBkap?=
 =?us-ascii?Q?CGuqKb2tfDxnaMhqcABckPtg4GVsyf+E+ko32RY9PRVyODaS66u751w1EEu9?=
 =?us-ascii?Q?3oLJR4sZorpGzFsM4Jl2V1f0oRKh+InzGOD1rz3v9vpT1GWzq522EeJv+AxM?=
 =?us-ascii?Q?GgJh/Sz9KYiFffVIN04sXkWtSPpJa2SMYm5bv7cVQj6hEVDzJlpbOfpC5thF?=
 =?us-ascii?Q?NwyIGv9ZSK8p2NZLAImtRZVYbpqcdvhEXr1kslNqniF1BkvX0O4/5E4yMyaW?=
 =?us-ascii?Q?2qOkCYU/oPwEHpI1RXWYMQw7XoW6s0WKdR7bEs4rg7QgyvT1hgW1b40ZiIRS?=
 =?us-ascii?Q?hRFg8seNkS/TcRXhz34PYwQcn6Ml7OlQSe/l5k5e+xAHNAgSurnDsOHNyx9q?=
 =?us-ascii?Q?iVxpzFTpgmbEc51a6fsOIQng225+jDzBtQKvHXVUh1PBCniBuYoFN2fEf+Bf?=
 =?us-ascii?Q?x2s0BT8kyjA9JXWvit1TOR85M5OmpkjgLoz+s2Y0u4F2ZL0G9JoLtO44IzkA?=
 =?us-ascii?Q?hDT3XiVwK83Oht11FOOIy2Dws0oPQ6II/msOjVmnK8etQLwlQFFH4RQHABLn?=
 =?us-ascii?Q?z25b/YQep/YrRIyYMAoOfUP+bklHuHDVQK25beaD3N46Y6Xojp6hGhGib6x9?=
 =?us-ascii?Q?AqEBgM0PWDOVUauFcadHt02d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nXtzKHGMlbxVlkmHH3d0/RSSb+reJBYvFMRCliZemzLw74V1oJPVU29P/ChK?=
 =?us-ascii?Q?EABrtqmCOpvXTHyDku0xnJOSe/x4P+/84WHUT8d3ZmJuYpd8s5WKBBNZ54IB?=
 =?us-ascii?Q?tMCdwKXsvcjoVvQ/6Urx35szLL5NG9+aDNH48bDs8DjFRwZKhCktzJj435aI?=
 =?us-ascii?Q?CXcMhebiwRjVVH7wXq/Hh8Llpy2doREy9owRwiVx/34oVjtoHrWKTSNBx6ES?=
 =?us-ascii?Q?QVvEebcLq8luj7BcTjJ4Xwh8cW++IS+/Do+WAbddqqTftppPn972O8EshSFC?=
 =?us-ascii?Q?PBCDIx105mPmp+Rer4Vi/1yL5GZx4/XEi6g90vgdffR307o85gYkfeuRq5jn?=
 =?us-ascii?Q?xpuS2AUL9JZaXS4+PN79/NVfKnTWfipMUx1S72h3FeyYQBezx63aBmnOuYgt?=
 =?us-ascii?Q?rc5mGklWO/kEQeSiPkBWw30XUXSlkbWV1FRs3hPmJJvOpqTJaukHCQ2YRBI4?=
 =?us-ascii?Q?YYMSqrKIh5jI7p1lx9f8dcfd6276SStE3H7/HKMuf25hSMloZQUZscj+Zwhi?=
 =?us-ascii?Q?Jnb7wvXlO2bLhEnNSElZYg6d0QbUp7ITp2rZFB35j5/4+7x6/W/N1WVTGFYN?=
 =?us-ascii?Q?41/l0PDxABa/REvSNI0o88XvKBNdUAjmi7OSBSID5NPRepMG/nrwAeR5OU+F?=
 =?us-ascii?Q?8uR/sxYtogxn9BoJFGVQoeAVQadl02LVTycmHcCCECF7+/o04wAUBquPT7aO?=
 =?us-ascii?Q?sJ1myOnlr2sQjvg35MV/aIhEcuo3Wg5TUqYDI/PFTP5cALSV/tlx2UGc6mfU?=
 =?us-ascii?Q?psm2AtvkLy6SpGVKFKHif/dcpIPqtD+hDjdSG45LQdX/qPYHNdpkaKQ0zpQ2?=
 =?us-ascii?Q?sk+I2VdTLkDFu9FBU4GpIE5LV/3VZQ8a6w/cMygP7d/E4A+r5EVeEkWQHWsL?=
 =?us-ascii?Q?9tsh6KkV/yRa22AE8C9Dro8Rt6szqJ/io4sWEJNUBnZf8C8/0uqLhVgTg/y4?=
 =?us-ascii?Q?XjEq6Xlkf/sB6cUiab4+bdb9PhCZXBKNZNwtRE7GCeT+j9S40vgQhh8KVYVY?=
 =?us-ascii?Q?cI7c6km0PuU+fkwHJ3cz3k5ta2csWXxNjxO43aaDkKjgFGckcv54CRm6gbHN?=
 =?us-ascii?Q?x9PaybCYJf5Svbbrapq4htZvTK7Da+gURqo7+YBI4NSTKN5KLsevagKe0PyL?=
 =?us-ascii?Q?3kDDveL534Fc7uYJvbx51M0+TMm6pnmbBVq6VB2UduLMSpIpnmbiaNh8s1IE?=
 =?us-ascii?Q?7MtLan9vaEB0clR1KiPCfFm0DaREAyVg7+Ib0JqN9sbWGe8Vq4rlqr2ghcHs?=
 =?us-ascii?Q?KadiuvY1o38saz2onwLRRTPdRfB0F8xr4nWPCxg9TzsN1R0CEVRZVhCgHuOE?=
 =?us-ascii?Q?bD48WnWg2ffM+MAXJoxnwiG5CGFZ8dwupl/H/KYQ03gxkNaan+Z9k07JBxCz?=
 =?us-ascii?Q?sqrF8mdhCLYjfwPM7tyPhrcJTBVM2fh5nZPUld6JbUTEoPBCPeeR4vdNcNnr?=
 =?us-ascii?Q?U6kIMqSyl1yFMGQDfycT7+F84d8QiLzKW6xtT1thG5uq4r/a7SNdzL+ComMp?=
 =?us-ascii?Q?d3aaUnoNgmQbcvSYSTGM0Oc2mFMvK6RugXFPx+AWE3jlIeZRf9lX0nfXDPrw?=
 =?us-ascii?Q?bMfQk2BW8E2GJSUYYRk2zawG+F0MI3U/yF+fYLxkKi4YLwoBjQh4Db9JNIPv?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed3d8c4-70f7-4148-9ae5-08dcf2fa0cb1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 00:31:34.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gIkb0jVB6V29+SoGW/HTCsaqm2XlG7dwtHf3QBrF54+1uFPVRv0UiKO1RFkxICMUCYlip2L2Y8/CmdWvwNCL/HWvjYIRh9zq40rTDCCe5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 10 Oct 2024 22:34:26 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In support of investigating an initialization failure report [1],
> > cxl_test was updated to register mock memory-devices after the mock
> > root-port/bus device had been registered. That led to cxl_test crashing
> > with a use-after-free bug with the following signature:
> > 
> >     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem0:decoder7.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
> >     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem4:decoder14.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
> >     cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[0] = cxl_switch_dport.0 for mem0:decoder7.0 @ 0
> > 1)  cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[1] = cxl_switch_dport.4 for mem4:decoder14.0 @ 1
> >     [..]
> >     cxld_unregister: cxl decoder14.0:
> >     cxl_region_decode_reset: cxl_region region3:
> >     mock_decoder_reset: cxl_port port3: decoder3.0 reset
> > 2)  mock_decoder_reset: cxl_port port3: decoder3.0: out of order reset, expected decoder3.1
> >     cxl_endpoint_decoder_release: cxl decoder14.0:
> >     [..]
> >     cxld_unregister: cxl decoder7.0:
> > 3)  cxl_region_decode_reset: cxl_region region3:
> >     Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bc3: 0000 [#1] PREEMPT SMP PTI
> >     [..]
> >     RIP: 0010:to_cxl_port+0x8/0x60 [cxl_core]
> >     [..]
> >     Call Trace:
> >      <TASK>
> >      cxl_region_decode_reset+0x69/0x190 [cxl_core]
> >      cxl_region_detach+0xe8/0x210 [cxl_core]
> >      cxl_decoder_kill_region+0x27/0x40 [cxl_core]
> >      cxld_unregister+0x5d/0x60 [cxl_core]
> > 
> > At 1) a region has been established with 2 endpoint decoders (7.0 and
> > 14.0). Those endpoints share a common switch-decoder in the topology
> > (3.0). At teardown, 2), decoder14.0 is the first to be removed and hits
> > the "out of order reset case" in the switch decoder. The effect though
> > is that region3 cleanup is aborted leaving it in-tact and
> > referencing decoder14.0. At 3) the second attempt to teardown region3
> > trips over the stale decoder14.0 object which has long since been
> > deleted.
> > 
> > The fix here is to recognize that the CXL specification places no
> > mandate on in-order shutdown of switch-decoders, the driver enforces
> > in-order allocation, and hardware enforces in-order commit. So, rather
> > than fail and leave objects dangling, always remove them.
> > 
> > In support of making cxl_region_decode_reset() always succeed,
> > cxl_region_invalidate_memregion() failures are turned into warnings.
> > Crashing the kernel is ok there since system integrity is at risk if
> > caches cannot be managed around physical address mutation events like
> > CXL region destruction.
> 
> I'm fine with this, but seems like it is worth breaking out as a precursor
> where we can discuss merits of that change separate from the complexity
> of the rest.
> 
> I don't mind that strongly though so if you keep this intact,

If there are merits to discuss, let's discuss them in this patch (in v2)
because if cxl_region_invalidate_memregion() failures are not suitable
to be warnings then that invalidates this patch.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Trivial passing comment inline.
> 
> 
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 3df10517a327..223c273c0cd1 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -712,7 +712,44 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
> >  	return 0;
> >  }
> >  
> > -static int cxl_decoder_reset(struct cxl_decoder *cxld)
> > +static int commit_reap(struct device *dev, const void *data)
> > +{
> > +	struct cxl_port *port = to_cxl_port(dev->parent);
> > +	struct cxl_decoder *cxld;
> > +
> > +	if (!is_switch_decoder(dev) && !is_endpoint_decoder(dev))
> > +		return 0;
> > +
> > +	cxld = to_cxl_decoder(dev);
> > +	if (port->commit_end == cxld->id &&
> > +	    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> I'd have gone with !(cxld->flags & CXL_DECODER_F_ENABLE) but
> this is consistent with exiting form, so fine as is.

I have long had an aversion to negation operators for the small
speedbump to left-to-right readability as evidenced by all the other
"(cxld->flags & CXL_DECODER_F_ENABLE) == 0" in drivers/cxl/.

