Return-Path: <stable+bounces-127436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E77A796E8
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 22:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C5A3B3080
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C861F2B8E;
	Wed,  2 Apr 2025 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMui3dda"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C01F130E
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627386; cv=fail; b=O/gZIfMzZKyO8nSvhMJ3MDB5XSFDnJaKZZZh4zG2zpj2XHAaXTKZai07qo3xdTXKF3KwKBrlNI4bWNBEDIf0twYiO1AsrDBS0Nx31QnwCnIho6xAMwEn7GKqM2w/IJ98oOV0V8xO+L8d7oDTat+dytfKEMbzLOzHDUiWcG0SVnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627386; c=relaxed/simple;
	bh=bPgyfRjMPJCz3XZvVoPh+3nXwcbvJTgPn6ldg11IEU4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gw+wdcmyUW8VZoj1AVzL0TJp+uES/lhmRXW06AvVH7JWRDsbfx37FX6yeuwv1AVjVE0nEGP7hryBi3izJcz1QmXi/Rmw6MN8+j/IES1uHLofCkpTQqkpFRDNjtCrmlPQx64HDEj7BF6/Za8ifh8WZShDkGF+xy+V/ImcnLT5Mlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMui3dda; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743627384; x=1775163384;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bPgyfRjMPJCz3XZvVoPh+3nXwcbvJTgPn6ldg11IEU4=;
  b=FMui3ddawolMyV2rLkNGUjyp2XfEN4g3YFx+9LxJpvXjBypwTU6+MkXm
   6ggYTbWy/oKNR7kveLeW7/TNYxbRhl3bM6mVVpSWUeQQ4bGk47lMeLSf9
   rMTEZFcEsdCk/wkCA2+S7Uka29m46GXqLqSQhPsW20KJmcB7bMn1yrsQ9
   jE9TXlvk4ACWlkcwfFR+MeSxjyZzwuYPIejMXbpGNCZFO/PKVb2DQTOxp
   aM6tfP+cjKv3cjlOJ0CH/DJDoLXC0DvX/+MV139XWPeY894XGqNTr980y
   hfeK5ldEVca1rFmTKubcy1j7H6jiPpiUsPvkTzoSs7zQ+hWyWGoEykb5z
   A==;
X-CSE-ConnectionGUID: 4FfsynslQ1iEYNgxfzk0GA==
X-CSE-MsgGUID: CwrSGfc6R9C3Oo5uExooMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45024654"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="45024654"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 13:56:24 -0700
X-CSE-ConnectionGUID: eSfiqDMjT6K/EJPILihfeQ==
X-CSE-MsgGUID: tbHDX1NiThi9H/xOkJ/kXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="126710305"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 13:56:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 13:56:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 13:56:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 13:56:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P89r/DqmOm3DDOWyUcQKx5LmZE4TtG2nO63+9TTjA8D/WEQCBpvhb298YyEj3OYjx+whT6a/JMI+8CwgbFl/LhVFK6/QZ6WAvAuEJmkU68Ks45Y09uOVkEFeZJfoPpQPHkXLyWEgMeGROrDUKDB3Y33zJld0yHnH9BbIIiU5xem2UDjMnKR5aqCgE3z1XcIxdSYj4sCBgW7rpWFzQV+QQXAoDE08gjGWio8jNhtkUVkfMoz5IDMr6MOYHWRDCCxXoxNEHZtFLwyJAbDU+lQGRdYoyTei0jsOVFaAtJAWeu9ggRmBCC8fwIVgUMRi2AxgipCh206d6NwT3dCcJaYoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs+YB73ShoRnrs30Q4WJRt1GD/0GSNlwNHUWMswhRaQ=;
 b=MD176JG3LIYFsn4CiahoRJXv9p2RRq7IqWvgYtz3JO4pG6pmqLKYdDCW7x0+CLy7ARDirhs5SLmnQIo061GwRHoGJIGZnc9srRvmPTUyXmPrtkNRxP2JKyIaN3X6r6NNwc7xuiucuw/3hJwpxVoY1To5qLCzN9MXYUsbE9idLWdJeCcfQ2GvG2BSYBWe/7HLcvx57JR/BCk4B+So0DIio93arf9DsnB8SvqyKzu2IubtgNiGWmBP7w0HKxz6zl9CriWKFQzTi3HlANAp3ZsCX/rbik9p2wbBHPDttKSENnKSlC1CSlRYQUfUd/HWlS2XlJFVSRvaDw0IB6ERi8tWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 20:56:02 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 20:56:02 +0000
Date: Wed, 2 Apr 2025 13:55:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, Vishal Annapurve <vannapurve@google.com>, "Kirill
 Shutemov" <kirill.shutemov@linux.intel.com>, <stable@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
