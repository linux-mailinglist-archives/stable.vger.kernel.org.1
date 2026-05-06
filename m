Return-Path: <stable+bounces-244312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIzfFb+8+mknSQMAu9opvQ
	(envelope-from <stable+bounces-244312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 05:59:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C314D609C
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 05:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BBC3303B7C5
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 03:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0F52E8897;
	Wed,  6 May 2026 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ba/uDHsY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2969463
	for <stable@vger.kernel.org>; Wed,  6 May 2026 03:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039955; cv=fail; b=BeWTH8z7k5CCrTzE4rHLSbKarNuskaIXb/jgJSD6DhgEjBW06Ipqqdhe0yNghPPEuBcJP5ypv+RsgF9mqgmBnJVqSyJ6hkp8mk6Vf/wjQ5RoiMTCKmpY7ObB4vHn/dwB9/flbdUuWbHJevf2lyzn9KtsmUNQOnOg6uxf/P6Hfww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039955; c=relaxed/simple;
	bh=AIfa+u7K0xFxZnfueULv2wqk8ybPUpEJd9+qn3p0+bs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SiFmzTHN1IX3/dTj/R2Y3Y3f1RLthX6bse0j2Goexkk+wnebB39E0UUqATwRBTEOBJfBRbqzMD9k6P8JHN24oWwb5xrZ0MlXXINM2Um4d37v8Vm6JgH9YcHIOdxrnVOiB+OWKG6innV7L0ADk5gvpzQYFGxDAOYvtjpRIqDlYBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ba/uDHsY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039954; x=1809575954;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AIfa+u7K0xFxZnfueULv2wqk8ybPUpEJd9+qn3p0+bs=;
  b=Ba/uDHsYoVR2F7duHPrY0j+ZxWJxVER9aksCjdP8G/OkRiGzAf5YjmLr
   +5KByeK0mNfxUHWYpd+nfknomzImvp0ESFI5sOQv2ShxsAbEIrAdbaDSr
   tm53UsMc+pH7DOS9a3bthFWcYOUIjvCO8eS/HiaOGwzeK+sUXlq10j0YJ
   r0NgH+2ioKxcbF4LamtlpKn/kOMIgkx26eLNRRXOIZS4t052mQeIQQFs1
   9wxwSX5U/zWbfqbpl4MOhQCGOGe4/MqTFJxhtilIB5Y9Tx9iryMoupj3g
   Bwlmx2Dt5D5rHGIeatt8sKMUfF7zu5hQ9yqi7yATzadOoRcypVBMYFrzf
   Q==;
X-CSE-ConnectionGUID: z4MDdHWOR5SJnHgeOxuNOQ==
X-CSE-MsgGUID: zkhZ6JzKSM+CahpMdi/tkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="66450838"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="66450838"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:59:13 -0700
X-CSE-ConnectionGUID: iH+Dy3sPT0KK6/7oiO03ZQ==
X-CSE-MsgGUID: nNXFEaDhSA+v8zbwIWG7jw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:59:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 20:59:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 20:59:12 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 20:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8rroFjSsCekKAdtGud67IOy3fbGve7u4ZWYaqY+CuWTSv1m0M1Qz4t7tsbVduZAoMzhc0eSmc3Vogt7XmLCqKUNMETHTr3ciLljeaKpkaSaWHdKb7vima/l5u7h6GNsrX7iYgLdVtMRR631GmOXg262AUDoUD5zocTMMinXYE80k0GxwBXBslpnJbZR9k6UZpcPCi3tNng1KxqNxbDD+cDARnlJgFNovT9i8lTJCLsmDeJoufV14qkY/oTGZPJrrqqgsbNXeAD13nVA7XHo8qsbXUj5Bk3RBIA8YJxGkgw599Cyb19dfe80RTF++zxNDUZztigHJcBnxc6MuzOJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NvdSDT3kL+hWrLer478tRMSiukVmIUNDPUFs+8MynU=;
 b=DHfNXuHmilE0wDTpiu5rxrrLt2alP/ng55cywXKW+7xtSsVMLWRyjL8BUjudkFMV3pxHTEzIqZxgaW2siWdFiF5M3R4pKmye0PSgK7HkcFsL5l0a4BOqk24sPhGc3h4xEcUwTtZqgX3Lh9v6wqFIs0SmculqYljfJGmbWq155bmA/SL8Po871P9JCxZ1rut5qYYPG0x2YnEGU21NvTeC3DtwqiTWRnL90Z7CCWT7+yDkSPp8tvKSloM1yNuanoET9ySg+OSKSDAD8qN6cbZllyM9t7bQHkd/PE55Rn3X0FomB9UpiNXf8pZG7ZJJ/jfub0D2MhdWIGhDFRf+RJOayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 03:59:06 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 03:59:04 +0000
Date: Tue, 5 May 2026 20:59:01 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Zack Rusin <zack.rusin@broadcom.com>
CC: <dri-devel@lists.freedesktop.org>, <ian.forbes@broadcom.com>,
	<maaz.mombasawala@broadcom.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 04/12] drm/vmwgfx: take fman->lock around fence list
 mutation in fifo_down
