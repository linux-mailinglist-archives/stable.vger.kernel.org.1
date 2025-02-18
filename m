Return-Path: <stable+bounces-116655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC17A39202
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 05:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF8C174088
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B21DE8BF;
	Tue, 18 Feb 2025 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQNyG7Rg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981CE1DE890
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851060; cv=fail; b=aF9jqsKWoXK+rPU2eRMySmDh5xxnSyeiHrpAzBL3Ldr978wNDdcVZkRCW/HtWttejxDhvp3sTl0gLgIKK3rIAfHKAqsigJI1yHP769Q2E0PGrk6hW5nitOoWVq/WG/pyxnqTWr42o28kvu/T7Jg2aL4Jdpt9bj4X6VCqlIobvb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851060; c=relaxed/simple;
	bh=vDqKs36EfHBZWYfRgjrJkMLLKizuE1see6z0VrXKtjQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mm0zrqjZNg+zD0kmgesgBpVY6eZaCvZ89yaX3GcZnIG3V+6Jn3N5/GSuL/3TPzrhRHzyHnbNZc2yUds/x6fZl69yLHMCLLAHoodlp+/0K7X/SW2WNowN4BeYYtzK03aiu5VMafXq7tG2aqB1BU07yrhTupZZ7ZHPOFgVbkgCmFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQNyG7Rg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739851058; x=1771387058;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vDqKs36EfHBZWYfRgjrJkMLLKizuE1see6z0VrXKtjQ=;
  b=EQNyG7RgEMr4BW1lprI10GgWt2RMsm1FAcwGo0p36yr8Zk3acvbZuNSf
   k7OIIfnaOM6v4PbqaIhHk7qKyNMH/38Ti3EH6JT8RKTLTtoVWE39xp3A8
   CORBo+FgUX4AGdYGD1mcGRYBp2HkTa176XJBmI23bvG1jPiddyOz6gEdi
   V5NESWvkj0E5uL79SfxxF45cmnz/rNOcRiwIQfr92OgCV8bTyh41pU6MK
   zykcvTIf69zFhbYg9CSuTtF8cWHd7cKwdA6SO3ce1KYLv+RRPc42Qp0b0
   B6j5kJjcIzjiccI/ZWe1pwtJinhunNyQhebGPf1ato8WAQr2EpcN+BxX0
   w==;
X-CSE-ConnectionGUID: Xm+JYVJUQcC/TvtdOewCLg==
X-CSE-MsgGUID: +LVS23thTKOrvpvvvhfHdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50750115"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="50750115"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:57:37 -0800
X-CSE-ConnectionGUID: 5hdxUU/wS52ntB+vj7V6yg==
X-CSE-MsgGUID: XbmgL3wfR6Wn4/791L2ZcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114021114"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:57:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 19:57:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 19:57:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 19:57:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bL4ePbcrrgc/tdCDNqeWLcNss1PHXxobVh+wzHXMeNECCFgHH1dJGVs9b5VHfYa8bCqgh51Jjkj6n7mLDNT6H7C4MbesjgX9qmcLGWnqrwuJ6+X+FvJwviKznAVr5ZyjfvkmYqzjBaVzwY09iuKlwumX43bkM+RaADfMR/lgsaWb6z1ZnduoECZaswsXIjiCNyTNR/gZVOerU9+CinSNXjIyBF2yO4hA8DFNjWaUtSrGuGllTBii9QS/ZaLnj5BVrc0pjOc4gm3wqp10hzFsl+BuVqi7bh4EIw+13/VSKN5iiKd/6NcbynOHe/WiRT6sL9b8drkK16LwKKVELvKnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRGvHGIhllPemmQI3iO7nXm1YKIufyYzyfeUoM+bxFI=;
 b=vk0fCogbF4HncvNkro4YYLHG0fJb9qo6+vfioL139xDlMsew74tbpAQlVQULSVSE/5sL1Af804YIAJDTK87vyIKm2SpqeOC2u8zsmqFMqJmy9AYyZvXpJWjGZ46D++CofV2Tea8NYV8YHC6z5LIKlDxHxCDGgGbVHOK7Uy4272K67qoLBrL7355+pIZ243cdWMdKt+5JQ9hM7WHXKVPEbqTLn/RQrV1Sjd2GQR1nlYvz/Nt+p86m44zbFkhcALe2TGcKJxgADSo0Y6eG3NeGtCPg3d49ey5bk8/DVg+6FTPwOJhOkGeXg6DLFBt6UdA4aydUXuR72LOSeyusqGOGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:57:15 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:57:09 +0000
