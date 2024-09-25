Return-Path: <stable+bounces-77076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2445F98525C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 07:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4703A1C22F51
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 05:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C11B85D5;
	Wed, 25 Sep 2024 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJFj5CQ9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A71487C0;
	Wed, 25 Sep 2024 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727241651; cv=fail; b=e9ZDrYZU8YcTmmxZqXiXhjSCMl33CzMBuc2Qj4he5R66uNuKzDVQUmARgeYmempMCa0VoMEUFl+9jg4bynP9/CSXDwu1ZZX0z48kX/NVn97xN4QI1CLqWCW3/hOXgsrU2NujBSOfZTyoPAfey1c5qLGkcqYLRLsqGabl2BT+IM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727241651; c=relaxed/simple;
	bh=m86MoUsMdq9a5xkzXqtaOp2ohB2c1sRjIK0Z/GJ+Ars=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CP4BjeTQ4AYps+8j1b3XOCURSuMneWjYFBz9tQ1QEP1PQJjqyGmn5dSfCEFLOyPvpwOt58cBFwQsMxQmBhtCtyOdYnavMcKIfTdd89vSLYFko07LL8EiuzNzu7VFT7R6TEOpxMJqsUFXpQHXVGQMkJCaY5hsH14QVyciXD9ahKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJFj5CQ9; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727241650; x=1758777650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m86MoUsMdq9a5xkzXqtaOp2ohB2c1sRjIK0Z/GJ+Ars=;
  b=kJFj5CQ9uJkOT/p0qu8RDwwCbEM8aai56TjT8nJlamyL7RK2V8C/2y6T
   lj2F5QqCUAslAwYfHgaohYGaDqmC5eOfH20xfj/h3VPghj4NSBzEZGQmb
   DqshJROONfiieRUzOFrvnVaIw5sqntndBecIJNshNz0z9uiFzxAHsB7Cp
   zqCOAZsMpY4BUOU4BlMT5Z1PZfDE9ev2w52d43uuQw8B2PuWqaLcFKykr
   hqz2m4KdbgYXqAAJHzkRpWbaQ5zIZ4hHy7FbFMR3gT/jarSOg2aBMmvs8
   Hq6weRMuPO+2JPDtCQLICtce8YsOcnb1LSfLCK1CE4lCG1XZAzDqVgw+Q
   w==;
X-CSE-ConnectionGUID: KpGxm5K/SpmTcFeTpf2V8w==
X-CSE-MsgGUID: KV/QZ1aGRzu/ACBqmYN3vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="30060494"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="30060494"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 22:20:49 -0700
X-CSE-ConnectionGUID: 4jKFA3TdTaisoZw8sDIiOA==
X-CSE-MsgGUID: caHE5p5cSf2JxPkB6y9wwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="72478343"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 22:20:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 22:20:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 22:20:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 22:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfS0ViV9wEDmcEPI9YmMzJ/jdNHrzoZ5zMQ3gRyUXzFgnD6Ote2CSZhpAIZW5bmUOiuQBCKcevkkA1KJ9TWz5Ff80cGFe6sKgsTCRlrizIv5PAfHypkDA2didaIOovL/YUd1TmwlHf7PMzzk/nR0ca5qySHJWJOW36uAmRjszPq11l7nH88Kh79D2HVj7y056+w4mm6PwiF8BmquESn+8Fb7F/8W8pIbcjnRQhQOcKm6TUaZo+xp2Zc7pv5inCPwGzRru/KQ+Yue54wOK4D/JSuRI812HFHtkKKolDsJyu0J1j8fRJCkdpxa0c++tS5/8ziY8fk/PpvwfoUTkfV7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m86MoUsMdq9a5xkzXqtaOp2ohB2c1sRjIK0Z/GJ+Ars=;
 b=yfNyDBfzc6ChgXQd3rn4vyP4lZyNQjBW5GJACZblPZcsZk9PjOfceYQfWcg5JrlMr6oWWwqw9BhGadfuSYqi1fcoWf29+oBfMpgBG4JffaxY71TLunu5NIQHoWrXJQpC9cbX9ljCEIjlyMiuio2oEfvlzYvf2Vr02aQM7OQIBOdniUv93q89k0JOOQdoPlcEeX6ggvy2sZk5frKMzQMk/8kViUrs63IJs8IvPJVcVuTf4E1ctUW74VATEP6GAASk7Fvd/4kBN3DcXE67p+YjEE3Y88GgvE8HkqtuZTnvifwHAG9vWC6qbA0TjRIB0DCKqm9wDrGNGllw6Y/TmGh5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 05:20:41 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 05:20:41 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "regressions@leemhuis.info" <regressions@leemhuis.info>, "Neri, Ricardo"
	<ricardo.neri@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "Gupta, Pawan
 Kumar" <pawan.kumar.gupta@intel.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"thomas.lindroth@gmail.com" <thomas.lindroth@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
