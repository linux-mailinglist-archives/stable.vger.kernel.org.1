Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA8173F4C3
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 08:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjF0Goi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 02:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjF0GoP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 02:44:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B93272D;
        Mon, 26 Jun 2023 23:41:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35R6e77u023276;
        Tue, 27 Jun 2023 01:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687848007;
        bh=dsiKsE91lKf5OvXMNGW1FlYQ10GaUD20ITfSwXJcI/I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=wEY4p2oTCRdbS1631HmBQOYmClEwoLSu7m7WA1qf+e+Uf3tlZRbankbpGHyOc+cR/
         vNJ1QaB14EKj12UiMhXTnnePXAkZXpgq/QG/tq8vKkwaiDbhOHcJHpWbHpocS1YVge
         eTeRiM1MrEAXgbzeXJ3gZyLyoNSuxlDBYctn7umE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35R6e7bp001016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Jun 2023 01:40:07 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Jun 2023 01:40:07 -0500
Received: from DLEE114.ent.ti.com ([fe80::bdc7:eccc:cd13:af84]) by
 DLEE114.ent.ti.com ([fe80::bdc7:eccc:cd13:af84%17]) with mapi id
 15.01.2507.023; Tue, 27 Jun 2023 01:40:07 -0500
From:   "Purohit, Kaushal" <kaushal.purohit@ti.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Oliver Neukum" <oneukum@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: issues with cdc ncm host class driver
Thread-Topic: [EXTERNAL] Re: issues with cdc ncm host class driver
Thread-Index: Adll85tYAc+Cq2MlRoaUYHp7CXh/XQASqSKAADMoCYAPKDRrAAFFkoXA
Date:   Tue, 27 Jun 2023 06:40:07 +0000
Message-ID: <2f71b6a5cc39445aa8c7f3c3558dfd50@ti.com>
References: <da37bb0d43de465185c10aad9924f265@ti.com>
 <28ec4e65-647f-2567-fb7d-f656940d4e43@suse.com>
 <da479ebf-b3fb-0a58-16be-07fe55d36621@leemhuis.info>
 <19199830-33b6-2a4c-e08b-d1a76ce4c59b@leemhuis.info>
In-Reply-To: <19199830-33b6-2a4c-e08b-d1a76ce4c59b@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.145.23]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

