Return-Path: <stable+bounces-110328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E994A1AA67
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 20:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F2116AA6F
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BFB155A59;
	Thu, 23 Jan 2025 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1saNvhm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DE17741
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661106; cv=fail; b=jkSXS4DsZ9cQpuDQ81jS12JAGbZGTXFK7ZFjga7mQu6AwRrGYLDrQnmbP0Ajz1x2RPdxtGcgq9yJPk80RrxDdpGIofY/iMoh5Z0nmeVtUtNecc9hVenrln28W7jSuIcJP1Uu1tdKq2oe1czfS4ZuEZGam9jGLq5RvbLaPCsn0ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661106; c=relaxed/simple;
	bh=LbxU9G75/QBZDKh09+ypJyDKmZ+SqA3+fFUFyJVKQbs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gy+UKYmRecWE+Wog2KpZcudgc/kfrNRP0UjCPGhpOyvWXVOZ2yJiDAwqS5kLi5ptq+ALpfYWEESWhzLi3xX3q0RPBi+Y1j6NKD8PJwVSiu1w6y5ZDCmfg63LVG3v7BRQzKnGZ6QcoEzixsy8MCyUNbglbj3yMApN+FhOzToFwTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1saNvhm; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737661104; x=1769197104;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LbxU9G75/QBZDKh09+ypJyDKmZ+SqA3+fFUFyJVKQbs=;
  b=Y1saNvhmfT99UlVA90QyZ9hafrIAqXiRerbTdROMDgtfBtJ2PwAadP3C
   Pj3AzuJp6US7j6i3rdyKKmolekSGDif3a/E2gCDNXtvg/McTxb/NIJ9rl
   VcXyetVUOe1KwzZYrYbjiqOsDEX5BST0wzYdwujIA1E3xy3j+yCcukdT4
   i85EpBUVh50Ho/ECSnu7gPD6alPyfDXIClKnlBwTg/uVa9+QOwwpHTGMv
   4LhQxHeCREGfjtwNXQlHtcDt6oIDhd9fVqfkG9ySUFUDGS5yfrGwdMFtk
   2KgPT+ZOJxi+tSyKi3/sVB4NyAr/SJkt9aBD7c5CMRSq4MGBVLkaTrIYy
   Q==;