Message-ID: <67eda45ee899d_1a6d929462@dwillia2-xfh.jf.intel.com.notmuch>
References: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
 <7ed9418b-db12-4678-bf7a-634daf66282d@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ed9418b-db12-4678-bf7a-634daf66282d@suse.com>
X-ClientProxiedBy: MW4PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:303:b8::6) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|MW3PR11MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 442c2c81-fa6d-464f-4033-08dd7228c75d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NytsUzFabVZaMWFZSjZjQUhINzJBSVRVenYxcDBReDg1bHpnOElyeHRMZlEw?=
 =?utf-8?B?cXN2M2FtejlFc1U3Zm45SWZWblFNTVpnVGZFcGJKeFNBd2hNQ290SEV1M3Mx?=
 =?utf-8?B?T0s5QW45OXRaOEN6dnVKeDNaN3pjM2c3ZEpSVzM5aGFrUXdFYVhOTlZ3bjlr?=
 =?utf-8?B?TFYwblZ2UkpGejZMOWhJRGRHdi81RWoyRktjL3pLVVBVbGhreEVNdXc1TVdw?=
 =?utf-8?B?WHkxNHlGMVEyVXVLbEpyL05hNUVETVRGUkdlVWx6eDAzSkMyeEpzZlhNQmp0?=
 =?utf-8?B?T0RnZlJTcGwrWkF3K0lPcWZYdUJNQk9qb0pPbzk4eFZKcTVic0RmVDJzelFB?=
 =?utf-8?B?L0NhSzBhd2FHZlhOZFI2RVJmV0MreWthS1RDdXBJdE9FZEJxZVo0ZExrTitj?=
 =?utf-8?B?TzRHMXlmekRCRE5ZOXNocDdZTE1yNFRwRUpER090UGVrM2V3c1NJMlM1Rkha?=
 =?utf-8?B?WW80U0tpZ1NtVGhVYTZVUnVOeHl2c1hmOW1RUHBiN0tjSnRMNE1Dcy9kRXBT?=
 =?utf-8?B?R1pVZ1NOZU9CZy9oQ3AxV3pkcEpRdWswcTdXZTNVN21tUzEwV0FjSUMwalhl?=
 =?utf-8?B?RVBTcmcrSXp0Mk5wYTM4RmUyOURnK0xFQ0NLSElYcytjMFlySG9aNWFQa2dw?=
 =?utf-8?B?NGNHNnFYSGhOOTErK0cwbm9QTzMzdDA3R1VYTXJldVU5cmlLZ2toNGJMVEts?=
 =?utf-8?B?am5ubjJnT2t2ZkVjbFV3WHhEWmlsZWNXS2tadVFjZWpVckRQTm9OVDQ2Nmh4?=
 =?utf-8?B?Y1MvbWg5SEpMNnQ1UUF4ZDdXYzFCejFoY0JzTHVyb2w2Rkplc3RNS3N5Rnh6?=
 =?utf-8?B?dWdXRWppMTh1Qy8wOVl4U3dnWkdmMTVsMzc0YyszWlFzbDdpMWNUbWNsV2hY?=
 =?utf-8?B?bVBoSWRjaWpJeFBtTDg5ZTBLMDdrcE9wRjdoMlRnUFYyL0pLbk41LzM4RlhS?=
 =?utf-8?B?TTNzOGNWdlEvRUpwM2tBdGs0Zm43YzFBWmpRWnRmcDF3ekVKb28wcktCTWJa?=
 =?utf-8?B?ZTZxM0JTZG1JUFQ1cXdVS0U2MWNvV05lODROeHJJMmJYNStUNStITFJhaG1U?=
 =?utf-8?B?MHppZUtwczhwNGRCdzR0ekFrK1cyRlZXa2oxWDl6bWFLelF6bnZQZ24vNU1v?=
 =?utf-8?B?ektXTEJVeHF6a05EYlFubncvWXFlTjJsbnZqWWQwbWlTVEtoMFl2S0JPZTlV?=
 =?utf-8?B?NVRRYVVvODgwSFJOdEc1cWVqc3Jjakk4UGRkNExleDB3QjBTNjd1Vjg3OHZP?=
 =?utf-8?B?WU10Q1RTbFFYeG4yVXBCalVHWFJ1NDR1bnFJNW1jZ2h2d0FDUCsxTmtQVk9h?=
 =?utf-8?B?blVDUHBwMzVMa3RHZGM1WjRheGExMWpvR2JHT3htOTEwQ0NsTDdMY2pSdnpy?=
 =?utf-8?B?N1pLZTRaUDhicGRTWEdXSDBpTzBDSEpNSGJJVExYOTFuT0tkaFhOZlJ3STBy?=
 =?utf-8?B?bFBJc094OFJOVkRLQlk1and5ZzYvUzdRaXNnaUxTazFWeFo2eFdIa2Jnb0lT?=
 =?utf-8?B?dHc4eGx5RkdZdWFpTVlreDl0TTd2cUhoaTcwMmFDSHBRektINFhhZUx0aUN5?=
 =?utf-8?B?WjQzQkZJdzl2QzlNeW5hVGVaRXo1OWpBQnFWWUlNNzlFc216RXJqOWJTRUtK?=
 =?utf-8?B?bWk4c2h1bW9Bck9iWVpvbDVzR25uMHZFRThSMEcrR1E0MEtYQy9KNlFNYXdF?=
 =?utf-8?B?U0F2azdvcWFsMDZlZDFPdVhYWG5nZ2dVRVk0Z0F2L2FmK2RXSktwVzQzZnBM?=
 =?utf-8?B?ZWp1OEFkK0R5ajgxdWRhSGxSc2NsMklFMmJDOGIyNENSVmQ4SXhsN2p6UXpR?=
 =?utf-8?B?UFF3WWNtMjBaUVk0UVZNSWVxbVlCWWJqck5HUGFMZWp2elY1K2UxUkFrVkMr?=
 =?utf-8?Q?58i0prgbFcQS0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDBwd29mdnpmU1ErakFiczFvN3BlNCtFTzg1RXJvTS9xekdVMFhpbkZoV2FX?=
 =?utf-8?B?bEE3YmtSQkJaaVJycUljdHlhVThEdFF0VjZGRE1tL29XL3h0TEdIcmUxdURa?=
 =?utf-8?B?UGlqQjJQQlJrcmxnNGM4ZVdVUlVMU3VoVEhSRGFVWFUxSERycnkvUXRCb2xm?=
 =?utf-8?B?cVFrR2w1b3NtLzJ3V2NFODZPek1pcmtSMUxmdER4YUFYSUswMjRTYXpHN0kv?=
 =?utf-8?B?RlkrK3pJZHd4T0RVNlNWSlZEbDc3emkyOHcxbDNGeVd2ekJ4QmlualFQYnJy?=
 =?utf-8?B?bWxoNHhJYmVaZkxWOFdjSEkvSEFGRENndGdnQjV2Y2VidVBYVndhdWdiYVVV?=
 =?utf-8?B?U29JSlJzZWFaN0VDRUFKZzRuRzZ0dVI0dTBnZG5KTEhrSVdlNW0wNW5XbWhF?=
 =?utf-8?B?M1d2d25LcEVGbk1BQzdvUjZ4Q0w3YThVMXZQblpCSlpUUHArMjJ4QUZKTkRQ?=
 =?utf-8?B?Q3RuNWtja0FmK3lKaER4c0RTOTEwb2ZoVUkxUjQ5SDc5anNCd1VZS1IzaGYw?=
 =?utf-8?B?RCtDbGJIeWd0RlFteDVhRFRJUEYxNHJ5WDVDVDBYOXRKUjJhTU5penR2aEJl?=
 =?utf-8?B?UnpPY3FxTXZHSENYaUQrNGtsZjZRQzAwZFR0SFg0emJGZG1xdG5kS0llc3o3?=
 =?utf-8?B?ZTg5TUoyaVNtTUFsVzN5dkZaQnBidEdCNS9PTjlBRnp4STNSZG5OUkZ5UXhp?=
 =?utf-8?B?OFdFalZFQUdFVmF1TjdqK25FNWh0aDNBRWFxS1g2bm95R21hMGdrQU9FTDh1?=
 =?utf-8?B?Y3doNGZjZzAyMEVXaW04SmROQkNiaVpFUjgzTXBqY1V3ak5NQzNJbHNYMWp6?=
 =?utf-8?B?TFRleGFXakE5ajNRUm5mWTNpRDViWFZFa1h0U25nT3NRVzNYaEI2UnpzZFRI?=
 =?utf-8?B?eDBYUEVqdytXUEFaWVp4WGFoZm9ZN0ZUb3NBMGF5VGkwSHpyTkUrV000WHBj?=
 =?utf-8?B?UlBwOXhkZHVwOTBZTmJpUllBcmdBaDhLMkw0Q0hUbE45L2d1ZlZPcktmTG1l?=
 =?utf-8?B?dHdtbU1XUnNlM1Rpek1MWUlxL3pOL0ZBN0hJdlN6NGNCU2FzdlF5am84YURt?=
 =?utf-8?B?eTBBWndrQmZKK3hkc0o1bS9jUTcvL2pMdmlEejRrZk9MSStLZVhBL1BualVi?=
 =?utf-8?B?Vm45Y29CNHYwWjhMK04zZ3ZSa2RuWlpOVW9Kb05MZDJYK096ZHdzRWNOS2Fr?=
 =?utf-8?B?eEVEMHlPaWd3SjZ0cE9IL0FsZGQ1OVczMHpRQnhFU084YlF3MTdXMUpKVGM2?=
 =?utf-8?B?alUvb3VxMDh0d2swQVhTcGpYUWF0UmllNHJxbWUxU1A1U0ZIdjZhdkpReG1s?=
 =?utf-8?B?eGp2dG9WUERsZXMxOHdBc2hzb09iMTc4TWY3RUw3bmd6T2JRSTdEYTNlK1pG?=
 =?utf-8?B?bWpXM3d6Q25nL28walljSmxRVGRWS2tLdG9nS3drODZLYkVDSGRLT2xXMlJu?=
 =?utf-8?B?ZnVxU1dyVCt2d3M3NDZ2bFdDRDU0THNqYzRxRWpPcU9RUXhoL3htYjgwUzdS?=
 =?utf-8?B?aXMwT2VweWRvTEhvTmRSVmxheWlxRW80YXlHTjdtc3JQNVRvWS9xeHFUSGdH?=
 =?utf-8?B?VENBTE8xcStjZ3A3OEpBMFFsZ1d1Q083TWdwczlsVXQxYjhWdTkzaGZ2NXhK?=
 =?utf-8?B?VGxjd2x4MjdCd3JYTUp4R1lUUkk3SUFsM1ROQThkVy9tT3ZDclZzOW5ORVN4?=
 =?utf-8?B?U1JaWkdBZGY5anBnV01TajgzUzJTQnhZbU9CZ3hFakFlVWtqSTJwWGlERzh6?=
 =?utf-8?B?YWlPVzlHZXJ1cTVZVmRYcXRjZytPUzU2akFwL2VuK25mTHczN3JwV2I4WHRx?=
 =?utf-8?B?V254S0pkbGx2LzM1OVpXMGM3R1B0L2lERGJrNEo0Z1VwdENna1FYZldyMXZt?=
 =?utf-8?B?Z3h4SDBJSUJTMmZnTHh2VU9oOXBGREtvYnpKVmdlaVdldW0rS1dKMWJzOUJq?=
 =?utf-8?B?VTBMS1k4bjc4eWt5OFcwMWpsa0I1Vi9DZ2hWcitUUHV2azRYYXhUeHcrRTRl?=
 =?utf-8?B?cVZJMys3cm9ubExXdFArSTdCU2FiaVpQSVpNMmpvWVZCbWlhSk9YTytadlhs?=
 =?utf-8?B?THFCR2JNSmFjb2c3MXh4Q0ljN2NTY3JkcVdaUDNVRkFXKzNkbHZnZ01mK09k?=
 =?utf-8?B?TWZLZTBMeGNEeHhjUmJjaVg0SVZRYmxPNmNpTFRFbzBlZDNPZCtDdCtLaUxa?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 442c2c81-fa6d-464f-4033-08dd7228c75d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 20:56:02.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YvqkDpPzOXqG0peWcrZzflw3SefMAcp9B0v0gi+nz3CCuuHE6tUq/y63rxRzss9hMWR9M2gVmV8CAMNn6gw1PULrdlU+l8t5U9CHjhI9Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com