Message-ID: <afq8hfDELz9DfDyK@gsse-cloud1.jf.intel.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
 <20260505222728.519626-5-zack.rusin@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260505222728.519626-5-zack.rusin@broadcom.com>
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|LV2PR11MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b45055-88fe-4f73-01c1-08deab23d052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8EUOnC/+ky7nHmCJMAO634pNcJUM3OfKXt2A+luDdygp9RfAkyk9D72yEVk2S9lGa3z/I9QxYf7L7L0Iil1tcw7xI2RngqLgz2mgDriSCPddbeiWpNYPGuSSUATLTRHtuR83CnqFB/LrOBvy5131sVc3V7R+DMdWRLvMAAY4DondWDkpqYddTUz7lbsuqp7m/O9iLLgdk2pDsojjwPs3MFfVZ/+EoU0y3GlCbxDnTyrbqFXjFEBSDtlQcAPI0VyPtnby1xo133rh5sAJQZ1khZe3HORSQlel/Zt64OFoPtNNOzPdCsh8dLUnpI0iXUU3Cwpydi5SjudJDSgdRAAPDY/5GhoLKe3iagoQ8Na5eMvOd4q04EYGL4UaxOcbQzC8jL0pnkG2q5RYLfss6GGRyIfdCAA6tGyysUuuLjB+lTqcIem9+DNgEiyXK2om58oI2sBrZZymPNbPJWUnItJa6M7KueKTKFy2vUmHdq+7x39yFUR4cyeBqSDe42OCutUKny8izM2GXyXU5r0TsvmnSTmkhmDQYReoIhNzQ4tMKfE5/kNHs3wcRmv3Gm99UWhqSYDnGrKpM4X8Nl/t4+cu8rYfuIJJwOChq5lkSjRqLCuN7xGMLLAmPVRWTOMm68BvYimtgnT00iz8rR10MNGNRC1l6uwLa9U8YUIe0bO0+W+i7fKKOQHipNj9GKCw/sZj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vs67JF/SgwCiLZDUexkGoSZaTLFqBCMuV/E6YWzu/2cEXSarATPKhZm3qIEW?=
 =?us-ascii?Q?cv9niW9OzR4OnFiDw4DA18zeEpOKXIX2o+Sl/pz6ALAmqWFmQgqiD9jigie9?=
 =?us-ascii?Q?/Kqgwf7jatGIBydYvR54vd/mIJd2kP6/gKQF/16Gwkw0mlbTJH6U9g1p4skG?=
 =?us-ascii?Q?qugm5rxh92I4hsmLs/TM6poSSNZbmOUTGwq1DjCF8lO6lvaCCdPWC6IFa0N6?=
 =?us-ascii?Q?+pyn3ICPqe0j+l2sNuPxHQ4DTyYuVfVoDiVqB1yHrx9gH88XviAMNAj/5efS?=
 =?us-ascii?Q?r+IYbUqMnuyWNI0ILRpnFuDy0gH03bQdA55lOEq2a859GBh1bDqhZ+AjJL/I?=
 =?us-ascii?Q?srOdhxs2JKB7jf/V3WtpYhGINCDkG9H11c+8QG/I/K9h5vObQudVTVhzeaTI?=
 =?us-ascii?Q?oGWH1ACtCBHf+dCU3DvAeyl9wHpiPibnTNEZcRt01pCCW4huQBOTWybYBWxm?=
 =?us-ascii?Q?EupZY9YszqTjuBq9XbnBwjHoFwE7Nf1ePgcrLRLdJHXJ7Rdm7jmQV5ZutDg4?=
 =?us-ascii?Q?eP4thacM4LREgXBFbjll1D8SOScZslMIw9zNP2eCNn3xf70DeF+2E/p5W2Ny?=
 =?us-ascii?Q?woZcT0pL//c55XfVmE3n+4t4YhfH1q+3r1lGW+LHF30HuwveSp7kJJ7yWxnB?=
 =?us-ascii?Q?H2uF5TdgSiGd8qm1dmk3IS14r0wtmiu+zIo75rg0XhenktapCFhH4tn/awqc?=
 =?us-ascii?Q?ANrRDMUq79TYEr8KnD3o1bLCHFsKvxn2m05IoVXGfVTgD555GXs7hKEqAkpS?=
 =?us-ascii?Q?1mbisPNMudGmIG8h5Rtzwl824hbYUuR2ukLfUTSMhWnqVZEudDREURUYJTRu?=
 =?us-ascii?Q?64WYdtxWrQZqCyHZbDtnVdPbSsUN++xhHbwaUNWlpQgQHIx0aokLGihiOUBv?=
 =?us-ascii?Q?scZ2WAsSVMWVXb6F2W0ogrCII7o5dKRTAv/fh+L9QAzGVyIPpz5lhIAJi4fQ?=
 =?us-ascii?Q?uEbSaq0jVNX3OWQy0gXpAdK/ldxxoSnHXsXBhY6jJsILmhCRRYbDwr5+0IoG?=
 =?us-ascii?Q?yT4chWkh8sW1vxRZDg14eijkvBfgxYrj0jigW+Me1vTXg8frpg13kdPmfPM8?=
 =?us-ascii?Q?fvW12rhboFLoU9fEYMm+BP5CVsBaF4r//tFHJa4eLli7iOGkrEp54Q+tDZU2?=
 =?us-ascii?Q?2iWOLDgMbZRlFtjblMs/6DEI2tNwXKp5eW9q8FiOkwTt1ErTDwSmaISvDV3J?=
 =?us-ascii?Q?DKACoGcADuscAOxU+RP0SVMEE39Jj1tKsjgdT9i2n9D6M9DNgloKsKMZrgMB?=
 =?us-ascii?Q?2WXjNMmo7QN4YyNiotUk8CyVtugw3qfA7hWeEKWAja5NScXUpLt/mYfxrvGP?=
 =?us-ascii?Q?qJpKMH1If30QMlM0OcdTa2TjbO8O4ZVtCVVc8YC0wFv5W/lkAW4Q4QTODAY0?=
 =?us-ascii?Q?WjiG7ln/Afsbstz84An9zL2PDZRW1CsCyyCTV2ggeO7x4UdXpeItP8VwPRJn?=
 =?us-ascii?Q?zMSFLJpKtFP/WmzqqFLLf5R3MOOSeMNtgK2CON1hYMTfQX8YnCwvkdnjNyAe?=
 =?us-ascii?Q?axJQkwR5xNzhxSmrc2vBf8QNFvvX4aJ3zyPcyIbxoAx07Tu+kxrW4bQ0lNQP?=
 =?us-ascii?Q?gQqd1HSkTnG0yJ/y2PQkKWZG8dPOndpV/wfaPcG/75HFbjiLwF4GT/Ow8Wfb?=
 =?us-ascii?Q?LDZpPZVJKg3VWnmwFKLjXvzfKOt73HFl+2cXcI8oO7HfFHIw8otEUaE54JGV?=
 =?us-ascii?Q?BaSOzlUWldWJ4lQqr/y+CMdtd6dc4qvbI8BECqVztHlBIbIhFXUuiDEnQzcV?=
 =?us-ascii?Q?SSiJ39dPJw=3D=3D?=
