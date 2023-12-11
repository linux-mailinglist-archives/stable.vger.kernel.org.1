Return-Path: <stable+bounces-6363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABECB80DC33
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 21:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681D8282552
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E695467C;
	Mon, 11 Dec 2023 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kun7AsaI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49400E3
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702328333; x=1733864333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=2+qFgroPuUct0uwDqR0jYCss0ZjEwsIZhWZe/snW5PI=;
  b=Kun7AsaIhBiqifVcgiO7YAsBvx/26Q/260p6i6uLpOEodt4blJAuP68V
   5MAqfEUbpjhtc9YpEGxmv8K5k3/tU59KooLVHT8mvb80hVeBhEmBiY+Hu
   63HAye0Z3k8OG2nXc+R2hUhdRY0hdH4BoNuHvUrLvPxJcTJMXLRugnMSu
   PCfbiHhGu7CJKpTLF4G2Y5vnHFEd+5BmzIRzPo7bo1OMcpTqxfsT08cnm
   BOb0Ffs9uVMz1rbnNyZ1Mw8EvSU7I8rnDHoK8zmAv8fTMUWdIVAmZIEQV
   8AXOTgQbOoVs5CdKNyEGp8xGE6IxhA7mvpawZ4kGRytHIjxWeWQ+9fOdU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="374216666"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="374216666"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 12:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="839177625"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="839177625"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 12:58:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 12:58:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 12:58:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 12:58:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjfrKIlFY2QpiVDs/hvgnLe6itrfwNGhp1+mEfnzJjkQqRYkjPn95WGpAXlJdUIBr/UKCb7N6DUgfERZWW0CY2FYQU+Z2Ytsq+lzi1kt4QY+bWgu0q47XCD628xPl0OYAZKJma9PHFwT44/7EKRaaimOCNYfbnfS2y1EXKL0XZ5zo4zIcgDkbMeAAlY5JjPAOqfTb2qnI1UthFlhkKqMGDzXNo+1AXtY9937rPJ8ljkJZUfQifrdq1+WbFIhkG0iYPMstKOzZVRmdlQVH2lPS+l/ZNbjnJf0H8sHHK9tpP0DNdNZFaavl3qfAJ6+KeQGWERA1QBgYArWao1+sNH6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFHv2nBeBgER2ppbB2rZAT/6SH0h2BESiuJhPSfpyzI=;
 b=P994+Pdi6cEFV661q4cuGENd93xDXjrJmjuZn/8G0c04cBVrGl8ywGmC6pXLKjTcz0xCe44MFsbYFj5DQ3GUq6viRN8cMsIHwJWFvr911GmqldS4jmE1Iq7qowsP3qh6b6XselCgMp9fN+9g4wDjWGX1ShB+lRQV1JZPIpIQMLMhXyKs4e6rDUZaPqAMxiBjLd8KUXmgYhaCqyhwWoUCTt0y4JGdXmjKQI+7BrTWFikS2VxR+SCQv/wdBbJEjdgIKjw2iAgQ8RCjfqLBLZpnAO+0Jo++BIr5UqX1a23wmSIuNMfvOUrw3E5PQW1CO/GW9kLhLA9w1QH6Q4eMLinsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5359.namprd11.prod.outlook.com (2603:10b6:5:396::21)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 20:58:50 +0000
