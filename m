Return-Path: <stable+bounces-86363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364A799F2D4
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5959D1C216C4
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C51F6687;
	Tue, 15 Oct 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mi+Yl77d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7841B3931;
	Tue, 15 Oct 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010231; cv=fail; b=rjiU/+NLBGubIcXy8q9ea14gezf8pX9g1BrVrQ/HykjMkE/rBqX5pdgkMl93ZgxaLDF3VJGt9vq6jnFsPdyn+6CjgfUJDxouf7XLY6DVGaOeXC58j0afgElGPoz9Ones48q+YvN8eqrTMYCvc2uBI1LWxXQwJuuivHFGC6yXzIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010231; c=relaxed/simple;
	bh=zm+WACmHthiAtueqWcTWnC33SX+xXVNKeHucER/FtHA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YCyuOTmvM4uVobguCWtY/HDGupdl1UCFVdjt6hlBh3oNnuNzQ00veVDO9szGarqjN0ObASfOxiO0Qesp77EzI0IlEE8o+ULqsaBm1tO+SFWYjXI6IdWHVnSO2Mgd9ps3wGSP3vTYFwGMAA44aV9iPhmvR9eIaCNNQ3tyVoRJsy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mi+Yl77d; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729010229; x=1760546229;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zm+WACmHthiAtueqWcTWnC33SX+xXVNKeHucER/FtHA=;
  b=mi+Yl77dzlYj7CSPdO3xUj13CAlyOoHAYGHyhopl9WFKI+xpwpeHXMYP
   /yAOwvDxnbGaXkibbd/L3ajqYpF9cAuaa3lvDYry/V7LQHc3d9YV2YYfQ
   nQf1zy1EPEHCxATQRZYVQPDF7fTGoaHNsFiFsMh8ypJM3TckJhS8xwC1M
   czQgH/oRKFcQo4l5kPuD5HSsyP/A1+Fv0JAij2pzzHDEoAq8qBIedCX1F
   va1n0nG3barF0S8BHEmiPsYyvBGXjCDkr875A1xIxqoaIrgwHQ/Go/GRG
   lo4S0TMWadeboW+36EZ50qUKMQvUHBgYt9g5u0ctvHj6QNzJ8boybko5f
   A==;
X-CSE-ConnectionGUID: Y0zZaKbJSJ6DkhMGd24Y+A==
X-CSE-MsgGUID: URswr/R1SmyOjy1zXsgPNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28618493"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="28618493"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 09:37:08 -0700
X-CSE-ConnectionGUID: Ky0sb2GMSS2MCObH1aA1HA==
X-CSE-MsgGUID: KuAh8AMYQBSYnTRSBEKBPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82757854"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 09:37:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 09:37:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 09:37:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 09:37:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 09:37:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvdgXwd9sOhOqHQXm3ye4Gy5uMTYGzaaPAWjJtUHM+lXgK1ZHFwbh2jczPT9ih26zAGZuIMQ46x8QV3nJHBzk3kfiAGO5CMW0ncevuU5frXygjxgsLFrJJbUeaRVlK9uL7DDcK4/sccSxxbJoZs619yFcuvBkWyTyKrTl0v9MTwUgTEzTOETSigOOvFDmcTaExqy7czczWEhYguoPgvxcBrZwMH7tzhBvde2Ni8+pJxVgZ9TM88R6rZ3RBLjvvukIuaEW3SAeaUHTTsNuYbePnl2c0XSmCZN0cbNZIfzwqDlasoC5BgDe7fqb8BUnwbhY/Ntyi1JtDAtxzW+6rlWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwB6M3P2LGA30YcwXIDeqaOXhSerzj+VXas1EzTG8aA=;
 b=AZd2PPO1EDzUcIekQjQ53U5I16THQhyGFK2/kmbY17d8nXQa2+qOVUQT5EfPIEPBicMbWUQ8NexXs/guGdLu/QWcDlF937lcepX2nu3MtcJbseyQAIZeIG5tp3HDdB4mg+eavTY1/sF3EfbTjszrULgPa2sbYLPqgMsiNvooniTlZ5eR3z07NQ3oI5u/5HE1j6aOjeOZMJXVl6iE/cXA1gdcfUOlrDIX1M9gfNXrB8kAXGdjyJtqPNIrCi8BvN5hlNHdi4nQOSsF5YIBIIybYwDNxOHO0W16ImeurN77OrPIrfHudvbjh/l9TWL2v+LoLvePxL/TugcOYvFTt7FkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:37:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 16:37:04 +0000
