Return-Path: <stable+bounces-245151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DpLCPiOAWpyeAEAu9opvQ
	(envelope-from <stable+bounces-245151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:10:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A90509DCF
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C92D3028DC5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545013B6BEE;
	Mon, 11 May 2026 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbIx1MGL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E23AB28C
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486629; cv=fail; b=Oo8iwy/YFyhj4EsTlwjMDUJZixgfTBnADoSQC3ijLa3hLYcU/F9Qp8SWhKyeXS8p2E40TZBclmX3rwX2AcGfNbToblJ8DUWyCmuexGHzBEFOt21pwxRv+8HxqFmPkC/LKQNqVcozZSWMt6He6YaGK058ATjJPt/8SEl1NeOfSa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486629; c=relaxed/simple;
	bh=sW7hQQmv4xMsuSmZylNU7627CfSMojAKjdGDYDzA5pU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cg/9b4G4x3KNsXKfFojSqK8ya+0THVGCeNJCn2LtZUMmnMc+CKMzVrdADvgleFBk9luw4oUYli+K3N4I29x9fNomEGNCckFsNzImTM3x3f6LGeJ6V2W9h88VImkJ6n4UwRa5+KwqxyHQCVyIg9nzKtOMo+UtlbITJGhjc6UEjqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbIx1MGL; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778486616; x=1810022616;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=sW7hQQmv4xMsuSmZylNU7627CfSMojAKjdGDYDzA5pU=;
  b=lbIx1MGL1OvTjTGu0SjoO9kuP12H8cm/rmVvzOzj8Z2DSm6DzIk6jD3F
   rGuN194Qo0CU6kme8GB5EwcJgUP0tfGHj1PJFdXDrk+QPmpQ7ipTi78D4
   baj7ZiSouw+bOndic3h/eb4/MoEx0pRwfbXCr5czAKleDNr62kqjKPBkr
   8c6tATmRw6S3qGWKXXMKJg9upl7ISYo77se0SzgIVD6hUkeN/miwPlzVt
   21rfsqSUQwFvpoOayCxglYisje8ZQDvGnPBDWAPJq33JMQ/aGW9DyhnnM
   ZcCEVgz/5lFpmlvj85Utif/PlXRViyIq/bzGU+JqHyXcs+BHvp9qTeOph
   Q==;
X-CSE-ConnectionGUID: aBl8x2pVSuaFgzzmNrLiPw==
X-CSE-MsgGUID: P0tsBLVyQjaLshmB6fOGfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90067033"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="90067033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:03:33 -0700
X-CSE-ConnectionGUID: TvdCoOeASYGBnmuzA46PsA==
X-CSE-MsgGUID: KL07nVXBTGqRiEDJnQXsIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="234324418"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:03:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:03:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 01:03:32 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nX2i1eThLZGV8qxCw8sA+GiIXMKHT9W1wcgfTS3QLOc24T8DZW964Wuh92gpVR2Jbha4/A9QSA4CqxYRLKLOqQDSiyNkfxwU4Jv9qGoyTCd/nPsX1RRXmRuGO6vsMJvpbZR427Qch6YygXc+2A5ibgV3skaq3i4y3ed7/t8mhIytTTUDbC1SlPmkBhNbz+9EG68GGHzfOYzIx68YMsMTuDZq7a3D7U5n9EC+BicryVhLINH609qiY3tGKoAh3MwkKi2Ra5Sci/RNl9OhnIuFtGUVzF+HOZHAWoNbsQyRIIvKJatuJZgdiP8UpnITP+XbT8y/PXTZTVJ0JegUar36Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IV+O/+0Bedz8q7n6osQNd13I4gVPcApQZzb07VpYa8=;
 b=YCpW/Jq+eJr8ROKIvWqcEOvhbvPy/QXq2+wFzapPNgw8eaC6+DimvM4LIkTS+y4EPfH8A4I71Vd+wTISbjVCcX8Vk2wvOH6c5neY/khsIN1SoFeF+u+dWvn6paN+qc+q54RlygYOhaIcXq49y78/OZj417M8ZIUc8ULRR3j83750Enu3yl9x96notgEZzqIkS1BB9jeRq+Jpa3ivNJN0QjaZE5hZdUXp9RAgLLmN10ejhdDMb0bZP7LDTsjf1JZ8nPyPgGVlahNXnc8tjMJFR+MNul9Ilu1MlBqc3fHWF7lJlQ8NfanG91/Tp6EaRcS98jEoBRdYCebwrlkysqdwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3658.namprd11.prod.outlook.com (2603:10b6:5:142::24)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Mon, 11 May
 2026 08:03:28 +0000
Received: from DM6PR11MB3658.namprd11.prod.outlook.com
 ([fe80::2c3:cb39:90c:2542]) by DM6PR11MB3658.namprd11.prod.outlook.com
 ([fe80::2c3:cb39:90c:2542%3]) with mapi id 15.20.9870.023; Mon, 11 May 2026
 08:03:28 +0000
Date: Mon, 11 May 2026 11:03:21 +0300
From: Imre Deak <imre.deak@intel.com>
To: Aaron Esau <aaron1esau@gmail.com>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <jani.nikula@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <joonas.lahtinen@linux.intel.com>,
	<tursulin@ursulin.net>, <mika.kahola@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] drm/i915/cx0: fix PLL enable failure handling on
 Meteor Lake
