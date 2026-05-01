Return-Path: <stable+bounces-242497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ9XFa379GnFGwIAu9opvQ
	(envelope-from <stable+bounces-242497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:14:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E1D4AF158
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380FE3022F97
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697B3DD50F;
	Fri,  1 May 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEilBgIY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F402DEA90;
	Fri,  1 May 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662797; cv=fail; b=nd80JoTJGUnXIAJjjhV2pDyTk+jktgCkaKcpqjP9ldj3JfB4qk0lwJemqFa64nNtl4T4+WO5wOpeMPMc2/tk1+7pXCCAr6JqLQKEM52Jeo/HktKa1+IMvYtZuEHnpHB0ihuckR9XCT3CLJtRMLq5ZemPvGvYi1uPZSiP711pKu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662797; c=relaxed/simple;
	bh=GmRaA7BLAgD8YRkSw/hpsoffVytNmz2lQ8z+scnwfB8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Etpa5eXPXSrZFwuMms3BLPs98n+/ZeLddr4gBtp+l/+Wny+HwWDVvY5qSs+bKLgsTDOKJePjJifLKL7P/PLdtK82jKK1U6R++QOAdQzpd32XDjWggjndR64oNlXiUJx7jiIK//3QKJ1Dc80n9sw3UGVTQrIx+VKr/6Ae+CUt4MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEilBgIY; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777662795; x=1809198795;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GmRaA7BLAgD8YRkSw/hpsoffVytNmz2lQ8z+scnwfB8=;
  b=BEilBgIYn1LncxQzSyzJBSLKshYBOsyXqO4kHjfPAU5u6qPPsoq6eLF/
   /EsfVcvnHnlXof7wqHyVDFkk8JUGAuRdT1qG9rt1AtZuoP19hLqsFr7hX
   IkB9nTHYki69zwBFyUYm3frMTanyEd7Mkno2AC0ozQAZa4IE4nqCAXAL5
   UhVgzBVWNzLTP4tfVXkwbRDnJ2uKST0AXlbmtiAgMiH+HVfhiROjB1WgD
   Xj3ztiUPWMQjPFFmKyvYm5K+0jKHJv9dkb9XbF0iU4sMBz+l7g9JwoDJJ
   Q/dJky3blzMQuPIH75OmsnMYAfB/DCs+NQGDVidDm+rq+BzUsQvt1I0Wj
   A==;
X-CSE-ConnectionGUID: uSTHOfsgQQ6G2ghnJfoEMw==
X-CSE-MsgGUID: 7u4HVKtpQNmfmMmm09aEAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="77787505"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="77787505"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 12:13:14 -0700
X-CSE-ConnectionGUID: GFBXXBeFRAK9WF/kipyB7g==
X-CSE-MsgGUID: 8/wyCm9TRiGKSusTeFhTQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="232294054"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 12:13:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 12:13:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 1 May 2026 12:13:13 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 1 May 2026 12:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCZTpHAwFFZnH45NFWiUWySUbsiNwDCE/W1evauPqvTpbTkyDchjKy0wzYlV/9MNrM2WtNJ+cLGl97hhEdgx9+AkAb7y0J4qDpwnMMAKyhHhUJcbIaSyAuC1Cq5u1Cp4jxQYWt3XhtUr/Aq41+4W4qK5EfaY20R7TnncHHvNhscOEhjji88KaNtT60xzObhqQnZODmid4MfkhmNParN0+C1IYotQZl3svhppLHwUsFvZN4Wy1tm5Xcfkqa1QM+G925LiTcciN5I0O25q2WG+Oc/hKVz5oTDqtkV7nxsmqeaV8J30vmc3BYFnltvl6GIM/tKEITPIj8amZhuV55uNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcdNkrKa8wPWbuPjXVijYAFguRywX9628Iv2MchHuQI=;
 b=B9Xrc6k6e/v98shMxvls5B7Y9SsGpn11hmjj/bGnb56FlCOhdotDN9FlAftDXBTe8DKDZq1OjP5FSJc/nzh967rqQqV46gPfb/2OfuGjgwENeGr1yaTcR6FW1ixblGapk1eLhxPuz82cGcA2720wL1RP3ShCK/duLPV1HycevNg58bEqA5lQhPu0tUQXRZW8NH3K7f9Ro1PrEWbZoJfMo9Fi6bg3zjHO/L/riGfK7O1nIBcemVNJcTtjbKbVoyoznkpOUwrEXnSZHQbT30YTfgQ9MiFc3jpuQfKpRdYXUG3bqmcr6Lr4lmhoH3/rMH3vdjW4v9LandLBTEzG+GXA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.21; Fri, 1 May 2026 19:13:10 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 19:13:10 +0000
Message-ID: <02a4adb3-8829-4681-b170-e3a2f44bf11c@intel.com>
Date: Fri, 1 May 2026 12:13:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: Andrei Vagin <avagin@google.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <criu@lists.linux.dev>, <x86@kernel.org>,
	<stable@vger.kernel.org>
References: <20260429000623.3356606-1-avagin@google.com>
 <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CAEWA0a5zwHKP51V90A3J960e3o3pdVkSUMYwRJaxiD-fkP-JcQ@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAEWA0a5zwHKP51V90A3J960e3o3pdVkSUMYwRJaxiD-fkP-JcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DS7PR11MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d65fb4-8828-4bb6-da72-08dea7b5aef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ERgoai4LgqxXP0o3mLBfkg/27LYR/a+yVisPZ8oo7LaJd85Wp3aJ1wJOSlmRN07KNkeCirUHYxQ6dfhna8p3LKQ+F4E4XP+hBUR5jtA5frs3P6GDYmdJHtihZLhpuLMW/gBVJLY1B8hhhO5cd5Rr6Q3W3kwniRcUjacSGcfQAu6OjYsbOrmaW3niFGT7AOnzUWtRbyK2004jUXCdkqzP/009sj4gb7L4NJoHol744OEDxf0ivwxVGm1TmMP0qGS4q3O63P/7vHz7j8jvr9IkMkkjD0CPyPqASlWgIZeGN+w2FRln6ddLO6gnx7p6QY5NkKU6rnXpkxWFRlLjFbZE7tcrx45XTFOCnSN+uq+ZFQzqlCarKBd7928+JLqXcUgi/NPKKDNkOPA8hGVc80pdpBHsk2WOE7QJI7D4QJTBtGSTnctRlvtta9tLs3zkA2FGmGJwNx5whon0VCGyUZQNlsn3ur2K6TZsRfaMdt1H4Z7SN+h4lZiGMxOgVYb8TO2ivZ0FDARnCoasa64FhYjPfPvdFMeyEBuC3n6lf6ZA50tvTRGltV4E6I0YOv44JPntdI5OOZOb3lm97jBXwIJVdCZP95i+AtdH6aNxIdlMmWnk8xmnS4gOtFhhklny+rCorWXs0EpsFryT5vMQ32fHcBiKuQiBQWVUe49osnFHL0cnguzgtnmNwCvugsoNIutd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkxsWXlDbHprTmdRK0FZVmFNNlRIWVVpa25WNWtkZDE1Y095bkJ6MFdORDUx?=
 =?utf-8?B?SHF6VzF6VWplZms3a21aNU14VlRpajh0c0VqT0pmZGIvMTg1akh5THFSL29j?=
 =?utf-8?B?UmZKTy9OZy9vV0M0NjVxb2Z4T3BHOVpLZXFVVTFxRHYzc2VPMXhKYk1MYXFo?=
 =?utf-8?B?T3VDWExhb1lZK3UzbERXNjlrbCtUSDVXeXpWcjdDYUhNakJneS9CVEVFZ2dK?=
 =?utf-8?B?cTlXell3c0dvVkd0cXpCRU02djNkeWpjTlBLUTFvNU5lbzBOem5wUE9KcWFL?=
 =?utf-8?B?VEc1YStnTWdXanVFZzFySHk4RTJSd3E5ck0xK0lsUlRuSWJrdm5iWGtBb3VX?=
 =?utf-8?B?T0ZNbmRWbEhlcmdCTHpPTFBnWHRzeHE5ZUpwblBMSkdtTGFwYTc3M1FqVE9M?=
 =?utf-8?B?YVB0aVovelFaaEpVUGJYSnhaMmlZKzZSbjZHdi8ramFhU1laRnp4ejZwRnJM?=
 =?utf-8?B?SzlJZmQyaklnSitpdWlmYW1Da0FQVm5WdndaSEtNMFBId2duOU1jRlFBZk1k?=
 =?utf-8?B?Z3ZQdEY1WXFEU3RtTHRKM0E4OUEwcXJac1VYUkNtRFNqRm9MOGVjUHBjSkQr?=
 =?utf-8?B?M2VWUGpxT2JYSmY4L04rVmdkaDFxZlM1akU4SXJiejk0dUNUMVlkV3JaM0VI?=
 =?utf-8?B?ck01anJGWW1OTTNTTHFxRVJ0WGh1WVBSdU9wRHJVUUJoTjVoQjBxVWpSb0R0?=
 =?utf-8?B?eElrVnVrS0pmVkFDRjB6SkFhK01rUStWekVuVTVPQVY3U0VZK0pkZU5xQUFU?=
 =?utf-8?B?RE0ra25EYVpPN0p5WW96aDF4Ym5GblJpZFBTVXRGQy9KUkRDSStZRmIvWTNO?=
 =?utf-8?B?SEg2K3J2ZTcvTFZLUGQwMFRoQWNiUGNwZzNZQ0NBVi8xb2RzM1JURFVtelJW?=
 =?utf-8?B?VTQ4dW9sUnVVdVFzTkErWWFzM0cweUZuZTlYZ2F0M0lLaEJGMXZLQWwrU3hL?=
 =?utf-8?B?bG5KVVBOd2VRTUUyNzJvZThFSzNVc3lvcnNLRDN4ZzVWbDh1L2x4dkhFNVF1?=
 =?utf-8?B?UTVwRWhGVFlJZ1pvVmtuSjc0L3lJOTFEMSs2V3djN2lydnEvWjEwWExaYlU0?=
 =?utf-8?B?WU56S1M2K2paVkFDMDExbkFGWUo4blU0WTh1ZXlRRkZVcDJ5NmVFTXl0MFV0?=
 =?utf-8?B?eE9LM2duWmNVdk45QW9ncWtxNkQyZ3UwSTBRR1E1RStMTWhqTFA4MlRIVHhk?=
 =?utf-8?B?L004Z0NCR1JQK3hXblA2cXNtSVZvb0VaaGZyZnliRmJpU3VESkpER21YdHFs?=
 =?utf-8?B?cC9SNTJXdFBtMEQzRFdpTFBSQ203RzN4aFh0b2xnWG9mNEYvclFQWlp4YkYv?=
 =?utf-8?B?RlhaaW1EeDUvR01XREdmNzBGQkdTbGRaa2FDYW9RZFUraXdTWEgrRUVTYzVC?=
 =?utf-8?B?aGlhdmZRWjkvZ2NNNzJoNlBWejFTbElpQjl2NDdtZEcxZHRjY2E1Z2tWL25k?=
 =?utf-8?B?dTE0QmZFK2xCODIvN2RrYzA4Y2l4WXVWOGJyUFpwRHE3T2cxSVhDWVYrVDVQ?=
 =?utf-8?B?UnNEM25BYXh4SEpPeUNqdnhldFFOVmpMekZqN2lHL0tVcGlwaDl6NXRDZUFx?=
 =?utf-8?B?QytPZDkyZ3FxSGE0MVBwQUNIVlhSMWIzOTNRdTkyT0JoRU8ybDhUTkJMZ1Mv?=
 =?utf-8?B?T2pja0gwc3dvcjhpSWs3dnJ1OXVsd2U0bitIS3FsR205QnF0MW5aTG8zQy80?=
 =?utf-8?B?Zy9uL01IR2ZhaGh6ZTg4T3Bld21ya2hpWWljRnhrT1lSK09YSFlRNWczZHZv?=
 =?utf-8?B?M0NDVTR4Unl1Z0ZYYnU3N2lNZkJZSmQzYThCR3VteU8zQThSeTZab1BZZngz?=
 =?utf-8?B?QTdROHRnS0tTaVlFQ2k1d3d2cGJrUGV1VHpiZXVRV01yL21sZVhkdUlKSFR5?=
 =?utf-8?B?OWNaS25mbC9hMjNmOUpCTFhtckpaZURLNGVyUjFpSkI3L2VPbmkwRmhyVFAz?=
 =?utf-8?B?NzVIZXhucmxnVUVHRmh0UnJKK3pWVlJjUHVHRnJsMW9FSU1RaldoUThzV1Mx?=
 =?utf-8?B?ZHJGSTJ6YUgxNEZqTGhDRHRQNGowWklJemJObGxMd2J3YjNwMURDaDB3T1hD?=
 =?utf-8?B?RWR3ZExGTXlKU0xEcmtwSkhDY3ovdjJyMk9JRTFLbE9tSlZGM2lQdGh6dmpL?=
 =?utf-8?B?aXl6SjM1V3QxUnVwNzNkRW9oNWQ3dzB4ZyttTnRWYU9vQWhYVkZOR1lFTUgv?=
 =?utf-8?B?UFpDeFRPMWMzemtVdkljdHhuTmNmeThqUEJrbmhjSUFKNTFFOHZGR05DTEQ5?=
 =?utf-8?B?cW1Ya2NNSkcvMzduRmtzL1U0SDc0Y3ZyanRKWkFhQjFVRGFIM0lpbWxxZDJm?=
 =?utf-8?B?R3JLOXErQTZHZHdCS3dMZGUvTEFyVXNmWElNQTZNUDk2ODhvMXE1dz09?=
X-Exchange-RoutingPolicyChecked: dsh96nr9YnqmNSB74UHnKvR3Nd6DsmnZKgcd14zBnDqkKHV6yNWEZSt9Ay4J8jVAYHslmBwTtD/DDl+Sm8w7Iy8ci9ueiPOGSTLxrOnIOQ/zv5b/V0Eh1LRpnox3IGYMK4+1R3CcbCBgak/jsfKrltQhcIZO/wZYgt2RPcCA/ANIZjIc4xKXzbSwnxG386q5Jk5pmaxfYRlb7FosXUZOsL12HLr8cMblfRAOC3x8pTRnUzWgHp4V3rupwCJX/ZRY7RWoES10hrIf2aw3WCPpuZ5CEjcZRKMIPst3gknd/MlgYOACrjHjlaInrloB3rfGuhBBKXjrUInK0NhTDaXq3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d65fb4-8828-4bb6-da72-08dea7b5aef6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 19:13:10.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSUluEBzcSC6lqNT+3QWZQGCFAWi5opYO1qBGb+QkmqAhaagJ9lMuIR98YrDu6gGDjIXgcHQ+TGgDShYzr+Zr3hk+3LWYCl7EN7u86wZPRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C9E1D4AF158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242497-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chang.seok.bae@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/1/2026 11:44 AM, Andrei Vagin wrote:
> 
> I've been thinking about this more, and I believe the claim that XSAVE
> offsets can differ across CPUs for the same feature is inaccurate. The
> XSAVE standard format uses fixed offsets specifically to allow migration
> between different CPU generations. If a feature exists on both the
> source and destination CPUs, its data resides at the exact same byte
> offset.

There is commit ba386777a30b ("x86/elf: Add a new FPU buffer layout info 
to x86 core files") for this reason:

     ...
     The XSAVE layouts of modern AMD and Intel CPUs differ, especially
     since Memory Protection Keys and the AVX-512 features have been
     inculcated into the AMD CPUs.

     Since AMD never adopted (and hence never left room in the XSAVE
     layout for) the Intel MPX feature, tools like GDB had assumed a
     fixed XSAVE layout matching that of Intel (based on the XCR0 mask).

     Hence, core dumps from AMD CPUs didn't match the known size for the
     XCR0 mask. This resulted in GDB and other tools not being able to
     access the values of the AVX-512 and PKRU registers on AMD CPUs.
     ...

Thanks,
Chang

