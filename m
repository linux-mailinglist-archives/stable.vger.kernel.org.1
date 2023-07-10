Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8574CC71
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 07:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjGJF4E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 01:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjGJF4C (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 01:56:02 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4776FA;
        Sun,  9 Jul 2023 22:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688968561;
  x=1720504561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rp4glHhigZRbb6cFa6BDkXLq2b9n6Bw3j2Uwao/CflA=;
  b=AqzCB6/tgYiM16NFxDCiMhcMngw5ZC+HduYHWrrIzU2t+6FgfuLcFUVT
   up/kzb/m//M4llNW5y2oV2lfX1QDbp2B97B46y5plSQzDNusGrknWOUuV
   9ZCjWXcRt7Qkpn7uCgdl8eyr7OGbPUXE6wbeKonLsBcS74e9a8RNslUig
   V0BxUp49rKubxQygCihiniOcQoPcT8zWkq0QoaxiQV1iPc7P/B46t8lGP
   iBRGPUz97K7cWvmmxCUtTf1eiMIfVjRjvy9NcTxOXZbySKyL8iIYjSvqw
   FVIX3BcLEoceWU8GLavTLfYNZZriCHvxSq3xZZXb2Dgy79nFFz0tkAaxA
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlIYTJf4pEnOtZkZJ2o1ryrR0kCfeWX1uP6jmzNQF5fuVwYjlBocBRIW68tPwFPqrinfTTCsq7XSaze4DbugdDt+WLbIoWFhAq2sLhgAwjsvasnzl0SRwYk98CzO1I/BkmqfmDOrKqT5BvPig0zAMROr+TEscBI4/W/89e7I/5oc+G5JmqhWzAdt58393F++Q4AE/6/WZztHv0csLDLwpwZ+xnzW05tOyE4OAsne4NqmjIdm4i8WuQe6Hdrc3I/OxyiB04USiVmitploTudPKCrbRaTSrmzMx4/tvZSKAvQxUA0v3Bh+Hi2cYVHZDeSmjmcBXpPEALoX9aghKRJ8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp4glHhigZRbb6cFa6BDkXLq2b9n6Bw3j2Uwao/CflA=;
 b=McOdcn3agpK0JNYFUUpjkejgb6MpmeUqVqh14iwTdM1qlF/SNg6oZr3RZT+svePNFn2vvyinb7GoTlfYuKVz366V9L171WgRn/IJ2lVSyv4Der1lzTucEIw5sJqAHZMofiJ/tNyg6Bc/eSlEfOocSkDvVgHWOI/QOyRwD69dKpUo8+5Qq1iVokNCeJr0hDJtwVIUHTkMuQlX6+aZAMpBjWAK2yQaKGEItQd824Xxq78qbTahinqfKWrMWXbbDeCVB4580Yl4A0wXtgXORAdMScXbVAlqpOLxihuu1A7nDlXw0+Qg8yl85CkKxthgTfJudyLPxM75XhaPZJolDMRqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp4glHhigZRbb6cFa6BDkXLq2b9n6Bw3j2Uwao/CflA=;
 b=xEKBOhLwY8hdzvyOWXHrDgaOcE1rq/qGrhOxusv/ILxdwTHn3IlWcjFMuKeg/J8QDvIzPUxVPBqznovpbVlUU0LpQNLrBVJDeKYov0KEq+Wt6xT7NV5wSn7fDHexnuHktbzhCYCe8Kdo4Kkbf+cBufqKt9Xkiea9Mx+HT7upQF4=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
        Vincent Whitchurch <Vincent.Whitchurch@axis.com>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: Patch "mmc: core: Support zeroout using TRIM for eMMC" has been
 added to the 5.15-stable tree
Thread-Topic: Patch "mmc: core: Support zeroout using TRIM for eMMC" has been
 added to the 5.15-stable tree
Thread-Index: AQHZsixPTotQlax7nEKNGJ3WnWYVIK+yggaA
Date:   Mon, 10 Jul 2023 05:55:54 +0000
Message-ID: <9dae21814b7b73cc0db1b974a868c4ced62287fa.camel@axis.com>
References: <20230709061209.483956-1-sashal@kernel.org>
In-Reply-To: <20230709061209.483956-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|GVXPR02MB8326:EE_
x-ms-office365-filtering-correlation-id: 9a9f7ca7-6a19-4971-7200-08db810a52fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L2rOIFbdUfSQ+0zNQvuPsVI2i+uxlXjjwa+sYdVKJotriBHhYJGinOJiy7XkgvkfZP9ubHOZxLCu+j7DnLUTMXzHj3bBJm13s+dDmHu0RRloE0Zjwe/guCCpjk4s9QC0g0sfzC9MSwViACp0zgHmpEYqKNrjfFsXxAJgAPRGfnV6JViENHscmQ6VkMLfK/XIR4ewDhYzoqx6dQW67UIizGLEjvgubm6SbDRAw5yBQxkNSbvCpYTJcAZC0DeTww/RNDuyb7DbBkL3q6q/P5kPmB/vNw+kMK9sjb9zHShPmYe93csCtAPMlBtkaoT6j8aPMEsP43AgYtELo/GiG1So5kQpYYyJDQBMgh5hs5BSNe0uW98gN6tzX7YkNSp0sSLWMB+fp6pFuzHRSu+5oiL7cCmFmf22YnsuWVGkwQ6qBbwymHqEZG4zPvem1kvwXA1eoIstSfK1UFB8yrqmPRDmutcGDfQeU+hZaY5CdA+vbQpApvRPsOdgInFhN6MYpTQJyHLmnLjTikQ/LPA2KfztMfkriM0fSoxwzE5o/73ybU+zaex04bT/OpeAcoHGqV5IMdmHmEPCAu+FjDIRyspPR5aabXEeUEy6PfbdrwIJUz8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39850400004)(366004)(396003)(451199021)(41300700001)(5660300002)(110136005)(71200400001)(6486002)(2906002)(316002)(8676002)(8936002)(966005)(66556008)(66446008)(91956017)(4326008)(66476007)(64756008)(66946007)(76116006)(6512007)(36756003)(478600001)(86362001)(38100700002)(2616005)(122000001)(186003)(26005)(38070700005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXV4dkE3bGZMbU05UU8wU20yWUtQWjZkSkhBcXBNUmVHcHVCU1EwaXorWjhO?=
 =?utf-8?B?bXYxS0lnbU9xRkc5M3g4bm9mY3N5T3ROZ3FzL2ZHbzFNOFNYOTROVTJtQlhK?=
 =?utf-8?B?NXBUNHpCbG95WkVBV1orSEx0ZVljU1VLVDNpRE82VEplMkI1Z1hrdS96TWZq?=
 =?utf-8?B?N241UTcvbk5PMTM1RlNVM2s2VFQ0cVhRRTlPcjhqU0JBd3BFZ1VnUS91Syt4?=
 =?utf-8?B?RmVIZFArM3BMMVFkODVaaEN0czdSb3UwNllrWjFLMmYvY1VVeVBjWUVNUjRB?=
 =?utf-8?B?Y1pGSDBIRCtvVjlVZEFqdlFIWHF4bXhmMExraU5ENHpTeGFhU1JYU05MTjEx?=
 =?utf-8?B?NnVVb3BmSkVGM3IrQ1Qyakx4WE1lbU5DdWVaQTIvUWFSMktEWk0zemFaR3N5?=
 =?utf-8?B?RXJmWVc2SFhjcXdubGQ4UWNHbFp4WGdndHZZNFNXcDYvL0I0T0JXUUtGVFp1?=
 =?utf-8?B?NXFoK1FLTGd4L2xiUkJSdFZ5dVEyMXpQcGE5MFgyODRUTm0zbSs1akI0aHUv?=
 =?utf-8?B?dmdVSEhDMVNFR2RUeThWVmxIRGlOZ1kvTTdYcDRkUlhJZk9UZWV2cVl6dzgz?=
 =?utf-8?B?ZW5lWVhiUEg5RFgvWmZJQjlJSDZ5V01DNkVmbEtjbC9RS1c1S1YwUEd1c01V?=
 =?utf-8?B?VWM0aVQrakFPWDkzSjcyMjRoTUczMjRnTzNib21tbTdkQU5BOExYTHBYRjFh?=
 =?utf-8?B?WXFMT08wOFNrNnptQzNaZDZRNk1IQm0rK2wrMlVIQmx1bXg0azFsZnRrY25K?=
 =?utf-8?B?T1AvTlcySHpwZ3NXL2pFT0NsbU95ZHdZcjM1bzBkNXM1OVNzV09pVTEvakVH?=
 =?utf-8?B?ajVKYThUSnVNV3BveHJMV1lnTU0weSsxYnl3eFlEWXRqdTcvSDNkTHZZejlQ?=
 =?utf-8?B?WWpzY2hNYUkwY3RUeDQxd05wMWJRNHFNV2N0WnN3UUlRWlh5aE53SVh2V2Z4?=
 =?utf-8?B?NlVPZDQxM1ZISUlpbHd5WUFqZ2ZyMHRRRDRwYmFIL2VzM01YbGIwYkxVbEdr?=
 =?utf-8?B?S295WnZJbEJNRTR6S2JHczFyaThLNjE0dVdqaFFjc1lYaEwxREJPREJiMmJQ?=
 =?utf-8?B?amkrR0hiOWJ3Qi81WERZeTdVSEVib1hETDdFbVlxOG5DMkR0d3Y1Qjh5czZG?=
 =?utf-8?B?UCtBQ1B2RFBpL3pSbjV3VkJJL2dGb25kdDNvUTlzQlI3b2x6Q2FwSWx1M1Fh?=
 =?utf-8?B?ckd5bTNXVjhxMHFiZWZMeTFTam5ja1V3YTQ0cHVrbmVuL2tJaWhjeDREd0RK?=
 =?utf-8?B?a3NTN3ZpcEoxL2ZrNFNWdm9WRXh2ZlpSNXF5MUQ0Mkt1TEMzd21veCtvcVF2?=
 =?utf-8?B?Z3JrYy9LUG1HMEdYek5odVlLa3cvOVlUUVB6N2FHOHpWaFdUWFF4TmthSWUw?=
 =?utf-8?B?N1Z1ZXByVzVNdkxwUmViK3FGaFdzMldIWVpBTHVrNi9rb1VKYzVKdmE2dUxT?=
 =?utf-8?B?OHdTWTdpZlhWemIwdEhIUG83Zm9FajdXblJ1YWFMakVSSnFsUXR4YnBQcVRz?=
 =?utf-8?B?d2cyMCthNGo2alpCK3FCR0VjQVBvN3VUV25tV0RWcUpxRGcwOUM4QmxxNG56?=
 =?utf-8?B?L2dhU3cxSU9acUYzWTVVTFVYUThjNC96d29pYzRNU2hQRXYwUFhWRjFoaFJX?=
 =?utf-8?B?UWlIOGhnMDQwNGR0T1VoYWlwallXeXJsYkNUbDU2Ylcyc0N5VVJRZ1ZoM2x3?=
 =?utf-8?B?T0c3WjN2a3hWSzA0T3IyOFFrS3oza1hoa2ZiY3NZOWV5clFlSGhKejdSTW9W?=
 =?utf-8?B?dXBPUnpLeFp3aXJQbThrUzVITHVtQ05VcXhiNS9rTVhJdzFFQzJLWkRFRUpB?=
 =?utf-8?B?bFNrNmlXV0xpQ2t1anZSSjV6VEdGNnhZWTNiTGZLQzZPVUlrZ2F5VUV4OVkz?=
 =?utf-8?B?SC9EVEdyVmcvaDdNM1MxSGF2K3Y1eGZTc01sQXhQYzB0d0VhRmp2QVZPaUZ3?=
 =?utf-8?B?ZG8vdUJTS0ZxMjlvcWVVY2JNVVovM3pwZkczeElkYW5GdVBqcDdJVEIrTVNr?=
 =?utf-8?B?QVQzbWlLdlpUK2U1TmFFeDVHbnV0V0ZKc29nNjVGTGRyb28yZmlSSjdLQmo5?=
 =?utf-8?B?UzM3anE1cmtKZXo0cGxiWEFZSTFqdmcyNkVpKzJFTTRpUzRyRlJPc2hVOWpB?=
 =?utf-8?Q?RAAGlkuylWKs6ezoZyQLINwx3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62F5040E86BA014C8AFC3E41F1D633D7@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9f7ca7-6a19-4971-7200-08db810a52fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 05:55:54.4990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C71DjC3fu8D39Ogzd0TnZI2XCMYWdOpmFBja5W6Xn1Cr67cRkz9i+n9i+xkDfBgf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB8326
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTA5IGF0IDAyOjEyIC0wNDAwLCBTYXNoYSBMZXZpbiB3cm90ZToNCj4g
VGhpcyBpcyBhIG5vdGUgdG8gbGV0IHlvdSBrbm93IHRoYXQgSSd2ZSBqdXN0IGFkZGVkIHRoZSBw
YXRjaCB0aXRsZWQNCj4gDQo+IMKgwqDCoMKgbW1jOiBjb3JlOiBTdXBwb3J0IHplcm9vdXQgdXNp
bmcgVFJJTSBmb3IgZU1NQw0KPiANCj4gdG8gdGhlIDUuMTUtc3RhYmxlIHRyZWUgd2hpY2ggY2Fu
IGJlIGZvdW5kIGF0Og0KPiDCoMKgwqDCoGh0dHA6Ly93d3cua2VybmVsLm9yZy9naXQvP3A9bGlu
dXgva2VybmVsL2dpdC9zdGFibGUvc3RhYmxlLXF1ZXVlLmdpdDthPXN1bW1hcnkNCj4gDQo+IFRo
ZSBmaWxlbmFtZSBvZiB0aGUgcGF0Y2ggaXM6DQo+IMKgwqDCoMKgwqBtbWMtY29yZS1zdXBwb3J0
LXplcm9vdXQtdXNpbmctdHJpbS1mb3ItZW1tYy5wYXRjaA0KPiBhbmQgaXQgY2FuIGJlIGZvdW5k
IGluIHRoZSBxdWV1ZS01LjE1IHN1YmRpcmVjdG9yeS4NCj4gDQo+IElmIHlvdSwgb3IgYW55b25l
IGVsc2UsIGZlZWxzIGl0IHNob3VsZCBub3QgYmUgYWRkZWQgdG8gdGhlIHN0YWJsZSB0cmVlLA0K
PiBwbGVhc2UgbGV0IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiBrbm93IGFib3V0IGl0Lg0KPiAN
Cj4gDQo+IA0KPiBjb21taXQgZTcxYzkwYmNjNjU3MjdkMzIzYjlhM2NiNDBiMjYzZGI3YmU1ZWU0
Yw0KPiBBdXRob3I6IFZpbmNlbnQgV2hpdGNodXJjaCA8dmluY2VudC53aGl0Y2h1cmNoQGF4aXMu
Y29tPg0KPiBEYXRlOiAgIEZyaSBBcHIgMjkgMTc6MjE6MTggMjAyMiArMDIwMA0KPiANCj4gwqDC
oMKgwqBtbWM6IGNvcmU6IFN1cHBvcnQgemVyb291dCB1c2luZyBUUklNIGZvciBlTU1DDQo+IMKg
wqDCoMKgDQo+IA0KPiDCoMKgwqDCoFsgVXBzdHJlYW0gY29tbWl0IGY3YjZmYzMyNzMyNzY5ODky
NGVmM2FmYTBjM2U4N2E1Yjc0NjZhZjMgXQ0KPiDCoMKgwqDCoA0KPiANCj4gwqDCoMKgwqBJZiBh
biBlTU1DIGNhcmQgc3VwcG9ydHMgVFJJTSBhbmQgaW5kaWNhdGVzIHRoYXQgaXQgZXJhc2VzIHRv
IHplcm9zLCB3ZSBjYW4NCj4gwqDCoMKgwqB1c2UgaXQgdG8gc3VwcG9ydCBoYXJkd2FyZSBvZmZs
b2FkaW5nIG9mIFJFUV9PUF9XUklURV9aRVJPRVMsIHNvIGxldCdzIGFkZA0KPiDCoMKgwqDCoHN1
cHBvcnQgZm9yIHRoaXMuDQo+IMKgwqDCoMKgDQo+IA0KPiDCoMKgwqDCoFNpZ25lZC1vZmYtYnk6
IFZpbmNlbnQgV2hpdGNodXJjaCA8dmluY2VudC53aGl0Y2h1cmNoQGF4aXMuY29tPg0KPiDCoMKg
wqDCoFJldmlld2VkLWJ5OiBBdnJpIEFsdG1hbiA8QXZyaS5BbHRtYW5Ad2RjLmNvbT4NCj4gwqDC
oMKgwqBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjIwNDI5MTUyMTE4LjM2MTcz
MDMtMS12aW5jZW50LndoaXRjaHVyY2hAYXhpcy5jb20NCj4gwqDCoMKgwqBTaWduZWQtb2ZmLWJ5
OiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gwqDCoMKgwqBTdGFibGUt
ZGVwLW9mOiBjNDY3YzhmMDgxODUgKCJtbWM6IEFkZCBNTUNfUVVJUktfQlJPS0VOX1NEX0NBQ0hF
IGZvciBLaW5nc3RvbiBDYW52YXMgR28gUGx1cyBmcm9tIDExLzIwMTkiKQ0KPiDCoMKgwqDCoFNp
Z25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4NCg0KSSBzdGlsbFsw
XSBwcmVmZXIgdGhhdCB0aGlzIG5vdCBiZSBiYWNrcG9ydGVkIHRvIHN0YWJsZS4NCg0KWzBdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ZMW93UVlscit2ZnhFbVM4QGF4aXMuY29tLw0K
