Return-Path: <stable+bounces-223272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJwONUj3qWk/IwEAu9opvQ
	(envelope-from <stable+bounces-223272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 22:36:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C18218890
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 22:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9ECA304C7E8
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 21:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE7D35E94D;
	Thu,  5 Mar 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKEF9FYL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85701354AE2;
	Thu,  5 Mar 2026 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772746563; cv=fail; b=CT7gx1iUp54mhHwLzgeiFtUJIHB7fNaW04NFgVOdXvXWc1Tcyyyd4XBc78XhG3sPM65dDEXleZ2vHNgWmbglVPOY/VnqGlOeBRK/ha6K0R5RFq0MJmOvglfXtqV8yG1PszorYDdFXO82ZilJFKvIBRKpj+PDTIhQVNDDJoE9zV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772746563; c=relaxed/simple;
	bh=MZMjE3SClE/Re8xbBWaR+nWU/R6PrTHCBR8L6/NP7AU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BkJj2xa3oLfc85BWZmlQ8omsJOYOAy5u7MQFyTBM/IqpSt8uiG3a74KotNv8/9XqTCxTAfQt1F8VS6izUk3QAY48RUV9QTTOzkfcR03FL6/yS86zY0sdu9PfCoQe4mmZwteJ2kcDbLlSLPC2z27tKcQD/dNDlg8Q1IlLI5xPsnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKEF9FYL; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772746561; x=1804282561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MZMjE3SClE/Re8xbBWaR+nWU/R6PrTHCBR8L6/NP7AU=;
  b=gKEF9FYL/U4o1mYa9KMDgAVRP6UWZmiCTrDLN/jIMZT7o5IvFU2PuEc8
   EBmjM6IkOQI835jqhhx/8nakmICcWIrO5OIHC3Nu3UnsaSwMssBIbGrjQ
   rLyPOeizg8YasfbYoR4KQeKDuv7d1968BAFHYcmYCn3Xj1Ey4yfVWNi41
   sPXt4t/QLbgXZYLC3eSf0XYkAcGR2XRx7Ippe7AHU+UGRtP1BbFxX8U+u
   1CXZGhcvXKlpo5rd3Vll5+Wd/kwAe3WWJLQe8rYzMGfKtpbA5UoMVjRi3
   Cn8Bt71tWy6h2+CIe7w1stZKzx36JI5Baecjl6mMH0M+Q8TILgONXLu2D
   Q==;
X-CSE-ConnectionGUID: /5qLiyaASc6L0eINoPX1vg==
X-CSE-MsgGUID: s0WWrR4GQBaY0H23JIDqFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85321570"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="85321570"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 13:36:01 -0800
X-CSE-ConnectionGUID: ZtAZZamHTeyjEXCRA49Zhw==
X-CSE-MsgGUID: vfDw2adSRZ6RvqNClzGIiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="223298048"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 13:35:59 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 13:35:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 13:35:58 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 13:35:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhVBPTQsb0LU23UsUdOC8zroFRf+qAr37TTvvO94oFMGOqy4czKkx1wFAwyJPMKf6rd7T+6w4/5gxlJlCFmC3Na02GpIj1o6M5qbVI8dApGxfZoZDmQ6jfJgE7oQ77iovO7USz1hn/bVq2Y01SwZl8Fk0sP96DndIS6yVZoKiHREeSYOZCT7Nzz7zwN+OOwO87Y48PvDS0DojC9IKqFSjql31yFz1V0bJaxbVg1T1L1x+kGl6SUugqQM5FEe0ILJNPkAsUY7n0hEMcKedXx+iMKRdq2WpJfLTK7KY4JqF4WhgB99wov6P4Ng75qmtfCPewq8t+wcoicuhwEhDSpkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZMjE3SClE/Re8xbBWaR+nWU/R6PrTHCBR8L6/NP7AU=;
 b=KVaXTHAoHZaAQbIpMk8eOTL3RWDffQH9KvY+1Vcamlw0StqmK9aqC6L7x4JnH7TWzeHwqDiTPsr7Hh5H9OwjIS7D1UeeK/31+kIFMLqTp4ZVNs+m0PTTFs0sFM5RN3YU91fq45viufpZe6UD74eGp3GF06pbMfA6Aviz+GNV4rLDa6bOYB2Z5vM/hDlP6yBT4ds6XxFzBzCqEabbvbOr/3JhA9k5CtUNPH8u4JXv+8OES6NFzCgMqLkIJ+VvXKna2YA7mO9QyPSRWPhqQAc7PX/QlfBWO5dHseky4TTMdu8JEJ8o4er0EZbJEk70bd+tKRL7ELgsYNUmwQ6W4AgVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB7735.namprd11.prod.outlook.com (2603:10b6:8:dd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.17; Thu, 5 Mar 2026 21:35:53 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 21:35:53 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Topic: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Index: AQHcqi6XsnrexK/sl0+dSWKh02Fmb7WgSOOAgAAy04A=
Date: Thu, 5 Mar 2026 21:35:53 +0000
Message-ID: <51e221b9bcdeddffb95f2c39dcc285fb0e9f5951.camel@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
	 <20260302102226.7459-2-kai.huang@intel.com>
	 <4a15470a-5a10-4742-9faf-f66a88105d58@suse.com>
In-Reply-To: <4a15470a-5a10-4742-9faf-f66a88105d58@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB7735:EE_
x-ms-office365-filtering-correlation-id: cff4d2e0-3e64-4fb8-c4cd-08de7aff2db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: wQxpq0ZNXZ4LlHmrk3upKtsD2b7pSjNzzDQ3GNFUFgmVQA4ONsYv33UWOKGRBJHxaycqrrLGmVThrWjmNOVCLczV92Y61YCrFSAITvHetFeI3VQhmlMlU7Qw6YT5PjzCi4IrpaOSUdFaCFnlcChEmIJMfLB4q8WLJ0p+BXd+0SKTerf8uzWa0MWYFvsxYuRQ/XHpYs/tjLNI+QNTxYhsMNgtqN3lMJaAjFuXPn/2KkRyUbgZEr9evZgR9BH71ZV4Ovp+9E9N94L2iFaBWBW6kIpUuqL+MLk21Na2xsGmWqQ9QEmYrkjClhCZNO9/99kSGaQUHqFQImbwMQevTyMA/zNQPpffcGOK+aw7WBbmVi7Z8oJWzw3pZY0pZ1oUhEPZ8N8zRfBhndNBv0W07jPnBMwM8GfeOudGf3K2j/QnPX6W1Hn9kbhVaMLk50Yno8gDqWFizY8tHdf2mjEGFdfn3LwMnjC/hO6ts+Wc9G11EdAHo/jSEytpw3poyGJc8cUZ/U8q17hglDFQHAlPYsDkasYG/Tp/+7oWDHYqOZxIVioYzlcvBQKt0+aNrZpQ2aB4gyaFF/6YObYUESc/D15EkMSFTYVYv6s5wzQ2SRRcJmYPnQ70B/Hzq0sEME3vDbvlD/UgvjOtb6c1dgijEFhD3Dzn4F2eD6X98ziAmb8vdiahgQgincbPMbts4xGd2VqO787TIYKwkVlMCW3TcJvRYu9Mq1uE9aCWjfOWByjHLyWbRbjFShNuwJLYNx5vCn91oIKM7jEdxoIU6dn2Kom6wavjw//dkZdwigowRYwRmhU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zzh4R2h1T2lldWlaMHFCOUZ0dlRrc0owWmxsZnhXTEtMK0NFbksrcVRIbTVl?=
 =?utf-8?B?WWhqY0hzQlhuNEpsZzhvVjZxbnlETDcwcXBkSFNWbkhwY0lDbVI3dCt0bnVn?=
 =?utf-8?B?N2k3cnFFR0VxSzhPeVMwUFU5Qk5GWjZ1QUhiUm5xeEJucmk2STRmZnVkKzN3?=
 =?utf-8?B?ZjlHd1pJOG5VM0llNHJOS1UrZ1k3R0Y4OUNocGg3MlZVUXdETnVyZ2VMOW41?=
 =?utf-8?B?aGlrSC9qSFZTbXA2bmd1WThJLzZHcDFzc1RvbkZ2MVNwS0lGY0FWdXpiTFpK?=
 =?utf-8?B?bUJiR0xkbm5xNUI3N0dYbUt3eHhyZ25zZG9PYkZtcHNoUVBzSnhSd3Z1czF1?=
 =?utf-8?B?cnRRNkh3TU91UG5GTy9BcVhrZndPUkRETkIreXpic3BSQVRuV0FCYlhMVU1s?=
 =?utf-8?B?V2Y3VmJRM0dlekVXQXJiQ3A4eFlhcGVadEd3d0xKWkpmZTAwT0ZXb2ZFbmN3?=
 =?utf-8?B?L0NhT0p0anE5NTdtZVNsbzhUVHFUYXhuMHFGa1pod3NLcXlNY2NURkZFOE5B?=
 =?utf-8?B?VndqMWE2YWFxVzZKd1F1bUlQL0dZUGdKb3lXdU1ZbGh2RUV6SFJ4RG9YbFpS?=
 =?utf-8?B?S250elhoOTB4dVg3QUdLcnVRRWxUMXdVL09BbDVEenIrOUlNSG9FZHNKVFNX?=
 =?utf-8?B?M052R0VNc3M0Um5yemFtWjVITExnVkladVBsdWpqVkZLL3UwQ1R3dXBYM2ZU?=
 =?utf-8?B?eVUwK3JkU2M5MU5xTjUvNFNqbnhjM0xhWUIzcXd5UHlWSk9oMkRtUkhoc0RV?=
 =?utf-8?B?ZDYyQVd5clU3dEhiWVROa0cwMEtuWFgvRnIxQ0gzdmJIWURubmhxd0NMTHZz?=
 =?utf-8?B?dW12b0VFTUJnMDI3ZnN4UUI3YjBnOGR3UTdPcnlhN1hLNi9WQ1UyYzhFUVFQ?=
 =?utf-8?B?TkV5YVZ6L3Zzc0VsVHp2ZERPU2lCTFNXSVR1S3phSlFwRWpHMEpEaFNkb0k0?=
 =?utf-8?B?Z0sya09INmhYYnpteENrVEovOVh5K1pFL2ZGSVhRc1pFRmJpMVR6U2pZL2JF?=
 =?utf-8?B?WFdPWldhZWMyemtYWTZpYm1senh3MERaWlFmb2ZLSktTbVVVOUdCZnZIVnJx?=
 =?utf-8?B?VldQdFVkaTAwRkxpb2dpaTFBUXFOTUQrYklwakNnQ3hOSzMvUzM3YzN2QmhX?=
 =?utf-8?B?dEg5ZVhWL0ZzcS9VSzY3SGNCUGtlSGFBZU5VcksrUklBdk5vVUVrRTBmZnZH?=
 =?utf-8?B?RVNnOFNELytCblpWU0gwQ1kwQUxCdGZsNlhzTjJKL3pDMmZqSHBtUHZRVTdW?=
 =?utf-8?B?QjlpY3V1OXFvYVR3dEJGWXV0bXVHOU96Y1ZqSnZrbGtncDIrZEE4S2hjZmlN?=
 =?utf-8?B?cHhEcllSWDNjSUNYTVdFakhyNjVrV0oyanQ0VEdOOEpqbFlEOGFFY053SVBW?=
 =?utf-8?B?bXEzRkVzM01BdENybUVscUwyRWZZNkYwQjkrN1FsTWV2NTJiR21lTmo4bDE1?=
 =?utf-8?B?d09mS1RYQVd1ajhEMDBoR0lUbVFmeVNJN1Nscy91NTZ4YmF5QWczeDMzZ0NJ?=
 =?utf-8?B?RGpqby9FbGI1L2FPS0pTa2hQUVZsWDVIT2g5eHNlbmk1ZzhxeU9Gb3pVWVpX?=
 =?utf-8?B?NWtnT3dHTWU1UEZCbGVpOWFYZFJvTDdQNndOcHV0aU1Qa00yZGk5THNKaitD?=
 =?utf-8?B?MVpnNm9XVXNEK2RLeHlyNkYzSTlsV2ptblNOVkQ3QkFQc1R4Y2lzNWdXN3Zh?=
 =?utf-8?B?MXpCdGtQSDNTSCtCK1hLUXROVEhobE0zdTcxb3Fka1NzTlBta3laT2dEaEgz?=
 =?utf-8?B?dlU4bzFHeFBabDhOZUR2RWlBNlJ4YnMxT0FsbVdUUW5UUjhhdHM4TUgrK2E2?=
 =?utf-8?B?UUJxWitzR0tuWVA5V01TQTNZL1VLa0YyT1hBTksrNDQ0d1B2dWZKUnl2aGhh?=
 =?utf-8?B?TVhDamsvTUE0TEhDWk90andweGEzbkpNOWpNaklWbXpBMEdJWlhTUHl0QjhV?=
 =?utf-8?B?Z05uMW9BMHZJVkZ4dWFDVzZ4YzRRRGxqei9ENXRKUTV5dC93VDgzODlrbmlP?=
 =?utf-8?B?cERwT2FzY2YzZFhuUW5BclZNZzMyZ0JQVkZnZ1UyNUFzdENzTFNuRlZrZDYw?=
 =?utf-8?B?bDNXZ2ZYMEM0MndtNGNmOVlMekZWZEtYRnl5MGxGdkk0K1QwbmwxVUFxTm1Z?=
 =?utf-8?B?UzNMd2tkSzBCR0sxRVhsc3IzMFVOdFZGQW1EMC91WCt5Y0h4NEFXcXoxa3R6?=
 =?utf-8?B?WktIRG5xRkNWMkN1Nk9GQVJnK3hHT29yMEhIQVFLQXMwTmJqS0hVclVQSmtz?=
 =?utf-8?B?VVdyaFo0WnNzOGZweUFUNDliR0tWWTFibWxBSXlqeEI2M3BuQUgyVDI5dDMv?=
 =?utf-8?B?MFZ0c2lvSHl1b2VENnduSXlEeGtrMktIeDUvb04wTk5Dc1dObm9DQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A81F4A02A047443BAF5189CCEC8ACAC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HJXzrKaJFMFerjD3keykA+pcEXwhMMt1x/VQ2eFafj7D0m38pB0I7X0aJcivjnS2qibV0qzVlAyyTjDZbU9kDAz8YYg8JO8p+JhnbXALQ3byFS0gQBBz3oxj95GHCa0V6EC3e2II3eRvIebHV9bpWAVlIdTMq7dDXqIiE9DSY7g/aNjHDyUFqk5Al71KGwL12tInxvIBe26vaD7vzcJ4KP2qZtJWjh4/XrL6znKPSz7wdAI33bZZFnQx9gHxX0VFJRy3SwZAAoob+ky3TPGbZIKUIXCD2ToePvoRvjCD5e2KlIuRxq3L+HdqfSxpfQ15kk+iKnBdP/5V+UxotcMxyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff4d2e0-3e64-4fb8-c4cd-08de7aff2db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 21:35:53.5153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BoaPQjFH2aKn3y4gBorr9tejkeaI3GlSfGVcMh+Nyq/zFxOSrTOnMdyf++XMVdMKi6u0rzTPbiS7NWK7yXzqQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7735
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 36C18218890
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223272-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQo+ID4gDQo+ID4gVGhlIHJlYWwgcmVxdWlyZW1lbnQgaXMgdGR4X2NwdV9mbHVzaF9jYWNoZV9m
b3Jfa2V4ZWMoKSBtdXN0IGJlIGRvbmUgb24NCj4gPiB0aGUgc2FtZSBDUFUuICBJdCdzIE9LIHRo
YXQgaXQgY2FuIGJlIHByZWVtcHRlZCBpbiB0aGUgbWlkZGxlIGFzIGxvbmcgYXMNCj4gPiBpdCB3
b24ndCBiZSByZXNjaGVkdWxlZCB0byBhbm90aGVyIENQVS4NCj4gDQo+IFRMRFI6IEl0IHdhbnRz
IG1pZ3JhdGlvbiBkaXNhYmxlZC4NCg0KQmFzaWNhbGx5IHllcy4NCg0KPiANCj4gPiANCj4gPiBS
ZW1vdmUgdGhlIHRvbyBzdHJvbmcgbG9ja2RlcF9hc3NlcnRfcHJlZW1wdGlvbl9kaXNhYmxlZCgp
LCBhbmQgY2hhbmdlDQo+ID4gdGhpc19jcHVfe3JlYWR8d3JpdGV9KCkgdG8gX190aGlzX2NwdV97
cmVhZHx3cml0ZX0oKSB3aGljaCBwcm92aWRlIHRoZSBtb3JlDQo+ID4gcHJvcGVyIGNoZWNrICh3
aGVuIENPTkZJR19ERUJVR19QUkVFTVBUIGlzIHRydWUpLCB3aGljaCBjaGVja3MgYWxsDQo+ID4g
Y29uZGl0aW9ucyB0aGF0IHRoZSBjb250ZXh0IGNhbm5vdCBiZSBtb3ZlZCB0byBhbm90aGVyIENQ
VSB0byBydW4gaW4gdGhlDQo+ID4gbWlkZGxlLg0KPiA+IA0KPiA+IEZpeGVzOiA2MTIyMWQwN2U4
MTUgKCJLVk0vVERYOiBFeHBsaWNpdGx5IGRvIFdCSU5WRCB3aGVuIG5vIG1vcmUgVERYIFNFQU1D
QUxMcyIpDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBSZXBvcnRlZC1ieTog
VmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiA+IFRlc3RlZC1ieTogVmlzaGFs
IFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IA0KPiANCj4gU28gaG93IGV4YWN0
bHkgZG9lcyB0aGlzIHBhdGNoIHByZXZlbnQgdGhlIEJVRzogcHJpbnRrIGluIA0KPiBjaGVja19w
cmVlbXB0aW9uX2Rpc2FibGVkIGZyb20gdHJpZ2dlcmluZywgaWYgdGhlIGxvY2tkZXAgYXNzZXJ0
IHdhcyANCj4gdHJpZ2dlcmluZz8NCg0KVGhlcmUncyBubyByZWFsIEJVRyBoZXJlLiAgSXQncyBq
dXN0IHRoZQ0KbG9ja2RlcF9hc3NlcnRfcHJlZW1wdGlvbl9kaXNhYmxlZCgpIGlzIG1pc3VzZWQu
DQo=

