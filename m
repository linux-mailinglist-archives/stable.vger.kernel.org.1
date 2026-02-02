Return-Path: <stable+bounces-213129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBUyAyI4gWmUEwMAu9opvQ
	(envelope-from <stable+bounces-213129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 00:49:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55256D2BF9
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 00:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FAE230166FC
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B2435E544;
	Mon,  2 Feb 2026 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwybXUBb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DC18A6A7;
	Mon,  2 Feb 2026 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076180; cv=fail; b=IvP63ggk3wyB7okeDg4/RMMj9zXsA5whtEKGkA8Itp9uYLOUm6XBg9zAlo2aVikiq+/E6su3kTEJS6yAgaanCUo70T7l85S/MfVIz0wzYesiZ+9Op9CdU1GI15lhKFoX2fsSdsO2kvxORpcct0oS91dRjqdFLeieWc0r6+t4Ws4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076180; c=relaxed/simple;
	bh=O4+5X6FVztjtJYzCOC+kFhj13O0OByyfKNXs0wHtyLA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nK4Uv2Cc5RmX8JLRB3qvwSzF4bCtJWTuJDMWOuNYwrGSaHfmrWg4+ngM2eqWa+8cR17C8kCxzmd/pcYLkfh2SfTuIfGfCloKoE7wpXL00dL9M9wpT/HGqCtIiZqdcAPhIpKrbSAEK66q+PzIsgnE00I9aBDM7IcmInO/BfPkWrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwybXUBb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770076180; x=1801612180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O4+5X6FVztjtJYzCOC+kFhj13O0OByyfKNXs0wHtyLA=;
  b=EwybXUBboKZqkTXGaLnhJt7m+6yjgfBJ4+KUhRPjrzNWPWtEjGMYU3q/
   HT9RPm81c1DH1uNHWioGNrtj+2Bb6pLB8HvuYQIl8fM5joBa+D3mbwKg6
   r3jAg6Dzvy8tCXzzLMfNU6ov0o0DGE/nH3wt2onU51gt+zQVlRz1qN6K2
   a+pHq1eZ+A/8LC5T8jL2cutHXZf0Cn9fw1QpCuIUGWsht4Kcsg98N4DCI
   QRuPrYjfrEyvx7ApiwoeDe6fQx2hJ/RAhK4LLUOcmGPoTdrH8QFQB8jaW
   ANI8NTi0N/dvw6JpBGuQy3K1/99cx48jrBAnsxWGzwDCxDIAj9pZjMm/O
   A==;
X-CSE-ConnectionGUID: otNZvTYUTdec6LuMU9y2fw==
X-CSE-MsgGUID: dfyjrbclSzCAwImdOA3nuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="74866278"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="74866278"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 15:49:39 -0800
X-CSE-ConnectionGUID: inLSACwbQKepDt/wL8xpZw==
X-CSE-MsgGUID: IQ7BJ1bPTg692vYhGTpQAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="214149485"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 15:49:38 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 15:49:37 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 15:49:37 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 15:49:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7Tq+A8qQBG56myLhURrOmV76+TbEjmAdjVBfptx7xHUqMocdSD0oQIrxpdyIZCrqsEZH2QvwBhoIPN1cWOoGL2lQBj8RRcwcn99FrZC9L2wy8dRjD2cuQBkdle+i595kxuW0sH48c3N03YxzBRmXRBvr1ATXwhLPafIJKixAQkCYTRkYSBg89/Qmf6yRxdy+Yi/57xOFQoIi2oYfmxN3Vq0ivyOZctin2M1U63qJph7QQCFoejv0STb1c9iwnq6Z9Q55BPfG//I7xf60XLGaassy9BYigAjFzE76k1y0sR0nOfm3NAxw0TwQTQ0wZow9RVAVNNim7flL3wLxWFz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttbMKg0QNuQ3WamOVfgbf53cn7R//N0eRXqJDL1qVys=;
 b=TUgaVOveT7NCD3RIdkkXT0v/ry+BwiGVbCFzwMmalyhCSwPkxzNXw5FgfGvfs5Z0IaJ+T0BbSkVgLXFrwwFDUpF5Z9iAcfApsIr44UDQwkns/q5f3BS5OGZTl648/jDR2MiqB548QDO7IiyzZbtF//8WXuwP/3z7jEOH1ClFRXoiA8ukItlPpC7JWQpmgX2KYyOiIwD0P3dOew4PBUqJUHiwRH5hSOUjqZWAtumT0tb2aCElkACzZH8Vz1sFuXjYlfZot81LoqHwD+wa9CHBgvZul3AHvJB0lpxhqpGAc8hE4jos9KAgCrVLJMAPUrOdX9Nq7vBolfmTdSy+Ue2ZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA3PR11MB9302.namprd11.prod.outlook.com (2603:10b6:208:579::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 23:49:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9564.010; Mon, 2 Feb 2026
 23:49:34 +0000
Message-ID: <9e61174d-f4df-4588-b105-e0c791181917@intel.com>
Date: Mon, 2 Feb 2026 15:49:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: sleep instead of busy wait for BMC
To: Jocelyn Falempe <jfalempe@redhat.com>, Thomas Zimmermann
	<tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>
CC: Pasi Vaananen <pvaanane@redhat.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260128-jk-mgag200-fix-bad-udelay-v1-1-db02e04c343d@intel.com>
 <338ff7cf-1c7d-48da-b1b8-37aac440fed0@suse.de>
 <88f33e4e-5d0e-4520-a399-5be2901a3281@intel.com>
 <27af79a8-ee84-4845-a737-82d3883536e7@redhat.com>
 <8d238204-b0f6-48a7-9afc-480097c32a23@suse.de>
 <770785c9-266b-4ebb-a0a1-f5e615e45855@redhat.com>
 <4272ae94-902e-40dc-86ce-62b642fa9656@suse.de>
 <85edc1c4-1985-48d0-9ece-50a5c70e1752@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <85edc1c4-1985-48d0-9ece-50a5c70e1752@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0381.namprd04.prod.outlook.com
 (2603:10b6:303:81::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA3PR11MB9302:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fcffe9-0a4f-4dee-5a20-08de62b5b7cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTZqMmdNNURHTXNVTVcrdXp6cFRCN2NaZ0hMYU94KzVhZkFQZEFDZ0cycHRt?=
 =?utf-8?B?SW5raHNPeUJvSlRsS0hGVG1sdXF1N1lRYVVrZkJGRFRBUDJKUTJrb2ZLYWlC?=
 =?utf-8?B?YW1yUVdlcHZCU1dPK0dKMXVNby9Jd3JFZzFERkRHdW9pSDJ0ZmZQK044OCs4?=
 =?utf-8?B?eDFPNjJZR2FVYitUMTJuVmFnSGRMWHhFcEFTSDMvQUVmQ3Qwc3dYZVJpMXU1?=
 =?utf-8?B?NlY4ekpRaGxLM0svNzRYVmpsN1dzQ0IrZ1M4MXh4ZUo5aU9SSEZjZzhHSGdR?=
 =?utf-8?B?WVNHL0Vsb0N3Yml4bHZueStwMnp3cnp4VWRBZWE2MUFCWTVWeXk2VWY4aEpn?=
 =?utf-8?B?V2FyTHk0dC8veVppbDl1S2lsVnJreGhyT0RHWlVwMXIzdVJqUEJOdXNHdjFZ?=
 =?utf-8?B?akxIUWJqb29LOWp0RlJhMTBRaWZrbThEUXVKeEswK05UQlppZUZYL3ppNWZu?=
 =?utf-8?B?RmFMUmJ5NThXY3ZBcHIvU2xjVlVFcytZS3FlTS84Rk5EbXNkaUlvRExFekdz?=
 =?utf-8?B?WEh3Ri85UWg1d2k4QlIrQ25lSXk1dk1uL253MzBsV3hyRkxDOTFGWWttK2JR?=
 =?utf-8?B?NWdzRDFMb3gxeEUrUVRwakdYeUV6M0gvSk40OTVFaWcvWTdMTjhqSERWSDNB?=
 =?utf-8?B?U1ZGRTcxL29GRG01NGJLeDdFYkMzVUdIampRaEY3eVAzeC9Rb3VURXEvQmUw?=
 =?utf-8?B?KzhiSjZiZkE1aWhwbkE4djNKVVcrYVlRdU1kTjl6ZnZvajM4YzZYY2F2Sm1V?=
 =?utf-8?B?UkQzeHl6S0hDRDZVYzJscmZLaURoMGhxRlBXdUdLc01Ka1VSYXYvVnUzMVFk?=
 =?utf-8?B?L0NtNkFIWFhGWk01UG9hRXRYSVptQmJOeDE5OXJwSytCK1NzdmtoMXBuVko2?=
 =?utf-8?B?bmVrdGxkYk9JZUhGZkR0MDMwRWhnd2hKZllGelkrbGR0SzcwdmVqRzQxdlVF?=
 =?utf-8?B?d2J0U1BVMitnQmdwcHRBV3hxZnphaVhHaGNibzZicTdFQ3lFVzhCZ1YyV00w?=
 =?utf-8?B?R3pIVHdjZm41Szk0OEVseHJXZngxdlpuSmxKcHJwZXJRd0YzeGY3UzJEdThG?=
 =?utf-8?B?ejVYV0FPK2wwT00zUThSSTdZZXBpTlVvTFdaU1c1bGp5RnJhams3Q0doWTVh?=
 =?utf-8?B?T01kZ1BydU5zK2lmNkc3UjZaNGlhMzN2WUIvL29yaUVHbGdYZUI5N28vNVI5?=
 =?utf-8?B?RGlRK2FMZXVTdVVYVWE0SGkwdURKM3M3SnZMZU9WOWZsNWhvY0FYNmNpajJL?=
 =?utf-8?B?VXk4RTZ3cHEraS9RZ1RqL1dEZDVnY2w1ZnZ5VzJDSmVwTUVFK2dTWXBjcHpO?=
 =?utf-8?B?blhud3FRbkgzc05vbGtOWmo1ZjcwdnJ3c2c2WlJDL2RTbWIvVlQwUk9iYy9I?=
 =?utf-8?B?dXRwRTAydno0Rm9BZFZOV01oMk5FYW9mRFFITUJnd3B3R0MvdWFlbGU1WTVT?=
 =?utf-8?B?M3hnUjFGamlpanZRNlB3ek0vTGZUbWlYc0I1cTNZQVdWUm9NRlNyVkhQVEtj?=
 =?utf-8?B?L3dORW1TNkhCUEZSMXY2WmQ4MEJrdVEwSjN3c3BYRnRCUTRoN2pIbmlYNkp2?=
 =?utf-8?B?MjB3U21EbEtmcHpLS3ZuZEVmUGt5a1dnMnJDOTZsVWhWOC82TkxBcm40ZmtR?=
 =?utf-8?B?N3ZqVExac3BXc0ZHRU93UG54dVVGdnBUY0dObTk3ZGJ5NUt4RlhsZ0h2bGFs?=
 =?utf-8?B?bjcrOGlzMTRDRitLSkpMcTV3WUlHajdWcGV5aEppdmVuZEkwTUhtNDJRVTRD?=
 =?utf-8?B?VmE0ekRLcy93L2QycVlsSWVzYTdncHRZWWtvNzgrWFJXeHI4VCt5YXBMb05U?=
 =?utf-8?B?ZnFLWGhLekpLUXNPdGg1ajFCTjVaVDBiemJESlRxMXVwRFB3Yzh4VHBvbURD?=
 =?utf-8?B?N25RNXRaeTBkbGJoNXBsL0hhazZOL2FTdE1lcWNzNGVTa1pjY1d4d1hZbjNa?=
 =?utf-8?B?Y2NrWDBjWHNvS0JsQkRtamFnM05kQUs0SEdQQmpTcHNudm9XQm93S2RnVUk5?=
 =?utf-8?B?dWkrTjZIRTY2WDVDUlMzTjZZVDVkK2UxVkFYZjVPcXluWWNMb2FmOGRsd3Jx?=
 =?utf-8?B?NG5tNnNGam9XTHZ3dVNnZmlacjZ1NlFoVVc5K2Vyd2NiRzkrYmhCM3J4Nm5Q?=
 =?utf-8?Q?cDcU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0NHT0dJMlFZQUEyRzFIL2pIUHo4dTF4dWVwUE5HTEttQ1dzS3ZsQm13UExj?=
 =?utf-8?B?Nk1iOVRoMjZDZzFKbkpzaTJtVE4xcktNcER1cFVHV1RvVHBlMzc2QkRrWHpm?=
 =?utf-8?B?WmFaSzBkUk16VmkxU2RHa0VtUkZJZmRqOFlzdFJLTnBPTVFmaWprbUIwKzFI?=
 =?utf-8?B?akpXRDN2ZklKang4WVBtaTJMSFRDZFU3eHZnQ1pzT3VkbGJjVjFVVVBrTnR2?=
 =?utf-8?B?U0xCemVkUTk0eGZkK0lQUFNmQUpvdVlPd0VkSFJ4anBjOWJJcjI4eHNKcHZI?=
 =?utf-8?B?OHlIZ01nejVLNGgzc2hITGVCLytnWHkxaDBRMk9TRHEwQUpSdDJZcERvWEgv?=
 =?utf-8?B?QlV6WW1kWGZsZG01cmo3ZWtjZ1FZZHdmMmMrNGR4V2RkL2luNzBEaGJWNFVi?=
 =?utf-8?B?dU1HaHpJSlNOcWF5d1RoajRLcC9BVzBOMzgxRGptc1lQRXVGZCtVYTdsR1g3?=
 =?utf-8?B?anVuQmx5QkoraTF4bjJxM21VTGU5a2Y2Ykt0dk9wVC8zazBnRU1TMzhzeEli?=
 =?utf-8?B?NU9XeENQOXpUa2dlRkZnYmwxamR6R2lIOERVeFBoM01IV3lhTlVDTEM2bVpP?=
 =?utf-8?B?dDliMEQrajFSUU9qUCtKY2JzeDgvK1EzMG9kcFBNRDlGd1BxcWkvU1NIeHBG?=
 =?utf-8?B?NnBMUlgzNXNuYlVsR2VnY25mcUYvSWJVM3pNMkE5bWlmNjhyeVBnZEh0TWVP?=
 =?utf-8?B?cUtRSmtBYlJ4L1hLNmNDZzZib0ozTFVYNzVaTHpiUTAvQ1RjaWlTVVFKREdt?=
 =?utf-8?B?c0lwTGp1N1hBQ01WZGUrU05VNkNxa3hMNksvL0tpVWlYUmhvSVduQlAyOE1k?=
 =?utf-8?B?K1JjRHBQOUJuK2lOODNDY1ozYkd0VmxOaEZqcTVjbjdUY2V1cEsxQTB0UWZX?=
 =?utf-8?B?d0dCQmFNeEdFMXdUY0c0eHNSWDRzUmJHa3ZFWGRkQi9Qa0JRRSt5bzhTRlk0?=
 =?utf-8?B?c3BETW1pMzdMNnVZYmNTZUVDUG96OUJreXFtWmoxK2xzMUdKekR4dm0vWTly?=
 =?utf-8?B?N3ZEZlhhdmF6dlB4VUJpNGN4TXpvclZHanhDTGdoQkxVTkljK2tKeGIrVWc0?=
 =?utf-8?B?NWpaQ1haQVRUSGlqWnBndXhPK3RROFovampMcGpRMGphbkNxU3BuVVlZb00x?=
 =?utf-8?B?QThyZTZyUEE0cWRjZ3VXbTFDM1lWbmg2b05DUUVXY2s2d0Z5cGM1NXo0R1Ez?=
 =?utf-8?B?RFM1dHRGZWIzTVowcG1VMVp5MGx6cVpSZzV6TGM1M2J2M3AwMlRKa1JMRXdZ?=
 =?utf-8?B?ZVVCTTVhZ1JFVzI2Y0pZV25DU2xJa2VyMzAvY1QxVktHakhqZStaOW04dS84?=
 =?utf-8?B?dHc3dDIvU3E3ZTQvcjZZbmRVN2NQNUhYT0pFRmJoTzhLbTEzMkpMbytGcFZn?=
 =?utf-8?B?N1hRd3VzN1ZsbzJvRWIzblMwM20wbTVLZDFwOG51TmQ5d2tyVkpSM1puMUth?=
 =?utf-8?B?dFBjRTNObGVwY3gyNHZlckdCNGxEYVp6WXdyZ0xHZnZCaTRHaWQxakdPTmc0?=
 =?utf-8?B?WGlobVUrdTZOaXhqOGxmbjR2VWh1S1RxellhaW5HNWU1enQrN2ZmM3FvQUtT?=
 =?utf-8?B?bGVNbk1nQjNsU1FoRk9IZ3BlSDg4cEV1d1V4NzdrbURya3Z4dlBJSm9Zbmkz?=
 =?utf-8?B?ZVV2QUNDZXV4MURESmo5bEY4b3oza2pZK0tLYlZvTEVaNjMxczNFdWJPcDBI?=
 =?utf-8?B?b2N3SVdwaXZKN3JkcDNVYW5OVytOQ0VELzZUM213d3N4TTNjUFVrbC81UEVS?=
 =?utf-8?B?dkUxbVkyZ1QyQWF3ejBENkdyTTQwb0Npd1hzN0toYlRySHEvK1pSODR2b1dT?=
 =?utf-8?B?UUZtajRUWjY4RHhxcWNwNjNQMGtodDdVUldHUmhhVUs4aFJsMkR1RjFneHpW?=
 =?utf-8?B?NE44eE5uQjVDcGd4ZUZRL1JZWHZ5WDV6ME5QWnFZNkxpQkd6bS9tU2JhMUlj?=
 =?utf-8?B?SHh0bWQ0RDd3ZnVXZWs0WW4yQ2dwWE9rWE15ZDRjN2hSZUNmZU5yMmpJQ0hS?=
 =?utf-8?B?RU5BM05ZRFA0Z3c0YW43NXZ4OWdzS1FhdEZhdE15K0xwMjVPczc3UXBsYkxT?=
 =?utf-8?B?akh1M1ZvKzl0V055NC8xWXdFa3RUb3BWV3FsKzU3dGZyT3hoVlduUHVXNnpt?=
 =?utf-8?B?dzhtY2g1azd3MjFaT2o3MTRkVkFNcDA0bG1mQlRQSzVvNjBxTm4rNGNWMmt2?=
 =?utf-8?B?M3MxaFVvVUllNjJtajkrcVhJaG9XeDc2UDU1K2RFNU5nY2FFSE1Jd0MweEdL?=
 =?utf-8?B?VmQ0bEViS20vM2k4L1QxUFI5TnNVUjNOZDVwOE84b3JQV2xnRThDeFIxQmRE?=
 =?utf-8?B?S3RnZmtzMWJ5NjlQN24rYnR6UDdYNjhPbEk2UzFWVkgrUllzUytndz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fcffe9-0a4f-4dee-5a20-08de62b5b7cb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 23:49:34.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qor8O0c3C2tUagUFZuyu0Dm2cZLvbQCLgPxIB0JQC/WQNh0gDw8U1yX8CEum/cGaiz4Jv6P8nVHhnlAfim57TT4qRDDNUhrbKjYFVLM+5zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9302
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213129-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 55256D2BF9
X-Rspamd-Action: no action



On 1/30/2026 6:22 AM, Jocelyn Falempe wrote:
> On 30/01/2026 15:03, Thomas Zimmermann wrote:
>> This is roughly the time that the CRTC spends in each scanline's blank 
>> area and likely the upper bound for the duration of a single polling 
>> with that display mode. Otherwise, we might miss the blank.
>>
>> Honestly, I'd just take the proposed patch as it is and not bother any 
>> further. I think this is the correct fix unless we can figure out the 
>> exact meaning of these bits and the BMC.
> 
> I'm fine with that too. At least on my machine, this waits for a random 
> amount of time, and that looks to work.

Sounds good. I'll send a v2 with an updated description to explain the 
changes to the condition logic and better explaining the problem as a whole.

That should be out later today.

Thanks everyone!

-Jake

