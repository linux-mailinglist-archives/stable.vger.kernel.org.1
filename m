Return-Path: <stable+bounces-89189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE359B491F
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22FB2861D3
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF2205AAA;
	Tue, 29 Oct 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWh0Jn2q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D040205ACF
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203694; cv=fail; b=Xgpby97WdAUcfHy8dt5Enl2gWjb1VREZEXI0+a8EebgNJ0N3hWrUG1cxawqm9oUr6OFQBe7JlqJHGvRExKsm79FIICm89qoaQYiE1vvhR5BJVUtYa8AfdXjN1JzV9JEXjUUXtLsZ35yKPo3ff+qljxqh6w25Quvi+M713EjimRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203694; c=relaxed/simple;
	bh=0HNio3vINslw9yve7twXVYh072zJBZ+Q1V8FV8YQYjU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h4TsoYoAyIYNBxkk9PALECazr8voLlheMFseODM4yh6owH0VgwtZr7ZRG4vBXz5FhlCiF6ukWLb3DuLV2mGYaTKe2H9PyDW3Nb6PJ74cXHrkwkSMCKCqPRp6sPL2FuuGjRFLkrom5BrW5wVfci/GLpruUZQeKznpgFPACplVJ2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWh0Jn2q; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730203693; x=1761739693;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0HNio3vINslw9yve7twXVYh072zJBZ+Q1V8FV8YQYjU=;
  b=CWh0Jn2qeeN175P7IZT6iAy7jpOfZqXBb5i/sBRWy6vEAFgbYNz3riEk
   WbWjXZvSENBaONRhss9ZOooznAYJRJxllF3i5DOggjauiMZd6GlhPC1Y/
   4uQGG+k2ldQm+6BDnoAUoyvzKVb5J72Jt3APpLj/XO6so2kOKb3w4SeDi
   cB8cILjv5f20n8p/4S+vlKdXsr1T/6qxTHHOQKXNFNTbckQV3id8cQ3Yb
   Gp9l7A5okoI99ZkuNVJGWVw5QXrG8JuylxxAcwQ1GpkTK3TgYVZgFxcsG
   GOyZ7PCGzsYY0VCAcWBJpIXZq5ZQJTr5fDbsETsIcJMR9Rq6klCTpEVL9
   w==;