Received: from DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e]) by DM4PR11MB5359.namprd11.prod.outlook.com
 ([fe80::d3fa:b9a3:7150:2d6e%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 20:58:50 +0000
From: "Berg, Johannes" <johannes.berg@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?utf-8?B?UGhpbGlwIE3DvGxsZXI=?= <philm@manjaro.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Thread-Topic: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Thread-Index: AQHaLBDPGcUd6QwgaUOjifUHynaWLbCjz9MAgAAARQCAAAOiAIAAAW8w
Date: Mon, 11 Dec 2023 20:58:49 +0000
Message-ID: <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
In-Reply-To: <2023121127-obstinate-constable-e04f@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5359:EE_|DS7PR11MB6223:EE_
x-ms-office365-filtering-correlation-id: 3358005a-49e3-4c0d-d40b-08dbfa8bf9b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l0ddwsh5Qr7YXE2aRfh1YcccQUAGAiCSXeuPwFl2cqQXhwXkIot51Co6WrYwH/K1Rhp0rSgcGO+GeSMKahzEw+LhH42cDGhn8sRhoNhKopyidmONo46eLsJoaHEvZONAfm1e/EhAiaSkIDyX6xmjDUZOcik66Yz/Z2yGBxOsa7irGxPML/D4XJD0fGUX6Di80bgRaOfiAgPmmZ2ess2BMl8gpNXNJnx4ifRmFq0Yv9E5r2v/jPK12ovv0vA1d6L2adPnzogQKLXB9l9NYLFFFmHroUVXcnQ3SBuBB+miB2bZAkcRUlHVmj3JtEjrr8eIc9z7KOQkJaHlCPsm8q6vIsufVJOc+ZI9kZVH/T2XxflDy8bZoEauqIQ6hYZ/ab2gcucEJNdhRkWSr19fU3GvyCnbdOcm4vUZYX7zuURx+G2lvMXGpV6G5qDwflo1+sCRo6LE6fx8hlmIUJXha+26PaUCnb3ONKm415pC4k17OSX6KYqWg3rlN27xtsxjzhn/EG9BLexqdWrKB10RLAdTYlIekyIuMiv4hqA4Or0U4hlFkCVaPNu7paX0hE4aWbMkYhPZZBkHdaF/WmdXnvgcrXV0OxajvRMVUsv5T57eC3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5359.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(26005)(83380400001)(82960400001)(38070700009)(33656002)(86362001)(38100700002)(122000001)(5660300002)(316002)(8936002)(8676002)(4326008)(4744005)(2906002)(6506007)(7696005)(71200400001)(9686003)(52536014)(66476007)(110136005)(66446008)(64756008)(66946007)(66556008)(966005)(478600001)(76116006)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVlZZXIwNkJyQlRvMUhkT3I5aW0wb25aVk5ka0ZuNHRHczBHd3UwZ2NvSWsr?=
 =?utf-8?B?ekJ1NHdGTGVQSFcyVjBaLzlvbjV0bnZmOVpCSXJRRjBXVnlLZkVpc3g4SkFu?=
 =?utf-8?B?VkczRG15dkp3TS93Zm83NmJQN0x3alNXRjZxb3IyNkRrdFRZQm9DNGVJemhn?=
 =?utf-8?B?SGlWTnJsNE9Xa3czK0RBQm1XcHN0VVdXSHB5ZnVLdEZ2aXRtWDhBYnVFM0Ra?=
 =?utf-8?B?Tjc4NDJVSDVoOGlZZkhJTDF0TThUTklRTjhnVEVQcTlLVFpTbnNpVjF2Y2hE?=
 =?utf-8?B?cnRYKzJ2OTFFOFFISHpWK2F2VnhidUVJamZHbUNGbzRudFZ6ekZsaEorMEo1?=
 =?utf-8?B?UXpJNmpMN1hXeU1iZXNmZGZhSFkrWmM5TUEzSFRJSlh2TjlKN0N6Yys2RnZJ?=
 =?utf-8?B?cm1HT01IM25sZCtocStSbXdraUQwVTJqK3RVYm94UWN2TEhCdU1UVkNCN2Q5?=
 =?utf-8?B?a0lLV2tBMjV0UCtaRGpLNUFqTGxkanlwSHM0YU12cGl0LzR0YVU3TjB3U1Fq?=
 =?utf-8?B?ZTRMYzQrWS9qa2ZFSTBPMTlEeWdVQmRjRTFQOU9IbW80VDRod2c1N0hWcGd4?=
 =?utf-8?B?WmVHbkhjT1FtRkpzZ004bGRtOU0yMjlwbjk2MitVVGJpVWppZkhmcVNQc0RE?=
 =?utf-8?B?OENmeHA3azZZb2pLcVJMYnYvcDcxd0NUWVFGMkZtUFdKUDJrZFVEZEVkMkdM?=
 =?utf-8?B?U05ybXFGSlhEalZnY2YyTWVMYURselQ0UjR3WjFEeHJIYWlGWmtxN3FoYXNs?=
 =?utf-8?B?YlhuQUJpd3VlTmQza3kwU3BueUxiN1lPNmZtd2JyMm8yaXJwY25kclY4Ymd0?=
 =?utf-8?B?MEI0emdDb3I0WE9hdUZSN0JNTjFlLytqMEl5RzUwQzVJN29pdUI0djJvbVBs?=
 =?utf-8?B?N1dETDVUalRyenQzWGJkUFR4c1ZUUUJ5Zk9jVnhBbWhOeFhxTHZ1WUR1NUFS?=
 =?utf-8?B?R3RWRkt3YmUxWjk4Z2svZjNZOG5mZDArNVpVNE5veWIxNm9Ja0U2QjFHVkNT?=
 =?utf-8?B?NU9hV2M0dnhFc0xZamdSMW8yNnYwU2RtYWYrZlpOV2Vwd3UydGhvSmpxMW1I?=
 =?utf-8?B?bkc1cFdkNyt3Q1dRNkxDVWFGN2JRbzc1U2k2QUNyZUhjM0FDeGxBYWF4aHc5?=
 =?utf-8?B?ZWFwc2lBVExyTklvWWFib3J3N0MvOHB5OWVuNUY3ZjZpdWRXbm5QWGtSc1Bw?=
 =?utf-8?B?ZElla1Q1L3o0WHp1U1RRQTNERkJRTGVzK1lTeFdSMEw2MElwbk9DYXhDeEtI?=
 =?utf-8?B?MURJREpIMXMzbzl1ZkUxM29GR3hmOVNjc3Z5Wll6VEZGb0hReHBOaERWVWNH?=
 =?utf-8?B?RU1pbGI3ZWRjNnBsWjdwQ081RVA4cUluV3BPM3RiSVl5ei82ZUt4d1MvZ1V2?=
 =?utf-8?B?endGWFo0c250ZUFXY1pNSm5XZm84bURsa2NNREYrNERmWGY5WTJvSFUvek9v?=
 =?utf-8?B?T0NhekF6MTFlZE04bnZRSFhIR2xoMWYvNVNzZnNiZmo3OUdCOTJxeEVxYlR4?=
 =?utf-8?B?b2xrNlhNSlg4T3V6ZkRzNzhueThKVXlsRXZRMWpzYkFtL2NseEdtUUZPWm1q?=
 =?utf-8?B?Sm1GOVJpT25IUnYrKzBhck9sdHEvMVpsbGtXcldRTlZ1UU9IemQxc1diZ0lH?=
 =?utf-8?B?aGtvOG9RRUZLdE9OTm9rSThkZ3FUdGNLdlc3UWFjL3hMRE44eXpxTjUzTld4?=
 =?utf-8?B?L0hzYzZ5TkZMZW1vcVBaT0pTcjVhWTFhVENxN0xlMXV6VFZYNm10QWxETGZn?=
 =?utf-8?B?MEtDWCtmdmFHTGtpN2tLKzBiV1JuM2laVldGaXZBV0pFSmhoM0swcWZJMVFE?=
 =?utf-8?B?N2NrM2JuSjZ6d1dvOHFYL29uajd6RjdHa3FFQjdWNHNzSmdrMkNUemdxWHli?=
 =?utf-8?B?ZVBEYnU5aGFGd3ZldHQ2akJDc2lPd09Ld2tsb3FqYXBkZHMrRmsybWgrYXVN?=
 =?utf-8?B?TDNrTG9lbEJ3QW05MFpDUFVzNWdraUxyWk84dm1Zb3JxQmVwd0NtUHB1Nyt0?=
 =?utf-8?B?cC9la25oMit2amdDcXRjUzBwOE91TGxnVGJ2ZGVVUFpsZEh4NHIyamZ2Qmhy?=
 =?utf-8?B?N203aEFEbmhxRWwyN2NvQ3orQUk4V0RkY1p5VHZtYjQ5ekx0Q0p6Y0UrTWFQ?=
 =?utf-8?Q?nVphqcuiFFoTuiFrc03koeTHq?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5359.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3358005a-49e3-4c0d-d40b-08dbfa8bf9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 20:58:49.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOchLU9d2feXcHsr9s8oyCPnSGZH33ilAmuFl7AP0kKRaxFihFwydS9t7QSZNiLpSE5IGWLf07xZxU/nMMC60w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

PiA+IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL3N0YWJsZS9tc2c3MDMwNDAuaHRtbA0K
DQpGV0lXLCB0aGF0IGxvb2tzIGZpbmUgdG8gbWUuIEkgZG9uJ3Qga25vdyBob3cgSSBtYW5hZ2Vk
IHRvIG1pc3MgdGhhdC4gU29ycnkgYWJvdXQgdGhhdCDimLkNCg0KPiBUaGF0ICJmaXgiIHdhcyBu
b3QgY2M6ZWQgdG8gYW55IG9mIHRoZSB3aWZpIGRldmVsb3BlcnMgYW5kIHdvdWxkIG5lZWQgYSBs
b3Qgb2YNCj4gcmV2aWV3IGJlZm9yZSBJIGZlZWwgY29tZm9ydGFibGUgYWNjZXB0aW5nIGl0LCBh
cyBJIHNhaWQgaW4gdGhlIHJlc3BvbnNlIHRvIHRoYXQNCj4gbWVzc2FnZS4NCg0KSW5kZWVkLCBJ
IGhhZG4ndCBzZWVuIGl0IGJlZm9yZS4NCg0KQnV0IEkganVzdCBjaGVja2VkIHRoZSBlcnJvciBw
YXRocyB0aGVyZSwgYW5kIHRoZSBmaXggYWRqdXN0IGFsbCB0aHJlZSBvZiB0aGVtIGNvcnJlY3Rs
eS4NCg0Kam9oYW5uZXMNCi0tIA0KDQpJbnRlbCBEZXV0c2NobGFuZCBHbWJIClJlZ2lzdGVyZWQg
QWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55ClRlbDogKzQ5
IDg5IDk5IDg4NTMtMCwgd3d3LmludGVsLmRlIDxodHRwOi8vd3d3LmludGVsLmRlPgpNYW5hZ2lu
ZyBEaXJlY3RvcnM6IENocmlzdGluIEVpc2Vuc2NobWlkLCBTaGFyb24gSGVjaywgVGlmZmFueSBE
b29uIFNpbHZhICAKQ2hhaXJwZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOiBOaWNvbGUg
TGF1ClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gKQ29tbWVyY2lhbCBSZWdpc3RlcjogQW10c2dl
cmljaHQgTXVlbmNoZW4gSFJCIDE4NjkyOAo=


