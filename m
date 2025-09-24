Return-Path: <stable+bounces-181586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2669B98EBF
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B794A4B21
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61749285C91;
	Wed, 24 Sep 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SErDcLQu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F3280CD5;
	Wed, 24 Sep 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703047; cv=fail; b=nAEmc/IRuETW5+MmuWAW1j3xqDp++Y+o91aci+QwF5yLN0TT33ai9NAT8yDyYZd0aSGqtxoGW/vOEAMH6a4eCdNB0Z/UdjifRBKL3jLcISuXzYz4x3EfhjNsUwKObU7BozT5IYjxKDvpDSXQQFkp1mWZfUAdaLUFhJ/5XUMC+lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703047; c=relaxed/simple;
	bh=q5NvqElI9aqplEguAc+BJyqE6RG2axmACAqQ9u2Or08=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWEGmYkqgS9lDFr/19rw8O7CBhJdRLQOvij+xm66ONiH6aWnLbeiJEolULayguLJRjqkAkWQqiY16QCTcnTum8WLPXZuWe6B/+gcJNMGjAazmhLbVhZQF2thl3giW1+DUr8+lObpEKRjIE1RdtjJBuXh8Fhjqyvg1I5K13DlWWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SErDcLQu; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758703046; x=1790239046;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=q5NvqElI9aqplEguAc+BJyqE6RG2axmACAqQ9u2Or08=;
  b=SErDcLQuLt6QoBVD4X71BF5avG1IYdHbCtjj8WmhiNqwHx+kK2lee7jT
   A0ca7t9AY8hY2nlt9vmTU4yF6TJFXtman6RL7AFQmlS4jtMghuUnhgn8W
   FjQc/PF166u/kpMXX0N5491bhI8KziaxjF1sLauKPG/Jw+ZHSUL9hFl8E
   AZHDOLDFFnuHDTc/xHn9bq7xgUAH+pLLZ9BeJej9rTnUDjOR3rnr+xnTa
   sf17j6I8iHFiW2s3PuT7curI+X6H7GCF5vlz4JAZOv3u7ioBgnb0EbQzM
   vJINKV49Swd/xb5fd7b4cqfOlXGJlQbBm0AM+/gB+C5lMN8isnIHuxJ4R
   w==;
X-CSE-ConnectionGUID: xiVy3zrVRBSBGwMYUZhqmQ==
X-CSE-MsgGUID: JUKISTOtSOKHb73fcrT4Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64800341"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64800341"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 01:37:25 -0700
X-CSE-ConnectionGUID: XQ4o4TirSJ2OVpIpmngiPg==
X-CSE-MsgGUID: OfGDnG4yS7KRXuerxzzlwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="182257228"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 01:37:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 01:37:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 01:37:22 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 01:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLNdzKp17wCOMM/KVpdHTQY+ZQF2/BpA7q1W8ru/s9f0fQjvOYsAQJgPoDXZYw9Tx8aQPuc8TG4J+i4onH+w3YWzX1YIjL7jXgWV+yNqsGGb2k7rp6OtBhINPGan0dhkyzCvl+aFqPdFl0qZOVz4UXXxtgB00Lv//GzbfhmOIlui99fP7qnoxB5tjDnXu95vw0/uAAUAktJILaZlVZvmiqINXEjNtwidlWJSKEU6GA6Z3xvlM2fhKw8UaWwvuSvIiZBKsJSPcNi/qvqnHT2vLl4lrqEgIEhjiQjjRGIVRvkaoFCLG/Dzwlu6cAZ0a5joLJOvzEJYLAFgu2XpyIsDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNWVB16dKjHNFQ4+/ZPDs+OUOIe6T03dN+7f/0ZdB9g=;
 b=PEfjHl8UyhmgtFfKVzOcaTXxz7V58rQyAP3dYXRpcU0QobrstXm6rX+oPPMAdc4S5QKmcvCeZ6DuXCGzAIm8Xoq6h7dg6CBtfWwSfcnNY5DrwWS65VTRiiKy4GfepLgJuz91UcmJrqGPTRF6W/EiaHDalmm3onMIZtgXJrAdMrwBeEcfZ5HEYf2Jj0ChheNx5J0Dptp/Bcg57hijI5r0TGCwV450CqBPX+iG7M2U45rKyEP2yXhhSapBBy7x/KVOXhg2cWuHnIB/P6u8nmQI9waEMnB7oeOnAKvKCJGrC3+HR96fdF/hJzwoNJdZId01Kv9FkB9c/4Qc045/bUCiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4688.namprd11.prod.outlook.com (2603:10b6:806:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 08:37:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:37:17 +0000
Date: Wed, 24 Sep 2025 16:37:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <hariconscious@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>, HariKrishna Sagala
	<hariconscious@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH net RESEND] net/core : fix KMSAN: uninit value in tipc_rcv
