Return-Path: <stable+bounces-107768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B0A032DD
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 23:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDCF3A15D4
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723DA1E102E;
	Mon,  6 Jan 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/Kpgdjt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F321E0E14
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736203507; cv=fail; b=KBI1TpUwqFtbF4uVuEnFxJz+r6GRMY4c8NIYjAS60PehOkKeRG1Lb+R7GuFypOyZlA5hSSaNFoY/+gzV6tZEVMh39uIOQfsFiAVbodV/ELTR7kFuBusrXUU1Jym6d8Cdil7/rVaO4w9jrTCcp2MAGrt2xoeXQCmaX/zheQNls64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736203507; c=relaxed/simple;
	bh=opDGOpoNO0ypYZ9jXGEh9TGrus1ychJYoQ6kLaJzChI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Co3r7zGXpJ955YZkTu93Edu/nYn07qZmDRL1eWlBD0aODQ1Ck7lOAFDEN2cfd5ukQUC6bZ7fZ1lVwL79i/xBiUSLC2y+1+YM8U9VdBBxxj6lWo7Edf7OD//TnOysvPBGPn9fgfqj1W4Iayj7zNRzMnTetDtcsRaJDUEfKXo3VfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/Kpgdjt; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736203505; x=1767739505;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=opDGOpoNO0ypYZ9jXGEh9TGrus1ychJYoQ6kLaJzChI=;
  b=n/Kpgdjte9m2HD0ShMDMKuqoBP1+wsNSBUQ8VGHotJvj8wm5MSxJ+081
   RT9JGKCfORvz+mp9/H0hXXWKiNEPuCwBBxpmlKnC0Yfr5z+KhPnLgXY0Y
   2J1SziuPRwTfqfSpUq9844dvUjzUYpdYHOFJ4Mj1dMNhx/MKVEbWUXWS0
   TNufb1uDEuXCP7x9pm67Wt9q6rIbb/MlyJni19wiyVjUsC3J+gtFFPBrD
   PkdFTBdW5eYymFq0BfzKiMAaMQmubKjrIoSbRK7uXVU/5VAzIcuQYGY9i
   FSKc1CdVIPs3jkKiDK03VogfjkEV6ulkeZ9bnIvgyGsUPaNDDoq7aI0m9
   w==;