Thread-Topic: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
Thread-Index: AQHbCZedKtdANIzIo0qy/xfgvzT5FLJe+GSAgAdMKICAAb2XAA==
Date: Wed, 25 Sep 2024 05:20:41 +0000
Message-ID: <c20149f35be104c0aa8e995b0f3c7727e095323a.camel@intel.com>
References: <eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com>
	 <a79fa3cc-73ef-4546-b110-1f448480e3e6@leemhuis.info>
	 <2024081217-putt-conform-4b53@gregkh>
	 <05ced22b5b68e338795c8937abb8141d9fa188e6.camel@intel.com>
	 <2024091900-unimpeded-catalyst-b09f@gregkh>
	 <20240924024551.GA13538@ranerica-svr.sc.intel.com>
In-Reply-To: <20240924024551.GA13538@ranerica-svr.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM6PR11MB4627:EE_
x-ms-office365-filtering-correlation-id: 4527a01e-adac-427f-469e-08dcdd21cc85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RnNCQWJNOTFrZ3lnWXdJdU5rRG5SMHNJZWN2bnhwTkYvQVNLVCtoZEFwWUhM?=
 =?utf-8?B?MHJ4NzhmTlpQZFRUdHNMTUxBclN5VFhjYUlhQWZteTdOVWZNT1N1Z1lOMVJ6?=
 =?utf-8?B?L08zQlJXcXFhOVoyMklBNktrMHI0cmhtalNCTG1SQjIxYWdkUnhzK29RMEIw?=
 =?utf-8?B?ZDFlYXlsMHp4MzE3VkJLb3BWNFZvMlp4bG1IcjFiSVN2Smc2RXRydTVFZkY4?=
 =?utf-8?B?R1RoQWFSQ2loMFJtekgxRkc2QkFrd2V5WVJYd1BDSFpKbkx3TThnSW5sd1Zk?=
 =?utf-8?B?T1k4YVFiRkVUUjEzWVNjYVJzOEhXQUNaOFNKWE45K0hJdzh3WU51RTdCbGxL?=
 =?utf-8?B?ZXozdU9tKy9vbHUyWk56MXJGeWJCZjR4QzRCa3FsbXRQcEpURDR4RE9LUjdH?=
 =?utf-8?B?eVVHZjdFWnluWm9nRWQ1RkhFbnZjYldiS21DM0pzZFlHV2dPbEFuaVdiWE5C?=
 =?utf-8?B?TE83SHJWeWIvdC9udmgxc0JRaWdDWE5DaFNwNFo4VGh3MkNYRm9oaTkzdDBI?=
 =?utf-8?B?dWNieXc3VG9yWmdEWkpXZ3BnaFUyQytRQitRaVgwcklHNTJrUjJVSDRWNWdy?=
 =?utf-8?B?YjBQQWlhRDhybHk1RUJydGdOLzNCVFkyZ2doYkxBMVJ0NlM3M3lFR0h6YUc4?=
 =?utf-8?B?K0FnN3NTVEZZL3UyZUk5bmgvNWFlWVpuMWZ5Vy9jMzNOc1JBU3dvMEdaWjlr?=
 =?utf-8?B?WlF3YTVFTTYzdmZ1VWt5SlVJTCs3dG5NRWc5aXFJNGdoc2VidnYzWHM4R0RR?=
 =?utf-8?B?L2lPckhUZkhrUFpjWHFtVXJpRlQwamcyQnllbVBTNFF5aUpNbTV3d2d2bCtz?=
 =?utf-8?B?WVRnVHRlaGE0QVNkczZlaG9aVnVsSm9SU08wVy9lRGNFTUhLc2VoWHNrQ253?=
 =?utf-8?B?Q3V3WGp1R1lyRVlHamsyRXNFRHBzKzhib0tSeXdFcFF4R0FDV1FqdVVjZW1w?=
 =?utf-8?B?VHpmS0paTEhLdHRyWXozeHcyWGl1QW5ocjV3aExjQzVmRFhENkZSblhTUWEr?=
 =?utf-8?B?NDBYMUdMdDB1OW5iQlErM2ZML3I2cVo5eXhhL3BFUG9jNlVUNTVKb2l2eXNx?=
 =?utf-8?B?dWZPUENGRWhVejE3THJrdDJCa25ZVjNOR0tLZnEzeU9uc3R1L2p5eFJKRDIy?=
 =?utf-8?B?NXNCVHNiSFNoeml4Sy8rRkROQzN4aTVrdXZUTWJrdkVwZWlWSVZxQzN3ZTB0?=
 =?utf-8?B?b0xMMUUrVFk3QmxnbTVMcGpsT1NqMEljcGgzZkFmUDNoU2VFS3Zlc1diaWRB?=
 =?utf-8?B?a2drcXN4Mk9HUTZvZGJSdWgvV3RWQ1hVSUtMVEtnb2xNTml2WVMvUkY2MTcv?=
 =?utf-8?B?U2Y0ck1tRFhPbE1VblVpcHU5TEdkS2RQRDZjVzl5ODhTZkY3UkZJbXZNanQy?=
 =?utf-8?B?TTkxRUdoRllYYWh2VkVBdzZ6YWREMVQwVDMvcmZMZXF4OEZWTzVlN3BZM0RB?=
 =?utf-8?B?SVhWNzRNQmFNZmc0QytpUVhWOSs3bGlqQm5VdlJZemU1VUJxZUdPZEQ4b1p3?=
 =?utf-8?B?YWlZamMrSmhwNU1sTzdTa1FhalQ5SjN2L24yMjhVWThudHZFek5vT0JBaUZO?=
 =?utf-8?B?Vk9MOXp6SU13QkdHMkkrL2E4Mk82OEtvb0VpcGpTeDNuYzVCdFF5Ukg4bVpv?=
 =?utf-8?B?ekxxUk84OUtDRTRkUmRJdjhLd0tuSjBiNG9BY0JnU2JnZlk1bEZrbWpqWWdF?=
 =?utf-8?B?RXJZN250eVhIUWZCTHEyeTVTK0VkWHNJYnAxNEE2cVFGeGhNeDUrSDNOK2gr?=
 =?utf-8?B?QzY5YWMzMVlrejRBd3E4YnQ2Y2JlUUVpUGhLSXp0THRZQ1paT0lHaHBFVEND?=
 =?utf-8?B?aG9sSG1za3RBU0ZLWWM1TDlCSkI1MXE4WjR3ZC80TzQyN1NOeTVLeHRPSHkw?=
 =?utf-8?B?R1VNYURjZldUTlcyeUl0VVl6eDRXN2pGOE8wR0YxeS9XOXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEJGMGM5QmI2ZFN6N2xIZFdML0t0dnJFT0RhNksrMEhmQmJPYW1WdE85bEpZ?=
 =?utf-8?B?VjRDb0Zka0FSMHZBa1h6UVdEQUhERlRGYlRQM1prWnA5TDJFY1ZiL29XWEdC?=
 =?utf-8?B?enNkYkluc3c4ZjU2VmRCUURjL0lSVHNpTW9kdDdKKzk2Q2xvMHdJRkphN09s?=
 =?utf-8?B?NTl2cGFhbndvWGN5SlZhMUxTeHBWV1FQNlZqUDlwcHBxNkRLeDBMblFJM21w?=
 =?utf-8?B?eTYwaDY4T3dQdS84Z0UzbUJwZWtkVXBZNjRTRU5IVHlTeUI4NTVUemovUTFN?=
 =?utf-8?B?N3FFRnJtR0JBTFkxWGdJeHNQUFR4R0ZVcWdYWmJNK01CUHJmQWR3Z1FyUDdx?=
 =?utf-8?B?Y21HakdUbUZJRkYrSFdadHFhaU1JdjBvVG5lWVl6cW01ZW1uYnduVUNzeWc5?=
 =?utf-8?B?ZDNjT2NjbktJVE45NThsdE5NSXZ0ekdvT0FKQ0c0eDFqQVR5QkdRcUhxS0sz?=
 =?utf-8?B?ai9TN2xyaUtnSlUwc0o3TkVWVGZiY3B3Z1RTZGxvWFptanRwL0I5RGR6Smoy?=
 =?utf-8?B?YVU0bUZWcWlWODFJQUpqOWlLR2JxdlVHTkNWUDM4Vkx6UE1GRmtCK3NVNUQ4?=
 =?utf-8?B?QVlIMkE5UGQvbHhUekVBd1JhdlREOEZLcmxOaW9JRWNMeTIxQ25wQTVYK1Fo?=
 =?utf-8?B?bC8vU3BhU0JEM3U1YmJselpDVDFXWWxVbGIvZVhOd0ZVR2NDRGs4Z1dxaU03?=
 =?utf-8?B?cHZkMWVvRlVpL3JqSmcvTmdMWTVGRllkcVV6V2Q0N0JFQVBYaWM3b3VEWGNp?=
 =?utf-8?B?RTQ0VHhsNXlURzJpSFJxWHZyRlpIOWdvWjdnaVhVQVFXNmF0UTJUOVNQWVVa?=
 =?utf-8?B?aXJIVDhlbTBSaVBHYkNsZWZkLzFlUndzckptdGNMOENLZmpkZEFqRjc1b2Zx?=
 =?utf-8?B?bFlZYk1Fc3BObDRsTDk0T3YyNGNmSUpnUTJxZFowVWF2cVlGUUlCejQ2aU1x?=
 =?utf-8?B?aGU2bUNTLy9MWURIOUwycTBtZ09FdGUxMWFXZ2Fvd1NHNHVPR1lBYnh0ZkVP?=
 =?utf-8?B?WWsxQ3FCNVV1djVtMzRhbnpybXN1K3VGU1QweTNKOE9hQXlwalplUFdiWTE0?=
 =?utf-8?B?Y0lKb1FkWXl0OGxlRXg5UlhtVHFwNXdTWG1INFRvZzlQdm4zQWEybFJtS1ln?=
 =?utf-8?B?TkxmUnB4aWJLa2daQ0MwSmkrRGRUYWR4ajhHb0MrMnc3NDNYUDNtZi9jWExN?=
 =?utf-8?B?M3ZIaGIrU3JNNEtGZlNQZTNaWEdtdjg0N1c1Y0RjUEZPYUhUVU10ZkFUem5B?=
 =?utf-8?B?N0VDMEJRblYvTVpydWxhc3FibWpaanpRQjFmWGFIM0ErYnhrZllBWTFodXJw?=
 =?utf-8?B?UTQyMnZrbkl1SVBTN0FKaGdhR3M3R2J3WE14SjZTb3pxV2k0WWZIaTBtZG5M?=
 =?utf-8?B?NEtOTXUzcUxZeE9PNXlZNUYwMnZpdlRtVFY4Y0FXb1hUd1JRNXZoZXZMaUFL?=
 =?utf-8?B?ZnZFSFRRM0VtcDJxMHIrS1VXeWtsd1lZdzBoQUdiV2VDREszR0xLcWRRdkhn?=
 =?utf-8?B?MkJDOU1vN3BCMWhQdStGaHFIUWc3OVZPK0NUMStxa0Y1VVppVlBpNGEwRGZX?=
 =?utf-8?B?U1hLSHJJZHNubDd3dnc3ZGpaZ1pFcmt1bWorT0tHVGJaSWRrNVVkLzM0SFVP?=
 =?utf-8?B?TUVRcHZqeU8wcjY3dUNUUDlja09jVFhyeVg2MS8wdU9tdENiTjNjbGdVMk53?=
 =?utf-8?B?RmVqVTBVdW5sZktrR0wyd3lYV25oTm5td2VadCtsODE3UENvRUY2cS9naUZB?=
 =?utf-8?B?VnR6VUNkTVVOdzhyZXlzMlZkUHdKc3JiSDhpU21TbVliK0FuZlZzVUFIcG5v?=
 =?utf-8?B?Q1NRMVROUXlZVy8rRlhiNU5NdVVRRldLeU0wLy9aY2swR2c0YjFVczByY00v?=
 =?utf-8?B?SVIrRDdyZnY2cDV6ZTk3bVZZeHZuYzNwbTQvNVdpdDVyUGl0K0xLRDVyTG5C?=
 =?utf-8?B?Mkt0djd5WVlnRG0wR3duQ0QrRVk0QUQvR0NUNStZZ2d3NU0yQzk0MTNVbmJr?=
 =?utf-8?B?bmZDaCtKZXdtWCsrQ0pyTTZ0ak9CallLelFFeDQ1NDcyZG95YXZ0NGxNSlZC?=
 =?utf-8?B?UE5XUWFIQjM2SVZ2YmlSSzB1ei9QTTA3bDJkVWxOcTkvbURXam9CZ3VTdkpu?=
 =?utf-8?Q?FyEfLNVJIiOIrF/GDBgiW1s8s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FB3860C75824A48B777D56B9CBA65EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4527a01e-adac-427f-469e-08dcdd21cc85
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 05:20:41.4171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdSu90iZaA2vTBhXGXHAxWJbJxpuZENdLMAf1FSpiRgEoqEndhacPoQS3k9XuvQ/s6oSMg6FBc2zFp88XZf8Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA5LTIzIGF0IDE5OjQ1IC0wNzAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6DQo+
IE9uIFRodSwgU2VwIDE5LCAyMDI0IGF0IDAxOjE5OjI3UE0gKzAyMDAsDQo+IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnwqB3cm90ZToNCj4gPiBPbiBXZWQsIFNlcCAxOCwgMjAyNCBhdCAwNjo1
NDozM0FNICswMDAwLCBaaGFuZywgUnVpIHdyb3RlOg0KPiA+ID4gT24gTW9uLCAyMDI0LTA4LTEy
IGF0IDE0OjExICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIEF1ZyAwNywg
MjAyNCBhdCAxMDoxNToyM0FNICswMjAwLCBUaG9yc3RlbiBMZWVtaHVpcw0KPiA+ID4gPiB3cm90
ZToNCj4gPiA+ID4gPiBbQ0NpbmcgdGhlIHg4NiBmb2xrcywgR3JlZywgYW5kIHRoZSByZWdyZXNz
aW9ucyBsaXN0XQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEhpLCBUaG9yc3RlbiBoZXJlLCB0aGUg
TGludXgga2VybmVsJ3MgcmVncmVzc2lvbiB0cmFja2VyLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IE9uIDMwLjA3LjI0IDE4OjQxLCBUaG9tYXMgTGluZHJvdGggd3JvdGU6DQo+ID4gPiA+ID4gPiBJ
IHVwZ3JhZGVkIGZyb20ga2VybmVsIDYuMS45NCB0byA2LjEuOTkgb24gb25lIG9mIG15DQo+ID4g
PiA+ID4gPiBtYWNoaW5lcyBhbmQNCj4gPiA+ID4gPiA+IG5vdGljZWQgdGhhdA0KPiA+ID4gPiA+
ID4gdGhlIGRtZXNnIGxpbmUgIkluY29tcGxldGUgZ2xvYmFsIGZsdXNoZXMsIGRpc2FibGluZyBQ
Q0lEIg0KPiA+ID4gPiA+ID4gaGFkDQo+ID4gPiA+ID4gPiBkaXNhcHBlYXJlZCBmcm9tDQo+ID4g
PiA+ID4gPiB0aGUgbG9nLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRob21hcywgdGh4IGZvciB0
aGUgcmVwb3J0LiBGV0lXLCBtYWlubGluZSBkZXZlbG9wZXJzIGxpa2UNCj4gPiA+ID4gPiB0aGUg
eDg2DQo+ID4gPiA+ID4gZm9sa3MNCj4gPiA+ID4gPiBvciBUb255IGFyZSBmcmVlIHRvIGZvY3Vz
IG9uIG1haW5saW5lIGFuZCBsZWF2ZQ0KPiA+ID4gPiA+IHN0YWJsZS9sb25ndGVybQ0KPiA+ID4g
PiA+IHNlcmllcw0KPiA+ID4gPiA+IHRvIG90aGVyIHBlb3BsZSAtLSBzb21lIG5ldmVydGhlbGVz
cyBoZWxwIG91dCByZWd1bGFybHkgb3INCj4gPiA+ID4gPiBvY2Nhc2lvbmFsbHkuDQo+ID4gPiA+
ID4gU28gd2l0aCBhIGJpdCBvZiBsdWNrIHRoaXMgbWFpbCB3aWxsIG1ha2Ugb25lIG9mIHRoZW0g
Y2FyZQ0KPiA+ID4gPiA+IGVub3VnaA0KPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gcHJvdmlkZSBh
IDYuMSB2ZXJzaW9uIG9mIHdoYXQgeW91IGFmYWljcyBjYWxsZWQgdGhlICJleGlzdGluZw0KPiA+
ID4gPiA+IGZpeCINCj4gPiA+ID4gPiBpbg0KPiA+ID4gPiA+IG1haW5saW5lICgyZWRhMzc0ZTg4
M2FkMiAoIng4Ni9tbTogU3dpdGNoIHRvIG5ldyBJbnRlbCBDUFUNCj4gPiA+ID4gPiBtb2RlbA0K
PiA+ID4gPiA+IGRlZmluZXMiKSBbdjYuMTAtcmMxXSkgdGhhdCBzZWVtcyB0byBiZSBtaXNzaW5n
IGluIDYuMS55LiBCdXQNCj4gPiA+ID4gPiBpZg0KPiA+ID4gPiA+IG5vdCBJDQo+ID4gPiA+ID4g
c3VzcGVjdCBpdCBtaWdodCBiZSB1cCB0byB5b3UgdG8gcHJlcGFyZSBhbmQgc3VibWl0IGEgNi4x
LnkNCj4gPiA+ID4gPiB2YXJpYW50DQo+ID4gPiA+ID4gb2YNCj4gPiA+ID4gPiB0aGF0IGZpeCwg
YXMgeW91IHNlZW0gdG8gY2FyZSBhbmQgYXJlIGFibGUgdG8gdGVzdCB0aGUgcGF0Y2guDQo+ID4g
PiA+IA0KPiA+ID4gPiBOZWVkcyB0byBnbyB0byA2LjYueSBmaXJzdCwgcmlnaHQ/wqAgQnV0IGV2
ZW4gdGhlbiwgaXQgZG9lcyBub3QNCj4gPiA+ID4gYXBwbHkNCj4gPiA+ID4gdG8NCj4gPiA+ID4g
Ni4xLnkgY2xlYW5seSwgc28gc29tZW9uZSBuZWVkcyB0byBzZW5kIGEgYmFja3BvcnRlZCAoYW5k
DQo+ID4gPiA+IHRlc3RlZCkNCj4gPiA+ID4gc2VyaWVzDQo+ID4gPiA+IHRvIHVzIGF0IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmfCoGFuZCB3ZSB3aWxsIGJlIGdsYWQgdG8gcXVldWUNCj4gPiA+ID4g
dGhlbSB1cA0KPiA+ID4gPiB0aGVuLg0KPiA+ID4gPiANCj4gPiA+ID4gdGhhbmtzLA0KPiA+ID4g
PiANCj4gPiA+ID4gZ3JlZyBrLWgNCj4gPiA+IA0KPiA+ID4gVGhlcmUgYXJlIHRocmVlIGNvbW1p
dHMgaW52b2x2ZWQuDQo+ID4gPiANCj4gPiA+IGNvbW1pdCBBOg0KPiA+ID4gwqDCoCA0ZGI2NDI3
OWJjMmIgKCIieDg2L2NwdTogU3dpdGNoIHRvIG5ldyBJbnRlbCBDUFUgbW9kZWwNCj4gPiA+IGRl
ZmluZXMiIikgDQo+ID4gPiDCoMKgIFRoaXMgY29tbWl0IHJlcGxhY2VzDQo+ID4gPiDCoMKgwqDC
oMKgIFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFOWSwgMSkswqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC8qIFNOQyAqLw0KPiA+ID4gwqDCoCB3aXRoDQo+ID4gPiDCoMKgwqDCoMKgIFg4Nl9N
QVRDSF9WRk0oSU5URUxfQU5ZLMKgwqDCoMKgwqDCoMKgwqAgMSkswqDCoMKgIC8qIFNOQyAqLw0K
PiA+ID4gwqDCoCBUaGlzIGlzIGEgZnVuY3Rpb25hbCBjaGFuZ2UgYmVjYXVzZSB0aGUgZmFtaWx5
IGluZm8gaXMNCj4gPiA+IHJlcGxhY2VkIHdpdGgNCj4gPiA+IDAuIEFuZCB0aGlzIGV4cG9zZXMg
YSB4ODZfbWF0Y2hfY3B1KCkgcHJvYmxlbSB0aGF0IGl0IGJyZWFrcyB3aGVuDQo+ID4gPiB0aGUN
Cj4gPiA+IHZlbmRvci9mYW1pbHkvbW9kZWwvc3RlcHBpbmcvZmVhdHVyZSBmaWVsZHMgYXJlIGFs
bCB6ZXJvcy4NCj4gPiA+IA0KPiA+ID4gY29tbWl0IEI6DQo+ID4gPiDCoMKgIDkzMDIyNDgyYjI5
NCAoIng4Ni9jcHU6IEZpeCB4ODZfbWF0Y2hfY3B1KCkgdG8gbWF0Y2gganVzdA0KPiA+ID4gWDg2
X1ZFTkRPUl9JTlRFTCIpDQo+ID4gPiDCoMKgIEl0IGFkZHJlc3NlcyB0aGUgeDg2X21hdGNoX2Nw
dSgpIHByb2JsZW0gYnkgaW50cm9kdWNpbmcgYQ0KPiA+ID4gdmFsaWQgZmxhZw0KPiA+ID4gYW5k
IHNldCB0aGUgZmxhZyBpbiB0aGUgSW50ZWwgQ1BVIG1vZGVsIGRlZmluZXMuDQo+ID4gPiDCoMKg
IFRoaXMgZml4ZXMgY29tbWl0IEEsIGJ1dCBpdCBhY3R1YWxseSBicmVha3MgdGhlIHg4Nl9jcHVf
aWQNCj4gPiA+IHN0cnVjdHVyZXMgdGhhdCBhcmUgY29uc3RydWN0ZWQgd2l0aG91dCB1c2luZyB0
aGUgSW50ZWwgQ1BVIG1vZGVsDQo+ID4gPiBkZWZpbmVzLCBsaWtlIGFyY2gveDg2L21tL2luaXQu
Yy4NCj4gPiA+IA0KPiA+ID4gY29tbWl0IEM6DQo+ID4gPiDCoMKgIDJlZGEzNzRlODgzYSAoIng4
Ni9tbTogU3dpdGNoIHRvIG5ldyBJbnRlbCBDUFUgbW9kZWwgZGVmaW5lcyIpDQo+ID4gPiDCoMKg
IGFyY2gveDg2L21tL2luaXQuYzogYnJva2UgYnkgY29tbWl0IEIgYnV0IGZpeGVkIGJ5IHVzaW5n
IHRoZQ0KPiA+ID4gbmV3DQo+ID4gPiBJbnRlbCBDUFUgbW9kZWwgZGVmaW5lcw0KPiA+ID4gDQo+
ID4gPiBJbiA2LjEuOTksDQo+ID4gPiBjb21taXQgQSBpcyBtaXNzaW5nDQo+ID4gPiBjb21taXQg
QiBpcyB0aGVyZQ0KPiA+ID4gY29tbWl0IEMgaXMgbWlzc2luZw0KPiA+ID4gDQo+ID4gPiBJbiA2
LjYuNTAsDQo+ID4gPiBjb21taXQgQSBpcyBtaXNzaW5nDQo+ID4gPiBjb21taXQgQiBpcyB0aGVy
ZQ0KPiA+ID4gY29tbWl0IEMgaXMgbWlzc2luZw0KPiA+ID4gDQo+ID4gPiBOb3cgd2UgY2FuIGZp
eCB0aGUgcHJvYmxlbSBpbiBzdGFibGUga2VybmVsLCBieSBjb252ZXJ0aW5nDQo+ID4gPiBhcmNo
L3g4Ni9tbS9pbml0LmMgdG8gdXNlIHRoZSBDUFUgbW9kZWwgZGVmaW5lcyAoZXZlbiB0aGUgb2xk
DQo+ID4gPiBzdHlsZQ0KPiA+ID4gb25lcykuIEJ1dCBiZWZvcmUgdGhhdCwgSSdtIHdvbmRlcmlu
ZyBpZiB3ZSBuZWVkIHRvIGJhY2twb3J0DQo+ID4gPiBjb21taXQgQg0KPiA+ID4gaW4gNi4xIGFu
ZCA2LjYgc3RhYmxlIGtlcm5lbCBiZWNhdXNlIG9ubHkgY29tbWl0IEEgY2FuIGV4cG9zZQ0KPiA+
ID4gdGhpcw0KPiA+ID4gcHJvYmxlbS4NCj4gPiANCj4gPiBJZiBzbywgY2FuIHlvdSBzdWJtaXQg
dGhlIG5lZWRlZCBiYWNrcG9ydHMgZm9yIHVzIHRvIGFwcGx5P8KgIFRoYXQncw0KPiA+IHRoZQ0K
PiA+IGVhc2llc3Qgd2F5IGZvciB1cyB0byB0YWtlIHRoZW0sIHRoYW5rcy4NCj4gDQo+IEkgYXVk
aXRlZCBhbGwgdGhlIHVzZXMgb2YgeDg2X21hdGNoX2NwdShtYXRjaCkuIEFsbCBjYWxsZXJzIHRo
YXQNCj4gY29uc3RydWN0DQo+IHRoZSBgbWF0Y2hgIGFyZ3VtZW50IHVzaW5nIHRoZSBmYW1pbHkg
b2YgWDg2X01BVENIXyogbWFjcm9zIGZyb20NCj4gYXJjaC94ODYvDQo+IGluY2x1ZGUvYXNtL2Nw
dV9kZXZpY2VfaWQuaCBmdW5jdGlvbiBjb3JyZWN0bHkgYmVjYXVzZSB0aGUgY29tbWl0IEINCj4g
aGFzDQo+IGJlZW4gYmFja3BvcnRlZCB0byB2Ni4xLjk5IGFuZCB0byB2Ni42LjUwIC0tIDkzMDIy
NDgyYjI5NCAoIng4Ni9jcHU6DQo+IEZpeA0KPiB4ODZfbWF0Y2hfY3B1KCkgdG8gbWF0Y2gganVz
dCBYODZfVkVORE9SX0lOVEVMIikuDQo+IA0KPiBPbmx5IHRob3NlIGNhbGxlcnMgdGhhdCB1c2Ug
dGhlaXIgb3duIHRoaW5nIHRvIGNvbXBvc2UgdGhlIGBtYXRjaGANCj4gYXJndW1lbnQNCj4gYXJl
IGJ1Z2d5Og0KPiDCoMKgwqAgKiBhcmNoL3g4Ni9tbS9pbml0LmMNCj4gwqDCoMKgICogZHJpdmVy
cy9wb3dlcmNhcC9pbnRlbF9yYXBsX21zci5jIChvbmx5IGluIDYuMS45OSkNCg0KVGhhbmtzIGZv
ciBhdWRpdGluZyB0aGlzLiBJIG92ZXJsb29rZWQgdGhlIGludGVsX3JhcGwgZHJpdmVyIGNhc2Uu
DQo+IA0KPiBTdW1tYXJpemluZywgdjYuMS45OSBuZWVkcyB0aGVzZSB0d28gY29tbWl0cyBmcm9t
IG1haW5saW5lDQo+IMKgwqDCoCAqIGQwNWI1ZTBiYWY0MiAoInBvd2VyY2FwOiBSQVBMOiBmaXgg
aW52YWxpZCBpbml0aWFsaXphdGlvbiBmb3INCj4gwqDCoMKgwqDCoCBwbDRfc3VwcG9ydGVkIGZp
ZWxkIikNCj4gwqDCoMKgICogMmVkYTM3NGU4ODNhICgieDg2L21tOiBTd2l0Y2ggdG8gbmV3IElu
dGVsIENQVSBtb2RlbCBkZWZpbmVzIikNCj4gDQo+IHY2LjYuNTAgb25seSBuZWVkcyB0aGUgc2Vj
b25kIGNvbW1pdC4NCg0KV2VsbCwgY29tbWl0IEIgOTMwMjI0ODJiMjk0ICgieDg2L2NwdTogRml4
IHg4Nl9tYXRjaF9jcHUoKSB0byBtYXRjaA0KanVzdCBYODZfVkVORE9SX0lOVEVMIikgaXMgYmFj
a3BvcnRlZCB0byBhbGwgc3RhYmxlIGtlcm5lbHMuIEFuZCB0aGUNCmFib3ZlIHR3byBicm9rZW4g
Y2FzZXMgYXJlIGFsc28gdGhlcmUuDQoNClNvIEkgc3VwcG9zZSB3ZSBuZWVkIHRvIGJhY2twb3J0
IGFsbCBvZiB0aGVtIHRvIDUueCBzdGFibGUga2VybmVsIGFzDQp3ZWxsLg0KDQp0aGFua3MsDQpy
dWkNCj4gDQo+IEkgd2lsbCBzdWJtaXQgdGhlc2UgYmFja3BvcnRzLg0KPiANCj4gVGhhbmtzIGFu
ZCBCUiwNCj4gUmljYXJkbw0KDQo=