Message-ID: <202509241629.3d135124-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919183146.4933-1-hariconscious@gmail.com>
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 70684dfa-11e8-43ac-0514-08ddfb459130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?HzudpmxkAFShNIUCOdzXNGPr9K5qmmpnj7XGErWlTZ6vN0eQix5Rsl4v9k?=
 =?iso-8859-1?Q?Z5jYtazEmbm1sSsoly1AiWEtZfhGCiDj30gRKgInbGa+4iDHPylq6aIiBQ?=
 =?iso-8859-1?Q?ZGhRDZ0LGHr1za1PXNyuKXYp4TJTAFhE6/PgdmFKOL29JA1DTiQk0ZlVz6?=
 =?iso-8859-1?Q?nobQeBQZ8lkHo3okXhRHF1v4gdOZPoMbB/Yqi9iK2DgeZhIuVLkkdWnjoI?=
 =?iso-8859-1?Q?wjCXsDjbJHJV4imyhh5K7IrvV8gUePKMqOvdQVYZvzJniKxN4sY2yb+bzz?=
 =?iso-8859-1?Q?Rv4QhCTrf+S1G4fk1/PQ9lImLwoRInJcCBnv2xw3T7OkvBgvCJoayv+KZB?=
 =?iso-8859-1?Q?cblq5DBUn1ux1CxrfhIOVTviKYt39anc56kILViMfh5tfFwb91EyurRO0K?=
 =?iso-8859-1?Q?EW1/rFU93QL+vCibDNBVQAffqfYbfyBLeWoQoYC8K2fRE2GF9c7KelRwbx?=
 =?iso-8859-1?Q?crrRbepBIOtHPW5u9yQRKA4V8JXmG6MmOmLM4CPnXyGQ8JB0PrNIBa2Oa1?=
 =?iso-8859-1?Q?oZ7TuVV125UvtDHgd38ND2WhRL6oMQ/Y9GmFiW21+1RxQFKfu0Xp/3thof?=
 =?iso-8859-1?Q?lEA1n+QsXudq7DL/qkYIdKTlGxN399PpPQ6woVBNVUt3Z49jPr1Qv2IGir?=
 =?iso-8859-1?Q?nDh3Ek6LfzYBimThy7RZ5TkdR/0ZpqE/UAAsdkNdbfFFngO3dO6Y0v1FLG?=
 =?iso-8859-1?Q?MkXaMohIJJBsMSc66HUdqnAlGBwkFzEBOQP13iCn11h/4fECRkDFYg41ba?=
 =?iso-8859-1?Q?f0MXVB7/Wg3geN5dWquOKGC31uQiyBD/TmtBn+/Ry3qmiI6WMFKEq5wDdz?=
 =?iso-8859-1?Q?qx4nZr4vmmT3xVoypP+n34bhRPS0NQb+06Q/3omtRydty30SBmzuFh5WKz?=
 =?iso-8859-1?Q?NWC0WDkg4KDv/NfDny5Kb8ryJ/6GjMdWzd3grWHDyPR7KXzAXtshDx8R2Q?=
 =?iso-8859-1?Q?FpLQEqARxtMDJjDeHT8r4IGiHP6siE0V/TaFnbSCc2jAsAW9v3T6QrmymR?=
 =?iso-8859-1?Q?hXr6H8ED/07fKzQXrjhe0O8rC11R5i9oMREkDr/Zn31D47wAYxEuj2YqyL?=
 =?iso-8859-1?Q?goJiIXeJmP8WyERnjuYYpxyDmCtYhCrLNY9L+477PdRIr2eT/w09cczulP?=
 =?iso-8859-1?Q?fMUoY3ql+dWP9/mnkZoSvn+j5beoTSNhoW9Spa8jPpRTLL5Fi+TF6yHRkQ?=
 =?iso-8859-1?Q?ktt6c5wEfMZ95DMMJTxWNl1gj8LbF+QlI8/TVn4WokbT+inbvMUw38frZk?=
 =?iso-8859-1?Q?8GgNbAyOMOoK8Ivzc+34tbJ1F7kGA5ELxH1T/5vSdh4/XmTo7jZ1EBJR4z?=
 =?iso-8859-1?Q?S/ZS044pXd7NyqaTdj+8AK0V4FM3poutJoDYc74mkTQDY+PWlb2XbOtOZL?=
 =?iso-8859-1?Q?85PDjZ/pmj64csFtfe9KYMZKzxfwKRneq24ravghiWUZNVQ+F+WzCiz/3z?=
 =?iso-8859-1?Q?yZDtm6BoLd0QJTxF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DnjVjeaXrxjKb/H5U+zSfhu2Cpk5h5LmVOPC/VGpObdJJW1+n6q1oacbg2?=
 =?iso-8859-1?Q?ItQEpQ85Z83pHnJKqBWsFWbGJN1nlq20UGrmvLQpyRWyg1aKb4Nq4Pu9tc?=
 =?iso-8859-1?Q?3NeQcKpLl/h2fmhiY6ySNv+FQj0MKGoCo8Dg61zmvzbwXjIKWb7tJehFvN?=
 =?iso-8859-1?Q?Dt9zH6nq3BME6OKSndNDsqwO1GsjLeZJ21q67uNUQpc1f4Ie4Zwuhmf7cU?=
 =?iso-8859-1?Q?GJpo9gGr0glOOXq3f7uubJr7uDZqTKv7oa70563gb8CTPQv19kBrIWMKhZ?=
 =?iso-8859-1?Q?qiCQrTN+cYxeFSq96zlPvWvMYgtW6dOEVjRh8QyHGpztm8EMKhKjR75nk5?=
 =?iso-8859-1?Q?SP68SoKjuz3vZ0y30p5Aj5Z9IdSf6XECYIaCqtJ1czYXE8KL1tgTpxTABd?=
 =?iso-8859-1?Q?ikRWnyLfbazP37i/4KLLKXB7vDjSTZh3zdkD2LWSmi0XIw3vyt8QyL+YTC?=
 =?iso-8859-1?Q?s5rvSM+uJtss/WcsNwUf0ImEyhAOI0kobLPFAGDaxSaEVKwS+hs+LhbfYk?=
 =?iso-8859-1?Q?MxowiJEIzVjXN1WgK3id58rCdMk8wKWKpS5QcsN2O8iiDRKFifqXNC6SFq?=
 =?iso-8859-1?Q?nOPmqjeSbiEzd4h9SaeJVVCHz6LzohwWYR/CVbqjS3Q0zPtESW3TVViyic?=
 =?iso-8859-1?Q?tTQxjFuOoaqP4FCk/v/nsb+2JdR1Y+NnRKSfsaPU95Alq8RCTJ1pAZBPhs?=
 =?iso-8859-1?Q?suCQpJkBtRdwRx1ruki3vW02Cvks31ncKcJaLnf8Kv8Y3OnOCtphTSg5qv?=
 =?iso-8859-1?Q?q93+KQ8krQqxzSF6b+ydaJArzzhzjYdgPERm+hdB/Faid4dd50zub+nxEt?=
 =?iso-8859-1?Q?6K6z5lnwANZvhQFWgM/p7POcOJOAKkj+nfBDAkPVSdPppXLVnbW19rFFSp?=
 =?iso-8859-1?Q?41RVRbLXMfYzs11EJL1XQK7d3cYo2jOUc2RU/8Yw/3/a4C8rJCXbqCIZpN?=
 =?iso-8859-1?Q?GLI/cqTGNKmhka88/IPsQU924t9Qqv/5vhvopInSSK17IZnjI7VVszkgoZ?=
 =?iso-8859-1?Q?IJP2rWPgsZyCnGSUcILF4bJLiYta6EXQyLTG0nPDqkkgqnzO8K9P6ooZ5t?=
 =?iso-8859-1?Q?siTLZipNeVcv8SS/hvJn8QzSqXhTm5+XGrgPhXq6msHTCYFRGD9EDA64bM?=
 =?iso-8859-1?Q?Wa3XXgfo8Jqu3HU1pKbcgoYlpEUHpiTEg8eu1JI1kNNZng2qyQypIyrWuE?=
 =?iso-8859-1?Q?R6TG9lGKUzjQ/h07DnxEU8hCu0SxVngH7COkFtYtnRLAots/c5VAO3UjTb?=
 =?iso-8859-1?Q?7p9IhAQ5V3gtRTWxXFkdNp83Ibl3W1Vq5cEgQp/ZvPrqrE3BXskDgT8ZO/?=
 =?iso-8859-1?Q?OBPE41EB84IizB73fL5MYKCgECzpCgAl9gFI7+rvR5djCiUajzUYi/6TIN?=
 =?iso-8859-1?Q?YbEnmFJAmXMz1c+fEgGrzI8UKMYAfKX3gberBV+aprOHVPCZbqnNZhF/ab?=
 =?iso-8859-1?Q?naRM2sEFHaqTaQecKt6TBIsZYoveDnsO/cVr7cP/VyUIXoCaAu8nV3cPRK?=
 =?iso-8859-1?Q?Pl3KwlCuLOVqeCrIJ6wQQsudkaVwX5wzkGvsx66S4uKwkG65Wn/e7dkfgV?=
 =?iso-8859-1?Q?ZajDbW4q4ilnQq8bncg9HVICsToLlj0fFcK3titcBGR3FSp3B3ggK/ZsnO?=
 =?iso-8859-1?Q?ARrWV8qNlRgFVHWCS0T9PIw+z/8G8sv6fmSyurnKqfBZL36G+ZxnoQzg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70684dfa-11e8-43ac-0514-08ddfb459130
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:37:17.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13PF45tA5/inhX1aTognJNlAqxzaZAMPv6WnkdZDUXze9pHNmG208Af8tWbQ1yNo0NRKXxnytrfkzKkFoJZiTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4688
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 33.9% regression of netperf.Throughput_Mbps on:


