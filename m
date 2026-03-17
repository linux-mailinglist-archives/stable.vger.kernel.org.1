Return-Path: <stable+bounces-226891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p1ysJVOtuWnOMAIAu9opvQ
	(envelope-from <stable+bounces-226891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:36:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0472D2B1961
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 990E130729D2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BC4342CA7;
	Tue, 17 Mar 2026 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZBl0xE9b"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426233B966;
	Tue, 17 Mar 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776206; cv=fail; b=TxxYx8P2YyKqqudMZBtJ/zlYZ8vDUxmYuHhEXfxaWaP0PA+UO3EHThAeFlwCRJsgtO4DWO696IkMwL0e4pt+KsO40aHDDaiRpGBKxeMUylkkLMQPKzD1k4YZCKzbrsP8jeQE1gAbejyPyuSWk/P5z7IPkKbD0k5iDTf971pYwew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776206; c=relaxed/simple;
	bh=uKCg90Pu0IrbcSAPwJekSE2XyLDrKf+nyhibEDH3o5I=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Upz5f3SCIheenbh6AT8mIo1RoWXZ3TA9zPKFaxeaZd9C+DGgAAWq7xvMG8Vl4ZuhZynTV6dEF+qazrnbAGf6r8MOUYygh8JoDXLHsxaUst33gslERABNU+qan01wvbUyYcxKPQj31CndObBfj6xDh2ljZBQC7Tz5VcdZdBYoH8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZBl0xE9b; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HEOHNp3853770;
	Tue, 17 Mar 2026 19:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=uKCg90Pu0IrbcSAPwJekSE2XyLDrKf+nyhibEDH3o5I=; b=ZBl0xE9b
	eM+wrB5yo5AOzTICXpq64HAG4/KlwquCW1RsEYqDzRwguqb2VI48ZtU4EsHt8fmd
	n1ZYsI8tpecLHPtQ4qG7SlAL+ubaLXgt41c1BlC2Lq4bPYnR4qBAYoXgWmubEM0J
	QOkg60+CZo2wdmc4GF6nPItMRtEoBLfodGqJbj/w8sKQ1JdydkhcwqM8XZJMcq3c
	EFYBu+zoEshZXPaEpvsvk+o1FkPGJ0JBfa5tyKApmiqWILzd9zdn+8tssOA/3WpT
	jdFIqYEh08jv6GNxtShCFlUqog6a0d45kMMp8om8TuKhnGz5DgObvJPGdZmANTKO
	8nO6e/AUQwIjyA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs6jhv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:36:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/GSvqhnQpk4Rh2MOZrQY8MFw69EKmDAQmikL+IyC7lQXkQaEbw750gyy4lGRTgr5GF+15sswB5Hl2f6VBtKi4ZqkcmV8GmdRm2mqOM74lQ0ldyE1t0eTzGTZGxM1vqFInq2HqCEa/GYEzNMyU86lVKDPG6q2CJmG+EG1eG21EKue+mvSVfh8t/ImxCDmCBa6z9px5u4/I2wgFEwAv4yIvxIack6FvQY/AKzvjrYUgFp14krGaqEqJO6vfLSbKGU30PKh+scyufqoBU/1BYInaHmExuJjHvoc0okHXslycqk6ZDZOjv6g+Mlv0XLkxc9/zNo/+Z/FbQpH/O8hYMiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKCg90Pu0IrbcSAPwJekSE2XyLDrKf+nyhibEDH3o5I=;
 b=SeUXepaGfNOIwMDAWfYrh1DsnH/jMUn7qGWMA+no5R5FsAqS3Nfge+7rkvb5Qbazw0AOdszAABv63Y5g96eTXOtoGZp9GytbH0dtmUesxxeydAEQZLu4yK9kBSwbahl34VYEBwBCjaCZwedEETIWHb9RP8gmDrvZs8qayznVLXY1PXEOBKOVhAC6bzONDSm0B0AzzJH97a4oqUcs5jd96zoakdGgNeIZcQ3dbcPCMa5RNLhEaFAqQwrDnf67xlbTcKmruj1fs65JUQvmzZYC2rdmPdcLydXyi8cOrE9wWxqAhMX4vnqpP2RHCgT+Onvlh35Md0oVf4qU51GxopxD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by PH3PPFE061D9768.namprd15.prod.outlook.com (2603:10b6:518:1::4cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 19:36:25 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.20.9723.013; Tue, 17 Mar 2026
 19:36:24 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "zilin@seu.edu.cn" <zilin@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>,
        "sougata@tuxera.com"
	<sougata@tuxera.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE:  [PATCH] hfsplus: fix held lock freed on
 hfsplus_fill_super()
Thread-Index:
 AQHcscZlUtL+PntFI0i7djFUt62CeLWrKgGAgACJzICAARm+gIAAlkWAgARmBICAAEp4gIABEtQA
Date: Tue, 17 Mar 2026 19:36:24 +0000
Message-ID: <646794a68e4f5f84f5e388b991de5cae05df9f23.camel@ibm.com>
References: <054d2ebe267ef9c13468a05557cb099c49a0b872.camel@ibm.com>
	 <20260317031245.831887-1-zilin@seu.edu.cn>
In-Reply-To: <20260317031245.831887-1-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|PH3PPFE061D9768:EE_
x-ms-office365-filtering-correlation-id: 610bdfce-8515-452c-4642-08de845c79d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|10070799003|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 OGJEWQvNx9kecVeumVo4eqAQXSRoLC7g9kumKJueiSFrWXAK/rbwzL3t4mebMQskjT9Eu07FlugiU11N/rgPCaA8bxTcm81BRUSQG7iotQd8ozhBXDutnWOVzFmF1/9FU+5v3Eunqe4vvbueAnfKdMz7gzHGgLX+K/YQd1y/vxwy8EBxlq2sau4t7o2ePvxVGh0CMnW8zWUh1bCU2OJMmCT2jgaeUr4DI5Mmvy+TgqrX+C0TOxBL/7uXLTtArGhbjpyQSv8Wtg6dX8NnyXfXg2IXddUHVcePGfOGopozhWmuFykxmI404DNaaDNqhF6N9c/sEb6nbBhJq3uCus4RlGjyQRQBCBwhsEirTTEKR3JN8KFBCEfRTJw57nJ5f0vLw4houPWOdKhBtsP1PEgU7UpSQZ/2N15gxVP0SUoooGuKP4yzb4RXZ/JuYcDPCpmFDWoW0SCWdtMyZzn9NQckGXgWQd5soam6WZl3kcN7gNPl7S+AX55FJilkYf5wTPJNdPrW55ACv6zYr5cE0LHDTinrNc+GBrPt9vZYkkiSs9rLNUXIvbDElxmPzgkca/PzhamzrCjip9qM4Is6Scw9r5VvDUVUbINt9hr8FUR3FogBb3r+GDABKXb6NwhJwroVwcfWW0IZdBzBmbW9CRnRPzVkN328t4GX2njbDuonnBKIYOw6VWFZjLHbXFJCSv019pcC9IsHXu2J7D+ifgnenXceyJfekLaw9k4K2d2BQ3pGtn7jDBMAs9g7C+yfyTifi6vSXAoRvmFQGvNSAx56y1NLFBZLpGQrKRTE4Kz2xr8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tys4UmtkKyttRDdFVGJQdHFGNUVmSmhFc1pYZ0drQ0pqSzNGVFc4R2hMVkUv?=
 =?utf-8?B?YTV5amJuUkpDWHgvdElCQ3ZpM0RSVmNDMFJWVHJGYnhYTG5mMzVWYm5JazJL?=
 =?utf-8?B?QnN6a3FlUVpacXFPMkw3aVBQNFdGbUI5TTZoMGVYUVlMenAzQVNyVEUxVjNW?=
 =?utf-8?B?ejd0WmU3anVhOXBzTzVaUWZGSTMzbkxCa3dvaTRzVjNwTExBTUhaQUNrSDhY?=
 =?utf-8?B?NlhMd21iMkh0Y01rVUtwb2VTVzR2OFptQ1NXN2VWVEhTektzcmYxZ2pZVlZM?=
 =?utf-8?B?UWhlVUJnMVRZZVdXUUgzTXY5aU04UmYrMHZ1c3RQeEthN2NlTXNHcldxd05M?=
 =?utf-8?B?TlltM05ucTNXMVo0RjZIbEVDbHVPUW5MZTMwWUlLUDByWE1UMS92NFlCODZE?=
 =?utf-8?B?UkZUdE50eUJIb2E5OFVGWVpKYUdlRDdrZnVKcFBlYXJXZ0ZZaHJOMDl0K21j?=
 =?utf-8?B?T0ZVOFJWcklaYi9XVFgvWS9pSXVpb1A2RVBZVVhFQWhvSEIzSXlza2lCNUts?=
 =?utf-8?B?bEhDdjRuUE5acGIycTFGZUlKWkNzdHYwRXFLZE1EekhzOWd1Q0p0bkpyMjdM?=
 =?utf-8?B?UTk0VWhoUkpLa1BxYVNiNUNuaGVya0tYQzE2bkpKVktJblAwbTZhSVpWYk56?=
 =?utf-8?B?Qkt4VExyVmJXOURUdTZJWXAyUktFcnZrbW56L1locDU5NjZrR2E0dHozems4?=
 =?utf-8?B?UGx1MFl2T1hGUlZwK3puSkk0YTdBMytQYUVBUTlyTi9SZ1dpMGFVUTBpclRj?=
 =?utf-8?B?TnNIWDJncGlTekM5Mmh1YTJhVTdraGV0UkRYdnJqUHUyZXpQK1VSUk9YWFg4?=
 =?utf-8?B?T0Z1cHlQNDBxbm4rSnNRdHQ5TkJCdUhNLzJYK1d0SmNRd0JQR3E4bXcwZERW?=
 =?utf-8?B?MkJ3RTBYTnlSWGV4QmFJTFBhR0ZFcTlXaDgvdVk3bm5UVitld0FZcHdRdVdT?=
 =?utf-8?B?bjYyM0syc0pPcnJtUWpqTkxFa2J4Z3hTS1hhbTRwN3FqOElOZEErRDBMcnNt?=
 =?utf-8?B?KzVwVlk5OXlNVGlkYlc1R055eUFKdlJKeHN1TUhBdG12N3R6UUtSajBPQVJE?=
 =?utf-8?B?Vm11SkVKMi9qbERKRWYrdm1HS2RjNDVQZGtyVjNMaGlTazVVeFN6c2NWSjN3?=
 =?utf-8?B?dzJVaEJsWkxCSmo4S0ZhOFh4RW1Oc0dPTlljU2dDWWJBVVN5SUFpZkh5S2E1?=
 =?utf-8?B?U3FRRkpyWXlydUgzZFRncUMzZ1JJbkdVcEt1Z1NBWFVjVFRKcnhJTkF2bTBE?=
 =?utf-8?B?bTVYRDRuaCt5Y1hwOUl4SGNRdGdDSURnNjlPeDJTTGk1R2pqTWJ3aG9DNHl0?=
 =?utf-8?B?VnNYVVdJenIzZldFc3I5VFBNV01BaG83QWtBMWo5TG5HSDNiNFo2ZWhvcHVX?=
 =?utf-8?B?MGhFRll4UkthOGYzYW16Z2xXUjhKeTlrVW8xcTY1VmRHT3FXUmkyM09lcHJG?=
 =?utf-8?B?VmpETVZRQVl4Y0dIeEd2bjZkVUU5NEJBZzRraCtTMVNpZzdXVDhOSHg5TnJI?=
 =?utf-8?B?cll3MVZ4L1oxelUrbGsyRGYvN1ZncWZnTGNjS3BidERhSy92OVJZYldrK3Fi?=
 =?utf-8?B?YzNRZGRGaE1IamNqZ0xTR1BFWlVBZ1dDNTRsTSs4elhPbWdIRUtrTkV0aHRN?=
 =?utf-8?B?eUkzd2JYbmtJTStrQmtpRGs0ZTU3NDR1Y1RzV242bUdtNWMyL3cyUFMrSmFT?=
 =?utf-8?B?bDhoOXNFWUg3bHZ1THBFbGZMUUtPK3pINEVaWUl5WU1wNmFBWTNib0N0SUl2?=
 =?utf-8?B?MmR1MHhTazdkTUdwaU84TkNtc3ZJdkhGMjFlZU81eFQwOEU4OVBYK2dUcGw3?=
 =?utf-8?B?UzZXTmtDZDdiczk0amJvT0NiRWNGQU1aMjRWL0tiaGg4RXVTMnV6NVdjVWFN?=
 =?utf-8?B?WUhtS3JSWEs5ZkJuaHRBaGdWeXBRNE93WHB3YWxjQUZPM2hDUmNLMkE4N29E?=
 =?utf-8?B?Wjh2dW9hZzU4NDg5Tkc2bXgzbE9ad0RqcmIrR2p6dUZ4UmtLbzlSZ3gzQnM4?=
 =?utf-8?B?QzVMUk5EZ0UxMFNXY1pDaE4yVTUxSlc2bjVZekd2d0ZTT3Z4Q1p6RGMwRkpH?=
 =?utf-8?B?Z09JdnJ6OUJCR3hyK3k2bHpsTEpyQnZlbkJiR2hweVoyc1pJMGhxcjQ4Ymhm?=
 =?utf-8?B?M1VReDZ4UXhJMzltbkU3UDBsR0poWUdLU0JjaFhFNFEzd2pHYm1oWWRhOFVX?=
 =?utf-8?B?Vmw3c1ZSTStkem8wR0I0WWtEbkc2RlJ2VlAyWE12VkY5ZEFoazhrTVR0VEFw?=
 =?utf-8?B?U3AvMDU0c2tJMEZ4elFBdkFUOGNsQm1hY3VyaFZsYjQ4a2U3U0FxVmZSR0lr?=
 =?utf-8?B?UTJzWXJHY2hseXJsU3gzOUE3MiszRkZ2eG9XOHZRUUtQZHd6MzFKK3BoM2kx?=
 =?utf-8?Q?v+861X+H1KfJ0/Lgn0wvCYpR21eMXXDUd3j13?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03F2A50F8392584DAF33AEDEA0A05DEE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BL+b3il2hdHY3FPq3HS+XKGIx9NqSTYM2wruJFjrbS+NHGLpND43bnnH/qoA4XRd1a8KCGhXU8DnIO+ZocA5CZoZjXwjv+T3XBRPrquH6ZgorMw9K2d/Jkz4k6P1SLKTRGjTOv5dMbdLyVnX3cb2KXzexpjRjWBPyIsAKPsr8GtJUwmuHeNc2WhjBZ1jQlnWYVa9E5TVGTtUm/21UFOJ1UGhUGqualBfahH6mqEbEB/Tqin8mc56tBbDXot/n3WnR9E8hxYsO0TTLevfuA7elmWG69fWw99n/+9/9Dy/+PKoztViNQrHtZKqJBQbeSh+xT6hovPvVzyr1mI4j7C6hQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610bdfce-8515-452c-4642-08de845c79d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 19:36:24.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6FbkK/qt/ukgCMGTvuTbj5BEcFrnpYAU2J5cWrnvM1aFvPQqBhP4XZvovyBFYRkqOTtzZl9zTpG8GSYLzxExg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE061D9768
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b9ad3b cx=c_pps
 a=YlXwlwCmDr4vNaLG4mezpw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=Tp0WGPgItI981w2rG28A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Nc8mkHe5f92z75N_aW9iqyCwT5Qq0sD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE2OSBTYWx0ZWRfX9WjBRgI5VYBl
 EagH/1P+eAK38qrpUSzGaUk8UDV/c85RlY9TGIpnmAXIYIlIMcEEnfQMaa4C+5g3UxOFb1BKJcU
 j3691DqtoP1y3/MYtyiNuzi8bnk0ndEX7LTYaVJFLQE6FtTiQGj7FDKhVH4uCkqYdelrhBx7qt7
 74MM07ZMhpAqw7Wj6bvJIi5Pfd1kyKci5CsRKaIH31WQcIElzHhmifbCSlq0N+dMiZGFySNh08I
 NNPSVTBNQ92c5GcChVn7oUUnxe2w2n0UGXupw1iKeTiQkQr3AA/trQT06vhl/evjGJQI38zIYei
 KMJdqOKxRV7QfUGw3X2GuTPqXKXZ8oZLtt32yaTFB7a/CC4Sk281nze20a2rBi6f2BA8Z38L6eG
 NaaHMA8YOEg2CUa8l6u0GlC6gT25i0agtXPlt4OTXSGOOLoTnsCPPHGuOxO0DAB3TZJxcO5Opin
 bUiopfXjF/h9WrycY1Q==
X-Proofpoint-GUID: Nc8mkHe5f92z75N_aW9iqyCwT5Qq0sD9
Subject: RE:  [PATCH] hfsplus: fix held lock freed on hfsplus_fill_super()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170169
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226891-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0472D2B1961
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDExOjEyICswODAwLCBaaWxpbiBHdWFuIHdyb3RlOg0KPiBP
biBNb24sIE1hciAxNiwgMjAyNiBhdCAxMDo0NjoxNFBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5
a28gd3JvdGU6DQo+ID4gT24gU2F0LCAyMDI2LTAzLTE0IGF0IDExOjM2ICswODAwLCBaaWxpbiBH
dWFuIHdyb3RlOg0KPiA+ID4gVG8gbWFrZSB0aGUgaGVscGVyIGNvbXBsZXRlbHkgY29ycmVjdCwg
d2UgZmFjZSBhbm90aGVyIGlzc3VlOiB0aGUgb3JpZ2luYWwgDQo+ID4gPiBjb2RlIGlnbm9yZXMg
YWxsIGVycm9ycyBmcm9tIGhmc19icmVjX3JlYWQoKSAod2hpY2ggY2FuIHJldHVybiAtRU5PRU5U
LCANCj4gPiA+IC1FSU5WQUwsIC1FSU8sIGV0Yy4pLCB0cmVhdGluZyB0aGVtIGFzIG5vbi1mYXRh
bC4NCj4gPiA+IA0KPiA+ID4gSWYgd2UgY29tYmluZSB0aGUgZmF0YWwgc2V0dXAgZnVuY3Rpb25z
IGFuZCB0aGUgbm9uLWZhdGFsIHJlYWQgZnVuY3Rpb24gDQo+ID4gPiBpbnRvIG9uZSBoZWxwZXIs
IGl0IGNhbm5vdCBzaW1wbHkgcmV0dXJuIGEgc3RhbmRhcmQgZXJyb3IgY29kZS4gSXQgd291bGQg
DQo+ID4gPiBuZWVkIHRvIHJldHVybiB0aHJlZSBkaXN0aW5jdCBzdGF0ZXM6DQo+ID4gPiANCj4g
PiA+IDEuIEZhdGFsIGVycm9yIC0+IGNhbGxlciBtdXN0IGFib3J0IG1vdW50Lg0KPiA+ID4gMi4g
Tm9uLWZhdGFsIHJlYWQgZXJyb3IgLT4gY2FsbGVyIG11c3QgY29udGludWUgbW91bnQsIGJ1dCBz
a2lwIGluaXQuDQo+ID4gPiAzLiBTdWNjZXNzIC0+IGNhbGxlciBtdXN0IGluaXQgaGlkZGVuX2Rp
ci4NCj4gPiA+IA0KPiA+ID4gVG8gaGFuZGxlIGFsbCB0aGVzZSBjYXNlcyBwcm9wZXJseSwgdGhl
IGhlbHBlciB3b3VsZCBoYXZlIHRvIGxvb2sgDQo+ID4gPiBzb21ldGhpbmcgbGlrZSB0aGlzOg0K
PiA+ID4gDQo+ID4gPiAJLyogUmV0dXJucyA8IDAgb24gZmF0YWwgZXJyb3IsIDAgb24gbWlzc2lu
Zy9yZWFkIGVycm9yLCAxIG9uIHN1Y2Nlc3MgKi8NCj4gPiA+IAlzdGF0aWMgaW5saW5lIGludCBo
ZnNwbHVzX2dldF9oaWRkZW5fZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+ID4g
PiAJCQkJCQkgICAgICAgaGZzcGx1c19jYXRfZW50cnkgKmVudHJ5KSANCj4gPiA+IAl7DQo+ID4g
PiAJCXN0cnVjdCBoZnNfZmluZF9kYXRhIGZkOw0KPiA+ID4gCQlpbnQgZXJyOw0KPiA+ID4gCQlp
bnQgcmV0ID0gMDsNCj4gPiA+IAkJLyogLi4uIGluaXQgc3RyIC4uLiAqLw0KPiA+ID4gDQo+ID4g
PiAJCWVyciA9IGhmc19maW5kX2luaXQoSEZTUExVU19TQihzYiktPmNhdF90cmVlLCAmZmQpOw0K
PiA+ID4gCQlpZiAoZXJyKQ0KPiA+ID4gCQkJcmV0dXJuIGVycjsgLyogRmF0YWwsIGZkIG5vdCBp
bml0aWFsaXplZCAqLw0KPiA+ID4gCQkNCj4gPiA+IAkJZXJyID0gaGZzcGx1c19jYXRfYnVpbGRf
a2V5KHNiLCBmZC5zZWFyY2hfa2V5LCBIRlNQTFVTX1JPT1RfQ05JRCwgJnN0cik7DQo+ID4gPiAJ
CWlmICh1bmxpa2VseShlcnIgPCAwKSkgew0KPiA+ID4gCQkJcmV0ID0gZXJyOw0KPiA+ID4gCQkJ
Z290byBmcmVlX2ZkOyAvKiBGYXRhbCAqLw0KPiA+ID4gCQl9DQo+ID4gPiANCj4gPiA+IAkJZXJy
ID0gaGZzX2JyZWNfcmVhZCgmZmQsIGVudHJ5LCBzaXplb2YoKmVudHJ5KSk7DQo+ID4gPiAJCWlm
IChlcnIpIHsNCj4gPiA+IAkJCXJldCA9IDA7IC8qIE5vbi1mYXRhbCwgYnV0IG5vIGVudHJ5IHRv
IGluaXQgKi8NCj4gPiA+IAkJCWdvdG8gZnJlZV9mZDsNCj4gPiA+IAkJfQ0KPiA+ID4gCQkNCj4g
PiA+IAkJcmV0ID0gMTsgLyogU3VjY2VzcyAqLw0KPiA+ID4gDQo+ID4gPiAJZnJlZV9mZDoNCj4g
PiA+IAkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiA+ID4gCQlyZXR1cm4gcmV0Ow0KPiA+ID4gCX0N
Cj4gPiA+IA0KPiA+ID4gQW5kIHRoZSBjYWxsZXI6DQo+ID4gPiAJDQo+ID4gPiAJZXJyID0gaGZz
cGx1c19nZXRfaGlkZGVuX2Rpcl9lbnRyeShzYiwgJmVudHJ5KTsNCj4gPiA+IAlpZiAoZXJyIDwg
MCkNCj4gPiA+IAkJZ290byBvdXRfcHV0X3Jvb3Q7DQo+ID4gPiAJaWYgKGVyciA9PSAxKSB7DQo+
ID4gPiAJCS8qIC4uLiBpbml0IGhpZGRlbl9kaXIgLi4uICovDQo+ID4gPiAJfQ0KPiA+ID4gDQo+
ID4gPiBXZSB3b3VsZCBoYXZlIHRvIGludmVudCBhIGN1c3RvbSByZXR1cm4gc3RhdGUgY29udmVu
dGlvbiAoMSwgMCwgPCAwKSBqdXN0IHRvIA0KPiA+ID4gaGlkZSBhIHNpbmdsZSBoZnNfZmluZF9l
eGl0KCkgY2FsbC4NCj4gPiA+IA0KPiA+ID4gR2l2ZW4gdGhpcywgSSB0aGluayB0aGUgY3VycmVu
dCBpbmxpbmUgbG9naWMgaW4gbXkgcGF0Y2ggaXMgbXVjaCBjbGVhbmVyIA0KPiA+ID4gYW5kIGF2
b2lkcyB0aGlzIGNvbnZvbHV0ZWQgZXJyb3Igcm91dGluZy4gDQo+ID4gPiANCj4gPiA+IFdoYXQg
ZG8geW91IHByZWZlcj8NCj4gPiA+IA0KPiA+IA0KPiA+IEkgZG9uJ3QgcXVpdGUgZm9sbG93IHRv
IHlvdXIgdHJvdWJsZS4gQW55IGZ1bmN0aW9uIGNhbiByZXR1cm4gdmFyaW91cyBlcnJvcg0KPiA+
IGNvZGVzIGFuZCBjYWxsZXIgY291bGQgcHJvY2VzcyB0aGUgZGlmZmVyZW50IGVycm9yIGNvZGVz
IGJ5IGRpZmZlcmVudCBsb2dpY3M6DQo+ID4gDQo+ID4gZXJyID0gaGZzcGx1c19nZXRfaGlkZGVu
X2Rpcl9lbnRyeShzYiwgJmVudHJ5KTsNCj4gPiBpZiAoZXJyID09IC1FTk9FTlQpIHsNCj4gPiAg
IDxwcm9jZXNzIC1FTk9FTlQ+DQo+ID4gfSBlbHNlIGlmIChlcnIgPT0gLUVJTlZBTCkgew0KPiA+
ICAgPHByb2Nlc3MgLUVJTlZBTD4NCj4gPiB9IGVsc2UgaWYgKGVyciA9PSAtRUlPKSB7DQo+ID4g
ICA8cHJvY2VzcyAtRUlPPg0KPiA+IH0gZWxzZSBpZiAoZXJyID09IDxzb21lIG90aGVyIGVycm9y
Pikgew0KPiA+ICAgPHByb2Nlc3MgdGhpcyBjYXNlPg0KPiA+IH0NCj4gPiANCj4gPiBEb2VzIGl0
IHNvbHZlIHlvdXIgdHJvdWJsZT8NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gU2xhdmEuDQo+IA0K
PiBIaSBTbGF2YSwNCj4gDQo+IFdoZW4gY29uc2lkZXJpbmcgdGhlIHNvbHV0aW9uLCBteSBwcmlt
YXJ5IGZvY3VzIHdhcyB0byBzdHJpY3RseSBwcmVzZXJ2ZSANCj4gdGhlIG9yaWdpbmFsIGV4ZWN1
dGlvbiBsb2dpYy4gVGhlcmVmb3JlLCBJIHdhcyBmb2N1c2luZyBtb3JlIG9uIHdoaWNoIA0KPiBm
dW5jdGlvbiByZXR1cm5lZCB0aGUgZXJyb3IgcmF0aGVyIHRoYW4gdGhlIHNwZWNpZmljIGVycm9y
IGNvZGUgaXRzZWxmLg0KPiANCj4gVGhlIGlzc3VlIHdpdGggcm91dGluZyBieSBlcnJvciBjb2Rl
cyBpcyB0aGF0IGRpZmZlcmVudCBmdW5jdGlvbnMgY2FuIA0KPiByZXR1cm4gdGhlIHNhbWUgY29k
ZSBidXQgcmVxdWlyZSBkaWZmZXJlbnQgaGFuZGxpbmcuIEZvciBleGFtcGxlLCANCj4gYm90aCBo
ZnNfZmluZF9pbml0KCkgYW5kIGhmc19icmVjX3JlYWQoKSBjYW4gcmV0dXJuIC1FTk9NRU0gDQo+
ICh0aGUgbGF0dGVyIHZpYSBfX2hmc19ibm9kZV9jcmVhdGUpLg0KPiANCj4gSW4gdGhlIG9yaWdp
bmFsIGNvZGU6DQo+IA0KPiAtIGhmc19maW5kX2luaXQoKSByZXR1cm5pbmcgLUVOT01FTSBpcyBm
YXRhbCAobXVzdCBhYm9ydCBtb3VudCkuDQo+IC0gaGZzX2JyZWNfcmVhZCgpIHJldHVybmluZyAt
RU5PTUVNIGlzIG5vbi1mYXRhbCAoY2xlYW4gdXAgYW5kIGNvbnRpbnVlIA0KPiBtb3VudCkuDQo+
IA0KPiBJZiBhIGhlbHBlciBzaW1wbHkgcmV0dXJucyBlcnIsIHRoZSBjYWxsZXIgY2Fubm90IGRp
c3Rpbmd1aXNoIHdoaWNoIA0KPiBmdW5jdGlvbiBmYWlsZWQsIG1ha2luZyBpdCBpbXBvc3NpYmxl
IHRvIHNhZmVseSBkZWNpZGUgd2hldGhlciB0byBhYm9ydCANCj4gb3IgY29udGludWUuDQo+IA0K
DQpZb3UgY2FuIHVzZSB0aGUgZGlmZmVyZW50IGVycm9yIGNvZGVzIHRvIGRpc3Rpbmd1aXNoIHRo
ZXNlIHNpdHVhdGlvbnMuDQoNCj4gU2luY2UgdGhlIGhlbHBlciBhcHByb2FjaCBhZGRzIHVubmVj
ZXNzYXJ5IGNvbXBsZXhpdHksIHdvdWxkbid0IGl0IGJlIA0KPiBiZXR0ZXIgdG8gc3RpY2sgd2l0
aCBteSBvcmlnaW5hbCBwYXRjaD8NCj4gDQo+IA0KDQpJIHByZWZlciB0byBzZWUgdGhlIGNvcnJl
Y3QgcmVmYWN0b3JpbmcgYmVjYXVzZSBpdCBjb3VsZCBtYWtlIHRoZSBjb2RlIG11Y2gNCmNsZWFu
ZXIuIEFuZCwgZnJhbmtseSBzcGVha2luZywgSSBkb24ndCBxdWl0ZSBmb2xsb3cgd2h5IGRvIHlv
dSBzZWUgc28gbWFueQ0KdHJvdWJsZXMgaW4gcmVhbGx5IHNpbXBsZSByZWZhY3RvcmluZy4NCg0K
VGhhbmtzLA0KU2xhdmEuDQo=