Message-ID: <agGNSW0r6w-IHW_q@ideak-desk.lan>
Reply-To: <imre.deak@intel.com>
References: <20260509162407.510539-1-aaron1esau@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260509162407.510539-1-aaron1esau@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-ClientProxiedBy: GV3PEPF0001DBCE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6ac) To DM6PR11MB3658.namprd11.prod.outlook.com
 (2603:10b6:5:142::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3658:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b4e658-11a1-4240-4b31-08deaf33c8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jMvaxTXsyqzLkTFfLMW7UUb9HkrghgxWJvUMY9i8SFJJFu5n57rkh3CkH3ainYiPTx4bCvNxPvEpC87Ylvcm6Kw8rdLf869ZbKN0UoFsIt1MDlexNI4kfvE4cWF6GNJWSOfbwXMmVopscW3PL+OTi1qKvcgxavKWU/FPjYYZ231L7ap7et7nHkaHBdbHDwyP1iEZc57AU2Q+b04kLP/neFuEuaGIYAaLw14Yfd17LblACYMHMu2/EDODztiEVVicjonfzX1WdV0OjkN9ckQS7L8zV7TPbCp7Qi/qNTN3A1znmWlNaSbAgjobT+F6uDsSNDqth3iw/s4Sv5uF7W/ohkHC+RVJ2W5iqoj1FiaNY6XX1I6v19fOvopEaEnwFci+/tAUBXZDEdvSs2wzIqFAtpKWGAwnIeU+kLeKH/jdEv9aRknPZ8DXwsJkhVhEKY5aZbCHz3RPNkZKRMqi32kvIJjSRu1nE+YDJRiv8uE8KAraylfj/xfifPtm0SMg3W7rgCE6orJJjOIJtTDNfRIAROT83P8XkEP4nAZP7IlCeZFoY0XH5HaCVtsm6xkmwaABacPrulOjQ9A+vUDInnBZjmqlfg9NtzD/S/xUZY3DN72n/KiMTHOIA5ybmEc8HTe5H32zmDLc2xN7CQMuiZqPim/Zw5GnUHGKIWIiBPPvACl+2eZB1ypy6gfW2Mv5MmIn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dL9xT6XfahiRuSSMhK3ajpmI0kK3PprzID2hUfevE8C5vznqUiF800Xv/kY/?=
 =?us-ascii?Q?cEGiSvt2LNdmjsaVsTONjwOfoclaxD6cU/k3jdgBPHGrxdxP2blNhxTSQfH4?=
 =?us-ascii?Q?/098DSB0F/3LTwReflxd7mQF9zu+YqKMXeH9ocmJMPbzWRYygUN6BERiV24K?=
 =?us-ascii?Q?KBi+aPzHyVCSZVYSelZIC9lP/uD/ypmWSaTKi5ouD7kFd/JSyHGc/GcV2brN?=
 =?us-ascii?Q?dpLvhyqzVzfcF4szEDtbBFLxDr+7mrZ3uoxVlTejBpCBNk7vqkxKYa30ys7U?=
 =?us-ascii?Q?/hQAh7LGouvc0OJxU/BKE11/uo+OvRSJ1zvPcA2KkhLY5/Fx/9zRN/NA5qc0?=
 =?us-ascii?Q?9LMa+bZWlsfXFzfMbqINErJXaNZXTFVLkEbAHVwU5EwdzXhuMk05AU0P2Hkl?=
 =?us-ascii?Q?k9ygcg4/S0tG2B0BggRZjFLLeJCnNa5eAW2gUcuYAdoRWPs2VTuSVpQS8KKF?=
 =?us-ascii?Q?bjDUvX2uEoPHHlX/iPUA5p5UzIMuQbyy3gKJ80Ft2+NljTqeWWNj2HDbn8Jw?=
 =?us-ascii?Q?oI4sICRLxJwSiTvgkeIKf3F0EzcBz/V/PhL5cpIiW0/tK2ONVQ8Z16n+XU48?=
 =?us-ascii?Q?NEs2yxubvCZUAWGKiW14sGGVysSX5V5xZEg1CVFj1Q+M6ldEXb/sXUqSpy7R?=
 =?us-ascii?Q?VV+Qy21RSwQ0Ldh+lucNNCrgJ6q4UY/WWIx7D4V6F+WR6uzy50QIgSp4yU5p?=
 =?us-ascii?Q?3/qbekG1eGvyFbjpt6x3SWA8gL/dsgaIburL7X+DgHPbX+P+kwgY0H67uepK?=
 =?us-ascii?Q?tZIvg3HrDUam2kZ9I7EulVHzP9VQn9zFU2+TZZTHatMOtiUBWVGm+4d2vSdC?=
 =?us-ascii?Q?8zwIhyevvRijfyUEOVDKV2kecABV2JtqnBNcCMnJkDRags9YCGqqxRcYcS34?=
 =?us-ascii?Q?I9QtwuUlXotFJdLMr2klgI+w5SikJJWGqaCuFGGjN2/VKrWgxQ88/y0v4kBH?=
 =?us-ascii?Q?PSlkNGszr2VR5OeklkylrtENAMk4g31nyftzWftICcUnxDWCeVs0GOC/q0wv?=
 =?us-ascii?Q?n04ubh3younXOoWNbW4TN84EYMQMYsJH8HwIFdyjXBjgq7tcMFE904IwlOnW?=
 =?us-ascii?Q?QfhAItdNT4iYF4YSDy8kpeYTt64VeuNgfUZxlZanR4xIJjzndmsWjugAEJW2?=
 =?us-ascii?Q?qHJUE/90AHIh6fX56daiKCUU0t308fNhiBvkDyvpzaGKyaE5DcIKQfoU0AZm?=
 =?us-ascii?Q?dmtVOKqjU1SIy1n5L883b5+k5Cy2whXhminek5jGZiYZsAtxKNfExAFqft80?=
 =?us-ascii?Q?GAPkw3P0VrmqItf2zyxcU2pLqCtWfme2r0sdihX/hhZuQ/EF/qtNp5g/mLf+?=
 =?us-ascii?Q?61jaWNASX/Rk/NOX5vhBe+wb0W7LPu1VTKGThCsf/KOtFTsH8ch8F6k2IgXY?=
 =?us-ascii?Q?MIWVUmZK0tvw+mfxvrB+mkty7J86T8xQiMwOW+5sGJeycGB1mLrwULchsdPi?=
 =?us-ascii?Q?ckNF8dar6MVG6xSG7vxd920zj4nqShF3hPrMG6nGLYiDwO0vRYKfHrBR8u9u?=
 =?us-ascii?Q?DRNmxITtM9PWZQmJMKIxtbHwVCto67pQy4kjfpLy7J9nd+o3wvcKJh3sZcj0?=
 =?us-ascii?Q?NV/w9hyjll8me5chmHHzG4CcrErijxaqcdtQji35LQgz/BlNZtudYdFHuW6x?=
 =?us-ascii?Q?U3I/CP1mWD1TVjcc0JAWK5dWibGmSzYbwZ2/fvPEvhQNjZ653QsJJYsK3hrF?=
 =?us-ascii?Q?b0wx/QEpOJngPXe5dm7L2fKrEyLiXK0QPhb2g6M7ff3kvlKRxsm/49ca55LD?=
 =?us-ascii?Q?/cPeL0OO9Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: DhswtbdZDPAgCVLUIR7e+3Mtla8w/QH2Rr5CCJ8x6RZjs/KtIVfKCKseoUwnblVXyc1rbgRDgDmv5reoz+jJ+aie3oAh/J/vsARLk9YYWfxGdO8nVHIFwL65EjBCBeQa3bgP+x8sUWQ5HZl4yZQPAqlu4/HGLI2efmghqA5txmR2Iwx3xbSOPb2FP7F4x8SJ2RNO3G4kDW2euW3fBDyMoBQUpAlWRlPxl1pgVpWXw267vZbYKS/lUyVcZqe5c6ZnHRBXnjezuL0+HJ3kUXVBYVIvV1e+Sh//Hs5tCQgGdBlM3YMp0Q8ImvmVkXuZCZEuHWJeAxdl/omY+9QIM868ng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b4e658-11a1-4240-4b31-08deaf33c8f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:03:28.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KXKrd0pIp+BBp/FC98IipXM1CmYvODONxgUgbSEEaKTIPgZefPax+WyoVKEl4RmMC10oUyALPWMxlnzh7bbjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C7A90509DCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245151-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:replyto,intel.com:dkim];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[imre.deak@intel.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imre.deak@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 11:24:04AM -0500, Aaron Esau wrote:
> On Meteor Lake with a hybrid Intel/NVIDIA GPU setup, s2idle resume can
> leave the CX0 PHY MSGBUS unresponsive. When this happens, the PLL
> enable sequence silently fails: register writes via MSGBUS are dropped,
> the PLL never locks, but the driver marks it as enabled and proceeds to
> drive the pipe.
> 
> The root cause of the MSGBUS becoming unresponsive appears to be the
> NVIDIA dGPU not participating in S0ix (addressed via the
> NVreg_EnableS0ixPowerManagement module parameter). However, the i915
> driver should handle PLL enable failures gracefully regardless of the
> trigger.
> 
> This series:
>   1. Fixes intel_cx0_pll_is_enabled() to check the hardware ACK bit,
>      not just the driver-set REQUEST bit, so a PLL that failed to lock
>      is correctly reported as disabled.
>   2. Adds error propagation through the DPLL enable path: changes the
>      .enable callback to return int, threads errors through
>      _intel_enable_shared_dpll() and intel_dpll_enable(), and checks
>      the result in hsw_crtc_enable() and ilk_pch_enable().
>   3. Makes the CX0 PLL enable path return -ETIMEDOUT when the PHY
>      fails to come out of reset or the PLL fails to lock.
> 
> Found on a Lenovo ThinkPad with Intel Ultra 7 155H and NVIDIA RTX 2000
> Ada. Kernel traces before each crash:
> 
>   i915: Failed to bring PHY A to idle.
>   i915: PHY A Read 0c70 failed after 3 retries.
>   i915: Timeout waiting for DDI BUF A to get active
>   i915: [CRTC:149:pipe A] flip_done timed out

This looks to be an issue in the BIOS/FW leaving the PHY and display
output HW state in general in a broken state. Could you please open a
ticket and provide a full dmesg log booting with drm.debug=0xe, so we
have a better idea on the sequence and proper ways to work around such
issues?

Thanks.

> 
> Aaron Esau (3):
>   drm/i915/cx0: check PLL ACK bit in intel_cx0_pll_is_enabled()
>   drm/i915/dpll: add error propagation to DPLL enable path
>   drm/i915/cx0: return errors from CX0 PLL enable on failure
> 
>  drivers/gpu/drm/i915/display/intel_cx0_phy.c  | 54 ++++++++----
>  drivers/gpu/drm/i915/display/intel_cx0_phy.h  |  6 +-
>  drivers/gpu/drm/i915/display/intel_display.c  | 10 ++-
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 87 ++++++++++++++-----
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.h |  2 +-
>  .../gpu/drm/i915/display/intel_pch_display.c  |  7 +-
>  6 files changed, 117 insertions(+), 49 deletions(-)
> 
> -- 
> 2.54.0
> 