commit: 5cde54f8220b582bda9c34ef86e04ec00be4ce4a ("[PATCH net RESEND] net/core : fix KMSAN: uninit value in tipc_rcv")
url: https://github.com/intel-lab-lkp/linux/commits/hariconscious-gmail-com/net-core-fix-KMSAN-uninit-value-in-tipc_rcv/20250920-023232
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git cbf658dd09419f1ef9de11b9604e950bdd5c170b
patch link: https://lore.kernel.org/all/20250919183146.4933-1-hariconscious@gmail.com/
patch subject: [PATCH net RESEND] net/core : fix KMSAN: uninit value in tipc_rcv

testcase: netperf
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 100%
	cluster: cs-localhost
	test: SCTP_STREAM
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509241629.3d135124-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250924/202509241629.3d135124-lkp@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-14/performance/ipv4/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/300s/lkp-srf-2sp3/SCTP_STREAM/netperf

commit: 
  cbf658dd09 ("Merge tag 'net-6.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
  5cde54f822 ("net/core : fix KMSAN: uninit value in tipc_rcv")

cbf658dd09419f1e 5cde54f8220b582bda9c34ef86e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 5.164e+09           -14.4%  4.419e+09        cpuidle..time
   1504152           -12.9%    1310310 ±  4%  cpuidle..usage
    125501 ±  2%     +19.6%     150094 ±  3%  meminfo.Mapped
    401239 ±  4%     +18.3%     474475        meminfo.Shmem
      8.63            -1.3        7.31 ±  2%  mpstat.cpu.all.idle%
      0.42            +0.1        0.52        mpstat.cpu.all.irq%
  1.96e+08           -34.2%   1.29e+08        numa-numastat.node0.local_node
 1.961e+08           -34.2%  1.291e+08        numa-numastat.node0.numa_hit
 1.943e+08           -33.3%  1.297e+08        numa-numastat.node1.local_node
 1.944e+08           -33.2%  1.298e+08        numa-numastat.node1.numa_hit
 1.961e+08           -34.2%  1.291e+08        numa-vmstat.node0.numa_hit
  1.96e+08           -34.2%   1.29e+08        numa-vmstat.node0.numa_local
 1.944e+08           -33.2%  1.298e+08        numa-vmstat.node1.numa_hit
 1.943e+08           -33.3%  1.297e+08        numa-vmstat.node1.numa_local
      1386           -33.9%     916.08        netperf.ThroughputBoth_Mbps
    266242           -33.9%     175886        netperf.ThroughputBoth_total_Mbps
      1386           -33.9%     916.08        netperf.Throughput_Mbps
    266242           -33.9%     175886        netperf.Throughput_total_Mbps
    476071           -18.8%     386450 ±  2%  netperf.time.involuntary_context_switches
      6916           +26.0%       8715        netperf.time.percent_of_cpu_this_job_got
     20872           +26.3%      26369        netperf.time.system_time
    117319           -33.4%      78105        netperf.time.voluntary_context_switches
    115788           -33.9%      76498        netperf.workload
   1005775            +1.8%    1024121        proc-vmstat.nr_file_pages
     31705 ±  2%     +18.6%      37602 ±  4%  proc-vmstat.nr_mapped
    100398 ±  4%     +18.3%     118736        proc-vmstat.nr_shmem
   9211977            -4.0%    8843488        proc-vmstat.nr_slab_unreclaimable
 3.905e+08           -33.7%  2.589e+08        proc-vmstat.numa_hit
    226148           +11.7%     252687        proc-vmstat.numa_huge_pte_updates
 3.903e+08           -33.7%  2.587e+08        proc-vmstat.numa_local
 1.164e+08           +11.6%  1.299e+08        proc-vmstat.numa_pte_updates
 1.243e+10           -33.8%  8.227e+09        proc-vmstat.pgalloc_normal
 1.243e+10           -33.8%  8.226e+09        proc-vmstat.pgfree
      4.20 ± 13%     -50.0%       2.10 ± 11%  perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      4.20 ± 13%     -50.0%       2.10 ± 11%  perf-sched.total_sch_delay.average.ms
    111.28 ±  3%     +10.7%     123.18 ±  5%  perf-sched.total_wait_and_delay.average.ms
     32792 ±  4%     -16.3%      27444 ±  6%  perf-sched.total_wait_and_delay.count.ms
      3631 ± 10%     +24.8%       4531 ±  5%  perf-sched.total_wait_and_delay.max.ms
    107.08 ±  3%     +13.1%     121.09 ±  5%  perf-sched.total_wait_time.average.ms
      3631 ± 10%     +24.8%       4531 ±  5%  perf-sched.total_wait_time.max.ms
    111.28 ±  3%     +10.7%     123.18 ±  5%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
     32792 ±  4%     -16.3%      27444 ±  6%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
      3631 ± 10%     +24.8%       4531 ±  5%  perf-sched.wait_and_delay.max.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    107.08 ±  3%     +13.1%     121.09 ±  5%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      3631 ± 10%     +24.8%       4531 ±  5%  perf-sched.wait_time.max.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    201981 ±  5%     +34.9%     272400 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.36 ±  6%     -14.1%       2.03 ±  5%  sched_debug.cfs_rq:/.h_nr_queued.max
      0.40 ±  4%     -23.5%       0.30 ±  4%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      2.25 ±  3%     -11.1%       2.00 ±  4%  sched_debug.cfs_rq:/.h_nr_runnable.max
      0.38 ±  5%     -24.0%       0.29 ±  4%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
     20700 ± 27%     -42.3%      11950 ± 12%  sched_debug.cfs_rq:/.load.avg
    201981 ±  5%     +34.9%     272400 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.28 ±  7%     -18.1%       0.23 ±  5%  sched_debug.cfs_rq:/.nr_queued.stddev
    350.87 ±  3%     -12.8%     306.09 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    335.58 ±  3%     -20.3%     267.63 ±  5%  sched_debug.cfs_rq:/.util_est.stddev
     21.08 ±  8%     +47.3%      31.05 ±  3%  sched_debug.cpu.clock.stddev
      2128 ±  7%     -15.5%       1799 ±  6%  sched_debug.cpu.curr->pid.stddev
      0.43 ±  3%     -27.4%       0.32 ±  5%  sched_debug.cpu.nr_running.stddev
      7223 ±  2%     -11.7%       6379 ±  3%  sched_debug.cpu.nr_switches.avg
      4597           -17.4%       3798 ±  2%  sched_debug.cpu.nr_switches.min
    129.49           +86.1%     241.00        perf-stat.i.MPKI
 8.424e+09           -42.4%  4.852e+09        perf-stat.i.branch-instructions
      0.29            +0.2        0.45        perf-stat.i.branch-miss-rate%
  17058270           -23.6%   13026512 ±  2%  perf-stat.i.branch-misses
     88.13            +2.9       91.01        perf-stat.i.cache-miss-rate%
 3.228e+09            -6.3%  3.023e+09        perf-stat.i.cache-misses
 3.654e+09            -9.3%  3.315e+09        perf-stat.i.cache-references
      6871 ±  2%     -16.7%       5721 ±  4%  perf-stat.i.context-switches
     22.00          +103.7%      44.81        perf-stat.i.cpi
 5.596e+11            +1.8%  5.697e+11        perf-stat.i.cpu-cycles
      1398           -20.9%       1105        perf-stat.i.cpu-migrations
    188.57            +5.6%     199.20        perf-stat.i.cycles-between-cache-misses
 3.807e+10           -40.8%  2.255e+10        perf-stat.i.instructions
      0.08           -39.9%       0.05        perf-stat.i.ipc
      0.07 ± 43%    +152.2%       0.17 ± 19%  perf-stat.i.major-faults
      8762 ±  6%     -11.8%       7728 ±  4%  perf-stat.i.minor-faults
      8762 ±  6%     -11.8%       7728 ±  4%  perf-stat.i.page-faults
    103.32           +51.1%     156.15        perf-stat.overall.MPKI
      0.24            +0.1        0.31 ±  2%  perf-stat.overall.branch-miss-rate%
     88.33            +2.9       91.19        perf-stat.overall.cache-miss-rate%
     17.83           +64.8%      29.38        perf-stat.overall.cpi
    172.58            +9.0%     188.12        perf-stat.overall.cycles-between-cache-misses
      0.06           -39.3%       0.03        perf-stat.overall.ipc
  83258790            -6.9%   77496361        perf-stat.overall.path-length
 6.993e+09           -40.6%  4.156e+09        perf-stat.ps.branch-instructions
  16501261           -22.8%   12743483        perf-stat.ps.branch-misses
  3.25e+09            -7.0%  3.022e+09        perf-stat.ps.cache-misses
 3.679e+09            -9.9%  3.314e+09        perf-stat.ps.cache-references
      6755           -16.5%       5642 ±  3%  perf-stat.ps.context-switches
 5.608e+11            +1.4%  5.684e+11        perf-stat.ps.cpu-cycles
      1399           -21.5%       1099        perf-stat.ps.cpu-migrations
 3.145e+10           -38.5%  1.935e+10        perf-stat.ps.instructions
      0.06 ± 34%    +195.2%       0.16 ± 20%  perf-stat.ps.major-faults
  9.64e+12           -38.5%  5.928e+12        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