Date: Mon, 17 Feb 2025 19:58:11 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] drm/xe/userptr: restore invalidation list on error
Message-ID: <Z7QFUy9ZyBRhPwuY@lstrano-desk.jf.intel.com>
References: <20250214170527.272182-4-matthew.auld@intel.com>
 <Z6/ttCTrEuwNsD6w@lstrano-desk.jf.intel.com>
 <6fec16d5-cbf3-448b-9c07-85a079095f62@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fec16d5-cbf3-448b-9c07-85a079095f62@intel.com>
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 5411d326-8caf-42a4-39f2-08dd4fd0510a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?8o2YgpDhdf3q67txnSYT04CamNd7+VgV15wrDoSO4BsDi/L8d3+O2t+z6R?=
 =?iso-8859-1?Q?D6M0TswdAzcPUuYPtW3IKH8KauqLrKowJ41OnJ+l7/LaJkooeHBcoP0hcH?=
 =?iso-8859-1?Q?TJdjg7sJDHsDkGHg3YV7dDtD/Gg3X2/kYwslWtehnuCtKyr7zNI94XRFjy?=
 =?iso-8859-1?Q?bUxhxuScqSAm0KueAAk0OPGBSVX1+H4bEAtEI7c8E2bXd2nGM2cYehVGow?=
 =?iso-8859-1?Q?GUHsXgnAFGNix/9uGIv5oF6hgrhWNSLewh88eNVC7u85dErYOBL1CbyQEP?=
 =?iso-8859-1?Q?cchJKoSCbl1GA5VD57NnoPjsvo6OxxYx/2TLOlE57LLIPfEarCxRHU8D4t?=
 =?iso-8859-1?Q?bPnZ+u1DjxUla/B8VkFMTj4LY++5Iv/n9ecP7ifqchbc2/Uk3PgvObi6rS?=
 =?iso-8859-1?Q?LRx2ZbfXCUaLtjZuFLlVM9Mvzqy4roz0OAyvK3ImF1Ob+7Xmz3kkG9zrzJ?=
 =?iso-8859-1?Q?rnOAEQvePwu2mGXVI1ECbDGxp/BPIQyJ8c63C6y9iBGPz5QRIxwDNRzHNd?=
 =?iso-8859-1?Q?T/5CHXx4/qwAVIDSWB1Te92ZsJjSPRVsXRUHm8HQuRh+7A5to3BZKOUpGE?=
 =?iso-8859-1?Q?gHVpxetlUgzuz7lNovlpjVNeG1CEXPHPDl2A/7cHKjC/w+cf3SM5cN+yaj?=
 =?iso-8859-1?Q?LVUyaZV61PkwJQPgNVMyQyLALBuQcEhf5Unt2yNz8Bka+73LQcCDQuukCz?=
 =?iso-8859-1?Q?bgk4bJsb2XMNjHi4nPX5FvHhhzg/nSvccjjAUILwVsjpr80TMPjKV6trLP?=
 =?iso-8859-1?Q?5xaiYwUuzGR44xNJoUPc9Gp+2b5bD/YwezQfkN+h75tH7xqG7H+bK2Jquj?=
 =?iso-8859-1?Q?bW2jSvbJl2Etyk6ystWjTUwELGajktuD1I+kjDQpFbc5sZZzdDAmvA+Dc+?=
 =?iso-8859-1?Q?dvYOYCPNtzAxWiOqtj45Y3BqSOT4+U1cg/63B/JoBnxle1bTKxchJ+kv3g?=
 =?iso-8859-1?Q?TUOMVYSuU46ATjqdmQn7Mm0ybc/MwTt8TE17rAlLEHscCf/Dr6qS7joXN5?=
 =?iso-8859-1?Q?4o+051sV1ngSQDZuA8/zSrDI+oo4AmuGc5yrilL8BexHOAS9r2/5Sg5HDc?=
 =?iso-8859-1?Q?FTexgBFls+kFybT8Sj4QfsE1LHsWDjGFqkZwndwLR0hAouZ93Eib52BOvI?=
 =?iso-8859-1?Q?hrJtPCXwMJsCb/cxOwflSyqd2tzprKXMeTGmcGIlOph/4exy/BhKEzI5Yd?=
 =?iso-8859-1?Q?lJsTjgM0n4PmipSpozRC9ehGI/oh9IFI9nEmmwi63GJr3Rh6OeYu587eCb?=
 =?iso-8859-1?Q?T6FytJp/O9EO4rMukFMgQGUljQy0IYyuM7O0I5pSdDATQoq3ZyOb2CVGSF?=
 =?iso-8859-1?Q?GdX5FrdarlKt534MULm9hcyUoXqGU1i+/+OL9DPMcN2lRL2A6Gd7aKqu8D?=
 =?iso-8859-1?Q?sBb2ATikRb0CBxJxg6zoGE90C7nzQGHkPwI5QdHg1dloY/N9ii1jvLnYm+?=
 =?iso-8859-1?Q?V3qmjTzLgVVg0yVy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NmeJH4jmUMETdwWjkXdWe5hDG8+Dqj7sSnvrPOJUTigUCf9ZL7RD/qHNvR?=
 =?iso-8859-1?Q?B1Q3c/UYxQpAUVQwVfzXXi1cNPnDhLvyecTau3/aqZXqxc54E435mEW58N?=
 =?iso-8859-1?Q?qpl9ooMFXdevnOMk7ynI+mtXx7kqQ6Ik4M0RdtR/8qAWi45k1A6bFCVcHE?=
 =?iso-8859-1?Q?dWnvuMkmNohYJtlsDurYT0/pO34cwQOEr/JTXxMoyt1N8g9sLWAAz3/eXe?=
 =?iso-8859-1?Q?oUJ399vZtegFlIogM+1YePt5P1NaDDjpzcUKLAWgiKBB6VF+96VuT25nOb?=
 =?iso-8859-1?Q?eT8VhHH2y+I7bWk9d6iNmIS1nyFHwj1hlIDgZXxnRXdfpQAQyuYbHzbivA?=
 =?iso-8859-1?Q?cp6NO8Z6nWm6fzNz0wz47q6ucHfpPmNnaPDtz7Rv+Fs13jJ90oneNvGTW4?=
 =?iso-8859-1?Q?CKqc+LYLS6+/5XI/kVGoD2usSQ7GIO8oiqFKFG+Z1iVoQCpAaThkU3vdud?=
 =?iso-8859-1?Q?KZvYnrP3ZKsZvkrBel5V2S4JTfzJyJeM2QIgQOy6bywXz1qK3gIN94rYjL?=
 =?iso-8859-1?Q?SW0LdTiALR1+tWbh9+H7acaO6pqsRfc+bSrnOvEtxkfr593YTEfB7ga2Wt?=
 =?iso-8859-1?Q?mZYFR7U5w+FDq5+wpqx5vkb1DkB4UQYyKmsF7IqpNKWyyoxzWAUrYCL9jv?=
 =?iso-8859-1?Q?QYoM/csrdw1nLrlUMlegubtE3xbJgXsjqxlYY1HWJBQlQ+4uW1bjewmXae?=
 =?iso-8859-1?Q?VCWG/Jdg1GZ/rg+w3dB5lL4GraQPqpX5yQfZ5MYFZKLbTWo6LiZGvgstO3?=
 =?iso-8859-1?Q?CFm0jfsCTxGjDek8E8is7/Wp/ldzlrXujSOELfHfckdHZKy75UzMkiUvoz?=
 =?iso-8859-1?Q?rx9UZoWZjUK37ZQrKautyzKpNFs6ViVXWwzfNNvFmfFHT96OVHj4F2EIxs?=
 =?iso-8859-1?Q?0Fi8MqHqv0U3vravg13WoM+yORrSeTiaDwIB6nXe1mcsvMaBdTsZkl7XvA?=
 =?iso-8859-1?Q?UbldtpDaYwtOqsdUdUpBPUK5AGe0QcwfLA9Lw76zKZhc0a9BF34BTllejQ?=
 =?iso-8859-1?Q?lkKMREyttP5B4cF7QceJ5MKGfb6w0SltGItG+cSkkWEf5DrYTNlzXwi7jd?=
 =?iso-8859-1?Q?dy3teWvzo3zpAw/9qdT+gHI3/T3bjyI077Ip9zYNcBB6HzCIts0s7zGrPi?=
 =?iso-8859-1?Q?u617H+figQ4PKejs1WX80vd2U5abNGWGy8ZPE82cDa9jWROc/gy+8saoWO?=
 =?iso-8859-1?Q?YdW2JC5a97EUD0Hbj14RYw4YS2faoSoNGoeIPoyxwziP2EbOw5VZakd8jR?=
 =?iso-8859-1?Q?pN2qwJB9f4QcPdq7Z6nwMIoWyx1lm1dK0QM5rlJ3vd+6RLX/4M5XKDat0v?=
 =?iso-8859-1?Q?9zdZlzbxfqNltjlXLtbOYuhNdtycDkyAuZHlBF/dvDsR9Sjk2MMOpEbXCP?=
 =?iso-8859-1?Q?t518vXuYsikeo9FgT0iFotrPZhMfWLy6mr/7NNBHXPfPo5cRHIGlMk5+b7?=
 =?iso-8859-1?Q?br8O5romQt2Dz3O+/06iLNdZK+uD3RqY8Sp0ltQhvZuhYz0nwYAZuC+XVR?=
 =?iso-8859-1?Q?XLAugaBi/+5mR+Uy7HroiC/tFQi0JrzGDF6djHatTRMk82fPshs1E7pc4Y?=
 =?iso-8859-1?Q?xtr+y0q21Aa7soiowbDYJw+P1V0bER9Ng0chRrNiDxlBd21odM+lImTDUw?=
 =?iso-8859-1?Q?CVqVr9cDplW5TEavbugpCEUe/8kfPvvDY+nV760jvl3o+Z47wQKwO/KA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5411d326-8caf-42a4-39f2-08dd4fd0510a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:57:08.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcDr8QzC1wYNYoUBaBoG9Scbd1mxYQJuvtKPV8WU9rD9axDGUXAZo2nkN+z7UUkcj7XJ24ndR3QF/bTuicfRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com

