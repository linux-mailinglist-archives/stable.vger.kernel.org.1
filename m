Return-Path: <stable+bounces-89249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2FE9B52EE
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 20:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE491C21988
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5198F2071ED;
	Tue, 29 Oct 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jgd0W3C1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE7206040
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231205; cv=fail; b=bWQRL7oI1m+L6WK8df5ey828ZP1BBR63nYjqb+W6MhC6ZcBCGAvs4JeTV3BLlQonyzUQgsrwgeSRXzBNM90qivaWikedgjcmtwa05uyZ2ZOBSMmMRXwOW714ZI8FhcTkjoNjaIyttBVzgjVCHLjceWlqotu5c5t+wGetiYi+lyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231205; c=relaxed/simple;
	bh=fDJjlAGATWiVSbmeFpoRf/fI98yRrZZZ48CElb2qNAA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IAh6lTN4DkEz2RbdzhnTfFiSXNuUlcuEo/NznNVfwvlxAxTI6KWNfT2uQ4mAnMsUdB/O53k/tCNPdQUsay7r8tVVxsrWj7rOIr9A8F5gDalduUCHZB9qw8s4zDlP1TQLMOi9U7YYlthM5R/BIQ/QW2NCFXZwHbpwYO6U/RwL2jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jgd0W3C1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730231203; x=1761767203;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fDJjlAGATWiVSbmeFpoRf/fI98yRrZZZ48CElb2qNAA=;
  b=Jgd0W3C11ZFZAE0OQAWfjsTvjvrjZtPph6k2LRMLy9d+0fJL7eG9LoqN
   U7W2YV1WU2nqVqqch/fa7A4JnsNKVCoW/15Q1Bs6rpCIzB8+E5sfm6AUY
   A5xF25I+SW4BKQpnbLURlAnJmioJvKDk84lPvvx9jO7GUxFcPtFYETfl0
   8TCXkPUPB+8qGHiBYH4TE1wfupYP49zRaaaHxXMkr4tRbgeHVhAx0vIqf
   IHoVtVbFtCoUSAU/jPX1toLOW+enMqTs2O5BOMeGC3oKmFn89ld4Q5LQm
   kEIS9QC9/tnf7zwkWnXIngtKWOqMtwSckJi8o5AqJeL6p1N1HqyUWJE4M
   A==;
