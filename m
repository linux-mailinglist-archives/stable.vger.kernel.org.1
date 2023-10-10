Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808157C009F
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjJJPqc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjJJPq2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 11:46:28 -0400
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 08:46:27 PDT
Received: from SJSMAIL01.us.kioxia.com (usmailhost21.kioxia.com [12.0.68.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECB8AC
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 08:46:26 -0700 (PDT)
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 08:31:23 -0700
Received: from SJSMAIL01.us.kioxia.com ([fe80::500:e96f:c1b5:4bf7]) by
 SJSMAIL01.us.kioxia.com ([fe80::500:e96f:c1b5:4bf7%5]) with mapi id
 15.01.2507.032; Tue, 10 Oct 2023 08:31:23 -0700
From:   Clay Mayers <Clay.Mayers@kioxia.com>
To:     Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>
CC:     Kanchan Joshi <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "vincentfu@gmail.com" <vincentfu@gmail.com>,
        "ankit.kumar@samsung.com" <ankit.kumar@samsung.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: RE: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Thread-Topic: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Thread-Index: AQHZ+mUoyARmXOgbpk2IO8jh/ea3FbBDHFYAgABiuAD//5dbYA==
Date:   Tue, 10 Oct 2023 15:31:23 +0000
Message-ID: <8a0e5f41559646d9b505b11386142b55@kioxia.com>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
 <20231010074634.GA6514@lst.de>
 <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
In-Reply-To: <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.43]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gVHVlc2RheSwgT2N0b2JlciAxMCwgMjAyMyA2OjQwIEFNIEthbmNoYW4gSm9zaGkgPGpvc2hp
LmtAc2Ftc3VuZy5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTox
NuKAr1BNIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPiB3cm90ZToNCj4gPg0KPiA+IE9u
IEZyaSwgT2N0IDA2LCAyMDIzIGF0IDA3OjE3OjA2UE0gKzA1MzAsIEthbmNoYW4gSm9zaGkgd3Jv
dGU6DQo+ID4gPiBTYW1lIGlzc3VlIGlzIHBvc3NpYmxlIGZvciBleHRlbmRlZC1sYmEgY2FzZSBh
bHNvLiBXaGVuIHVzZXIgc3BlY2lmaWVzIGENCj4gPiA+IHNob3J0IHVuYWxpZ25lZCBidWZmZXIs
IHRoZSBrZXJuZWwgbWFrZXMgYSBjb3B5IGFuZCB1c2VzIHRoYXQgZm9yIERNQS4NCj4gPg0KPiA+
IEkgZmFpbCB0byB1bmRlcnN0YW5kIHRoZSBleHRlbnQgTEJBIGNhc2UsIGFuZCBhbHNvIGZyb20g
bG9va2luZyBhdCB0aGUNCj4gPiBjb2RlIG1peGluZyBpdCB1cCB3aXRoIHZhbGlkYXRpb24gb2Yg
dGhlIG1ldGFkYXRhX2xlbiBzZWVtcyB2ZXJ5DQo+ID4gY29uZnVzaW9uLiAgQ2FuIHlvdSB0cnkg
dG8gY2xlYXJseSBleHBsYWluIGl0IGFuZCBtYXliZSBzcGxpdCBpdCBpbnRvIGENCj4gPiBzZXBh
cmF0ZSBwYXRjaD8NCj4gDQo+IFRoZSBjYXNlIGlzIGZvciB0aGUgc2luZ2xlIGludGVybGVhdmVk
IGJ1ZmZlciB3aXRoIGJvdGggZGF0YSBhbmQNCj4gbWV0YWRhdGEuIFdoZW4gdGhlIGRyaXZlciBz
ZW5kcyB0aGlzIGJ1ZmZlciB0byBibGtfcnFfbWFwX3VzZXJfaW92KCksDQo+IGl0IG1heSBtYWtl
IGEgY29weSBvZiBpdC4NCj4gVGhpcyBrZXJuZWwgYnVmZmVyIHdpbGwgYmUgdXNlZCBmb3IgRE1B
IHJhdGhlciB0aGFuIHVzZXIgYnVmZmVyLiBJZg0KPiB0aGUgdXNlci1idWZmZXIgaXMgc2hvcnQs
IHRoZSBrZXJuZWwgYnVmZmVyIGlzIGFsc28gc2hvcnQuDQo+IA0KPiBEb2VzIHRoaXMgZXhwbGFu
YXRpb24gaGVscD8NCj4gSSBjYW4gbW92ZSB0aGUgcGFydCB0byBhIHNlcGFyYXRlIHBhdGNoLg0K
PiANCj4gPiA+IEZpeGVzOiA0NTZjYmEzODZlOTQgKCJudm1lOiB3aXJlLXVwIHVyaW5nLWNtZCBz
dXBwb3J0IGZvciBpby1wYXNzdGhydSBvbg0KPiBjaGFyLWRldmljZSIpDQo+ID4NCj4gPiBJcyB0
aGlzIHJlYWxseSBpb191cmluZyBzcGVjaWZpYz8gIEkgdGhpbmsgd2UgYWxzbyBoYWQgdGhlIHNh
bWUgaXNzdWUNCj4gPiBiZWZvcmUgYW5kIHRoaXMgc2hvdWxkIGdvIGJhY2sgdG8gYWRkaW5nIG1l
dGFkYXRhIHN1cHBvcnQgdG8gdGhlDQo+ID4gZ2VuZXJhbCBwYXNzdGhyb3VnaCBpb2N0bD8NCj4g
DQo+IFllcywgbm90IGlvX3VyaW5nIHNwZWNpZmljLg0KPiBKdXN0IHRoYXQgSSB3YXMgbm90IHN1
cmUgb24gKGkpIHdoZXRoZXIgdG8gZ28gYmFjayB0aGF0IGZhciBpbg0KPiBoaXN0b3J5LCBhbmQg
KGlpKSB3aGF0IHBhdGNoIHRvIHRhZy4NCj4gDQo+ID4gPiArc3RhdGljIGlubGluZSBib29sIG52
bWVfbmxiX2luX2NkdzEyKHU4IG9wY29kZSkNCj4gPiA+ICt7DQo+ID4gPiArICAgICBzd2l0Y2gg
KG9wY29kZSkgew0KPiA+ID4gKyAgICAgY2FzZSBudm1lX2NtZF9yZWFkOg0KPiA+ID4gKyAgICAg
Y2FzZSBudm1lX2NtZF93cml0ZToNCj4gPiA+ICsgICAgIGNhc2UgbnZtZV9jbWRfY29tcGFyZToN
Cj4gPiA+ICsgICAgIGNhc2UgbnZtZV9jbWRfem9uZV9hcHBlbmQ6DQo+ID4gPiArICAgICAgICAg
ICAgIHJldHVybiB0cnVlOw0KPiA+ID4gKyAgICAgfQ0KPiA+ID4gKyAgICAgcmV0dXJuIGZhbHNl
Ow0KPiA+ID4gK30NCj4gPg0KPiA+IE5pdHBpY2s6IEkgZmluZCBpdCBuaWNlciB0byByZWFkIHRv
IGhhdmUgYSBzd2l0Y2ggdGhhdCBjYXRjaGVzDQo+ID4gZXZlcnl0aGluZyB3aXRoIGEgZGVmYXVs
dCBzdGF0ZW1lbnQgaW5zdGVhZCBvZiBmYWxsaW5nIG91dCBvZiBpdA0KPiA+IGZvciBjaGVja3Mg
bGlrZSB0aGlzLiAgSXQncyBub3QgbWFraW5nIGFueSBkaWZmZXJlbnQgaW4gcHJhY3RpY2UNCj4g
PiBidXQganVzdCByZWFkcyBhIGxpdHRsZSBuaWNlci4NCj4gDQo+IFN1cmUsIEkgY2FuIGNoYW5n
ZSBpdC4NCj4gDQoNCldoYXQgaWYgdGhlIG5zIHVzZWQgdGhlIEtWIENTPyAgU3RvcmUgYW5kIHJl
dHJpZXZlIGFyZSB0aGUgc2FtZQ0Kb3AgY29kZXMgYXMgbnZtZV9jbWRfd3JpdGUgYW5kIG52bWVf
Y21kX3JlYWQuDQoNCj4gPiA+ICsgICAgIC8qIEV4Y2x1ZGUgY29tbWFuZHMgdGhhdCBkbyBub3Qg
aGF2ZSBubGIgaW4gY2R3MTIgKi8NCj4gPiA+ICsgICAgIGlmICghbnZtZV9ubGJfaW5fY2R3MTIo
Yy0+Y29tbW9uLm9wY29kZSkpDQo+ID4gPiArICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+
DQo+ID4gU28gd2UgY2FuIHN0aWxsIGdldCBleGFjdGx5IHRoZSBzYW1lIGNvcnJ1cHRpb24gZm9y
IGFsbCBjb21tYW5kcyB0aGF0DQo+ID4gYXJlIG5vdCBrbm93bj8gIFRoYXQncyBub3QgYSB2ZXJ5
IHNhZmUgd2F5IHRvIGRlYWwgd2l0aCB0aGUgaXNzdWUuLg0KPiANCj4gR2l2ZW4gdGhlIHdheSB0
aGluZ3MgYXJlIGluIE5WTWUsIEkgZG8gbm90IGZpbmQgYSBiZXR0ZXIgd2F5Lg0KPiBNYXliZSBh
bm90aGVyIGRheSBmb3IgY29tbWFuZHMgdGhhdCBkbyAob3IgY2FuIGRvKSB0aGluZ3MgdmVyeQ0K
PiBkaWZmZXJlbnRseSBmb3IgbmxiIGFuZCBQSSByZXByZXNlbnRhdGlvbi4NCj4NCj4gPiA+ICsg
ICAgIGNvbnRyb2wgPSB1cHBlcl8xNl9iaXRzKGxlMzJfdG9fY3B1KGMtPmNvbW1vbi5jZHcxMikp
Ow0KPiA+ID4gKyAgICAgLyogRXhjbHVkZSB3aGVuIG1ldGEgdHJhbnNmZXIgZnJvbS90byBob3N0
IGlzIG5vdCBkb25lICovDQo+ID4gPiArICAgICBpZiAoY29udHJvbCAmIE5WTUVfUldfUFJJTkZP
X1BSQUNUICYmIG5zLT5tcyA9PSBucy0+cGlfc2l6ZSkNCj4gPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIHRydWU7DQo+ID4gPiArDQo+ID4gPiArICAgICBubGIgPSBsb3dlcl8xNl9iaXRzKGxlMzJf
dG9fY3B1KGMtPmNvbW1vbi5jZHcxMikpOw0KPiA+DQo+ID4gSSdkIHVzZSB0aGUgcncgZmllbGQg
b2YgdGhlIHVuaW9uIGFuZCB0aGUgdHlwZWQgY29udHJvbCBhbmQgbGVuZ3RoDQo+ID4gZmllbGRz
IHRvIGNsZWFuIHRoaXMgdXAgYSBiaXQuDQo+ID4NCj4gPiA+ICAgICAgIGlmIChiZGV2ICYmIG1l
dGFfYnVmZmVyICYmIG1ldGFfbGVuKSB7DQo+ID4gPiArICAgICAgICAgICAgIGlmICghbnZtZV92
YWxpZGF0ZV9wYXNzdGhydV9tZXRhKG5zLCBudm1lX3JlcShyZXEpLT5jbWQsDQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1ldGFfbGVuLCBidWZmbGVuKSkgew0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgZ290byBvdXRfdW5tYXA7DQo+ID4gPiArICAgICAgICAgICAgIH0NCj4g
PiA+ICsNCj4gPiA+ICAgICAgICAgICAgICAgbWV0YSA9IG52bWVfYWRkX3VzZXJfbWV0YWRhdGEo
cmVxLCBtZXRhX2J1ZmZlciwgbWV0YV9sZW4sDQo+ID4NCj4gPiBJJ2QgbW92ZSB0aGUgY2hlY2sg
aW50byBudm1lX2FkZF91c2VyX21ldGFkYXRhIHRvIGtlZXAgaXQgb3V0IG9mIHRoZQ0KPiA+IGhv
dCBwYXRoLg0KPiA+DQo+ID4gRllJOiBoZXJlIGlzIHdoYXQgSSdkIGRvIGZvciB0aGUgZXh0ZXJu
YWwgbWV0YWRhdGEgb25seSBjYXNlOg0KPiANCj4gU2luY2UgeW91IGhhdmUgaW1wcm92aXNlZCBj
b21tZW50cyB0b28sIEkgbWF5IGp1c3QgdXNlIHRoaXMgZm9yIHRoZQ0KPiBuZXh0IGl0ZXJhdGlv
bi4NCg==