X-CSE-ConnectionGUID: GI6Pi7TnQWCik2HG4zryPA==
X-CSE-MsgGUID: VLMTj5WjS9iub3FIPeTPCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48771811"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="48771811"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 11:38:20 -0800
X-CSE-ConnectionGUID: zq+WQKzeTXy47LlDHBWHww==
X-CSE-MsgGUID: ClaWvlutShG82cIg6Eg2+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112513635"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 11:38:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 11:38:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 11:38:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 11:38:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUixf6T3rkQ4o4J2C0G81cqtWDR0AiZeFB/uaKrl0uLmYMu483QSrtcDwp/OXS+n6zFLOOOLyxS1sMtG70xAG6CkLGBmpe0sTukgXgLtOxz6OVfNQkAnL1v/d5eaVLtu9uEeQYMas62u2Gvsoe5OMVcJVL71OuVzgCYMaB+uRMI0gw7HokvJl3pgk9vbtcI9BFu3VB+SC5n5t82rSaPpRMcqRPoG2TuLitpsTES7WjSEOaiK3qctfT0sRRJrh96IbvnA6xr1ghf7k0b5CS4fFF3LG6ldYtHeZ09rxsSyZOMw8+xP3dzRAzjl58yn0/fWIdnZalHnuSnmRCs3AWykaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4S53RHaky6oQ3ia3B3WzyFA+WhRvEuVr6ztkwwJMgQ=;
 b=K/8SNg8tzTzDu1BrVQhRPj/zDXmdIJ4CNfEMzZ5EOzO+3byKsWmDwiIh943RM+Tgd/IDr4xA/tV6ssdqaowNKac/yrZhJ89T3xjOQY+cscn2dmmZyAmvMS27iAM9e6B7IutJj14PvrP9ArmqkOQE3mnuHM/H4wRiCqjSPP7Xm3AdrodWV/3WhQ0st25gDIogX4o3YgxMg2OdPhFEH7dB8tHlSIxt922G6I8uxeokQz8ygAQcH9aUd8hpQBfTiCyP0TOsv3AwcT+YQzyIBrK1yPQTrd7uqDq+OCdhNRwuOqSo4bSscw2EUY+2CsHIFGy7/VMgNvlsoBfBq/7Trf9XIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB5134.namprd11.prod.outlook.com (2603:10b6:a03:2de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 19:37:37 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 19:37:37 +0000
Date: Thu, 23 Jan 2025 13:37:33 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: =?utf-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>
CC: <intel-xe@lists.freedesktop.org>, John Harrison
	<John.C.Harrison@intel.com>, Julia Filipchuk <julia.filipchuk@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/xe: Fix and re-enable xe_print_blob_ascii85()
Message-ID: <5lsmg37ivutxa5qthq2egx5u35gnr734gji5qdixpkbizw7hfi@vg3bd4nyq4x4>
References: <20250123180320.66198-1-jose.souza@intel.com>
 <20250123180320.66198-2-jose.souza@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123180320.66198-2-jose.souza@intel.com>
X-ClientProxiedBy: MW4P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::33) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a1f4de-26a5-4b8e-6dcd-08dd3be56429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?YY0ErxCUlulJgBW4ANN4ZM26MHqg58GZE1uE67B05plbz80UHGc3sGCEM1?=
 =?iso-8859-1?Q?enZBssBmjUmjNCgzRz4FGoWQPnjsJa1LkJJOq7ugUope9N+Jsu8wfCT/YV?=
 =?iso-8859-1?Q?lio3aN3LUioP4L3icbzc9hOs/aIsNTWXBvblh4byh8yB658Q5bosYYMbE3?=
 =?iso-8859-1?Q?KwNvnx2D1aZYxXM1eYuDkmoRPfQkp0qUNmiCgnrgcJjhhGnio7rxtAkTeV?=
 =?iso-8859-1?Q?ThrSI6k3L2s+rg5p5e16LHNig8wu4ffLjL1WXOTTg1z28I8SNq1n4cTzGj?=
 =?iso-8859-1?Q?HpFbTbTiRuxuejxmeEfZkcHoJk2Bvx2T1cfqsl7+RWhXHzyX1STizMvHhb?=
 =?iso-8859-1?Q?sqP6P+D5XZP7aX75DRvwfFTbo2wBwEJM8K7+TcdEEK0g9rkILQAwgAhYX4?=
 =?iso-8859-1?Q?Xdr+jznDFokqcQHW91hYrGDcuHqqiBAvf451oj0qxSxCn13dXD/PmiYfuO?=
 =?iso-8859-1?Q?/SujHwDGpyVIrsZJT7wkRbu7wEY0/LM4bWwkjyiqhxCzS7HxwdXy67z7vX?=
 =?iso-8859-1?Q?cauaS45tclmvcX5Yek1+VqehnWYDsAvDSHSgFLBC+I7uF6/xzw6qyMKU2t?=
 =?iso-8859-1?Q?Fp/zH+r7QoN/5Fqp65smhDPayMEXmwrW2mKCb5jme7mdv0hg078Dy656od?=
 =?iso-8859-1?Q?tS2U4KsrBrinfrGfPNB10aOjAs/TK0vRdtch0xqqWTiR2gCameQHDdJlO8?=
 =?iso-8859-1?Q?citieh0GxFQv+yxKkK8Q7EN5qt8VQILGUU8AYCIxHQdK4Q3lsmrf9VkEDI?=
 =?iso-8859-1?Q?sa2oN2FQYNvQqTZwR8EBKUdyfQ6poA0+h+Vmbm2pfKgKsJDL5gbTDIOOeY?=
 =?iso-8859-1?Q?/VsXPI/C/1mBl0qlhZ1p0LzDACJ1j4B1gH71T2/6Malwa7YQpQv7ccuLny?=
 =?iso-8859-1?Q?2NbA0kGyTI0jH8ZLH6griwXAfKpZPwcIEbZ3IUHpB8ah8ViKgUTk6LxpLY?=
 =?iso-8859-1?Q?O1rDEIRZN6pDt1iRsoTVfKnJ+0exXbpzXPXWIpDtnr5YrduZKO1XWQKoSF?=
 =?iso-8859-1?Q?RcDTjEsjrDQxLBHdg8y4fgWOzcSvZSOwHe1x6UhjNN34KkgxuEc3iKXUwo?=
 =?iso-8859-1?Q?J9wPV2oG38I28TefXqw2fH40JIImBZbMeuy9Ix2KGxrQM7UsTH41x3AC3u?=
 =?iso-8859-1?Q?+aw9hrBAvjlPjTgQaDDXhggyGnRiuLYUXMdhd69HxMpyaeagWTDgMP30iP?=
 =?iso-8859-1?Q?qwIrxxo9ZbjGmvisOsAUYNs/G/DDSq1ofW70muv0IS7EcQUgNDqoRH1EpR?=
 =?iso-8859-1?Q?d/+mn7QX/JSvKZ5PnOu0WxsL1v6MLfc+mLHW0ELRC8dTAt2bwzKLIzL1Wo?=
 =?iso-8859-1?Q?ZxmAr5fhYoB54fjMfvan71qo0ZmdD9kbTo+nUgg35th3xrw4pzYRrVIlEC?=
 =?iso-8859-1?Q?LlpsfE07UsESieIAkVajS1qjtBHeo6awNDmfTwooh/c+rFeF0js52AwSPT?=
 =?iso-8859-1?Q?0FEnaLgYPLMYTA2M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qqZk/cgVUa4l/k1NSrDEaw/QsDAu9N+0W8arcPJWebBhG5tsXFlC0C8WWI?=
 =?iso-8859-1?Q?6oZAaBBLfdVYoibY6nFYZeV9H5EDV5ewGhQf/3K3dXEG2MBlpnbV0M6RNY?=
 =?iso-8859-1?Q?1paMjjkYKdQ+fEdz8t/qGUP1+29RoHUPizXdVRVzsZSa3c+mIvZTWRSnpo?=
 =?iso-8859-1?Q?cJbfjvl0mewICR9itSGRMEFcmnlKh45v6wJEad3P7ByvPgKA43wg4zENPW?=
 =?iso-8859-1?Q?FqJuLBYqmcT9eyhBK2udmZaRz0FLXm2LlLEA+JsCd1QjHA7P7TYcyY3eNO?=
 =?iso-8859-1?Q?GQqQZDDRNDnG81ykZ2qNPewP9g9oGJgtVsRccpeyEf5m1finWY1HxUvSn9?=
 =?iso-8859-1?Q?5eAryOVVk2fKHxJTbrBzlxrGu/QO6mN11qWyfyF4BA2MqsqEZLdhtQHbgQ?=
 =?iso-8859-1?Q?scvPC70nmOyMpneYFYVemfphuSOzWJUd14CPCK1++eeXlPR77LUWoHJ+gk?=
 =?iso-8859-1?Q?gM2OMmpLo1VkLeOqmJtkSfOtcX6fQotC3PN0ssxSz4bg3TqoaPngTTAnQy?=
 =?iso-8859-1?Q?quwejMfkzzejgm9mLSeAeSgi46BA+5Pqszgh+ezAKmPv8roDoqV8u29QYB?=
 =?iso-8859-1?Q?0S72DVRPuGT2xN/BOxkjZCkMmbFJjAhFWC9gz6+GHWc4NETTx/jI9RCTFT?=
 =?iso-8859-1?Q?g/katUhCQPpx6I2zYa0Q5DBr0VCiB7RXLJRe2E282TtX5RLG1j8bpHb6AB?=
 =?iso-8859-1?Q?K7QLVh7+6ZujulyM73ZvrxA8Xw2cl8cJOB6RL7DXtX6dJ3aZ7CPQhi0Svl?=
 =?iso-8859-1?Q?nGOS0r4sedfj4sOSw0MCsoosz3PVxfNZtxRd6ugqLOBznTUyEmhrjky6hp?=
 =?iso-8859-1?Q?/642TD+ISR9cbWANcOFXPojjtJpImFtYW/BjXIJmt82IPppocXnpEvVrI0?=
 =?iso-8859-1?Q?n4teGFyWwRhFtdxcgnKgm3lWPvgd+qKhZst2TnmNAagB/sOpCD2fZ9S2G4?=
 =?iso-8859-1?Q?nZ1fEyHaZIsBDoQAhNU0Ubx8TlmSFITezFTcptzFd/nxhgGT8fhRQfATWh?=
 =?iso-8859-1?Q?e8/k7IgCX0ibagmbBVJNNgfgleWb+Q0/QfuYGx+pGY4Fu3eq4kIUAudLJS?=
 =?iso-8859-1?Q?zJ5Lc+SgeYgA6B2GExSZ9DMQskZEBXgCGfnnx0TXfTSqOG5K/jox02V613?=
 =?iso-8859-1?Q?lY2YRCIbVCBpPET0exJO2so0yiJ4/vK629hz87/yXfVMIxKMBys8Q10t20?=
 =?iso-8859-1?Q?sM7qjFXXjwIGVHBPhaZQteCL4Ju4mqPXYEeMDtImQ26SrPyVjHRCeeW7aG?=
 =?iso-8859-1?Q?XcDctHAal8qcsEVyZoANzvZPXtahXt8Wc3sLQvJ3Uyf0SOz4jWREPABups?=
 =?iso-8859-1?Q?Nzrukk4sd812UhymZbaW31N6RkwtD3lyQvxh+j/Pe7MHNB0hzGptfMcuh4?=
 =?iso-8859-1?Q?bJzXQbvZbyr+/rNomXfgq0viV07j7BA8vWcdTPg0GxNjuT1mZu59S4eQaR?=
 =?iso-8859-1?Q?D+opuMEtu8cks9KKnUwJfjASA8bSjKTkiCBWJbD0mwOA8Ta7xnkdYxlRFA?=
 =?iso-8859-1?Q?r+wLErOBv8FSryIckoGmlxtgKnofvMcv+xYyVe3Dk9f4yE724ujUHi3Bsi?=
 =?iso-8859-1?Q?G6uWzk+miwRnoaOMWcjIGZjpiDhmkdH6X7+bCUno1q8xv78BgqhLWbBPZJ?=
 =?iso-8859-1?Q?hIEogojNNAjZlWagyXwoKeSRzcj3z28xiyqka+I/VMBzqrdX2G1UwOOA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a1f4de-26a5-4b8e-6dcd-08dd3be56429
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 19:37:37.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LcWqD1P0jwUopyydbLpZ0bMVvPsALVMCxaVpPwXAfXSJ+Mqzh6B72Ar4TQ6a5MyRhiaI4tMlVtO+BiJ7ZjDi/icYSVvc92Y/XsnfOIbdQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5134
X-OriginatorOrg: intel.com