X-CSE-ConnectionGUID: dEPok8osQV6zHVmd/DtG0w==
X-CSE-MsgGUID: TC5NddU0SQGoots4i3/D2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33599231"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33599231"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 12:46:43 -0700
X-CSE-ConnectionGUID: X/DaZ/prS9yuQaa2zUgy7w==
X-CSE-MsgGUID: RrGR3LMTTcqbOghrF/0aRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="86819804"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 12:46:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:46:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 12:46:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 12:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikJ/AFaxDy0U+ydyQSV3ohLpDY0k+kWArtpet8vuCBfSZLejmwQ/OgQayLbPNPmuRkfg5sFSKQLRuQqH+pQ6xe1Je2RYzFUQc+7uNyVnJWbGmR3NuCGrEaJSi3JAMLqsPsotM3akSs385mbHIUOJCk+ISNa+iCYzXPpdywW5mevoXH0ZgIjZZYg7PV6rx/NgR1BN5uA1nOI9K8tx4u3m4GgDUcZuMXfJhSM2GsJRSmMPxjPKSDX3ypHFMGQxRg279sikCovqSgE3McKk5GYyX1/+Sxb2XbV6Oe1wi/grqslVjNhnaWGkqwZtTlJX0cwF++5mVQzk9jxvLvaU2ZQqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgyE715jAKx8Ct6uLJsy5iai0Ja5crydRoul9P0Yssk=;
 b=ABaRLUsjTn1tR2DZQACNuaJsGhvXvMMtChhvtjv5pYsoLDTRg5aIZj/WS+BgYpFzVcJ+ApvvRwYBa6XRBRYMdVIx/1RDEBzYJx3drtymX1UgRTcLOKT2nusKMWJjw2xzdWy42YKZHyZkkZg8y5DJDywy6VG/zp/+GXqoO9GSBtp5hHcUlZj+Ld4Ef+8dz9PbURQ3M8mXlcB0PCInXpgvhZpFVtMFZ76SwZuMnbuMVWvBAaka6A9PbFof1mnAdhtrqdnUuJ/HV1JwnPiPeywlYJE3Y7lEK0WgBcVrM39V/0s/ZVlbWY681Yu9X2o7gaFvPj3g8V6f6B4r42vNDY/TiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SN7PR11MB7116.namprd11.prod.outlook.com (2603:10b6:806:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Tue, 29 Oct
 2024 19:46:31 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 19:46:31 +0000
Date: Tue, 29 Oct 2024 14:46:25 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
CC: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>, Jonathan Cavitt
	<jonathan.cavitt@intel.com>, <intel-xe@lists.freedesktop.org>,
	<saurabhg.gupta@intel.com>, <alex.zuo@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <john.c.harrison@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
Message-ID: <xzsc7o2n22zch3js32dbgzzxxmzuwltkizcjtlnnfcomjbaud3@tbptbzmkxhu6>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>
 <pug6v3ckrvxd7hkrfmppwxck7nxz3ta36sorzcekpzdwgk5ljt@4hxdgwvuctwj>
 <854j4uzv79.wl-ashutosh.dixit@intel.com>
 <brnhn6qx55xqnldy5sw6dahr4rkfwegew2wav5ao65kkah4kwv@kwkps2xwmsil>
 <20241029193313.GY4891@mdroper-desk1.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20241029193313.GY4891@mdroper-desk1.amr.corp.intel.com>
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SN7PR11MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 4068e871-49f3-4f70-01a3-08dcf852630c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N+wCrdLHjaLijPaPrAmdrQWoFyarvk3SCgP+yjNDdbBKpFDhfhp6BpiAlKLc?=
 =?us-ascii?Q?kAwGrZ4i7i7D+oZmwdyvr1GVAcfy8Y5W0faNmnDf3sjxHnOEBo+VJzMDCRBi?=
 =?us-ascii?Q?v5NCRoc6HfETVChue9rHD7wu/o7ahWql2Ng9uV2SQ4ILLoM8d647LP9leDQD?=
 =?us-ascii?Q?OweRtIuntxuEOv0W7M+cAJtmvmoiQoc79HLfaxmE52lH6fLcVvmGwA+vzgOm?=
 =?us-ascii?Q?1/1C61cj9JlgoJmd+EApcFMjl/QBritPCdtRzQvkVFhBZqXxX63FPLvb1qqg?=
 =?us-ascii?Q?Rtw3kQm0eueRJ6+l04kegTEwLYOv2MxbATkma5h+2miu6rJZN1Hhm83pTetO?=
 =?us-ascii?Q?0D8n64fes4dVYQZ9Zm7sxFfJgyQ2ozdNABQUdH1gfL1kJYm53WwTkL+XwQjq?=
 =?us-ascii?Q?6etWMauRMddi8U7jzwR+2HAeWDguiQmSN18RXVIf4LdLtQlFgU02ClNO0ReE?=
 =?us-ascii?Q?s4TfQZM8YUd2sTULYKprF68uInl5hLHwxh5irAItiC29tHQ/qOmhwPtgCIq2?=
 =?us-ascii?Q?x5MQshuF2RjTmPj0xYZnB0U9BS/CMmjGp5tzfm+Bnz98c4Im7ZvlU9duzOkj?=
 =?us-ascii?Q?C5deUtpY+LeNRXPsRMptrnNV5kDVfdXaGbyTCCyWOwu+F2fPplEWwWSKovK6?=
 =?us-ascii?Q?8WZFKmLzPTM7WHus04agOwrIuxXKOgFGe707tKHfQjOM0KUFsdCJxmdWwE5A?=
 =?us-ascii?Q?BBwghEcteb0EflsxbpNJ5hyWb1OJfDmGCEwojrjHRdIJPuqPB7pI7zeRpRQg?=
 =?us-ascii?Q?v8iCgWRz6EZiatLeUdwajiwA52k6l7uJH/XQ1NHfMFYssYKZzw1cnLythc3q?=
 =?us-ascii?Q?tdul23rHzQcSyifz2WcKTEWFHEJU1l5k8CX5TU01LUWesaq64CHw1m+n+zWE?=
 =?us-ascii?Q?9VoVLM3zsCOlcKENL0NqdW1iVFMBKjg7+qM+4bieRQM0ZoQvif4GVPf/Fqye?=
 =?us-ascii?Q?SlIkZRgmcPywqMgpa2kO4Hvd/V6U2kuXqY/tyZtvwmpfDWA/cqbQrnQ7XkbC?=
 =?us-ascii?Q?ed87fME7VF/B/BKc+1FRWaa3JDnz+HP6F6Q+NB1OFlCC+8kcyZp06t44Uh9c?=
 =?us-ascii?Q?swDbYcAKPcL5sOJn4/dnb3IiQwDb7bnDX9tl/pT5yTWIvPYypSVFRhNshk8l?=
 =?us-ascii?Q?RGSP9RHL4e4GyfvUMIz6Oz2wh9AHDBYtM8EW80hqA1OKwz+4GGALGpHkZPvr?=
 =?us-ascii?Q?5KIKhnNE29/HexzZlrjoFqjCjHaKd4x9wzFpenjYLrxzoMnhNs/bIZR1VfU0?=
 =?us-ascii?Q?Cwl6RNEqS1iiRZL430usSHJdmuCz4vjFOPid4dxWFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BntIZfmiYBxCBqvI/bizqULzF0hOgIEx3h1wFYzKYI6by22vdKD506L0iBfW?=
 =?us-ascii?Q?T7TjMG3Bbc1b2/vy6GFZlH9dDQjhJe+/lfvwTuk24GdTtuIEQKQC05c6qSSI?=
 =?us-ascii?Q?tdRVn9CZZN/EwzQDmVqUQMWlYO32OjL5JXmYrBlLdk7oUrh9bPAyy43mKYuY?=
 =?us-ascii?Q?dl/8uAUfb4hoV93XBTi8A02cVHVKteQRmypS0I1g/s2eH18FlRQU6QqH6rfM?=
 =?us-ascii?Q?8hNQK7HCezJdwhY6JuEucGSH8k8Q4syBlKJtogK+VpoNK/XIepxwXSNy2j77?=
 =?us-ascii?Q?zK5jDiwOei2SVACSBi9KSBtLvagn9H3j35/jw56N5wQTY9nNNEpTrE9NchbQ?=
 =?us-ascii?Q?F0IBsVNPprorl9bCkyWyv+bsgewa6vKYPlH6BZJl7Wwp2dNnWwhlyqqxwVlB?=
 =?us-ascii?Q?kx8YVxktzfP1UGZMBAePU5g3KSQDnwhLXbTG976xkt+6/SYXoaQ4NvGPIXmI?=
 =?us-ascii?Q?FZSc8L+jgpAQR2cK5207Y7aYe6Ra8QNV/hW/ZVbuDULqNmK9jzY5K8+CitN3?=
 =?us-ascii?Q?Pwvs0uDLm4xcmfCsqRp90wgYBI8ArJIkc+OmiQYHq8zXmNEfBdpmlbfzGFFy?=
 =?us-ascii?Q?xJIeRbP/WHpqwtk5VB1dsX7rJgKjEOQXvu1yusG8N3UjiNQxx5m6d2+x16PL?=
 =?us-ascii?Q?zLE7sf5BFd2yovQDrQLyaF9Fh6MoCKl9sUYadIEEvHyGi6Lb2bYGP/N3lxo7?=
 =?us-ascii?Q?BxZltl2jFNJ48p1x2v5ig79mfzquao65ucHGcU9CqKT6WlzvGjiY2wS0iFtI?=
 =?us-ascii?Q?mMLPqXVkw3hyGxh9TCJ1x/YYpfoYbgZbp+RgNbkNt3uUEiL21BEtFxU6RrCQ?=
 =?us-ascii?Q?1ZU7MNRdbAkSCnsq+Y2yhsfiAsBbUWitlHQ70lYEWd+q2ShC1ZPa3aw4PGtZ?=
 =?us-ascii?Q?Gx5vJQDRpoyCcag4qdldXDejHFS4Nhr0XlGa+k2k5koatfV8h/JYNx/oj00D?=
 =?us-ascii?Q?Xnj+5N5VrRWFUbzEUtDLGYWjDw0+Ro2w7gxuPxHAEExx8K2aP7H5DYR2RBDA?=
 =?us-ascii?Q?cUw5kj9GZgCfUvQ53nIdQcmciNzuQnq40TKuAhUwdTNomnqXGx/9ywwFqfl+?=
 =?us-ascii?Q?EScjnhjIJpYLFz3bUCXjK9mppbUuYTVGKm26/e9JOrNSGU6NADtok1VLDQrB?=
 =?us-ascii?Q?aJR2MpaF+2fst4488u2Ho+Idbpx4f57MatqO0wXfNZIcghvt6xMwsSzeZS//?=
 =?us-ascii?Q?JRA+FxE03ycNLmj4r/2ykH+vd6ZMAUZFJ8zWRqLcfvC+2fTgiRDJlV1Vo2u9?=
 =?us-ascii?Q?SZObIoFQVY0NwT10nJNCF7vzKPvEjpTYTq3gAt45EJG62gDsEscGQwoVgi9v?=
 =?us-ascii?Q?KWMgChjyR5SKo0eoYxLoeCgOPOpk2hK5huJ4GtZmx3TresSrYJhal6LRcaGL?=
 =?us-ascii?Q?XRR9JNUP51IPAHpikeMotppr4MscYg4Q/yDMDADqvAtO2hC3siNQ5NJcI8rJ?=
 =?us-ascii?Q?PZzDTuRoOMamXoSkcVAzASaGyQ108HaBOTzl96DpJDvlzfTJE+SdKcL3HMkm?=
 =?us-ascii?Q?Ufp735sG6mp7r6fuzzK6sh5YGzFxtyseOW5IoGFvpCt1q6oVY6s1yu0IgBM0?=
 =?us-ascii?Q?jCZgVxclwEMCR9XIWoZAYXoveMoOPUDBiWsfIn9hKCn1dnnjeYq+ysPwMiCd?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4068e871-49f3-4f70-01a3-08dcf852630c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 19:46:31.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DMgCm6uMYb2KPy/te09ORa5zvq0ag16LEJZcrMh2jEtTIh0gL0XhqUY5609oaxGFHdparLCM2UijGlUs0awqlVqi3ety9eCbOIicmDWMmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7116
X-OriginatorOrg: intel.com

On Tue, Oct 29, 2024 at 12:33:13PM -0700, Matt Roper wrote:
>On Tue, Oct 29, 2024 at 12:32:54PM -0500, Lucas De Marchi wrote:
>> On Tue, Oct 29, 2024 at 10:15:54AM -0700, Ashutosh Dixit wrote:
>> > On Tue, 29 Oct 2024 09:23:49 -0700, Lucas De Marchi wrote:
>> > >
>> > > On Wed, Oct 23, 2024 at 08:07:15PM +0000, Jonathan Cavitt wrote:
>> > > > Several OA registers and allowlist registers were missing from the
>> > > > save/restore list for GuC and could be lost during an engine reset.  Add
>> > > > them to the list.
>> > > >
>> > > > v2:
>> > > > - Fix commit message (Umesh)
>> > > > - Add missing closes (Ashutosh)
>> > > >
>> > > > v3:
>> > > > - Add missing fixes (Ashutosh)
>> > > >
>> > > > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2249
>> > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> > > > Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>> > > > Suggested-by: John Harrison <john.c.harrison@intel.com>
>> > > > Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
>> > > > CC: stable@vger.kernel.org # v6.11+
>> > > > Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
>> > > > Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>> > > > ---
>> > > > drivers/gpu/drm/xe/xe_guc_ads.c | 14 ++++++++++++++
>> > > > 1 file changed, 14 insertions(+)
>> > > >
>> > > > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
>> > > > index 4e746ae98888..a196c4fb90fc 100644
>> > > > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
>> > > > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
>> > > > @@ -15,6 +15,7 @@
>> > > > #include "regs/xe_engine_regs.h"
>> > > > #include "regs/xe_gt_regs.h"
>> > > > #include "regs/xe_guc_regs.h"
>> > > > +#include "regs/xe_oa_regs.h"
>> > > > #include "xe_bo.h"
>> > > > #include "xe_gt.h"
>> > > > #include "xe_gt_ccs_mode.h"
>> > > > @@ -740,6 +741,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
>> > > >		guc_mmio_regset_write_one(ads, regset_map, e->reg, count++);
>> > > >	}
>> > > >
>> > > > +	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
>> > > > +		guc_mmio_regset_write_one(ads, regset_map,
>> > > > +					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
>> > > > +					  count++);
>> > >
>> > > this is not the proper place. See drivers/gpu/drm/xe/xe_reg_whitelist.c.
>> >
>> > Yikes, this got merged yesterday.
>> >
>> > >
>> > > The loop just before these added lines should be sufficient to go over
>> > > all engine save/restore register and give them to guc.
>> >
>> > You probably mean this one?
>> >
>> > 	xa_for_each(&hwe->reg_sr.xa, idx, entry)
>> > 		guc_mmio_regset_write_one(ads, regset_map, entry->reg, count++);
>> >
>> > But then how come this patch fixed GL #2249?
>>
>> it fixes, it just doesn't put it in the right place according to the
>> driver arch. Whitelists should be in that other file so it shows up in
>> debugfs, (/sys/kernel/debug/dri/*/*/register-save-restore), detect
>> clashes when we try to add the same register, etc.
>
>Also, this patch failed pre-merge BAT since it added new regset entries
>that we never actually allocated storage space for.  Now that it's been
>applied, we're seeing CI failures on lots of tests from this:
>
>https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3295

right... it missed updating the function calculate_regset_size()
to account for these additional registers.

Lucas De Marchi