QXBvbG9naWVzIGZvciBsYXRlIHJlcGx5LCBJIHdhcyBzdHVjayB3aXRoIHNvbWV0aGluZy4NCg0K
WWVzIGF0dGFjaGVkIHBhdGNoIHdhcyB3b3JraW5nIHdlbGwuIEkgZGlkIG5vdCBzZWUgc2V0IGZp
bHRlciBwYXJhbXMgcmVxdWVzdCBhZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLg0KDQpUaGFua3Ms
DQpLYXVzaGFsDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMaW51eCByZWdy
ZXNzaW9uIHRyYWNraW5nIChUaG9yc3RlbiBMZWVtaHVpcykgPHJlZ3Jlc3Npb25zQGxlZW1odWlz
LmluZm8+IA0KU2VudDogVHVlc2RheSwgSnVuZSAyMCwgMjAyMyA3OjQ2IFBNDQpUbzogT2xpdmVy
IE5ldWt1bSA8b25ldWt1bUBzdXNlLmNvbT47IFB1cm9oaXQsIEthdXNoYWwgPGthdXNoYWwucHVy
b2hpdEB0aS5jb20+OyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQpDYzogcmVncmVzc2lvbnNAbGlz
dHMubGludXguZGV2OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBbRVhURVJO
QUxdIFJlOiBpc3N1ZXMgd2l0aCBjZGMgbmNtIGhvc3QgY2xhc3MgZHJpdmVyDQoNCk9uIDA0LjA0
LjIzIDEyOjMzLCBMaW51eCByZWdyZXNzaW9uIHRyYWNraW5nIChUaG9yc3RlbiBMZWVtaHVpcykg
d3JvdGU6DQo+IFNpZGUgbm90ZTogdGhlcmUgaXMgbm93IGEgYnVnIHRyYWNraW5nIHRpY2tldCBm
b3IgdGhpcyBpc3N1ZSwgdG9vOg0KPiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19i
dWcuY2dpP2lkPTIxNzI5MA0KPiANCj4gT24gMDMuMDQuMjMgMTI6MDksIE9saXZlciBOZXVrdW0g
d3JvdGU6DQo+PiBPbiAwMy4wNC4yMyAwODoxNCwgUHVyb2hpdCwgS2F1c2hhbCB3cm90ZToNCj4g
DQo+Pj4gUmVmZXJyaW5nIHRvIHBhdGNoIHdpdGggY29tbWl0IElEDQo+Pj4gKCplMTBkY2IxYjZi
YTcxNDI0M2FkNWEzNWExMWI5MWNjMTQxMDNhOWE5KikuDQo+Pj4NCj4+PiBUaGlzIGlzIGEgc3Bl
YyB2aW9sYXRpb24gZm9ywqBDREMgTkNNIGNsYXNzIGRyaXZlci4gRHJpdmVyIGNsZWFybHkgDQo+
Pj4gc2F5cyB0aGUgc2lnbmlmaWNhbmNlIG9mIG5ldHdvcmsgY2FwYWJpbGl0aWVzLiAoc25hcHNo
b3QgYmVsb3cpDQo+Pj4NCj4+PiBIb3dldmVyLCB3aXRoIHRoZSBtZW50aW9uZWQgcGF0Y2ggdGhl
c2UgdmFsdWVzIGFyZSBkaXNyZXNwZWN0ZWQgYW5kIA0KPj4+IGNvbW1hbmRzIHNwZWNpZmljIHRv
IHRoZXNlIGNhcGFiaWxpdGllcyBhcmUgc2VudCBmcm9tIHRoZSBob3N0IA0KPj4+IHJlZ2FyZGxl
c3Mgb2YgZGV2aWNlJyBjYXBhYmlsaXRpZXMgdG8gaGFuZGxlIHRoZW0uDQo+Pg0KPj4gUmlnaHQu
IFNvIGZvciB5b3VyIGRldmljZSwgdGhlIGNvcnJlY3QgYmVoYXZpb3Igd291bGQgYmUgdG8gZG8g
DQo+PiBub3RoaW5nLCB3b3VsZG4ndCBpdD8gVGhlIHBhY2tldHMgd291bGQgYmUgZGVsaXZlcmVk
IGFuZCB0aGUgaG9zdCANCj4+IG5lZWRzIHRvIGZpbHRlciBhbmQgZGlzY2FyZCB1bnJlcXVlc3Rl
ZCBwYWNrZXRzLg0KPiANCj4gI3JlZ3pib3QgXmludHJvZHVjZWQgZTEwZGNiMWI2YmE3MTQyNDNh
ZA0KPiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzI5MA0K
PiAjcmVnemJvdCBmcm9tOiBQdXJvaGl0LCBLYXVzaGFsDQo+ICNyZWd6Ym90IHRpdGxlIG5ldDog
Y2RjX25jbTogc3BlYyB2aW9sYXRpb24gZm9yIENEQyBOQ00gI3JlZ3pib3QgDQo+IGlnbm9yZS1h
Y3Rpdml0eQ0KDQpOb3Qgc3VyZSB3aGF0IGhhcHBlbiB0byB0aGlzLCBteSBsYXN0IGlucXVpcmll
cyB3ZXJlIG5vdCBhbnN3ZXJlZCwgc28gaXQgc2VlbXMgbm9ib2R5IGNhcmVzIGFueW1vcmUNCg0K
I3JlZ3pib3QgaW5jb25jbHVzaXZlOiByYWRpbyBzaWxlbmNlLCBpZ25vcmluZyAjcmVnemJvdCBp
Z25vcmUtYWN0aXZpdHkNCg0KQ2lhbywgVGhvcnN0ZW4gKHdlYXJpbmcgaGlzICd0aGUgTGludXgg
a2VybmVsJ3MgcmVncmVzc2lvbiB0cmFja2VyJyBoYXQpDQotLQ0KRXZlcnl0aGluZyB5b3Ugd2Fu
bmEga25vdyBhYm91dCBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2luZzoNCmh0dHBzOi8v
bGludXgtcmVndHJhY2tpbmcubGVlbWh1aXMuaW5mby9hYm91dC8jdGxkcg0KSWYgSSBkaWQgc29t
ZXRoaW5nIHN0dXBpZCwgcGxlYXNlIHRlbGwgbWUsIGFzIGV4cGxhaW5lZCBvbiB0aGF0IHBhZ2Uu
DQoNCg==
