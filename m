Return-Path: <stable+bounces-164603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FDAB10A75
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718203A2CDA
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803822D3737;
	Thu, 24 Jul 2025 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJ+QYjaE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02712D372E;
	Thu, 24 Jul 2025 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360900; cv=fail; b=YqfqauQGF4ujqu5T8ekk2K3hOw/hIgAUCsIwITsk/4kSoCcMxmnaHUpGONvbNJAD8Qc73gN/Og9iSkDDPzxpfCfyDdksNcdMFYMSsdXtKYcNoBbQyoh5q2o3VMNQ74nRSFTDBcj05OfOjeoDZ4nPLXiuPi+WTyImkbZZ4m8/0BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360900; c=relaxed/simple;
	bh=zn0HV6eiOj0Np9yTShMMHqKUUU7DZ+sL1TA8kaMxlzw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fj9/ViaW+zr8K24hrPFvaQtmnzh1qYt3nTQdvth49O7Z6qbVgOxpkSORCmVQD9HiuTDPozf6JpnyNe3HEGHMI54Bj8pe0zqfDwjEaNJNL46PnwFOTtxgMfZi7pJbeyz95X/kl++NQFIMrYnd0X6aw0ozc3rrzCdcfF9hBFrYces=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJ+QYjaE; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753360898; x=1784896898;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zn0HV6eiOj0Np9yTShMMHqKUUU7DZ+sL1TA8kaMxlzw=;
  b=mJ+QYjaEp5Ayq/8GgwsYc4NQq35Y4lNjz6MwvTM4A44xTZqrL7hWOdJp
   8w+OE2uyH1zNNIBt+WNb2EMuio0VCJlLyKYOg8kabWWzbe6ti+Oe4MiIl
   ZMoWkpoOfGC3oLKUZ1++fwI538kEzLieg6X118rUgoP1NZhaQzthOCBX6
   s7lEknJ7R3mVdebQrQnFMZMekQOa2Q4q/gR4SO89vUdOox8mBJ4zGR24s
   bDqyWrTmtYRQIWGMLf66ZJ5G3Qb7xIbK+23cFwoBWgvndI8qrazpbSg4N
   N/goahXxq7McesaJg+waRTdCFjHjNn5mNG1ppeojrev0N9kDH+2uqcq9l
   A==;
X-CSE-ConnectionGUID: Y2moGYymQpexIDPnF5GQcQ==
X-CSE-MsgGUID: w94nnIwfR7mCcFVLtrnFAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66746636"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="66746636"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:41:37 -0700
X-CSE-ConnectionGUID: 5KUWUzO4RWu20+lW6oqUiw==
X-CSE-MsgGUID: wrtWZ1u7SSKl9qZ6yL/hUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160493063"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:41:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 05:41:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 05:41:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.79) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 05:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXQ6XGBZVq8VKetX1VO/cfJeEfkSg0TzV0Z/QOyZ6XAJCN0Ehp6/Hapyr6SN+6r7hk/uZcuHlUOs8RnFF2ak5cuWOwxuIjHYvc+t6rNOiPB91gHBVAc/b638eK89SS/Y4dx07HjKb7VB76z+upSug0XcW4+ySlBSEOz5H4+qJrl+wNS6AKyATDWl3kcfvTBgUGkeCy0jLgbV8h9OnQl7NwbOhEQcPz3/Ei1m6JZGi0EQHXZiW88ZWSD8n9p0tmSugypkPGlT+3n9aWSG8NxsTMccBFNLob2rHQ5zovux3Bh5cHLBtyL3rdZco+ZclnDO8N0Qt5mt57YWqrte+lA1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCg54KHcMJfEEn2KS3hAaDVmUkKPTOWl5eQr/QsxZn0=;
 b=vfwtQVMwfJtWHOwXKym6T9H5UxkY/eEUGpUX1mHuY+ZCrjFmnMUfggtlUZPJ0xVVVg6sTgGfTRi1OihGv24S7EqvAOpDT61JTTGPUBYInFB4CkdYIU2GyAv12pcmVJb8rDRF1u037Gf3yTqK5UvtIMq3hFuK1lrZgg4Dl1Ti2sKiqzQrGPOiaRZlP5gHowrAcivqg3SLYj4d75i3z0wSEKilDVgbMwomTVo9kgILP7W5S9s3oK84YcX7EE8ZNunnRlyzRosyyIrAW6oicbkUDkzop2wfRZCnHAw2UV+kSMw4sBi0BqXQ6qsbdAWt8O7jgbekrXzxrO4PZBoxVmFaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by SJ2PR11MB8321.namprd11.prod.outlook.com (2603:10b6:a03:546::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 12:41:34 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 12:41:34 +0000
Date: Thu, 24 Jul 2025 14:41:27 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Greg KH <greg@kroah.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
	Kyung Min Park <kyung.min.park@intel.com>, <xin3.li@intel.com>, Farrah Chen
	<farrah.chen@intel.com>, <stable@vger.kernel.org>, Borislav Petkov
	<bp@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3] x86: Clear feature bits disabled at
 compile-time
