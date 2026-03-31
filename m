Return-Path: <stable+bounces-232593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MqmBeRHzGmTSAYAu9opvQ
	(envelope-from <stable+bounces-232593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:17:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B89F372599
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2803013484
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131A74657E0;
	Tue, 31 Mar 2026 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUB00m/d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F38845BD6B;
	Tue, 31 Mar 2026 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995221; cv=fail; b=X7rzlkx36mUo8S4ZpitTB9Wl24Cv/AYwTbS6WHYxXOPqIzjph4+bDuEZNaWob+x9QrzZJR95UXBCAO7WEj8M37dwqgy5XSKpYFKd18zU6vL6CMHD9C3cGzs8/bnTSl/3mDPgqSMDMthzLNjLdJ2PA27QcJPaRwR5vpk3wARrYrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995221; c=relaxed/simple;
	bh=5f3uphekpPFJTx9aR8X+QbB2ZgAV7h1uz9zOd9ALjGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FauK3UjdEucOijb5vXfYztsq0dqidlMemu8lnSOUdVpGfJ9OkVGj1oODkcdhsYxn+2Z39TENmQ9LG4laL7IYSw237ygXS642+kyOj8CP8TWBuYrg2/S/hE7gI5iztHAiiV8+SY9pB3z3yCz10hkI4W009yXLzQRDi3A6Nnog1A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUB00m/d; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774995221; x=1806531221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5f3uphekpPFJTx9aR8X+QbB2ZgAV7h1uz9zOd9ALjGY=;
  b=ZUB00m/dYV6MfUl04DkO4oFKTTx7Oubdmor7Kt8fTdm7TsOgn9x37kQc
   zDZu9RcMGiFXkPC6HdmyCze+i5z9nmQZDGZuY31LNG+ojqGiC5FC5Ucdo
   GBrKpgqSN7DpbFwurEEXA4mJUe0S3URCbFV23E1ucYtOf0I3xtBIc71Kk
   wBYiPZdyJfN5JRWiRSETmKqqqhfdaYNKpv/1AAHGJyJpVZm26WEbOayH0
   TqmaheUqNOInaIfPeUA2v4nuK/BXtaSwt3FquZhPa4LbxzNqtfKUGe4jA
   oHpt8wEdet+NPZQoEu1l49ZXprVSr+ByjCHM6kxaGdJQF67Pc7AJ29soz
   Q==;
X-CSE-ConnectionGUID: 1Ia/LsXwTK+9SwEOuQsTKg==
X-CSE-MsgGUID: g253rPKxSl+35Sex4myWaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75916790"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75916790"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:13:40 -0700
X-CSE-ConnectionGUID: oWfCvUTnTGC+mVM2PXYtRw==
X-CSE-MsgGUID: r+eqPdoMQgeeQ81eqm3WZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="228093800"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:13:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 15:13:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 15:13:38 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 15:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0vd8xulLcYz2xUNrPmy+bdGyCJCA2tUh3U2cRbIo1oTAUMK6vHefDeZFCQsM8XN2uAQn3Z/YHO4NshSg6eDrXMs0acBOqfvAytci92iUIVU1nGDeU4Bq9MnWfNwovf3a0//6sHGIdViuNHLIO7kx0ctZjRL052Tzh9t4CwAxB+PJDQo0JlaSSDpNtem7bC6feWc4SkGdRPXbKxPa8S+AMyg63yNyJRNA+ZNFpBrK70YRgV5GpnSDEOxe1O8Nc5l2HIgnmnR+/V5xuqrOu3BK/bmiSZCIevJoRWglGgwsBEKIj/aDczaH9S9pflPXnLmRbs6twi16Agb5Hj95SuwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f3uphekpPFJTx9aR8X+QbB2ZgAV7h1uz9zOd9ALjGY=;
 b=BsX6qGXzltnmZJi4oPKiHsdtvjH3RM45+kLW0PvjkSOtZUIo0pLhYwlojZXfXa8sQdMPXvpPgXpWTVjSlMwlfHThDn+QATnkpInadbpn/X15H1bjs54TnUDq0JQLl33fpFDBF987mZQY8D8Rcfk6epmJV0gck4NCe7c+hLO+0Mq2/d1SUUWzJ3yLKsAsoGau5XK8msh65XgyV6BFRaWrB/4181iIcdpWkisELXZxqVz5N4qzcHWLrGGEIAkNK8cMH5Irmw9yp4kOJ8PC7ub5Ue5yAAEFw/YJcO8K8QVAGVGWYwhmKV7Y4Xnl0BVwSr3293Ac/m0NU7j5C/xShDpWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CY8PR11MB7945.namprd11.prod.outlook.com (2603:10b6:930:7b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Tue, 31 Mar 2026 22:13:34 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 22:13:34 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tsyrulnikov.borys@gmail.com"
	<tsyrulnikov.borys@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Thread-Topic: [PATCH 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Thread-Index: AQHcwQHewGMDj1nIL0C/CFqs0Av6JbXJNTQA
Date: Tue, 31 Mar 2026 22:13:34 +0000
Message-ID: <baa91fa31ced03b4aec120e0eb8fedb76b560292.camel@intel.com>
References: <20260331112430.71425-1-kas@kernel.org>
	 <20260331112430.71425-3-kas@kernel.org>
In-Reply-To: <20260331112430.71425-3-kas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CY8PR11MB7945:EE_
x-ms-office365-filtering-correlation-id: 72e19aab-b32d-455d-7ae4-08de8f72c02e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: ojtwBHFqNsM+qhSGGv1IpFkueyyZ82+uap59syMZSM8FmQRLrJoRNNqt0+5u5Q6Sf8e8KUcmMfr8PCVnqXif8T0NkxKJl2A8AH6LHFoYjNKFD/fllFtjTp/Ie1KwrSkoGIRhiGsCXuVNhZyxuskT8bqcd/OqPmqYvIyH9Gr+YrBsiCxjYnHcpkwdDlQsyr13LeUnl20kPM2nnFWVGS1aFovkkLsWIJBIeHNgd/ZZuURbIpupS0B7fp9bMi5nLJmmOnLQ4Ke6ksARYC9vlfpWvxu74YbftQaDVfrM7BROo89PJeEy/OknVTk+3k6Hcc5CsUSBk7rHE2yrGltzK/1KEZuyx4qBWFfwxgzVM1GCQz/SYioSrFr6wI7RcRiLO0D01wI4Uv95kba+WLhKpUE3RGJ/x9kTLUuqVf1UyVdJZxlve2YXtJtCoHVbXlOUf9aVwXiNP8DkfVB+KgB+EsWn+mOfFjV/B4gnggjtnhKXmRRA8sNDG3VhsXHn8kpXPeFYbXKo5T7cMn1g9pEze+sqcHLWtcmt4rYz883UauEul7oN2llpjDbrOVigmwXdShjqTKVilhDSAWZA+Ob8DDEzJj4AtzIZ9ez8RnY+iA80LbfKdJQJaTMNW2qLX1xMagpVrFKBa30XOeW7kbUIyM47dclb6xvdyAsMDz3S1MKdF/RnDn6cUBmCmOxXbZdxS2PNzYW+sccgUC7OF9W3Yzzc3VPgeOMjnZiFSZIxTdkS8hdrsGYEiuLWvHVvMeVnT5zJv/gjKvb4pA6O9M+9S80Kdx8r5rPsd83ZKvj0JRgETmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXdVbEdCc1FOV3B1U3hBOWdLUXBDNFdsdHp0eEJNWTQ4cHFiaWl5U241MGls?=
 =?utf-8?B?TWt6NVV5NkhNKytqWnIzOVFvemxObktNTVV2NHF1dFl2cEJnZHJtRUUzNSs4?=
 =?utf-8?B?MDI0c0FQNjdhR3U1SkkyaGJDQkFUS0duTTNuWTA5R0NKMktlQ2xONi94eU1F?=
 =?utf-8?B?c1RveWtpSHFjTDB5SnM2QUd4a0ZnT3ZtWThCTktrRkRzRFZsemdnM0VUeWJ4?=
 =?utf-8?B?Q2tWODAwOFl2ZDlsWFBaaU95RkhEUi9PbUxETlhZUlFjTnJDZFIwSVk2RUlY?=
 =?utf-8?B?UGhoWG9pQThPUldxOGY1RGVhRXcxTXdESG44dzVZbzR2UmFmTEhTcUgyemIw?=
 =?utf-8?B?QWNzWjdjMytTd0VOdmc3Q09DOElreEJuU2hZelI5eWFyVitqWHlJM0hPMC9j?=
 =?utf-8?B?Ukdrc2h0ZXVlREZ6QTZVemxDcnB2ZHE2aEQ2WHRTZmVnZFBlaXFmWnJOYzNK?=
 =?utf-8?B?ZUkyM2wyRzRXdkNOanYvSjB6YStYNDVNNU1hK3phSGliZlUwU3VyM3h1a3lh?=
 =?utf-8?B?dHlKUHBIaEpsc2RQYUtvbFJaRFdEeVdLSkRubm1wT0UvUk9iaG4raTgzdlVU?=
 =?utf-8?B?TEFERnYxNTZIU09xMWY4T2hZOGlRdVlLVkdJeWl2QUJDS1ZPeUxVSHZkd2dx?=
 =?utf-8?B?ZDVzZ1p3RTFjalBhd2hlOS8ySE9DT21JM1hITmU0NWZKbmxDM1lsUm9QdlhU?=
 =?utf-8?B?K1MwUnE3bjk5YjJWUjFxNktKNFV1SDdTOUZ4WEJDbDBUL2RucFRLaHZ5cEJX?=
 =?utf-8?B?ZGZCbWFpektCWEllUnZreEpxQ3RKVkIwb0ZvZkhYUWZRK0hFMmh0dzZWQ3Vu?=
 =?utf-8?B?RmhRTHd6ZTUwN0FOcDdvczBZdUNLTlFXdUxvbjFsZTFjSFN6TEcrUTBmSGZl?=
 =?utf-8?B?eGFnSnhsM0NGR05WWHRrVGRxRGFSeVpYeGlFcEthL3pVRGtGSDJEZ2JkUlpn?=
 =?utf-8?B?dmNWWnFPN3NQZVZiK0RHQXJEZ3lLR0RkZkp4dXFiV3ZBQWlrendmZC8rTEhM?=
 =?utf-8?B?V1V1QWN4VEx2NDMxVVNaMzdTamhwNkVYRVFoRllaUzVSSkowUjhTdjVOUVpQ?=
 =?utf-8?B?TXJkeVphdmxibTh6b2VTWDlxV2xkc0FnbXNKbHFrUmZBeW93YWlybzlWTE02?=
 =?utf-8?B?MUh0SUlRcEd2QTVueTdLbHRWdGlOVktObFFuNmdFQ3FSc2VQclZrS2lUano2?=
 =?utf-8?B?TjJTNGFVcXJGbDlzN0grcUd2clR4NDNHUzFNcXIzaktMRGI4Q0dSbVNkSmVD?=
 =?utf-8?B?M0dFY2VFMUd5K0R3V1FIVjlXL0NJNWtMM1VPYUpMdUFHanQ3ZmhnOUdKZTRO?=
 =?utf-8?B?WXRwODNCeVlNUFEvMGFTMzIyL3ZuQnVZTG10T0tHNUtzVGo2VU85WFMrUTZ6?=
 =?utf-8?B?cDdyVmxHTkoxSFdyanlZdyt6R3c3YnVDOGR5QndFTWdOT2thTVRPZWVaYmEx?=
 =?utf-8?B?d0IxWEl1VmtEN2Zwb2FmTGo0WFplY0VEUmZEQUQxeWVicXM0UjB3dVh6MVZa?=
 =?utf-8?B?a0l5YzZXTHRaa1dtYVhpL0hBMWR1eXVIWnEvc3ZKTEEvN0RVUllvMzk3bHda?=
 =?utf-8?B?VTUyZTJIZzNadWJaNlNRc0o5eVNjWjh2eU8rdlNWc3dXT3ZXVm9yWUJ2NGRF?=
 =?utf-8?B?MjQ0UXZLeFZCMzI1bkVla1E4ZTdmMHlFTVVOTUk0Sk9vTXROLzVCOFprVThB?=
 =?utf-8?B?NjhwL21TZno1eEh3OXYraWlScm5VckdSTk42Ym0rWGxWRDV2OCtJVlFNRDNp?=
 =?utf-8?B?UGF4SGRmdEt5KzdIWlJvVjZtYlM1NHF2ZGtxZnREY1VsS2MvMVRQUVFrSmRa?=
 =?utf-8?B?Z29EL1Z1cjluS1gzTm05Y1VKQmdwUW5KU2FHUGZVRlVRTXFNR2p6UVpyUXo1?=
 =?utf-8?B?Y1Q1MXdvRUNWVkpVaGFzM21paFZvRmZOelJRZ0hLekFpSnpjcDAxVTdqbVFy?=
 =?utf-8?B?c3FVMXZXS2c2RldDcjdRYU1WcFd0Wi91QldsRGtBcXlKQWhKZ0J2c0w5akY0?=
 =?utf-8?B?aWg4b1MyZm1XMitwZU5SYUE1WWJtcGpiSWNHNzJ6MjlXdytmNDVCUlFPd1dp?=
 =?utf-8?B?T1BPMUFHNzJYb04yVEhKT1NvTXRpb0tjRnc1bSt2OHhKdHZqWk1pOVNiTEZJ?=
 =?utf-8?B?dHhaRkkvazZQWDRYMFViazVpTnFSQWxTZUlaTm42VFhzNUJ5bW9uVDFJQzhh?=
 =?utf-8?B?QktFaGtLYy9RYkFCNURoYzN3Wk9tMlFPYjRqd2NCZDNSYXpmLzE2ekQrN2ww?=
 =?utf-8?B?ODhObUNqQUozS0xSTWVVUlhUOE1lZC9sNm1QajM1N3Y3emMwa0Q3VEd1SzJP?=
 =?utf-8?B?RlQyR09aMDBncDRVbzYwcnUyWXI2K0ZWOXJlRktXY25PeXJmNDBBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D5E3BB475E5F43A3DC4470C630E26E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: awwV7dX292uw7mqJIsUGluFdoQNyyeJqFbExVFoafFUUH4u+ytwonypHsxeyHp+GzZi4QsSmU0hhmuFlLxpQwbI4eZ/vY1FAAvUyZzckhFwXtjIMT10kgf1mX+zRW+n1nu31T9zpM96Ae/d2iz1xToEatgxCd5NZnPambteE/tgFd6FrZIOl0DGhLabYmvNwsAPoHsRlwgee8/LfMJxxB13QqaWQOY6mlfb1bsXRiyZ+03q1dyAMILKpxsbrSCjD2FsRaBY73oKfKpfY5iDK4ZACUSLEU4BTAyvnd/mEX3Et+eO/pNJg+GiqnBs6NIpBHPoh0waKh6AcsBOR8gQ37Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e19aab-b32d-455d-7ae4-08de8f72c02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 22:13:34.5939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJ8f4onRNSovZCLyGOsptLtgL7wEGlTlhYq8ZXEkBfwZ/WxILhbnhRim9bStjbmsqwfOz/TwOdLauwx44vJWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7945
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-232593-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,zytor.com,linux.intel.com,vger.kernel.org,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 7B89F372599
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEyOjI0ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEp
IHdyb3RlOg0KPiBBY2NvcmRpbmcgdG8geDg2IGFyY2hpdGVjdHVyZSBydWxlcywgMzItYml0IG9w
ZXJhdGlvbnMgemVyby1leHRlbmQgdGhlDQo+IHJlc3VsdCB0byA2NCBiaXRzLsKgDQo+IA0KDQpG
V0lXLCB0aGUgcmVsZXZhbnQgcGFydCBpbiB0aGUgU0RNIHNlZW1zIHRvIGJlOg0KDQogIENoYXB0
ZXIgMy40LjEuMSBHZW5lcmFsLVB1cnBvc2UgUmVnaXN0ZXJzIGluIDY0LUJpdCBNb2RlDQoNCiAg
Li4uDQogICogMzItYml0IG9wZXJhbmRzIGdlbmVyYXRlIGEgMzItYml0IHJlc3VsdCwgemVyby1l
eHRlbmRlZCB0byBhIDY0IGJpdMKgDQogICAgcmVzdWx0IGluIHRoZSBkZXN0aW5hdGlvbiBnZW5l
cmFsLXB1cnBvc2UgcmVnaXN0ZXIuDQoNCj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2Yg
aGFuZGxlX2luKCkgb25seSBtYXNrcw0KPiB0aGUgbG93ZXIgMzIgYml0cywgd2hpY2ggcHJlc2Vy
dmVzIHRoZSB1cHBlciAzMiBiaXRzIG9mIFJBWCB3aGVuIGENCj4gMzItYml0IHBvcnQgSU4gaW5z
dHJ1Y3Rpb24gaXMgZW11bGF0ZWQuDQo+IA0KPiBVcGRhdGUgaGFuZGxlX2luKCkgdG8gemVybyBv
dXQgdGhlIGVudGlyZSBSQVggcmVnaXN0ZXIgd2hlbiB0aGUgSS9PIHNpemUNCj4gaXMgNCBieXRl
cyB0byBlbnN1cmUgY29ycmVjdCB6ZXJvLWV4dGVuc2lvbi4gRm9yIHNtYWxsZXIgc2l6ZXMgKDEg
b3IgMg0KPiBieXRlcyksIGNvbnRpbnVlIHRvIHByZXNlcnZlIHRoZSB1bmFmZmVjdGVkIHVwcGVy
IGJpdHMuDQo+IA0KPiBGaXhlczogMDMxNDk5NDg4MzJhICgieDg2L3RkeDogUG9ydCBJL086IEFk
ZCBydW50aW1lIGh5cGVyY2FsbHMiKQ0KPiBSZXBvcnRlZC1ieTogQm9yeXMgVHN5cnVsbmlrb3Yg
PHRzeXJ1bG5pa292LmJvcnlzQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogS2lyeWwgU2h1
dHNlbWF1IChNZXRhKSA8a2FzQGtlcm5lbC5vcmc+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQoNCj4g
LS0tDQo+ICBhcmNoL3g4Ni9jb2NvL3RkeC90ZHguYyB8IDEzICsrKysrKysrKysrLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jIGIvYXJjaC94ODYvY29jby90ZHgvdGR4
LmMNCj4gaW5kZXggNGQ3ZjcxZDUwMTIyLi5iOWI5YTJkNzUxMTkgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gveDg2L2NvY28vdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jDQo+
IEBAIC03MDMsOCArNzAzLDE3IEBAIHN0YXRpYyBib29sIGhhbmRsZV9pbihzdHJ1Y3QgcHRfcmVn
cyAqcmVncywgaW50IHNpemUsIGludCBwb3J0KQ0KPiAgCSAqLw0KPiAgCXN1Y2Nlc3MgPSAhX190
ZHhfaHlwZXJjYWxsKCZhcmdzKTsNCj4gIA0KPiAtCS8qIFVwZGF0ZSBwYXJ0IG9mIHRoZSByZWdp
c3RlciBhZmZlY3RlZCBieSB0aGUgZW11bGF0ZWQgaW5zdHJ1Y3Rpb24gKi8NCj4gLQlyZWdzLT5h
eCAmPSB+bWFzazsNCj4gKwkvKg0KPiArCSAqIFVwZGF0ZSBwYXJ0IG9mIHRoZSByZWdpc3RlciBh
ZmZlY3RlZCBieSB0aGUgZW11bGF0ZWQgaW5zdHJ1Y3Rpb24uDQo+ICsJICoNCj4gKwkgKiAzMi1i
aXQgb3BlcmFuZHMgZ2VuZXJhdGUgYSAzMi1iaXQgcmVzdWx0LCB6ZXJvLWV4dGVuZGVkIHRvIGEg
NjQtYml0DQo+ICsJICogcmVzdWx0Lg0KPiArCSAqLw0KPiArCWlmIChzaXplIDwgNCkNCj4gKwkJ
cmVncy0+YXggJj0gfm1hc2s7DQo+ICsJZWxzZQ0KPiArCQlyZWdzLT5heCA9IDA7DQo+ICsNCj4g
IAlpZiAoc3VjY2VzcykNCj4gIAkJcmVncy0+YXggfD0gYXJncy5yMTEgJiBtYXNrOw0KPiAgDQo=