X-CSE-ConnectionGUID: Lep2vfHaTsuttPkxh4rkqQ==
X-CSE-MsgGUID: pp8byFeCTRe69v3LTT0jeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29958672"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29958672"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:08:12 -0700
X-CSE-ConnectionGUID: g+zmVYhYTs+osdnM0I+snQ==
X-CSE-MsgGUID: 6OwuhBMYQcmnoUpMP7sloQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86553067"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 05:08:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 05:08:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 05:08:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 05:08:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jex+U2x4+vCbGWiWTqNByl+vdCRT1+kmppnWuQZBh9H0TPA2IyqFd1m2O736fJylMBLHzouNceE86OUMGgUyxnitlwF4gzwgBLclEHldP+6FP3Xr30ZY8D+k0XiHsenVW2A9ZcvQcQ7lQj/oLwT4Xa53qv0k0OhCNIHgZjhYDcdeOht62DmDq6LCj+oIA9ZlKmIYN0jxqGlXhNzeobA9m1NWi4uUWchxmvz9XvPtTfRaTJukyFJCDWkBcNHvRIl3BGjgGIl+dYmTeJz4gPgHgsFCo18BUbHYZ8KKo/2cwLH4yqks/8otZlliWPlrPa6c3EaZK1ph3P94IbJXF2XpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HNio3vINslw9yve7twXVYh072zJBZ+Q1V8FV8YQYjU=;
 b=pqelhzA3OtOHttNsYlwO5ugsJytQsySfbkutty/hY5Iscv3Mmd43sc/BNJIOdLbTlUWckXad1Na0ZGwRjX9wwIpLtZ8qwmB9euY1acUhnC/KplB8ZpROiCB5lBzeUrtvP37t/d0Mfvyu3gYtOiyaZbBeyvVn9v7gIZGYXsR8evwDJuwKiF9ccEfBZKCgBDUXF/iBaF3go3/xQ/h7R6mwdDd7rOnFU3+noHXkAVvpTDU1pFpaT7uh7/wJ8EZR8zzCEH8Mh52k+9hjzm8wZKKY5vnIrePndb9itLRQS3DrooVg7sj8NYkEHn76gEIDpl1UIvLcUptxsGt6pLAUosE3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 DS0PR11MB8163.namprd11.prod.outlook.com (2603:10b6:8:165::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Tue, 29 Oct 2024 12:08:07 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 12:08:07 +0000
Message-ID: <5cf6b361-c727-4e93-948c-bb0bbe2c97e2@intel.com>
Date: Tue, 29 Oct 2024 13:08:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/xe/guc/tlb: Flush g2h worker in case of tlb
 timeout
To: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>
CC: Badal Nilawar <badal.nilawar@intel.com>, Matthew Brost
	<matthew.brost@intel.com>, John Harrison <John.C.Harrison@Intel.com>, "Himal
 Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>
References: <20241029095416.3919218-1-nirmoy.das@intel.com>
 <20241029095416.3919218-3-nirmoy.das@intel.com>
 <b50daa2b-45b7-434b-88e9-d5f40bcc6542@intel.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@intel.com>
In-Reply-To: <b50daa2b-45b7-434b-88e9-d5f40bcc6542@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To DS0PR11MB6541.namprd11.prod.outlook.com
 (2603:10b6:8:d3::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6541:EE_|DS0PR11MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc45477-c888-4823-7c7e-08dcf8125997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlgxUzlSYVM0MGM1bXFhclJBM3c2WnpTNWY2ZENYcDlMQjFGcGE2K1Q0UDhN?=
 =?utf-8?B?bXVKZklWbFVncTVOZndBMk4rOGxiclllWnJSSzNKbENpZGZqdEw3K0hPNHZ2?=
 =?utf-8?B?TEQ0S0RmbklxZ0NpY3dQSFdkRmllKzU0Q1dSSDRlenpSTUtkdlp6T2NVenY4?=
 =?utf-8?B?UzV6cUU1OWJZTUpDWFVVTVZjYnhQWjhJTHJxbXRKQW4wM1BKR3M5YW9OY24v?=
 =?utf-8?B?cVBqR3FSa0VTOXdsTWZmd2Q3K0ZraEp0OHl2b0sxd3hIbHZONUlVUStnRy9U?=
 =?utf-8?B?ZmpSbFBmRU0wcERtRU9qT2xYcDFjUUVBN0dXZ0ZGL1MweXBzS3daK3FEcExS?=
 =?utf-8?B?WjJoZTYvb2FHdmxTZTl6NXlGV3hmS3QvTGk2MThUY0x6TldyRU5YNC9Pd1FD?=
 =?utf-8?B?bndLNmt4c1I5b0x0eDVMb2xZWjNnU2F6dnZWR1F3NEpHVTNkNTJTZnJpMU1j?=
 =?utf-8?B?Yk9VeHdCTXdqUjg2Q3h2bmxPT3QwbktrWFJYamxtcStVcDA2dXFkSVR5OXI2?=
 =?utf-8?B?TW1qZ0Q2K3kwZjAzSGdYdnFoQkNhT0pNQmVnbUhmUHBCOHE3aC9qMFFuYkNH?=
 =?utf-8?B?eW9aSHFqcmpLM0kwaDlmamRHVWhGa09vRGdNdEtjeHlBdE5xK1E4SWdmTTZT?=
 =?utf-8?B?RU14NlNPZVJKUWoyNGtrT3d2OVJDaHdRVlZiL05YbFA5Qi9haHpOYzhYNnVV?=
 =?utf-8?B?c3FaNWdValVwaXFYTkRad2FrdG51ZW1GRFczYXVCNVViUU4vYkdITE03NjJt?=
 =?utf-8?B?VUJDUHdndllWZFhiVEdPK3pwL0srVm1uVnh2NWxENmFvQ28vbFByVGZNVklT?=
 =?utf-8?B?M09JSzdhL3g3OTB4K01PcStETnN2czlZOVhhc3JrY0xCRnZOOWFsNmpSRFBu?=
 =?utf-8?B?K2hmVGd5TVJpdDhrQjYvdEkxZVF4K3hZcGRkVGpsNnA1TC9WRGpNMVZMMUsr?=
 =?utf-8?B?cldPM216ZFZJR010c1NNU1lTY3V2bTRxcDRObDF5K0cxRDJ6ZWdOQy9IdzN3?=
 =?utf-8?B?TWJOQzhUc1Nsd1BKWW1kdzFnNzQ0TmtWNDlIaTBLSmpDZnhtbDhPNlNsYnlz?=
 =?utf-8?B?S25tbTh5cTBpZlU4ZWhLOVM2MGVRZi9oMDc3NUdGaDhQemlSWUpudDVHOVJS?=
 =?utf-8?B?bTRaWGFXZDFTL09odkVKZm1oU2syc3FkNmVySXh3Ymo3V2UyNjhXOTc2TmJa?=
 =?utf-8?B?WnF6K2dkQVR4VHBzQnlDdVdLOXRLSXVFYWhmNHJQZVNWWTNMWVk5MVBzVzlx?=
 =?utf-8?B?N3BoR0xwcFA0SGhLVlhsTzZTTWtldG81bnJHaklhaU8zTXIzczBKNm5SWjlK?=
 =?utf-8?B?alh2R1IzOUtxL015QVZRWHRJcFlsQm0vRnlPUEg4MnpTT01nL0VqVkYrTk44?=
 =?utf-8?B?VkNSM3FZREVPZjFseXkyN1Y1OS8wUXU5b2RvcEw3YXVhNWN4clM3VnByQkxr?=
 =?utf-8?B?V0lPYk93U1cwTGxpZjRBV3FjVlYyUmtvYVdXTjhXcnBORnNYWW1QbXRIYnFS?=
 =?utf-8?B?ZXBodzRpTTRSTHVkR0FGeWFHN1dXUGJTWm1Ud1RXT2FpTUNwWGdRM2MrVEpE?=
 =?utf-8?B?QXZsVXJmZWhLRDdZVFlVRkxEamZ2V2FnQVpDYXFsc0pDWUhsOXJpQkcva1dr?=
 =?utf-8?B?NnBFbkFKdDUyRVR3SE5udlBlbGZqeSt0bFgvVEtGeW81OExrQlVmT2xqYThR?=
 =?utf-8?Q?XHtSUJO5iKftVPRPKsmm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmlmRlFUWDBEeU5yaUhqVnF0VDNwSU5Wd1EyZFZiZGU0dlUxU0tkeDhmVHh5?=
 =?utf-8?B?c2h1MEpIZjRaRGorMm05SUFNNmtZVVFVL3l0UDZhWjFUbmhIdlpLSTFXcnYv?=
 =?utf-8?B?Q09lSWZubnlVTytMYUY1Z2JmV2I0UmlUUC8xQ3YwMSt3MFA0NXZXUGJDb0NF?=
 =?utf-8?B?MGlFUE12dmVPZUtyd0NrQUJnSEJLWWs3MC9TME95SjM4MUVremRrWlRlZW83?=
 =?utf-8?B?QmlPeFdYcmVVTHV4eDRiMmlKWkRoTFBzS3JEZmdTVGF2ejAzWUJRaGtEUDBY?=
 =?utf-8?B?aUJYT1VRUFZFbC9ZTzhYM2tCb1FWWklxdUE2ejNlNW5GbVFXSGd4RTNKVHB5?=
 =?utf-8?B?d3AzSlQ3UGVPd3pWSDFqbkpBaGdmTGlLMjJvK281dE05eUgybWNubkg1djVF?=
 =?utf-8?B?aFFZVE9RTHRUbWx2TUVXRWtjQjkrKzlDMERZYXJvVlkvdnFtd3JtR0xpMGJF?=
 =?utf-8?B?TUp4MjJhdUFjTlJlbW1rL2JpQzJUcGs0a0ZESWZUdURTTlpUWkZyNTU1Vjlm?=
 =?utf-8?B?bEZEeElZOUo0Q1h0SHUvczc3cVllN0wwU2ZzL0JaQ3BzVDV1djExR3dxREVL?=
 =?utf-8?B?dEh2QkNXWjFPMnVLM28rRUlIWnRSN1pMNGQwLy9BQlZmWUExU2ZlV3hEUldv?=
 =?utf-8?B?TXIxZ0ZRUmlSOWs3M3VvZ0phSFhVaks5dHEzWnRUUDdITWVwekdmWlozYWpH?=
 =?utf-8?B?Q2c2UkRWckdZRDJUQ1piOTVXOTVmdnVlUU1hOFA2Y21CMEtCYW04UzBQRUpD?=
 =?utf-8?B?ckhENFhNcDFaUDFjVzFtWHVob3lOYytld3lMcTdXRXlycTdKb2toOHRrUXNS?=
 =?utf-8?B?TUlrL1RMNXhIQ3B4VnR3L0lodDltSE1pYWVndFRKTHlySEVibzArYTlhclNF?=
 =?utf-8?B?N1l6dkxTZmsyVGhWOGJxb1Fub0NyUlpucnFqNGxZcDJUNyt2UUFkYUdqbGh2?=
 =?utf-8?B?OEljMUtwdFRjK1hHbUVyNVh3clY3MDVGbGZBTHU5bDlhbG1uUVUyK0h1RWI3?=
 =?utf-8?B?UmkvaVk5VWFvc2tzVE8xMk1pR1VaazIvREYwSU1MamFuZWlRMUFLZTJMUTlJ?=
 =?utf-8?B?eEROZXg2R1c4ZnluM0w0ei9EQVhyT3BUYWVyTEt5dzlCUXBOUDNpanY5UVdV?=
 =?utf-8?B?MTFjUkRaV3ZyS2l0eXM0ZUJ4NkVUMEpBWHN2YUswV0JjWHY5YVRLNU4zVlk3?=
 =?utf-8?B?c29vMHVOR09xLzIyWGFleDkxaG5PQmczUXl4V1drdTRTT0IrRmdabWppODNa?=
 =?utf-8?B?RytvRGxZa1J3eFpEcnRUcjJiTEFZaE12M3V2dzBXY3BrUmNkSlZ2dUlZclBO?=
 =?utf-8?B?M0hUSVFGeWJ6SjVncytOT05MYmg2bDIrN01uRm4wK1JTQTBaUG1SNFNLdk9i?=
 =?utf-8?B?SE1yNnhKTGRjUDlzeDFFT1dvWDVCcWlnM0ZFT2crRVVrMHE1N0s1bmRWMlJN?=
 =?utf-8?B?SVk2MC9zUXdlZ2dkQmEwTjd1ekhXSWVDRHl6bFI5WkxyR1ZPV2ZaUDBxK3hX?=
 =?utf-8?B?cTErcnFUb3IvTk95TXBHdUs3VFpoVHRIdkFGaG5FV1hMTzR3eUNKa28ranVG?=
 =?utf-8?B?QXh3NGxaUXlTQUt4NEVvREJSejl3YWRkZjJGaTdKbm4zWGhDT1UySmhQdUh3?=
 =?utf-8?B?WFd6SWlrZlh0emNYMkNvU1JNaXJoUFhzZWxvTm1PVDhhc2JOczYzcTN0TVky?=
 =?utf-8?B?S0Zzd3R1ZTBsY2lWZ053N1o2M0lsQXVZbW4yMDJpdFl3aG41YkZIVTJQYWhh?=
 =?utf-8?B?YWNxSTBkSTFtNFZpbzlLc1crSE1EcVNhS3RYMFUzQlFYRHpJNStCbFIySzdM?=
 =?utf-8?B?dXJVd2wwSmxyaU5LOVVuT2U2aVVJcDN4K1FLZjZlc1U3cVQ0RWZkamNQQjk5?=
 =?utf-8?B?enRuY3JTUWtQb3pjVkRMekpJQTNyUnNqa1lTdDFjdk1WUGJYQlVEUXhBYWVI?=
 =?utf-8?B?U2lNMk53VUlrLzEvNDB0ZlRBVjZGWGlab0txeDEvRDdoY1ZFdGJ1T3FCazRO?=
 =?utf-8?B?UkVHMm1JdW5GeTBRbjVRb1E1aWUvclAwYUpXaFltYnI3VkhZK04rcTI3V3BF?=
 =?utf-8?B?Tm1adWpJNDBpcVJ4MUlVSGNzSjZ0VEdxRG1leDFNWktnU2NaYXlRUkZOZ2Fp?=
 =?utf-8?Q?L1wOi+dTSlNNHPIvqecqKueM/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc45477-c888-4823-7c7e-08dcf8125997
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 12:08:07.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+LEEPDB4xCHV2naJYVMcEluWRL8vw9FNK+tvHpXHg2eZjXcWUIM1M9w8wk0ZS3BtW7m6EmRmjGwXnwHwWuVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8163
X-OriginatorOrg: intel.com


On 10/29/2024 11:59 AM, Matthew Auld wrote:
> On 29/10/2024 09:54, Nirmoy Das wrote:
>> Flush the g2h worker explicitly if TLB timeout happens which is
>> observed on LNL and that points to the recent scheduling issue with
>> E-cores on LNL.
>>
>> This is similar to the recent fix:
>> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
>> response timeout") and should be removed once there is E core
>> scheduling fix.
>>
>> v2: Add platform check(Himal)
>> v3: Remove gfx platform check as the issue related to cpu
>>      platform(John)
>>      Use the common WA macro(John) and print when the flush
>>      resolves timeout(Matt B)
>>
>> Cc: Badal Nilawar <badal.nilawar@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: John Harrison <John.C.Harrison@Intel.com>
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.11+
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2687
>> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> index 773de1f08db9..0bdb3ba5220a 100644
>> --- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> +++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>> @@ -81,6 +81,15 @@ static void xe_gt_tlb_fence_timeout(struct work_struct *work)
>>           if (msecs_to_jiffies(since_inval_ms) < tlb_timeout_jiffies(gt))
>>               break;
>>   +        LNL_FLUSH_WORK(&gt->uc.guc.ct.g2h_worker);
>
> I think here we are holding the pending lock, and g2h worker also wants to grab that same lock so this smells like potential deadlock. Also flush_work can sleep so I don't think is allowed under spinlock.
Ah yes. It  ran BAT tests without any warning so I  didn't think much about this change :/

>
>> +        since_inval_ms = ktime_ms_delta(ktime_get(),
>> +                        fence->invalidation_time);
>
> I think invalidation_time is rather when we sent off the invalidation req, and we already check that above so if we get here then we know the timeout has expired for this fence, so checking again after the flush doesn't really help AFAICT.
>
> I think we can just move the flush to before the loop and outside the lock, and then if the fence(s) gets signalled they will be removed from the list and then also won't be considered for timeout?


I put the flush inside to get a log when it resolves a timeout. I will revert it and just do flush and not print anything.


Regards,

Nirmoy

>
>> +        if (msecs_to_jiffies(since_inval_ms) < tlb_timeout_jiffies(gt)) {
>> +            xe_gt_dbg(gt, "LNL_FLUSH_WORK resolved TLB invalidation fence timeout, seqno=%d recv=%d",
>> +                  fence->seqno, gt->tlb_invalidation.seqno_recv);
>> +            break;
>> +        }
>> +
>>           trace_xe_gt_tlb_invalidation_fence_timeout(xe, fence);
>>           xe_gt_err(gt, "TLB invalidation fence timeout, seqno=%d recv=%d",
>>                 fence->seqno, gt->tlb_invalidation.seqno_recv);