Message-ID: <3byjofiuvo65bpw6rahw2ncn5qu7gskip5cysvil7yksigaqtp@ukknbspddcsg>
References: <20250724104539.2416468-1-maciej.wieczor-retman@intel.com>
 <2025072440-prepaid-resilient-9603@gregkh>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025072440-prepaid-resilient-9603@gregkh>
X-ClientProxiedBy: LO4P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::10) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|SJ2PR11MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b32cf9-2da8-4664-2ef3-08ddcaaf6c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?jq1tUyPwpR53tjXix0CJNkjF2U3NJ+eJ5N1puQs6eWidVKs5atwIuwOXNW?=
 =?iso-8859-1?Q?lmsY33OveaJhuiMSmvxxk2krZFNXH2R3P9eE3WnmTkA2AjxISWqz8e9Y8f?=
 =?iso-8859-1?Q?KRyHpFQFaldY5Zg1UQ9hDdj8xCqezq4EJ8qLRo+LYmWJQuClVLx+HLbSrs?=
 =?iso-8859-1?Q?NkzdunZJAQFFagWYZaHS6ZSNUo9JZJoz7Ud1St9YxkIq5vKw2hfLbijjaH?=
 =?iso-8859-1?Q?88fcYKf/IzHbA8bbh22ApQmQ8vCqlCSN8SP30hB9N0IsGw6V9y5u2lnUtf?=
 =?iso-8859-1?Q?Qu3fKKK8F/vp3lYutuS+I0OzuovW0All0nxWIWvdqIqgES30vXC92fCcl6?=
 =?iso-8859-1?Q?LjbmjYOiXEMScVPLbXrDFPXxASJYwRTATFirReMn3WLPlzGdfTQHeHJ/yl?=
 =?iso-8859-1?Q?fPRk/J+tMU2DN3WteR8RmBhNp0u4aiLFOHRMoHdXQCAgDxE/0mGRxtW/jF?=
 =?iso-8859-1?Q?7wDy1uyEGw+j6OZHhLH8OsqQz+ybHqH86Qo+Bkgz1T6V18wtxhMSOl/pzx?=
 =?iso-8859-1?Q?RR7TgWgFF3a6RMkD17XW/B2EkBri07N2io0Va+YyK7nCewaFDJtJvYPIhE?=
 =?iso-8859-1?Q?eQ5hvsZlt87xOtDAl6uElEg6g5yHnA3qd5mjpX/YaeFqMWwsBV4UDiPQxI?=
 =?iso-8859-1?Q?o9U3nqPS0vp8/HHTv3YYLk2ArsrC9pzgxVAC659yJmwqyYI2hBjfz35S3p?=
 =?iso-8859-1?Q?11KS2ZwlbXl9/ECyLn2zb/jebdEXEAnd2pESSw8S+Qt4p7MS1zpyDJlwbe?=
 =?iso-8859-1?Q?4zkZKVCuDyGuoWvK1adIl471CCyFSSuMkZGLnTAvMX8aOq9ZsF9+dIKx7B?=
 =?iso-8859-1?Q?+0QBXs7HLmzK2z4/ar7ALpPFoF9UOlojpYUKlfrqSVPLvb/ZUMDI9KOtza?=
 =?iso-8859-1?Q?wRdl1FahanvYES3s7ibcLaNM+HY+eSrTjdbyHeeAB2sHIgpaRdt973SHKr?=
 =?iso-8859-1?Q?crINHNsLYz6fnpOzmKoLxsAao7Z51fyDSbBEONXtgGyVnwQjwJrhCjVpms?=
 =?iso-8859-1?Q?x0GqnfE9syMmYSSWIhCFkVJ1a+9gej4ElX3TKBVpQYNnIZZHl151fWAe+s?=
 =?iso-8859-1?Q?TCJCZ+JOEo1sfhmoaM27+5GWPvLIQ0Mcx1OFeSRXfxUuMvWMM+Jty8RVsf?=
 =?iso-8859-1?Q?y/PhZZuOm/18yalpyLdNFzR8AuJcykNf6s1+iqptwCAolsVo4bYCkEoPaH?=
 =?iso-8859-1?Q?/DIqvHgQ4hnknZJPb22nVDNpa5ebMAR8Z2HfFt6V+b+ePSIjBixum4CMmb?=
 =?iso-8859-1?Q?MSQMBRf6G8+cHkR9ZNCAf61W01UeFsipee8Jw19fM7+g6CIE/uvuynsnG+?=
 =?iso-8859-1?Q?luPN8PLo095PjDhN03w0Opf5fLf/ksMydBCJ7KcB9xEz+biw2RpdE9k1+E?=
 =?iso-8859-1?Q?CEkbA21Gw3qsgkFaTfwVBk3EExH9RdrGIptPG/bnqZn05NoY6w0MDSQDl6?=
 =?iso-8859-1?Q?82olAD80md6MOW6slcdDp5cY2J4JeeY6o3rCJGVC06WKCq7YVFP7WIMILA?=
 =?iso-8859-1?Q?M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dUjcn17OgfC55k9g8U4dLpw8m7qcYD8tfiGYOGWEGz1pz4yKAdVl1h8rjL?=
 =?iso-8859-1?Q?HiDWD8xZrEJPEJ1iv0v4Gn89mu5twuuyzJny1o/oXZtDY2imZ8avUmpsfx?=
 =?iso-8859-1?Q?0AQrSZX6kiUeEPZP+SCrOUeXWgHXqzEQ+5fs09TM83bDSrsH4UZvfk6MQC?=
 =?iso-8859-1?Q?j8uLlcsKe7p1GEuhCuS2jlddeL4IrOYNx7FE9v64zMn9FB2uwVHrRZS4rK?=
 =?iso-8859-1?Q?A0L4QgHqonpAeYEy3t59Hj0HgBgr4nYIQtNwnvQ1FJDghclyXqX/8ybrZU?=
 =?iso-8859-1?Q?bvqfafFV7gxBjEXVqbBveuxX4dYzyUIUy5rOMUQR5eA4gMlJgWwJFvjnSv?=
 =?iso-8859-1?Q?X20w9RAvRy/c0ZE0hPac+7m2DPvXfWNIL78FNifzZK1cW1Uali/uoud+2N?=
 =?iso-8859-1?Q?jKfxweJUiQdxA3wJpNNXLHMsRGcCkfg0LdaAlf3mtVOL4CL9uxhL5K2ULR?=
 =?iso-8859-1?Q?haeH+SBEgaPEr8uJpiwJydh4sCcKPdGMWWhL8rFHNaxnSsVgpn0rstwjWn?=
 =?iso-8859-1?Q?eI0LGSz3XRJPDyBmCphE3TOG0pQeYKkkYzR7KlmptNUquxgDLHTH+4IkD0?=
 =?iso-8859-1?Q?JuJGUhez3XBBwjfgcgAUhbdgNsToKnjUBYWszA3YMZ2654A+haDKXVfydd?=
 =?iso-8859-1?Q?BdF5qbTNWz+41G9F3Hm5ZAqsBO6I73dJenK+lYLCzSmSLwOLPJ/Nn1ec/B?=
 =?iso-8859-1?Q?mMJXQ8TBv70BFzJdE67KvcOMR6zYtoNE+2gUU5PRfwT8u4lqvWsoT68QTG?=
 =?iso-8859-1?Q?hvt3Hrq9wur5jF0u6372YkSwQSHgGmGoho6B4zeCtUWYqXnu5AKOBtm8iN?=
 =?iso-8859-1?Q?c4vexyHdLc7jI37mKkPKiUIRlyj7HZaOx07z0M6IdIgRQ3/cP8+nUsS5K0?=
 =?iso-8859-1?Q?58oBxj2F7dvbmPIIrFRLafiF9rxQLjDsJAAamdLH2987v0e6umQKE4IE9I?=
 =?iso-8859-1?Q?dYfCJTDOeDENQ7v0FS0vYfhjfHJEEJ7SV5NLiU4VaR+1bYa9o/dyTm/l+4?=
 =?iso-8859-1?Q?fCXsuMZF6mynInn+/rnzZtfThNi+KyZ28VtVS6P5PgVF8mBCFe4QeEdZS2?=
 =?iso-8859-1?Q?faNpzCYUZsn+jnloa/XOikfRl+I/WJhoKPQjQMMwJwB1xQ3h+Rcr9aoALO?=
 =?iso-8859-1?Q?5rRPuWVNrdDkucd7jkdLGxqNr7Gj9/Rdi1GInFxu63KFHYU/pETW7vcvVH?=
 =?iso-8859-1?Q?XegU6pIlJgDgy74sXNS5g7CLpjExezZx6FlAdnIdpgvxm0zFMnXd2DreLT?=
 =?iso-8859-1?Q?kEJVw09HQy+n6RLxU/bJn9cVNg4c4qFFeoONp+KmAqdZSrfUz7n17hhuaw?=
 =?iso-8859-1?Q?vppQhyfdE+uMKz2THUtc31bRQIgsGbT5+Sr1EihVnmMHh03+fyhRvlbiyo?=
 =?iso-8859-1?Q?r5/vkTuKqk0EO6azd2z43/Y8l26giOsE2+u+MYEklwYxIjG+aJ9j2aJRr5?=
 =?iso-8859-1?Q?dSVCNFVGlNxaLxhIUfW7RdYwaa0Bco38VjZdrRrmvQZYh2iatkDfhdW92s?=
 =?iso-8859-1?Q?usBm14rPB6oA/bYLRw+VcBqdlkvF4tWNtXNjpv5/v/v95NbBXMw1kErEjK?=
 =?iso-8859-1?Q?oOGRHyASc2j+sF+2l9pJ3YACKit16vO3NacRA9A36kJEF9dB1B49pnsJlC?=
 =?iso-8859-1?Q?vQFyGWkKgcB47605IbcsYymw5+rOLJSTqaUdcP6Z5/EwTNfL0h8hnua0QV?=
 =?iso-8859-1?Q?yXhW4pqKBrM8ylvBWIM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b32cf9-2da8-4664-2ef3-08ddcaaf6c17
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 12:41:34.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFpOM6Oq8ccHGnRg4SQrJXLT6lpNhVkzhnt1PJtWqLXxPMuIvejMPaxAmtIBSYRgBz4xqs/mDj6FQTeR/vXinI914Eexa5pdpBNZjRz1bU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8321
X-OriginatorOrg: intel.com

