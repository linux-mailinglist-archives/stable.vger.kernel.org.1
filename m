Return-Path: <stable+bounces-100518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D009EC2E7
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 04:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB94188123D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9D207A1C;
	Wed, 11 Dec 2024 03:09:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F61CA4E
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886598; cv=fail; b=TnzIlQl5mLoJOnRU6TVJvEThx5KuVybsTrfPWY/Ns37MzmiGCmEMKhDGU+od/FiKxvZR8ml35Uwq0p3FGQngW36ahFd3nkZ65S0Ag5sBmwSa2fHQc/i+GgvfacwUIiIT3VzODP9NWhYiU5fs5ex+ajJFHmUpe6v1Xv4H0DhJfEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886598; c=relaxed/simple;
	bh=JmPg1JrWtqLbir9xqcLqHW0soTMXS84QbAKuVr4+vBw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PLRIg7D+cOUUfcrAakw5tHmGD8w9tPPG5QWwpHZBq/laqYm0mzZlQrqVMXCEr4hFAlaN0HlyGS6JX6dzImi5TK6m6utfpMXGdsTkTh4O3j/HW+gnFzZK9di+4t+c0c2emTPpwpLRTvFlOYcOcb15k9y4GbtMpIu3+S5QOA71XvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB2AiiT027096
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 03:09:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xbnsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 03:09:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sv4W5JQbeh3Xj90fvJeFk4hLTC3ASNXEdVs99po5f6M2VIfYh+NWwgiZxGscupDCofowclU3HwSzThl7oHgn0uLUo1s1s8Q+IWBXYfzAyLzCIaQ55E+RUxFQ7v9NywbXwEGvhjqDMKVX/m9nUL78Mr16JmjBd58ARI4++sVTQ2EZLKzMwycmw9S1OAb35Bp0sSH/pGz5KQJ2MjIzfOmL39wtyVlws0m95RJxxfXXaNu4M5BFeE52Js/xErRKGIbDk5JEVPuVkp3teKI959qO1/HUNsOzt3lckqsB7LZQBXYXjSaSV0NTDY4m7AviPuklGC6wYYR2y/iltbGVfQDnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmPg1JrWtqLbir9xqcLqHW0soTMXS84QbAKuVr4+vBw=;
 b=sPFyAlvVOVm+rBvAyt2U3rfaFZrIwQ2F+f+6ZQ58EhuireRNyjtkBoXi5tRupxN+w8qeecQPIv+yg+cXj/zgcuVNKYl6yAwd3SdA5ZhlP2Alsb4TPX5eqCpYuCBRyxbCVvvrSjT9vshLrmybEBUyIcxQBU+TQP867ZKg/EHaXplJTQqmRcSuDnI5P0ORTX5vr29awK+yKF5JD2ZwDDb28LQaLrIrrRCLe41a9mr6Bh4VmJs9BbbtFviuKWx9SGcmQurT0NX4WhPhVXMg6MfuGlS3a8U88se/0eJ5hfbIFg1NPmm7MLaBePjWBsrMKRILZjnms50GjFpWTitL9KiOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by SA3PR11MB7978.namprd11.prod.outlook.com (2603:10b6:806:2fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Wed, 11 Dec
 2024 03:09:51 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 03:09:45 +0000
From: "Chen, Libo (CN)" <Libo.Chen.CN@windriver.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] crypto: hisilicon/qm - inject error before stopping queue
Thread-Topic: [PATCH] crypto: hisilicon/qm - inject error before stopping
 queue
Thread-Index: AQHbS3gV6iaoVEmGe0GdAh1qy3CQWbLgXU5Q
Date: Wed, 11 Dec 2024 03:09:45 +0000
Message-ID:
 <BN9PR11MB53541CDB383F04005CB83F02DE3E2@BN9PR11MB5354.namprd11.prod.outlook.com>
