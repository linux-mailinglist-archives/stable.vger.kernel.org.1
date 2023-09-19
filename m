Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21A67A574F
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 04:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjISCV3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 22:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjISCV2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 22:21:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55CD10A
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 19:21:18 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38J2KtHR22873115, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38J2KtHR22873115
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 10:20:55 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 19 Sep 2023 10:20:55 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 19 Sep 2023 10:20:53 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Tue, 19 Sep 2023 10:20:53 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
CC:     Paul Grandperrin <paul.grandperrin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Wei_wang <wei_wang@realsil.com.cn>,
        Roger Tseng <rogerable@realtek.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from drivers/misc/cardreader breaks NVME power state, preventing system boot
Thread-Topic: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from
 drivers/misc/cardreader breaks NVME power state, preventing system boot
Thread-Index: AQHZ5XTPQHzxhN3m602gmLzU6tUtJLAYNE4TgAk8SwA=
Date:   Tue, 19 Sep 2023 02:20:53 +0000
Message-ID: <7991b5bd7fb5469c971a2984194e815f@realtek.com>
References: <5DHV0S.D0F751ZF65JA1@gmail.com>
 <82469f2f-59e4-49d5-823d-344589cbb119@leemhuis.info>
 <2023091333-fiftieth-trustless-d69d@gregkh>
In-Reply-To: <2023091333-fiftieth-trustless-d69d@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGkgR3JlZyBrLWihQQ0KDQpJbiBvcmRlciB0byBjb3ZlciB0aGUgdGhvc2UgcGxhdGZvcm0gUG93
ZXIgc2F2aW5nIGlzc3VlLCANCm91ciBhcHByb2FjaCBvbiBuZXcgcGF0Y2ggd2lsbCBiZSBkaWZm
ZXJlbnQgZnJvbSB0aGUgcHJldmlvdXMgcGF0Y2ggKDEwMWJkOTA3YjQyNDRhNzI2OTgwZWU2N2Y5
NWVkOWNhZmFiNmZmN2EpLg0KDQpTbyB3ZSBuZWVkIHVzZWQgZml4ZWQgVGFnIG9uIDEwMWJkOTA3
YjQyNDRhNzI2OTgwZWU2N2Y5NWVkOWNhZmFiNmZmN2EgDQpvciBhIG5ldyBwYXRjaCBmb3IgdGhp
cyBwcm9ibGVtPw0KDQpSaWNreQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBXZWRuZXNk
YXksIFNlcHRlbWJlciAxMywgMjAyMyAxOjAzIFBNDQo+IFRvOiBMaW51eCByZWdyZXNzaW9ucyBt
YWlsaW5nIGxpc3QgPHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldj4NCj4gQ2M6IFBhdWwgR3Jh
bmRwZXJyaW4gPHBhdWwuZ3JhbmRwZXJyaW5AZ21haWwuY29tPjsgc3RhYmxlQHZnZXIua2VybmVs
Lm9yZzsNCj4gV2VpX3dhbmcgPHdlaV93YW5nQHJlYWxzaWwuY29tLmNuPjsgUm9nZXIgVHNlbmcN
Cj4gPHJvZ2VyYWJsZUByZWFsdGVrLmNvbT47IFJpY2t5IFdVIDxyaWNreV93dUByZWFsdGVrLmNv
bT47IExpbnVzIFRvcnZhbGRzDQo+IDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4g
U3ViamVjdDogUmU6IFJlZ3Jlc3Npb24gc2luY2UgNi4xLjQ2IChjb21taXQgOGVlMzllYyk6IHJ0
c3hfcGNpIGZyb20NCj4gZHJpdmVycy9taXNjL2NhcmRyZWFkZXIgYnJlYWtzIE5WTUUgcG93ZXIg
c3RhdGUsIHByZXZlbnRpbmcgc3lzdGVtIGJvb3QNCj4gDQo+IA0KPiBFeHRlcm5hbCBtYWlsLg0K
PiANCj4gDQo+IA0KPiBPbiBUdWUsIFNlcCAxMiwgMjAyMyBhdCAwNzoxMDozOFBNICswMjAwLCBM
aW51eCByZWdyZXNzaW9uIHRyYWNraW5nIChUaG9yc3Rlbg0KPiBMZWVtaHVpcykgd3JvdGU6DQo+
ID4gKENDaW5nIEdyZWcsIGFzIGhlIG1lcmdlZCB0aGUgY3VscHJpdCwgYW5kIExpbnVzLCBpbiBj
YXNlIGhlIHdhbnRzIHRvDQo+ID4gcmV2ZXJ0IHRoaXMgZnJvbSBtYWlubGluZSBkaXJlY3RseSBh
cyB0aGlzIGFwcGFyZW50bHkgYWZmZWN0cyBhbmQNCj4gPiBhbm5veXMgcXVpdGUgYSBmZXcgcGVv
cGxlKQ0KPiANCj4gVGhlIGRyaXZlciBhdXRob3JzIGtub3cgYWJvdXQgdGhpcyBhbmQgaGF2ZSBz
YWlkIHRoZXkgYXJlIHdvcmtpbmcgb24gYQ0KPiBzb2x1dGlvbi4gIExldCdzIGdpdmUgdGhlbSBh
IGZldyBtb3JlIGRheXMgb24gaXQgYmVmb3JlIHJldmVydGluZyBzdHVmZi4NCj4gDQo+IHRoYW5r
cywNCj4gDQo+IGdyZWcgay1oDQo=