On 2025-07-24 at 13:34:44 +0200, Greg KH wrote:
>Your reply-to is messed up :(
>
>On Thu, Jul 24, 2025 at 12:45:35PM +0200, Maciej Wieczor-Retman wrote:
>> If some config options are disabled during compile time, they still are
>> enumerated in macros that use the x86_capability bitmask - cpu_has() or
>> this_cpu_has().
>> 
>> The features are also visible in /proc/cpuinfo even though they are not
>> enabled - which is contrary to what the documentation states about the
>> file. Examples of such feature flags are lam, fred, sgx, ibrs_enhanced,
>> split_lock_detect, user_shstk, avx_vnni and enqcmd.
>> 
>> Add a DISABLED_MASK_INITIALIZER macro that creates an initializer list
>> filled with DISABLED_MASKx bitmasks.
>> 
>> Initialize the cpu_caps_cleared array with the autogenerated disabled
>> bitmask.
>> 
>> Fixes: ea4e3bef4c94 ("Documentation/x86: Add documentation for /proc/cpuinfo feature flags")
>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> Resend:
>> - Fix macro name to match with the patch message.
>
>That's a v4, not a RESEND.
>
>Doesn't Intel have a "Here is how to submit a patch to the kernel"
>training program you have to go through?
>
>confused,
>
>greg k-h

The way I did it used to work for me previously, I'm not sure why it didn't this
time.

-- 
Kind regards
Maciej Wieczór-Retman

