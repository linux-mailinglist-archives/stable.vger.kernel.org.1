Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0265C7A5D7B
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjISJLd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 05:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjISJLc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 05:11:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3599EF0
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 02:11:23 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38J9B5dF43369498, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38J9B5dF43369498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 17:11:05 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 19 Sep 2023 17:11:05 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 19 Sep 2023 17:11:04 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Tue, 19 Sep 2023 17:11:04 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Jade Lovelace <lists@jade.fyi>
CC:     "paul.grandperrin@gmail.com" <paul.grandperrin@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roger Tseng <rogerable@realtek.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Wei_wang <wei_wang@realsil.com.cn>
Subject: RE: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from drivers/misc/cardreader breaks NVME power state, preventing system boot
Thread-Topic: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from
 drivers/misc/cardreader breaks NVME power state, preventing system boot
Thread-Index: AQHZ5XTPQHzxhN3m602gmLzU6tUtJLAYEMCAgAk+JoCAAJGokA==
Date:   Tue, 19 Sep 2023 09:11:04 +0000
Message-ID: <5acda839bf8b4d5f960d623662b001ec@realtek.com>
References: <c7bdd821686e496eb31e4298050dfb72@realtek.com>
 <20230919080447.2594902-3-lists@jade.fyi>
In-Reply-To: <20230919080447.2594902-3-lists@jade.fyi>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