Date: Tue, 15 Oct 2024 09:37:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, <stable@vger.kernel.org>, Zijun Hu
	<zijun_hu@icloud.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>, Gregory Price
	<gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Message-ID: <670e9a2db6f4a_3ee229472@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
 <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
 <a5a310fe-2451-b053-4a0f-53e496adb9be@amd.com>
 <670af0e72a86a_964f229465@dwillia2-xfh.jf.intel.com.notmuch>
 <0c945d60-de62-06a5-c636-1cec3b5f516c@amd.com>
 <670d9a13b4869_3ee2294a4@dwillia2-xfh.jf.intel.com.notmuch>
 <9a1827e3-1c55-cfbb-566f-508793b47a4a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9a1827e3-1c55-cfbb-566f-508793b47a4a@amd.com>
X-ClientProxiedBy: MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b11599f-52ac-4442-7321-08dced379a29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sCuIBI2BnVMpfaBuPKpEaULS6Tw4FzF/0BQpEaxj0bO9MXzKs/Bp3Z6imSpS?=
 =?us-ascii?Q?K0nFmJOKaIrorDacY53Vpm3JNbSu/QuuRU8awBjRlQ5445+D8hP3USu70x5F?=
 =?us-ascii?Q?eWCKbdvnRiYmwT+Vp9is4iduqLDOCF2owLK0l/LVr9f8GcsZqy5RdDXq1drO?=
 =?us-ascii?Q?NuIrHCHug0N4V3uo1U1JNT8tD8DF2cLur2QMJkrTSFeB7jT1pkNrB73wS84W?=
 =?us-ascii?Q?8rvH/SX6raWStswLXb4gnY1FHgnY8hxc4cykl5waDJTYmWJjtBiFy9I4u9Bw?=
 =?us-ascii?Q?7cqErCNmVQaoiNJEE3Z+tUp65lFzBoes4709VE2PAH3G2oK6JoZcjuAnnNAp?=
 =?us-ascii?Q?yp223oiKTClXmQ1t4Ypr3mu4gizU0/1eDW+fGL88A7ZkqqtwyNkEVOFhlIcw?=
 =?us-ascii?Q?c4H1Fb+wr9DBb2G4k8JYucxhepgvxLYmVVS7LjHL43oQwhpkju3hNZq43tjv?=
 =?us-ascii?Q?YH6q6Xlm+der9u/QsmMi6w7asyONzf6nDMgAuCxaphz0vlIqCbD5u0pIJH2E?=
 =?us-ascii?Q?VAftydk1jYC9XMNxU4UKBoB7zpFBMPzmVJN5V7fa9Ky56sV72VmMrdpqiIeB?=
 =?us-ascii?Q?iPDOF92bbO036chJfrgXsopYW54H7l6+AunCvhyqkO4WtjSiHBI8Rb9eWjms?=
 =?us-ascii?Q?4ehQ4lzxJ+22L+Pdkwsnc0s4REnBgwa5HRYcyeGUmeM0UWlF1P7E1BwRH3Ux?=
 =?us-ascii?Q?Ca0TZscYiKgl4FbQ9is5G3brqwK0CeYJt54uNEXqv9FC1HqCMX4HTfQqqpRO?=
 =?us-ascii?Q?+7/3awi30sopicFiLRXY1lrywcJqHAjKzlCVwCAdkozeH3NtagXAJVmrRPnz?=
 =?us-ascii?Q?I48bpxmN8hINFr11aiFVIbN5L80X3TaiwY9y8cL2fdvyUvcN+FtjEbupemp8?=
 =?us-ascii?Q?1DrZZBWgLtnHXGax+IYnDM0cCwujmHhjnfh/gnx9HaBbxDbAkK3NP7NSQaAN?=
 =?us-ascii?Q?LMdjeUZ1zazEFSW/T51yu6GhP9uyDxFbEhM4SaNB7LRYZhX/fg+8SdWp3cEi?=
 =?us-ascii?Q?JgfdGwWWn1+fyfw7hku+7jfUqrIqB+S+Z4t1Rk3R8baRjgkGHaU271+1vPkj?=
 =?us-ascii?Q?QlJh+dri4Dyum8IcQppkfmvvhUCoAQ4Ki1KD6fbKUypP7VvoJZAdb4CeYAwN?=
 =?us-ascii?Q?LLHGz8lKsYg/9iuH+AxwEHO9JiEgri50qZQ0+VSR59uGJnPv2wPR02l7ozZu?=
 =?us-ascii?Q?xn85lVqzgQBGDyNxLKlXA/Kld6/akCKV2377LpejDTbSIL+BmKTa0nSK7Bai?=
 =?us-ascii?Q?3tHY4RJqJH9d0lIjuMZw+waGAyBkJUSxSBZWICmK6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsRp1VIj8fX3OY2WzliMG8NALXLEJ3+M1pbAEerItVk+PHDDngagVVpjmI3S?=
 =?us-ascii?Q?TNV0QziTZEaLyMhTxKbZEFn2jaSH87/WZfU3eb1KVHjmVZ4+DptK1lNisoJT?=
 =?us-ascii?Q?1frwYD9YUnSNz/SJHsDqYsySVy1oI+S+iOWubeTahfl21cW81XifCfrYpbmC?=
 =?us-ascii?Q?Ef4DnqQi0YQRC7HPANY3KcGTiC7KE/EWReJSR9yV8e4pOujjAjuaSsqo37EU?=
 =?us-ascii?Q?Klbt4WO33Tp0YdsRR7iTambSOPs5eQlHMb+4V42UK67QnuUw9kz6OnSiIB42?=
 =?us-ascii?Q?ey7jxSEPX19IXEy/cqL3yLfHAMxNDwBhSI4Ug6nS3QvHCj+3BsQXhRuiiNIG?=
 =?us-ascii?Q?VQjzSO1yk4tk9A69N45EJhrIE0R8bl8BjvqsQhgs0kqdtSDhheRIgzaeTi3l?=
 =?us-ascii?Q?+lVAyqnwes5qetEkj2jSeSkwIEaX1/77PyuagJ7tWUIEpsyQd6rApWteOc5W?=
 =?us-ascii?Q?zlfnkXSf9x3F7B+xy5KTwX9gZY4VdWdFBw7IiVLBPTLFA/KsTIBCoz4fIm5h?=
 =?us-ascii?Q?6dOa4FKyrcRbu5Jy5qtqiEQnu5nUjvpy9cyFwRxsmD9WqEur90IpqcG5ERAX?=
 =?us-ascii?Q?yyUgsI4+9v3U+T2Esk+s7L1sxtlDa4RLkaJp4Euw947PnaHRhjDnawwrnC/B?=
 =?us-ascii?Q?DolomI3EgIqVfx90Yyx82uoVFxJ8fPcjS4mR2PwicLhdrfIyJwfF5ZkNOb5B?=
 =?us-ascii?Q?lPcIiY+Qt4jAu8jwcHaI1hgiFoM6tAFtb+PSHlN5Z+VYHdifJ3wVXkjyUC18?=
 =?us-ascii?Q?XYQhPoTRus7uW5W+wd32PcS+iGWwBy6gWOwmWQmyAvL+nasxRaXj09aoFff4?=
 =?us-ascii?Q?SejgMrS5ETdae0DDsIL3VIN8BLYm0ux+7S1yvOfBcdt1LnqhwkUilf9t2r8j?=
 =?us-ascii?Q?WbH10qFwjGAJBgLApgAzSltWQxJPn8IhsXC3m4vkjlGEO/hSZo0zUc6x/llx?=
 =?us-ascii?Q?KsPtkAyZkpzZyoA/B3COj5YYkhwSJX0Wrvk9iTae7jVlTdt1yRCkX47kaauz?=
 =?us-ascii?Q?QZfCPO00UIM5piyxT5TDf/q6dWyYSm/MaGWcpprBKRcGUR8ihGFz+V8wlYUT?=
 =?us-ascii?Q?hA6aBd7NsNByRIuMar1rmWwjSqTDh0TXJ1bhQxXyXpPq/UUwF4bwtMORJMiK?=
 =?us-ascii?Q?G6c1hR0TCajMQpWnkdklaB70ipmcmnY6PJEP4VyW6ioEuqjyxtDZLks15P5d?=
 =?us-ascii?Q?qqbXQngfz/7ZtNZOk/SdKXrNQymf+xdJlUcxVyGaL4UjjByhTJ90/hk+OWt0?=
 =?us-ascii?Q?G98C7NuFzBWgnCjC1gCbsarlx4ZAcbH5x/7pngkatGSud/M0qc4MfxU9aB3Y?=
 =?us-ascii?Q?0A8m1P7ye4YoD/b2SKFad9cSfYhzimDbJtYSQRpGisY/NQt1wzzAnqAMUv8Y?=
 =?us-ascii?Q?41gUocQXybv5qeLklDabwo4+NLx8LwCacxOpQLyW41Uwg6tta0Pubgji4n/A?=
 =?us-ascii?Q?AUL9/GmXIYcMgSgJS2cL0UIqL0yl+HhHdxIBIm14Ii/a9932tqqJYQaB3imt?=
 =?us-ascii?Q?72s2Pns+ZAJTXIUqrRhwB3FSjzm95hu8lwQ/ANucrxmJR191kffeXOAJA0+p?=
 =?us-ascii?Q?cCpvlKZvVe+1DMSZOhsEmTYrHtNYYvkJdRoXjaS8QcToF5vA0QBajuo78d7P?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b11599f-52ac-4442-7321-08dced379a29
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:37:04.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fNQQu378UGgzv23uUdaLAT94QoyXnS5aSmZNrp5aWNbigPZJYAiZDtlbqc3RTrWNzBCn4lM3xOBeOAJMm6tNHJYJrVqLrdhpxcIxhrYgDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> >> Then it makes sense that change. I'll do it if not already taken. I'll
> >> send v4 without the PROBE_FORCE_SYNCHRONOUS flag and without the
> >> previous loop with delays implemented in v3.
> > So I think EPROBE_DEFER can stay out of the CXL core because it is up to
> > the accelerator driver to decide whether CXL availability is fatal to
> > init or not.
> 
> 
> It needs support from the cxl core though. If the cxl root is not there 
> yet, the driver needs to know, and that is what you did in your original 
> patch and I'm keeping as well.

