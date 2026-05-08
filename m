Return-Path: <stable+bounces-244840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPmhICVl/mmoqAAAu9opvQ
	(envelope-from <stable+bounces-244840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:35:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9724FC636
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15C6300CBF3
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 22:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F4339705;
	Fri,  8 May 2026 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjqVYuTa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DE27057D;
	Fri,  8 May 2026 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778279674; cv=fail; b=B2FKE/feD8WRohryvHDu3z7enu3YRPUKpZjMmzM0vGgC2pLiQLUU0AcK/0QGIOGmbR+8bm9fVF+v1GvvQJWJj1a06BjJESiu9UXRhyvitCm5x0Z85lxYUzdMUjHchykKWdsTZ0O+ysXny3Kq2ZFCNJKhQaiZ2wbZ7YtJgF0R+K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778279674; c=relaxed/simple;
	bh=knQwe5Xw0Tp6fOgHWl28GmdmIA3W24lrw0EIflyvs1U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KxgLCrDIJMTa3ofEj8G5vhvZ1UYbIuUl7+oUvw1CbUhX+RsE3m5z6qQ5VrYNi7wNfbBc0YulCn+CiHn1aF+sL+CIX08M907nUd5va7iSYRaSEo8/xpMHphIZ98jI0CjKzqzpPFDGfMtzEewDqdcYkMu7AfzzrvkK3hi3XIzfxrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjqVYuTa; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778279672; x=1809815672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=knQwe5Xw0Tp6fOgHWl28GmdmIA3W24lrw0EIflyvs1U=;
  b=kjqVYuTalhgriK8oMGLhNUxOSXHe3tIYrQBU2PUQ156XHnHkaKf692Rq
   e0iX2CzR1li4m4DIrZ0Sf4H7kNJGAATgu4pfnFUU7Xp8SB3uWhAG2akwP
   l442B6Te4ZuBKzxUVuUWhDf17vOaVO8xWXtkPaztSrx3HyhroyoIwhjK9
   erCsKZ9Vl+aLsrlFfDLxOgoSAl0jQVii50USSR5KWJLJYOWLgctFGeiNd
   pNicHvI9gNVjun6ygXGUZOEN7EX6cJMGQHY5+WCMhx6nL49sjZKNpd39r
   PnONJoBooBaVJuKDjiqZCiWi/dNRwy+SHnyS1I+oRt96nl6snANDtbFW/
   g==;
X-CSE-ConnectionGUID: vQQWuzljT2mXokRRgb7P8Q==
X-CSE-MsgGUID: 1c5L2QAJQrWH0iKEJy7rTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="78398426"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="78398426"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 15:34:31 -0700
X-CSE-ConnectionGUID: 8g9BVSjdQyWZMar6rgm2bw==
X-CSE-MsgGUID: VFdVTJQDSAOFmZ1a7cY0Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="241842207"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 15:34:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 15:34:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 15:34:31 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 15:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp+pGxucsSZtgBP2lN1kXAlc5FWEMJde61ku6GJatGKwVaYS+xh9Ea/k12MTmpPTCczU78zuQadq9m3XcGuH5+2m21ndktkkbz3FoeFga8bZi7gg37Kb4FDN5vv8wYpWVtdueNjAiGgWHerCwYmSKthM3G2vJNbmtittpzxn53zxWcn1OCcb1GzkBbBzjx1X1FfQqSFWgYa+HXmuo2vBLkTgja+X3U9BqjcMBc2cqMfaw3fq30Nc4jno2wsTlirnxjvJMgRQDkc5V/3WVnf3sY+c9XXwZ0OtpqUQ69oLkqGqeZBCUuirh3pb4G52aqrf044vcene3QwzF5u35KXc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NO1uP6S21JNI2yd7ZDkVKwR6D550xTIjQZew5U4cKU=;
 b=gALtvPx2cmJ83l2GA+SDFBgsPeIVpYSHznsRfx10xu42UBwn7WOL+USP2aFH1tDoSp9Qvm5FRks2HZHfDZ1A8I6wez65GEBLBAoihfbdcceILz4n5+SRCGV98q+XNIertEfngBiW6+t1NDxGLHmaj/75XVM/x5c2RM/7ifzvKbEHa6u3Jzh04cAYEfPSw9k7dkE4Gtj6i2WqP5m6cKakxkusxbWcTMs4QTiQaJQXRFl6sREtH950TjweFW0Gm1dnqtthY/cG3OryPM8w2yQVtZEFqERWuTpSL9zQlyBEomilGo50zY0M7V5X7UKzoLeuWIQlNVIx6AmnTdad6Pe/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by DS0PR11MB8740.namprd11.prod.outlook.com (2603:10b6:8:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 22:34:25 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 22:34:25 +0000
Message-ID: <a2c831d2-6825-4eed-a494-6e254d451667@intel.com>
Date: Fri, 8 May 2026 15:34:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ice: fix packet corruption due to extraneous page
 flip
To: John Ousterhout <ouster@cs.stanford.edu>
CC: <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260507183843.1457-1-ouster@cs.stanford.edu>
 <379cd3dc-aff5-4fcd-bf9f-4878ae21ee74@intel.com>
 <CAGXJAmzqBQha+XRu12ZpLTDBSMgAEANffD2uGKZ+VVdkMk6OVA@mail.gmail.com>
 <3de05bb6-2cae-470f-8b8d-8ada1cd0a0f4@intel.com>
 <CAGXJAmxKw-85-=0CX=s33CbfUmJA32=oqpDM=SeV5ZLi04fCOg@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAGXJAmxKw-85-=0CX=s33CbfUmJA32=oqpDM=SeV5ZLi04fCOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|DS0PR11MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: e80f6b24-ccbd-436f-0daf-08dead51f500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: CotewVsewjq3iq2ssuuB8flOir54vJjPXQRUbETIiPbfzwkNk+25PJFZZASgHrzWS+IUmlHAa91bwYicXFj711SKJw4acH0VfqVGS+k15dwCp3g7IPzEDruxq5nlPZXKQaUDpujXhylrKWRSwgDDrqaBTDzJDlauBbydXuu7WWJ//5fFfKXFcrTwfEUJMx51mF5ye0Dx5wj89n04rBvDhAYsXi76XmyfFwQOFwW0FulyAk3Jp4cjrth7NS7P4RbaQMcM0nAnjBndoX0HVGMGegUOpIrxT6NlbS0SFZbxIAEco3yBdnE6wqyVf5S36maLDwKeUvSK156297Fbzfx7qK98BdJm1O4rGlwpMdPCAY21RU8WPbd7vTa51e4Obawci1He1jWNFeKCb8P1nZeGEiQBszW5co7StN9npk+js9KBIKy0mya2+k/XrJUcKBMkV8JSG7oWWz78E5uhZgNStsGc8aTWuf8KmmCLrHAZIFuXR87WfDWaTQyhg3JiA5lPU5z/R2oLwrxxhWr/Eyw3eXLkD3G0RczKLTrhGoX8Ol7pVSlErUfhPmQXoAUWLWvtDwjqGbOhUt60qbxfx3koQPt5qVGCeP1TNMw+aI05tsQcPVYjOMtf4DOBYmFe6P3xZeonPJ07Ejx4P5LH5fcRL9XtR4OmJu82fvbdPmL9WRmqv/sBMfpIjXwbGndYLsAP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlNMk9MbldUWlM1MVh4MFQ0NUdMdWZzRnBhR3h5S1IxNHQxeGFnQ0tDUUds?=
 =?utf-8?B?Sm9LekI3dFloVnBBL0FtVFhDc0NVRDd4ZEt6NXRVMVdFL2xsOVlGNHFCenFw?=
 =?utf-8?B?MGZteW1kazRHVlE2UlV2MTRiL3NBa003RVYxa3d3UlhVK2FVSjdHckFnRVRw?=
 =?utf-8?B?cnk2ZDRwcnhNdURMTVNpdVorS3dwRUFGeVZqTktSa2VZM3k2VE9WNWovNjAw?=
 =?utf-8?B?TEZqcTJUVjlqVWpqeGxDdWY5N1Jwc3YwUUpDekFNb2kvTnVZNHl3OFFidzg2?=
 =?utf-8?B?VmlKK2o1WWlrVUVUaGNDeGlybUg2M3diWlI4TXRCRnJVRDJzVUJZN2RPMlNX?=
 =?utf-8?B?V3k4NDZUdDhKdEZQNFJvWmtUU3Y2TTJ1bjh6QXZMTEczRGRTZnFmejRFNGdv?=
 =?utf-8?B?YzVYN3lPd2MzTjAwQkJ1WnpRcDcxRXNJSmJRbU9BWjg3UmVWMTVjaTdlY3NH?=
 =?utf-8?B?ZWFCaFJLRnJEM3hranAvRklPWWZRK2Z1YTRvdkt3aXRQcjBPRStUSlp3emdo?=
 =?utf-8?B?SU5SVThnSWdZMG81cUxuazQxcndSVFNUQktvS0NIQ21mVUp6TTNyd1NmcERT?=
 =?utf-8?B?UmJSZDE5NnlzcEpzcEhzd2Vvd3Bibm1LdnhWTjNrZGs2NGNoc1owMVdwc1dB?=
 =?utf-8?B?clBhQVZIS2pORWRIVnR1ckg2dkpHMVhiUFNkZE1JeHo4SXJ6ZkJsQnRRTkdD?=
 =?utf-8?B?TWFCOTV5MWhBZWRScUE0UlJjZ2dQcElMZ1E4QWJVRVJ2Kyt2a2J2UXR5SWZL?=
 =?utf-8?B?aDlYTEZaTkxmSlNBZG1lTXZsTFRHaXNZQW5NYTlrQ3BoeTkrREpKSElNRXN2?=
 =?utf-8?B?eWppYi9wbERHZE5hTWZTZzdaZEtEQzVqV2RCTnN4UjQxYkRxaDFxb21pM2xQ?=
 =?utf-8?B?WkhqMlN0ZXFISURtSmpCTFU1clN5SEZ4NWRWd3pnRkZPa2RHNWliRUszSnZm?=
 =?utf-8?B?UURlWUdzUWUrOEZLQ3VWMVBmYytSRmtaK04wcjU3K2xOUnpvVkFENFJkTVlm?=
 =?utf-8?B?SlEzL3VIQVM5aHBjeFBQbHlyV2Z2TWl5YTVici93WTM5UGlaSVppcXpSMkFW?=
 =?utf-8?B?Qm1PdWxTcHRQSUVKd0JMc1N5Ymgxb2tROGMvc3R5eXE1OWZuZXVvZjZtMmZt?=
 =?utf-8?B?aEJYbHo0S0dYK2pMQkhKTmhBWGZHZStsNkVVQlNRb093YzVkWmtxWDNIMm1m?=
 =?utf-8?B?aWFLRlVMUGIwNU1vZDlVOGRjU01zeVhjeUpLZGZjWGZnMHpTa3VQVld5dVRK?=
 =?utf-8?B?QWRENTVOdmhMTTZJUkFwUU0rVWRjK2pyNjVTemJBeEcyaG1kZHZ5OWV4ai80?=
 =?utf-8?B?Z3VhbHpoUXBZUnlNaVg2aUUvTDVROE1GaUJpa2o5YkhJTEFjcU5reXl2a21E?=
 =?utf-8?B?Z2k5S085eUtaTWxnVEU3Q1JPRXhvbm9mekdxdEMwKyt4aGVobThyY3ZWQjZW?=
 =?utf-8?B?WnB1d3RSNXhsK0YvT0cvak5KN3czc3NWMDhCRUh3VGJWb3g3UmxHbDZrTTJs?=
 =?utf-8?B?TGxHSEVLT2lZVGgwc3g1eVNlRVFHc2pCMkRhR2FYRkRtaXNXYW5lMnExekpZ?=
 =?utf-8?B?WXN4dXNRTGh4V2xpQ3kzY2YvVDc0a3d1N2c0dHhJOTY0NHVEaVpPZ0s4Sko3?=
 =?utf-8?B?U2ZHd1U3bUlxdFhGVFdyQXkycDFiSFdMeCtRR3l0OVlmQlAyV1V1bnhLTGhq?=
 =?utf-8?B?WEh3RFhPWG1VOVA4ZWJGRHhNc2h3alFzZGNxRzJvWXdnKzRKVXQzQ2ljaVhK?=
 =?utf-8?B?WkZPTW1yYTF6MHhtNmFSOFN4RXluTFViaXFyeGRtRGJtdmZuWXZuSEphV2sr?=
 =?utf-8?B?TDRQR1ZDdHpYbmw2a3gxdG84Z2kwZ3pubm5Nd0ljMmRzU09lVGlkMEdUTHVG?=
 =?utf-8?B?MHBFK0hVSkNnTnVCbWFzZW94ZTZiaUIwb2dHb1M4Mmw0UnEvVzIvbnExVWx5?=
 =?utf-8?B?cndxc3FWWUZ3M09ybjNkSVBsakREUjloQTJKdkVycUpsVmxwZFlUTnJ2OGkx?=
 =?utf-8?B?czNjc0Y1d1p0Wml5NnlVOHh4Y2F2cmg5WFNsMWNEOEQ3bnZlRUdQUTYyc0Zl?=
 =?utf-8?B?Qy85Rm9VU2xmcHJtbXMvRHhaSy9EVlhDUFZYY0Vleml2YjNyWCt4aWNJeFRB?=
 =?utf-8?B?TCtoSWNhV0pna1N1c1dlREptTE1jejJJL1NQNjIrK1B5Q2FxMklWNjNSTS8w?=
 =?utf-8?B?TXpPQWx2QVl0ZU1yOWxzcEVPaEVwWkdLMFM3eXNEcVVReVVkMkhMUGJmSytL?=
 =?utf-8?B?UmFCMGFPK0Z4WUJiTWJ5aG5MSTVVM2NySVZuei9hb2N0Ymg3eWJxdmFQUzVF?=
 =?utf-8?B?c3NyS2M1c3cwZkF1bzVPTmRyQWhqMnNFVjVwQ09CRzkvVkptUEhmQT09?=
X-Exchange-RoutingPolicyChecked: udShiXBS5rAxZ4qiQ+JdhAzZM3rEEbrPPgqlOqIZf2cIb7adr6WJbTyFyTzHpwmXGk+NEHgqenQYBm9pDZHCflmGo68Y7xcqf0+cnVuAPAc7jQCKxEROGvETVxj2xtZoFKZBnV13ZQwTCS9vhWcq3TiY2QZT4Nh82zxcKgFg15u34oawXRnrb1RK7b0HFbbPL0gc1qa6D3lojfPcV3vD2aelcaZWbvVsSXm3PNCb/VV0rqIxbfA5GL+Yx5LRu9krwsCmllMYrEwyY+XMxu3lVo7zqa4Gqdpwwi84hkOa59mi2hyFbVYKG4G2CAgQnQOtM0IAzXr5vaV7q8Voikc/7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e80f6b24-ccbd-436f-0daf-08dead51f500
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 22:34:25.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luiAHtMKbYxm9fj7m2SgsV1xOrtHMcc9NngTBOWOvLL9sv4v6oFnWb/04tVqlohYarhLmskyTv5DIkFUTn4DvS1sp/zg9KAeUJmU9z8xKvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8740
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 2D9724FC636
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
	TAGGED_FROM(0.00)[bounces-244840-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/8/2026 2:59 PM, John Ousterhout wrote:
> On Fri, May 8, 2026 at 2:55 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>> On 5/7/2026 7:37 PM, John Ousterhout wrote:
>>> Correct: this patch only applies to the ice driver before its conversion.
>>>
>>> The patch applies to versions 6.18.27 and 6.12.86. I believe the bug
>>> may also be present in 6.6.137, but the code has a slightly different
>>> structure there (the function ice_put_rx_mbuf doesn't yet exist in
>>> that version) so the patch would need to be reworked a bit.
>>>
>>> This situation isn't all that rare. It isn't a zero-length packet that
>>> triggers it; it seems to happen if a packet uses every available byte
>>> in a buffer, ending precisely at the end of the buffer. When this
>>> happens, the NIC seems to generate an extra zero-length "buffer". This
>>> happens quite frequently (thousands of times per second in some of my
>>> workloads).
>>>
>>> What keeps corruption from happening constantly is that there is only
>>> a problem if the "other half" of the buffer page is still active when
>>> the 0-length buffer is received from the NIC. I suspect that with TCP
>>> this is pretty unlikely: packet buffers get recycled quickly. If the
>>> other half is not in use, then it doesn't matter whether the page gets
>>> "flipped" while processing the 0-length buffer. I ran into this
>>> problem because I was testing Homa under conditions that caused some
>>> packet buffers to stay alive for longer periods of time.
>>>
>>> -John-
>> Right. So I think we need to make sure the patch is cc'd to stable.
>> Technically it doesn't strictly follow any of the 3 rules, but its
>> closest to 3 with a clarification that there is no upstream equivalent
>> due to the libeth Rx refactor.
> 
> It looks like messages on this chain have been cc-ed to stable since
> your first message. Is that sufficient, or do I need to resubmit (e.g.
> v3) with stable in the cc list?
> 
> -John-

I had added cc to stable to get some visibility, but I suspect that it
won't show up to the stable maintainers without being sent fully as a
patch that can be picked up by patchwork etc. Thus....

Its probably best to send a version to stable along with a comment about
why you can't list an upstream commit id following the guidelines from
Documentation/process/stable-rules.rst specifically the "option 3" rule,
since we can't apply this fix to any main tree, and there is no
equivalent commit already to backport.

Its a bit unorthodox but I can't see any other solution. It is also
important to be extremely clear in the commit to explain why it deviates
from the upstream (which was fixed accidentally by libeth refactor and
pagepool conversion) as to why we need a separate commit is necessary.

For now I would just target the kernels that the patch easily applies
on. Fixing some is better than fixing none. For the 6.6.x series, I can
try to poke someone from Intel to see if we can get something tested.

Thanks,
Jake

