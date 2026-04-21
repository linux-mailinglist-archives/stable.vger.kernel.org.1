Return-Path: <stable+bounces-240213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ8aFB6152lU/wEAu9opvQ
	(envelope-from <stable+bounces-240213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:34:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DCD43E08E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F7B2304EB8E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E131077A;
	Tue, 21 Apr 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lO7qyD7d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A02BDC0B
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792669; cv=fail; b=jbVzrKh2MfcPD9Qt5IYALKGs75mbW0SEiLTHZRW91DmdP+f6FZBFcjmnIiPm+WhBcIE1FD4Tbv/4kgdjg9WgTHeQMiP4IQrB3JlkSg2EgQHKiIlKpO30Rx/Ot9XHJMSMjzQmL98MfrG9y7JswdzPyrqlCTzBbcvR08eg2xLTDLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792669; c=relaxed/simple;
	bh=KSZDSQ8QBcGh5xZonEtTBGx7ezb+FpA8hTktwCvynCA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bOmuHZDtjzKfmL8lnyXsTXIzDSbWpWsUAz3wYPK2wKB8mni0XgB+qVQWO090pDqwicixgVqLl62rI3vQ9Am7HHq0wcdjYx2vZWCgdNvLZ2G7qfOFN4OqJWdWU6BcsFoJnCfbcwhKt6yNVY/B2U2Eylcz8YaDojEFuiT8rrelo9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lO7qyD7d; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776792668; x=1808328668;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KSZDSQ8QBcGh5xZonEtTBGx7ezb+FpA8hTktwCvynCA=;
  b=lO7qyD7dFUXlGF10oQ7V9NEfrkig7KdCCMeDzjSf4l7b8ywkAMbtaPII
   //CPOPbPxoYInGai7vAQ78gs6i1TSD7x3CRHK3fkt3wEav6E+8JJoYvu/
   x96NmIQAKT41fJo1hyFCHIQz9nksuAfoMpqdt6Qh26HP46XEO4oj7QcA7
   t33Djl1sI8MFinLJxEIAwXEIINjbn+2qm7WZdFUaurQvsIBKum+whl98Q
   Rpo8fzh1+q9Q8C6qes7jTBJzwHZul7U5S/+kVz9LBXjdLxryiKPKylRaP
   A6jH9ud2/7JdiaW7yJOEurVXpmAblr3mO3zmfOWAfH9sRMTepj61H2P0x
   Q==;
X-CSE-ConnectionGUID: 47yVX9f2T6qD8fPpPcp/HQ==
X-CSE-MsgGUID: 1TsiZbfVQsaw0AE8ooWzhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="95147730"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="95147730"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 10:31:07 -0700
X-CSE-ConnectionGUID: sZZ838V3SSW1KFnvxePm6A==
X-CSE-MsgGUID: DlLPhItuQ+OzXXGGei5drg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="237124426"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 10:31:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 10:31:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 10:31:06 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 10:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAueysljNdYh7lK4E77JxjmJM1uQUM5y4y/i0Fk5weOpy1ZVQuilG13e+adAZ9sgMgAbLA1G4cBEMtPR5uYT447yCiMlF2lkf6FVbcbSLO5Oj2biH0I2o8GWcJX3RJ5e6iUEMbr/LXcSuAWfkW4ozd3zTxnLrTJok5ytbawbB6MkaHmD+c582ek8BNfhGzbVgGph5cn/TY/qNAK5IgQMq+O8HfIeqWeuyETCXu9WT9iRPRYECQUyCTdBTltcHzTmAVujLX1IUX3qInF3k6Z19s62YQgkoL9sSSZVgA7fjvTj0S7HXRgfMNvLtho409hbECzowIdiS+OiR1907Y+tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu2gW8dESTdt1j/pgvrePkyGvjqUmKXyHh9Netf4nOc=;
 b=b3IBFZsr7c2Hlmi9Z6H8Tmm21gUzgq6vhLQ9GfhxdvUbZurUempF3sngVmvCrssWoTELuWkEqKilKs2aRYX+cwAD0VhMzK1u4NWWDjBql9GuRSsUKe0eYDaEIHlaFCgGvAYr6N3402cu7TIPrkgIE3quKOiPUIoYqG4hOKseLvahT81KQNo0fCeqKhQzm81oPd8N2+vKJBs86HYeChyM/RFIDkE/2mclfEVk4nTusJQt+KZOmofQbbDYVaJS4fCRaVFJPjFPVMIbHes62aTxurniXn9t8zF/+i7LQYJk8n0fzsL0Hn6hhzguvcp/8DNoqvpcha0egL6axlw19i3jPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by DS7PR11MB6295.namprd11.prod.outlook.com (2603:10b6:8:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:31:03 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 17:31:03 +0000
Date: Tue, 21 Apr 2026 10:31:00 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: Tvrtko Ursulin <tursulin@ursulin.net>, <intel-xe@lists.freedesktop.org>,
	<kernel-dev@igalia.com>, Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/xelp: Fix Wa_18022495364
Message-ID: <20260421173100.GC2131374@mdroper-desk1.amr.corp.intel.com>
References: <20260420131603.70357-1-tvrtko.ursulin@igalia.com>
 <384adac7-2aa4-4568-b7a5-987e914fbaf2@ursulin.net>
 <20260420202932.GH7476@mdroper-desk1.amr.corp.intel.com>
 <866fe0f9-73a6-47b3-ac37-41bb26c0c6a6@igalia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <866fe0f9-73a6-47b3-ac37-41bb26c0c6a6@igalia.com>
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|DS7PR11MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: acb3236c-7d87-4605-5044-08de9fcbc2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qLFAAQIb3m+TagkICInqzcQi9z0FEX6It0swKV7eZ5ncjz2C1B/qIXG9PH0ciZ6/YibZ1In5tz9QCk67BJqL6xPME3D51NjlRrkIilzRf9+am4owFFZpVrumciRU6UqkdSMqP6XYSU3CqADoNcXFkcbqrHpSQyEoMOt0LqLAmdq+CdHej75M+01cxCy3rcl6MAqvUynPWO30ZjdvdpPMdXM57FnrZun+5GsXndvFyy84lik0US/tYsPC/S8BjBBuF26amscZT79G6WdIbmaEOcruRKaglaKRXR+pVGaJSE54UWe5WgN1sqbDH6jw2S+l4BB6Nxuxx0bXHkdLzyG6M3waqUfdmKOIQhCYCqTxgv74YMipi+OhTHr4x/dsUYPzX4+rNboGOIdecvw4t9J1LHLjbfNAH26a/AYinonRZG1whGEUJtQWWwJ6xTgMyiZoBoWQlTefsRpSujSRf597Mn+1oxDSoA5dBLlZB/3nUafAO2GI+4OC5PgRj2UxVNv0MIouTXfLdS+w23TqQFL47UTGcl1aaFUZ1GVv4LFHYDh2S0hgXHshktlAjuwJ685TgRUekJeuPkd0q240vTszx9/SjNxtR2PUAUw2l1LKJPV86kOab/YhhsBJpqJeDJpZtBGG+hiMDoZnX9Sw7HsX+DYPOqtFIyPyrlJWEM6GEyFqAtd8EPi6GhgM8GPXzFKjYnp6Vmlp9SnUfZk3CYMn0ckmIxptA9FFJVSpEAOLbtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n2hcTzzdatZIVIMez2zs15JP8RPyjB4wQQIdYffsKvawx5CKcX+Tm/SOkc?=
 =?iso-8859-1?Q?mzKtixRzdKVzC1cqNkl+B0XSyH95gg9HAO6aRf8k+GeX4mATq2D0C5oWAp?=
 =?iso-8859-1?Q?wYEOZkDeAEDZ7v+2rzCg32aFNGWV1RiSjYzux3OYhpcHToIboS9kaRV0T6?=
 =?iso-8859-1?Q?bO2otYmMgpNmX36+rHLHPZFY2/SkIO7ItSh4QBA3o5k2C1G1EzcfE9dgqK?=
 =?iso-8859-1?Q?Of/DrZlSuFcCNg0voFS2DyOIBpcPFPsARekiNWQ2s0qgXleqmu0QLGwHid?=
 =?iso-8859-1?Q?v+3YY1tkjyo/uzGeVShmaRXYR84FwFxikgmGlOJnea/P6Yo6yjb5n5lcbm?=
 =?iso-8859-1?Q?85XJFNpUB/iDX+0elKu/Hz5xTi9Axyn6Pacb2aoHkXgMlAS1/Ymi1tztkj?=
 =?iso-8859-1?Q?6j5J4204veJpmfZay21r/X/YmuYn8xzOsBS2e1igb/Xeh93lCLjNoH+Ovw?=
 =?iso-8859-1?Q?u1itAsfZmXhhr9MemOXYBNKvBPDnrCijrjyckXQXtXC5vbUWHkHi9FNGuA?=
 =?iso-8859-1?Q?LZHfIOjkNkOGD74KjrRHkXr7KioC0VqdH/OT89arHUozCYCxOc2lHW7HnC?=
 =?iso-8859-1?Q?alOnciyF7Q/uzslMzFb++T3Q10wK3AznsVf6wcXgo2z+Cypj70MIAUe2+f?=
 =?iso-8859-1?Q?9nSsYkdbF5JZgzglUPrVmAdNgwES3UUgtEjW7rPEhTTNMrkaFigxp2ZzeY?=
 =?iso-8859-1?Q?JOg1WghI9RodBXRIW2zmEU+Vyl7GUX38AGdBoIE4sKTvu+nDHVxLkDS5j9?=
 =?iso-8859-1?Q?ItdOF+L/KFmckplm8jYD5p0RJJL48LJkPahiTaY155UwAjEs7EbBpDU0CN?=
 =?iso-8859-1?Q?KZqn0gPC6JeIFh8Qsh5HEUdIJDgb5fc9WDPnD0YGiUV9HXD8EInIE9/sfX?=
 =?iso-8859-1?Q?N4G0MatVupBWPjrM190mSSnotZMmIS07iqhLbCUplhMDfkfs7Hh3HT5uPl?=
 =?iso-8859-1?Q?lVsWZrcPBn5hMvYa9qPlqkwkHh3Vehcbg6NFbcyG3UcmduxH10OOtlWtxc?=
 =?iso-8859-1?Q?EO/RaEK8zOmYEUVAE/0qXrbxLrvB+oWPUugokXEXGlWf24jBQTx8DTT4vE?=
 =?iso-8859-1?Q?XIQUgAD4FTbBCSXCtqWKyzTU0YEZi6leWmjex0fg/ajCAQO6LKhy2IIj2S?=
 =?iso-8859-1?Q?WE5PU5drW9sLIitL+SnHwmPlqUr8FksLVbtxvU2fDGjDvEsF7uePuKrUdZ?=
 =?iso-8859-1?Q?IdzhTFT37tBehObAkTil8x07S2fDqd+G+k9/k/8/SHsewz2DujbDpZakbj?=
 =?iso-8859-1?Q?vN/VjIgJzJkObiQ19j/errFyAqf1nWOpKtl5o8Ddhjhj+NEPL9zbl2/aB9?=
 =?iso-8859-1?Q?aWLBnnQOZUSQJTZRucStZxXujD3OUqc0CMnz3Bm8VJmZyoSYS4bLmz/oJc?=
 =?iso-8859-1?Q?Wluw0gU4Q+LBSnwrbUcMtW599jyL0ctMedSBSYi4uHG/ypMZPJRewaL4jw?=
 =?iso-8859-1?Q?j7Q+WdpOBRloVqk2an/Y7GxIs111pqC9pj5Qgdo3wLEkXp9S+XBbbR9932?=
 =?iso-8859-1?Q?AVCb1VDE3ybdUzPuOBYNN/75LxGpKztIR2Fyks/L3lWCK8KC2qvfqKjHzq?=
 =?iso-8859-1?Q?KY4fPnuQP2ohYs/Qq1BpevyEaH3TZja5U7wdiAh9u1Nou7+xIo5Q0hUb0K?=
 =?iso-8859-1?Q?vJH/2hDS/Xe/82cWmxesgJOe10JN9xVLUkddF3QhfN4lNlYgB8vfnz2A/g?=
 =?iso-8859-1?Q?z9K8zY0j/wDM8GvdtLOXzCGow0qYOrszRGUEr6Wk3Y6jiWZkN56EynQC/e?=
 =?iso-8859-1?Q?qpVB1sG0nXJhegZIjOvd+hTBJN+5vukM+bHz0O87UoqIRynlQLR8t1LX8R?=
 =?iso-8859-1?Q?CKG7nkEdeUk+s/vu8dr4TR1rXPEek04=3D?=
X-Exchange-RoutingPolicyChecked: wKK97BknL5a37PSe4/9M627i1o4Po3AQud0FR6EUSh+aY6D7QEnPybokpAJ2xLHA/BEQfTk5bo+Aw1DHa160i90WmPxi+OoR0SZcih/zFADsu8dHZdeDrVgTFzklAYo6LO91+M0b2GoN4WnFmHUuY9ej3mmFd4vBsXuqEkEloaI5YwnkHH4D5sxp93xG4G8KVxB+XV0/uo/YlUSjw6KffhqWqqZUGcBsxKl3oT2z/V2NqNLxz8xWamPvTfUaR31fdio3NtJuPX054wwxOGPs3nh6sar3CUT4IU0qY3SRKb3QDy3VgeFPey55lqhkfoogrpCMUFU8YPcpnLnWGEk4Lw==
X-MS-Exchange-CrossTenant-Network-Message-Id: acb3236c-7d87-4605-5044-08de9fcbc2c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:31:02.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGsP5miwK77t7kh+Nmcn/2cYVhlCEQ0cQC/aVSZvv14Wxn/og9w3EK/QWNMB1yKwPQtFC6KHVTOrCYbZ+SOVXHSrCVZ3To3nV7Lq30bM0Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6295
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240213-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.d.roper@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D1DCD43E08E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 04:09:25PM +0100, Tvrtko Ursulin wrote:
> 
> On 20/04/2026 21:29, Matt Roper wrote:
> > On Mon, Apr 20, 2026 at 02:24:05PM +0100, Tvrtko Ursulin wrote:
> > > 
> > > On 20/04/2026 14:16, Tvrtko Ursulin wrote:
> > > > Command parser relative MMIO addressing needs to be enabled when writing
> > > > to the register.
> > > > 
> > > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
> > > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > Cc: <stable@vger.kernel.org> # v6.18+
> > 
> > I don't think we want/need the stable Cc here; this workaround doesn't
> > apply to any of the Xe2 and later platforms that the Xe driver supports
> > for users.  While it's possible for developers to manually override the
> > driver's detection flags and force it to load on Xe1-era platforms that
> > this workaround does apply to, doing so will taint the kernel and we
> > already know that a lot of Xe1 era workarounds aren't implemented.
> 
> You are right, I just blindly copied the output of dim fixes. But it doesn't
> matter hugely either way since as long as there is Fixes: it would get
> picked up for -stable anyway.
> 
> > 
> > > > ---
> > > >    drivers/gpu/drm/xe/xe_lrc.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> > > > index 9d12a0d2f0b5..c725cde4508d 100644
> > > > --- a/drivers/gpu/drm/xe/xe_lrc.c
> > > > +++ b/drivers/gpu/drm/xe/xe_lrc.c
> > > > @@ -1214,7 +1214,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
> > > >    	if (xe_gt_WARN_ON(lrc->gt, max_len < 3))
> > > >    		return -ENOSPC;
> > > > -	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
> > > > +	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_LRM_CS_MMIO | MI_LRI_NUM_REGS(1);
> > > 
> > > Or if this register exists only for RCS would it be better to define
> > > CS_DEBUG_MODE2 as the absolute 0x20d8 (as in i915)? Unfortunately the public
> > > TGL PRM does not list neither the register or the workaround so I am not
> > > sure.
> > 
> > CS_DEBUG_MODE2 exists on both the RCS and CCS engines, so I think the
> > current register definition is fine.
> > 
> > Personally I might have changed the line farther down to
> > CS_DEBUG_MODE2(hwe->mmio_base) so that we're using an absolute offset
> > instead of relative, but adding the MI_LRI_LRM_CS_MMIO flag and passing
> > the relative offset should work fine too.
> 
> Good to know, thanks! I am happy to change to absolute if you prefer.
>  > Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
> 
> Thank you!
> 
> I assume someone will pull the patch in?

Yeah, I just pushed it; the CI results weren't available when I checked
yesterday (likely due to the weekend CI farm downtime creating a big
testing backlog).

Thanks.


Matt

> 
> Regards,
> 
> Tvrtko
> 
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation

