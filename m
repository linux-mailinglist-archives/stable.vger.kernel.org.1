Return-Path: <stable+bounces-164944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B6B13BC0
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A8917C5F2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE91865EE;
	Mon, 28 Jul 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0zABWRc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D2263892
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710335; cv=fail; b=Sx9xdWgRcNODXuuBXr1oj+7duLcgOmc+JfJL9cttb/19ZqP9cn0ER1qBaIBeCOu6JoHa+tp95W69nmsKRFA10v+NVHhCpyr+Ronowo8qx8ZJZ4Sa7VeMk7Rt32VPlmvB1mbfBMemunYVX8k8t497hS+W5Fn83J+tzi1CgtV6Jvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710335; c=relaxed/simple;
	bh=iJfMoNUJf1tr6zHWuqZiwXkbQUpYmLLSUPsuRtB5mXM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UV74EP2ReZH+aLcB+JmB1XudpgLjWlduQW93IoqBueu5Fj7U1/i0W9CjcCUhF5IpA+M0h2FXWS/U4j38JJZPGIA1JRp8coBvlJB/zDi7W4CUYca1W5SZLuh6Aqx4Ok0wD2sR1y3emfLiV1bfdF1R4t6xv4aBE+h+5MT0hq5DIPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0zABWRc; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753710334; x=1785246334;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iJfMoNUJf1tr6zHWuqZiwXkbQUpYmLLSUPsuRtB5mXM=;
  b=R0zABWRczJTMmS/YCBWjZU6UlsztANaK4B4sr8nNV56eNSeoG8htHtGc
   VusvmIiKtVhN765nvjnJx2rBBKjfkj4fVTztgYO0cw39R9MLfkTOFXg/z
   D4cqiDAZYf6SyPNIy/IKu49C0mpBXXviocJiitrAnYi0QyBikgKy9hTz9
   1/frrHiX/cZYg8RzT/ROuvzOw23UwZMgMCbYuIv0vrBi8E0Iy71+BVws5
   Upybndg9xwNR5Dj7nAp3Q5aQCjmSZD807DBgVLwsPQV9Z5Emc+1/j7s3u
   O5kK8GahW46S7ZVDjIJGt+ljGGNFxsz3iXjhlsl3AKf5a0QS3ikMpTCMZ
   w==;
X-CSE-ConnectionGUID: gbfDMhlvSdOU0aS0XtLjkw==
X-CSE-MsgGUID: 2pKTNBZcTwSaQJDNKKtxHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="78507926"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="78507926"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 06:45:29 -0700
X-CSE-ConnectionGUID: CErgKfvkSxiCH8Hu/T9eiA==
X-CSE-MsgGUID: 2A7g5yKVQCe3Z9xhAgT+9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="163195717"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 06:45:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 06:45:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 06:45:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 06:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsy2J2NuyQ97Qamrh63f0zlNHrUkuJW98x1LJ2PYyXv1wYeOuNFO0wm9ENvPxLP9G27KM6gikD2kdhpx1N/qWCuCXFP3ynbC6gkJY7V17xQJQGFGbPsYgrYcmVM9g61Dn8zW7DNW73TyjKx/KfexykQ7Fci4+9IZ24TqJ8uGldQRXVBJvm1pfCDe/63t5aj0Xp7N1t1dw9/6QyoimwkrvqsMSb24tLjmnF7s1Ok96f+eF6wlqv3P2Xo/lHeLeMvJHct7oM5Pydq0mZ6ihbNGT7zjs95Q0QCOjLY15h+TrKPWQp+Kb2hJOMh1gTP2s3hpjeplzfpsnLbRu5Vy5vkaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbPd/I6xXKB/jxLqDdQDQNGClHjtGNhUNAt8E6/BTgY=;
 b=Tb8SRUZJvW3oiuIYNS8QPshcYvNjncVVgri5IV3gMlLh57BgsmuzlZHnpBjfIIev2exeZaXO/kZoTUOeGHBr1mSc7Aw2gp5LnzesDjnADmL5bAXq96hd7WzZoQWfDO72QDHrMKLFTIsd8Id9ht/3RK+SZxFV7kK8ww9FpUNkJqnCp+zNCF2K6bQmEMBpW2+2EPmezjJliLJP3SCuurxh9nzQfsCAUCJalah5GEixgOYkUyMdOdw6k1LdFZcB6EF4xorO2vKfRoC++5ddclZ+IMbtF5arcvADfLxneAaDmwWvNGmCazQOA2OAH3AzvMP42ZM0tbElUksfWACLVmLFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 13:45:05 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:45:05 +0000