References: <20241211025442.3926281-1-libo.chen.cn@windriver.com>
In-Reply-To: <20241211025442.3926281-1-libo.chen.cn@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5354:EE_|SA3PR11MB7978:EE_
x-ms-office365-filtering-correlation-id: 4ff5e104-73d1-4b42-5164-08dd1991439d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Umw5RVF6VUdTODZJUDBKN24xTFBtWjBUMWdNOGR6MFMzeUc5SFdUelFhdkox?=
 =?utf-8?B?QVRSTXdEQzhBUVJlcVdoZG1WSC9hb0EzeFJMbUIzTGR1c2Y0MkMxMzZOai9Y?=
 =?utf-8?B?UFlxZjRQVDZBV05sVjVXTVVQYXdHYVJFMU5Vc3NUWWJ5blgvS01PUGZCSXk2?=
 =?utf-8?B?c3NkNWNqUTZYa3o3RnNIa2lVd2UvRS93ejN6SGh1VC9qcXJkNDRCUGZBWTcx?=
 =?utf-8?B?NFlhRVkxUzcxbmhXdmxsRkRhU0ZkZllZT21LRmJMNkVudTRhV1k4QlZiRzAv?=
 =?utf-8?B?VTRPWitMd2hBNmxjL0ZhdXQ2TFZFeWZEb1IzTnVDa2k5TkJ6ajdGSHIxZ1NG?=
 =?utf-8?B?dWpUL3ljZVlqM3N0RUpJVG9vaGpPK0c5ZUxYek5lbTArZUpTVUU1WEpwTWZa?=
 =?utf-8?B?ZUt6SnF2RXhCRXFoZFFoUGErK1Fvc0VtQy9sVEVUL09WY2JXTmRsdGdNUTFB?=
 =?utf-8?B?QTFmb1lQa0c2RWZDbnM4VlJtanpJRWZSNVlhVCtzVzdBOUNLQjBTUmxmZzZ4?=
 =?utf-8?B?cU5BZzd6NUQ1U0hhQlc0Z2FHaEQ1dEd4Nytoc2EzT0ZwQTdmODFycnJUVTk3?=
 =?utf-8?B?bVF1eDU4c1RNQ0NMTWU2Z2M4NUdkL3RqbGZ2RUFVbHlMWDhrUEhhSldwRktD?=
 =?utf-8?B?bVJ5WnRtRmRjNGhGZTBIRTZPakpDMkhwV3Z1L0x4cVlaZitPdVZ6TTBBTEFE?=
 =?utf-8?B?SG9WYmpmMU8xa25sRXhPV0FUbDJoV0FBOWhFZWQvcHNMNnh2UWtXU25xTFU0?=
 =?utf-8?B?QTdjYlFkQVhCcStrOXl4MnVPV1RMWWlQVDhyM3R1WFUxNExYNThwbzJGcmhQ?=
 =?utf-8?B?SjBXRkpKVXgzTk5oU0tKQVNwbXdtSnd3T3d6OTdEdEJzNXQ1Wm1VckJaYmhO?=
 =?utf-8?B?Sis5YTBWN2tRRXVJSE1MUmFuOGcyMWViejRnVHpNYzM3dUFRcUU0d2J6SlpW?=
 =?utf-8?B?cFlTODQyd3RQbEhYSkdWWGF3ZTBveUJldy8wN3NzS3RrNm1ZdWdCMHVnZ05J?=
 =?utf-8?B?bVdLc2J2Tk1VK1dxWGdoVSs3bFlyRmlUbUF5Wlo1aTRiMEZkdnhUODFkRTBv?=
 =?utf-8?B?MUd5TFpFbnpvYWhDRkZBd2xmcEIxYnB0SFZucEYyS053bktHVSszNm5Kc0hL?=
 =?utf-8?B?bi9rdzNDUzBXdG1PbDc1TExNRlJ6Um90YW5VY21rVUxmMmhHZXlJVXdCdkt0?=
 =?utf-8?B?dVVPRll2bmJIOVVMK0UxR29tUFJCUk5mVTlzZ0FRa2h0K0RTT1A3SDh5NWg1?=
 =?utf-8?B?N3RsZ0RrWUsrRThrWXdmMU8zUHBCZmVnc3Z5YUZmSjBBZUVWbW9GRmY5R1lX?=
 =?utf-8?B?ZVY4YVRudkN2aCtZUWhVM1dmTlZsczdXRExVRW5VUVZpMVd0cDBka3EzV29C?=
 =?utf-8?B?WGJsYUxTQ0VzMTFwb3IyWFN3SC9wOXh5akhQQTQ5N2h2ekF2YysySXV5cWZp?=
 =?utf-8?B?Z085TENTM0xkWFNBY29RMDJyUFpwYTBqaU42MTJhMVZzNGxyMHdmbmdOSmpW?=
 =?utf-8?B?b1RpN3N0L3FkeHowdkxvblNHd1pwMzBiTmIzZkhoRVY2RzVrL2hackpjMTBq?=
 =?utf-8?B?V1YzelVuT0FOZHFXR1N0RzVKenlzQktBaWw5UlJJS3I5T0wrNDlYTUpPdVFx?=
 =?utf-8?B?ODJzalNCcW1PNndTbDhwQlZPWWFxSzAyejZ0VUZxSWxIQ0N2WC9iNWNHbFdD?=
 =?utf-8?B?QmZUOFJmTFpPK1hDdjdDQlJuS2gzcytjMFI3U0lqdmpDVlF0SlZxeXU0Vm81?=
 =?utf-8?B?L2FQOC9SVlZqditJUFJ1bEQ2YjZmRTJqZTdCSThkL1EvSHJOS3V1TFRGWUQr?=
 =?utf-8?B?OU1GUWZBSDVkdWpRWU5mS2kvU0lhaWxkbFpKcWMzMExQUFJ3VG5Od1FlNHJI?=
 =?utf-8?B?Tk55YUNpeS9sWkdUTkdYMW9BRnhQaThzU0Fjd1NvL1hzT2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjFncVlMYjBEYTFoUG03S0NHa3B4U1g2TVU5YWJjNEFlSGhzdkdOU3FhRDNh?=
 =?utf-8?B?dXlaSGMxUUFqa0NCOXlWWVdSV3BKNXlmbVcxeHdDZSs0ZXZURG9EVythWXJi?=
 =?utf-8?B?Y1paV1JjdnJSNzJyd255OEtvTkROeElyL0ZrR3RFSEZKajRxN21QMjhrQTdV?=
 =?utf-8?B?L2ZiUlMxb3BBdU1aWDd3QjBvajdHSWk1NVg1Y0tKR2JSdWtKeDl0bjRscXhh?=
 =?utf-8?B?MWkyakxLWlE1MTAxaGVtN25BMDFEdUpMM3FLMjhmM1Yrd1RKS0ZMRDZIclRm?=
 =?utf-8?B?V0p0NjFDYlorUnRMZEFQRkQyOWo1b3hxdzdyelA2d3ZraEp2NHBEUlBta1I3?=
 =?utf-8?B?aVFNU1dPU2RBclcwaWpWd0xTSEdDZmdPdVBzeEF2TjE2STRNUDdxS25mUUtj?=
 =?utf-8?B?VnhaL0thSDZ5d2hHcG1Sb0dienlXWkpLUGZQVlFzaHNwS05wNllqTFJMczNw?=
 =?utf-8?B?cFdFb2N2Qll6NUJHT3VYNlRTM0tTM05GT29nL1lISThiK3hET1dXaEVycnIv?=
 =?utf-8?B?Qks4d0RrSFlXOFkxbE9VcS9SNUlRcE8vOFR6WU1Ka2swYnBnUVAxanNiWEFO?=
 =?utf-8?B?L2ZiTWRJdGtIekZkdnlBTUV2RGJsa2lKcnRrTk00dDVZQzJRbEoxbHpEazhE?=
 =?utf-8?B?TzZCQW9WaFdtc3l2Z1ZtM1ZqWDhucmMzaEE1WWcwbEdERHJiNElVTnpVY2NR?=
 =?utf-8?B?TCt2OWtNdlhyTjh6dXhkTU9lL0YzcENUVmh2L09NQmlVd0hWUW9udUppR2Fr?=
 =?utf-8?B?YXpjYTdXWTZtcVF3bGlwTGxNR2dnNDdlbmxQTzRKRzBIbmRHYW0wUTJiY3F6?=
 =?utf-8?B?Tms1UTlHQ0RrL0FlVUYxcnJuTjdadCs4Z2t3UGY3RlViVXk0NXRqWDRWTlVr?=
 =?utf-8?B?L1UzeEorRUdsTTNSanBBQTFGbFhhVjBJZVNTVndEeld5Kytaa01wQ2hYOXdQ?=
 =?utf-8?B?RUVZQkZVb2NSRGJDWkhMVUhZWnFvcU92YkdWOTRXWi9SUXZRTDJUemlWbEJI?=
 =?utf-8?B?cUM4OEsyWlQrNUwvYVJpL1VJNzJKUGFLQ0tCSXRXZld0eVlHaUQwVUxkaEZh?=
 =?utf-8?B?M0VEUy82MGlOVElnN0R6akZwU081dGNNcjJKNW5nVDZmeXhQN1VaQ3B5WlVu?=
 =?utf-8?B?cXJPalhXeXB5WWswSWxVQXc5WG5aQ3I2eE1vN29jQTNnQXJQcEVHeDJsS1JD?=
 =?utf-8?B?aVJBSk5SU1M5M1ZIWnlyM3JxVStUVFNlWDlQdFVycEJ2aWUvT2I0OEpqdlVz?=
 =?utf-8?B?TlVLVUx2U091RzBHc25oaVB3YUFnK1hETzB4c0FsNWRHTFdRZ1Y2MExnUU5F?=
 =?utf-8?B?RmRFdE9hcjBrc0pYdXMyTk5VSFREWHNQYUgwUUtDejVOU0tDU0FyRnVVK3R2?=
 =?utf-8?B?OUp0TUtXcFFvd1BaME1sSTd4eFVvbzN6dCszTGM1bEFjZW5JRlY5WjFaSWl1?=
 =?utf-8?B?UFdIcS8zMmlSWFplYUpSUEMwZjJRMS9qbnB3RzdNT29rZjFkOEFpM3RNRU9p?=
 =?utf-8?B?bXhBdlBJUkp6ZE5VWjczc1pSUEw0WUNqeWt0NVhpdFYxeGdJdUltUkVBcWNS?=
 =?utf-8?B?STJxeUtlRlBleis1Q2dmRldUMkYzNEkrQ1U0SFZTMVhtSnJGbW5mVko4am1R?=
 =?utf-8?B?OHYvOE1qKzlXeVlNbzZyMi9WQmlnWHZ1eTQza1NzVDVTcmg0Ump0VTZhMVBr?=
 =?utf-8?B?YkdPdFJiWnR0VmtzMnZvWmpqSm55amd5aWlsRlhydFRsNW1UMmlqTFM3YWdZ?=
 =?utf-8?B?bDV3N1ZaT1pRMi8zenI3Q05XVWxMTVJjYVNEemdXT25TWXFDSDFRSkpRWkQy?=
 =?utf-8?B?aGRyeFIyRFBxTUdMR3gwdVRvQkRYaEtWTzd4a0l1dmd6UDYwbFd4QlZPZ09R?=
 =?utf-8?B?VjJBbkN2TGVacW92ZUJvWnlRaWZaZ1Z1dWt5UlJrY2lmTEhBSk1XL2dwVmF6?=
 =?utf-8?B?aEc0ZEpYRHV4MXdwalV6L2w4bWo5cmNQc3lEY1dNZW1YRE55VnhFNmVKcHlI?=
 =?utf-8?B?SWdMeHM4aVA0QVkzQUlyS3N4M29tSlExbWd2bjZHZlowYTlpeVNieFo4cnFU?=
 =?utf-8?B?ZnJVWlB6N0NkS2w5Q3lhVnBKNVdJQzR0SEh0SVMrdUN2NEkwMHc4VlZQTUhZ?=
 =?utf-8?Q?jMAXr8Qh1Kz0eluFJh6nltzFW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff5e104-73d1-4b42-5164-08dd1991439d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 03:09:45.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBFVkXT3p5yA+ty4TN6H+gXqf+vR2EFTfG0NvVRWxcUUJC9pJCTe0YcBhoh7xRTOIqUcEJVmDtRPugQ4S0Irl1kQ4lAtbQ1dB6DDIppE/XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7978
