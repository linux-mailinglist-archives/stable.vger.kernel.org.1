Return-Path: <stable+bounces-232905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPL9CwjvzWkzjQYAu9opvQ
	(envelope-from <stable+bounces-232905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:22:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 354EF383859
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 06:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 222333057AE9
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 04:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2273603C7;
	Thu,  2 Apr 2026 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwcF+EYC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4EF36074D;
	Thu,  2 Apr 2026 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103547; cv=fail; b=fFB5w8ER8YFeVTttopu/0qM5FFbkCDZ6PMCWM2yaIz2aNsod9z6vgpFKk47pbhjETdvFOF0eC36VqDgpBfGRyRxS82kPo25Kh1mFPwtAy8iEvIglcva8HmJ7xWkf9GFJxz8nm2/WvGpN77adLS1t9v2cJKseH3sqq0LOM82gKWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103547; c=relaxed/simple;
	bh=mGRDaZHW+cr3FRkmWLv+f+HL9CNPArjUymetNV+zEIY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ahc+w9lrlg1YGC6KQ6yn/W5VfM1pqDOiaxaWxJM7w9fbLkWbNupeRk7QYgOcHUiesHrsP10101Fj0Y+RElF00vl0CIR7hyPsNtxHBSNQuGj5fL3/Cv6AX6EUPpPk2jQubr3c24Avqn4axKl2n3f0APf+SHSP7VQjtCdUoDTMn5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwcF+EYC; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775103546; x=1806639546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mGRDaZHW+cr3FRkmWLv+f+HL9CNPArjUymetNV+zEIY=;
  b=lwcF+EYCDx5j84Wh7bF0OaOlikYB5f0/7PVvtw8p2GG/s1duiIcQGYnh
   yKUbSQANhQUH2RVLSTE/t5u/jJasJYl3zYDmPM5nNFAAwTj8CAFkiUlzf
   TSok1SBM/9Z+GjfPg24v3RFzP7I2vqYqNBRLyFB43DOS+hcqbpEMzwd+2
   Kn6EsgnfGtcvi1jD+02cZlrKnDGnPiq6YrRFm33vD+2x/uApMbMCxfhbq
   2Y5yh6maz3T3+CjXgwuQEhtcdg0j/YWpAnnbtUEDZqMVqyervU20oNzZF
   LCHIVRwqR1t6UAVfcp5ky63I2m4T1RUHm3kSmDFPGQO1hihl4Glg2fNOO
   Q==;
X-CSE-ConnectionGUID: f2IYBGFSQUyv0PQ+8mAIKA==
X-CSE-MsgGUID: h9RRycgvSViYUjDUS47BUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76042893"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76042893"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 21:19:05 -0700
X-CSE-ConnectionGUID: kjWeumUwRxK6QOHLP2iPgw==
X-CSE-MsgGUID: K8s8YdHRQDydT0YCOdA2Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="230935069"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 21:19:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 21:19:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 21:19:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 21:19:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTdeGFIX5wynUXkzCQ8Wc0r17rYr/91b3Zh5QuMcgH0xU5PG2yQj43FcLECbK54PJiHX9NxBer9aGy2PnGLw5aX/SUl1p6Lt6QQBqWzLuAbBg/hKLM+M372TnQrZGANDl8JsIV8DAHxgB1Iqk6DXWgHPo73l6y90T9lB0Zb7Rwamq2Y4tHWduwoWdZRQ2psEZOKgNFIYhk840zxP7FTaYSC86k5jzG1+93fZwDTp1kOwDqe2KBacySp1ukvy6f+nnk6VeKwGfRKKlulhAvW/W5PH2wkqDrGacdq6RVFSTnm7+zqJzKLZeJJA+Vy/1jN1qHaDJBqJNZ5U0yQfnCwriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRTKBmSsnwHJbaMTWJXXHzvgUX2fklzKfK9n2wTlwtg=;
 b=Gz8yMhGktAdt25yaRJMQdTMDUvs0wnEZRnUYhpQOXfveQ4VI2iSCZdYFnathusnrj7L4+niSKJf4552kF2VffVCmIIEP21GY1Dhc6ldqIEJUIQj+cMIj9yq1OnXPYlWiUDM2hy7UeTvSaPJJvJQElwZFcUG07Lk/JmEax8D9Obtu9ANWwfvhDeb3QPXAsTN1DThIP5/LU34e4kJL93BKzz9TFRzIV62ypKwW2T/kYKBIMNWZXH5JzZW2+ngMIfnkBOGHiYRwj8Odcsp8ziflg754pEL5ypA3f7kwmIasRm9vQCmLLd9HwYe9p51GpyLOEUF06G7rq3WZIJYLsfYMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 04:18:55 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 04:18:54 +0000
Date: Wed, 1 Apr 2026 21:18:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: Waiman Long <longman@redhat.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Carlos
 Santa" <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
	<stable@vger.kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Add pool_workqueue to pending_pwqs list
 when unplugging multiple inactive works
Message-ID: <ac3uK2ZVRhiPfL6v@gsse-cloud1.jf.intel.com>
References: <20260401010739.1053192-1-matthew.brost@intel.com>
 <604e3d6aea8767a245160e8c6d3b4b4c@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <604e3d6aea8767a245160e8c6d3b4b4c@kernel.org>
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA2PR11MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbc3c75-622c-4404-8e5d-08de906ef3ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: aYJztKfh9wKz0S8wuleLTi9aiioBqVjpA/vzTGaA81QxzLEfB49ZydIxVwD/6FqV6a6UVUVFgQiXDdobHRiUou05CaqAnMYOYHIz09YxUirg9JKXZuUJwJoXzw2IT2J7ghooi0qF1ZpXUF+/SETTZ30yk85td6Fe5I+1zxs6nrNU7L62bW8Hf37j1b8jVmGPu4HjF0soIKoEzSpt+/3zCbulPPyg1x4d5eqldMkji2AMre+Sk7eA+wo3zq/ozpWGvP85hrOa7H2prGIjLp4jxoDMPPWuMu21kSuxe3yfBAzgXTzz54xMSWbR+dJhMhjhn7Are9Hj7+/ngWzeevmsSCwxAG252deN490EoRmyIZ0nmHF+gBFTuoX0Z72o9lqtgE34hR50jA3xZFVevm9ufnPIPL2d7tzEyl62+t74b8ATOBNzuV+mWhPQxbhfaZGOHp9P5wPQCOJLNDUu29XSKbywI/rV+mjNAmVYuLE48KSyMxCoak+Z7Fe5aEgknG6wigTHh6o0zupHkNF4lYAY+cRxQ6kh8Mpdtyzp05oJDCKwJq1h0lMSrDFfrXphy7CP/IgM6Gc2HM7xRNcnXjEz3gXn8ajCy9MJh5Y8CFiNhcRvZH676mo4psWXBcnRDABwEJsb+2nPx0JE2ORMwIWrox/0VO8XY5a48QoDL8E8h+pGmE4pJQzOgwBIl7eNDKCl5qkPeziPFTfmVacvGmserbM61fmiur4W2tAUmi6n9hQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQZmTdJIkSYjbDgeigyWXDoQYlRj6z51Vm7hRGK7PA7FqxgRnq5kWmyTf2De?=
 =?us-ascii?Q?OS+7cgHCjOOlpnQuCElq4QeqYTTjbd3K/b+XVMN6ny9s+xvxaMR0CkP6qryj?=
 =?us-ascii?Q?CdcPzXusvMh5y+o4MRa8VSbioMQBL1XQG34L92oCMU3AxEagPTCXoaDbQqpD?=
 =?us-ascii?Q?7Td9uwk/SovHpI/xJwPAslGUUjXLk/lJgMaDiula9DIYZ1mcJDV00hSCvOW0?=
 =?us-ascii?Q?LAh46Sc6IQF8QLXQvPW+tYOgbUM8x9+FoBvZ9DAId3iaTXFYC0U9lq6VJtOq?=
 =?us-ascii?Q?QVkMq1Yu2AkcOzhTbyZ2EiYQ6iSPOtkW/a8CFkfYPd8HErHpbBGO6CpSlnyv?=
 =?us-ascii?Q?bMOBCMmApp3zEf3PRZr3l82v2pwz+6xyFd3ev0u30TKTuKi7irmfqc8Jgjk7?=
 =?us-ascii?Q?yE0HZIbbhBc0s6NireaBNj/LRULfAORU/aCgzrQg0DzuBE6cMhhQb3n1la3R?=
 =?us-ascii?Q?hJAC3pdQA5bQ4wnUuQfO5dXffV7juqgY5Xi1xQVr0fVKe/3F+Zhgi2VY07CI?=
 =?us-ascii?Q?M7Ik7oQ77lIBIO4sBoxH+v/2S5K2qNL1wHsaCX8zvxAIKP2Ft3393dYZxn+m?=
 =?us-ascii?Q?GA213nUljcq8AJT0Pkd23VJ6JcVVg+My/fUFLRon1vsId1/WMnd5GshTxHYp?=
 =?us-ascii?Q?XNvmixZwlS1hP2O2EiRplGi34z5akoj+gd+gj5zaxsIK2b3qmY1UjRaNnIze?=
 =?us-ascii?Q?Nw9TEuZL1DsmYd8nGh6izoM7ewj3YY+PFmhkVCs55VFAt5Fm8wFqN5RXK2o8?=
 =?us-ascii?Q?yKvlTD4XPmRhyjzj471rNGEnLIRhuygkRGA3W6vgfxj1n6JPbX6DKIUqqglt?=
 =?us-ascii?Q?zEHzTa6cP/ZOWf29pXkHipK4joJva73eb+q2vNMDJZBvLN61BTsYdWeGTthi?=
 =?us-ascii?Q?9ENP57bwxPSRREcoElwiNuQwSvchauUCveCIpm/sbqgCgu7S9KKvmx49At+4?=
 =?us-ascii?Q?8kDlMpewTZ/MUp/nm5d9dFAzVj/H4KeP0KGd9aBcp79hwyALCTvT+bC0Fdbe?=
 =?us-ascii?Q?SZpVuWNMEZCye9OyZ2r62/UbxbHPmfucPyUREV13oX9mIYVFSmXItedPQohP?=
 =?us-ascii?Q?wjoxFmb6haaj4RcT/s2E8MeaeuqJrNdEFc7LH9D/A1OIBPBiZ1DO9NIkEf5b?=
 =?us-ascii?Q?lgzhVVD0PG+7iRaWzasGd4WE0W6cDRR9Q7/buTqH+ScANOLGNHayLIXz2aJP?=
 =?us-ascii?Q?s63aXTL5Qj5YeDH6y0tcOtRbKxxELaa0xGyBAjJPGUzt3LbkzvKOJvBEPen/?=
 =?us-ascii?Q?hSj1DyzP6svMmRQOvOLXmBdgFbb99dPGxpyNwknGZio2XCwqdmLb9SvnB+bp?=
 =?us-ascii?Q?mpIcjTxwboODvffjhT00X2UNoi28T6dfs/xnhrQDMeVJjejg0IngXLIyJaXE?=
 =?us-ascii?Q?VNBtv470Ovn+4am5uUiwalDh7qKBPsreGB/c55LCeZuLHzn13MlNgJmG5P5Y?=
 =?us-ascii?Q?a4588OQFNJ0tN/ulN02VMD8EwC3yCbhCochFVreoCkgLhxtpiXpUubcMVfY4?=
 =?us-ascii?Q?cWMMx5KtN3glX3JEI4Q6zs8BERnGbE1bmAKkGrvY4TXqTt1xyjQWu5Rj/rfN?=
 =?us-ascii?Q?TQjYGDxywRDr12adyrwGKu/tdCn+pOhaT39kJj2eoNm+//DTuxkeRwOevC0+?=
 =?us-ascii?Q?/mctQHyIN1FrWjZm/U2wz/acXLEu6IF/5M+JkO7nHJG8mDXV2EJoLyvABl80?=
 =?us-ascii?Q?UM2S1lLsSBS41K7E0uMb6IXum5b8i566xN07QTMx9viaGlbKWOocH+eEsHLu?=
 =?us-ascii?Q?5hJghBfMFnX74wx91euGTbL6mjxHx1U=3D?=
X-Exchange-RoutingPolicyChecked: Nzwl5AFjEaSJyeYVkOLb+a02qWMXIoOYPOWkDKtv9nMRUQ+v1/PqHNpChGVDsQAhMYGzMdeVt1hk60GXjq45JGQfJZprX/H5rar5mVYcOloc3TiOG9WsKPutC+qfDnoM2sjabZrj6PKo7JxG86e58I5lOyNJCE0E0VlxdGW9Dps3CyCMd5lTkM/bhXA/lBAzpCGgcfZXN2s4l4EBaFOcZX+iaobT9xKJjDdM5ds6jjauMZLOe/bfGldraJfXBZk4OWHEZMXUiJcLwP0f5M7agrXwa30f/jj+CX6C2BjoHN+WUItwvthGY7neM2JtIOtVgpW3C35Rr7MP1JDpE/kTOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbc3c75-622c-4404-8e5d-08de906ef3ef
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 04:18:54.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri0ISt761FheH15zQejESM+4Iv8S5iFKrPF7f7FyTRde/T/gRqVDXJeg1CWAPccUFIfVMvbDFcIHeBK68Lq0ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,lists.freedesktop.org,vger.kernel.org,intel.com,google.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-232905-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 354EF383859
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:20:13AM -1000, Tejun Heo wrote:
> Hello,
> 
> Applied to wq/for-7.0-fixes with the comment updated as below.
> 

+1 on commenr adjustment. Thanks for the quick pull.

Matt

> Thanks.
> 
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1852,12 +1852,11 @@
>  		if (pwq_activate_first_inactive(pwq, true)) {
>  			/*
> -			 * pwq is unbound. Additional inactive work_items need
> -			 * to reinsert the pwq into nna->pending_pwqs, which
> -			 * was skipped while pwq->plugged was true. See
> -			 * pwq_tryinc_nr_active() for additional details.
> +			 * While plugged, queueing skips activation which
> +			 * includes bumping the nr_active count and adding the
> +			 * pwq to nna->pending_pwqs if the count can't be
> +			 * obtained. We need to restore both for the pwq being
> +			 * unplugged. The first call activates the first
> +			 * inactive work item and the second, if there are more
> +			 * inactive, puts the pwq on pending_pwqs.
>  			 */
> 
> -- 
> tejun

