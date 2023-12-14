Return-Path: <stable+bounces-6717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2268129F3
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 09:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FE11F210B6
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384E15482;
	Thu, 14 Dec 2023 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/V04E2T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43C111F
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 00:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702541181; x=1734077181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=CpbYicKCriCK4CWs4kKw4euJbRTJsEtNNrgO0JGp0NA=;
  b=Y/V04E2T2SIvwS2OP6lsCCeKZeeriLSECfU0UjtIGz2viH3v19KAfEby
   uV7lg+EBp7PDvYZy0mLrgZzNpSzt4MRCl5DcN7d1WsPqEzJaC+P2hOKnc
   2FAuZjl9P8lmyNZ8bt9gx702LFlixQMO6z/ZWZYX6RSaS6hkSRpNSrqSW
   /9vEPtrAPaDltFq2cpfvbQjwOlmJVw7PI92KKBsVBcmJI7ZpDTC3+7Ef0
   e8d7LNR1k+W/AloKMWe2xrrf5G62ttSBeVkyBz3TyCiLx4+7b7w7FkgMS
   fh26PWV7fENqOkODk1BDtsXImR6PTI+/UxH7Xt2KLpOV3BxF7lvaGbfNL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459407595"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="459407595"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 00:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021426371"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1021426371"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 00:05:59 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 00:05:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 00:05:58 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 00:05:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTAyidJ1t+0SOL8o+gKmNr6CCQ9op9TOxHVsiKwDwRxBStPQMrE00NNxFViQagA302lUyxCBPeE3AavAjDCPXMdXfUfUZY00v8r3eHKsbxB+bvbXgSX5Et/w7xX7pI55XCMnTSp26RxLUIgJ1TuyDHh91RHZ/rUZBNJfGL4I09CTkfYIi69ytJxzMeCbh37XzJDsYXvFa1c6bCqh1D9kYSW698smlQzFOVlH59GyNE59awaK9zfE4Xq8pCDwRc16yykckYZU5Wwt37c9uacRqM61gpKf1NVwGX5VGrzLzNKygr0IM5RTQYuNGy+VCsCrfmBugWSfMm+aDhoASdCvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1T9lxMOMBCTY5gTF2TtNdiCpTNrIZDyhYlhvlieGe8=;
 b=LztlRyuBNCu5Np7R0blG0XQnCShqiK25rAAEcBe5K+1IHT5RWWZTqnBu/YuO2TkUHfMwEZZ7b7XVh0GLvWjNJ7TKy7WM91p4knI52H9FyYCjG7QW7BAzAw2RHo0aaBCOo+72xm2khVDjXZHfqvAbzZFzvEArslh6CuMKAsK8BL7OBceoPkzmh0SaArm2KUnFYCNPDjw+sFNMJzJAEDcRY9OZ0IoWq+B6al4V1gNf0QADmRp/oUf6fMcaCGy0xBOdrbKCmbIJVPyURrQgwrTqLBWbkjjwr9acCKE0VXdhWW34IEUlcYnKOs1MhmUDQExEwmZYszz+KdAkBzDvZDJ6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5359.namprd11.prod.outlook.com (2603:10b6:5:396::21)
 by MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:05:55 +0000
Received: from DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e]) by DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 08:05:55 +0000
From: "Berg, Johannes" <johannes.berg@intel.com>
To: =?utf-8?B?UGhpbGlwIE3DvGxsZXI=?= <philm@manjaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, =?utf-8?B?TMOpbyBMYW0=?= <leo@leolam.fr>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Thread-Topic: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Thread-Index: AQHaLBDPGcUd6QwgaUOjifUHynaWLbCjz9MAgAAARQCAAAOiAIAAAW8wgADU6oCAAzjYgIAAjRnw
Date: Thu, 14 Dec 2023 08:05:55 +0000
Message-ID: <DM4PR11MB5359B0524B31A258DD3B20F4E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
 <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