X-CSE-ConnectionGUID: Q5miunr0TJeVX4lc9CHu6g==
X-CSE-MsgGUID: YhMYuj7+TuW59UWAlZc4Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="40308187"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="40308187"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:45:04 -0800
X-CSE-ConnectionGUID: kY7Q8pUtR3q1NR+5tKaXkA==
X-CSE-MsgGUID: cL4YddMcQFyN1M1vnr9EaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="107629002"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jan 2025 14:45:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 6 Jan 2025 14:45:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 6 Jan 2025 14:45:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 6 Jan 2025 14:45:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdij8M2jxHdhdEVuznA2cshWaCwQ4OOLsi1DcM9yT4uzGXRD/7bEeaQB/iKWTY0PdKHEi75cMCD/dmrNnPFRr+3jPRws8+v++bs32BY4jjgVnDLxHYZOjGLdPneWbFIATRujqLw4XbmulM1l2xr83WrMZ6uK2LiGIeD3iLb1Ge4xl/zrjTnWB4CBW1mQ1VvxewjObD7bUmQQXhHpqIFxBBRJQPQiS6/uxc2Hz9dygoVgKiGDeeActQkvUSFZFFJcO3uO6PJTdZ+So/+l8+hGc/zWoy3A7aGMfnOW6pCEoGY1FUlkY7sRFp9nYwmai+y2ivX4L4AXY6IdSxxVJscORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdtFLWWHtnSJIlAbQutggLSfbmKHyp+eVZ5p84RINmU=;
 b=kVVVKWrzF3KPUSANtQGybWQSbKMir+9kD1NucixIuhYN/7lllfWMSAiICMN4Nfr2n8xGy8hXfZbvhLaAWjLtpM0meZURhRDXULFJGNcrs7EFZzywvcXt0GmwzKLBJH2ChGo/XXF5LQe30VYIXjMhaKIQ3S2v16RjHj/ORE0rKCOBDLzBbLylqW0vBybc9i9DnYoxS13hRrI3WXjioyaNooUHVvbupxfwbdx8Ml/UORuBpHyEB9ZZfIiQKA5IvofkPpxpn6u1RVy5f7lDs/4XsQqsrEseiXde7c3Yf9aRnSXhslAEsauPeOOqqGcA5UzI+DbEzwu7hbYFMUT0lsplkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15)
 by PH8PR11MB6830.namprd11.prod.outlook.com (2603:10b6:510:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 22:44:29 +0000
Received: from DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543]) by DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 22:44:29 +0000
Date: Mon, 6 Jan 2025 14:44:27 -0800
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <matthew.brost@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <Z3xcy2Z3CuwkR9L1@orsosgc001>
References: <20241212173432.1244440-1-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20241212173432.1244440-1-lucas.demarchi@intel.com>
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To DS0PR11MB7408.namprd11.prod.outlook.com
 (2603:10b6:8:136::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7408:EE_|PH8PR11MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fdcd82-2083-4de0-dfca-08dd2ea3ae06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2NXN2Y4VmMxazhwZFltYnJVV0xzZnBvVzE4MFVyZWpYUTYxc2xwZjJOTU5G?=
 =?utf-8?B?ampXb0NZV1g5Ynl1WEllWjdJV21xNG1xc1poVUlaR0tBYkozM2pJRTJ4NUMr?=
 =?utf-8?B?MzEvNVlVeDU0anlqVkE4RUdWUkpXZnpmRzZhZGI5d3ZmeWZvQ1FyMG0rTHlL?=
 =?utf-8?B?WWdjMHprQ1F1RlV1ckFKenhWbE9PQTVNL29xK204VlZIQTRQNmppV2RjZWVM?=
 =?utf-8?B?VE9WM2tGcXZFWXNNYXFjbTNLRGh4dFZrdnUraEh2VWFJS1ZuTjNrSWFTMGYx?=
 =?utf-8?B?bi9rRkNhTG1USi9BWGFDU3d0VmxkSGhlaW8wWlhEOGwrc21WUWt3elJ0Q0F6?=
 =?utf-8?B?Y0NZb01GN29DOU9XeE5xRWVldHRCa2VEcGEwaTJDUnlVVUpmNHBZZnY3aUd4?=
 =?utf-8?B?ZFFidUhJbFU0dERXVVFDUi9EQW5lbDlMendjNEkvdGdhUTlpSTh3QVlPbWJJ?=
 =?utf-8?B?RUlKUjVyNTMzQWFIQUZuOTBCQ2E2cHgxM3lucGs3amxsUGlLeVJQdnNEeE45?=
 =?utf-8?B?N0JHUWo4dVprcU1MOHptMlBEc2FsSTgxZnlpcWZ5b2JqcnFkNUUrclB2a3BK?=
 =?utf-8?B?ZW92NUg3TzJjS3dOQzFraW9iT0JPR1VhcStwa3J6T3g1V2hkVUVqc1BwVE5t?=
 =?utf-8?B?eTdMSWtNWFhaL3VSeEZZTW83K054alpIUC9VU1BGKytiQmlFOTVnZG1wdExF?=
 =?utf-8?B?WnNuMjJYOW1uMDNua0dGdzR5Y0lGRnVrbHhFY3NxS2lmK29aYnN6bVBsTEFh?=
 =?utf-8?B?cVVxUXZrS0ZPQW1BS2ZOb2M0REl1U2JIek9jZUZ3STRtYzJtQ3lwRUpyVWJp?=
 =?utf-8?B?NHo2TFc3alZ1L00rNjNkSjdJZjJyZS83OGpmenRaUHAvUEhYckJ3NGF2bnpy?=
 =?utf-8?B?V3pPR2lXQWRJSUVHd29WbXdWZFVRMVU5dHBYNkpPTkRHL1VmODdRUFBseWpC?=
 =?utf-8?B?TXNkYlpMMEl6TDBPRm5KS3dKbFpUUWdhNlk4NTNXZ0p5UGlZVTFEa2FmQzM0?=
 =?utf-8?B?ejFyalo1S1pYRUMvSSs5YVNLOFE0emt4bUNzN0p2V0hHbjAyWU5qektxMm52?=
 =?utf-8?B?b0UvTFRkQWpUTnkxZXFSM3B2aS9vbGxmQmt4VmY0RVNibFl6bG14dE5SSS9q?=
 =?utf-8?B?akxjNHMrSTRsdlcyelNZeU9yQU5FZS8rS0p4cWh4U1o5cyt2SmZ3RUVibmNp?=
 =?utf-8?B?UG12a2hweXRQcEJjdGFHQUpmL3pndGFxK2JkWEdqdklrZFhqWk9LUW56anll?=
 =?utf-8?B?SFpyRTh5ZGs5S3FFSkZGSXJFY2FGYWVCVXpzT0RvaFhZa3liTG5IUllNd2t3?=
 =?utf-8?B?Wkx2SE1aMXFBZERESktkeDMyM1ZZQ2VyMXBIaHoyQ0lKQXhtOUE1UmhiNmhO?=
 =?utf-8?B?S3dUY2d3Q3VlbldyVFRaeEhPUkFDd1JZVEE1ZzVqS0JhUWhWNGlKeWJWdExN?=
 =?utf-8?B?eklQUG01emprNmZ6ZHFkZU4rekdJMmlyMFl2cDJCb2lhOGxEdjk3MnU3QXMx?=
 =?utf-8?B?VDA2WW9Xd0xJZlBNdXJ1aGhSa1I2ZmlFYU1QZmhQbkJOYmlQVEhLNmhEdDdN?=
 =?utf-8?B?RU53U3ZhWnlvdUFHSm9ZdGRtSzQyQ25IS21RMzZSU1A1V21nWXdySTBQeVNI?=
 =?utf-8?B?ZGhUYko1U2FJTGNCcFQ5TU51bHR4SXZ0dG84enhyRjRlS3ZnL3RBNCtmbE9V?=
 =?utf-8?B?VStxc3NDbkUxMzBCeUdlaXYvNGF2NEQrMjlpeDh2Q3U1YWJyVVdPc1RGQVEy?=
 =?utf-8?B?cVhxYmlKSVV4QTYyNWVkMDdZWThrTmRzSVZCa0RUeWRwYXYxWXNubFI2VTBp?=
 =?utf-8?B?U1F4c3ZPN2phVHg4QU1adz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7408.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2oyb0ZOQnBKMWczUnJpS0hsaTBLVTJ4Z3B2dEhBeUViZXZ0UzdFWlBqVnRE?=
 =?utf-8?B?aTJ1eEpqSDdqTkYwSzMzcnBqMWU4MzhwUzVpc0N2M1U3RW5tOFJhZmdWUkhh?=
 =?utf-8?B?RTBCRkFVOStDNnJub3J3UjFVQ2NNcWxYd0RGTnRyc0h4VmtwbXpBblNLTVU3?=
 =?utf-8?B?NnA3K0VIQ0VWM1ZyMWpqWkMxU3I3bGhCMVN4aWtiRzZ0UnM1MHppblQ2N3p5?=
 =?utf-8?B?eGo3dENhdHlKUlZ6MnV4K05sbjV1RFoxejJURXpNTmtTZWNJc1JJMGJVMUtC?=
 =?utf-8?B?RlYwTnBVcVkzaGM3bmFUS3Z6Y043cy9VdEdXb1FuNVo1VW4rSWxzTis0MWlw?=
 =?utf-8?B?c0s1RWlJalc5byt2MERoNmQrOURSYnRLVmFJckR6eUxhUnFnZlIxRmxPdngr?=
 =?utf-8?B?eFp2T0dIZGR5VUhTQ3BXRVVDZTJmRml2YWhNQndLMzV4dVdjVUp6QitDbnZ3?=
 =?utf-8?B?bUxBSFZNMGtTOHo3aUdud2c1N2Y2dkF5VTZiWG5ZZlhpeUczd1JtaU1sSStC?=
 =?utf-8?B?Wkc4bnEzVVNtTXlvUUgzaGRWK1kwOFljM2F1NE5ROUxNTVpkMFBBN3kxMmR2?=
 =?utf-8?B?Q3JBTktGYTlZWndxN2hmeityUnc1TzBMcENBaHdWOVJrYzBKVEJjNXUrdGFX?=
 =?utf-8?B?RHVROTFWZ2tIMWoyVUFtbElDS0hNQldGb1pTOW5HdGpMVFJ4cjZmdTNKVlE1?=
 =?utf-8?B?VlRqdXJqcUdMd2NJTUViMmtzSHl6R0kwbE15Y2dIM3BNcytkUFpDT0gvUGZ3?=
 =?utf-8?B?S2hBc1RTU0JBak1ET3NBaXcvd0lKTEV6TEpacDBjcUdEQ1NFbklTTGJRVW9O?=
 =?utf-8?B?VU40SE9VbHRVM1BiOTk3VmQ4dk16TGUwMmZWSURLeFlEanp0bTVtRkNrZDIz?=
 =?utf-8?B?cnpzdm9iQ1lSNTVteW52UmpwWkdLUmJnYXhVTzE0dTZFa2hJcU9CMU45Q0tR?=
 =?utf-8?B?c09aa1FscERjc0Z0WEdYNVowY2NDeGZocnJBYy9LQXorSXNneTV6eUFWMktG?=
 =?utf-8?B?dTFzakJCVG54cEZqMmJJQWFMWm10NGViVkNDdmhmYW9VTWlRN0cyclFIR1JZ?=
 =?utf-8?B?djBPNWxCVW1hSkRvbU1uZS9iMkVRZGU5Q1hxcitrL3l3cU5wc1JQNFpibXZn?=
 =?utf-8?B?U0pXb0cwZ3RSbWIyWDl6eVNaMmVGTDZxdXM0QXhxOUpEUC8wbllUYTNpeEtZ?=
 =?utf-8?B?aklmSmxWcHRpTkRIN3p6dkFNa0wrTVhXVzMxemNLbFBhZU94UEoxbFo3M2Ew?=
 =?utf-8?B?VmFOMEMvUGlRL2NTUGFVSEI3emtmZ0NjTTZMd2JxWnlvZmhVaHgxUFlmNTUr?=
 =?utf-8?B?ci8vK1Z2eElPRTFvQm1DMUs3dXUwZVpHekljTWJ3TkhoTDRmdjNWYjNqK0dU?=
 =?utf-8?B?cGEweXo2SXBidE1iZVhLUUR6UXBNOERZOXNpcG9yR016NHhFcHF5TTc2V2tN?=
 =?utf-8?B?VXpOYU9WU3JrREZVdlhNZDQ1Sm8veEtEVEcxMUswejdSZndmbVQwRHhGOXcx?=
 =?utf-8?B?a0MzcCt3Z25BSTFuLzZBVXdSNkszZG54blhLRWdHTmZyenVhTjVEa2l5VUxQ?=
 =?utf-8?B?dEZ0S21aMjlVeG10VGlUQ2Z2SDZCb1BWNXNBbHJzckkvdzR0YVcxcDdSS2t6?=
 =?utf-8?B?a0FWdml1OEttMGJ2NkVPbWpsZ2piSUgwVlVDMmhOa3Y1b1dOQ0MwTFlsOWx3?=
 =?utf-8?B?R000cmJTTzUwYWFGZVhQTWsxV0o3Q2JNdkxzZFNNNzdRVkN2TmlBQmQxNnI3?=
 =?utf-8?B?SGxkU0dkYTErd2ZSQnljMG11L0hRc1FEdTg5bzVzdDFlS1U5MkdCUVd0RkRB?=
 =?utf-8?B?QTZCV1lEQTVJNWtxVk9TK1d4dlEwNTRTaEF4RmRuSXdyWHpidWFobTlUb0dk?=
 =?utf-8?B?Y3BCVGgyT0xPMDJiaEZmNVoxWGRGS1FDT3E3SjR1WFIrU2pPQmlRRUwyRUJV?=
 =?utf-8?B?T0ozMGlJbVlXbGVPYjRRellnRmZzNnovR0hJa1FWYlE4T2tFV2E3VzNxTE5T?=
 =?utf-8?B?ZUM1VnNYY25zeHFWRVd1S3ZNc091MVAwbGlKcGUxcW5qbzd2VUF4Y0xBelVJ?=
 =?utf-8?B?NzVGaG10TCtRRFllMUlYSWpGczVRdTYrd2xjYU1oTUJwSXVxL0ZRQXZ0Z1Zi?=
 =?utf-8?B?WkprWEFPcW0zdTZISjlrbUJGNXNmblhXNWEwazZJRDVBUXhkL3VqSzdmZ2Q2?=
 =?utf-8?Q?YO3+Qw+vVvVESk5jNXsOaWQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fdcd82-2083-4de0-dfca-08dd2ea3ae06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7408.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 22:44:29.3143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: au3JEv7KRrDOYAR22yCG+OCJ9SrGeMCLsmK7a+oF0Te6VM+DjhIXsz1XKZOHGJLHODuJ+rL4EKMtMqlQjxB7Xolt8efWUutFm3LkUStGkQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6830
X-OriginatorOrg: intel.com

On Thu, Dec 12, 2024 at 09:34:32AM -0800, Lucas De Marchi wrote:
>This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
>queue file lock usage."). While it's desired to have the mutex to
>protect only the reference to the exec queue, getting and dropping each
>mutex and then later getting the GPU timestamp, doesn't produce a
>correct result: it introduces multiple opportunities for the task to be
>scheduled out and thus wrecking havoc the deltas reported to userspace.
>
>Also, to better correlate the timestamp from the exec queues with the
>GPU, disable preemption so they can be updated without allowing the task
>to be scheduled out. We leave interrupts enabled as that shouldn't be
>enough disturbance for the deltas to matter to userspace.

Assuming

- timestamp from exec queues = xe_exec_queue_update_run_ticks()
- GPU timestamp = xe_hw_engine_read_timestamp()

shouldn't you also move the xe_hw_engine_read_timestamp() within the 
preempt_disable/preempt_enable section?

Something like this ..

	preempt_disable();

	xa_for_each(&xef->exec_queue.xa, i, q)
		xe_exec_queue_update_run_ticks(q);

	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);

	preempt_enable();