Date: Mon, 28 Jul 2025 09:45:00 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
CC: <intel-xe@lists.freedesktop.org>, <jeffbai@aosc.io>,
	<stable@vger.kernel.org>, Wenbin Fang <fangwenbin@vip.qq.com>, Haien Liang
	<27873200@qq.com>, Jianfeng Liu <liujianfeng1994@gmail.com>, Shirong Liu
	<lsr1024@qq.com>, Haofeng Wu <s2600cw2@126.com>, Shang Yatsen
	<429839446@qq.com>
Subject: Re: [PATCH v3 5/5] drm/xe/query: use PAGE_SIZE as the minimum page
 alignment
Message-ID: <aId-3AFWP-V10Cfr@intel.com>
References: <20250723074540.2660-1-Simon.Richter@hogyros.de>
 <20250723074540.2660-6-Simon.Richter@hogyros.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250723074540.2660-6-Simon.Richter@hogyros.de>
X-ClientProxiedBy: BY3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:254::25) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BL1PR11MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e51b7b-3809-4d82-06ee-08ddcddcf57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fOY0Tr4hKSKEbC3ETjnBRVlFUTkg1zLasxCP98eMEIJTnZWnFeb9iJndJQtz?=
 =?us-ascii?Q?rCLuctB5HjJNtFenbAwUttK6lzPZf0ogpqfwLz8CkjqHANLqstUut8554NV/?=
 =?us-ascii?Q?/8hRFy7ZxPJrJfHTailXkxlbQB24RJCWCuB/P1zeqZvzikd5W0wju4GOJoXo?=
 =?us-ascii?Q?MGAt7Cug6D8h/fKLoOp3tGqIXdC30KZIQvDvBkheDSg5OXehaIx1Y8lamSKL?=
 =?us-ascii?Q?SHQvA0Hl3ovCE1Y4tacI8nst7aCP96QBSZ0T6SX96qRQ79puP1g6A9yANCq6?=
 =?us-ascii?Q?MMmVGK/1OGV4TQKhKTTzMPGH3BMy/Y0hp7T1Zxg4CP7BvJRgUKjyl9oGzsZU?=
 =?us-ascii?Q?ZBDacIgbrtSRnawFZ3odBXQi7B2L/l7/eIxo+eCGIP37StBTuVjUzu/lnkJg?=
 =?us-ascii?Q?4iqYxMZRf8zOf8eWoJkYiLjpc6v9Vt5HCuHrGwwvHc+XMob9OmdY0X/ZAiHp?=
 =?us-ascii?Q?8wM5ic8B69SN7OhMDmsweJ5EigthehJ9oQy4Xbj8IdtAlYJKmP2XGkCUceK0?=
 =?us-ascii?Q?IfeVbyE71tHb8wBYQFdESzI8BFE+hKjoWH0k8IZhjSsWU+iqpT7wJuz5KdL8?=
 =?us-ascii?Q?5g7acDHjY7785KHSufuSKkCEl7KqSKKu2o+w4rxMFFGo6mU/W7mcUzvDpwJe?=
 =?us-ascii?Q?iqEkLQCHFeMnyERlsXaGiBJMxhnaJ5gKcLnmiCuy8Su1cQqU/AvZ7EAT9dS6?=
 =?us-ascii?Q?f6F7nh5cnK0Nj5M7TPEJqI/YKWpjCZJJhSOTcngBPi2/dKXqKcqs+nOLkv4K?=
 =?us-ascii?Q?l+kYhGzITPrPUlBm3heXYyhRj031WQmHs0uZ4f9sVHArXiEyBz/qCj/7QGb6?=
 =?us-ascii?Q?NbmBe3Zmv47Dhy+ZtGEMlL/Vpde2ZZHt1nsTQubQtS83Cbikk1LRQgF9z46b?=
 =?us-ascii?Q?/ZH8ndty0Nxy69KI1PlQ+n5zLjgkK0UhJRYlTKEP4STetse8TFy0bPz3Qy9l?=
 =?us-ascii?Q?b6u19r7tiiNTmu/nCiKy3RvWteVIPl4BUU5kNULDRCV6L16NeJO/ph+xjreO?=
 =?us-ascii?Q?08LrtfyvDAFMReTKCTpOKD58ekmZTZlHXGeLhe4FLGj3dqpriTsYh/2r1p+a?=
 =?us-ascii?Q?Jyc2Q5yHOklZeDuahb7U3H2j/oZq/GRPUhlyPC0DzevFd++snQ1pUkA7JUdW?=
 =?us-ascii?Q?a//v0SxTDcpiTmvjJAUz6uvhm9p4wYQK3sAyMYebOJGtXHBTrkNX6bLVeehv?=
 =?us-ascii?Q?i8rVM4jAm2eGPQJeUKuMiHRTgYUEh9Rryq8TuTuJ4gDpblS8+avilMZFAzFW?=
 =?us-ascii?Q?4y0jKqhV6IQcKPJ95vLqnYj49PYG+q3CDxvF69otZQlq/b9xeLECqbLzGt02?=
 =?us-ascii?Q?Tq6OfXENCJysKPaSpvuM5E2hVUmDcn8PbkgkLg1qHcQYt1wHBo2fpjuuaTnn?=
 =?us-ascii?Q?3yYnA6rqcnemElAOgFPHfYbPO2HFRgs9ak7RbJ8TmBfSeUjVbuyqf7thDxYj?=
 =?us-ascii?Q?ujGu22OMrzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fF8F36nnfSprNkO72VrYKbCZcxd/FGXfSbryqTnK/o2kGRXPJEs7pZEcDmLH?=
 =?us-ascii?Q?L9QcbGhwCYOmQZaTmFz6Z2+I/hfH7Exq5xWMNjEmfoqcINuZ/TMqj/ce7s9T?=
 =?us-ascii?Q?J+lC+JPmpagqWeU90pqzyk8KUzDvrHvKrny3frvk/K2/ezHD0vnSobcIQ3E8?=
 =?us-ascii?Q?7zl6Hmup4tdmgBo9XrExR2/o1eg4hSb6JQDrliRuUhaKqLO2YDAEfT4e1VHI?=
 =?us-ascii?Q?hJK0rUv9KxuiLn8Rb1i05AbMe7dQznk5z4/Pcx2X3KNhfTu2AHHUcYqkoNIl?=
 =?us-ascii?Q?GglBZBcVxomZr5HO/xC8UXc3xdcIdim0H95Mi5Z5V8UPr3IE7NfWkSCDr+os?=
 =?us-ascii?Q?pa9+JnVGS4skBfHHvmMvuWNNHu3TooGNQ4zoSFA8WLda8dDU4VYsTvf8MHMx?=
 =?us-ascii?Q?I9opoq8fHx136o85DFC125H/1YNDpAE9HUzC7LO/LBuV0aWa8gXSfwER6ha9?=
 =?us-ascii?Q?50eG0IN5fvn7q+4OQelS1VVaIQ28+v/o9wBn/QC4vZRLuuOK1hqrrn27DZiP?=
 =?us-ascii?Q?WuwKrDPLFaD+pwcL0V8zgGLNCWSgecKcq2vbW4xTO3KqjljOlEtDN2JsjfG3?=
 =?us-ascii?Q?X5LO98CpE1aE8+31DidQvUE3+J4dJv2dTG3EZ6qDagqYpmx/yt1urdeJMj3b?=
 =?us-ascii?Q?gvwia0kxTOj0NWIVrd4WIFiHNrr/xDATTYy1t8RP3Jn9rJldMI/bW/2H/jeR?=
 =?us-ascii?Q?EX+M/iKJuUeAqSO4L/IaPPn6RerRrVMeqZpT91SiOfdkoufp+aFOwtGqgAt8?=
 =?us-ascii?Q?TP276QDZUFrg6hh1fBdCUTKpZdz4ctyHTfRXDSjyggPbZP+N5knE0nyRWol3?=
 =?us-ascii?Q?CjyFgubjOnNmIiukPUlpKbr5N8py90VOMKUjfnk6bLSJyyPfiDMZdjPbjGHt?=
 =?us-ascii?Q?LVQlS+aqoct8vVg9vazGPSgxYZgLQM12ek5FDRQUV+s1FTD+gdFZTgzMma4U?=
 =?us-ascii?Q?GKUtoi7PEANFWdqb9xwlhT6FIgJi5EyPxhOvTY5bgiJvv6JyJkqkwr50eAzH?=
 =?us-ascii?Q?47xHodaKQwixOAwqIRKp2ppQ2WXJ2rrlPSOnvPu9/H/OJnHHIHGbYGyNIzZx?=
 =?us-ascii?Q?e/G4ygqSyTTuOuyEr0YyVUkYtiAtVW7aZULeT+SJzLnrPdAB2mJFcFXBYJbF?=
 =?us-ascii?Q?TRsSVC8Rekds0nzIf3nJxbctJpjxsalVKCo3HLS5bFbMWpej9S37qvP/hKRA?=
 =?us-ascii?Q?PGa2b1kfoM9XyYL8/1qNFxcxMimuELEXsHEFaOHLtYIDvMZW7l/r/Hky0LnB?=
 =?us-ascii?Q?7enZ1X9jdFz+Q9lOy758e3+FCErbVtzNQY+61OXJRQKkhLXGQuAvTN8B18ka?=
 =?us-ascii?Q?vYVU/y0Vtg7+FL9srWOko3q4GL5AvHWTez6qmJ1UT3BfseAmIsrG4Yy0AB9h?=
 =?us-ascii?Q?GA1kkbjQsAn65URi9o7KIaYDo75TCToHXGu9SBaRlKJ2N+ldbo139aIhV8Lj?=
 =?us-ascii?Q?dpU5BwtdeMVI18D2k0QdlfwxaqMK3Emj4+jhZxrheHayYFjXzECIu1lkEFeh?=
 =?us-ascii?Q?+botuYzrtK0kzifClUvbma7IcYCVGuXaK1tDjc163msl7vkhp6PsFBWkUfNi?=
 =?us-ascii?Q?WcLhBOs3vXTEh8nRZER/D35hK70xblKSOp6WXVeD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e51b7b-3809-4d82-06ee-08ddcddcf57e
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:45:05.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GquPxhd4FF0VoZLvIjMgVqJ/yXcG+wA9mUygXiR8HOpWhjivjBDzinTIgYBCo+t6+z4sWzlCyEOqgjiOAki6lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-OriginatorOrg: intel.com