Nikolay Borisov wrote:
> 
> 
> On 1.04.25 г. 2:14 ч., Dan Williams wrote:
> > Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
> > address space) via /dev/mem results in an SEPT violation.
> > 
> > The cause is ioremap() (via xlate_dev_mem_ptr()) establishing an
> > unencrypted mapping where the kernel had established an encrypted
> > mapping previously.
> > 
> > Teach __ioremap_check_other() that this address space shall always be
> > mapped as encrypted as historically it is memory resident data, not MMIO
> > with side-effects.
> > 
> > Cc: <x86@kernel.org>
> > Cc: Vishal Annapurve <vannapurve@google.com>
> > Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> > Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> > Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
> > Tested-by: Nikolay Borisov <nik.borisov@suse.com>
> > Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> > ---
> >   arch/x86/mm/ioremap.c |    4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > index 42c90b420773..9e81286a631e 100644
> > --- a/arch/x86/mm/ioremap.c
> > +++ b/arch/x86/mm/ioremap.c
> > @@ -122,6 +122,10 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
> >   		return;
> >   	}
> >   
> > +	/* Ensure BIOS data (see devmem_is_allowed()) is consistently mapped */
> > +	if (PHYS_PFN(addr) < 256)
> > +		desc->flags |= IORES_MAP_ENCRYPTED;
> 
> Side question: Is it guaranteed that this region will be mapped with 4k 
> pages and not some larger size? I.e should the 256 constant be dependent 
> on the current page size?

True, if in some future kernel PAGE_SHIFT changes for x86 then both
devmem and this code would be confused.

I will submit a follow-on patch to clean that up.

That said, I expect PAGE_SHIFT != 12 breaks many other places besides
this in x86. I wrote it this way just for symmetry with
devmem_is_allowed().

