Return-Path: <stable+bounces-89258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514BF9B54F2
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 22:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54204B226C3
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00B20897B;
	Tue, 29 Oct 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6JLWssF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDB1946BB
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236806; cv=fail; b=pyx1U0KPcAEhJqxS7pfOvv1qb7q4DlK0bZqQMbxWmZiEdqoHdAHpAVtRxbrn7pqBpncI3GXkP1YEv0nNMIRKX2UfhqvKoArfrF/+lBW/FTTElV5O3P5absLtWkekISIFB29AR6Suy2fv+eV9BChP/cFBoFObzhY1cyTdeCOPmGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236806; c=relaxed/simple;
	bh=FbIRNKrYCqE0BlC3J0rmk/8OkRldWwb3PbuSDxyu1c8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kDuM7hbCRCQoMwl0g7fHQkEqrm0vdW7P1lrVcfYyvZjXxiVEEvMJ3+igrp/9eA66N50F44NaDGsFq+RvdVq8z0HxQ1xTNRfuif5AQVl4QSaPoNLBmVeWxQqg1sLuq/nPJTEjK64NLBtnnjvtcvKF88sA1QROz1nziam53Kq1nnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6JLWssF; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730236804; x=1761772804;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FbIRNKrYCqE0BlC3J0rmk/8OkRldWwb3PbuSDxyu1c8=;
  b=m6JLWssFjao4PvVmrTSCeZwuFE8QfF6FJuoMAYd7jBNhMkka5NwlI8xM
   1JXFL7Dvy9LEwO1jlTxkmnXhWlIzG1dCpyzIIwLVIYwn73P2Ldd1Ht/Mb
   yYG+1S72E9T35mbOmS4SI8tq5go0pi76J/b91qzDTr/nf9mjlNN6eojOl
   i9QYx+xQm3UMdCVgKxSu9qzBcQl1fJZXNmw82z0KHjIMIiqU5bNtKIIDF
   KiY+zFP5xY7cTdtxLf76Mix0JhCJe7KO3jk11fr/INKyPfpNKqaBCZ7/8
   4dXn7yyQUyKPrjXZIo9RziTJVSOjdsHs27TuKRNn1QGGxpIU9B8+P88+O
   g==;
X-CSE-ConnectionGUID: SsXA8jZQTc+6+gnNafVZIg==
X-CSE-MsgGUID: 8OI2hDP0RbKXtfeQapm9NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30055250"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30055250"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 14:20:03 -0700
X-CSE-ConnectionGUID: eE3vNTZAQTCbxAeust9f7w==
X-CSE-MsgGUID: M8le9f6zSLWEMj9EIuxHeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="119573094"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 14:20:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 14:20:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 14:20:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 14:20:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoRfMbPRXkOi31eFOuPYajhdvwdJYQFQNxMXxKiXNt0Hh+2nMfeBeWu09OBwYizQobKrHsJTGKzOMiOlnYohIK3JQ7NEvhFChINw9fNtmrvI9i5fD7gT5aUcLAVHlaORkS1J15KwP98edBmcfvHJrXoXUcnCLYfYXcbxQBBdLxqJ+UXeqpcEawHhtuX9ZLi1q9CO1MC5bCQnT+hPzLGBBBOnd70rBXifHxNb8agUGfYkb089+ofbfs6nLkVUGqAIq79a+6E11Wv+uOGaeAgGRdpw09ec0duW71YNYHsKcFYOZuJpI1tGRGC1vw0Mk/PoMz0UvGZTl467SI5RXHS/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHYr2IJ+fcEFmaS7zIqcEQEzLmpG4qCfz5OQZCYYtFk=;
 b=qPtHt3T1N9ieYEp9PiNHFyaztgvT2O42MX/CWF+2LfvlMGBV7T/bR82+/7Qte7gON+b6Fy6e7kxOQ2eOPPo3yUgf02T30f+jzlmnZymAXw0ns0tItgHYoMno7xJwIjenGE8j4uemV9FqwTuatBN5X/uO3KQJSEq7XGji++CXVspRIxGVfhDC9JCau9X4risjVz2Ug6Z5qZ7tWK/vxCyk6f4FwRwhA6OWN5X1tZP0O3BjkBQr2JvUc9utf450IH4c6NhEoLb4mJYw27IXjgDIdb2NsVMWeqN6Lcwd7c1an9nEH+LJoY9X48995LjM7R9cFUGOTSNuiwsuyMuGON4S4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15)
 by SJ0PR11MB5038.namprd11.prod.outlook.com (2603:10b6:a03:2d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 21:19:52 +0000
Received: from DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543]) by DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 21:19:52 +0000
Date: Tue, 29 Oct 2024 14:19:47 -0700
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
CC: Lucas De Marchi <lucas.demarchi@intel.com>, "Dixit, Ashutosh"
	<ashutosh.dixit@intel.com>, Jonathan Cavitt <jonathan.cavitt@intel.com>,
	<intel-xe@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
	<alex.zuo@intel.com>, <john.c.harrison@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
Message-ID: <ZyFRcxPoKX6Libuc@orsosgc001>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>
 <pug6v3ckrvxd7hkrfmppwxck7nxz3ta36sorzcekpzdwgk5ljt@4hxdgwvuctwj>
 <854j4uzv79.wl-ashutosh.dixit@intel.com>
 <brnhn6qx55xqnldy5sw6dahr4rkfwegew2wav5ao65kkah4kwv@kwkps2xwmsil>
 <20241029193313.GY4891@mdroper-desk1.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20241029193313.GY4891@mdroper-desk1.amr.corp.intel.com>
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To DS0PR11MB7408.namprd11.prod.outlook.com
 (2603:10b6:8:136::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7408:EE_|SJ0PR11MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e39c88-6a03-40aa-7a99-08dcf85f6da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z052LzZXV2prdXBpV1UrMEVldWRrMjU1TEFseERicTZUalVRVUYvY21Od29Y?=
 =?utf-8?B?Y0owaHc4MWU5dnNPd2JsYURmcXFnWTI1NkJzUy8vWVBQQjlTS2E0TEU5Qk0x?=
 =?utf-8?B?V3dwa2RhcS9FSlh0Wkt4VkxZM0MyZFZJdFZJMS9OT0RnaUJEZmIrNW5VSEx0?=
 =?utf-8?B?b0lHSkVHbFV2WEd3SHVJUHQvNlgwVTJHYjRNZDlqaENGRS81S3RJTDVOL1NQ?=
 =?utf-8?B?Wk5MdmovdVRjRmdMb1JTMnNZV24xbzlBVkh4WnBYQk83SmMyVGNJaFRRUWpC?=
 =?utf-8?B?MG1KQ2lpdkMzcVQ4Z3lHTGx6eHgraEE1NGxZenJYemxtSnh4emw2UXAwRHc3?=
 =?utf-8?B?bSswZGJYbFVFQmlLWEFXenl1ZlBzd0Uyb00yRWp5Q3ZrcHNqaXlhOFN0VVM5?=
 =?utf-8?B?aVhvK01GMUJETWVyc0QzQXQ3MnFzYXdKajJpMUZEVDVqMWhtbmRyL2poOFY4?=
 =?utf-8?B?MElVZWFTZXFXOTJYOUhGWXFYd21GNlRmemxrdExQU2FUdGRvcHRLTjMxQ2Rn?=
 =?utf-8?B?bzdzNVFiRFZFenIxWVk3Y3Z5UUY4dElBVGtVTndSUW9oQWIxeTFpbllwbldZ?=
 =?utf-8?B?WldQN1I3aDA4dEZ0RHJ4Y2V6VzlrRTduZ0lTRGoraitNVG5qTGRhSmF3OUFL?=
 =?utf-8?B?L0w0UDk4eW1GaWV6eUxSK3EzVDYvTWhuNEoxaDZNYlRmeEMyQmFvazdHSTRs?=
 =?utf-8?B?RXdjSUEycldIT2dKM2FhQW4vdVQvaGVja3pjb1VVS2dGWmdHYTB1WHRkakRr?=
 =?utf-8?B?VGdSNlpaWXJFR0VDdmMvTEt4MEtkWHErOFNmSXVnYk9pa0FBVUNjYTR0d1Zu?=
 =?utf-8?B?QTZSTHBTT0dtZklYNmY0WUpIQ0tSdlVHWHRoQndjRjR3TWcwd01DQjdjZ1pw?=
 =?utf-8?B?U2VtU3FKUUdHOWdKWHQ2cWQraHFrcmFjby9FV3kvc0hOVC8xY1ZZSzY4ejJH?=
 =?utf-8?B?UzlQSUZFOFczaHgyeFozbGNrSndHY1gzNWM0SXdOYStZQ3I5dkxBNDJPQ3N5?=
 =?utf-8?B?U2ZqUWJ6OFJVMUFrN1lGYlJJZXFoV0M3aTFrQlN1U2RPdy8xa2JmdWhTUC9E?=
 =?utf-8?B?a1pZTkk2a3d4b2Vld2p4a0VRYUdDM0VHVUo4U2VPMG9YUlNVUXhZTm5OeFN1?=
 =?utf-8?B?cnJNYmcvUFVvcWp5R2p4YTZya3o1RWtLc2lPRDZiYjVCekh3eENGd1NvNXVD?=
 =?utf-8?B?ZzZha2lLdUh2VGs0dXpiYzFxZDRHQTd1K201R2ZZM0pGUFVqaWNRSGt1K1NH?=
 =?utf-8?B?WHlWaXhEaFlyZkZWME82eFQ2RU5wWmZ2T0l2c1cxNGlJeUdNaktBdUlrQS8w?=
 =?utf-8?B?MnY1cjc0L0pCMTBHUURZZHNyS0p3T0RjY2hlM25mNmwzdC9PNHorMThJejVr?=
 =?utf-8?B?eUNhWTlHUSt0YktKTUVsMnNWRkNOQkF6VjdFSVZWM3UxSzJxWWhtdEpoMlNp?=
 =?utf-8?B?cGhaQW0wNGRrdm1hTzYzS1IrUlpFWVJFNzJYampKcFEyNDFNdHVoWmx4Qksy?=
 =?utf-8?B?VE5LWlZzaU1ZREN3N1ljbG1oNU9yQjVqS2RoSUkxOGhzT29TR2o2N2EyYUlt?=
 =?utf-8?B?MHF1cS92WTZVd1UxU29XRVRXZnArT0dVOGo4SlAxdC83cERveFEzZDlCd1lm?=
 =?utf-8?B?MWs0b05rN2RET2k0aEwrNS82UmVRVFRsQnpJU2pUL1F0WGJLRFY0ZTBtWjdI?=
 =?utf-8?B?d3Q0d1BQUlMxYnVJOWRWWU5veVJxOEN5ajJGZTZGMi9UWEI3dzFWc2ZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7408.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnRvUkw1SzNmUVJPUmhxQ3hoYnIyQzdkSGVYNENhMXJUSjFxOVVMamVpeE9h?=
 =?utf-8?B?clIvQ0Q4czJkOFMvOG5kM1IwV3MyQWh0TlFrZWpaMmE2eC9ZZjVpMDZkMHVV?=
 =?utf-8?B?enRqVnZzQ2pwWnBscDJtTDhkcVV3Tmw5dnhyeG40akc5aWR5MENiK1lBUXFH?=
 =?utf-8?B?SXNRQ3liYjFWcGFBZUhETk1pSHVRdnVtWVArRnpnNGh0YXF5M1Y3RnRKa3o0?=
 =?utf-8?B?UFdhMWpqVkhMSjYyL0NSU1hyYytReitDaEdoWmU1N2tzWklNYzdFNGVNTVNh?=
 =?utf-8?B?OUhQOTE3Rlg4TDM5RTRSWjJhNlJCQ04veGdLSGNGV1dEakwrT2N5Y0dpMnpD?=
 =?utf-8?B?YW5ibGpvNEhONHFvc0Q4MlpHM0dLZFNEc3N1Y2xlMlFHUEY0Q2ZQb2J2L2gw?=
 =?utf-8?B?a2FyT210enhQT0MzcjZEWFZmRUhyd25neHR1Q1FwQUxzRUpvVy9IL1MySHQr?=
 =?utf-8?B?bERXMmdBT2pvVTBscjlkU0s4T21lNEYxYWozWW9XbFdKRitqeHQreS9md0JY?=
 =?utf-8?B?OCsvS3dYbHJRRTAxM29HZGcwcHNKMFJZRmFMUjNycW1jWE9NenRiTSthY0lq?=
 =?utf-8?B?eHFvRVlhOFhmNkcreGUrVDRkR21YeG5rNUtta1o1NXNrUk9KVHc2Y1lBcWpk?=
 =?utf-8?B?TnhSUUM1aEtiRmU3bU9BOGxuZS9UTUtyYS9mS1IzaTcrRmFuc2g1cUVoZWlW?=
 =?utf-8?B?dStKUzNldG45UEdXMEVOSmxRRTFSRmVacE9jV0czeURIRFNnNkI1TUdGWHBo?=
 =?utf-8?B?U2Y1ZHVIWkJYc1pCQklJalViNm5CcWFrdlFWdUdiTXBicnFHUzhHejNoZVdS?=
 =?utf-8?B?WDlVS0c0dnNnSFNYc1dnYmorL0Y2SnpLUlJpb3UyOVRFR2F5dXliMytiaFIx?=
 =?utf-8?B?V0gvVkZHYXFwUnZtbUF3R1NxVVVpSXovQVNkVVAycVg4dnAwRzJQZ3hXU3gz?=
 =?utf-8?B?cGJXejcxVmV3ZmZtMEYzaDZrdlNzMmpabE9YMDdVT1FMUUlOWlpMbjRLMXRq?=
 =?utf-8?B?SFhtMkdWZjVtK29QVzR1TFhBTTRZajVQMllrRThReVVpbmNhOWR2cUJibFBa?=
 =?utf-8?B?YXNyaXgzNVdFakt3c0ZQRHNIUVMvaS9oVVJVL2pBb1p3V2FBVGRRZnpBMlRu?=
 =?utf-8?B?emhVanMycllOWWl2WnhJQURDbUp2UmdSYlN1TDcrZTJvR2g5VHFvSUZXb1B4?=
 =?utf-8?B?NkJteGUyRHMwM3RqQ003enRzOEUxQXRxdThZUnV0YVJ1end4b0xjcEtZa2hB?=
 =?utf-8?B?dkpFNmJXU2RFWDN5UCtRVFpzYk5YWVIrb2xsNkIyOEwrNndJa2RqR09LcXF4?=
 =?utf-8?B?MkNmVm1ibG9pUFVFRDZJa2YvR3YvQzJOcTRkaC9ndG84Nk5ROE5TUFl0MW1a?=
 =?utf-8?B?RHlJWGxCZWJxRVJYZ3AvY2czb2pEd2FYVG5NTW1vL1JyT1BTZUM0R2RLaWlu?=
 =?utf-8?B?VmVYZW4yL3N3aXhmYU9PcDhZOEVuMjhqTi9NNEZqVyt0djBWakVIRVkyRkZ3?=
 =?utf-8?B?enFEbUhmRmlCU0NOQ0pJWkJHMTd4Tkk5T3JqUC9OdmtVbzNHcWtmdGpaeG1i?=
 =?utf-8?B?YjBGTUdNNGordDdhcHBoeTNKWmxkSitEODUwdnIwWjdqamI0REovb3VTYUZi?=
 =?utf-8?B?MDEyaklpUFFNM0piMmFab2hEcTZVUG11Tk5JQnlHOUlWSEZENmtvMjRCeW8y?=
 =?utf-8?B?dnNrRXdia0lDRFhYR0hTRmtOTVRZenV6MVMwRFBnQU5xZE9JZ3UweUZJUllU?=
 =?utf-8?B?NWFqQkpNbnVwUVBpRC9NVnpOVDQvd1FXRmVPemoxL09ncjYwZS9OaGZYM1JW?=
 =?utf-8?B?cWFVUkhxZWcyVFY3S0xlVTVnazZMQm1MNldoQUlndlRWd0dYNEVURHJBY1BD?=
 =?utf-8?B?VTJwZnFmelg4RDY5dkxyM3V5MDVicFVLalZHNEJlcGJjYUEzN0NyRE95aXhk?=
 =?utf-8?B?Z0diZm1rdHY2cGhFZjZiSFJXUVBKYXpzYWo1anVkdEViRnhEVGFpVDcvZTVS?=
 =?utf-8?B?MjhxZmt2YkxvQzV3bURXeThlZVJqaHlCRHdOQXNYcjgzV2pDQ1ZWd2dxem5k?=
 =?utf-8?B?S0hHRjZIS0xkb2tLMXF5NlMrdTBBTUhZY0xBaklkYXBCVnA5eENLOEQ5Yi9V?=
 =?utf-8?B?QjdmYWhaUFR5SUVoT0ZUQUxqSnk0em9aM0dRdWpGdm9PbVJTN1gwaUk3d2hl?=
 =?utf-8?Q?jJLUqsFgG45lo4u0NeQV8oo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e39c88-6a03-40aa-7a99-08dcf85f6da1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7408.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 21:19:52.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt+YWScNSVkuZRATDM+osfRSPV9IZE2zSGYYFUUgiq6x9yzczHL3hFZubmfMXCmku2fScffDUzSXhpSha1QcG4MsgSAnw05sc7vHDgct7mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5038
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
>

Sorry, didn't fully understand how this works in Xe KMD.

Does this mean that we should just add stuff into the 
register_whitelist[] array in xe_reg_whitelist.c OR should this be added 
to hwe->reg_sr using the xe_rtp_process_to_sr() interface? What's the 
difference between the 2 ways or when to use which one?

Thanks,
Umesh
>
>Matt
>
>>
>>
>> Lucas De Marchi
>>
>> >
>> > Ashutosh
>
>-- 
>Matt Roper
>Graphics Software Engineer
>Linux GPU Platform Enablement
>Intel Corporation