On Wed, Jul 23, 2025 at 04:45:17PM +0900, Simon Richter wrote:
> From: Mingcong Bai <jeffbai@aosc.io>
> 
> As this component hooks into userspace API, it should be assumed that it
> will play well with non-4KiB/64KiB pages.
> 
> Use `PAGE_SIZE' as the final reference for page alignment instead.
> 
> Cc: stable@vger.kernel.org
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Fixes: 801989b08aff ("drm/xe/uapi: Make constant comments visible in kernel doc")
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> Tested-by: Wenbin Fang <fangwenbin@vip.qq.com>
> Tested-by: Haien Liang <27873200@qq.com>
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Tested-by: Shirong Liu <lsr1024@qq.com>
> Tested-by: Haofeng Wu <s2600cw2@126.com>
> Link: https://github.com/FanFansfan/loongson-linux/commit/22c55ab3931c32410a077b3ddb6dca3f28223360
> Link: https://t.me/c/1109254909/768552
> Co-developed-by: Shang Yatsen <429839446@qq.com>
> Signed-off-by: Shang Yatsen <429839446@qq.com>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>  drivers/gpu/drm/xe/xe_query.c | 2 +-
>  include/uapi/drm/xe_drm.h     | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
> index 44d44bbc71dc..f695d5d0610d 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
> @@ -347,7 +347,7 @@ static int query_config(struct xe_device *xe, struct drm_xe_device_query *query)
>  	config->info[DRM_XE_QUERY_CONFIG_FLAGS] |=
>  			DRM_XE_QUERY_CONFIG_FLAG_HAS_LOW_LATENCY;
>  	config->info[DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT] =
> -		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : SZ_4K;
> +		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : PAGE_SIZE;
>  	config->info[DRM_XE_QUERY_CONFIG_VA_BITS] = xe->info.va_bits;
>  	config->info[DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY] =
>  		xe_exec_queue_device_get_max_priority(xe);
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index e2426413488f..5ba76b9369ba 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -397,8 +397,11 @@ struct drm_xe_query_mem_regions {
>   *      has low latency hint support
>   *    - %DRM_XE_QUERY_CONFIG_FLAG_HAS_CPU_ADDR_MIRROR - Flag is set if the
>   *      device has CPU address mirroring support
> - *  - %DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT - Minimal memory alignment
> - *    required by this device, typically SZ_4K or SZ_64K
> + *  - %DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT - Minimal memory alignment required
> + *    by this device and the CPU. The minimum page size for the device is
> + *    usually SZ_4K or SZ_64K, while for the CPU, it is PAGE_SIZE. This value
> + *    is calculated by max(min_gpu_page_size, PAGE_SIZE). This alignment is
> + *    enforced on buffer object allocations and VM binds.

honest question: if it is vram needing 64k we give 64k alignment, otherwise
nowadays regardless if it is vram or system memory we give 4k.

what should happen with non-64k vram request on these systems? really give
the cpu alignemnt or continue with the 4k for gpu?

>   *  - %DRM_XE_QUERY_CONFIG_VA_BITS - Maximum bits of a virtual address
>   *  - %DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY - Value of the highest
>   *    available exec queue priority
> -- 
> 2.47.2
> 

