Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68A177551E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 10:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjHIIYF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 04:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHIIYE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 04:24:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A1699
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 01:24:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-oV41YQSUPSmBcZSspKOtjg-1; Wed, 09 Aug 2023 09:23:49 +0100
X-MC-Unique: oV41YQSUPSmBcZSspKOtjg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 9 Aug
 2023 09:23:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 9 Aug 2023 09:23:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        Ranjan Kumar <ranjan.kumar@broadcom.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "sreekanth.reddy@broadcom.com" <sreekanth.reddy@broadcom.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] Perform additional retries if Doorbell read
 returns 0
Thread-Topic: [PATCH v3 1/2] Perform additional retries if Doorbell read
 returns 0
Thread-Index: AQHZymB3zD70idl4qkOVizLGETk6/K/hn8Ag
Date:   Wed, 9 Aug 2023 08:23:46 +0000
Message-ID: <f89c7dea130842c4bb0089bd2d5a07d9@AcuMS.aculab.com>
References: <20230726112527.14987-1-ranjan.kumar@broadcom.com>
        <20230726112527.14987-2-ranjan.kumar@broadcom.com>
        <yq1o7jsq9lq.fsf@ca-mkp.ca.oracle.com>
        <CAMFBP8MS0hwd9-bfVrPi8yTB3Es-w7ugHwEMyxtb8R-mj8PPCg@mail.gmail.com>
        <yq1sf8ujmf2.fsf@ca-mkp.ca.oracle.com>
        <CAMFBP8Nf6ifVxJnNBv=zq+WyJRZR-2Hiuo4AejLAguE-GWuzJg@mail.gmail.com>
 <yq1a5v1ja8a.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1a5v1ja8a.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

RnJvbTogTWFydGluIEsuIFBldGVyc2VuDQo+IFNlbnQ6IDA5IEF1Z3VzdCAyMDIzIDAyOjI2DQo+
IA0KPiANCj4gSGkgUmFuamFuLA0KPiANCj4gPiBCdXQgZm9yIGZldyByZWdpc3RlcnMgemVybyBt
YXkgYmUgYSB2YWxpZCB2YWx1ZSBhbmQgd2UgZG9u4oCZdCB3YW50DQo+ID4gdGhvc2UgcmVnaXN0
ZXJzIHRvIGdldCBwZW5hbGl6ZWQgd2l0aCAzMCByZWFkIHJldHJpZXMgd2hlcmUgMS8zIHJlYWRz
DQo+ID4gd291bGQgaGF2ZSBzdWZmaWNlZC4NCj4gDQo+IElmIDAgaXMgYSB2YWxpZCByZWdpc3Rl
ciB2YWx1ZSB5b3UnbGwgZW5kIHVwIGFsd2F5cyBkb2luZyAzIHJldHJpZXMNCj4gYmVmb3JlIHJl
dHVybmluZy4gRXZlbiBpZiB0aGUgZmlyc3QgcmVnaXN0ZXIgcmVhZHMgd2VyZSAic3VjY2Vzc2Z1
bCIuDQo+IFBlY3VsaWFyIQ0KDQpMb29rcyBsaWtlIHRoZSBjb3JyZWN0IHNvbHV0aW9uIGlzIHRv
IGNvbXBsZXRlbHkgZGlzYWJsZSB0aGUgQk1DLg0KSXQgY2xlYXJseSBpc24ndCBjb21wYXRpYmxl
IHdpdGggdXNpbmcgdGhlIGRyaXZlciBhcyB3ZWxsLg0KDQpJZiB0aGF0IGlzbid0IHBvc3NpYmxl
IGlzIHNlZW1zIGl0IG5lZWRzIHRvIGJlIG1hcmtlZCBCUk9LRU4gOi0pDQoNCk11Y2ggbGlrZSB0
aGUgbWFpbiBldGhlcm5ldCBpbnRlcmZhY2Ugb24gbXkgSXZ5IGJyaWRnZSBpNy4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