On Mon, Feb 17, 2025 at 09:38:26AM +0000, Matthew Auld wrote:
> On 15/02/2025 01:28, Matthew Brost wrote:
> > On Fri, Feb 14, 2025 at 05:05:28PM +0000, Matthew Auld wrote:
> > > On error restore anything still on the pin_list back to the invalidation
> > > list on error. For the actual pin, so long as the vma is tracked on
> > > either list it should get picked up on the next pin, however it looks
> > > possible for the vma to get nuked but still be present on this per vm
> > > pin_list leading to corruption. An alternative might be then to instead
> > > just remove the link when destroying the vma.
> > > 
> > > Fixes: ed2bdf3b264d ("drm/xe/vm: Subclass userptr vmas")
> > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.8+
> > > ---
> > >   drivers/gpu/drm/xe/xe_vm.c | 26 +++++++++++++++++++-------
> > >   1 file changed, 19 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > index d664f2e418b2..668b0bde7822 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -670,12 +670,12 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
> > >   	list_for_each_entry_safe(uvma, next, &vm->userptr.invalidated,
> > >   				 userptr.invalidate_link) {
> > >   		list_del_init(&uvma->userptr.invalidate_link);
> > > -		list_move_tail(&uvma->userptr.repin_link,
> > > -			       &vm->userptr.repin_list);
> > > +		list_add_tail(&uvma->userptr.repin_link,
> > > +			      &vm->userptr.repin_list);
> > 
> > Why this change?
> 
> Just that with this patch the repin_link should now always be empty at this
> point, I think. add should complain if that is not the case.
> 

If it is always expected to be empty, then yea maybe add a xe_assert for
this as the list management is pretty tricky. 

> > 
> > >   	}
> > >   	spin_unlock(&vm->userptr.invalidated_lock);
> > > -	/* Pin and move to temporary list */
> > > +	/* Pin and move to bind list */
> > >   	list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
> > >   				 userptr.repin_link) {
> > >   		err = xe_vma_userptr_pin_pages(uvma);
> > > @@ -691,10 +691,10 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
> > >   			err = xe_vm_invalidate_vma(&uvma->vma);
> > >   			xe_vm_unlock(vm);
> > >   			if (err)
> > > -				return err;
> > > +				break;
> > >   		} else {
> > > -			if (err < 0)
> > > -				return err;
> > > +			if (err)
> > > +				break;
> > >   			list_del_init(&uvma->userptr.repin_link);
> > >   			list_move_tail(&uvma->vma.combined_links.rebind,
> > > @@ -702,7 +702,19 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
> > >   		}
> > >   	}
> > > -	return 0;
> > > +	if (err) {
> > > +		down_write(&vm->userptr.notifier_lock);
> > 
> > Can you explain why you take the notifier lock here? I don't think this
> > required unless I'm missing something.
> 
> For the invalidated list, the docs say:
> 
> "Removing items from the list additionally requires @lock in write mode, and
> adding items to the list requires the @userptr.notifer_lock in write mode."
> 
> Not sure if the docs needs to be updated here?
> 

Oh. I believe the part of comment for 'adding items to the list
requires the @userptr.notifer_lock in write mode' really means something
like this:

'When adding to @vm->userptr.invalidated in the notifier the
@userptr.notifer_lock in write mode protects against concurrent VM binds
from setting up newly invalidated pages.'

So with above and since this code path is in the VM bind path (i.e. we
are not racing with other binds) I think the
vm->userptr.invalidated_lock is sufficient. Maybe ask Thomas if he
agrees here.

Matt

> > 
> > Matt
> > 
> > > +		spin_lock(&vm->userptr.invalidated_lock);
> > > +		list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
> > > +					 userptr.repin_link) {
> > > +			list_del_init(&uvma->userptr.repin_link);
> > > +			list_move_tail(&uvma->userptr.invalidate_link,
> > > +				       &vm->userptr.invalidated);
> > > +		}
> > > +		spin_unlock(&vm->userptr.invalidated_lock);
> > > +		up_write(&vm->userptr.notifier_lock);
> > > +	}
> > > +	return err;
> > >   }
> > >   /**
> > > -- 
> > > 2.48.1
> > > 
> 

