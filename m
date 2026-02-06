Return-Path: <stable+bounces-214662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ETDG83yhWk+IgQAu9opvQ
	(envelope-from <stable+bounces-214662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:55:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4514FE7BB
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48F39304F481
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BEC3E9F73;
	Fri,  6 Feb 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uk4H+bso"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3F3E9F9F
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385815; cv=fail; b=FykLbsAXR1XDzkZV73SFf2kGjxs0+jc7bqMxaogZT+6DuDXY7YwS8P9EUzZ6vQXgIXDGR8XRzMiW5C6GCCNCF+K6NeQ+0EBGcNXjp3/PzLH+8C0JaGG7+ElKPJCqhlelsZXAyHVtCnsbgVv9vVhOJnUehKJQ3hP3t4eW5sx8FXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385815; c=relaxed/simple;
	bh=C8Cor/c+/2VxcBbNVJZRXnRwM8ht9eLeJwlkisN3B2Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BLXqXAOv+hZW6mJx6hFJXlaUeJvjde4l++x8wtnzWHZxu2nZJxXhquei3UjmIEwsOCtxvKy80xWvP3KLj0rd6lE9dGJjoZ7ZceGopg1QGNVQ5Fza5B86zQrwCl3M7N++CaBwqzByhUXsjQYqFL/TDSMsMgQtu0b3yVSdXrM41nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uk4H+bso; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770385814; x=1801921814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C8Cor/c+/2VxcBbNVJZRXnRwM8ht9eLeJwlkisN3B2Y=;
  b=Uk4H+bso+8eAnqUg136wRPS+xg3iF7KA6aTAe7rqahlIPF0CF9z+kdPs
   vX8JctoZbYnejrhSDnhmjUH+s7Z2lGbns06E/6Q75A8HNZ4leHXhziXfP
   n4Inr1DZfWGnQf8S+X4qVap08Xng78pxAdqRLDZBsFmJxllxpth1XSYCR
   LNZtNUYfkdggRCo39UHYQE7R+38s4aaecAV2GeDptva+AmbuYvNwX5bAS
   aBBEQ29OkkouhEUdpjGvpfRYErkUkMpTy5840W/9kQpvCHmfkSOXx7v6e
   eocmmm5ehXqE/ceLmUBugBtEmtZ9C8eknmZ7bsUWOGJ6Z+8V0TxsG/kSq
   A==;
X-CSE-ConnectionGUID: DoJO4LlYTWGXHZpX3vP7/Q==
X-CSE-MsgGUID: 78Iw2vKYRRy8nshDiOOEfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71483471"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71483471"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 05:50:13 -0800
X-CSE-ConnectionGUID: x1P6UqUgTIqk0bG0rN18Bw==
X-CSE-MsgGUID: RZbtHQtPTuCec0PaQVBy0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="215446866"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 05:50:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 05:50:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 05:50:12 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 05:50:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX9ondZZR8ptiyWwovOl9GfmPznz5upykKA8vOADLhwGjiYf32olT+SvSoLb2OLpQLXwlWSr9e1Im1LHlRyV4zP3fMk4EfJ/tyzqy81qv+pbfiPWUcWIs1jzCCYQSWqIc9K6Bv/12Y5RlWEqJbW0IcA3CNAmTD/rGMTYKSwFxyz2gQH0O6LzwfSd4tMA5NwY4BR/REvifqx3qrU2hheqOcfcdyeyf0CNB5KWkPbBKL+PmHU/Q3e33DRHSq6oK1zW7r19phgGqjnmhUkcr+fFkbCUu76bF8fornivKcNcbMZxC2jtgVAcBbYqDblqZ0B/XKNIXRiopun8QLd4HVDiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSTL/eU0UBOMQpGMeHjkL27u85fTELRDxiMbSphdTh4=;
 b=WvOkiVeQh3zA6G/jcY1GbqD4Jn+uY2ob5YkiP9SPwzludCETqzOnbHnUkZa1FPAEfq+YYk8bKnTEiaM7N63BEN+jA94W/ph5d2hJCcXdzuk4HISa/9yaImrEQlZ+FWCO5aJCw0fmsW6pQiovuJ4gquMtN/8UXhe5LO5gcCAzhriTCY6GCerZqUNqAMrTQeOSmUtt5Hhfd5/F6uSWgUSA0XBzYkvLGhaX/PUY7JjpzoOtbLaYYCyRFtBP53jxWP/EROfK96x3BN0k4N00Vnoa95tUVRRzruleklKElVze8msF8e8gSr7Jz6RSOf5FNnFTXqSkvUXe7lnNyzH2c/oQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5341.namprd11.prod.outlook.com (2603:10b6:5:390::22)
 by PH0PR11MB7523.namprd11.prod.outlook.com (2603:10b6:510:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 13:50:10 +0000
Received: from DM4PR11MB5341.namprd11.prod.outlook.com
 ([fe80::397:7566:d626:e839]) by DM4PR11MB5341.namprd11.prod.outlook.com
 ([fe80::397:7566:d626:e839%3]) with mapi id 15.20.9542.010; Fri, 6 Feb 2026
 13:50:10 +0000
Message-ID: <f6b59555-01f6-49ff-aff4-a6da9d347332@intel.com>
Date: Fri, 6 Feb 2026 19:20:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/i915/dp: Fix pipe BPP clamping due to HDR
To: Imre Deak <imre.deak@intel.com>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>
CC: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	<stable@vger.kernel.org>
References: <20260206104227.290231-1-imre.deak@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20260206104227.290231-1-imre.deak@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0183.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::13) To DM4PR11MB5341.namprd11.prod.outlook.com
 (2603:10b6:5:390::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5341:EE_|PH0PR11MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 47cd4295-4249-4e46-0677-08de6586a4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bityNDRmNkozTVJQVVNhM3Y0TlpyNU9EUEN1dkVMUTlHMkdHQ2JmdTV1TVJq?=
 =?utf-8?B?UEl3bWNNQW5IQll5ZS92MnFla0NmSmNPR1dxQkVSMkpCQUV2UzMxS3h0R212?=
 =?utf-8?B?aGNtaHB2MU1udHoxQUdkWUxRL3NKTDF5YW5JQXRnZUV1SmxJUHhYbDVyNTZB?=
 =?utf-8?B?VVgrK3QrOEZUcEhNeVhaMDlxaXFMV1RoU1g4R1k3VlF2TGVXMFRZR3E5NkRu?=
 =?utf-8?B?TjlYWnI3dHZsQi9YYlJscVVXRFlaMjBHNE1HRmdMdjJib3k4WUNtVUtPQk9O?=
 =?utf-8?B?cVVFVzg1WmR6YWI3Y1NJKzlhSXgxRDFSUFhwNWpSSzNZQnRXNUFVRHJPMnZX?=
 =?utf-8?B?bHB4dytZUmpycjFSeVVvRk9Sa1V5VmMvRUxMZS8xOEx0Z1VSTE5sZWxxWFFr?=
 =?utf-8?B?S0F5ckdHK1lUQU5kTE1ZdFNjcisxZnZNdktvczdGMHNDVzNrU1lKOWxpTE9m?=
 =?utf-8?B?TERLVXJ6bEtRY3ZmQVo2OE8zbDh6dVVOMVdpOGR6Uy9vUGNWTFVCVmpxQXZx?=
 =?utf-8?B?aVZDbkpZQ0dMYjV6aXpXY3Vxa0FDK3pYNjJPcEJsOXVJS2JCY1VZbk1LdEg5?=
 =?utf-8?B?S2MvbzVxK1hucVZDSmlwendMd0Y3eTRuY0RCcHIyYnhlN05hREtvTmhNRXZ2?=
 =?utf-8?B?VDNSM1NHc05XL3pXaTNrbjIzNEM2Z0k5elc5YTc5dWU1bU02RUZqM1RpSWhz?=
 =?utf-8?B?alFNNkxvSERFVnhEWkNvZ1k1b2NXaC9KWnM1Y3BTNURIbEVlVlFqeGJCRUNj?=
 =?utf-8?B?QVBVdk1SODV1RUU2NngyWWh1cE01N1NpcGorWkhxTzE2bEdDYjlTN0VsM3NE?=
 =?utf-8?B?N0laeTVCK1FhYVI0VkE0eWtBNXBlWjVpdlhYcytqWk9lbVhkQWNuWGQ1RTRG?=
 =?utf-8?B?Ri90RWFOdGd5WjhZTldtYXlKbFRGWTg4ZnV1VHlKTThIQ0I3RHJjR25wUlFO?=
 =?utf-8?B?V3RDQkNIZWZNeEpjakFSOGh6TTV3TllDdEtKQ1JWWmJZTkxPRkp4Q2pBeVBp?=
 =?utf-8?B?V3FRS0lvVFh4alJOeWJMSUloK0xMcnJnaHh5ZnRHcHlURXB0eUs5Q2ZHMVVz?=
 =?utf-8?B?d084aUpiSldOcWV1RzF4SWpLM0tLamwrS1RWOURVUUd0YUN3U0RNc09YTURv?=
 =?utf-8?B?c2ZsWXk3V1BvRzlLS0dKMUdNUTRhQWpwVXR2U0s1dmxOUmpJWHJ5NUhoR0E3?=
 =?utf-8?B?VmJSWjdhT2tpSU1BOUMzVWZWamZPNlF1encreUx1Z2RxaHIyVHlWZlg4djRM?=
 =?utf-8?B?QmVML1puRUdWTGo2SHNZY2czdFdGUnBQMXoxTjJyRXMrWDVDMnpOQi9ZcytH?=
 =?utf-8?B?QndkOUJzZ2p0TnNwVW43ZE5NOWF0NFFHb3JkanVmY2szem1XUVVrVkFKNlJE?=
 =?utf-8?B?OC90WnIwbi9rdXlZM0JVcnYxdnptZTk5SDZRalR4UDJkOG5VWndySEpLSlZW?=
 =?utf-8?B?TWMzcVpvb0RvczdZQTl1QnAvSzQxZlM4c1BLN1R3MVkyZ3ZudkxHN3pERHBi?=
 =?utf-8?B?aUVlb1FVcyt1MGFYdmZjKzUwWkQvNGJmeUthTm5UTVp4Uzg4QVp2QnNtVWhW?=
 =?utf-8?B?NGtRYWdxQ0hwOUJZcXJFTVpJWmpIMEdTWWZMbEY1c050eVpQaCtkN2huWnls?=
 =?utf-8?B?SXZjcTJ0T3lSRGlEQ0I5K2t1MXlXK2g0cVZtNm9Pay9FUlNROGNjeWtRTzRX?=
 =?utf-8?B?TW5rNjZ4aFBhMTJVSS9CYVZxbjc3K05wVGRUaWlNcDY2bDJRMnZDWndxL0pY?=
 =?utf-8?B?eVhEK0pwU0tIUEU3U3ZNcGtsU2Y1UmVjYWRrMFRHRS9HWmk0RDREMkIrdG9U?=
 =?utf-8?B?cHBlbTl3dlcwVTJpcVFHNHBkK0dKSU1DZ2JLSXA3Z0RWa1BKSks2cURxOStY?=
 =?utf-8?B?ckllNzN3WEdBU1pKT0NYZGxpQnlOQXUrWE81Z3VUek9GSGVJTDB3ZnQzM09S?=
 =?utf-8?B?d2FWaS9QMGtoNE5OVUNhVkVkaFZFcGFFb2p2SU5ZZ1JyS01BR3JucGUvaWd0?=
 =?utf-8?Q?NiU6qcc3sk44IsEaYPaWsHgQeAk8Jg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGprdlpELzBMT2ZlNWJZdFdhc21CMURQZnY0VG5KMTBhYS9KcVNkbDI2VDdJ?=
 =?utf-8?B?cjNDVTM1Vmdpa3RPRFJnMXV3ZU12WEdYbUZ1dm9BbGo0a2J0bDBiSkZraDY1?=
 =?utf-8?B?Ujd3K2tJaEJuNkVDTWlPdlo3OG54a0h1ZkFzc05RTXJCeXRkNFZqODIzVGU5?=
 =?utf-8?B?REVqNGFTWEpZeHpFYWRSRzJnNjdmM3VROGhTbGFML3RtU2RpWjRMY2hpZDRE?=
 =?utf-8?B?OVVocUkzYU5tNm1vOVZQZWQ4UEw2RUxNN3ZlNlNteWtMQjR0T3BVL0lzSTQ3?=
 =?utf-8?B?M1dVQWRua2F2M2FhYTZkdVQ4NjhpN2NFNktNZWU2ZkhrNDRpYUdROWJoVG5X?=
 =?utf-8?B?YmQwd0ttM2ZpT1Y1WTFIT0VTWVlzczFlN0laaDlpNlVnbDVwZloraXFQTGdi?=
 =?utf-8?B?bTdLelFybU4zNjExREE3RXh1cEtsODBCY2lDTmVpa1RRb2xobitxckJuSHpw?=
 =?utf-8?B?cjI1WGc1UFFxbW5xMUdPNHZsVGlNaXYxajduSjlDYVYwbUlHbURjZVhpOHBF?=
 =?utf-8?B?b2VuYXpvTTFTOW9zOXZnNTVaUmJ2VzNkT0NEUGRkNXdDQXZNK3VuMm9uVEN6?=
 =?utf-8?B?cGhKblAxeHAwMHZZZkdkV2VFbW5TSjdrVVArcklIU1gvTXNQSUw5d2o1MXhn?=
 =?utf-8?B?TU1PUm8rQWpSN2ZMNkN4QlIzNWRTNm5pVUVIQ3A2LzA2M1l5TnMrZmtGNUIv?=
 =?utf-8?B?RkFXeTlJWkc1N2dJMW1tUUJBSzV2TlY5NmpUaFRpYUNOblViQzNndG1yRWt0?=
 =?utf-8?B?NHRSQnpNZzBIY3BBOWkwSmVjL0MzK1RBakZVOTFqVkwrRjcyc3hkV1JCbGtQ?=
 =?utf-8?B?U2ZIdm1qK1N4UitPaXhTUnFEQTgzbmUvSi9xb3NxaDAwSWRicnVxZzZyOHNz?=
 =?utf-8?B?S0NqQy9yUWYwWmQ0OXovZlNxQnAwSGVYY2I3emwzSWd3Yk8xK0h4YXpiaG5j?=
 =?utf-8?B?NTZiN3VVR2pFUms3b1BTYlV3b3BwWFozN1pHMjZHTWVIYjhJbDRtNlhIUnRK?=
 =?utf-8?B?cWRoS1hhY0ZBRHF2VmozWkVnSHJDdnJoUG9MakNMWGc4ZThVWGFpa3NqTUlR?=
 =?utf-8?B?bzlobVBWdzl1UFpLaWRPMlhkSVBaQk5PWUVURnV1eE80OExFblNuN0ExQnF3?=
 =?utf-8?B?ek5YRTlBVHJGSWpGcTd6NldBWFJORHVlVURxUEJPRG1QKzA1YUVCZ09qRlRj?=
 =?utf-8?B?ZjRtaHRyK3V2N0wrWk01ellYT1UxLzcxdldneEw3SkEvd0ZwYmhTMnRkMHBy?=
 =?utf-8?B?OS9BOE81eDhmSXo0T1I1YzhqUTRTRHAyNmsyUSsrV1Jhd3RaZnVzY2FUQk1O?=
 =?utf-8?B?UGFzNnN4a3VVU1dKaEp2OUpCc0dRNmZIUTNxSWFCenh2ODc5cDVjZDdUMm5U?=
 =?utf-8?B?OTZPaFJrdzN2Q1YzaDFRNVV0cStNdUltRlVUamNTekxlMWhsZkFINlJ1ODhK?=
 =?utf-8?B?Wi9nMkZkcU85aWlKbm9jQ0NhTVQ3Uk5ISndDU29UUld1SXBrTG9oRFl3SE85?=
 =?utf-8?B?aVFXZXduQW50dzJ6WllORnM5R1BrRmtmOGZ1QU1rSzdpM1BaVHRpSjM4Zkpx?=
 =?utf-8?B?TE9lM2NMV1krN3MraGVlcWFHRzhxNEJVNG1OVUV3ZTZnS0diRW42cVd1bTlG?=
 =?utf-8?B?Yy9XZjhaeVlxaFN2ZTQxNmZieTNKcUxMaXdpTTBiTlBJYVNXVnZBV2o5TmY1?=
 =?utf-8?B?cER5bTJybjNJZjAvZGI0MnlMQ2orYnBkY0FBaFJyMXJHRHY3cmQ4VE1hdVFr?=
 =?utf-8?B?NHh5WUZPWkxhc0JFNUtmSUN1YUZPSG8vUXFqdFJyQTRrdmRDZUNZZG1WdUFD?=
 =?utf-8?B?YjRIcktuUEhzN2FGN0cvN2g2RzFZTjBGdGdGZzUySDByQzliVkJlVWtsd3NS?=
 =?utf-8?B?VWRudUZnZGtRY3dwOXhKY1duaVdhMEtoczhjVGJUeVFKTnFnZzJmdW1BbnpR?=
 =?utf-8?B?WFBwcDgvRnBFYjJtT0xpSXZpZlByaW5zTC9MUDBzb0tabTQ5bHVCQnRZRTdK?=
 =?utf-8?B?VjFONE8zaVdSc0ZuUWo5bUVaRGk3NmY5TVRHcGhRanVtZTNtRk00MlQvM01Z?=
 =?utf-8?B?a1pzampuL2hISUpZdndiWU5GWEpna2tPUk91djVsSzJuVEVHTXZ0Y0N6bUdF?=
 =?utf-8?B?QWhVSWpTSCs0NE45SHBTREEzZ2dDYTdBMjVvZGZxNXFIMVJFRlYyYjlLYnRR?=
 =?utf-8?B?QVhhT28rQUNiRkw1cWVRVWRJNU8welh2bG1BVlJGNzd1KzkxZG5vaE00MWJy?=
 =?utf-8?B?cnhIUDlyK1pPOGhFK3BaRGh1RGMySTZHRkl0b3NSZGxRbDc2REdzQ1dIMkJG?=
 =?utf-8?B?U2kvZ1p5d3l6YiswaFF5bGZoUHhhenY5c1pobEl5cXFudXdiNWI4UVBjbE9t?=
 =?utf-8?Q?UpiL6FxeeTexnfTo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cd4295-4249-4e46-0677-08de6586a4c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:50:10.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLt4fZpFDHhHa5fiF093/4RaQKCa67urkLHdzXwwAjfuXkiZVwfAykpVuzX2vTIimycxYzVo05r5txj7sPy6IlirIqOJVlchuCy8i6V9qPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7523
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214662-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,gitlab.freedesktop.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ankit.k.nautiyal@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D4514FE7BB
X-Rspamd-Action: no action


On 2/6/2026 4:12 PM, Imre Deak wrote:
> The pipe BPP value shouldn't be set outside of the source's / sink's
> valid pipe BPP range, ensure this when increasing the minimum pipe BPP
> value to 30 due to HDR.
>
> Fixes: ba49a4643cf53 ("drm/i915/dp: Set min_bpp limit to 30 in HDR mode")
> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>   drivers/gpu/drm/i915/display/intel_dp.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 2b8f43e211741..4d8f480cf803f 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -2697,6 +2697,7 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
>   			       bool dsc,
>   			       struct link_config_limits *limits)
>   {
> +	struct intel_display *display = to_intel_display(intel_dp);
>   	bool is_mst = intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST);
>   	struct intel_connector *connector =
>   		to_intel_connector(conn_state->connector);
> @@ -2709,8 +2710,7 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
>   	limits->min_lane_count = intel_dp_min_lane_count(intel_dp);
>   	limits->max_lane_count = intel_dp_max_lane_count(intel_dp);
>   
> -	limits->pipe.min_bpp = intel_dp_in_hdr_mode(conn_state) ? 30 :
> -				intel_dp_min_bpp(crtc_state->output_format);
> +	limits->pipe.min_bpp = intel_dp_min_bpp(crtc_state->output_format);
>   	if (is_mst) {
>   		/*
>   		 * FIXME: If all the streams can't fit into the link with their
> @@ -2726,6 +2726,16 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
>   							respect_downstream_limits);
>   	}
>   
> +	if (intel_dp_in_hdr_mode(conn_state)) {
> +		if (limits->pipe.min_bpp <= 30 && limits->pipe.max_bpp >= 30)
> +			limits->pipe.min_bpp = 30;
> +		else
> +			drm_dbg_kms(display->drm,
> +				    "[CONNECTOR:%d:%s] HDR min 30 bpp outside of valid pipe bpp range (%d-%d)\n",
> +				    connector->base.base.id, connector->base.name,
> +				    limits->pipe.min_bpp, limits->pipe.max_bpp);


pipe.max_bpp < 30 will be either due to the max_bpc property set to less 
than 10, or perhaps when the panel itself does not support 10 bpc 
(limited by EDID or VBT).
With these constraints doesn't make sense to enable HDR and send HDR 
metadata.
However, as we see in some reported issues [1] [2], in practice some 
compositor seems to enable HDR by default and with the hard limit set, 
they report blankout.
So it does make sense to raise the min bpp limit only if its inside the 
supported range.

Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>


[1] https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7052
[2] 
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/5969#note_3248404

> +	}
> +
>   	if (dsc && !intel_dp_dsc_compute_pipe_bpp_limits(connector, limits))
>   		return false;
>   