So there are two ways, check if a registered @memdev has
@memdev->dev.driver set, assuming you know that the cxl_mem driver is
available, or call devm_cxl_enumerate_ports() yourself and skip the
cxl_mem driver indirection.

Setting @memdev->endpoint to ERR_PTR(-EPROBE_DEFER), as I originally
had, is an even more indirect way to convey a similar result and is
starting to feel a bit "mid-layer-y".

> > Additionally, I am less and less convinced that Type-2 drivers should be
> > forced to depend on the cxl_mem driver to attach vs just arranging for
> > those Type-2 drivers to call devm_cxl_enumerate_ports() and
> > devm_cxl_add_endpoint() directly. In other words I am starting to worry
> > that the generic cxl_mem driver design pattern is a midlayer mistake.
> 
> You know better than me but in my view, a Type2 should follow what a 
> Type3 does with some small changes for dealing with the differences, 
> mainly the way it is going to be used and those optional capabilities 
> for Type2. This makes more sense to me for Type1.

If an accelerator driver *wants* to depend on cxl_mem, it can, but all
the cxl_core functions that cxl_mem uses are also exported for
accelerator drivers to use directly to avoid needing to guess about when
/ if cxl_mem is going to attach.

> > So, if it makes it easier for sfc, I would be open to exploring a direct
> > scheme for endpoint attachment, and not requiring the generic cxl_mem
> > driver as an intermediary.
> 
> V4 is ready (just having problems when testing with 6.12-rcX) so I would 
> like to keep it and explore this once we have something working and 
> accepted. Type2 and Type1 with CXL cache will bring new challenges and I 
> bet we will need refactoring in the code and potentially new design for 
> generic code (Type3 and Type2, Type2 and Type1).

Yeah, no need to switch horses mid-race if you already have a cxl_mem
dependent approach nearly ready, but a potential simplification to
explore going forward.

