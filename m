Return-Path: <stable+bounces-132882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7602BA90DD5
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 23:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D129188E0FD
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123E233700;
	Wed, 16 Apr 2025 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m68bG7oo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41991FF1B0;
	Wed, 16 Apr 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744839100; cv=fail; b=Xu9n9W3q82WC4BGhYAqsYnGhaXCz7LzTUPYPHUp3HglI80AEwe0pV0b2OsvrgfOwS63v84ZvpVJAxYGgX5xADFptJLJKj3gmzm3w22+2tckaEdi0oCYPwIjyonGvoagg8Z3nzmHVAOssk9eGlnoqiGKUH5ig3qs6g2oGZTUmDxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744839100; c=relaxed/simple;
	bh=Lk/dftFmg+lr5vNr8jVXOxXl+/OxpLqU8Oo6zJIs9Z4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PdpMaGEJGznYmmm9DmYEhK4vjn3zGEvOFt5/exkrIHwS4rMlomNaKx9b0flezhDdOao2FTruVtSTumG2JfraFC9YWAdpBAi3RqUB62diNmE7JGY4iCkzaAd1jzBoKlGmTUe+AurRLV3rHnOKd0adFiZMu/9c3NTZWr+yQcrc45E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m68bG7oo; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744839099; x=1776375099;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lk/dftFmg+lr5vNr8jVXOxXl+/OxpLqU8Oo6zJIs9Z4=;
  b=m68bG7ooo722ZcfjyZjLKLizwmSl/C2f0DLcot+NfRyBerqgOiLN1ryP
   YfhfNbUl9hUyt7cdigKXB+BrIaQDg4UJbPShF0FGuaAytg2b0BOxyl8BF
   vU/Y5TBOrsr9SEvce0r93E/VbxlLcNGXnY/tZE9W+bbZCVQew7le4Brfx
   BJ3UWfmX5xKBnpRBM74ndF6dSN+b3TfcSMNWpjSfi22YAy8tJhAR4S+Nu
   V992FEIscNu5chpgDeYMX7pJWGJqoH3xWyUQzFCqJpjSZp3gnHxjcZWlN
   651Mw8xXD+S4ZHcIdaEduQD+Vuod/QPSo6tG5BcBn1qFyo+jIafOURqWC
   Q==;
X-CSE-ConnectionGUID: usZjAs1tTEu1+au28OEOWQ==
X-CSE-MsgGUID: Skk/exuwRfqQpWX4u6idYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="50216276"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="50216276"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 14:31:38 -0700
X-CSE-ConnectionGUID: XaFrZvAaRPmuXoHiJYJ7iA==
X-CSE-MsgGUID: dl09yShDSTORkAfJ7eCVaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="131504641"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 14:31:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 14:31:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 14:31:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 14:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXvKGGWHw3sukpXz/bBRKzMiEZ0S9NRarG89DPn5/1wPgY20WfP4G8Hm/dyCrsMXJg5iqoOjpPestZbEelJQosQO9CLburZWqeQvAhAibS/FiKcwYRli4nVApm+jBu6icmON1aiLushqmPZ5k9us6wl0QZMJTn208TK7nM2tMtcfyBAqLAbNJ9TtOU2bPbwRrwFYqOoM5oqzvL59tGSngLHtdvlbLRduocvRR2Gzligdt6uDcgG0HZ4o7tKE/mhJp25WJPjNer92IBjbdFGkqWdwgbp6Zq4aUOpjQEHhOMUmMEo8EzDLR9QQY8CLVvkXfdLDzCVzFR01LdFGGxc4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8J/4AH9XAF7L4LrBODMKftbqq91bCoLwU74hrX06FU=;
 b=xMg5bICR2XXpEtiX1WrGAd6JsgNttGUEo6rW0unDa5uAQDml4oxw/KEMlg4JJZ8Nm3xyosYE3K7VJZkLBAGpCQkZ/Yg/dN9RtqnZYEs2jnGDekwLah/EkHUNMX8XQbLMaypNj87DW773sT0aJhYa0KV3CZ+uOlgIBPh61QiuSn502yWLijE/zB6XH0oF+jhS8mfw5f9GPg7P6z/tmHN6Tk4MrCcgiYJC+iay17Nt9JylRG5KweazgXmN6hwPsZF4B/KAheil0PDTj0MO2sHRDAf/G7EQWXn8R03LqmFIywDzgDECyA90+BxL4mq4M3+alnwLHMWBH8U7Yk/rEDVbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Wed, 16 Apr 2025 21:31:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 21:31:00 +0000