On Thu, Jan 23, 2025 at 09:59:41AM -0800, Jose Souza wrote:
>From: Lucas De Marchi <lucas.demarchi@intel.com>
>
>Commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
>debug tool") partially reverted some changes to workaround breakage
>caused to mesa tools. However, in doing so it also broke fetching the
>GuC log via debugfs since xe_print_blob_ascii85() simply bails out.
>
>The fix is to avoid the extra newlines: the devcoredump interface is
>line-oriented and adding random newlines in the middle breaks it. If a
>tool is able to parse it by looking at the data and checking for chars
>that are out of the ascii85 space, it can still do so. A format change
>that breaks the line-oriented output on devcoredump however needs better
>coordination with existing tools.
>
>Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
>Cc: John Harrison <John.C.Harrison@Intel.com>
>Cc: Julia Filipchuk <julia.filipchuk@intel.com>
>Cc: José Roberto de Souza <jose.souza@intel.com>
>Cc: stable@vger.kernel.org
>Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
>Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper function")
>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>---
> drivers/gpu/drm/xe/xe_devcoredump.c | 30 +++++++++--------------------
> drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
> drivers/gpu/drm/xe/xe_guc_ct.c      |  3 ++-
> drivers/gpu/drm/xe/xe_guc_log.c     |  4 +++-
> 4 files changed, 15 insertions(+), 24 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
>index 81dc7795c0651..1c86e6456d60f 100644
>--- a/drivers/gpu/drm/xe/xe_devcoredump.c
>+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
>@@ -395,42 +395,30 @@ int xe_devcoredump_init(struct xe_device *xe)
> /**
>  * xe_print_blob_ascii85 - print a BLOB to some useful location in ASCII85
>  *
>- * The output is split to multiple lines because some print targets, e.g. dmesg
>- * cannot handle arbitrarily long lines. Note also that printing to dmesg in
>- * piece-meal fashion is not possible, each separate call to drm_puts() has a
>- * line-feed automatically added! Therefore, the entire output line must be
>- * constructed in a local buffer first, then printed in one atomic output call.
>+ * The output is split to multiple print calls because some print targets, e.g.
>+ * dmesg cannot handle arbitrarily long lines. These targets may add newline
>+ * between calls.
>  *
>  * There is also a scheduler yield call to prevent the 'task has been stuck for
>  * 120s' kernel hang check feature from firing when printing to a slow target
>  * such as dmesg over a serial port.
>  *
>- * TODO: Add compression prior to the ASCII85 encoding to shrink huge buffers down.
>- *
>  * @p: the printer object to output to
>  * @prefix: optional prefix to add to output string

let's just make sure to document suffix

    * @suffix: optional suffix to add at the end. 0 disables it and is
    *          not added to the output, which is useful when using multiple calls
    *          to dump data to @p

Lucas De Marchi

>  * @blob: the Binary Large OBject to dump out
>  * @offset: offset in bytes to skip from the front of the BLOB, must be a multiple of sizeof(u32)
>  * @size: the size in bytes of the BLOB, must be a multiple of sizeof(u32)
>  */
>-void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>+void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
> 			   const void *blob, size_t offset, size_t size)
> {
> 	const u32 *blob32 = (const u32 *)blob;
> 	char buff[ASCII85_BUFSZ], *line_buff;
> 	size_t line_pos = 0;
>
>-	/*
>-	 * Splitting blobs across multiple lines is not compatible with the mesa
>-	 * debug decoder tool. Note that even dropping the explicit '\n' below
>-	 * doesn't help because the GuC log is so big some underlying implementation
>-	 * still splits the lines at 512K characters. So just bail completely for
>-	 * the moment.
>-	 */
>-	return;
>-
> #define DMESG_MAX_LINE_LEN	800
>-#define MIN_SPACE		(ASCII85_BUFSZ + 2)		/* 85 + "\n\0" */
>+	/* Always leave space for the suffix char and the \0 */
>+#define MIN_SPACE		(ASCII85_BUFSZ + 2)	/* 85 + "<suffix>\0" */
>
> 	if (size & 3)
> 		drm_printf(p, "Size not word aligned: %zu", size);
>@@ -462,7 +450,6 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
> 		line_pos += strlen(line_buff + line_pos);
>
> 		if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
>-			line_buff[line_pos++] = '\n';
> 			line_buff[line_pos++] = 0;
>
> 			drm_puts(p, line_buff);
>@@ -474,10 +461,11 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
> 		}
> 	}
>
>+	if (suffix)
>+		line_buff[line_pos++] = suffix;
>+
> 	if (line_pos) {
>-		line_buff[line_pos++] = '\n';
> 		line_buff[line_pos++] = 0;
>-
> 		drm_puts(p, line_buff);
> 	}
>
>diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
>index 6a17e6d601022..5391a80a4d1ba 100644
>--- a/drivers/gpu/drm/xe/xe_devcoredump.h
>+++ b/drivers/gpu/drm/xe/xe_devcoredump.h
>@@ -29,7 +29,7 @@ static inline int xe_devcoredump_init(struct xe_device *xe)
> }
> #endif
>
>-void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>+void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
> 			   const void *blob, size_t offset, size_t size);
>
> #endif
>diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
>index 8b65c5e959cc2..50c8076b51585 100644
>--- a/drivers/gpu/drm/xe/xe_guc_ct.c
>+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>@@ -1724,7 +1724,8 @@ void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot,
> 			   snapshot->g2h_outstanding);
>
> 		if (snapshot->ctb)
>-			xe_print_blob_ascii85(p, "CTB data", snapshot->ctb, 0, snapshot->ctb_size);
>+			xe_print_blob_ascii85(p, "CTB data", '\n',
>+					      snapshot->ctb, 0, snapshot->ctb_size);
> 	} else {
> 		drm_puts(p, "CT disabled\n");
> 	}
>diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
>index 80151ff6a71f8..44482ea919924 100644
>--- a/drivers/gpu/drm/xe/xe_guc_log.c
>+++ b/drivers/gpu/drm/xe/xe_guc_log.c
>@@ -207,8 +207,10 @@ void xe_guc_log_snapshot_print(struct xe_guc_log_snapshot *snapshot, struct drm_
> 	remain = snapshot->size;
> 	for (i = 0; i < snapshot->num_chunks; i++) {
> 		size_t size = min(GUC_LOG_CHUNK_SIZE, remain);
>+		const char *prefix = i ? NULL : "Log data";
>+		char suffix = i == snapshot->num_chunks - 1 ? '\n' : 0;
>
>-		xe_print_blob_ascii85(p, i ? NULL : "Log data", snapshot->copy[i], 0, size);
>+		xe_print_blob_ascii85(p, prefix, suffix, snapshot->copy[i], 0, size);
> 		remain -= size;
> 	}
> }
>-- 
>2.48.1
>