DQpIaSBKYWRl77yMDQoNCkkgdGhpbmsgeW91IGhhdmUgc29tZSBtaXN1bmRlcnN0YW5kLCBvdXIg
c2V0IGNsa3JlZyByZWdpc3RlciBpcyBub3QgZ28gZGlyZWN0bHkgdG8gY29udHJvbCBDTEtSRVEj
IGFmdGVyIHNldHRpbmcuLi4uDQpPdXIgZGV2aWNlIGtlZXAgQ0xLUkVRIyBsb3cgdW50aWwgZW50
ZXIgQVNQTSwgc28gdGhlIHN5c3RlbSBsZXQgb3VyIGRldmljZSB0byBBU1BNIG1vZGUgdGhlbiB3
ZSByZWxlYXNlIHRoaXMgQ0xLUkVRIyBwaW4NCg0KPiANCj4gPiBJbiB0aGUgcGFzdCBpZiB0aGUg
QklPUyhjb25maWcgc3BhY2UpIG5vdCBzZXQgTDEtc3Vic3RhdGUgb3VyIGRyaXZlciB3aWxsIGtl
ZXANCj4gZHJpdmUgbG93IENMS1JFUSMgd2hlbiBIT1NUIHdhbnQgdG8gZW50ZXIgcG93ZXIgc2F2
aW5nIHN0YXRlIHRoYXQgbWFrZQ0KPiB3aG9sZSBzeXN0ZW0gbm90IGVudGVyIHRoZSBwb3dlciBz
YXZpbmcgc3RhdGUuDQo+IA0KPiA+IEJ1dCB0aGlzIHBhdGNoIHdlIHJlbGVhc2UgdGhlIENMS1JF
USMgdG8gSE9TVCwgbWFrZSB3aG9sZSBzeXN0ZW0gY2FuDQo+IGVudGVyIHBvd2VyIHNhdmluZyBz
dGF0ZSBzdWNjZXNzIHdoZW4gdGhlIEhPU1Qgd2FudCB0byBlbnRlciB0aGUgcG93ZXINCj4gc2F2
aW5nIHN0YXRlLCBidXQgSSBkb24ndCAga25vdyB3aHkgdGhpcyBzeXN0ZW0gY2FuIG5vdCB3YWtl
IG91dCBzdWNjZXNzIGZyb20NCj4gcG93ZXIgc2F2aW5nIHN0YXRlIg0KPiANCj4gPg0KPiANCj4g
PiBUaGlzIGlzIGEgUENJRSBDTEtSRVEjIGRlc2lnbiBwcm9ibGVtIG9uIHRob3NlIHBsYXRmb3Jt
LCB0aGUgcGNpZSBzcGVjDQo+IGFsbG93IGRldmljZSByZWxlYXNlIHRoZSBDTEtSRVEjIHRvIEhP
U1QsIHRoaXMgcGF0Y2ggb25seSBkbyB0aGlzLi4uLg0KPiANCj4gDQo+IA0KPiBJIHNwZW50IHNv
bWUgdGltZSBkZWJ1Z2dpbmcgdG9kYXkgYnV0IEkgYW0gbm90IGEgUENJZSBleHBlcnQuIEkgdGhp
bmsNCj4gDQo+IHRoYXQgdGhlIGNhcmQgcmVhZGVyIGlzIGFjdHVhbGx5IHZpb2xhdGluZyB0aGUg
UENJZSBzcGVjIGJ5IG5vdCBmb3JjaW5nDQo+IA0KPiBDTEtSRVEjIGxvdyBvbiBzeXN0ZW1zIHRo
YXQgZG9uJ3Qgc3VwcG9ydCBBU1BNLCBhcyBhcHBlYXJzIHRvIGJlIGRvbmUNCj4gDQo+IChhY2Np
ZGVudGFsbHk/KSBieSB0aGUgcmVncmVzc2luZyBkcml2ZXIgY2hhbmdlLg0KPiANCj4gDQo+IA0K
PiBUaGUga2VybmVsIGxvZ3Mgb24gdGhlIGFmZmVjdGVkIHN5c3RlbSBzdGF0ZXMgdGhlIGZvbGxv
d2luZzoNCj4gDQo+IFsgICAgMC4xNDIzMjZdIEFDUEkgRkFEVCBkZWNsYXJlcyB0aGUgc3lzdGVt
IGRvZXNuJ3Qgc3VwcG9ydCBQQ0llIEFTUE0sIHNvDQo+IGRpc2FibGUgaXQNCj4gDQo+IA0KPiAN
Cj4gVGhlIFBDSWUgMy4wIHNwZWMgc3RhdGVzIChpbiB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIExp
bmsgQ29udHJvbA0KPiANCj4gUmVnaXN0ZXIpLCByZWdhcmRpbmcgZW5hYmxpbmcgY2xvY2sgcG93
ZXIgbWFuYWdlbWVudDoNCj4gDQo+ID4gRW5hYmxlIENsb2NrIFBvd2VyIE1hbmFnZW1lbnQg4oCT
IEFwcGxpY2FibGUgb25seSBmb3IgVXBzdHJlYW0gUG9ydHMgYW5kDQo+IHdpdGggZm9ybSBmYWN0
b3JzIHRoYXQgc3VwcG9ydCBhIOKAnENsb2NrIFJlcXVlc3TigJ0gKENMS1JFUSMpIG1lY2hhbmlz
bSwgdGhpcw0KPiBiaXQgb3BlcmF0ZXMgYXMgZm9sbG93czoNCj4gDQo+ID4gMGIgQ2xvY2sgcG93
ZXIgbWFuYWdlbWVudCBpcyBkaXNhYmxlZCBhbmQgZGV2aWNlIG11c3QgaG9sZCBDTEtSRVEjDQo+
IHNpZ25hbCBsb3cuDQo+IA0KPiA+IDFiIFdoZW4gdGhpcyBiaXQgaXMgU2V0LCB0aGUgZGV2aWNl
IGlzIHBlcm1pdHRlZCB0byB1c2UgQ0xLUkVRIyBzaWduYWwgdG8NCj4gcG93ZXIgbWFuYWdlIExp
bmsgY2xvY2sNCj4gDQo+ID4gYWNjb3JkaW5nIHRvIHByb3RvY29sIGRlZmluZWQgaW4gYXBwcm9w
cmlhdGUgZm9ybSBmYWN0b3Igc3BlY2lmaWNhdGlvbi4NCj4gDQo+IA0KPiANCj4gTXkgcmVhZGlu
ZyBvZiB0aGlzIGlzIHRoYXQgb24gdGhpcyBzeXN0ZW0gd2hpY2ggZG9lcyBub3Qgc3VwcG9ydCBB
U1BNDQo+IA0KPiBhbmQgdGhlcmVmb3JlIGFsc28gZG9lcyBub3Qgc3VwcG9ydCBjbG9jayBQTSwg
dGhlIGRyaXZlciBtdXN0IGhhdmUgdGhlDQo+IA0KPiBkZXZpY2UgaG9sZCB0aGUgbGluZSBsb3cs
IGJ1dCBJIG1heSBiZSB3cm9uZy4NCj4gDQo+IA0KPiANCj4gSXQncyBzdGlsbCB1bmNsZWFyIHRv
IG1lIGJhc2VkIG9uIHN0dWR5aW5nIHRoZSBzY2hlbWF0aWMgb2YgdGhlIGxhcHRvcA0KPiANCj4g
YW5kIHRoZSBQQ0ggZGF0YXNoZWV0IHdoeSB0aGUgb25lIFBDSWUgcG9ydCBpcyBhYmxlIHRvIGJy
ZWFrIHRoZSBvdGhlcg0KPiANCj4gb25lIGxpa2UgaXQgZG9lcy4gVGhlIENMS1JFUSMgbGluZXMg
YXJlIHNpbXBseSBjb25uZWN0ZWQgZGlyZWN0bHkgdG8gdGhlDQo+IA0KPiBTUkNDTEtSRVEjIGxp
bmVzIG9mIHRoZSBQQ0gsIHBsdXMgYSAxMGsgcHVsbC11cCB0byAzdjMsIHdoaWNoIHNlZW1zDQo+
IA0KPiBlbnRpcmVseSByZWFzb25hYmxlOyBhbnkgYnJlYWthZ2Ugc3VyZWx5IHdvdWxkIGJlIHNv
bWUgc29mdHdhcmUvZmlybXdhcmUNCj4gbGV2ZWwNCj4gDQo+IG1pc2NvbmZpZ3VyYXRpb24uDQo+
IA0KPiANCj4gDQo+IEphZGUNCg0K