Date: Wed, 16 Apr 2025 14:30:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Naveen N Rao <naveen@kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: <dave.hansen@linux.intel.com>, <x86@kernel.org>, Ingo Molnar
	<mingo@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Kirill Shutemov
	<kirill.shutemov@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] x86/devmem: Restrict /dev/mem access for
 potentially unaccepted memory by default
Message-ID: <68002191c4733_71fe294da@dwillia2-xfh.jf.intel.com.notmuch>
References: <174433453526.924142.15494575917593543330.stgit@dwillia2-xfh.jf.intel.com>
 <174433455868.924142.4040854723344197780.stgit@dwillia2-xfh.jf.intel.com>
 <l2crzyeoux2pammbifkivrhp637gza7piumd3s6j66mezsfvdy@nwczgs2hkq4f>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <l2crzyeoux2pammbifkivrhp637gza7piumd3s6j66mezsfvdy@nwczgs2hkq4f>
X-ClientProxiedBy: MW4PR04CA0378.namprd04.prod.outlook.com
 (2603:10b6:303:81::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1e1ea4-220c-498f-9333-08dd7d2dfb59
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jCq6OwB/8RN8XfQUUXMT+02vK8iVo5FHRN0htuZb0KtBwIzYkXScaEO19yRC?=
 =?us-ascii?Q?POtWFYhnhvZo18rFvheL4qGOEYyaUQ1DHESBirSn4+5h2/2VVkIHvhzGFyxv?=
 =?us-ascii?Q?888RFb2SCXACgjtU0zRqcoMlbIv0/brael/pFtjhZEe89gtUsau2sqYE8tYN?=
 =?us-ascii?Q?vGEWDlBX9qSb5oovZ4xC/dn6d7tCMmNc+zOcNwxQh8+8+paQgpRlhPV/a26A?=
 =?us-ascii?Q?utA/JKKrophH0dIFoGPuBF9juc9RFyTqf7sx24cBvTJkWzhl6gU6exryRoG6?=
 =?us-ascii?Q?cTWlhBvvLsEFWEA6IqFxqyKwo7Ilie0O7BodWr6f2r2F9VDq00pGT0ImBM3Z?=
 =?us-ascii?Q?Nd5rWgvpZSW19Qp1q1M+ap8h0F5mDNP09q7SOu+cMREHwwK5LJ5STJHm+TLV?=
 =?us-ascii?Q?Igc5mct7hokxBcjGwXj9wT9jZJC+PsL/1/kCtDyr4sVdzG6IFMsw+PZ0DBfM?=
 =?us-ascii?Q?3WYD8h1bScQKl8ov2VVoNnKOcV/DzpkZ4aMtj3t1XiPBcGz1PPIOKobUiRgW?=
 =?us-ascii?Q?LP0nOU/cOV5d8ARaNLOveRvkcsZ8izCaYvS28YV7tNT1Po6ZSdeZswkfynK7?=
 =?us-ascii?Q?0tlt+s2dDEsXoq0jY5DIUxmqutMRjBv4NaN+stt/itXGmdYot1lPRtNxo0In?=
 =?us-ascii?Q?1wVloa1rwNYv1kyMHTck8Bl+8OS5Eozd6AmPokmh8eMCHA4HCckJI8cSbRqF?=
 =?us-ascii?Q?lMJEwaCSgmbsUBLMctJBEjRPw+TzqYf/lD7oKiNxOohPrrO2vHAeeO+G2MVL?=
 =?us-ascii?Q?ZTwLHx6PcC1NbIg7SIDKBZLL17SxsZFumEIGFseyGh88MbLP8WwuxDEYx1Nk?=
 =?us-ascii?Q?PpTsASvNVriYZEhEwM2NSCIEvnuOK307+Ooxl0zzaFk96xSSIWYlvwquCXE1?=
 =?us-ascii?Q?iz6CQGXGVcDj0Ze5XJJqfT+/Z5xSulZFg8BAMaWZgo8Pz6y74vBWqpf2EIb3?=
 =?us-ascii?Q?ESat+umHNmJloBnRdsgldT8a333deGW+uocfuH0HakNN0xYf7CVVbFthlRGW?=
 =?us-ascii?Q?0VPYeUhbK8AeBbXavM+c31iVncDdlmNdHqwtqIDTFkLPhnY1dA7OFcnKhA8a?=
 =?us-ascii?Q?HyQ2bxyx91INbpTVwafLSO7xz0HHso9zkw+hWckz3ZJrR1RzRXgHPEpgrmQN?=
 =?us-ascii?Q?EOrvQYAYAKIRHFTg+honZX2pvwS8PyjvFI4vtDmwUQcPxm6QhlJPd+pcyRPf?=
 =?us-ascii?Q?mls8HnNjTjRSMJSzDJfqeiZqBk+cl6fbRIZYkEo19Rq5WwlbR4RKdlMhx2aM?=
 =?us-ascii?Q?fIKS9HSOPIHPKf2lRL1snbZ/CvNWG138xT7/po3bkgAnxyN/3c5pkmDUBEgs?=
 =?us-ascii?Q?iMKhqAq4I2yD4UNVA+cnr87TG2FLP159ys23OPArdh4K65gPEeN3NfYNppfj?=
 =?us-ascii?Q?2dgYtk71lRk8GHCqOow5YijSGVTBA4C4zBqpaawL9n59xJmeZfR80owX/yrt?=
 =?us-ascii?Q?TWNWMmD/Rbc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ETAo2IxjYPJ9Aq3xslG9kK5yQoYEzrzYjOG79nge4TnRex3Xsr4yG8CTZ+3a?=
 =?us-ascii?Q?MCO117zEhMm9jBwpBJYFDz4BhINb9y75m0D5ZtE7Vw/Jt0UEZaqunZjbR9XI?=
 =?us-ascii?Q?FauXQLUmYn9RLlAFSYAPyfN66Zp+4gzAKywRHVUSFuXPGf5P0mWDykf6geMV?=
 =?us-ascii?Q?/XRXS1xJUKuNZA6EfKCr7tNZxgIRV38sJkzqQeRk7fxbPytOjgHGLclXdPch?=
 =?us-ascii?Q?CDhFL25M2uoITUjYmJCEk2OKq/V+Nh7D1XRYN6kHJh0PIly3sGT1FSYX2SOm?=
 =?us-ascii?Q?c7K4WQBe1oitagMfuI0diQ04Wv9udOX4tQNdhAdb884fE8LB3r4enfCDqRx/?=
 =?us-ascii?Q?8X9g/gw1P44bzogvFNgDGupi9o06vqPQGO/wSaUrFoQWvXFWiHT/nhbmfnQE?=
 =?us-ascii?Q?hhNIT1ePDmcAYSgfIfawJUWd9QE+sjakGyf4+4Lovt/Pr4xlBzXhq/B27qy4?=
 =?us-ascii?Q?bybDcDx8fSSC6+M3SNGdrETVsR706r27LGDA2l6QdMUepQys4Ma1mJ5uP5xD?=
 =?us-ascii?Q?vfEIGLeltTAyksUYfyQIEawZ0+B7Yno9XB7TCfJBkemSOCOUsUfIqQZiJbO3?=
 =?us-ascii?Q?Eff47UntSqXeuggBc8vmTh0jqbY2IsuQ8jNKoPxmMReVaj213V7f8KObhTH8?=
 =?us-ascii?Q?a6HbyaDpTrZQ0O58Q+CpjskolaBe+Y/Qm9eKQ+r1xdcsDXeRvXdNrHGF/PhI?=
 =?us-ascii?Q?63KqkC5B3zth8i7bLS+fmqH3E0EFB1383YFN+qsMLENl7kFWjsE9SCbhZ0DP?=
 =?us-ascii?Q?W4K/dDdAILkJgmmGK7/9AnmBEPpOQzGr9eCp/TedDlGRBgDyT0IsWMqLovPq?=
 =?us-ascii?Q?5Rz4ET3FDr17vSJzSPXEWiIsr/Qzb7dDEM91/ymgY+R1ncVGAK3hR/sM5rjM?=
 =?us-ascii?Q?q5zP1VaQTD6Eu1tVxlT4v/hmFtDC1MHk6+yeu7u/27HKLccy+m1VXSe4LiYN?=
 =?us-ascii?Q?95ozdMZ0gqiQUsEenxIkCttM7ZNhyigjodliXYNIogbfywZlRGi81Kx2iGYH?=
 =?us-ascii?Q?lQnXLdzpu/zsdYQOXx7ZW/YzqCUk0QWX775HUAjYjWVFCd1swhvG9+qbyide?=
 =?us-ascii?Q?TdvJhEeyAbuINIeMTG4toAzQcGBwfHbuxMIX89AdUXQvFJCTnacP3o9xNHup?=
 =?us-ascii?Q?0MKNErSD6jS7n1BQv5dmbQfCWzsvBCvISZYT9Hy1KMptrObFqAIDl+mHZevG?=
 =?us-ascii?Q?ffjK17rkCAIMCabLnNXGUCiDHzRjZqrh1dK25BLcHtObuTQnUEMxWZgtvDee?=
 =?us-ascii?Q?z9lVHmoSefNDQwtUYiUwwMM1A9uCBPaN584tr6WtDJygw85rPRn4FtiT9D2M?=
 =?us-ascii?Q?hCGnClvJRpVIwItZrSmhwkZ20rtR/TI2wx/ytirxRi9liPLHN/VLiFZfgQgW?=
 =?us-ascii?Q?n9ogK7rNOnNnzPVZvEsqma+x9uTVhBEWJfKvi80dqCoXmXpM5V0+bAJFRX8f?=
 =?us-ascii?Q?tsiU7m9e3btbMW2sDw24snO8k/0xOD8mCRxdvWyG//wslGBt11diPEZ4mIjP?=
 =?us-ascii?Q?fK4T7x5k8RUTedSBxIKk8zcq0/ad2BAgzA0C2CIGWYNkUebbTrU5PA2UZkN2?=
 =?us-ascii?Q?s2gp/CRM4O6YxfCwk9URMSJiAJ6OvLupLbLsY0oGDbWhZdPSUg4tVjVyaSMd?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1e1ea4-220c-498f-9333-08dd7d2dfb59
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 21:31:00.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+FfDYQSGMIMLw/IuXMO9cOgbszY8qnRMnmA2QN3yoCd52XtiPW+Q/Bi1jie272guy7yHLCfeP1e2bwu1LOLQXa4uUk3PWRUH77e/LhEr7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com

Naveen N Rao wrote:
> On Thu, Apr 10, 2025 at 06:22:38PM -0700, Dan Williams wrote:
> > Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> > address space) via /dev/mem results in an SEPT violation.
> > 
> > The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
> > unencrypted mapping where the kernel had established an encrypted
> > mapping previously.
> > 
> > An initial attempt to fix this revealed that TDX and SEV-SNP have
> > different expectations about which and when address ranges can be mapped
> > via /dev/mem.
> > 
> > Rather than develop a precise set of allowed /dev/mem capable TVM
> > address ranges, teach devmem_is_allowed() to always restrict access to
> > the BIOS data space.
> 
> This patch does more than just restrict the BIOS data space - it rejects 
> all accesses to /dev/mem _apart_ from the first 1MB. That should be made 
> clear here.
> 

Agree, and per the follow on conversation [1] even that low 1MB access to
return zeroes is not helpful. Confidential Computing userspace should
drop its dependency on interfaces that are difficult to make compatible
with consistent encryption policy and acceptance status.

http://lore.kernel.org/67f98e27a799e_7205294e3@dwillia2-xfh.jf.intel.com.notmuch [1]

[..]
> >  int devmem_is_allowed(unsigned long pagenr)
> >  {
> > +	bool platform_allowed = x86_platform.devmem_is_allowed(pagenr);
> > +
> 
> If we are going to do this, I don't see the point of having an 
> x86_platform_op. It may be better to simply gate this on  
> cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) directly here.

That is fair, no point in premature flexibility.