Thanks,
Umesh

>
>Test scenario:
>
>	* IGT'S `xe_drm_fdinfo --r --r utilization-single-full-load`
>	* Platform: LNL, where CI occasionally reports failures
>	* `stress -c $(nproc)` running in parallel to disturb the
>	  system
>
>This brings a first failure from "after ~150 executions" to "never
>occurs after 1000 attempts".
>
>Cc: stable@vger.kernel.org # v6.11+
>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>---
> drivers/gpu/drm/xe/xe_drm_client.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
>index 298a587da7f17..e307b4d6bab5a 100644
>--- a/drivers/gpu/drm/xe/xe_drm_client.c
>+++ b/drivers/gpu/drm/xe/xe_drm_client.c
>@@ -338,15 +338,12 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
>
> 	/* Accumulate all the exec queues from this client */
> 	mutex_lock(&xef->exec_queue.lock);
>-	xa_for_each(&xef->exec_queue.xa, i, q) {
>-		xe_exec_queue_get(q);
>-		mutex_unlock(&xef->exec_queue.lock);
>+	preempt_disable();
>
>+	xa_for_each(&xef->exec_queue.xa, i, q)
> 		xe_exec_queue_update_run_ticks(q);
>
>-		mutex_lock(&xef->exec_queue.lock);
>-		xe_exec_queue_put(q);
>-	}
>+	preempt_enable();
> 	mutex_unlock(&xef->exec_queue.lock);
>
> 	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>-- 
>2.47.0
>