X-Exchange-RoutingPolicyChecked: RdN2MdMxocTM/ihXnORbXzn/v+1ye1LcYa/JuvssSQwdrXjvYMUApKqQipWgb5U+/R8kWaxZ+sWcAwn46HFG0LoiagCg7iU6gxqmdwaUg6twNnTPWIF5gBEAfplVTZHZ9gfIABEwCrXpiKDHO78FYEDg2e80bCHuc5PuqM7OpwrBDF+mjmtyFqW+1eA46TzWz9L+FR7Tvq9otw7HjhWldyW8R3fhyuNMkOYuqG3YrK8SpOLhwbwi0trWvnwRShyM3prrIw/DGzl9FJ2WYyTFasf58F+azhpZ51qUXW46nlht1YS7aIUBErtpbWasRaLPrWBnkYe90y0Wuk47C9j6IA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b45055-88fe-4f73-01c1-08deab23d052
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:59:04.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P68bwCN9hqZsY9HGI+7kMdtuR3MMB6nbjIfrZqFVsluc4tXMrMmSt7r3mrTc7Oc6XI/r8BJtrZF1YoQbBfY9pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C4C314D609C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244312-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gsse-cloud1.jf.intel.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On Tue, May 05, 2026 at 06:22:25PM -0400, Zack Rusin wrote:
> vmw_fence_fifo_down() drops fman->lock to wait on a fence and, on
> timeout, mutates fman->fence_list via list_del_init() and signals
> the fence without re-acquiring the lock.  __vmw_fences_update() walks
> and removes entries from the same list under fman->lock from any
> other waiter, the fence-IRQ thread, or vmw_fences_update(), so the
> unlocked list_del_init() can corrupt the list head.
> 
> Re-take fman->lock before manipulating fence->head and use
> dma_fence_signal_locked().  Wrap the locked signalling in
> dma_fence_begin_signalling() / dma_fence_end_signalling() so the
> lockdep annotation that dma_fence_signal() previously provided is
> preserved (the same pattern as __vmw_fences_update()).
> 
> dma_fence_put() is moved outside the lock to avoid a recursive
> acquire from vmw_fence_obj_destroy(), which also takes fman->lock.
> 