In-Reply-To: <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5359:EE_|MW4PR11MB6715:EE_
x-ms-office365-filtering-correlation-id: 314ad0da-a550-4134-1216-08dbfc7b7f9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AacgbEfZPzPoTnd6p/BfIOLvqDYuIhDM7Q7gzWmqI8IO419mtrJ5Jrx/2kvoy19mBfG/XRUOq41LFjzJsOkd2rzBjYlVsl8LwgLFCon57vAbiX1AjLj4fgDkM2PkErF7qIFdBJasyNnDyoRAFVblHbOyt7gKNFis+Y4WCspByCUxP1wjWNqK87QzGlkR5ILno7YAk8CWjY0f8vDiQir2DVQ50kld8upVzosV4CZlh1InEZyoaszZ8vGVqwbPqce7Bv2mAC9J09bYt8Qwf1KwwMmqKeT3gXLxWUl+IVnMvtVpjV/JJeFnQJe284jd86TZwSB651iuAqj1+oFba21zlVDZeeHOkzawX2oeTrurksEHyO2dskDDMKC2brOiNPz8wi6Dv/OpxcJWLM1EAW2kh59elIutvudK/FzK7S7zenrvpGk6NtP/B0/22c9OjDXQN/EcgKKvndVwtIgrFregEDXLorbW2YLebyukcoQJXdzjtx8y0zzj5SwFhOXNuM1P2pdYQ+osiZP6U5kr8+57gpVYH+pYIJVZxT1CRqDEx1f+YmbG41/NQZksQkGY9sDKR8C3j2wbsJUe7E+MEthXsmLIGp558Dz0MuPwYWSUUoMSXxloYlpaK9mm0zkKxlkC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5359.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(4744005)(2906002)(122000001)(38100700002)(33656002)(38070700009)(41300700001)(86362001)(66556008)(55016003)(8676002)(8936002)(4326008)(64756008)(66476007)(66446008)(26005)(71200400001)(66946007)(9686003)(76116006)(110136005)(316002)(5660300002)(478600001)(6506007)(7696005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUhJWmlYK3l0RXNHRGh6NnJXd0ROa2tRVjFQMEVJRTFsMU5MckJRSUxBODlD?=
 =?utf-8?B?ZVliZTlqVjQxWHV0NjZlcU9mNGFmZ2Y5QThJd2I4dXlmTGNWTWZtMFlUNXZn?=
 =?utf-8?B?UlQ0SWpmQW1TSUZ1N2o1RkpkSWFFQjY5amk1OXNrSlR1OXFyNlp6L1NHbkVK?=
 =?utf-8?B?RVhzbVY2Skh2dWkwSy9URi94UTRGTHVDU3hFdUtpVUhDdzhKNFZScDRrMmRN?=
 =?utf-8?B?UTNIKzIxSStmbHlGNndFeUJ3VDVJSEdIWGhaVXM2VmVPQ25aUHI0Q3o3Yk9o?=
 =?utf-8?B?cUZpL0tpNEE4R0EvN3ZPWUZsblE0UjE5ZkVEVnBKbExINUhDRXF5aitmTFVN?=
 =?utf-8?B?dHpzYVZuQUEyYWJRRzhaMVEwRmNxQ1hlSndYN2E4Sy9aOE54OEoxZkV2dXh2?=
 =?utf-8?B?NWZiNGpNVGNaSFBmSVczbDQwcVY5SjVoSEt6Q2F1dUJUYTd5eGh2MEtVemJm?=
 =?utf-8?B?ajZ2L2kvalZhSHFjUlhXZmZ2Vm9NVkV0dU5Xa0VXMWoyaEVmak5MQWZoRyt4?=
 =?utf-8?B?Wno3b1U4R2tGTGhKQnBKQmo2MGxrcUQ0dVMyNlRhVytVdklXVTVEZXpXWlFX?=
 =?utf-8?B?bTk4M2tFQ2NuZXB1N0l2b1lWTGwxR2tNVDFmSnR2QWlQQS9ZeDQ3RjVBaExs?=
 =?utf-8?B?UWdVK0JOUHNpN2Q2K1A0OUdJdjk4U08ydys2S3ZzdWpIaFZvcHZVZWtJQThp?=
 =?utf-8?B?TUxMdVNSdmJLWUhLWE9YME5JUUkzTnR1WEtJUXB0ZG9WQVowbEQrYnhncXlJ?=
 =?utf-8?B?YVhqSDBFa3R2SzEwZjVkNDBqcXFMak9abFhjKzRTeEt1QW1JS1hJVUg4MjBo?=
 =?utf-8?B?TXlhK2xORjhTMG9JZDBYSytGTG9GdlRnY2JqR2FYWnI4N0ZwdjAzYlpPOGpM?=
 =?utf-8?B?TVh4UHh6NGR3aWhkNXIrTnN3NkhRWVJBMTVTVlRHbnZvMHVCY1BrekFkcGZG?=
 =?utf-8?B?TVJNeHhmK0Q5Yjg5dEZxcVNtcjBjcTFjQ3BtYmZtcjQ0cmIwV2puSDloMGNO?=
 =?utf-8?B?cFdiUU51dUczdzdXTlpQaGNta0doOWh1eEtCMWxucG9Vc0pEbWhSVmlHTUI4?=
 =?utf-8?B?YXY2aFc1VXFVUHVpVmtQNU1xZUR3LzBvWVdMamsvdjdHNXdsb0tLSlZqWGY2?=
 =?utf-8?B?OUZnNDVTMW9pMnpyV0pKYzZ5b3ZUekFtWXBkWW5VS09Sa2gyUlZ4KzBJbVRy?=
 =?utf-8?B?UHRPUWM5STZiak4xNkgzTDA0MnphNnRZem5ZamVHNUVNMk04UGJRTG50Kzdp?=
 =?utf-8?B?S1UxQmhCcFFZdk1pUGNoNkdIS1JtKzdWdHY1dDFzY1M0MTE4eFYvOTdHQkpK?=
 =?utf-8?B?cWt6N0RRZkxhOUU4YlRnTzJ5NlRqTE1MVXlLMlNVRkZacUF4WW5DVWZoSlZ4?=
 =?utf-8?B?aGtiRktFYVI0TkdaTTFxOHoyRFlXR2dLd0NHZ2xlM3ZHS1JFS000VWhSVTBF?=
 =?utf-8?B?dmp0SWVOUzVIaGhTT2ZQUkl3c09aOU91NFM0bTdCbk9tOG0zSzJmVE4xb3Vk?=
 =?utf-8?B?VHFWM3p4MEhxYm03YlZZNkNRclFTVlhNZ1hNREEyWmo1MHVnRDVaVEdtM3RN?=
 =?utf-8?B?YlE3ZXNHaFFSTTd3d0R2OWpIQXlpNjFMTGx3TTdCeTlBcEoxSWhVSlVzVjNr?=
 =?utf-8?B?NTcrVTM1UTEycmgrNlpvdURpNmJjc3JWREpJcE1IWWVLTVRxMGFWTCswaWtn?=
 =?utf-8?B?TlZpZy96LzlFNWMvR3RSM1l1ZDJBOUtDUHRWMkFDVmdlNEtSb3pnRUNHbUFr?=
 =?utf-8?B?N2FPQVJuMzcrWkdVdkc4dDBZTERVeG90WHg5aG9lWWlOcml4S29lbVFaSyt4?=
 =?utf-8?B?NDlpTTJQVUNwc2J5bFc3WDVTTnNZb1hsZTErQjc5QkgrbFFrc0NYdWo5aUdD?=
 =?utf-8?B?WTZvNGJ6MmZFdjlwYlc3UDcyT2NNMVFlZUg0QjNUV21nMWhUbUQ3MWI4eGNj?=
 =?utf-8?B?NVk3NStRc01saDEySkh4SHA0NmFKMEtXelRMQ1RqRVRSSzFqalh3aDlhdkov?=
 =?utf-8?B?VkFHSDhpZG1YNzNQeUhVbGdJOThiOFl3emF1RGNVdmhlTmQ2WHUwWTVFSWxE?=
 =?utf-8?B?SlFWNTVmdCtHTDgxVlhIY09NSmFMcjFIcHo4OFdGVlFBelFkbEg3ZEREaGlt?=
 =?utf-8?Q?hZa/5sD6ej/ji+3Yvw8u0nleg?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5359.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314ad0da-a550-4134-1216-08dbfc7b7f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 08:05:55.4458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4H1YUniGUeEHjeKWQpb2CFx1ErTJrhQ6pLtQW/TCdsT2lbOxETth8k8Ym+CFvbB96cIcuX4BEoIpZ/pwtlcoWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

IA0KPiBTbyBHcmVnLCBob3cgd2UgbW92ZSBmb3J3YXJkIHdpdGggdGhpcyBvbmU/IEtlZXAgdGhl
IHJldmVydCBvciBpbnRlZ3JhdGUNCj4gTGVvJ3Mgd29yayBvbiB0b3Agb2YgSm9oYW5uZXMnPw0K
DQpJdCB3b3VsZCBiZSAicmVzZW5kIHdpdGggdGhlIGZpeGVzIHJvbGxlZCBpbiBhcyBhIG5ldyBi
YWNrcG9ydCIuDQoNCj4gSm9oYW5uZXMsIGhvdyBpbXBvcnRhbnQgaXMgeW91ciBmaXggZm9yIHRo
ZSBzdGFibGUgNi54IGtlcm5lbHMgd2hlbiBkb25lDQo+IHByb3Blcmx5Pw0KDQpXZWxsIENRTSB3
YXMgYnJva2VuIGNvbXBsZXRlbHkgZm9yIGFueXRoaW5nIGJ1dCAoZWZmZWN0aXZlbHkpIGJyY21m
bWFjIC4uLiBUaGF0IG1lYW5zIHJvYW1pbmcgZGVjaXNpb25zIHdpbGwgYmUgbGVzcyBvcHRpbWFs
LCBtb3N0bHkuDQoNCklzIHRoYXQgYW5ub3lpbmc/IFByb2JhYmx5LiBTdXBlciBjcml0aWNhbD8g
SSBndWVzcyBub3QuDQoNCmpvaGFubmVzDQotLSANCg0KSW50ZWwgRGV1dHNjaGxhbmQgR21iSApS
ZWdpc3RlcmVkIEFkZHJlc3M6IEFtIENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFu
eQpUZWw6ICs0OSA4OSA5OSA4ODUzLTAsIHd3dy5pbnRlbC5kZSA8aHR0cDovL3d3dy5pbnRlbC5k
ZT4KTWFuYWdpbmcgRGlyZWN0b3JzOiBDaHJpc3RpbiBFaXNlbnNjaG1pZCwgU2hhcm9uIEhlY2ss
IFRpZmZhbnkgRG9vbiBTaWx2YSAgCkNoYWlycGVyc29uIG9mIHRoZSBTdXBlcnZpc29yeSBCb2Fy
ZDogTmljb2xlIExhdQpSZWdpc3RlcmVkIE9mZmljZTogTXVuaWNoCkNvbW1lcmNpYWwgUmVnaXN0
ZXI6IEFtdHNnZXJpY2h0IE11ZW5jaGVuIEhSQiAxODY5MjgK