X-Proofpoint-GUID: agogsEVoKO6SaNvgHWQtjG9lD4Ko7bTY
X-Proofpoint-ORIG-GUID: agogsEVoKO6SaNvgHWQtjG9lD4Ko7bTY
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=67590283 cx=c_pps a=Dwc0YCQp5x8Ajc78WMz93g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=FNyBlpCuAAAA:8 a=mzVGTZs34JFsiwU4K9gA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=RlW-AWeGUCXs_Nkyno-6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_02,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412110022

UGxlYXNlIGlnbm9yZSB0aGlzIGVtYWlsLiBTb3JyeSBmb3Igd3Jvbmcgc3ViamVjdC4NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENoZW4sIExpYm8gKENOKSA8TGliby5DaGVu
LkNOQHdpbmRyaXZlci5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxMSwgMjAyNCAx
MDo1NSBBTQ0KVG86IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtQQVRDSF0gY3J5
cHRvOiBoaXNpbGljb24vcW0gLSBpbmplY3QgZXJyb3IgYmVmb3JlIHN0b3BwaW5nIHF1ZXVlDQoN
CkZyb206IFdlaWxpIFFpYW4gPHFpYW53ZWlsaUBodWF3ZWkuY29tPg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCBiMDRmMDZmYzAyNDM2MDA2NjViM2I1MDI1Mzg2OTUzM2I3OTM4NDY4IF0NCg0KVGhlIG1h
c3RlciBvb28gY2Fubm90IGJlIGNvbXBsZXRlbHkgY2xvc2VkIHdoZW4gdGhlIGFjY2VsZXJhdG9y
IGNvcmUgcmVwb3J0cyBtZW1vcnkgZXJyb3IuIFRoZXJlZm9yZSwgdGhlIGRyaXZlciBuZWVkcyB0
byBpbmplY3QgdGhlIHFtIGVycm9yIHRvIGNsb3NlIHRoZSBtYXN0ZXIgb29vLiBDdXJyZW50bHks
IHRoZSBxbSBlcnJvciBpcyBpbmplY3RlZCBhZnRlciBzdG9wcGluZyBxdWV1ZSwgbWVtb3J5IG1h
eSBiZSByZWxlYXNlZCBpbW1lZGlhdGVseSBhZnRlciBzdG9wcGluZyBxdWV1ZSwgY2F1c2luZyB0
aGUgZGV2aWNlIHRvIGFjY2VzcyB0aGUgcmVsZWFzZWQgbWVtb3J5LiBUaGVyZWZvcmUsIGVycm9y
IGlzIGluamVjdGVkIHRvIGNsb3NlIG1hc3RlciBvb28gYmVmb3JlIHN0b3BwaW5nIHF1ZXVlIHRv
IGVuc3VyZSB0aGF0IHRoZSBkZXZpY2UgZG9lcyBub3QgYWNjZXNzIHRoZSByZWxlYXNlZCBtZW1v
cnkuDQoNCkZpeGVzOiA2YzZkZDU4MDJjMmQgKCJjcnlwdG86IGhpc2lsaWNvbi9xbSAtIGFkZCBj
b250cm9sbGVyIHJlc2V0IGludGVyZmFjZSIpDQpTaWduZWQtb2ZmLWJ5OiBXZWlsaSBRaWFuIDxx
aWFud2VpbGlAaHVhd2VpLmNvbT4NClNpZ25lZC1vZmYtYnk6IEhlcmJlcnQgWHUgPGhlcmJlcnRA
Z29uZG9yLmFwYW5hLm9yZy5hdT4NClNpZ25lZC1vZmYtYnk6IExpYm8gQ2hlbiA8bGliby5jaGVu
LmNuQHdpbmRyaXZlci5jb20+DQotLS0NCiBkcml2ZXJzL2NyeXB0by9oaXNpbGljb24vcW0uYyB8
IDUxICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jcnlwdG8vaGlzaWxpY29uL3FtLmMgYi9kcml2ZXJzL2NyeXB0by9oaXNpbGljb24vcW0uYyBp
bmRleCBmZDg5OTE4YWJkMTkuLjU4ZTk5NWRiMzc4MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5
cHRvL2hpc2lsaWNvbi9xbS5jDQorKysgYi9kcml2ZXJzL2NyeXB0by9oaXNpbGljb24vcW0uYw0K
QEAgLTQ2MzgsNiArNDYzOCwyOCBAQCBzdGF0aWMgaW50IHFtX3NldF92Zl9tc2Uoc3RydWN0IGhp
c2lfcW0gKnFtLCBib29sIHNldCkNCiAJcmV0dXJuIC1FVElNRURPVVQ7DQogfQ0KIA0KK3N0YXRp
YyB2b2lkIHFtX2Rldl9lY2NfbWJpdF9oYW5kbGUoc3RydWN0IGhpc2lfcW0gKnFtKSB7DQorCXUz
MiBuZmVfZW5iID0gMDsNCisNCisJLyogS3VucGVuZzkzMCBoYXJkd2FyZSBhdXRvbWF0aWNhbGx5
IGNsb3NlIG1hc3RlciBvb28gd2hlbiBORkUgb2NjdXJzICovDQorCWlmIChxbS0+dmVyID49IFFN
X0hXX1YzKQ0KKwkJcmV0dXJuOw0KKw0KKwlpZiAoIXFtLT5lcnJfc3RhdHVzLmlzX2Rldl9lY2Nf
bWJpdCAmJg0KKwkgICAgcW0tPmVycl9zdGF0dXMuaXNfcW1fZWNjX21iaXQgJiYNCisJICAgIHFt
LT5lcnJfaW5pLT5jbG9zZV9heGlfbWFzdGVyX29vbykgew0KKwkJcW0tPmVycl9pbmktPmNsb3Nl
X2F4aV9tYXN0ZXJfb29vKHFtKTsNCisJfSBlbHNlIGlmIChxbS0+ZXJyX3N0YXR1cy5pc19kZXZf
ZWNjX21iaXQgJiYNCisJCSAgICFxbS0+ZXJyX3N0YXR1cy5pc19xbV9lY2NfbWJpdCAmJg0KKwkJ
ICAgIXFtLT5lcnJfaW5pLT5jbG9zZV9heGlfbWFzdGVyX29vbykgew0KKwkJbmZlX2VuYiA9IHJl
YWRsKHFtLT5pb19iYXNlICsgUU1fUkFTX05GRV9FTkFCTEUpOw0KKwkJd3JpdGVsKG5mZV9lbmIg
JiBRTV9SQVNfTkZFX01CSVRfRElTQUJMRSwNCisJCSAgICAgICBxbS0+aW9fYmFzZSArIFFNX1JB
U19ORkVfRU5BQkxFKTsNCisJCXdyaXRlbChRTV9FQ0NfTUJJVCwgcW0tPmlvX2Jhc2UgKyBRTV9B
Qk5PUk1BTF9JTlRfU0VUKTsNCisJfQ0KK30NCisNCiBzdGF0aWMgaW50IHFtX3ZmX3Jlc2V0X3By
ZXBhcmUoc3RydWN0IGhpc2lfcW0gKnFtLA0KIAkJCSAgICAgICBlbnVtIHFtX3N0b3BfcmVhc29u
IHN0b3BfcmVhc29uKSAgeyBAQCAtNDc0Miw2ICs0NzY0LDggQEAgc3RhdGljIGludCBxbV9jb250
cm9sbGVyX3Jlc2V0X3ByZXBhcmUoc3RydWN0IGhpc2lfcW0gKnFtKQ0KIAkJcmV0dXJuIHJldDsN
CiAJfQ0KIA0KKwlxbV9kZXZfZWNjX21iaXRfaGFuZGxlKHFtKTsNCisNCiAJLyogUEYgb2J0YWlu
cyB0aGUgaW5mb3JtYXRpb24gb2YgVkYgYnkgcXVlcnlpbmcgdGhlIHJlZ2lzdGVyLiAqLw0KIAlx
bV9jbWRfdW5pbml0KHFtKTsNCiANCkBAIC00NzY2LDMxICs0NzkwLDYgQEAgc3RhdGljIGludCBx
bV9jb250cm9sbGVyX3Jlc2V0X3ByZXBhcmUoc3RydWN0IGhpc2lfcW0gKnFtKQ0KIAlyZXR1cm4g
MDsNCiB9DQogDQotc3RhdGljIHZvaWQgcW1fZGV2X2VjY19tYml0X2hhbmRsZShzdHJ1Y3QgaGlz
aV9xbSAqcW0pIC17DQotCXUzMiBuZmVfZW5iID0gMDsNCi0NCi0JLyogS3VucGVuZzkzMCBoYXJk
d2FyZSBhdXRvbWF0aWNhbGx5IGNsb3NlIG1hc3RlciBvb28gd2hlbiBORkUgb2NjdXJzICovDQot
CWlmIChxbS0+dmVyID49IFFNX0hXX1YzKQ0KLQkJcmV0dXJuOw0KLQ0KLQlpZiAoIXFtLT5lcnJf
c3RhdHVzLmlzX2Rldl9lY2NfbWJpdCAmJg0KLQkgICAgcW0tPmVycl9zdGF0dXMuaXNfcW1fZWNj
X21iaXQgJiYNCi0JICAgIHFtLT5lcnJfaW5pLT5jbG9zZV9heGlfbWFzdGVyX29vbykgew0KLQ0K
LQkJcW0tPmVycl9pbmktPmNsb3NlX2F4aV9tYXN0ZXJfb29vKHFtKTsNCi0NCi0JfSBlbHNlIGlm
IChxbS0+ZXJyX3N0YXR1cy5pc19kZXZfZWNjX21iaXQgJiYNCi0JCSAgICFxbS0+ZXJyX3N0YXR1
cy5pc19xbV9lY2NfbWJpdCAmJg0KLQkJICAgIXFtLT5lcnJfaW5pLT5jbG9zZV9heGlfbWFzdGVy
X29vbykgew0KLQ0KLQkJbmZlX2VuYiA9IHJlYWRsKHFtLT5pb19iYXNlICsgUU1fUkFTX05GRV9F
TkFCTEUpOw0KLQkJd3JpdGVsKG5mZV9lbmIgJiBRTV9SQVNfTkZFX01CSVRfRElTQUJMRSwNCi0J
CSAgICAgICBxbS0+aW9fYmFzZSArIFFNX1JBU19ORkVfRU5BQkxFKTsNCi0JCXdyaXRlbChRTV9F
Q0NfTUJJVCwgcW0tPmlvX2Jhc2UgKyBRTV9BQk5PUk1BTF9JTlRfU0VUKTsNCi0JfQ0KLX0NCi0N
CiBzdGF0aWMgaW50IHFtX3NvZnRfcmVzZXQoc3RydWN0IGhpc2lfcW0gKnFtKSAgew0KIAlzdHJ1
Y3QgcGNpX2RldiAqcGRldiA9IHFtLT5wZGV2Ow0KQEAgLTQ4MTYsOCArNDgxNSw2IEBAIHN0YXRp
YyBpbnQgcW1fc29mdF9yZXNldChzdHJ1Y3QgaGlzaV9xbSAqcW0pDQogCQlyZXR1cm4gcmV0Ow0K
IAl9DQogDQotCXFtX2Rldl9lY2NfbWJpdF9oYW5kbGUocW0pOw0KLQ0KIAkvKiBPT08gcmVnaXN0
ZXIgc2V0IGFuZCBjaGVjayAqLw0KIAl3cml0ZWwoQUNDX01BU1RFUl9HTE9CQUxfQ1RSTF9TSFVU
RE9XTiwNCiAJICAgICAgIHFtLT5pb19iYXNlICsgQUNDX01BU1RFUl9HTE9CQUxfQ1RSTCk7DQot
LQ0KMi4yNS4xDQoNCg0K