Just looking as someone who is curious about AI - not my driver but this
almost certainly looks like a good fix from quick look at vmwgfx code.

> Fixes: ae2a104058e2 ("vmwgfx: Implement fence objects")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4.7
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> index 4ef84ff9b638..384c6736cf6b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -367,13 +367,24 @@ void vmw_fence_fifo_down(struct vmw_fence_manager *fman)
>  		ret = vmw_fence_obj_wait(fence, false, false,
>  					 VMW_FENCE_WAIT_TIMEOUT);
>  
> +		spin_lock(&fman->lock);
>  		if (unlikely(ret != 0)) {
> +			bool cookie = dma_fence_begin_signalling();
> +
>  			list_del_init(&fence->head);
> -			dma_fence_signal(&fence->base);
> +			if (fence->waiter_added) {
> +				vmw_seqno_waiter_remove(fman->dev_priv);
> +				fence->waiter_added = false;
> +			}
> +			dma_fence_signal_locked(&fence->base);
> +			dma_fence_end_signalling(cookie);
>  		}
>  
>  		BUG_ON(!list_empty(&fence->head));
> +		spin_unlock(&fman->lock);
> +

You likely can drop spin_unlock/spin_lock dance around the put here as a
put is just ref count move or vmw_fence_obj_destroy on final which seems
to resolve to kfree_rcu in any case. ofc, if you want to be parnoid it
is perfectly fine to drop the reacquire the lock.

Matt

>  		dma_fence_put(&fence->base);
> +
>  		spin_lock(&fman->lock);
>  	}
>  	spin_unlock(&fman->lock);
> -- 
> 2.51.0
> 

